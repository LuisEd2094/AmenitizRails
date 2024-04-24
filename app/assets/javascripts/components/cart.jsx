import { useState } from 'react';


function Cart(props) {
  console.log(props)
  const [selectedProducts, setSelectedProducts] = React.useState([]);
  const [total, setTotal] = React.useState(null);

  const handleAddToCart = (productCode, quantity) => {
    setSelectedProducts(prevSelectedProducts => [...prevSelectedProducts, { productCode, quantity }]);
  };
  
  const handleSubmitPurchase =  (event) => {
    event.preventDefault();
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
      setTotal(data.total);
    })
    .catch(error => {
      console.error('Error fetching data:', error);
    });
  }

  return (
    <div>
      <h2>Product List</h2>
      <ul>
        {props.products.map(product => (
          <li key={product.id}>
            {product.name} - ${product.price}
            <input type="number" min="1" defaultValue="0" onChange={(e) => handleAddToCart(product.code, parseInt(e.target.value))} />
          </li>
        ))}
      </ul>
      <button onClick={handleSubmitPurchase}>Add to Cart</button>

      {total && (
      <div>
        <h3>Total: ${total}</h3>
      </div>
    )}
    </div>
    
  );
};

