Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83ECC1D72F6
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2020 10:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgERIan (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 May 2020 04:30:43 -0400
Received: from mail-vi1eur05on2080.outbound.protection.outlook.com ([40.107.21.80]:2112
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbgERIam (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 May 2020 04:30:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7QUtsbQRHcelGQoHOvg5luFZZySfqzcV5sVKLnlYXI8o2oJmCHmVBq9cOVMcYMdAOR7KpvQvy9BuL3j2yFOuFRPeWlIVy5YbhFyhgG0uPOB6CAGBYruC/OcRzx8ot0RVCDa5oBbL/Th1gpOnxD0gJjgrUITyg8CSmLCA3BQv6LLe9AohWmCb/O8nCVOUDG0qMTBCTvSUpLZS+y4jpnlYuY57xm48zC0Cxc0WeOnH44Cmpw/u47o9FiqEPrgHSjFeN79kcmtHMyAdDHnWk/E2gqy1bwLNnkoZeesnxc4Ak/QPgutXAb73+YIR8eQqxcJFIkNqUn3jPEmheQO3D6wFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHEgVvWfGtBkcDdDc3LCwvnCOtKHS63deiz8bdkiz1Y=;
 b=PZs8OqoTH0unyTAtmbwLAsgAc3/UDzhB5J8ESTEyjQnwOJFdHtKeBe9BdKSWYi4qUNP1fKnty+ueEqyJ858g0l9UbiqWjzuJJA1lFEJDVNybMjgVsfs8lntV/RCx53Gfb1OpmVIlDTMVfWNL5fdBUvHkIUgqqDUgKtWwY7SWJGU0CEHumBWQWGHr4T64eoC6l0BIuI02jn6ol8mudqcFWbjeNEeLJGv6biFRWIOANiBtWJbprZdkFMO+X9lanONdWGCUBl8FUEOufJdq2uD0yC0sdKZZk0E3UoOI6WzWtGvrOFgRaVVCHYwACAGug492Ni3DGotdnWE3jEwtwd5NAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHEgVvWfGtBkcDdDc3LCwvnCOtKHS63deiz8bdkiz1Y=;
 b=gij4idUPn3Y8FbZn/iVtKTDGMLs/vUhLv4/+85ilqdscFExh1PqbannJNO8a2iiVbe61yoSZQBHzTA0FsGoToJreazerEyg1ucQf29VfOG/foivTJvfGgItnkGHQqmZC/Nrta/BkpZuvMEHg+DkrrTx2wReBZmOegjyzON+W6mM=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM6PR05MB6232.eurprd05.prod.outlook.com (2603:10a6:20b:29::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 08:30:36 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::1466:c39b:c016:3301]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::1466:c39b:c016:3301%4]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 08:30:36 +0000
Date:   Mon, 18 May 2020 11:30:32 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Yamin Friedman <yaminf@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Or Gerlitz <ogerlitz@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH V2 2/4] RDMA/core: Introduce shared CQ pool API
Message-ID: <20200518083032.GB185893@unreal>
References: <1589370763-81205-1-git-send-email-yaminf@mellanox.com>
 <1589370763-81205-3-git-send-email-yaminf@mellanox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589370763-81205-3-git-send-email-yaminf@mellanox.com>
X-ClientProxiedBy: AM3PR05CA0155.eurprd05.prod.outlook.com
 (2603:10a6:207:3::33) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::a43) by AM3PR05CA0155.eurprd05.prod.outlook.com (2603:10a6:207:3::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Mon, 18 May 2020 08:30:35 +0000
X-Originating-IP: [2a00:a040:183:2d::a43]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7c86325d-bb52-4583-9fc7-08d7fb05bce3
X-MS-TrafficTypeDiagnostic: AM6PR05MB6232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB62320AACD8E5BB25D0A96712B0B80@AM6PR05MB6232.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Of5r/5mqSzI2s/V7i46dWRbN22MOp9Ve8FzhgUdO2JjIjkofbDgsPpzkftvTNKxsAU6pI5rHlS1nEUj6FSCuHzdM9765k9G0lnkBvmW3pFJzCtL9q2QBxFddpL+fGKnGxXKwlhCDeVLsHAJS0jWPOmiwFWJ6119xoBwwen5V4S30lltPuSXajhjYRTf9vFu8KAoXynWkkm6A7HWQxiecUQEYjhEvn18kA0DSOsYjr6WA5GGCIiSD6Fu4hS6suwxpISID9tftEiWUDatAligJejk6vwmiXcbede3QzmB12F2+dwjNU7UnnS4dBggwJ2Rf9F4OC4klhetwolRM+hwvmJUQYMgXr/g9CyQK8msJDq8PHnohzwtd0eCNhz9GaeUKPTG/h8wVZ+4Wd6/mwULcf/fBGai3Nm5174b7Q28CAflQFOrCGABBCUEDMAuI2Si1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6408.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(39860400002)(366004)(136003)(396003)(376002)(346002)(33716001)(86362001)(316002)(6666004)(66946007)(66476007)(66556008)(52116002)(6496006)(186003)(30864003)(9686003)(33656002)(16526019)(54906003)(5660300002)(4326008)(8676002)(8936002)(478600001)(6862004)(2906002)(6636002)(6486002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8zIdUVhrh3EkdQcJ4vWoE37so5YdgMYgDrujLImMrFNv3ScndRfjYf4N7JGwIeUcxBDA40uCPttC1oJsTylJ9oMbg7wkwQ1vj2ZAQp+/sOp81LuyncDzGPJWR8TVL8pNA0f7dJNm15aHd2C3FqPjQuGKxouIpjuq8gMsufGNq/yKhvESQ1E/OT3gUqzmBuWx53+c3KgRv/pb5pqfSBi/0OvPlifG4wtRrcacTs16REQEymZ82p6cgc4QxoHulw/4IY+oRajzdrDhd7HLrvhUK37ttkKdFKLWmSwTa7jTot84T0/qn0ZmdD371Vtbkm1E3rcSfs1iCr1DX5buyw2bnaaxkD3YQv/4VRWTu/7HrpS1zNU1+J0WyfjiJzSbGQV+c7dwKvN03EWmrZYzvC99qqsVUKRlFDCtfjJgytUv2A1EpyPmhYqB0RW76Dt7bcDRNCw+ncGN0t3KV/QKYsIG/BTFI1fMrdkzz2iPD9JcUPcP5pAqzqZwvYk6b4E2w6IabL0j+9S2GYdNics9KLlz4w==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c86325d-bb52-4583-9fc7-08d7fb05bce3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 08:30:36.0645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sdd80Br9hSfx9cvqMtTngOQYC7zB8JkWhnl7SQq5/YkOaJvdRob0A+SbYSvLNbfkIBL8Jc4sOMJMsnFUsGjEXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6232
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 13, 2020 at 02:52:41PM +0300, Yamin Friedman wrote:
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
> ---
>  drivers/infiniband/core/core_priv.h |   4 ++
>  drivers/infiniband/core/cq.c        | 137 ++++++++++++++++++++++++++++++++++++
>  drivers/infiniband/core/device.c    |   2 +
>  include/rdma/ib_verbs.h             |  35 +++++++++
>  4 files changed, 178 insertions(+)
>
> diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
> index cf42acc..fa3151b 100644
> --- a/drivers/infiniband/core/core_priv.h
> +++ b/drivers/infiniband/core/core_priv.h
> @@ -414,4 +414,8 @@ void rdma_umap_priv_init(struct rdma_umap_priv *priv,
>  			 struct vm_area_struct *vma,
>  			 struct rdma_user_mmap_entry *entry);
>
> +void ib_cq_pool_init(struct ib_device *dev);
> +
> +void ib_cq_pool_destroy(struct ib_device *dev);
> +
>  #endif /* _CORE_PRIV_H */
> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> index 04046eb..5319c14 100644
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
> +#define IB_MAX_SHARED_CQ_SZ		4096
>
>  /* # of WCs to poll for with a single call to ib_poll_cq */
>  #define IB_POLL_BATCH			16
> @@ -218,6 +222,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
>  	cq->cq_context = private;
>  	cq->poll_ctx = poll_ctx;
>  	atomic_set(&cq->usecnt, 0);
> +	cq->comp_vector = comp_vector;
>
>  	cq->wc = kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), GFP_KERNEL);
>  	if (!cq->wc)
> @@ -304,6 +309,8 @@ static void _ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>  {
>  	if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
>  		return;
> +	if (WARN_ON_ONCE(cq->cqe_used != 0))

Let's do WARN_ON_ONCE(cq->cqe_used)

> +		return;
>
>  	switch (cq->poll_ctx) {
>  	case IB_POLL_DIRECT:
> @@ -340,3 +347,133 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>  		_ib_free_cq_user(cq, udata);
>  }
>  EXPORT_SYMBOL(ib_free_cq_user);
> +
> +void ib_cq_pool_init(struct ib_device *dev)
> +{
> +	int i;
> +
> +	spin_lock_init(&dev->cq_pools_lock);
> +	for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++)
> +		INIT_LIST_HEAD(&dev->cq_pools[i]);
> +}
> +
> +void ib_cq_pool_destroy(struct ib_device *dev)
> +{
> +	struct ib_cq *cq, *n;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++) {
> +		list_for_each_entry_safe(cq, n, &dev->cq_pools[i], pool_entry)
> +			_ib_free_cq_user(cq, NULL);
> +	}
> +
> +}
> +
> +static int ib_alloc_cqs(struct ib_device *dev, int nr_cqes,
> +			enum ib_poll_context poll_ctx)
> +{
> +	LIST_HEAD(tmp_list);
> +	struct ib_cq *cq;
> +	unsigned long flags;
> +	int nr_cqs, ret, i;
> +
> +	/*
> +	 * Allocated at least as many CQEs as requested, and otherwise
> +	 * a reasonable batch size so that we can share CQs between
> +	 * multiple users instead of allocating a larger number of CQs.
> +	 */
> +	nr_cqes = min(dev->attrs.max_cqe, max(nr_cqes, IB_MAX_SHARED_CQ_SZ));
> +	nr_cqs = min_t(int, dev->num_comp_vectors, num_online_cpus());
> +	for (i = 0; i < nr_cqs; i++) {
> +		cq = ib_alloc_cq(dev, NULL, nr_cqes, i, poll_ctx);
> +		if (IS_ERR(cq)) {
> +			ret = PTR_ERR(cq);
> +			goto out_free_cqs;
> +		}
> +		cq->shared = true;
> +		list_add_tail(&cq->pool_entry, &tmp_list);
> +	}
> +
> +	spin_lock_irqsave(&dev->cq_pools_lock, flags);
> +	list_splice(&tmp_list, &dev->cq_pools[poll_ctx - 1]);
> +	spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
> +
> +	return 0;
> +
> +out_free_cqs:
> +	list_for_each_entry(cq, &tmp_list, pool_entry)
> +		ib_free_cq(cq);
> +	return ret;
> +}
> +
> +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int nr_cqe,
> +			     int comp_vector_hint,
> +			     enum ib_poll_context poll_ctx)
> +{
> +	static unsigned int default_comp_vector;
> +	int vector, ret, num_comp_vectors;
> +	struct ib_cq *cq, *found = NULL;
> +	unsigned long flags;
> +
> +	if (poll_ctx > ARRAY_SIZE(dev->cq_pools) || poll_ctx == IB_POLL_DIRECT)
> +		return ERR_PTR(-EINVAL);
> +
> +	num_comp_vectors = min_t(int, dev->num_comp_vectors,
> +				 num_online_cpus());
> +	/* Project the affinty to the device completion vector range */
> +	if (comp_vector_hint < 0)
> +		vector = default_comp_vector++ % num_comp_vectors;
> +	else
> +		vector = comp_vector_hint % num_comp_vectors;
> +
> +	/*
> +	 * Find the least used CQ with correct affinity and
> +	 * enough free CQ entries
> +	 */
> +	while (!found) {
> +		spin_lock_irqsave(&dev->cq_pools_lock, flags);
> +		list_for_each_entry(cq, &dev->cq_pools[poll_ctx - 1],
> +				    pool_entry) {
> +			if (vector != cq->comp_vector)

I think that this check worth to have a comment.
At least for me, it is not clear if it will work correctly if
comp_vector == 0.

> +				continue;
> +			if (cq->cqe_used + nr_cqe > cq->cqe)
> +				continue;
> +			if (found && cq->cqe_used >= found->cqe_used)
> +				continue;
> +			found = cq;
> +			break;
> +		}
> +
> +		if (found) {
> +			found->cqe_used += nr_cqe;
> +			spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
> +
> +			return found;
> +		}
> +		spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
> +
> +		/*
> +		 * Didn't find a match or ran out of CQs in the device
> +		 * pool, allocate a new array of CQs.
> +		 */
> +		ret = ib_alloc_cqs(dev, nr_cqe, poll_ctx);
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +
> +	return found;
> +}
> +EXPORT_SYMBOL(ib_cq_pool_get);
> +
> +void ib_cq_pool_put(struct ib_cq *cq, unsigned int nr_cqe)
> +{
> +	unsigned long flags;
> +
> +	if (nr_cqe > cq->cqe_used)
> +		return;

Is it possible?
1. It is racy
2. It is a bug in the ib_cq_pool_put() caller.

> +
> +	spin_lock_irqsave(&cq->device->cq_pools_lock, flags);
> +	cq->cqe_used -= nr_cqe;
> +	spin_unlock_irqrestore(&cq->device->cq_pools_lock, flags);
> +}
> +EXPORT_SYMBOL(ib_cq_pool_put);
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index d9f565a..abd7cd0 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -600,6 +600,7 @@ struct ib_device *_ib_alloc_device(size_t size)
>  	mutex_init(&device->compat_devs_mutex);
>  	init_completion(&device->unreg_completion);
>  	INIT_WORK(&device->unregistration_work, ib_unregister_work);
> +	ib_cq_pool_init(device);

Why did you add this function in _ib_alloc_device() and not
to the ib_register_device()?

>
>  	return device;
>  }
> @@ -1455,6 +1456,7 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
>  	device_del(&ib_dev->dev);
>  	ib_device_unregister_rdmacg(ib_dev);
>  	ib_cache_cleanup_one(ib_dev);
> +	ib_cq_pool_destroy(ib_dev);

