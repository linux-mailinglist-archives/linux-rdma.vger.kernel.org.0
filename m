Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4324723869
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 15:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbfETNlO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 09:41:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731655AbfETNlO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 09:41:14 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C65B20856;
        Mon, 20 May 2019 13:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558359673;
        bh=YtqhMqtCEFXMkh33dR230ADCPzUY+1p0XxrF+Iagt5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nSi1Yo5t0ubnin2mTDmfa3fKSlMzhkJMximamQjqcFyiMvWJc541jKULIpandleP1
         wV81O9JXeNvgj/myPqskgkIeb4NjM60zNGu1EHfxe2RbefnHdPIOo4VgOfvJeU3Ie/
         7D0d123eBpvXBK0Nf2WG3bddKXQOc+Fcf3bQGjvc=
Date:   Mon, 20 May 2019 16:41:09 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH rdma-next 15/15] RDMA: Convert CQ allocations to be under
 core responsibility
Message-ID: <20190520134109.GL4573@mtr-leonro.mtl.com>
References: <20190520065433.8734-1-leon@kernel.org>
 <20190520065433.8734-16-leon@kernel.org>
 <9eb4853d-71cd-0335-bfaf-ce808ba21047@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eb4853d-71cd-0335-bfaf-ce808ba21047@amazon.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 20, 2019 at 04:31:22PM +0300, Gal Pressman wrote:
> On 20/05/2019 9:54, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Ensure that CQ is allocated and freed by IB/core and not by drivers.
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> > diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
> > index 8d8d3bd47c35..2ceb8067b99a 100644
> > --- a/drivers/infiniband/hw/efa/efa.h
> > +++ b/drivers/infiniband/hw/efa/efa.h
> > @@ -137,9 +137,8 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
> >  			    struct ib_qp_init_attr *init_attr,
> >  			    struct ib_udata *udata);
> >  void efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
> > -struct ib_cq *efa_create_cq(struct ib_device *ibdev,
> > -			    const struct ib_cq_init_attr *attr,
> > -			    struct ib_udata *udata);
> > +int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> > +		  struct ib_udata *udata);
> >  struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
> >  			 u64 virt_addr, int access_flags,
> >  			 struct ib_udata *udata);
> > diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
> > index db974caf1eb1..27f8a473bde9 100644
> > --- a/drivers/infiniband/hw/efa/efa_main.c
> > +++ b/drivers/infiniband/hw/efa/efa_main.c
> > @@ -220,6 +220,7 @@ static const struct ib_device_ops efa_dev_ops = {
> >  	.reg_user_mr = efa_reg_mr,
> >
> >  	INIT_RDMA_OBJ_SIZE(ib_ah, efa_ah, ibah),
> > +	INIT_RDMA_OBJ_SIZE(ib_cq, efa_cq, ibcq),
> >  	INIT_RDMA_OBJ_SIZE(ib_pd, efa_pd, ibpd),
> >  	INIT_RDMA_OBJ_SIZE(ib_ucontext, efa_ucontext, ibucontext),
> >  };
> > diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> > index e57f8adde174..6ccb85950439 100644
> > --- a/drivers/infiniband/hw/efa/efa_verbs.c
> > +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> > @@ -859,8 +859,6 @@ void efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
> >  	efa_destroy_cq_idx(dev, cq->cq_idx);
> >  	dma_unmap_single(&dev->pdev->dev, cq->dma_addr, cq->size,
> >  			 DMA_FROM_DEVICE);
> > -
> > -	kfree(cq);
> >  }
> >
> >  static int cq_mmap_entries_setup(struct efa_dev *dev, struct efa_cq *cq,
> > @@ -876,20 +874,23 @@ static int cq_mmap_entries_setup(struct efa_dev *dev, struct efa_cq *cq,
> >  	return 0;
> >  }
> >
> > -static struct ib_cq *do_create_cq(struct ib_device *ibdev, int entries,
> > -				  int vector, struct ib_ucontext *ibucontext,
> > -				  struct ib_udata *udata)
> > +int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> > +		  struct ib_udata *udata)
> >  {
> > +	struct efa_ucontext *ucontext = rdma_udata_to_drv_context(
> > +		udata, struct efa_ucontext, ibucontext);
> > +	struct ib_device *ibdev = ibcq->device;
> > +	struct efa_dev *dev = to_edev(ibdev);
>
> Nit, can we please keep the existing reverse xmas tree?

<...>

> >
> > -	ibdev_dbg(ibdev, "create_cq entries %d\n", entries);
> > +	ibdev_dbg(ibcq->device, "create_cq entries %d\n", entries);
>
> No need to change, we can keep using 'ibdev'. Same applies for other prints.
>

Thanks for the review, I changed it locally, will send it in v1.
