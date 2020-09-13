Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107BC267E78
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Sep 2020 10:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgIMICj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Sep 2020 04:02:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgIMICj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 13 Sep 2020 04:02:39 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9280C2074B;
        Sun, 13 Sep 2020 08:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599984158;
        bh=KKHXbv4fB4680N6E8ZjD15Mq3rSarEptUUQS4/1cemk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YKjjKkA3hHjdyW/ukBB4dHRqMXw/6MAGTRsoztsG7ZPZI+z3XI8Tdy4ehMYiCswzz
         1XI/K8iXKoaGUYY7CM3JHVEW6TuEfUq+XE2Jj1K2AoArD5O/BuCyXrxemYqugC5oZp
         msv1oJ0KnJUjsLCkB1mj6/weaT/VILLmxtTKbtVE=
Date:   Sun, 13 Sep 2020 11:02:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 3/4] RDMA/core: Introduce new GID table query
 API
Message-ID: <20200913080233.GE35718@unreal>
References: <20200910142204.1309061-1-leon@kernel.org>
 <20200910142204.1309061-4-leon@kernel.org>
 <20200911195221.GS904879@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911195221.GS904879@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 11, 2020 at 04:52:21PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 10, 2020 at 05:22:03PM +0300, Leon Romanovsky wrote:
> > From: Avihai Horon <avihaih@nvidia.com>
> >
> > Introduce rdma_query_gid_table which enables querying all the GID tables
> > of a given device and copying the attributes of all valid GID entries to
> > a provided buffer.
> >
> > This API provides a faster way to query a GID table using single call and
> > will be used in libibverbs to improve current approach that requires
> > multiple calls to open, close and read multiple sysfs files for a single
> > GID table entry.
> >
> > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >  drivers/infiniband/core/cache.c         | 93 +++++++++++++++++++++++++
> >  include/rdma/ib_cache.h                 |  5 ++
> >  include/uapi/rdma/ib_user_ioctl_verbs.h |  8 +++
> >  3 files changed, 106 insertions(+)
> >
> > diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> > index cf49ac0b0aa6..175e229eccd3 100644
> > +++ b/drivers/infiniband/core/cache.c
> > @@ -1247,6 +1247,99 @@ rdma_get_gid_attr(struct ib_device *device, u8 port_num, int index)
> >  }
> >  EXPORT_SYMBOL(rdma_get_gid_attr);
> >
> > +/**
> > + * rdma_get_ndev_ifindex - Reads ndev ifindex of the given gid attr.
> > + * @gid_attr: Pointer to the GID attribute.
> > + * @ndev_ifindex: Pointer through which the ndev ifindex is returned.
> > + *
> > + * Returns 0 on success or appropriate error code. The netdevice must be in UP
> > + * state.
> > + */
> > +int rdma_get_ndev_ifindex(const struct ib_gid_attr *gid_attr, u32 *ndev_ifindex)
> > +{
> > +	struct net_device *ndev;
> > +	int ret = 0;
> > +
> > +	if (rdma_protocol_ib(gid_attr->device, gid_attr->port_num)) {
> > +		*ndev_ifindex = 0;
> > +		return 0;
> > +	}
> > +
> > +	rcu_read_lock();
> > +	ndev = rcu_dereference(gid_attr->ndev);
> > +	if (!ndev || (READ_ONCE(ndev->flags) & IFF_UP) == 0) {
> > +		ret = -ENODEV;
> > +		goto out;
> > +	}
>
> None of this is necessary to read the ifindex, especially since the
> read_lock is being held.

I see same rcu_read_lock->rcu_dereference->rcu_read_unlock pattern in
rdma_read_gid_l2_fields(), why this function is different?

>
> > +/**
> > + * rdma_query_gid_table - Reads GID table entries of all the ports of a device up to max_entries.
> > + * @device: The device to query.
> > + * @entries: Entries where GID entries are returned.
> > + * @max_entries: Maximum number of entries that can be returned.
> > + * Entries array must be allocated to hold max_entries number of entries.
> > + * @num_entries: Updated to the number of entries that were successfully read.
> > + *
> > + * Returns 0 on success or appropriate error code.
> > + */
> > +int rdma_query_gid_table(struct ib_device *device,
> > +			 struct ib_uverbs_gid_entry *entries,
> > +			 size_t max_entries, size_t *num_entries)
>
> return ssize_t instead of the output pointer

I'll change.

>
> > +{
> > +	const struct ib_gid_attr *gid_attr;
> > +	struct ib_gid_table *table;
> > +	unsigned int port_num;
> > +	unsigned long flags;
> > +	int ret;
> > +	int i;
>
> i is unsigned

"i" is used as an iterator till table->sz while "sz" is declared as int.
I'll change it to be unsigned int, but it is not needed.

Thanks

>
> Jason
