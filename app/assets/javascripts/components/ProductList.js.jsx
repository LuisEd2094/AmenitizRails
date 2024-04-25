
const productGridStyles = {
  display: 'grid',
  gridTemplateColumns: 'repeat(auto-fill, minmax(250px, 1fr))',
  gap: '20px',

};

const productCardStyles = {
  border: '1px solid #ccc',
  padding: '20px',
};



function ProductList({ products, handleAddToCart, handleIncrement, handleDecrement, getQuantity }){
  return (
    <div style={productGridStyles}>
      {products.map(product => (
        <div key={product.id} style={productCardStyles}>
          <div>
            <h3>{product.name}</h3>
            <p>Price: {product.price}€</p>
          </div>
          <div>
              <button onClick={() => handleDecrement(product.code)}>-</button>
              <span style={{ margin: '0 10px' }}>{getQuantity(product.code)}</span>
              <button onClick={() => handleIncrement(product.code)}>+</button>
            </div>
        </div>
      ))}
    </div>
  );
};
