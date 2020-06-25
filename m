Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19237209B43
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2020 10:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390626AbgFYI0k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jun 2020 04:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389747AbgFYI0k (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Jun 2020 04:26:40 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 684B0207E8;
        Thu, 25 Jun 2020 08:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593073599;
        bh=2sDMnUjTazBOP60LsbeNUhYqeLsZS+2p13sGQro3g/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z3Zll4auEkOycHUTooxBbaE6qhgjh9xVeUhg8NALm59bRvnHhjLxWhDfljtiABotq
         KspR1DsEQHMfcidyR/fzHOl7YFJJCTlndGHoC+83NxrL94aPYusp0W1cIaoy22o5e/
         ZBJiwl14061+Fw06XZlwHtpOoqOpbRR2AToBzzDQ=
Date:   Thu, 25 Jun 2020 11:26:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Maor Gottlieb <maorg@mellanox.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 2/2] RDMA/core: Optimize XRC target lookup
Message-ID: <20200625082635.GC1446285@unreal>
References: <20200623111531.1227013-1-leon@kernel.org>
 <20200623111531.1227013-3-leon@kernel.org>
 <20200623175200.GA3096958@mellanox.com>
 <20200623181506.GC184720@unreal>
 <20200623184940.GN2874652@mellanox.com>
 <d5206962-69ae-48e7-261b-485db71d2a41@mellanox.com>
 <20200624140047.GG6578@ziepe.ca>
 <9e018ff8-9ba1-4dd2-fb5b-ce22b81b2c52@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e018ff8-9ba1-4dd2-fb5b-ce22b81b2c52@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 24, 2020 at 05:48:27PM +0300, Maor Gottlieb wrote:
>
> On 6/24/2020 5:00 PM, Jason Gunthorpe wrote:
> > On Wed, Jun 24, 2020 at 01:42:49PM +0300, Maor Gottlieb wrote:
> > > On 6/23/2020 9:49 PM, Jason Gunthorpe wrote:
> > > > On Tue, Jun 23, 2020 at 09:15:06PM +0300, Leon Romanovsky wrote:
> > > > > On Tue, Jun 23, 2020 at 02:52:00PM -0300, Jason Gunthorpe wrote:
> > > > > > On Tue, Jun 23, 2020 at 02:15:31PM +0300, Leon Romanovsky wrote:
> > > > > > > From: Maor Gottlieb <maorg@mellanox.com>
> > > > > > >
> > > > > > > Replace the mutex with read write semaphore and use xarray instead
> > > > > > > of linked list for XRC target QPs. This will give faster XRC target
> > > > > > > lookup. In addition, when QP is closed, don't insert it back to the
> > > > > > > xarray if the destroy command failed.
> > > > > > >
> > > > > > > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > > > > > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > > > > >    drivers/infiniband/core/verbs.c | 57 ++++++++++++---------------------
> > > > > > >    include/rdma/ib_verbs.h         |  5 ++-
> > > > > > >    2 files changed, 23 insertions(+), 39 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> > > > > > > index d66a0ad62077..1ccbe43e33cd 100644
> > > > > > > +++ b/drivers/infiniband/core/verbs.c
> > > > > > > @@ -1090,13 +1090,6 @@ static void __ib_shared_qp_event_handler(struct ib_event *event, void *context)
> > > > > > >    	spin_unlock_irqrestore(&qp->device->qp_open_list_lock, flags);
> > > > > > >    }
> > > > > > >
> > > > > > > -static void __ib_insert_xrcd_qp(struct ib_xrcd *xrcd, struct ib_qp *qp)
> > > > > > > -{
> > > > > > > -	mutex_lock(&xrcd->tgt_qp_mutex);
> > > > > > > -	list_add(&qp->xrcd_list, &xrcd->tgt_qp_list);
> > > > > > > -	mutex_unlock(&xrcd->tgt_qp_mutex);
> > > > > > > -}
> > > > > > > -
> > > > > > >    static struct ib_qp *__ib_open_qp(struct ib_qp *real_qp,
> > > > > > >    				  void (*event_handler)(struct ib_event *, void *),
> > > > > > >    				  void *qp_context)
> > > > > > > @@ -1139,16 +1132,15 @@ struct ib_qp *ib_open_qp(struct ib_xrcd *xrcd,
> > > > > > >    	if (qp_open_attr->qp_type != IB_QPT_XRC_TGT)
> > > > > > >    		return ERR_PTR(-EINVAL);
> > > > > > >
> > > > > > > -	qp = ERR_PTR(-EINVAL);
> > > > > > > -	mutex_lock(&xrcd->tgt_qp_mutex);
> > > > > > > -	list_for_each_entry(real_qp, &xrcd->tgt_qp_list, xrcd_list) {
> > > > > > > -		if (real_qp->qp_num == qp_open_attr->qp_num) {
> > > > > > > -			qp = __ib_open_qp(real_qp, qp_open_attr->event_handler,
> > > > > > > -					  qp_open_attr->qp_context);
> > > > > > > -			break;
> > > > > > > -		}
> > > > > > > +	down_read(&xrcd->tgt_qps_rwsem);
> > > > > > > +	real_qp = xa_load(&xrcd->tgt_qps, qp_open_attr->qp_num);
> > > > > > > +	if (!real_qp) {
> > > > > > Don't we already have a xarray indexed against qp_num in res_track?
> > > > > > Can we use it somehow?
> > > > > We don't have restrack for XRC, we will need somehow manage QP-to-XRC
> > > > > connection there.
> > > > It is not xrc, this is just looking up a qp and checking if it is part
> > > > of the xrcd
> > > >
> > > > Jason
> > > It's the XRC target  QP and it is not tracked.
> > Really? Something called 'real_qp' isn't stored in the restrack?
> > Doesn't that sound like a bug already?
> >
> > Jason
>
> Bug / limitation. see the below comment from core_priv.h:
>
>         /*
>          * We don't track XRC QPs for now, because they don't have PD
>          * and more importantly they are created internaly by driver,
>          * see mlx5 create_dev_resources() as an example.
>          */
>
> Leon, the PD is a real limitation? regarding the second part (mlx5),  you
> just sent patches that change it,right?

The second part is not relevant now, but the first part is still
relevant, due to the check in restrack.c.

  131         case RDMA_RESTRACK_QP:
  132                 pd = container_of(res, struct ib_qp, res)->pd;
  133                 if (!pd) {
  134                         WARN_ONCE(true, "XRC QPs are not supported\n");
  135                         /* Survive, despite the programmer's error */
  136                         res->kern_name = " ";
  137                 }
  138                 break;


The reason to it that "regular" QPs has the name of their "creator"
inside PD which doesn't exist for XRC. It is possible to change and
make special case for the XRC, but all places that touch "kern_name"
need to be audited.

It is in my roadmap after allocation work will be finished and we will
introduce proper reference counting for the QPs.

Thanks

>
