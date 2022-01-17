Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5F4491031
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jan 2022 19:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbiAQSUx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jan 2022 13:20:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45694 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiAQSUs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jan 2022 13:20:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A297060F93;
        Mon, 17 Jan 2022 18:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0A7C36AE7;
        Mon, 17 Jan 2022 18:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642443646;
        bh=fFtq/Zv2zqsZGJQryCmgrP6oBAx9jF38A8pLzZjLoOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lSFGVmfCZTKAXZMN10+INLBNdQYNxNzF/PteQVaosV9TUM1Q6PqGwdp8N+yie6j5T
         CrZIiSkBiMWIkebX+3/NqoKRIinbOJWEOqevd5tq0/ZhyrxkJNFxcAIIUNnn4puNW6
         xz087OcybIm8sgjvnjM0iabYnXE1er6jm3R9um8Z91dCWtIW9ngOJYhXhDUQhx2Mrc
         9BGRDklnnI/YOvYBbzEQ7xGOFNpb3dOGKbD/t7QnnK8cg9P3HuKZaUiflzqzH4qUFT
         PnqFmfRGwCdC2cm1xKccdf2Ro+NSODE3TMytQlXWDPxhJO6WDc75eQn2un466c/05A
         c3aD1A0SNymwg==
Date:   Mon, 17 Jan 2022 20:20:40 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-rc] RDMA/cma: Clear all multicast request fields
Message-ID: <YeWzeA/8TgXalrD8@unreal>
References: <1876bacbbcb6f82af3948e5c37a09da6ea3fcae5.1641474841.git.leonro@nvidia.com>
 <20220106173941.GA2963550@nvidia.com>
 <YdrTbNDTg7VdR2iu@unreal>
 <20220110153619.GC2328285@nvidia.com>
 <Ydx1dDSa1JDJGFdJ@unreal>
 <20220117161621.GC84788@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117161621.GC84788@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 17, 2022 at 12:16:21PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 10, 2022 at 08:05:40PM +0200, Leon Romanovsky wrote:
> 
> > > We should probably check the PS even earlier to prevent the IB side
> > > from having the same issue.
> > 
> > What do you think about this?
> 
> IB is a bit different, it has a bunch of PS's that are UD compatible..
> 
> Probably what we really want here is to check/restrict the CM ID to
> SIDR mode, which does have the qkey and is the only mode that makes
> sense to be mixed with multicast, and then forget about port space
> entirely.
> 
> It may be that port space indirectly restricts the CM ID to SIDR mode,
> but the language here should be 'is in sidr mode', not some confusing
> open coded port space check.
> 
> I'm also not sure of the lifecycle of the qkey, qkeys only exist in
> SIDR mode so obviously anything that sets/gets a qkey should be
> restriced to SIDR CM IDs..
> 
> > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > index 835ac54d4a24..0a1f008ca929 100644
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -4669,12 +4669,8 @@ static int cma_join_ib_multicast(struct rdma_id_private *id_priv,
> >         if (ret)
> >                 return ret;
> > 
> > -       ret = cma_set_qkey(id_priv, 0);
> > -       if (ret)
> > -               return ret;
> > -
> >         cma_set_mgid(id_priv, (struct sockaddr *) &mc->addr, &rec.mgid);
> > -       rec.qkey = cpu_to_be32(id_priv->qkey);
> > +       rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
> 
> And I'm not sure this makes sense? The UD qkey should still be
> negotiated right?

Yes, I think so, it will be changed in SIDR phase.

The original code has "cma_set_qkey(id_priv, 0)" call, that in IB case will
execute this switch anyway:
   515         switch (id_priv->id.ps) {
   516         case RDMA_PS_UDP:
   517         case RDMA_PS_IB:
   518                 id_priv->qkey = RDMA_UDP_QKEY;

The difference is that we won't store RDMA_UDP_QKEY in id_priv->qkey,
but I'm unsure that this is right.

Thanks

> 
> Jason
