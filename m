Return-Path: <linux-rdma+bounces-17522-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI1TK2RoqWlN6wAAu9opvQ
	(envelope-from <linux-rdma+bounces-17522-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 12:26:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2742D2108E2
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 12:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17BCA3014C45
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 11:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C768637B022;
	Thu,  5 Mar 2026 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMCtI1lG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0nBvH0v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9626237475C
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 11:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709983; cv=none; b=Xy977hw7m5eRzJ2qp7vJ1Ckk0S9tN80ZfYeFlldI8+JGHD9plp9oqGI/x9smYZVQJpoVwhDM/NHeYzUZq7FRIefiF85FMjrKzqPMAmwGBK2ZAGtOBvN62ix0bgyS1K/z6A8grOcRh1kwgaWDYimgMxXPJqnUa42cwP4NyIu/qsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709983; c=relaxed/simple;
	bh=YZF2+qbA9NLMDI3/4YuPpkKbozBNwPhHAlMxMzTX1vQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jo2rPk8An4/u9rW6wwGzmd2pg8dh3ulfzJsen0grbWykGjRnlnyueV6hRpU1xOEFwprhJ0cLKVLNKdWyQdNwfWq/abKrbOOhbKOQK6SgUlpGwNspR4vKzJKCsiJRrlH5iD84Z+9/3J4uweVusIk5TcRaRAbcApPdsX9meXkitJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KMCtI1lG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0nBvH0v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772709980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PDdJdydDAqY2r+QCid29LNFFApkwhWkx5ohf3cC8Sw=;
	b=KMCtI1lGVK4Ldhmwk4ehe0VV5LFghX0cNVuIFyI4PllD/ptxPZ4x0B/ou/ksp+2W73thHC
	K9uVUvRbS9uve7ZJO+Bs7n3rPVmri0sGSgTxABCJuajLOuBca87ktjtNLtV4pSDxyypvTh
	hcBkq+ZkI5EANPultwZ31KEkvK7X9CM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-dN3sRzqpO-qUHan14gkCrQ-1; Thu, 05 Mar 2026 06:26:17 -0500
X-MC-Unique: dN3sRzqpO-qUHan14gkCrQ-1
X-Mimecast-MFC-AGG-ID: dN3sRzqpO-qUHan14gkCrQ_1772709976
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4836cc0b38eso80337655e9.2
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2026 03:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772709976; x=1773314776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/PDdJdydDAqY2r+QCid29LNFFApkwhWkx5ohf3cC8Sw=;
        b=R0nBvH0vfPoKjFStHsWmrF7ByCS8PIlSpNc/EBNc+slFn6qstCth5x4TKFQ/LrCPD8
         +nrcBe2j6facHyAMqm8o+RVkuEuqKtT1QdGqCI/l0aLROfv82OU7ZjfviQn2+T7Ooirh
         2kSgh3pz92aVr5GWR2lgjCsH+SN1u4pj+eMV04uzLtKfMx51i5JiIRfIl7wVt8hz8JBQ
         A+DQM+htL8dVz0ZGj5eOf3InlTmRlPSJB6AVVRlruptvixsXGv5Acy5arB26nqIaOnWJ
         bZl7C6mZ379mlKAS/aLKQ8mXaEfZeqlzotf5HDwPhvHF2x2r40v082NrScZCLHNiL/mA
         KT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772709976; x=1773314776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/PDdJdydDAqY2r+QCid29LNFFApkwhWkx5ohf3cC8Sw=;
        b=Ua38dclH65NBWJt89F0VduaJkdjbs+23bP3SBk0yyaglcGNwk2nbpvcergQLc7Qfg+
         UTUsnqhKxxa+vrGD0KdAUSFDoqaeKujELpM3EOpWVvflgYCFTDir9Du1xSCnkrBbBlkJ
         bCde+mppJG6S1MyErnFVswSkAo2KaBQayHeaT6A1JK+mOrjX+mRNPwCzaq2+0T7qFozS
         8HQJtBJ3tP2OamNF49z2GHe5J/ED9BRhHKnV8OvlLpu0fJkyQw68ZQS57eNzy+Idrphh
         YZZT9xNbVLRLzaI1SHcRIsTo8YbTbLMgcAmOjrbQMEegOXtzqAnd9nRh6UMX6NZDczbN
         As2w==
X-Forwarded-Encrypted: i=1; AJvYcCX5fxxobiXvMB2W2C3REVso1YnnABtbU58dipChlqraTJu0O/mh6w/EuLTRVg3t5NjTObfxUyIl4l66@vger.kernel.org
X-Gm-Message-State: AOJu0YwuocKffVWjJ75hgGu+mqZ6guypzNpiYXoOPjkCRXUuK06EIE5k
	i+HhAebSQOgSGPCqMSb9Qd9VYkVG3pU29mFDT91PAs95SuQ3zmT/x+W0NrQYvRUKepFMGU3PZD7
	ioSRnGnI3XhRok8992QkrBy466W4htSR1hbNP4T5luhxOFRPRDYrW9YlDUt2luUY=
X-Gm-Gg: ATEYQzwXf8Ickye336OL4aY7mXMUlaoqtZWDvkmfkczV5yiv00j6J62h36wRbHzQNWb
	ZeMzlAktpbJlWhMw/ggJEw0CpBlZvyeet9SK3YoXa6g0D6GYBdJrYcVDRpBIT3TmPUHTX8XoxtN
	60N2oEJt4TAFdHEiy7mhygu3rL3G6LhNCLp3QQUTtiLbg40mn3Q1nxqH0YK6lH/+Ty+h5Al116/
	jcg2KLPkbH0XJj1dXBdDaa1DqXVuNB2cO1X8n4nNyObQJtmVZCM7rhce0UTS067frVhOIklzzfu
	CLAYQTofdXC002YPLenyX12sFoKpmNubqHS79Ae9zBjKURmIFC2bmLhZKjoyCHl4ubIVA6WpqYp
	jCcb9ORCOr4b0esUXJzHEsdRaUg==
X-Received: by 2002:a05:600c:6305:b0:483:b505:9db7 with SMTP id 5b1f17b1804b1-485198c1d1fmr86121235e9.32.1772709976222;
        Thu, 05 Mar 2026 03:26:16 -0800 (PST)
X-Received: by 2002:a05:600c:6305:b0:483:b505:9db7 with SMTP id 5b1f17b1804b1-485198c1d1fmr86120825e9.32.1772709975788;
        Thu, 05 Mar 2026 03:26:15 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851d8ecb09sm38337535e9.2.2026.03.05.03.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 03:26:15 -0800 (PST)
Message-ID: <f9fef510-09bb-44b5-8340-c472f3b95deb@redhat.com>
Date: Thu, 5 Mar 2026 12:26:13 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next V4 5/5] eth: mlx5: Move pause storm errors to pause
 stats
