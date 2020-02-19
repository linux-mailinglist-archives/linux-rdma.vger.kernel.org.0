Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F0C163F88
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 09:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgBSIoF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 03:44:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54086 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgBSIoF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 03:44:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id s10so5492002wmh.3
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 00:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ex8FiiQ+z8KcC7oDMM+ujxp30ewa0W0AOLWrFhzyxc4=;
        b=ixgEOJe+7w85nYlppBSzIjWpn7awZN9pd9ITynG2BR6+MlnzQfhpy2NoOTabg6ojAz
         +Zy/rNeyu3l0IzXRKqIvzqGBDWs2DK8noeR+HKcBZHXh6HU0otEbNIyXdnmMVuWU8VrV
         0ewSIhPDWzX8nNCa8kMOfqSGkOCWIYUhYvcK7gFKzALhAtqvKuY/q5Yry31AdEtPY1qP
         ibGBiMjNk+KW2uRcNbLZUR2kAEulslEKCIbRWcS9ASwIDT9duYPwOKUkUYybc+xwSPh8
         zPZ8KB2lI8M0Coa9ToOPUYnVdwcT7ruHuzL9suGmwK0eD/oSnp1w3gXHwGEE5N92Af9w
         w1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ex8FiiQ+z8KcC7oDMM+ujxp30ewa0W0AOLWrFhzyxc4=;
        b=GBv6pxstVL/1uANgYcx5ksOB4Wq1H7yjji89Zlt/zr2fJNNcdKD0v53u0OnMSpyI7F
         I7RI4FnzVI06i3Bfdx3Ni5q0sVV1GP6JCST2fiJMXp5iwuonCRV5OKkdCzBEEjSOas2z
         TGICuxtureQ5TMQjQDJjFfl7WAtE/uqYCxGu1/TtRXxDT4/9ggXpD4wW9wgSWXgtK3t6
         LbULx+BnRJceSHI9oKpuz+q9Zsn+7LBgICuuP+TyNaCpOJtb+qPx63IaEFXAa6Buhqil
         CjObewXJ6yZJzqXvnqnWIfKbNu5pEsdkfm7KY84KXzJJunIZOPTIE9ju4Kr02Hdp+wRC
         kxzw==
X-Gm-Message-State: APjAAAWb17mJ/FzuoSOC5fJq53+Nua/8KLVL8tMwrwi9eqE4yzjLMDp6
        PIS+mhwYJmUS4/jNdTc81cM=
X-Google-Smtp-Source: APXvYqzAIO/1vK5ZHUW5/OIT6SWASVuoYVyIqrrcyXO2YM3g8oNET+tFzYY255tFuILsDpEWmWFmDw==
X-Received: by 2002:a1c:113:: with SMTP id 19mr8819107wmb.95.1582101843525;
        Wed, 19 Feb 2020 00:44:03 -0800 (PST)
Received: from kheib-workstation ([2.53.143.129])
        by smtp.gmail.com with ESMTPSA id 59sm2158521wre.29.2020.02.19.00.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 00:44:03 -0800 (PST)
Date:   Wed, 19 Feb 2020 10:43:59 +0200
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH for-next v2] RDMA/siw: Fix setting active_{speed, width}
 attributes
Message-ID: <20200219084359.GA12296@kheib-workstation>
References: <20200218095911.26614-1-kamalheib1@gmail.com>
 <20200218165847.GA15239@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218165847.GA15239@unreal>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 18, 2020 at 06:58:47PM +0200, Leon Romanovsky wrote:
> On Tue, Feb 18, 2020 at 11:59:11AM +0200, Kamal Heib wrote:
> > Make sure to set the active_{speed, width} attributes to avoid reporting
> > the same values regardless of the underlying device.
> >
> > Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > ---
> > V2: Change rc to rv.
> > ---
> >  drivers/infiniband/sw/siw/siw_verbs.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
> > index 73485d0da907..d5390d498c61 100644
> > --- a/drivers/infiniband/sw/siw/siw_verbs.c
> > +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> > @@ -165,11 +165,12 @@ int siw_query_port(struct ib_device *base_dev, u8 port,
> >  		   struct ib_port_attr *attr)
> >  {
> >  	struct siw_device *sdev = to_siw_dev(base_dev);
> > +	int rv;
> >
> >  	memset(attr, 0, sizeof(*attr));
> 
> This line should go too. IB/core clears attr prior to call driver.
> 
> Thanks
>

This can be done in a separate patch as this patch fixes a specific issue.

Thanks,
Kamal

> >
> > -	attr->active_speed = 2;
> > -	attr->active_width = 2;
> > +	rv = ib_get_eth_speed(base_dev, port, &attr->active_speed,
> > +			 &attr->active_width);
> >  	attr->gid_tbl_len = 1;
> >  	attr->max_msg_sz = -1;
> >  	attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
> > @@ -192,7 +193,7 @@ int siw_query_port(struct ib_device *base_dev, u8 port,
> >  	 * attr->subnet_timeout = 0;
> >  	 * attr->init_type_repy = 0;
> >  	 */
> > -	return 0;
> > +	return rv;
> >  }
> >
> >  int siw_get_port_immutable(struct ib_device *base_dev, u8 port,
> > --
> > 2.21.1
> >
