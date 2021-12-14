Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89FB474EC0
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 00:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbhLNXuU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Dec 2021 18:50:20 -0500
Received: from mail-bn7nam10on2058.outbound.protection.outlook.com ([40.107.92.58]:7488
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232938AbhLNXuT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Dec 2021 18:50:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/5F/nXXJlVRIcitr+CmfMPB7JvqXqD3Q3yayUNPuDipeRorHkq5ie772wzQfBVGqSr6s2MfyIgORDFUwGuTZ8PAH/b5TFJ3ctE2guoKjw3FT7i/ZCNy1VoZ+boA2LabScgoZX32HKS0Ec8ij/YjTTFfr30Wi4tQKH/lyAv+/9MtWRNKxnayA3wBEtVj+wzF0Fv64g67/jKfKbdXHeUGpBFwW2qA5sv/M26csYGdog0UGMEHGPhPn4k7Vo7FmDLP9D0UmEEJbXO9lPfjvht/7KznzvfNiAd60Jviswx/xS1uzkM1vjKUfbU8KP5Zj52BRQGDS1oxnXM9ADeCpUqWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PGx5l6ey4q57UJib4s/wk91DBPh69PMMX+zYJdsXLo=;
 b=mmcmGw3HvQ+wYI+JNjXPcNLqXn/XGoPEPK7ZfxYkrBeoMFTeJj90ZUSMvtZbfdgcnQBu8BrQn+DPamR+s2zlzdD8vgiT3hVazGw/loN86ydDBr0dzmRiOlTseJ2jRs6tJH/IiY2DCBl1ZoflSmk4W+N5z3DJRpeLqkwqzxRXfQ7FoxHFGescJUhNzn/RiHWPWtIwWUHYnPZYQrZwv90PVdKv3HZSE7fwUcZuNHdCtgMPp8GpLUhoAZeefwouj1+FNwWZBczcuY1qF0tz0zrsTd8x88j6ihUvtxka+xMd0WfmS7bnF+7c+0pa9cUhK25UFbzFtFVxWYPoa3J/FbYp6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PGx5l6ey4q57UJib4s/wk91DBPh69PMMX+zYJdsXLo=;
 b=dgVTR3tDMahMa0m12N70hmxG4Don74TInHbegB35C+OxfFz+ww4jFGC/BAjaEaU6ogg1YxZEPNzm+VZx0yse9PjQAida6ggqtjgta2OR7CeO5nW+A6/ouTh9zmhZh0jIVxy+2Pq9RzJoE52Vvx17BeX26zAJwZwqoruDyxLQJ7tADctzCTyDAC8md1+D5tjVg+d6z6XjT5mjDAR085NBAzlBEDqtTT0NqPvzxMouzW1Q2SnOkdjSOL7FWKRdXF6vUNLLVWqvyMqj0XVrzYBB22KvyFcZ1lh5RaVz9naU2CsbJ7fCnWPXp6otetHMPdXpUkp9XGHSc7O/GNL0CAb8Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.15; Tue, 14 Dec 2021 23:50:18 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::218e:ede8:15a4:f00d]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::218e:ede8:15a4:f00d%4]) with mapi id 15.20.4801.014; Tue, 14 Dec 2021
 23:50:18 +0000
Date:   Tue, 14 Dec 2021 19:50:15 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     cgel.zte@gmail.com
Cc:     devesh.s.sharma@oracle.com, chi.minghao@zte.com.cn,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, mbloch@nvidia.com,
        selvin.xavier@broadcom.com, trix@redhat.com,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH for-next v4] RDMA/ocrdma: remove unneeded variable
Message-ID: <20211214235015.GA969883@nvidia.com>
References: <CO6PR10MB5635347074DDA51CF2766B9DDD759@CO6PR10MB5635.namprd10.prod.outlook.com>
 <20211214092339.438350-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214092339.438350-1-chi.minghao@zte.com.cn>
