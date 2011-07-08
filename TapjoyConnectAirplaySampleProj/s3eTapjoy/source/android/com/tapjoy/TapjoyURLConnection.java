package com.tapjoy;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.Map.Entry;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.util.EntityUtils;


public class TapjoyURLConnection
{
	private static final String TAPJOY_URL_CONNECTION = "TapjoyURLConnection";
	
	
	public TapjoyURLConnection()
	{
		
	}
	
	
	/**
	 * Performs a network request call to the specified URL and parameters.
	 * @param url					The base URL.
	 * @param params				The URL parameters.
	 * @return 						Response from the server.
	 */
	public String connectToURL(String url, String params)
	{
		String httpResponse = null;
		
		try
		{
			String requestURL = url + params;
			
			// Replaces all spaces.
			requestURL = requestURL.replaceAll(" ", "%20");
			
			TapjoyLog.i(TAPJOY_URL_CONNECTION, "baseURL: " + url);
			TapjoyLog.i(TAPJOY_URL_CONNECTION, "requestURL: " + requestURL);
			
			HttpGet http = new HttpGet(requestURL);
			
			// Create a HttpParams object so we can set our timeout times.
			HttpParams httpParameters = new BasicHttpParams();
			
			// Time to wait to establish initial connection.
			HttpConnectionParams.setConnectionTimeout(httpParameters, 15000);
			
			// Time to wait for incoming data.
			HttpConnectionParams.setSoTimeout(httpParameters, 30000);
			
			// Create a http client with out timeout settings.
			HttpClient client = new DefaultHttpClient(httpParameters);
			
			HttpResponse response = client.execute(http);
			HttpEntity entity = response.getEntity();
			
			httpResponse = EntityUtils.toString(entity);
			
			TapjoyLog.i(TAPJOY_URL_CONNECTION, "--------------------");
			TapjoyLog.i(TAPJOY_URL_CONNECTION, "response status: " + response.getStatusLine().getStatusCode());
			TapjoyLog.i(TAPJOY_URL_CONNECTION, "response size: " + httpResponse.length());
			TapjoyLog.i(TAPJOY_URL_CONNECTION, "response: ");
			TapjoyLog.i(TAPJOY_URL_CONNECTION, "" + httpResponse);
			TapjoyLog.i(TAPJOY_URL_CONNECTION, "--------------------");
		}
		catch (Exception e)
		{
			TapjoyLog.e(TAPJOY_URL_CONNECTION, "Exception: " + e.toString());
		}
		
		return httpResponse;
	}
	
	
	/**
	 * Performs a network request call using HTTP POST to the specified URL and parameters.
	 * @param url							The URL to connect to.
	 * @param params						POST parameters in key/value format.
	 * @param paramsData					Any additional POST parameters in key/value format.
	 * @return								Response from the server.
	 */
	public String connectToURLwithPOST(String url, Hashtable<String, String> params, Hashtable<String, String> paramsData)
	{
		String httpResponse = null;
		
		try
		{
			String requestURL = url;
			
			// Replaces all spaces.
			requestURL = requestURL.replaceAll(" ", "%20");
			
			TapjoyLog.i(TAPJOY_URL_CONNECTION, "baseURL: " + url);
			TapjoyLog.i(TAPJOY_URL_CONNECTION, "requestURL: " + requestURL);
			
			HttpPost httpPost = new HttpPost(requestURL);
			
			List<NameValuePair> pairs = new ArrayList<NameValuePair>();
			
			Set<Entry<String, String>> entries = params.entrySet();
			Iterator<Entry<String, String>> iterator = entries.iterator();
			
			while (iterator.hasNext())
			{
				Entry<String, String> item = iterator.next();
				pairs.add(new BasicNameValuePair(item.getKey(), item.getValue()));
				
				TapjoyLog.i(TAPJOY_URL_CONNECTION, "key: " + item.getKey() + ", value: " + item.getValue());
			}
			
			if (paramsData != null && paramsData.size() > 0)
			{
				entries = paramsData.entrySet();
				iterator = entries.iterator();
				
				while (iterator.hasNext())
				{
					Entry<String, String> item = iterator.next();
					pairs.add(new BasicNameValuePair("data[" + item.getKey() + "]", item.getValue()));
					
					TapjoyLog.i(TAPJOY_URL_CONNECTION, "key: " + item.getKey() + ", value: " + item.getValue());
				}
			}
			
			httpPost.setEntity(new UrlEncodedFormEntity(pairs));
			
			TapjoyLog.i(TAPJOY_URL_CONNECTION, "HTTP POST: " + httpPost.toString());
			
			// Create a HttpParams object so we can set our timeout times.
			HttpParams httpParameters = new BasicHttpParams();
			
			// Time to wait to establish initial connection.
			HttpConnectionParams.setConnectionTimeout(httpParameters, 15000);
			
			// Time to wait for incoming data.
			HttpConnectionParams.setSoTimeout(httpParameters, 30000);
			
			// Create a http client with out timeout settings.
			HttpClient client = new DefaultHttpClient(httpParameters);
			
			HttpResponse response = client.execute(httpPost);
			HttpEntity entity = response.getEntity();
			
			httpResponse = EntityUtils.toString(entity);
			
			TapjoyLog.i(TAPJOY_URL_CONNECTION, "--------------------");
			TapjoyLog.i(TAPJOY_URL_CONNECTION, "response status: " + response.getStatusLine().getStatusCode());
			TapjoyLog.i(TAPJOY_URL_CONNECTION, "response size: " + httpResponse.length());
			TapjoyLog.i(TAPJOY_URL_CONNECTION, "response: ");
			TapjoyLog.i(TAPJOY_URL_CONNECTION, "" + httpResponse);
			TapjoyLog.i(TAPJOY_URL_CONNECTION, "--------------------");
		}
		catch (Exception e)
		{
			TapjoyLog.e(TAPJOY_URL_CONNECTION, "Exception: " + e.toString());
		}
		
		return httpResponse;
	}
}