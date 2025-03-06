Return-Path: <linux-rdma+bounces-8402-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC93EA543CE
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 08:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01FF3AE418
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 07:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B8C1AAE13;
	Thu,  6 Mar 2025 07:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zw4s+xf5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZK9UfUwb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE85184E;
	Thu,  6 Mar 2025 07:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741246735; cv=none; b=cKNY2EbyG0sBncXKBGPjwj8y5CyvA/eK2JEyUVPR5MrfpVfiwHxAlwjK1Jj2gOiRnxIzcQdIu/EKhRsNn5D4aEKSwTufLlx/5lUPaNjSSDgqgt9V7iTEi5Jrbqlz7W3SDcHgxhcjYn85L+YghzJapOA9ZH3N01YphTJt3ZmtezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741246735; c=relaxed/simple;
	bh=hNwFeJd87ylqxeZqYsq4ZSvBei/DfdwstfqBdRI/zTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIyVxfNawcaJHEcOc/HMD8j8S09WkgDtNTcxZxl4/QfEUilAjBqXY/V33b7c/ZOYpD6hsOmTVW40C29FK35ZDjAB4VeWUiaIn4j3+6GYOEYwdZ3B9XSSyAzQAXHS0930Wy15/z4ln9mRrscr8uzAU4q3HEyb1EG39ah/cXl5jqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zw4s+xf5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZK9UfUwb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 6 Mar 2025 08:38:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741246731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nS6P45mUCMn1oxPskIVg60Xol7SNa+58TiakbC7+hHg=;
	b=zw4s+xf5dsyadrhmnGzHbAKgd/t3uO0oPcc9Ux9SE1moOH0muQErKQA+gQBTnRDXHSqIv9
	5/0ZbPWOg863g4f45010u+US00oYD/ZqMg6AzmU5X0fCMfs/vqbTlg9CTY4KSJnYLRznEO
	g30StBN+jzlF5MS3LcxB7cx7FimhQ+n3Ymbjrse95aZ4dGP6GKAbkq6kR+JJre3osYCkYF
	mmjh4xmpSr42IDcqqrtwO95KD3jLFjYq/uiIPqM+U/z+JDoBwAGVpXtYRNjtV6hC9TOT5s
	SbuSgHR4NUzmdPu1gS/D5dr3Bs0LcB708PiUa53oGK+HHVLJUcpAJciHU74HHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741246731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nS6P45mUCMn1oxPskIVg60Xol7SNa+58TiakbC7+hHg=;
	b=ZK9UfUwb8ysLQcbN0g8kGRBKKqnokQHjSmyWWh210PgArkq7Vn5WiieXj8eoAHcRTOnHhx
	hI3sdQrL7IBJ30CQ==
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
Message-ID: <20250306073850.yA23Fs1V@linutronix.de>
References: <20250305121420.kFO617zQ@linutronix.de>
 <8168a8ee-ad2f-46c5-b48e-488a23243b3d@gmail.com>
 <20250305202055.MHFrfQRO@linutronix.de>
 <42892aa7-f7a9-4227-9f3f-24a0f1c96992@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42892aa7-f7a9-4227-9f3f-24a0f1c96992@gmail.com>

On 2025-03-06 08:49:55 [+0200], Tariq Toukan wrote:
> > > I like the direction of this patch, but we won't give up the per-ring
> > > counters. Please keep them.
> > 
> > Hmm. Okay. I guess I could stuff a struct there. But it really looks
> > like waste since it is not used.
> > 
> 
> Of course they are used.
> Per-ring (per-pool) counters are exposed via ethtool -S.

That is true for some stats and they are prefixed with a number for the
individual ring. In case of page_pool_stats they are not exposed
individually. The individual page_pool_stats counters from each ring are
merged into one counter and as exposed as one (not per ring).

Sebastian

