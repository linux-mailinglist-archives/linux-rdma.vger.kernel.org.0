Return-Path: <linux-rdma+bounces-14633-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26609C72D97
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 09:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F5B035B44A
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 08:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01893112A5;
	Thu, 20 Nov 2025 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PUagXUfX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA2C310625
	for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627010; cv=none; b=aY7YpU3eBjj9LNNgcuHDpBtolR2WYfv/U8XqZRd1fb0B72WvOKjpl/UFgBT6WgpM7TOc7Glx/3IxmGltX/blbVgGtdVi/kRvXzo7o9w0iL8bGh7Xk0m/weMGBmjdD1d15dotB7rXOfLlEOkaLV8Zce20KaaoheaDlV7s+jpRCpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627010; c=relaxed/simple;
	bh=lz3C1BijMM/g4Dp1N7kwcUbZURUQDWRihRMwyfRAp7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3bT6Yp5Np6OPa4R/0xzFMs4RKjS9TtCoUKxkVqRA0QE0PsR3aHBKzop5OarzyUS4VK6aqmFt1vF0rHxiFL1HSQO4dWuD1onwPK1bvgr2z9mcXl6D7Wsj5mPCNcKUE2SpROOJNDzRRfs6tOw1d9gOqht6CB37EwTWMZaP6o/pyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PUagXUfX; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5BEB41A1C0F;
	Thu, 20 Nov 2025 08:23:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 279926068C;
	Thu, 20 Nov 2025 08:23:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F32D103713E4;
	Thu, 20 Nov 2025 09:23:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763627005; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=rBaqG1h8z9S+3XpuGkfDmFNGqfXLXYWP7uVYMOf3F90=;
	b=PUagXUfXM9tyJNSXOBVjjJcPpyZQy4GtFge/T/V1pSIUmT8SPuowJtOX3WrTfxBMaKuX4F
	JiIvdAaKXcMYRamukpU789W7490Ucl9xvQIEgkmrre81qZgU0tMx3ro58FwzoCjkfjVeR9
	lHKz34BONXelHHVI8gf0/sElMBqXomzINk/7wk22axNqPYVTTFdjFrLg9sQZ12A2ByInFH
	09fm6Uz1gfA67Y3hS63WLypgXdUFV8r3JAlAb/01fLPfSGGNvttBDQ2aEjq4ZXsnbxmLqw
	tjCTHmAmWvveGDYLCJNdbAyvAmg+5RLNQZzguLNlzYUygXUjgEFh64+/AF/kRw==
Message-ID: <06661540-a1d5-496c-a807-1aa4577b4361@bootlin.com>
Date: Thu, 20 Nov 2025 09:23:20 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 1/3] net: ethtool: Add support for 1600Gbps
 speed
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Shahar Shitrit <shshitrit@nvidia.com>, Yael Chemla <ychemla@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <1763585297-1243980-1-git-send-email-tariqt@nvidia.com>
 <1763585297-1243980-2-git-send-email-tariqt@nvidia.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <1763585297-1243980-2-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 19/11/2025 21:48, Tariq Toukan wrote:
