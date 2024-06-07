Return-Path: <linux-rdma+bounces-2968-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED558FF89B
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 02:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04721C21256
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 00:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B381843;
	Fri,  7 Jun 2024 00:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiIDII4P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C78A802;
	Fri,  7 Jun 2024 00:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717719584; cv=none; b=fGeYXMPJTx9Zv3EcJzYMd8H3QYBMdLEg8OfB955sCRApFpx9CDzutJ/+OdH7eahsQdpdpRKTS0RltLsBEF+JvOyZqDNwGAU3HqUvP317MF/rcIf+TEE6GcQOL70pbci5u3HWvFl23maC2AVrqBRI4Q5EGHqNaYhe+rpfOqWeQ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717719584; c=relaxed/simple;
	bh=g3QH/J1UqGMMgv1UFdPgFNuujOHdUk7CBldWAmkk7JM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=An2lttabgbnJABaCj88d32LQ6UBBovfjVsv7G0D72akbIxytRyoMmRL93Ec4w8yULL3qR5O3cg4z/XtUtdC09CIT+JrDa6s3Aq8iAHsQ0Q6FnmIgzjql2TPrXFr9GORwPUxYkn2+8W7ODrcp3RfHYJrGoKybehJJEi6I6nYT4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiIDII4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6F6C2BD10;
	Fri,  7 Jun 2024 00:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717719584;
	bh=g3QH/J1UqGMMgv1UFdPgFNuujOHdUk7CBldWAmkk7JM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oiIDII4P8I3kgYt0Wf6S9xsjVebnxAwTbnApLdPnwJdv7o7zwSjjwbdoxUaGdQgSa
	 1+rnYpLqGni4g7s2kiXo1VxNITAFaLZ160mNlCPP2AX06NXC5mg7Y9cDHivIG+v3i4
	 DBTYq4x4H45ci4GnA3MCuRbo+IZ+6t+NHiwWO7hoEqwZ49EeHgcW6lDf4z8xTZUQIE
	 RWEnefG15CzHvoBiAT3iSG6X3HCrXyJTQr4yPSpRRD+wEyK1k6j/4g8kOxQYxuXLxf
	 HLKtKbvSyrlk74Up91TbD9tK9Sj5G8w5STIk25ccja88ZVhBgMimocXROJ4vdUlawq
	 1dZgvVAMlbmnA==
Date: Thu, 6 Jun 2024 17:19:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nalramli@fastly.com, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "open
 list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>
Subject: Re: [RFC net-next v4 2/2] net/mlx5e: Add per queue netdev-genl
 stats
Message-ID: <20240606171942.4226a854@kernel.org>
In-Reply-To: <ZmIwIJ9rxllqQT18@LQ3V64L9R2>
References: <20240604004629.299699-1-jdamato@fastly.com>
	<20240604004629.299699-3-jdamato@fastly.com>
	<11b9c844-a56e-427f-aab3-3e223d41b165@gmail.com>
	<ZmIwIJ9rxllqQT18@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Jun 2024 14:54:40 -0700 Joe Damato wrote:
> > > Compare the values in /proc/net/dev match the output of cli for the same
> > > device, even while the device is down.
> > > 
> > > Note that while the device is down, per queue stats output nothing
> > > (because the device is down there are no queues):  
> > 
> > This part is not true anymore.  
> 
> It is true with this patch applied and running the command below.
> Maybe I should have been more explicit that using cli.py outputs []
> when scope = queue, which could be an internal cli.py thing, but
> this is definitely true with this patch.
> 
> Did you test it and get different results?

To avoid drivers having their own interpretations what "closed" means,
core hides all queues in closed state:

https://elixir.bootlin.com/linux/v6.10-rc1/source/net/core/netdev-genl.c#L582

> > PTP RQ index is naively assigned to zero:
> > rq->ix           = MLX5E_PTP_CHANNEL_IX;
> > 
> > but this isn't to be used as the stats index.
> > Today, the PTP-RQ has no matcing rxq in the kernel level.
> > i.e. turning PTP-RQ on won't add a kernel-level RXQ to the
> > real_num_rx_queues.
> > Maybe we better do.
> > If not, and the current state is kept, the best we can do is let the PTP-RQ
> > naively contribute its queue-stat to channel 0.  
> 
> OK, it sounds like the easiest thing to do is just count PTP as
> channel 0, so if i == 0, I'll in the PTP stats.
> 
> But please see below regarding testing whether or not PTP is
> actually enabled or not.

If we can I think we should avoid making queue 0 too special. 
If someone configures steering and only expects certain packets on
queue 0 - getting PTP counted there will be a surprise. 
I vote to always count it towards base.