To: netdev@vger.kernel.org, tariqt@nvidia.com, saeedm@nvidia.com,
 mbloch@nvidia.com, gal@nvidia.com, leon@kernel.org, idosch@nvidia.com
Cc: alexanderduyck@fb.com, alok.a.tiwari@oracle.com, andrew+netdev@lunn.ch,
 andrew@lunn.ch, davem@davemloft.net, dg573847474@gmail.com,
 donald.hunter@gmail.com, edumazet@google.com, horms@kernel.org,
 jacob.e.keller@intel.com, kernel-team@meta.com, kory.maincent@bootlin.com,
 kuba@kernel.org, lee@trager.us, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux@armlinux.org.uk,
 mike.marciniszyn@gmail.com, o.rempel@pengutronix.de,
 vadim.fedorenko@linux.dev, Mohsin Bashir <mohsin.bashr@gmail.com>
References: <20260302230149.1580195-1-mohsin.bashr@gmail.com>
 <20260302230149.1580195-6-mohsin.bashr@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260302230149.1580195-6-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2742D2108E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[fb.com,oracle.com,lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,vger.kernel.org,armlinux.org.uk,pengutronix.de,linux.dev];
	TAGGED_FROM(0.00)[bounces-17522-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/3/26 12:01 AM, Mohsin Bashir wrote:
> Report device_stall_critical_watermark_cnt as tx_pause_storm_events in
> the ethtool_pause_stats struct. This counter tracks pause storm error
> events which indicate the NIC has been sending pause frames for an
> extended period due to a stall.
> 
> The ethtool_pause_stats struct reports these stalls as a single value,
> whereas the device supports tracking them per priority. Aggregate the
> counter across all priority classes to capture stalls on all priorities.
> Note that the stats are fetched from the device for each priority via
> mlx5_core_access_reg().
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
>  .../ethernet/mellanox/mlx5/core/en_stats.c    | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> index a8af84fc9763..1a3ecf073913 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> @@ -916,11 +916,30 @@ static int mlx5e_stats_get_ieee(struct mlx5_core_dev *mdev,
>  				    sz, MLX5_REG_PPCNT, 0, 0);
>  }
>  
> +static int mlx5e_stats_get_per_prio(struct mlx5_core_dev *mdev,
> +				    u32 *ppcnt_per_prio, int prio)
> +{
> +	u32 in[MLX5_ST_SZ_DW(ppcnt_reg)] = {};
> +	int sz = MLX5_ST_SZ_BYTES(ppcnt_reg);
> +
> +	if (!(MLX5_CAP_PCAM_FEATURE(mdev, pfcc_mask) &&
> +	      MLX5_CAP_DEBUG(mdev, stall_detect)))
> +		return -EOPNOTSUPP;
> +
> +	MLX5_SET(ppcnt_reg, in, local_port, 1);
> +	MLX5_SET(ppcnt_reg, in, grp, MLX5_PER_PRIORITY_COUNTERS_GROUP);
> +	MLX5_SET(ppcnt_reg, in, prio_tc, prio);
> +	return mlx5_core_access_reg(mdev, in, sz, ppcnt_per_prio, sz,
> +				    MLX5_REG_PPCNT, 0, 0);
> +}
> +
>  void mlx5e_stats_pause_get(struct mlx5e_priv *priv,
>  			   struct ethtool_pause_stats *pause_stats)
>  {
>  	u32 ppcnt_ieee_802_3[MLX5_ST_SZ_DW(ppcnt_reg)];
>  	struct mlx5_core_dev *mdev = priv->mdev;
> +	u64 ps_stats = 0;
> +	int prio;
>  
>  	if (mlx5e_stats_get_ieee(mdev, ppcnt_ieee_802_3))
>  		return;
> @@ -933,6 +952,17 @@ void mlx5e_stats_pause_get(struct mlx5e_priv *priv,
>  		MLX5E_READ_CTR64_BE_F(ppcnt_ieee_802_3,
>  				      eth_802_3_cntrs_grp_data_layout,
>  				      a_pause_mac_ctrl_frames_received);
> +
> +	for (prio = 0; prio < NUM_PPORT_PRIO; prio++) {
> +		if (mlx5e_stats_get_per_prio(mdev, ppcnt_ieee_802_3, prio))
> +			return;
> +
> +		ps_stats += MLX5E_READ_CTR64_BE_F(ppcnt_ieee_802_3,
> +						  eth_per_prio_grp_data_layout,
> +						  device_stall_critical_watermark_cnt);
> +	}
> +
> +	pause_stats->tx_pause_storm_events = ps_stats;
>  }
>  
>  void mlx5e_stats_eth_phy_get(struct mlx5e_priv *priv,

It would be nice if someone at nVidia could have a look at the mlx bits
here. Waiting a little longer for that.

Thanks,

Paolo


