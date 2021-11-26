Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D74A45EDC1
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Nov 2021 13:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhKZMVj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Nov 2021 07:21:39 -0500
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:12896
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234003AbhKZMTj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 26 Nov 2021 07:19:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MT9/lYpcFp+lFqoEpf0hkGJJi6y/BDRA8ethBWMXw891Wka3inny3+dJ0rnOUXNFqN5KjxyTdlOW7mN4gwpWxxIhGIfzk5xwLtEKyvqTNTZXOnwlpvtuA6HnmUA69u6kIeXMg9ayuBxYJ6FGltT/4wZO1IjnORp0AbtlCQ/AcDyjynGjMOwyf8QFQSpKmEzXIA7jBqPSap9X49PhQFV47LQaj+DzlF0lKdrHHRarTN0PiFTyP7RCDh6YUgq3fmgqA86Fu7QqU/PKhbTuFnnhbaX+sEoJ/Ic2fw7gIruCNAFbZbuamNTtEqG+YPDDMgcA19KFuXE2AH/PmXpceQUD/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDn8GKXIFYxeGvDTTftzy4sc7dbImUck6REPYym7kNM=;
 b=XCadpo6BLDdcKkQYa12Wkps8z0hvvg6IbZ7NPNThgMv12L9Ath1NaKUZHnheTtFbOLdZTLEd/JHfHmW6yUpq4H/Edf6P4bMzVppAGYSahvcgvciukEI5Ax3MckwCrpXiW9qzTKZNDhQPMUVzhFa2TbQijyybN8ueVa4oIawaExYA38caEu4PHxB6MLyT5MlbH9lFuX3JhY4Uh4CwcctdZMiy9pT8YNOKyUoqWP8sedkfpnf+urpmhBX0j0KyIxXbY4HGkjFKEApZvzIvo+n1mLRDPBk4AOQSLyYD8WK825JGcPgWlAP3IoV4yh+4+rVUkLcEXfdqEolHaUG7rRBmiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDn8GKXIFYxeGvDTTftzy4sc7dbImUck6REPYym7kNM=;
 b=Mk83WKYpDPEODBNEowYijKGElhGRGx195mDxur8tmn3CMO1mYMm+h0vKrsOBCuu5LvdZge36tW5bI6/7lfUZWiQbS4CAZSe994QvXKo1OmfW/zpXL8irqcrgJxXgUYR+V2iKLDpgybvCxt7OajKecJyOrJuN9tGQLY9mWVPXdv4e2w/dI+d3AVIaNbHQXGYDJTm4WBJ7RMDL9iBQmlGNIIyJX2lAIJyFciA7OCBna2jLVE/eUMDxDKHK2keFyMjpKy/WLGgdNHdECjPR7HvxM+ZyR8PhAlimnGPrTI56DegINm/FL3dAbJ47vOQxZA+LZOkXa/+8+TeJzdFKfPJ1tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 26 Nov
 2021 12:16:24 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.023; Fri, 26 Nov 2021
 12:16:24 +0000
Date:   Fri, 26 Nov 2021 08:16:23 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v4 for-next 1/1] RDMA/hns: Support direct wqe of userspace
Message-ID: <20211126121623.GQ4670@nvidia.com>
References: <20211122033801.30807-1-liangwenpeng@huawei.com>
 <20211122033801.30807-2-liangwenpeng@huawei.com>
 <YZtboTThVCL7xs5s@unreal>
 <20211125175044.GA504288@nvidia.com>
 <9b3e8596-a386-667b-b8b2-21358331d681@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b3e8596-a386-667b-b8b2-21358331d681@huawei.com>
