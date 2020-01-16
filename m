Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D194913D925
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 12:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgAPLhP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 06:37:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgAPLhP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jan 2020 06:37:15 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C9A720730;
        Thu, 16 Jan 2020 11:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579174634;
        bh=1JtktxfKzN+N0n52FEf7hmpES7NKJAfNOU40ZZS7UJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iMQT21dXDy8IZ07j8n3PTSS9jFvGISpl2YbO6PWY3YjVEP5rsvww6/5KArct7jb+/
         JiWpGk0oRS4EE0c1Myhouwe7i2dB5fiptr+McW970DamO81reXEgZEa1y7mRO2Gt+K
         VxRnLUNLX3D589Cxy7ntKLV8+HP1tAd6ZB1dGI24=
Date:   Thu, 16 Jan 2020 13:37:10 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, shiraz.saleem@intel.com,
        aditr@vmware.com, mkalderon@marvell.com, aelior@marvell.com,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH RFC for-next 1/6] RDMA/core: support deliver net device
 event
Message-ID: <20200116113710.GD6853@unreal>
References: <1579147847-12158-1-git-send-email-liweihang@huawei.com>
 <1579147847-12158-2-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579147847-12158-2-git-send-email-liweihang@huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 16, 2020 at 12:10:42PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
>
> For the process of handling the link event of the net device, the driver
> of each provider is similar, so it can be integrated into the ib_core for
> unified processing.
>
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/core/cache.c  |  21 ++++++-
>  drivers/infiniband/core/device.c | 123 +++++++++++++++++++++++++++++++++++++++
>  include/rdma/ib_cache.h          |  13 +++++
>  include/rdma/ib_verbs.h          |   8 +++
>  4 files changed, 164 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index 17bfedd..791e965 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -1174,6 +1174,23 @@ int ib_get_cached_port_state(struct ib_device   *device,
>  }
>  EXPORT_SYMBOL(ib_get_cached_port_state);
>
> +int ib_get_cached_port_event_flags(struct ib_device   *device,
> +				   u8                  port_num,
> +				   enum ib_port_flags *event_flags)
> +{
> +	unsigned long flags;
> +
> +	if (!rdma_is_port_valid(device, port_num))
> +		return -EINVAL;

I know that ib_get_cached_port_state() has the same check, but it is
dumb, we don't need to call this function with wrong port_num.

> +
> +	read_lock_irqsave(&device->cache_lock, flags);
> +	*event_flags = device->port_data[port_num].cache.port_event_flags;
> +	read_unlock_irqrestore(&device->cache_lock, flags);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(ib_get_cached_port_event_flags);

This function is limited to ib_core.ko, no need in EXPORT_SYMBOL.

> +
>  /**
>   * rdma_get_gid_attr - Returns GID attributes for a port of a device
>   * at a requested gid_index, if a valid GID entry exists.
> @@ -1391,7 +1408,7 @@ ib_cache_update(struct ib_device *device, u8 port, bool enforce_security)
>  	if (!rdma_is_port_valid(device, port))
>  		return -EINVAL;
>
> -	tprops = kmalloc(sizeof *tprops, GFP_KERNEL);
> +	tprops = kzalloc(sizeof(*tprops), GFP_KERNEL);

Unrelated change but OK.

>  	if (!tprops)
>  		return -ENOMEM;
>
> @@ -1435,6 +1452,8 @@ ib_cache_update(struct ib_device *device, u8 port, bool enforce_security)
>  	device->port_data[port].cache.pkey = pkey_cache;
>  	device->port_data[port].cache.lmc = tprops->lmc;
>  	device->port_data[port].cache.port_state = tprops->state;
> +	device->port_data[port].cache.port_event_flags =
> +						tprops->port_event_flags;
>
>  	device->port_data[port].cache.subnet_prefix = tprops->subnet_prefix;
>  	write_unlock_irq(&device->cache_lock);
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index f6c2552..f03d6ce 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -1325,6 +1325,77 @@ static int enable_device_and_get(struct ib_device *device)
>  	return ret;
>  }
>
> +unsigned int ib_query_ndev_port_num(struct ib_device *device,
> +				    struct net_device *netdev)
> +{
> +	unsigned int port_num;
> +
> +	rdma_for_each_port(device, port_num)
> +		if (netdev == device->port_data[port_num].netdev)
> +			break;

Each event will do this function, while mlx5 has different logic separated
to RoCE, IB and representors.

> +
> +	return port_num;
> +}
> +EXPORT_SYMBOL(ib_query_ndev_port_num);

No need in EXPORT_SYMBOL.

> +
> +static inline enum ib_port_state get_port_state(struct net_device *netdev)

No inline function in C files.
> +{
> +	return (netif_running(netdev) && netif_carrier_ok(netdev)) ?
> +		IB_PORT_ACTIVE : IB_PORT_DOWN;
> +}
> +
> +static int ib_netdev_event(struct notifier_block *this,
> +			   unsigned long event, void *ptr)
> +{
> +	struct ib_device *device = container_of(this, struct ib_device, nb);
> +	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
> +
> +	switch (event) {
> +	case NETDEV_CHANGE:
> +	case NETDEV_UP:
> +	case NETDEV_DOWN: {
> +		unsigned int port_num = ib_query_ndev_port_num(device, netdev);
> +		enum ib_port_state last_state;
> +		enum ib_port_state curr_state;
> +		struct ib_event ibev;
> +		enum ib_port_flags flags;
> +
> +		if (ib_get_cached_port_event_flags(device, port_num, &flags))
> +			return NOTIFY_DONE;
> +
> +		if (flags & IB_PORT_BONDING_SLAVE)
> +			goto done;

I afraid that this "goto ..." breaks RoCE bonding.

> +
> +		if (ib_get_cached_port_state(device, port_num, &last_state))
> +			return NOTIFY_DONE;
> +
> +		curr_state = get_port_state(netdev);
> +
> +		if (last_state == curr_state)
> +			goto done;
> +
> +		ibev.device = device;
> +		if (curr_state == IB_PORT_DOWN)
> +			ibev.event = IB_EVENT_PORT_ERR;
> +		else if (curr_state == IB_PORT_ACTIVE)
> +			ibev.event = IB_EVENT_PORT_ACTIVE;
> +		else
> +			goto done;
> +
> +		ibev.element.port_num = port_num;
> +		ib_dispatch_event(&ibev);
> +		dev_dbg(&device->dev,
> +			"core send %s\n", ib_event_msg(ibev.event));
> +		break;

You put break in wrong place.

> +	}
> +
> +	default:
> +		break;
> +	}
> +done:
> +	return NOTIFY_DONE;
> +}
> +
>  /**
>   * ib_register_device - Register an IB device with IB core
>   * @device: Device to register
> @@ -1342,6 +1413,7 @@ static int enable_device_and_get(struct ib_device *device)
>   */
>  int ib_register_device(struct ib_device *device, const char *name)
>  {
> +	unsigned int port;
>  	int ret;
>
>  	ret = assign_name(device, name);
> @@ -1406,6 +1478,34 @@ int ib_register_device(struct ib_device *device, const char *name)
>  	}
>  	ib_device_put(device);
>
> +	device->nb.notifier_call = ib_netdev_event;
> +	ret = register_netdevice_notifier(&device->nb);

It is not relevant for IB and OPA devices.

> +	if (ret) {
> +		device->nb.notifier_call = NULL;
> +		return ret;
> +	}
> +
> +	rdma_for_each_port(device, port) {
> +		struct ib_event event;
> +		struct net_device *netdev = ib_device_get_netdev(device, port);
> +		enum ib_port_flags flags;
> +
> +		if (ib_get_cached_port_event_flags(device, port, &flags))
> +			continue;
> +
> +		if (flags & IB_PORT_BONDING_SLAVE)
> +			continue;
> +
> +		if (get_port_state(netdev) == IB_PORT_ACTIVE) {
> +			event.device = device;
> +			event.event = IB_EVENT_PORT_ACTIVE;
> +			event.element.port_num = port;
> +			ib_dispatch_event(&event);
> +			dev_dbg(&device->dev, "init event %s\n",
> +				ib_event_msg(event.event));

You already added print to newly ib_netdev_event().

> +		}
> +	}
> +
>  	return 0;
>
>  dev_cleanup:
> @@ -1470,6 +1570,29 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
>   */
>  void ib_unregister_device(struct ib_device *ib_dev)
>  {
> +	unsigned int port;
> +
> +	unregister_netdevice_notifier(&ib_dev->nb);

Not relevant for IB and OPA.

> +
> +	rdma_for_each_port(ib_dev, port) {
> +		struct net_device *netdev = ib_device_get_netdev(ib_dev, port);
> +		struct ib_event event;
> +		u32 flags;
> +
> +		if (ib_get_cached_port_event_flags(ib_dev, port, &flags))
> +			continue;
> +
> +		if (flags)
> +			continue;
> +
> +		if (get_port_state(netdev) == IB_PORT_ACTIVE) {
> +			event.device = ib_dev;
> +			event.event = IB_EVENT_PORT_ERR;
> +			event.element.port_num = port;
> +			ib_dispatch_event(&event);
> +		}
> +	}
> +
>  	get_device(&ib_dev->dev);
>  	__ib_unregister_device(ib_dev);
>  	put_device(&ib_dev->dev);
> diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h
> index 870b5e6..f37f667 100644
> --- a/include/rdma/ib_cache.h
> +++ b/include/rdma/ib_cache.h
> @@ -131,6 +131,19 @@ int ib_get_cached_port_state(struct ib_device *device,
>  			      u8                port_num,
>  			      enum ib_port_state *port_active);
>
> +/**
> + * ib_get_cached_port_event_flags - Returns a cached port event flags
> + * @device: The device to query.
> + * @port_num: The port number of the device to query.
> + * @event_flags: port_state for the specified port for that device.
> + *
> + * ib_get_cached_port_event_flags() fetches the specified event flags stored in
> + * the local software cache.
> + */
> +int ib_get_cached_port_event_flags(struct ib_device   *device,
> +				   u8                  port_num,
> +				   enum ib_port_flags *event_flags);
> +
>  bool rdma_is_zero_gid(const union ib_gid *gid);
>  const struct ib_gid_attr *rdma_get_gid_attr(struct ib_device *device,
>  					    u8 port_num, int index);
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index d8031f6..ce88d0b 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -670,6 +670,7 @@ struct ib_port_attr {
>  	u8			active_speed;
>  	u8                      phys_state;
>  	u16			port_cap_flags2;
> +	u32			port_event_flags;
>  };
>
>  enum ib_device_modify_flags {
> @@ -2149,12 +2150,18 @@ enum ib_mad_result {
>  	IB_MAD_RESULT_CONSUMED = 1 << 2  /* Packet consumed: stop processing */
>  };
>
> +enum ib_port_flags {

Please don't do named enums for bitwise declarations.

> +	IB_PORT_NORMAL = 0,		/* normarl port            */

normarl -> normal
Better to describe what do you mean by "normal port".

> +	IB_PORT_BONDING_SLAVE = 1 << 0, /* rdma bonding slave port */
> +};
> +
>  struct ib_port_cache {
>  	u64		      subnet_prefix;
>  	struct ib_pkey_cache  *pkey;
>  	struct ib_gid_table   *gid;
>  	u8                     lmc;
>  	enum ib_port_state     port_state;
> +	enum ib_port_flags     port_event_flags;

Please no, u32.

>  };
>
>  struct ib_port_immutable {
> @@ -2706,6 +2713,7 @@ struct ib_device {
>  	/* Used by iWarp CM */
>  	char iw_ifname[IFNAMSIZ];
>  	u32 iw_driver_flags;
> +	struct notifier_block nb;
>  };
>
>  struct ib_client_nl_info;
> --
> 2.8.1
>
