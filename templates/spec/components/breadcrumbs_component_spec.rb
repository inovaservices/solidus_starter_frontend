require "solidus_starter_frontend_helper"

RSpec.describe BreadcrumbsComponent, type: :component do
  let(:request_url) { '/' }

  subject(:component) do
    with_request_url(request_url) do
      render_inline(described_class.new(taxon))
    end

    rendered_component
  end

  before  do
    allow(self.request).to receive(:path).and_return(request_url)
  end

  describe '#call' do
    let(:taxon) { nil }

    context 'when the taxon is nil' do
      let(:taxon) { nil }

      it { is_expected.to be_blank }
    end

    context 'when the taxon is present' do
      let(:parent) { nil }
      let(:taxon) { build_stubbed(:taxon, parent: parent) }

      context 'when the current page is the root page' do
        let(:request_url) { '/' }

        it { is_expected.to be_blank }
      end

      context 'when the current page is not the root page' do
        let(:request_url) { '/products' }

        context 'when the taxon has no ancestors' do
          let(:parent) { nil }

          it 'renders a breadcrumb for the taxon', :focus do
            expect(component).to eq('TODO')
          end
        end

        context 'when the taxon has one ancestor' do
          it 'renders a breadcrumb for the taxon and its ancestor'
        end

        context 'when the taxon has multiple ancestors' do
          it 'renders a breadcrumb for the taxon and its ancestors'
        end
      end
    end
  end
end
