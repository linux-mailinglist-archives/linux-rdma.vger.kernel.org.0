Return-Path: <linux-rdma+bounces-8135-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 701FEA45E54
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 13:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C642178461
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 12:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8503121B1B5;
	Wed, 26 Feb 2025 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HpW5DSRQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p6hDxATe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7621A457;
	Wed, 26 Feb 2025 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571602; cv=none; b=mUjG8IewIadsNo9A09gFfJfPs7iXoG5ykY8ngTv6jk9AMEqu/D3+YDg/A3py57yjk4HYB/TpEYRGoCwFEynSh9lSShDIWt/RI8qSrsIV1q4vPEwnhYSVc/KQoBE4kOLshk83uvsha8GWtlqUDMBvHDkbnWmibRmmUO3It/thf4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571602; c=relaxed/simple;
	bh=6RPrb/oNCKfWLnwevJl9sd+mapqG0L+h8JUcaQ7Lsyk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i79vZijTTckuS76NRV7Ol55V666yNHgeuQ47pUHWwr2sCYoOVFPRCjP7wM3I6Wt8oiJ554IKL8nXLYXTM/ye+olVZ0DtqmgO+JLkNnbi40Vr8o5XrsbVVugVu3f25hQM5Es4LLUFiyXY7fmzimud7MjPrfYs9VR2WerzsjiKptM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HpW5DSRQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p6hDxATe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 13:06:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740571599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lMbmogvqMvxoME+iCYsEFSMEAUVBtH4Ru2hAHUhAvGY=;
	b=HpW5DSRQ+Vk4lb8c6SeDY1V0uDzcCqw3LBgjQWZii/SQTOoo9Kb3HyQTAo0J62pFwX4kNe
	hGCox1TY9tZIJGg1UzafVxCJiHL9PGEf8IkigWCoy3hHmFfC1SySUORawWlH93Z28v9kuR
	GiibHeh2bBe0rVX25SnUaVrle4iDkqqAZCc6D3BkH8kA35xxQHgHNZAlZvTJX8Rw7XP6zu
	S5NKlBvdhnb81EObpIdqEV/1OiRa774Pny4bNMk+Bxg3T76DgUaR9ijcgCKSaRPHStKhjr
	H9ShW30rnQ5JObMOtenL/SWxpZf8MkbMeXPopJCn+NMBuoRgRZ2DVcky3V4/wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740571599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lMbmogvqMvxoME+iCYsEFSMEAUVBtH4Ru2hAHUhAvGY=;
	b=p6hDxATeNgHlyRhMK/ycx/R6z0jXp2jEAMpM9WOU1b4RLwo1pqqZGq4UW6pRSvyFXB6pP+
	Zl214dDNJB8DBcBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joe Damato <jdamato@fastly.com>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH net-next 1/2] page_pool: Convert page_pool_recycle_stats
 to u64_stats_t.
Message-ID: <20250226120637.2lx8aGWz@linutronix.de>
References: <20250221115221.291006-1-bigeasy@linutronix.de>
 <20250221115221.291006-2-bigeasy@linutronix.de>
 <Z7i2JHiKX6rggsUz@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z7i2JHiKX6rggsUz@LQ3V64L9R2>

On 2025-02-21 12:21:40 [-0500], Joe Damato wrote:
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> > index 611ec4b6f3709..baff961970f25 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> > @@ -513,11 +513,11 @@ static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)
> >  	rq_stats->pp_alloc_waive = stats.alloc_stats.waive;
> >  	rq_stats->pp_alloc_refill = stats.alloc_stats.refill;
> >  
> > -	rq_stats->pp_recycle_cached = stats.recycle_stats.cached;
> > -	rq_stats->pp_recycle_cache_full = stats.recycle_stats.cache_full;
> > -	rq_stats->pp_recycle_ring = stats.recycle_stats.ring;
> > -	rq_stats->pp_recycle_ring_full = stats.recycle_stats.ring_full;
> > -	rq_stats->pp_recycle_released_ref = stats.recycle_stats.released_refcnt;
> > +	rq_stats->pp_recycle_cached = u64_stats_read(&stats.recycle_stats.cached);
> > +	rq_stats->pp_recycle_cache_full = u64_stats_read(&stats.recycle_stats.cache_full);
> > +	rq_stats->pp_recycle_ring = u64_stats_read(&stats.recycle_stats.ring);
> > +	rq_stats->pp_recycle_ring_full = u64_stats_read(&stats.recycle_stats.ring_full);
> > +	rq_stats->pp_recycle_released_ref = u64_stats_read(&stats.recycle_stats.released_refcnt);
> >  }
> >  #else
> >  static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)
> 
> It might be better to convert mlx5 to
> page_pool_ethtool_stats_get_strings and
> page_pool_ethtool_stats_get_count instead ?

You mean something like

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 611ec4b6f3709..76be86ed35b03 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -506,18 +506,7 @@ static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)
 	if (!page_pool_get_stats(pool, &stats))
 		return;
 
-	rq_stats->pp_alloc_fast = stats.alloc_stats.fast;
-	rq_stats->pp_alloc_slow = stats.alloc_stats.slow;
-	rq_stats->pp_alloc_slow_high_order = stats.alloc_stats.slow_high_order;
-	rq_stats->pp_alloc_empty = stats.alloc_stats.empty;
-	rq_stats->pp_alloc_waive = stats.alloc_stats.waive;
-	rq_stats->pp_alloc_refill = stats.alloc_stats.refill;
-
-	rq_stats->pp_recycle_cached = stats.recycle_stats.cached;
-	rq_stats->pp_recycle_cache_full = stats.recycle_stats.cache_full;
-	rq_stats->pp_recycle_ring = stats.recycle_stats.ring;
-	rq_stats->pp_recycle_ring_full = stats.recycle_stats.ring_full;
-	rq_stats->pp_recycle_released_ref = stats.recycle_stats.released_refcnt;
+	page_pool_ethtool_stats_get(&rq_stats->pp_alloc_fast, &stats);
 }
 #else
 static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)

?
Because I've been staring on this for a while and it seems that they
have their own logic around struct mlx5e_sw_stats for stats.

Sebastian

