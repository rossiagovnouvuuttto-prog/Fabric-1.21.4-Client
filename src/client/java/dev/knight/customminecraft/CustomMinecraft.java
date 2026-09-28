package dev.knight.customminecraft;

import net.fabricmc.api.ClientModInitializer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public final class CustomMinecraft implements ClientModInitializer {
    public static final String MOD_ID = "customminecraft";
    public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);

    @Override
    public void onInitializeClient() {
        LOGGER.info("Custom Minecraft 1.21.4 Fabric runtime loaded.");
    }
}
