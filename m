Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7204F76A004
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 20:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjGaSI0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 14:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjGaSIZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 14:08:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BB7114
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:08:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8v3lLv/kU5T7EBDFyP88dHj+Jp7xnW2SHBVmD/ayL+mjGznMaz6xlcYTHPpZ6XzdX4TchIkInZ3Rjdu3+eWNEgyqWqwuxjK9l79j0F0hYyVbXRVZh2boJJjBo11KLRYKImOSVfNclFaqypOy+rwyQI4ZPodqbH64dm/K0YjAT3LtXBgxUqo2eRlQP7WzAM757pqUWINy9rVEq0uWtYwHRSn8i8vB2tVEXl56vhGCfbb5HNGKi7diMIPV5oVAcoZrNL7/oUUSWc/dgtvClzbOZHH++3iLU85CExuZacEuUhWMzygAgYtJMaFnWl45w1Dl3ckb3wNpz3FB4VV2m1kwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yx9FPd6WWsv5CBFvCW7/rSsjbcKCn945a4aV0QeG4nE=;
 b=UPJsYSpQUKy4Fnj7Oy/XvAALaV7GQYfj+tqfdbnwHsysxqWL/FfvPzBmCHjX1YJwFmjAKUWxZQ8+ybrsfT0R22uQkCoCdskKcTOMvsSXB/74ui+3me0Gh4atI/NE8/M3C7LjpEef+5T+0Q3NqAfq3XV8O1Q46rpspmRsA+F6dpBJSAr0i8RejKSGD8KdyZRrp/g2F7ig1zzhnBIo5SPenxO+KKgC88YuxpwAoyQ98dlloWmGTtgW00wz7CqCp/BpP4Ewk4vB/HFyI3YXSg4lqJh5cxiuBlWDxfpZPnXM0NzEloRLdx2SzrtG+cX14knO9kcVSjj0fTE5ms/YT6ucCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yx9FPd6WWsv5CBFvCW7/rSsjbcKCn945a4aV0QeG4nE=;
 b=T7DtW1QZlEftOsKsICFyYkMb9ZdzHfXQS51iNGcScw52fkJjynPn0DlL+lSaIjmglWFr1tLN5i8l95EZGNk9b4I7aHj/E+600UR04x+qMt2DbKykR6d8rdsG3x0TknUpJyAvO0Y8izS+WjBPx1IKBsVyjY4Mk4hDiPa3WFeH22UgfS9931gSzynC9mqbe5zDXVbeh29ORbl6wNTJcpy8TPXTY1ZfMFOSQAn2Pmz87lj2NESF+vG68NhZrNpDerDn1BHVxJIxE0yt7uCQ8GrLYplmc+SFtqsFIkWXyHewDs0jFLlGckRQLzgl/485VQNPY5SOYphwBmeytAsr2HutrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB8170.namprd12.prod.outlook.com (2603:10b6:806:32c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 18:08:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 18:08:22 +0000
Date:   Mon, 31 Jul 2023 15:08:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 1/9] RDMA/rxe: Fix handling sleepable in
 rxe_pool.c
