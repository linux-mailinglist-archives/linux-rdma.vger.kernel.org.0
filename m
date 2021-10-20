Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE256435654
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 01:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhJTXRS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Oct 2021 19:17:18 -0400
Received: from mail-dm6nam11on2053.outbound.protection.outlook.com ([40.107.223.53]:27905
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231308AbhJTXRR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Oct 2021 19:17:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+Lj/EZLx7Ybr6Hj7naHJDkKS8N2z277n8h8B3AYs/Wx7r7mHtMWsWPG7sRIr7pR2XE4xGzICk9GAmq4P/c1K5pzKTbZiSs6G99RzNKxZdhXoI3fLHbCukg04mQoEWig3Hk04LNppGMW0QSj4UB/kTCh/L0kyd61ESc2TY1EdNYyMQDbkgo0syWR3Z+Qvy2PHCVPyMl6Cv8YpIXKfJYWQcKD71YIJWNsG6bGi4DqN62+ozXt/ynm2W9pzsq9D8nriHKgzgkeiMe4TuL/nHRUAQLo2a5SdvPg0IeyYFnmQF914v5fmLcGIcjbNpGIruB2qF0UFLTMVUwBtUQWkgQoNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LT5wppl4rMvyQqwLdANGHcBrDm/e3+Cd0JkXhLqPSM0=;
 b=W1ORHBI1EsE6tabeCr6ui0ISbPlKUYIyyf4xhRQcJuQ7bm+G4DEzfCUXi1upW5YzKAEbJikWDs4Bz2BrsFTmm/svhPMn5qyo7Y6Keiazt9kK2V+/sY75d+vp0UlJO/G+hCKL2Dsh8dn2Rmituhd1L82bNLnU5XpqtRjPM/z2g4TRkF2jm2TEAbseH+B8/NxkQw9wCu5paH+xfM1mcRt0H7Z7ipvipYRXFR2OLVjksql34a6Hv7cq3yvITXJbAUCZ6i9O3wCiy5VxYVrGVrdky5mpVzAwxEt2ahMEaC3mMxXS9QLq4YOIUxcn7f4iHoz4+yZv2JDWPvyCRbIDva16ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LT5wppl4rMvyQqwLdANGHcBrDm/e3+Cd0JkXhLqPSM0=;
 b=U5xjXj3W8NHuLZieevGmZS2nE/Z8XTtoaiYMr33wc6K3O1FM1XNPFyy1UA8xi+zyEWdnpXSCnP5jACTKSiobE+/Z0ncxt/Eecj5+mt07eoWi47LL2aqQ+63W105CElPNnRAIqBRVwZ4VmzwyfUF3tLlX51DGMGAfqZgvQUurcnOLcuKJbYxAlQHEL3AuJ/E1wQoDuTsl1UtOvG6xvzeGJwk7B8LiVrjvuBcraYQy3iAwGVJUG+YhmpzrcJA4QuUTvq2SMGFfEmvwvwkVdA1kwVbY3YdjAJ3N9DrhxOHB6LhGsWm7nit9KWB04V8m0+cYWpE5pHSz4oWEEHq/Z01TzA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5096.namprd12.prod.outlook.com (2603:10b6:208:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Wed, 20 Oct
 2021 23:15:01 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 23:15:01 +0000
Date:   Wed, 20 Oct 2021 20:15:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next] RDMA/hns: Add a new mmap implementation
Message-ID: <20211020231500.GA27862@nvidia.com>
References: <20211012124155.12329-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012124155.12329-1-liangwenpeng@huawei.com>
X-ClientProxiedBy: MN2PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:208:a8::36) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR12CA0023.namprd12.prod.outlook.com (2603:10b6:208:a8::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 23:15:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mdKnU-0007LG-6i; Wed, 20 Oct 2021 20:15:00 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e3f1a73-4896-436e-9b77-08d9941f710b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5096:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50962C01A35257B6461C0D18C2BE9@BL1PR12MB5096.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NWbX1rEOhavx2xQAvJHo6BPN1xFPcbt8igtEa1qaqWj1VEOg9ORuHH7JLeEgQ9me5vkdkwRewsw5LoQmKDnwUjq8kPQsuFVk1ykrCbYXGGpM+Adhm+fjIQnUqbEVvE7OIyxlykQFVlk6xfZ4OcNUoNrLbcD2xqQQUNLuuDKYo6eecqbYf35ixjEwH3Qc5FMo7ocCrAZW6uOnD9pw56aT8G8D8vtoB1kcEZ1khILB35IOjAH5X5shudggiUPfTiLirdxc7EB+t+7Jx3DNaFD1UskjMMtkGjteGb69RjQGCHK0gg5eHC1lh6W3VAbIhz3YDZAqmfQXxeldGQXpvYh4g8JzHfYF+7WoWDG1unXZlAZqbCdY1qAEK8+Pk+RK5L4Gq+e2wtuVZG/6IptGNr3j1NpOpArGS+EiqbNvK8vnFeNVhr9dUwChb0b27caCIRROWJcvNoiJOm0nq9ErUGFe0iPYvxJF377OyvFWZ3Fukh/YL80IUod7TIJQhvsVIpR5FRPb4VeW5+ZOEXR1NTRSgkZ6tJv3s3urml1/V7DrBu90hQ8q7y5AucIk1UPqyPbtPKHhcP4SDkx/FzBsjJLo7j48Q9jXfiMO394K6HcbiiceRomRfGK2t7mVksQl0LJfXImVOfqvj5+mHO5hCvHeRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(508600001)(86362001)(186003)(9786002)(8936002)(36756003)(83380400001)(33656002)(2906002)(5660300002)(8676002)(316002)(426003)(6916009)(1076003)(9746002)(66476007)(66556008)(66946007)(2616005)(4326008)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IiU9Gc94h0CBXqm4t5II9OfXG1ZdQ7vv6RbHLqqXAb3n48GQvj+ed8wAIdJU?=
 =?us-ascii?Q?7Pqm21Sn9wB3PGYIagojxA+/9KWsnhFJa3b4H52IpH4uMRUYYpQpcjh2hNVe?=
 =?us-ascii?Q?0iUDuSm32VMiVxawOMHyVFlWlBoGq6WsmmczTfBodLNF2N7+V/itRLhITqoN?=
 =?us-ascii?Q?aKWAQRp2IqpYs7CSVmcga45Hr7xJJNfW6PUuU+YuuOgYec2v/iqE4w4USFrY?=
 =?us-ascii?Q?Ciuq03Hp4FLiIRha6p/R2yd2xDrzrstiwomzo40nTi6XKfn/mILVdclRW5D6?=
 =?us-ascii?Q?scVaUY2K/kEKn3P8fLeX7ece/s6n/WDk3cNA3Llzo7oSJ9c2anVEskR7Jf5G?=
 =?us-ascii?Q?GndibJZW1Z56mZh1esl6r0UDIA4fn5fV7Wk5XWH0dtvKvVGIRJqpC5nekrc5?=
 =?us-ascii?Q?KdZG1oxdMgIqEAQbqUBIItp3m6bEJwJBQ+QReZ7q1gHT1PCxQxe2AgVwn8tT?=
 =?us-ascii?Q?MZmx+mtVYBGAJrChgo/RZXShc0WU2fvaLyq/I7evoOl+ZNoX2/GOgkfudFDD?=
 =?us-ascii?Q?b23fxO6WjpTOd2PWkErQWIrAKMkH5AG/sY6EWJMX3iIRh5oOnFTsjUf70kyK?=
 =?us-ascii?Q?zOuh+wHtMTiKm31QCJQatesSCV85kv1vs2w+QzUIeF6jpOQFBdVWQjVG7loP?=
 =?us-ascii?Q?T6Xkm6dnjGNHQ5t+gFzDu5MAW9TsAQVFPgqjp85B8upT6yKkLDBCFNGrDEvf?=
 =?us-ascii?Q?8PJ+nBs1oE5ytn+HKUHbyhuMV76DkhrVbkXyWHfXtH/MyEHmtTWUjhiBO9wP?=
 =?us-ascii?Q?tGqU3ZaXaRY8hfs0RwLut4S7oqTEOknEQgI3mdixBiClTXvKtOc23j42lTAp?=
 =?us-ascii?Q?7QjGZAnaz5ZhnILsg2vCuX/GEgPekmpd670cu3dIdhDqZWyY/bNS3QGt8aEK?=
 =?us-ascii?Q?hJosukQw9B4GC9Ipu4fIvjgvDtZ+DtiPVaECY5/5V/DTqwS24oIgddJV9Dbv?=
 =?us-ascii?Q?guoF77VE0siST1ZMDTcF66+vA8jRk+HQYY+ErFsP4Hsi3MR2DUAJyQwgqeOI?=
 =?us-ascii?Q?a5Ryf4BXUEqoQ4uECpAEVN9L2igmfE/2l4IDqFFA1e3Z7+RaL8nwIQxaGynA?=
 =?us-ascii?Q?kdkpCsonLFw1V+e2KCAE4f1KHdurciUc/EyOyVHq8kGV/roaMA5nEwWfWH5S?=
 =?us-ascii?Q?flvUIiiN4G/Yn0F0v+EJESAcWWzGFGHni/Hdm+HbQT2YtmSs1+MrR6pG8mlS?=
 =?us-ascii?Q?TkPG0/pXbwuZFxRQZXFh3YrZ/Qa/UDgZI7haHcHDRtCgOyB260SnJT3xkAAF?=
 =?us-ascii?Q?2UYW0mmJxbawDbcFNyKINPgvDGkvtTjC1b0wwxIhEFZqtb5nNcx+K5NURibT?=
 =?us-ascii?Q?CmZY9dE5dRglWhzcK7Cmtlnm2QBmHr2FzLd9ZB9rCwS97emU5Bz3eQDBjH/U?=
 =?us-ascii?Q?nneC3CbeXtvwW1fXc+QzK40Orry7c5xDVMKhBe6LqQhrUlMHIxMnPxLGOGOz?=
 =?us-ascii?Q?oKj4pnHFmTQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3f1a73-4896-436e-9b77-08d9941f710b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 23:15:01.2751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgg@nvidia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5096
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 12, 2021 at 08:41:55PM +0800, Wenpeng Liang wrote:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> Add a new implementation for mmap by using the new mmap entry API.
> 
> The new implementation prepares for subsequent features and is compatible
> with the old implementation. And the old implementation using hard-coded
> offset will not be extended in the future.
> 
> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_device.h |  23 +++
>  drivers/infiniband/hw/hns/hns_roce_main.c   | 208 +++++++++++++++++---
>  include/uapi/rdma/hns-abi.h                 |  21 +-
>  3 files changed, 225 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 9467c39e3d28..1d4cf3f083c2 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -225,11 +225,25 @@ struct hns_roce_uar {
>  	unsigned long	logic_idx;
>  };
>  
> +struct hns_user_mmap_entry {
> +	struct rdma_user_mmap_entry rdma_entry;
> +	u64 address;
> +	u8 mmap_flag;

Call this mmap_type and use the enum:

 enum hns_roce_mmap_type mmap_type

> +struct hns_user_mmap_entry *hns_roce_user_mmap_entry_insert(
> +				struct ib_ucontext *ucontext, u64 address,
> +				size_t length, u8 mmap_flag)
> +{
> +#define HNS_ROCE_PGOFFSET_TPTR 1
> +#define HNS_ROCE_PGOFFSET_DB 0
> +	struct hns_roce_ucontext *context = to_hr_ucontext(ucontext);
> +	struct hns_user_mmap_entry *entry;
> +	int ret;
> +
> +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> +	if (!entry)
> +		return NULL;
> +
> +	entry->address = address;
> +	entry->mmap_flag = mmap_flag;
> +
> +	if (context->mmap_key_support) {
> +		ret = rdma_user_mmap_entry_insert(ucontext, &entry->rdma_entry,
> +						  length);
> +	} else {
> +		switch (mmap_flag) {
> +		case HNS_ROCE_MMAP_TYPE_DB:
> +			ret = rdma_user_mmap_entry_insert_range(ucontext,
> +						&entry->rdma_entry, length,
> +						HNS_ROCE_PGOFFSET_DB,
> +						HNS_ROCE_PGOFFSET_DB);

Please add this to avoid the odd #defines:

static inline int
rdma_user_mmap_entry_insert_exact(struct ib_ucontext *ucontext,
                                  struct rdma_user_mmap_entry *entry,
                                  size_t length, u32 pgoff)
{
        return rdma_user_mmap_entry_insert_range(ucontext, entry, length, pgoff,
                                                 pgoff);
}

> -static int hns_roce_mmap(struct ib_ucontext *context,
> -			 struct vm_area_struct *vma)
> +static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
>  {
> -	struct hns_roce_dev *hr_dev = to_hr_dev(context->device);
> -
> -	switch (vma->vm_pgoff) {
> -	case 0:
> -		return rdma_user_mmap_io(context, vma,
> -					 to_hr_ucontext(context)->uar.pfn,
> -					 PAGE_SIZE,
> -					 pgprot_noncached(vma->vm_page_prot),
> -					 NULL);
> -
> -	/* vm_pgoff: 1 -- TPTR */
> -	case 1:
> -		if (!hr_dev->tptr_dma_addr || !hr_dev->tptr_size)
> -			return -EINVAL;
> +	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
> +	struct ib_device *ibdev = &hr_dev->ib_dev;
> +	struct rdma_user_mmap_entry *rdma_entry;
> +	struct hns_user_mmap_entry *entry;
> +	phys_addr_t pfn;
> +	pgprot_t prot;
> +	int ret;
> +
> +	rdma_entry = rdma_user_mmap_entry_get_pgoff(uctx, vma->vm_pgoff);
> +	if (!rdma_entry) {
> +		ibdev_err(ibdev, "Invalid entry vm_pgoff %lu.\n",
> +			  vma->vm_pgoff);
> +		return -EINVAL;
> +	}
> +
> +	entry = to_hns_mmap(rdma_entry);
> +	pfn = entry->address >> PAGE_SHIFT;
> +	prot = vma->vm_page_prot;

Just write

 if (entry->mmap_type != HNS_ROCE_MMAP_TYPE_TPTR)
    prot = pgprot_noncached(prot);
 ret = rdma_user_mmap_io(uctx, vma, pfn,
			rdma_entry->npages * PAGE_SIZE,
			pgprot_noncached(prot), rdma_entry);

No need for the big case statement

> diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
> index 42b177655560..ce1e39f21d73 100644
> +++ b/include/uapi/rdma/hns-abi.h
> @@ -83,11 +83,30 @@ struct hns_roce_ib_create_qp_resp {
>  	__aligned_u64 cap_flags;
>  };
>  
> +enum hns_roce_alloc_uctx_comp_flag {
> +	HNS_ROCE_ALLOC_UCTX_COMP_CONFIG = 1 << 0,
> +};
> +
> +enum hns_roce_alloc_uctx_resp_config {
> +	HNS_ROCE_UCTX_RESP_MMAP_KEY_EN = 1 << 0,
> +};
> +
> +enum hns_roce_alloc_uctx_req_config {
> +	HNS_ROCE_UCTX_REQ_MMAP_KEY_EN = 1 << 0,
> +};
> +
> +struct hns_roce_ib_alloc_ucontext {
> +	__u32 comp;
> +	__u32 config;
> +};
> +
>  struct hns_roce_ib_alloc_ucontext_resp {
>  	__u32	qp_tab_size;
>  	__u32	cqe_size;
>  	__u32	srq_tab_size;
> -	__u32	reserved;
> +	__u8    config;
> +	__u8    rsv[3];
> +	__aligned_u64 db_mmap_key;

I'm confused, this doesn't change the uAPI, so why add this stuff?
This should go in a later patch?

Jason
