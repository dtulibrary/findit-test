require 'spec_helper'

describe "Author search" do
	
	context "Should only return hits from the author field" do
		
		it "q of 'feynman' in Author" do
			resp = solr_resp_author_only(author_search_args('feynman'))
			resp.should include("author_t" => "Feynman").in_each_of_first(10).documents
		end

		it "q of 'Larsen, N' in Author" do
	    resp = solr_response(author_search_args('Larsen, N'))
	    resp.should_not include("title_t" => "CENTRE POMPIDOU, METZ - Knut Einar Larsen")
	  end
	end

	context "No stemming on author name" do

		# wip - should be fixed by no author stemming
		it "q of 'Gimsing' in Author", :wip => true do
			resp = solr_resp_author_only(author_search_args('Gimsing'))
			resp.should_not include("author_t" => "Gimse").in_first(10).results
		end
	end

end