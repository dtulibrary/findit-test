
describe "Book search" do

	context "matches in title should sort first" do
		it "book search on fluid fem", :wip => true do
			resp = solr_response({'q'=>'fluid fem', 'fq' => ['format:book']})
			resp.should include("title_ts" => "The finite element method for fluid dynamics").as_first_document
			resp.should include("title_ts" => "The finite element method for solid and structural mechanics").before("title_t" => "Damage and fracture mechanics : failure analysis of engineering materials and structures")
		end
	end

end