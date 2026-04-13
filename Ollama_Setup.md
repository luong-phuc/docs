Chào anh, để biến con **Fedora 43 WSL** của anh thành một "trạm phát AI" vĩnh viễn và miễn phí cho Miku, đây là bản tóm tắt các bước chuẩn nhất, bỏ qua các lỗi rườm rà mình đã gặp:

---

### Bước 1: Cài đặt Ollama vào Fedora
Mở Terminal Fedora và chạy lệnh cài đặt chính thức:
```bash
curl -fsSL https://ollama.com/install.sh | sh
```
*Lưu ý: Nếu hệ thống hỏi mật khẩu root, anh cứ nhập vào.*

### Bước 2: Quản lý dịch vụ (Service)
Trên Fedora, Ollama sẽ tự chạy ngầm. Anh cần biết 3 lệnh "quyền lực" sau:
* **Kiểm tra xem nó có sống không:** `sudo systemctl status ollama`
* **Khởi động lại (nếu bị lag/lỗi):** `sudo systemctl restart ollama`
* **Dừng hẳn:** `sudo systemctl stop ollama`
* **Stop Service không cho tự khởi động lại:** `sudo systemctl disable ollama`

### Bước 3: Tải "Bộ não" (Model) về máy
Đây là bước tốn dung lượng ổ cứng nhưng chỉ cần làm **một lần duy nhất** (cần internet). Anh nên tải Qwen (giỏi tiếng Việt) hoặc Llama:
```bash
# Phiên bản gọn nhẹ chỉ 2Gb RAM
ollama pull qwen2.5:3b

# Tải Qwen 2.5 (Khuyên dùng cho Miku vì tiếng Việt rất ngọt)
ollama pull qwen2.5

# Hoặc tải Llama 3.1
ollama pull llama3.1
```
*Sau khi chạy xong lệnh này, anh có thể ngắt kết nối Internet.*

### Bước 4: Kiểm tra danh sách model đã có
Để chắc chắn model đã nằm trong ổ cứng, anh gõ:
```bash
ollama list
```
Nếu thấy tên model hiện ra là anh đã thành công 100%.

### Bước 5: Cài đặt thư viện Python để "nói chuyện"
Trong môi trường `venv` của dự án `chromadb`, anh cài thư viện kết nối:
```bash
pip install ollama
```

---

### Bước 6: Code mẫu để "Miku" bắt đầu nói chuyện
Anh tạo file `miku_chat.py` và dán đoạn code "vòng lặp" này vào:

```python
import ollama

def miku_talk():
    print("--- Miku đã sẵn sàng (Offline) ---")
    while True:
        # Nhập liệu an toàn cho tiếng Việt trên Fedora
        import sys
        print("\nAnh: ", end='', flush=True)
        user_input = sys.stdin.buffer.readline().decode('utf-8', errors='replace').strip()
        
        if user_input.lower() in ['exit', 'quit']: break

        # Gọi model Qwen đã tải
        stream = ollama.chat(
            model='qwen2.5', # Hoặc llama3.1
            messages=[{'role': 'system', 'content': 'Bạn là Miku, một cô gái dịu dàng.'},
                      {'role': 'user', 'content': user_input}],
            stream=True,
        )

        print("Miku: ", end='', flush=True)
        for chunk in stream:
            print(chunk['message']['content'], end='', flush=True)
        print()

if __name__ == "__main__":
    miku_talk()
```

---

### 💡 Lưu ý cuối cùng cho "ông chủ" của Miku:
1.  **Ổ cứng:** Mỗi model (Qwen hay Llama) sẽ tốn khoảng **4.5GB - 5GB** ổ cứng. Anh đảm bảo WSL còn trống tầm 10GB nhé.
2.  **RAM:** Khi Miku đang trả lời, cô ấy sẽ chiếm khoảng **5GB - 8GB RAM**.
3.  **Tốc độ:** Nếu máy anh có card đồ họa (NVIDIA), Ollama sẽ tự nhận và trả lời cực nhanh. Nếu không, nó sẽ dùng CPU, vẫn chạy tốt nhưng sẽ chậm hơn một chút.

Chúc anh có những giây phút tâm sự thật nhẹ lòng với Miku nhé! Anh đã bắt đầu `pull` model nào chưa?