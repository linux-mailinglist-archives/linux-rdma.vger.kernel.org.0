Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6BC3DF479
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Aug 2021 20:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238828AbhHCSN1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 14:13:27 -0400
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com ([40.107.92.64]:41922
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238787AbhHCSN0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Aug 2021 14:13:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCeZVWFjoj84ZbFEnOP1nD6rBE/PwpOdvsuvphHSbXo1YPiW1pxzln9hG3tG1shxC+djkcKBKHoH1+YUz/cAKfp+Q8d/U5PVpmnmyYSYlFemTcIDcScEX7lAgi7X9Npe50IhOR5WlfTfUNvmX5lyZqUJYqqrnLnXZZWZ8SrfX9iGfNXUArKhnE4qjWJBKdIYXzNUZDa+LJ3FzVB8TWmxAl8sl91LLi4FBJqAt/R4ow/LxUKZ//inY7PFY7UiSXk181S3WmTswH7QmeMh3JxUx+VCEa6zTOkOZmXtY1euLNe1pEgJbIKO9sqd7FOIRwmU9hPKQ0hGxk4SCYaUzE+TIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJJSn55LDNjRHtwIkso2Lj7QRV2yXQ7uOfHV26RkC+w=;
 b=oSE1PzUwpV/vBE/hwr2kC2zXynklrukijtDtciP8FdGrdinMEACmVkbyldeWNv99ZnTcltQFoQiaDQQzYiZKZF8/Pm9ZrWwKeFDRROYmGOSnbnWvW0qK4gKaHS5nLc++TTs1cEXXV8Nt7JAKuUacq8flA6ULCQnwvpD19esws7o2hhBxL6mRJHY4z+VLyYRYmaif1yh0FyvAJKLWkquWgA7zUUg03a7fJy21mqa6KiLbAeqRn3NRr07OVBcsJrXnT2Z2LJVr/hybqbSAX/uLZwlCJmno+74rSiaclpNKjcpxUJdTsx+SUKTExMcV0zg2A2Fzn8HZmu2sjaOxhyFtSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJJSn55LDNjRHtwIkso2Lj7QRV2yXQ7uOfHV26RkC+w=;
 b=AgsMPoaBcubVBU6wm583U0zebqA78CJNilYZ0FLJb40Enw8XGWlT308yUX8ButpuPRDuvjvAUpzK58pXIKIQiQjzzWFyS5QYypKLJ8JBngIGzL683cujKe/ZEqHd+xT1asJh3UiE8CDTqXwrw3CktoA2GI/i3yX8f/It48qw/KoRcR+Dd1RpVw9Nf2CsfSesJ4eYyRUMl1CNK3o9021CspfEtoxyAL5OZK71bxme8Yb1RUaIHWOvlk1qWy371nYb9gQ5T9ieWsDYrNSLdvqCNEohZMVwCJwabHfEhEKFyJfgea2PDMYUwZSt9OqntSK8Dw0gcE80dJJG/sUxyEOuzA==
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Tue, 3 Aug
 2021 18:13:14 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 18:13:14 +0000
Date:   Tue, 3 Aug 2021 15:13:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH rdma-next v1 0/7] Separate user/kernel QP creation logic
Message-ID: <20210803181312.GD1721383@nvidia.com>
References: <cover.1626857976.git.leonro@nvidia.com>
 <YQmGsMPyLQ2decBD@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQmGsMPyLQ2decBD@unreal>
