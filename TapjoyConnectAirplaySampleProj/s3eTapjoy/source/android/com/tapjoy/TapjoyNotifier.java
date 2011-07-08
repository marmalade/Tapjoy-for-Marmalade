package com.tapjoy;

/**
 * Any class calling getTapPoints should implement TapjoyNotifier so it can
 * receive the callback containing the virtual currency name/total info.
 */
public interface TapjoyNotifier
{
	/**
	 * Callback containing the virtual currency name and total points information.
	 * @param currencyName	 The name of the virtual currency.
	 * @param pointTotal	 Total number of virtual currency earned.
	 */
	public void getUpdatePoints(String currencyName, int pointTotal);
	
	
	/**
	 * Call containing error message if getTapPoints fails.
	 * @param error			The error message for a failed request.
	 */
	public void getUpdatePointsFailed(String error);
}