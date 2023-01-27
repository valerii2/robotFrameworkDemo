from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn

@library
class Cart:

    def __init__(self):
        self.sel_lib = BuiltIn().get_library_instance("SeleniumLibrary")

    @keyword
    def check_products_in_cart(self, need_products_list):
        actual_products_list = []
        product_titles = self.sel_lib.get_webelements("xpath://h4[@class='media-heading']")
        for product_title in product_titles:
            actual_products_list.append(product_title.text)
        print(actual_products_list)
        assert actual_products_list.sort() == need_products_list.sort()
        self.sel_lib.click_element("css:.btn.btn-success")
