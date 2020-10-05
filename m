Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5067F283450
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Oct 2020 12:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgJEK52 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Oct 2020 06:57:28 -0400
Received: from mail-dm6nam10on2062.outbound.protection.outlook.com ([40.107.93.62]:18121
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbgJEK52 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 5 Oct 2020 06:57:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKyRefIPofLhY3WS7brG82bgPQGukj89wiomSI7xPzzerCN+Yq1Cb8PPn0L1hVaD9DWiJV7kKf0MwSGBlHV6T18G4UKz7Cq0FHGS/MW7dbulpwOtYVzLqP9YkpiVRwJ7tbPHey8B2OVKP4dGroRTBC4BSS8ypEgnr1FNwOW9AcOHikjwrAx4PH59jsvUTNjYKbH8UELAnfnT7LW7zOrtVona/3HLRGlSymxSkaod5HfEa1//7G2LdrqiHatm/BO9iHoKnwE/7QFvznP7ukAPMZchIArtf7Dgn0h74eUxsw1V+4Ptdi4JSdaXTl6KihDeNk6NdUoUVpwhd98bVmCObQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0CA3XAOCkHJCHRcirCilvr6SxriLNSP1jJUaSGoGig=;
 b=NFpLvE4DlmaYvoU6uWrNbyqNEXsLvMt/NfFlauWWR6beROa84fYwTupkUk9YDrvwMuYggZd1XrNxsxW/ikNqPpdwEsLx4xsaa8znifivqt6X4wLbMgzbIMohz1x8rdEgcDsEONUxue+AiDK6+MHXlzr4HAmIxoDX/BYJeXrUF/OacHM7OP7+WS8rZ4roYOt/Lrda+/wFyyOWmpb+3PAERkAa0TnugSqgwcm0SnZgKCO8NQ8d0cDrTWpJugqRI2XSayYBLehjoy9+k7e3S9P05n74b9bR4RWSsrTqht/LWn3JnunikpnpY4YIf65xBN3wRpViBFV9PIleTLcjpCnj5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0CA3XAOCkHJCHRcirCilvr6SxriLNSP1jJUaSGoGig=;
 b=esH0OI36AEXuR7K5q+D4HaRw6QoTzzxGh83M/hK3QncsFknl8BJnZCfLfYQDEF/8ZqMnNu8eG9Gp9e2gwT+AhRnI+THoLSzYy9xypjbFWkr8EcamiThC7JjjCR7AaI8Ufc6FCk5mRIj+MuSVoSOhUhxX9nbEkC12YniWnZlgguc=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Mon, 5 Oct
 2020 10:54:47 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 10:54:47 +0000
Subject: Re: [RFC PATCH v3 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
To:     Jianxin Xiong <jianxin.xiong@intel.com>,
        linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <1601838751-148544-1-git-send-email-jianxin.xiong@intel.com>
 <1601838751-148544-2-git-send-email-jianxin.xiong@intel.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <dbc54851-1c98-d439-7d30-6572a7d89ea3@amd.com>
Date:   Mon, 5 Oct 2020 12:54:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1601838751-148544-2-git-send-email-jianxin.xiong@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::13) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37 via Frontend Transport; Mon, 5 Oct 2020 10:54:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f9c32f1d-1328-4c6a-2c41-08d8691d130f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4334:
X-Microsoft-Antispam-PRVS: <MN2PR12MB43348DCA751DB2B9592EDE90830C0@MN2PR12MB4334.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4JqAOtp2b2kQM1NwlBLQyNckD0bVi0i83dFqT3sk0N6urf96PgMP+USI59KwXt1hucFD0ACG5Z6zYPhpnfiB/FGicjdCDb7Nb2nyFmgjAoOuKZCow/0jTZpNRtWcXLAL7wt9nVvFz8TIhZ7wy2moV0UYO21/ISXAyMm6O5aL/KTUPttuONjIFyvBC/rLHVdNBDkn17gf1UPRfqmjBHiCxY6rbpQovQVVuA5Pap0cArM/g8ES651GnocvsZ5nDbTpRfv0wBAXNb574MMuxbWIvHn9GUSMNpfTK8wGzPG77V4E59RnsK8nvDs0H4vaMwlVtFXYPquf5Qd1zcOP1dpQx0jDQzPUy0pDEDEHo8lazIEoEyGwwc4z7OFBiWZiFw02
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(36756003)(31686004)(2906002)(8676002)(8936002)(478600001)(4326008)(66556008)(66946007)(6666004)(2616005)(54906003)(66574015)(31696002)(83380400001)(86362001)(66476007)(316002)(6486002)(16526019)(30864003)(5660300002)(52116002)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: BmHgl9KoIn1P7FKKLxR2UQUiMoDE5qOGBTjFiVmuBV3L4Oot3kC/k+27Hy9CrCRkOn/ra9DRjC9d+kmt+m2jo9eVsSSPONo5fVIlklOFZBQWeV+Y39WlV4EGyAlmgucE6XF92m1IcNIPw7YilDOW9GSHutXnrWLMXu46xdmZ4mPXpZppbzyMGcj9PhxmBIobj/5RCW63NKbbpZoLHy3ggHwzfVQtd9vBQe0q/JRQBjRKzlo2JoiHVlbvLU57YFmYPIy/Lrc/3/QPZCPI2fdzFVWbZw+ConEkV3nkUfqgbkoEI+om/Ca23avYRyEnAejwQhmC72QLrgZoDdjG3UWVWvx+SSBvZz70wIJWyGdS2lLtqo4EVdrAlXHFKTR8z9zMbTEcsUb0zXIcQo2G356j1BHc6gnFn1SXGVRlDdoqxL7YfeBPwDWggD2XRtUQATEZ68WEeBHPh+AEuijB8VUHaaHW/AgQjDGnXY25FZwzS608Zta/x0laX+aIyv64K38r9ARNUUxh3C0/ODKa6iWZ6v5VtV4pWyFOnupAt7vYo0CEPnsBImmpGeBqVBLNL8l3LDAhpSpy3ZsGtjK+fc2mOEhkA6pStYwU2B0nrPY46+8c5AZI5u1D3hGa6XJnxgESqj8jiz8G/ZT4Y1edPw24noUJUdPWMiSPeyQuRGWgOHTLmdDlkSWSGlMzewNh63sNAtjj9DQ72CyyHDtOIOnhnA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c32f1d-1328-4c6a-2c41-08d8691d130f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 10:54:46.9883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vshLQVcojMK+Zqg8Fn5OEG1rgDvAbP2tqMKU7IElHNoU6TxW2r2NGnb6TEbk+ONU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jianxin,

Am 04.10.20 um 21:12 schrieb Jianxin Xiong:
> Dma-buf is a standard cross-driver buffer sharing mechanism that can be
> used to support peer-to-peer access from RDMA devices.
>
> Device memory exported via dma-buf is associated with a file descriptor.
> This is passed to the user space as a property associated with the
> buffer allocation. When the buffer is registered as a memory region,
> the file descriptor is passed to the RDMA driver along with other
> parameters.
>
> Implement the common code for importing dma-buf object and mapping
> dma-buf pages.
>
> Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
> Reviewed-by: Sean Hefty <sean.hefty@intel.com>
> Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>

well first of all really nice work you have done here.

Since I'm not an expert on RDMA or its drivers I can't really review any 
of that part.

But at least from the DMA-buf side it looks like you are using the 
interface correctly as intended.

So feel free to add an Acked-by: Christian König 
<christian.koenig@amd.com> if it helps.

Thanks,
Christian.

> ---
>   drivers/infiniband/core/Makefile      |   2 +-
>   drivers/infiniband/core/umem.c        |   4 +
>   drivers/infiniband/core/umem_dmabuf.c | 291 ++++++++++++++++++++++++++++++++++
>   drivers/infiniband/core/umem_dmabuf.h |  14 ++
>   drivers/infiniband/core/umem_odp.c    |  12 ++
>   include/rdma/ib_umem.h                |  19 ++-
>   6 files changed, 340 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/infiniband/core/umem_dmabuf.c
>   create mode 100644 drivers/infiniband/core/umem_dmabuf.h
>
> diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
> index 24cb71a..b8d51a7 100644
> --- a/drivers/infiniband/core/Makefile
> +++ b/drivers/infiniband/core/Makefile
> @@ -40,5 +40,5 @@ ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
>   				uverbs_std_types_srq.o \
>   				uverbs_std_types_wq.o \
>   				uverbs_std_types_qp.o
> -ib_uverbs-$(CONFIG_INFINIBAND_USER_MEM) += umem.o
> +ib_uverbs-$(CONFIG_INFINIBAND_USER_MEM) += umem.o umem_dmabuf.o
>   ib_uverbs-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += umem_odp.o
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index 831bff8..59ec36c 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -2,6 +2,7 @@
>    * Copyright (c) 2005 Topspin Communications.  All rights reserved.
>    * Copyright (c) 2005 Cisco Systems.  All rights reserved.
>    * Copyright (c) 2005 Mellanox Technologies. All rights reserved.
> + * Copyright (c) 2020 Intel Corporation. All rights reserved.
>    *
>    * This software is available to you under a choice of one of two
>    * licenses.  You may choose to be licensed under the terms of the GNU
> @@ -42,6 +43,7 @@
>   #include <rdma/ib_umem_odp.h>
>   
>   #include "uverbs.h"
> +#include "umem_dmabuf.h"
>   
>   static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int dirty)
>   {
> @@ -318,6 +320,8 @@ void ib_umem_release(struct ib_umem *umem)
>   {
>   	if (!umem)
>   		return;
> +	if (umem->is_dmabuf)
> +		return ib_umem_dmabuf_release(umem);
>   	if (umem->is_odp)
>   		return ib_umem_odp_release(to_ib_umem_odp(umem));
>   
> diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
> new file mode 100644
> index 0000000..10ed646
> --- /dev/null
> +++ b/drivers/infiniband/core/umem_dmabuf.c
> @@ -0,0 +1,291 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +/*
> + * Copyright (c) 2020 Intel Corporation. All rights reserved.
> + */
> +
> +#include <linux/dma-buf.h>
> +#include <linux/dma-resv.h>
> +#include <linux/dma-mapping.h>
> +#include <rdma/ib_umem_odp.h>
> +
> +#include "uverbs.h"
> +
> +struct ib_umem_dmabuf {
> +	struct ib_umem_odp umem_odp;
> +	struct dma_buf_attachment *attach;
> +	struct sg_table *sgt;
> +	atomic_t notifier_seq;
> +};
> +
> +static inline struct ib_umem_dmabuf *to_ib_umem_dmabuf(struct ib_umem *umem)
> +{
> +	struct ib_umem_odp *umem_odp = to_ib_umem_odp(umem);
> +	return container_of(umem_odp, struct ib_umem_dmabuf, umem_odp);
> +}
> +
> +static void ib_umem_dmabuf_invalidate_cb(struct dma_buf_attachment *attach)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf = attach->importer_priv;
> +	struct ib_umem_odp *umem_odp = &umem_dmabuf->umem_odp;
> +	struct mmu_notifier_range range = {};
> +	unsigned long current_seq;
> +
> +	/* no concurrent invalidation due to the dma_resv lock */
> +
> +	dma_resv_assert_held(umem_dmabuf->attach->dmabuf->resv);
> +
> +	if (!umem_dmabuf->sgt)
> +		return;
> +
> +	range.start = ib_umem_start(umem_odp);
> +	range.end = ib_umem_end(umem_odp);
> +	range.flags = MMU_NOTIFIER_RANGE_BLOCKABLE;
> +	current_seq = atomic_read(&umem_dmabuf->notifier_seq);
> +	umem_odp->notifier.ops->invalidate(&umem_odp->notifier, &range,
> +					   current_seq);
> +
> +	atomic_inc(&umem_dmabuf->notifier_seq);
> +}
> +
> +static struct dma_buf_attach_ops ib_umem_dmabuf_attach_ops = {
> +	.allow_peer2peer = 1,
> +	.move_notify = ib_umem_dmabuf_invalidate_cb,
> +};
> +
> +static inline int ib_umem_dmabuf_init_odp(struct ib_umem_odp *umem_odp)
> +{
> +	size_t page_size = 1UL << umem_odp->page_shift;
> +	unsigned long start;
> +	unsigned long end;
> +	size_t pages;
> +
> +	umem_odp->umem.is_odp = 1;
> +	mutex_init(&umem_odp->umem_mutex);
> +
> +	start = ALIGN_DOWN(umem_odp->umem.address, page_size);
> +	if (check_add_overflow(umem_odp->umem.address,
> +			       (unsigned long)umem_odp->umem.length,
> +			       &end))
> +		return -EOVERFLOW;
> +	end = ALIGN(end, page_size);
> +	if (unlikely(end < page_size))
> +		return -EOVERFLOW;
> +
> +	pages = (end - start) >> umem_odp->page_shift;
> +	if (!pages)
> +		return -EINVAL;
> +
> +	/* used for ib_umem_start() & ib_umem_end() */
> +	umem_odp->notifier.interval_tree.start = start;
> +	umem_odp->notifier.interval_tree.last = end - 1;
> +
> +	/* umem_odp->page_list is never used for dma-buf */
> +
> +	umem_odp->dma_list = kvcalloc(
> +		pages, sizeof(*umem_odp->dma_list), GFP_KERNEL);
> +	if (!umem_odp->dma_list)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
> +				   unsigned long addr, size_t size,
> +				   int dmabuf_fd, int access,
> +				   const struct mmu_interval_notifier_ops *ops)
> +{
> +	struct dma_buf *dmabuf;
> +	struct ib_umem_dmabuf *umem_dmabuf;
> +	struct ib_umem *umem;
> +	struct ib_umem_odp *umem_odp;
> +	unsigned long end;
> +	long ret;
> +
> +	if (check_add_overflow(addr, size, &end))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (unlikely(PAGE_ALIGN(end) < PAGE_SIZE))
> +		return ERR_PTR(-EINVAL);
> +
> +	umem_dmabuf = kzalloc(sizeof(*umem_dmabuf), GFP_KERNEL);
> +	if (!umem_dmabuf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	umem = &umem_dmabuf->umem_odp.umem;
> +	umem->ibdev = device;
> +	umem->length = size;
> +	umem->address = addr;
> +	umem->writable = ib_access_writable(access);
> +	umem->is_dmabuf = 1;
> +
> +	dmabuf = dma_buf_get(dmabuf_fd);
> +	if (IS_ERR(dmabuf)) {
> +		ret = PTR_ERR(dmabuf);
> +		goto out_free_umem;
> +	}
> +
> +	/* always attach dynamically to pass the allow_peer2peer flag */
> +	umem_dmabuf->attach = dma_buf_dynamic_attach(
> +					dmabuf,
> +					device->dma_device,
> +					&ib_umem_dmabuf_attach_ops,
> +					umem_dmabuf);
> +	if (IS_ERR(umem_dmabuf->attach)) {
> +		ret = PTR_ERR(umem_dmabuf->attach);
> +		goto out_release_dmabuf;
> +	}
> +
> +	umem_odp = &umem_dmabuf->umem_odp;
> +	umem_odp->page_shift = PAGE_SHIFT;
> +	if (access & IB_ACCESS_HUGETLB) {
> +		/* don't support huge_tlb at this point */
> +		ret = -EINVAL;
> +		goto out_detach_dmabuf;
> +	}
> +
> +	ret = ib_umem_dmabuf_init_odp(umem_odp);
> +	if (ret)
> +		goto out_detach_dmabuf;
> +
> +	umem_odp->notifier.ops = ops;
> +	return umem;
> +
> +out_detach_dmabuf:
> +	dma_buf_detach(dmabuf, umem_dmabuf->attach);
> +
> +out_release_dmabuf:
> +	dma_buf_put(dmabuf);
> +
> +out_free_umem:
> +	kfree(umem_dmabuf);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL(ib_umem_dmabuf_get);
> +
> +unsigned long ib_umem_dmabuf_notifier_read_begin(struct ib_umem_odp *umem_odp)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf = to_ib_umem_dmabuf(&umem_odp->umem);
> +
> +	return atomic_read(&umem_dmabuf->notifier_seq);
> +}
> +EXPORT_SYMBOL(ib_umem_dmabuf_notifier_read_begin);
> +
> +int ib_umem_dmabuf_notifier_read_retry(struct ib_umem_odp *umem_odp,
> +				       unsigned long current_seq)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf = to_ib_umem_dmabuf(&umem_odp->umem);
> +
> +	return (atomic_read(&umem_dmabuf->notifier_seq) != current_seq);
> +}
> +EXPORT_SYMBOL(ib_umem_dmabuf_notifier_read_retry);
> +
> +int ib_umem_dmabuf_map_pages(struct ib_umem *umem, u64 user_virt, u64 bcnt,
> +			     u64 access_mask, unsigned long current_seq)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf = to_ib_umem_dmabuf(umem);
> +	struct ib_umem_odp *umem_odp = &umem_dmabuf->umem_odp;
> +	u64 start, end, addr;
> +	int j, k, ret = 0, user_pages, pages, total_pages;
> +	unsigned int page_shift;
> +	size_t page_size;
> +	struct scatterlist *sg;
> +	struct sg_table *sgt;
> +
> +	if (access_mask == 0)
> +		return -EINVAL;
> +
> +	if (user_virt < ib_umem_start(umem_odp) ||
> +	    user_virt + bcnt > ib_umem_end(umem_odp))
> +		return -EFAULT;
> +
> +	page_shift = umem_odp->page_shift;
> +	page_size = 1UL << page_shift;
> +	start = ALIGN_DOWN(user_virt, page_size);
> +	end = ALIGN(user_virt + bcnt, page_size);
> +	user_pages = (end - start) >> page_shift;
> +
> +	mutex_lock(&umem_odp->umem_mutex);
> +
> +	/* check for on-ongoing invalidations */
> +	if (ib_umem_dmabuf_notifier_read_retry(umem_odp, current_seq)) {
> +		ret = -EAGAIN;
> +		goto out;
> +	}
> +
> +	ret = user_pages;
> +	if (umem_dmabuf->sgt)
> +		goto out;
> +
> +	dma_resv_lock(umem_dmabuf->attach->dmabuf->resv, NULL);
> +	sgt = dma_buf_map_attachment(umem_dmabuf->attach,
> +				     DMA_BIDIRECTIONAL);
> +	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
> +
> +	if (IS_ERR(sgt)) {
> +		ret = PTR_ERR(sgt);
> +		goto out;
> +	}
> +
> +	umem->sg_head = *sgt;
> +	umem->nmap = sgt->nents;
> +	umem_dmabuf->sgt = sgt;
> +
> +	k = 0;
> +	total_pages = ib_umem_odp_num_pages(umem_odp);
> +	for_each_sg(umem->sg_head.sgl, sg, umem->sg_head.nents, j) {
> +		addr = sg_dma_address(sg);
> +		pages = sg_dma_len(sg) >> page_shift;
> +		while (pages > 0 && k < total_pages) {
> +			umem_odp->dma_list[k++] = addr | access_mask;
> +			umem_odp->npages++;
> +			addr += page_size;
> +			pages--;
> +		}
> +	}
> +
> +	WARN_ON(k != total_pages);
> +
> +out:
> +	mutex_unlock(&umem_odp->umem_mutex);
> +	return ret;
> +}
> +
> +void ib_umem_dmabuf_unmap_pages(struct ib_umem *umem)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf = to_ib_umem_dmabuf(umem);
> +	struct ib_umem_odp *umem_odp = &umem_dmabuf->umem_odp;
> +	int npages = ib_umem_odp_num_pages(umem_odp);
> +	int i;
> +
> +	lockdep_assert_held(&umem_odp->umem_mutex);
> +	dma_resv_assert_held(umem_dmabuf->attach->dmabuf->resv);
> +
> +	if (!umem_dmabuf->sgt)
> +		return;
> +
> +	dma_buf_unmap_attachment(umem_dmabuf->attach, umem_dmabuf->sgt,
> +				 DMA_BIDIRECTIONAL);
> +
> +	umem_dmabuf->sgt = NULL;
> +
> +	for (i = 0; i < npages; i++)
> +		umem_odp->dma_list[i] = 0;
> +	umem_odp->npages = 0;
> +}
> +
> +void ib_umem_dmabuf_release(struct ib_umem *umem)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf = to_ib_umem_dmabuf(umem);
> +	struct ib_umem_odp *umem_odp = &umem_dmabuf->umem_odp;
> +	struct dma_buf *dmabuf = umem_dmabuf->attach->dmabuf;
> +
> +	mutex_lock(&umem_odp->umem_mutex);
> +	dma_resv_lock(umem_dmabuf->attach->dmabuf->resv, NULL);
> +	ib_umem_dmabuf_unmap_pages(umem);
> +	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
> +	mutex_unlock(&umem_odp->umem_mutex);
> +	kvfree(umem_odp->dma_list);
> +	dma_buf_detach(dmabuf, umem_dmabuf->attach);
> +	dma_buf_put(dmabuf);
> +	kfree(umem_dmabuf);
> +}
> diff --git a/drivers/infiniband/core/umem_dmabuf.h b/drivers/infiniband/core/umem_dmabuf.h
> new file mode 100644
> index 0000000..b9378bd
> --- /dev/null
> +++ b/drivers/infiniband/core/umem_dmabuf.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> +/*
> + * Copyright (c) 2020 Intel Corporation. All rights reserved.
> + */
> +
> +#ifndef UMEM_DMABUF_H
> +#define UMEM_DMABUF_H
> +
> +int ib_umem_dmabuf_map_pages(struct ib_umem *umem, u64 user_virt, u64 bcnt,
> +			     u64 access_mask, unsigned long current_seq);
> +void ib_umem_dmabuf_unmap_pages(struct ib_umem *umem);
> +void ib_umem_dmabuf_release(struct ib_umem *umem);
> +
> +#endif /* UMEM_DMABUF_H */
> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
> index cc6b4be..7e11619 100644
> --- a/drivers/infiniband/core/umem_odp.c
> +++ b/drivers/infiniband/core/umem_odp.c
> @@ -1,5 +1,6 @@
>   /*
>    * Copyright (c) 2014 Mellanox Technologies. All rights reserved.
> + * Copyright (c) 2020 Intel Corporation. All rights reserved.
>    *
>    * This software is available to you under a choice of one of two
>    * licenses.  You may choose to be licensed under the terms of the GNU
> @@ -47,6 +48,7 @@
>   #include <rdma/ib_umem_odp.h>
>   
>   #include "uverbs.h"
> +#include "umem_dmabuf.h"
>   
>   static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
>   				   const struct mmu_interval_notifier_ops *ops)
> @@ -263,6 +265,9 @@ struct ib_umem_odp *ib_umem_odp_get(struct ib_device *device,
>   
>   void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
>   {
> +	if (umem_odp->umem.is_dmabuf)
> +		return ib_umem_dmabuf_release(&umem_odp->umem);
> +
>   	/*
>   	 * Ensure that no more pages are mapped in the umem.
>   	 *
> @@ -392,6 +397,10 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
>   	unsigned int flags = 0, page_shift;
>   	phys_addr_t p = 0;
>   
> +	if (umem_odp->umem.is_dmabuf)
> +		return ib_umem_dmabuf_map_pages(&umem_odp->umem, user_virt,
> +						bcnt, access_mask, current_seq);
> +
>   	if (access_mask == 0)
>   		return -EINVAL;
>   
> @@ -517,6 +526,9 @@ void ib_umem_odp_unmap_dma_pages(struct ib_umem_odp *umem_odp, u64 virt,
>   	u64 addr;
>   	struct ib_device *dev = umem_odp->umem.ibdev;
>   
> +	if (umem_odp->umem.is_dmabuf)
> +		return ib_umem_dmabuf_unmap_pages(&umem_odp->umem);
> +
>   	lockdep_assert_held(&umem_odp->umem_mutex);
>   
>   	virt = max_t(u64, virt, ib_umem_start(umem_odp));
> diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
> index 71f573a..b8ea693 100644
> --- a/include/rdma/ib_umem.h
> +++ b/include/rdma/ib_umem.h
> @@ -1,6 +1,7 @@
>   /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>   /*
>    * Copyright (c) 2007 Cisco Systems.  All rights reserved.
> + * Copyright (c) 2020 Intel Corporation.  All rights reserved.
>    */
>   
>   #ifndef IB_UMEM_H
> @@ -13,6 +14,7 @@
>   
>   struct ib_ucontext;
>   struct ib_umem_odp;
> +struct ib_umem_dmabuf;
>   
>   struct ib_umem {
>   	struct ib_device       *ibdev;
> @@ -21,6 +23,7 @@ struct ib_umem {
>   	unsigned long		address;
>   	u32 writable : 1;
>   	u32 is_odp : 1;
> +	u32 is_dmabuf : 1;
>   	struct work_struct	work;
>   	struct sg_table sg_head;
>   	int             nmap;
> @@ -51,6 +54,13 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
>   unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
>   				     unsigned long pgsz_bitmap,
>   				     unsigned long virt);
> +struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
> +				   unsigned long addr, size_t size,
> +				   int dmabuf_fd, int access,
> +				   const struct mmu_interval_notifier_ops *ops);
> +unsigned long ib_umem_dmabuf_notifier_read_begin(struct ib_umem_odp *umem_odp);
> +int ib_umem_dmabuf_notifier_read_retry(struct ib_umem_odp *umem_odp,
> +				       unsigned long current_seq);
>   
>   #else /* CONFIG_INFINIBAND_USER_MEM */
>   
> @@ -73,7 +83,14 @@ static inline int ib_umem_find_best_pgsz(struct ib_umem *umem,
>   					 unsigned long virt) {
>   	return -EINVAL;
>   }
> +static inline struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
> +						 unsigned long addr,
> +						 size_t size, int dmabuf_fd,
> +						 int access,
> +						 struct mmu_interval_notifier_ops *ops)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
>   
>   #endif /* CONFIG_INFINIBAND_USER_MEM */
> -
>   #endif /* IB_UMEM_H */

