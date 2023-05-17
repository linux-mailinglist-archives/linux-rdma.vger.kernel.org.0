Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7787070ED
	for <lists+linux-rdma@lfdr.de>; Wed, 17 May 2023 20:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjEQSiy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 May 2023 14:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjEQSi1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 May 2023 14:38:27 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F1DA273
        for <linux-rdma@vger.kernel.org>; Wed, 17 May 2023 11:38:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9DTk4zt2tRRf4fHEzj33VuvyKvSV7C9Z+RmOmqY8dO4NqjDVOvGT6FX6jJOMMBhP9GCHjDr8/yl+WXgXO10PUOO6F+SRFXKG0aI+ym178jSYC36FkrniXOixU3yjXNgIWiKgQZpIqmcYo/iS6CCq5y8xoIjwqqgM2JCmVBbKiulReVVRMoHXjicQDgM8a6Jm3sO4oX+zdDc7hVH5GDv62nM2irrFE7DJy6bjhzQadRHWPd6OLxYz5ohE90lCv55I7W2wNtIQoNPB1wzVZwezN/VXEjdHoMj2NBKJC+qp0Fxits0A+PUgJ0KjfW4BIWbymfqVcm7qcPCMbU0irPEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t78u2jtXWDPuYWtAA8oEp6hzFgK9/x0yeXFzLM/Qros=;
 b=LBvUJs/NzpefzryiTD8GTS/7fvUA3Bx7gDdil9knw5x2ZA2u4BOiQVSf6HkfhSkSMoELN2MvuYoA0+xILMPFl3+aPoV2u83Ek5FrTC/oclOikjBcnWfBXhWpwck59EVvZ/RNvTIO5HrJkUIZSwF6/Nro4k/gzoP2eMEiGKtSW4FoFArzwTvfWSdR/pxOTYpKulEdxLFSjxyHvowgUYAeUrX94L2H4qPztcBbeLMAmWJNb3kK1reRPWn+6XVYQWF4ksET1b32xGPS7yLNDkszB1EVH5RjDgpaqu28V3Eymwl+cotoPAoAvC2KDbCajFPochsMwayXuM7XLZzMo3aIlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t78u2jtXWDPuYWtAA8oEp6hzFgK9/x0yeXFzLM/Qros=;
 b=rBeua5fKKMX7/RaBqceupHxgHL5ZIV1XmZP1Dtcu4I18VnLLq1bzx6BvDcXTFrCcs6UydLD8QUOMYpdWfVaQe2b+OdS4eE6/RBOTYmYxkkP5xx0Ik02RWD7UUOraU940zLPhkm69mI9ymzS0pa1jlyZz853IQqaYXi/M5R9UwWdSO9MMymbTtxb7V5mmQPWNGEPfx9IUMykx/Odw2pyv5eEJYROdC8mE4UvS0CoEx4qylUHyKKlaNU05k14GZKkTNVLOI2LZlwiorwBFkS4WvygQMm9Cx5iwIauLpYElJFH9E1LQ3KJrcvfuLco7vXN4H5ZXRXiZwbz9zkNlwCWCHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 18:38:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 18:38:23 +0000
