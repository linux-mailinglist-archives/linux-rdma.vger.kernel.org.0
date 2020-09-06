Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E343225EE2B
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Sep 2020 16:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgIFO3i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Sep 2020 10:29:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728959AbgIFO3O (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 6 Sep 2020 10:29:14 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFFF320714;
        Sun,  6 Sep 2020 14:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599402513;
        bh=zBhBqVZd9ztz2ZxeGt4K7JKYxY7ZPe3xOvZcFzjPp4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wd1eSpvP/QcGWa+7eqB1F7kCSy4LSAV5yrdXE+3zcUlTcQt45d7jO8A6PBECCe3Tf
         wOT397N2pmW5NNJp2uRuFzpD+f5x03RFxXgkh2vJ4CeIUHmcHk0npTpEQUiQiNTU9U
         QNO6eDqf66fKfOB7cd7T0dsRARnynIilTxdlh1k4=
Date:   Sun, 6 Sep 2020 17:28:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 01/13] RDMA/cma: Delete from restrack DB
 after successful destroy
Message-ID: <20200906142829.GI55261@unreal>
References: <20200830101436.108487-1-leon@kernel.org>
 <20200830101436.108487-2-leon@kernel.org>
 <20200903142716.GA1550655@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903142716.GA1550655@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 03, 2020 at 11:27:16AM -0300, Jason Gunthorpe wrote:
> On Sun, Aug 30, 2020 at 01:14:24PM +0300, Leon Romanovsky wrote:
> > diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> > index 62fbb0ae9cb4..90fc74106620 100644
> > +++ b/drivers/infiniband/core/restrack.c
> > @@ -330,6 +330,9 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
> >  	rt = &dev->res[res->type];
> >
> >  	old = xa_erase(&rt->xa, res->id);
> > +	if (!old &&
> > +	    (res->type == RDMA_RESTRACK_MR || res->type == RDMA_RESTRACK_QP))
> > +		return;
> >  	WARN_ON(old != res);
> >  	res->valid = false;
>
> What is this for? It doesn't seem to have anything to do with the cm
> change.

Yes, it is a mix between two patches, will fix.

>
> Calling rdma_testrack_del() on a yet to be added ID should early exit
> from !valid right?

QP and MR are not converted yet to ib_core allocation, and they don't
have wait_for_completion() support yet, this is why we need to ball out
early.

>
> Jason
