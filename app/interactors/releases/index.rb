module Releases
  class Index < ApplicationOrganizer

    # Define the sequence of interactors to be executed in the release indexing process
    organize Releases::NormalizeParams,
             Releases::BuildScope,
             Releases::ApplyPastFilter,
             Releases::ApplyPagination,
             Releases::BuildResponse
  end
end
