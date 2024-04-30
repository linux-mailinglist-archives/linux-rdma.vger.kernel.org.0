Return-Path: <linux-rdma+bounces-2157-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F088E8B75C7
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 14:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7721F2300F
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 12:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB1117106D;
	Tue, 30 Apr 2024 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcrZ10J7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E7E38C;
	Tue, 30 Apr 2024 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714480399; cv=none; b=mfj4ZPe0MFHmoJVhmJp3BDTvU98vBL29e2TimK+VcgGPaOu7cmzQ0Ardoa015TxPYJMwdSAYhgb4y4BQebTceW0NAg8PSXomMeC8h5kld6V7/pC9e7ti0KeHdJ9Hyo096N/MmHkYZ7p5QogAfGt/bD3TNRomBptnKAm/KjVM83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714480399; c=relaxed/simple;
	bh=/LnjZchm5qf6ZsVqluE2uSwA/wQzWbCi7cL/XRfoVfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpe6GY88BPfEoHruY8wAg6Tg0f90DT4DeOysqkpuvxIxFARPFhxW4h3hZcwZH80tvuT/iAUzUHHKBLT49Vl2HrvEEmiZwSUqVNuEe73MR7iNiT0LXicIfTyj3PfXi2RhtbqZM/BILxnTgmgxQLW92pG8APt6ZLz+DDnrzQa0OVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcrZ10J7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F33C2BBFC;
	Tue, 30 Apr 2024 12:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714480399;
	bh=/LnjZchm5qf6ZsVqluE2uSwA/wQzWbCi7cL/XRfoVfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bcrZ10J7HZw1Ti6R6KrcCQovLk25aS7vWWFHkg6qT5bFvMbJpcrgxNGW1yreFttky
	 oT2lqPHSWiCraxSV9D7ehxQKSWcDAxusOKK9VJY1cTGnG42I9woJiDJVGiybY86oQ3
	 ZMXhxqZNCZGcQsW5oPB+vEkXa3+MXJvcLhvk2BHp/8F5zueIuA+MUOR0rQxNbcKPA4
	 NWZhC0p/Vko9J0y5CiUXFSj0HZEt0OqvQ7rYpPDq7SVR0k9AyFCNAknYogpy8kYXi/
	 ep88yWYPnthf1NSiljI4mrpTIbsG44E9jqp7xM/imSjeB7uZL2enjb2z3TtdHFJt/1
	 8ITiF7Ah5JNuA==
Date: Tue, 30 Apr 2024 15:33:14 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, tariqt@nvidia.com, saeedm@nvidia.com,
	mkarsten@uwaterloo.ca, gal@nvidia.com, nalramli@fastly.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] net/mlx4: support per-queue statistics via
 netlink
Message-ID: <20240430123314.GC100414@unreal>
References: <20240423194931.97013-1-jdamato@fastly.com>
 <20240423194931.97013-4-jdamato@fastly.com>
 <Zig5RZOkzhGITL7V@LQ3V64L9R2>
 <20240423175718.4ad4dc5a@kernel.org>
 <ZiieqiuqNiy_W0mr@LQ3V64L9R2>
 <20240424072818.2c68a1ab@kernel.org>
 <Zik1zCI9W9EUi13T@LQ3V64L9R2>
 <ZiqFUs-z5We2--5n@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiqFUs-z5We2--5n@LQ3V64L9R2>

