#!/bin/bash

# Hàm sinh chuỗi ngẫu nhiên có độ dài 5 ký tự
generate_random_string() {
  local random_string=$(LC_ALL=C tr -dc 'a-z' < /dev/urandom | head -c 5 ; echo '')
  echo "${random_string}-$(LC_ALL=C tr -dc 'a-z' < /dev/urandom | head -c 5 ; echo '')"
}

# Hàm tạo project ID
generate_project_id() {
  local random_suffix=$(generate_random_string)
  echo "$random_suffix"
}

# Hàm tạo project name
generate_project_name() {
  random_numbers=$(generate_random_numbers)
  echo "My Project $random_numbers"
}

# Hàm sinh chuỗi ngẫu nhiên gồm 5 số
generate_random_numbers() {
  local random_numbers=$(shuf -i 0-99999 -n 1)
  printf "%05d" "$random_numbers"
}
generate_random_number() {
  echo $((1000 + RANDOM % 9000))
}
generate_valid_instance_name() {
  local random_number=$(generate_random_number)
  echo "prodvm-${random_number}"
}

startup_script_url="https://raw.githubusercontent.com/vinatechpro/titan-install/main/titan-gcp.sh"
# List of regions and regions where virtual machines need to be created
zones=(
  "us-east4-a"
  "us-east1-b"
  "us-east5-a"
  "us-south1-a"
  "us-west1-a"
  "europe-west4-b"
)
# Kiểm tra sự tồn tại của tổ chức
organization_id=$(gcloud organizations list --format="value(ID)" 2>/dev/null)
echo "ID tổ chức của bạn là: $organization_id"

# Lấy ID tài khoản thanh toán
billing_account_id=$(gcloud beta billing accounts list --format="value(name)" | head -n 1)
echo "Billing_account_id của bạn là: $billing_account_id"

# Hàm đảm bảo có đủ số lượng dự án
ensure_n_projects() {
  desired_projects=2
  if [ -n "$organization_id" ]; then
    current_projects=$(gcloud projects list --format="value(projectId)" --filter="parent.id=$organization_id" 2>/dev/null | wc -l)
  else
    current_projects=$(gcloud projects list --format="value(projectId)" 2>/dev/null | wc -l)
  fi

  echo "Tổng số dự án đang có là: $current_projects"

  if [ "$current_projects" -lt "$desired_projects" ]; then
    projects_to_create=$((desired_projects - current_projects))
    echo "Chưa có đủ $desired_projects dự án, đang tiến hành tạo $projects_to_create dự án..."

    for ((i = 0; i < projects_to_create; i++)); do
      local project_id=$(generate_project_id)
      local project_name=$(generate_project_name)

      if [ -n "$organization_id" ]; then
        gcloud projects create "$project_id" --name="$project_name" --organization="$organization_id"
      else
        gcloud projects create "$project_id" --name="$project_name"
      fi
      sleep 4
      gcloud alpha billing projects link "$project_id" --billing-account="$billing_account_id"
      gcloud config set project "$project_id"
      echo "Đã tạo dự án '$project_name' (ID: $project_id)."
    done
  else
    echo "Đã có đủ $desired_projects dự án."
  fi
}

# Hàm tạo firewall rule cho một project
create_firewall_rule() {
    local project_id=$1
    gcloud compute --project="$project_id" firewall-rules create firewalldev --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=all --source-ranges=0.0.0.0/0
}

re_enable_compute_projects(){
    local projects=$(gcloud projects list --format="value(projectId)")
    echo "projects list: $projects"
    if [ -z "$projects" ]; then
        echo "The account has no projects."
        exit 1
    fi
    for project_ide in $projects; do
        echo "enable api & create firewall_rule  for project: $project_ide ....."
        gcloud services enable compute.googleapis.com --project "$project_ide"
        sleep 5
        create_firewall_rule "$project_ide"
        echo "enabled compute.googleapis.com project: $project_ide"
    done
}

