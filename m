Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E29A7C381
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 15:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfGaN3o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 09:29:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40005 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388206AbfGaN3h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Jul 2019 09:29:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so59865137wmj.5
        for <linux-rdma@vger.kernel.org>; Wed, 31 Jul 2019 06:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c47Z1TY2KR18WtxPywsw9i3nKkDlcVu4CTaVaj0aRoM=;
        b=LYC5zntICfIo5OeXsjMBihDIf6ukI3nGeT0vj1ZYFOZcD3zcSLymnrrMyVtYaoCvmb
         JWCyWNKRGMoXTS0jqux1T/JR7fBVvwXss6dh28Ux8QYprO7lDNdeZAr9WsN5JUnLBY8/
         W8LSYLe7gw7WtDPkNl4kGycEIh+aTvF9fmP/TjH5cmL9aTxRkXGBnSBNZvHxccnXGZr2
         nFzQO+oxb+FYQkfSra+qgAhutCPV5DXPTFQ/FjDRMgtLoKN1acyPbmIXlL6OWBEMAXvM
         qKEZk00izlL4paNhGVT0x9jWRRGATiR+blNPv+NhBqpOkefcMosWiX6Gat7ok9oi2GvG
         2MeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c47Z1TY2KR18WtxPywsw9i3nKkDlcVu4CTaVaj0aRoM=;
        b=sJqAYvmjGNZqUVf6rI2X92VHWTTy1nC0sBnaAodCZoI95x7Q2a84vPjAnjrVXl1FB5
         4fMl9EspHW019CoKlBQF4ZKWvNi285ofPXtbuBnleuNN65Cu8JO+QKiH8VhgcG8Bre1C
         TLmQbn8nSMpsSm9AKpurU5BxBkXT4xjJWjipUrqdArl2MkhU6NQsEXb/gCURO9zC9HAF
         mP+LStozrn7FgIaJBrDoosTk1yDLkWHjk6kkRNehtiDMNr7MACnhmedPXpuK+ge4nUcv
         giX1e9Wb2LJHUPJ3i/6RhhMZRQKXLHLFkDK1KqKnUBCZ5KehCO2izcx0NtvAs/TqjM4c
         5ksA==
X-Gm-Message-State: APjAAAWffOf6fgpaL61mG6KL5qkImHtcDFAD5wIk/MhczyqkrFYDEv6T
        9YoYYcnPuLINYWLgN6Xd2W0=
X-Google-Smtp-Source: APXvYqyrrUpS4MyRtCTqxpTBvIy7jlVNZv10baSkK7Dcrdr8EVV6167AtCpIYikiXSE87DrTHrj7/A==
X-Received: by 2002:a1c:cb43:: with SMTP id b64mr112986656wmg.86.1564579775091;
        Wed, 31 Jul 2019 06:29:35 -0700 (PDT)
Received: from kheib-workstation (bzq-109-65-15-211.red.bezeqint.net. [109.65.15.211])
        by smtp.gmail.com with ESMTPSA id t13sm82588536wrr.0.2019.07.31.06.29.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 06:29:34 -0700 (PDT)
Date:   Wed, 31 Jul 2019 16:29:30 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Moni Shoua <monis@mellanox.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next 3/4] RDMA/core: Add common iWARP query port
Message-ID: <20190731132930.GA11198@kheib-workstation>
References: <20190731111503.8872-1-kamalheib1@gmail.com>
 <20190731111503.8872-4-kamalheib1@gmail.com>
 <20190731130927.GF3946@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731130927.GF3946@ziepe.ca>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 31, 2019 at 10:09:27AM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 31, 2019 at 02:15:02PM +0300, Kamal Heib wrote:
> > Add support for a common iWARP query port function, the new function
> > includes a common code that is used by the iWARP devices to update the
> > port attributes like max_mtu, active_mtu, state, and phys_state, the
> > function also includes a call for the driver-specific query_port callback
> > to query the device-specific port attributes.
> > 
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> >  drivers/infiniband/core/device.c | 85 ++++++++++++++++++++++++++------
> >  1 file changed, 71 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > index 9773145dee09..8db632a35a30 100644
> > +++ b/drivers/infiniband/core/device.c
> > @@ -1940,6 +1940,72 @@ void ib_dispatch_event(struct ib_event *event)
> >  }
> >  EXPORT_SYMBOL(ib_dispatch_event);
> >  
> > +static int __iw_query_port(struct ib_device *device,
> > +			   u8 port_num,
> > +			   struct ib_port_attr *port_attr)
> 
> Not sure the __ prefixes make sense here
>
OK, I'll remove it in v2.

