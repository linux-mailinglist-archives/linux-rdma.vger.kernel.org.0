Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A83624ACA
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Nov 2022 20:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiKJTj6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Nov 2022 14:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKJTj5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Nov 2022 14:39:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AB645EF5
        for <linux-rdma@vger.kernel.org>; Thu, 10 Nov 2022 11:39:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B21A61E32
        for <linux-rdma@vger.kernel.org>; Thu, 10 Nov 2022 19:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486E5C433D6;
        Thu, 10 Nov 2022 19:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668109195;
        bh=4kXX/FnCJjyTA4RZvJI0vzOBXiqLIm5r9XYzb+xtzok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=roYUHd9Uw662AwfD9zNGJx/+c4mLhrtu8/XVb7KE5JhqHxkIfI1xKQm2Y4rzppBV6
         Rwr7RIUrZ6xULcsRjVNia05AXkO9moQkQmjfNtxcmnYWIPDL4D8r4mB2frSz2ywnoc
         GzAeD3D4yBFbJI6SadSqhN8BKW4JGxMaCTlrzxXOsS9g2aMMFnGNTU1QJ4S85slFqA
         jzRINVxUalQMoNYdEPUzOkBfFpbBYTQ6XYuFIzX4CpPmo+IDkieq09uAm7XX6KoE1N
         cOWrTruvGeopppnOJDswGihhtp7iEtjExHrzydumDofeLY8RUYo7t9bJ2zOgF5UPT+
         D96al3sIzDIZQ==
Date:   Thu, 10 Nov 2022 21:39:51 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Or Har-Toov <ohartoov@nvidia.com>
Subject: Re: [PATCH rdma-next 2/4] RDMA/restrack: Release MR restrack when
 delete
Message-ID: <Y21Th3bG8gaARGuZ@unreal>
References: <cover.1667810736.git.leonro@nvidia.com>
 <703db18e8d4ef628691fb93980a709be673e62e3.1667810736.git.leonro@nvidia.com>
 <Y2v6sTD8docw5bjK@nvidia.com>
 <Y2zF6c5gs8KObRK0@unreal>
 <Y21RJc2NIiUZw7A5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y21RJc2NIiUZw7A5@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 10, 2022 at 03:29:41PM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 10, 2022 at 11:35:37AM +0200, Leon Romanovsky wrote:
> > On Wed, Nov 09, 2022 at 03:08:33PM -0400, Jason Gunthorpe wrote:
> > > On Mon, Nov 07, 2022 at 10:51:34AM +0200, Leon Romanovsky wrote:
> > > > From: Mark Zhang <markzhang@nvidia.com>
> > > > 
> > > > The MR restrack also needs to be released when delete it, otherwise it
> > > > cause memory leak as the task struct won't be released.
> > > > 
> > > > Fixes: 13ef5539def7 ("RDMA/restrack: Count references to the verbs objects")
> > > > Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> > > > Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > ---
> > > >  drivers/infiniband/core/restrack.c | 2 --
> > > >  1 file changed, 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> > > > index 1f935d9f6178..01a499a8b88d 100644
> > > > --- a/drivers/infiniband/core/restrack.c
> > > > +++ b/drivers/infiniband/core/restrack.c
> > > > @@ -343,8 +343,6 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
> > > >  	rt = &dev->res[res->type];
> > > >  
> > > >  	old = xa_erase(&rt->xa, res->id);
> > > > -	if (res->type == RDMA_RESTRACK_MR)
> > > > -		return;
> > > 
> > > This needs more explanation, there was some good reason we needed to
> > > avoid the wait_for_completion() for the driver allocated objects, but I
> > > can't remember it anymore.
> > > 
> > > You added this code in the v2 of the original series, maybe it had
> > > something to do with mlx4?
> > 
> > I failed to remember either, but if you want even more magic in your life,
> > see this hilarious thread:
> > https://lore.kernel.org/linux-rdma/9ba5a611ceac86774d3d0fda12704cecc30606f9.1618753038.git.leonro@nvidia.com/
> 
> Oh, that clears it up
> 
> The issue is that dereg can fail for MR:
> 
> 	rdma_restrack_del(&mr->res);
> 	ret = mr->device->ops.dereg_mr(mr, udata);
> 	if (!ret) {
> 		atomic_dec(&pd->usecnt);
> 
> Because the driver management of the object puts it in the wrong
> order.
> 
> The above if is necessary because if we trigger this failure path
> without it, then the next attempt to free the MR will trigger a
> WARN_ON.

Not really, after first entry to rdma_restrack_del(), we will set
res->valid to false. Any subsequent calls to rdma_restrack_del() will
do nothing.

  322 void rdma_restrack_del(struct rdma_restrack_entry *res)
  323 {
  324         struct rdma_restrack_entry *old;
  325         struct rdma_restrack_root *rt;
  326         struct ib_device *dev;
  327
  328         if (!res->valid) {
  329                 if (res->task) {
  330                         put_task_struct(res->task);
  331                         res->task = NULL;
  332                 }
  333                 return; <------- exit
  334         }

Thanks
