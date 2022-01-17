Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E544B49108E
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jan 2022 20:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241842AbiAQTGd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jan 2022 14:06:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51768 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbiAQTGc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jan 2022 14:06:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1F47B811C1;
        Mon, 17 Jan 2022 19:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C299C36AE3;
        Mon, 17 Jan 2022 19:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642446390;
        bh=jPsm71XEp6TrnU8p92pXK9/eIp0Z/kNU0eB8BEV/BIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kpw2AnTDynkkCJcW+N0T96YbwIFbkvZkRh02dpMteTjTscXm3xZUGSfEcG5YgYEUf
         BkMzH7V1Ntr2XZAujbnKsEMNjoUNFA4ky+k1hxvSLDrZq1JpC0y4NxL81sHALtBNUj
         KhTE/8lIYptwGIMttqIJO/stxCuAX+IiaWBs7XgLom/KmcJcrQ8+abFhTyGpTgxanY
         Kh3EjiAOM4oWK/nv7uFbky0Zi/+/pqJURVM/CxneLh+3MmW6LUdDPoVa+e5UbneWuC
         6N/xoFcbelKlZ5PhlfJQuB3jz4cVqTjDkWyQ1hUkpBoTnXgj6uGgGUtCrW3d9S5m54
         EO0Zv+tn6/brA==
Date:   Mon, 17 Jan 2022 21:06:18 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-rc] RDMA/cma: Clear all multicast request fields
Message-ID: <YeW+KoN8zrpWw22d@unreal>
References: <1876bacbbcb6f82af3948e5c37a09da6ea3fcae5.1641474841.git.leonro@nvidia.com>
 <20220106173941.GA2963550@nvidia.com>
 <YdrTbNDTg7VdR2iu@unreal>
 <20220110153619.GC2328285@nvidia.com>
 <Ydx1dDSa1JDJGFdJ@unreal>
 <20220117161621.GC84788@nvidia.com>
 <YeWzeA/8TgXalrD8@unreal>
 <20220117183832.GD84788@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117183832.GD84788@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 17, 2022 at 02:38:32PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 17, 2022 at 08:20:40PM +0200, Leon Romanovsky wrote:
> > On Mon, Jan 17, 2022 at 12:16:21PM -0400, Jason Gunthorpe wrote:
> > > On Mon, Jan 10, 2022 at 08:05:40PM +0200, Leon Romanovsky wrote:
> > > 
> > > > > We should probably check the PS even earlier to prevent the IB side
> > > > > from having the same issue.
> > > > 
> > > > What do you think about this?
> > > 
> > > IB is a bit different, it has a bunch of PS's that are UD compatible..
> > > 
> > > Probably what we really want here is to check/restrict the CM ID to
> > > SIDR mode, which does have the qkey and is the only mode that makes
> > > sense to be mixed with multicast, and then forget about port space
> > > entirely.
> > > 
> > > It may be that port space indirectly restricts the CM ID to SIDR mode,
> > > but the language here should be 'is in sidr mode', not some confusing
> > > open coded port space check.
> > > 
> > > I'm also not sure of the lifecycle of the qkey, qkeys only exist in
> > > SIDR mode so obviously anything that sets/gets a qkey should be
> > > restriced to SIDR CM IDs..
> > > 
> > > > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > > > index 835ac54d4a24..0a1f008ca929 100644
> > > > +++ b/drivers/infiniband/core/cma.c
> > > > @@ -4669,12 +4669,8 @@ static int cma_join_ib_multicast(struct rdma_id_private *id_priv,
> > > >         if (ret)
> > > >                 return ret;
> > > > 
> > > > -       ret = cma_set_qkey(id_priv, 0);
> > > > -       if (ret)
> > > > -               return ret;
> > > > -
> > > >         cma_set_mgid(id_priv, (struct sockaddr *) &mc->addr, &rec.mgid);
> > > > -       rec.qkey = cpu_to_be32(id_priv->qkey);
> > > > +       rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
> > > 
> > > And I'm not sure this makes sense? The UD qkey should still be
> > > negotiated right?
> > 
> > Yes, I think so, it will be changed in SIDR phase.
> > 
> > The original code has "cma_set_qkey(id_priv, 0)" call, that in IB case will
> > execute this switch anyway:
> >    515         switch (id_priv->id.ps) {
> >    516         case RDMA_PS_UDP:
> >    517         case RDMA_PS_IB:
> >    518                 id_priv->qkey = RDMA_UDP_QKEY;
> > 
> > The difference is that we won't store RDMA_UDP_QKEY in id_priv->qkey,
> > but I'm unsure that this is right.
> 
> Well the whoele cma_set_qkey() function appears to be complete
> jumblied nonsense as if qkey is zero then it doesn't do anything if
> the qkey was already set.
> 
> When called with 0 it is really some sort of 'make a default qkey if
> the user hasn't set one already' and in that case defaulting to
> RDMA_UDP_QKEY does makes some kind of sense.
> 
> The functions purposes should be split into two functions really.
> 
> So, we end up with 'make sure the cm id is in SDIR mode' then 'if the
> qkey is not set, set it to a default', so that the net result is the
> qkey is always set once the function returns.
> 
> Though, I'm not sure what the semantics are for qkey during SIDR
> negotiation, that should be checked in the spec.

There is no negotiation. Device simply sends its qkey to another side
and expects to get this qkey in every packet.

---------------------------------
Queue Key (Q_Key): Enforces access rights for reliable and unreliable
datagram service (RAW datagram service type not included). Administered
by the channel adapter. During communication establishment for datagram
service, nodes exchange Q_Keys for particular queue pairs and a node uses
the value it was passed for a remote QP in all packets it sends to that
remote QP. Likewise, the remote node uses the Q_Key it was provided.
Receipt of a packet with a different Q_Key than the one the node provided
to the remote queue pair means that packet is not valid and thus rejected.
-----------------------------------

Thanks

> 
> Jason
