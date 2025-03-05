Return-Path: <linux-rdma+bounces-8380-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0DFA50C64
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 21:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A6D3B0A5E
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 20:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE238254878;
	Wed,  5 Mar 2025 20:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ibt5x9I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y1haZ0ox"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AFE2459FC;
	Wed,  5 Mar 2025 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741206068; cv=none; b=N2qPH3D8x5sYV0+ZmroD26jrK7cHUQvDBPFQBv+QVqu9oE+nRQ/yhVGzmu/Nv5Wi8huN/2qGJFAOow5pO5xVuk2kPPBYCL4xEoKbxz3saoEhaj+B8BbqqMyWB0wGG3OzCcXJE2l/9DL+Gc3KAMkKFHU/LXK01vArXbg1jFVsiig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741206068; c=relaxed/simple;
	bh=5QhY5f3kf2O/mUI5KeGQzo1tJMrcLmCDJcEng4FRJnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXEgyGRxnWISIw/kB3aQtDvN8zn7Utv6npx070Neu8uCTGIes7wM+dnRQkY8H4kNcMSzosF9APNGWGfrs2D3wO4CAoGNlDEmoqngI3vG7YilMniqBXxzEA5JFIo8GO7id8US0oxoz1xjEQNcPSY2r/nXADjg0f8PvY+HS6maxEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ibt5x9I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y1haZ0ox; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Mar 2025 21:20:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741206057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cUNfCA8pHf+83tsUMHJzb2XKVvK6o+uPQfq7/hnMo4A=;
	b=2ibt5x9IH67QyZtBFRdvYg6tPvzMHBzxKK8sCLbUqlEV2p1dT5OE4f76qjCLScvce5GytI
	ZPQG3KT3rrJvuBp3kxHS34ip02UOsw+fB2V9cgd5QeaLSQg6R6OZcIkaJh1InZ+Cl7Yt4s
	4UqzJXZ0nvISNa4LC7ZnytfwEYNzf8jr0uXVyvXy1EDsTGI4l4BKUR8LFup/VF/gnHcPpd
	lh2lG1kVl2f1vDAgSlPY2Il7UldWMj2u+vyU9iB3koemu65NAW4DEzHD2LpOhgled5Wltp
	M5u6qihR54pWFBb64QJsqYqxlvqnIh/cXWewsnJpkdyj+3jUwPZlk+mSBYS3Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741206057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cUNfCA8pHf+83tsUMHJzb2XKVvK6o+uPQfq7/hnMo4A=;
	b=y1haZ0oxtYCDB88gRYk0otrAmy6FfzsHrC8MXDoH3GpDC9mFD8mb+r0QoybLFlLj6qS1HJ
	OcFQ0mY7tHnJEWDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Joe Damato <jdamato@fastly.com>,
	Leon Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH net-next] net/mlnx5: Use generic code for page_pool
 statistics.
Message-ID: <20250305202055.MHFrfQRO@linutronix.de>
References: <20250305121420.kFO617zQ@linutronix.de>
 <8168a8ee-ad2f-46c5-b48e-488a23243b3d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8168a8ee-ad2f-46c5-b48e-488a23243b3d@gmail.com>

On 2025-03-05 21:44:23 [+0200], Tariq Toukan wrote:
> Hi,

Hi,

> Thanks for your patch.
> 
> IIUC you remove here the per-ring page_pool stats, and keep only the summed
> stats.
> 
> I guess the reason for this is that the page_pool strings have no per-ring
> variants.
> 
>   59 static const char pp_stats[][ETH_GSTRING_LEN] = {
>   60         "rx_pp_alloc_fast",
>   61         "rx_pp_alloc_slow",
>   62         "rx_pp_alloc_slow_ho",
>   63         "rx_pp_alloc_empty",
>   64         "rx_pp_alloc_refill",
>   65         "rx_pp_alloc_waive",
>   66         "rx_pp_recycle_cached",
>   67         "rx_pp_recycle_cache_full",
>   68         "rx_pp_recycle_ring",
>   69         "rx_pp_recycle_ring_full",
>   70         "rx_pp_recycle_released_ref",
>   71 };
> 
> Is this the only reason?

Yes. I haven't seen any reason to keep it. It is only copied around.

> I like the direction of this patch, but we won't give up the per-ring
> counters. Please keep them.

Hmm. Okay. I guess I could stuff a struct there. But it really looks
like waste since it is not used.

> I can think of a new "customized page_pool counters strings" API, where the
> strings prefix is provided by the driver, and used to generate the per-pool
> strings.

Okay. So I make room for it and you wire it up ;)

Sebastian

