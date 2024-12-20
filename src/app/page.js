import styles from "./page.module.css";
import { prisma } from "../lib/prisma";

const Home = async () => {
  const posts = await prisma.post.findMany();
  const voucher = await prisma.voucher.findMany();

  return (
    <main className={styles.main}>
      Hello World <br />
      <ul style={{ display: 'flex', flexWrap: 'wrap', gap: '10px' }}>
        {voucher.map((entry) => (
          <li
            key={entry.id}
            style={{
              width: '100px',
              height: '100px',
              backgroundColor: entry.active ? 'lightgreen' : 'lightcoral',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              listStyleType: 'none',
            }}
          >
            {entry.name}
          </li>
        ))}
      </ul>

      
      <ul>
        {posts.map((post) => (
          <li key={post.id}>{post.name}</li>
        ))}
      </ul>
      
    </main>
  );
};

export default Home;
