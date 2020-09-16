Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC96626C948
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 21:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgIPTGR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 15:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbgIPRpm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Sep 2020 13:45:42 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DF2C2074B;
        Wed, 16 Sep 2020 10:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600252633;
        bh=PgEI8vS0nsgv3iH8i8L4GHDU7WPQh7ep9t9JCYDYbR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UIYuDS4T0OS4B4+s3Dxa5sOMPGrVIVSWZ3chUXWQvj34S0/SZ9dU1WR/GX3k3Kpzl
         +rX0iiyy+kxMS0v+LH4n4jtE4QnZD2rN+HXUp2Fdpl7BjGEPBw9nz55OYgL+JLYnxl
         o7t5j1dyHBdo9e5njhSvORAsvbv6FkX0NYwO0pEE=
Date:   Wed, 16 Sep 2020 13:37:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 4/4] RDMA/uverbs: Expose the new GID query API
 to user space
Message-ID: <20200916103710.GH486552@unreal>
References: <20200910142204.1309061-1-leon@kernel.org>
 <20200910142204.1309061-5-leon@kernel.org>
 <20200911195918.GT904879@nvidia.com>
 <20200913091302.GF35718@unreal>
 <20200914155550.GF904879@nvidia.com>
 <20200915114704.GB486552@unreal>
 <20200915190614.GE1573713@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915190614.GE1573713@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 15, 2020 at 04:06:14PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 15, 2020 at 02:47:04PM +0300, Leon Romanovsky wrote:
> > On Mon, Sep 14, 2020 at 12:55:50PM -0300, Jason Gunthorpe wrote:
> > > On Sun, Sep 13, 2020 at 12:13:02PM +0300, Leon Romanovsky wrote:
> > > > > > +static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_ENTRY)(
> > > > > > +	struct uverbs_attr_bundle *attrs)
> > > > > > +{
> > > > > > +	const struct ib_gid_attr *gid_attr;
> > > > > > +	struct ib_uverbs_gid_entry entry;
> > > > > > +	struct ib_ucontext *ucontext;
> > > > > > +	struct ib_device *ib_dev;
> > > > > > +	u32 gid_index;
> > > > > > +	u32 port_num;
> > > > > > +	u32 flags;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	ret = uverbs_get_flags32(&flags, attrs,
> > > > > > +				 UVERBS_ATTR_QUERY_GID_ENTRY_FLAGS, 0);
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	ret = uverbs_get_const(&port_num, attrs,
> > > > > > +			       UVERBS_ATTR_QUERY_GID_ENTRY_PORT);
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	ret = uverbs_get_const(&gid_index, attrs,
> > > > > > +			       UVERBS_ATTR_QUERY_GID_ENTRY_GID_INDEX);
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	ucontext = ib_uverbs_get_ucontext(attrs);
> > > > > > +	if (IS_ERR(ucontext))
> > > > > > +		return PTR_ERR(ucontext);
> > > > > > +	ib_dev = ucontext->device;
> > > > >
> > > > > > +	if (!rdma_is_port_valid(ib_dev, port_num))
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	if (!rdma_ib_or_roce(ib_dev, port_num))
> > > > > > +		return -EINVAL;
> > > > >
> > > > > Why these two tests? I would expect rdma_get_gid_attr() to do them
> > > >
> > > > First check is not needed, but the second check doesn't exist in
> > > > rdma_get_gid_attr(). We don't check that table returned from
> > > > rdma_gid_table() call exists.
> > >
> > > Oh that is a bit exciting, maybe it should be checked...
> > >
> > > Ideally we should also block this uapi entirely if the device doesn't
> > > have a gid table, so this should be -EOPNOTSUP and moved up to the
> > > top so it can be moved once we figure it out.
> >
> > It is already in earliest possible stage, right after we get ib_device.
>
> I usually put it before the uverbs_get_XX.. but doesn't matter
>
> > @@ -408,9 +409,17 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_ENTRY)(
> >  	entry.gid_index = gid_attr->index;
> >  	entry.port_num = gid_attr->port_num;
> >  	entry.gid_type = gid_attr->gid_type;
> > -	ret = rdma_get_ndev_ifindex(gid_attr, &entry.netdev_ifindex);
> > -	if (ret)
> > -		goto out;
> > +
> > +	if (rdma_protocol_roce(ib_dev, port_num)) {
>
> Not sure this is needed? non-roce still has gid table entries, and the
> attr->ndev should be null so it will do the ENODEV naturally.

It depends on how you want to treat errors from rdma_read_gid_attr_ndev_rcu().
Current check allows us to ensure that any error returned by this call is
handled.

Otherwise we will find ourselves with something like this:
ndev = rdma_read_gid_attr_ndev_rcu(gid_attr);
if (IS_ERR(ndev)) {
	if (rdma_protocol_roce())
		goto error;
	if (ERR_PTR(ndev) != -ENODEV)
	        goto error;
}

>
> > +		rcu_read_lock();
> > +		ndev = rdma_read_gid_attr_ndev_rcu(gid_attr);
> > +		if (IS_ERR(ndev)) {
> > +		       rcu_read_unlock();
> > +		       goto out;
> > +		}
> > +		entry.netdev_ifindex = ndev->ifindex;
> > +		rcu_read_unlock();
> > +	}
>
> This is better than what is in rdma_get_ndev_ifindex()
>
> Jason
