Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FAA267EE3
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Sep 2020 11:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgIMJNJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Sep 2020 05:13:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgIMJNH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 13 Sep 2020 05:13:07 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10FE1207BB;
        Sun, 13 Sep 2020 09:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599988386;
        bh=DrSFdlkCJ88se4MgjiUOXNcJIFl3i9GSP0Gldfu17TI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2rkboum6NZCqr34JlgdBtu6An2PRQSaFF/LqsvIQrQJ+U2PWr9zgyeWs+MqzdANqv
         /ofe/vC+DOx2qVg+Z163i3v7w/mjuoUVNkL7uk6OMhI+/06JfLiqf56iPXE0MMJSvz
         Dsh3l8JQ1eTeqNeEcfFUPimGBAMoEsSpyWqbpgOg=
Date:   Sun, 13 Sep 2020 12:13:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 4/4] RDMA/uverbs: Expose the new GID query API
 to user space
Message-ID: <20200913091302.GF35718@unreal>
References: <20200910142204.1309061-1-leon@kernel.org>
 <20200910142204.1309061-5-leon@kernel.org>
 <20200911195918.GT904879@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911195918.GT904879@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 11, 2020 at 04:59:18PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 10, 2020 at 05:22:04PM +0300, Leon Romanovsky wrote:
