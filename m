Return-Path: <linux-rdma+bounces-8479-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C465A56EA4
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 18:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD028169B83
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 17:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DAD23F27B;
	Fri,  7 Mar 2025 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BfhQnlvs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="st0T204+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCC523BD04;
	Fri,  7 Mar 2025 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741367133; cv=none; b=LTOqL8AW0csI9tBBHhB/NgCO1YGx8KAcU5z/fKlGwcOfMXyy4CZegrVqVNv0ca+qozeS0Acxx5ydKo71nPtZ2QobCV8h2uxAZlfsa7S9tPRshwt45dRqIgU+EVkyHhMz3KEWm+81YutnYUDq/C0ZHddg5f1lCTjKnlkLAsritzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741367133; c=relaxed/simple;
	bh=6J6//RENc0I7j/QmziHsTLSOI4ZvnkvjpENcSSNSc2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdROKDqGmgVG+BPHY04mu+1aCKDiAgzQDb44+jYWB+IXg4OocySUVvnqDNXZ/vBFY0+cQ8tg5FS2OjVKDeHvK5QTFUdwKjb4pFx2n4WaRDl7MC7FBLuIitskJ6tMXohyASrNfnJYmQxrVJyYnI9HQkGL02JVrsw/aD4vQMeB52E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BfhQnlvs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=st0T204+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 7 Mar 2025 18:05:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741367130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uqb0PabbiByGVglMYOPJ7rZC5d/84F8HmxrJUmHYVhY=;
	b=BfhQnlvsDEOAWgxKZ3u0cR/rgHE1ZplM1fNeIakGKmRa/gLTLuiSNeK3K7or6vnEuNEYmh
	+aG71KzoR8SAEKDsx0/S3DLVO3QbRgYdhGY60FyqZrGnp+xK1Fd66d1wNcbfzpNEC824aH
	sYB8IIae0UZ6V6J0ixNZpxoBgLurbZV2LlqwUvfFwZpgBvtkT8UFKm0M6lqgoqCYmVIP/d
	Cp2ohrDW9jWI35gq/FzDrA/YkaNvtLhmuog6XT+9cwuCAbo3QlkMSg2jCTZTKrJtDQJCJY
	vErcjh0o3n6uGIG1I1rfM0E039a22I9dZuVZdm2umEfyPxdbqtWjT46YdRZdfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741367130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uqb0PabbiByGVglMYOPJ7rZC5d/84F8HmxrJUmHYVhY=;
	b=st0T204+5xvy6hH66KO4ZoiWf5dXr8AnRIphceX1DfcTq7Ztpu3y2Wq+gsbch5UJyGV6pa
	1gYkGJfi16jM6RDw==
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
Message-ID: <20250307170528.BhcdOvfQ@linutronix.de>
References: <20250307115722.705311-1-bigeasy@linutronix.de>
 <20250307115722.705311-3-bigeasy@linutronix.de>
 <20250307081135.5ade6e37@kernel.org>
 <20250307165046.qZAH0XkD@linutronix.de>
 <20250307085946.244ddeb6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307085946.244ddeb6@kernel.org>

On 2025-03-07 08:59:46 [-0800], Jakub Kicinski wrote:
> What I'm saying is they are already available per queue, via netlink,
> with no driver work necessary. See tools/net/ynl/samples/page-pool.c
> The mlx5 stats predate the standard interface.

ach, got you.

> > I don't care, I just intended to provide some generic facility so we
> > don't have every driver rolling its own thing. I have no problem to move
> > this to the mlx5 driver.
> 
> Thanks, and sorry for not catching the conversation earlier.

No worries, thanks.

Sebastian

