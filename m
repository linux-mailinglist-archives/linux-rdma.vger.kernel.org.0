Return-Path: <linux-rdma+bounces-8477-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6E8A56E58
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 17:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E0F1898A11
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 16:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3C624166B;
	Fri,  7 Mar 2025 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sgOBZWc7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LAZFv1we"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F418F24110D;
	Fri,  7 Mar 2025 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366251; cv=none; b=qSrJ4d/rd83EqY+jUJwD+t/8dL+gIV97Ee1LjxB/dSCCffEkRztS5CpRNIxCPCh+qGHb3Uv/jf9fHruX78eJZymt6NLEBD3o0nXUFICAxdGYhaWCgdJgzClGEa0AFZ1Sjy84RXl4+BBju+KgXh/Oy3lKyxmckHn7/L5hRG/hUA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366251; c=relaxed/simple;
	bh=oTdGyM7i17u0BTRapoUbuecK2FRjICILOT2rFoRnWL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wk3uoeLNsRlQUybYX7BnyPw/uWae9orCmW/tJ9/kaEs7I7RhYjFjFzgGNlswcKbFPcq8avaPm1rgwGTP9FddBJv08IWhp6Dm55k1luhkJw4zXRhmdaPNSsN/qZC2RVmv4gCYtz/Bl9LPfVBqqZCbiLD3G3h1/ua3BUWmsTarfgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sgOBZWc7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LAZFv1we; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 7 Mar 2025 17:50:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741366247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtCpW9oSAbhRWZnZwZUFMaiUwcwgd8ptKJLo6/MTFjk=;
	b=sgOBZWc7//+ZuPBByA8yhX8d0984jwcL0caP1u8j1NR5Dh5Eeklc0MMfZ1QGCdtqetumux
	VNyNVKe4lgUQYanG4MB5SHawbbBJWzuI+z8EUhbkgARuj9CXHqYVB31BELHqW3327tydGN
	33XZg+T56QWhoTLz8ISo3FFlF6Igdt7Rk/6jVycsaS29lT1l9Jf8NaxdQ7ymyP81yFOUlC
	yH0y2lg/VWLHrMjYk19AOnkfLo3CH3f9jJgo02cAV6lx6Kf3C0tcxsc25RJcfWore1KpfO
	S0T4iKKTEwNXaETlbrT3lymZGom6jHKnNpsLW9MnVbsRX656ObOeFT4o6RiFMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741366247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtCpW9oSAbhRWZnZwZUFMaiUwcwgd8ptKJLo6/MTFjk=;
	b=LAZFv1wens/OV5YHDQQlXnOlo6IN12r29jpVq3Q0EJTq2me81I/wy1IeYkRi7zTX0gdCHj
	pHKEjOLP9WTnkkAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Joe Damato <jdamato@fastly.com>, Leon Romanovsky <leon@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH net-next v2 2/5] page_pool: Add per-queue statistics.
Message-ID: <20250307165046.qZAH0XkD@linutronix.de>
References: <20250307115722.705311-1-bigeasy@linutronix.de>
 <20250307115722.705311-3-bigeasy@linutronix.de>
 <20250307081135.5ade6e37@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250307081135.5ade6e37@kernel.org>

On 2025-03-07 08:11:35 [-0800], Jakub Kicinski wrote:
> On Fri,  7 Mar 2025 12:57:19 +0100 Sebastian Andrzej Siewior wrote:
> > The mlx5 driver supports per-channel statistics. To make support generic
> > it is required to have a template to fill the individual channel/ queue.
> >=20
> > Provide page_pool_ethtool_stats_get_strings_mq() to fill the strings for
> > multiple queue.
>=20
> Sorry to say this is useless as a common helper, you should move it=20
> to mlx5.
>=20
> The page pool stats have a standard interface, they are exposed over
> netlink. If my grep-foo isn't failing me no driver uses the exact
> strings mlx5 uses. "New drivers" are not supposed to add these stats
> to ethtool -S, and should just steer users towards the netlink stats.
>=20
> IOW mlx5 is and will remain the only user of this helper forever.

Okay, so per-runqueue stats is not something other/ new drivers are
interested in?
The strings are the same, except for the rx%d_ prefix, but yes this
makes it unique.
The mlx5 folks seem to be the only one interested in this. The veth
driver for instance iterates over real_num_rx_queues and adds all
per-queue stats into one counter. It could also expose this per-runqueue
as it does with xdp_packets for instance. But then it uses the
rx_queue_%d prefix=E2=80=A6

I don't care, I just intended to provide some generic facility so we
don't have every driver rolling its own thing. I have no problem to move
this to the mlx5 driver.

Sebastian

