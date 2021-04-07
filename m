Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE92357891
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 01:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhDGXcS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 19:32:18 -0400
Received: from mail-bn8nam11on2070.outbound.protection.outlook.com ([40.107.236.70]:25793
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229459AbhDGXcS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Apr 2021 19:32:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBN55wGGUTIIHhzNunKYczQChSPx3mNTvotjf3uGuCbBlA5cDvmF/VnwPVLc9L0b7KCSHZzFySgR11bsPgElWcx/E2fDg5sYmjEofHZHLbKznJfeEEA0ANhCwk4q4nr5CpZ8QKsMHStn38JGJ6JyNuI9y1u+rRwRdrYzTjfG5gvHuWYc8+5HsO3P5lVtSJ+hCmOUNdxej3/eX6Ng3ISrCl9+SBrT+isjyvX88fHYry+6unB8FXwwPKFJVajTRFYZTV2WIFpSkma7yetdMO/VkschzM9qQ599mfg1JjtAAG2KZ1HpAKoGk+3JomCTmDhZnJ+wHIgdV7srUhERt+IdJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4ErW7XFC8rwbPvnep6dVdbUw9XJsRyOZK4Vt/TPdYo=;
 b=BLppPcDQFQNeBbTCfa4Y9j9Bm+wlE+8RIsyqCgJVdw24rG5zJyuC+i3HFBAOeM/U3W4vI5iu/0PNz6JeON69VYDimzvr0hRawNv2AD7FOtsk4ixU0hBf7UIPoHiWdOTpVlPsn69rckXSiE4KWGUx1oTIyqHAG4lG7xVZSzfbqvchP0j8BIBHYFpksFBaPc7syqd5v/osv79WOXLGN+YI9ebfdDlnSGBDKwz6nS50NTUa/3WEMQuLKpdy5gUAniD+/IbVW72SlFwGiSDsZjSRNzPukasIH9jI2nKv0JmDhENJ/1Itxr+hw3lXkrZUUAgd6pueHHbeOjUN3j1TTaSE+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4ErW7XFC8rwbPvnep6dVdbUw9XJsRyOZK4Vt/TPdYo=;
 b=izE1tLEXehkJvU9WRneksM57Ut53Zl4W/iBknfUkkMH40ZgGSNVKpyGzj7XHB/P0eCBRkscxRnrbWtL2MMYBfUjdnwdq+60RM2Zyp6hB0Aj82Hqx+ZUjRSPcOWyMCf7Rnhk2fyCn+e1SpU2DVALfU6zeZe7XNAabH04D8t/FYVWIB5y9K+CDGqkjwh30bKyo83ho2xJedPiSmQ0PYO9AGlu7n7CM3Jq6PIhWgUR3cDUFC/QPDdAzJ1zQE2uZvf6ldexMCw1k33WXW5F7aYfeKGbdduGZaXBSl31HIZ8EXrCV0+117NnUkhLvEND//ECGQbYqvJBhNKsNPtBVNZ+QtA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1547.namprd12.prod.outlook.com (2603:10b6:4:c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32; Wed, 7 Apr 2021 23:32:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 23:32:07 +0000
Date:   Wed, 7 Apr 2021 20:32:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Yangyang Li <liyangyang20@huawei.com>,
        Lijun Ou <oulijun@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] RDMA/hns: Use GFP_ATOMIC under spin lock
