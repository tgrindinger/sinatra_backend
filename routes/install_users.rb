get    '/api/install_users'     do handle_get    :install_users, InstallUser end
get    '/api/install_users/:id' do handle_get    :install_users, InstallUser end
post   '/api/install_users'     do handle_post   :install_users, InstallUser end
put    '/api/install_users'     do handle_put    :install_users, InstallUser end
delete '/api/install_users/:id' do handle_delete :install_users, InstallUser end