X-ClientProxiedBy: MN2PR20CA0054.namprd20.prod.outlook.com
 (2603:10b6:208:235::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR20CA0054.namprd20.prod.outlook.com (2603:10b6:208:235::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21 via Frontend Transport; Fri, 26 Nov 2021 12:16:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mqa9P-0033Bu-5N; Fri, 26 Nov 2021 08:16:23 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 019e9111-a14f-4d3f-73f3-08d9b0d6907d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5288:
X-Microsoft-Antispam-PRVS: <BL1PR12MB528867A7FFF21ECD2C7A76ADC2639@BL1PR12MB5288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dGaF3yId9U52FxOidlMcu7eID/8B0YdGD0Dx8ajMUDQz/ceVmSk2Me6fkRl5Oj7A+o9L7st7xRm0TA7hA4mePN2/70Agg3X0nc5dm2t/6M1kgNPUn8h9y2qj+jxK/9E1lTJg/VTm85J3RRMFAKxjfK8d+GoHCdeQlHzYzA/fRap8hYgXYzuLni+NYHfbl9j0R9yMTsyx/EKcONfIeL5tQuvM9L+mj/+XrMFqAwJv/u5VatisHoDndpGX9z+oPBbvo3Tp+gxGd/tcAdUwIZEhVyDB/W2Kea2xWBDByEzgQRrEThEFLV+bqp4FRKCtKgN7piHuy9o3tCLARY4nilLS4aiPBF+BolnRPkvsFa1IdK5/MmRecB30ToEIyE0XjYGMSRc2ycKqfPNi3U8dYvjIiLGmXl6mkjAg4aMECgQ50yCMzU+1RWANIsxLEO1fBBoxyN/b0dUJP6n4U6mCzckRC9yFTqDKDsQ8sPnaZMd0AlyxSZ1ACkKeCcBJhBWdRM2KRoBTrjMV+1MQzrMLZYzazxU8iZRJH6zqnSGW4bmHfb2Z90R0jMOtpYOzQ/sBcd80upWoe/3jR7nP2mHC6MYTaq/9NItero753c6mKpa/Nnjaf04DUNqbKWgqqH4s7poXQRphV2q1ltpr4p7jbSY48w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(316002)(86362001)(426003)(83380400001)(2906002)(8936002)(6916009)(186003)(66946007)(66556008)(66476007)(8676002)(26005)(36756003)(33656002)(4326008)(2616005)(1076003)(9746002)(5660300002)(9786002)(38100700002)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zyieaDWtEWrym/R5mkej0N+bIXs1OZMsaJIww1kPVrOl1cizPJL/NqR4nWYg?=
 =?us-ascii?Q?Y0x+AU6XZqtWbrQropV7g7KrQNXTaft0WNfB1sKCH/jM6PW1ftyh1SXyOdI2?=
 =?us-ascii?Q?tPBHMKDEn9eUbxkZxyTXgPmsgUbNCZuC6uYRM68zOCDHvaSXWLPgFr8RjjJe?=
 =?us-ascii?Q?BMo+0mRGtK9eGxmYbwBB6TZ599m3JtTPxnYZr7JAwkF8ymuM7QCRFWVfToGU?=
 =?us-ascii?Q?v/jQSEX1V2VAzrDYfealTPxQSlW8wbeq4r59Ky0K7VkUyoHzQAZSYsOcTlOp?=
 =?us-ascii?Q?gavkP53dYqcqHk7Jqubr3wCw2shdQ7avxUM4RZ2PUCj+428mQ/XIH7NNb4P2?=
 =?us-ascii?Q?2KJOevwP2+0oeo/G1D35TSamCckbUSDN0P5TXYJ6l/eQgfh04ZQJJnMYtc+Y?=
 =?us-ascii?Q?f9XnygdBZNd3G/Jee1cTl+cBRpW5cICf7dd1sa9A5gH08Kx/gpbS6sHZ4vWN?=
 =?us-ascii?Q?76PnlEbGOGlNjFsd+ZMKh81hmhbZ//LscP3zXOlWmq0lEf7egcXyPx+fldfv?=
 =?us-ascii?Q?Y3p7smKju19mE5cvv+a80+IwEOaLe/kAbSs+/MeeB+Ecdaqsbje09s4dW0if?=
 =?us-ascii?Q?ahduvOgnV6d0GaOGyXoMEHmXcK2x9mA3Rp6cV41t4S1S1lF/6M6AWjUjAjc6?=
 =?us-ascii?Q?+/MfK8qpFnvZgdIlpXP9BxERlN5v0EZA/QcG5KQqAmlMwlV7dtvRKv/0NL1U?=
 =?us-ascii?Q?qo7QOhqdvf6vEUIE8hq6DVAkMpiMjWj+s0J0wJeRwLA9Sg7lk9AZovcFn+uB?=
 =?us-ascii?Q?T7epAp+k1ebbPFeCW0BmzoAH+wAq3dYyBRiAbIEMNvsZ+iwnI/UjfR6ANHyO?=
 =?us-ascii?Q?RsYfanhNBktsslDV/xtFEdYiiAT7XAtkEbrRca2N/UqXrzLBPzjDkbuUb9qM?=
 =?us-ascii?Q?IhM1dNt83oazvJWAeweseobHIs+2U7g+AP0rnVJf5BkH1ckK1YtTFWyv3SMh?=
 =?us-ascii?Q?J7TYM75BUQjUdgjG3z4InUpQAy3zRrrwb6O1ahr4DEtmJ3eaAUYrLyqy2eRw?=
 =?us-ascii?Q?vsMp5Y5mEQWr7CGaJn9zLa1x3y+r+6z81zVHXROR3ePYSw+HILk6jQTKbfJR?=
 =?us-ascii?Q?L1FGD4tGZjzRrwrpGS4fy/LPDUCI48Wnx1jkp+f48Msg2KuK/xFNPfzde2es?=
 =?us-ascii?Q?yCpecNtCbGgkLJyvURGuGYY3wpA4WUMKGLYYdXALKBQ1s2yJWFf4JuURI6py?=
 =?us-ascii?Q?ZGupNsyCXWl+LJA3l8Usw52urxWhozdfr35bWS3XmMwkXdE+aJAoVSLjgyPs?=
 =?us-ascii?Q?ZmWy2YaHBKfevub82ebg4x3PlQxVE18PiwUBBkW6mNiASXfvh46A34w7oZtQ?=
 =?us-ascii?Q?fuREp2C81BX27KzT/Dn48WT+J8CJRrDwvwsM6Wa4Dl5sbCMMEpM1aPRezyB3?=
 =?us-ascii?Q?A9J3lywseRM4zGpsiRT7oKd9qXmgq+qybgtpl3UpKtacFYjJehyaLIK3Tymo?=
 =?us-ascii?Q?WOadeRLnYQPg5CQaRe3xo2k6JzA90frtg2NTEunafyJd2wzvijSRejLwikyD?=
 =?us-ascii?Q?Bt8YrGaDptgG+M72jJQbHXj1iAaQr7Tc+SeLbk4Uz34vhqR67O5NLF7kbbLt?=
 =?us-ascii?Q?JZY6XJftjWFyu7hRadI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019e9111-a14f-4d3f-73f3-08d9b0d6907d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 12:16:24.4341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJz/OH6yGtpxiTbg71Imsg5Gq9VX+JcXKmARI4H1yEW7a1imd0fA70uKk88g3RBQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 26, 2021 at 04:25:27PM +0800, Wenpeng Liang wrote:
> On 2021/11/26 1:50, Jason Gunthorpe wrote:
> > On Mon, Nov 22, 2021 at 10:58:09AM +0200, Leon Romanovsky wrote:
> >> On Mon, Nov 22, 2021 at 11:38:01AM +0800, Wenpeng Liang wrote:
> >>> From: Yixing Liu <liuyixing1@huawei.com>
> >>>
> >>> Add direct wqe enable switch and address mapping.
> >>>
> >>> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
> >>> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> >>>  drivers/infiniband/hw/hns/hns_roce_device.h |  8 +--
> >>>  drivers/infiniband/hw/hns/hns_roce_main.c   | 38 ++++++++++++---
> >>>  drivers/infiniband/hw/hns/hns_roce_pd.c     |  3 ++
> >>>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 54 ++++++++++++++++++++-
> >>>  include/uapi/rdma/hns-abi.h                 |  2 +
> >>>  5 files changed, 94 insertions(+), 11 deletions(-)
> >>
> >> <...>
> >>
> >>>  	entry = to_hns_mmap(rdma_entry);
> >>>  	pfn = entry->address >> PAGE_SHIFT;
> >>> -	prot = vma->vm_page_prot;
> >>>  
> >>> -	if (entry->mmap_type != HNS_ROCE_MMAP_TYPE_TPTR)
> >>> -		prot = pgprot_noncached(prot);
> >>> +	switch (entry->mmap_type) {
> >>> +	case HNS_ROCE_MMAP_TYPE_DB:
> >>> +		prot = pgprot_noncached(vma->vm_page_prot);
> >>> +		break;
> >>> +	case HNS_ROCE_MMAP_TYPE_TPTR:
> >>> +		prot = vma->vm_page_prot;
> >>> +		break;
> >>> +	case HNS_ROCE_MMAP_TYPE_DWQE:
> >>> +		prot = pgprot_device(vma->vm_page_prot);
> >>
> >> Everything fine, except this pgprot_device(). You probably need to check
> >> WC internally in your driver and use or pgprot_writecombine() or
> >> pgprot_noncached() explicitly.
> > 
> > pgprot_device is only used in two places in the kernel
> > pci_mmap_resource_range() for setting up the sysfs resourceXX mmap
> > 
> > And in pci_remap_iospace() as part of emulationg PIO on mmio
> > architectures
> > 
> > So, a PCI device should always be using pgprot_device() in its mmap
> > function
> > 
> > The question is why is pgprot_noncached() being used at all? The only
> > difference on ARM is that noncached is non-Early Write Acknowledgement
> > and devices is not.
> > 
> > At the very least this should be explained in a comment why nE vs E is
> > required in all these cases.
> > 
> > Jason
> > .
> > 
> 
> HIP09 is a SoC device, and our CPU only optimizes ST4 instructions for device
> attributes. Therefore, we set device attributes to obtain optimization effects.
> 
> The device attribute allows early ack, so it is faster compared with noncached.
> In order to ensure the early ack works correctly. Even if the data is incomplete,
> our device still knocks on the doorbell according to the content of the first
> 8 bytes to complete the data transmission.

That doesn't really explain why the doorbell needs to be mapped noncache

Jason
