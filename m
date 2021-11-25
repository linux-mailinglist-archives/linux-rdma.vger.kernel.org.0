Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A7645E007
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 18:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241689AbhKYR4A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 12:56:00 -0500
Received: from mail-bn7nam10on2088.outbound.protection.outlook.com ([40.107.92.88]:27904
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241880AbhKYRx7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Nov 2021 12:53:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSIs4jLksLxN/Jz5RiFsK2Vf6s+K+HIAozwwvEJqQMt0QY3A5tcNdTqzp46Fuz9ktaWkSMhHdrNGZp/F77Ft1IbhgfufV0YhyBxqXdhNR6XQvx/atEih4NiSYVH1o0mlObPX2eB/xXgZpz8fOwXzwnYQ/s4KpIm8rOSs6CyzgLG7jy+BP+PCFIKZ7hjBlEYY8NjltRRTuP91OsSCpGYZ+r3osUizcA1yl3+WzR6/0PLunc4Akjn/dadeGwXsT8KtF6FOuqeBrYYpdbix8YjrBAO3BmH1l40d+8QvVFMrrNDr8Owya5TDALCh0RJyrGzU0pEOZftxSlOhAbD5ryd6fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lru06TQdng5Ub94r6+hBH/R0tUA4dYFHgGA6ibhigSk=;
 b=jWTjnwqoEJcJ/cYFYePAbqI9Mb1S4Hijw9OH7ahIYOmxO/Wbr1u7UQ/7spfbhhQA6SMjOd4BVWTy3NYxpRZ2F5VzE8fUGOnOBFvXQmenknHYOb2m01QaEx7ARCbdeFksQAsYU+RUyAvTd8zt18sGb4PzWggH3U3auFY9of8OQfmSmbLq4Phb+glIDMUZGouKOu03QwEDGwmfQathlOXiD77Sevr22+XWwmGvlDID40awPKwPQ+tSm+VaL/P80uaoFG+iBwv0KMdSrFojbOQlEbzUIyXfHb17Z0pAOqRz4GGkyLz0ev9rbHn3RIrO2s85LScbWdXZQQRzkQ0+PmI3Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lru06TQdng5Ub94r6+hBH/R0tUA4dYFHgGA6ibhigSk=;
 b=sKfc+9lPThdNzyaHUn+9Cgnc4+ETIcJywt5tn8v2pejkGvtKjZhvUowAwXLYdqon8FovFSw0QXq44jj7pBNoceSbD/5VzB/2ruRK79yt09+NdKLgUgDE19SirYTslpRiBFI9FMcvxAIqcEXor+/COyXlAjIl9jWeOYSjJSfdmSV2A1o3tmp27KO+SjrTQA8aT2q05fLnYASwfdUPrPqrtKT3VeqEEoMY9uTPSBxt1fjj35k90qsOcOSWysyO4a1LJgE9I85JbfPj61WpB60RABafGlLPAXiGWHOggxZoXcl6/6PVIDG84kqaInWzPtYUf4IkBNa6h+qt3Jwr3n9png==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5539.namprd12.prod.outlook.com (2603:10b6:208:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Thu, 25 Nov
 2021 17:50:45 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.023; Thu, 25 Nov 2021
 17:50:45 +0000
Date:   Thu, 25 Nov 2021 13:50:44 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Wenpeng Liang <liangwenpeng@huawei.com>,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v4 for-next 1/1] RDMA/hns: Support direct wqe of userspace
Message-ID: <20211125175044.GA504288@nvidia.com>
References: <20211122033801.30807-1-liangwenpeng@huawei.com>
 <20211122033801.30807-2-liangwenpeng@huawei.com>
 <YZtboTThVCL7xs5s@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZtboTThVCL7xs5s@unreal>
X-ClientProxiedBy: MN2PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:208:120::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR10CA0016.namprd10.prod.outlook.com (2603:10b6:208:120::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Thu, 25 Nov 2021 17:50:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mqItQ-0027Vu-Di; Thu, 25 Nov 2021 13:50:44 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6b8ecdb-52b6-44fe-5a25-08d9b03c1b54
X-MS-TrafficTypeDiagnostic: BL0PR12MB5539:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5539FF8D37ABC35FBE585794C2629@BL0PR12MB5539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+Uwj4rdN66VHw0kd5hGX2YqdCkVTEyJ8UZRb4Z1knif8N0/AgTeVFl7s9OriBIDnaRqgSleMsGaQQfW07YGm7U7de9jXsxYJCxxjx0T26KOccEL9j2+uoIU2BjGLLpVznyYgd99q8h9rejhJ6BgW7uxfhN9500qWQ5HVnIm5YWC9pA/1iXf4DlzOIrkMLPn+GZghxGedteEBqGW9doFXwMVgWim5U/AUhfhd93SZGJp9WG9RhLmhK4q+DfAQR8uRbZddsAJfd46ctTFSR1aIlCZClkoVifO89Ox0wPR18nvi+XPvYDgl2HLx1fh1Vmr8XkiNIH2eLibZgU9mQIi+o/W5hTaRDk9gaJiOwnowemjXBIUUZ8hlfzRA5jc9Y9nYWzOFqn80bSG6FCE+JqhfVdt0pygb4Mji8eAy82jlZc6P8S3RGkKwRAtUSfxSpAsjNBqrmyyCheCLD6OOYVgXLKgvgweH8gUKDJnUSa7wKPxmwWIbX59HamqMSnP+/FAijyPelJhAYOwM4hIKevBWk1kRCMwDxDI34vxAiIIQr1akW+pm+ynOwXMHGZGixsuJ7VeZq7tsk9v51QLmsAREQ09eJp3bp8s251I9gx6iSanuVdHGs4tgI4A8fvAXAs0vjt0slJfmM39vZaqFpXHwGVjSbBjjjuxt9NUZSZPoyhXIyMa1LATd0N9CB1U72c6vpY40ozyXYK1Tcqvkb79dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(426003)(186003)(66946007)(1076003)(316002)(4326008)(2906002)(86362001)(66476007)(66556008)(83380400001)(6916009)(9786002)(9746002)(38100700002)(26005)(36756003)(8676002)(33656002)(508600001)(2616005)(8936002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BC1EyR6g1CQX2ppPy2+mt7+EJ/xmoI8sOLBnazzdZf6/l+3UXa/h35vwSpzM?=
 =?us-ascii?Q?XP9HkZmFzOPJZjfD3JiOgvgomrppv5y5A3YgKelvKekAcYroD/JxGx/BaEV1?=
 =?us-ascii?Q?Xe37ngxWtY8zlCxSb/TTFIfHF75XjWUT2ok2NZ9z23vTNFEDjH9Xw4zGiBKW?=
 =?us-ascii?Q?pEDZ8szqkEIK5c8JKiLvUod/SQWO206Jd52LNA/Tn2sDx/RoXfKrwVYQ2KNX?=
 =?us-ascii?Q?8vALtTRnS7MUEWhyKBR9AJyOcEV8SGq4vkpVoY1N/KGC+p9uaBdoo1zmNpZ9?=
 =?us-ascii?Q?Mt7bhRKdCU8OEA2UtJ1eTGAUfp3J6659KFrkDgiS9RGA0ezMu+/ZpG5KTRsn?=
 =?us-ascii?Q?6h8W845YHlZSuSyWC9KONxVbr/PJYDpk2trCf97Flbj6HkBaOnda22c6MeE0?=
 =?us-ascii?Q?J/IXhx95rtLS1Nd66SQJO2trUWdnLDW0sli2/U+GEurl7/XvEtZD/EiExyUI?=
 =?us-ascii?Q?blW38VcBKfNNimtl13ONIurwmp5kxVdO1suIRppMaohhjYVDfzJpCL0UKVwS?=
 =?us-ascii?Q?5J//xg0Zqf3Vs7bpCscB7MESaVOM6HMdanG47wyrcfhshM246mQzoD9H9y6v?=
 =?us-ascii?Q?s2Se6Cu3KiLkDrXvJRC4ErR5Q8CA388MFdgMPGUlL5LF6hRs2aET5FS1d+ZJ?=
 =?us-ascii?Q?E4KxOKbTXnpInJBoy1q8M4oCSg+u/Ae5bSuIkgYLqBC7Q3Eb44Vd+xxg9RTj?=
 =?us-ascii?Q?OSA7VWjadXAYLsH9EUeUp+AW1tHqaM8t925xLVPiQ2ps5PCNN17LtuTkbuCp?=
 =?us-ascii?Q?MbdcTNIuNFBNPhr8gbdlUTOSmIWYDgAo5prsBLdLxnG4TaBgPHmWTCrkcata?=
 =?us-ascii?Q?BmK/2f+5itSBy6W7AcNdWeMpRsrmNfMvWz1CShIlTjedXhRLQC1LxcxlgaKS?=
 =?us-ascii?Q?6zQzdyogFs3UlkOpXVKD2r1IwMDEkLvlWT9vDr1yJ7YWAa5iB/WCgHWbC0ww?=
 =?us-ascii?Q?oF3krDOe7kLa7k8RGAorotOxIqWWeODqJKbmZJ7Hac9H75XnZYH/SXr/Vg1L?=
 =?us-ascii?Q?KqyK30r9goz+Mbcd5VVQqm0JkljnOPF6+5tdZHm87zfsCQhOiXfqqmBaIGI9?=
 =?us-ascii?Q?SoYBElMB+0qbJniDU5VKKoOj4Ck6Z0C5XiKM2ozCv0UNkJZN/e56Xnw4F6Dm?=
 =?us-ascii?Q?a2tujgaTOynCMHPvkEV3zrmJM0DB0pVHHEhjszNio74qjCIZ8s/m58ql1xdc?=
 =?us-ascii?Q?oOqYLZgN9qC2dIZbUdrN2KLdSrRW0sqiGl1tAM/dMAHq/RrlDdjf9eW54ndd?=
 =?us-ascii?Q?VRIMpjPy8GcffgRWM/xMnGIxooCUadJ9pF8MwEo1W1LeLnF0Mqsg88GLylfY?=
 =?us-ascii?Q?JZVbaCRk9JXBT0iZLE0kb62x5bxw0QxGDA9ognOC7BpXFOcgNvMXCF5u+udv?=
 =?us-ascii?Q?YbUiX2XXJWWCPk/utR4FrK1wSSd3uu3KeRKX8C3Nj2CMEuubNCZyBuAHqiQ7?=
 =?us-ascii?Q?XnH52gQTJYtXE6qg/+SNZDrUhh0LaVbQqedWCWCB6ZufBvEfukQQKlWYzSyY?=
 =?us-ascii?Q?A0wRfaJQzK9B8i6VssPbHLeM8kmBh9Bo1mUoM/iTPBjzkdxaZh9YvZgR/NLv?=
 =?us-ascii?Q?OCpPX3Jh2pydsVAWLnU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b8ecdb-52b6-44fe-5a25-08d9b03c1b54
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 17:50:45.4068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NBUU8QYCL0P9dZzuvs3wkEeLTDDlkbF5fuZ4ohQwn/VHVzW+X8QPEX39yKERv8+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5539
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 22, 2021 at 10:58:09AM +0200, Leon Romanovsky wrote:
> On Mon, Nov 22, 2021 at 11:38:01AM +0800, Wenpeng Liang wrote:
> > From: Yixing Liu <liuyixing1@huawei.com>
> > 
> > Add direct wqe enable switch and address mapping.
> > 
> > Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
> > Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> >  drivers/infiniband/hw/hns/hns_roce_device.h |  8 +--
> >  drivers/infiniband/hw/hns/hns_roce_main.c   | 38 ++++++++++++---
> >  drivers/infiniband/hw/hns/hns_roce_pd.c     |  3 ++
> >  drivers/infiniband/hw/hns/hns_roce_qp.c     | 54 ++++++++++++++++++++-
> >  include/uapi/rdma/hns-abi.h                 |  2 +
> >  5 files changed, 94 insertions(+), 11 deletions(-)
> 
> <...>
> 
> >  	entry = to_hns_mmap(rdma_entry);
> >  	pfn = entry->address >> PAGE_SHIFT;
> > -	prot = vma->vm_page_prot;
> >  
> > -	if (entry->mmap_type != HNS_ROCE_MMAP_TYPE_TPTR)
> > -		prot = pgprot_noncached(prot);
> > +	switch (entry->mmap_type) {
> > +	case HNS_ROCE_MMAP_TYPE_DB:
> > +		prot = pgprot_noncached(vma->vm_page_prot);
> > +		break;
> > +	case HNS_ROCE_MMAP_TYPE_TPTR:
> > +		prot = vma->vm_page_prot;
> > +		break;
> > +	case HNS_ROCE_MMAP_TYPE_DWQE:
> > +		prot = pgprot_device(vma->vm_page_prot);
> 
> Everything fine, except this pgprot_device(). You probably need to check
> WC internally in your driver and use or pgprot_writecombine() or
> pgprot_noncached() explicitly.

pgprot_device is only used in two places in the kernel
pci_mmap_resource_range() for setting up the sysfs resourceXX mmap

And in pci_remap_iospace() as part of emulationg PIO on mmio
architectures

So, a PCI device should always be using pgprot_device() in its mmap
function

The question is why is pgprot_noncached() being used at all? The only
difference on ARM is that noncached is non-Early Write Acknowledgement
and devices is not.

At the very least this should be explained in a comment why nE vs E is
required in all these cases.

Jason
