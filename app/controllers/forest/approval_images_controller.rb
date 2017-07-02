class Forest::ApprovalImagesController < ForestLiana::ApplicationController
  def make_approved
    ids do |id|
      ai = ApprovalImage.find(id)
      ai.approved!
    end
    render nothing: true, status: 204
  end

  def make_denied
    ids do |id|
      ai = ApprovalImage.find(id)
      ai.denied!
    end

    render nothing: true, status: 204
  end

  def make_waiting_approval
    ids do |id|
      ai = ApprovalImage.find(id)
      ai.waiting_approval!
    end

    render nothing: true, status: 204
  end

  private

  def ids &block
    params[:data][:attributes][:ids].each(&block)
  end
end