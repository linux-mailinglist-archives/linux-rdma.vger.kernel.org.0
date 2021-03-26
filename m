Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3FF34ACFB
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Mar 2021 17:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCZQ7O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Mar 2021 12:59:14 -0400
Received: from mail-bn8nam11on2068.outbound.protection.outlook.com ([40.107.236.68]:55265
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230209AbhCZQ6m (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 26 Mar 2021 12:58:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDvPDzcyA9S0HevRdMA1Pz0xm/QKKXesUFuMEv43t/zvCO0ZBhqy+N2i+6m3qlNP6h186WsVTqgnp54hNaCL/5ZHSPRja1uz4RbSnctrhGMvSOsSor9atpU0NMrf632aAGqQEnum2V246TD5LsicHJjXhA6xV7PfqTDqLkaTcape4I89cOE031eq4kpKSKxKYe3WVVBZh62vNbe1nROs4tib/I+uiRC0NHr3daI7UcgpxMc3IUeAArsmcdNDqr8kt5/9nqHduZVJ9EXYR8oGLGM+TV+tPpWb255tCmesd94ir4DbaMmTbGwVMxASSgNZExXYcvStRq6YsMzmrJvBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSrPIcH3MXyu9mFsKwLq82EMDSUMwlklY36fl8dRefE=;
 b=nbroQMkYM75wrG43G0qPseR3C3hyZ7NqU/0i78bgk5NDo9/4l6LlTBMjg6tQwau1QQ6SZNo3l4MBLGGGoqq7V9dg7numALGZpBeo42nNV1fnc1xVGkMhs6zD6Tf1xNsa4SUy9HPsJrP4vs4hrR6YQfndMNodL8XlzOgFLdGBFWK9agB8lg6Bje+MHRroFOUoQb9BhB9aisnPqhmkn/sOCpFIFAjGnAgFRo/yZZCmuzdaYqpBxB3inAxxAtw3vUWT2uXzGRNpexXzsO54ps6134Ym5e3Gs3Lk01RoOXimB7f0faFVWaOFovW8Z3dIsAk7ws6UOHbIC975s8rhgW7xhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSrPIcH3MXyu9mFsKwLq82EMDSUMwlklY36fl8dRefE=;
 b=ct6tqlcO3yl3Elm/1xcW7euRKRt9IWAaAd3skIZf0CBOEUETTePcN6hAWI1J9HniYtwtTrTy989/0NmHb5cw6RY/YcoX7NnAPxLGRqc7KyQBbG9llVPXytjWK7QMtiNbUMO2F/e7pkoCoicWgteN22MVLuO+nzY8MhpXJCh63o98zXo2snd7MtnymU5P5xrBwcdr+XqT42ZCC77qCwiwcNibJt2mV0Vt78ZVgFMv6o3Wl/qmAtpa2LP7T4RuYj/IKaQsR6yjGxiUeTYJ3tV/gBXBjSe5rGUtneCWDwrs2ykbhI4O5RjCPjk2F3NvMLZX4VntsSlDKQEiNN2ELbrfNg==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2811.namprd12.prod.outlook.com (2603:10b6:5:45::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 26 Mar
 2021 16:58:40 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 16:58:40 +0000
Date:   Fri, 26 Mar 2021 13:58:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Set ODP caps only if device profile
 support ODP
Message-ID: <20210326165838.GC863945@nvidia.com>
References: <20210318135259.681264-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318135259.681264-1-leon@kernel.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR19CA0015.namprd19.prod.outlook.com
 (2603:10b6:208:178::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR19CA0015.namprd19.prod.outlook.com (2603:10b6:208:178::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Fri, 26 Mar 2021 16:58:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPpnC-003clx-TE; Fri, 26 Mar 2021 13:58:38 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87e840e4-f5d7-405b-c8c5-08d8f07867c1
X-MS-TrafficTypeDiagnostic: DM6PR12MB2811:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB28110B846C8C5A8C55BA493BC2619@DM6PR12MB2811.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vQmMIQlhj9EmqEzs/1/J3YozPi8jiW7sHMMxFdqaFymRCcbO/sD5KODiuxnS1RL607Zk8m3j0BknSNKiWKmEcdLG9avHngxmZbwmcvuWWjwPfYdqeAEfc7qw1IpmpWeFx950HQpEn01UQOS6mugEUUFS4M1688WTZC34NhdegKpz6/qPi7Y0Zzt7xPAKo1YHa3xb3ehHce7GmjW18Fm6iQQYY3NDUe0w4HLY8s0YXyErdQoy9NRwAi5BaCK3d0agg0wCndtYBCzCUdXmAxi2qAT7MOQMCOXciK8X4hFprCUXA0hul8yyHUB9GfDtO45rnrqzW27aQjmJBzVxMB6L4CQ3iL567P9uB22NsJiPUfwsn19r1mhiPOmEPD3EnkJK2o3B0vTr0JJKOLHKlwUAAUWxKdlie5ru9Etzzn1laM6N/Xu32Q9qp9tIhOUpvRcYMKIC0LFzBD+Bu0WXuMMRdYe4zFaanst6QAgIB7qvAhtmg6HjCMnBsT4rqLx8SLHpRri0ePaXUyg0ogM3c6ef3CCSXgCFb8KemZOFKCtbqePjNt/vrujmqcqAJOnC/wuRnh5Q9pSCEbNuzw0bs6msaRGxaqMQ1IjXZf3opStssj+keBS1bMqMF3x8pj67zsXKMW/mFPvckzdN8y5+x1BYKL0Dp43NmBZOjU+uUzTfW8oEd81BneHs5hRhCMg6JGF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(426003)(316002)(107886003)(38100700001)(6916009)(36756003)(2906002)(2616005)(8676002)(66946007)(9786002)(5660300002)(66476007)(66556008)(4326008)(33656002)(86362001)(8936002)(1076003)(26005)(186003)(54906003)(4744005)(83380400001)(9746002)(478600001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pp7yVRNWqHjo1XA15z0n4ag5aGvnYt6eNRP1oiBQADxLM+7uWgOU6VFeojkN?=
 =?us-ascii?Q?wckq2HGvdGTs+OMwoW7H+w+iqs/TvuKim3BFWb/OKCPOohdW0NFUryyBbQ84?=
 =?us-ascii?Q?W6zWbpcvqMoA4aTyOz2oK2Ynm/bQm9H92USdZ3BvcsuiRk0zMiPuIFASzjzs?=
 =?us-ascii?Q?SqgSU82K2P1lMJyRgEYzuTYrhz7teiube2OJ5V/LkC2vONCwLsqzzd1U+Cxd?=
 =?us-ascii?Q?XL6hL2rY645SGgxm9pY5aQxedoL7M1DkRe9jRdPtmVITExNAkc9BFkO1qH5Z?=
 =?us-ascii?Q?/Wyzjp/mt8xAwmj8TSb6F8HI7DcEXpGUST19UIVHaDWOpmulMAI7cumK22pE?=
 =?us-ascii?Q?2a58amxyywRZn7pcsZNz+v4+FhCYgoH5c2dJpDexYqCQLrxG4W2E7VM7RQzw?=
 =?us-ascii?Q?5JVvrzaKmc6NyCMYHCMt3eImV9V3ABa1da4V90nVsHP8BDo2rwui2+ELiIi+?=
 =?us-ascii?Q?k4TPyrkWqIy0VY4hmnMP1FzE9hFMhc9ygWYXJRTa13HTNyFt2wPdaey2J9Hs?=
 =?us-ascii?Q?x6y3oDWzHS0p5IfJ1wfxlmgeVajcMhmsAL0PMblb6zMZI2XpgVXa6ECmvCVU?=
 =?us-ascii?Q?vHJGYycgi7lt5LpR1mA8hoX4+S9fcMPFGCU28eUllmHZ62fYsTNPiXK8gRQi?=
 =?us-ascii?Q?44lh9KnYzo436XxWHk+yHuiUeIM/6kOIf8Lvv2Zd++8NpO6DAxHucr44e5D1?=
 =?us-ascii?Q?l682MQgDF2kFRNzMiJ2SuXqT4mV9hFw0ydcxaAhQttCL7Vx+SlaVvH5T4ADd?=
 =?us-ascii?Q?XV8Rr/0UV8UxLio0iWvXeOglncLyR7tN87uLSwC1FI/WZSYM3qFCQG+vMl7Z?=
 =?us-ascii?Q?OQTOHC8IVqbbr98h2q804C3OaKpSrsb2CJMV6bjl45BnNZcUCScVWCAKZ7zm?=
 =?us-ascii?Q?/4pNWW7/OKrZj6CGIa2oDdvXSaN4DYtrQ+c+tJmp9kUZflnMpCnOds77/t1s?=
 =?us-ascii?Q?Xc34hJDwFVtZAU8rRS6Yqo/SQGE/4WA1KCE2QikTqpkZIkm0D0/dY0pa+n0S?=
 =?us-ascii?Q?UVXYIplip/agMlDqfUPST3vV35zVvmlUakdxZOVbIu+qhFlqhdTabnoaB2m4?=
 =?us-ascii?Q?hT0YoHyiMk9hF5Q69sYsxxpowkF8lKXKCT4Cyz+nH5YelQNC4gV+OM1Ui3PV?=
 =?us-ascii?Q?84W9Q3KfueGhajqNl7wzRJ8OYBfsSc9KcXF1FxVCGbA5JuhMk/zBS1PDeeDX?=
 =?us-ascii?Q?DIEc5NM/lUobGf0nMte634hEV5ySXehtuvsMfyfqovgxiog1GCN64hawyUlQ?=
 =?us-ascii?Q?ZN7v/IW7PX7oGFLicT8T/nzD1UoqmQV5S6RzSR/lWDzBuuPMuKPE1LsvxLgM?=
 =?us-ascii?Q?j8O4pRS9PUZDWAqc9yLnwqMjvelPQqmkbc+KlOmKz+0ieg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e840e4-f5d7-405b-c8c5-08d8f07867c1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 16:58:40.5517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbJoEZObHpdWHee9AtTeyLWY0ynSx0jbmzUme7Pv2jVbDWiE87ltp/jLKQY9ovz5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 18, 2021 at 03:52:59PM +0200, Leon Romanovsky wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> Currently, ODP caps are set during the init stage of mlx5_ib_dev,
> regardless whether the device profile supports ODP or not.
> There isn't a point to set ODP caps if the device profile doesn't
> supports ODP. Hence, setting the ODP caps in the odp_init stage.
> 
> Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c    | 2 --
>  drivers/infiniband/hw/mlx5/mlx5_ib.h | 6 ------
>  drivers/infiniband/hw/mlx5/odp.c     | 4 +++-
>  3 files changed, 3 insertions(+), 9 deletions(-)

Applied to for-next, thanks

Jason
