Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30464C723D
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 18:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbiB1RNE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 12:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbiB1RND (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 12:13:03 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD6E115
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 09:12:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ge95bAV6dFfkhENotDlnFdd9GjS9Zf+DlMwQlPL9uoH8g8LE2T+F21yZ9u4ephZpB+8jyv0buYdpTWtFAwmaK59+aheU4G2erAj7Vxhgtbm/e0wt18lg7uKXJUkNaxdLAD4vkIqeEBq498oMjSK2+/cBhwyqj3Pj7QvFVC87unImJZKFgP2Zk1MxVpa5j6hX4h2R7GzDtBA5+uQkWPBGk32gwrExGkSLF3eWdRfu9+LhgRG6KHrdhebRdhPRiYIjKM2NIfkUfP095IsdCfCUHclVkw49VjSy5j6M76zAZK28AQlyi8NclpeBhufRt6NBGNtjw1knIUuYl/gQxvLpNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0vzxk92QyttlMzbuC9/QdGdcm1Ukd3N9sW88K3Imt8=;
 b=GFxneSTJ+yFqJlBZhE24PFykAeE346cTaIbRIvmki2rlMAdnR1CUW/7AMOebm5ncsgU2QEq0hZ2WfEiD9fKfDUOJUgBc6FZ8sJGWE0QvoAp6eck8yN3jUnlWYv5uJpreGYI6awL56IHB0GJ3AxhlJz6TJbtqE4zFdkpf8jxoD18WnYcbRv+591mwuf8toYPTVvlsOhyH5N4L7hs2OUDT2sFNRa6Y+1Zsb7VVkx3zbYwtevsGb8UXPNUpfJ6PvuQC9RF+F6WDNxz9sWMB4lpr6K7/DrH/tCNE1iqs8YZwOYoRvZ2SpdabF/++I4gkSUoWDElSW8OjH0u3zALVGGwiyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0vzxk92QyttlMzbuC9/QdGdcm1Ukd3N9sW88K3Imt8=;
 b=BvqCG0KRv/9N3ouoKPw42DQOCoKK5y6ok9819rstDC2b10Os96YoHUMcPYBda0kl8+QZm40G1Rm4vX3dXuxO4WSrMaR+UqbJQm9m3BS9R0kBAMyldwi6zhmYeJDE4nJQ5wWff/OwTANAOcms2sJZzB5WsnkVQSLg5NoZrfswMMTZvSKUgfgZ+OmORGncRRfQO65VWLqUnLE5qP4muX+Pqx1QRjNAaV342uGSunGbDzog194RvuTSmqWoHAjn1qqz1o19XGm0mIJsrKrX6XlWqUC3xo5sZcTN2oTgoDwPeA7BUV8/FEBJBdy5jRvjOJx58j9Qw6SFyj6C9YaJkgdbvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL0PR12MB4961.namprd12.prod.outlook.com (2603:10b6:208:1c9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Mon, 28 Feb
 2022 17:12:20 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 17:12:20 +0000
Date:   Mon, 28 Feb 2022 13:12:19 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v10 09/11] RDMA/rxe: Convert read side locking
 to rcu
Message-ID: <20220228171219.GM219866@nvidia.com>
References: <20220225195750.37802-1-rpearsonhpe@gmail.com>
 <20220225195750.37802-10-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225195750.37802-10-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:208:239::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3d62ea4-8659-4af7-3ec2-08d9fadd7ab1
X-MS-TrafficTypeDiagnostic: BL0PR12MB4961:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB49615215C0ECBAD123B96E2CC2019@BL0PR12MB4961.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSKf3u1sg7CpjB6RTtYMW7B8QbcNtMJhyySe8iwb53+nhU2pam1ChU8kwGDhjn5yX8mhVOFx3FlxYs9XGLwJ7oFpvIRRHRC+i5F5BfmjkJMIBfS+0O/RHWiN8BZJG+TveDCzAk5aj6d8meYCMkEsgBP/KqiIpQjrK0eqVBrCJhiE7FDB+eocyjsNZzpZHKRSmTcinjy5kpfbKMIp1srPJvIaNtaEQQO+9ZhxjhIbT3Bqxb9dwH97LZ644ix5WiaG4gDo9lVEJdtJtFh6uRYvS2+plPulja63PtvAf7UkRLmJ8z+zTEjzMl1hSFzQnnjTDBtt8HJdNuwzZjm6nPd231N19YRIcP0IojUOy0hDuFxjv0Ww1jzdMEfPhnrz9YP1emsBvGUX1pSnz9ftpGQgD/5fb89VjzCtOf8z679K0sVSM1BLAfthTtLVZqfkDBXO0BW0quNLPwRZC2ZZzSQzrX8zV3BRhtCsvVa3MtmDXgOOCQxQWA8sU6WiGAkklGQaInebKmgpZsGMr9WDDJczTxqsWEx6GefjNR3uCf6uK/cGJv23sg/6c3/BPtVgk6oiqZh4gABW+cFukL4/JQv2dpECtL+cn0WtLaMxvfQJCbK77rF4lSmMjWwbhI053wytABhwjUttDOGjaAx+V2S7DoAOCbavxQP3TDvGDlXzd4e8+Ripa5ou2gjPdIwpFfpG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(2906002)(38100700002)(26005)(6486002)(186003)(508600001)(5660300002)(6916009)(316002)(66556008)(8676002)(4326008)(86362001)(66476007)(83380400001)(8936002)(6506007)(1076003)(66946007)(33656002)(36756003)(6512007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pxlITs418MVnrTfKSai5Vdoxlf2CDeGHsnIdxIALw04TFy3SgBp8TDzs/6ef?=
 =?us-ascii?Q?OJ18HUyEzib+9PLqPhFy0RjpNNtay0TrkgJE40y+HTNj7qPkscdig2RxtJHB?=
 =?us-ascii?Q?W68vcdDF0lIgoP0wIp45FrLz3oRt6Z0tMdUZKFJsu1S3Q9O0VKOaaaiUnB3e?=
 =?us-ascii?Q?vCkNBf1hsgn5DOSNBvnnS/fMCTnaWg42N6YL7pBRhAOB7HcqwXP8gG5ZZMfB?=
 =?us-ascii?Q?hGosfsfjNzZKUKteZBqK3yD0hF6eGOVR3PEzYAzWA7MkJ9/BL81tmlZQvHHb?=
 =?us-ascii?Q?UsiaXbVqeS5KQYEhXUjYsFAZYs3pXA6ma/aP2JA5djPwMDBRBSARFHxBdk1z?=
 =?us-ascii?Q?ESAk2AR0Mnl+vMoOnJmvqIWLNNZUjyyvDq9iScJtb4lcitHq+rfzQtZNlCUj?=
 =?us-ascii?Q?s9v3tYgge4Pi8AqLh2jlcU1JfigHwfE4H/cqLNVs9rSQ+0Ruoa4ol0OJInNw?=
 =?us-ascii?Q?+iIh4yR+GwkAVpMkyN4077o6U86cg/unkDqWTHsbNu7tjm5i7HzYg/I+MCJ6?=
 =?us-ascii?Q?JjrXy9p7ie/y97lUqs3tOQM4QeD/O8uky/s6P3hlg3fs2tuGBR2ZCtlhkU3g?=
 =?us-ascii?Q?cqKjsZPDslXDyD8v6l1LRz0rEciiWTutxWCaeo8hgWWv0sV8+WJClie6au/1?=
 =?us-ascii?Q?9nUFSPdgcnNe0/FREYk/eYHHoY2Fp7NSlP3wmciI8xU4m17TIsTvVyZoYFqk?=
 =?us-ascii?Q?WmJIUFijaON8/rdScMJC4ueD/kXGmQsSUbrItdQX6a/RsNM2AMMzkKjEjTQW?=
 =?us-ascii?Q?WVDdx6GjIEYVqY9MkVP97hoCJg+IicD/+7x5fW5po/Y+X1RR2pTRQJJ+tXFh?=
 =?us-ascii?Q?jBzwY+/R747OJBexNBW2f8NY2ptKTmXxYcKEFJ61UXvFFQeUpDQt4NYeWAeG?=
 =?us-ascii?Q?no0oeRpaR8U6h8XEWUcLZrVtNCX/TXMQNHIMYeKsFHivehEU3PZqvxRghBRX?=
 =?us-ascii?Q?3n0fIh7QqxW/0U0kzc+CeNalBR/0uZ0XppX9H90M+as7vARDmBgLYiUxFixZ?=
 =?us-ascii?Q?OAW/fheF7uUzEf+00Pm0y0kw17MMEaKBKpAX4FzCCfGPeYwJwnRY6e3BZlf0?=
 =?us-ascii?Q?sf65/0q0Y7kY34Bdp5QjqZUN+m7WPaWemDw+yB23VtH2bq98wob21xynfrs6?=
 =?us-ascii?Q?7edvlfF0TCYhkZghuxIt61q3jXa1k5T+VUcQ/KYtvCuVFkUEtuMz6K+Q8vFE?=
 =?us-ascii?Q?BgF8RcfLaQ5tU+iagD8YLssnPZrMNItIjwK4gV4RqSsEL2I6dRd4rb+d1zo6?=
 =?us-ascii?Q?5Wgx+/j37k0pNz/SsI9R9R1BpLCvyrN1Kks9zlvT4mGu4BSSjFosOWenaa/Q?=
 =?us-ascii?Q?0XqmkAcDmI1AZxZSUUvY/lFz4BEtO7z74ORKFs0QrnqXGLepGnDoTLQNlyhW?=
 =?us-ascii?Q?yse5eWDNlwJU2KXstmey5q90tQf4naxnvG70usH+7Qrei5O5pM/jlnD0RbrH?=
 =?us-ascii?Q?7zoK4H6JdtvCZiqVJswwQfX1UyT76S1jKVJaitw4z5PZH9DSoV+B1GrexbzL?=
 =?us-ascii?Q?WmR8JbYeKEcu/XznX7eCyNEddV7rbBhMcdAWzXVD9BbXQNKOPZmtlg0ft69L?=
 =?us-ascii?Q?pdIPFD80uYfNliz/nWg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d62ea4-8659-4af7-3ec2-08d9fadd7ab1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 17:12:20.3725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bbq94O/6vKdOduQIfimkH8m5IuFOahZBhQ50VNJ6UTU5RjA4wxAxbCVJXacPHQji
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4961
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 25, 2022 at 01:57:49PM -0600, Bob Pearson wrote:
> Use rcu_read_lock() for protecting read side operations in rxe_pool.c.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_pool.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 1d1e10290991..713df1ce2bbc 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -202,16 +202,15 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
>  void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
>  {
>  	struct rxe_pool_elem *elem;
> -	unsigned long flags;
>  	void *obj;
>  
> -	spin_lock_irqsave(&pool->xa.xa_lock, flags);
> +	rcu_read_lock();
>  	elem = xa_load(&pool->xa, index);
>  	if (elem && elem->enabled && kref_get_unless_zero(&elem->ref_cnt))
>  		obj = elem->obj;
>  	else
>  		obj = NULL;
> -	spin_unlock_irqrestore(&pool->xa.xa_lock, flags);
> +	rcu_read_unlock();

Where is the kfree_rcu to go along with this?

Jason
