class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # Read
  get('/recipes') do
    @recipes = Recipe.all
    erb(:index)
  end

  # Create
  get('/recipes/new') do
    erb(:new)
  end

  post('/recipes') do
    @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    redirect('/recipes/'+ @recipe.id.to_s)
  end

  # Read
  get('/recipes/:id') do
    @recipe = Recipe.find_by_id(params[:id])
    erb(:show)
  end

  # Update
  get('/recipes/:id/edit') do
    @recipe = Recipe.find_by_id(params[:id])
    erb(:edit)
  end

  patch('/recipes/:id') do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect('/recipes/'+ @recipe.id.to_s)
  end

  # Delete
  delete('/recipes/:id') do
    Recipe.find_by_id(params[:id]).destroy
    redirect("/recipes")
  end

end