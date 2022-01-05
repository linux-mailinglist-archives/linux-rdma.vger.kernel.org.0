Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96272485974
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 20:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243651AbiAETtN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 14:49:13 -0500
Received: from mail-dm6nam12on2072.outbound.protection.outlook.com ([40.107.243.72]:22785
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243679AbiAETtB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 14:49:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLONpg8wsRGjorv6ZefxggpBviiC85BtQmL8duLQLBMNwJ2x/mBKXSQx326WVPr/hQFAfiBBECpOb24pI/7g/WqL++CDnGvjSUxRnkzpIL/iVsZjhUwez5a5ij0acdTrfELup/IiXYXN/E8LI67E0JPxeQwsNXLVgd6yUv7X380ZQlX4GG52U3uwhIQ8c4PBpf7Ykhp/5gIoYQ5FqMDbHOESKhpbq3AqS5ZG3I+3FzKH3CuFuAKkWjwInBgJd2oE1Cxn5rbNk7V/GIQ+sp2L9gLeXfAV5OSlMVx6ebyIb1ZZReqAO7fLB4VlrwfDwLu6LBiI0Qc0FHZdB33IjbrUhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLnXtcLXLDSr+POAVifNWWnN0a2IDRvMWU+NSw547mM=;
 b=DoowC8jfPtzBKSMWOalDZctrDFpuncZA0+QVcNgwZyB5advuY708uaopqVci2nldjsSmKrsM/01kJZPAQkLOIjj15VdIC18GzRRDcbaS7TAGJoZtMjbpkD5IjNkeUGdchtgN4O3UshAwiS88oUJq9+XpDvZyPr+1HV1HGdyUzBhzzmx5EAnctePGeIuBHYFBj8/OocrlxyOgbYA9ecpdX9vJw2zWg7uaw/0zmGR2w+ekCDpV3S2qGmYzERkINym7fdTQXjqIDhhFEd8wHmQQ872Q3uKebHA6wnqaSKlFoafEbZvnlFN7cXqt8l997/hl/4gs4AeppGweyDBgMNpImg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLnXtcLXLDSr+POAVifNWWnN0a2IDRvMWU+NSw547mM=;
 b=ov/uPorr2hShwTRCQ0Qye4gt4dK7Ix8E+E3GjeimUq6gUg0yXFHps0fwyjsGMXWNUMMNgyyDp86qwRMsvz+9rB8aGHon5OH9FoG2e6B8d3zHa5taA2KqlKKXTVJ2/mWdImq6ehGCt2dKW8KkkybUo3m7zAE/i0gM0uAH7n+mw57l4l5vcu4XM+qtHS2C94MvxNlMyaNLwdjs5Ej1zzTyQ8n+VMJDUgbTjR/HnYDmiC6aUzCZl5O9pLEVnsI51neU2b8PONxgkG7fTPtLyDYevWRNXnQFxWC1gOGDplO15H11wt/U5sfOqvRlLxpuYyUg/rYKVhQudFKDAe1V9RbswA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 5 Jan
 2022 19:48:59 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 19:48:59 +0000
Date:   Wed, 5 Jan 2022 15:48:56 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     zyjzyj2000@gmail.com, hch@infradead.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        leon@kernel.org
Subject: Re: [PATCH v3] RDMA/rxe: Fix indentations and operators sytle
Message-ID: <20220105194856.GB2872048@nvidia.com>
References: <20220105042605.14343-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105042605.14343-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: SJ0PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::30) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdb10e72-185c-4207-c6e2-08d9d0846a8c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5031:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB50316687BC4308039C5EAEDBC24B9@BL1PR12MB5031.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Yd3LPZlips/OzDVa3W3r7OJwEYfvlc8LW7oMixWuBQ/5LWiWe8nHUOxKPowTxqTEXAA6T7iAUXUzAcgTy12gzjU0KZ7CAawYJEitmvuNZCeB1hnl7+uBtuv2OFaHDm7UukwSxqlpGAPM4jyHgXT3FHxeuumc7eLjtaPWIvRWA3HNsE/rBight5N907OK/IR+cPekLNuf6jQEt1/cm5otHHwdvHKmfVMf4Tu/bKyhg/KAyU1HG01fDEYTYMd33nbjUc7M6kI5F7SYqHqZqc9TPU0xgWH/xRUCwYjGr9cHQKr0vmo+lfSJa0CuUzIdcP8U+6bUKu0DivsteSEdd3J/cdk6azwJO8omVeQAaXV2Fuiyc5sKCc8um79qh1V97hgxbt3K+Fv95jWToBY6Fbnq70zQHPCx0VKziMTVrTefGMt1rPVe7xa889X55HWo8SyAhK0IshVZCgbS9QZBIF6R1vSizchQXpzQooZ8CeMrwvDhJ7uZXGXkWZ0ouesxhnwiBzU9zEv/4d8NzCQGhEcCNIPEI+zoWiUPrpQePxqCHk89ykQsxWrB1cHSWdBBNpvu+ybVWGdyjxP5wI0bo+60qR0zMxoKRZcPI2xCezoPMkG8VVhsOZz5hNij/RCevPIYJfSCnthpjLjp90nU54KMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(5660300002)(36756003)(8676002)(66946007)(508600001)(66556008)(6916009)(4326008)(2906002)(186003)(1076003)(26005)(2616005)(86362001)(33656002)(6666004)(6486002)(6506007)(6512007)(38100700002)(316002)(4744005)(8936002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?psIxBFiZi+I4+QSVZI3vWtFXHZ0bGQt2+g9QBvOsejXXuxo5I0kA45R7GyY+?=
 =?us-ascii?Q?5akvhlgD+xafLofD1kmSte46dNbW8iDBhLRRbAdoXm1hBMoImxOIoeKFRLSL?=
 =?us-ascii?Q?P0dBbFh70Zi/GFPVoMQo8gozzrmXCVmT2MK/TjLd2GT+Irv834/Wm2Zwt06O?=
 =?us-ascii?Q?eYhFpbYjerbOj3ECBa/orV7UY9bAemx1QGR+T9X8M6G0iDcGefGcP23Ryo4Z?=
 =?us-ascii?Q?QdWA46btLbTToLC7dspimpxgVGDSXf4J9RyHcVoPsYbDAP5pELPiiW6eMoEq?=
 =?us-ascii?Q?B9+P2+RPTOHW0CUwBE1FChUm/ELTePU8HZILpfkiXm7087Dv7+D7D2Luggwa?=
 =?us-ascii?Q?LBRgUB96hGr7FtXiEjaHtOcYiShO2QMdNfYbJVuCacG1pJpuv9R2zXG1bLAG?=
 =?us-ascii?Q?9Yih9psR1VWeSggtwib6vZVv7Xwc5D+ZSAQZASLJo5r7gtremNklodzzIZae?=
 =?us-ascii?Q?VM7cDH/V+PCIQmaq9CBNmMjBUCIlMfaYag/XGyvxw3Ua2SswlM5++NLiECLP?=
 =?us-ascii?Q?VH76q6gHe51zJnh7u+UmY0v/0o003yEWU0QeKqXNWGUpWuePVW1evxdgAy3U?=
 =?us-ascii?Q?Myaeq04UfK7EeWVboP+O9mgKUIvYgmMuXvI/M1zuI5GMaBwihuwyjgwe1WIO?=
 =?us-ascii?Q?OPV1WR3wrwwHvS7o5UbcWUUOOlx23XKJEENiClsBqdrH4LVIMo4wUvb5BHB7?=
 =?us-ascii?Q?hgGiIRe1onB7qhRbr+d++FgRK9b9qn1cLq+cCJOdarpDNc7Z+H97CZGihJAw?=
 =?us-ascii?Q?bSY/m5xlyvfsS3F/MxltCtytuHqb7hzUu/m0DeSHfsQiqwsaOAMaTTe7Mw+F?=
 =?us-ascii?Q?Ev9AXeXzIBLYMksfUsu1pGToRSxaRtQgSfTeyY9HxXJtuMJs/e3OE0736KIe?=
 =?us-ascii?Q?z5wi6cOlN67IBfMPngXBerm5b8fschAf06J0dJn0Wwsjv4JTsidSUNFDHw6N?=
 =?us-ascii?Q?6vrWz02bCB5m/eqT3mnlbKnxsgvzSbqSDUd2jpx6o20LXvdcUFXpsOZIiMg2?=
 =?us-ascii?Q?nbK7wm8hY13vQWMhWt683cPXCDPEkEPebAeE8aka4d1tNDOekewE0p2JzCdU?=
 =?us-ascii?Q?qygEYGNufIxrRvadYJ4VEhSSndmgrt9Lnlfmk5xt5eyNCXQLFn7jhIZi48fT?=
 =?us-ascii?Q?P5/46wMfQff45NlVSxtCDmzpp4PO6xeNfTmbr3+wEIYy09z256CgEhBWKhMp?=
 =?us-ascii?Q?gT3uHr55Q/sMORqANle3Pl/W8l4AmsSNpR7OLbcR/YyLW5rDchGJvrkrzAAl?=
 =?us-ascii?Q?8Rmx5/BHj2mlQEY9/9MrOJ/790bvpqOa5tpNoN9+YqiMBB16fjtJi+ekt2E9?=
 =?us-ascii?Q?7VY8JOOq/1p2qQ2zu5qKPjJdSNn5WP8W8smRECGb0zdAr0uJ4QodImpWpJPo?=
 =?us-ascii?Q?D15TuIY5M5q/pTYEIuY0ZruczaZmlTpqJNwIHRVZiU8PyZSIM2+cF+cat4EC?=
 =?us-ascii?Q?oTtKPYIiayDMPl2GgIW/gnQYNWCk3wR/ygkfxvvrejiApyv985Cq55hlujqs?=
 =?us-ascii?Q?ttcH5aMXZSySmuO0FTaFvmmAVWSAOWMPi5o08vSchRQOdJbkfRlU739F17YH?=
 =?us-ascii?Q?T5W2edwD+MsimHrigx0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb10e72-185c-4207-c6e2-08d9d0846a8c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 19:48:59.3225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /J58wJggMEphKOsdKv5OzCNZPOrCQu1DnFRI5+DiLVy0lHbvCSSEY9j/dwsEr2/A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 05, 2022 at 12:26:04PM +0800, Li Zhijian wrote:
> * Fix these up to always have the '+', and '|' on the continuing line which
>   is the normal kernel style.
> * Fix indentations correspondingly
> 
> NOTE: this patch also remove the 2 redundant plus in IB_OPCODE_RD_FETCH_ADD
> and IB_OPCODE_RD_COMPARE_SWAP
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
> V3: it's former version is [PATCH v2] RDMA/rxe: Get rid of redundant plus
> ---
>  drivers/infiniband/sw/rxe/rxe_opcode.c | 737 +++++++++++++------------
>  1 file changed, 369 insertions(+), 368 deletions(-)

Applied to for-next, thanks

Jason
