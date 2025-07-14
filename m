Return-Path: <linux-rdma+bounces-12142-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB01B04405
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 17:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA74166746
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 15:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5D226FD9B;
	Mon, 14 Jul 2025 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQga0rlm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EAD26D4C3;
	Mon, 14 Jul 2025 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506761; cv=none; b=tq1RT53mYPDKYOMniPGy9GDV9GHsMnKJMWQVdnHDqbMXcVHO8dqcrdg0htQIZkhKy+0S62LTse6DZ0ZS1ljraAPmOwxbIioZXQErt5t6pd4A8ADuArECiYI8YpdlYmSlFnzAmzpNRvtn1DmdbDtom5D3GnzHDzeEhOdxdTaSMbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506761; c=relaxed/simple;
	bh=PmO6um/+dA5SWNVXsOyKgr4VOMFYydZca5EuD5cvcqE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcTB00y2rvhne1eEClefW5H/QoPP0NyvkwgmhB10M9fRYy94J2v5S2dMClzVsan89YAgxP2OtMyIzQsmSggE2CqmgWyCm/jmcjSkK/70XF9uQDc8EiZ9Xh4HVHApLybzN3e9o1CiGidkpZGf5gsbKO83aSSNflQazPfF9wXOoV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQga0rlm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC051C4CEED;
	Mon, 14 Jul 2025 15:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506761;
	bh=PmO6um/+dA5SWNVXsOyKgr4VOMFYydZca5EuD5cvcqE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mQga0rlmITKIDVh7CI2wnZAfv4mYauqiEI6z5FLSVEMs8aAcBekbzLM6uq+D2DW5T
	 IZgpJKI577jpxfersgYRnozWaTMrbtZWUrUbqdCRSxWCtSSq0HENiG3WLKKkUVdoW7
	 mG7YbwfeOdFQuJNuUx2BQ1PlwqeLeg+UqvhxaW5BpGGrZsx6cBCaRT3mYMhJX31jJV
	 iysu5UnZS+czC8pmeJNQanvUdlDzVK+rs9GXcvLT0H/LEeZi9Au3aKl+H7PVQ9FZo8
	 9Ml2sjgzVsyki6SDvnMDwK+KiBvaUdQoRGt4yjUR+kYFOJP/8o2300yrxmKah5rxxD
	 Ii9sRR9B2uCLg==
Date: Mon, 14 Jul 2025 08:26:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeed@kernel.org>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Saeed
 Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Jonathan
 Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2 2/3] net/mlx5e: Add device PCIe congestion
 ethtool stats
Message-ID: <20250714082600.15113118@kernel.org>
In-Reply-To: <nqfa765k7djsxh7w5hecuzt6r4hakbyocrp5wtqv63jyrjv3z2@qdar7f2osjcj>
References: <1752130292-22249-1-git-send-email-tariqt@nvidia.com>
	<1752130292-22249-3-git-send-email-tariqt@nvidia.com>
	<20250711162504.2c0b365d@kernel.org>
	<nqfa765k7djsxh7w5hecuzt6r4hakbyocrp5wtqv63jyrjv3z2@qdar7f2osjcj>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Jul 2025 07:55:27 +0000 Dragos Tatulea wrote:
> > The metrics make sense, but utilization has to be averaged over some
> > period of time to be meaningful. Can you shad any light on what the
> > measurement period or algorithm is?
>
> The measurement period in FW is 200 ms.

SG, please include in the doc.
 
> > > +	changes = cong_event->state ^ new_cong_state;
> > > +	if (!changes)
> > > +		return;  
> > 
> > no risk of the high / low events coming so quickly we'll miss both?  
> Yes it is possible and it is fine because short bursts are not counted. The
> counters are for sustained high PCI BW usage.
> 
> > Should there be a counter for "mis-firing" of that sort?
> > You'd be surprised how long the scheduling latency for a kernel worker
> > can be on a busy server :(
> >  
> The event is just a notification to read the state from FW. If the
> read is issued later and the state has not changed then it will not be
> considered.

200ms is within the range of normal scheduler latency on a busy server.
It's not a deal breaker, but I'd personally add a counter for wakeups
which did not result in any state change. Likely recent experience
with constant EEVDF regressions and sched_ext is coloring my judgment.

