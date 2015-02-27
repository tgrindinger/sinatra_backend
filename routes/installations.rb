get    '/api/installations'     do handle_get    :installations, Installation end
get    '/api/installations/:id' do handle_get    :installations, Installation end
post   '/api/installations'     do handle_post   :installations, Installation end
put    '/api/installations'     do handle_put    :installations, Installation end
delete '/api/installations/:id' do handle_delete :installations, Installation end
