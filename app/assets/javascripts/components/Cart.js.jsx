function Cart (props) {
  const [selectedProducts, setSelectedProducts] = React.useState([]);
  const [total, setTotal] = React.useState(null);
  const [discount, setDiscount] = React.useState(null);
  const [hasDiscount, setHasDiscount] = React.useState(null);

  const handleAddToCart = (product_code, quantity) => {
    const existingProductIndex = selectedProducts.findIndex(product => product.product_code === product_code);

    if (existingProductIndex !== -1) {
      setSelectedProducts(prevSelectedProducts => {
        const updatedProducts = [...prevSelectedProducts];
        updatedProducts[existingProductIndex].quantity = quantity;
        return updatedProducts;
      });
    } else {
      setSelectedProducts(prevSelectedProducts => [...prevSelectedProducts, { product_code, quantity }]);
    }
  };

  const getQuantity = (product_code) => 
  {    
    const existingProductIndex = selectedProducts.findIndex(product => product.product_code === product_code);

    if (existingProductIndex !== -1) 
    {
        return selectedProducts[existingProductIndex].quantity;
    }
    else {
      return 0
    }
  }

  const handleIncrement = (product_code) => {
    const existingProductIndex = selectedProducts.findIndex(product => product.product_code === product_code);

    if (existingProductIndex !== -1)
    {    
      const updatedProducts = [...selectedProducts];
      handleAddToCart(product_code, updatedProducts[existingProductIndex].quantity + 1 )
    }
    else
    {
      handleAddToCart(product_code, 1);
    }
  };

  const handleDecrement = (product_code) => {
    const existingProductIndex = selectedProducts.findIndex(product => product.product_code === product_code);

    if (existingProductIndex !== -1)
    {    
      const updatedProducts = [...selectedProducts];
      if (updatedProducts[existingProductIndex].quantity > 1)
        handleAddToCart(product_code, updatedProducts[existingProductIndex].quantity - 1 )
      else 
        handleAddToCart(product_code, 0 )
    }
    else
    {
      handleAddToCart(product_code, 0);
    }
  };

  const handleSubmitPurchase = (event) => {
    const csrfToken = document.querySelector('[name=csrf-token]').content;
    const response = fetch('/add_to_cart', 
    {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken,

      },
      body: JSON.stringify({ products: selectedProducts }),
    }
    );

    response.then(response => {
      if (!response.ok) 
      {
        throw new Error('Network response was not ok');
      }
      return response.json();
    })
    .then(data => {
      if (data.has_discount)
      {
        setHasDiscount(true);
        setDiscount(data.discount_amount)
      }
      else
      {
        setHasDiscount(false);
        setDiscount(0)
      }
      setTotal(data.total);
    })
    .catch(error => {
      console.error('Error fetching data:', error);
    });
  }
  console.log(selectedProducts);
  return(
    <div>
      <ProductList getQuantity={getQuantity} cart={selectedProducts} products={props.products} handleAddToCart={handleAddToCart}  handleIncrement={handleIncrement} handleDecrement={handleDecrement}></ProductList>
      <button onClick={handleSubmitPurchase}>Add to Cart</button>
      {total && (
      <div>
        <h3>Total: {total}€</h3>
      </div>
      )}
      {hasDiscount && (
      <div> 
        <h3>Discount: {discount}€</h3>
      </div>
      )
      }
    </div>)
};


