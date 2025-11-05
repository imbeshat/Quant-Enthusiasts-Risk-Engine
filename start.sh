set -e

echo "Starting Quant Enthusiasts Risk Engine..."
echo "Environment: ${RENDER:+Render.com}${RENDER:-Local Docker}"

if [ -n "$RENDER" ]; then
    echo "==> RENDER.COM DEPLOYMENT MODE"
    
    echo "Installing Python dependencies..."
    pip install --upgrade pip
    pip install -r python_api/requirements.txt
    pip install pybind11
    
    echo "Building Python C++ extensions..."
    cd python_api
    python setup.py install
    cd ..
    
    echo "Installing Node.js dependencies..."
    cd react_dashboard
    npm install
    
    echo "Building React production bundle..."
    npm run build
    cd ..
    
    echo "Starting Flask API server..."
    cd python_api
    exec python app.py
    
else
    echo "==> LOCAL DOCKER DEPLOYMENT MODE"
    
    if [ "$DEV_MODE" = "true" ]; then
        echo "Running in DEVELOPMENT mode with hot-reload..."
        
        cd /app/react_dashboard
        npm run dev -- --host &
        REACT_PID=$!
        
        cd /app/python_api
        /app/venv/bin/python app.py &
        API_PID=$!
        
        trap "kill $REACT_PID $API_PID 2>/dev/null" EXIT
        wait $REACT_PID $API_PID
    else
        echo "Running in PRODUCTION mode..."
        
        cd /app/python_api
        exec /app/venv/bin/python app.py
    fi
fi