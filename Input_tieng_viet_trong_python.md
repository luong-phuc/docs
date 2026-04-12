```
# -*- coding: utf-8 -*-
import sys
import io

# 1. Ép UTF-8 với chế độ xử lý lỗi 'replace' để không bao giờ sập vì byte lẻ
sys.stdin = io.TextIOWrapper(sys.stdin.buffer, encoding='utf-8', errors='replace')
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')

def get_input_utf8(prompt):
    # In prompt mà không bị lỗi font
    sys.stdout.write("\n" + prompt)
    sys.stdout.flush()
    line = sys.stdin.readline()
    if not line: return ""
    return line.strip()

if __name__ == "__main__":
    user_input = get_input_utf8("👉 Nhập lệnh: ")
    print(user_input)