Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22BA1D8EBF
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 06:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgESE2g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 00:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgESE2g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 00:28:36 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23628C061A0C
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2020 21:28:36 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id e18so13104921iog.9
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2020 21:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RpaSqXcMtggPmkHCch5Ebg5hPAaljMvFZmoZIJOwHuQ=;
        b=AqWvskXSlKN/9ck1xDMNV8Dl89mFR4RWoLlX4fgnkHYCYxZStse1et2lt73xMI2Y+S
         BTfcWcrU/pEK49+xD+jz3oXMEv1X+2oOXbTp/tQLOfLL/sqZFr3EjOBN2ocoyG1SJXfO
         rvJCeERmr/cE4LweCYk3NaB0CkshjBiH+F54A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RpaSqXcMtggPmkHCch5Ebg5hPAaljMvFZmoZIJOwHuQ=;
        b=JUJRScOWQSnUsWJbYRUxkAFPPNYSZComm8SGejBni26hYtLI1FEhxLX17pwrVXBjEy
         aG2HBpyln+CAIJdpX0Kjmpc+D18PGkmXCHhCiQdqCnMqhHjSDDiXWV6x5CA/iZ9eEwWZ
         EiwWGMwOwgtV1so3WuFuqlEqBbB68tE9QvaNlyAVaCTU6eF0ksr0MHHLpzEIm7cN8Tkl
         yqV2zpO+EFl/HUeDpf2E7OFkFDGSdaJ/qvrDOhKUVird44eQvU/C0A1fsYbqwXGWF0ca
         8BUdUpqzlRGtbx1XlAYjo284wC7SG9bUhzqkDYWa+jGzmuHmiVQoV43lCSkbZvYS/b/H
         uUmw==
X-Gm-Message-State: AOAM531W85yIS1aUSrlCYyoKy9mfjViGpq41VkXii+auIrH0Cc82/Bd3
        8PVmYs3rsZiW3YjeBhXF/136/39H5rdtnmMHpBMbvw==
X-Google-Smtp-Source: ABdhPJxQwFeM0p921wL4jsUE21YHsX029VDzDf/R8ApOWkfBKaKdk/IQRh+7H5SOCfKFfSdiyZMKoD6rbkCXW9J2jSw=
X-Received: by 2002:a02:3b4b:: with SMTP id i11mr19507786jaf.16.1589862515108;
 Mon, 18 May 2020 21:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <1589370763-81205-1-git-send-email-yaminf@mellanox.com>
 <1589370763-81205-3-git-send-email-yaminf@mellanox.com> <20200518083032.GB185893@unreal>
 <a6281ce2-71e1-db0f-1038-8aa0db0aa6be@mellanox.com> <20200518174821.GB188135@unreal>
