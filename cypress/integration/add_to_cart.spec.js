describe("home page", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("there is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("there is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("clicks add to cart button", () => {
    cy.get(".btn").first().click({ force: true });
    cy.contains("My Cart (1)");
  });
});
