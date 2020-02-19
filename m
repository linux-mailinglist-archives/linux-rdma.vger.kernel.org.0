Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C983164161
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 11:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgBSKVR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 05:21:17 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38960 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgBSKVQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 05:21:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so6133755wme.4
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 02:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IHgDBQdHw6HC5/n92AkobR3+jZh8V+sXKQ7AVEV0VFM=;
        b=oDj+nApIh/BISHFBn40BAdFZAYDg6uK/UQse9LgXgchKebJoBb+E0I7DuMpx55ez3z
         hTZnu3CaYZqXKDz+SRnGOmv8Hwgoj53//NS/LtD59z+0oMjQwRT0cylhCid/3zDnKH8j
         TYPRCM+Qr3WWKjj0U/uSW8MzKQvXMoB/syGseHP7rzEkFFsHP1J15sirrxGnQMpA+0U0
         lb9oDfIU3hDG4T6oTWEfuvvV/sUEBXTpxw5+xnksHQN6OFKKD/DOULGTuOLM6Rfg2TLv
         tSeB24S6rJoUmDqS+9S2TizWN3t0sH9mSOCrXIMBr9/04reM8T+xteV74s9uE+btbmPp
         Xc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IHgDBQdHw6HC5/n92AkobR3+jZh8V+sXKQ7AVEV0VFM=;
        b=gX55IvrkPLBDHyzw/75pPuv3Aq09+tqUDGCkS+ZyN4NWIgWZUM8nSIo3Imt0teJup2
         Se9XOPOJfHYuoqG0SI4I3mIDkWCiQyEpqhDEXK+a/WY88RHXTtbnRcRYhgq5WsDAdRsb
         sihBlxr0ibuuAf0jS8TWkAgL+QbKbQXowRixj2g5AbztszyP64kRinUJrFTEFjxDj5ov
         JCNQQ2tSFJbTdWqqEdrgb2nzBfQ9wbe7TZ4qaiiua62eS2WGtTWqelfHThBi78NzeicP
         0mSTknIjWC7myUvfvwP+pa9z9dWiM0MMiT1rifrgXeGyjljrUvgPGpmIvurRFq3AHt57
         gQ3g==
X-Gm-Message-State: APjAAAUq+IXDTm63+NeAfLhZ3hLL4MD02rMzUD/HdPMKrprjNv5UVk2w
        2VO7amp9QqmwZ5I3AOcJvCisV5CH2dA=
X-Google-Smtp-Source: APXvYqwq8zaweunZmlygPRO3qTPgdRsdbA9nFtwPfWjcFPF9nuvFlWlXckVSo91vfMfwXfRJxrAY6w==
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr8862276wmh.164.1582107674219;
        Wed, 19 Feb 2020 02:21:14 -0800 (PST)
Received: from kheib-workstation (bzq-109-65-128-51.red.bezeqint.net. [109.65.128.51])
        by smtp.gmail.com with ESMTPSA id z133sm2510455wmb.7.2020.02.19.02.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 02:21:13 -0800 (PST)
Date:   Wed, 19 Feb 2020 12:21:10 +0200
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH for-next v2] RDMA/siw: Fix setting active_{speed, width}
 attributes
Message-ID: <20200219102110.GA13582@kheib-workstation>
References: <20200218095911.26614-1-kamalheib1@gmail.com>
 <20200218165847.GA15239@unreal>
 <20200219084359.GA12296@kheib-workstation>
 <20200219093321.GI15239@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219093321.GI15239@unreal>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 19, 2020 at 11:33:21AM +0200, Leon Romanovsky wrote:
> On Wed, Feb 19, 2020 at 10:43:59AM +0200, Kamal Heib wrote:
> > On Tue, Feb 18, 2020 at 06:58:47PM +0200, Leon Romanovsky wrote:
> > > On Tue, Feb 18, 2020 at 11:59:11AM +0200, Kamal Heib wrote:
> > > > Make sure to set the active_{speed, width} attributes to avoid reporting
> > > > the same values regardless of the underlying device.
> > > >
> > > > Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> > > > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > > > ---
> > > > V2: Change rc to rv.
> > > > ---
> > > >  drivers/infiniband/sw/siw/siw_verbs.c | 7 ++++---
> > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
> > > > index 73485d0da907..d5390d498c61 100644
> > > > --- a/drivers/infiniband/sw/siw/siw_verbs.c
> > > > +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> > > > @@ -165,11 +165,12 @@ int siw_query_port(struct ib_device *base_dev, u8 port,
> > > >  		   struct ib_port_attr *attr)
> > > >  {
> > > >  	struct siw_device *sdev = to_siw_dev(base_dev);
> > > > +	int rv;
> > > >
> > > >  	memset(attr, 0, sizeof(*attr));
> > >
> > > This line should go too. IB/core clears attr prior to call driver.
> > >
> > > Thanks
> > >
> >
> > This can be done in a separate patch as this patch fixes a specific issue.
> 
> Whatever works for you, if you don't value your own time, go for it,
> do separate patch for every line you are changing. It just looks crazy
> to see changes like this:
>  * changed line
>  * line to be changed, but not changed
>  * another changed line
> 
> Thanks
>

Leon, With all my respect, This isn't your decision what I do and when.

W.R.T your suggestion for removing the memset() line, there are multiple
places in the siw drivers that do memset in the ib_device_ops, with that
said, I think that this need to be done in a separate patch. BTW you can
do the change too ;)

Thanks,
Kamal

> >
> > Thanks,
> > Kamal
> >
> > > >
> > > > -	attr->active_speed = 2;
> > > > -	attr->active_width = 2;
> > > > +	rv = ib_get_eth_speed(base_dev, port, &attr->active_speed,
> > > > +			 &attr->active_width);
> > > >  	attr->gid_tbl_len = 1;
> > > >  	attr->max_msg_sz = -1;
> > > >  	attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
> > > > @@ -192,7 +193,7 @@ int siw_query_port(struct ib_device *base_dev, u8 port,
> > > >  	 * attr->subnet_timeout = 0;
> > > >  	 * attr->init_type_repy = 0;
> > > >  	 */
> > > > -	return 0;
> > > > +	return rv;
> > > >  }
> > > >
> > > >  int siw_get_port_immutable(struct ib_device *base_dev, u8 port,
> > > > --
> > > > 2.21.1
> > > >
