Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C85897C2EC
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 15:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388188AbfGaNJa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 09:09:30 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46428 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388174AbfGaNJ3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Jul 2019 09:09:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so66392622qtn.13
        for <linux-rdma@vger.kernel.org>; Wed, 31 Jul 2019 06:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZFlcAXpM6xzH0eWhr4nqGXCTpxl+faS0kHADptHljXk=;
        b=PfE6v1c5fmlU2uhsDX4BXNOCi0kZ8F4E6E0zVwbT9783wLjhQeRJNuC4g7t29vUVWu
         CfYTAOdK/mMxQr1HVBTQfQ/jO8WoIP4EElHSuwReFyoVxyAUHc/MaiIqhSPs6AHvRltK
         XY0hFYfZ6O6mawTmXWqGIX86lFbdHeDddzAjaqnpMuGr7zeiXtxnwgzQEv1X3eDfOuM/
         Pv1BxqVEq0QwQHLm9gsCi2rCf8hlYnYQvPIR+j+v3Edlhc8nTbnMQSxK7lj1yKvNvAFU
         LCOiD4VXWocEOnPOFgfz09sfApH9uI0RpGEFl94PSNQEoMxQ5l/x77MKceBpGj2qOIVq
         dHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZFlcAXpM6xzH0eWhr4nqGXCTpxl+faS0kHADptHljXk=;
        b=W3etxX3ycQSjr8zPkQA1NzguQsDjHi0nVO9MBwhaXTk7J9n05xzDI8ODNKVrB8RKi5
         I7Rh1NoUJnoWTyEqtsgdW93Rlfac/OGGbxIt+nW2Fz5iKTuPian3UCjcamZbxN8E6mYP
         24G8TiK3j0m+euWJh+L1/F0TfzK9RNb+n8r3+bSyhZRFZU2nu09KBX4MrO9z/TFVeWqY
         l49xwHQd3ze5CGJNflVFO1jYxQQRwC+PJ5UFgFwpQSaKmKunJn44c6RVcvJZ78NwrUG2
         9A8zLs1yOTclu9j7WhVzsaGkSSL2w5bPcCj/A3DtqoSqZodPLeFt9a1nRUb7IFt+iC42
         H8Pw==
X-Gm-Message-State: APjAAAVSMujUil8GyPC/W4494zOclqdGvLuHgQlTOjjtYQYU0zmrzhA0
        EQXJdKTtGmhUldL9ePjwECRw8w==
X-Google-Smtp-Source: APXvYqzv9slPTXMrfCxMSpA876I3aclPEXBFnMckxx7GB2JxAwqiEbiJFdrNO9E52e3Z2CbxsCq3Jw==
X-Received: by 2002:ac8:170f:: with SMTP id w15mr83978587qtj.370.1564578568153;
        Wed, 31 Jul 2019 06:09:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 47sm39691420qtw.90.2019.07.31.06.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jul 2019 06:09:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hsoMB-0006rF-3B; Wed, 31 Jul 2019 10:09:27 -0300
Date:   Wed, 31 Jul 2019 10:09:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
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
Message-ID: <20190731130927.GF3946@ziepe.ca>
References: <20190731111503.8872-1-kamalheib1@gmail.com>
 <20190731111503.8872-4-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731111503.8872-4-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 31, 2019 at 02:15:02PM +0300, Kamal Heib wrote:
> Add support for a common iWARP query port function, the new function
> includes a common code that is used by the iWARP devices to update the
> port attributes like max_mtu, active_mtu, state, and phys_state, the
> function also includes a call for the driver-specific query_port callback
> to query the device-specific port attributes.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>  drivers/infiniband/core/device.c | 85 ++++++++++++++++++++++++++------
>  1 file changed, 71 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 9773145dee09..8db632a35a30 100644
> +++ b/drivers/infiniband/core/device.c
> @@ -1940,6 +1940,72 @@ void ib_dispatch_event(struct ib_event *event)
>  }
>  EXPORT_SYMBOL(ib_dispatch_event);
>  
> +static int __iw_query_port(struct ib_device *device,
> +			   u8 port_num,
> +			   struct ib_port_attr *port_attr)

Not sure the __ prefixes make sense here

> +{
> +	struct in_device *inetdev;
> +	struct net_device *netdev;
> +	int err;
> +
> +	memset(port_attr, 0, sizeof(*port_attr));
> +
> +	netdev = ib_device_get_netdev(device, port_num);
> +	if (!netdev)
> +		return -ENODEV;

missing dev_put(netdev)

> +	port_attr->max_mtu = IB_MTU_4096;
> +	port_attr->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
> +
> +	if (!netif_carrier_ok(netdev)) {
> +		port_attr->state = IB_PORT_DOWN;
> +		port_attr->phys_state = IB_PORT_PHYS_STATE_DISABLED;
> +	} else {
> +		inetdev = in_dev_get(netdev);
> +
> +		if (inetdev && inetdev->ifa_list) {
> +			port_attr->state = IB_PORT_ACTIVE;
> +			port_attr->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
> +			in_dev_put(inetdev);
> +		} else {
> +			port_attr->state = IB_PORT_INIT;
> +			port_attr->phys_state =
> +				IB_PORT_PHYS_STATE_PORT_CONFIGURATION_TRAINING;
> +		}
> +	}
> +
> +	err = device->ops.query_port(device, port_num, port_attr);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int __ib_query_port(struct ib_device *device,
> +			   u8 port_num,
> +			   struct ib_port_attr *port_attr)
> +{
> +	union ib_gid gid;
> +	int err;
> +
> +	memset(port_attr, 0, sizeof(*port_attr));

gid = {}

> +
> +	err = device->ops.query_port(device, port_num, port_attr);
> +	if (err || port_attr->subnet_prefix)
> +		return err;
> +
> +	if (rdma_port_get_link_layer(device, port_num) !=
> +	    IB_LINK_LAYER_INFINIBAND)
> +		return 0;
> +
> +	err = device->ops.query_gid(device, port_num, 0, &gid);
> +	if (err)
> +		return err;
> +
> +	port_attr->subnet_prefix = be64_to_cpu(gid.global.subnet_prefix);
> +	return 0;
> +}
> +
>  /**
>   * ib_query_port - Query IB port attributes
>   * @device:Device to query
> @@ -1953,26 +2019,17 @@ int ib_query_port(struct ib_device *device,
>  		  u8 port_num,
>  		  struct ib_port_attr *port_attr)
>  {
> -	union ib_gid gid;
>  	int err;
>  
>  	if (!rdma_is_port_valid(device, port_num))
>  		return -EINVAL;
>  
> -	memset(port_attr, 0, sizeof(*port_attr));
> -	err = device->ops.query_port(device, port_num, port_attr);
> -	if (err || port_attr->subnet_prefix)
> -		return err;
> -
> -	if (rdma_port_get_link_layer(device, port_num) != IB_LINK_LAYER_INFINIBAND)
> -		return 0;
> -
> -	err = device->ops.query_gid(device, port_num, 0, &gid);
> -	if (err)
> -		return err;
> +	if (rdma_node_get_transport(device->node_type) == RDMA_TRANSPORT_IWARP)
> +		err = __iw_query_port(device, port_num, port_attr);
> +	else
> +		err = __ib_query_port(device, port_num, port_attr);

Just return, no need to have err

Jason
