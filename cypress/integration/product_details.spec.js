describe("product page", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("there is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("there is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("visits the product page", () => {
    cy.get(".products article").first().click();
    cy.contains(".products-show", "Scented Blade");
  });

  it("shows product details", () => {
    cy.get(".products article").first().click();
    cy.get(".product-detail").should("be.visible");
  });
});