It is not symmetric to the registration flow.

>
>  	/*
>  	 * Drivers using the new flow may not call ib_dealloc_device except
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index b79737b..0ca6617 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -1555,6 +1555,7 @@ enum ib_poll_context {
>  	IB_POLL_SOFTIRQ,	   /* poll from softirq context */
>  	IB_POLL_WORKQUEUE,	   /* poll from workqueue */
>  	IB_POLL_UNBOUND_WORKQUEUE, /* poll from unbound workqueue */
> +	IB_POLL_LAST,
>  };
>
>  struct ib_cq {
> @@ -1564,9 +1565,12 @@ struct ib_cq {
>  	void                  (*event_handler)(struct ib_event *, void *);
>  	void                   *cq_context;
>  	int               	cqe;
> +	int			cqe_used;
>  	atomic_t          	usecnt; /* count number of work queues */
>  	enum ib_poll_context	poll_ctx;
> +	int                     comp_vector;
>  	struct ib_wc		*wc;
> +	struct list_head        pool_entry;
>  	union {
>  		struct irq_poll		iop;
>  		struct work_struct	work;
> @@ -2695,6 +2699,10 @@ struct ib_device {
>  #endif
>
>  	u32                          index;
> +
> +	spinlock_t                   cq_pools_lock;
> +	struct list_head             cq_pools[IB_POLL_LAST - 1];
> +
>  	struct rdma_restrack_root *res;
>
>  	const struct uapi_definition   *driver_def;
> @@ -3957,6 +3965,33 @@ static inline int ib_req_notify_cq(struct ib_cq *cq,
>  	return cq->device->ops.req_notify_cq(cq, flags);
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
> +			     int comp_vector_hint,
> +			     enum ib_poll_context poll_ctx);
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