Message-ID: <ZMf4jipS+FdUK2Gn@nvidia.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721205021.5394-2-rpearsonhpe@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:a03:331::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 45be3b1f-90fe-4646-a48a-08db91f1204f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RdZUPgAZ7N7LVanZYDrRrfHxjsXpv5SCBZXq4HJhs+e7516xUBKAoFRiQIjhV3PJSu4YQyM+T1j4XWTGojaXvojR6J/iuziINaIOSkWRQiyY8P5E6kacWDpwjeJHALvzDR0hdQEHri0C8kApqj+TFWin5ACrQC6c39YNM3BuQ0DzqbGIyOJcK7TpmUsjTqUasWwbKr3nQjInszYCGda6ecMCpL061wWY2oPcCwFvy5CLR38GdFUT9VN+5MGYE9rwssWSENb5NXfeOV1Q5Xwoco+qHFD3QcNWW9I7Qf14+R6CbgTkF4tGpOhl8sdZaaXKQCiDS/ER51cyoqOwgoEH62fdz5twieR8vXdJI0YE49EAhA3KF5olKJwIIKDDdwrOAl/l5y2YzDm4bBxae0PxjPauJgEM9pH0m6CwkuTRktUtWocsiNwPUvbGc3xSL4SUAwbhs6N1Nq3Fiqv87gD1r9Hw+qrFyB3Z0f3WpkEMnr+W0acaNBpKr6VTwlWSeh0RhYX+hs5lMSQZAzdcnBwzDEEyNzQSOEC7Yu2JtmwjifK+fbK49f1itId4JFeoXHyHGQu9u/UziEeEuvGvvZjqc7FLlDWSlxQdD98yDWN9I3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(66476007)(26005)(41300700001)(316002)(6916009)(4326008)(8936002)(8676002)(6506007)(66899021)(478600001)(66946007)(6512007)(66556008)(36756003)(6486002)(38100700002)(2906002)(2616005)(83380400001)(86362001)(6666004)(186003)(5660300002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FVRSkmZFmLtulkXkEWTOVBMrsP5z1BG1VYLvVeBkIxJDYmRWPvdZHN4uLjxy?=
 =?us-ascii?Q?GRmKiam10TtXuj5BEnJyKo3PHIZyIhp0UTeQzyQq6GLWvMHOVQps6/FmITI/?=
 =?us-ascii?Q?Q4nq8IH6eYjp4bPbRDx2qn4pihYG3Pw88TIvY5sA0B7Qzyboc04xqp17BoSt?=
 =?us-ascii?Q?45UyPKH4aaxs9bx5R1E9NDGP02BLfOZEAGMBwfZZ0wmC1r4DzUdBsfpjodqH?=
 =?us-ascii?Q?5Nb5YjYvAJ7IEuK0Ie12mQhiJ3plw4UOXm7CvQ2yZBujVlbolGZkoa6/x5z7?=
 =?us-ascii?Q?yMAmQdgcr8v/9VKP1eAxmtAANtqf2Lhl9ZWm2aBgYL8UZBoXUCWGfQ/KCGYO?=
 =?us-ascii?Q?I60+eFLaWSEmbDTseP4CQoTtpNEZGHtPHF/BAKYFKP2DCQNgHtC5b0mmcFjc?=
 =?us-ascii?Q?lmvF1HvMvHYI73pqZZzZVYeL+CoMrj+abgfZkHjFrL/RcLq8BLEUQEA7Zrey?=
 =?us-ascii?Q?p7A72zH4EJFrh/EcUBvGbNF6O1FUB8LJHpvwx1AzIJC5GtufWiKtkpgCj946?=
 =?us-ascii?Q?6HP2bMn66NfeqCWXDiKuhblIREUdQigBlJMCflNyF8lQsXcKjooWGL9Lh0lB?=
 =?us-ascii?Q?9NurNzwfNXTwelrV+m0+xNRbm3ygWsq5+aBhqg8AXCtOi3cGRz8hmOJH1cqu?=
 =?us-ascii?Q?pn+GYGbi2mkBBEO0TYu0VSkGTqNJTRmsJm1UD8C48kbqvo0EWSpb9homguUj?=
 =?us-ascii?Q?3sQjDhDmWae3R62zzdPtC0SbBRLA2J7BbkIzC6S8swryM46/T0hzh8XWfiP2?=
 =?us-ascii?Q?o+r/pGRARPx8NCSjGxsC6FFN9CNfZNPi9pl8LwAUDVb2GSb0U5oUUv0PF/Jo?=
 =?us-ascii?Q?GtZeCrNy3BNZpinCr0VwB8Z7LdFHScYbs/DEh2CKG9QObPL1v1h8QW70ykeq?=
 =?us-ascii?Q?P3sJHWZwdzkHkq11R+WKCFJ9sr1ZGSrUJfeRh5CDqnIvHLfYcXNt6Q10ZuSX?=
 =?us-ascii?Q?Br03/BpzQ57scrnya6l6LSmBtVPbDmdbJeWK4IO4EU313EMl6z1YaltIBioG?=
 =?us-ascii?Q?Kna71e0SqoFTxiWHrzx1q7KGuRS6DzWTu8oGNE2z5zigSDMeGZRI52m39I99?=
 =?us-ascii?Q?sK60NTVJItgnu1+BOMUKPLZ6aDfKQ3w8RZZwUuB1HvxdxZeoDbmIMkCybh85?=
 =?us-ascii?Q?wfAuZIElgdUl+Vej/cOpDDBpKJxl5fkLJoCzlAPJQW4Yfzt0ngsmaYn/Gj/e?=
 =?us-ascii?Q?j1uSEyeQ4U+IkQuHFvRlqhDV3zNxlslpQyO7ep1fi0EXkzKg+tsJHeQYfVLE?=
 =?us-ascii?Q?j6yfJhBW1a7AGjMEjAPcZttOq1Eu/OvV7QQjBZwN27yww//iKNa0WApang4h?=
 =?us-ascii?Q?pbwgsc2yuduiiVStnJmyWsLwUlukFSD5d5I6js6QhnciaQecOtYESAulrVI2?=
 =?us-ascii?Q?2zaq0rLNbeTK9tFHxW6dlgUJBg+de16Les1GD/aOFPwn5vxkngzeus+Sao2x?=
 =?us-ascii?Q?SNrRJHLhpEvlRtDIG9d/ll52DVw2zn+xvnZS6dQqqTgtuI3eFStDAojvYVkw?=
 =?us-ascii?Q?q19C9zbMqYgBbRVOpkniAIFDx5So9FZ/f9Eo7CTZ7v2llyosZgVn2CUppfxp?=
 =?us-ascii?Q?8whIOCThZrn0z7G+H1kwRMQ7WjToMP+9ITUhHH8F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45be3b1f-90fe-4646-a48a-08db91f1204f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:08:21.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlsxgF/CdjdS5cPIJUvwulcmWAZbD5W8iSD6vD+kqdW/4AtDf/6fTlTHXEgsmLfo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 21, 2023 at 03:50:14PM -0500, Bob Pearson wrote:
> Since the AH creation and destroy verbs APIs can be called in
> interrupt context it is necessary to not sleep in these cases.
> This was partially dealt with in previous fixes but some cases
> remain where the code could still potentially sleep.
> 
> This patch fixes this by extending the __rxe_finalize() call to
> have a sleepable parameter and using this in the AH verbs calls.
> It also fixes one call to rxe_cleanup which did not use the
> sleepable API.
> 
> Fixes: 215d0a755e1b ("RDMA/rxe: Stop lookup of partially built objects")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_pool.c  |  5 +++--
>  drivers/infiniband/sw/rxe/rxe_pool.h  |  5 +++--
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 11 ++++++-----
>  3 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 6215c6de3a84..de0043b6d3f3 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -247,10 +247,11 @@ int __rxe_put(struct rxe_pool_elem *elem)
>  	return kref_put(&elem->ref_cnt, rxe_elem_release);
>  }
>  
> -void __rxe_finalize(struct rxe_pool_elem *elem)
> +void __rxe_finalize(struct rxe_pool_elem *elem, bool sleepable)
>  {
>  	void *xa_ret;
> +	gfp_t gfp_flags = sleepable ? GFP_KERNEL : GFP_ATOMIC;
>  
> -	xa_ret = xa_store(&elem->pool->xa, elem->index, elem, GFP_KERNEL);
> +	xa_ret = xa_store(&elem->pool->xa, elem->index, elem, gfp_flags);
>  	WARN_ON(xa_err(xa_ret));
>  }

You don't need to do this, there is no allocation here, when you call
xa_alloc_cyclic() it reserved all the memory necessary for this.

Just add a comment and mark it GFP_ATOMIC.

Jason
