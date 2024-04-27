const button_style = { 
  display: 'flex', 
  justifyContent: 'center' }

function Cart (props) {
  const [products, set_products] = React.useState([]);
  const [total, set_total] = React.useState(null);
  const [discount, set_discount] = React.useState(null);
  const [has_discount, set_has_discount] = React.useState(null);

  const add_to_cart = (product_code, quantity) => {
    const product_index = products.findIndex(product => product.product_code === product_code);

    if (product_index !== -1) {
      set_products(prev_products => {
        const updated_products = [...prev_products];
        updated_products[product_index].quantity = quantity;
        return updated_products;
      });
    } else {
      set_products(prev_products => [...prev_products, { product_code, quantity }]);
    }
  };

  const get_quantity = (product_code) => 
  {    
    const product_index = products.findIndex(product => product.product_code === product_code);

    if (product_index !== -1) 
    {
        return products[product_index].quantity;
    }
    else {
      return 0
    }
  }

  const increment = (product_code) => {
    const product_index = products.findIndex(product => product.product_code === product_code);

    if (product_index !== -1)
    {    
      const updated_products = [...products];
      add_to_cart(product_code, updated_products[product_index].quantity + 1 )
    }
    else
    {
      add_to_cart(product_code, 1);
    }
  };

  const decrement = (product_code) => {
    const product_index = products.findIndex(product => product.product_code === product_code);

    if (product_index !== -1)
    {    
      const updated_products = [...products];
      if (updated_products[product_index].quantity > 1)
        add_to_cart(product_code, updated_products[product_index].quantity - 1 )
      else 
        add_to_cart(product_code, 0 )
    }
  };

  const submit_cart = () => {
    const csrf_token = document.querySelector('[name=csrf-token]').content;
    const response = fetch('/add_to_cart', 
    {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrf_token,

      },
      body: JSON.stringify({ products: products }),
    }
    );

      //Wait for response and parse the data, updating total and discount
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
        set_has_discount(true);
        set_discount(data.discount_amount)
      }
      else
      {
        set_has_discount(false);
        set_discount(0)
      }
      set_total(data.total);
    })
    .catch(error => {
      console.error('Error fetching data:', error);
    });
  }

  
  return(
    <div>
      <ProductList get_quantity={get_quantity} cart={products} products={props.products}  increment={increment} decrement={decrement}></ProductList>
      <div style={button_style}>
        <button onClick={submit_cart}>Add to Cart</button>
      </div>
      {total && (
      <div>
        <h3>Total: {total}€</h3>
      </div>
      )}
      {has_discount && (
      <div> 
        <h3>Discount: {discount}€</h3>
      </div>
      )
      }
    </div>)
};


