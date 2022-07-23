describe("example to-do app", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("there is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("there is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
});
