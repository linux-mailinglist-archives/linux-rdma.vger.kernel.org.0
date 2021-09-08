Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B502403911
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Sep 2021 13:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351561AbhIHLpv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 07:45:51 -0400
Received: from mail-dm6nam11on2075.outbound.protection.outlook.com ([40.107.223.75]:44416
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349218AbhIHLpv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Sep 2021 07:45:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUdiR+vwTyu0rzjP2wMb3BZEEqDR0KeMZrOTz+5UlxJkEtXMEyoulrmBWoA8JktIpu7X1aA/JR60fBinrbL0LIQv1p1ygCGyRmNxw4A7bT3mUqZXUEqM23qLwSWkPLk1lse+wD/UyXx86BQ9mODPPVUJN81US50Am57s6XX5p+HF8usi20nViiFjMpFmmO27bvMouHPGKraJzHEStHarHL6zTPKp4FLdct2OXlkahg1SQKFdjhg0z5wTasOcRo3I5viiQhc5QSkXtUHAehTxilUWBz8Guc34jNx/2tMwxYaDI+LM1rEdzPGgpCn+/9ax6eaLVThR8moOD8QNXMzvcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rNy1XzjbgOq9bDkaMalG9uAALbRrDf1EGcMnBT4RC8k=;
 b=KaZ+tosoGq0GA2LdFbKmU18VD5hUaNLxzQ76J6ANMoxy95XvVAdVo4oIU2jQ2LAR4/IP3D0GYMJ98v7BNdx+DBtQ+zxlnDuFyARN7j4cBy6fRvBVdzoLEcMZv3bTeNRWrtdlj/KoWpaFIuVwTtW9cD7AIwm06sYT6xyK/RmCtVVjLwP70QSyItbPsLr+9vISgnhDGGkFqpYNPJG2ICLngyIMOPhQMg1D+1cx+QOgyemqxK6q+wV734V0Pj/p2WBJ03Vz1EWFd8guUGmvElxL8Lrtn4/kjFKYfFHBKaLGntWF1X9zPSsyf1baIXze8/JPVAMbPl6zHV5KLLCaDXnyww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNy1XzjbgOq9bDkaMalG9uAALbRrDf1EGcMnBT4RC8k=;
 b=j0yA6K0Z1Vk5cR+s+kc2+lYGNZkTPGkHn84jb2ZndP/C/9iyG58eyAXong1VLOql1bZBNeaqRAH/1n5uPjMx5HEfvasW/p9+cIpvjxf9GQ2TwSVWn1SoDG7FZHIxbW1LNORpT2evLLaEk48C4RpZjNwVrdC9Gt1XAlMFERaHN+7PqBahBh5waUTDwTsok0Ak64QmPnygbS2wb7YfC1figQE0ff7fq5aG5SooJfZGHYxYCmXrY5+eUswDL73WDtCXYXK0zgJ1ruGyhOp3sa5oXYxsI8n9XMm4AeaHtz9qIp0Dg8i7TGA+LW8FPPhJ4FuSlB591yByknN7vYc5+LalkQ==
Authentication-Results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 11:44:41 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 11:44:41 +0000
Date:   Wed, 8 Sep 2021 08:44:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Len Baker <len.baker@gmx.com>
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Kees Cook <keescook@chromium.org>, linux-rdma@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/bnxt_re: Prefer kcalloc over open coded arithmetic
Message-ID: <20210908114440.GB3190597@nvidia.com>
References: <20210905081812.17113-1-len.baker@gmx.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210905081812.17113-1-len.baker@gmx.com>
X-ClientProxiedBy: BL1PR13CA0427.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0427.namprd13.prod.outlook.com (2603:10b6:208:2c3::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 11:44:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mNw0O-00DO39-8Z; Wed, 08 Sep 2021 08:44:40 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8c68312-08ea-471e-46af-08d972be0b72
X-MS-TrafficTypeDiagnostic: BL1PR12MB5158:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5158FBE96A90C45F88DED74AC2D49@BL1PR12MB5158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q31BUA55KNHxCHJCeEWSxCAlJbyVdUj71NVh51NLq5r3N8XqWXJRiBOT4+/ADYL1x4S+5BZwaKOeresLdK6bJVm4zo1RitY0YPH0T9YQZbfMZRvPH8F6bhzAP8Ts4cjKMMV2iLZdXzElBV6BtY6/r6iOwSqiokopjxtmyHDb/GDIOH7Uc0OIIoNw4nGT6asnkhS42/87Ke4bm/rGql6qnGoYBg2/TvqvRTi9rpDcT/eExKODeXTmWmUlWb4PGj93z4p1qm7M0ZBcf1huv7HBj71/GwISIqLSa+e8Mr7x45xF8b/3p3tZPPVV6rRACHoBomUX0TWc6PQwYtBA1oMTg26HyUiGMJdZ//wA8gp5tbwsfLX7T4cZhDqK2N+EGIVF1gQVXdMzZPMRlSv2n4rTcArfh5A9H13+tSTN/htrlkSu8/nqPN15r/2c4xNYkl0Iw75QTpMxhokAl18pW0xwehEJZQfkJlFUmy31ztOpnZOXgFL5ysBlxyNGIUK7ptkZ+3zFNq2RXLub8rt26zZ0bOBOlJrKJhnWWEllY1jIaImzJYMZDmi18+RfB10cIs4K2gZTbXzA+o3QxTVD+p99GjCWuWUPqf5le1Ir6Z105PvFJvh8T50K6QSU9dyI9dXm9GzloMour6Cju5QVaCTKiGvysJbkcI3AyB0v0PDaQzJYtS63I1wEN9H7BZ4KklYmkEMGDeTIx+E0SmxMyt39hSCBYJqhjFtf0Kz/lWNCKXySHju9eDCDj3BZfgbWo7R2cRLV2YckUtrCBtkDwHHhiu1bWoB1sluOfeU4dBWTkrM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(66476007)(9786002)(26005)(66946007)(54906003)(66556008)(2616005)(8936002)(966005)(478600001)(316002)(426003)(5660300002)(2906002)(36756003)(86362001)(33656002)(1076003)(83380400001)(38100700002)(8676002)(9746002)(4326008)(186003)(6916009)(518174003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eSPQdQUB5CSGABiddkvey4MNkC0Xi3iBNbNib0mauNTzDcQ4YUOE6BJFWh4P?=
 =?us-ascii?Q?ut7F5WBzK5W1yVbtornz0j457NckZCXs0bp1J7GrmEsWliFO2EPUvA3uqoEu?=
 =?us-ascii?Q?z9oPAChO1aX+h2PGFQoSyXCsciiT223tcyn3BRhGRLsodBTA46bfI3BhS4RY?=
 =?us-ascii?Q?9sma0XGZR3nOyOTJAssYZOtX1y1yf33nPfxJcNl2BlPcdJK7fXOc6RIJY0dr?=
 =?us-ascii?Q?3Yoq2ZK3N2iTZEmQYDPw7UF1ec0IU5q40YCELaGhag+jL25+nLeTO4ecLrh6?=
 =?us-ascii?Q?sYQNsQqB0liTJ8WEtMDl9KnM6lrt7SIIp1Tb8yGBsZ3derBSsnFr4n1L2mTQ?=
 =?us-ascii?Q?EzDK+56DG35AAd4JXBL6F5ovq1tkR1UH/Z5Kw9ndJXvPu+3h/Pz1YhfOqHlo?=
 =?us-ascii?Q?SRHUMKh1nWEq/1f222WRWk9CMLzAHW0K33dK4QuINeixI2CfPNJGJP5wP5JA?=
 =?us-ascii?Q?JZaI7FaIYwWP39TR+YyeGm9ZiIDJHXMGtjjje5CFFHHPDJmvu8UtWN4uf9I5?=
 =?us-ascii?Q?vVSBAP8aESX3rLQ3BRi22AooRxZZji1+0CGvsrgPS6lTR7yG10nlskK/R8Zu?=
 =?us-ascii?Q?jAihTtsn5uYiK4BDcA7PkJsybyhp49wjYErMUDSALVBwOU84mgsZfz8LhT7g?=
 =?us-ascii?Q?8Fm6jtlqWKLZ+x1coiShHLHl8s5T6ssa6YBZIjByVrWwX+8USGajipfQRXon?=
 =?us-ascii?Q?vhKFHqPk1bRFnrj67hjFWx4FSy9rIrp6xrRDPzptjSAdHBw98PFPnUQdfYW4?=
 =?us-ascii?Q?mgzDknCDGCR3H9YmxZqG2u5INtISxmoqIBxm/BCMILcPIZNBOdSWVE66R0rC?=
 =?us-ascii?Q?PCbFfcwt995veuO2TQbxq7mQwNonaiif//3+O2xn90vfRYWI/7b8fG2UQz+y?=
 =?us-ascii?Q?jBcs8c/N/lOhtCXBthI2iVOyNf0FOHzRnh1DM4VU5APy5nxKOUW665Ww9l7U?=
 =?us-ascii?Q?+TQxEaQqjiFzDwtzWU4x/xHsvMOT0/onjW0x88hl/oYeECJ93LcA0RiaB4sp?=
 =?us-ascii?Q?A4hEjlB2eZWxSGM9lgrj01z2p9gqM3H8fhZYVG7esD4l69OSL+7GO1cYooH4?=
 =?us-ascii?Q?a5CQBuf3j6YZcNjlo446FCgMsTGpcaBtljW7dx1bQ6b2PcAWvctJ3AA5dBoo?=
 =?us-ascii?Q?0Lk2Nt9/jjUkCM2+Oj6HK7nPqi6rB8luIzxEoGkl2y+p85yK23VErkhuihYY?=
 =?us-ascii?Q?ahD50VwR8q1wQC+c+EgU+CgdDHh0JyMJoanjn7pnHtYdcUGaqvFi1uSxF2zJ?=
 =?us-ascii?Q?jE4WnfsNDoJUAA5C/1cN1N0pgXYdXUJd70YfJ+JH168KBnqRRPO8QVUChwfb?=
 =?us-ascii?Q?M6nfBbRVx+m083j8NP3aBadz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c68312-08ea-471e-46af-08d972be0b72
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 11:44:41.6294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7MoNOex5QVImQAOhksopb/vAt5puy8wQPuaicDc5g9K+FZFo9n3tZ8J0QMHv7Mm9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5158
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 05, 2021 at 10:18:12AM +0200, Len Baker wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> In this case this is not actually dynamic sizes: both sides of the
> multiplication are constant values. However it is best to refactor this
> anyway, just to keep the open-coded math idiom out of code.
> 
> So, use the purpose specific kcalloc() function instead of the argument
> size * count in the kzalloc() function.
> 
> Also, remove the unnecessary initialization of the sqp_tbl variable
> since it is set a few lines later.
> 
> [1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
