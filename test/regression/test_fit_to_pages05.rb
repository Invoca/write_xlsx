# -*- coding: utf-8 -*-
require 'helper'

class TestRegressionFitToPages05 < Test::Unit::TestCase
  def setup
    setup_dir_var
  end

  def teardown
    File.delete(@xlsx) if File.exist?(@xlsx)
  end

  def test_fit_to_pages05
    @xlsx = 'fit_to_pages05.xlsx'
    workbook  = WriteXLSX.new(@xlsx)
    worksheet = workbook.add_worksheet

    worksheet.fit_to_pages(1, 0)
    worksheet.set_paper(9)

    worksheet.write('A1', 'Foo')

    workbook.close
    compare_xlsx_for_regression(
                                File.join(@regression_output, @xlsx),
                                @xlsx,
                                [
                                 'xl/printerSettings/printerSettings1.bin',
                                 'xl/worksheets/_rels/sheet1.xml.rels'
                                ],
                                {
                                  '[Content_Types].xml'      => ['<Default Extension="bin"'],
                                  'xl/worksheets/sheet1.xml' => ['<pageMargins'],
                                }
                                )
  end
end
