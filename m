Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4F833824E
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 01:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhCLAaY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Mar 2021 19:30:24 -0500
Received: from mail-bn8nam11on2064.outbound.protection.outlook.com ([40.107.236.64]:46944
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229956AbhCLAaU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Mar 2021 19:30:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7xZ0nwMeh67Bo9yzeQWMO0jQfjmJwxmvMXrNJSdHmfV5pPXUkUDYx74CNU7XpEcKYR6bKtb17jFBececmKAWTu4Uu2GeEfyBHyJNadeTfH/AlIZyE/ehlyH/SJL8tPIrMOzmIdiHQEcSh6n6ym1YryJIVva+qxUOqYyhII3Ay6OGDXS9629W1w1IRTbkk89udA70HKhLT4fxeL1rQHX1feYaVep/F/L23nckct/sy1pNEGwFbQ2co1w243jaDN40ktRGAT0wpnM7jFnEc/DhMdNMBrzmzxjJfGhg145d9XpcEJtIsOKeaGXS3HViCWbbBMCR4W860jEUvMapGC2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc3dgbzzAWiEAOKm8iVCpx2Z7ay0Zmw/KMBHVEGYVjo=;
 b=DdtOx4j2bHZDnzFKV2PoaRUOu9hEhAAo+TUnbKBt5uAMpKvIXxxNlBc5AOl45DCSJ5lkSQ9pzzsVApY465Xm0T1UIiMrBcLL9NKw+D8awx+0JcTcOXJdfiRqQWc94Ses7poJSLY8Vg1rjXK7CPsc/NbSboZ00P5uZni7EEpgrArE0QLeN10ekmCXRatCuVfgm85urhas1DRsxLibGL3RktkMZmSvMs+5ahbF1IGnW2Yg79QVxlW4d8+CZuG4XtuURLYgL+0D9Jieh7Rlfe4QPnoSpYmrmEgZIG0R6rB0yUN7GnlLwc3RvF4+91B8UV3Zzzw6ECwfwcV/MPL3Z2kEWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc3dgbzzAWiEAOKm8iVCpx2Z7ay0Zmw/KMBHVEGYVjo=;
 b=kF1TApnzaNN6ZO90Cn/rgJ+Y2VyFWLfuDiQgTJ0XqB9g0a6JuuiomrU93iOu4NTHwpu0nTIEMpYngWGySL8j1Ft78P+boDDy0gMRGB7KQUg4Jm6V/VJO1sKZ3YHk20CjocndiS9uzr2nJuX+qcJStKTpudygmm6jbtjOKGyZXx5gRdyUsGk8gYcC9rhoKWxXMJOzqXiWPJExQkUNgiJNMz59mn0wSnzEimhi0CgXhOjSJjNXl4TRRwviT+AzHsCHZeXjZRkpILSzBh+tHsH0at2nktlx9MVPqGhTyDsPn2QbN/+0XjJzvVcd1caMptIqHTBUTVK+a9sSFEK7cAxjXA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB3301.namprd12.prod.outlook.com (2603:10b6:a03:130::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 00:30:18 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43%6]) with mapi id 15.20.3912.028; Fri, 12 Mar 2021
 00:30:18 +0000