Message-ID: <20210407233205.GC605674@nvidia.com>
References: <20210407154900.3486268-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407154900.3486268-1-weiyongjun1@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:208:91::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR05CA0012.namprd05.prod.outlook.com (2603:10b6:208:91::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Wed, 7 Apr 2021 23:32:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUHeX-002XaN-HV; Wed, 07 Apr 2021 20:32:05 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e826450-ee73-4d18-168d-08d8fa1d5b66
X-MS-TrafficTypeDiagnostic: DM5PR12MB1547:
X-Microsoft-Antispam-PRVS: <DM5PR12MB15476C07437BF71ACB1E612BC2759@DM5PR12MB1547.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vsJDKLar2GU6k1N2VXZ8KN7V+Jt/zcPKL6GAnV98pXeEH4lCQpsJCKTm3uCICp9X5eCoCyHGBmsbep0GPveXJusNFTjS2VOhxt/ZgQIql8Vk7zWZxwUSt4Rbyi7+7rNTgE7KFUJARC9wWs4VwftmrDutdYaGjMdeUU7ucwrw+lqLQlnvlh0PxAlWCn8b15yCiwU08jPFwGOgq5LoTwCJkNbhy/cVGjlhNF9/RhDxa1MKUpVn3MRtoINbf6Xi9kfZd5Uw1wLsB2Zs0Y30nEN75YeDpGdz9zJ3zQOJJf7aFuhTgkeaSww4FypVhneevXXeja6ZU3sOVBui5jJQR3bFho/UnoytJRZojIdrhz/NXpD4VYcPHv9cC3CSDHsWTHCTLB4BevXqO6pemo06g4zl5R9HLdjhdTCowR0G5pLQ1RFHOAgzmlGB50SQV5KP5e2mwi2pVRmYBrfPV5HG1zvIEd4LPLcJKu/GuRcOi2T4y1kBRH5dPOsTxRz7+YAHDnDBdEBApQPlWKXIcPs8RrpceWraOpt3pH4LcnD2uZFJeUdSC2twxLUmFZ5Gq54MVgvRUZgjsutJDoX+gtfbJGJPZrkiV49qil2WLpz591WOhFMiH0s2nOrGRKCDk/3qzGJCJzpC3CVvr83zS7izIDQiZu6PM1n42oGMI0WzvKsYzJzes86ebMn//NxcxJha6L7x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(26005)(83380400001)(9746002)(9786002)(1076003)(8936002)(66556008)(66946007)(66476007)(478600001)(86362001)(6916009)(4326008)(4744005)(186003)(5660300002)(8676002)(2616005)(2906002)(38100700001)(54906003)(316002)(36756003)(33656002)(426003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bW3zujM+A6rQBZnbJQlvDZpA1tZ8QqT1Q+Y5SCjHzRVewqRgJ9gvRpzi4sVM?=
 =?us-ascii?Q?n7CNo3dE/3yfMRcF090aGGZWZ/i9Lx5WY5MwRvk6PD0iGnIc9hLIWj7UTK8Y?=
 =?us-ascii?Q?M4HhDHDL/J7hYPRLC845huKH/M5vWbcJIQ7nWGY+SlKYr09UgBL3PU3zwjjv?=
 =?us-ascii?Q?AjBVz//QIN97F3MbQZbku/Y6okyVaaHCzIbgKT5+KS/Px5Gqn6v0+zObbiMo?=
 =?us-ascii?Q?YQYvFFoHWKMqi15H2bXSoFclHCwiOjO0dm8BBsPYRwnGqEXX1E0kJ411TCLY?=
 =?us-ascii?Q?Z+6vtLW5yvZ2PFCcY2ZtxDhMaxP+ek07Ipe7GYUevm+tOpRASnyd79LyfQ9W?=
 =?us-ascii?Q?HPDOyz9ph7mfHujzpEhPGBQohXsJaWsAMEKh/bQsk1SLxbenuLjWjYHuOyAa?=
 =?us-ascii?Q?HF6VLNKSj68oUAmjo2dfWbhL2yOE86EsWIv1hFVgRnvNctY0FoNLle//x4y7?=
 =?us-ascii?Q?S9t4YQcTYMi6s3DCelIFxpTLBclUwYzfR2J8EBP1wphoRXOvxaTv5F+hA3Lp?=
 =?us-ascii?Q?N9yfi3pIMykL10fF+UarBc+R1yAgyj2QFeK2jXT6x3bWRzdKHzbot3wTPOJZ?=
 =?us-ascii?Q?Vr39bYljK6J3fHDl0KLW6cpjxJrkPamWOsV5UfsOX+wPOtf7EmnFHODoPNfI?=
 =?us-ascii?Q?Y6KzXrZjag+cZJ68W2Pg2Tr6piUZ+4XVY283lcu7e/hci5gtctuXHqqFTA4Y?=
 =?us-ascii?Q?MIc/ihPzxu1fqYDXd0BLyWDdLzzxeOB34sWG0J1DZGan+cs7sK8YVpuQvrAD?=
 =?us-ascii?Q?wgGv0Ki+tBTLjCibaWwwecAj1ByFb25+rp7XbgwF7z0872dvmITrg7W9Ylgj?=
 =?us-ascii?Q?F2xpbh3zOpjqG9MYqKcY7WxV1trUHfZAX78q2BYYc6bOzDVWfihKexB+nMNW?=
 =?us-ascii?Q?eNSfFBeZRtXQE7XfKxk1j7k/KXTdFQuGMbylr+s0+y5rEYMe7VkeHk6Q1GDz?=
 =?us-ascii?Q?umDRNnAZL3yYPE5UY7AnZcfLet8JrmE/Myvv7TdHE10wNcWWKxu1E3ZO/bKT?=
 =?us-ascii?Q?s3GJrBe3vFb8vfCiqEk4AUXtjb/0/Wsr//xXOhhr6fHy54aJ/68BygycY2PY?=
 =?us-ascii?Q?Gc7W7FIdG9XEM03LQrSmCgx6y0sjjBn3U2V6yxECodTdRM3XKAIYELQfThRW?=
 =?us-ascii?Q?TPAvktdgU1uej1c1fd79w2MyDs8NnY853N1FvFMdHxvD/AMPy8GtutGtOJD6?=
 =?us-ascii?Q?mBYJFJsKDn57X46QRZsJxQf7fdnln+/rFJP6p2qzRYyBSrkIQmIlOOXRLpZk?=
 =?us-ascii?Q?DkBrSwQ1rDtlmoZP/lSYLErME02lO5gzf+M20nVHEUj0IB+8FhyKAx+ya16m?=
 =?us-ascii?Q?vV5GIK60zW77bjsv/l0isuyDFIS5w0my9KCBqed2DyH0ag=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e826450-ee73-4d18-168d-08d8fa1d5b66
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 23:32:06.9466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hualkiLopq8lCi1fskiA+GwJZqc/k3/rQg1jXEJFq0tUEicrb5KKOwMRrtumRhCc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1547
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 07, 2021 at 03:49:00PM +0000, Wei Yongjun wrote:
> A spin lock is taken here so we should use GFP_ATOMIC.
> 
> Fixes: f91696f2f053 ("RDMA/hns: Support congestion control type selection according to the FW")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