X-ClientProxiedBy: BYAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::34) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53cdcdd9-c3b9-4387-bc2f-08d9bf5c7b6e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5101:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB510141CA82656C433C6F2FCCC2759@DM4PR12MB5101.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPOHPWfTQmQThKDgN+NRBHuQK8BMjPIi1apyMXw3Nl2xtOBq68yNbkJKwN+Qha8NZCk4uNRR9aPe+r88t93ktC8XTK5HqxW0FSo83Zt/I0dEx6p7PjFRqaoFDYxomZVmq1UiN+CCDbDz00HUZuen1RyCTpFidEBr6lDkqw7ad/7p3azzE7DpKSMp0HnPEtpo7zotCJo5jUfqXjZAmQlBmeOTD1npa6FZzpAkShIL45hvp44CHm/K68adL30lqgE+j16dOEi9jzJ3jlzT6GkW0svYCNe4NMdpK948YWCCe0W3HVZQ6o9Vjk8IlS8B0I+BMu8BWYlxwU+19ch7KIqWATDv6mtz+PzqqzeZLtBGLe0Hz8iY6xJKMQQSNyiiO7TO9vEGSqHqxkIa//wXuLDm24bxAe08+rQDEYw6ySCbC6YN72z9UCD/HZn6Oj5MPOMDNsoESRBksxabrrZ65ELy04QNxJfMCh4mfVfl7lLD7NKsH9EUtOQHxo04LmX6nYS73wPJ4NkSim9gNyMHktowIGCgl1wQziLPkAlPWWvMO7RhsHdomU1H7I58crxoWiez84fJNbTfePS0ZaAvLla2lwSdM7myqaCHNiUvp6HCvKEuweqyEN8eKHm9f5TzmAaLi1ur0nhRtjosXy9WAW37IRGJNBoq8n2E36Bgz2j3O6K55D97/wsIAkQ5QrJAyj/YE7bKACbhuWnolYpAQvePdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(316002)(6666004)(36756003)(66946007)(7416002)(26005)(33656002)(38100700002)(83380400001)(6506007)(66476007)(6512007)(4326008)(86362001)(2616005)(8936002)(6916009)(66556008)(2906002)(508600001)(6486002)(186003)(1076003)(5660300002)(4744005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e3opWv4/ZiOKJbZWXGVvcOuxE8+3Tdz48SpEFXigAAkSFRjPZwPiqUJ9NVlx?=
 =?us-ascii?Q?JIxCW+l4mtrLhDOLtAj2VDWSou/zJfnFFYSAT3sEvQmVol7q7jOzeVXfxGW0?=
 =?us-ascii?Q?8HUDh5UVxnffb8ApXD5IU7vf6Wj9xxUOLggDaMcBVdmUOMC/YbaFSvrpnX1o?=
 =?us-ascii?Q?LoaR6Egdx2rxGwZKnqZKWv88C/D5OeQNnhl6OG/Q6AjzQ25JKrUeiv4q5wkT?=
 =?us-ascii?Q?26oAfqJU60GtnuyaE8AhYvTrJU15RMqV4t5X6Yvcrj73P87F2HyfbhnEz8M1?=
 =?us-ascii?Q?bcnqDn2j9w6uozAUtM4I20TCxZMrE1G0Ww6N0H1okql6mZbvK+v3pXeGYR3S?=
 =?us-ascii?Q?7IQwl0Ki6b8N3scDV8oQ7Gz890xHjj3M0LTaoUhYkswjGjcJDh40+JtXBeD/?=
 =?us-ascii?Q?BOi+pYnG0lAMhb+mZteC7+K8VsqY4GnoBqP0L8+RXu6epy4+9c1hQn5bRKHv?=
 =?us-ascii?Q?XwzaGA2bj0XnVnx2s8bpbM8MvbZKt8fdR7R/Fuds9OHzkZBv7HE/bpjBIgD7?=
 =?us-ascii?Q?ZGbpbvwvuAhanIv0akxM5dfzRP7zWIkJNF+q9zaveU7YOdHIZ2hnJHOZchZv?=
 =?us-ascii?Q?3iyEEAa7yVSYXA18fd9NIBnONq9eh7lPJMyjb4AKHiU+FbJnkZv/ChpiBXZL?=
 =?us-ascii?Q?/PBn/CczW6N3Abq3t0reNWbEFiytsycbrDFnT9tvvNF766JB0i+RH3bdJ4r8?=
 =?us-ascii?Q?SakU5JI84FEJ83r1YH3bO5ICj6xEbkd+VSN8thw75S78J6R5rukwAN3mCoeN?=
 =?us-ascii?Q?QRKVml121hrkCcLIofJpnGI4pBg0cqgQIAw+EscCXhG7pUDHtn7l7fEua7sG?=
 =?us-ascii?Q?Y31XxE8Qk0agxB015VyRf0sRH/8DdB2jmHqyoMB+hOKjWHzCo/Me3lgP9BNO?=
 =?us-ascii?Q?s7BI/B9fzu3/IH7KZxd2o29FJK3d+z41ywd+LnAICQzeg086wSEvWvme26B2?=
 =?us-ascii?Q?TtVmCyQoGP4nNJxw2zqBuz9AwSf2hH9PEEuyCeCjKAXX108uKIOO/G/TXJzR?=
 =?us-ascii?Q?UT0wyKCQrhdSO+j8DWh/JBNUtV4rhIs+SyNF0aqP2uOtrkx7ILtWnBJPtir7?=
 =?us-ascii?Q?ZauDjc9I9rQ0opQP3Kwp3+NyX7eTPMqM5TMhSFCWrXBriT2FGP35QLHhL8nh?=
 =?us-ascii?Q?g+6U+dypkFUAzvFmWAK+Y3X4WXklSY+Gdccvl3BXk3TwUrJoe+0H8KbeWo7F?=
 =?us-ascii?Q?dEgerCjM9lLhYWCGT1yNoFucMJIGmYuRXV7BJdvDI7P+o39hx38oJfGoMOs6?=
 =?us-ascii?Q?t5ZH0bdqKHy385HzLgg2Vh6BA1nnaGRUDurHLUbnQ6D1tAZ/NanmpgjCW3R8?=
 =?us-ascii?Q?yU+6FctvecndmIvrXoubpiFyu2cpo8mYjjJWOTUD/9QEPB4k3kRjoqkHLScw?=
 =?us-ascii?Q?zklhiPYekd/E1qkEeGPLXLl6m6EigqX7wz7Nll1g8e/DmITs77NhjcHztwj6?=
 =?us-ascii?Q?K6uPk57OAAXIh4dk9iI5lH+9tjxm5OZk1vzDu4Lj4rF9aiPBvLcyFslBdzOx?=
 =?us-ascii?Q?DpSmbjrA1EzB1G02RAX/NvGSeqXKcXQID0Ds655OFL1MC7uzzj7/tJFHOqox?=
 =?us-ascii?Q?m7HoYxV8NBHDKvra2Rg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cdcdd9-c3b9-4387-bc2f-08d9bf5c7b6e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 23:50:18.0886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8sAN9C2ITY9h1Ln8qiYrKNhxscBV9ysPzEBzbR21XGUaL6iKENCtjpszcAzvQUo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5101
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 14, 2021 at 09:23:39AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return status directly from function called.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
> change since v2: [PATCHv2] drivers:ocrdma:remove unneeded variable
>              v3: [PATCH v3 ocrdma-next] drivers: ocrdma: remove unneeded
> variable
>              v4: [PATCH for-next v4] RDMA/ocrdma: remove unneeded
> variable
> Thanks!
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

This is white space mangled and won't apply, please fix your
environment.

Jason
