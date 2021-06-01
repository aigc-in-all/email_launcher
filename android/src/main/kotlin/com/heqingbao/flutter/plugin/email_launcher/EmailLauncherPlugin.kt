package com.heqingbao.flutter.plugin.email_launcher

import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

private const val TO = "to"
private const val CC = "cc"
private const val BCC = "bcc"
private const val SUBJECT = "subject"
private const val BODY = "body"

/** EmailLauncherPlugin */
public class EmailLauncherPlugin : FlutterPlugin, MethodCallHandler {

    private var context: Context? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "email_launcher")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "email_launcher")
            channel.setMethodCallHandler(EmailLauncherPlugin())
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "launch") {
            launchEmail(call, result)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    }

    private fun launchEmail(call: MethodCall, result: Result) {
        val intent = Intent(Intent.ACTION_SENDTO, Uri.parse("mailto:"))
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK

        if (call.hasArgument(TO)) {
            call.argument<ArrayList<String>>(TO)?.let { to ->
                intent.putExtra(Intent.EXTRA_EMAIL, listArrayToArray(to))
            }
        }

        if (call.hasArgument(CC)) {
            call.argument<ArrayList<String>>(CC)?.let { cc ->
                intent.putExtra(Intent.EXTRA_CC, listArrayToArray(cc))
            }
        }

        if (call.hasArgument(BCC)) {
            call.argument<ArrayList<String>>(BCC)?.let { bcc ->
                intent.putExtra(Intent.EXTRA_BCC, listArrayToArray(bcc))
            }
        }

        if (call.hasArgument(SUBJECT)) {
            call.argument<String>(SUBJECT)?.let { subject ->
                intent.putExtra(Intent.EXTRA_SUBJECT, subject)
            }
        }
        if (call.hasArgument(BODY)) {
            call.argument<String>(BODY)?.let { body ->
                intent.putExtra(Intent.EXTRA_TEXT, body)
            }
        }

        context?.let { ctx ->
            if (intent.resolveActivity(ctx.packageManager) != null) {
                ctx.startActivity(intent)
                result.success(true)
            } else {
                result.error("1", "No mail client or no mail configuration", null)
            }
        }
    }

    private fun listArrayToArray(r: ArrayList<String>): Array<String> {
        return r.toArray(arrayOfNulls<String>(r.size))
    }
}
