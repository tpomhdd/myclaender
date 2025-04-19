import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static BannerAd? _bannerAd;
  static InterstitialAd? _interstitialAd;
  static RewardedAd? _rewardedAd;

  // Banner Ad
  static BannerAd loadBannerAd() {
    _bannerAd = BannerAd(
     // adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Test ID
     adUnitId: 'ca-app-pub-2621758642220553/1629300491', // Test ID

      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => print('Banner Ad Loaded'),
        onAdFailedToLoad: (ad, error) {
          print('Banner Failed to Load: $error');
          ad.dispose();
        },
      ),
    )..load();
    return _bannerAd!;
  }

  // Interstitial Ad
  static void loadInterstitialAd(Function onAdClosed) {
    InterstitialAd.load(
  //    adUnitId: 'ca-app-pub-3940256099942544/1033173712', // Test ID
    adUnitId: 'ca-app-pub-2621758642220553/3852139153',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              onAdClosed();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              print('Interstitial Ad failed to show: $error');
            },
          );
          _interstitialAd!.show();
        },
        onAdFailedToLoad: (error) => print('Failed to load interstitial: $error'),
      ),
    );
  }

  // Rewarded Ad
  static void loadRewardedAd(Function onRewardEarned) {
    RewardedAd.load(
  //    adUnitId: 'ca-app-pub-3940256099942544/5224354917', // Test ID
      adUnitId: 'ca-app-pub-2621758642220553/1297293857', // Test ID
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              print('Rewarded Ad failed to show: $error');
            },
          );
          _rewardedAd!.show(
            onUserEarnedReward: (ad, reward) {
              onRewardEarned();
            },
          );
        },
        onAdFailedToLoad: (error) => print('Failed to load rewarded ad: $error'),
      ),
    );
  }
}
void loadInterstitialWithDelay() async {
  await Future.delayed(Duration(seconds: 3)); // تأخير 10 ثواني
  AdManager.loadInterstitialAd(() {
    print("تم إغلاق الإعلان بنجاح");
  });
}
