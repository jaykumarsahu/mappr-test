### Specific Configuration Files
##### `/config/database.yml`
Set the entire set of keys specified in the example `config/database.yml.example.yml`
Please Add file `/config/database.yml` and update with your local system's PSQL user credentials.

### Master.key
`/config/master.key` - should not be pushed to repository but it's a demo-app so I have added the one to side the setup issues.

#### Setup steps
- Create DB by run command `rails db:create`
- Migrate DB by run command `rails db:migrate`
- Start application server by run command `rails server`
- Open URL in your browser `http://localhost:3000/admin/products`

### POST Snippet Sample
```sh
curl -X POST \
  http://localhost:3000/api/v1/products.json \
  -H 'cache-control: no-cache' \
  -H 'content-type: multipart/form-data;' \
  -F 'tags[]=black' \
  -F 'tags[]=jacket' \
  -F 'tags[]=leather' \
  -F 'categories[]=jackets' \
  -F 'categories[]=mens-wear' \
  -F 'expire_date= 2016-09-05' \
  -F 'name= Black Jacket' \
  -F sku_id=1234 \
  -F price=1000 \
  -F 'images[][img_path]=https://upload.wikimedia.org/wikipedia/commons/c/c0/BiyaRiver.JPG' \
  -F 'images[][img_path]=https://is5-ssl.mzstatic.com/image/thumb/Purple118/v4/5f/6b/6c/5f6b6c32-9e7d-ab72-e7b0-b81038ed41e7/source/256x256bb.jpg'
```
