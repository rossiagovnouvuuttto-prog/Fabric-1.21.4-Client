package dev.knight.fabric1214;

import net.fabricmc.api.ClientModInitializer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public final class ClientMain implements ClientModInitializer {
    public static final String MOD_ID = "fabric1214client";
    public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);

    @Override
    public void onInitializeClient() {
        LOGGER.info("Fabric 1.21.4 client loaded successfully.");
    }
}
