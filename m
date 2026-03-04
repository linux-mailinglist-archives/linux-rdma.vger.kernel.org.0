Return-Path: <linux-rdma+bounces-17458-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAMpL2jtp2mWlwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17458-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 09:29:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C761FC9EE
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 09:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52EFD3015D1B
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 08:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A09A3914EC;
	Wed,  4 Mar 2026 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9a/IGhf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8697238E5E1
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 08:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772612949; cv=none; b=f6GPn3jQzo290w6F5SYAw6e/z70UkstdNVrnNWwqmD+RwFvZuvcocM4uOz7zNySjkUKgQH3iD1xwwQI5FNHLG+bDK06GLkMtnw/e7ZvK/r0SXxDWbmF9CMZW0T0YVCGvp0NMDIwMDknEoBAp09cQsQGd/3gx+RfhEm1l2WsfN3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772612949; c=relaxed/simple;
	bh=W61KOgJijBTu+KgaDoSnTPcPN7wOVxVekxKvmZ2tA8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mKcnCHR2CTh7Ul6YoGJ5T4GesM8W7VgS2uzP3LzdQbQXHjcQ+4kwMjkI61BSkU7ye9qqp8Q3mkeodDW28PqAC8mrKx/zIuiQb+sOrC5X/eE+w8pt4F7MBfNXw5d9B5sUvIfAznbhkuuGaaKDmksR/nM60SzAdbuafZo8/x1fS/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9a/IGhf; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439c5b40f60so594806f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2026 00:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772612947; x=1773217747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nSKM+6gFf9Fg1BMeTVJ4haJM0Fv9Kx92rGo08mnwG5k=;
        b=K9a/IGhf7C/F1Y6Zu9TyAG6UZawwX0nGBdTeyDeX3DBZlrY8jMuL2i/qgtiO2vUVOC
         K/OFqT9J7n/mnYzLCc2c7Q8XO+LBgaSQXWZjvur2Wlb4RnaDhBz1cjNsLvteq6ymF+5I
         ImTnzpXdtYdK/g9PqO41/kPpt43eh/UjKq4ndOpXRDJep07XTEcfrqbNDUZfBvTiNdc7
         bOd7P+D987XXes8sP8H26AwTphVPN5wyVy9G7F6TP8uEnl0eALbv7FfYZqS74cb+Z2t5
         BnkgDgsuHFVPVWZPaszbrVakQN/Lq5iDJz4IePODoElijX3SlYVzJKEK0qx2zJ7K7wrx
         fTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772612947; x=1773217747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSKM+6gFf9Fg1BMeTVJ4haJM0Fv9Kx92rGo08mnwG5k=;
        b=C43/XBD0o7f1dOtpZjjRoTxoNV6zwt8KvsLpzHTUsHfENJwPa4ondHxE+vD6c5B47u
         yLfsY60K14+QreUaR5lJcna0WEoLOQP2U3QIrsywr4WoTsMOfnaI04CxcvhMdkTwpfqX
         l5fXcVmb6Uo2rsA4yPkHhqkgw2OcOxrVjxjGZYfai+yOjsqRUpFnOM+QDQnvzeIi9dE9
         TWahWkmvVh1Jq3qWNh8UdbKs+mUmyOLbvIwhTIR8tAC9bhniTNp/gTal7Xb4kBDD9t/H
         5t0Z/tEQfiPbe19nl9rnUT26fdVVlR0bHlGEKIijhd+ci2mL9IuEzoR2Yx7KVro/lv5V
         +Rhw==
X-Forwarded-Encrypted: i=1; AJvYcCV8aOS4DUlwNJIsuDke06RO/okl2rLNCSILmA/XSpRJgEdZrTNnlYpDsycLxBgxK6/yUEwTt7cxePql@vger.kernel.org
X-Gm-Message-State: AOJu0YxoAxxbQWteYbw3iYtt/m7yrzdTuG81PaZXkDFaXhtdqpFnBSI9
	50Or2pNQmPedkqhJlOaPLFkq+agBbeXpbmYjBInoxkzAWUAuAuPD22MQ
