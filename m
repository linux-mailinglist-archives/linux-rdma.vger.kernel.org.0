Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46528237C4
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 15:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbfETNKG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 09:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730513AbfETNKF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 09:10:05 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A0E320815;
        Mon, 20 May 2019 13:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558357804;
        bh=k9eD2TZypAsxqDp8hA8ZH/WXIVSpfYoE/373ktyUG8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nb3eIgecB1/2qZ9IXyCx/OdcYDJM6jfKFJI8Qk0c4h5doHtNwrapEzV4EzhEY4ksZ
         5GYzeGsGG5ez2AcV1Jbsv6WippU09qhMnAQmZ/98jNQTfulIDfDa9MIhJUuJtcyP95
         4095pEJM/ufibq/jX4+6MMn2+yG7gPG7Vos5DF3U=
Date:   Mon, 20 May 2019 16:10:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH rdma-next 04/15] RDMA/efa: Remove check that prevents
 destroy of resources in error flows
Message-ID: <20190520131000.GJ4573@mtr-leonro.mtl.com>
References: <20190520065433.8734-1-leon@kernel.org>
 <20190520065433.8734-5-leon@kernel.org>
 <a3358e40-9be4-0a7c-dab5-96573b646ded@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3358e40-9be4-0a7c-dab5-96573b646ded@amazon.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 20, 2019 at 03:39:26PM +0300, Gal Pressman wrote:
> On 20/05/2019 9:54, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > There are two possible execution contexts of destroy flows in EFA.
> > One is normal flow where user explicitly asked for object release
> > and another error unwinding.
> >
> > In normal scenario, RDMA/core will ensure that udata is supplied
> > according to KABI contract, for now it means no udata at all.
> >
> > In unwind flow, the EFA driver will receive uncleared udata from
> > numerous *_create_*() calls, but won't release those resources
> > due to extra checks.
>
> Thanks for the fix Leon, a few questions:
>
> Some of the unwind flows pass NULL udata and others an uncleared udata (is it
> really uncleared or is it actually the create udata?), what are we considering
> as the expected behavior? Isn't passing an uncleared udata the bug here?

It is a matter of unwind sequence, if IB/core did something after
driver created some object, it will need to call to destroy of this
object too. So I don't think that it is the bug.

And yes, it is not applicable for all flows, the one which caused me to
write this patch is failure in ib_uverbs_reg_mr(), which will call to
ib_dereg_mr_user(mr, &attrs->driver_udata);

and attrs->driver_udata is valid there.

>
> Also, if passing NULL udata is expected (why?) we have a bigger problem here as
> existing code will cause NULL dereference.

Not anymore, the destroy paths are not relying on udata now.

>
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  drivers/infiniband/hw/efa/efa_verbs.c | 24 ------------------------
> >  1 file changed, 24 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> > index 6d6886c9009f..4999a74cee24 100644
> > --- a/drivers/infiniband/hw/efa/efa_verbs.c
> > +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> > @@ -436,12 +436,6 @@ void efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
> >  	struct efa_dev *dev = to_edev(ibpd->device);
> >  	struct efa_pd *pd = to_epd(ibpd);
> >
> > -	if (udata->inlen &&
> > -	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
> > -		ibdev_dbg(&dev->ibdev, "Incompatible ABI params\n");
> > -		return;
> > -	}
> > -
> >  	ibdev_dbg(&dev->ibdev, "Dealloc pd[%d]\n", pd->pdn);
> >  	efa_pd_dealloc(dev, pd->pdn);
> >  }
> > @@ -459,12 +453,6 @@ int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
> >  	struct efa_qp *qp = to_eqp(ibqp);
> >  	int err;
> >
> > -	if (udata->inlen &&
> > -	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
> > -		ibdev_dbg(&dev->ibdev, "Incompatible ABI params\n");
> > -		return -EINVAL;
> > -	}
> > -
> >  	ibdev_dbg(&dev->ibdev, "Destroy qp[%u]\n", ibqp->qp_num);
> >  	err = efa_destroy_qp_handle(dev, qp->qp_handle);
> >  	if (err)
> > @@ -865,12 +853,6 @@ int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
> >  	struct efa_cq *cq = to_ecq(ibcq);
> >  	int err;
> >
> > -	if (udata->inlen &&
> > -	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
> > -		ibdev_dbg(&dev->ibdev, "Incompatible ABI params\n");
> > -		return -EINVAL;
> > -	}
> > -
> >  	ibdev_dbg(&dev->ibdev,
> >  		  "Destroy cq[%d] virt[0x%p] freed: size[%lu], dma[%pad]\n",
> >  		  cq->cq_idx, cq->cpu_addr, cq->size, &cq->dma_addr);
> > @@ -1556,12 +1538,6 @@ int efa_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
> >  	struct efa_mr *mr = to_emr(ibmr);
> >  	int err;
> >
> > -	if (udata->inlen &&
> > -	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
> > -		ibdev_dbg(&dev->ibdev, "Incompatible ABI params\n");
> > -		return -EINVAL;
> > -	}
> > -
> >  	ibdev_dbg(&dev->ibdev, "Deregister mr[%d]\n", ibmr->lkey);
> >
> >  	if (mr->umem) {
> > --
> > 2.20.1
> >