> From: Yael Chemla <ychemla@nvidia.com>
> 
> Add support for 1600Gbps link modes based on 200Gbps per lane [1].
> This includes the adopted IEEE 802.3dj copper and optical PMDs that use
> 200G/lane signaling [2].
> 
> Add the following PMD types:
> - KR8 (backplane)
> - CR8 (copper cable)
> - DR8 (SMF 500m)
> - DR8-2 (SMF 2km)
> 
> These modes are defined in the 802.3dj specifications.
> References:
> [1] https://www.ieee802.org/3/dj/public/23_03/opsasnick_3dj_01a_2303.pdf
> [2] https://www.ieee802.org/3/dj/projdoc/objectives_P802d3dj_240314.pdf
> 
> Signed-off-by: Yael Chemla <ychemla@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/phy/phy-caps.h   | 1 +
>  drivers/net/phy/phy-core.c   | 4 +++-
>  drivers/net/phy/phy_caps.c   | 2 ++
>  include/uapi/linux/ethtool.h | 5 +++++
>  net/ethtool/common.c         | 8 ++++++++
>  5 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
> index b7f0c6a3037a..4951a39f3828 100644
> --- a/drivers/net/phy/phy-caps.h
> +++ b/drivers/net/phy/phy-caps.h
> @@ -29,6 +29,7 @@ enum {
>  	LINK_CAPA_200000FD,
>  	LINK_CAPA_400000FD,
>  	LINK_CAPA_800000FD,
> +	LINK_CAPA_1600000FD,
>  
>  	__LINK_CAPA_MAX,
>  };
> diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
> index 0c63e6ba2cb0..277c034bc32f 100644
> --- a/drivers/net/phy/phy-core.c
> +++ b/drivers/net/phy/phy-core.c
> @@ -17,7 +17,7 @@
>   */
>  const char *phy_speed_to_str(int speed)
>  {
> -	BUILD_BUG_ON_MSG(__ETHTOOL_LINK_MODE_MASK_NBITS != 121,
> +	BUILD_BUG_ON_MSG(__ETHTOOL_LINK_MODE_MASK_NBITS != 125,
>  		"Enum ethtool_link_mode_bit_indices and phylib are out of sync. "
>  		"If a speed or mode has been added please update phy_speed_to_str "
>  		"and the PHY settings array.\n");
> @@ -55,6 +55,8 @@ const char *phy_speed_to_str(int speed)
>  		return "400Gbps";
>  	case SPEED_800000:
>  		return "800Gbps";
> +	case SPEED_1600000:
> +		return "1600Gbps";
>  	case SPEED_UNKNOWN:
>  		return "Unknown";
>  	default:
> diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
> index 23c808b59b6f..3a05982b39bf 100644
> --- a/drivers/net/phy/phy_caps.c
> +++ b/drivers/net/phy/phy_caps.c
> @@ -25,6 +25,7 @@ static struct link_capabilities link_caps[__LINK_CAPA_MAX] __ro_after_init = {
>  	{ SPEED_200000, DUPLEX_FULL, {0} }, /* LINK_CAPA_200000FD */
>  	{ SPEED_400000, DUPLEX_FULL, {0} }, /* LINK_CAPA_400000FD */
>  	{ SPEED_800000, DUPLEX_FULL, {0} }, /* LINK_CAPA_800000FD */
> +	{ SPEED_1600000, DUPLEX_FULL, {0} }, /* LINK_CAPA_1600000FD */
>  };
>  
>  static int speed_duplex_to_capa(int speed, unsigned int duplex)
> @@ -52,6 +53,7 @@ static int speed_duplex_to_capa(int speed, unsigned int duplex)
>  	case SPEED_200000: return LINK_CAPA_200000FD;
>  	case SPEED_400000: return LINK_CAPA_400000FD;
>  	case SPEED_800000: return LINK_CAPA_800000FD;
> +	case SPEED_1600000: return LINK_CAPA_1600000FD;
>  	}
>  
>  	return -EINVAL;
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index 8bd5ea5469d9..eb7ff2602fbb 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -2077,6 +2077,10 @@ enum ethtool_link_mode_bit_indices {
>  	ETHTOOL_LINK_MODE_800000baseDR4_2_Full_BIT	 = 118,
>  	ETHTOOL_LINK_MODE_800000baseSR4_Full_BIT	 = 119,
>  	ETHTOOL_LINK_MODE_800000baseVR4_Full_BIT	 = 120,
> +	ETHTOOL_LINK_MODE_1600000baseCR8_Full_BIT	 = 121,
> +	ETHTOOL_LINK_MODE_1600000baseKR8_Full_BIT	 = 122,
> +	ETHTOOL_LINK_MODE_1600000baseDR8_Full_BIT	 = 123,
> +	ETHTOOL_LINK_MODE_1600000baseDR8_2_Full_BIT	 = 124,
>  
>  	/* must be last entry */
>  	__ETHTOOL_LINK_MODE_MASK_NBITS
> @@ -2190,6 +2194,7 @@ enum ethtool_link_mode_bit_indices {
>  #define SPEED_200000		200000
>  #define SPEED_400000		400000
>  #define SPEED_800000		800000
> +#define SPEED_1600000		1600000
>  
>  #define SPEED_UNKNOWN		-1
>  
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index 55223ebc2a7e..369c05cf8163 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -233,6 +233,10 @@ const char link_mode_names[][ETH_GSTRING_LEN] = {
>  	__DEFINE_LINK_MODE_NAME(800000, DR4_2, Full),
>  	__DEFINE_LINK_MODE_NAME(800000, SR4, Full),
>  	__DEFINE_LINK_MODE_NAME(800000, VR4, Full),
> +	__DEFINE_LINK_MODE_NAME(1600000, CR8, Full),
> +	__DEFINE_LINK_MODE_NAME(1600000, KR8, Full),
> +	__DEFINE_LINK_MODE_NAME(1600000, DR8, Full),
> +	__DEFINE_LINK_MODE_NAME(1600000, DR8_2, Full),
>  };
>  static_assert(ARRAY_SIZE(link_mode_names) == __ETHTOOL_LINK_MODE_MASK_NBITS);
>  
> @@ -422,6 +426,10 @@ const struct link_mode_info link_mode_params[] = {
>  	__DEFINE_LINK_MODE_PARAMS(800000, DR4_2, Full),
>  	__DEFINE_LINK_MODE_PARAMS(800000, SR4, Full),
>  	__DEFINE_LINK_MODE_PARAMS(800000, VR4, Full),
> +	__DEFINE_LINK_MODE_PARAMS(1600000, CR8, Full),
> +	__DEFINE_LINK_MODE_PARAMS(1600000, KR8, Full),
> +	__DEFINE_LINK_MODE_PARAMS(1600000, DR8, Full),
> +	__DEFINE_LINK_MODE_PARAMS(1600000, DR8_2, Full),
>  };
>  static_assert(ARRAY_SIZE(link_mode_params) == __ETHTOOL_LINK_MODE_MASK_NBITS);
>  EXPORT_SYMBOL_GPL(link_mode_params);


