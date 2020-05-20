Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD501DAA89
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 08:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgETGU1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 02:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgETGU1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 May 2020 02:20:27 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C1AC061A0E
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 23:20:26 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id m6so1964784ilq.7
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 23:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vbv4IJmd4hjhKIi0q5uByo55XONVpx369luxfur02IY=;
        b=eEhSUybn0ZnSWOBhiKbef3xrSIVVblZNcR1e9foNFV3n9oQMAeQc3khnuQRx6mS9Lg
         nJnAOsNqraJ6K3ZZoYiKCzkxNo9QCtcXLiQuqOXh4VGEZe5N0xjJOlKwOR72BtWCyzOh
         UaE/VGdO6Ru+Grcr8LOom++Yc71AjY/nrxQYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vbv4IJmd4hjhKIi0q5uByo55XONVpx369luxfur02IY=;
        b=HLWxdbBeipFKDFZ/g3JzWKE6DiLCWi+Ipv9WNcxpQhT676Ng4R13dDE9YVIky0xECx
         kAvhfRBqdD3JL1MdTQxV8BTcU57cAgXiEKBZRddbC9YZmujrW7wUQVtsNxZxYLmSsMBA
         6Kjy94jEls4MZz73uKXjuifXp6tKHZUJQodMywd22jLUZQD+whhbYcK70LYb7rv4lKy4
         dOtEUtNZaIXpYCZql0DoftY8V0ircNbhnKmulNRYqV+n1knGRDEypvt/yloqdHKIZbKY
         LvHv8eC2T3eJgP8GcEIibRDyfvzZb1ZIzrYaCABz4cr22Z/mwK4OqvHpTK1bmwRwgJbR
         eWJA==
X-Gm-Message-State: AOAM530prm7CpU3OPrFUY2oJHVOk0dT8EGHqYJK8E3qtLwUreFWylZKz
        cM0Kdo94EQf7kDcwyI5R30KrfjOZLQuMCm0jfTU23w==
X-Google-Smtp-Source: ABdhPJxfOIPL0qh+jAhhD2K5KkAk0iOjBEmNAB9ev2kUy1TAM/obUoK/0TTCjItNtg/BxdzY8bPXnQFOhNpNeRY8hXM=
X-Received: by 2002:a05:6e02:ca3:: with SMTP id 3mr2445086ilg.285.1589955625656;
 Tue, 19 May 2020 23:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <1589892216-39283-1-git-send-email-yaminf@mellanox.com> <1589892216-39283-3-git-send-email-yaminf@mellanox.com>
