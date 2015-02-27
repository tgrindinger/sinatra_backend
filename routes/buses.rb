get    '/api/buses'     do handle_get    :buses, Bus end
get    '/api/buses/:id' do handle_get    :buses, Bus end
post   '/api/buses'     do handle_post   :buses, Bus end
put    '/api/buses'     do handle_put    :buses, Bus end
delete '/api/buses/:id' do handle_delete :buses, Bus end
