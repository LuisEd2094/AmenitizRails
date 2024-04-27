
const product_grid_styles = {
  display: 'grid',
  gridTemplateColumns: 'repeat(auto-fill, minmax(250px, 1fr))',
  gap: '20px',

};

const product_card_styles = {
  padding: '20px',
};



function ProductList({ products, increment, decrement, get_quantity }){
  return (
    <div style={product_grid_styles}>
      {products.map(product => (
        <div key={product.id} style={product_card_styles}>
          <div>
            <h3>{product.name}</h3>
            <p>Price: {product.price}€</p>
          </div>
          <div>
              <button onClick={() => decrement(product.code)}>-</button>
              <span style={{ margin: '0 10px' }}>{get_quantity(product.code)}</span>
              <button onClick={() => increment(product.code)}>+</button>
            </div>
        </div>
      ))}
    </div>
  );
};
