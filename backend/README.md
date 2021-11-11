# Packages dependencies:
1. bcryptjs
2. dotenv
3. express
4. jsonwebtoken
5. mongoose
6. nodemon
7. socket.io

# List of permissions:

## Group Permissions:

1. add channels
2. add/modify/delete roles, add/remove members from roles
3. add/remove members
4. Add/edit/delete events
5. Edit/Delete group (Admin only)

## Channel Permissions:

1. view
2. write
3. edit (includes channel name and channel permissions)
4. delete channel (Nobody should have the permission to delete general channel)

## .env content format

1. HTTP_PORT=<integer>
2. HTTPS_PORT=<integer>
3. DATABASE_URL=<link to mongodb server>
4. JWT_EXPIRY=<integer h/d>
5. JWT_KEY=<random key string>
