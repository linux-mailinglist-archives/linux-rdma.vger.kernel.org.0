Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963BC400EA1
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Sep 2021 09:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbhIEIAN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Sep 2021 04:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236261AbhIEIAN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 5 Sep 2021 04:00:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4BC861027;
        Sun,  5 Sep 2021 07:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630828750;
        bh=RZZU99bVJsNASLVTjmNSv2Zbtb7TlW5O0F66W1l3S+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dYFyjpqq+AajKXEOilpkoFV076B/PZPcv6z6kHL7VMxksbelK6JrJ3ptls5gU5rO9
         7xanuq+Rjud+EugTVxkekT1I1OlfH5FFzyjtP0fqbXqMshWpD+dcTt+VnqlVkL3d4/
         zsa/pgXC5LV+nSG9x9rj+WiznRj1W7OHSeRQdBw5RS7jQDts2Xzhbd/CjftJ1xLviF
         p6IB1FWa4LLrFW2WhTJgOnTauj5qlT09mCmvoT++Rq11OwGfzQGSA/kLE9id7V0F1Y
         msLZkgdt5hLVE0Os8sbZdg5c3bEI+S5amw72qqRoPbLEJiVsAPDBW+9MfmRFh0xB7E
         0ppDIhCWOFoXA==
Date:   Sun, 5 Sep 2021 10:59:06 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next 4/4] RDMA/efa: CQ notifications
Message-ID: <YTR4yhTyYi323lqe@unreal>
References: <20210901115716.GG1721383@nvidia.com>
 <c8549e51-47a2-1426-b44b-f1c4ade3dce2@amazon.com>
 <20210901153659.GL1721383@nvidia.com>
 <d1b2dc01-5a42-371e-c4b6-2f9b3425f5b6@amazon.com>
 <20210902130255.GR1721383@nvidia.com>
 <3a5fb37a-dd72-e322-f7c6-790ee4e04efa@amazon.com>
 <20210902151029.GV1721383@nvidia.com>
 <f80c3b52-d38b-3045-0fcc-b27f1f7b8c0d@amazon.com>
 <20210902154124.GX1721383@nvidia.com>
 <9ffde1c4-d748-0091-0d7d-b2e2eb63aa51@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ffde1c4-d748-0091-0d7d-b2e2eb63aa51@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 05, 2021 at 10:25:17AM +0300, Gal Pressman wrote:
> On 02/09/2021 18:41, Jason Gunthorpe wrote:
> > On Thu, Sep 02, 2021 at 06:17:45PM +0300, Gal Pressman wrote:
> >> On 02/09/2021 18:10, Jason Gunthorpe wrote:
> >>> On Thu, Sep 02, 2021 at 06:09:39PM +0300, Gal Pressman wrote:
> >>>> On 02/09/2021 16:02, Jason Gunthorpe wrote:
> >>>>> On Thu, Sep 02, 2021 at 10:03:16AM +0300, Gal Pressman wrote:
> >>>>>> On 01/09/2021 18:36, Jason Gunthorpe wrote:
> >>>>>>> On Wed, Sep 01, 2021 at 05:24:43PM +0300, Gal Pressman wrote:
> >>>>>>>> On 01/09/2021 14:57, Jason Gunthorpe wrote:
> >>>>>>>>> On Wed, Sep 01, 2021 at 02:50:42PM +0300, Gal Pressman wrote:
> >>>>>>>>>> On 20/08/2021 21:27, Jason Gunthorpe wrote:
> >>>>>>>>>>> On Wed, Aug 11, 2021 at 06:11:31PM +0300, Gal Pressman wrote:
> >>>>>>>>>>>> diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
> >>>>>>>>>>>> index 417dea5f90cf..29db4dec02f0 100644
> >>>>>>>>>>>> +++ b/drivers/infiniband/hw/efa/efa_main.c
> >>>>>>>>>>>> @@ -67,6 +67,46 @@ static void efa_release_bars(struct efa_dev *dev, int bars_mask)
> >>>>>>>>>>>>      pci_release_selected_regions(pdev, release_bars);
> >>>>>>>>>>>>  }
> >>>>>>>>>>>>
> >>>>>>>>>>>> +static void efa_process_comp_eqe(struct efa_dev *dev, struct efa_admin_eqe *eqe)
> >>>>>>>>>>>> +{
> >>>>>>>>>>>> +    u16 cqn = eqe->u.comp_event.cqn;
> >>>>>>>>>>>> +    struct efa_cq *cq;
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +    cq = xa_load(&dev->cqs_xa, cqn);
> >>>>>>>>>>>> +    if (unlikely(!cq)) {
> >>>>>>>>>>>
> >>>>>>>>>>> This seems unlikely to be correct, what prevents cq from being
> >>>>>>>>>>> destroyed concurrently?
> >>>>>>>>>>>
> >>>>>>>>>>> A comp_handler cannot be running after cq destroy completes.
> >>>>>>>>>>
> >>>>>>>>>> Sorry for the long turnaround, was OOO.
> >>>>>>>>>>
> >>>>>>>>>> The CQ cannot be destroyed until all completion events are acked.
> >>>>>>>>>> https://github.com/linux-rdma/rdma-core/blob/7fd01f0c6799f0ecb99cae03c22cf7ff61ffbf5a/libibverbs/man/ibv_get_cq_event.3#L45
> >>>>>>>>>> https://github.com/linux-rdma/rdma-core/blob/7fd01f0c6799f0ecb99cae03c22cf7ff61ffbf5a/libibverbs/cmd_cq.c#L208
> >>>>>>>>>
> >>>>>>>>> That is something quite different, and in userspace.
> >>>>>>>>>
> >>>>>>>>> What in the kernel prevents tha xa_load and the xa_erase from racing together?
> >>>>>>>>
> >>>>>>>> Good point.
> >>>>>>>> I think we need to surround efa_process_comp_eqe() with an rcu_read_lock() and
> >>>>>>>> have a synchronize_rcu() after removing it from the xarray in
> >>>>>>>> destroy_cq.
> >>>>>>>
> >>>>>>> Try to avoid synchronize_rcu()
> >>>>>>
> >>>>>> I don't see how that's possible?
> >>>>>
> >>>>> Usually people use call_rcu() instead
> >>>>
> >>>> Oh nice, thanks.
> >>>>
> >>>> I think the code would be much simpler using synchronize_rcu(), and the
> >>>> destroy_cq flow is usually on the cold path anyway. I also prefer to be certain
> >>>> that the CQ is freed once the destroy verb returns and not rely on the callback
> >>>> scheduling.
> >>>
> >>> I would not be happy to see synchronize_rcu on uverbs destroy
> >>> functions, it is too easy to DOS the kernel with that.
> >>
> >> OK, but isn't the fact that the uverb can return before the CQ is actually
> >> destroyed problematic?
> > 
> > Yes, you can't allow that, something other than RCU needs to prevent
> > that
> > 
> >> Maybe it's an extreme corner case, but if I created max_cq CQs, destroyed one,
> >> and try to create another one, it is not guaranteed that the create operation
> >> would succeed - even though the destroy has finished.
> > 
> > More importantly a driver cannot call completion callbacks once
> > destroy cq has returned.
> 
> So how is having some kind of synchronization to wait for the call_rcu()
> callback to finish different than using synchronize_rcu()? We'll have to wait
> for the readers to finish before returning.

Why do you need to do anything special in addition to nullify
completion callback which will ensure that no new readers are
coming and call_rcu to make sure that existing readers finished?

Thanks
