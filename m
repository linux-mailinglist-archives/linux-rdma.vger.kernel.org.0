Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FD2454EC5
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Nov 2021 21:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbhKQUxm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Nov 2021 15:53:42 -0500
Received: from mail-co1nam11on2066.outbound.protection.outlook.com ([40.107.220.66]:2607
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238225AbhKQUxi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Nov 2021 15:53:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqWIEmC7A+5R1kzVhPbZhAJrDhRmETwWCLZdPlZZijBIzxurh0wvXZ9cIZcWipkGnaBJnjPX3Qo09F5F3a9ARk3hHh0fNPYSEM0zBuygyRFUFjQBTwzYaXq77LfeLIAwdKQ0pV53t63PFs48BubANWuid2NIx/ryU9YH8w7zVukK/wUGVCTtWIG3az4Wqb9xSutbVhmi6Z5QzVUnvN6l2cmmjTZuDZit0Ft9mkrWbdInkKOferUpxk57mXYBSqaenq3TBrjx//ACYVpE7z0nSBIqZ3Q0VIqXl/bxuNqfseeRe7F4cfbI3bDGdDLyG+STJyY9g63ALcsgMezUVwVe6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+oqkE7z1JzOYR/xOsT2BSq05hvOhxF+hDqtDvUL8nI=;
 b=WPWtahDFX2H3SLv0qY7o0bFPINg1kR7wL0PdgJzwXGn4UnhMB9u0C20j+Bx8nYlmDpd4POpDEKoiIlHsj8Zh43ASwoOQJj8jD/fPNvevLxL2oWa36Qg2mV9jvSmv1LmDmVKoWcHeS6lAS47UVNlMdgsPikPO9zXb/hCAeIEknWNR3exEA507+pQ94BMF6EnXfUFLRctqetNlew/QSuNaSxM09JUf2iQhwGJBMGJUDwarxz040yyRGHtlCIfZ4IeD001xsxQETx//8eoyPOcMMMvAZNFBNOLVXLjDoneaNA++d4CQhzL32nYSuAOr5xE7MbqmZ//kCOB/D3o2mcuUDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+oqkE7z1JzOYR/xOsT2BSq05hvOhxF+hDqtDvUL8nI=;
 b=g3/+pNAJkNWW5fP3VhpMsHcc23657RLJNhmMw1K1QJOOy2O/3TkSJdFO5jNHW80bPK5u1RqsQTYu/2B5MGNoWXSfloWHZKal8epYHkZQhIdPx6bI2E41Ocfde42v0A2NgobJih5ebHk21SW4Js3AojdW2zZZJ2VZLJETuy6qsYqQzeMWU5/W2fkQL6s/yt5k+N2/LlwTmZjT2P/69xtKCjR/s8gRBn1umV3Sgd52d7vAJZPa8JEG+/8FpgTov7hNfXEG/NwmrAgvxBqdOVi3rJpWN1jRRL49v0DryJDD6YZZL3b831j+ikhJ+14EixFWZKvqKmue8XUSu/6xfxsvKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5141.namprd12.prod.outlook.com (2603:10b6:208:309::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 17 Nov
 2021 20:50:38 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4713.021; Wed, 17 Nov 2021
 20:50:38 +0000
Date:   Wed, 17 Nov 2021 16:50:37 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, haris.iqbal@ionos.com, yishaih@nvidia.com
Subject: Re: [PATCH] RDMA/mlx4: Do not fail the registration on port stats
Message-ID: <20211117205037.GA2762130@nvidia.com>
References: <20211115101519.27210-1-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115101519.27210-1-jinpu.wang@ionos.com>
X-ClientProxiedBy: BL1P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::35) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend Transport; Wed, 17 Nov 2021 20:50:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mnRt7-00BaZM-9k; Wed, 17 Nov 2021 16:50:37 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a32ba2b-62ed-4551-1d27-08d9aa0be90a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5141:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5141D92303D2BBBA92E98F99C29A9@BL1PR12MB5141.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kqQaXHL5Ux/sle4id4Y+wHTk1u9nReW88r1l+oi7aiww9vhpOgUzjIJ36F0T84MsuJCh9zqSqka4k1reOeNRA0u3mm2J8vSuzwz0LjolG+zyfQnMD/XsbPRg/2EbN/m9QRzSivXHst9pYURT2hK5mqPD8QJIumeLSgu+8evLJ1BMnFwg5+J/HyK3z6RHlZkhYpLvqKaef2qrVyLS0TQFxGUE9/eXL21wyqBX08ie+LK3n+epQSytxnmJYggKoJ2yHI4nLSpjehH14H9G5GbJw5u0fzWxW9W24F+jBB1yU/LAcRvdEKyOLyO3u32hAs8xlQTXzmbjBs1+hgdG/4vuuHfyHaXtlDqmM8ErhVERA0DTE5FhVFaCqm8IzS1hxrnCQfEhSJFyjiocU/cgyjcm3EqNdn0bI1ApOdI0CDrercmqtoGUSnMhtLhdWaSTwbWnuKIHGUNngqW99pbCWDt19XQ4T3+RVmb0JtgHS2DUxiN0v4wsqBHAJgZSp6kI8lRY66TBobPbD2Sy0X1B+vYlQC5fc/qMu6QjzgK5C9m+P2hfZSc7+kJK9PuvWAFuxMUpd+PTWjoByY9+VmZY13KJqaYqqM4xf7jrkA1+MIIet8+Pcbw/x7zzDu9jPJfFwEjfi8vvb2wEAxDByggAvA3hwSzl+JHVfVTMY1FgfR3KsxAtsMgRW3WkAGt7meheIzXbGHcxZanSGWnEaXIG3IGzwAqWp5JI/leDkRlLdFQ0xMI50PDIzZcy4Oouwt7NBITDYK7bzoMrqNwnU0K79ZpQ0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(9746002)(9786002)(1076003)(83380400001)(86362001)(316002)(66476007)(66556008)(4744005)(2616005)(8936002)(5660300002)(2906002)(66946007)(8676002)(107886003)(33656002)(186003)(966005)(508600001)(6916009)(4326008)(36756003)(426003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EZF+45VrxB4Al2ghyHT5QQ45D1Sgi3DzUezAFHSuImR6MBA6DMH+a3wqx7tW?=
 =?us-ascii?Q?K07EjQrg2kiSKfttg3Vh4V/XBoWVmcwj4OfFentkxIrQCs5UFuqce4B1lRK/?=
 =?us-ascii?Q?rz8fmvwiSDvm0MX4s1bOCkRJbnBW4kEMCVuymQ6Sp5lZ46edB2wLbDj67VM1?=
 =?us-ascii?Q?sff5uUTtACABl2VnawPC0VL9lWGvhkptkgwECgLOiVJUYMY1/lN1rgd2cAIF?=
 =?us-ascii?Q?cAo0Ytr0VeIgS7T0f9nkg8lieFzYatDCF5IEqNFqGwzCOUlU0H/+AHvsbMe1?=
 =?us-ascii?Q?/CZbHsAvSSeV6vWEjdhDXAnpYM4C5Qc5nOXozHKDqYpK0aR9Jf/V0O0L430Y?=
 =?us-ascii?Q?IfPFhx7H/T8v/ocPeTA1E+E2KoBkF3Fn55yyqrVQ+3EK1hBDVLV4uf7A87So?=
 =?us-ascii?Q?AB4VYZ/7W4ydBoJkaniIVbdjIKR7gC8p6Qo4D2IItPXjEn1Cemgj3FAhEri0?=
 =?us-ascii?Q?Hnc+Hur1Mc6SJ3oCjmrQbE62DHNzwKIJhsYwtbqgYFVR/a4fueXOoS4kF/qa?=
 =?us-ascii?Q?e5Ie6BazVXFwvUq/04bGbhVPKhNIqrLSy+TmytKiopFiLtG2FeSLYFt7q9qH?=
 =?us-ascii?Q?IweKHbfnuNsq+aZqT9mD49zVRbvu3wiCCenNNjP7lTLVZhs5BOoze9R9G3Hs?=
 =?us-ascii?Q?AKuEGyzawKOypTKXbfxm55/9dcVhUxkkUIA+KWVTkdz7EmZoN87hon4+QBJp?=
 =?us-ascii?Q?8j1wS8TbgumWYlqSGJ2Fufcjt3tL0sHzX6/tgyRiv1ht2KCCXF1h1w2iykYl?=
 =?us-ascii?Q?2t+Acd0KeiFECx2TCncBVPvoImQc9xAMpiWYUfJ5T8vhOACFh+zk7E86lqxJ?=
 =?us-ascii?Q?4pq2dFSWnsIENX8N81IZGzOT7F2L1OrDBQQqSGu4HqQPZsz+AA3E8tfqm0rI?=
 =?us-ascii?Q?wGv/QDSewr4RusiCXOMhgbwmi+2ToODEGYfmNvIhQXB1ml/rtV34Ohrqqasp?=
 =?us-ascii?Q?uhcEDVb0D7epcs1spKRlbCMTUDYhmI459m1iRXvx0n41eo/KtIsf5FaX7CIR?=
 =?us-ascii?Q?yotVgohLglo+EI/znJtlnr7KpTSJeBEdhvjAEdY+X1bldj9bR2lpPOTB68pn?=
 =?us-ascii?Q?jPpFAzXlseKrHKxlHxZsy+W9K8gXIqksmssPOE/djMYNft/MNnG/bGuUGF6Z?=
 =?us-ascii?Q?SIo9nuGJchxpKjOEWsRQ6mouyHFNq0BmslR1DxVYg2qT3ouY21o652uigkNV?=
 =?us-ascii?Q?0ejWUv2RIPptahwQO1sLaYAFNmYCS82ySc/ciRimZI7V3mtxr2D99dE0vgiy?=
 =?us-ascii?Q?Ri0yKZmUuw7awtJA1t48/mV4eXM8xxgjydcGfQOBIkopsyvKi/gFaU0/FfNR?=
 =?us-ascii?Q?+2jRlU/DTDjt+6lzBlTQW35XMM6NDBPAVD/sFtdYbBslov4zIbsHD+u4KWPH?=
 =?us-ascii?Q?hcuQDritH18eZs2BOgBs6bichnxrxqDPa9Xh7ZFZI9ipeMV1eJfqT5w6spU5?=
 =?us-ascii?Q?yipciajPKhA/GDp+C3iI1itXU17XhAKLijCJ915GrIKNHu/+WzHo7q/Aavqe?=
 =?us-ascii?Q?MZ045gd03W7fB/C1/sHzHaMChF/iaaVr/YQYkFwWDwd0OB6GuQqqHcPAx1Vm?=
 =?us-ascii?Q?TikbbPL+z/UPN2SvHzM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a32ba2b-62ed-4551-1d27-08d9aa0be90a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 20:50:38.2116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWFXNY0oQKS176wIkKpPBWkiSYYB9g2YvGw4KLBicWTOAPefm/FZnkvmHfWVIFZi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5141
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 15, 2021 at 11:15:19AM +0100, Jack Wang wrote:
> If the FW doesn't support MLX4_DEV_CAP_FLAG2_DIAG_PER_PORT,
> mlx4 driver will fail the ib_setup_port_attrs, which is called
> from ib_register_device/enable_device_and_get, in the end leads
> to device not detected[1][2]
> 
> To fix it, add a new mlx4_ib_hw_stats_ops1, w/o alloc_hw_port_stats
> if FW does not support MLX4_DEV_CAP_FLAG2_DIAG_PER_PORT.
> 
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=2014094
> [2] https://lore.kernel.org/linux-rdma/CAMGffEn2wvEnmzc0xe=xYiCLqpphiHDBxCxqAELrBofbUAMQxw@mail.gmail.com/T/#t
> 
> Fixes: 4b5f4d3fb408 ("RDMA: Split the alloc_hw_stats() ops to port and device variants")
> 
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx4/main.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

Applied to for-rc, thanks

Jason
