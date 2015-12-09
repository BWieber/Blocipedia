class CollaboratorsController < ApplicationController
  
  def new
    @wiki = Wiki.find(params[:wiki_id])
    @collaboration = Collaborator.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaboration = Collaborator.new(collaboration_params)
    @collaboration.wiki = @wiki

    if @collaboration.save
      flash[:notice] = "Collaborator was added to this wiki."
      redirect_to @wiki
    else
      flash[:error] = "Collaborator was not added. Please try again."
      render :show
    end
   end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaboration = Collaborator.find(params[:id])

    if @collaboration.destroy
      flash[:notice] = "Collaborator was removed from this wiki."
      redirect_to @wiki
    else
      flash[:error] = "Collaborator was not removed. Please try again."
      render :show
    end
   end

  private

  def collaboration_params
    params.require(:collaborator).permit(:user_id)
  end

end
