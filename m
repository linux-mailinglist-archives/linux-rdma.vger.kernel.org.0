Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA1174DB76
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jul 2023 18:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjGJQrz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jul 2023 12:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjGJQry (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jul 2023 12:47:54 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0F0F4
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jul 2023 09:47:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Is4PZR/HWkk/F6MXFELYThJ+2CexbcxdG/hmZvwPOpKJwynZbc5egORwnEnETVOFyNkxktLdBv2zP8Ha7VqcXBbGOBNZDyW/FW2gs1CrHZdJrHxr9UTHfpRVVMDjeGJLSKYER95zaXpAyHur+DyFMnBBkx666t7P8V+m8dSrRPrI4GbAIrZ+TB6gOT4iJEhmGPUtH46wac5hkVlbJ4nNo1s0Vba0iRe2UlP7J+JSWVH24x0qOBZtUDS50n/TiEC+lxpMcNRaqPjGUTtIvFYjEJXlKXCRSnHxhVj5tY9tTOVqmv5fEHt9gnsnAzDPoXI+AiRFl+fb1/EvjVY3QII/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8C+m0mT+Ffdq9NfhSm/R/7S3kUFpYFFS7nNluFB9to=;
 b=fNiBCRfQwdc3XuyR4NiKnvyGgvCH7LnmC88gaD+e2pQpDiaE9Qf4w385gaHOBwzeAxHeFKQco949DGmORF39QRrFOf2D2LmZqlrbBRnXGLc6UMEl7un4qpMYvW1coLe5LsLdR+2Tz7Rb4UM2zHgq8f8Xl8XaK5fXICPhURGo1VzSvmI5Pv5i39AVGRltcJhXsuvHVE7/a1uWRR40GtrR4x85WaQEJqzDiLBBxnaaMbCDqVCWYOOf9dxzh1R1W3QjphsxpgK56R/LTcCxXr/BCLDljP8Fni9V1EQG5RBmULDeuV2E97qJ5IbqdGLBy7SujtjCG9N8pIeiJhqtfJHtCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8C+m0mT+Ffdq9NfhSm/R/7S3kUFpYFFS7nNluFB9to=;
 b=OdQr1b04ZxDKFY+JuFTIhyzXFozMA0qMFoqT8MkeGCjXPzOoo0XkEWyI/sEaxkmHUSMFY3bJtyGY7B1IkMEI+l706xbC9QPVR3EkMZs1jZrR2gUGpptH57EkvJAyFF/o8HtK3+8S3e6x6QAQ6A7a9Z3WR8j2Y4r2FgLRlAmajZDOGPJeTGiKXuWZocFHvrUx4il83cDTMYqPV6ERq2l7iXtbGdpDiQ9Ys1G2hvPEeqhcL9cNsixQl6jPPEwHsG1VH9cpHSo1GSt9OlYku9YsN8rV1FButreWMrKCjZ0ay9OAYvYmC4fUKqIZ1UoOFyy+/b2Orh3op8dSy0qx3WyMZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4893.namprd12.prod.outlook.com (2603:10b6:5:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 16:47:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::98a5:ba0f:4167:8d53]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::98a5:ba0f:4167:8d53%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 16:47:50 +0000
Date:   Mon, 10 Jul 2023 13:47:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, frank.zago@hpe.com, ian.ziemba@hpe.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Fix potential race in
 rxe_pool_get_index
Message-ID: <ZKw2NbcUhCo5F2+g@nvidia.com>
References: <20230629223023.84008-1-rpearsonhpe@gmail.com>
 <ZJ4RXctDIYEhjnQ9@nvidia.com>
 <f48d9b89-d80a-c191-9618-102957868429@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f48d9b89-d80a-c191-9618-102957868429@gmail.com>
X-ClientProxiedBy: BLAPR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:208:32f::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4893:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f4866c-5834-42f8-c5e0-08db816565b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZiinelUv5eovKAvRaZAe0HtjbOcw/QU4ULXZ6BtuzxEKacShZV7rW+wUGQQDl/Q+BZcMPViLAOEzSrZD0nEPqECqIGxNvihL0SJEPXSBDkRURmexXZKB8M4CjHOuq6t/+9B30kKxbmF/MhOWZgBtSEYi+9+CWWhyj8k0h9NUlItj3Zoq9tjUaK9EYjx4THWyk1c8nVHvXA+Gd4gdAB/UGrptZauL+xLCzVga50M0oEaMq1ALUZpCRdAjRSRPQnQvqP7ZWbbpRzoEzy2247iLbF9Ptv8e29/31MNVpGaJQcKSjS1N65K+6X5cwbp5LT2B74Q5i0mpGsHW99zRWRUjhiJmX2f3wmLkzD75b22DyNb/kBG/23uK+KuFUWUr4xY5RMTjDyL+XSRqrFLZK4p9vkaf0gLhf9GiZ+JgHSYVzWYxNGg3B7JRUz0nGy5iGd/RSXDtjZO7/IfL2VtwdUJSr3iJ2XMFLxYMpvQA53eZqzLQGrA4dhGRkhbv6PW7QuZ8GPYxiXC4J+JZBcYZo3hZt9qTNNpkSZ9V3cqnVxOWWvG398FwZeNgZenzWjiQS8cGpWCQSuqg0E7rwfMyNP7TVdlylEbT6c6m6eY8K8so7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199021)(186003)(6506007)(53546011)(26005)(2616005)(6512007)(83380400001)(41300700001)(4326008)(66476007)(2906002)(66556008)(316002)(5660300002)(8936002)(8676002)(6916009)(478600001)(66946007)(6486002)(36756003)(38100700002)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tEdQfVg+el80BjXOH62rQU1IvvChyKHmK/Oj+2NBaHALTxuaMMhdF/knpeAr?=
 =?us-ascii?Q?VtFeIxkl4H9oLOXNqAomHej94inZB2saGYGpYvtktfXZaI9JFxLZwxlH7t9t?=
 =?us-ascii?Q?cZAaN3ikX2cQ49taRdCVIopA5WXRIvcD9rC2dJrFLEIn2Plp1VrrnhcOalvk?=
 =?us-ascii?Q?vskVmnPkwCWMVCDj7qb8UpE7NNUmrsYRHLh2+Z97fbpJbiLv1RQATHHx3O1X?=
 =?us-ascii?Q?W51lNuLSbXncWrIgf41MiWyzkSxpkl3iZjJIC8P7Acq3Xo3XYDa1KGbbTAo6?=
 =?us-ascii?Q?jzqmt/OBC+poDDqa3SLmrAKG/JGYKxyi4dlo6hZ0LFRZ2V4uk96K/rfc5lfj?=
 =?us-ascii?Q?Hcluxr4Oamkzsmmm8EXtMuZgd3edQ7u5KBrbThltNTV77uzZzlhlmTcq4/5A?=
 =?us-ascii?Q?H3dBd0BrYybzqFtoedEEtbg1oTwuxPU6a9xiUnJquFDVPf2QMq/csFPu+OY5?=
 =?us-ascii?Q?gwQ0FFkAPIQs/K9Hp25b9NHuoabPyof/YwLbasRez6qe3HeizYUvWokuIJmV?=
 =?us-ascii?Q?n0mUXDQImGVGos8M14hT8w88HTvcVqjnWKxEVWETAj6RCBAu6SixBrzU6E9o?=
 =?us-ascii?Q?2xeBYdIxbJCgJ2PzMDQYbsuqn7fMVBDer7AAZ5CmfwjIXJ6yevAxgiGx+HhP?=
 =?us-ascii?Q?f7Rd4Pw8m3sHIMsjjCmFotWLFo7Qb7biBtyZO7LIzC48zjNjpOo5Ipn4D1ZP?=
 =?us-ascii?Q?3gS2e0sMcuOch7Tyb9DQLaJPsmMn13qwcxutUs0fKUr26RiPcxD33fAfiaQs?=
 =?us-ascii?Q?dizbqYCBgBVr++zEwIorfZJRGjipFERUYeBhoUQge29g+ua8jPpvckrnaC19?=
 =?us-ascii?Q?/zpAk8TgTGdx3VlOEgRyYgrRAHU/C05sKc/BHz0PtNf5mmGBbLg8MPji8pRb?=
 =?us-ascii?Q?7RADzGj4oX06R126rInj9LgQ09YpnqCiPSGMiZK/EOIgQy56dRQoIMaAD6af?=
 =?us-ascii?Q?Yk0LS2VzwXxlBrg57Pr2bdTXS6ZezmnxLIzOvxd9lGZknPD2bhl1f/4eg0ja?=
 =?us-ascii?Q?g+eOOUQkk+Rea+N9Cg1MxftLRQn6GMVg7SSeSFOXyFCtmEnREg5Nk+7mqj/w?=
 =?us-ascii?Q?Ygxrzxb4zHylhVUzqQu7YQJKFibJPF5eWz0R+HAKubLBP5BtqtnkX5PuhEwV?=
 =?us-ascii?Q?DxRk9f1qPoLuLkBX6laZ+y4tzi7E5niEEPdYsggH6Zc/gUrXJIY9TeSeKYOW?=
 =?us-ascii?Q?9kbKMDUZZp++s8JK3TxCxP5WIltnGznIlsRYpIPrRJlOL2LZOPiMYWxvx1B1?=
 =?us-ascii?Q?YnWOe+kXt5myn5+WxjDI6qan0YKcfSyg6xPJv2pYFQTHrT/l1YE79E/WfxSC?=
 =?us-ascii?Q?ZJpgjPyUp9//VRM71zAS0HQsQMlZ+WTbMf6F871sO5CxZWQVhpkyhhARCMPs?=
 =?us-ascii?Q?lI1KavJSbMucGl8/6imCfzE9+zrJQOe3povqkkL+35Fs8gVCpzcBb0KrT8j/?=
 =?us-ascii?Q?yGHDSq4t14Dw94Xo3/hX9Ejt8svQg1RKvw7DXQyhtN1pZQjWCe3PHGCXRcHS?=
 =?us-ascii?Q?Iecc98+o5NhRcFKm0bMUN2fw9StGQLukWf3dI6UJSWLL0ylqo+x2/Hg7iivC?=
 =?us-ascii?Q?4n+xGnSdPr3CgE78g8ut4wp6EbQmuLpPanCV8uWd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f4866c-5834-42f8-c5e0-08db816565b2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 16:47:50.2974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNlRyUbkmkcVzEv9gbAqQhQXkBSgRzhJa4XHqHdBt6hEryJ94T3ROlrmG+NY/TYO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4893
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 30, 2023 at 10:33:38AM -0500, Bob Pearson wrote:
> On 6/29/23 18:18, Jason Gunthorpe wrote:
> > On Thu, Jun 29, 2023 at 05:30:24PM -0500, Bob Pearson wrote:
> >> Currently the lookup of an object from its index and taking a
> >> reference to the object are incorrectly protected by an rcu_read_lock
> >> but this does not make the xa_load and the kref_get combination an
> >> atomic operation.
> >>
> >> The various write operations need to share the xarray state in a
> >> mixture of user, soft irq and hard irq contexts so the xa_locking
> >> must support that.
> >>
> >> This patch replaces the xa locks with xa_lock_irqsave.
> >>
> >> Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by xarrays")
> >> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >> ---
> >>  drivers/infiniband/sw/rxe/rxe_pool.c | 24 ++++++++++++++++++------
> >>  1 file changed, 18 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> >> index 6215c6de3a84..f2b586249793 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> >> @@ -119,8 +119,10 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
> >>  int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
> >>  				bool sleepable)
> >>  {
> >> -	int err;
> >> +	struct xarray *xa = &pool->xa;
> >> +	unsigned long flags;
> >>  	gfp_t gfp_flags;
> >> +	int err;
> >>  
> >>  	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
> >>  		goto err_cnt;
> >> @@ -138,8 +140,10 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
> >>  
> >>  	if (sleepable)
> >>  		might_sleep();
> >> -	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
> >> +	xa_lock_irqsave(xa, flags);
> >> +	err = __xa_alloc_cyclic(xa, &elem->index, NULL, pool->limit,
> >>  			      &pool->next, gfp_flags);
> >> +	xa_unlock_irqrestore(xa, flags);
> > 
> > This stuff doesn't make any sense, the non __ versions already take
> > the xa_lock internally.
> > 
> > Or is this because you need the save/restore version for some reason?
> > But that seems unrelated and there should be a lockdep oops to go
> > along with it showing the backtrace??
> 
> The background here is that we are testing a 256 node system with
> the Lustre file system and doing fail-over-fail-back testing which
> is very high stress. This has uncovered several bugs where this is
> just one.

> The logic is 1st need to lock the lookup in rxe_pool_get_index()
> then when we tried to run with ordinary spin_locks we got lots of
> deadlocks. These are related to taking spin locks while in (soft
> irq) interrupt mode. In theory we could also get called in hard irq
> mode so might as well convert the locks to spin_lock_irqsave() which
> is safe in all cases.

That should be its own patch with justification..
 
> >> @@ -154,15 +158,16 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
> >>  {
> >>  	struct rxe_pool_elem *elem;
> >>  	struct xarray *xa = &pool->xa;
> >> +	unsigned long flags;
> >>  	void *obj;
> >>  
> >> -	rcu_read_lock();
> >> +	xa_lock_irqsave(xa, flags);
> >>  	elem = xa_load(xa, index);
> >>  	if (elem && kref_get_unless_zero(&elem->ref_cnt))
> >>  		obj = elem->obj;
> >>  	else
> >>  		obj = NULL;
> >> -	rcu_read_unlock();
> >> +	xa_unlock_irqrestore(xa, flags);
> > 
> > And this should be safe as long as the object is freed via RCU, so
> > what are you trying to fix?
> 
> The problem here is that rcu_read_lock only helps us if the object is freed with kfree_rcu.
> But we have no control over what rdma-core does and it does *not* do
> that for e.g. qp's.

Oh, yes that does sound right. This is another patch with this
explanation.

Jason
