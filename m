Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC29E2F842
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 10:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfE3IHX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 04:07:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbfE3IHX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 May 2019 04:07:23 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC2D72576C;
        Thu, 30 May 2019 07:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559203023;
        bh=3oO9IK4BW4WkZQcVQ9zFS77wPWeEJtHyqDTNuwB1wMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QI1Yu+bXzyum5pg3oCM7R4EUtyisnieSvcGTPQmlRLL9GF0gTk4ysbLsof9RY99lP
         XbxL2x1/4SKu+m6Ebut1wbh8QJ+dXzCxJS8gIojGuAChyomEVes+MsmpXKCUsYQ6Se
         XXmLa+haKR72F3VykkCDOFFLtyFjNvJ3Ja5RfwhA=
Date:   Thu, 30 May 2019 10:56:59 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH rdma-next 09/15] RDMA: Clean destroy CQ in drivers do not
 return errors
Message-ID: <20190530075659.GC6251@mtr-leonro.mtl.com>
References: <20190520065433.8734-1-leon@kernel.org>
 <20190520065433.8734-10-leon@kernel.org>
 <9DD61F30A802C4429A01CA4200E302A7A5B07E14@fmsmsx124.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7A5B07E14@fmsmsx124.amr.corp.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 29, 2019 at 07:39:45PM +0000, Saleem, Shiraz wrote:
> > Subject: [PATCH rdma-next 09/15] RDMA: Clean destroy CQ in drivers do not
> > return errors
> >
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Like all other destroy commands, .destroy_cq() call is not supposed to fail. In all
> > flows, the attempt to return earlier caused to memory leaks.
> >
> > This patch converts .destroy_cq() to do not return any errors.
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  drivers/infiniband/core/cq.c                  |  5 +-
> >  drivers/infiniband/core/verbs.c               |  3 +-
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 13 ++---
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.h      |  2 +-
> >  drivers/infiniband/hw/cxgb3/cxio_hal.c        |  6 +--
> >  drivers/infiniband/hw/cxgb3/cxio_hal.h        |  2 +-
> >  drivers/infiniband/hw/cxgb3/iwch_provider.c   |  8 +---
> >  drivers/infiniband/hw/cxgb4/cq.c              | 13 ++---
> >  drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |  2 +-
> >  drivers/infiniband/hw/efa/efa.h               |  2 +-
> >  drivers/infiniband/hw/efa/efa_verbs.c         |  9 +---
> >  drivers/infiniband/hw/hns/hns_roce_cq.c       | 48 +++++++++----------
> >  drivers/infiniband/hw/hns/hns_roce_device.h   |  4 +-
> >  drivers/infiniband/hw/hns/hns_roce_hw_v1.c    | 14 ++----
> >  drivers/infiniband/hw/i40iw/i40iw_verbs.c     |  3 +-
> >  drivers/infiniband/hw/mlx4/cq.c               |  4 +-
> >  drivers/infiniband/hw/mlx4/mlx4_ib.h          |  2 +-
> >  drivers/infiniband/hw/mlx5/cq.c               |  4 +-
> >  drivers/infiniband/hw/mlx5/mlx5_ib.h          |  2 +-
> >  drivers/infiniband/hw/mthca/mthca_provider.c  |  4 +-
> >  drivers/infiniband/hw/nes/nes_utils.c         |  4 +-
> >  drivers/infiniband/hw/nes/nes_verbs.c         | 30 ++++--------
> >  drivers/infiniband/hw/ocrdma/ocrdma_hw.c      |  8 ++--
> >  drivers/infiniband/hw/ocrdma/ocrdma_hw.h      |  2 +-
> >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  6 +--
> >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |  2 +-
> >  drivers/infiniband/hw/qedr/verbs.c            | 20 +-------
> >  drivers/infiniband/hw/qedr/verbs.h            |  2 +-
> >  drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |  4 +-
> > drivers/infiniband/hw/usnic/usnic_ib_verbs.h  |  2 +-
> > drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  |  6 +--
> >  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  2 +-
> >  drivers/infiniband/sw/rdmavt/cq.c             |  6 +--
> >  drivers/infiniband/sw/rdmavt/cq.h             |  2 +-
> >  drivers/infiniband/sw/rxe/rxe_verbs.c         |  3 +-
> >  include/rdma/ib_verbs.h                       |  2 +-
> >  36 files changed, 82 insertions(+), 169 deletions(-)
> >
> [...]
>
> > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > index 2c3685faa57a..a3c65e45a2bc 100644
> > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > @@ -2517,9 +2517,8 @@ int bnxt_re_post_recv(struct ib_qp *ib_qp, const struct
> > ib_recv_wr *wr,  }
> >
> >  /* Completion Queues */
> > -int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
> > +void bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
> >  {
> > -	int rc;
> >  	struct bnxt_re_cq *cq;
> >  	struct bnxt_qplib_nq *nq;
> >  	struct bnxt_re_dev *rdev;
> > @@ -2528,20 +2527,14 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct
> > ib_udata *udata)
> >  	rdev = cq->rdev;
> >  	nq = cq->qplib_cq.nq;
> >
> > -	rc = bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
> > -	if (rc) {
> > -		dev_err(rdev_to_dev(rdev), "Failed to destroy HW CQ");
> > -		return rc;
> > -	}
> > -	if (!IS_ERR_OR_NULL(cq->umem))
>
> Are we losing any useful debug data here? Is there a device error print to track the adminQ cmd failure?
> Same applies to other call sites where your removing prints.

