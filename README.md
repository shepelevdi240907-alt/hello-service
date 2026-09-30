# Hello Service — FastAPI + Docker

## Что установить
Нужны Python 3.12+, Docker Desktop и желательно VS Code.

Проверка:
```powershell
python --version
docker --version
docker run hello-world
```

## Запуск без Docker
В PowerShell из папки проекта:
```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
python -m pip install -r requirements.txt
python -m uvicorn main:app --reload
```

Если PowerShell запрещает Activate.ps1:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.venv\Scripts\Activate.ps1
```

Откройте http://127.0.0.1:8000/
Ожидается:
```json
{"message":"hello world"}
```
Остановить: Ctrl+C.

## Docker
Docker Desktop должен быть запущен.

Сборка:
```powershell
docker build -t hello-service .
```

Запуск:
```powershell
docker run -d -p 8000:8000 --name hello-service-container hello-service
```

Проверка:
```powershell
docker ps
curl.exe -i http://localhost:8000/
```

Ожидается HTTP/1.1 200 OK и:
```json
{"message":"hello world"}
```

Swagger:
http://localhost:8000/docs

Остановка:
```powershell
docker stop hello-service-container
```

Удаление:
```powershell
docker rm hello-service-container
```

Если контейнер остановился:
```powershell
docker logs hello-service-container
```

Если порт 8000 занят:
```powershell
docker run -d -p 8080:8000 --name hello-service-container hello-service
```
Тогда адрес: http://localhost:8080/
