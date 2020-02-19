Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3AE6165160
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 22:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgBSVHe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 16:07:34 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37650 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgBSVHe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 16:07:34 -0500
Received: by mail-qv1-f67.google.com with SMTP id s6so876645qvq.4
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 13:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OThLpFpXxsdg3wzWj6hUYtQkZOYwvVvM9gRR17m4oro=;
        b=GHQc1EiMrW8ev8e/6rpwSp1PQjJKFdcbqAaNzGws8oCBuakKCGUPTBI9M+EisHUD3g
         zpmyTf8O7w/XlEuKnP3ermtBJbYHs/LRr66Co127ukc0+/q8y7rh8d+iLediaF7bhKEq
         sUXGP9YxfSkx80TlafUJXQV8UIM+p+XaSDWWuV+cS9i26IuON7UffEgnyqw0i9Fy7jGZ
         YoF7QfwEMt8NAnpyaQeyhCJtgbocoypWaE8xRemUCvqU9IUHdxve0Vdcr481w2L456+Z
         J8LgS9kmgU3Gh5/JqsQ4noYyetVhIeOsREgcBgD47pWDE+oJeIbZyIxGVVwveTJt/R0A
         rkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OThLpFpXxsdg3wzWj6hUYtQkZOYwvVvM9gRR17m4oro=;
        b=ADSKIzd9mV0E8bifTAzbTspQ283BLtXFT4ViSkow27OUVkB1GjrbW99ut2lCknGYbv
         j/qlem+LVQrMC4OFJ41odb/621h5PF/bTIefmLxr4twdIeYTZv/a483S9steA9+42Mog
         a+Snx1nWY/KgSGkr5Z+EmoDcH7scGVbq8dRbIymHXH4PnBuEVznaihaTaE1LDF7PIwHZ
         R1zyVG58wmVDOnLXsfuoxaoIQqryZhyBiudf/+qWpOCFou/JKTHTt9fwXZbdTaR5YYmu
         Qws+AvL6HrWcEJNeJftPEyYwDCzc8nvX+RxT26NPM8VsDR9Zw2XYDi/l+hEmyIloGc1r
         6WOg==
X-Gm-Message-State: APjAAAUNkipFfhWPjvxkO9EhF/fpoIcToYdwosfdLGf/flJNLcgjlf3O
        U86vwXIb3S4AXePJ/zoRPC7C2Q==
X-Google-Smtp-Source: APXvYqxp0/tDwcoO9eGUOJYNAIdZZWf59m0qizgEJWukQT6dwsyaOaW/CEzlOYG9hyWHYb7HxFAYiQ==
X-Received: by 2002:a0c:ffc4:: with SMTP id h4mr22659092qvv.233.1582146453712;
        Wed, 19 Feb 2020 13:07:33 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id v10sm656507qtp.22.2020.02.19.13.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 13:07:33 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4WZA-00075O-Sd; Wed, 19 Feb 2020 17:07:32 -0400
Date:   Wed, 19 Feb 2020 17:07:32 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH RFC v2 for-next 6/7] RDMA/core: support send port event
Message-ID: <20200219210732.GB31668@ziepe.ca>
References: <20200204082408.18728-1-liweihang@huawei.com>
 <20200204082408.18728-7-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204082408.18728-7-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 04, 2020 at 04:24:07PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> For the process of handling the link event of the net device, the driver
> of each provider is similar, so it can be integrated into the ib_core for
> unified processing.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>  drivers/infiniband/core/device.c        |  1 +
>  drivers/infiniband/core/roce_gid_mgmt.c | 45 +++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 84dd74f..0427a4d 100644
> +++ b/drivers/infiniband/core/device.c
> @@ -2225,6 +2225,7 @@ struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
>  
>  	return res;
>  }
> +EXPORT_SYMBOL(ib_device_get_netdev);
>  
>  /**
>   * ib_device_get_by_netdev - Find an IB device associated with a netdev
> diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
> index 2860def..4170ba3 100644
> +++ b/drivers/infiniband/core/roce_gid_mgmt.c
> @@ -751,6 +751,12 @@ static int netdevice_event(struct notifier_block *this, unsigned long event,
>  	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
>  	struct netdev_event_work_cmd cmds[ROCE_NETDEV_CALLBACK_SZ] = { {NULL} };
>  
> +	enum ib_port_state last_state;
> +	enum ib_port_state curr_state;
> +	struct ib_device *device;
> +	struct ib_event ibev;
> +	unsigned int port;
> +
>  	if (ndev->type != ARPHRD_ETHER)
>  		return NOTIFY_DONE;
>  
> @@ -762,6 +768,45 @@ static int netdevice_event(struct notifier_block *this, unsigned long event,
>  		cmds[2] = add_cmd;
>  		break;
>  
> +	case NETDEV_CHANGE:
> +	case NETDEV_DOWN:
> +		device = ib_device_get_by_netdev(ndev, RDMA_DRIVER_UNKNOWN);
> +		if (!device)
> +			break;
> +
> +		rdma_for_each_port (device, port) {
> +			if (ib_device_get_netdev(device, port) != ndev)
> +				continue;

This feels strange, maybe we need to fix ib_device_get_by_netdev to
return the port too?

> +
> +			if (ib_get_cached_port_inactive_status(device, port))
> +				break;
> +
> +			ib_get_cached_port_state(device, port, &last_state);
> +			curr_state =
> +				netif_running(ndev) && netif_carrier_ok(ndev) ?
> +					IB_PORT_ACTIVE :
> +					IB_PORT_DOWN;
> +
> +			if (last_state == curr_state)
> +				break;
> +
> +			if (curr_state == IB_PORT_DOWN)
> +				ibev.event = IB_EVENT_PORT_ERR;
> +			else if (curr_state == IB_PORT_ACTIVE)
> +				ibev.event = IB_EVENT_PORT_ACTIVE;
> +			else
> +				break;

Other states are ignored?

> +
> +			ibev.device = device;
> +			ibev.element.port_num = port;
> +			ib_dispatch_event(&ibev);
> +			ibdev_dbg(ibev.device, "core send %s\n",
> +				  ib_event_msg(ibev.event));
> +		}
> +
> +		ib_device_put(device);
> +		break;

Ah the series is backwards. 

You need to organize your series so that every patch works
properly. This has to be before any drivers are removed, and you'll
need some temporary capability to disable it for drivers that have not
been migrated yet.

Jason
