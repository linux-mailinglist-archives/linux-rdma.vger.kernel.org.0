Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1A6E1E66
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 16:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405069AbfJWOk0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 10:40:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40533 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404928AbfJWOk0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 10:40:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id o49so24789981qta.7
        for <linux-rdma@vger.kernel.org>; Wed, 23 Oct 2019 07:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ofBF1YPQYX8K4+LYBRwzXFu0Row2bhTZzviN+DYJzyA=;
        b=HrgTHFv9QSc7cVT7TD8qyQW6U9v6tQ7198Ujj7tILJMTD0McW3KXYR8b3d0Ta9imzQ
         FCd4g1Qr6GD1N5JqBEW/VIUXBUqJ9T7ZWyLlkTE9+f3iIAeFuqhXLgrJXu8PAREVzTmV
         bPiO8i6LlPKMf7jsPA72keFPNWLxR75gL/u+5Ffv3ph0LSBDeAO20Hneu/bdNqG5dqUx
         OFAGKrGtSoFl2/GwN4gvBk8LWJfvNM11J/VpkeI9iLqsR4qP2N8Cn9goNQchafzpDptX
         IR169YIcIWeNZT+hkkwnt+/9DGGc+OJQzl98FfgqDN17K2d8BTst6bP8Hx0lNN+uZSyz
         pK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ofBF1YPQYX8K4+LYBRwzXFu0Row2bhTZzviN+DYJzyA=;
        b=Kxw5mYSB9W4vj0dt2DK0kbExo5xWM5mMW6Ydj2fQzBVSwbBycEm+jhbY0BZWoodt2F
         Sd3+/lYzpE+/daXz+vlrDmMJdDldBym2hmLJngrg164o+rXJJxJuzMnGcj2IBwm6mX6l
         aj0wO/ZgfFGfGFqgysyTA+Be7UorhUDkBm3TDNSQHf26ZEDf43CG+kLGdBCXrlhsPi3O
         MCxBCkW6HqwTqKnJkONsXao8qf3tYsqezYPvj+qdBGpd7j1JjXOYGDrhtkEJkauwmCq1
         HLNw/W7K3r9mFufsNZe+nbs9Yh1J5e2ODXPNLuJ5dFYNoe9t5KYrMePtUn5gDq7PxHih
         Ir4Q==
X-Gm-Message-State: APjAAAXlD3PffHFld9ONJh8bATaxt3bOORll0RGE/+hhuvz2q52RFGoL
        kUlunbVAwWx5GzTgwq2Sn0BVjw==
X-Google-Smtp-Source: APXvYqxlal6x+ij8mo3xFD7GoiOQWk1j/BjiEPpgTYaSruCL6Yt9PM+zoriFcPDHGHP6ncl7r31x0A==
X-Received: by 2002:ac8:1e13:: with SMTP id n19mr3254225qtl.384.1571841624228;
        Wed, 23 Oct 2019 07:40:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id c18sm10456441qkk.17.2019.10.23.07.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Oct 2019 07:40:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iNHoF-0003MG-0O; Wed, 23 Oct 2019 11:40:23 -0300
Date:   Wed, 23 Oct 2019 11:40:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>
Subject: Re: [PATCH for-next v3 1/4] RDMA/core: Fix return code when
 modify_port isn't supported
Message-ID: <20191023144022.GL23952@ziepe.ca>
References: <20191018094115.13167-1-kamalheib1@gmail.com>
 <20191018094115.13167-2-kamalheib1@gmail.com>
 <20191022192002.GF23952@ziepe.ca>
 <20191022202138.GA25589@kheib-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022202138.GA25589@kheib-workstation>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 22, 2019 at 11:21:38PM +0300, Kamal Heib wrote:
> On Tue, Oct 22, 2019 at 04:20:02PM -0300, Jason Gunthorpe wrote:
> > On Fri, Oct 18, 2019 at 12:41:12PM +0300, Kamal Heib wrote:
> > > Improving return code from ib_modify_port() by doing the following:
> > > 1- Use "-EOPNOTSUPP" instead "-ENOSYS" which is the proper return code.
> > > 2- Avoid confusion by return "-EOPNOTSUPP" when modify_port() isn't
> > >    supplied by the provider and the protocol is IB, otherwise return
> > >    success to avoid failure of the ib_modify_port() in CM layer.
> > > 
> > > Fixes: 61e0962d5221 ("IB: Avoid ib_modify_port() failure for RoCE devices")
> > > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > >  drivers/infiniband/core/device.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > > index a667636f74bf..626ac18dd3a7 100644
> > > +++ b/drivers/infiniband/core/device.c
> > > @@ -2397,7 +2397,7 @@ int ib_modify_port(struct ib_device *device,
> > >  					     port_modify_mask,
> > >  					     port_modify);
> > >  	else
> > > -		rc = rdma_protocol_roce(device, port_num) ? 0 : -ENOSYS;
> > > +		rc = rdma_protocol_ib(device, port_num) ? -EOPNOTSUPP : 0;
> > >  	return rc;
> > 
> > Oh gross, this is such an ugly hack
> > 
> > roce mode should allow a fake IB_PORT_CM_SUP to be manipulated and
> > nothing else.
> > 
> > All other cases should return EOPNOTSUPP as something has gone really
> > wrong
> > 
> > Jason
> 
> Do you mean something like the following:
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index a667636f74bf..1db97f6f5dec 100644
> +++ b/drivers/infiniband/core/device.c
> @@ -2396,8 +2396,12 @@ int ib_modify_port(struct ib_device *device,
>                 rc = device->ops.modify_port(device, port_num,
>                                              port_modify_mask,
>                                              port_modify);
> +       else if (rdma_protocol_roce(device, port_num) &&
> +                ((port_modify->set_port_cap_mask & IB_PORT_CM_SUP) ||
> +                (port_modify->clr_port_cap_mask & IB_PORT_CM_SUP)))

That isn't the right logic.. it is more like & ~IB_PORT_CM_SUP) == 0

Jason
