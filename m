Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8076143FF09
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Oct 2021 17:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhJ2PIq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Oct 2021 11:08:46 -0400
Received: from mail-dm3nam07on2052.outbound.protection.outlook.com ([40.107.95.52]:31649
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229623AbhJ2PIp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 29 Oct 2021 11:08:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hld0SG9boQNYvWAj4pdY7Jm9MBgruCctiH7T3WnxHY3DkfBZuU41zVjU5pATWQsbn/8rDnLRycFGRxxGn6XXqKb3vFGQ37NohfADcNTSPxG5FDmcNTzImRYJ6yWwdNKu0tK16i1NVK5PqQSB5uR+4Pk5esyk7iQ+SPmE9a7/DsXoD5AAK7PPLDJjl3GnjRBl/biRzPDQeggRBfWRyWi2O76XkcVQP6ZknHsZwejl+r5oGrXIhR1e1WWo6D3/7RLnWAd6/2GsJgJsJuUAh5JwQFvPxteqwh0uzbFaUOFm4GFN071ESeeP4r/c1A6L07QQldEyEVe799FdD3VLesCA6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtNHtsXzgz4foVRQSvj+TZxfxMquK+RyTxcje9MOauE=;
 b=CMipQjJa2egEIBbSHdf6gp1b0ZMQT98zSfYxFRglM9Is6K8RC4QGJlV/NkD9gU3FEuj7vNI0RnL99kIWeGcNptFeia1B34l2E2Eeo5F8eQACZS/7GMsilbFOrGGzF/9gHEZ79e70csMRobl8igTeXWlhL4ItNJDBSuwV0546Xhs1Y8T3UJbFE49yPIgGQ62CKvNeaeK3yZpYfZEGwwFvpGgRJ4A71rfOptktDdpY1TuAL70tK/egrtxhfsTO3ORCFoQMQfk76yR63iPQuSs4WvtOlM++jvv0ZdhSUisCJY628ulhdw2R1jb5HVayNosiV9kuvs5+m6J2z1omgPLgxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtNHtsXzgz4foVRQSvj+TZxfxMquK+RyTxcje9MOauE=;
 b=KHCuesRv99Emqifzo94DGo2XqVE8EIqyiRkU+lVl6kvQGMNnDag/Tqt6d/8Zg0NZa4Go3lF/RyQ9TdYw2cJOLJpj3jNJGVNgA8lUyd7aqJUcuvebDpm1Omom2NivEEMTQigIRv2etTG0oPmhS3QMaZqzvu+FoyM+oxtnT1HoKeZBwUbDtz6CTGMc/KGeTTYHJMa4aczAVIo4wMpRj628sZAVTtDpMeyUPPHclcyeaErlIkHrqjlP4vs2zmFyJMMUWq8R+RAyMZDhc6/l6LACkTSFvh7O8Z0Ie6p/fvO/BUnqZM/XYa58KRnFiikZ1E4reqkwL+NrEjR0K7DOK2l8NQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5061.namprd12.prod.outlook.com (2603:10b6:208:310::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 15:06:13 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 15:06:13 +0000
Date:   Fri, 29 Oct 2021 12:06:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-rc] RDMA/hns: Fix initial arm_st of CQ
Message-ID: <20211029150612.GB834869@nvidia.com>
References: <20211029095846.26732-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029095846.26732-1-liangwenpeng@huawei.com>
X-ClientProxiedBy: MN2PR14CA0027.namprd14.prod.outlook.com
 (2603:10b6:208:23e::32) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR14CA0027.namprd14.prod.outlook.com (2603:10b6:208:23e::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Fri, 29 Oct 2021 15:06:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mgTSO-003VDH-HX; Fri, 29 Oct 2021 12:06:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed2294b1-ed2f-4414-b743-08d99aeda60d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5061:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5061F17A7FF1304A2A54C213C2879@BL1PR12MB5061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HkFu1JSv0LVYppDSti2sxY0Gc6nowDInNNZQWYDPQMfNP6hkZmUv9CAflrqJTHpH4G4scysoBBXce77AqtNc3UzOjwhQqF/pbnVN459DblvV2zNntyZb2fqOcQBiC1mTwRu2Tv3A5eQnRZKlP1IYQ8H+yckFPoVm57u0K39wDqnNdTwzlEIggAElBXo9UHK81aNjXRsV9nmG5B0n/Q9O1rf8aJmdE9bD2ZP5k7BBBWvwnGm4uYZ6D/BmSkYIV362a6OtFxCmCyjJb0UIRFQvt3f60qob8+sVLzE++sqAuW9OLnfTQ3yvNhLef2lojPiXsx1Anlfr0P9Ca8XDyh9ubri9BuboEZ04sKcf097AMbyjf0FIsYoM8PYhi8bz4gtjQ+8KdyJMDKTpdArZpdlwgHzUz1Ex3Z5T1zx9H1yvQDq5mEGSFABncdRvm6Oz8Yz216X7NYG3+v8FTbwEQn8IjBqJUPl461LR4WzT7ET/vVfUWjvHNkPde5vRIi2oBZG/2yFxyPXrwZ6pp6opU6ayJoHzupJuWZn+CbRVUQyZQjEj3QfwVSZuLKvWlxc1rmv54m5EPhJ1pOKMPMjA7KcIzWFMGVhxrXZXzgGndjiEubgRsHK0v6phPbtDWaHkoGtcADuhBEpfGjarVZu20qwvbsaQtcrcnHYv9kxay7qrvxV3NY0+mpxkq7UshipNTPTps+zH2Dy+BAndj/0aGgoYhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(2906002)(186003)(38100700002)(8676002)(316002)(6916009)(5660300002)(83380400001)(36756003)(1076003)(508600001)(66476007)(26005)(9786002)(426003)(9746002)(66946007)(2616005)(4326008)(8936002)(4744005)(86362001)(66556008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mmROgQqJVPuyKSNbSXUwNvt9a5esA4rceLJeLWomXO25a3xigoCXP+y2RZ7F?=
 =?us-ascii?Q?xuaqPRny+5qwMOBMg+zQNiek9VuIIyzsOi4M71D5w9X0u3qY6R+jW1EqkEPr?=
 =?us-ascii?Q?KNWD7uEleR53E+1piBRbVx2IJvAouRgw2jp6Guuq5MIJbxfzZ98328iVMSux?=
 =?us-ascii?Q?lgU02YW28yI0/ACBkME+vcg12+0xFs9AOgsbC3LuGUD/oEbnZHlF/Wo94Jyd?=
 =?us-ascii?Q?sRX2TV3TNacD7HUErphL6eCv88+XfKNkhjbad/b++2s+1QbOq8MkClct8Kgn?=
 =?us-ascii?Q?Zx6J3FtJ5NyHKXaxzUIppv4ebsrodBzj20jetnpFPpUmKuwCPjIRYR92WG1f?=
 =?us-ascii?Q?D+s9yJr2clHgpOPmhmTtBriiJyPwNbWXFofNOlC/SeP/8ZUd6vJG0pPj7YhC?=
 =?us-ascii?Q?/4aSfDBk76zhPh021e2hMO9PpUWEWax6cDchwO9/j6q3VQakUU7hAdzhkzd1?=
 =?us-ascii?Q?go/43NbWw3bRLFwNFzhdD/U//EZQuvJNLQW52LKoGCPCKLpzmQYdSstSwtjj?=
 =?us-ascii?Q?pZ621GWSytBFZp9i+6hC0XU+J+MfLU+Kqy8h5aDdZ0DqWxgiTlXOLvFIPGeu?=
 =?us-ascii?Q?rl6IMfNAy7GFKtsCnSrj8ji71fhmChQWacPfvz85ovx68WU59NTzBem9og9w?=
 =?us-ascii?Q?omKF6spnf/5he/qdBo9Hv6FztDq8Cl2i2PZfegIGq8FPIjsLkqxVwCc0fLbJ?=
 =?us-ascii?Q?9ziHvyFgE0b27RYrYB+CLtRhwFXFAw0cB9RgFAnjDc1KDRRU20EGXhtvSfAI?=
 =?us-ascii?Q?7BFZU1lakxgl8DcDQo6UpxbT4BnRq7L8WQvH7XwJLiSSBtRYuthaNSVeyf4J?=
 =?us-ascii?Q?LZNIarj/1Umu/8WxDn9W6Ef57vkN43FY7uYInok8QQfwUbJnofu42JSA/jiD?=
 =?us-ascii?Q?MkgP0ssVa/PAr0s3embKxjnMAc94cOSGEq0As2PE7TyrcePiFfbDac8X7lmG?=
 =?us-ascii?Q?ICeO/4UaPdYeMkRlqk3dRtvcpwX6MmUQbX/CtiVUpVVJJhCXfOh506VDLktI?=
 =?us-ascii?Q?oalkqO6yFsiPIO3GoW6LNn8jPbtnjkqFn2gZ3zt5mkrsQLlYRpvvvdehZkIt?=
 =?us-ascii?Q?9y9Del/Z5DRzbqgNHUMaH822dqUkFPWDManDLrJ184nzic1QLoYDWFtlVaY7?=
 =?us-ascii?Q?Th5+WAe3ZDfa+OYbCTle26SmZr0iZrAOg3g0iHLC+jpRufScQYLo6oA3s1C7?=
 =?us-ascii?Q?pTcNJxyxRfK9XLVBQEluLMfgUSt2SSZ7G6D48tOQeWILliaGTe/OhK/E7QoM?=
 =?us-ascii?Q?A943JSo91KvRavodVvLKxEn+atkBZ+PFJ3k42sr48hA9iry6+ZQtkRhySq7h?=
 =?us-ascii?Q?PoWzCE2PJw9ya9g9aHUYb80uPeG5h4VWpkl/iczm9Pa+3/NhSgS6xuy4mjuJ?=
 =?us-ascii?Q?fvMm9gotK2zRNoeILe8H9RQfu08QIEV/D6YbKh6RdRsXEU9tfA/u4U0eVfLO?=
 =?us-ascii?Q?ctqqtNd8m0LvMSFe2dv6creELp8H7d8Am2/ODgC+FRBkjSUWQpKMV7EsNd3p?=
 =?us-ascii?Q?hoxBrge2PydESr/60NNywftlK4ZAFiQWWMQzg/ucftrHiuwUMah5N4RuEeED?=
 =?us-ascii?Q?4l/Db0tW6REUXgyRu1E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2294b1-ed2f-4414-b743-08d99aeda60d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:06:13.5629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6llP3RePlLrCcNQzOiTXxSckIks6SvpBXP0RJNXH9WoPHYiOIXrZejZTOMGhBod
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5061
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 29, 2021 at 05:58:46PM +0800, Wenpeng Liang wrote:
> From: Haoyue Xu <xuhaoyue1@hisilicon.com>
> 
> We set the init CQ status to ARMED before. As a result, an unexpected CEQE
> would be reported. Therefore, the init CQ status should be set to no_armed
> rather than REG_NXT_CEQE.
> 
> Fixes: a5073d6054f7 ("RDMA/hns: Add eq support of hip08")
> Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
