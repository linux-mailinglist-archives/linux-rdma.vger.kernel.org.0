Return-Path: <linux-rdma+bounces-11792-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD95AEF4F2
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 12:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA883A7954
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 10:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7752701D2;
	Tue,  1 Jul 2025 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQdpYFeM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A53626F477;
	Tue,  1 Jul 2025 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751365456; cv=none; b=K3XP8Xjrx4m34zL0C2e9bV4pTnC/gE0v2f3F9uBheB6OP6MZCf8qcn24fNa7dBQxyoxGstT38FOj0QdNb5PpsoS5N5mptwSVh/2HzcsH9QL2TwATkrKYbfpha/4kObORHMfT/Vh4KVHKsUOfv4pnVPeWQrRWzPCORP6qgQM1jp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751365456; c=relaxed/simple;
	bh=Ap6a6/7zWEFfGBEq3+BTor3vbcQo4WoX9hvuGKvl4a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQgsVEuCu3H5j1IS/zWi6gQPQBVYTlimOdOnwty9fZ4xzxh1BDmJivhNRt+UhmJAl0xNX3M7A2Bsex6ALR6mXm5C5PTGaINm+Va3cIc4nkT8nBlAKtzmQUweedjgefKaRFfMU0eGuNWoSt906IQIOOW4oDOSMYHKO7giOQq/nxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQdpYFeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEAFC4CEEB;
	Tue,  1 Jul 2025 10:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751365454;
	bh=Ap6a6/7zWEFfGBEq3+BTor3vbcQo4WoX9hvuGKvl4a0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NQdpYFeMlE7Bvb0e5MK0NruLB8i8jbzC6TIe1pnsgvKaSzy4EGs81zdh921v12kJf
	 fnEWuEJSf/alOJC7Ty+Zd3q8jf9bumf/qGyVYCwk8/zA8EEfZsRLMK4sA2VbVdZNS1
	 3lxRSHB4P5i6uHaWTTF9/siyJfhHw3C/oTbPw69MuRMbeIUt8waYh7c1NAyYXMmTXh
	 kztlCzsyK8peHsTcgOtfLEQjr95dM4FFsHkuv2ksVB0xyGcWck5JEoiTJh3qvJV4KN
	 vT//YY6rN35RQcIx9475MfeyxgGwzEil7bZgHBmcIxeNVj4SP3gPVsA91PV+gc4Qt3
	 3jbaWIGczQl8A==
Date: Tue, 1 Jul 2025 13:24:09 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	corbet@lwn.net, jgg@ziepe.ca, andrew+netdev@lunn.ch,
	allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Boyer <andrew.boyer@amd.com>
Subject: Re: [PATCH v3 09/14] RDMA/ionic: Create device queues to support
 admin operations
Message-ID: <20250701102409.GA118736@unreal>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
 <20250624121315.739049-10-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624121315.739049-10-abhijit.gangurde@amd.com>

On Tue, Jun 24, 2025 at 05:43:10PM +0530, Abhijit Gangurde wrote:
> Setup RDMA admin queues using device command exposed over
> auxiliary device and manage these queues using ida.
> 
> Co-developed-by: Andrew Boyer <andrew.boyer@amd.com>
> Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
> Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> ---
> v2->v3
>   - Fixed lockdep warning
>   - Used IDA for resource id allocation
>   - Removed rw locks around xarrays
> 
>  drivers/infiniband/hw/ionic/ionic_admin.c     | 1169 +++++++++++++++++
>  .../infiniband/hw/ionic/ionic_controlpath.c   |  184 +++
>  drivers/infiniband/hw/ionic/ionic_fw.h        |  164 +++
>  drivers/infiniband/hw/ionic/ionic_ibdev.c     |   56 +
>  drivers/infiniband/hw/ionic/ionic_ibdev.h     |  225 ++++
>  drivers/infiniband/hw/ionic/ionic_pgtbl.c     |  113 ++
>  drivers/infiniband/hw/ionic/ionic_queue.c     |   52 +
>  drivers/infiniband/hw/ionic/ionic_queue.h     |  234 ++++
>  drivers/infiniband/hw/ionic/ionic_res.h       |  154 +++
>  9 files changed, 2351 insertions(+)
>  create mode 100644 drivers/infiniband/hw/ionic/ionic_admin.c
>  create mode 100644 drivers/infiniband/hw/ionic/ionic_controlpath.c
>  create mode 100644 drivers/infiniband/hw/ionic/ionic_fw.h
>  create mode 100644 drivers/infiniband/hw/ionic/ionic_pgtbl.c
>  create mode 100644 drivers/infiniband/hw/ionic/ionic_queue.c
>  create mode 100644 drivers/infiniband/hw/ionic/ionic_queue.h
>  create mode 100644 drivers/infiniband/hw/ionic/ionic_res.h

