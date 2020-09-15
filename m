Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFBF26A468
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Sep 2020 13:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgIOLru (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Sep 2020 07:47:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIOLrI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Sep 2020 07:47:08 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A709F20732;
        Tue, 15 Sep 2020 11:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600170428;
        bh=u0ZCXAtUd1T/sahy0seTlGuKqmBczTEOCYW+fb2HauA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1sHFqMp4cvdfdNhvovS9YomMQXah6hbwaVfQLHTyaxAJ8eHucUi2fjFkCujJFAEs0
         WaFk2nvTNTSE6bpqYcQ8JuafoMvg8qncyExYq2arrFFRmtdkDN3gzbuXyZzalIHJYl
         6y+OlU7ZS07M0Mew1NFczvRb//K4oTQEtrg5P7Kk=
Date:   Tue, 15 Sep 2020 14:47:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 4/4] RDMA/uverbs: Expose the new GID query API
 to user space
Message-ID: <20200915114704.GB486552@unreal>
References: <20200910142204.1309061-1-leon@kernel.org>
 <20200910142204.1309061-5-leon@kernel.org>
 <20200911195918.GT904879@nvidia.com>
 <20200913091302.GF35718@unreal>
 <20200914155550.GF904879@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914155550.GF904879@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 14, 2020 at 12:55:50PM -0300, Jason Gunthorpe wrote:
> On Sun, Sep 13, 2020 at 12:13:02PM +0300, Leon Romanovsky wrote:
> > > > +static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_ENTRY)(
> > > > +	struct uverbs_attr_bundle *attrs)
> > > > +{
> > > > +	const struct ib_gid_attr *gid_attr;
> > > > +	struct ib_uverbs_gid_entry entry;
> > > > +	struct ib_ucontext *ucontext;
> > > > +	struct ib_device *ib_dev;
> > > > +	u32 gid_index;
> > > > +	u32 port_num;
> > > > +	u32 flags;
> > > > +	int ret;
> > > > +
> > > > +	ret = uverbs_get_flags32(&flags, attrs,
> > > > +				 UVERBS_ATTR_QUERY_GID_ENTRY_FLAGS, 0);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = uverbs_get_const(&port_num, attrs,
> > > > +			       UVERBS_ATTR_QUERY_GID_ENTRY_PORT);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = uverbs_get_const(&gid_index, attrs,
> > > > +			       UVERBS_ATTR_QUERY_GID_ENTRY_GID_INDEX);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ucontext = ib_uverbs_get_ucontext(attrs);
> > > > +	if (IS_ERR(ucontext))
> > > > +		return PTR_ERR(ucontext);
> > > > +	ib_dev = ucontext->device;
> > >
> > > > +	if (!rdma_is_port_valid(ib_dev, port_num))
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (!rdma_ib_or_roce(ib_dev, port_num))
> > > > +		return -EINVAL;
> > >
> > > Why these two tests? I would expect rdma_get_gid_attr() to do them
> >
> > First check is not needed, but the second check doesn't exist in
> > rdma_get_gid_attr(). We don't check that table returned from
> > rdma_gid_table() call exists.
>
> Oh that is a bit exciting, maybe it should be checked...
>
> Ideally we should also block this uapi entirely if the device doesn't
> have a gid table, so this should be -EOPNOTSUP and moved up to the
> top so it can be moved once we figure it out.

It is already in earliest possible stage, right after we get ib_device.

>
> > > > +	gid_attr = rdma_get_gid_attr(ib_dev, port_num, gid_index);
> > > > +	if (IS_ERR(gid_attr))
> > > > +		return PTR_ERR(gid_attr);
> > > > +
> > > > +	memcpy(&entry.gid, &gid_attr->gid, sizeof(gid_attr->gid));
> > > > +	entry.gid_index = gid_attr->index;
> > > > +	entry.port_num = gid_attr->port_num;
> > > > +	entry.gid_type = gid_attr->gid_type;
> > > > +	ret = rdma_get_ndev_ifindex(gid_attr, &entry.netdev_ifindex);
> > >
> > > Use rdma_read_gid_attr_ndev_rcu()
> >
> > I don't want to bring below logic to uverbs* file.
> >
> >   1263         if (rdma_protocol_ib(gid_attr->device, gid_attr->port_num)) {
> >   1264                 *ndev_ifindex = 0;
> >   1265                 return 0;
> >   1266         }
>
> Shouldn't be needed, rdma_read_gid_attr_ndev_rcu() already returns -1
> for IB

It will be something like this:

diff --git a/drivers/infiniband/core/uverbs_std_types_device.c b/drivers/infiniband/core/uverbs_std_types_device.c
index 8e957aa38531..071698af4b8e 100644
--- a/drivers/infiniband/core/uverbs_std_types_device.c
+++ b/drivers/infiniband/core/uverbs_std_types_device.c
@@ -368,10 +368,11 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_TABLE)(
 static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_ENTRY)(
 	struct uverbs_attr_bundle *attrs)
 {
+	struct ib_uverbs_gid_entry entry = {};
 	const struct ib_gid_attr *gid_attr;
-	struct ib_uverbs_gid_entry entry;
 	struct ib_ucontext *ucontext;
 	struct ib_device *ib_dev;
+	struct net_device *ndev;
 	u32 gid_index;
 	u32 port_num;
 	u32 flags;
@@ -408,9 +409,17 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_ENTRY)(
 	entry.gid_index = gid_attr->index;
 	entry.port_num = gid_attr->port_num;
 	entry.gid_type = gid_attr->gid_type;
-	ret = rdma_get_ndev_ifindex(gid_attr, &entry.netdev_ifindex);
-	if (ret)
-		goto out;
+
+	if (rdma_protocol_roce(ib_dev, port_num)) {
+		rcu_read_lock();
+		ndev = rdma_read_gid_attr_ndev_rcu(gid_attr);
+		if (IS_ERR(ndev)) {
+		       rcu_read_unlock();
+		       goto out;
+		}
+		entry.netdev_ifindex = ndev->ifindex;
+		rcu_read_unlock();
+	}

 	ret = uverbs_copy_to_struct_or_zero(
 		attrs, UVERBS_ATTR_QUERY_GID_ENTRY_RESP_ENTRY, &entry,
