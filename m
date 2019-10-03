Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46CBDC9C2E
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 12:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfJCKZh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 06:25:37 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:18102 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfJCKZh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Oct 2019 06:25:37 -0400
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x93APHcP026009;
        Thu, 3 Oct 2019 03:25:18 -0700
Date:   Thu, 3 Oct 2019 15:55:11 +0530
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RDMA: release allocated skb
Message-ID: <20191003102510.GA10875@chelsio.com>
References: <20190923050823.GL14368@unreal>
 <20190923155300.20407-1-navid.emamdoost@gmail.com>
 <20191001135430.GA27086@ziepe.ca>
 <CAEkB2EQF0D-Fdg74+E4VdxipZvTaBKseCtKJKnFg7T6ZZE9x6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkB2EQF0D-Fdg74+E4VdxipZvTaBKseCtKJKnFg7T6ZZE9x6Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thursday, October 10/03/19, 2019 at 03:05:06 +0530, Navid Emamdoost wrote:
> Hi Jason,
> 
> Thanks for the feedback. Yes, you are right if the skb release is
> moved under err4 label it will cause a double free as
> c4iw_ref_send_wait will release skb in case of error.
> So, in order to avoid leaking skb in case of c4iw_bar2_addrs failure,
> the kfree(skb) could be placed under the error check like the way
> patch v1 did. Do you see any mistake in version 1?
> https://lore.kernel.org/patchwork/patch/1128510/

Hi Navid,
Both the revisions of the patch are invalid. skb is freed in both the cases of 
failure and success through c4iw_ofld_send().
case success: in ctrl_xmit()
case failure: in c4iw_ofld_send()

Thanks,
Bharat.


> 
> 
> Thanks,
> Navid
> 
> On Tue, Oct 1, 2019 at 8:54 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Sep 23, 2019 at 10:52:59AM -0500, Navid Emamdoost wrote:
> > > In create_cq, the allocated skb buffer needs to be released on error
> > > path.
> > > Moved the kfree_skb(skb) under err4 label.
> >
> > This didn't move anything
> >
> > > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > >  drivers/infiniband/hw/cxgb4/cq.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
> > > index b1bb61c65f4f..1886c1af10bc 100644
> > > +++ b/drivers/infiniband/hw/cxgb4/cq.c
> > > @@ -173,6 +173,7 @@ static int create_cq(struct c4iw_rdev *rdev, struct t4_cq *cq,
> > >  err4:
> > >       dma_free_coherent(&rdev->lldi.pdev->dev, cq->memsize, cq->queue,
> > >                         dma_unmap_addr(cq, mapping));
> > > +     kfree_skb(skb);
> > >  err3:
> > >       kfree(cq->sw_queue);
> > >  err2:
> >
> > This looks wrong to me:
> >
> > int c4iw_ofld_send(struct c4iw_rdev *rdev, struct sk_buff *skb)
> > {
> >         int     error = 0;
> >
> >         if (c4iw_fatal_error(rdev)) {
> >                 kfree_skb(skb);
> >                 pr_err("%s - device in error state - dropping\n", __func__);
> >                 return -EIO;
> >         }
> >         error = cxgb4_ofld_send(rdev->lldi.ports[0], skb);
> >         if (error < 0)
> >                 kfree_skb(skb);
> >         return error < 0 ? error : 0;
> > }
> >
> > Jason
> 
> 
> 
> -- 
> Navid.
