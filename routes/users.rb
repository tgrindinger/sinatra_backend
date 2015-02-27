get    '/api/users'     do handle_get    :users, User end
get    '/api/users/:id' do handle_get    :users, User end
post   '/api/users'     do handle_post   :users, User end
put    '/api/users'     do handle_put    :users, User end
delete '/api/users/:id' do handle_delete :users, User end