In-Reply-To: <20200518174821.GB188135@unreal>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Tue, 19 May 2020 09:57:58 +0530
Message-ID: <CANjDDBh32qgfYFv+cVbzYj7fE3+PRE3QqrhW-X7h=BQJzowX_g@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] RDMA/core: Introduce shared CQ pool API
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Yamin Friedman <yaminf@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 18, 2020 at 11:18 PM Leon Romanovsky <leonro@mellanox.com> wrote:
>
> On Mon, May 18, 2020 at 04:16:05PM +0300, Yamin Friedman wrote:
> >
> > On 5/18/2020 11:30 AM, Leon Romanovsky wrote:
> > > On Wed, May 13, 2020 at 02:52:41PM +0300, Yamin Friedman wrote:
> > > > Allow a ULP to ask the core to provide a completion queue based on a
> > > > least-used search on a per-device CQ pools. The device CQ pools grow in a
> > > > lazy fashion when more CQs are requested.
> > > >
> > > > This feature reduces the amount of interrupts when using many QPs.
> > > > Using shared CQs allows for more effcient completion handling. It also
> > > > reduces the amount of overhead needed for CQ contexts.
> > > >
> > > > Test setup:
> > > > Intel(R) Xeon(R) Platinum 8176M CPU @ 2.10GHz servers.
> > > > Running NVMeoF 4KB read IOs over ConnectX-5EX across Spectrum switch.
> > > > TX-depth = 32. The patch was applied in the nvme driver on both the target
> > > > and initiator. Four controllers are accessed from each core. In the
> > > > current test case we have exposed sixteen NVMe namespaces using four
> > > > different subsystems (four namespaces per subsystem) from one NVM port.
> > > > Each controller allocated X queues (RDMA QPs) and attached to Y CQs.
> > > > Before this series we had X == Y, i.e for four controllers we've created
> > > > total of 4X QPs and 4X CQs. In the shared case, we've created 4X QPs and
> > > > only X CQs which means that we have four controllers that share a
> > > > completion queue per core. Until fourteen cores there is no significant
> > > > change in performance and the number of interrupts per second is less than
> > > > a million in the current case.
> > > > ==================================================
> > > > |Cores|Current KIOPs  |Shared KIOPs  |improvement|
> > > > |-----|---------------|--------------|-----------|
> > > > |14   |2332           |2723          |16.7%      |
> > > > |-----|---------------|--------------|-----------|
> > > > |20   |2086           |2712          |30%        |
> > > > |-----|---------------|--------------|-----------|
> > > > |28   |1971           |2669          |35.4%      |
> > > > |=================================================
> > > > |Cores|Current avg lat|Shared avg lat|improvement|
> > > > |-----|---------------|--------------|-----------|
> > > > |14   |767us          |657us         |14.3%      |
> > > > |-----|---------------|--------------|-----------|
> > > > |20   |1225us         |943us         |23%        |
> > > > |-----|---------------|--------------|-----------|
> > > > |28   |1816us         |1341us        |26.1%      |
> > > > ========================================================
> > > > |Cores|Current interrupts|Shared interrupts|improvement|
> > > > |-----|------------------|-----------------|-----------|
> > > > |14   |1.6M/sec          |0.4M/sec         |72%        |
> > > > |-----|------------------|-----------------|-----------|
> > > > |20   |2.8M/sec          |0.6M/sec         |72.4%      |
> > > > |-----|------------------|-----------------|-----------|
> > > > |28   |2.9M/sec          |0.8M/sec         |63.4%      |
> > > > ====================================================================
> > > > |Cores|Current 99.99th PCTL lat|Shared 99.99th PCTL lat|improvement|
> > > > |-----|------------------------|-----------------------|-----------|
> > > > |14   |67ms                    |6ms                    |90.9%      |
> > > > |-----|------------------------|-----------------------|-----------|
> > > > |20   |5ms                     |6ms                    |-10%       |
> > > > |-----|------------------------|-----------------------|-----------|
> > > > |28   |8.7ms                   |6ms                    |25.9%      |
> > > > |===================================================================
> > > >
> > > > Performance improvement with sixteen disks (sixteen CQs per core) is
> > > > comparable.
> > > >
> > > > Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
> > > > Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
> > > > Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
> > > > ---
> > > >   drivers/infiniband/core/core_priv.h |   4 ++
> > > >   drivers/infiniband/core/cq.c        | 137 ++++++++++++++++++++++++++++++++++++
> > > >   drivers/infiniband/core/device.c    |   2 +
> > > >   include/rdma/ib_verbs.h             |  35 +++++++++
> > > >   4 files changed, 178 insertions(+)
> > > >
> > > > diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
> > > > index cf42acc..fa3151b 100644
> > > > --- a/drivers/infiniband/core/core_priv.h
> > > > +++ b/drivers/infiniband/core/core_priv.h
> > > > @@ -414,4 +414,8 @@ void rdma_umap_priv_init(struct rdma_umap_priv *priv,
> > > >                            struct vm_area_struct *vma,
> > > >                            struct rdma_user_mmap_entry *entry);
> > > >
> > > > +void ib_cq_pool_init(struct ib_device *dev);
> > > > +
> > > > +void ib_cq_pool_destroy(struct ib_device *dev);
> > > > +
> > > >   #endif /* _CORE_PRIV_H */
> > > > diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> > > > index 04046eb..5319c14 100644
> > > > --- a/drivers/infiniband/core/cq.c
> > > > +++ b/drivers/infiniband/core/cq.c
> > > > @@ -7,7 +7,11 @@
> > > >   #include <linux/slab.h>
> > > >   #include <rdma/ib_verbs.h>
> > > >
> > > > +#include "core_priv.h"
> > > > +
> > > >   #include <trace/events/rdma_core.h>
> > > > +/* Max size for shared CQ, may require tuning */
> > > > +#define IB_MAX_SHARED_CQ_SZ              4096
> > > >
> > > >   /* # of WCs to poll for with a single call to ib_poll_cq */
> > > >   #define IB_POLL_BATCH                   16
> > > > @@ -218,6 +222,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
> > > >           cq->cq_context = private;
> > > >           cq->poll_ctx = poll_ctx;
> > > >           atomic_set(&cq->usecnt, 0);
> > > > + cq->comp_vector = comp_vector;
> > > >
> > > >           cq->wc = kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), GFP_KERNEL);
> > > >           if (!cq->wc)
> > > > @@ -304,6 +309,8 @@ static void _ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
> > > >   {
> > > >           if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
> > > >                   return;
> > > > + if (WARN_ON_ONCE(cq->cqe_used != 0))
> > > Let's do WARN_ON_ONCE(cq->cqe_used)
> > >
> > > > +         return;
> > > >
> > > >           switch (cq->poll_ctx) {
> > > >           case IB_POLL_DIRECT:
> > > > @@ -340,3 +347,133 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
> > > >                   _ib_free_cq_user(cq, udata);
> > > >   }
> > > >   EXPORT_SYMBOL(ib_free_cq_user);
> > > > +
> > > > +void ib_cq_pool_init(struct ib_device *dev)
> > > > +{
> > > > + int i;
> > > > +
> > > > + spin_lock_init(&dev->cq_pools_lock);
> > > > + for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++)
> > > > +         INIT_LIST_HEAD(&dev->cq_pools[i]);
> > > > +}
> > > > +
> > > > +void ib_cq_pool_destroy(struct ib_device *dev)
> > > > +{
> > > > + struct ib_cq *cq, *n;
> > > > + int i;
> > > > +
> > > > + for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++) {
> > > > +         list_for_each_entry_safe(cq, n, &dev->cq_pools[i], pool_entry)
> > > > +                 _ib_free_cq_user(cq, NULL);
> > > > + }
> > > > +
> > > > +}
> > > > +
> > > > +static int ib_alloc_cqs(struct ib_device *dev, int nr_cqes,
> > > > +                 enum ib_poll_context poll_ctx)
> > > > +{
> > > > + LIST_HEAD(tmp_list);
> > > > + struct ib_cq *cq;
> > > > + unsigned long flags;
> > > > + int nr_cqs, ret, i;
> > > > +
> > > > + /*
> > > > +  * Allocated at least as many CQEs as requested, and otherwise
> > > > +  * a reasonable batch size so that we can share CQs between
> > > > +  * multiple users instead of allocating a larger number of CQs.
> > > > +  */
> > > > + nr_cqes = min(dev->attrs.max_cqe, max(nr_cqes, IB_MAX_SHARED_CQ_SZ));
> > > > + nr_cqs = min_t(int, dev->num_comp_vectors, num_online_cpus());
> > > > + for (i = 0; i < nr_cqs; i++) {
> > > > +         cq = ib_alloc_cq(dev, NULL, nr_cqes, i, poll_ctx);
> > > > +         if (IS_ERR(cq)) {
> > > > +                 ret = PTR_ERR(cq);
> > > > +                 goto out_free_cqs;
> > > > +         }
> > > > +         cq->shared = true;
> > > > +         list_add_tail(&cq->pool_entry, &tmp_list);
> > > > + }
> > > > +
> > > > + spin_lock_irqsave(&dev->cq_pools_lock, flags);
> > > > + list_splice(&tmp_list, &dev->cq_pools[poll_ctx - 1]);
> > > > + spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
> > > > +
> > > > + return 0;
> > > > +
> > > > +out_free_cqs:
> > > > + list_for_each_entry(cq, &tmp_list, pool_entry)
> > > > +         ib_free_cq(cq);
> > > > + return ret;
> > > > +}
> > > > +
> > > > +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int nr_cqe,
> > > > +                      int comp_vector_hint,
> > > > +                      enum ib_poll_context poll_ctx)
> > > > +{
> > > > + static unsigned int default_comp_vector;
> > > > + int vector, ret, num_comp_vectors;
> > > > + struct ib_cq *cq, *found = NULL;
> > > > + unsigned long flags;
> > > > +
> > > > + if (poll_ctx > ARRAY_SIZE(dev->cq_pools) || poll_ctx == IB_POLL_DIRECT)
> > > > +         return ERR_PTR(-EINVAL);
> > > > +
> > > > + num_comp_vectors = min_t(int, dev->num_comp_vectors,
> > > > +                          num_online_cpus());
> > > > + /* Project the affinty to the device completion vector range */
> > > > + if (comp_vector_hint < 0)
> > > > +         vector = default_comp_vector++ % num_comp_vectors;
> > > > + else
> > > > +         vector = comp_vector_hint % num_comp_vectors;
> > > > +
> > > > + /*
> > > > +  * Find the least used CQ with correct affinity and
> > > > +  * enough free CQ entries
> > > > +  */
> > > > + while (!found) {
> > > > +         spin_lock_irqsave(&dev->cq_pools_lock, flags);
> > > > +         list_for_each_entry(cq, &dev->cq_pools[poll_ctx - 1],
> > > > +                             pool_entry) {
> > > > +                 if (vector != cq->comp_vector)
> > > I think that this check worth to have a comment.
> > > At least for me, it is not clear if it will work correctly if
> > > comp_vector == 0.
> > >
> > > > +                         continue;
> > > > +                 if (cq->cqe_used + nr_cqe > cq->cqe)
> > > > +                         continue;
> > > > +                 if (found && cq->cqe_used >= found->cqe_used)
> > > > +                         continue;
> > > > +                 found = cq;
> > > > +                 break;
> > > > +         }
> > > > +
> > > > +         if (found) {
> > > > +                 found->cqe_used += nr_cqe;
> > > > +                 spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
> > > > +
> > > > +                 return found;
> > > > +         }
> > > > +         spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
> > > > +
> > > > +         /*
> > > > +          * Didn't find a match or ran out of CQs in the device
> > > > +          * pool, allocate a new array of CQs.
> > > > +          */
> > > > +         ret = ib_alloc_cqs(dev, nr_cqe, poll_ctx);
> > > > +         if (ret)
> > > > +                 return ERR_PTR(ret);
> > > > + }
> > > > +
> > > > + return found;
> > > > +}
> > > > +EXPORT_SYMBOL(ib_cq_pool_get);
> > > > +
> > > > +void ib_cq_pool_put(struct ib_cq *cq, unsigned int nr_cqe)
> > > > +{
> > > > + unsigned long flags;
> > > > +
> > > > + if (nr_cqe > cq->cqe_used)
> > > > +         return;
> > > Is it possible?
> > > 1. It is racy
> > > 2. It is a bug in the ib_cq_pool_put() caller.
> >
> > It is possible, the pool doesn't save the amount of cqes used per user.
>
> So, #2 from the list above.
>
> >
> > I think to make it really secure I would have to never reduce the cqes used,
> > save the number of active users, and have some form of garbage collection
> > for used up CQs but that seems to me a lot for something that should not
> > occur during proper use.
> >
> > Would it be better to just have a WARN for this case?
>
> I think so.
>
It would be better to fail the pool creation with WARN, because there
may not be any benefit of having a pooled CQs if comp-vectors = 0 for
any given provider.
Using what strategy CQs are pulled from the pool is it FCFS? I did not
checked the complete patch, but is it possible to balance the load
across all the CQs present in the pool?
> Thanks
