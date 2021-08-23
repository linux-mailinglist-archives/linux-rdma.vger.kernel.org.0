Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660F83F4E0B
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 18:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhHWQMG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 12:12:06 -0400
Received: from mail-bn8nam12on2076.outbound.protection.outlook.com ([40.107.237.76]:10336
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229627AbhHWQMC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Aug 2021 12:12:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POaXDuz2IGhhYQYqCR+dMwOGrgNG+wf7IGsPOUk/I7livLEAQW5v42IhrWj/b0Nt99aTQrYSHyvQm2mZc6c1n1zDJi0qWq8dgSWr5QNye3UO951ZXgi4019JU1Bi1lOZTGXJXnJMBm3zgNPx/ahpsUo/1Ie+9xeE0dkN4eGfEYXppS4XUZN3sByyMesxEONdMgxWcpI9wxU+VQ39IwQCGYUv2CZfUpewGyx1ih7DYYu6gEYyfHC/1cpPeMFhueNqMWYG/J2bsIcDS7h2Wmf/Q3/BjG69U/eXoTeMedi1ccGSqTllLIKw+gCHuqtzHWQQ3KXF40o79oDLzdvIItpTdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFqyQM98zySzbId/CCnBSWOFMiQ7jmWKcC+1W8X71nA=;
 b=CRqG52xsjd309ojwawOryu6oUoIfv11XGP/fTx9OQNoZE9eYe/NttttrtGDWbeTAwSqO/zVWwGO7pvpI6m2/og7jd4ySDuiDsV+TTtM4sdNTJJ3oiEMk2U/+3qcZo+RghFKgrnibfEx/kcIct4x2AWzRHQGqsU1wij9HYZB1YDkSccbcTrtljwGZUsz41CtbsYlWDMcR6xKtkPRlvxWeAzJT0TOy3ZfWRJiILGGi4nJJtp7zZfEZ3KHIoCFTXv5kfE86ZRaBIoNV9fCyMi5uY707d5BRxowa9hFlsSokjRdHLAJNkzN2J4f9wUDpPeemlLpCxa6jY5pU+lPCFgv9DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFqyQM98zySzbId/CCnBSWOFMiQ7jmWKcC+1W8X71nA=;
 b=TaxwE1ZmQKnwVTsirzQ4Vv/cUx/sNmvfbksJG4e+mNJD9WYpY3vMAItYI/IjptYFJH+TZ8m/nUPtFBbMwwW0jzXoVt3yoyJMAElRzklS0HirvHGsIkZabhHf1uu7QGQOwFWRdaYPE14SgeWlz+19b4wZ3OVPwYpL8ozIt1giWwqYQkQe6/zYeylseet3xg27EsUIkQPPttw2OzpCyILQGBk4rAo+rywTom84Qi3hlhJNEg1O/uRMhLXpVsJiSPUiGgsl9uC+FEUoQ+zSG5X0imxcO4/NDgCF39uOwmuhjD8DLHJkh/la3IInM8OJmAk0wE4QugaepRT/+DwJHXD6AQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5080.namprd12.prod.outlook.com (2603:10b6:208:30a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 16:11:17 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 16:11:17 +0000
Date:   Mon, 23 Aug 2021 13:11:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Message-ID: <20210823161116.GO1721383@nvidia.com>
References: <20210823154816.2027-1-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823154816.2027-1-tatyana.e.nikolova@intel.com>
X-ClientProxiedBy: MN2PR16CA0027.namprd16.prod.outlook.com
 (2603:10b6:208:134::40) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:208:134::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 16:11:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mICXc-003iYS-L2; Mon, 23 Aug 2021 13:11:16 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5344b81-ee54-4e3b-20db-08d96650a38f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5080:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5080DF28D7D81FAB094CB994C2C49@BL1PR12MB5080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wcjKACBFme/M6T3vD87sqeQ0IejT2qXxWPaZGuygJwtGCdviAaXquOf3DbLeq/FRApQG9xs8Eqyc6PB0NRX0+jFfJOG7zU7qz0t6LinR6/T+v5yT8bKGQgPIb+CuIWjeLwS1sA7nNmdkeRiRA3VN7G2qr+RG2zjeFXqzwvkBJ1YDW6oRTG1tj/FUs4LcQIZTvLcWR5XTnlkp+PzYtnPx36/FfNIZy9599uX5buek4GiI6eQyhzgfj2AOgTmCYSga897+dkkI77tp3syzrlPCTTImO/umyyzwOsvEAKVuv5EMqYDDeg30C4C4nxNJyDuelp8W7ZInHgtVC1lxZi9ReZVkpV7BcKyRI9aPbUVh0ugY9Q/o7oluv010Q97LsoJiiwTANCxFK4EUSZFi8jGGBlK+N71nIkoCpm+E6VQpVXwIv6E989Egn4OzIeTJd5KAP6WL1SE204k+ElAqf+UpU1MvAfLqZ3f+Vta7Kgnc8LjQGK5KrWTmGQCo86R/59i9XUOStyn/DrHvhubKzMWgS1QDQhiZiEYzZth5rmVONF4QM4LUdBTKyD4yEc3UQAvvkPWRycETsepeQzHumg1ZOt7CN/VakXDQ7+DqOjoyo2QfrLUTF9CBpalC+HXvogeHSHUOahXHcw4HxYxQjKxzew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(38100700002)(1076003)(5660300002)(66476007)(86362001)(4326008)(8936002)(2906002)(4744005)(66946007)(2616005)(83380400001)(36756003)(9786002)(9746002)(316002)(6916009)(26005)(426003)(478600001)(8676002)(66556008)(186003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WdpcAcL33BNTo+/uyJe42sR55onb3FSvNNkR/Dqs5wBSbfHaLDtZnU0ctzWg?=
 =?us-ascii?Q?09Vvtrbb2dcL+HgWbVVzfjltjsVm4zkxEEr3UmZfBzhxDu4qQIgQzFBvRM2U?=
 =?us-ascii?Q?kp9IMhOhEhqzrFy+Hlu6p8qnUoMHXEQWUsQkhRlqFPoycEeoYEM9h/fJXKhC?=
 =?us-ascii?Q?QlKUjCZUix+2gJAe3aqwFuRkp1CVg/rO0tWcxLfCbddsxsGa29kdtcR+3Or3?=
 =?us-ascii?Q?FJlzKBkpG9EftKNBKONZZK6jHFt7mc8GmNCZsvswITHZedY7T3XUbS+CmY6k?=
 =?us-ascii?Q?SRY4CScx6Rq4stdKCTePMaJyLBL2XapENYdIDXxRxMDCvkzZPRswkoVQCXhB?=
 =?us-ascii?Q?VrGQZSEjOCWtwozH52LSFS9hgZqbdI3PUWWHIgc+h33yKgwldTZxi2h+6WzZ?=
 =?us-ascii?Q?69EGbUObvoaFSDjp0vihB3v+xNigG2XLhk1WVZZXAXu5fzgjCYxTQ0YAjHQI?=
 =?us-ascii?Q?Xf64Doth/ehGkv7/oUQL8r/rd9ZmD4Ee4/Hzw9QOHkVK49ZI/wurtx8aFBc4?=
 =?us-ascii?Q?JIjZbAC2lLk1zoEcQ/nL/bZSYTlqfk4VtnVPG3OU/AbLM4J6/5lkWX7LpyY2?=
 =?us-ascii?Q?lmZIKco+hNTGUHiC6fTm0dONfx6A1/fdBBEwcvrpKJ6qY0KgrVh+C7YfsXyU?=
 =?us-ascii?Q?PQps2O3Z5sHK6FlMUpg8NA6CskHH7WS/yR5e5RJN8rNjNirPTLQVFB0rXoyN?=
 =?us-ascii?Q?khDtM0R0+18E8jbh6+4J1UCG/ZIYxBSeBZHpPglEm/cwmLKAh6MxrM6GiV8Y?=
 =?us-ascii?Q?iw+5S1rx7NSkfZ3UbzkVv7NqfvHo7dHR85fGnIFtMLinfWHeBxBK7PEnn23t?=
 =?us-ascii?Q?Cbm3wiUBm6BUTyHaQyhvscbGGGPTbpnJ9IiPHH82UalaogeBCXsNTUxWtmHz?=
 =?us-ascii?Q?APa4WUCPbCIr+Tz3+lQN1Fe3Tp+CnVxkSxaAc4t3GTa3oMAvGPIWqLXUBy2v?=
 =?us-ascii?Q?bV5sgm7wT3DYGDpxvYAIkgCNLMNW42VqHdc+aaQyB7gVvR4UrMHHzC81Q3Yw?=
 =?us-ascii?Q?3tMr04g3CZF5S/ETFeu6MbZ5yj8J7jIGWVI5Q/SxdqiSkxkEqKtG4vryAA7F?=
 =?us-ascii?Q?R2NR+2gLwca3N+p0BYXY8wHz+pexToEWxx8AshTKBOPLpgx36xU7vEeaZecz?=
 =?us-ascii?Q?QUsRCGTjH7B6ESrGav4FH83NnLNRKyVkTXNWQM/qUtQaXuxOCjXzECXD2aMi?=
 =?us-ascii?Q?M0x0JYQ57GJp9693WSeKUQ5qvtu70Uz1WbelOgOOlqYl0f8Yh1Ov83kMHIDk?=
 =?us-ascii?Q?Wa/JbnEwU2DJm1F/zXbx0yCdyQ/Yh94Rn4b1wVQPIU1uHh6ReSWq3kD9/3Vy?=
 =?us-ascii?Q?H11VsBeB+N8uFMcDMn2t7WOi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5344b81-ee54-4e3b-20db-08d96650a38f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 16:11:17.8054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 507p6pvN+OIHy9o206qC5bssBM8CBqZqQEGS5GNzaQ8rSg1VlqHiw+72HJBUKQp6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5080
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 23, 2021 at 10:48:16AM -0500, Tatyana Nikolova wrote:
> Add ice and irdma to kernel-boot rules so that
> these devices are recognized as iWARP and RoCE capable.
> 
> Otherwise the port mapper service which is only relevant
> for iWARP devices may not start automatically after boot.
> 
> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
>  kernel-boot/rdma-description.rules | 2 ++
>  1 file changed, 2 insertions(+)

Given that ice is both iwarp and roce, is there some better way to
detect this? Doesn't the aux device encode it?

Jason
