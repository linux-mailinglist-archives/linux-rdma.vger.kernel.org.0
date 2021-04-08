Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2836358D4B
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 21:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbhDHTLq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 15:11:46 -0400
Received: from mail-mw2nam10on2043.outbound.protection.outlook.com ([40.107.94.43]:33238
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232970AbhDHTLm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Apr 2021 15:11:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeW8BY2A2s+qhk/VevF1P4t6mbOliVtRhhZWLIeU7WNqtqbM4xhJ/A7Yv1vLbItz6q6RXEFHc27r5Uy4jO2zEFUOVE1CHyWwxXugOqjGTW6SiNcKklLUC9BrKEP/kDeU3tnlbc7ZshpEqvbaRusaNgsQM5h9JDHwHWKV55IaePUI+JXXbJ8QtfeCMShdP1K0e7nRyGkCmcX71jZIFg2Cu4Ndm7xmAmEbQqJ4xMT+xlaJzdzW2b/9SFoJNfAOaP/KszbCkGpEEPtItCVOlP8Ml4G3Y/5WuLKEILP9sdXduC1wkZkYzgbIkVa/0/HOVYVVoPsKtRRaX6jgp/ZkpBCtQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56Hax509Qj8n+NkdmWwdlpJdUPHQzlUGm5kTGowP7ek=;
 b=USIcD76KSQotItBhC3cpweUyO03/BMVWVfGJj+F4XwremPOwCnQHzNjRWRi2Y0cJ9Vlqy+3nLi0428K3EwG4AWRNV06ZwhG+GbCVd4HOcaRFpo56MyK6taQ6RpChFKwQcDQFl4WOMSNn8p1eKrFrXvb0ehwYGwoeUc+sEE/xL765i//UuBDxCIMzOKJJ7Ofdun8z3PoiPmtaTgE6uHdKIJneKthhbzHRX2VCxs7xNbpynvfEc8cOy9S/0qGhHOruSxFZRkpZdHWH+qhw1SHMpQY/HiMc7tC+yaSjMo6A1yG3Dm4K4APdG4RISwwu6LgaVEYPFu1dy3NdiyT7aoENWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56Hax509Qj8n+NkdmWwdlpJdUPHQzlUGm5kTGowP7ek=;
 b=PhR/q24Z/WWJBuNLSgInu47D8Pz+mNl4tSR+WmQWM/dWonbP+kDLZUcZiCxqBoOdHhRjwTTaiGV3K0BESAZY9apZDtpyI0gMoE78OMjiOKPA2Cg7PWel5X3v6X9CXNdN02tTNxFUx7WzwMqfHwT355fgK97cLnofJlyT+0eFuqib61u7Bxjm4yYCfnIT5vFaRc58cusZp5p7SDhoNn/FMIOZsbixfQVD2v+Hg9RPZ5jSYQLP6pd3041WTsIk7RbUC7JTAvCl1b2zOrnvQevV9k2ggxU2Prj6zDnME4gdvXAFiFDOiqPMijnpO4ECqbQIBNt0iwoDKN9oH0ANRz3G2g==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Thu, 8 Apr
 2021 19:11:29 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 19:11:29 +0000
Date:   Thu, 8 Apr 2021 16:11:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix missing acks from responder
Message-ID: <20210408191128.GB692402@nvidia.com>
References: <20210402001016.3210-1-rpearson@hpe.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402001016.3210-1-rpearson@hpe.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:208:e8::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR20CA0015.namprd20.prod.outlook.com (2603:10b6:208:e8::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Thu, 8 Apr 2021 19:11:29 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUa3s-002u99-6G; Thu, 08 Apr 2021 16:11:28 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee824954-581e-43e2-d923-08d8fac21d49
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0203D9ACC0CCE450B5D24069C2749@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VVpKe7PpzwS7jHTcX2AcI948m/wv5kWRYqFLlVQs764zlGawEzx0evFTVGWZgLUk4VQuO21g1X7js/pvPNaXmx/hl8jjlHEahzVz+HJaUTgPxcoDgS8LoYhcJ5lIrmqCJjsOSvLYnNk1bekirCkMdCLk4eMJMZmib3J6q0tF64FYAWj5WfY2m0u4S8dbAwW8X2DkKwQYZTKcbLf0mXbeTMyDsltv3ilkFUTKyIUhfYBQ3Z5InaY7uOSdUZXtjMhsFHsJCBwKhhX8SAi41S92YRqNogAQR26B1hQcV6IyYfPkXPSBTdPXJ0VWSrY2tGoiQ2G+5oVs/ZP706CanGRPuARf1XOzqmLrod4ENHRB8EsAwPCWiZautJp60uECQrkJSIbZAYgKFN6u9lnXMu7bFmDLkmwGkk7hyEXQZg6q2brMDPbmh7woLL1tW/rF0ieTvkZzzs9gG5dsPO2b/lFrI0qyg3gIIffV0KjBaQVXYmv+ew1Ms7NT0mnJrYHCR0J240HHZyI1cdsGP9ssrRmyFguQc2IUK0KDv4grgl5vG6G4cPQb1kPucVvHUABCraV34BuIbm7B0V+lPkVWoCiK1y71K6cNdlIZBpF7beAtde3vwxnEC7w4B2GPqxe3qGTzNOSAwmJH5EdNvpwFLX07LF0+sVt2OwO2gcP0PFIGR1RFBG57dlVwJVEF4Npvkx73Y5R6xavQa4kbn0PI/1DfB5C9pQWr6ZhbWjxfdLa6YMAgwxAFdcBD+nBJ42bL5UhthLKmE8tf1La6oJfbWa34Vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(38100700001)(316002)(26005)(2906002)(2616005)(186003)(966005)(426003)(4326008)(1076003)(33656002)(86362001)(8676002)(9746002)(9786002)(4744005)(66476007)(5660300002)(83380400001)(6916009)(478600001)(36756003)(8936002)(66556008)(66946007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hWOjefm1uhOZJ3+S4NjKtQPVxaKhG6uKAIaSs42Ah6JFU/40CRg+7y3dzcQA?=
 =?us-ascii?Q?jwAo9PFfcUkbD/Mzi6G+IqKEWU+Az3UlZCrH4atRenRndu53AY+21ysy0nAE?=
 =?us-ascii?Q?oFfUtkmqfUL8ju9m9xN4uK6vJWhVjIB/HJOLPaUAwa0XKhChJee3gr82Ncj1?=
 =?us-ascii?Q?KS+qq68CTml/y8R0+iXfn5h32H/JAQPFb/x4tssTeBwQO4mDlTB+M1miiqcp?=
 =?us-ascii?Q?2otkSeFEVfMvIUodHBBOyrBjGKq9WWjGCyRWAh153N6UB3zHhKCyvjTRnpy/?=
 =?us-ascii?Q?9NE0SjwB2ccZ6kEHo3fUGlnVut612gS6ZaZlmf1Zi3hcYap2eSDAtUrH8CQ2?=
 =?us-ascii?Q?frZwsYqcqMdCZINz1hEk1X3+LpLogjESvNM670fGvn8yVHA+UR1HV+x62Qa7?=
 =?us-ascii?Q?M8MdeDu6O3cIXUTKhRve65JrzUGuTYhTVOwB4CArJ+8fDTEZakOfwhQ/V4rY?=
 =?us-ascii?Q?hzPUTuQ8CrDIJA8D3WR6bbzrU5CEMxct/y9cqE7GPvDLYdaWsAZBrVN7FMT6?=
 =?us-ascii?Q?x1/2cfJJtbpHzSDmcKPsaLvEmOnTxL4eTIoJIw/BB5gr1vDdtJ3rgjHbpKtt?=
 =?us-ascii?Q?+U1Prgmx3pzIB+Pio6ulBoJ0plYGoStzvRC27T2nf+FuJMmncidEUTvUgMg/?=
 =?us-ascii?Q?JHNe/oePwXuequ928Ki9FNq570ZSewTBMw9RO0hYSPwRdpmHgU10o8py757I?=
 =?us-ascii?Q?zllrj912QDm7eUabl63E52zMDzYMAFnqZGYWT8iYY+QIyadCi3ThmcXd3Ms3?=
 =?us-ascii?Q?NQlxLB7a1JwajaqRZ71zyy9ccB6AdKYS0HaerMz2NB4MM7pZ7ZHkdVFdhzUa?=
 =?us-ascii?Q?59m2XCiUot7T6EIv/8LrzUHTohVzDcHqXpzw7ZPyhnNpMckVLPqret5X1CVd?=
 =?us-ascii?Q?aWpWpS3EXUA8CiWJSVsb4EWnO4i3IOfjAmwZyJ6jZ9YO+vNbr4j8y3L9JgUR?=
 =?us-ascii?Q?PoQwuErhP97Hu9lNOX19ph8vzimc7MBdDtV+Dt4o8aH4EZ7h9ccXXu9+A2Mw?=
 =?us-ascii?Q?n5Ps76A+dx1zOlQjO5SKbK64JVKFe4GJthcfgxx66Cy76auAeJ772cKkfwWr?=
 =?us-ascii?Q?5LBhjQ5W3pdYeNwFMMPFRJ7NycZFp0TKXE5F8Qm1CakPMaobagOM5aemVdBT?=
 =?us-ascii?Q?JGDGAqA7/PSL4uUtkay12h++ugmKvq0w/vDCqxuisX5kyGNTTzznLs9dubtZ?=
 =?us-ascii?Q?bfMfn6uklgxp6OlDUXT/81brftTZal0MjlMt5rqX3FJpy5xPGGDYw/coBF0S?=
 =?us-ascii?Q?4EIz43+mjkpZJEXrKY1pR59VMJXWxl8thIP0KrL/DxZ0IfY95GjNjRWkR7Ix?=
 =?us-ascii?Q?iF9uNzu1yT79x4g7nB92N9ZKNzmVT3uuK/tD0tbEN7Epxg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee824954-581e-43e2-d923-08d8fac21d49
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 19:11:29.7692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VVsQXm+oixTGZbiFf5R8VTg0Wknw9pJOmJ1c5CRtuJoxLh9KRTpSsaCqOctlWma
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 01, 2021 at 07:10:17PM -0500, Bob Pearson wrote:
> All responder errors from request packets that do not
> consume a receive WQE fail to generate acks for RC QPs.
> This patch corrects this behavior by making the flow
> follow the same path as request packets that do consume
> a WQE after the completion.
> 
> Link: https://lore.kernel.org/linux-rdma/1a7286ac-bcea-40fb-2267-480134dd301b@gmail.com/
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_comp.c |  1 -
>  drivers/infiniband/sw/rxe/rxe_resp.c | 18 ++++++++----------
>  2 files changed, 8 insertions(+), 11 deletions(-)

Applied to for-next, thanks

Jason