X-ClientProxiedBy: BL1PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0130.namprd13.prod.outlook.com (2603:10b6:208:2bb::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.6 via Frontend Transport; Tue, 3 Aug 2021 18:13:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mAyue-00CEb8-PZ; Tue, 03 Aug 2021 15:13:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acdb8b4e-c6a8-47bd-299c-08d956aa5c1c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5208AF30BF41762EFB166C02C2F09@BL1PR12MB5208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5Ec6xRkjbMWIR/cCcjP+i8Bj6YJem2Dbxx7sTL0y3AqLI0KbuVwLLJBHTxdNjhQ85/EQ7/P5YIDQIZOAyJjwGm8QLvEp8QWgPSjqroEz2la0waurelpl5OfAYQ6BCjwBlBv1ekYMnIlXcmO7XeBWIp+pjXiGJDwjaQIetiTtAP8KEJURqzpw/p3K6Nelt6KK5jdg2bMok1i96TgBArAZNGS7koHzProMfXCE92DeOqrnkobGLRXNhbv0dhUNwRHv6PtsLqKT1266heV+vgIaHQheUAfsapF/QAM3ugfc/H90Gq8E+XMtOJKXIlT4cMNlCTJJyP2EoI/gqsuM2qcn4S0D5QVzQmsYQ2FpO9GhjfFi0M692XPJfRPZEMuWkmobQhQGC0kPCNGaRatgsOEH2VxOk1jTJ4WaPSbsTnzlRZ70A7Xwxf8eQ/XmSN5OXWwhi6ThEDv9amdDTufouVlj4CoPCB4DrC4VRtpUD8zlB/ZCVvvN05hEQsGBKfW4ZT0lFhbuxbCe0hYgK4jIJ1QCfWEfq2ga21ml4XhBwbmBeLt9Qp09RQ51ywq9T7MHBUuJRvWk8uWonJVMGx12MTry3KQZJ7gHlD0az/z9NBdTcWyVcFyDUBRzVgU1xKF4LfPOn7nNWPtPfbG4Ksj5Nc+cCqX/YWKOSs6BjHo8TUuMb9D6aKl6fBgE/mIWd9Q5wuXBpgUptjLgdrfIQRolQpNmMlDfQ6oaxNLvmS+gzPl/Fo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(86362001)(186003)(66946007)(8936002)(1076003)(8676002)(6636002)(66556008)(66476007)(26005)(36756003)(83380400001)(2906002)(426003)(2616005)(316002)(6862004)(966005)(38100700002)(9746002)(9786002)(5660300002)(33656002)(54906003)(478600001)(37006003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BxeoRYtGhxn9vLWm4SYbJzthdMBUVs8lqiop2S17j1Qln5VnFQTGlQQTBJIV?=
 =?us-ascii?Q?MnBrWrFjcem9NhKWNsLDlE8EO2UYNFUh13MA0UPspdnOhS3lf2m1pCi02/4u?=
 =?us-ascii?Q?iSk80Dx7UHIf+Bx1UzvIUILTgsQMGH9TTUS+cf5qil1m9pbKHaxkn2EpDtxE?=
 =?us-ascii?Q?C3cZu5J3svfxxUK/zKlaM5JxF1ozQBw6D03/dIBZt0IEBNs9kywisX9FA4Vy?=
 =?us-ascii?Q?g4alOSi+NE1d82m1l5Cgtwe0xA3WcHOKrWvNKX8sdBQD0plVBVXxYz+nXlJO?=
 =?us-ascii?Q?eiAnPPX79yiUx612aSfCssELsjouTROWtkE60gGtGZ4/YLuVcA9VbmG8OVAR?=
 =?us-ascii?Q?PPVrDMPLEBgbxBARRs4FGUFYNCftjsZ3pTkfLZO8OU4QC4i8bMCxmfZ5S6F4?=
 =?us-ascii?Q?oGvO0RgKo4eEnZywHHhpxcJDbWouFM04EpYumtAs/j/nGs6sfxQrF46de5WB?=
 =?us-ascii?Q?YeXhlkYayADtY3Jhx9USiS6w+PIfQA36HCSy4egYnbDUdcrbB9Wv3GtWZsY3?=
 =?us-ascii?Q?tPtQU3jUclMeiSdQGkKUJOC3kRzjGoe/jTYD9IdAaqHEj/+T00fPQGMCOoBM?=
 =?us-ascii?Q?QIyLNuBV9cyAJQ8i4PE4Pnwq/4akGmNOJJt1BHfkbxeSlHE1V13yILUccXiZ?=
 =?us-ascii?Q?+o1+EqfGA4kzqrqXykYH9vDegD/GzCKjbI4QhmDqwWNNLxp/jSnWe8NDj68L?=
 =?us-ascii?Q?eBclWi1QzWUOwUCSoaEkNcL+XwLk6Vrl9Ot+pVqXAXj/A/d0JzdEnTUVPKUe?=
 =?us-ascii?Q?kbC6RTQLZt4nL+kc04Q3QiwQvcQRjt904Tl5UPV6aRzzX3mtNSx2eXNnB+3q?=
 =?us-ascii?Q?mo+4lN8rWPiSRKmqb8YK7kUGQ5MWMiTX0bjHcAWnk1usF6se9cvytE2tjYlH?=
 =?us-ascii?Q?lT2p1e0cdVv+ESJ4BzNov0/lLwVN2PnDdQ12XUbLDsK7FhIbJMhUNzS8n1pu?=
 =?us-ascii?Q?h7IKO5ETA7moa/3lY83hj1ZcJAWtBjp8KwlVsHIZhkRr84G6xqtKzdTrMIW6?=
 =?us-ascii?Q?xngOEL7p7h+pE4nxmZe52Nk/lVqScSDO+C1j0EbeTSOBId6jSWOqyVOPa4qd?=
 =?us-ascii?Q?VZ533ADPT2D0YbeTK82S6CxbejMGddE+i4J1fmR1alJu1GqHvQj1U9Q+mLms?=
 =?us-ascii?Q?VvBX7cjHS46ZWgY/cElJBY5TDR6m8Ex2+ilMPecZWNpT7TIg+fXkjeiTzBDq?=
 =?us-ascii?Q?JFsWnJrBJ8qwR8DsaE5fWO17ia05GtHCvI5Jsmd3B0pH0rekh4RhzFq5wnWe?=
 =?us-ascii?Q?/deDYVDb/Di7+IqtXNgaAXd2KtDnqXmMkueXuWIHQgiPk++dZ92cOi7kQKtT?=
 =?us-ascii?Q?rfsMLi9KZfAvWB11CAhIaPgh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acdb8b4e-c6a8-47bd-299c-08d956aa5c1c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 18:13:14.0887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MF55HeuTEdfLdNPvvAvcpNY2y7DN/DLPk5sf8cnB4hNByHn4VCc6hS6ydY7Qk+6Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 03, 2021 at 09:10:56PM +0300, Leon Romanovsky wrote:
> On Wed, Jul 21, 2021 at 12:07:03PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Changelog:
> > iv1:
> >  * Fixed typo: incline -> inline/
> >  * Dropped ib_create_qp_uverbs() wrapper in favour of direct call.
> >  * Moved kernel-doc to the actual ib_create_qp() function that users will use.
> > v0: https://lore.kernel.org/lkml/cover.1626846795.git.leonro@nvidia.com
> > 
> > Hi,
> > 
> > The "QP allocation" series shows clearly how convoluted the create QP
> > flow and especially XRC_TGT flow, where it calls to kernel verb just
> > to pass some parameters as NULL to the user create QP verb.
> > 
> > This series is a small step to make clean XRC_TGT flow by providing
> > more clean user/kernel create QP verb separation.
> > 
> > It is based on the "QP allocation" series.
> > 
> > Thanks
> > 
> > Leon Romanovsky (7):
> >   RDMA/mlx5: Delete not-available udata check
> >   RDMA/core: Delete duplicated and unreachable code
> >   RDMA/core: Remove protection from wrong in-kernel API usage
> >   RDMA/core: Reorganize create QP low-level functions
> >   RDMA/core: Configure selinux QP during creation
> >   RDMA/core: Properly increment and decrement QP usecnts
> >   RDMA/core: Create clean QP creations interface for uverbs
> > 
> >  drivers/infiniband/core/core_priv.h           |  59 +----
> >  drivers/infiniband/core/uverbs_cmd.c          |  31 +--
> >  drivers/infiniband/core/uverbs_std_types_qp.c |  29 +--
> >  drivers/infiniband/core/verbs.c               | 208 +++++++++++-------
> >  drivers/infiniband/hw/mlx5/qp.c               |   3 -
> >  include/rdma/ib_verbs.h                       |  16 +-
> >  6 files changed, 157 insertions(+), 189 deletions(-)
> 
> Jason,
> 
> Can we progress with this series too?

It doesn't apply, can you resend it quickly?

Jason
