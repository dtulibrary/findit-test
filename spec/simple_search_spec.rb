require 'spec_helper'

describe "Simple search" do

  context "One search term" do
    it "q of 'nanotechnology'" do
      resp = solr_resp_title_only({'q'=>'nanotechnology'})
      resp.should include("title_t" => /^nanotechnolog[a-z]+$/i).in_each_of_first(10).documents
    end
  end

  context "search author surname and initials combined with other search terms" do
    it "q of 'mckinley r.s. swim' as search all" do
    	resp = solr_response({'q'=>'mckinley r.s. swim'})
    	resp.should include("title_t" => /swim/i).in_each_of_first(10).documents
      resp.should include("author_t" => /mckinley, r\. s\./i).in_each_of_first(10).documents
    end
  end

	context "search author surname and first names combined with other search terms and year" do
		it "q of 'hans janssen moisture buildings 2011' as search all, only one record in result" do
			resp = solr_response({'q'=>'hans janssen moisture buildings 2011'})
			resp.should include("title_t" => "In situ determination of the moisture buffer potential of room enclosures")
			resp.should have_exactly(1).document
		end
	end

	context "search phrase that includes a colon" do 
    it "q of 'Women: Latent bias harms careers' as search all" do 
     resp = solr_resp_title_only({'q'=>'Women: Latent bias harms careers'}) 
     resp.should include("title_t" => "Women: latent bias harms careers").as_first_result
    end
  end

  context "multiple simple search terms" do

    # wip - should be fixed by title boosting
    it "q of 'radio transmitters'", :wip => true do
      resp = solr_resp_title_only({'q' => "radio transmitters"})
      resp.should include("title_t" => "Radio transmitters").as_first
    end

    # wip - should be fixed by title boosting
    it "q of 'Applications of magnetoelectrics'", :wip => true do
      resp = solr_resp_title_only({'q' => "Applications of magnetoelectrics"})
      resp.should include("title_t" => "Applications of magnetoelectrics").as_first
      resp.should include("title_t" => "Electrotechnical applications of magnetoelectric phenomena in semiconductors")
        .before("title_t" => "Magnetoelectric Composites")
    end
  end
end