Date:   Wed, 17 May 2023 15:38:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     matsuda-daisuke@fujitsu.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, Ian Ziemba <ian.ziemba@hpe.com>
Subject: Re: [PATCH v8 for-next] RDMA/rxe: Add workqueue support for tasks
Message-ID: <ZGUfHp6+RF5iO2O8@nvidia.com>
References: <20230428171321.5774-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428171321.5774-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:208:120::40) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: d38d51dc-4570-4ed8-c0f5-08db5705e523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhAXeaxgqWn5jSE19Xh+oVe5iKpgQFxXf3NiJXudsY+FGcZJUj1oulcusB+F7baLGyKZj3BW7f4fdKMSDeAoqLXZCPRBd1ko0I7tb6liRTWOXXH5Cdb+VYt/yyVA3AOBgsBZOnmWFs090hrDazWKLpq4vhrPkC5vbweRVQgLajxdWq8rIBiaVd0/IXcVTE9CnaWCPP9rQRyoHI9g7QMaYwicc3fPKXWmRyfDYU3Vt0yvdmKXRiGjgafftvCjhQNg600ibnN2kr3/Fskdy+p6ekjzWNG5PKUu5FFiwBGo7akYy44AHuCz1atqfK2e/kRRY+42T0+3PyWnAn0cn+v9fQ4SJ8IU18iWjEOAmpgKfqh8Dca5Odg/F/5PT47xqHiQmlA7J8UAmxTgkA6wqCBWNGjeqR4X8fRjbHTeOtEcm+VqnY0iAzT1gyv4EK9c1he9BR0U6k1hZGNPov86FTZC/PXnZm385LPU+f0u91WUN7Fi+HgjS+xcSGmRr+Dp4YZrB3cIZopLzoBu/bwyN0kc4VFpAwY2fJ5idSFVter53fRFaFmJ6z2p6ISoaTQCqZ4wOciAdK93aRpA1Q7hBDOlyR7ogAVOCtPDHhi+ekwTlPhAoVLtmJgFjxJAH7iXn9ua3184JiRWH0V/ZiEy5t7M7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(966005)(2616005)(186003)(41300700001)(38100700002)(6486002)(83380400001)(26005)(6506007)(6512007)(478600001)(66476007)(6916009)(66556008)(4326008)(316002)(66946007)(8936002)(5660300002)(8676002)(86362001)(36756003)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dtsJOzttqmd7SLVxrXSvZ3+y4pXRCCBYfjLKIyejEA1oyiRtAm5lML1yGMiO?=
 =?us-ascii?Q?nCkKFzfriiZGnFauZxO+JefbW4Awefe+hsgxya8zfn7qzJJazD6fNsxc3wCU?=
 =?us-ascii?Q?/vKVYo6jpqUZMLTXA0QHprn4fk7zddk51Ntbyx4vxIOgHT2YFeLrCzBZ0IgZ?=
 =?us-ascii?Q?FuvxKqYbKRvmZQWHDPkDQPvjs0sJNvnCwZ7VAtjKcgkLPm9RxtJ+Rrb+45t2?=
 =?us-ascii?Q?6SQ6TQ5WKTKweLQfpi8G4zQXHEuN3r1HTnHAZD82gG68aq1nTtUyTOcTSWtr?=
 =?us-ascii?Q?p2c0T4kFzU0lBqJgIcr9E+SW7AvGEF9CbzpjRwYVWzZkvZnOUcyzS0FsfDa4?=
 =?us-ascii?Q?U/GZwwjp2o6vnQwX4PrsQlY65miHoX3DuMSaTM7N1iw5trK5/pC0rY3y61ZU?=
 =?us-ascii?Q?SE3b8dIBxBg/I/7l8dvnmR1PLNSJeSvi43mxisbB65fsJs4FeY4TWUK4OCop?=
 =?us-ascii?Q?x5DOTaZ0GVjUkvdWRwBksPrS3xohJgqk3lw0tZ1EYbToDwFnX082AT5Ipcia?=
 =?us-ascii?Q?LEJPDnoFiOvPnaAXVlhkvCJDoBvz7UcXoD1U6zZj8mZK6RQ7IudmdBl9izDd?=
 =?us-ascii?Q?1Be7OJ3B5isxdgKfOZ7VFhL8ZelEcojoQlDk6CyxuQyePFhHIBi1rEMG4HhC?=
 =?us-ascii?Q?Oae5wDpVQ5Cf5XtWi9ZCb1aFP7q54pNUqFg7jO5P+O5+RK7f9T3Lk1nvfcNh?=
 =?us-ascii?Q?wQVlamio0vdHa0zlwO2Jgzor7ymWnLgDVablBKQ//ypmztymoQJpbdjVxOvB?=
 =?us-ascii?Q?3OCLMGGp03WNgGtuByuJPVcNpVozvCrddWE8qCsNiuYUJOfm1Z4PNFZAFakC?=
 =?us-ascii?Q?9vJUqYphZ31XIXb73XwKr9uqSsIffzmYRQy/e3iHCf0CmtQV4oAp7BbbkOrk?=
 =?us-ascii?Q?S22bWRiQBqnOiKddbem8hMSnh7noVNfbM8eaLcw1zt9/0ZBdDTPW0F4FrHjo?=
 =?us-ascii?Q?O1hbR2ddWQleaVg+Psnyb3z8Rynpv6MR3oZ+BxaeB0YQk/2b8XwJVPiRkSFS?=
 =?us-ascii?Q?zQTldgceAUg56B0Sfm8+eag/lsMbvHy4lrqlU8rbubo8uKnglicaJjLEvTpa?=
 =?us-ascii?Q?qPn6TukeNUyBH4iNx/q9VKy6+WPgg5OfcaT+EqhwHWTzOwf/jT2rLmwWpDJw?=
 =?us-ascii?Q?wB0Qv/2v94YYwwA4S27xY4eEFQgzmPa3RsqFEuEAIOsin1XIxoJyCpZp7scx?=
 =?us-ascii?Q?HCaMfjnZAvkgaKQ48KO4nm/PJk38Ecv5G0zziNlGbHn8iGG2YjW21AxpCCk+?=
 =?us-ascii?Q?UKZw/NVFSrKgRkFyO2w8NERzrD2VlpToZtDGTgbepJVlaoXjvLFNFEw9b0IQ?=
 =?us-ascii?Q?72wc/JByUt9GQVpb4MIBmmAGa440P9lctzcTHGoHVJ5Rx5gtK2xCKxhbtfsY?=
 =?us-ascii?Q?+/WZl5OZlG+nyRgnj4hc3GO79xtVrTsIdLFOtAI57muk9drhnZnEKSaci9ve?=
 =?us-ascii?Q?jKcTofCWxWiTbNIWVgsYg0zYk3JJXysVfPXsQUnq2XQiZ9lSMNq4kRRf1tAg?=
 =?us-ascii?Q?7bBC2czj5CYaC9fMGFA20xnkcHYesBbyrJi1kixI7Oqv3biQlBBlOimRTn6y?=
 =?us-ascii?Q?IY+2coFzvDn7RQD7A2xV7vf18uLaFjsA6c3p9Iua?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38d51dc-4570-4ed8-c0f5-08db5705e523
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 18:38:23.5294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwARMFhvaUuqPx2SZASGM0oiExlxIGK5IsNEXnDDpSwGM7nZIjg0R9AZ4YXugIT2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 28, 2023 at 12:13:22PM -0500, Bob Pearson wrote:
> Replace tasklets by work queues for the three main rxe tasklets:
> rxe_requester, rxe_completer and rxe_responder.
> 
> Rebased to current for-next branch with changes, below, applied.
> 
> Link: https://lore.kernel.org/linux-rdma/20230329193308.7489-1-rpearsonhpe@gmail.com/
> Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> Reviewed-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> Tested-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
> v8:
>   Corrected a soft cpu lockup by testing return value from task->func
>   for all task states.
>   Removed WQ_CPU_INTENSIVE flag from alloc_workqueue() since documentation
>   shows that this has no effect if WQ_UNBOUND is set.
>   Removed work_pending() call in __reserve_if_idle() since by design
>   a task cannot be pending and idle at the same time.
>   Renamed __do_task() to do_work() per a comment by Diasuke Matsuda.
> v7:
>   Adjusted so patch applies after changes to rxe_task.c.
> v6:
>   Fixed left over references to tasklets in the comments.
>   Added WQ_UNBOUND to the parameters for alloc_workqueue(). This shows
>   a significant performance improvement.
> v5:
>   Based on corrected task logic for tasklets and simplified to only
>   convert from tasklets to workqueues and not provide a flexible
>   interface.
> ---
>  drivers/infiniband/sw/rxe/rxe.c      |   9 ++-
>  drivers/infiniband/sw/rxe/rxe_task.c | 108 +++++++++++++++------------
>  drivers/infiniband/sw/rxe/rxe_task.h |   6 +-
>  3 files changed, 75 insertions(+), 48 deletions(-)

Applied to for-next, thanks

Jason
