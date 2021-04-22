Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7E4368105
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 15:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbhDVNCB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 09:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236253AbhDVNB7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Apr 2021 09:01:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 371D460233;
        Thu, 22 Apr 2021 13:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619096485;
        bh=79JCQbztA7MgD3tZmbGV0afRdOBq5x1ZY+BzokfIB30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WcglOCEJvYlKgjmAt5FZ30D1F+ZVN0Q9KpZ2UqtOup6G9fqF9lIhRX6rlinK1+BKI
         EV3wqxozSbnxe7hRJuAEYDIhJmlfStqAsvXXIh8c/XnyyIgOfXw86tcxn9Z8Uh/Aea
         cQEsTWakWxOZ9YurqsoBUgx6K1A5qU9IKJu+XGNpuznm3Oky31m9Cf3NwT2M2NpP/n
         CbVIkO1Ccq+bgD10S5TRPy9NDwdZmarkaTE0hey2roOxYbZ38oSoD6YmhMxxH+2+P9
         KIKeDr5EpVlNuraIB/GMcWkNGCIgQnPIwmJSCrVc/wzTsQn5va2mfKutdxWc49FKkL
         o4WmoFR+Ju1Dw==
Date:   Thu, 22 Apr 2021 16:01:20 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shay Drory <shayd@nvidia.com>, Doug Ledford <dledford@redhat.com>,
        Krishna Kumar <krkumar2@in.ibm.com>,
        linux-rdma@vger.kernel.org, Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next 2/3] RDMA/core: Fix check of device in
 rdma_listen()
Message-ID: <YIFzoJOVvZPPJwwy@unreal>
References: <cover.1618753862.git.leonro@nvidia.com>
 <b925e11d639726afbaaeea5aeaa58572b3aacf8e.1618753862.git.leonro@nvidia.com>
 <20210422112802.GA2320845@nvidia.com>
 <1fca1133-8cdd-8b21-42cf-69d610b4f8f4@nvidia.com>
 <20210422125135.GV1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422125135.GV1370958@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 22, 2021 at 09:51:35AM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 22, 2021 at 03:44:55PM +0300, Shay Drory wrote:
> > On 4/22/2021 14:28, Jason Gunthorpe wrote:
> > 
> > > On Sun, Apr 18, 2021 at 04:55:53PM +0300, Leon Romanovsky wrote:
> > > > From: Shay Drory <shayd@nvidia.com>
> > > > 
> > > > rdma_listen() checks if device already attached to rdma_id_priv,
> > > > based on the response the its decide to what to listen, however
> > > > this is different when the listeners are canceled.
> > > > 
> > > > This leads to a mismatch between rdma_listen() and cma_cancel_operation(),
> > > > and causes to bellow wild-memory-access. Fix it by aligning rdma_listen()
> > > > according to the cma_cancel_operation().
> > > So this is happening because the error unwind in rdma_bind_addr() is
> > > taking the exit path and calling cma_release_dev()?
> > > 
> > > This allows rdma_listen() to be called with a bogus device pointer
> > > which precipitates this UAF during destroy.
> > > 
> > > However, I think rdma_bind_addr() should not allow the bogus device
> > > pointer to leak out at all, since the ULP could see it. It really is
> > > invalid to have it present no matter what.
> > > 
> > > This would make cma_release_dev() and _cma_attach_to_dev()
> > > symmetrical - what do you think?
> > > 
> > > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > > index 2dc302a83014ae..91f6d968b46f65 100644
> > > +++ b/drivers/infiniband/core/cma.c
> > > @@ -474,6 +474,7 @@ static void cma_release_dev(struct rdma_id_private *id_priv)
> > >   	list_del(&id_priv->list);
> > >   	cma_dev_put(id_priv->cma_dev);
> > >   	id_priv->cma_dev = NULL;
> > > +	id_priv->id.device = NULL;
> > >   	if (id_priv->id.route.addr.dev_addr.sgid_attr) {
> > >   		rdma_put_gid_attr(id_priv->id.route.addr.dev_addr.sgid_attr);
> > >   		id_priv->id.route.addr.dev_addr.sgid_attr = NULL;
> > 
> > I try that. this will break restrack_del() since restrack_del() is
> > using id_priv->id.device and is being called before restrack_del():
> 
> Oh that is another bug, once cma_release_dev() is called there is no
> refcount protecting the id.device and any access to it is invalid.
> 
> The order of rdma_restrack_del should be moved to be ahead of the
> cma_release_dev, and we also can't have a restrack without a cma_dev
> in the first place

We have restrack per-cmd_id and not per-cma_dev.

> 
> Jason
