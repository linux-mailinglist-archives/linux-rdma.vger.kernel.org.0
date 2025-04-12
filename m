Return-Path: <linux-rdma+bounces-9386-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D91AA869FF
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Apr 2025 03:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9374C114F
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Apr 2025 01:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A6274E09;
	Sat, 12 Apr 2025 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ene4xxBX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471E817BB6;
	Sat, 12 Apr 2025 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744420847; cv=none; b=T5cHXYMM9kaOKXUB7uh/0TiTSL+GRIGW4NS+E1L7RnmY/uN/oAPNmQ/EzX0DV52kHMKW4+NDXiuaCSRKK8NOcUbNX3qTqaoYYkX4JItyVna0UKRNgUkLKw7bkis9VLG6DMHYtMQV2au/MxdrKEwHLDxWkGv+PmXbFoTcVcYVYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744420847; c=relaxed/simple;
	bh=CoQliKqWOHFzGKP4DchqFP7OVdp1mTfrv/cHHzKnePg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvN1MdAemvzSjLYU25NtlJE2fECHFIW7KlRmGqc7mKmSKp01Fcv3K0b9ROz7t02Ww1JFhTb8vFkc3NgM2y0/S65wuM5OgIZkGJ69NrhaacinBvnVhloZAk/P5eoL3ufEDtgwpuzoiMHmmlHSKsbQmHAG+UKAgQZA1tel1YB1s4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ene4xxBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EADC4CEE2;
	Sat, 12 Apr 2025 01:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744420846;
	bh=CoQliKqWOHFzGKP4DchqFP7OVdp1mTfrv/cHHzKnePg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ene4xxBXkuYwEtUfKCDeZCNQW9Xqn8hwwVQ4k/lsQOd3e7aMDfsfd0on6GZcyYpzQ
	 b7+Uwtjlo3+dsguHMuOf17/c/C1rTQGgOS2ZnvEwAUr8lT1vwNNTCr4jzPHyqZGX8U
	 X/tjMvTlvx8F/O9euitLcAg/olViXuQwC9WWzrRz19n+zhVFp32HDaUQdNi8RRJ+UN
	 x4rh4i2BuWNa0P7WglvTJ3kSK/beT0TyjIMQk6/svtSgvkIu67PYoVR4cvEYTWcKba
	 OVswweFe4z7/gWfyTv2rven6NbFwiX7YTB/7AUWfcxP+3R9SSR31KaLfzDv0C5tceC
	 c8ghQbKeC2yGA==
Date: Fri, 11 Apr 2025 18:20:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Bryan
 Whitehead <bryan.whitehead@microchip.com>, UNGLinuxDriver@microchip.com,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Paul Barker
 <paul.barker.ct@bp.renesas.com>, Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?=
 <niklas.soderlund@ragnatech.se>, Richard Cochran
 <richardcochran@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Andrei Botila <andrei.botila@oss.nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: ptp: introduce .supported_extts_flags
 to ptp_clock_info
Message-ID: <20250411182044.0ee40963@kernel.org>
In-Reply-To: <20250408-jk-supported-perout-flags-v1-1-d2f8e3df64f3@intel.com>
References: <20250408-jk-supported-perout-flags-v1-0-d2f8e3df64f3@intel.com>
	<20250408-jk-supported-perout-flags-v1-1-d2f8e3df64f3@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Sorry for the late nit but the conversion is pretty inconsistent..

