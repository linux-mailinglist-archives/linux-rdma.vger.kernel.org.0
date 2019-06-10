Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD1583B7F7
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 17:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389830AbfFJPEJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 11:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389345AbfFJPEJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 11:04:09 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FD0E20859;
        Mon, 10 Jun 2019 15:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560179048;
        bh=nxj7GZVJsiPI4fCQSjsYbK+kxomTJa3zmf/uaqaXnPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FrSpwJjlNbSny5R38T5GR6ozCrcbzFzMe4iiFv7Gps0F/80VD1gUKlpnv0lCi+1BI
         S3xrA185VDkAnZ4PpNn2ZExy0kCEZNcB/7wAVAS74irsm+EifmLQZEH2r2NR7TCsft
         IqzHJcar5rhupoqiV4xUPwSylAZdWqgmOM+JvuM8=
Date:   Mon, 10 Jun 2019 18:04:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
Message-ID: <20190610150404.GF6369@mtr-leonro.mtl.com>
References: <20190605183252.6687-1-jgg@ziepe.ca>
 <20190605183252.6687-3-jgg@ziepe.ca>
 <20190610142325.GC6369@mtr-leonro.mtl.com>
 <20190610144737.GE18446@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610144737.GE18446@mellanox.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 10, 2019 at 02:47:42PM +0000, Jason Gunthorpe wrote:
> On Mon, Jun 10, 2019 at 05:23:25PM +0300, Leon Romanovsky wrote:
> > On Wed, Jun 05, 2019 at 03:32:51PM -0300, Jason Gunthorpe wrote:
> > > From: Jason Gunthorpe <jgg@mellanox.com>
> > >
> > > Allow userspace to issue a netlink query against the ib_device for
> > > something like "uverbs" and get back the char dev name, inode major/minor,
> > > and interface ABI information for "uverbs0".
> > >
> > > Since we are now in netlink this can also trigger a module autoload to
> > > make the uverbs device come into existence.
> > >
> > > Largely this will let us replace searching and reading inside sysfs to
> > > setup devices, and provides an alternative (using driver_id) to device
> > > name based provider binding for things like rxe.
> > >
> > > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > >  drivers/infiniband/core/core_priv.h |  9 +++
> > >  drivers/infiniband/core/device.c    | 88 ++++++++++++++++++++++++++++
> > >  drivers/infiniband/core/nldev.c     | 91 +++++++++++++++++++++++++++++
> > >  include/rdma/ib_verbs.h             |  4 ++
> > >  include/rdma/rdma_netlink.h         |  2 +
> > >  include/uapi/rdma/rdma_netlink.h    | 10 ++++
> > >  6 files changed, 204 insertions(+)
> > >
> > > diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
> > > index ff40a450b5d28e..a953c2fa2e7811 100644
> > > +++ b/drivers/infiniband/core/core_priv.h
> > > @@ -88,6 +88,15 @@ typedef int (*nldev_callback)(struct ib_device *device,
> > >  int ib_enum_all_devs(nldev_callback nldev_cb, struct sk_buff *skb,
> > >  		     struct netlink_callback *cb);
> > >
> > > +struct ib_client_nl_info {
> > > +	struct sk_buff *nl_msg;
> > > +	struct device *cdev;
> > > +	unsigned int port;
> > > +	u64 abi;
> > > +};
> > > +int ib_get_client_nl_info(struct ib_device *ibdev, const char *client_name,
> > > +			  struct ib_client_nl_info *res);
> > > +
> > >  enum ib_cache_gid_default_mode {
> > >  	IB_CACHE_GID_DEFAULT_MODE_SET,
> > >  	IB_CACHE_GID_DEFAULT_MODE_DELETE
> > > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > > index 49e5ea3a530f53..80e7911951f6f6 100644
> > > +++ b/drivers/infiniband/core/device.c
> > > @@ -1749,6 +1749,94 @@ void ib_unregister_client(struct ib_client *client)
> > >  }
> > >  EXPORT_SYMBOL(ib_unregister_client);
> > >
> > > +static int __ib_get_client_nl_info(struct ib_device *ibdev,
> > > +				   const char *client_name,
> > > +				   struct ib_client_nl_info *res)
> > > +{
> > > +	unsigned long index;
> > > +	void *client_data;
> > > +	int ret = -ENOENT;
> > > +
> > > +	if (!ibdev) {
> > > +		struct ib_client *client;
> > > +
> > > +		down_read(&clients_rwsem);
> > > +		xa_for_each_marked (&clients, index, client, CLIENT_REGISTERED) {
> > > +			if (strcmp(client->name, client_name) != 0)
> > > +				continue;
> > > +			if (!client->get_global_nl_info) {
> > > +				ret = -EOPNOTSUPP;
> > > +				break;
> > > +			}
> > > +			ret = client->get_global_nl_info(res);
> > > +			if (WARN_ON(ret == -ENOENT))
> >
> > You are putting to much WARN_ON, sometimes printk can be enough.
>
> One should not use printk for a kernel bug. It just makes debugging
> harder. This is the appropriate pattern for 'things that cannot happen'
>
>
> > > +				ret = -EINVAL;
> > > +			if (!ret && res->cdev)
> > > +				get_device(res->cdev);
> > > +			break;
> > > +		}
> > > +		up_read(&clients_rwsem);
> > > +		return ret;
> >
> > This flow is better to have in separate function, one function for
> > loaded client and another for no-loaded.
>
> Yah, maybe so
>
> > > diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
> > > index f588e8551c6cea..15eb861d1324f4 100644
> > > +++ b/include/uapi/rdma/rdma_netlink.h
> > > @@ -279,6 +279,8 @@ enum rdma_nldev_command {
> > >
> > >  	RDMA_NLDEV_CMD_RES_PD_GET, /* can dump */
> > >
> > > +	RDMA_NLDEV_CMD_GET_CHARDEV,
> > > +
> > >  	RDMA_NLDEV_NUM_OPS
> > >  };
> > >
> > > @@ -491,6 +493,14 @@ enum rdma_nldev_attr {
> > >  	 */
> > >  	RDMA_NLDEV_NET_NS_FD,			/* u32 */
> > >
> > > +	/*
> > > +	 * Information about a chardev
> > > +	 */
> > > +	RDMA_NLDEV_ATTR_CHARDEV_TYPE,		/* string */
> > > +	RDMA_NLDEV_ATTR_CHARDEV_NAME,		/* string */
> > > +	RDMA_NLDEV_ATTR_CHARDEV_ABI,		/* u64 */
> > > +	RDMA_NLDEV_ATTR_CHARDEV,		/* u64 */
> >
> > Please document them, especially RDMA_NLDEV_ATTR_CHARDEV and
> > RDMA_NLDEV_ATTR_CHARDEV_TYPE.
>
> Where do you want to put them? There is a distinct lack of
> documentation for the netlink attributes in this file. Every one I
> wanted to use I had to look up the implementation.

I believe that short description near their declaration in
rdna_netlink.h is fine enough.

Thanks

>
> Jason