In-Reply-To: <1589892216-39283-3-git-send-email-yaminf@mellanox.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Wed, 20 May 2020 11:49:49 +0530
Message-ID: <CANjDDBgPQBOuBNQE=3PqsAtNgSzVbnDDt6wYNrS8iC-gAYzHJQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] RDMA/core: Introduce shared CQ pool API
To:     Yamin Friedman <yaminf@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 19, 2020 at 6:13 PM Yamin Friedman <yaminf@mellanox.com> wrote:
>
> Allow a ULP to ask the core to provide a completion queue based on a
> least-used search on a per-device CQ pools. The device CQ pools grow in a
> lazy fashion when more CQs are requested.
>
> This feature reduces the amount of interrupts when using many QPs.
> Using shared CQs allows for more effcient completion handling. It also
> reduces the amount of overhead needed for CQ contexts.
>
> Test setup:
> Intel(R) Xeon(R) Platinum 8176M CPU @ 2.10GHz servers.
> Running NVMeoF 4KB read IOs over ConnectX-5EX across Spectrum switch.
> TX-depth = 32. The patch was applied in the nvme driver on both the target
> and initiator. Four controllers are accessed from each core. In the
> current test case we have exposed sixteen NVMe namespaces using four
> different subsystems (four namespaces per subsystem) from one NVM port.
> Each controller allocated X queues (RDMA QPs) and attached to Y CQs.
> Before this series we had X == Y, i.e for four controllers we've created
> total of 4X QPs and 4X CQs. In the shared case, we've created 4X QPs and
> only X CQs which means that we have four controllers that share a
> completion queue per core. Until fourteen cores there is no significant
> change in performance and the number of interrupts per second is less than
> a million in the current case.
> ==================================================
> |Cores|Current KIOPs  |Shared KIOPs  |improvement|
> |-----|---------------|--------------|-----------|
> |14   |2332           |2723          |16.7%      |
> |-----|---------------|--------------|-----------|
> |20   |2086           |2712          |30%        |
> |-----|---------------|--------------|-----------|
> |28   |1971           |2669          |35.4%      |
> |=================================================
> |Cores|Current avg lat|Shared avg lat|improvement|
> |-----|---------------|--------------|-----------|
> |14   |767us          |657us         |14.3%      |
> |-----|---------------|--------------|-----------|
> |20   |1225us         |943us         |23%        |
> |-----|---------------|--------------|-----------|
> |28   |1816us         |1341us        |26.1%      |
> ========================================================
> |Cores|Current interrupts|Shared interrupts|improvement|
> |-----|------------------|-----------------|-----------|
> |14   |1.6M/sec          |0.4M/sec         |72%        |
> |-----|------------------|-----------------|-----------|
> |20   |2.8M/sec          |0.6M/sec         |72.4%      |
> |-----|------------------|-----------------|-----------|
> |28   |2.9M/sec          |0.8M/sec         |63.4%      |
> ====================================================================
> |Cores|Current 99.99th PCTL lat|Shared 99.99th PCTL lat|improvement|
> |-----|------------------------|-----------------------|-----------|
> |14   |67ms                    |6ms                    |90.9%      |
> |-----|------------------------|-----------------------|-----------|
> |20   |5ms                     |6ms                    |-10%       |
> |-----|------------------------|-----------------------|-----------|
> |28   |8.7ms                   |6ms                    |25.9%      |
> |===================================================================
>
> Performance improvement with sixteen disks (sixteen CQs per core) is
> comparable.
>
> Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
> Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/core_priv.h |   3 +
>  drivers/infiniband/core/cq.c        | 144 ++++++++++++++++++++++++++++++++++++
>  drivers/infiniband/core/device.c    |   2 +
>  include/rdma/ib_verbs.h             |  35 +++++++++
>  4 files changed, 184 insertions(+)
>
> diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
> index cf42acc..a1e6a67 100644
> --- a/drivers/infiniband/core/core_priv.h
> +++ b/drivers/infiniband/core/core_priv.h
> @@ -414,4 +414,7 @@ void rdma_umap_priv_init(struct rdma_umap_priv *priv,
>                          struct vm_area_struct *vma,
>                          struct rdma_user_mmap_entry *entry);
>
> +void ib_cq_pool_init(struct ib_device *dev);
> +void ib_cq_pool_destroy(struct ib_device *dev);
> +
>  #endif /* _CORE_PRIV_H */
> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> index 4f25b24..7175295 100644
> --- a/drivers/infiniband/core/cq.c
> +++ b/drivers/infiniband/core/cq.c
> @@ -7,7 +7,11 @@
>  #include <linux/slab.h>
>  #include <rdma/ib_verbs.h>
>
> +#include "core_priv.h"
> +
>  #include <trace/events/rdma_core.h>
> +/* Max size for shared CQ, may require tuning */
> +#define IB_MAX_SHARED_CQ_SZ            4096
>
>  /* # of WCs to poll for with a single call to ib_poll_cq */
>  #define IB_POLL_BATCH                  16
> @@ -218,6 +222,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
>         cq->cq_context = private;
>         cq->poll_ctx = poll_ctx;
>         atomic_set(&cq->usecnt, 0);
> +       cq->comp_vector = comp_vector;
>
>         cq->wc = kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), GFP_KERNEL);
>         if (!cq->wc)
> @@ -309,6 +314,8 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>  {
>         if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
>                 return;
> +       if (WARN_ON_ONCE(cq->cqe_used))
> +               return;
>
>         switch (cq->poll_ctx) {
>         case IB_POLL_DIRECT:
> @@ -334,3 +341,140 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>         kfree(cq);
>  }
>  EXPORT_SYMBOL(ib_free_cq_user);
> +
> +void ib_cq_pool_init(struct ib_device *dev)
> +{
> +       int i;
> +
> +       spin_lock_init(&dev->cq_pools_lock);
> +       for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++)
> +               INIT_LIST_HEAD(&dev->cq_pools[i]);
> +}
> +
> +void ib_cq_pool_destroy(struct ib_device *dev)
> +{
> +       struct ib_cq *cq, *n;
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++) {
> +               list_for_each_entry_safe(cq, n, &dev->cq_pools[i],
> +                                        pool_entry) {
> +                       cq->shared = false;
> +                       ib_free_cq_user(cq, NULL);
> +               }
> +       }
> +
> +}
> +
> +static int ib_alloc_cqs(struct ib_device *dev, int nr_cqes,
> +                       enum ib_poll_context poll_ctx)
> +{
> +       LIST_HEAD(tmp_list);
> +       struct ib_cq *cq;
> +       unsigned long flags;
> +       int nr_cqs, ret, i;
> +
> +       /*
> +        * Allocated at least as many CQEs as requested, and otherwise
> +        * a reasonable batch size so that we can share CQs between
> +        * multiple users instead of allocating a larger number of CQs.
> +        */
> +       nr_cqes = min(dev->attrs.max_cqe, max(nr_cqes, IB_MAX_SHARED_CQ_SZ));
> +       nr_cqs = min_t(int, dev->num_comp_vectors, num_online_cpus());
No WARN() or return with failure as pointed by Leon and me. Has
anything else changes elsewhere?

> +       for (i = 0; i < nr_cqs; i++) {
> +               cq = ib_alloc_cq(dev, NULL, nr_cqes, i, poll_ctx);
> +               if (IS_ERR(cq)) {
> +                       ret = PTR_ERR(cq);
> +                       goto out_free_cqs;
> +               }
> +               cq->shared = true;
> +               list_add_tail(&cq->pool_entry, &tmp_list);
> +       }
> +
> +       spin_lock_irqsave(&dev->cq_pools_lock, flags);
> +       list_splice(&tmp_list, &dev->cq_pools[poll_ctx - 1]);
> +       spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
> +
> +       return 0;
> +
> +out_free_cqs:
> +       list_for_each_entry(cq, &tmp_list, pool_entry) {
> +               cq->shared = false;
> +               ib_free_cq(cq);
> +       }
> +       return ret;
> +}
> +
> +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int nr_cqe,
> +                            int comp_vector_hint,
> +                            enum ib_poll_context poll_ctx)
> +{
> +       static unsigned int default_comp_vector;
> +       int vector, ret, num_comp_vectors;
> +       struct ib_cq *cq, *found = NULL;
> +       unsigned long flags;
> +
> +       if (poll_ctx > ARRAY_SIZE(dev->cq_pools) || poll_ctx == IB_POLL_DIRECT)
> +               return ERR_PTR(-EINVAL);
> +
> +       num_comp_vectors = min_t(int, dev->num_comp_vectors,
> +                                num_online_cpus());
> +       /* Project the affinty to the device completion vector range */
> +       if (comp_vector_hint < 0)
> +               vector = default_comp_vector++ % num_comp_vectors;
> +       else
> +               vector = comp_vector_hint % num_comp_vectors;
> +
> +       /*
> +        * Find the least used CQ with correct affinity and
> +        * enough free CQ entries
> +        */
> +       while (!found) {
> +               spin_lock_irqsave(&dev->cq_pools_lock, flags);
> +               list_for_each_entry(cq, &dev->cq_pools[poll_ctx - 1],
> +                                   pool_entry) {
> +                       /*
> +                        * Check to see if we have found a CQ with the
> +                        * correct completion vector
> +                        */
> +                       if (vector != cq->comp_vector)
> +                               continue;
> +                       if (cq->cqe_used + nr_cqe > cq->cqe)
> +                               continue;
> +                       found = cq;
> +                       break;
> +               }
> +
> +               if (found) {
> +                       found->cqe_used += nr_cqe;
> +                       spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
> +
> +                       return found;
> +               }
> +               spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
> +
> +               /*
> +                * Didn't find a match or ran out of CQs in the device
> +                * pool, allocate a new array of CQs.
> +                */
> +               ret = ib_alloc_cqs(dev, nr_cqe, poll_ctx);
> +               if (ret)
> +                       return ERR_PTR(ret);
> +       }
> +
> +       return found;
> +}
> +EXPORT_SYMBOL(ib_cq_pool_get);
> +
> +void ib_cq_pool_put(struct ib_cq *cq, unsigned int nr_cqe)
> +{
> +       unsigned long flags;
> +
> +       if (WARN_ON_ONCE(nr_cqe > cq->cqe_used))
> +               return;
> +
> +       spin_lock_irqsave(&cq->device->cq_pools_lock, flags);
> +       cq->cqe_used -= nr_cqe;
> +       spin_unlock_irqrestore(&cq->device->cq_pools_lock, flags);
> +}
> +EXPORT_SYMBOL(ib_cq_pool_put);
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index d9f565a..0966f86 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -1418,6 +1418,7 @@ int ib_register_device(struct ib_device *device, const char *name)
>                 device->ops.dealloc_driver = dealloc_fn;
>                 return ret;
>         }
> +       ib_cq_pool_init(device);
>         ib_device_put(device);
>
>         return 0;
> @@ -1446,6 +1447,7 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
>         if (!refcount_read(&ib_dev->refcount))
>                 goto out;
>
> +       ib_cq_pool_destroy(ib_dev);
>         disable_device(ib_dev);
>
>         /* Expedite removing unregistered pointers from the hash table */
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 1659131..d40604a 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -1555,6 +1555,7 @@ enum ib_poll_context {
>         IB_POLL_SOFTIRQ,           /* poll from softirq context */
>         IB_POLL_WORKQUEUE,         /* poll from workqueue */
>         IB_POLL_UNBOUND_WORKQUEUE, /* poll from unbound workqueue */
> +       IB_POLL_LAST,
>  };
>
>  struct ib_cq {
> @@ -1564,9 +1565,12 @@ struct ib_cq {
>         void                  (*event_handler)(struct ib_event *, void *);
>         void                   *cq_context;
>         int                     cqe;
> +       int                     cqe_used;
>         atomic_t                usecnt; /* count number of work queues */
>         enum ib_poll_context    poll_ctx;
> +       int                     comp_vector;
>         struct ib_wc            *wc;
> +       struct list_head        pool_entry;
>         union {
>                 struct irq_poll         iop;
>                 struct work_struct      work;
> @@ -2695,6 +2699,10 @@ struct ib_device {
>  #endif
>
>         u32                          index;
> +
> +       spinlock_t                   cq_pools_lock;
> +       struct list_head             cq_pools[IB_POLL_LAST - 1];
> +
>         struct rdma_restrack_root *res;
>
>         const struct uapi_definition   *driver_def;
> @@ -3952,6 +3960,33 @@ static inline int ib_req_notify_cq(struct ib_cq *cq,
>         return cq->device->ops.req_notify_cq(cq, flags);
>  }
>
> +/*
> + * ib_cq_pool_get() - Find the least used completion queue that matches
> + *     a given cpu hint (or least used for wild card affinity)
> + *     and fits nr_cqe
> + * @dev: rdma device
> + * @nr_cqe: number of needed cqe entries
> + * @comp_vector_hint: completion vector hint (-1) for the driver to assign
> + *   a comp vector based on internal counter
> + * @poll_ctx: cq polling context
> + *
> + * Finds a cq that satisfies @comp_vector_hint and @nr_cqe requirements and
> + * claim entries in it for us. In case there is no available cq, allocate
> + * a new cq with the requirements and add it to the device pool.
> + * IB_POLL_DIRECT cannot be used for shared cqs so it is not a valid value
> + * for @poll_ctx.
> + */
> +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int nr_cqe,
> +                            int comp_vector_hint,
> +                            enum ib_poll_context poll_ctx);
> +
> +/**
> + * ib_cq_pool_put - Return a CQ taken from a shared pool.
> + * @cq: The CQ to return.
> + * @nr_cqe: The max number of cqes that the user had requested.
> + */
> +void ib_cq_pool_put(struct ib_cq *cq, unsigned int nr_cqe);
> +
>  /**
>   * ib_req_ncomp_notif - Request completion notification when there are
>   *   at least the specified number of unreaped completions on the CQ.
> --
> 1.8.3.1
>
