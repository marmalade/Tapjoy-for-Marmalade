package com.tapjoy;

/**
 * Any class calling spendTapPoints should implement TapjoySpendPointsNotifier so it can
 * receive the callback containing the virtual currency name/total info.
 */
public interface TapjoySpendPointsNotifier
{
	/**
	 * Callback containing the virtual currency name and total points information.
	 * @param currencyName	 The name of the virtual currency.
	 * @param pointTotal	 Total number of virtual currency earned.
	 */
	public void getSpendPointsResponse(String currencyName, int pointTotal);
	
	
	/**
	 * Call containing error message if spendTapPoints fails.
	 * @param error			The error message for a failed request.
	 */
	public void getSpendPointsResponseFailed(String error);
}

