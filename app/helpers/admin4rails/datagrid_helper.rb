module Admin4rails
  module DatagridHelper
    def datagrid(grid)
      datagrid_table(grid, html: { class: 'table table-striped dataTable' }) +
        content_tag(:div, class: 'row') do
          concat(content_tag(:div, class: 'col-xs-6') { datagrid_total(grid) })
          concat(content_tag(:div, class: 'col-xs-6') { datagrid_pager(grid) })
        end
    end

    private

    def datagrid_total(grid)
      content_tag(:div, class: 'dataTables_info') do
        pluralize(grid.assets.total_count, 'record')
      end
    end

    def datagrid_pager(grid)
      content_tag(:div, class: 'dataTables_paginate paging_bootstrap') do
        paginate grid.assets
      end
    end
  end
end
