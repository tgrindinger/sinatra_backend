get '/api/orgs' do
  if params[:available] == "true"
    {orgs: Org.available_sandboxes}.to_json
  else
    handle_get :orgs, Org
  end
end

get    '/api/orgs/:id' do handle_get    :orgs, Org end
post   '/api/orgs'     do handle_post   :orgs, Org end
put    '/api/orgs'     do handle_put    :orgs, Org end
delete '/api/orgs/:id' do handle_delete :orgs, Org end
