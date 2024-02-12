import express, {Express, Request, Response} from 'express'
import dotenv from "dotenv";
import {supabase} from "./db";
dotenv.config();


const app: Express = express();
const port = process.env.PORT || 3000;
app.get("/", (req: Request, res:Response) => {
    res.send("Hello SC-ers!");
});

app.listen(port, async  () => {
    console.log("Listening on port " + port)
    const response = await  supabase.from('User').select("*")
    console.log(response)
});