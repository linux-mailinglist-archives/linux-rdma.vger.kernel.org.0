Return-Path: <linux-rdma+bounces-14535-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB12C6473F
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 14:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CEA7534B98A
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C83632BF55;
	Mon, 17 Nov 2025 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvuH4Q0y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4920230F95C
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386874; cv=none; b=TooVKK+6KN6qSZt7SJevkoVfyZVGBPAU8xSQA8tbrBqpuPYedCAGjwaiz0RmWnj9ZyFMr7lqXdR+fO+J+Y8CsADjFX5T2jKwRGzCtkeMXcsCDpJ4IMHTYZn37y+J4N6GDWvR502dMRvdYvVvIm/MaplnWFek60aKGcaHcN1cVZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386874; c=relaxed/simple;
	bh=j7VPNFFlZq0BUXDuPDvasOjKyVgPrnkIbLr53dQ6JYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F2Jtrh8AoLYEYzRd5OOFqrj7M7AF+9Megbk8dogC4tg7YNfBdMWSURR1G8sPy5KFon6dCCGb8tlMjyNRYYkCrOeWxUrAigJTY0YTxmffkiKWqiTNBXaGnAq9n8c1TyN36Vrwar5EWAw8bEtdRxAnvdV/iMMMbeK22H2kPNh84ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvuH4Q0y; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso21347385e9.0
        for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 05:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763386872; x=1763991672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6lFKQIH/3Mxeg5x+zKX6H3OQkOENi/J/tZcjNSVfL9A=;
        b=mvuH4Q0ylx3gd78BJd6PspzQ7DkWdcZPfLIktLA01bvmw+kOYf9hKI+k5KYtE9hpTb
         coVydcv3dY5EcOnEdDJtDtjkVcjc65NGc5ozope+tPcaKRDW+zTnMSyAvCZKdMaoB7QR
         eJKczQrbqu7WmrSYX5Tfmy0UUPE1HFH8cNb/PV0K5x0oxbT7+0NeR2BTPhPbgbZlsaMG
         q0toAe+eAGqlA1o4877pc71Weud2xK1U7c9LoHAMa8U8lENi886axCWHQVwKUfLe92YN
         5kuO/13X1lY15lbPZXdzQmeijNS0r+0GFl3FgQoKF/Q5PTD7OKFQKHJE2pYkJGNazxI+
         uh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763386872; x=1763991672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6lFKQIH/3Mxeg5x+zKX6H3OQkOENi/J/tZcjNSVfL9A=;
        b=cPYCfNBL7KenLW+rTzozbmvQyl9MGo8+X0sFacGx1dxWivKh1r7CHGQawEnFZZ7Phq
         Edu44ujaCuvSNdgjER8G0Un+4X6jY2j16iK0Gd3TShfg1z8v5UJE3HE6Dsgp9rxDlmZn
         9IM+4laODY637cF+sgEen4XE6MNZRXq3WpKQB/+0HtNRsYSisuRMdDLYK3C2h/KmDIdZ
         CvR14Kn/PlF4yB7+VWeAbkPQ1SoAC/8g6TNUqJDJ+qlgvJnX1nRC5m+b6WV/OEks5RzD
         VdDWMx1Wf5F0auNZEmqNfbHujotn+4FzyY0BJcOOr+gKiap484F84L08dsZzrGUyS60R
         NK3w==
X-Forwarded-Encrypted: i=1; AJvYcCWDNqIFVy7JGGkA6ig9KsWjX94IwCC9HNjeVk9KDy48YZdlj3V/vjwUu/zBraAzE1xfAdxzWE0Un+Tg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw68j4DAmC5M1FLIOB77YGQyabaZ1+e25SIFgApZzBG/J++sz7s
	FHUUsBT4rZgOeCop+eUnW5vtLZNKsYdq7KlccmnVFRALiwXJfbSW6wkN
X-Gm-Gg: ASbGnctM8OM6D2ezjKUrNzWqwoTlWNl108jd713zsq5tQU4c0FBfS47fQ8kZVDV5AJ4
	r8LEkc7tSyPOAOcrI00DgSrjF3G704HwJoCMjlhFt3NN9aiWyO2llQGoJfk2wxR+cqk7a8DVDPE
	GJT3Eo0ULGox8fayAnVUx6hN6mP5w6Z4KVJAvzaHPnrqQNvAwkTWFsF/NBq8+sbkfT93quKxEvv
	FQt96mSKbctsHI2EUChWfe/GngXHrvKL0AJBmPtVJn+DuCeeh3pCsBC3FninbtqWUs0bG130C1x
	VloEazMKXqMdPCmuzS50Xo/E9Y+IvNenc3wq3wzPtubvz+quU2bbtdUVxrGbCpAyKECyEFhy2ZB
	HveST92CgZ8iD2tkSG4+d5S4Dm/Gaie/i7tnPSBMcaJFIfBm/86pzz0la7vEdy03GQJs0uxkFzS
	xS7WStMfBAyXJVPKsPvhk63g+wqQE=
X-Google-Smtp-Source: AGHT+IGHE9acfTrCcDeNM7N4fjnirYz4dNvSnn3lNuor1rshswnUa4aKqX6YbOkPdeLKvX06tMOqdg==
X-Received: by 2002:a05:600c:3587:b0:477:5aaa:57a3 with SMTP id 5b1f17b1804b1-4778fe55589mr120648835e9.2.1763386871346;
        Mon, 17 Nov 2025 05:41:11 -0800 (PST)
