Return-Path: <linux-rdma+bounces-8405-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF4FA544F1
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 09:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5C63A2B51
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 08:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBAB20764E;
	Thu,  6 Mar 2025 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="07JFPWMO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EVCXZvjh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6182B1FF7C3;
	Thu,  6 Mar 2025 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249983; cv=none; b=o/QlN0XtgZA/E35Ku0+2jdH8JwVVftCob5fpBn3Ex8Y+7NuI3l4LPix7i+Y2JEU2/1HmQVWEJaft8OG9PdNlTD4n5heh0IFVBZCbxZXX54RAdzbPH54Y1wHSbi3mbohghgPWi8dfP95q3UHOKgB4meNMNGcbrV2gJJe7zvqVC7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249983; c=relaxed/simple;
	bh=ez50SSMWVKpwPEAxzgukmtL7C6KphQWYaE4CggHetSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYPcLHlRfe2MEoER6mJ6lKpIm1F3X5BGFjCPXiKecqW63zm11rl71ikMs6VmL/5eXVr/yTf41Ng0wYtZhqUStFTdxKQHGqIqZAHkSSRMlfjC7KndKGf/dnOKzcbp1eBUTa/MhE92W/mmeHqkPMK+bfAWwSssF3OOrITk1T0SbyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=07JFPWMO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EVCXZvjh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 6 Mar 2025 09:32:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741249980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+7sIA2Or82cKYEHIWaYKM61Z3buK52N4jHm/iaiMVoU=;
	b=07JFPWMONquVy6F7VLk9PvK3/31JaGMgodYokXIXzDLCwByth4gconO1CFhFlxjkoQZVtG
	fGV/oq0rf5fFa6U209O/DwH3/X30YF5/AZ70B6DJJI6ak55Bc1W6DBsHSlE9eZteqPHjkK
	iePSq7DIteIG9Vo2VnF2qjn8y8drJdIhrqDCxcO6ffDd/jFlnpCzCgI2iGwXTXUtMGtIp9
	XJ1Dfe7DxCSfcna5xf7sffXJaUoKO+jAoAVkOSGA8EzBXhQE5kTwCS6b2aweuxDdPLBtJX
	bLcoEk8M3r8XNFdKl9kQpSVqHQ4Ex05RYg40+hZm0NK1MbbT1o8dc3c1TAYsCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741249980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+7sIA2Or82cKYEHIWaYKM61Z3buK52N4jHm/iaiMVoU=;
	b=EVCXZvjhjs43XOWP5SxhAHEXiLIHSvqDDaJPIY0cC4sIrV7cFPrfPp6nLT2ajektud1cKd
	ErN7LCvia+XCQjAg==
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
Message-ID: <20250306083258.0pqISYSF@linutronix.de>
References: <20250305121420.kFO617zQ@linutronix.de>
 <8168a8ee-ad2f-46c5-b48e-488a23243b3d@gmail.com>
 <20250305202055.MHFrfQRO@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250305202055.MHFrfQRO@linutronix.de>

On 2025-03-05 21:20:57 [+0100], To Tariq Toukan wrote:
> > I like the direction of this patch, but we won't give up the per-ring
> > counters. Please keep them.
> 
> Hmm. Okay. I guess I could stuff a struct there. But it really looks
> like waste since it is not used.
> 
> > I can think of a new "customized page_pool counters strings" API, where the
> > strings prefix is provided by the driver, and used to generate the per-pool
> > strings.
> 
> Okay. So I make room for it and you wire it up ;)

Could I keep it as-is for now with the removal of the counter from the
RQ since we don't have the per-queue/ ring API for it now? It is not too
hard it back later on.
The thing is that page_pool_get_stats() sums up the individual stats
(from each ring) and it works as intended. To do what you ask for, you I
would have to add a struct page_pool_stats to each struct mlx5e_rq_stats
for the per-ring stats (so far so good) but then I would have manually
merge the stats into one struct page_pool_stats to expose it via
page_pool_ethtool_stats_get(). Then I am touching it again while
changing the type of the counters and this is how this patch started.

Sebastian

