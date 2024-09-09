import styles from "./page.module.css";
import { prisma } from "../lib/prisma";

const Home = async () => {
  const posts = await prisma.post.findMany();

  return (
    <main className={styles.main}>
      Hello World <br />
      <ul>
        {posts.map((post) => (
          <li key={post.id}>{post.name}</li>
        ))}
      </ul>
    </main>
  );
};

export default Home;
