package com.example.widget_home


import android.annotation.SuppressLint
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.graphics.Color
import android.util.Log
import android.widget.RemoteViews
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import es.antonborri.home_widget.HomeWidgetPlugin
import androidx.core.graphics.toColorInt


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
            val responseDate = HomeWidgetPlugin.getData(context)
            try {
                val rawData = responseDate.getString("CurrencyData" , "null")
                println("RawData Is : $rawData ")

                val gson = Gson()
                val mapType = object : TypeToken<List<CurrencyInfo>>() {}.type
                println("object type is : $mapType")
                println(mapType::class)
                val currencyList: List<CurrencyInfo> = gson.fromJson(rawData, mapType)
                println(currencyList[0].toString())
                val usdDate =
                    currencyList.find { it.symbol == "USD" } ?: CurrencyInfo(symbol = "USD")
                val uroDate =
                    currencyList.find { it.symbol == "EUR" } ?: CurrencyInfo(symbol = "EUR")
                println("USD price is ${usdDate.price}")
                val views = RemoteViews(context.packageName, R.layout.dollar_price)
                if(usdDate.changePercent > 0){
                    // set percent text color to red
                    views.setTextColor(R.id.txt_usd_change_percent ,"#f04f43".toColorInt())
                }else{
                    // set percent text color to green
                    views.setTextColor(R.id.txt_usd_change_percent , "#86fc8a".toColorInt())
                }
                if(uroDate.changePercent > 0){
                    // set percent text color to red
                    views.setTextColor(R.id.txt_euro_change_percent ,"#f04f43".toColorInt() )
                }else{
                    // set percent text color to green
                    views.setTextColor(R.id.txt_euro_change_percent , "#86fc8a".toColorInt())
                }
                views.setTextViewText(R.id.txt_dollar, "USD")
                views.setTextViewText(R.id.txt_euro, "EUR")
                views.setTextViewText(R.id.txt_usd_date, usdDate.date)
                views.setTextViewText(R.id.txt_usd_price, usdDate.price)
                views.setTextViewText(R.id.txt_usd_change_percent, usdDate.changePercent.toString())
                views.setTextViewText(R.id.txt_euro_price, uroDate.price)
                views.setTextViewText(R.id.txt_euro_change_percent, uroDate.changePercent.toString())
                views.setTextViewText(R.id.txt_date_euro, uroDate.date)

                appWidgetManager.updateAppWidget(appWidgetId, views)
            } catch (e: Exception) {
                Log.e("WidgetProvider", "Error parsing", e)
            }


//            updateAppWidget(context, appWidgetManager, appWidgetId)

        }
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