<...>

> +static void ionic_admin_timedout(struct ionic_aq *aq)
> +{
> +	struct ionic_cq *cq = &aq->vcq->cq[0];
> +	struct ionic_ibdev *dev = aq->dev;
> +	unsigned long irqflags;
> +	u16 pos;
> +
> +	spin_lock_irqsave(&aq->lock, irqflags);
> +	if (ionic_queue_empty(&aq->q))
> +		goto out;
> +
> +	/* Reset ALL adminq if any one times out */
> +	if (aq->admin_state < IONIC_ADMIN_KILLED)
> +		queue_work(ionic_evt_workq, &dev->reset_work);
> +
> +	ibdev_err(&dev->ibdev, "admin command timed out, aq %d\n", aq->aqid);
> +
> +	ibdev_warn(&dev->ibdev, "admin timeout was set for %ums\n",
> +		   (u32)jiffies_to_msecs(IONIC_ADMIN_TIMEOUT));
> +	ibdev_warn(&dev->ibdev, "admin inactivity for %ums\n",
> +		   (u32)jiffies_to_msecs(jiffies - aq->stamp));
> +
> +	ibdev_warn(&dev->ibdev, "admin commands outstanding %u\n",
> +		   ionic_queue_length(&aq->q));
> +	ibdev_warn(&dev->ibdev, "%s more commands pending\n",
> +		   list_empty(&aq->wr_post) ? "no" : "some");
> +
> +	pos = cq->q.prod;
> +
> +	ibdev_warn(&dev->ibdev, "admin cq pos %u (next to complete)\n", pos);
> +	print_hex_dump(KERN_WARNING, "cqe ", DUMP_PREFIX_OFFSET, 16, 1,
> +		       ionic_queue_at(&cq->q, pos),
> +		       BIT(cq->q.stride_log2), true);
> +
> +	pos = (pos - 1) & cq->q.mask;
> +
> +	ibdev_warn(&dev->ibdev, "admin cq pos %u (last completed)\n", pos);
> +	print_hex_dump(KERN_WARNING, "cqe ", DUMP_PREFIX_OFFSET, 16, 1,
> +		       ionic_queue_at(&cq->q, pos),
> +		       BIT(cq->q.stride_log2), true);
> +
> +	pos = aq->q.cons;
> +
> +	ibdev_warn(&dev->ibdev, "admin pos %u (next to complete)\n", pos);
> +	print_hex_dump(KERN_WARNING, "cmd ", DUMP_PREFIX_OFFSET, 16, 1,
> +		       ionic_queue_at(&aq->q, pos),
> +		       BIT(aq->q.stride_log2), true);
> +
> +	pos = (aq->q.prod - 1) & aq->q.mask;
> +	if (pos == aq->q.cons)
> +		goto out;
> +
> +	ibdev_warn(&dev->ibdev, "admin pos %u (last posted)\n", pos);
> +	print_hex_dump(KERN_WARNING, "cmd ", DUMP_PREFIX_OFFSET, 16, 1,
> +		       ionic_queue_at(&aq->q, pos),
> +		       BIT(aq->q.stride_log2), true);
> +
> +out:
> +	spin_unlock_irqrestore(&aq->lock, irqflags);
> +}

Please reduce number of debug prints. You are supposed to send driver
that works and not for the debug session.

