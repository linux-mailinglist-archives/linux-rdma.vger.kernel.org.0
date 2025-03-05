Return-Path: <linux-rdma+bounces-8372-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D37A506A3
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 18:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A085316F1E2
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 17:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B21F1AAE2E;
	Wed,  5 Mar 2025 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LxeE6+Z7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3035761FFE;
	Wed,  5 Mar 2025 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196625; cv=none; b=g4io12F+RLW7PAWpAuFNQucR/8RorUiYqJA7MfX9jyaoHvkTWjlvLg0ZOg3nwmAc2+RyTCOSpbQIEDhyEDAAlm3CMsPiyqtPQ2YeSJAFUhDzNH1vp1JNdMF8NNNUfx9Lr54B0pXfHBIzi0VCytFqMKK2CeLhdjCJ/dgk89Ns90g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196625; c=relaxed/simple;
	bh=BULtslcAgRtkIcgu5k0uwjHwL3Dn0IoM6+GCN9lRF9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYERgJ9eSvQF9hEVVCvt6KXzqkN7yX48ceSrCl5I3JVmAY7zDzMPpsxzv5wnpCBi9Qt84VUDSpkLNvgY6PE7bVNNthtnLaAETAST3IthvRY3oT0T/+nLYZgitNZ1F2Yx/6qC+bUgDthRr/PpnSRG9qcyH4On2EgGAj6tCPmu6RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LxeE6+Z7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/iA2dVyhk+69gnf3UVI0x/ZxghoxWkLPj4jz9pqw4ys=; b=LxeE6+Z7uUV4cusCkF6VLd9LlI
	Zzku4m+NQQyy5RfixukDCmLouf7G7BpNBBTfLsnR/VApMww/jjq+w6wH8Xf3/Roz9B7zKPcVBXQpZ
	1wp2KTh2UzDithOLZ+Z/rggExwtRoVGbDHwM25K7FfGGMyisVEhFQZESShRjGReHeRmQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tpsmR-002Y8C-VW; Wed, 05 Mar 2025 18:43:39 +0100
Date: Wed, 5 Mar 2025 18:43:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Message-ID: <86aaf4f3-9792-4d70-a16b-2f5fc7ce63a3@lunn.ch>
References: <20250305121420.kFO617zQ@linutronix.de>
 <433b43b1-0a42-4606-b919-3429c36aa934@lunn.ch>
 <20250305162636.cQf23qHf@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305162636.cQf23qHf@linutronix.de>

On Wed, Mar 05, 2025 at 05:26:36PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-03-05 17:21:56 [+0100], Andrew Lunn wrote:
> > > @@ -276,6 +263,9 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(sw)
> > >  		mlx5e_ethtool_put_stat(data,
> > >  				       MLX5E_READ_CTR64_CPU(&priv->stats.sw,
> > >  							    sw_stats_desc, i));
> > > +#ifdef CONFIG_PAGE_POOL_STATS
> > > +	*data = page_pool_ethtool_stats_get(*data, &priv->stats.sw.page_pool_stats);
> > > +#endif
> > >  }
> > 
> > Are these #ifdef required? include/net/page_pool/helpers.h:
> > 
> > static inline u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
> > {
> > 	return data;
> > }
> > 
> > Seems silly to have a stub if it cannot be used.
> 
> As I mentioned in the diffstat section, if we add the snippet below then
> it would work. Because the struct itself is not there.
> 
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index f45d55e6e8643..78984b9286c6b 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -143,10 +143,14 @@ struct page_pool_recycle_stats {
>   */
>  struct page_pool_stats {
>  	struct page_pool_alloc_stats alloc_stats;
>  	struct page_pool_recycle_stats recycle_stats;
>  };
> +
> +#else /* !CONFIG_PAGE_POOL_STATS */
> +
> +struct page_pool_stats { };
>  #endif
  
Please do add this, in a separate patch. But i wounder how other
drivers handle this. Do they also have #ifdef?

    Andrew

---
pw-bot: cr

