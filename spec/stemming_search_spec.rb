require 'spec_helper'

describe "Stemming of English words" do
	
	context "exact matches before stemmed matches and exact phrase before part of phrase" do
		
		# wip - should be fixed by title boosting
		it "q of 'hydrobiology'", :wip => true do
			resp = solr_resp_title_only({'q'=>'hydrobiology'})
			resp.should include("title_t" => "Hydrobiology").as_first_document
			resp.should include("title_t" => "Ecohydrology Hydrobiology").before("title_t" => "Hydrochemistry of the ultra-fresh Lake Aszyrynis in north-eastern Poland")
		end
	end
end