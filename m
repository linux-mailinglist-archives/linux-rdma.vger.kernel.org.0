Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92ED3205A5D
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 20:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732988AbgFWSPK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 14:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbgFWSPK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jun 2020 14:15:10 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 264E1207FB;
        Tue, 23 Jun 2020 18:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592936109;
        bh=EakZHm4+pAlaLBl8b0/zepdJSj8NnqMpyqyLuGP155k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gnBd7FAzBXDE0WYAhX1XelWRjJDw0V2xDflB9FIUgbu12XlM60+vlpDJf/gOTx0HY
         dku8VqXWwbYi3B4prtgbnQ3glFxjdbx1KwmfiugBaJBirHigDgJf4AV7znNThfUgZb
         tutVcbFD/Mx18Xg9HubA3moKxb5G9ErXOQYjsTNk=
Date:   Tue, 23 Jun 2020 21:15:06 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 2/2] RDMA/core: Optimize XRC target lookup
Message-ID: <20200623181506.GC184720@unreal>
References: <20200623111531.1227013-1-leon@kernel.org>
 <20200623111531.1227013-3-leon@kernel.org>
 <20200623175200.GA3096958@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623175200.GA3096958@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 23, 2020 at 02:52:00PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 23, 2020 at 02:15:31PM +0300, Leon Romanovsky wrote:
> > From: Maor Gottlieb <maorg@mellanox.com>
> >
> > Replace the mutex with read write semaphore and use xarray instead
> > of linked list for XRC target QPs. This will give faster XRC target
> > lookup. In addition, when QP is closed, don't insert it back to the
> > xarray if the destroy command failed.
> >
> > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/core/verbs.c | 57 ++++++++++++---------------------
> >  include/rdma/ib_verbs.h         |  5 ++-
> >  2 files changed, 23 insertions(+), 39 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> > index d66a0ad62077..1ccbe43e33cd 100644
> > +++ b/drivers/infiniband/core/verbs.c
> > @@ -1090,13 +1090,6 @@ static void __ib_shared_qp_event_handler(struct ib_event *event, void *context)
> >  	spin_unlock_irqrestore(&qp->device->qp_open_list_lock, flags);
> >  }
> >
> > -static void __ib_insert_xrcd_qp(struct ib_xrcd *xrcd, struct ib_qp *qp)
> > -{
> > -	mutex_lock(&xrcd->tgt_qp_mutex);
> > -	list_add(&qp->xrcd_list, &xrcd->tgt_qp_list);
> > -	mutex_unlock(&xrcd->tgt_qp_mutex);
> > -}
> > -
> >  static struct ib_qp *__ib_open_qp(struct ib_qp *real_qp,
> >  				  void (*event_handler)(struct ib_event *, void *),
> >  				  void *qp_context)
> > @@ -1139,16 +1132,15 @@ struct ib_qp *ib_open_qp(struct ib_xrcd *xrcd,
> >  	if (qp_open_attr->qp_type != IB_QPT_XRC_TGT)
> >  		return ERR_PTR(-EINVAL);
> >
> > -	qp = ERR_PTR(-EINVAL);
> > -	mutex_lock(&xrcd->tgt_qp_mutex);
> > -	list_for_each_entry(real_qp, &xrcd->tgt_qp_list, xrcd_list) {
> > -		if (real_qp->qp_num == qp_open_attr->qp_num) {
> > -			qp = __ib_open_qp(real_qp, qp_open_attr->event_handler,
> > -					  qp_open_attr->qp_context);
> > -			break;
> > -		}
> > +	down_read(&xrcd->tgt_qps_rwsem);
> > +	real_qp = xa_load(&xrcd->tgt_qps, qp_open_attr->qp_num);
> > +	if (!real_qp) {
>
> Don't we already have a xarray indexed against qp_num in res_track?
> Can we use it somehow?

We don't have restrack for XRC, we will need somehow manage QP-to-XRC
connection there.

Thanks

>
> Jason