Received: from [10.80.3.86] ([72.25.96.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e36ca3sm332453495e9.5.2025.11.17.05.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 05:41:11 -0800 (PST)
Message-ID: <e9d75cda-b017-408f-9308-3e8631d62192@gmail.com>
Date: Mon, 17 Nov 2025 15:41:09 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mlx5: extract GRXRINGS from .get_rxnfc
To: Breno Leitao <leitao@debian.org>, Tariq Toukan <tariqt@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20251113-mlx_grxrings-v1-0-0017f2af7dd0@debian.org>
 <20251113-mlx_grxrings-v1-2-0017f2af7dd0@debian.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20251113-mlx_grxrings-v1-2-0017f2af7dd0@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/11/2025 18:46, Breno Leitao wrote:
> Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
> optimize RX ring queries") added specific support for GRXRINGS callback,
> simplifying .get_rxnfc.
> 
> Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
> .get_rx_ring_count() for both the mlx5 ethernet and IPoIB drivers.
> 
> The ETHTOOL_GRXRINGS handling was previously kept in .get_rxnfc() to
> support "ethtool -x" when CONFIG_MLX5_EN_RXNFC=n. With the new
> dedicated .get_rx_ring_count() callback, this is no longer necessary.
> 
> This simplifies the RX ring count retrieval and aligns mlx5 with the new
> ethtool API for querying RX ring parameters.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c   | 18 ++++++++----------
>   .../net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c    | 18 ++++++++----------
>   2 files changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> index 01b8f05a23db..939e274779b3 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> @@ -2492,21 +2492,18 @@ static int mlx5e_set_rxfh_fields(struct net_device *dev,
>   	return mlx5e_ethtool_set_rxfh_fields(priv, cmd, extack);
>   }
>   
> +static u32 mlx5e_get_rx_ring_count(struct net_device *dev)
> +{
> +	struct mlx5e_priv *priv = netdev_priv(dev);
> +
> +	return priv->channels.params.num_channels;
> +}
> +
>   static int mlx5e_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
>   			   u32 *rule_locs)
>   {
>   	struct mlx5e_priv *priv = netdev_priv(dev);
>   
> -	/* ETHTOOL_GRXRINGS is needed by ethtool -x which is not part
> -	 * of rxnfc. We keep this logic out of mlx5e_ethtool_get_rxnfc,
> -	 * to avoid breaking "ethtool -x" when mlx5e_ethtool_get_rxnfc
> -	 * is compiled out via CONFIG_MLX5_EN_RXNFC=n.
> -	 */
> -	if (info->cmd == ETHTOOL_GRXRINGS) {
> -		info->data = priv->channels.params.num_channels;
> -		return 0;
> -	}
> -
>   	return mlx5e_ethtool_get_rxnfc(priv, info, rule_locs);
>   }
>   
> @@ -2766,6 +2763,7 @@ const struct ethtool_ops mlx5e_ethtool_ops = {
>   	.remove_rxfh_context	= mlx5e_remove_rxfh_context,
>   	.get_rxnfc         = mlx5e_get_rxnfc,
>   	.set_rxnfc         = mlx5e_set_rxnfc,
> +	.get_rx_ring_count = mlx5e_get_rx_ring_count,
>   	.get_tunable       = mlx5e_get_tunable,
>   	.set_tunable       = mlx5e_set_tunable,
>   	.get_pause_stats   = mlx5e_get_pause_stats,
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
> index 4b3430ac3905..3b2f54ca30a8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
> @@ -266,21 +266,18 @@ static int mlx5i_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
>   	return mlx5e_ethtool_set_rxnfc(priv, cmd);
>   }
>   
> +static u32 mlx5i_get_rx_ring_count(struct net_device *dev)
> +{
> +	struct mlx5e_priv *priv = mlx5i_epriv(dev);
> +
> +	return priv->channels.params.num_channels;
> +}
> +
>   static int mlx5i_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
>   			   u32 *rule_locs)
>   {
>   	struct mlx5e_priv *priv = mlx5i_epriv(dev);
>   
> -	/* ETHTOOL_GRXRINGS is needed by ethtool -x which is not part
> -	 * of rxnfc. We keep this logic out of mlx5e_ethtool_get_rxnfc,
> -	 * to avoid breaking "ethtool -x" when mlx5e_ethtool_get_rxnfc
> -	 * is compiled out via CONFIG_MLX5_EN_RXNFC=n.
> -	 */
> -	if (info->cmd == ETHTOOL_GRXRINGS) {
> -		info->data = priv->channels.params.num_channels;
> -		return 0;
> -	}
> -
>   	return mlx5e_ethtool_get_rxnfc(priv, info, rule_locs);
>   }
>   
> @@ -304,6 +301,7 @@ const struct ethtool_ops mlx5i_ethtool_ops = {
>   	.set_rxfh_fields    = mlx5i_set_rxfh_fields,
>   	.get_rxnfc          = mlx5i_get_rxnfc,
>   	.set_rxnfc          = mlx5i_set_rxnfc,
> +	.get_rx_ring_count  = mlx5i_get_rx_ring_count,
>   	.get_link_ksettings = mlx5i_get_link_ksettings,
>   	.get_link           = ethtool_op_get_link,
>   };
> 

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

