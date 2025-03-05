Return-Path: <linux-rdma+bounces-8371-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78740A504DC
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 17:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACBF18996EB
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B67A198A38;
	Wed,  5 Mar 2025 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mTRGVeHC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gVVg7iIu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B35A18FC9F;
	Wed,  5 Mar 2025 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192001; cv=none; b=Ft5gRuS3QkX/mMYGNbnLzzuS1h2WYKvXepFTVMEdUK1yQJVOuUfd28DC8LLEUDvkrCFxjJ/+5SDv4s7HuuraTBgEoQDVdQYqQgatQ0odbvbJWMaZBW8ux7V5uTGnkVCz/yM6ffeALQx4I/87vaVWF9Dsqb1hmzN8t/2fJJj3UdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192001; c=relaxed/simple;
	bh=47ZpcMy5LCUivpIcvFmxjz3YPcpVLjTg7akVh13dhdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1oPaZA2lV3suQCTp6YUOvy3icgr7ysEojJDclT7uoCiPmJoP79v0+IG//e4EaRlyZd9mV3mSIifn5Xh3kv3nYMQ/dwIGlgSO4sOnsrDeRMKlUHClNoPKA9+eR1Q+bx4HRVdn4DxkEf0NrXqVQqOQNIIgbznrIrUUzim0DzL+ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mTRGVeHC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gVVg7iIu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Mar 2025 17:26:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741191997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+EUWRgdHcKOIwdKsipg2rolTqSP+W0UujWsBhAfb6aM=;
	b=mTRGVeHCcHD39tJS8eOy/YUjw+v4NGFyBGtxG2JAA2mag3ITx/9vUDrIVHwkF6BAZbTK8x
	wo94O921I57HX6Ww2eR3uCKxPneTE7Gu2e14QAPm4YDmCOqxjjQhD2oKKh/HM+B0X8pnnb
	qvx2s1hnd0ehBmN127mIRipCvl4dQuDk6m3lAizKkiEMjF4zb+hZlvWYoTmk9i4zN9Aung
	Ew71Cr+gWC2A/35dCUVpN/Ao2cYbYMRRwMu+pKPMGU+cJfAbahi580JsGSp3k600WCbefh
	aqlnmj9ZGDXRJ7hOFjZzUfKv5JmDFIOqzz+MLs37FqXg+SqyLqbco1eJxYRWDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741191997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+EUWRgdHcKOIwdKsipg2rolTqSP+W0UujWsBhAfb6aM=;
	b=gVVg7iIuaMvCx/TAfEOgk38rjSAHkkcawzd/jY6MxcTFYQ+E2m2hoPR0OXdVN4gY8fXHHE
	Giz5y22ThoOihBCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Joe Damato <jdamato@fastly.com>,
	Leon Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH net-next] net/mlnx5: Use generic code for page_pool
 statistics.
Message-ID: <20250305162636.cQf23qHf@linutronix.de>
References: <20250305121420.kFO617zQ@linutronix.de>
 <433b43b1-0a42-4606-b919-3429c36aa934@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <433b43b1-0a42-4606-b919-3429c36aa934@lunn.ch>

On 2025-03-05 17:21:56 [+0100], Andrew Lunn wrote:
> > @@ -276,6 +263,9 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(sw)
> >  		mlx5e_ethtool_put_stat(data,
> >  				       MLX5E_READ_CTR64_CPU(&priv->stats.sw,
> >  							    sw_stats_desc, i));
> > +#ifdef CONFIG_PAGE_POOL_STATS
> > +	*data = page_pool_ethtool_stats_get(*data, &priv->stats.sw.page_pool_stats);
> > +#endif
> >  }
> 
> Are these #ifdef required? include/net/page_pool/helpers.h:
> 
> static inline u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
> {
> 	return data;
> }
> 
> Seems silly to have a stub if it cannot be used.

As I mentioned in the diffstat section, if we add the snippet below then
it would work. Because the struct itself is not there.

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index f45d55e6e8643..78984b9286c6b 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -143,10 +143,14 @@ struct page_pool_recycle_stats {
  */
 struct page_pool_stats {
 	struct page_pool_alloc_stats alloc_stats;
 	struct page_pool_recycle_stats recycle_stats;
 };
+
+#else /* !CONFIG_PAGE_POOL_STATS */
+
+struct page_pool_stats { };
 #endif
 
 /* The whole frag API block must stay within one cacheline. On 32-bit systems,
  * sizeof(long) == sizeof(int), so that the block size is ``3 * sizeof(long)``.
  * On 64-bit systems, the actual size is ``2 * sizeof(long) + sizeof(int)``.

> 	Andrew

Sebastian

