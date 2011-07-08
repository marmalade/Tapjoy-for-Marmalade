package com.tapjoy;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup.LayoutParams;
import android.view.Window;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.ProgressBar;
import android.widget.RelativeLayout;

/**
 * This is customized Tapjoy web view. It initially shows list of applications that user can download to earn points.
 */
public class TJCOffersWebView extends Activity
{
	private WebView webView = null;
	private String offersURL = null;													// URL to load the offer wall.

	private ProgressBar progressBar;
	private Dialog dialog = null;

	private String clientPackage = "";													// Package of the application using TapjoyConnect
	private String urlParams = "";														// URL parameters.
	private String userID = "";															// Publisher defined userID.

	final String TAPJOY_OFFERS = "Offers";

	@Override
	protected void onCreate(Bundle savedInstanceState)
	{	
		// Get URL parameters from the extras.
		Bundle extras = getIntent().getExtras();
		
		// Read the extras data if it's available.
		if (extras != null)
		{
			urlParams = extras.getString(TapjoyConstants.EXTRA_URL_PARAMS);
			clientPackage = extras.getString(TapjoyConstants.EXTRA_CLIENT_PACKAGE);
			userID = extras.getString(TapjoyConstants.EXTRA_USER_ID);
			
			// Generate the url parameters, then append the publisher ID.
			urlParams += "&" + TapjoyConstants.TJC_USER_ID + "=" + userID;
			
			TapjoyLog.i(TAPJOY_OFFERS, "urlParams: [" + urlParams + "]");
			TapjoyLog.i(TAPJOY_OFFERS, "clientPackage: [" + clientPackage + "]");
		}
		else
		{
			TapjoyLog.e(TAPJOY_OFFERS, "Tapjoy offers meta data initialization fail.");
		}
		
		// Build the URL with parameters.
		offersURL = TapjoyConstants.TJC_SERVICE_URL + TapjoyConstants.TJC_SHOW_OFFERS_URL_PATH + urlParams;
		
		offersURL = offersURL.replaceAll(" ", "%20");
		
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		
		//setContentView( this.getResources().getIdentifier("tapjoy_offers_web_view", "layout", clientPackage));
		
		RelativeLayout layout = new RelativeLayout(this);
		
		// Load and display the Offers WebView.
		//webView = (WebView) findViewById(this.getResources().getIdentifier("offersWebView", "id", clientPackage));
		webView = new WebView(this);
		webView.setWebViewClient(new TapjoyWebViewClient());
		
		WebSettings webSettings = webView.getSettings();
		webSettings.setJavaScriptEnabled(true);
		
		// Create our progress spinner.
		//progressBar = (ProgressBar)findViewById(getResources().getIdentifier("OfferProgressBar", "id", clientPackage));
		progressBar = new ProgressBar(this, null, android.R.attr.progressBarStyleLarge);
		progressBar.setVisibility(View.VISIBLE);
		
		// Center progress bar.
		RelativeLayout.LayoutParams layoutParams = new RelativeLayout.LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
        layoutParams.addRule(RelativeLayout.CENTER_IN_PARENT);
        progressBar.setLayoutParams(layoutParams);
        
        // Add relative layout to our content view.
        layout.addView(webView, LayoutParams.FILL_PARENT, LayoutParams.FILL_PARENT);		
		layout.addView(progressBar);
		setContentView(layout);
		
		//TapjoyLog.i(TAPJOY_OFFERS, "load web url: " + System.currentTimeMillis());
		
		webView.loadUrl(offersURL);
		
		TapjoyLog.i(TAPJOY_OFFERS, "Opening URL = [" + offersURL + "]");
	}

	
	@Override
	protected void onResume()
	{
		//TapjoyLog.i(TAPJOY_OFFERS, "onResume -- refreshing offers");
		
		super.onResume();
		
		// Refresh the offers page anytime we regain focus.
		if (offersURL != null && webView != null)
			webView.loadUrl(offersURL);
	}
	
	
	/**
	 * This class handle all events of tapjoy customized view, like to open link, test and verify url then load it in browser or market depends upon the url
	 */
	private class TapjoyWebViewClient extends WebViewClient
	{
		public void onPageStarted(WebView view, String url, Bitmap favicon)
		{
			progressBar.setVisibility(View.VISIBLE);
			progressBar.bringToFront();
		}
		
		public void onPageFinished(WebView view, String url)
		{
			//TapjoyLog.i(TAPJOY_OFFERS, "onPageFinished : " + System.currentTimeMillis());
			
			// Dismiss the progress wheel once the page is done loading.
			progressBar.setVisibility(View.GONE);
		}
		
		/**
		 * When any user hits any url from tapjoy custom view then this function is called before opening any user.
		 */
		public boolean shouldOverrideUrlLoading(WebView view, String url)
		{
			TapjoyLog.i(TAPJOY_OFFERS, "URL = ["+url+"]");
			
			if (url.indexOf("market") > -1)
			{
				TapjoyLog.i(TAPJOY_OFFERS, "Market URL = ["+url+"]");
				
				try
				{
					// Format is: "market://search?q=com.package.app"));
					String str[] = url.split("q=");
					String composeedURL = "http://market.android.com/details?id="+str[1]+"&referrer="+clientPackage;
					Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(composeedURL));
					startActivity(intent);
					TapjoyLog.i(TAPJOY_OFFERS, "Open URL of application = ["+composeedURL+"]");
				}
				catch(Exception e)
				{

					dialog = new AlertDialog.Builder(TJCOffersWebView.this).setTitle("").setMessage("Android market is unavailable at this device. To view this link install market.").setPositiveButton("OK", new DialogInterface.OnClickListener()
					{
						public void onClick(DialogInterface dialog, int whichButton)
						{
							dialog.dismiss();
						}
					}).create();
					
					try
					{
						dialog.show();
					}
					catch(Exception exp)
					{
						exp.printStackTrace();
					}

					TapjoyLog.i(TAPJOY_OFFERS, "Android market is unavailable at this device. To view this link install market.");
				}
			}
			else
			// Keep redirecting URLs in the webview.
			if (url.contains(TapjoyConstants.TJC_BASE_REDIRECT_DOMAIN))
			{
				TapjoyLog.i(TAPJOY_OFFERS, "Open redirecting URL = ["+url+"]");
				view.loadUrl(url);
			}
			else
			// Open all other items in a new window.
			{
				TapjoyLog.i(TAPJOY_OFFERS, "Opening URL in new browser = ["+url+"]");
				Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
				startActivity(intent);
			}

			return true;
		}
	}

	/**
	 * This handle hard back key at Android device.
	 */
	public boolean onKeyDown(int keyCode, KeyEvent event)
	{
		if ((keyCode == KeyEvent.KEYCODE_BACK) && webView.canGoBack())
		{
			webView.goBack();
			return true;
		}
		return super.onKeyDown(keyCode, event);
	}
}