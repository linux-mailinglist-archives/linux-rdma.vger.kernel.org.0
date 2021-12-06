Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE654469F60
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 16:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386300AbhLFPrT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 10:47:19 -0500
Received: from mail-bn8nam11on2046.outbound.protection.outlook.com ([40.107.236.46]:51188
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1389838AbhLFPlP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Dec 2021 10:41:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLkvOiJ7j0ZRLCKFfqoPl5vU60a9ixjbcDmpkyCM7Xkb/xOQdSHR/xBXEcU++1MKtGAQepMv7zpK2iEUai8oamCA+RmpfpiIvoqvuoY+a0Cp0/X8PovjsqjZGdjfyMOALUyUw0MUpHBseM387gwa131IStCvcaFvlvB469nyVZJ9SlU2wwF6Ij7M2eQ8i9Ejlwk71Gs+E8ln/MHGxfBKCApjg/knWONKjYtya/Ss93lU7dxtiYTByjQzHKDLqbzRHsDSF5Jo5Hy1k8b6aW7R146EebmYJJOvoIrrmAUS3z3hHrPf8NYeUtKGQJQou25b7beKxMGZyV2BzrtJM8T7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5CHtP8xyff01ZhkM9CNTOoA4VwfACvBV4kNqVRobDY=;
 b=UfMas3BNshfqmCZ5S+eKMjbDOAADlrUaki7eUhEm46gncpYmTClUyGsG40t0JhDQ9qSa3QMfhI78dymdS6HIy/+f4xA5g2qDar351HesoEVZ4+KlSucPHghO0/B6IdQeX97e6e6lwSesC5OqBZcY8gCxQsHvW2rtJtFF2mFQe03wdG9RlKtmUQ22LozwEqkCFS6g3SP4eG3ItBgUhpWniylCIW/lRLXECBXh1yi/6M7mYowTkk8SfPWiw5KT+IyEZL+jJ4i0RxNckBqmFl3EN6vdR1V+NLNPEWOMCpNzdOg4Q6h7+skOE9jbw/oxbt3zJf5ArrwIGR6dHJnbhYWnoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5CHtP8xyff01ZhkM9CNTOoA4VwfACvBV4kNqVRobDY=;
 b=NLkVH2BERSHB4CIc4+MyWYIByc8iMV+EHz0vdYQOnBHkE99jwWMg3q15o/a7/GF0QaAdqKV1P+Xeq1Xo/m/kPYXppxr194UPTsjAuMtn7PQmZRmgS949DuYGBlj9wUYZB2ii8gOnyaq9GVMUie+7L8MRmEoJncl7mlEzcBE0PEFL/Up5q/DekpL+ytbUkkoY+W6ltA8btnibCY6+mTf0X48kHo4+EEdZ87J4nq5i8uifae1PgYj1RW1t9mTCn/fKvq559pQE6IP/Anl41o8kyOuZMlipGgktxQaAghMkpa6ePzk0wEFtnNrr1mf8Hm+YwCoa6tUilZ+95hyuc+Hdug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5380.namprd12.prod.outlook.com (2603:10b6:208:314::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Mon, 6 Dec
 2021 15:37:44 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 15:37:44 +0000
Date:   Mon, 6 Dec 2021 11:37:43 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Modify the mapping attribute of
 doorbell to device
Message-ID: <20211206153743.GI4670@nvidia.com>
References: <20211206133652.27476-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206133652.27476-1-liangwenpeng@huawei.com>
X-ClientProxiedBy: MN2PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:208:134::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR16CA0011.namprd16.prod.outlook.com (2603:10b6:208:134::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Mon, 6 Dec 2021 15:37:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1muG3j-008xsO-GL; Mon, 06 Dec 2021 11:37:43 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7cdbe74-abe7-4df5-f739-08d9b8ce58e0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5380:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5380C652CE5E002B6A8828F5C26D9@BL1PR12MB5380.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MAIjRTr2eIx4IrMugCJDC71Qf+wu6IsnoHBuWq670JJVhK8JaTbBbcW6mnXxnppaAUpYBqkTiUQ/Cc5IcogdqACOtU8PmjZjBHQPinEoaQRIaeVTrUYPGDK/Ac/W82NrXfjZhwACoJVYWDtzSa9571rt49ElwbIibsgCGGag8Ky9M9hPOXTm5JvghLGgMANChQQ6/Bmrj/nKE86QUSq3HTD9DxgbhROD8gu6pbQsT7EMJ0ZeNFxeUMU/ksnV483HEK7R0Xtq9DLg9irc1oYpL3milAwoUMZA3MN8G4buaCULNJXvCu/2G8nzs6BBM9Cd2huDsi5H6FlpjUEUyImqNgXf4cL4mckGqx4ro/uaF/T0XE4ykD6ShI1gaLGmmQUrIoEYtezDBgTaRXQJAZaUOP0RTWCZk0Re+dCfn+K0H6s5fg64b+1K+Z/UN28bQ/1A9T6aVuDMmozwwgp6BaGdM3qJGClO5nDWIPpV7P5uZmv3pt5JjU0pMasP3BOXU1wyR0Hd94aivqoriSlWRUNONCKaRb6S5UMoP26pKoEEEUSGDmhMXC7R7gyj4PKydycr80ncjpSa3CETk8uuCcFRTzIjHterihbKHTMnI4A6896LpfxDyhZeKT7BIzMQ1uVdsikDtNxuu1e6wYunFeqzJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(1076003)(66556008)(66476007)(86362001)(508600001)(83380400001)(316002)(186003)(2616005)(426003)(26005)(9786002)(2906002)(33656002)(4326008)(8676002)(36756003)(8936002)(38100700002)(9746002)(6916009)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vrUqVF/dVlgNmv9kNAV79DIvB3f+xhamboxvRxXr/jHj6BpU84KkzF5BrfS/?=
 =?us-ascii?Q?4I9cRcVhL0q7K4clvA8VoVCr6CV8xqLlzS73qyZSQM3gXMVXZlk2ObTfn7O1?=
 =?us-ascii?Q?fri7a53hKWP2hs53HpHyhLQlqybk8W/LElP6OSdN8XTP7cumBR826lOW2tb+?=
 =?us-ascii?Q?CHVREXDepsWv6PhZRLc6iZ1cGsrBY+VDWaN0wLDJpY4uoGo0PGkgvt7PuD+P?=
 =?us-ascii?Q?4CmLrKAblQfarw3OuFqXuzGCl1ASS5/UNfaX0Gbk1ukJNNgTiD/J/JdXL22X?=
 =?us-ascii?Q?9FKmfOhGO9SwUie7spBVjEmPI1Qvk6Qv0m+vcFRihSlukPUSC/oEvA2c3ZcY?=
 =?us-ascii?Q?WLWzj0sw6Zf4i7Z9MsrY+J4RPfp4UvQCbjai1k4tYX8WQ7CMLdWdq/A6klqP?=
 =?us-ascii?Q?gdyVl2T8A4V9Dkn+LvDB6OZTSYcgmuzIdbn8x73C4khi7biJPboLBRQK9OrX?=
 =?us-ascii?Q?gqiL1rjbtM0OX1fJl6JBfrDYnuyWjaxsA3lruOmyGrqHORRTeOZvb3qIHLYZ?=
 =?us-ascii?Q?ByTNDX7H1AposRxkwEQfIAJ1kBBePkWLIZca+3shYraZI8F+utmGHgwa0B3B?=
 =?us-ascii?Q?MpisHM37TVWNs5ejERQKt8fr68o7BbRG6LYwnmUn6t+ab8LPDg0cgTveeh/x?=
 =?us-ascii?Q?5peRiJ61i+W/ZLbCnPdZ09o946v7kwi/f06AoHFB/f4OYIS1agPILoq1Zbl8?=
 =?us-ascii?Q?LmIGB35OdTt0skCxgr+gRW1sFpBSpOX/oC1/djHK9nmRCUFBzy8ZPPrfgDGi?=
 =?us-ascii?Q?URaMISAKH1U6p8lJ0QDbtEXoGc8CH07eZUep+0SMxuFiMQqdrHn7H5sJJmAc?=
 =?us-ascii?Q?hj9FSVsjXIreAYic5wdPfZ+L1iw59T/GD0r8yBhWEhvi1v4cHZL2j/2mMuPz?=
 =?us-ascii?Q?zonX2fa1GfP7g48IDESTApfc6h1TrsihOQoxEQxqpkoKqq5mx6kEcgAmEt7z?=
 =?us-ascii?Q?Gx2TCgsvrfh/zU92Sza2WvIqPCYDmxHCFmYvohH08SafNCycFTZvK4Yuw31V?=
 =?us-ascii?Q?f9GDfjqxYX+0V5F0FW8IxfAkWtDspyIWaaoKk8xuiMJCzL6i3GF3IQWExcj7?=
 =?us-ascii?Q?fZnXaNtdgpxAtA8f8YlhDfw5ongFmfEXubbORdoALBSw7Y6I8UWy9Kmr5jWA?=
 =?us-ascii?Q?y/2JJnLmur90R7dLkkFsy6v5a5fEnUd+m1V4LGki0MmIxLiUR6Nw3lLdzwQT?=
 =?us-ascii?Q?mzeJ0D91nYYqkUSYQkJVGkvJkvVyAVmxAUdL+5gbrh+T3xixoNNksfRsG/Ia?=
 =?us-ascii?Q?eCigW4jFSTSuvffWjekkKzo/lnOF3i/+ZzL4VTJLIQSL3vVmACMOm26/33Hw?=
 =?us-ascii?Q?/IPSotm5jWA+i3WtZTv1+jHItDgS7TyKYHIAth1au3BafjcfDd7Cmdco+he9?=
 =?us-ascii?Q?aL2E0/v5s+y0xawPJOZfQuDxEOU+JQzZxbujvaebX8paCJQvRz/QO0S9mKBa?=
 =?us-ascii?Q?8G+yhkH4/j/uufoPzZd+5xs0TJw73Hrkiv8ZYagu3Qn7mUAcsftK14jhk3TB?=
 =?us-ascii?Q?SnsLDS2GCJ82mIM4bXuU05fsm1zRxm+B12FlFuINDTKG0MrJTXjJtsieduPB?=
 =?us-ascii?Q?tJd74F/7h+5R1lduByE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cdbe74-abe7-4df5-f739-08d9b8ce58e0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 15:37:44.4641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yan+S/f7BPqrK6wLT+dE7nv2FD3GbrrIVVlV3n9ZXFK4+SdeqexvNPYecyaNomRS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 06, 2021 at 09:36:52PM +0800, Wenpeng Liang wrote:
> From: Yixing Liu <liuyixing1@huawei.com>
> 
> It is more general for ARM device drivers to use the device attribute to
> map pci bar spaces.
> 
> Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

It seems like the right thing todo, thanks

I see other drivers are doing it wrong as well:

drivers/infiniband/hw/bnxt_re/ib_verbs.c:               vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
drivers/infiniband/hw/cxgb4/provider.c:         vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
drivers/infiniband/hw/cxgb4/provider.c:                                 pgprot_noncached(vma->vm_page_prot);
drivers/infiniband/hw/cxgb4/t4.h:       return pgprot_noncached(prot);
drivers/infiniband/hw/efa/efa_verbs.c:                                  pgprot_noncached(vma->vm_page_prot),
drivers/infiniband/hw/hfi1/file_ops.c:          /* vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot); */
drivers/infiniband/hw/hfi1/file_ops.c:          vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
drivers/infiniband/hw/hns/hns_roce_main.c:              prot = pgprot_noncached(prot);
drivers/infiniband/hw/irdma/verbs.c:                             pgprot_noncached(vma->vm_page_prot), NULL);
drivers/infiniband/hw/irdma/verbs.c:                                    pgprot_noncached(vma->vm_page_prot),
drivers/infiniband/hw/mlx4/main.c:                                       pgprot_noncached(vma->vm_page_prot),
drivers/infiniband/hw/mlx4/main.c:                      PAGE_SIZE, pgprot_noncached(vma->vm_page_prot),
drivers/infiniband/hw/mlx5/main.c:              prot = pgprot_noncached(vma->vm_page_prot);
drivers/infiniband/hw/mlx5/main.c:              prot = pgprot_noncached(vma->vm_page_prot);
drivers/infiniband/hw/mlx5/main.c:                                       pgprot_noncached(vma->vm_page_prot),
drivers/infiniband/hw/mthca/mthca_provider.c:   vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:            vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
drivers/infiniband/hw/qib/qib_file_ops.c:               vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
drivers/infiniband/hw/qib/qib_file_ops.c:       vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
drivers/infiniband/hw/usnic/usnic_ib_verbs.c:   vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c:        vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

They should all use pgprot_device I think?

It is the same except on ARM where pgprot_device() is a bit faster

Jason
