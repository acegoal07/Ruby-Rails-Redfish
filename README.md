# SERVER API CALLS
Get all current servers:
```sh
curl -X GET http://127.0.0.1:3000/api/servers
```

Add a new server:
```sh
curl -X POST http://127.0.0.1:3000/api/servers \
   -F "server[file]=@file_path.json" \
   -F "server[cabinet_id]=CABINET_ID" \
   -F "server[slot]=1" \
   -F "server[u_position]=1" \
   -F "server[notes]=Imported from inventory"
```

Get Specific server:
```sh
curl -X GET http://127.0.0.1:3000/api/servers/SERVER_ID
```

Update server:
```sh
curl -X patch http://127.0.0.1:3000/api/servers/SERVER_ID \
   -F "server[file]=@file_path.json" \
   -F "server[cabinet_id]=CABINET_ID" \
   -F "server[slot]=1" \
   -F "server[u_position]=1" \
   -F "server[notes]=Imported from inventory"
```

Delete Server:
```sh
curl -X DELETE http://127.0.0.1:3000/api/servers/SERVER_ID
```

# CABINET API CALLS
Get all current cabinets:
```sh
curl -X GET http://127.0.0.1:3000/api/cabinets
```

Add a new cabinet:
```sh
curl -X POST http://127.0.0.1:3000/api/cabinets \
   -F "cabinet[name]=Cabinet Name" \
   -F "cabinet[u_size]=10"\
   -F "cabinet[notes]=Its a cabinet"
```

Get Specific cabinet:
```sh
curl -X GET http://127.0.0.1:3000/api/cabinets/CABINET_ID
```

Update cabinet:
```sh
curl -X patch http://127.0.0.1:3000/api/cabinets/CABINET_ID \
   -F "cabinet[name]=Cabinet Name" \
   -F "cabinet[u_size]=10"\
   -F "cabinet[notes]=Its a cabinet"
```

Delete Cabinet:
```sh
curl -X DELETE http://127.0.0.1:3000/api/cabinets/CABINET_ID
```