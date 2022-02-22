package com.mopub_flutter;

import android.content.Context;

import androidx.annotation.NonNull;

import com.mopub.common.MoPub;
import com.mopub.common.SdkConfiguration;
import com.mopub.common.SdkInitializationListener;
import com.mopub.common.logging.MoPubLog;

import java.util.HashMap;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.embedding.engine.plugins.FlutterPlugin;

import static com.mopub.common.logging.MoPubLog.SdkLogEvent.CUSTOM;

/**
 * MopubFlutterPlugin
 */
public class MopubFlutterPlugin implements FlutterPlugin, MethodCallHandler {

    private Context context;

    private MethodChannel channel;

    public MopubFlutterPlugin() {
    }

    private static void setup(MopubFlutterPlugin plugin, FlutterPluginBinding binding,
            BinaryMessenger binaryMessenger) {
        plugin.context = binding.getApplicationContext();
        plugin.channel = new MethodChannel(binaryMessenger, MopubConstants.MAIN_CHANNEL);
        plugin.channel.setMethodCallHandler(plugin);

        // Banner Ad PlatformView channel
        binding.getPlatformViewRegistry()
                .registerViewFactory(MopubConstants.BANNER_AD_CHANNEL, new MopubBannerAdPlugin(binaryMessenger));
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals(MopubConstants.INIT_METHOD))
            result.success(init((HashMap) call.arguments));
        else
            result.notImplemented();
    }

    private boolean init(HashMap initValues) {
        final boolean testMode = (boolean) initValues.get("testMode");
        final String adUnitId = (String) initValues.get("adUnitId");

        final SdkConfiguration.Builder configBuilder = new SdkConfiguration.Builder(adUnitId)
                .withLogLevel(testMode ? MoPubLog.LogLevel.DEBUG : MoPubLog.LogLevel.NONE);

        MoPub.initializeSdk(context, configBuilder.build(), new SdkInitializationListener() {
            @Override
            public void onInitializationFinished() {
                MoPubLog.log(CUSTOM, "##Flutter## MoPub SDK initialized." +
                        " AdUnitId: " + adUnitId + " TestMode:" + testMode);
            }
        });

        return true;
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        setup(this, flutterPluginBinding, flutterPluginBinding.getBinaryMessenger());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }
}