> > From: Avihai Horon <avihaih@nvidia.com>
> >
> > Expose the query GID table and entry API to user space by adding
> > two new methods and method handlers to the device object.
> >
> > This API provides a faster way to query a GID table using single call and
> > will be used in libibverbs to improve current approach that requires
> > multiple calls to open, close and read multiple sysfs files for a single
> > GID table entry.
> >
> > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >  .../infiniband/core/uverbs_std_types_device.c | 180 +++++++++++++++++-
> >  include/rdma/ib_verbs.h                       |   6 +-
> >  include/uapi/rdma/ib_user_ioctl_cmds.h        |  16 ++
> >  include/uapi/rdma/ib_user_ioctl_verbs.h       |   6 +
> >  4 files changed, 204 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/uverbs_std_types_device.c b/drivers/infiniband/core/uverbs_std_types_device.c
> > index 7b03446b6936..beba1e284264 100644
> > +++ b/drivers/infiniband/core/uverbs_std_types_device.c
> > @@ -8,6 +8,7 @@
> >  #include "uverbs.h"
> >  #include <rdma/uverbs_ioctl.h>
> >  #include <rdma/opa_addr.h>
> > +#include <rdma/ib_cache.h>
> >
> >  /*
> >   * This ioctl method allows calling any defined write or write_ex
> > @@ -266,6 +267,157 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_CONTEXT)(
> >  	return ucontext->device->ops.query_ucontext(ucontext, attrs);
> >  }
> >
> > +static int copy_gid_entries_to_user(struct uverbs_attr_bundle *attrs,
> > +				    struct ib_uverbs_gid_entry *entries,
> > +				    size_t num_entries, size_t user_entry_size)
> > +{
> > +	const struct uverbs_attr *attr;
> > +	void __user *user_entries;
> > +	size_t copy_len;
> > +	int ret;
> > +	int i;
> > +
> > +	if (user_entry_size == sizeof(*entries)) {
> > +		ret = uverbs_copy_to(attrs,
> > +				     UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES,
> > +				     entries, sizeof(*entries) * num_entries);
> > +		return ret;
> > +	}
> > +
> > +	copy_len = min_t(size_t, user_entry_size, sizeof(*entries));
> > +	attr = uverbs_attr_get(attrs, UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES);
> > +	if (IS_ERR(attr))
> > +		return PTR_ERR(attr);
> > +
> > +	user_entries = u64_to_user_ptr(attr->ptr_attr.data);
> > +	for (i = 0; i < num_entries; i++) {
> > +		if (copy_to_user(user_entries, entries, copy_len))
> > +			return -EFAULT;
> > +
> > +		if (user_entry_size > sizeof(*entries)) {
> > +			if (clear_user(user_entries + sizeof(*entries),
> > +				       user_entry_size - sizeof(*entries)))
> > +				return -EFAULT;
> > +		}
> > +
> > +		entries++;
> > +		user_entries += user_entry_size;
> > +	}
> > +
> > +	return uverbs_output_written(attrs,
> > +				     UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES);
> > +}
> > +
> > +static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_TABLE)(
> > +	struct uverbs_attr_bundle *attrs)
> > +{
> > +	struct ib_uverbs_gid_entry *entries;
> > +	struct ib_ucontext *ucontext;
> > +	struct ib_device *ib_dev;
> > +	size_t user_entry_size;
> > +	size_t max_entries;
> > +	size_t num_entries;
> > +	u32 flags;
> > +	int ret;
> > +
> > +	ret = uverbs_get_flags32(&flags, attrs,
> > +				 UVERBS_ATTR_QUERY_GID_TABLE_FLAGS, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = uverbs_get_const(&user_entry_size, attrs,
> > +			       UVERBS_ATTR_QUERY_GID_TABLE_ENTRY_SIZE);
> > +	if (ret)
> > +		return ret;
> > +
> > +	max_entries = uverbs_attr_ptr_get_array_size(
> > +		attrs, UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES,
> > +		user_entry_size);
> > +	if (max_entries <= 0)
> > +		return -EINVAL;
> > +
> > +	ucontext = ib_uverbs_get_ucontext(attrs);
> > +	if (IS_ERR(ucontext))
> > +		return PTR_ERR(ucontext);
> > +	ib_dev = ucontext->device;
> > +
> > +	entries = uverbs_zalloc(attrs, max_entries * sizeof(*entries));
>
> This multiplication could overflow

Right, I fixed it.

>
> > +
> > +static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_ENTRY)(
> > +	struct uverbs_attr_bundle *attrs)
> > +{
> > +	const struct ib_gid_attr *gid_attr;
> > +	struct ib_uverbs_gid_entry entry;
> > +	struct ib_ucontext *ucontext;
> > +	struct ib_device *ib_dev;
> > +	u32 gid_index;
> > +	u32 port_num;
> > +	u32 flags;
> > +	int ret;
> > +
> > +	ret = uverbs_get_flags32(&flags, attrs,
> > +				 UVERBS_ATTR_QUERY_GID_ENTRY_FLAGS, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = uverbs_get_const(&port_num, attrs,
> > +			       UVERBS_ATTR_QUERY_GID_ENTRY_PORT);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = uverbs_get_const(&gid_index, attrs,
> > +			       UVERBS_ATTR_QUERY_GID_ENTRY_GID_INDEX);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ucontext = ib_uverbs_get_ucontext(attrs);
> > +	if (IS_ERR(ucontext))
> > +		return PTR_ERR(ucontext);
> > +	ib_dev = ucontext->device;
>
> > +	if (!rdma_is_port_valid(ib_dev, port_num))
> > +		return -EINVAL;
> > +
> > +	if (!rdma_ib_or_roce(ib_dev, port_num))
> > +		return -EINVAL;
>
> Why these two tests? I would expect rdma_get_gid_attr() to do them

First check is not needed, but the second check doesn't exist in
rdma_get_gid_attr(). We don't check that table returned from
rdma_gid_table() call exists.

>
> > +	gid_attr = rdma_get_gid_attr(ib_dev, port_num, gid_index);
> > +	if (IS_ERR(gid_attr))
> > +		return PTR_ERR(gid_attr);
> > +
> > +	memcpy(&entry.gid, &gid_attr->gid, sizeof(gid_attr->gid));
> > +	entry.gid_index = gid_attr->index;
> > +	entry.port_num = gid_attr->port_num;
> > +	entry.gid_type = gid_attr->gid_type;
> > +	ret = rdma_get_ndev_ifindex(gid_attr, &entry.netdev_ifindex);
>
> Use rdma_read_gid_attr_ndev_rcu()

I don't want to bring below logic to uverbs* file.

  1263         if (rdma_protocol_ib(gid_attr->device, gid_attr->port_num)) {
  1264                 *ndev_ifindex = 0;
  1265                 return 0;
  1266         }

>
> Jason