X-Gm-Gg: ATEYQzwSU4M3CiwJMaQ0vXD+LX1uZPUu1fsRAEdD0omo+i3Mah/BLqMiWHrYGuLTkaU
	VsKfYRXT5Kx33nGBO8YvzVWA4ORzBH2JdJrIYKJNyaFF5ARFPuK/9WHaBxfZxHvElS55ht/AhgF
	exU2hq5295I9A2lMLsXaXDMrw5MC0yJuz/HLEw6sn/DWCI209mrjgddSJq2qbbFZwnpR58BwdMi
	ZeVl+8Kzq8BjAYeARlVUo6wmexupNlattxe6VsKEutCDn8sAYC3wqQZ+UcnWd2i0OHZdCCEB8Fn
	tC1H8zyZ3LML/hQXdHYIo2hRLjLi1zuHaFOpuDwAxyT089kdQtGM5y6MfYxsvksps2gzwSeQWP5
	ASpsCpPs1J/EsbhBYiLGkAhLNMSaq0IFoBDC0UVkJHlT0/8cGXQFpaIAKYbqaUphF3exsCUrw8q
	G1n1qNT8vMOJUYyhzEvbGP7tifpWvvwd4/OC5TH4vXn6gWDRo=
X-Received: by 2002:a05:6000:2c07:b0:439:b7c9:2edb with SMTP id ffacd0b85a97d-439c7fbbc27mr2236706f8f.25.1772612946627;
        Wed, 04 Mar 2026 00:29:06 -0800 (PST)
Received: from [10.125.201.152] ([165.85.126.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c60f764sm42507855f8f.3.2026.03.04.00.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 00:29:05 -0800 (PST)
Message-ID: <639ae63d-dbb0-428f-a13b-4cc354e19566@gmail.com>
Date: Wed, 4 Mar 2026 10:29:05 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5e: use flex array for rqns
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260304042042.7822-1-rosenp@gmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260304042042.7822-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 39C761FC9EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17458-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 04/03/2026 6:20, Rosen Penev wrote:
> Simplifies allocation. Separate kcalloc and kfree not needed anymore.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)
> 

This is not the typical structure that matches the usage of kvzalloc_flex().

I prefer keeping current code, being consistent with other dynamically 
allocated members like rss_vhca_ids.


> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
> index 92974b11ec75..fc71dd72938c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
> @@ -16,7 +16,6 @@ struct mlx5e_rx_res {
>   
>   	struct mlx5e_rss *rss[MLX5E_MAX_NUM_RSS];
>   	bool rss_active;
> -	u32 *rss_rqns;
>   	u32 *rss_vhca_ids;
>   	unsigned int rss_nch;
>   
> @@ -29,6 +28,8 @@ struct mlx5e_rx_res {
>   		struct mlx5e_rqt rqt;
>   		struct mlx5e_tir tir;
>   	} ptp;
> +
> +	u32 rss_rqns[];
>   };
>   
>   /* API for rx_res_rss_* */
> @@ -316,7 +317,6 @@ struct mlx5e_rss *mlx5e_rx_res_rss_get(struct mlx5e_rx_res *res, u32 rss_idx)
>   static void mlx5e_rx_res_free(struct mlx5e_rx_res *res)
>   {
>   	kvfree(res->rss_vhca_ids);
> -	kvfree(res->rss_rqns);
>   	kvfree(res);
>   }
>   
> @@ -325,20 +325,13 @@ static struct mlx5e_rx_res *mlx5e_rx_res_alloc(struct mlx5_core_dev *mdev, unsig
>   {
>   	struct mlx5e_rx_res *rx_res;
>   
> -	rx_res = kvzalloc_obj(*rx_res);
> +	rx_res = kvzalloc_flex(*rx_res, rss_rqns, max_nch, GFP_KERNEL);
>   	if (!rx_res)
>   		return NULL;
>   
> -	rx_res->rss_rqns = kvcalloc(max_nch, sizeof(*rx_res->rss_rqns), GFP_KERNEL);
> -	if (!rx_res->rss_rqns) {
> -		kvfree(rx_res);
> -		return NULL;
> -	}
> -
>   	if (multi_vhca) {
>   		rx_res->rss_vhca_ids = kvcalloc(max_nch, sizeof(*rx_res->rss_vhca_ids), GFP_KERNEL);
>   		if (!rx_res->rss_vhca_ids) {
> -			kvfree(rx_res->rss_rqns);
>   			kvfree(rx_res);
>   			return NULL;
>   		}


