get    '/api/packages'     do handle_get    :packages, Package end
get    '/api/packages/:id' do handle_get    :packages, Package end
post   '/api/packages'     do handle_post   :packages, Package end
put    '/api/packages'     do handle_put    :packages, Package end
delete '/api/packages/:id' do handle_delete :packages, Package end
