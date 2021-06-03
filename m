Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20A639A95C
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 19:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhFCRkt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 13:40:49 -0400
Received: from mail-mw2nam10on2064.outbound.protection.outlook.com ([40.107.94.64]:50913
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230201AbhFCRks (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Jun 2021 13:40:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cit3d3JBFTY20Cfe3mriktz+2rUA+LwexbzgA+/Rwwojff1QwJI6KxVKY7rC6381mVBNcdqmS9rMznPh08bBX96F2uv1qSCj7renBkXS6mKa9zR0HjZPqKvbLv0KiGHZphLu8F0P8jHKfdMGatrvZENBbc/tDvyd4Le0iRpbvWOH2co3G1GDK+mCL+XDAkZMmv4ZerBMKHUc7BwA0cH3wJN4qqdPd0AWtKEjbjg69nEfkCaKxhgvbZ4BNMHs0LSRHNH7IxheD3Uwum2teasc1QvCoM+gVT/jmHSGnKGfriQdio1x8JxhjCZQrX9Q5ZumezK90j0j5+BFbe15GBKGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGFCPm1d6RELeEp6pNUFu/s0ka6bxRJvEUdAhUQ1Ohk=;
 b=YMq0rCGUerzCco+bMm8tFcSCV1e5SK7ib81yuxhT+Xhom9lYmpvL7/NfjvImOBExots9eGS3WGvMu5sZ0F5CscfqVoY+7RBsT5kSyQHXxt/gdJ+qHheTFl8/BRHr6XAHPXorzIKm69YHXr8oT5RabHawVuSJcKmFOcAGW3JT8VjcZeNZuf1PF06kSuCXgnovZH8y4w3z2twtJGY79kHEo/HXZecjIFHji0pgdpA9uSQVexJ/EzJnd8K3s3EhJ7gp1QNgdBobkRZbkcI7UXvMIw7INQluAaqyxD0uScTUQ65KqgOs2eL+hjN4Ya+6HXP3QYBruxqnmaMN9NglCOTxtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGFCPm1d6RELeEp6pNUFu/s0ka6bxRJvEUdAhUQ1Ohk=;
 b=AVVaE5uOz5ADdr8GSRqM6qi5N97xaCxfi6qbowTeyc1W4Vy92Eu5hugAQHf3AU4rON6gyW2dRMYse6nRgH9EqV6orzgajTq3wEUqdU7TASCOkOPqAll/bvVtucQRV8xke/7GhSSeA5+HtS2OOOvxPq7T5nlZ9SzmS5lQTwTHKwNUK/KzLTYITQIBPOwXUau8x48F9jJyfuPV4Y8f5xxEyq9vFINodotLkXm/bRlPBzZdJ5vFSJ/hpYjQNx130Lf59HbUM2113e9t2ihLZOH7tVRxAFNqM73+zmaPJFQvQ2yIZCKuAT4Mgh7zO8WgqdMF2VK30+4g5MyPz/HPi4+U2w==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Thu, 3 Jun
 2021 17:39:03 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 17:39:02 +0000
Date:   Thu, 3 Jun 2021 14:39:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Use different doorbell memory for
 different processes
Message-ID: <20210603173901.GA303986@nvidia.com>
References: <feacc23fe0bc6e1088c6824d5583798745e72405.1622726212.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feacc23fe0bc6e1088c6824d5583798745e72405.1622726212.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:23a::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:23a::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend Transport; Thu, 3 Jun 2021 17:39:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lorJ7-001H5d-Dm; Thu, 03 Jun 2021 14:39:01 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d7ebc96-00ed-46b6-3d2c-08d926b67a38
X-MS-TrafficTypeDiagnostic: BL1PR12MB5192:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB519293FD2D7742D97719EA59C23C9@BL1PR12MB5192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O336qz0UlpNawhmXDztVor9GzPZysd1bcWhxjl6b/yp2EMVdUmfhAU8YFM4FNhjN5t1kaS53KFJ4cRDfw0Xfi9Yxga186WFnZx6ORyoahDF2jsXy1cZxdPqjMnNoIYJLXsRs17jSc7IRfu9uPgI/tF5tycfWRHod4MbQugYoGQW931ZFwYRgYCHy5gbf3Qf3wMyGYwbZyLVBRlpK//bGp0BKDy/YhlhUmr1rl1bpJYDEqJja8IJ3+7V8/sSMnYSwEKjtI9rU6XxpfwPItFRZDkrPt1/D11GaI720qE3w8ZzvvbKFpJAvnu8G10RpSF4Bl+YquB+jmTcy8Lo+ZvfQI2NV44wFT2Ork0xUJH46sNgubOL5xgX8aETKGbkfeytuc0MxWF/z6VP91U5Eavm7O18dWOdHB8wr+Jku6jjBjgwGwIwsz4NoFB5dw3BbydQPLaECEDAK+ud8KNICY5qWunhftK76qZsYpNKQW+9RUrHOyL04MEipMUmWxvwouUw5u+Z7fnZFsXVee4Qt80SQLkA8LkeWyX6MA2E+GJNHmEc9Z9shAGuua4pi8CHGnS8nHPX3Vdtqld+Vh37LvpbNe9w/ZE+bPs3xZ/TxB4vY3qXgalG9Z/KWSVi8+R1BwpvBkY73qy/bZ72ik1I9p7n5KU9JONaprZizS6yWy+qnWtw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(376002)(396003)(366004)(346002)(5660300002)(9786002)(9746002)(66556008)(4326008)(66476007)(86362001)(1076003)(38100700002)(66946007)(54906003)(8936002)(33656002)(83380400001)(478600001)(8676002)(4744005)(186003)(26005)(2616005)(2906002)(36756003)(6916009)(426003)(316002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ADl2B5Ajtfchz1S/CWoIHmKNjFpRWg6yFgBxigSPiyfVW7Qz3k99ZFPDMifX?=
 =?us-ascii?Q?33LV1RGVq10i9TfHJWt+6Z1XoJWaLypB4kdFOel8xdk1ALp0im0opLzayE90?=
 =?us-ascii?Q?CCRP1Kkf5aPXHqULJmwChtm+X3IhSefDS6ea2KZE8G1hiZgFCfosRrj9Fqah?=
 =?us-ascii?Q?qgGsr0SAZ+waUIVLRB2ICTUsJ2L1xG5O16Ib7w96jXeCyUagY/Ct7hJgwoxP?=
 =?us-ascii?Q?EYMCtR8N+1IML8FZstgU2MVqIbv/dpH7G4QT8uNEyKc//tC65iasTO39jc2T?=
 =?us-ascii?Q?xQ7xPo9L/cvwt/g2vIIEcJ5gJqPowpB/M3luJZHZXb76icaG+Zrzuvy6ugCE?=
 =?us-ascii?Q?qJaV6noJbUWtEfVU/9ptWmvqj2zmwX758nkWbaKc66kj9jdoa6Cr+j9qJMrE?=
 =?us-ascii?Q?ovAPp/ay9etoN9FgJRbvKxBkwaCP10Q4ZNhSOjkQDYKfi1Uy8nRPR8TJnPZh?=
 =?us-ascii?Q?msNPiPjTGnajDDLS3rVa2YoAmtdzHouRkls98L2pxt8gBP3517LAGh05wLl/?=
 =?us-ascii?Q?5iSfr96mdWrCU9xtbSiAKdYoPUBUadYmj1SY2WxR4ySzVj3aOxl4+CrR2D8W?=
 =?us-ascii?Q?n/sVtwL0kk5Rj7rV/9dPfFXDGEyOimNjw1WYBShEIyd5MTXt+3H1W1jAVGUz?=
 =?us-ascii?Q?x0xE04Sg27EYHSE3TweUrKeUj2rvXK2d9NHIGVFjkekF4YDHUNuJ6Viuwxhf?=
 =?us-ascii?Q?X7ohipo7thpSlY1Ybk0fM4Jiy+XSteQ293SmJEa0rCzJh6EykGrVQDCz6OHN?=
 =?us-ascii?Q?yZB15r36ELh2GnKewhjIOFVlUl80TsYoKs0YqWUobaSj0USqTzIDsDPAAl8I?=
 =?us-ascii?Q?BMqy7tRtzbbqE9q7RsBHSgfaiBoJW4rUeVWd8/xiGX4/5azVR1m87XmOFmFn?=
 =?us-ascii?Q?nOs39OHAOasJ1rn0obilC+9Bv38QAbzACWHG8twqqyl1FLosuYTlEn7TQzQC?=
 =?us-ascii?Q?VQhwCLM93yrSEBqO6ekrFJsa4izI9luARvZ4vO3mWlkD4yxHaVH/3W7NBqc8?=
 =?us-ascii?Q?sAeu2NTkSv4pVRAa3zj8Dq4Mo6JdYu6zU0qoiZKnIpEI6CCJ68VchwkdABZN?=
 =?us-ascii?Q?mdIM4qteXMj9F1WkYS+F7gJF9DsMjCztSWM5Yy4LudmuqOO1GmiYFs8++F7I?=
 =?us-ascii?Q?GuAmOv0vbNEMfivgZpTtid+mRbTRay0W4tXxgeachvQLlX6gnjG+ad642Z1k?=
 =?us-ascii?Q?20U2OTiQjOVOz/exgMvy9OilZrcBHvlt6u0qY7tKjftI86DyFtLlh/HCdtS5?=
 =?us-ascii?Q?TmLCYT5+fqVQKRPNDkH8K++OnYyp9SzLKOWFXsoN++B9ps+stYtdGOyDT84J?=
 =?us-ascii?Q?Kc1dK3uhMPdXEZJWT6y280ky?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7ebc96-00ed-46b6-3d2c-08d926b67a38
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 17:39:02.7120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8rA5gV2y8VUu/Aiu9cZXjI6nJRU3rPi0gMmwmJzI27N+xDtX6iw5nSqLm2/dRW7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 03, 2021 at 04:18:03PM +0300, Leon Romanovsky wrote:
> From: Mark Zhang <markzhang@nvidia.com>
> 
> In fork scenario, the parent and child can have same virtual address.
> That causes to the list_for_each_entry search return same doorbell location
> for all processes.
> 
> This patch takes the mm_struct into consideration during search, to make
> sure that different doorbell memory is used for the different processes.
> 
> Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/doorbell.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
