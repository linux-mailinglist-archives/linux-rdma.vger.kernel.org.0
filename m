Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8D23F34A8
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 21:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhHTT36 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 15:29:58 -0400
Received: from mail-bn8nam11on2057.outbound.protection.outlook.com ([40.107.236.57]:39648
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229923AbhHTT36 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Aug 2021 15:29:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zz7NilbQcPdVQ4fBafIAHov5nJgsmc4tH4mGK5phdrG0CniHh1bbdQbRphFw7gW6uGv7SmWQ2bW2e7pUDq/2sBO4ggeMmGNVyzq3gjMDgrU7jS9tJ+DVoQFigZWSUSaGwCHaKu6NUt3gt9ibkeakVOIV+Nim3gMwxqSTKt8uwA2BK+SlDd7yl8sMfcDA+Bu1RbUq85rRbfnF8UlMcR3p2bVVjqeuzHyAtWtaxjAfzlkzUJghRg7z2hB65nXO92y+fFZcoksLvCCwpcmZRnaSo+hJ7kVRxhWehg8J7bp0nCADuXUoYUwzOaR1JTI9vTjkWqJmDcc3ICgCRc63QuTZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6sDMfr74YkjrgJw11ZxIfJ7jtvolCr0ePCwB7IO/SY=;
 b=ZbRRsD6qV3zZKvG/kN78dffl0DcCCHXvUSEN5IZLVJbBhg3lJbbshzJaIyfgoJZdovvfOKO/8JzBSNAYBErrlWynKBZfLaNd4QenDj5MHTNGENFh4jq1nzEuLx3GNU2TqusgZVtfqstCG7PLhckHV/fTXJJnIzOha3aKP8PsajFihjc5W142HK2xhnTjJmd6bPYxzEG6Wm3CSguHCv9O5/gv7WO8nL4DS/aEWDoDzBDJ/5mw1WHm40OLqZcplePeELRKLEMs6clkUjty7yBQwWV/0CFqqm5obqpqa3H23nMMSx/mTCcBeLofJJKvK9CK6dFZMSLlf4KwxaY81IyG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6sDMfr74YkjrgJw11ZxIfJ7jtvolCr0ePCwB7IO/SY=;
 b=D4TK7iUjOa40Ehp0kBmogoYJy/9XNgG+JEBTKhgV+/+YBuWq9yj8dYf6/bW7evms95sWIy6bhsA/rANWh9X/dzeD7onyI9POH0vn1R/nJm+gL5ychr7Kgg83CJBKT5ZVo9HcTIMwdkO7MgCnFVcoxrNHLUf8yB3aGnwaSl02vcH6R4zUdvAKr5LTJZdCHIiVe2qsCtM2pFsyqEnHSt44/5Sl2rXsjhqR45kuMWjacHwKVb7vR/ynhrOpgeTFjUtD7OD8gqm0uMGULT7VAeFU6PXycswEfJrelFvpDPjHuSVBLWRysOHOjgPddDN2hRN73bbyBx0TuSfV0029FCKdcg==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5539.namprd12.prod.outlook.com (2603:10b6:208:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 19:29:18 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.021; Fri, 20 Aug 2021
 19:29:18 +0000
Date:   Fri, 20 Aug 2021 16:29:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [RESEND PATCH v2 for-next] RDMA/hns: Solve the problem that
 dma_pool is used during the reset
Message-ID: <20210820192917.GA572552@nvidia.com>
References: <1629339474-43445-1-git-send-email-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629339474-43445-1-git-send-email-liangwenpeng@huawei.com>
X-ClientProxiedBy: MN2PR19CA0044.namprd19.prod.outlook.com
 (2603:10b6:208:19b::21) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR19CA0044.namprd19.prod.outlook.com (2603:10b6:208:19b::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 19:29:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mHACb-002P0x-Bo; Fri, 20 Aug 2021 16:29:17 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9c77cbc-5712-453e-cbd3-08d96410cdc6
X-MS-TrafficTypeDiagnostic: BL0PR12MB5539:
X-Microsoft-Antispam-PRVS: <BL0PR12MB553963F767978131561574DBC2C19@BL0PR12MB5539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TDJ0fcOpCpCkExtrS7d9oppS3gVqIbjKqlUVkxCCuQ2Bv+pzzA9LDESAKfLeEg7PI1IIxDT7AB74q731dzLSvGV34fE1gK6XgRtRfBOhw6peKkuS/utOYX+L9BN3fUMIJEu4EY6hneUZRWnRbHewpWuR09Bwmf1STPlHg+4ZFHY20sREIFTa/n5Rqfh1/g1UEE67yywbDRgzVyMdbquphzSt22NumsUT+cQsrLSTaNSAkaMfYVC9Qdf8J7ltOsKQaK3xFVlYkt9Hz+slHCdLTDb8O2f8t9PmC6tL/Q+CN4IYKC3gjDSdJAy1p/BGSfJ2xEj883c5IaYiI6d1yelE/WCgspGmgek+tWo4fZ3k1a07/8Y8MKUU80AtnHr3FCio5DbD7HVR1vdhmSPAl/tpqhRZwEYs/ZYy3x7RaAQU2istzwX/OECie0Jl9TsxAVjtC4zwEyyBQJ17qr4W5NzrVdghMzv7qZ6oqRFPhlhyFnxAcgKReyws1vus4U0dmQZn7JOfgTxEMwiSNHuj/p7ZJJSyuLnu6srXjeI6kPm1NvOQtg90TxnzHcYVaRACX/8vgfDQZypZ+ziuT6U1veRXZer1Jd/0qD23drYPsgfJ+czYk0f79qFL/883EwqJ1/NaDFSiMtpI8YUnVBA4IH9aREGKwwIa0hLvdchiSJjw45l/QZM3ZWYza1mc+xqSd0yJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9746002)(66476007)(2906002)(426003)(66946007)(86362001)(9786002)(66556008)(8676002)(8936002)(36756003)(6916009)(5660300002)(186003)(38100700002)(508600001)(316002)(1076003)(2616005)(4326008)(33656002)(83380400001)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xrdAcudJMYgmFuQn6JYwtTAn0ii17V/Ls60WX8vVPvoOnjB6n52HFFiV9A/Q?=
 =?us-ascii?Q?qqFRRHDVijRiVuotdV+yurBLlhj5YEwi8W0IQseYfdxSXO+cxCVEk2aLMNiy?=
 =?us-ascii?Q?pFN/GjcoVD/I/EWvFNlJ6XrWiUq+57EZw3EnAfzU0yo6jXrE6GgJN7mQ+kX9?=
 =?us-ascii?Q?KetqQH6e3L4ZHFyKRdhCQLSIw9XH8ojfEQNmA3JyufsqLtpx9eVs44DQLvok?=
 =?us-ascii?Q?MjWoH+PLHACX6kxYMq9bEtpY9rvB48iXO0LJzKsNfQpTonlD3a9V4rUQo8ok?=
 =?us-ascii?Q?0u7/QvkTq/lbm+okyxsfKeys7JdA0dfjw0+chJVYL0keUyErRxLOOpssQvOl?=
 =?us-ascii?Q?+/pQp6MDY1l9pAU8rwPW3jqbfWJvk8jPWEPBQEpwxa6LxGOrC+iItUhARNHu?=
 =?us-ascii?Q?Gg3rMDulU/ejA9PQfOyqbMjLdmiWBDWVxKomQqIY8+jMKcbGgCkE2ISEmRIy?=
 =?us-ascii?Q?FJ28ZYDtrEJJTyW61yNcNDh41nX94RF0V6+HQW9ZpbQfFsqstuFndhKcK4cp?=
 =?us-ascii?Q?uhonC44LGrblY16h2Vke+uKWYOpXuP49Zt1FBEqqsiuZiq8Cdz08w8CVK/I7?=
 =?us-ascii?Q?KHcOfH3HPR/658oxDw6aVzcfHJ15SKK3m90zCtTd98N6gs+G1aeFXgiT886d?=
 =?us-ascii?Q?0c+JT+w93cRTcYuWOCEzyu7ADyR87lKVGnT8qYSfl3loPsDz9PKDG2SLQ4Sx?=
 =?us-ascii?Q?o7swYcvwzliACOdlKLD4k2246QTrt+NfzrzuUa4OvNFUnokOfWnCij5APoZ7?=
 =?us-ascii?Q?QUeE0GAgm8L0w0/phQsJ723vg4YxZocCEZDZXgOFuYCpSelaBYhw6EQSiDr3?=
 =?us-ascii?Q?Zn2woMGJi+nuqtLgkQfnEjneXvL/KoQJ14e8uc8lI7BSgwdQggu102lFslWY?=
 =?us-ascii?Q?Yd8lNJ/cecF/abixrS01r3/1GScMNUEOnLFjzrdIx4oLJdiqN9vCeh+J7bUn?=
 =?us-ascii?Q?MHcRDw5eGPQINJNVaYrK4FjBhFSOBXDFSngDn9LVjigTbYo3JDQeKxCIWBpM?=
 =?us-ascii?Q?jg6E6y973kZuEUYzUOs6YHseyGlzVk5R/hruMGoJO4j5g/wllVYOw7PF1Nt1?=
 =?us-ascii?Q?Z1yx81xwp4zPMRiKYqYu3+X8RD/fXrNeB0PMXSq0xHwVdKUn0XnFFaH4Lfnl?=
 =?us-ascii?Q?Ee+/v367HXaFEB8rie9hFltk+YdLRvrL/IdZNV+HjZoCnDUOcZwbavl30Atu?=
 =?us-ascii?Q?n6FpJ1uP5DQET3pvOjlBI0B2avLJkbQYOoNvGADuJUTlTTWAG841yGrsOEmn?=
 =?us-ascii?Q?0Zv3OgudmRQcjwSuTSwmWnTYrz4lTz5k1XdgvAew4ryntdJ7y0lunIYIyUpb?=
 =?us-ascii?Q?9z4nl5R1iqbGUxbzHaD1NKS9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c77cbc-5712-453e-cbd3-08d96410cdc6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 19:29:18.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nToZ3sHoWUxbitnM44mmaLdncTQ+VcWiNeBNBF/nJKcRFzNx9MacvVuL7Pd0ekvI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5539
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 19, 2021 at 10:17:54AM +0800, Wenpeng Liang wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> During the reset, the driver calls dma_pool_destroy() to release the
> dma_pool resources. If the dma_pool_free interface is called during the
> modify_qp operation, an exception will occur.
> 
> [15834.440744] Unable to handle kernel paging request at virtual address
> ffffa2cfc7725678
> ...
> [15834.660596] Call trace:
> [15834.663033]  queued_spin_lock_slowpath+0x224/0x308
> [15834.667802]  _raw_spin_lock_irqsave+0x78/0x88
> [15834.672140]  dma_pool_free+0x34/0x118
> [15834.675799]  hns_roce_free_cmd_mailbox+0x54/0x88 [hns_roce_hw_v2]
> [15834.681872]  hns_roce_v2_qp_modify.isra.57+0xcc/0x120 [hns_roce_hw_v2]
> [15834.688376]  hns_roce_v2_modify_qp+0x4d4/0x1ef8 [hns_roce_hw_v2]
> [15834.694362]  hns_roce_modify_qp+0x214/0x5a8 [hns_roce_hw_v2]
> [15834.699996]  _ib_modify_qp+0xf0/0x308
> [15834.703642]  ib_modify_qp+0x38/0x48
> [15834.707118]  rt_ktest_modify_qp+0x14c/0x998 [rdma_test]
> ...
> [15837.269216] Unable to handle kernel paging request at virtual address
> 000197c995a1d1b4
> ...
> [15837.480898] Call trace:
> [15837.483335]  __free_pages+0x28/0x78
> [15837.486807]  dma_direct_free_pages+0xa0/0xe8
> [15837.491058]  dma_direct_free+0x48/0x60
> [15837.494790]  dma_free_attrs+0xa4/0xe8
> [15837.498449]  hns_roce_buf_free+0xb0/0x150 [hns_roce_hw_v2]
> [15837.503918]  mtr_free_bufs.isra.1+0x88/0xc0 [hns_roce_hw_v2]
> [15837.509558]  hns_roce_mtr_destroy+0x60/0x80 [hns_roce_hw_v2]
> [15837.515198]  hns_roce_v2_cleanup_eq_table+0x1d0/0x2a0 [hns_roce_hw_v2]
> [15837.521701]  hns_roce_exit+0x108/0x1e0 [hns_roce_hw_v2]
> [15837.526908]  __hns_roce_hw_v2_uninit_instance.isra.75+0x70/0xb8 [hns_roce_hw_v2]
> [15837.534276]  hns_roce_hw_v2_uninit_instance+0x64/0x80 [hns_roce_hw_v2]
> [15837.540786]  hclge_uninit_client_instance+0xe8/0x1e8 [hclge]
> [15837.546419]  hnae3_uninit_client_instance+0xc4/0x118 [hnae3]
> [15837.552052]  hnae3_unregister_client+0x16c/0x1f0 [hnae3]
> [15837.557346]  hns_roce_hw_v2_exit+0x34/0x50 [hns_roce_hw_v2]
> [15837.562895]  __arm64_sys_delete_module+0x208/0x268
> [15837.567665]  el0_svc_common.constprop.4+0x110/0x200
> [15837.572520]  do_el0_svc+0x34/0x98
> [15837.575821]  el0_svc+0x14/0x40
> [15837.578862]  el0_sync_handler+0xb0/0x2d0
> [15837.582766]  el0_sync+0x140/0x180
> 
> It is caused by two concurrent processes:
> 	uninit_instance->dma_pool_destroy(cmdq)
> 	modify_qp->dma_poll_free(cmdq)

Something else has gone wrong in your system.

modify_qp is not allowed to be running after ib_unregister_device()
returns.

I see:

 [15834.707118]  rt_ktest_modify_qp+0x14c/0x998 [rdma_test]

Which suggest to me your ULP is a test and that test is not properly
acting as an ib_client. When a client is unregistered it must close
all RDMA objects and stop all activity before the client unregister
callback returns.

Jason
