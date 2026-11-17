package com.example.widget_home


import android.annotation.SuppressLint
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.util.Log
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin
import androidx.core.graphics.toColorInt
import org.json.JSONArray


/**
 * Implementation of App Widget functionality.
 */

data class CurrencyInfo(
    val symbol: String = "null",
    val price: String = "0",
    val date: String = "null",
    val changePercent: Double = 0.0,
)



class DollarPrice : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.dollar_price)
            var usdData = CurrencyInfo(symbol = "USD")
            var eurData = CurrencyInfo(symbol = "EUR")
            try {
                val rawData = HomeWidgetPlugin.getData(context).getString("CurrencyData", null)
                if (!rawData.isNullOrBlank() && rawData != "null") {
                    val currencyList = parseCurrencyList(rawData)
                    usdData = currencyList.find { it.symbol == "USD" } ?: usdData
                    eurData = currencyList.find { it.symbol == "EUR" } ?: eurData
                }
            } catch (e: Exception) {
                Log.e("WidgetProvider", "Error parsing widget data", e)
            }

            if (usdData.changePercent > 0) {
                views.setTextColor(R.id.txt_usd_change_percent, "#f04f43".toColorInt())
            } else {
                views.setTextColor(R.id.txt_usd_change_percent, "#86fc8a".toColorInt())
            }
            if (eurData.changePercent > 0) {
                views.setTextColor(R.id.txt_euro_change_percent, "#f04f43".toColorInt())
            } else {
                views.setTextColor(R.id.txt_euro_change_percent, "#86fc8a".toColorInt())
            }
            views.setTextViewText(R.id.txt_dollar, "USD")
            views.setTextViewText(R.id.txt_euro, "EUR")
            views.setTextViewText(R.id.txt_usd_date, usdData.date)
            views.setTextViewText(R.id.txt_usd_price, usdData.price)
            views.setTextViewText(R.id.txt_usd_change_percent, usdData.changePercent.toString())
            views.setTextViewText(R.id.txt_euro_price, eurData.price)
            views.setTextViewText(R.id.txt_euro_change_percent, eurData.changePercent.toString())
            views.setTextViewText(R.id.txt_date_euro, eurData.date)

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }

    private fun parseCurrencyList(rawData: String): List<CurrencyInfo> {
        val result = mutableListOf<CurrencyInfo>()
        val array = JSONArray(rawData)
        for (i in 0 until array.length()) {
            val obj = array.optJSONObject(i) ?: continue
            result.add(
                CurrencyInfo(
                    symbol = obj.optString("symbol", "null"),
                    price = obj.optString("price", "0"),
                    date = obj.optString("date", "null"),
                    changePercent = obj.optDouble("changePercent", 0.0),
                )
            )
        }
        return result
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}

@SuppressLint("RemoteViewLayout")
internal fun updateAppWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int
) {

    // Construct the RemoteViews object
    val views = RemoteViews(context.packageName, R.layout.dollar_price)
    views.setTextViewText(R.id.txt_dollar, "USD")
    views.setTextViewText(R.id.txt_euro, "URO")
    views.setTextViewText(R.id.txt_usd_date, "1403/11/02")
    views.setTextViewText(R.id.txt_usd_price, "94,100")
    views.setTextViewText(R.id.txt_usd_change_percent, "1.4")
    views.setTextViewText(R.id.txt_euro_price, "98,200")
    views.setTextViewText(R.id.txt_euro_change_percent, "1.8")
    views.setTextViewText(R.id.txt_date_euro, "1403/11/02")

    // Instruct the widget manager to update the widget
    appWidgetManager.updateAppWidget(appWidgetId, views)
}
