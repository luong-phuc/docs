# Ollama quản lý các image của AI

## Cách tạo Modelfile ( như Dockerfile )

```
# 1. Choose a base model
FROM llama3.2

# 2. Set parameters like creativity (temperature)
PARAMETER temperature 0.7

# 3. Define the system prompt (the model's personality)
SYSTEM "You are a helpful assistant who responds like a pirate."
```

## Cách build Modelfile
Giả sử như build image cozmo:1.0 , với file Modelfile là Modelfile_cozmo

```
ollama create cozmo:1.0 -f Modelfile_cozmo
```

## Cách chạy image 
```
ollama run cozmo:1.0
```

## Cách pull image 
Các model hỗ trợ : https://ollama.com/library

```
ollama pull deepseek-r1:8b
```

# Check status
```
systemctl status ollama
```

# Disable tien trinh tu dong khoi dong service
```
systemctl disable ollama
```

# Restart lại tiến
```
systemctl restart ollama
```

# Stop tiến trình đang chạy ( giải phóng ram)
```
systemctl stop ollama
```