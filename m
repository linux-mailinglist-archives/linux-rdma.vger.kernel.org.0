Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAF8390CF9
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 01:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhEYXfr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 19:35:47 -0400
Received: from mail-bn8nam11on2053.outbound.protection.outlook.com ([40.107.236.53]:36449
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231504AbhEYXfr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 May 2021 19:35:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3ZSuJs1VlOW7cLgswTw3OchkAP0LISI1K3pquu7wSLVhut1tpbKaqZIdiwdpjSOpm4K7N2+2XsXa7cX69ry0ie53LqcPfX9D3Tz9t5y/v2aHjxj6CPeuGlHlFpF98CRRBiyaVo1txKI8CTDzSsCdIv1+IyK9cRNzax25tolueSOO04D33Km1b+X0BDSj4hTOUQyJOoB4556acq2gwGGYkm9qESot5UD9l4Vww5/J/uSm0xmRHjQyloIDvJIINdUMzi7tnLwPYdsLl57Is8jpRjyryu+/HOpJ/IymU+aycFLr2hil/HT9pN4yYPHUsmXqI7wl5xmgekoh1VhIwiSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hcC4nBKyrw08IN/5WKaJUsfBjTDY0ZKgnrWmJdS37Q=;
 b=BChwboMyTTYM87G6/AK/wuNjjB3UF0f9/CXl7oEPuQUmZzqB4U6x9omAqdIDItOzmoOEmtS2KgKU1/HnKLYqQEPCWy9kaXybPNccO6AczIfQFY1I3HFEEN6wgdIEA8STlgxt4aGVZR9wMAq0IfXZyLYLXjljZCvgGkN12mvlAErj01T0sie0kYhMB/oLUuu8TJsfm32034WqQJUaymI0o8el3+RYXgqrajOYbjbA3ndeGCwfTf+VuUdN3zjiZ6OVKGbBk522QcfINov7f38YOosIZlUqHhosa8Tg0uvTjFRsHbXjvRNVoAkSg6RGnv9kxm+Jb+vnjDbRR59r2gzJAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hcC4nBKyrw08IN/5WKaJUsfBjTDY0ZKgnrWmJdS37Q=;
 b=rTWL/ahwfK/Dl0Lzehwa5SlMeAhj++kBY6SpG74FK76lkJejFd9N0YDcGrcZpu+VVE+vMXjBrsyMxkoNepYgdQ+5g2qDWaHwu2RA6+FZ2+VcgcKQ2179J+tq0kFyJ4SA43erf7J7Vzkd3QFKmspb2u2epIOG4BambNfBvG3302CU+36Cvt2cGyb1uyYBNBeI1UvazFbk5fZdPSLgEWPSWm3dOSAcIWvwQvh07iBIvTQDZ/C/G7tqrsoPZG9pUjMw0oJ9GKsdONI27hc5KySeUYS2t7aBvO9rHFTN0OjkJWyOhMwuNGSNE1g6AHPoMZkZzVgphNYjAr0ybSMfWTc8zQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 25 May
 2021 23:34:15 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 23:34:15 +0000
Date:   Tue, 25 May 2021 20:34:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Pearson, Robert B" <rpearsonhpe@gmail.com>
Cc:     zyj2020@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Fix memory ordering problem for
 resize cq
Message-ID: <20210525233413.GM1002214@nvidia.com>
References: <20210525201111.623970-1-rpearsonhpe@gmail.com>
 <20210525230303.GK1002214@nvidia.com>
 <6d7531df-3b09-790c-ac22-cbf9faae5701@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d7531df-3b09-790c-ac22-cbf9faae5701@gmail.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR05CA0011.namprd05.prod.outlook.com (2603:10b6:610::24)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR05CA0011.namprd05.prod.outlook.com (2603:10b6:610::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend Transport; Tue, 25 May 2021 23:34:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1llgYv-00EfPj-NT; Tue, 25 May 2021 20:34:13 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 603a76a8-b6fe-46e4-09db-08d91fd59bf4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5333:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5333E07A2C0BF242CA65362AC2259@BL1PR12MB5333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GIKQu3j++ReIvAvMrmQ1JSsSpcC1up5l4DOjJy0xFEBUmQnygiaz6dHP2KXhWZUtEZQqeMcqOAGV3ndmAm/nvqS0seYpfsYGncV+SvUcI8wYCkHwutgHjPvvJA68bohtVrGaOFhevMBgwwwZtsakpytgIiHAjnophu/K5f5b58gBpPycxGRElSu94RMbSZowuDB1ggplR+A0gmCaBJOx1CFX1yI/sh4SBJb3iVDwGr870qxnUnQHOZzKsJzY4PyMfLz9qYanHJ9NyuW4dx1G6Fglrm/fBoK1jly9nQjWvzKvLJLNOMVMB4yjoeRF2DjcUMan5u5EcUroPNxR0iLvsvfJ19Fs3lISd09c1d3XY8F4EMmhUoeuLX06X9qQbJ316zo8YoCNCLipEObvfvN7m7b/DZxweu1zkMsLaNSxcl3T9Uy/mp9q2qFM8xbBROzxqBmHliQhNRvCWBnvM921o8XFry8EDfico5P2ZQXsz3CKy+UicUBRW8bj7/OfSn+4LJqtKgIqAX5XP+vngzNbIx5EXFR0PTZVn/bf45CFE//5SjycKFNe2IyF8+gB/EWBCM44qsNbIDDK3uYj26dPrQkRR5E+8AtPGJTD3TL27WM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(86362001)(9786002)(36756003)(33656002)(83380400001)(6916009)(478600001)(2906002)(26005)(4326008)(2616005)(186003)(316002)(66946007)(53546011)(5660300002)(8676002)(8936002)(38100700002)(9746002)(426003)(66556008)(66476007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kD7znhp0h1Bcw/2cXL+p9c++u1NiG1dJ/WJ+MYlf1uo72TICflXkdqWPqQZh?=
 =?us-ascii?Q?ch8a11X98pe1q38uWxyJZbfk1aq3b2b8yV1ZLPpNg2SVZtfBP1ETsO0FkQOW?=
 =?us-ascii?Q?yLR3dQ+70yZUIwTt4kDg/SS3XbQceRqssCeb8RU/LXlaeh9qV1LMD8OoD9dO?=
 =?us-ascii?Q?KBqzjBKcps3RL1IodhSl+v158m/EEmBBRY8h93uauZDnf5AQ9/mBHydtlwUI?=
 =?us-ascii?Q?rcExXxAq5SxQ6PQq9WuJ1n3v2ZrUU1n86WOzq3zz8wMKs4PCVNxJqsv9d2J0?=
 =?us-ascii?Q?4esNmHhjJM3p21t3FhrX+um1KM+G8lHmZNxx1hsdhoNNOnjf6FZ2M7nsTB3F?=
 =?us-ascii?Q?dlCdv5qcCgVRGwiSpCnd7LZLgwuDtnldpdUxkCj8Blardq34w8va4TdckehY?=
 =?us-ascii?Q?2727vc4ZTnkGsmMOsVxka6nPYl3gHrrxz8WX73scrTdX41A/THN4t/6YXAer?=
 =?us-ascii?Q?mmiai3GNWC6oQ+mSX53d934dX7/ZaSkK0RlIHwI+GHMFlD/9VwTQ5WfJZhlm?=
 =?us-ascii?Q?E3x5dFZw7EG79AZBrW4kwPo3Lf8yFX8fZfKFyc9THNs614UFEdQbv3XzXsqp?=
 =?us-ascii?Q?h4vrmOsT4h8Z7/YNFvmOd6j+9o8Fe9lq7NiJ65T15E46ROcPfKeEnxpm1UnO?=
 =?us-ascii?Q?bH69+29IzNl98Pk9fvKYfQu9eWpf9RnuDywhbiQ3Xm/pJQsp9PqLTQdmA+S4?=
 =?us-ascii?Q?OJRPnm9H5tvmDJhoXltonRdRvaT/xz6FEMBlPiub/I3CclWQx4W5Hus/5fyp?=
 =?us-ascii?Q?zH4Cj57f2aZwTdYS7VyfcNM23KGFajX+kwZGziDo91u4MrCoJXkQ0Km2XDyh?=
 =?us-ascii?Q?Nmz+v/3sKguHtQuPWy5a1g3Lzk4JuaI+ZFvmGuh4HsdVNhsAm0clK+YzOanD?=
 =?us-ascii?Q?jZw824VjQM58dUGMFIg7bYZ4M3i91zlylwty65KcS63OwYiM775l3kh0e50I?=
 =?us-ascii?Q?KKYUnN87H6/NalS3I+874ZVQlMNIWa8cTIjzslhipqsM7gVtVCoN5Zb6n1Gj?=
 =?us-ascii?Q?/LiP8AYmd/xS4fpfksFzwaJVMdyJpNj00VHawnLs3QyRf+L0Ht/Wk3+I0DVF?=
 =?us-ascii?Q?GDGMV8+95eG0S1nTAawcYRb018Mdt/ZUP6d8ZkkRXkt3ANXVm7xYAQihB8R+?=
 =?us-ascii?Q?6mysEgjwHYgCxvHHu5d0UBbfh9sVyHknEB7QNXUen3ZL0kLCyubo1PbP5TdE?=
 =?us-ascii?Q?n1o+eJvHB8Jr3AKXy5we/XgEI937RUXH8w1bqAgjb1gQLq8N8hmDLVAVryUv?=
 =?us-ascii?Q?WHwXdS/fyAhYauaXa4w3Qkqw3U6DUvLidUyk1CZIJ85dN2unE2qfRZ3MhT8G?=
 =?us-ascii?Q?sgpQNn3jCJRKH4dUQLGvWXya?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603a76a8-b6fe-46e4-09db-08d91fd59bf4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 23:34:15.5578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BTbgoXG/+L9B8V1CrOm81AJgese/zp7b6UEmDCt3i8oFIoeE/tpyUI+BRmkj51n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5333
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 25, 2021 at 06:12:46PM -0500, Pearson, Robert B wrote:
> 
> On 5/25/2021 6:03 PM, Jason Gunthorpe wrote:
> > On Tue, May 25, 2021 at 03:11:12PM -0500, Bob Pearson wrote:
> > > The rxe driver has recently begun exhibiting failures in the python
> > > tests that are due to stale values read from the completion queue
> > > producer or consumer indices. Unlike the other loads of these shared
> > > indices those in queue_count() were not protected by smp_load_acquire().
> > > 
> > > This patch replaces loads by smp_load_acquire() in queue_count().
> > > The observed errors no longer occur.
> > > 
> > > Reported-by: Zhu Yanjun <zyj2020@gmail.com>
> > > Fixes: d21a1240f516 ("RDMA/rxe: Use acquire/release for memory ordering")
> > > Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> > >   drivers/infiniband/sw/rxe/rxe_queue.h | 18 ++++++++++++++++--
> > >   1 file changed, 16 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
> > > index 2902ca7b288c..5cb142282fa6 100644
> > > +++ b/drivers/infiniband/sw/rxe/rxe_queue.h
> > > @@ -161,8 +161,22 @@ static inline unsigned int index_from_addr(const struct rxe_queue *q,
> > >   static inline unsigned int queue_count(const struct rxe_queue *q)
> > >   {
> > > -	return (q->buf->producer_index - q->buf->consumer_index)
> > > -		& q->index_mask;
> > > +	u32 prod;
> > > +	u32 cons;
> > > +	u32 count;
> > > +
> > > +	/* make sure all changes to queue complete before
> > > +	 * changing producer index
> > > +	 */
> > > +	prod = smp_load_acquire(&q->buf->producer_index);
> > > +
> > > +	/* make sure all changes to queue complete before
> > > +	 * changing consumer index
> > > +	 */
> > > +	cons = smp_load_acquire(&q->buf->consumer_index);
> > > +	count = (prod - cons) % q->index_mask;
> > > +
> > > +	return count;
> > >   }
> > It doesn't quite make sense to load both?
> > 
> > Only the one written by userspace should require a load_acquire, the
> > one written by the kernel should already be locked somehow with a
> > kernel lock or there is a different problem
> > 
> > But yes, this does look like a bug to me
> > 
> > Jason
> 
> The rxe_queue.h API is used by completion and work queues so both directions
> occur. The question is the trade off between the logic to avoid the
> load_acquire vs the branching to get around. Same point could be applied to
> queue_empty() which already had both load_acquire() calls. Is it worth
> creating several versions of APIs with different choices made?

Hard to say.. I would probably have made special types for 'user
producer' and 'user consumer' queues and had actually different
behavior - the kernel controlled data should be shadowed in the kernel
and only copied to the user - have to consider the user corrupting the
data, for instance.

Jason
