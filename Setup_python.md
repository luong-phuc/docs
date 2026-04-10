# Setup thư mục tạm khi cài đặt bằng pip
Sau khi tạo thư mục tmp ở 1 nơi nào đó (ví dụ : /root/pip_tmp)
```
vim ~/.bash_profile

# Setup nội dung sau : 
export PYTHONIOENCODING=utf-8
export TMPDIR=/root/pip_tmp

# Khi cài đặt bằng pip nên thêm tham số --no-cache-dir để đem thư viện theo cùng
pip install --no-cache-dir {tên thư viện}
```

# Tạo môi trường cho python
```
python3 -m venv venv

# truy cập vào môi trường ảo để sử dụng
source venv/bin/activate

# Thoát khỏi môi trường ảo
deactivate
```

# Đóng gói thư viện trong thư mục cài đặt 
```
pip freeze > requirements.txt
```

# Install tất cả thay vì install từng lần :
pip install -r requirements.txt
