Return-Path: <linux-rdma+bounces-8413-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED19FA54805
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 11:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E637B173431
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 10:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722F5207656;
	Thu,  6 Mar 2025 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZkvItvby";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qgVAEmNp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62DE20A5E7;
	Thu,  6 Mar 2025 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257515; cv=none; b=e9/M3Sn+KT6YuKB1SzQ5v/hPWPdx0VqsnEXPXXuK0zTF3NN97ZvO2Rml4BwlfsKPi8iPwmJ3NIlYj7CHh/lkQRXxDdUtTQFN3ERSpxXXGm4SHUKRlEqHMOcZXQiqlxn8kc4HLPxBELkP+KkeQl6ea1cR98/u6VWocArCAW0Zzz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257515; c=relaxed/simple;
	bh=HviRadPskvpfp0j4BBD0yPd5krqoGmkk1uk/u8H09mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYNdNqBSDhX39uJ19pPG6HEI/a29K9Z/4bYp1UhcWgTV38XVu7FXcjWWyUbdWiMlfMGYvRbvyhRuQEyiMdXW9kFHXw+CSv7KQg/lrqnSpEF914z87VDjHWuFCxOu4SiAtWBUQlY4kDRwiA57Kc3A2EwUE/8gSbSWQizUjNzpkQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZkvItvby; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qgVAEmNp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 6 Mar 2025 11:38:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741257512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9g45w808QR7b/YlyCo/XCrgw//yKP2YPfM55myvgpIk=;
	b=ZkvItvbypFOae/oWLVxKZpnuuYWH440qqmxRjWIE2gKBIAgVlgtaKg5q+VdY69rOpZHiJj
	whprwJTj2bxgPXinK5884SFK95oLbd3YtHOlGhW4SGs6bsSUAvzVf4quyZsMG05lgaGJLg
	PzLpWPzAUXfeDQBj/vdBgZnVdOa07vnyZdYCBDQRvqabGqzBhL29Z2EvAUIu7kr9qwHnRp
	aBYRM6BvVvgLdwtdRjUKi8Z8WlzOtfVxKNAtYAJU4ZABLLtmMnuA+6ETE//0xZ5/fv3BNI
	6K4pQr7jpDMdAaGO55QewbDMDVyexJZhjaeRG2l2HREO5VsB2OsmBAGfDml/8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741257512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9g45w808QR7b/YlyCo/XCrgw//yKP2YPfM55myvgpIk=;
	b=qgVAEmNplAHwHxXJnO085lQ1Knj+LioZhz5WwhI7bXILC2OHMLsnAOlpdzcM/Qxdoxg4To
	ZHI7oMh5bki3ZaBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Joe Damato <jdamato@fastly.com>,
	Leon Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next] net/mlnx5: Use generic code for page_pool
 statistics.
Message-ID: <20250306103830.2LUEimH0@linutronix.de>
References: <20250305121420.kFO617zQ@linutronix.de>
 <8168a8ee-ad2f-46c5-b48e-488a23243b3d@gmail.com>
 <20250305202055.MHFrfQRO@linutronix.de>
 <20250306083258.0pqISYSF@linutronix.de>
 <042d8459-e5be-4935-a688-9fe18b16afa1@gmail.com>
 <20250306095639.HpT1e8jH@linutronix.de>
 <3452446f-602f-4756-a65d-ec02d95c767b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3452446f-602f-4756-a65d-ec02d95c767b@gmail.com>

On 2025-03-06 12:22:42 [+0200], Tariq Toukan wrote:
> 
> 
> On 06/03/2025 11:56, Sebastian Andrzej Siewior wrote:
> > On 2025-03-06 11:50:27 [+0200], Tariq Toukan wrote:
> > > On 06/03/2025 10:32, Sebastian Andrzej Siewior wrote:
> > > > Could I keep it as-is for now with the removal of the counter from the
> > > > RQ since we don't have the per-queue/ ring API for it now?
> > > 
> > > I'm fine with transition to generic APIs, as long as we get no regression.
> > > We must keep the per-ring counters exposed.
> > 
> > I don't see a regression.
> > Could you please show me how per-ring counters for page_pool_stats are
> > exposed at the moment? Maybe I am missing something important.
> > 
> 
> After a ring is created for the first time, we start exposing its stats
> forever.
> 
> So after your interface is up for the first time, you should be able to see
> the following per-ring stats with respective indices in ethtool -S.
> 
> pp_alloc_fast
> pp_alloc_slow
> pp_alloc_slow_high_order
> pp_alloc_empty
> pp_alloc_refill
> pp_alloc_waive
> pp_recycle_cached
> pp_recycle_cache_full
> pp_recycle_ring
> pp_recycle_ring_full
> pp_recycle_released_ref
> 
> Obviously, depending on CONFIG_PAGE_POOL_STATS.

That is correct. But if you have 4 rings, you only see one pp_alloc_fast
which combines the stats of all 4 rings. Or do I miss something?

Sebastian