> > +{
> > +	struct in_device *inetdev;
> > +	struct net_device *netdev;
> > +	int err;
> > +
> > +	memset(port_attr, 0, sizeof(*port_attr));
> > +
> > +	netdev = ib_device_get_netdev(device, port_num);
> > +	if (!netdev)
> > +		return -ENODEV;
> 
> missing dev_put(netdev)
> 

My bad, I'll fix it in v2.

> > +	port_attr->max_mtu = IB_MTU_4096;
> > +	port_attr->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
> > +
> > +	if (!netif_carrier_ok(netdev)) {
> > +		port_attr->state = IB_PORT_DOWN;
> > +		port_attr->phys_state = IB_PORT_PHYS_STATE_DISABLED;
> > +	} else {
> > +		inetdev = in_dev_get(netdev);
> > +
> > +		if (inetdev && inetdev->ifa_list) {
> > +			port_attr->state = IB_PORT_ACTIVE;
> > +			port_attr->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
> > +			in_dev_put(inetdev);
> > +		} else {
> > +			port_attr->state = IB_PORT_INIT;
> > +			port_attr->phys_state =
> > +				IB_PORT_PHYS_STATE_PORT_CONFIGURATION_TRAINING;
> > +		}
> > +	}
> > +
> > +	err = device->ops.query_port(device, port_num, port_attr);
> > +	if (err)
> > +		return err;
> > +
> > +	return 0;
> > +}
> > +
> > +static int __ib_query_port(struct ib_device *device,
> > +			   u8 port_num,
> > +			   struct ib_port_attr *port_attr)
> > +{
> > +	union ib_gid gid;
> > +	int err;
> > +
> > +	memset(port_attr, 0, sizeof(*port_attr));
> 
> gid = {}
>
I'll fix it in v2.

> > +
> > +	err = device->ops.query_port(device, port_num, port_attr);
> > +	if (err || port_attr->subnet_prefix)
> > +		return err;
> > +
> > +	if (rdma_port_get_link_layer(device, port_num) !=
> > +	    IB_LINK_LAYER_INFINIBAND)
> > +		return 0;
> > +
> > +	err = device->ops.query_gid(device, port_num, 0, &gid);
> > +	if (err)
> > +		return err;
> > +
> > +	port_attr->subnet_prefix = be64_to_cpu(gid.global.subnet_prefix);
> > +	return 0;
> > +}
> > +
> >  /**
> >   * ib_query_port - Query IB port attributes
> >   * @device:Device to query
> > @@ -1953,26 +2019,17 @@ int ib_query_port(struct ib_device *device,
> >  		  u8 port_num,
> >  		  struct ib_port_attr *port_attr)
> >  {
> > -	union ib_gid gid;
> >  	int err;
> >  
> >  	if (!rdma_is_port_valid(device, port_num))
> >  		return -EINVAL;
> >  
> > -	memset(port_attr, 0, sizeof(*port_attr));
> > -	err = device->ops.query_port(device, port_num, port_attr);
> > -	if (err || port_attr->subnet_prefix)
> > -		return err;
> > -
> > -	if (rdma_port_get_link_layer(device, port_num) != IB_LINK_LAYER_INFINIBAND)
> > -		return 0;
> > -
> > -	err = device->ops.query_gid(device, port_num, 0, &gid);
> > -	if (err)
> > -		return err;
> > +	if (rdma_node_get_transport(device->node_type) == RDMA_TRANSPORT_IWARP)
> > +		err = __iw_query_port(device, port_num, port_attr);
> > +	else
> > +		err = __ib_query_port(device, port_num, port_attr);
> 
> Just return, no need to have err
> 
I'll fix it in v2.

> Jason

Thanks for your review.
