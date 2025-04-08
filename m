Return-Path: <linux-rdma+bounces-9279-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D05A81741
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 22:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 896F67B7E71
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 20:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFF12550A5;
	Tue,  8 Apr 2025 20:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="admFDjxM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565F525333E;
	Tue,  8 Apr 2025 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744145733; cv=none; b=MGeaV000myMmstfeIb3T04+fk82XB4yk3LqD8jFLqpbg616EmfvrVruOB06vUSaUrD8Vn3rOH5EciAqR/3aLA31HC9gr7zpElSNYVCDSZafkt4EqOnLXpx3aMY1v5R87f6eQWnSdbBT4ZGWg9FDP7aEFYO0WJamniR1WwK0W9AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744145733; c=relaxed/simple;
	bh=3Ez1p1CtSQmA+CuP5eRjxp2rkuhj5NNe7rsL/JVzk94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cCLDsohNevNQYeYphbEn25wYSLX8qpBRW2mBBCDgaG86iDiADVdrdjHLbd7tuL1MFN26GBtfqhCIixJOhWHaiwcpCWyPiVahSjB3Xh+dsxKw4uutE5Gdo99AJ6AgGcCmHm7FwvLvwn64EDKRNzd+SqjxQe522BOXnJPo8At2A6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=admFDjxM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744145731; x=1775681731;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=3Ez1p1CtSQmA+CuP5eRjxp2rkuhj5NNe7rsL/JVzk94=;
  b=admFDjxMCesPnwdkf8SRN10UAcEFPbAyp/DzrxwHa6TNRlAS7CGE4nex
   frfHOKNxutXpgtvNbeaH0Q0gVjj7ENAKhgBEcxAlOQqTJ7ObqLb12CzB/
   krQq6meKWfBCVPHqWX+GyeNFHYZgfvF4OVU94kZzLu8hd1RXVkigeJW9w
   lbHmjb/vqyLHyK0b4HrbQTgh8LQyYy2x61ZnsEfgbc8ANb5hyLeZwyfk3
   4GKcwGBCiWloOZP0uaB2/kljTWhCvc4TBKNY2a+8PWXk4Jv8KANE8gs4u
   oywJCbiVC6W8dVzs0jDflc5gG3jjetkOIDixyIuN/vynYhVDi86ovLBsL
   A==;
X-CSE-ConnectionGUID: LbpbJfxKR3arECdPNrDcOA==
X-CSE-MsgGUID: eqB3akM7RMCi0n74VpkBZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56970739"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="56970739"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 13:55:29 -0700
X-CSE-ConnectionGUID: 55TU8aK8TNKRlis1LpGcZw==
X-CSE-MsgGUID: vkZt3/47TFSxR10ayAfYUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="151563683"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 13:55:28 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 08 Apr 2025 13:55:15 -0700
Subject: [PATCH net-next 2/2] net: ptp: introduce .supported_perout_flags
 to ptp_clock_info
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250408-jk-supported-perout-flags-v1-2-d2f8e3df64f3@intel.com>
References: <20250408-jk-supported-perout-flags-v1-0-d2f8e3df64f3@intel.com>
In-Reply-To: <20250408-jk-supported-perout-flags-v1-0-d2f8e3df64f3@intel.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Bryan Whitehead <bryan.whitehead@microchip.com>, 
 UNGLinuxDriver@microchip.com, Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Andrei Botila <andrei.botila@oss.nxp.com>, 
 Claudiu Manoil <claudiu.manoil@nxp.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2

The PTP_PEROUT_REQUEST2 ioctl has gained support for flags specifying
specific output behavior including PTP_PEROUT_ONE_SHOT,
PTP_PEROUT_DUTY_CYCLE, PTP_PEROUT_PHASE.

Driver authors are notorious for not checking the flags of the request.
This results in misinterpreting the request, generating an output signal
that does not match the requested value. It is anticipated that even more
flags will be added in the future, resulting in even more broken requests.

