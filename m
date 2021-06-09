Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9973A15F2
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 15:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhFINsr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 09:48:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234871AbhFINsq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Jun 2021 09:48:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6415D6101A;
        Wed,  9 Jun 2021 13:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623246412;
        bh=xD/1TmkpuvLLNeQSyT+xrYmhzbmmp8EZunTSTraD624=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VQ5bWqd2AhEAvS5O5f6v+2UpTgYa4i6hTCizWIZj2Bs6eWl+PrAeJjMZv5AC7CjPO
         o/1B9sVMNizP0O9zFdsDcuzCmWYbMh0Cse3giBNOE81wOA8iz78img1f1OUIOd0Plr
         PpSK17ecyHWCl09buia6iR1mja/4PAOV+JRP8FJmI2Rlty8kO9BsSF6PaHPFWReBi9
         8yjQ6RjhI75O5v2Ebp0hNSe63gwvb27nh6BpwJESpuPsfas58b9oMNoKTXfiRWm0Dx
         y+dTY8gyGIMyVAexPRaGLCEC8OT28XrAkIvTGlWf2Hyni4WvTRX/QDxanVRBxiuTIS
         gGGt6uXHpAmqg==
Date:   Wed, 9 Jun 2021 16:46:48 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Bloch <markb@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA: Verify port when creating flow rule
Message-ID: <YMDGSOkAXsqJCepn@unreal>
References: <07ddc8516a0e53e54e3cf5cbbff19cac6cda3d82.1623129061.git.leonro@nvidia.com>
 <20210608200935.GA992630@nvidia.com>
 <YMCeGiLRG9aTIC2O@unreal>
 <20210609114720.GW1002214@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609114720.GW1002214@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 09, 2021 at 08:47:20AM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 09, 2021 at 01:55:22PM +0300, Leon Romanovsky wrote:
> > On Tue, Jun 08, 2021 at 05:09:35PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jun 08, 2021 at 08:12:24AM +0300, Leon Romanovsky wrote:
> > > > @@ -3198,6 +3199,13 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
> > > >  	if (err)
> > > >  		return err;
> > > >  
> > > > +	ucontext = ib_uverbs_get_ucontext(attrs);
> > > > +	if (IS_ERR(ucontext))
> > > > +		return PTR_ERR(ucontext);
> > > 
> > > ib_uverbs_get_ucontext() should only be used by methods that don't
> > > have a uboject, this one does so it should be using uobj->context
> > > instead
> > 
> > Why "should"?
> > At the end, we will get same ucontext.
> 
> The locking methodologies are different, they are not guarenteed to be
> exactly the same, but once the uobj is obtained then the related
> ucontext is fixed.
> 
> > > It looks like this can be moved down to after the uobject is allocated
> > 
> > The idea is to fail early, before first kmalloc and uobj_alloc, so we won't need
> > to do any error unwinding.
> 
> The error handling is needed anyhow..

Thanks, I'll change.

> 
> Jason
