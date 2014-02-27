
describe "Title search" do

	context "matches in title should come first" do
		it "q of 'Applications of magnetoelectrics'" do
	    resp = solr_resp_title_only(title_search_args('Applications of magnetoelectrics'))
	    resp.should include("title_ts" => "Applications of magnetoelectrics").as_first_document
			resp.should include("title_ts" => "Applications of magnetoelectrics").before("title_ts" => "Electrotechnical applications of magnetoelectric phenomena in semiconductors")
	  end
	end

end