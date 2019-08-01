Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31B6E7DC75
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 15:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbfHANXG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 09:23:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35171 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730091AbfHANXG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Aug 2019 09:23:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so63150743wmg.0
        for <linux-rdma@vger.kernel.org>; Thu, 01 Aug 2019 06:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AQuHszNh2Xtp+3fxJasyokZWc/xinPfLbROtl9CzuW0=;
        b=TMNXn3G2hiVBIaj7+0P1eJbJN7/6Ai15dNL+Sf1NLNE8kDLF/nVPIA4a1NbK6XuoET
         YmROxauYp6o25qpE2sFGP+FDV4gVY7Mh1CqrWNCvlxAjpbAT6Up1+08sLCqeeKRAjeBf
         KyW9wKpLwS8fWliQIoWPzV5Q3CU6aDSDDSdANFNL2AwW0Q41nrByHvcVh8VFxb7wS4hL
         u9BAQyCUNzk2HtR0CkMbj5PXqt6O6zHVXfF2tzDnVlmbG2aw1EhzHRoUc0V/95tEYQIa
         mYMPRkAkwLwvFJuIpPGqv23z4i/Q+92+mEMhWYwzK/6cLMDYsfeaTsh/rIQbovP6PK9D
         8JfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AQuHszNh2Xtp+3fxJasyokZWc/xinPfLbROtl9CzuW0=;
        b=bJC5TATrlbFlU5YQHyJzTMIfr/9ID0lYovKRYlZF9j0R6udaE0jduOrmVbdM+9yGJE
         13A8DZa0XAwButAvYGVqyVy+x7k+ikxLYWxTh3/udHJro3h6h9LUfwhV0dsXVp2vTeYU
         q33aQAbvkTe2womJsf5F8aUNn9LtUXhzw9X9LSqFbXSCbJucgX2B5qHaTIo5deUIVyAk
         vR7mtq/Fui+7E2qtOz9zfhWVy+IG5pHI12aUK+hQ3iWUwTApFXtwDj25ZnNTsy7uQhRV
         Sz1COHmjsNqZA4o1x3V6AOMwvZJbBwPUG9e/gX5Bz8mbQiBvdBLJrycDt9J8YiHeYUv+
         nMbQ==
X-Gm-Message-State: APjAAAUjgq1k+vD02hqQhS1SpT3G+nvzBRVQHNTaVJgdNQIHyAQNh09Z
        YxfhQHMRyxMRUVH2MCCRlek=
X-Google-Smtp-Source: APXvYqyOVn/PjWm+OjztWEoM+awajQj4kYKz3TBqEh8+cYWB1euDCptLU3BG6cLZh702N9+x2t5JwQ==
X-Received: by 2002:a1c:5a56:: with SMTP id o83mr114468235wmb.103.1564665783632;
        Thu, 01 Aug 2019 06:23:03 -0700 (PDT)
Received: from kheib-workstation (bzq-109-65-15-211.red.bezeqint.net. [109.65.15.211])
        by smtp.gmail.com with ESMTPSA id g19sm84373175wmg.10.2019.08.01.06.23.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 06:23:02 -0700 (PDT)
Date:   Thu, 1 Aug 2019 16:22:58 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Moni Shoua <monis@mellanox.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next V2 3/4] RDMA/core: Add common iWARP query port
Message-ID: <20190801132258.GA23425@kheib-workstation>
References: <20190731202459.19570-1-kamalheib1@gmail.com>
 <20190731202459.19570-4-kamalheib1@gmail.com>
 <MN2PR18MB3182171DC6B1F23380A5B67EA1DE0@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB3182171DC6B1F23380A5B67EA1DE0@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 01, 2019 at 11:10:11AM +0000, Michal Kalderon wrote:
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Kamal Heib
> > 
> > Add support for a common iWARP query port function, the new function
> > includes a common code that is used by the iWARP devices to update the
> > port attributes like max_mtu, active_mtu, state, and phys_state, the
> > function also includes a call for the driver-specific query_port callback to
> > query the device-specific port attributes.
> > 
> Thanks, the qedr is also a iWARP device but it has most of the code common with
> The RoCE part, so we'll need to split the code earlier between the protocols. 

Yes, That's why I decided not to touch it.

> However, why not make the code for port-state and mtu common for Both iWARP + RoCE? 
> 

