Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513641CEED1
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 10:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgELIIh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 04:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729116AbgELIIg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 04:08:36 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5290920674;
        Tue, 12 May 2020 08:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589270916;
        bh=H9aabxf944ZHduaHOWJFmpMXz7GhPE6+nbahnAPAHxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ufSi3T7hCKsDXas2+7YcUestod+e1g1Zf96cHqWUzV6h/zUZF0ODmyQuSTEKaOHgV
         i2Ur0kqu9bmRazH73eupaapoY3wjU3ronWMVW45PeHgxvLnv7giGyg3blfDuTJHhNV
         7xbJgsls/J2wdFLeFToSDJ7ld1gpWSuhLRlpboBk=
Date:   Tue, 12 May 2020 11:08:31 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yamin Friedman <yaminf@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/4] RDMA/core: Introduce shared CQ pool API
Message-ID: <20200512080831.GH4814@unreal>
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
 <1589122557-88996-3-git-send-email-yaminf@mellanox.com>
 <20200511050740.GB356445@unreal>
 <345890f8-52d6-1aef-dd63-b3115384def5@mellanox.com>
 <eada151f-b763-f300-fb60-8b38c9a7be2d@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eada151f-b763-f300-fb60-8b38c9a7be2d@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 12, 2020 at 10:00:59AM +0300, Yamin Friedman wrote:
>
> On 5/11/2020 3:08 PM, Yamin Friedman wrote:
> >
> > On 5/11/2020 8:07 AM, Leon Romanovsky wrote:
> > > On Sun, May 10, 2020 at 05:55:55PM +0300, Yamin Friedman wrote:
> > > > Allow a ULP to ask the core to provide a completion queue based on a
> > > > least-used search on a per-device CQ pools. The device CQ pools
> > > > grow in a
> > > > lazy fashion when more CQs are requested.
> > > >
> > > > This feature reduces the amount of interrupts when using many QPs.
> > > > Using shared CQs allows for more effcient completion handling. It also
> > > > reduces the amount of overhead needed for CQ contexts.
> > > >
> > > > Test setup:
> > > > Intel(R) Xeon(R) Platinum 8176M CPU @ 2.10GHz servers.
> > > > Running NVMeoF 4KB read IOs over ConnectX-5EX across Spectrum switch.
> > > > TX-depth = 32. Number of cores refers to the initiator side.
> > > > Four disks are
> > > > accessed from each core. In the current case we have four CQs
> > > > per core and
> > > > in the shared case we have a single CQ per core. Until 14 cores
> > > > there is no
> > > > significant change in performance and the number of interrupts
> > > > per second
> > > > is less than a million in the current case.
> > > > ==================================================
> > > > |Cores|Current KIOPs  |Shared KIOPs  |improvement|
> > > > |-----|---------------|--------------|-----------|
> > > > |14   |2188           |2620          |19.7%      |
> > > > |-----|---------------|--------------|-----------|
> > > > |20   |2063           |2308          |11.8%      |
> > > > |-----|---------------|--------------|-----------|
> > > > |28   |1933           |2235          |15.6%      |
> > > > |=================================================
> > > > |Cores|Current avg lat|Shared avg lat|improvement|
> > > > |-----|---------------|--------------|-----------|
> > > > |14   |817us          |683us         |16.4%      |
> > > > |-----|---------------|--------------|-----------|
> > > > |20   |1239us         |1108us        |10.6%      |
> > > > |-----|---------------|--------------|-----------|
> > > > |28   |1852us         |1601us        |13.5%      |
> > > > ========================================================
> > > > |Cores|Current interrupts|Shared interrupts|improvement|
> > > > |-----|------------------|-----------------|-----------|
> > > > |14   |2131K/sec         |425K/sec         |80%        |
> > > > |-----|------------------|-----------------|-----------|
> > > > |20   |2267K/sec         |594K/sec         |73.8%      |
> > > > |-----|------------------|-----------------|-----------|
> > > > |28   |2370K/sec         |1057K/sec        |55.3%      |
> > > > ====================================================================
> > > > |Cores|Current 99.99th PCTL lat|Shared 99.99th PCTL lat|improvement|
> > > > |-----|------------------------|-----------------------|-----------|
> > > > |14   |85Kus                   |9Kus |88%        |
> > > > |-----|------------------------|-----------------------|-----------|
> > > > |20   |6Kus                    |5.3Kus |14.6%      |
> > > > |-----|------------------------|-----------------------|-----------|
> > > > |28   |11.6Kus                 |9.5Kus |18%        |
> > > > |===================================================================
> > > >
> > > > Performance improvement with 16 disks (16 CQs per core) is comparable.
> > > >
> > > > Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
> > > > Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
> > > > ---
> > > >   drivers/infiniband/core/core_priv.h |   8 ++
> > > >   drivers/infiniband/core/cq.c        | 145
> > > > ++++++++++++++++++++++++++++++++++++
> > > >   drivers/infiniband/core/device.c    |   3 +-
> > > >   include/rdma/ib_verbs.h             |  32 ++++++++
> > > >   4 files changed, 187 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/infiniband/core/core_priv.h
> > > > b/drivers/infiniband/core/core_priv.h
> > > > index cf42acc..7fe9c13 100644
> > > > --- a/drivers/infiniband/core/core_priv.h
> > > > +++ b/drivers/infiniband/core/core_priv.h
> > > > @@ -191,6 +191,14 @@ static inline bool
> > > > rdma_is_upper_dev_rcu(struct net_device *dev,
> > > >       return netdev_has_upper_dev_all_rcu(dev, upper);
> > > >   }
> > > >
> > > > +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned
> > > > int nr_cqe,
> > > > +                 int cpu_hint, enum ib_poll_context poll_ctx);
> > > > +void ib_cq_pool_put(struct ib_cq *cq, unsigned int nr_cqe);
> > > > +
> > > > +void ib_init_cq_pools(struct ib_device *dev);
> > > > +
> > > > +void ib_purge_cq_pools(struct ib_device *dev);
> > > I don't know how next patches compile to you, but "core_priv.h" is wrong
> > > place to put function declarations. You also put them here and in
> > > ib_verbs.h
> > > below.
> > >
> > > Also, it will be nice if you will use same naming convention like in
> > > mr_pool.h
> > I will remove the use of core_priv and look into refactoring the names.
> Init_cq_pools and purge_cq_pools are not exported functions they are for
> internal core use, is ib_verbs really the place for them?

I don't know, probably better to group them together because you
will need to put ib_cq_pool_put/ib_cq_pool_get in the ib_verbs.h anyway.

Thanks
