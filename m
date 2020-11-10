Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062CE2AD20F
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Nov 2020 10:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgKJJIK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Nov 2020 04:08:10 -0500
Received: from mail-eopbgr30062.outbound.protection.outlook.com ([40.107.3.62]:47226
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726462AbgKJJII (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Nov 2020 04:08:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfEhMd5M2Bj/ZreX3MSTG0q96wKpjzAT7XpzHDReUHe5ufgUKmH7IkRkF+crMN3IMY/LGLZoDzyTHFFdDBKJp+fkyhQF6+IQFyrcis4tK6I2SXV/3wm4jvgaVn8Dj0n9mAPn1UN55gbTX7NOvWXB6qVvlgcXrwPkx0q7e3oMXB60LSSPXXUKzMrtlb5BIvZRwVZsOJ3KH5H75j8bzqKkVUIGgBGKB3xKN5IwrLY/9HyxNECMk8RChHzmvzh8zHV4uPESHDM8ipRuveVmYXh6X1MzB72Pxu9DciLNIkRcDovQBs7KiUXtZiYHduO+eE0qGgorWpgnBIN4QBf6ZXu4rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2d92ad3jBjtgdvYMZ0d+uFiXkRXBdspi/eWjZS3Dec=;
 b=CXuZLuYr1RitlQfTGCr3I7EHOJjQujBK6idjX6AgyNQPBBRlMg1GsEIYZQNybeFCEw7bAzCbuTRildFqrtiYwetO2LME+oTUc7Y0Xu7NmcIzDyrWywtJwcA1ZYjbihg6kFrcpudBmvXeOh6JIicyUOFsjBbzycAtwHlD1mo1xqsFKMEm7A/3QtD3uE5J6cjj6AFZF6GKXSXAyqYfQTfc3rRF61c0ERpXM7v9x9pgEEzCoeJy1DgN3EgtHt7hUlmj7r/j3IS8/YgAOXHO9NxUksa3sPauXeFUSpU9EYPIxS8vCg6fC+/q0gIKJXs9MOP9yIMb57SefzaYIcfmalqHWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2d92ad3jBjtgdvYMZ0d+uFiXkRXBdspi/eWjZS3Dec=;
 b=DMHlupWeY3+h5X45ut27A8ermQT6OCZG2VAY2BrZLnAGW4TtaRtzvXuUEp9t7W3gYDrJaiyig6Rq3N2owDzqnET2vUrTELl9eVvYo//ywWojObxBn9EdwBMhG7r4EPJGlRlVbLMNcXNsrwpgNQYUYv0qfQ3ddHP4o1b1baa09ak=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM7PR05MB7107.eurprd05.prod.outlook.com (2603:10a6:20b:18f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Tue, 10 Nov
 2020 09:08:04 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c809:3cfb:d4d5:6007]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c809:3cfb:d4d5:6007%6]) with mapi id 15.20.3541.022; Tue, 10 Nov 2020
 09:08:04 +0000
