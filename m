Return-Path: <linux-rdma+bounces-8376-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DFBA50A58
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 19:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A19A7A6BA5
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 18:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBD0253357;
	Wed,  5 Mar 2025 18:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YBaAvqAq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AhDAn0tW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52505245010;
	Wed,  5 Mar 2025 18:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200747; cv=none; b=r+ahjQXbloSYhV0Th7AQ1zQPv2DCdd4fbkAQqZlqhOef6/iH4AYVarxO2CeznFUXwcByKEg7OSW27ocMk6XKNueuvUtnoWAWm1Jr4gzabjdui4iMTDZbzl5/jdXxetHz4QOnq/IuUkZqpeRoIxky/xUwDEXEDx5KgBr1bHEoeGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200747; c=relaxed/simple;
	bh=k0gIuwgb7DbjY6nZzjWuaVBqPEavNNyFK0U/4DVn9ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QapmgC8FZAoo4dtLcAWfSaijJXd2bJoKL38E7YMf4QfeGjFu8kwNBK9oTyyYwGCBqLfzkfp9ZEAaJ8Ofw/a6fs3o6qrYyPic7DLXEI+pQrT3/jYZ6i0ofTWE9UeEu1QGmmRHilGgi8U0yyHw+afuEmpTkBTy471o4Lh8Onb1JL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YBaAvqAq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AhDAn0tW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Mar 2025 19:52:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741200744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vBupRxl84uMo5Lro/2rBP6Ygdv19uAmPN8rGJRvd6jw=;
	b=YBaAvqAqXPu3dvBR6uNhqJeJC6PnoXC32UN4TP3GZOOTt/tkUK6cNF7wSXntWy+6XmV6RK
	PdQT6WvTSeMiJEcE3qhmEPhwfvO9d9W7SQg5+b4V+OW7EfEZAWM72ZGcgEz6cGI5WnowEj
	RCgyFuIEJkModjUhNO3ZgtalnmmV4H0b9nLz8BpVaDe/CBNK+F8khpjUaiShli/8vhr8hF
	mtwXhIeQHkLP6LiXM7qEIfdutRKY1LIclL3JP36/4cXUTxQpVG3IBbNjW04Hp6p0GkyAig
	JLU/jAtCyZ6e6KjpEDVg85byH9JKfyKOWRF3iR1p3UY1aDQnSl/6YMdFB8BZhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741200744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vBupRxl84uMo5Lro/2rBP6Ygdv19uAmPN8rGJRvd6jw=;
	b=AhDAn0tWE+fdfRtY3xrU/ECmDSqBXX0FUJXXxR6N4gcm51KmTL0lZiXHReuK8Cr80jpb1i
	Jr6MAZ03/v/lEEAg==
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
Message-ID: <20250305185222.ryCIhbOs@linutronix.de>
References: <20250305121420.kFO617zQ@linutronix.de>
 <433b43b1-0a42-4606-b919-3429c36aa934@lunn.ch>
 <20250305162636.cQf23qHf@linutronix.de>
 <86aaf4f3-9792-4d70-a16b-2f5fc7ce63a3@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86aaf4f3-9792-4d70-a16b-2f5fc7ce63a3@lunn.ch>

On 2025-03-05 18:43:39 [+0100], Andrew Lunn wrote:
> > diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> > index f45d55e6e8643..78984b9286c6b 100644
> > --- a/include/net/page_pool/types.h
> > +++ b/include/net/page_pool/types.h
> > @@ -143,10 +143,14 @@ struct page_pool_recycle_stats {
> >   */
> >  struct page_pool_stats {
> >  	struct page_pool_alloc_stats alloc_stats;
> >  	struct page_pool_recycle_stats recycle_stats;
> >  };
> > +
> > +#else /* !CONFIG_PAGE_POOL_STATS */
> > +
> > +struct page_pool_stats { };
> >  #endif
>   
> Please do add this, in a separate patch. But i wounder how other
> drivers handle this. Do they also have #ifdef?

veth.c, fec_main.c, yes.
mvneta.c, mtk_eth_soc.c, no. But then they select PAGE_POOL_STATS so it
is not exactly a fair comparison.

>     Andrew

Sebastian