I don't think that this is a good idea because they don't share the same
code for determining the port-state and mtu (please see mlx4/mlx5 v.s.
other iWARP drivers), while it is the same code for all iWARP drivers.

> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > ---
> >  drivers/infiniband/core/device.c | 87 ++++++++++++++++++++++++++------
> >  1 file changed, 71 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/infiniband/core/device.c
> > b/drivers/infiniband/core/device.c
> > index 9773145dee09..860c08ca49e7 100644
> > --- a/drivers/infiniband/core/device.c
> > +++ b/drivers/infiniband/core/device.c
> > @@ -1940,31 +1940,64 @@ void ib_dispatch_event(struct ib_event *event)
> > }  EXPORT_SYMBOL(ib_dispatch_event);
> > 
> > -/**
> > - * ib_query_port - Query IB port attributes
> > - * @device:Device to query
> > - * @port_num:Port number to query
> > - * @port_attr:Port attributes
> > - *
> > - * ib_query_port() returns the attributes of a port through the
> > - * @port_attr pointer.
> > - */
> > -int ib_query_port(struct ib_device *device,
> > -		  u8 port_num,
> > -		  struct ib_port_attr *port_attr)
> > +static int iw_query_port(struct ib_device *device,
> > +			   u8 port_num,
> > +			   struct ib_port_attr *port_attr)
> >  {
> > -	union ib_gid gid;
> > +	struct in_device *inetdev;
> > +	struct net_device *netdev;
> >  	int err;
> > 
> > -	if (!rdma_is_port_valid(device, port_num))
> > -		return -EINVAL;
> > +	memset(port_attr, 0, sizeof(*port_attr));
> > +
> > +	netdev = ib_device_get_netdev(device, port_num);
> > +	if (!netdev)
> > +		return -ENODEV;
> > +
> > +	dev_put(netdev);
> > +
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
> > +			port_attr->phys_state =
> > IB_PORT_PHYS_STATE_LINK_UP;
> > +			in_dev_put(inetdev);
> > +		} else {
> > +			port_attr->state = IB_PORT_INIT;
> > +			port_attr->phys_state =
> > +
> > 	IB_PORT_PHYS_STATE_PORT_CONFIGURATION_TRAINING;
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
> > +	union ib_gid gid = {};
> > +	int err;
> > 
> >  	memset(port_attr, 0, sizeof(*port_attr));
> > +
> >  	err = device->ops.query_port(device, port_num, port_attr);
> >  	if (err || port_attr->subnet_prefix)
> >  		return err;
> > 
> > -	if (rdma_port_get_link_layer(device, port_num) !=
> > IB_LINK_LAYER_INFINIBAND)
> > +	if (rdma_port_get_link_layer(device, port_num) !=
> > +	    IB_LINK_LAYER_INFINIBAND)
> >  		return 0;
> > 
> >  	err = device->ops.query_gid(device, port_num, 0, &gid); @@ -1974,6
> > +2007,28 @@ int ib_query_port(struct ib_device *device,
> >  	port_attr->subnet_prefix = be64_to_cpu(gid.global.subnet_prefix);
> >  	return 0;
> >  }
> > +
> > +/**
> > + * ib_query_port - Query IB port attributes
> > + * @device:Device to query
> > + * @port_num:Port number to query
> > + * @port_attr:Port attributes
> > + *
> > + * ib_query_port() returns the attributes of a port through the
> > + * @port_attr pointer.
> > + */
> > +int ib_query_port(struct ib_device *device,
> > +		  u8 port_num,
> > +		  struct ib_port_attr *port_attr)
> > +{
> > +	if (!rdma_is_port_valid(device, port_num))
> > +		return -EINVAL;
> > +
> > +	if (rdma_node_get_transport(device->node_type) ==
> > RDMA_TRANSPORT_IWARP)
> Raising a question, in some places we use the macro above and in others
> rdma_protocol_iwarp(device, port_num), any reason to prefer one over the other ?

I thought it's more readable to use rdma_node_get_transport() in this
case than using rdma_protocol_iwarp().

>  thanks,
> 
> > +		return iw_query_port(device, port_num, port_attr);
> > +	else
> > +		return __ib_query_port(device, port_num, port_attr); }
> >  EXPORT_SYMBOL(ib_query_port);
> > 
> >  static void add_ndev_hash(struct ib_port_data *pdata)
> > --
> > 2.20.1
> 