Date:   Tue, 10 Nov 2020 11:07:50 +0200
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] RDMA/cm: Make the local_id_table xarray non-irq
Message-ID: <20201110090750.GH209294@unreal>
References: <0-v1-808b6da3bd3f+1857-cm_xarray_no_irq_jgg@nvidia.com>
 <20201105085231.GP5429@unreal>
 <20201105151522.GF2620339@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105151522.GF2620339@nvidia.com>
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: BYAPR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::23) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (216.228.112.21) by BYAPR06CA0010.namprd06.prod.outlook.com (2603:10b6:a03:d4::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 09:08:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0930745d-aaa1-458d-cf31-08d88558214c
X-MS-TrafficTypeDiagnostic: AM7PR05MB7107:
X-LD-Processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
X-Microsoft-Antispam-PRVS: <AM7PR05MB71074AC99AE9D174E36B53A4B0E90@AM7PR05MB7107.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLRnO7psZgu4kq+Pjpp+yXODhc7YOIzWgCl2yjbswXtnWd7D5L7ToWnLf/L1hRtb9sjaVjWWXZFIINoZkJRAO0HlGir+PB8a+3ukvGNZcbqXAHBR0z3A9HWegK5iOXr+s61Y6bemtXyqrSbhdFSU+/ClDLQn6Gt2p864zOZ/T6EWztp2lmHNIrgcyaYG/3vDSDZGbqeRoRTbX3svM7sGEi0DtkzbK57BKc+jWarM7N4DHzQjClv73fiASh0IaBGK/4LWlBZspTm8PgCzwZ5OTFI2RDez2AzssBHnbgWty9RUPCkatdodMD3lnfcjinhIjNZ9S4KrCM7L2UiOOhP6EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6408.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(16526019)(86362001)(1076003)(478600001)(26005)(33716001)(956004)(83380400001)(66556008)(9686003)(66476007)(66946007)(6486002)(2906002)(4326008)(6916009)(5660300002)(316002)(8676002)(8936002)(6496006)(52116002)(33656002)(186003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: vwVyq9dZ0Vg8hkcIdxzixcXakRlHxzZ3B9jDyLFLmyQ0xeQuNU49M/tgPlwxvph7RlvMed7QsBfOgMUjhXwNwNzyYwEEZO1ehDibRkC8BShmbNg/x579R3+eGkHc/rBpz0SNZkhb8l0d2ol4Dki3CeVBhP+0JPHw5ZXXPVM+MjI28Bvc10qCNB6a+caWmQUYoqNRM5NUb0jNkBPsxEoH/zvHq7hdQKdjPiZ7uZwqgwkGApfGGPmLl/xUAIFnt8Jm2z5Cv8qhjWKufkjaSklxxV5Pup7OFQqinAmvN3/x41bsRof1F6ANiFUBB12iFuz5eZ7hkOAJ2W77PNTuOoNJ9jPRFhVkkXqBQM+S7lcqXa5KUVlC79SMK403PZIKzc6lKrvr9onAomKcTsVVcfx5CUBZc+dNwAXOv1hQkaZfrHXRTi8b/pluIcSARuIqxEDxjKB024AXnJuqjVq4PrtsTwscOie+QlXRiSrGuulKABV3uKDDhFJ7CmFyg6TjG0uKFeZ3MaxRky9PEcQl1gDqzVcvq9Nv6+h6pCwG/i3FmxRh8/1dRbP8XZuS3yJ2JuqpIOX3seAqWwffuctbPTCgJCQzkFvuI/IWvZuHAl8/RIYt0MAxEIokn0lC0JvhKbLhI80mnNf9MfUeogFNBwv6VQ==
X-MS-Exchange-Transport-Forked: True
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0930745d-aaa1-458d-cf31-08d88558214c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6408.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 09:08:04.2998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEm/xiqfraJkennJkqgcPYCHZ/Ci0/e9/IJw3SeFv1tIFvDUP4LvPTnIIBXn7JCF9n5Vn7DuxDYOZxjItx4riA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB7107
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 05, 2020 at 11:15:22AM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 05, 2020 at 10:52:31AM +0200, Leon Romanovsky wrote:
> > On Wed, Nov 04, 2020 at 05:40:59PM -0400, Jason Gunthorpe wrote:
> > > The xarray is never mutated from an IRQ handler, only from work queues
> > > under a spinlock_irq. Thus there is no reason for it be an IRQ type
> > > xarray.
> > >
> > > This was copied over from the original IDR code, but the recent rework put
> > > the xarray inside another spinlock_irq which will unbalance the unlocking.
> > >
> > > Fixes: c206f8bad15d ("RDMA/cm: Make it clearer how concurrency works in cm_req_handler()")
> > > Reported-by: Matthew Wilcox <willy@infradead.org>
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > >  drivers/infiniband/core/cm.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> > > index 0201364974594f..167e436ae11ded 100644
> > > +++ b/drivers/infiniband/core/cm.c
> > > @@ -859,8 +859,8 @@ static struct cm_id_private *cm_alloc_id_priv(struct ib_device *device,
> > >  	atomic_set(&cm_id_priv->work_count, -1);
> > >  	refcount_set(&cm_id_priv->refcount, 1);
> > >
> > > -	ret = xa_alloc_cyclic_irq(&cm.local_id_table, &id, NULL, xa_limit_32b,
> > > -				  &cm.local_id_next, GFP_KERNEL);
> > > +	ret = xa_alloc_cyclic(&cm.local_id_table, &id, NULL, xa_limit_32b,
> > > +			      &cm.local_id_next, GFP_KERNEL);
> > >  	if (ret < 0)
> > >  		goto error;
> > >  	cm_id_priv->id.local_id = (__force __be32)id ^ cm.random_id_operand;
> > > @@ -878,8 +878,8 @@ static struct cm_id_private *cm_alloc_id_priv(struct ib_device *device,
> > >   */
> > >  static void cm_finalize_id(struct cm_id_private *cm_id_priv)
> > >  {
> > > -	xa_store_irq(&cm.local_id_table, cm_local_id(cm_id_priv->id.local_id),
> > > -		     cm_id_priv, GFP_KERNEL);
> > > +	xa_store(&cm.local_id_table, cm_local_id(cm_id_priv->id.local_id),
> > > +		 cm_id_priv, GFP_ATOMIC);
> > >  }
> >
> > I see that in the ib_create_cm_id() function, we call to cm_finalize_id(),
> > won't it be a problem to do it without irq lock?
>
> The _irq or _bh notations are only needed if some place acquires the
> internal spinlock from a bh (timer, tasklet, etc) or irq.
>
> Since all the places working with local_id_table are obviously in
> contexts that can do GFP_KERNEL allocations I conclude a normal
> spinlock is fine.

I see, Thanks

>
> Jason