# Hàm kiểm tra và chờ dịch vụ được enable
check_service_enablement() {
    local project_id="$1"
    local service_name="compute.googleapis.com"
    echo "Đang kiểm tra trạng thái của dịch vụ $service_name trong dự án : $project_id..."

    while true; do
        service_status=$(gcloud services list --enabled --project "$project_id" --filter="NAME:$service_name" --format="value(NAME)")
        if [[ "$service_status" == "$service_name" ]]; then
            echo "Dịch vụ $service_name đã được enable trong dự án : $project_id."
            break
        else
            echo "Dịch vụ $service_name chưa được enable trong dự án : $project_id. Đang cố gắng enable..."
            gcloud services enable "$service_name" --project "$project_id"
            sleep 5
        fi
    done
}

run_enable_project_apicomputer(){
   local projects=$(gcloud projects list --format="value(projectId)")
   for project_id in $projects; do
    check_service_enablement "$project_id"
   done
}

create_vms(){
    local projects=$(gcloud projects list --format="value(projectId)")
    for project_id in $projects; do
        echo "processing create vm on project-id: $project_id"
        gcloud config set project "$project_id"
        service_account_email=$(gcloud iam service-accounts list --project="$project_id" --format="value(email)" | head -n 1)
        if [ -z "$service_account_email" ]; then
            echo "No Service Account could be found in the project: $project_id"
            continue
        fi
        for zone in "${zones[@]}"; do
            instance_name=$(generate_valid_instance_name)
            gcloud compute instances create "$instance_name" \
            --project="$project_id" \
            --zone="$zone" \
            --machine-type=t2d-standard-1 \
            --network-interface=network-tier=PREMIUM,nic-type=GVNIC,stack-type=IPV4_ONLY,subnet=default \
            --maintenance-policy=MIGRATE \
            --provisioning-model=STANDARD \
            --service-account="$service_account_email" \
            --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
            --create-disk=auto-delete=yes,boot=yes,device-name="$instance_name",image=projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20240607,mode=rw,size=139,type=projects/"$project_id"/zones/"$zone"/diskTypes/pd-balanced \
            --no-shielded-secure-boot \
            --shielded-vtpm \
            --shielded-integrity-monitoring \
            --labels=goog-ec-src=vm_add-gcloud \
            --metadata=startup-script-url="$startup_script_url" \
            --reservation-affinity=any
            if [ $? -eq 0 ]; then
                echo "Created instance $instance_name in project $project_id at region $zone sucessfully."
            else
                echo "Fail create instance $instance_name in project $project_id at region $zone."
            fi
        done
    done

}

list_of_servers(){
    local projectsss=($(gcloud projects list --format="value(projectId)"))
    all_ips=()
    # Lặp qua từng dự án và lấy danh sách các địa chỉ IP công cộng
    for projects_id in "${projectsss[@]}"; do
        echo "Retrieving list of servers from project: $projects_id"       
        # Đặt dự án hiện tại
        gcloud config set project "$projects_id"      
        # Lấy danh sách địa chỉ IP công cộng của các máy chủ trong dự án hiện tại
        ips=($(gcloud compute instances list --format="value(EXTERNAL_IP)" --project="$projects_id"))       
        # Thêm các địa chỉ IP vào mảng all_ips
        all_ips+=("${ips[@]}")
    done
    echo "List of all public IP addresses:"
    for ip in "${all_ips[@]}"; do
        echo "$ip"
    done

}

# Gọi hàm để đảm bảo có đủ số lượng dự án
# Hàm main: Chạy các hàm
main() {
    echo "------*******Xã hội này có chạy node thì mới có ăn*******---------"
    echo "----------------Đang kiểm tra 3 project.-----------------"
    ensure_n_projects
    echo "----------------Kiểm tra xong 3 project.-----------------"
    re_enable_compute_projects
    run_enable_project_apicomputer
    echo "----------------Tiến hành tạo máy...... Hãy đi hút thuốc và đợi chạy xong-------------"
    create_vms
    list_of_servers
    echo "Acc đã múc xong! bạn sắp thành trọc phú."
}
main
