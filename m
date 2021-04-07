Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22A3357885
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 01:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhDGX32 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 19:29:28 -0400
Received: from mail-bn8nam12on2062.outbound.protection.outlook.com ([40.107.237.62]:25761
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229480AbhDGX31 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Apr 2021 19:29:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoQ1KkkKvR3pGXFoeQcgLibTq4snDsNXG7IiwTaHo8q7FPBj2n6BpgIYvAfpCzJNIJydTYl8dqex4lGQD8nfuvyEJetwCNGLo4ghHJZB55PcVaPCYkvogTKH4BhmIbObU9RkLNgzyF/gV5sCNujbNB8YdSgwnS0MvDd01kg/mZD2L7rzPNOr8rEH1NfiYx/KXA9aFVnYb2SPdH/3/SGmucYGunNDTzcVqXkWYll/ktqIyoQ37YO8JLpLLPOYC7Xaf8MAWEsu54UPeUyh24tEZ7ZrVUr0JbeOHQn8ki9cOAHbEyD6wzbTypsOmB6rMRR/TyJa2aPLg0xOI9imJcHoqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxNuwID/pP96Mj0139NQCxvcvKMd/eE/VRMjzKVZLTM=;
 b=CBVsmzBRNYER5/eKY00io3ia+cp8VDvxS3kQAuumVtXmlzKWyteU6Ds3p0n/b4cq5R8PazdrgvIJLG3a/5DzIUxfBlOktVPTNkeF06WA9bkBhisf1VAdvEkCQwKj1sUIMTBFT+EpKVZmyCVxutbCFe3+Cvt7j2C9fYs2iWa/TjIx2IivD73rx3gZGiA6L+2DpDSkQBxL5B4KIHBqfxXq6QEKxq8x4BZ83c610d/ggTIUOB81H7eJ2Bwju/GcJVF1OBfaJc38nwAiARzmDSn5s42d4kLTbn6hEV6simR+nECAgG7aCoatoHs/tIVdahRJdJOWokABInucDdVuUFAfiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxNuwID/pP96Mj0139NQCxvcvKMd/eE/VRMjzKVZLTM=;
 b=mtPkDWn/w1E8Z6Ev4QT0X+Gbny5edimEmWsmPFjxYo+KsY/3cNaOZNE1OLAwC1E0k8Bd4BLPomHdcNu9i/uo0xyGWxHUCqjvc81nKturQz8DCiThcNIGXK/zDyoW3MsYj5aCJFP22hqU/HIuEqITtg4A83+Op9rHhdekGdaLQw3/0Ojf8WDCftnw+UfRVsP/ko1LaWTcHb6KmdmozHVZft03SH+1hQZB5FzJhzm3pHWpb3wqPkGY5nx4rCuzjuc+3jkiJQlcJgdkJ4WM+V/DxpgzDeBLJxrrAMKhid7z4rCrTmhSSb7VAYdWxxi5PW2RBjOAFeOrVSBWZbS1wz8lxg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1833.namprd12.prod.outlook.com (2603:10b6:3:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Wed, 7 Apr
 2021 23:29:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 23:29:15 +0000
Date:   Wed, 7 Apr 2021 20:29:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>
Subject: Re: [PATCH for-rc] RDMA/qedr: Fix kernel panic when trying to access
 recv_cq
Message-ID: <20210407232913.GA601885@nvidia.com>
References: <20210404125501.154789-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210404125501.154789-1-kamalheib1@gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:208:1a0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 23:29:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUHbl-002WbP-Lc; Wed, 07 Apr 2021 20:29:13 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ea973a0-7905-4629-a11d-08d8fa1cf4ea
X-MS-TrafficTypeDiagnostic: DM5PR12MB1833:
X-Microsoft-Antispam-PRVS: <DM5PR12MB183353B1E08300997BC6E701C2759@DM5PR12MB1833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wlwBRRMBkK0EcI7nswl/2yE07CZ2GwJBonpCZO208yDcud5v/I7emSj3V3IctwCEZ34YcpESk4Nx+U6vDqgmBGmIM+D+oZsXCYMyLHRYu7MMe+CQUtSK93svLsDP1Ep4FDVv/ubDdy+b5LyHUw/6edw0vSonF8V0+Zmsj433uSaXH+eKvAQi3fmD0jYyxbeqmKYoYlHahv19figwAbn4YJmVZfeeyY97A9ml5LFlPVAhfXkVjsmtSpqnCF4jOIZco29WruZBAieWtFzLn6Wnewb24N5Ym/xUGLnS3GQDOfhKyzQZ+0u5mHS9+IXOF98/+PWEMVKuGrYQyvTHIt+yoxEbrldOY21FZ5WbYw4d8TzOoQEYUCSkphCQW9xgrII4IQLP3T7QicLgClqpL4/zvuB0l3FjUhnAN2YzBToGeNwwumuVCmQxZek6SQWs2m4jZfyLL5Gc4191Mqw3EvAOGTkYKiQoaR+dhJvzEUw8TUoA2g/jV02OlIsppeVk2QRpXJPQGR9GDPjgnuBG0Gd3EFINFxwC/8uncvBpaysaUmVvLSGSwUNxr0mJYE55wcVzCj6RufVh0Il1hi7V47l7V2NFRa/E4dmTk36jLS6ZkFDYVL/7BajNUJntWMRyTeKkXcjoeGXO451hs7uVbCZ8r7C62tfhKSADoheXeM5bzKqKuW369X0wnUvS41R2oKvX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(9786002)(9746002)(2616005)(33656002)(426003)(83380400001)(38100700001)(36756003)(86362001)(4326008)(186003)(316002)(6916009)(66476007)(66556008)(66946007)(26005)(478600001)(8936002)(2906002)(5660300002)(54906003)(8676002)(1076003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gWCiDcVwFjMOvvn6aWOG/1Vfw+XdYaU17m7z8jF2JIYG8DqYzf7WHdmNh1KD?=
 =?us-ascii?Q?SLvjJ5cC/h8oKR3HD3lPAKOmn6afket+NgMZSNBB9kN3UO1eOjyzwfEr3RSf?=
 =?us-ascii?Q?oC1NY/oIy4CvyOZZ1ljsrb0v2W8PDOkJwbSlzwEzQJRvmLXsrFjaGtwquA4Q?=
 =?us-ascii?Q?9A+AzbZyEYNEdR0fl1cFR+5JmDkPLkBZTBbZ+Pw61Wc+coRm5jZSXtLYyPvP?=
 =?us-ascii?Q?g/CQbsYyFrzTx3mZME172OnMd9rAF/hxQcrbZOm5f5eHnOGCXPNwoXaGjwFh?=
 =?us-ascii?Q?XnP4RVynTx27A7i8wAe4XkJK9jDzy4Q/ytu0KqMYKK+oVHt5omk1DhPphH9P?=
 =?us-ascii?Q?KrPi7A4XZ67NTKhmly9G2EbezofjAlVagpbYntIa8M63zEL5glsXee1sHv04?=
 =?us-ascii?Q?7a1HRm/s+Z7csmQPOM/jOZalnC5iBc7Odc5/CaBMl8VLhaCUla33DCmbnQtP?=
 =?us-ascii?Q?ogwDCjd0RBKms7swA1z+gq1zrUqCalU41AELP6XuRG/zUvxjN+9zbzVmXlJd?=
 =?us-ascii?Q?Q6/2t5WPbZVo79QI4GVJvaZtqQZDSKQCdIGUo6O62QE+JpQOpz5mRAUi1EkN?=
 =?us-ascii?Q?bhSJRGw9UMY32Y/bg2TNZNcCUQ6hrGfuzNnCPkjsw/vyAj3jtsOEf6PMf7Av?=
 =?us-ascii?Q?DAr7dhgfFw6q9YSGbstj0zTqnXS8OkeSBz+v8c6/vGIxTtiTuC0hs+Ipj2Jy?=
 =?us-ascii?Q?3RniLvbCPifoPTaSYG/xulix6rlBi72E7gffRvpdDFjbZyDRgbb/AZEYrqpJ?=
 =?us-ascii?Q?3UJIUOY4hNQ0MpkzXrGmf/ddKkFdYLewwBLV+wlfqZ8gM7jMJTNuLJXzBmSv?=
 =?us-ascii?Q?G+nDl+MUs9w0wGkhiA6G889O1K7YtetnkE3+zV3aqUVmymfdEdsFMTNqa0Ht?=
 =?us-ascii?Q?UxFON9Puz7c1GYyTghELMx01byuBn8UOvcCIZBbq1DMshZNHg1A/JxJ5amyZ?=
 =?us-ascii?Q?csp4cmnMpKnRzTGyzb6ZxBY1jUthMpGTVlxhxMXWkrg1XNNBUl8W+048FhOp?=
 =?us-ascii?Q?r3Up3CY5Tth2cSm03wyYiLZiAwI3yDOu7UEdgvhZlDYG89jZBXAYFV6Het+a?=
 =?us-ascii?Q?iOHWjuBKpvS+4HNG4arvaduw7q0XSFAsdISNWQqtmNleO1ovxcSRpXz5AcIV?=
 =?us-ascii?Q?7jdM7qt3wefK5xqD7CFLRk4bf74ReM+cuMlY6CrPvxhCA1U1Uttq1L7fqYYe?=
 =?us-ascii?Q?T1Y76KHAjLSbWa5MMoqlJuWruOaIH4PYEA04da+OBQCAP2EgF3O7wYgsaWKE?=
 =?us-ascii?Q?GqQgfA8Tv/jvBd11yurZxY0scPhlJGaS/Ry/GlppsmHGKpsj/imVdLxsFoRR?=
 =?us-ascii?Q?YAcGmYDe9+cj278EB81+/zD+y/t0VAQyvpkkX5Z1RD6syg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea973a0-7905-4629-a11d-08d8fa1cf4ea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 23:29:14.9879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZQjdaBOpL/Lm1w4tNpnmSwRZ8lTy7dbT4YcHDvcz9Ugp26F6gCUgCpV9hFym3hG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1833
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 04, 2021 at 03:55:01PM +0300, Kamal Heib wrote:
> As INI QP does not require a recv_cq, avoid the following null pointer
> dereference by checking if the qp_type is not INI before trying to
> extract the recv_cq.
> 
> BUG: kernel NULL pointer dereference, address: 00000000000000e0
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: 0000 [#1] SMP PTI
>  CPU: 0 PID: 54250 Comm: mpitests-IMB-MP Not tainted 5.12.0-rc5 #1
>  Hardware name: Dell Inc. PowerEdge R320/0KM5PX, BIOS 2.7.0 08/19/2019
>  RIP: 0010:qedr_create_qp+0x378/0x820 [qedr]
>  Code: 02 00 00 50 e8 29 d4 a9 d1 48 83 c4 18 e9 65 fe ff ff 48 8b 53 10 48 8b 43 18 44 8b 82 e0 00 00 00 45 85 c0 0f 84 10 74 00 00 <8b> b8 e0 00 00 00 85 ff 0f 85 50 fd ff ff e9 fd 73 00 00 48 8d bd
>  RSP: 0018:ffff9c8f056f7a70 EFLAGS: 00010202
>  RAX: 0000000000000000 RBX: ffff9c8f056f7b58 RCX: 0000000000000009
>  RDX: ffff8c41a9744c00 RSI: ffff9c8f056f7b58 RDI: ffff8c41c0dfa280
>  RBP: ffff8c41c0dfa280 R08: 0000000000000002 R09: 0000000000000001
>  R10: 0000000000000000 R11: ffff8c41e06fc608 R12: ffff8c4194052000
>  R13: 0000000000000000 R14: ffff8c4191546070 R15: ffff8c41c0dfa280
>  FS:  00007f78b2787b80(0000) GS:ffff8c43a3200000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00000000000000e0 CR3: 00000001011d6002 CR4: 00000000001706f0
>  Call Trace:
>   ib_uverbs_handler_UVERBS_METHOD_QP_CREATE+0x4e4/0xb90 [ib_uverbs]
>   ? ib_uverbs_cq_event_handler+0x30/0x30 [ib_uverbs]
>   ib_uverbs_run_method+0x6f6/0x7a0 [ib_uverbs]
>   ? ib_uverbs_handler_UVERBS_METHOD_QP_DESTROY+0x70/0x70 [ib_uverbs]
>   ? __cond_resched+0x15/0x30
>   ? __kmalloc+0x5a/0x440
>   ib_uverbs_cmd_verbs+0x195/0x360 [ib_uverbs]
>   ? xa_load+0x6e/0x90
>   ? cred_has_capability+0x7c/0x130
>   ? avc_has_extended_perms+0x17f/0x440
>   ? vma_link+0xae/0xb0
>   ? vma_set_page_prot+0x2a/0x60
>   ? mmap_region+0x298/0x6c0
>   ? do_mmap+0x373/0x520
>   ? selinux_file_ioctl+0x17f/0x220
>   ib_uverbs_ioctl+0xa7/0x110 [ib_uverbs]
>   __x64_sys_ioctl+0x84/0xc0
>   do_syscall_64+0x33/0x40
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>  RIP: 0033:0x7f78b120262b
> 
> Fixes: 06e8d1df46ed ("RDMA/qedr: Add support for user mode XRC-SRQ's")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
