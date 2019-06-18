Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4FA34A095
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 14:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfFRMRN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 08:17:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFRMRN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jun 2019 08:17:13 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B37A2085A;
        Tue, 18 Jun 2019 12:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560860232;
        bh=qkdW+jcw5/ZGMez7MSNVa7xJ+DhWr9m/C/IplO43qhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vNtXmaNgfYeXgVJJ6UfhoIwDltnQ1Yrw52hsOhXkoEITpzfKlNnn5kb1O44SV/WV6
         OyLQEuSvBLIeJmLMboeoDPPhi/KU907SmPuov5k9bR0bfO5LSCFGXmDTloxaTNjeLD
         23wWjjIoXJtAN3SAscWbYc8718BVowSZVXg8/jaE=
Date:   Tue, 18 Jun 2019 15:17:09 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v2 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
Message-ID: <20190618121709.GK4690@mtr-leonro.mtl.com>
References: <20190614003819.19974-1-jgg@ziepe.ca>
 <20190614003819.19974-3-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614003819.19974-3-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 13, 2019 at 09:38:18PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> Allow userspace to issue a netlink query against the ib_device for
> something like "uverbs" and get back the char dev name, inode major/minor,
> and interface ABI information for "uverbs0".
>
> Since we are now in netlink this can also trigger a module autoload to
> make the uverbs device come into existence.
>
> Largely this will let us replace searching and reading inside sysfs to
> setup devices, and provides an alternative (using driver_id) to device
> name based provider binding for things like rxe.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/core_priv.h |  9 +++
>  drivers/infiniband/core/device.c    | 98 +++++++++++++++++++++++++++++
>  drivers/infiniband/core/nldev.c     | 91 +++++++++++++++++++++++++++
>  include/rdma/ib_verbs.h             |  4 ++
>  include/rdma/rdma_netlink.h         |  2 +
>  include/uapi/rdma/rdma_netlink.h    | 14 +++++
>  6 files changed, 218 insertions(+)
>
> diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
> index ff40a450b5d28e..a953c2fa2e7811 100644
> --- a/drivers/infiniband/core/core_priv.h
> +++ b/drivers/infiniband/core/core_priv.h
> @@ -88,6 +88,15 @@ typedef int (*nldev_callback)(struct ib_device *device,
>  int ib_enum_all_devs(nldev_callback nldev_cb, struct sk_buff *skb,
>  		     struct netlink_callback *cb);
>
> +struct ib_client_nl_info {
> +	struct sk_buff *nl_msg;
> +	struct device *cdev;
> +	unsigned int port;
> +	u64 abi;
> +};
> +int ib_get_client_nl_info(struct ib_device *ibdev, const char *client_name,
> +			  struct ib_client_nl_info *res);
> +
>  enum ib_cache_gid_default_mode {
>  	IB_CACHE_GID_DEFAULT_MODE_SET,
>  	IB_CACHE_GID_DEFAULT_MODE_DELETE
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index abb169f31d0fe3..7db8566cdb8904 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -1726,6 +1726,104 @@ void ib_unregister_client(struct ib_client *client)
>  }
>  EXPORT_SYMBOL(ib_unregister_client);
>
> +static int __ib_get_global_client_nl_info(const char *client_name,
> +					  struct ib_client_nl_info *res)
> +{
> +	struct ib_client *client;
> +	unsigned long index;
> +	int ret = -ENOENT;
> +
> +	down_read(&clients_rwsem);
> +	xa_for_each_marked (&clients, index, client, CLIENT_REGISTERED) {
> +		if (strcmp(client->name, client_name) != 0)
> +			continue;
> +		if (!client->get_global_nl_info) {
> +			ret = -EOPNOTSUPP;
> +			break;
> +		}
> +		ret = client->get_global_nl_info(res);
> +		if (WARN_ON(ret == -ENOENT))
> +			ret = -EINVAL;
> +		if (!ret && res->cdev)
> +			get_device(res->cdev);
> +		break;
> +	}
> +	up_read(&clients_rwsem);
> +	return ret;
> +}
> +
> +static int __ib_get_client_nl_info(struct ib_device *ibdev,
> +				   const char *client_name,
> +				   struct ib_client_nl_info *res)
> +{
> +	unsigned long index;
> +	void *client_data;
> +	int ret = -ENOENT;
> +
> +	down_read(&ibdev->client_data_rwsem);
> +	xan_for_each_marked (&ibdev->client_data, index, client_data,
> +			     CLIENT_DATA_REGISTERED) {
> +		struct ib_client *client = xa_load(&clients, index);
> +
> +		if (!client || strcmp(client->name, client_name) != 0)
> +			continue;
> +		if (!client->get_nl_info) {
> +			ret = -EOPNOTSUPP;
> +			break;
> +		}
> +		ret = client->get_nl_info(ibdev, client_data, res);
> +		if (WARN_ON(ret == -ENOENT))
> +			ret = -EINVAL;
> +
> +		/*
> +		 * The cdev is guaranteed valid as long as we are inside the
> +		 * client_data_rwsem as remove_one can't be called. Keep it
> +		 * valid for the caller.
> +		 */
> +		if (!ret && res->cdev)
> +			get_device(res->cdev);
> +		break;
> +	}
> +	up_read(&ibdev->client_data_rwsem);
> +
> +	return ret;
> +}
> +
> +/**
> + * ib_get_client_nl_info - Fetch the nl_info from a client
> + * @device - IB device
> + * @client_name - Name of the client
> + * @res - Result of the query
> + */
> +int ib_get_client_nl_info(struct ib_device *ibdev, const char *client_name,
> +			  struct ib_client_nl_info *res)
> +{
> +	int ret;
> +
> +	if (ibdev)
> +		ret = __ib_get_client_nl_info(ibdev, client_name, res);
> +	else
> +		ret = __ib_get_global_client_nl_info(client_name, res);
> +#ifdef CONFIG_MODULES
> +	if (ret == -ENOENT) {
> +		request_module("rdma-client-%s", client_name);
> +		if (ibdev)
> +			ret = __ib_get_client_nl_info(ibdev, client_name, res);
> +		else
> +			ret = __ib_get_global_client_nl_info(client_name, res);
> +	}
> +#endif
> +	if (ret) {
> +		if (ret == -ENOENT)
> +			return -EOPNOTSUPP;
> +		return ret;
> +	}
> +
> +	if (WARN_ON(!res->cdev))
> +		return -EINVAL;
> +	return 0;
> +}
> +
>  /**
>   * ib_set_client_data - Set IB client context
>   * @device:Device to set context for
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index 69188cbbd99bd5..55eccea628e99f 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -120,6 +120,9 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
>  	[RDMA_NLDEV_ATTR_DEV_PROTOCOL]		= { .type = NLA_NUL_STRING,
>  				    .len = RDMA_NLDEV_ATTR_ENTRY_STRLEN },
>  	[RDMA_NLDEV_NET_NS_FD]			= { .type = NLA_U32 },
> +	[RDMA_NLDEV_ATTR_CHARDEV_TYPE]		= { .type = NLA_NUL_STRING,
> +				    .len = 128 },
> +	[RDMA_NLDEV_ATTR_PORT_INDEX]		= { .type = NLA_U32 },

It is wrong, we already have RDMA_NLDEV_ATTR_PORT_INDEX declared in nla_policy.
But we don't have other RDMA_NLDEV_ATTR_CHARDEV_* declarations here.

Thanks