On Tue, 08 Apr 2025 13:55:14 -0700 Jacob Keller wrote:
> diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
> index aed4a4b07f34b1643a8bf51c2501d1f61ef0cf0b..4c037d4853fdbb86b5082437efe2ae7308559d66 100644
> --- a/drivers/net/dsa/mv88e6xxx/ptp.c
> +++ b/drivers/net/dsa/mv88e6xxx/ptp.c
> @@ -332,13 +332,6 @@ static int mv88e6352_ptp_enable_extts(struct mv88e6xxx_chip *chip,
>  	int pin;
>  	int err;
>  
> -	/* Reject requests with unsupported flags */
> -	if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
> -				PTP_RISING_EDGE |
> -				PTP_FALLING_EDGE |
> -				PTP_STRICT_FLAGS))
> -		return -EOPNOTSUPP;
> -
>  	/* Reject requests to enable time stamping on both edges. */
>  	if ((rq->extts.flags & PTP_STRICT_FLAGS) &&
>  	    (rq->extts.flags & PTP_ENABLE_FEATURE) &&
> @@ -566,6 +559,11 @@ int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
>  	chip->ptp_clock_info.verify	= ptp_ops->ptp_verify;
>  	chip->ptp_clock_info.do_aux_work = mv88e6xxx_hwtstamp_work;
>  
> +	chip->ptp_clock_info.supported_extts_flags = PTP_ENABLE_FEATURE |
> +						     PTP_RISING_EDGE |
> +						     PTP_FALLING_EDGE |
> +						     PTP_STRICT_FLAGS;

Sometimes you leave all the flags be..

>  	if (ptp_ops->set_ptp_cpu_port) {
>  		struct dsa_port *dp;
>  		int upstream = 0;
> diff --git a/drivers/net/dsa/sja1105/sja1105_ptp.c b/drivers/net/dsa/sja1105/sja1105_ptp.c
> index 08b45fdd1d2482b0f1f922aae4ff18db8e279f09..a7e9f9ab7a19a8413f2f450c3b4b3f636a177c67 100644
> --- a/drivers/net/dsa/sja1105/sja1105_ptp.c
> +++ b/drivers/net/dsa/sja1105/sja1105_ptp.c
> @@ -820,13 +820,6 @@ static int sja1105_extts_enable(struct sja1105_private *priv,
>  	if (extts->index != 0)
>  		return -EOPNOTSUPP;
>  
> -	/* Reject requests with unsupported flags */
> -	if (extts->flags & ~(PTP_ENABLE_FEATURE |
> -			     PTP_RISING_EDGE |
> -			     PTP_FALLING_EDGE |
> -			     PTP_STRICT_FLAGS))
> -		return -EOPNOTSUPP;
> -
>  	/* We can only enable time stamping on both edges, sadly. */
>  	if ((extts->flags & PTP_STRICT_FLAGS) &&
>  	    (extts->flags & PTP_ENABLE_FEATURE) &&
> @@ -912,6 +905,9 @@ int sja1105_ptp_clock_register(struct dsa_switch *ds)
>  		.n_pins		= 1,
>  		.n_ext_ts	= 1,
>  		.n_per_out	= 1,
> +		.supported_extts_flags = PTP_ENABLE_FEATURE |
> +					 PTP_EXTTS_EDGES |
> +					 PTP_STRICT_FLAGS,

..sometimes you combine FALLNIG|RISING -> EDGES ..

>  	};
>  
>  	/* Only used on SJA1105 */
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 1fd1ae03eb90960d1e3e20acb0638baecaa995f5..96f68c356fe81b6954653f8903faf433ef6018f5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1624,14 +1624,6 @@ static int ice_ptp_cfg_extts(struct ice_pf *pf, struct ptp_extts_request *rq,
>  	int pin_desc_idx;
>  	u8 tmr_idx;
>  
> -	/* Reject requests with unsupported flags */
> -
> -	if (rq->flags & ~(PTP_ENABLE_FEATURE |
> -			  PTP_RISING_EDGE |
> -			  PTP_FALLING_EDGE |
> -			  PTP_STRICT_FLAGS))
> -		return -EOPNOTSUPP;
> -
>  	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
>  	chan = rq->index;
>  
> @@ -2737,6 +2729,10 @@ static void ice_ptp_set_caps(struct ice_pf *pf)
>  	info->enable = ice_ptp_gpio_enable;
>  	info->verify = ice_verify_pin;
>  
> +	info->supported_extts_flags = PTP_RISING_EDGE |
> +				      PTP_FALLING_EDGE |
> +				      PTP_STRICT_FLAGS;

sometimes you drop ENABLE

> +
>  	switch (pf->hw.mac_type) {
>  	case ICE_MAC_E810:
>  		ice_ptp_set_funcs_e810(pf);
> diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
> index f323e1c1989f1bfbbf1f04043c2c0f14ae8c716f..7dd5bf02ca32506666ce422ae3da23e66b0adfca 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
> @@ -502,13 +502,6 @@ static int igb_ptp_feature_enable_82580(struct ptp_clock_info *ptp,
>  
>  	switch (rq->type) {
>  	case PTP_CLK_REQ_EXTTS:
> -		/* Reject requests with unsupported flags */
> -		if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
> -					PTP_RISING_EDGE |
> -					PTP_FALLING_EDGE |
> -					PTP_STRICT_FLAGS))
> -			return -EOPNOTSUPP;
> -
>  		/* Both the rising and falling edge are timestamped */
>  		if (rq->extts.flags & PTP_STRICT_FLAGS &&
>  		    (rq->extts.flags & PTP_ENABLE_FEATURE) &&
> @@ -658,13 +651,6 @@ static int igb_ptp_feature_enable_i210(struct ptp_clock_info *ptp,
>  
>  	switch (rq->type) {
>  	case PTP_CLK_REQ_EXTTS:
> -		/* Reject requests with unsupported flags */
> -		if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
> -					PTP_RISING_EDGE |
> -					PTP_FALLING_EDGE |
> -					PTP_STRICT_FLAGS))
> -			return -EOPNOTSUPP;
> -
>  		/* Reject requests failing to enable both edges. */
>  		if ((rq->extts.flags & PTP_STRICT_FLAGS) &&
>  		    (rq->extts.flags & PTP_ENABLE_FEATURE) &&
> @@ -1356,6 +1342,10 @@ void igb_ptp_init(struct igb_adapter *adapter)
>  		adapter->ptp_caps.n_per_out = IGB_N_PEROUT;
>  		adapter->ptp_caps.n_pins = IGB_N_SDP;
>  		adapter->ptp_caps.pps = 0;
> +		adapter->ptp_caps.supported_extts_flags = PTP_ENABLE_FEATURE |
> +							  PTP_RISING_EDGE |
> +							  PTP_FALLING_EDGE |
> +							  PTP_STRICT_FLAGS;
>  		adapter->ptp_caps.pin_config = adapter->sdp_config;
>  		adapter->ptp_caps.adjfine = igb_ptp_adjfine_82580;
>  		adapter->ptp_caps.adjtime = igb_ptp_adjtime_82576;
> @@ -1378,6 +1368,8 @@ void igb_ptp_init(struct igb_adapter *adapter)
>  		adapter->ptp_caps.n_ext_ts = IGB_N_EXTTS;
>  		adapter->ptp_caps.n_per_out = IGB_N_PEROUT;
>  		adapter->ptp_caps.n_pins = IGB_N_SDP;
> +		adapter->ptp_caps.supported_extts_flags = PTP_EXTTS_EDGES |
> +							  PTP_STRICT_FLAGS;

sometimes you both drop the enabled and combine the edges 

>  		adapter->ptp_caps.pps = 1;
>  		adapter->ptp_caps.pin_config = adapter->sdp_config;
>  		adapter->ptp_caps.adjfine = igb_ptp_adjfine_82580;

No preference which version you pick but shouldn't we go with one?
Or is this on purpose to show we have no preference?
-- 
pw-bot: cr

