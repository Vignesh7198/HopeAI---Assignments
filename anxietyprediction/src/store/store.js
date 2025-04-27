import { configureStore } from "@reduxjs/toolkit";

import getReducer from "./slice";

export const store = configureStore(
    {
        reducer:{
            user:getReducer,
        }
    }
)