> +
> +static void ionic_admin_reset_dwork(struct ionic_ibdev *dev)
> +{
> +	if (atomic_read(&dev->admin_state) >= IONIC_ADMIN_KILLED)
> +		return;

<...>

> +	if (aq->admin_state >= IONIC_ADMIN_KILLED)
> +		return;

<...>

> +	ibdev_dbg(&dev->ibdev, "poll admin cq %u prod %u\n",
> +		  cq->cqid, cq->q.prod);
> +	print_hex_dump_debug("cqe ", DUMP_PREFIX_OFFSET, 16, 1,
> +			     qcqe, BIT(cq->q.stride_log2), true);

We have restrack to print CQE and other objects, please use it.

> +	*cqe = qcqe;
> +
> +	return true;
> +}
> +
> +static void ionic_admin_poll_locked(struct ionic_aq *aq)
> +{
> +	struct ionic_cq *cq = &aq->vcq->cq[0];
> +	struct ionic_admin_wr *wr, *wr_next;
> +	struct ionic_ibdev *dev = aq->dev;
> +	u32 wr_strides, avlbl_strides;
> +	struct ionic_v1_cqe *cqe;
> +	u32 qtf, qid;
> +	u16 old_prod;
> +	u8 type;
> +
> +	lockdep_assert_held(&aq->lock);
> +
> +	if (aq->admin_state >= IONIC_ADMIN_KILLED) {

IONIC_ADMIN_KILLED is the last, there is no ">" option.

> +		list_for_each_entry_safe(wr, wr_next, &aq->wr_prod, aq_ent) {
> +			INIT_LIST_HEAD(&wr->aq_ent);
> +			aq->q_wr[wr->status].wr = NULL;
> +			wr->status = aq->admin_state;
> +			complete_all(&wr->work);
> +		}
> +		INIT_LIST_HEAD(&aq->wr_prod);

<...>

> +	if (do_reset)
> +		/* Reset device on a timeout */
> +		ionic_admin_timedout(bad_aq);

I wonder why RDMA driver resets device and not the one who owns PCI.

> +	else if (do_reschedule)
> +		/* Try to poll again later */
> +		ionic_admin_reset_dwork(dev);
> +}

<...>

> +	vcq = kzalloc(sizeof(*vcq), GFP_KERNEL);
> +	if (!vcq) {
> +		rc = -ENOMEM;
> +		goto err_alloc;
> +	}
> +
> +	vcq->ibcq.device = &dev->ibdev;
> +	vcq->ibcq.uobject = NULL;

1. There is no need in explicit NULL here, vcq was allocated with kzalloc()
2. Maybe rdma_zalloc_drv_obj() should be used here.

> +	vcq->ibcq.comp_handler = ionic_rdma_admincq_comp;
> +	vcq->ibcq.event_handler = ionic_rdma_admincq_event;
> +	vcq->ibcq.cq_context = NULL;
> +	atomic_set(&vcq->ibcq.usecnt, 0);

<...>

> +	aq->admin_state = IONIC_ADMIN_KILLED;

<...>

> +	old_state = atomic_cmpxchg(&dev->admin_state, IONIC_ADMIN_ACTIVE,
> +				   IONIC_ADMIN_PAUSED);
> +	if (old_state != IONIC_ADMIN_ACTIVE)

In all these places you are mixing enum_admin_state and atomic_t for
same values, but different variable. Please chose or atomic_t or enum.

> +		return;
> +
> +	/* Pause all the AQs */
> +	local_irq_save(irqflags);
> +	for (i = 0; i < dev->lif_cfg.aq_count; i++) {
> +		struct ionic_aq *aq = dev->aq_vec[i];
> +
> +		spin_lock(&aq->lock);
> +		/* pause rdma admin queues to reset device */
> +		if (aq->admin_state == IONIC_ADMIN_ACTIVE)
> +			aq->admin_state = IONIC_ADMIN_PAUSED;
> +		spin_unlock(&aq->lock);
> +	}
> +	local_irq_restore(irqflags);
> +
> +	rc = ionic_rdma_reset_devcmd(dev);
> +	if (unlikely(rc)) {
> +		ibdev_err(&dev->ibdev, "failed to reset rdma %d\n", rc);
> +		ionic_request_rdma_reset(dev->lif_cfg.lif);
> +	}
> +
> +	ionic_kill_ibdev(dev, fatal_path);
> +}

<...>

> +static void ionic_cq_event(struct ionic_ibdev *dev, u32 cqid, u8 code)
> +{
> +	struct ib_event ibev;
> +	struct ionic_cq *cq;
> +
> +	rcu_read_lock();
> +	cq = xa_load(&dev->cq_tbl, cqid);
> +	if (cq)
> +		kref_get(&cq->cq_kref);
> +	rcu_read_unlock();

What and how does this RCU protect?

> +
> +	if (!cq) {

Is it possible?

> +		ibdev_dbg(&dev->ibdev,
> +			  "missing cqid %#x code %u\n", cqid, code);
> +		return;
> +	}

<...>

>  module_init(ionic_mod_init);
> diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
> index e13adff390d7..e7563c0429fc 100644
> --- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
> +++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
> @@ -4,18 +4,243 @@
>  #ifndef _IONIC_IBDEV_H_
>  #define _IONIC_IBDEV_H_
>  
> +#include <rdma/ib_umem.h>
>  #include <rdma/ib_verbs.h>
> +
>  #include <ionic_api.h>
> +#include <ionic_regs.h>
> +
> +#include "ionic_fw.h"
> +#include "ionic_queue.h"
> +#include "ionic_res.h"
>  
>  #include "ionic_lif_cfg.h"
>  
> +#define DRIVER_NAME		"ionic_rdma"

It is KBUILD_MODNAME, please use it.

> +#define DRIVER_SHORTNAME	"ionr"
> +
>  #define IONIC_MIN_RDMA_VERSION	0
>  #define IONIC_MAX_RDMA_VERSION	2

Nothing from the above is applicable to upstream code.

Thanks

