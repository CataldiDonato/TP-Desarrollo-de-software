import "dotenv/config";
import app from './src/app';

// En Vercel la app corre como función serverless: no se levanta el servidor, solo se exporta.
if (!process.env.VERCEL) {
    const PORT = process.env.PORT || 3000;

    app.listen(PORT, () => {
        console.log(`Servidor Backend corriendo en http://localhost:${PORT} 🚀`);
    });
}

export default app;
