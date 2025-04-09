Return-Path: <linux-rdma+bounces-9306-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022E4A82C1E
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 18:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF893AD974
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 16:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDB41BD50C;
	Wed,  9 Apr 2025 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="34Efn0TO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CyNS8dpT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F1D25291E;
	Wed,  9 Apr 2025 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744215105; cv=none; b=fahv+VshPw/vA12MTqPryxMLlkUdaBIu25l1gmh0yol1a8mkQSCnnKoGpDDVMrFl/jsAKU6F+tnPcWoVW5ksyX5QZp3lNfGziChBnVOoadRNaCIa3igjTKStLU70AJiTWchSIxr8NqPwyE2srrgsiR8Wlhw1sUbHE/MNU9c/c+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744215105; c=relaxed/simple;
	bh=MiVTnIC2+bhkCArxVKD+yTeDnBjDmgCvDWMFOgjJO1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmtKs+UjZlRFTrK8jzVsJAFlxeehIhGueiImEiMvX4O00z1lNRKc8kJdps4LZbN8kKBH4Y92XZMvTyjvZCnP+W6YQrhsJNmvhrzFrQ+XF1nP9cl3dOiVGGJTLe2vCf8VYefhVO7ryuLB9ajLgREx6m/O4JefnoHnM0MvB14piIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=34Efn0TO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CyNS8dpT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 9 Apr 2025 18:11:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744215101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PRDAYueeSE0rSRTm2UWZBPmD2llhpcLxL39y2Ha55CE=;
	b=34Efn0TOiPIGqiDvKTuju+dmf90AToL2+L/rPaBW5OdYR82W8Pxc4X5fQo2OV7HSHEOiYU
	XC7Z1mGKZSb5JE//ra59l7PxW6rix3upYXJevKeJV7S3Pdg9ex9yz5SJChS1we95xwXAQ6
	wn5/mfwcGYQG+ffg8JC4/Uex5PQldTCwvdSdg28RuyjZSy6jfaAIa/+oYqIoXE5/CC4Tr5
	vSDyg4rMve6i12+vG2hnZ98JKatkJjFTjapn3kkn1DDpcMG/mTo6YEhJtDIPE0hn6uW8Jl
	8TKWqi6E1q/DlVwUM5ccLpdNl974/5nfp6LmbSFv/2xyHqyeS0coAJu12KiqVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744215101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PRDAYueeSE0rSRTm2UWZBPmD2llhpcLxL39y2Ha55CE=;
	b=CyNS8dpTxI1HQ2vbNigmPmlICkRnSfugxNo8TPwhetWF+bxvStqQKoBKw3xs4PhcposbjI
	IYudupa/rX3v0lBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: linux-rdma@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Joe Damato <jdamato@fastly.com>, Leon Romanovsky <leon@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH net-next v3 3/4] page_pool: Convert
 page_pool_recycle_stats to u64_stats_t.
Message-ID: <20250409161140.-k4iGuQe@linutronix.de>
References: <20250408105922.1135150-1-bigeasy@linutronix.de>
 <20250408105922.1135150-4-bigeasy@linutronix.de>
 <988c920b-56b8-43f6-a42c-54e3ea6dc261@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <988c920b-56b8-43f6-a42c-54e3ea6dc261@huawei.com>

On 2025-04-08 20:13:09 [+0800], Yunsheng Lin wrote:
> > index 9d958128a57cb..5215fd51a334a 100644
> > --- a/Documentation/networking/page_pool.rst
> > +++ b/Documentation/networking/page_pool.rst
> > @@ -181,11 +181,11 @@ Stats
> >  
> >  	#ifdef CONFIG_PAGE_POOL_STATS
> >  	/* retrieve stats */
> > -	struct page_pool_stats stats = { 0 };
> > +	struct page_pool_stats stats = { };
> >  	if (page_pool_get_stats(page_pool, &stats)) {
> >  		/* perhaps the driver reports statistics with ethool */
> > -		ethtool_print_allocation_stats(&stats.alloc_stats);
> > -		ethtool_print_recycle_stats(&stats.recycle_stats);
> > +		ethtool_print_allocation_stats(u64_stats_read(&stats.alloc_stats));
> > +		ethtool_print_recycle_stats(u64_stats_read(&stats.recycle_stats));
> 
> The above seems like an unnecessary change? as stats.alloc_stats and

Right. The ethtool_print_.*() don't exist either. Let me remove that.

> stats.recycle_stats are not really 'u64_stats_t' type.
> 
> Otherwise, LGTM.
> Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>

Sebastian

