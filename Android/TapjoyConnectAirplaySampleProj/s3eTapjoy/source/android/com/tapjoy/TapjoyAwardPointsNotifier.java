package com.tapjoy;

/**
 * Any class calling awardTapPoints should implement TapjoyAwardPointsNotifier so it can
 * receive the callback containing the virtual currency name/total info.
 */
public interface TapjoyAwardPointsNotifier
{
	/**
	 * Callback containing the virtual currency name and total points information.
	 * @param currencyName	 The name of the virtual currency.
	 * @param pointTotal	 Total number of virtual currency earned.
	 */
	public void getAwardPointsResponse(String currencyName, int pointTotal);
	
	
	/**
	 * Call containing error message if spendTapPoints fails.
	 * @param error			The error message for a failed request.
	 */
	public void getAwardPointsResponseFailed(String error);
}

