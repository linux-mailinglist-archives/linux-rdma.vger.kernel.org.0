Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC413D00F7
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2019 21:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfJHTKH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Oct 2019 15:10:07 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35347 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfJHTKH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Oct 2019 15:10:07 -0400
Received: by mail-qk1-f196.google.com with SMTP id w2so17882488qkf.2
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2019 12:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eSUEc5y6zHWNPhLYRap0P0BKbjireZUuxlhL7Ipm7/k=;
        b=EaUmK2gj4L7C7C8vl9vAIOOTADQT9+32vsJqoQKliWGr80xCNCYb9LC210t6T5++cP
         TC98HdW1CWjFjmOx3Ly2ZykYSrtScoSEp25puHSmmcPgL2KqJbStyc3hAX54WyiqYWBE
         hJy0LbXWjWJZSwcRdnq2N3b8HqOOQk+y+4FdwnTdPMxIqc4/Nm8otiiifk+zQFNWSVQT
         UaMZj5Z7EmF5yMBLijGjYIhuzwvxv+4JO1y1xVNcsVMzokMUN7PP9IgkSztht+wp7mPl
         0LNHZSfd4VLQricQd11yfGlHXSXjyivcMD6SBDN7gHtytBBDk/0u/OqcJMLOIp1Y4MMm
         WfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eSUEc5y6zHWNPhLYRap0P0BKbjireZUuxlhL7Ipm7/k=;
        b=p+xBMVDMWq8gnwBzD3+9lRVo9+wcqF2aRfVGdPikaa879pPGuPuaWRq0oWxZ5FvNAn
         0ObJzwS3vasXsmi1qIsmOmk9NOX/JmHp4LVAkih/DQf1RmZud5tr45siSdCgkX4XM2v7
         w/rStcIcbJptv0eq7maA555NvseYjFvzFhZBeuj2vaQ7KctaeXNZCaQEddLsNelcRj3S
         ilOepIN/XS0V2EegKmsDbZ72yiM6iTZs2Pz8uAFQm22/aE533aKYeAlT/znLTnim1ewd
         kZg4jXp8FkNyLXMYPLrVzxbT8/f54rwxV9SF/BOJxJCJVlN/mP3cGY5hkviIdQo+5o/j
         kzcQ==
X-Gm-Message-State: APjAAAUCRbM6bq6daX2DyjN4qMEFGn93YUP5yfPhwJtrKEPigCzbn+pW
        1VMX3EJkYQxX4Hxy+gEHdN25+sZMNXc=
X-Google-Smtp-Source: APXvYqyPfvY4HhVaYhKA37ZlAfE8Y33BQu0XUwUY5p0EbziGCZgi6vG0eZ/d6Un+jLS7fUyKi/xbOw==
X-Received: by 2002:a37:6789:: with SMTP id b131mr2764721qkc.314.1570561806355;
        Tue, 08 Oct 2019 12:10:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id q5sm12615683qte.38.2019.10.08.12.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 12:10:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iHus1-0003Xq-3n; Tue, 08 Oct 2019 16:10:05 -0300
Date:   Tue, 8 Oct 2019 16:10:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/cma: Honor traffic class from lower
 netdevice for RoCE
Message-ID: <20191008191005.GA13576@ziepe.ca>
References: <20191002121959.17444-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002121959.17444-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Wed, Oct 02, 2019 at 03:19:59PM +0300, Leon Romanovsky wrote:
> From: Parav Pandit <parav@mellanox.com>
> 
> When macvlan netdevice is used for RoCE, consider the tos->prio->tc
> mapping as SL using its lower netdevice.
> 1. If lower netdevice is VLAN netdevice, consider such VLAN netdevice
> and it's parent netdevice for mapping
> 2. If lower netdevice is not a VLAN netdevice, consider tc mapping
> directly from such lower netdevice
> 
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/cma.c | 59 +++++++++++++++++++++++++++++------
>  1 file changed, 50 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 0e3cf3461999..18b5ad8c7d5f 100644
> +++ b/drivers/infiniband/core/cma.c
> @@ -2827,22 +2827,63 @@ static int cma_resolve_iw_route(struct rdma_id_private *id_priv)
>  	return 0;
>  }
>  
> -static int iboe_tos_to_sl(struct net_device *ndev, int tos)
> +static int get_vlan_ndev_tc(struct net_device *vlan_ndev, int prio)
>  {
> -	int prio;
>  	struct net_device *dev;
>  
> -	prio = rt_tos2priority(tos);
> -	dev = is_vlan_dev(ndev) ? vlan_dev_real_dev(ndev) : ndev;
> +	dev = vlan_dev_real_dev(vlan_ndev);
>  	if (dev->num_tc)
>  		return netdev_get_prio_tc_map(dev, prio);
>  
> -#if IS_ENABLED(CONFIG_VLAN_8021Q)
> +	return (vlan_dev_get_egress_qos_mask(vlan_ndev, prio) &
> +		VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
> +}
> +
> +struct iboe_prio_tc_map {
> +	int input_prio;
> +	int output_tc;
> +	bool found;
> +};
> +
> +static int get_lower_vlan_dev_tc(struct net_device *dev, void *data)
> +{
> +	struct iboe_prio_tc_map *map = data;
> +
> +	if (is_vlan_dev(dev))
> +		map->output_tc = get_vlan_ndev_tc(dev, map->input_prio);
> +	else if (dev->num_tc)
> +		map->output_tc = netdev_get_prio_tc_map(dev, map->input_prio);
> +	else
> +		map->output_tc = 0;
> +	/* We are interested only in first level VLAN device, so always
> +	 * return 1 to stop iterating over next level devices.
> +	 */
> +	map->found = true;
> +	return 1;
> +}
> +
> +static int iboe_tos_to_sl(struct net_device *ndev, int tos)
> +{
> +	struct iboe_prio_tc_map prio_tc_map = {};
> +	int prio = rt_tos2priority(tos);
> +
> +	/* If VLAN device, get it directly from the VLAN netdev */
>  	if (is_vlan_dev(ndev))
> -		return (vlan_dev_get_egress_qos_mask(ndev, prio) &
> -			VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
> -#endif
> -	return 0;
> +		return get_vlan_ndev_tc(ndev, prio);
> +
> +	prio_tc_map.input_prio = prio;
> +	netdev_walk_all_lower_dev_rcu(ndev,
> +				      get_lower_vlan_dev_tc,
> +				      &prio_tc_map);

Kinda looks like you have to hold rcu before calling this?

Jason