On Thu, Apr 25, 2024 at 09:31:14AM -0700, Joe Damato wrote:
> On Wed, Apr 24, 2024 at 09:39:43AM -0700, Joe Damato wrote:
> > On Wed, Apr 24, 2024 at 07:28:18AM -0700, Jakub Kicinski wrote:
> > > On Tue, 23 Apr 2024 22:54:50 -0700 Joe Damato wrote:
> > > > On Tue, Apr 23, 2024 at 05:57:18PM -0700, Jakub Kicinski wrote:
> > > > > On Tue, 23 Apr 2024 12:42:13 -1000 Joe Damato wrote:  
> > > > > > I realized in this case, I'll need to set the fields initialized to 0xff
> > > > > > above to 0 before doing the increments below.  
> > > > > 
> > > > > I don't know mlx4 very well, but glancing at the code - are you sure we
> > > > > need to loop over the queues is the "base" callbacks?
> > > > > 
> > > > > The base callbacks are for getting "historical" data, i.e. info which
> > > > > was associated with queues which are no longer present. You seem to
> > > > > sweep all queues, so I'd have expected "base" to just set the values 
> > > > > to 0. And the real values to come from the per-queue callbacks.  
> > > > 
> > > > Hmm. Sorry I must have totally misunderstood what the purpose of "base"
> > > > was. I've just now more closely looked at bnxt which (maybe?) is the only
> > > > driver that implements base and I think maybe I kind of get it now.
> > > > 
> > > > For some reason, I thought it meant "the total stats of all queues"; I didn't
> > > > know it was intended to provide "historical" data as you say.
> > > > 
> > > > Making it set everything to 0 makes sense to me. I suppose I could also simply
> > > > omit it? What do you think?
> > > 
> > > The base is used to figure out which stats are reported when we dump 
> > > a summary for the whole device. So you gotta set them to 0.
> > 
> > OK, thanks for your patience and the explanation. Will do.
> > 
> > > > > The init to 0xff looks quite sus.  
> > > > 
> > > > Yes the init to 0xff is wrong, too. I noticed that, as well.
> > > > 
> > > > Here's what I have listed so far in my changelog for the v2 (which I haven't
> > > > sent yet), but perhaps the maintainers of mlx4 can weigh in?
> > > > 
> > > > v1 -> v2:
> > > >  - Patch 1/3 now initializes dropped to 0.
> > > >  - Patch 3/3 includes several changes:
> > > >    - mlx4_get_queue_stats_rx and mlx4_get_queue_stats_tx check if i is
> > > >      valid before proceeding.
> > > >    - All initialization to 0xff for stats fields has been omit. The
> > > >      network stack does this before calling into the driver functions, so
> > > >      I've adjusted the driver functions to only set values if there is
> > > >      data to set, leaving the network stack's 0xff in place if not.
> > > >    - mlx4_get_base_stats sets all stats to 0 (no locking etc needed).
> > > 
> > > All the ones you report right? Not just zero the struct.
> > > Any day now (tm) someone will add a lot more stats to the struct
> > > so the init should be selective only to the stats that are actually
> > > supported.
> > 
> > Yes, not just zero the struct. Since I am reporting bytes packets for both
> > RX and TX and alloc_fail for RX I'll be setting those fields to 0
> > explicitly.
> > 
> > And there's also a warning about unused qtype (oops) in patch 2/3.
> > 
> > So, the revised v2 list (pending anything Mellanox wants) is:
> > 
> >   v1 -> v2:
> >    - Patch 1/3 now initializes dropped to 0.
> >    - Patch 2/3 fix use of unitialized qtype warning.
> >    - Patch 3/3 includes several changes:
> >      - mlx4_get_queue_stats_rx and mlx4_get_queue_stats_tx check if i is
> >        valid before proceeding.
> >      - All initialization to 0xff for stats fields has been omit. The
> >        network stack does this before calling into the driver functions, so
> >        I've adjusted the driver functions to only set values if there is
> >        data to set, leaving the network stack's 0xff in place if not.
> >      - mlx4_get_base_stats set all stat fields to 0 individually (no locking etc needed).
> > 
> > I'll hold off on sending this v2 until we hear back from Mellanox to be
> > sure there isn't anything else I'm missing.
> 
> It's been a few days and I haven't heard back from the mlx4 folks, so I
> think I'll probably send my v2 later today which, hopefully, will fix most
> of the above issues.

MLNX folks were in long vacation in last two weeks.

Thanks