In case of failure, we will see debug errors from bnxt_qplib_rcfw_send_message().
In addition, even before this patch, there is one place of bnxt_qplib_destroy_cq()
without checks of return value.

>
> Sorry if this is a naïve question but can we now run into a situation where the adminQ cmd failed for some reason
> (maybe FW didn't even issue it to HW), and the HW continues to write to the CQ which you have just freed in core?
> This is not to say leaking kernel memory is correct...but are we risking corruption?

It is not different from any other places, there is no silver bullet
proof against broken HW.

>
> > +	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
> > +	if (!cq->umem)
> >  		ib_umem_release(cq->umem);
> >
> >  	atomic_dec(&rdev->cq_count);
> >  	nq->budget--;
> >  	kfree(cq->cql);
> >  	kfree(cq);
> > -
> > -	return 0;
> >  }
> >
>
> [...]
>
> > a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
> > index 3d7bde19838e..d2a230d6c0e7 100644
> > --- a/drivers/infiniband/hw/qedr/verbs.c
> > +++ b/drivers/infiniband/hw/qedr/verbs.c
> > @@ -962,14 +962,13 @@ int qedr_resize_cq(struct ib_cq *ibcq, int new_cnt,
> > struct ib_udata *udata)
> >  #define QEDR_DESTROY_CQ_MAX_ITERATIONS		(10)
> >  #define QEDR_DESTROY_CQ_ITER_DURATION		(10)
> >
> > -int qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
> > +void qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
> >  {
> >  	struct qedr_dev *dev = get_qedr_dev(ibcq->device);
> >  	struct qed_rdma_destroy_cq_out_params oparams;
> >  	struct qed_rdma_destroy_cq_in_params iparams;
> >  	struct qedr_cq *cq = get_qedr_cq(ibcq);
> >  	int iter;
> > -	int rc;
> >
> >  	DP_DEBUG(dev, QEDR_MSG_CQ, "destroy cq %p (icid=%d)\n", cq, cq-
> > >icid);
> >
> > @@ -980,10 +979,7 @@ int qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata
> > *udata)
> >  		goto done;
> >
> >  	iparams.icid = cq->icid;
> > -	rc = dev->ops->rdma_destroy_cq(dev->rdma_ctx, &iparams, &oparams);
> > -	if (rc)
> > -		return rc;
> > -
> > +	dev->ops->rdma_destroy_cq(dev->rdma_ctx, &iparams, &oparams);
> >  	dev->ops->common->chain_free(dev->cdev, &cq->pbl);
> >
> >  	if (udata) {
> > @@ -1014,9 +1010,6 @@ int qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata
> > *udata)
> >  		iter--;
> >  	}
> >
> > -	if (oparams.num_cq_notif != cq->cnq_notif)
> > -		goto err;
> > -
>
> Do you want to keep the check and the DP_ERR print for debug?

I relied on the comment above which says that such scenario is possible
in disaster and assumed that qedr will print enough information in other
places. Anyway, this "disaster" won't be related to CQ, but to some
internal HW failure and this print won't help too much.

>
> >  	/* Note that we don't need to have explicit code to wait for the
> >  	 * completion of the event handler because it is invoked from the EQ.
> >  	 * Since the destroy CQ ramrod has also been received on the EQ we can
> > @@ -1026,15 +1019,6 @@ int qedr_destroy_cq(struct ib_cq *ibcq, struct
> > ib_udata *udata)
> >  	cq->sig = ~cq->sig;
> >
> >  	kfree(cq);
> > -
> > -	return 0;
> > -
> > -err:
> > -	DP_ERR(dev,
> > -	       "CQ %p (icid=%d) not freed, expecting %d ints but got %d ints\n",
> > -	       cq, cq->icid, oparams.num_cq_notif, cq->cnq_notif);
> > -
> > -	return -EINVAL;
> >  }
> >
>
