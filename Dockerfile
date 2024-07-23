# 使用基礎映像
FROM python:3.9-slim

# 安裝必要的系統依賴項
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    tesseract-ocr-chi-sim \
    tesseract-ocr-chi-tra \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 設置工作目錄
WORKDIR /app

# 複製需求文件並安裝 Python 依賴項
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# 複製應用程序代碼
COPY . .

# 暴露 Streamlit 默認端口
EXPOSE 8501

# 運行 Streamlit 應用
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]


