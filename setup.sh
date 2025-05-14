git clone https://gitlab.com/deusops/projects/react-spring-app.git temp-repo
mv temp-repo/frontend ./frontend
mv temp-repo/backend ./backend
rm -rf temp-repo

mkdir -p nginx

cat <<EOF > nginx/default.conf
server {
    listen 80;

    location /api/ {
        proxy_pass http://backend:8000/;
    }

    location / {
        proxy_pass http://frontend:3000/;
    }
}
EOF

cat <<EOF > .env
DB_USER=appuser
DB_PASSWORD=apppass
DB_NAME=appdb
DB_HOST=db
DB_PORT=5432
EOF

echo "Setup complete. Run: docker compose up --build"
