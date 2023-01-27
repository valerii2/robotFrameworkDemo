from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn

@library
class Shop:

    def __init__(self):
        self.sel_lib = BuiltIn().get_library_instance("SeleniumLibrary")


    @keyword
    def add_products_to_cart(self, need_products_list):
        i = 1
        product_titles = self.sel_lib.get_webelements("xpath://h4[@class='card-title']")
        for product_title in product_titles:
            if product_title.text in need_products_list:
                self.sel_lib.click_button("xpath:(//*[@class='card-footer'])["+str(i)+"]/button")
            i = i + 1
        self.sel_lib.click_element("css:.nav-link.btn.btn-primary")
