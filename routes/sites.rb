get '/api/sites' do
  if params[:name]
    render_get(:sites, Site.first(name: params[:name]))
  else
    handle_get :sites, Site
  end
end

get    '/api/sites/:id' do handle_get    :sites, Site end
post   '/api/sites'     do handle_post   :sites, Site end
put    '/api/sites'     do handle_put    :sites, Site end
delete '/api/sites/:id' do handle_delete :sites, Site end
