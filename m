Return-Path: <linux-rdma+bounces-4294-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C918E94DA4F
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Aug 2024 05:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1E24B21FF0
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Aug 2024 03:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B660B1311A7;
	Sat, 10 Aug 2024 03:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiqvyIhi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD6D1799F;
	Sat, 10 Aug 2024 03:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723260970; cv=none; b=uoFwuHEm29PU+twGWP0kqRQoXaFd7rcJRMpcbX7uXZhGFiz6mFPXh7H78iG67gc0y5bdlzMPjkknVm7qjaFp6fc+XdCnayZMb8J3yspf+fxL7P5qwlgMMon+BvVwTOgTtFVH8bqkTvwUFwQsuzNQeaBUHIE5eS7mhmXyvQEytOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723260970; c=relaxed/simple;
	bh=4W740LMxQSHpD+a8jut0olyJQpP8ghD1qCvb9gqE2+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azxFpbB1NCHgPc0LZaHLGB1PZw7KsH8WZ0VzfcX+g9dyMdq/TvNLNBmm2I4k5/0yhKNcE0K271odLKuERLQPzU8YyauZ+d+T6ALqO2ObtJ20j0JWJegZQUF54KVMG+JK5YOkJmPuJHYnQBmsfdixNUHoutl3ZF0lw0r8kGFKpZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiqvyIhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CE0C32782;
	Sat, 10 Aug 2024 03:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723260969;
	bh=4W740LMxQSHpD+a8jut0olyJQpP8ghD1qCvb9gqE2+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GiqvyIhi1kv5o/hv4hzAWewMCSQvtMxAZfqm8DgYQDjhMdvNKv4GJgxzF6BoD0psa
	 WpAxGTfAGzCkbyHkHgVMGVVx0lBHg6Fl/elaEcRAT0RI4PaHiPuIXQPsysm0ZWhYXw
	 RkIXSkAFUkjIfah+JG5OUYOvQEPlBMOj+8GCBGN6UiVDPzdj4kkjdKGnRE66SaT9JM
	 t9x7jTsCQbc6gfjTwZtGYEy3jrCj2P9lz+SFdgYlDAqIWAvic8ClhxI2xRh5hHPCtz
	 TtnLoEN5zew+WdSexRheOV2wfoIgE8x1G3LIG/x+Yn5HpS1cTSOOMy6J4egkfjy0Ab
	 kRqMUzsmiW7OQ==
Date: Fri, 9 Aug 2024 20:36:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Allen <allen.lkml@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 jes@trained-monkey.org, kda@linux-powerpc.org, cai.huoqing@linux.dev,
 dougmill@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, nnac123@linux.ibm.com,
 tlfalcon@linux.ibm.com, cooldavid@cooldavid.org, marcin.s.wojtas@gmail.com,
 mlindner@marvell.com, stephen@networkplumber.org, nbd@nbd.name,
 sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, lorenzo@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 borisp@nvidia.com, bryan.whitehead@microchip.com,
 UNGLinuxDriver@microchip.com, louis.peens@corigine.com,
 richardcochran@gmail.com, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acenic@sunsite.dk,
 linux-net-drivers@amd.com, netdev@vger.kernel.org, Sunil Goutham
 <sgoutham@marvell.com>
Subject: Re: [net-next v3 05/15] net: cavium/liquidio: Convert tasklet API
 to new bottom half workqueue mechanism
Message-ID: <20240809203606.69010c5b@kernel.org>
In-Reply-To: <CAOMdWSJF3L+bj-f5yz5BULTHR1rsCV-rr_MK0bobpKgRwuM9kA@mail.gmail.com>
References: <20240730183403.4176544-1-allen.lkml@gmail.com>
	<20240730183403.4176544-6-allen.lkml@gmail.com>
	<20240731190829.50da925d@kernel.org>
	<CAOMdWS+HJfjDpQX1yE+2O3nb1qAkQJC_GSiCjrrAJVrRB5r_rg@mail.gmail.com>
	<20240801175756.71753263@kernel.org>
	<CAOMdWSKRFXFdi4SF20LH528KcXtxD+OL=HzSh9Gzqy9HCqkUGw@mail.gmail.com>
	<20240805123946.015b383f@kernel.org>
	<CAOMdWS+=5OVmtez1NPjHTMbYy9br8ciRy8nmsnaFguTKJQiD9g@mail.gmail.com>
	<20240807073752.01bce1d2@kernel.org>
	<CAOMdWSJF3L+bj-f5yz5BULTHR1rsCV-rr_MK0bobpKgRwuM9kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Aug 2024 19:31:57 -0700 Allen wrote:
> > > In the context of of the driver, the conversion from tasklet_enable()
> > > to enable_and_queue_work() is correct because the callback function
> > > associated with the work item is designed to be safe even if there
> > > is no immediate work to process. The callback function can handle
> > > being invoked in such situations without causing errors or undesirable
> > > behavior. This makes the workqueue approach a suitable and safe
> > > replacement for the current tasklet mechanism, as it provides the
> > > necessary flexibility and ensures that the work item is properly
> > > scheduled and executed.  
> >
> > Fewer words, clearer indication that you read the code would be better
> > for the reviewer. Like actually call out what in the code makes it safe.
> >  
> Okay.
> > Just to be clear -- conversions to enable_and_queue_work() will require
> > manual inspection in every case.  
> 
> Attempting again.
> 
> The enable_and_queue_work() only schedules work if it is not already
> enabled, similar to how tasklet_enable() would only allow a tasklet to run
> if it had been previously scheduled.
> 
> In the current driver, where we are attempting conversion, enable_work()
> checks whether the work is already enabled and only enables it if it
> was disabled. If no new work is queued, queue_work() won't be called.
> Hence, the callback is safe even if there's no work.

Hm. Let me give you an example of what I was hoping to see for this
patch (in addition to your explanation of the API difference):

 The conversion for oct_priv->droq_bh_work should be safe. While
 the work is per adapter, the callback (octeon_droq_bh()) walks all
 queues, and for each queue checks whether the oct->io_qmask.oq mask
 has a bit set. In case of spurious scheduling of the work - none of
 the bits should be set, making the callback a noop.

