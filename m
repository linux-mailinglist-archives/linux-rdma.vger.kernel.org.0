Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCC836A775
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Apr 2021 15:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhDYNSe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Apr 2021 09:18:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229688AbhDYNSe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 25 Apr 2021 09:18:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E3FA611B0;
        Sun, 25 Apr 2021 13:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619356674;
        bh=ciTcRFMYPpr0OfHkzC+c6c6tCIDsZtjXKOxCFuvLkXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d6ACd1m37G1nZfbe+ItDXVY2Hn4DmGWBLOamjC4eKIQWUhc59hM1jd0C69IoCZgRJ
         NVBtjFR9WoioXRSz/t5ZSMCASQtOscQutTjEzJBB7O2x5zW8g/ZDTtaRF9luno1dCB
         oQwBRHOpY/B5OzktRFNYnrpvtIYVN7vg6Pw3Rqk72TPJtQlHKhZGACGJsZEjtOhA53
         XPXWZQAmWwIhSDPw7U7iAM8uSux4dG2TYHNXnvZC2wbq4D6RmZ1sA6q6rTPip4g8iD
         9Z0xIlL5o9fydWUDEjg6yfu6qLCaAZSNi7ee+XNa5OF5iM5ucG8kqzNe9IMkCDvKiH
         Lvszl3rInQoGQ==
Date:   Sun, 25 Apr 2021 16:17:51 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shay Drory <shayd@nvidia.com>, Doug Ledford <dledford@redhat.com>,
        Krishna Kumar <krkumar2@in.ibm.com>,
        linux-rdma@vger.kernel.org, Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next 2/3] RDMA/core: Fix check of device in
 rdma_listen()
Message-ID: <YIVr/2RrE6WTLbiV@unreal>
References: <cover.1618753862.git.leonro@nvidia.com>
 <b925e11d639726afbaaeea5aeaa58572b3aacf8e.1618753862.git.leonro@nvidia.com>
 <20210422112802.GA2320845@nvidia.com>
 <1fca1133-8cdd-8b21-42cf-69d610b4f8f4@nvidia.com>
 <20210422125135.GV1370958@nvidia.com>
 <YIFzoJOVvZPPJwwy@unreal>
 <20210422130218.GW1370958@nvidia.com>
 <YIGPCjiXAR2aFO9S@unreal>
 <20210422161809.GZ1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422161809.GZ1370958@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 22, 2021 at 01:18:09PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 22, 2021 at 05:58:18PM +0300, Leon Romanovsky wrote:
> > On Thu, Apr 22, 2021 at 10:02:18AM -0300, Jason Gunthorpe wrote:
> > > On Thu, Apr 22, 2021 at 04:01:20PM +0300, Leon Romanovsky wrote:
> > > > On Thu, Apr 22, 2021 at 09:51:35AM -0300, Jason Gunthorpe wrote:
> > > > > On Thu, Apr 22, 2021 at 03:44:55PM +0300, Shay Drory wrote:
> > > > > > On 4/22/2021 14:28, Jason Gunthorpe wrote:
> > > > > > 
> > > > > > > On Sun, Apr 18, 2021 at 04:55:53PM +0300, Leon Romanovsky wrote:
> > > > > > > > From: Shay Drory <shayd@nvidia.com>
> > > > > > > > 
> > > > > > > > rdma_listen() checks if device already attached to rdma_id_priv,
> > > > > > > > based on the response the its decide to what to listen, however
> > > > > > > > this is different when the listeners are canceled.
> > > > > > > > 
> > > > > > > > This leads to a mismatch between rdma_listen() and cma_cancel_operation(),
> > > > > > > > and causes to bellow wild-memory-access. Fix it by aligning rdma_listen()
> > > > > > > > according to the cma_cancel_operation().
> > > > > > > So this is happening because the error unwind in rdma_bind_addr() is
> > > > > > > taking the exit path and calling cma_release_dev()?
> > > > > > > 
> > > > > > > This allows rdma_listen() to be called with a bogus device pointer
> > > > > > > which precipitates this UAF during destroy.
> > > > > > > 
> > > > > > > However, I think rdma_bind_addr() should not allow the bogus device
> > > > > > > pointer to leak out at all, since the ULP could see it. It really is
> > > > > > > invalid to have it present no matter what.
> > > > > > > 
> > > > > > > This would make cma_release_dev() and _cma_attach_to_dev()
> > > > > > > symmetrical - what do you think?
> > > > > > > 
> > > > > > > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > > > > > > index 2dc302a83014ae..91f6d968b46f65 100644
> > > > > > > +++ b/drivers/infiniband/core/cma.c
> > > > > > > @@ -474,6 +474,7 @@ static void cma_release_dev(struct rdma_id_private *id_priv)
> > > > > > >   	list_del(&id_priv->list);
> > > > > > >   	cma_dev_put(id_priv->cma_dev);
> > > > > > >   	id_priv->cma_dev = NULL;
> > > > > > > +	id_priv->id.device = NULL;
> > > > > > >   	if (id_priv->id.route.addr.dev_addr.sgid_attr) {
> > > > > > >   		rdma_put_gid_attr(id_priv->id.route.addr.dev_addr.sgid_attr);
> > > > > > >   		id_priv->id.route.addr.dev_addr.sgid_attr = NULL;
> > > > > > 
> > > > > > I try that. this will break restrack_del() since restrack_del() is
> > > > > > using id_priv->id.device and is being called before restrack_del():
> > > > > 
> > > > > Oh that is another bug, once cma_release_dev() is called there is no
> > > > > refcount protecting the id.device and any access to it is invalid.
> > > > > 
> > > > > The order of rdma_restrack_del should be moved to be ahead of the
> > > > > cma_release_dev, and we also can't have a restrack without a cma_dev
> > > > > in the first place
> > > > 
> > > > We have restrack per-cmd_id and not per-cma_dev.
> > > 
> > > No, restrack has this:
> > > 
> > > 	dev = res_to_dev(res);
> > > 	if (WARN_ON(!dev))
> > > 
> > > And here dev will be NULL if cma_dev isn't set
> > 
> >   127 static struct ib_device *res_to_dev(struct rdma_restrack_entry *res)
> >   128 {
> > 
> > <...>
> > 
> >   136         case RDMA_RESTRACK_CM_ID:
> >   137                 return container_of(res, struct rdma_id_private,
> >   138                                     res)->id.device;
> >                                                 ^^^^^ it is not cma_dev
> 
> The invariant is that 
> 
>    priv.id.device == priv.cma_dev->device
> 
> (this de-normalization of data exists only to allow priv to be in a
> private header)
> 
> If cma_dev == NULL then id.device == NULL as cma_Dev was the thing
> preventing the pointer from being free'd.

Let's see what I can do here.

Thanks

> 
> Jason