Expecting these issues to be caught during review or playing whack-a-mole
after the fact is not a great solution.

Instead, introduce the supported_perout_flags field in the ptp_clock_info
structure. Update the core character device logic to explicitly reject any
request which has a flag not on this list.

This ensures that drivers must 'opt in' to the flags they support. Drivers
which don't set the .supported_perout_flags field will not need to check
that unsupported flags aren't passed, as the core takes care of this.

Update the drivers which do support flags to set this new field.

Note the following driver files set n_per_out to a non-zero value but did
not check the flags at all:

 • drivers/ptp/ptp_clockmatrix.c
 • drivers/ptp/ptp_idt82p33.c
 • drivers/ptp/ptp_fc3.c
 • drivers/net/ethernet/ti/am65-cpts.c
 • drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
 • drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
 • drivers/net/dsa/sja1105/sja1105_ptp.c
 • drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
 • drivers/net/ethernet/mscc/ocelot_vsc7514.c
 • drivers/net/ethernet/intel/i40e/i40e_ptp.c

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 include/linux/ptp_clock_kernel.h                     |  6 ++++++
 drivers/net/dsa/sja1105/sja1105_ptp.c                |  4 ----
 drivers/net/ethernet/intel/ice/ice_ptp.c             |  4 +---
 drivers/net/ethernet/intel/igc/igc_ptp.c             |  4 ----
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c  | 15 +++------------
 drivers/net/ethernet/microchip/lan743x_ptp.c         |  5 +----
 drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c |  6 ++----
 drivers/net/ethernet/mscc/ocelot_ptp.c               |  5 -----
 drivers/net/ethernet/mscc/ocelot_vsc7514.c           |  2 ++
 drivers/net/ethernet/renesas/ravb_ptp.c              |  4 ----
 drivers/net/phy/dp83640.c                            |  3 ---
 drivers/net/phy/micrel.c                             |  9 ++-------
 drivers/net/phy/microchip_rds_ptp.c                  |  5 +----
 drivers/net/phy/nxp-c45-tja11xx.c                    |  4 +---
 drivers/ptp/ptp_chardev.c                            |  2 ++
 15 files changed, 21 insertions(+), 57 deletions(-)

diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 25cba2e5ee69c6a52f0d8a95653988371da379a2..eced7e9bf69a81f9b87b5fd4ff56074647f7aef4 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -69,6 +69,11 @@ struct ptp_system_timestamp {
  * @n_pins:    The number of programmable pins.
  * @pps:       Indicates whether the clock supports a PPS callback.
  *
+ * @supported_perout_flags:  The set of flags the driver supports for the
+ *                           PTP_PEROUT_REQUEST ioctl. The PTP core will
+ *                           reject a request with any flag not specified
+ *                           here.
+ *
  * @supported_extts_flags:  The set of flags the driver supports for the
  *                          PTP_EXTTS_REQUEST ioctl. The PTP core will use
  *                          this list to reject unsupported requests.
@@ -185,6 +190,7 @@ struct ptp_clock_info {
 	int n_per_out;
 	int n_pins;
 	int pps;
+	unsigned int supported_perout_flags;
 	unsigned int supported_extts_flags;
 	struct ptp_pin_desc *pin_config;
 	int (*adjfine)(struct ptp_clock_info *ptp, long scaled_ppm);
diff --git a/drivers/net/dsa/sja1105/sja1105_ptp.c b/drivers/net/dsa/sja1105/sja1105_ptp.c
index a7e9f9ab7a19a8413f2f450c3b4b3f636a177c67..6c1280b761e636e139dae060ab414c501eb1bf76 100644
--- a/drivers/net/dsa/sja1105/sja1105_ptp.c
+++ b/drivers/net/dsa/sja1105/sja1105_ptp.c
@@ -737,10 +737,6 @@ static int sja1105_per_out_enable(struct sja1105_private *priv,
 	if (perout->index != 0)
 		return -EOPNOTSUPP;
 
-	/* Reject requests with unsupported flags */
-	if (perout->flags)
-		return -EOPNOTSUPP;
-
 	mutex_lock(&ptp_data->lock);
 
 	rc = sja1105_change_ptp_clk_pin_func(priv, PTP_PF_PEROUT);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 96f68c356fe81b6954653f8903faf433ef6018f5..be691b716edb000364868cca2ad6f5e6f02aece7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1794,9 +1794,6 @@ static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
 	struct ice_hw *hw = &pf->hw;
 	int pin_desc_idx;
 
-	if (rq->flags & ~PTP_PEROUT_PHASE)
-		return -EOPNOTSUPP;
-
 	pin_desc_idx = ice_ptp_find_pin_idx(pf, PTP_PF_PEROUT, rq->index);
 	if (pin_desc_idx < 0)
 		return -EIO;
@@ -2732,6 +2729,7 @@ static void ice_ptp_set_caps(struct ice_pf *pf)
 	info->supported_extts_flags = PTP_RISING_EDGE |
 				      PTP_FALLING_EDGE |
 				      PTP_STRICT_FLAGS;
+	info->supported_perout_flags = PTP_PEROUT_PHASE;
 
 	switch (pf->hw.mac_type) {
 	case ICE_MAC_E810:
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 66a3a3ff1d8e3a91481c04d0055b48f177c13039..f9fb4f8d61c603d47d6aead5f6cbe0ba377a05be 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -293,10 +293,6 @@ static int igc_ptp_feature_enable_i225(struct ptp_clock_info *ptp,
 		return 0;
 
 	case PTP_CLK_REQ_PEROUT:
-		/* Reject requests with unsupported flags */
-		if (rq->perout.flags)
-			return -EOPNOTSUPP;
-
 		if (on) {
 			pin = ptp_find_pin(igc->ptp_clock, PTP_PF_PEROUT,
 					   rq->perout.index);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 3eee84430ac98b7fe61469be684a0d1e92a03b39..cec18efadc7330c84ce545efc5922c359ac6b470 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -813,12 +813,6 @@ static int perout_conf_npps_real_time(struct mlx5_core_dev *mdev, struct ptp_clo
 	return 0;
 }
 
-static bool mlx5_perout_verify_flags(struct mlx5_core_dev *mdev, unsigned int flags)
-{
-	return ((!mlx5_npps_real_time_supported(mdev) && flags) ||
-		(mlx5_npps_real_time_supported(mdev) && flags & ~PTP_PEROUT_DUTY_CYCLE));
-}
-
 static int mlx5_perout_configure(struct ptp_clock_info *ptp,
 				 struct ptp_clock_request *rq,
 				 int on)
@@ -854,12 +848,6 @@ static int mlx5_perout_configure(struct ptp_clock_info *ptp,
 		goto unlock;
 	}
 
-	/* Reject requests with unsupported flags */
-	if (mlx5_perout_verify_flags(mdev, rq->perout.flags)) {
-		err = -EOPNOTSUPP;
-		goto unlock;
-	}
-
 	if (on) {
 		pin_mode = MLX5_PIN_MODE_OUT;
 		pattern = MLX5_OUT_PATTERN_PERIODIC;
@@ -1031,6 +1019,9 @@ static void mlx5_init_pin_config(struct mlx5_core_dev *mdev)
 						PTP_FALLING_EDGE |
 						PTP_STRICT_FLAGS;
 
+	if (mlx5_npps_real_time_supported(mdev))
+		clock->ptp_info.supported_perout_flags = PTP_PEROUT_DUTY_CYCLE;
+
 	for (i = 0; i < clock->ptp_info.n_pins; i++) {
 		snprintf(clock->ptp_info.pin_config[i].name,
 			 sizeof(clock->ptp_info.pin_config[i].name),
diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c b/drivers/net/ethernet/microchip/lan743x_ptp.c
index c3dd4f493bd22dab65a65db42ff9a3b2d4b3696d..e4f88fa863fc8de3515a08dc7ebd98e9bd7053a6 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
@@ -463,10 +463,6 @@ static int lan743x_ptp_perout(struct lan743x_adapter *adapter, int on,
 	struct lan743x_ptp_perout *perout = &ptp->perout[index];
 	int ret = 0;
 
-	/* Reject requests with unsupported flags */
-	if (perout_request->flags & ~PTP_PEROUT_DUTY_CYCLE)
-		return -EOPNOTSUPP;
-
 	if (on) {
 		perout_pin = ptp_find_pin(ptp->ptp_clock, PTP_PF_PEROUT,
 					  perout_request->index);
@@ -1540,6 +1536,7 @@ int lan743x_ptp_open(struct lan743x_adapter *adapter)
 	ptp->ptp_clock_info.supported_extts_flags = PTP_STRICT_FLAGS |
 						    PTP_RISING_EDGE |
 						    PTP_FALLING_EDGE;
+	ptp->ptp_clock_info.supported_perout_flags = PTP_PEROUT_DUTY_CYCLE;
 	ptp->ptp_clock_info.pin_config = ptp->pin_config;
 	ptp->ptp_clock_info.adjfine = lan743x_ptpci_adjfine;
 	ptp->ptp_clock_info.adjtime = lan743x_ptpci_adjtime;
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
index 1ba1b595ab935f8992120f15073af1d2d6e6de8b..9657d7476e24a5a13e56285e087a79f06157d002 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
@@ -815,10 +815,6 @@ static int lan966x_ptp_perout(struct ptp_clock_info *ptp,
 	bool pps = false;
 	int pin;
 
-	if (rq->perout.flags & ~(PTP_PEROUT_DUTY_CYCLE |
-				 PTP_PEROUT_PHASE))
-		return -EOPNOTSUPP;
-
 	pin = ptp_find_pin(phc->clock, PTP_PF_PEROUT, rq->perout.index);
 	if (pin == -1 || pin >= LAN966X_PHC_PINS_NUM)
 		return -EINVAL;
@@ -975,6 +971,8 @@ static struct ptp_clock_info lan966x_ptp_clock_info = {
 	.supported_extts_flags = PTP_ENABLE_FEATURE |
 				 PTP_RISING_EDGE |
 				 PTP_STRICT_FLAGS,
+	.supported_perout_flags = PTP_PEROUT_DUTY_CYCLE |
+				  PTP_PEROUT_PHASE,
 };
 
 static int lan966x_ptp_phc_init(struct lan966x *lan966x,
diff --git a/drivers/net/ethernet/mscc/ocelot_ptp.c b/drivers/net/ethernet/mscc/ocelot_ptp.c
index cc1088988da0948bd7f6212dbeace5c032383c26..d2a0a32f75ea90529641d2288fa56d3ab6d0f2e6 100644
--- a/drivers/net/ethernet/mscc/ocelot_ptp.c
+++ b/drivers/net/ethernet/mscc/ocelot_ptp.c
@@ -211,11 +211,6 @@ int ocelot_ptp_enable(struct ptp_clock_info *ptp,
 
 	switch (rq->type) {
 	case PTP_CLK_REQ_PEROUT:
-		/* Reject requests with unsupported flags */
-		if (rq->perout.flags & ~(PTP_PEROUT_DUTY_CYCLE |
-					 PTP_PEROUT_PHASE))
-			return -EOPNOTSUPP;
-
 		pin = ptp_find_pin(ocelot->ptp_clock, PTP_PF_PEROUT,
 				   rq->perout.index);
 		if (pin == 0)
diff --git a/drivers/net/ethernet/mscc/ocelot_vsc7514.c b/drivers/net/ethernet/mscc/ocelot_vsc7514.c
index 055b55651a49fdc390acc0df22bf4258b78d6c43..498eec8ae61d83455bf9b54d685126daeb11bf6f 100644
--- a/drivers/net/ethernet/mscc/ocelot_vsc7514.c
+++ b/drivers/net/ethernet/mscc/ocelot_vsc7514.c
@@ -108,6 +108,8 @@ static struct ptp_clock_info ocelot_ptp_clock_info = {
 	.n_ext_ts	= 0,
 	.n_per_out	= OCELOT_PTP_PINS_NUM,
 	.n_pins		= OCELOT_PTP_PINS_NUM,
+	.supported_perout_flags = PTP_PEROUT_DUTY_CYCLE |
+				  PTP_PEROUT_PHASE,
 	.pps		= 0,
 	.gettime64	= ocelot_ptp_gettime64,
 	.settime64	= ocelot_ptp_settime64,
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index 93c8ca49e97a714af62bf2f4d3edce6bc5969835..61fe4259308bf36a5f15fcffcfdc41fefaf3ae17 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -206,10 +206,6 @@ static int ravb_ptp_perout(struct ptp_clock_info *ptp,
 	unsigned long flags;
 	int error = 0;
 
-	/* Reject requests with unsupported flags */
-	if (req->flags)
-		return -EOPNOTSUPP;
-
 	if (req->index)
 		return -EINVAL;
 
diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 694e6125ead8c37af1cdde9db264d1e75180698d..68885d8327e52a96f15d650a721ab4d6921e562d 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -506,9 +506,6 @@ static int ptp_dp83640_enable(struct ptp_clock_info *ptp,
 		return 0;
 
 	case PTP_CLK_REQ_PEROUT:
-		/* Reject requests with unsupported flags */
-		if (rq->perout.flags)
-			return -EOPNOTSUPP;
 		if (rq->perout.index >= N_PER_OUT)
 			return -EINVAL;
 		return periodic_output(clock, rq, on, rq->perout.index);
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index f469aaa423ecf71acc99d1abe75cf5a26f77b7b3..77f1307756fd1946e64f2c6175c3a143a997139a 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -3236,10 +3236,6 @@ static int lan8814_ptp_perout(struct ptp_clock_info *ptpci,
 	int pulse_width;
 	int pin, event;
 
-	/* Reject requests with unsupported flags */
-	if (rq->perout.flags & ~PTP_PEROUT_DUTY_CYCLE)
-		return -EOPNOTSUPP;
-
 	mutex_lock(&shared->shared_lock);
 	event = rq->perout.index;
 	pin = ptp_find_pin(shared->ptp_clock, PTP_PF_PEROUT, event);
@@ -3915,6 +3911,7 @@ static int lan8814_ptp_probe_once(struct phy_device *phydev)
 	shared->ptp_clock_info.supported_extts_flags = PTP_ENABLE_FEATURE |
 						       PTP_EXTTS_EDGES |
 						       PTP_STRICT_FLAGS;
+	shared->ptp_clock_info.supported_perout_flags = PTP_PEROUT_DUTY_CYCLE;
 	shared->ptp_clock_info.pin_config = shared->pin_config;
 	shared->ptp_clock_info.n_per_out = LAN8814_PTP_PEROUT_NUM;
 	shared->ptp_clock_info.adjfine = lan8814_ptpci_adjfine;
@@ -5066,9 +5063,6 @@ static int lan8841_ptp_perout(struct ptp_clock_info *ptp,
 	int pin;
 	int ret;
 
-	if (rq->perout.flags & ~PTP_PEROUT_DUTY_CYCLE)
-		return -EOPNOTSUPP;
-
 	pin = ptp_find_pin(ptp_priv->ptp_clock, PTP_PF_PEROUT, rq->perout.index);
 	if (pin == -1 || pin >= LAN8841_PTP_GPIO_NUM)
 		return -EINVAL;
@@ -5312,6 +5306,7 @@ static struct ptp_clock_info lan8841_ptp_clock_info = {
 	.n_per_out      = LAN8841_PTP_GPIO_NUM,
 	.n_ext_ts       = LAN8841_PTP_GPIO_NUM,
 	.n_pins         = LAN8841_PTP_GPIO_NUM,
+	.supported_perout_flags = PTP_PEROUT_DUTY_CYCLE,
 };
 
 #define LAN8841_OPERATION_MODE_STRAP_LOW_REGISTER 3
diff --git a/drivers/net/phy/microchip_rds_ptp.c b/drivers/net/phy/microchip_rds_ptp.c
index 3e6bf10cdeed9e42a935d75be972bab4233ff1cc..e6514ce04c29fa9eefe8a89398b11578badf1256 100644
--- a/drivers/net/phy/microchip_rds_ptp.c
+++ b/drivers/net/phy/microchip_rds_ptp.c
@@ -224,10 +224,6 @@ static int mchp_rds_ptp_perout(struct ptp_clock_info *ptpci,
 	struct phy_device *phydev = clock->phydev;
 	int ret, event_pin, pulsewidth;
 
-	/* Reject requests with unsupported flags */
-	if (perout->flags & ~PTP_PEROUT_DUTY_CYCLE)
-		return -EOPNOTSUPP;
-
 	event_pin = ptp_find_pin(clock->ptp_clock, PTP_PF_PEROUT,
 				 perout->index);
 	if (event_pin != clock->event_pin)
@@ -1259,6 +1255,7 @@ struct mchp_rds_ptp_clock *mchp_rds_ptp_probe(struct phy_device *phydev, u8 mmd,
 	clock->caps.pps            = 0;
 	clock->caps.n_pins         = MCHP_RDS_PTP_N_PIN;
 	clock->caps.n_per_out      = MCHP_RDS_PTP_N_PEROUT;
+	clock->caps.supported_perout_flags = PTP_PEROUT_DUTY_CYCLE;
 	clock->caps.pin_config     = clock->pin_config;
 	clock->caps.adjfine        = mchp_rds_ptp_ltc_adjfine;
 	clock->caps.adjtime        = mchp_rds_ptp_ltc_adjtime;
diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 1f74a30ea790b222ed5e373d83c2a6babc7ab4c2..b4733a0895b5fc0273d58534ced63271c303e779 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -763,9 +763,6 @@ static int nxp_c45_perout_enable(struct nxp_c45_phy *priv,
 	struct phy_device *phydev = priv->phydev;
 	int pin;
 
-	if (perout->flags & ~PTP_PEROUT_PHASE)
-		return -EOPNOTSUPP;
-
 	pin = ptp_find_pin(priv->ptp_clock, PTP_PF_PEROUT, perout->index);
 	if (pin < 0)
 		return pin;
@@ -960,6 +957,7 @@ static int nxp_c45_init_ptp_clock(struct nxp_c45_phy *priv)
 					 PTP_RISING_EDGE |
 					 PTP_FALLING_EDGE |
 					 PTP_STRICT_FLAGS,
+		.supported_perout_flags = PTP_PEROUT_PHASE,
 	};
 
 	priv->ptp_clock = ptp_clock_register(&priv->caps,
diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index c24228c139549d14d95a1ff080e75c28420f40bd..4bf421765d03332234aac405fc594842760037f1 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -324,6 +324,8 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 			err = -EINVAL;
 			break;
 		}
+		if (req.perout.flags & ~ptp->info->supported_perout_flags)
+			return -EOPNOTSUPP;
 		req.type = PTP_CLK_REQ_PEROUT;
 		enable = req.perout.period.sec || req.perout.period.nsec;
 		if (mutex_lock_interruptible(&ptp->pincfg_mux))

-- 
2.48.1.397.gec9d649cc640


