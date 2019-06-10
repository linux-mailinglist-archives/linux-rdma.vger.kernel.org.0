Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2533B74C
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 16:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389378AbfFJO0b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 10:26:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389402AbfFJO0b (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 10:26:31 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CC9420859;
        Mon, 10 Jun 2019 14:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560176790;
        bh=vwfzWKTmclP2KoM1sbwTVmlYHpMZUdr4+1IJkMIndaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0NhiahYazVe7I+Y5Q6usV7PGejrmF0bMKXOzxui2rZAvSZ7Yba++pPIPDo/GWHiGx
         GcMJwScmAm2QveXkgU6UhiXNSgOPejMjxyXJw7s7K0/B1t+Tk8xsvk5o3xvUW/nfu5
         UO1Svf0dnvXydcEuUxAv34EBBZSH8nQ5lwZYyB1U=
Date:   Mon, 10 Jun 2019 17:26:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
Message-ID: <20190610142626.GD6369@mtr-leonro.mtl.com>
References: <20190605183252.6687-1-jgg@ziepe.ca>
 <20190605183252.6687-3-jgg@ziepe.ca>
 <20190610142325.GC6369@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610142325.GC6369@mtr-leonro.mtl.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 10, 2019 at 05:23:25PM +0300, Leon Romanovsky wrote:
> On Wed, Jun 05, 2019 at 03:32:51PM -0300, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> >
> > Allow userspace to issue a netlink query against the ib_device for
> > something like "uverbs" and get back the char dev name, inode major/minor,
> > and interface ABI information for "uverbs0".
> >
> > Since we are now in netlink this can also trigger a module autoload to
> > make the uverbs device come into existence.
> >
> > Largely this will let us replace searching and reading inside sysfs to
> > setup devices, and provides an alternative (using driver_id) to device
> > name based provider binding for things like rxe.
> >
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > ---
> >  drivers/infiniband/core/core_priv.h |  9 +++
> >  drivers/infiniband/core/device.c    | 88 ++++++++++++++++++++++++++++
> >  drivers/infiniband/core/nldev.c     | 91 +++++++++++++++++++++++++++++
> >  include/rdma/ib_verbs.h             |  4 ++
> >  include/rdma/rdma_netlink.h         |  2 +
> >  include/uapi/rdma/rdma_netlink.h    | 10 ++++
> >  6 files changed, 204 insertions(+)
> >
> > diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
> > index ff40a450b5d28e..a953c2fa2e7811 100644
> > --- a/drivers/infiniband/core/core_priv.h
> > +++ b/drivers/infiniband/core/core_priv.h
> > @@ -88,6 +88,15 @@ typedef int (*nldev_callback)(struct ib_device *device,
> >  int ib_enum_all_devs(nldev_callback nldev_cb, struct sk_buff *skb,
> >  		     struct netlink_callback *cb);
> >
> > +struct ib_client_nl_info {
> > +	struct sk_buff *nl_msg;
> > +	struct device *cdev;
> > +	unsigned int port;
> > +	u64 abi;
> > +};
> > +int ib_get_client_nl_info(struct ib_device *ibdev, const char *client_name,
> > +			  struct ib_client_nl_info *res);
> > +
> >  enum ib_cache_gid_default_mode {
> >  	IB_CACHE_GID_DEFAULT_MODE_SET,
> >  	IB_CACHE_GID_DEFAULT_MODE_DELETE
> > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > index 49e5ea3a530f53..80e7911951f6f6 100644
> > --- a/drivers/infiniband/core/device.c
> > +++ b/drivers/infiniband/core/device.c
> > @@ -1749,6 +1749,94 @@ void ib_unregister_client(struct ib_client *client)
> >  }
> >  EXPORT_SYMBOL(ib_unregister_client);
> >
> > +static int __ib_get_client_nl_info(struct ib_device *ibdev,
> > +				   const char *client_name,
> > +				   struct ib_client_nl_info *res)
> > +{
> > +	unsigned long index;
> > +	void *client_data;
> > +	int ret = -ENOENT;
> > +
> > +	if (!ibdev) {
> > +		struct ib_client *client;
> > +
> > +		down_read(&clients_rwsem);
> > +		xa_for_each_marked (&clients, index, client, CLIENT_REGISTERED) {
> > +			if (strcmp(client->name, client_name) != 0)
> > +				continue;
> > +			if (!client->get_global_nl_info) {
> > +				ret = -EOPNOTSUPP;
> > +				break;
> > +			}
> > +			ret = client->get_global_nl_info(res);
> > +			if (WARN_ON(ret == -ENOENT))
>
> You are putting to much WARN_ON, sometimes printk can be enough.
>
> > +				ret = -EINVAL;
> > +			if (!ret && res->cdev)
> > +				get_device(res->cdev);
> > +			break;
> > +		}
> > +		up_read(&clients_rwsem);
> > +		return ret;
>
> This flow is better to have in separate function, one function for
> loaded client and another for no-loaded.
>
> > +	}
> > +
> > +	down_read(&ibdev->client_data_rwsem);
> > +	xan_for_each_marked (&ibdev->client_data, index, client_data,
> > +			     CLIENT_DATA_REGISTERED) {
> > +		struct ib_client *client = xa_load(&clients, index);
> > +
> > +		if (!client || strcmp(client->name, client_name) != 0)
> > +			continue;
> > +		if (!client->get_nl_info) {
> > +			ret = -EOPNOTSUPP;
> > +			break;
> > +		}
> > +		ret = client->get_nl_info(ibdev, client_data, res);
> > +		if (WARN_ON(ret == -ENOENT))
>
> Same comment
>
> > +			ret = -EINVAL;
> > +
> > +		/*
> > +		 * The cdev is guaranteed valid as long as we are inside the
> > +		 * client_data_rwsem as remove_one can't be called. Keep it
> > +		 * valid for the caller.
> > +		 */
> > +		if (!ret && res->cdev)
> > +			get_device(res->cdev);
> > +		break;
> > +	}
> > +	up_read(&ibdev->client_data_rwsem);
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * ib_get_client_nl_info - Fetch the nl_info from a client
> > + * @device - IB device
> > + * @client_name - Name of the client
> > + * @res - Result of the query
> > + */
> > +int ib_get_client_nl_info(struct ib_device *ibdev, const char *client_name,
> > +			  struct ib_client_nl_info *res)
> > +{
> > +	int ret;
> > +
> > +	ret = __ib_get_client_nl_info(ibdev, client_name, res);
> > +#ifdef CONFIG_MODULES
> > +	if (ret == -ENOENT) {
> > +		request_module("rdma-client-%s", client_name);
>
> Do our ib_clients have rdma-client-* names?

Ohh, I see it patch #3.

>
> > +		ret = __ib_get_client_nl_info(ibdev, client_name, res);
> > +	}
> > +#endif
> > +	if (ret) {
> > +		if (ret == -ENOENT)
> > +			return -EOPNOTSUPP;
> > +		return ret;
> > +	}
> > +
> > +	if (WARN_ON(!res->cdev))
> > +		return -EINVAL;
> > +	return 0;
> > +}
> > +
> >  /**
> >   * ib_set_client_data - Set IB client context
> >   * @device:Device to set context for
> > diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> > index 69188cbbd99bd5..55eccea628e99f 100644
> > --- a/drivers/infiniband/core/nldev.c
> > +++ b/drivers/infiniband/core/nldev.c
> > @@ -120,6 +120,9 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
> >  	[RDMA_NLDEV_ATTR_DEV_PROTOCOL]		= { .type = NLA_NUL_STRING,
> >  				    .len = RDMA_NLDEV_ATTR_ENTRY_STRLEN },
> >  	[RDMA_NLDEV_NET_NS_FD]			= { .type = NLA_U32 },
> > +	[RDMA_NLDEV_ATTR_CHARDEV_TYPE]		= { .type = NLA_NUL_STRING,
> > +				    .len = 128 },
> > +	[RDMA_NLDEV_ATTR_PORT_INDEX]		= { .type = NLA_U32 },
> >  };
> >
> >  static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
> > @@ -1347,6 +1350,91 @@ static int nldev_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
> >  	return 0;
> >  }
> >
> > +static int nldev_get_chardev(struct sk_buff *skb, struct nlmsghdr *nlh,
> > +			     struct netlink_ext_ack *extack)
> > +{
> > +	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
> > +	char client_name[IB_DEVICE_NAME_MAX];
> > +	struct ib_client_nl_info data = {};
> > +	struct ib_device *ibdev = NULL;
> > +	struct sk_buff *msg;
> > +	u32 index;
> > +	int err;
> > +
> > +	err = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1, nldev_policy,
> > +			  extack);
> > +	if (err || !tb[RDMA_NLDEV_ATTR_CHARDEV_TYPE])
> > +		return -EINVAL;
> > +
> > +	if (nla_strlcpy(client_name, tb[RDMA_NLDEV_ATTR_CHARDEV_TYPE],
> > +			sizeof(client_name)) >= sizeof(client_name))
> > +		return -EINVAL;
> > +
> > +	if (tb[RDMA_NLDEV_ATTR_DEV_INDEX]) {
> > +		index = nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
> > +		ibdev = ib_device_get_by_index(sock_net(skb->sk), index);
> > +		if (!ibdev)
> > +			return -EINVAL;
> > +
> > +		if (tb[RDMA_NLDEV_ATTR_PORT_INDEX]) {
> > +			data.port = nla_get_u32(tb[RDMA_NLDEV_ATTR_PORT_INDEX]);
> > +			if (!rdma_is_port_valid(ibdev, data.port)) {
> > +				err = -EINVAL;
> > +				goto out_put;
> > +			}
> > +		} else {
> > +			data.port = -1;
> > +		}
> > +	} else if (tb[RDMA_NLDEV_ATTR_PORT_INDEX]) {
> > +		return -EINVAL;
> > +	}
> > +
> > +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> > +	if (!msg) {
> > +		err = -ENOMEM;
> > +		goto out_put;
> > +	}
> > +	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
> > +			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
> > +					 RDMA_NLDEV_CMD_GET_CHARDEV),
> > +			0, 0);
> > +
> > +	data.nl_msg = msg;
> > +	err = ib_get_client_nl_info(ibdev, client_name, &data);
> > +	if (err)
> > +		goto out_nlmsg;
> > +
> > +	err = nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_CHARDEV,
> > +				huge_encode_dev(data.cdev->devt),
> > +				RDMA_NLDEV_ATTR_PAD);
> > +	if (err)
> > +		goto out_data;
> > +	err = nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_CHARDEV_ABI, data.abi,
> > +				RDMA_NLDEV_ATTR_PAD);
> > +	if (err)
> > +		goto out_data;
> > +	if (nla_put_string(msg, RDMA_NLDEV_ATTR_CHARDEV_NAME,
> > +			   dev_name(data.cdev))) {
> > +		err = -EMSGSIZE;
> > +		goto out_data;
> > +	}
> > +
> > +	nlmsg_end(msg, nlh);
> > +	put_device(data.cdev);
> > +	if (ibdev)
> > +		ib_device_put(ibdev);
> > +	return rdma_nl_unicast(msg, NETLINK_CB(skb).portid);
> > +
> > +out_data:
> > +	put_device(data.cdev);
> > +out_nlmsg:
> > +	nlmsg_free(msg);
> > +out_put:
> > +	if (ibdev)
> > +		ib_device_put(ibdev);
> > +	return err;
> > +}
> > +
> >  static int nldev_sys_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
> >  			      struct netlink_ext_ack *extack)
> >  {
> > @@ -1404,6 +1492,9 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
> >  		.doit = nldev_get_doit,
> >  		.dump = nldev_get_dumpit,
> >  	},
> > +	[RDMA_NLDEV_CMD_GET_CHARDEV] = {
> > +		.doit = nldev_get_chardev,
> > +	},
> >  	[RDMA_NLDEV_CMD_SET] = {
> >  		.doit = nldev_set_doit,
> >  		.flags = RDMA_NL_ADMIN_PERM,
> > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> > index d5dd3cb7fcf702..b93135a783eec0 100644
> > --- a/include/rdma/ib_verbs.h
> > +++ b/include/rdma/ib_verbs.h
> > @@ -2684,11 +2684,15 @@ struct ib_device {
> >  	u32 iw_driver_flags;
> >  };
> >
> > +struct ib_client_nl_info;
> >  struct ib_client {
> >  	const char *name;
> >  	void (*add)   (struct ib_device *);
> >  	void (*remove)(struct ib_device *, void *client_data);
> >  	void (*rename)(struct ib_device *dev, void *client_data);
> > +	int (*get_nl_info)(struct ib_device *ibdev, void *client_data,
> > +			   struct ib_client_nl_info *res);
> > +	int (*get_global_nl_info)(struct ib_client_nl_info *res);
> >
> >  	/* Returns the net_dev belonging to this ib_client and matching the
> >  	 * given parameters.
> > diff --git a/include/rdma/rdma_netlink.h b/include/rdma/rdma_netlink.h
> > index 10732ab31ba2f9..c7acbe08342828 100644
> > --- a/include/rdma/rdma_netlink.h
> > +++ b/include/rdma/rdma_netlink.h
> > @@ -110,4 +110,6 @@ void rdma_link_register(struct rdma_link_ops *ops);
> >  void rdma_link_unregister(struct rdma_link_ops *ops);
> >
> >  #define MODULE_ALIAS_RDMA_LINK(type) MODULE_ALIAS("rdma-link-" type)
> > +#define MODULE_ALIAS_RDMA_CLIENT(type) MODULE_ALIAS("rdma-client-" type)
> > +
> >  #endif /* _RDMA_NETLINK_H */
> > diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
> > index f588e8551c6cea..15eb861d1324f4 100644
> > --- a/include/uapi/rdma/rdma_netlink.h
> > +++ b/include/uapi/rdma/rdma_netlink.h
> > @@ -279,6 +279,8 @@ enum rdma_nldev_command {
> >
> >  	RDMA_NLDEV_CMD_RES_PD_GET, /* can dump */
> >
> > +	RDMA_NLDEV_CMD_GET_CHARDEV,
> > +
> >  	RDMA_NLDEV_NUM_OPS
> >  };
> >
> > @@ -491,6 +493,14 @@ enum rdma_nldev_attr {
> >  	 */
> >  	RDMA_NLDEV_NET_NS_FD,			/* u32 */
> >
> > +	/*
> > +	 * Information about a chardev
> > +	 */
> > +	RDMA_NLDEV_ATTR_CHARDEV_TYPE,		/* string */
> > +	RDMA_NLDEV_ATTR_CHARDEV_NAME,		/* string */
> > +	RDMA_NLDEV_ATTR_CHARDEV_ABI,		/* u64 */
> > +	RDMA_NLDEV_ATTR_CHARDEV,		/* u64 */
>
> Please document them, especially RDMA_NLDEV_ATTR_CHARDEV and
> RDMA_NLDEV_ATTR_CHARDEV_TYPE.
>
> > +
> >  	/*
> >  	 * Always the end
> >  	 */
> > --
> > 2.21.0
> >
