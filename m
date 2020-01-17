Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6772140C60
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jan 2020 15:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgAQOXV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Jan 2020 09:23:21 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45833 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgAQOXU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Jan 2020 09:23:20 -0500
Received: by mail-qk1-f195.google.com with SMTP id x1so22749855qkl.12
        for <linux-rdma@vger.kernel.org>; Fri, 17 Jan 2020 06:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0Ohjp2DRXkr7M3X9dHBMZo0fYON0PiuG7X2OVDjJyk0=;
        b=eZFzMvRJH9ADC1idI6dpGzzOHSOgl+3SGoIB8Z4ta1LUSOtqAQ2BvSMTMtutp89Sia
         Ehl7J/QCaID6QPg4evOnAcUJFv5bHpjvhXpFgUsp4zzMTnX4TGFLqWBmDcciQvVCXyo2
         bVXDUBeDlsLV2xx4pKICkPtc7NRQh+YelVfyuB9k42tmXTAiqA59E/XOsuyA5lR+/1CR
         DgSzLVi++cgQnCKA6f+Wg/RiDmmw0fVAITn0hjnVu6U7HTTBOAZh+cU66otHMKrLd4z/
         oDTb1lwdqI9qld4lz7rN90GtBxG9+dh2wsIreC8ILa4A8ZfBZXZMANnyff0yvsqBVN/k
         kuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Ohjp2DRXkr7M3X9dHBMZo0fYON0PiuG7X2OVDjJyk0=;
        b=hAWNCjxt5piJfEVd/DgFbnzj/IdHUaXXvze8gE599H/Byw5gLp5/QwTPqCXM6sW+uI
         fSZNUMZM8piqR8dYct8QMGriTB9ByFjF1U/e5iZ0A951/tdDBxgn3+41yV4GbW22xSzn
         OBCiQgbiTC0oSgo4NGyDqC5cG8D6eDR2gZouj7eDl/LAMlZ8rkWB5Y3Oe63d1gB+e8Ev
         BtIRDrLcIyoPhAYYY7dBUVk2W6Cb/Pp0lgK/pJ5OSu0hnODHTuZ0LtTIRwtL4DrP/Aij
         +5HMlikHtOHZrBMybXR2kp/Ve5UbPLFEz3DkELdWZRbQG15XHjxXpDycF/PXUj/y++LY
         DQbQ==
X-Gm-Message-State: APjAAAW9W8oj8dr60ogiy/pm2P+V8tE9SNLt9h7fG17Z10b5QKboFcB5
        Ik1zvlaYmgOiQIkwoNb9StrXNA==
X-Google-Smtp-Source: APXvYqy2uta2u+/e2gcPJP+s9BaYmEr5ZlX+jccijLQEe08v/lCzcgrZKRHUQL7SaJn7y96YEBMwTA==
X-Received: by 2002:a05:620a:a0b:: with SMTP id i11mr39324972qka.11.1579270999664;
        Fri, 17 Jan 2020 06:23:19 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t15sm11676330qkg.49.2020.01.17.06.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Jan 2020 06:23:19 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1isSWs-00008T-Cj; Fri, 17 Jan 2020 10:23:18 -0400
Date:   Fri, 17 Jan 2020 10:23:18 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, shiraz.saleem@intel.com,
        aditr@vmware.com, mkalderon@marvell.com, aelior@marvell.com,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH RFC for-next 1/6] RDMA/core: support deliver net device
 event
Message-ID: <20200117142318.GB29725@ziepe.ca>
References: <1579147847-12158-1-git-send-email-liweihang@huawei.com>
 <1579147847-12158-2-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579147847-12158-2-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
>  drivers/infiniband/core/cache.c  |  21 ++++++-
>  drivers/infiniband/core/device.c | 123 +++++++++++++++++++++++++++++++++++++++
>  include/rdma/ib_cache.h          |  13 +++++
>  include/rdma/ib_verbs.h          |   8 +++
>  4 files changed, 164 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index 17bfedd..791e965 100644
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
> +
> +	read_lock_irqsave(&device->cache_lock, flags);
> +	*event_flags = device->port_data[port_num].cache.port_event_flags;
> +	read_unlock_irqrestore(&device->cache_lock, flags);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(ib_get_cached_port_event_flags);
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
> +
> +	return port_num;
> +}
> +EXPORT_SYMBOL(ib_query_ndev_port_num);

This returns garbage if the netdev isn't found

> +
> +static inline enum ib_port_state get_port_state(struct net_device *netdev)
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

Lets not register a notifer for every device please, we already have
ib_device_get_by_netdev() for this purpose, and we already have global
notifiers in this module.

Jason
