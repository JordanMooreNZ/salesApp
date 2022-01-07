require "./sales_app"

describe SalesApp do

  describe "#get_receipt" do
    subject { described_class.new.get_receipt(input) }

    shared_examples "an accurate receipt" do
      it "should match the expected output" do
        expect(subject).to eq(expected_output)
      end
    end

    context "input 1" do
      let(:input) do
        <<~CSV
          Quantity,Product,Price
          1,book,12.49
          1,music cd,14.99
          1,chocolate bar,0.85
        CSV
      end
      let(:expected_output) do
        <<~OUTPUT
          1,book,12.49
          1,music cd,16.49
          1,chocolate bar,0.85

          Sales Taxes: 1.50
          Total: 29.83
        OUTPUT
      end

      it_behaves_like "an accurate receipt"
    end

    context "input 2" do
      let(:input) do
        <<~CSV
          Quantity,Product,Price
          1,imported box of chocolates,10.00
          1,imported bottle of perfume,47.50
        CSV
      end
      let(:expected_output) do
        <<~OUTPUT
          1,imported box of chocolates,10.50
          1,imported bottle of perfume,54.65

          Sales Taxes: 7.65
          Total: 65.15
        OUTPUT
      end

      it_behaves_like "an accurate receipt"
    end

    context "input 3" do
      let(:input) do
        <<~CSV
          Quantity,Product,Price
          1,imported bottle of perfume,27.99
          1,bottle of perfume,18.99
          1,packet of headache pills,9.75
          1,box of imported chocolates,11.25
        CSV
      end
      let(:expected_output) do
        <<~OUTPUT
          1,imported bottle of perfume,32.19
          1,bottle of perfume,20.89
          1,packet of headache pills,9.75
          1,box of imported chocolates,11.85

          Sales Taxes: 6.70
          Total: 74.68
        OUTPUT
      end

      it_behaves_like "an accurate receipt"
    end
  end
end
