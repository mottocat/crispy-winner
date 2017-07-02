class Forest::ApprovalImage
  include ForestLiana::Collection

  collection :approval_images
  action 'Make approved'
  action 'Make denied'
  action 'Make waiting approval'
end