Date:   Thu, 11 Mar 2021 20:30:16 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH rdma-next 0/3] Batch independent fixes to mlx5_ib
Message-ID: <20210312003016.GB2787233@nvidia.com>
References: <20210304124517.1100608-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304124517.1100608-1-leon@kernel.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:208:91::30) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:91::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.10 via Frontend Transport; Fri, 12 Mar 2021 00:30:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lKVh2-00Bh80-58; Thu, 11 Mar 2021 20:30:16 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c083d41-b12e-4cf5-bf31-08d8e4ee0399
X-MS-TrafficTypeDiagnostic: BYAPR12MB3301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3301416FD423571058D9AF0CC26F9@BYAPR12MB3301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3Bv6eZAVGbiaV2ZDg/4soHTMNjZfaCk/T2nXY2LW72IbV5GZIGV2QMAI0m5A24+nuALyTBHukwSQLU/oSj8j/1PPDwFf/lYsRQdER7XAfjoNd0Xo4tBRHg8E0qvMDA0LCy0nGVuZYQoNH+SWcbSxU7kUa+fdqcZjuTGjYMrpswky10O9YsjcXaRQyA81pTv0u/D5KM2oMw0cY5GF/IyiakcZuv4no0CfR7eLCyYyxWtMjap1pkebSce4/gnc4pKkoBSent/U1gmF1WQP2NNJGUmBQ0HgBGUXRdVLQVKI2Dtv4GoKa9Pvz3pqosrDZ4h0sapI8yXeuCzu0FamKoujiEIi2mphHubKtllJlb2iduYTCjlM6gwc/+JvWfol2clz9BPOZZADEbN9DJtkI5DL+ha1eSDH9G87YRXr9qbR5sx6I0We8rXyTGWA4LmE278+SMC4yxz1N1ndgodo4E1TY3EIJiWkQZHH9oejY5YE8777lHmFF59ap1RCxjB/Y4BI0XXHkH9PVabm9e/UTeciQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(107886003)(186003)(478600001)(2616005)(4744005)(8936002)(426003)(316002)(1076003)(54906003)(6916009)(86362001)(5660300002)(26005)(66946007)(9786002)(66476007)(66556008)(4326008)(2906002)(8676002)(36756003)(33656002)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XYAWP96f6PNEIyEg7xmAAuPcZfgS/FGmcl4+BLmpZwPrxwAD0gHCqN736CZL?=
 =?us-ascii?Q?0IZQ0umeCRa7kSL2wUqAaGLyNDV54IuZg7F0xldG82RKFBw/wRBMyq3Zgh+8?=
 =?us-ascii?Q?ILbctXOtGsHQBJ3maMaQRxj45Saq2ITc3+oYjWqOduD2GHvsWQVvdI/i5sfe?=
 =?us-ascii?Q?PkLvbRbt9HowzQ6SY1SGg3V8ZaWtBMKiHSex5HG7XWOpL+i3HfRpNpeCYj4h?=
 =?us-ascii?Q?/KfNGnfAsgZqdkg/A1LEE62KwkQ3kCgvqjuUNR+RDwRyaGgbwaEFC8r6w7+0?=
 =?us-ascii?Q?ipYNRyslpf5ZNXTp7DXaij2uoB7WaLxUg4Tc6hY2/iZou236XgPvC4KJZqR3?=
 =?us-ascii?Q?60CJu/8TQyOnaBPNZ4WWKY/ea1yJELQOrSyY1tHslZAAIdjElKnkDzjdiKUd?=
 =?us-ascii?Q?ViVN3KY8OvzalyB0F8sFPrOLvN7h7+3bkiCGZRAtJmwjhB8ef7WgZlD/IAvd?=
 =?us-ascii?Q?uwdTHLM4vJFF0m4ByxNvMRSvjWFJgPGNZxE7XpYbiqXw97DHwJBQjAO8ttBy?=
 =?us-ascii?Q?KncsIvPFbNpRz+oSv6badnaU/my6NDsRYT5RWyCqGJIm2ua2E9+7kYTiRcpx?=
 =?us-ascii?Q?itOIL6xP97P9C51tKuc+EtBlpPR4T3TGvhZhKQvf5zBBuZG1LwFRmDk3sOKu?=
 =?us-ascii?Q?UZQDvQlLqMEsNfkgmNuT0RFzMiJs7D7N+T3gCoOyVn5CzRySTQE4fM4VunZ8?=
 =?us-ascii?Q?beooF1ZmzJF5U7Dp/gE6QeD2DjJvHsIepyWmO0+ea7RRfm1F3ZQF9cBaMuEU?=
 =?us-ascii?Q?jwbslLkDgVbs3iZh5EDuM3pMH36mteRUZrnMfPa+yL+q3BO3bpWm7DXMM8EF?=
 =?us-ascii?Q?iVg5lluhe/LM8XS5TNqvBPlm8pLbfRfWUSLAvB5iTb4Lpzdlvvmb19bRfKL+?=
 =?us-ascii?Q?tecp5YjeFm9PSOOIlDuQlpkUS9TceF1sTR0kTRd/s6y0t829uAU3Vp7jt7HD?=
 =?us-ascii?Q?pKnTY/aWC0BCiGn2Q85c/WvW7NXkjGQaG/QKGiIxc1lExqCUdQJ+twEoLGgx?=
 =?us-ascii?Q?srkVVqXI2RHaU4QfOdyRpDzwbbTYfMe2v/I38+0Ff63leHPaZjVSG7LevDvq?=
 =?us-ascii?Q?jZ95GlipafF2WZE0+mVMtkN/K1laJeyc0USkKhb3UUXE+ViGJSRH66eAIkK+?=
 =?us-ascii?Q?7zgdnTg+sRdV0ocUNvyljmuXat2Q8NXvcLY7x+pzxJrUJ/uPlRm3+Zqybh7/?=
 =?us-ascii?Q?6apBD1IQR+lpdX5cMF1qEMcFJQrJjWl4mSiR8ImlKvcaZnsEgQmJf7gHKRPx?=
 =?us-ascii?Q?vYAKSEmgVzgSBKT6OjPZVCcMYiLPeLhtjkpfXVkYhZNRoZ3xzxzvq+GwkeK/?=
 =?us-ascii?Q?zKSynj6bChnUZGzufeiM7VUbxrdacvFHvyl2yW8q4PXrTA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c083d41-b12e-4cf5-bf31-08d8e4ee0399
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 00:30:18.8011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBBAM/oIF1tPUUwj3oKDh7yGRQtOtBKj0C49/D+gAY7miIOk7fsAuNqeDja7g0n9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3301
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 04, 2021 at 02:45:14PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Completely independent fixes and improvements to mlx5_ib driver.
> 
> Maor Gottlieb (1):
>   RDMA/mlx5: Fix query RoCE port
> 
> Mark Zhang (1):
>   RDMA/mlx5: Fix mlx5 rates to IB rates map

Applied to for-next

> Shay Drory (1):
>   RDMA/mlx5: Create ODP EQ only when ODP MR is created

This one needs a fix

Thanks,
Jason
