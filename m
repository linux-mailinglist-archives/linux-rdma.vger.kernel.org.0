Return-Path: <linux-rdma+bounces-8478-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95111A56E78
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 17:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018B93B274E
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 16:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C045D23ED6F;
	Fri,  7 Mar 2025 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCTEc77L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C74D21A456;
	Fri,  7 Mar 2025 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366788; cv=none; b=AT1TvqNXUu1LO6GWo/u4P5GiXrrPtZKX2fr6+EUqagPsK/mkKkze9frqtkLpi5arKRmAiLDrAJ5WXhqKS5D3rtStoxMcTTEKVbVeDDCsMnxziiF00MdnkUNgrl0LC8t/BCduEq396zKlyL5QbfOlzweQRvhsqwKhaP25+EdIa58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366788; c=relaxed/simple;
	bh=9wEzaXZsbLpzrzvhwB2YG2GvfE8YsWepanekirN/N4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oc1mdya0dbQNS9+WEkFCGil8vuN0noejFBn0UD/UaY42mr+RXzplrX4+6VUr3o41DOoPi4P04aa/SpxfHsHkfxvit7CrpX51i5z3vqTo7VTNZG2+5OQjfM7xHfJWmmmtgBc72lm/vvtNRDf/Aka+jchnTqioqaOY2qWpqwN5V+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCTEc77L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C47C4CED1;
	Fri,  7 Mar 2025 16:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741366788;
	bh=9wEzaXZsbLpzrzvhwB2YG2GvfE8YsWepanekirN/N4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BCTEc77LbJUg0gKAXkUA6Osd57n4K5KeYwn/BFDUVexeiOJOqUGHNQV+1tRE401hJ
	 I+HQd76cPVM48OQFWg+ZnwV6TK7Ol8piB0bGxfZYizAjtWHhiwF+cuBAQZZVS7+UvU
	 Du3flHbxXKlMJCR/cQmUHPtFzd5Jiu73T1gtcMJ+feWO5smaQLxQNjbiTCjFI0hOET
	 EF7Vht7DlE61iHSpRSuM5j0rCQIB1XF3lIxk0Xc1sjCD5WLXfWiyM7ts7Wto/3tiUn
	 dXF5/PbKFNF/XTQa1v2n+ft49HshE8yVCk9U6a8v7xtRyWABOdEz5wUgRZIjUX/pta
	 T9tnMrKg0R1wA==
Date: Fri, 7 Mar 2025 08:59:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Leon Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Simon Horman <horms@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>, Yunsheng Lin
 <linyunsheng@huawei.com>
Subject: Re: [PATCH net-next v2 2/5] page_pool: Add per-queue statistics.
Message-ID: <20250307085946.244ddeb6@kernel.org>
In-Reply-To: <20250307165046.qZAH0XkD@linutronix.de>
References: <20250307115722.705311-1-bigeasy@linutronix.de>
	<20250307115722.705311-3-bigeasy@linutronix.de>
	<20250307081135.5ade6e37@kernel.org>
	<20250307165046.qZAH0XkD@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Mar 2025 17:50:46 +0100 Sebastian Andrzej Siewior wrote:
> On 2025-03-07 08:11:35 [-0800], Jakub Kicinski wrote:
> > On Fri,  7 Mar 2025 12:57:19 +0100 Sebastian Andrzej Siewior wrote: =20
> > > The mlx5 driver supports per-channel statistics. To make support gene=
ric
> > > it is required to have a template to fill the individual channel/ que=
ue.
> > >=20
> > > Provide page_pool_ethtool_stats_get_strings_mq() to fill the strings =
for
> > > multiple queue. =20
> >=20
> > Sorry to say this is useless as a common helper, you should move it=20
> > to mlx5.
> >=20
> > The page pool stats have a standard interface, they are exposed over
> > netlink. If my grep-foo isn't failing me no driver uses the exact
> > strings mlx5 uses. "New drivers" are not supposed to add these stats
> > to ethtool -S, and should just steer users towards the netlink stats.
> >=20
> > IOW mlx5 is and will remain the only user of this helper forever. =20
>=20
> Okay, so per-runqueue stats is not something other/ new drivers are
> interested in?
> The strings are the same, except for the rx%d_ prefix, but yes this
> makes it unique.
> The mlx5 folks seem to be the only one interested in this. The veth
> driver for instance iterates over real_num_rx_queues and adds all
> per-queue stats into one counter. It could also expose this per-runqueue
> as it does with xdp_packets for instance. But then it uses the
> rx_queue_%d prefix=E2=80=A6

What I'm saying is they are already available per queue, via netlink,
with no driver work necessary. See tools/net/ynl/samples/page-pool.c
The mlx5 stats predate the standard interface.

> I don't care, I just intended to provide some generic facility so we
> don't have every driver rolling its own thing. I have no problem to move
> this to the mlx5 driver.

Thanks, and sorry for not catching the conversation earlier.

