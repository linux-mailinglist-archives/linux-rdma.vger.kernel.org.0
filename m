Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F011281117
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 13:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgJBLQa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Oct 2020 07:16:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgJBLQa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 2 Oct 2020 07:16:30 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 278AF2065D;
        Fri,  2 Oct 2020 11:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601637389;
        bh=Nvz8lbJnLBj4X+8/PyTxGZapYh20UtJdyWMyZZf9JME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IMQihlXKqtiwOxLBphmfu3xwqvmTSYEuC+0g1brIyJKKuFmOYW+PjQ6+6+IIq08DE
         Wn1I3ofarPwefhfnGDCY6n3i/D7MU/Uw2tkBZKY+h5uADV9fX5Jt/EENe7sCtuFXm6
         QwddAuUKya4B1YIuz2hshVGDh1UcVvV30QKbOQ6g=
Date:   Fri, 2 Oct 2020 14:16:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v3 3/4] RDMA/core: Introduce new GID table
 query API
Message-ID: <20201002111626.GA3094@unreal>
References: <20200923165015.2491894-1-leon@kernel.org>
 <20200923165015.2491894-4-leon@kernel.org>
 <20201002000356.GA1213435@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002000356.GA1213435@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 01, 2020 at 09:03:56PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 23, 2020 at 07:50:14PM +0300, Leon Romanovsky wrote:
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
> >  drivers/infiniband/core/cache.c         | 73 ++++++++++++++++++++++++-
> >  include/rdma/ib_cache.h                 |  3 +
> >  include/uapi/rdma/ib_user_ioctl_verbs.h |  8 +++
> >  3 files changed, 81 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> > index cf49ac0b0aa6..211b88d17bc7 100644
> > +++ b/drivers/infiniband/core/cache.c
> > @@ -1247,6 +1247,74 @@ rdma_get_gid_attr(struct ib_device *device, u8 port_num, int index)
> >  }
> >  EXPORT_SYMBOL(rdma_get_gid_attr);
> >
> > +/**
> > + * rdma_query_gid_table - Reads GID table entries of all the ports of a device up to max_entries.
> > + * @device: The device to query.
> > + * @entries: Entries where GID entries are returned.
> > + * @max_entries: Maximum number of entries that can be returned.
> > + * Entries array must be allocated to hold max_entries number of entries.
> > + * @num_entries: Updated to the number of entries that were successfully read.
> > + *
> > + * Returns number of entries on success or appropriate error code.
> > + */
> > +ssize_t rdma_query_gid_table(struct ib_device *device,
> > +			     struct ib_uverbs_gid_entry *entries,
> > +			     size_t max_entries)
> > +{
> > +	const struct ib_gid_attr *gid_attr;
> > +	ssize_t num_entries = 0, ret;
> > +	struct ib_gid_table *table;
> > +	unsigned int port_num, i;
> > +	struct net_device *ndev;
> > +	unsigned long flags;
> > +
> > +	rdma_for_each_port(device, port_num) {
> > +		if (!rdma_ib_or_roce(device, port_num))
> > +			continue;
> > +
> > +		table = rdma_gid_table(device, port_num);
> > +		read_lock_irqsave(&table->rwlock, flags);
> > +		for (i = 0; i < table->sz; i++) {
> > +			if (!is_gid_entry_valid(table->data_vec[i]))
> > +				continue;
> > +			if (num_entries >= max_entries) {
> > +				ret = -EINVAL;
> > +				goto err;
> > +			}
> > +
> > +			gid_attr = &table->data_vec[i]->attr;
> > +
> > +			memcpy(&entries->gid, &gid_attr->gid,
> > +			       sizeof(gid_attr->gid));
> > +			entries->gid_index = gid_attr->index;
> > +			entries->port_num = gid_attr->port_num;
> > +			entries->gid_type = gid_attr->gid_type;
>
> > +			rcu_read_lock();
> > +			ndev = rdma_read_gid_attr_ndev_rcu(gid_attr);
>
> This can't call rdma_read_gid_attr_ndev_rcu(), that also obtains the
> rwlock. rwlock can't be nested.

Sorry for that.

>
> Why didn't lockdep explode on this?

I don't know.

>
> This whole thing can just be:
>
>     ndev = rcu_dereference_protected(gid_attr->ndev, lockdep_is_held(&table->rwlock))
>     if (ndev)
>          entries->netdev_ifindex = ndev->ifindex;
>
> Jason
