
describe "Simple search" do

  context "One search term" do
    it "q of 'nanotechnology'" do
      resp = solr_resp_title_only({'q'=>'nanotechnology'})
      resp.should include("title_ts" => /^nanotechnolog[a-z]+/i).in_each_of_first(10).documents
    end
  end

  context "search author surname and initials combined with other search terms" do
    it "q of 'mckinley r.s. swim' as search all" do
    	resp = solr_response({'q'=>'mckinley r.s. swim'})
    	resp.should include("title_ts" => /swim/i).in_each_of_first(10).documents
      resp.should include("author_ts" => /mckinley, r\. s\./i).in_each_of_first(10).documents
    end
  end

	context "search author surname and first names combined with other search terms and year" do

		it "q of 'hans janssen moisture buildings 2011' as search all, only one record in result", :wip => true do
			resp = solr_response({'q'=>'hans janssen moisture buildings 2011'})
			resp.should include("title_ts" => "In situ determination of the moisture buffer potential of room enclosures")
			resp.should have_exactly(1).document
		end
	end

	context "search phrase that includes a colon" do
    it "q of 'Women: Latent bias harms careers' as search all" do
     resp = solr_resp_title_only({'q'=>'Women: Latent bias harms careers'})
     resp.should include("title_ts" => "Women: latent bias harms careers").as_first_result
    end
  end

  context "multiple simple search terms" do

    it "q of 'radio transmitters'" do
      resp = solr_resp_title_only({'q' => "radio transmitters"})
      resp.should include("title_ts" => "Radio transmitters").as_first
    end

    it "q of 'Applications of magnetoelectrics'" do
      resp = solr_resp_title_only({'q' => "Applications of magnetoelectrics"})
      resp.should include("title_ts" => "Applications of magnetoelectrics").as_first
      resp.should include("title_ts" => "Electrotechnical applications of magnetoelectric phenomena in semiconductors")
        .before("title_ts" => "Magnetoelectric Composites")
    end
  end
end
