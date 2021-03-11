Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6B0337F30
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Mar 2021 21:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhCKUnJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Mar 2021 15:43:09 -0500
Received: from mail-dm6nam11on2080.outbound.protection.outlook.com ([40.107.223.80]:59873
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229688AbhCKUnD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Mar 2021 15:43:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrUxLdXdocn0aDYXo0Orz6fl90fATAsGNahczFa4kC8dnvtY+JD4Ni5F9OTPIkPWBWhzjWT34xxS2+rXSuSdf5JyfT/jxbHWmKz45EbREsYcBtSib4ng6LctbPFF30c+pmtBnKx3Gu4xzQ50fj7iGJYJTl4NSVANMlgl2dDy2UjDx4p1//JgybEzK60hspAim7PIBxpifqDPUBpGpABjonn4eXB+oqNRfMBkEBkxsgCB0DDiQNhxYU3xNoTHwDTETsmtkDrKZuhsWK07Vp6208hpICFl2U4wN/x+5afmpCHAFBeiscEyivy/NubGGRm4o0Y1ZpdCPnxD5TAWgf4ifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ni7ogW5W7m3fOouYhDiegf+YPm2nLKul+zp5v9uezAk=;
 b=F8CpF6FAALJ8PYZu7n0ed/OxfNzKGZVaCjrAk2xwPGiRRKeKdoy2ENsK+scr+GGt81LZizniDMm4iv2dH3cL8IBFijLcEE4/FVhO40T+3dEM2Z/zBqWe6TMTiMXIBdQjJ+fRzPoCp44GvQ9HaVhwzNdE2Lw5m8EbkfsEffAh28XmhlJFYXcFzknAokvHoDsynVmWgdK/cp8aw5qqqj9kNq5yWPq0gFKo01qyLR+b/e485FHQE0qXCOUA3I7UF6SOQynPYFV2j7FehrIjlFqeDXuztcot4X6Vgw/lP+OX42x76rSbMd1w2Ot9Ym07yl+VOLZUd/Zv0Sm9FGLhLFRABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ni7ogW5W7m3fOouYhDiegf+YPm2nLKul+zp5v9uezAk=;
 b=jDl+2pVOxUu73WckWfZlIE2qEQalKcO6wPHsNyfgBnlP7PTx+pGW+MaEBp0FUfA0tluZ7gndCs6hsAx61C/pt2eTmaYETcrgMOvC8BjQU3mWpzIuGHLz488+YQNqu0ubnBwIYP2fOY3Ri3ku1EIgB2MtnPXUqEt9YGqgq2dsgKaclRne9mnH+UFYM/mjnTRSQ4H3itJTmcuX3hWrX9b/BArKc1bCtn3qAGucJ9M3lOmPMz7DkH9jcWh2cDrjiWc7tebA1XBvG1PIHMTtvFZMiFvgjhsGdQFayJ+u3YuUUmKt6EscLZRoxytwh9mCGdbUn/BmmmlqHDeFVN0KHBpuug==
Authentication-Results: cloud.ionos.com; dkim=none (message not signed)
 header.d=none;cloud.ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2488.namprd12.prod.outlook.com (2603:10b6:3:e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.28; Thu, 11 Mar
 2021 20:43:02 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3933.031; Thu, 11 Mar 2021
 20:43:02 +0000
Date:   Thu, 11 Mar 2021 16:43:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCHv2 for-next 1/2] RDMA/rtrs: Use new shared CQ mechanism
Message-ID: <20210311204300.GA2749140@nvidia.com>
References: <20210222141551.54345-1-jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222141551.54345-1-jinpu.wang@cloud.ionos.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::11) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR07CA0001.namprd07.prod.outlook.com (2603:10b6:208:1a0::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 20:43:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lKS96-00BXBq-Cn; Thu, 11 Mar 2021 16:43:00 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bda5831e-318a-4663-e109-08d8e4ce435d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB248888C3C2CF72C25B12A12CC2909@DM5PR1201MB2488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDR1+WOMyLu35tNcDIaiWxefOGPtWIRf4TWxgzr9HD8OZT5hIDsMymgdMe+YSAY2GPlKcYZ6wh7nsZYouZwIMLW7e0yQGbxV6rxwAAEba8larwVp2wCA8iGEw4Uhkcum8WtcKPRPRYnuc+9tycKmTIXqC0PWvdP9CCiuazQO9WlhotutD2ZD18vDfvvuXnXJJ9ie8ATfh4zcaMnwMF2gAFVgVTjn9rmoJnqF+znA43ggf/4TrIEAI5xwsvprOvqVLjrTtQPypgXq74qANQFUKaAJLiWHdXKwlh73EdzmCtcqBxvY8XsdAXpbD4XQRtt5JWwhfA+ZCsCZibDQxL3n0mW6hoZOzjutz/KmUu7O6vlv/IC9Rgy5OgeR+lLf5LHMrZNTep5/YD8fJTJuE6k/b+Bx5fvunxq+/YN6uEL+PG5eqb+BPfVbp9VQs9+VWdWgSDwvmwl896ieYraRJAUUkBXs4l5FuR3OIn8tEAitALgCTTB5eMc6K5+U+q7+UMIUx/w+68Ddvaw7NSq49xKSMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(107886003)(26005)(9746002)(66946007)(6916009)(8676002)(33656002)(478600001)(8936002)(9786002)(86362001)(2906002)(186003)(1076003)(4326008)(5660300002)(66556008)(4744005)(66476007)(36756003)(83380400001)(316002)(2616005)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?i0TtVq5nsBdtsJiP0CAjRfPymiUDbifptOqnMIlW1/gTvVeRvK5U0Hp/7qgr?=
 =?us-ascii?Q?bz7SytWd8iHS1+OnE21PIoG4sWyq83O1oa2QqG9j4qyMV/cY0TCgapZCEgKv?=
 =?us-ascii?Q?Q3BDU77orM+BJW/8P/rdJ7gN1rTzT7LzNos8PKZRzldG6I/vK7H1dMF4yN+r?=
 =?us-ascii?Q?WpzCulBSL1Qwy+gwx/U0wjOISRggG5K27xScC3AVLQZJC/FE405KzdvRN7uF?=
 =?us-ascii?Q?8Az6ngpm2cwzoeO6DC3UNnynTIv8MUDpCkwbLx3i9fhaaNyjAb760hGh8iVU?=
 =?us-ascii?Q?g7S5dMISM1nElQnPasZ90Nx251sLbfLCZKK5Mbfc5m/LU0xFrqkAMrWuSNGM?=
 =?us-ascii?Q?bY3MgsC67duizkDrkGr4LNCi5UUQGGd4LchX+Lo/l75bOJLo2FcQLSarW8NZ?=
 =?us-ascii?Q?dHis5QF20qQ12eOI2ALi2NbX0FpXNGzaCJN4yhCHkbRoVo9iIv3a+YjuVruI?=
 =?us-ascii?Q?g0Qeo8VI7s0PH9Zn/YgCddxpZOiKOUvVpeZVg4G9D+dv6J2SJuovVdXkWK4d?=
 =?us-ascii?Q?STCgUOjbozLRfzj+ZzI8C0QaPjAQ6l4uPg5qpLZKmrz6H3lsHl9TAENcKmen?=
 =?us-ascii?Q?8nfCjm83qrswrQzIhrZC3GjB9jkq6mWj/DcCyp6Cx4w52WeGJ+aWg1YbQumf?=
 =?us-ascii?Q?2qww0BdAVWh7rI6wVTdoYQ6DslnRTIQ+HjdjK5GK/2+Qsj8KA4XIt5XAi22v?=
 =?us-ascii?Q?3ZxIAGeO+VQjoIzw/CKfWRJI1Aa1pPshqmz3p44WYOUg3HAZTfkd1o8/qV2f?=
 =?us-ascii?Q?U6Y225LFZo+FZeBpezvi01PjrWkVdFWWZIKOi5PRiBdNoJeeiA2DvNKUl5BB?=
 =?us-ascii?Q?EAGUztpwN/luhLY8pidlHxCxuYkI3ZCDmlQBPsPb91N1/42eDEeB3U1MjE7F?=
 =?us-ascii?Q?WgZvMTQ8t6Vo2/lZ5hi8TKSL56GOIgcD2ivWOz7O5JedQGhTMWzN98dvApqr?=
 =?us-ascii?Q?a8MAJEKn+9PaCA9VO/WKf4ZD5StQ3hEeTcxo3OxEl6pnafdALayEcJ5F6W98?=
 =?us-ascii?Q?fJ4qDnTM2KNHvMERCbdK4q9c+XCYlPUhr91SMS7iz9V5wcb9d5mQtrAdHq7y?=
 =?us-ascii?Q?it0I7PB7bDNUvx7fWEpsK+yvCurKZhITBrJSXDGpG3mOdsFTkAQaEJBCu7vg?=
 =?us-ascii?Q?Qi5g+gmiePmct48yi9kGbkZ1MLbnlYqBc9+aEcC/dhQRl/mvILc1H19pzMRx?=
 =?us-ascii?Q?T3BJifYZ/DxSOrTFSCPypd6cEe0WZR8w9uwp5pK8kMK9VeGoRkVA3YJ9UdRE?=
 =?us-ascii?Q?3jN9dFnHVpCiFXrGcDnUagvnRTSrXmBSxiW6C/8CMz7vTPHQw3cZ90axFGfx?=
 =?us-ascii?Q?4jhvvxGYV0GCd8yF0xwZ03ZSA6AK/SIXXhqfMzksJEy3+w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda5831e-318a-4663-e109-08d8e4ce435d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 20:43:02.0525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kU6rpTbzfz4NVSvEuPk5ZBAaFKsuA2X0MK7wbBFez+DSFFvHXl1SpKG41Ked37HU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2488
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 22, 2021 at 03:15:50PM +0100, Jack Wang wrote:
> Has the driver use shared CQs providing ~10%-20% improvement during
> test.
> Instead of opening a CQ for each QP per connection, a CQ for each QP
> will be provided by the RDMA core driver that will be shared between
> the QPs on that core reducing interrupt overhead.
> 
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 10 +++++-----
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h |  1 +
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 10 +++++-----
>  drivers/infiniband/ulp/rtrs/rtrs.c     |  9 +++++----
>  4 files changed, 16 insertions(+), 14 deletions(-)

Applied to for-next, thanks

Jason
