Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4C6DA80A
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2019 11:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408394AbfJQJJi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Oct 2019 05:09:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42823 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404200AbfJQJJi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Oct 2019 05:09:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id n14so1412278wrw.9
        for <linux-rdma@vger.kernel.org>; Thu, 17 Oct 2019 02:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3CG/30+NyvUJbSlZfOhh4lxLl3HE5sB4CEcwd6pIocQ=;
        b=DM+/TTAgjXnaamb/FcrUK4qXiOU2rT8U0195WUKUSc1VwODiLqoO/UN9piURsEP5h4
         LTIdTptlJn2AqJyp93QQbUlctEuq2QM5eWOGJ0FXA5kWegCEX9CWeyLoDDH8HOrUPMo8
         ZdT+TH/GGv5y1vaBpCNbEXAFjg0zIKiirMSG97R/jaygf20N6R6XvIJ8857LQMpcqJ1x
         BdH67Ak8lbpv5IV1XET2EqrNarTQCMZR5mRKzFmS1j1z119TS2pHzkmgLUMfGn0BUefE
         oyuPjquK/rIO08AeueH8ajlBqEiAqn9pkUxPAYl9GVNmAMNI98NnK7Zm2QGxMRHvb2xm
         lupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3CG/30+NyvUJbSlZfOhh4lxLl3HE5sB4CEcwd6pIocQ=;
        b=ASVfDbzoUA9MvNqdkebbJPpjBJI3LK5yJbH4XSdXiwfpvKJICdmRdsA3y187Qd0wg+
         Zmr8sy7nsQ39rReqae4t2dWWz+ODuMIiBPJtZzMHmhMEjUQjIepoNWmIsB3zy6voY+cx
         zj2CnwBxH0P9zdejxkHdkRTTh9pmkupm7es25pxYgvkNM1CsrMTYOQUaqxBzq8OCWHjy
         7ht1ApYZx6JuEB9WQHXDpK9f9lb1AV630V6ycxOHlkgCA4ehr29cdCF3FdQsymWlvHQw
         Sxd58R2P4lnFzmifnhpGFOrayb8iegm3aHK1GynujrZOAtYbJ0ratGYctOlMzEBM00gh
         9cDg==
X-Gm-Message-State: APjAAAV21vrzYoei+LDizi2Y8ubdaZrTYk+jxdXSDx97twcsJEZg6t1l
        j4yIa/cTcP6Xerxth6aAswjApBTN
X-Google-Smtp-Source: APXvYqxOauej6Uiy0BNc8af9v5I6Url6l0lGYXHLOdYp4Pwd06BsofoW4RGMr78LGrbETthCMyNdsw==
X-Received: by 2002:adf:a54e:: with SMTP id j14mr2194877wrb.265.1571303375359;
        Thu, 17 Oct 2019 02:09:35 -0700 (PDT)
Received: from kheib-workstation (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id f8sm1528216wmb.37.2019.10.17.02.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 02:09:34 -0700 (PDT)
Date:   Thu, 17 Oct 2019 12:09:30 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [EXT] [PATCH for-next v2 1/4] RDMA/core: Fix return code when
 modify_port isn't supported
Message-ID: <20191017090930.GA28093@kheib-workstation>
References: <20191016072234.28442-1-kamalheib1@gmail.com>
 <20191016072234.28442-2-kamalheib1@gmail.com>
 <MN2PR18MB31825843C5DFA493069485D2A1920@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB31825843C5DFA493069485D2A1920@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 16, 2019 at 08:05:49AM +0000, Michal Kalderon wrote:
> > From: Kamal Heib <kamalheib1@gmail.com>
> > Sent: Wednesday, October 16, 2019 10:23 AM
> > 
> > External Email
> > 
> > ----------------------------------------------------------------------
> > The proper return code is "-EOPNOTSUPP" when modify_port callback is not
> > supported.
> > 
> > Fixes: 61e0962d5221 ("IB: Avoid ib_modify_port() failure for RoCE devices")
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > ---
> >  drivers/infiniband/core/device.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/core/device.c
> > b/drivers/infiniband/core/device.c
> > index a667636f74bf..98a01caf7850 100644
> > --- a/drivers/infiniband/core/device.c
> > +++ b/drivers/infiniband/core/device.c
> > @@ -2397,7 +2397,7 @@ int ib_modify_port(struct ib_device *device,
> >  					     port_modify_mask,
> >  					     port_modify);
> >  	else
> > -		rc = rdma_protocol_roce(device, port_num) ? 0 : -ENOSYS;
> > +		rc = rdma_protocol_roce(device, port_num) ? 0 : -
> > EOPNOTSUPP;
> 
> This is a bit confusing, looks like for RoCE it's ok not to have a callback but for the 
> The other protocols it's required. For iWARP for example there also isn't a modify-port.
> Is there any other protocol except ib that this is relevant to ? 
> If not perhaps modify rdma_protocol_roce(..)? to rdma_protocol_ib(...)? -EOPNOTSUPP : 0?
>

Yes, I agree this is confusing.

This change was introduced by the following commit to avoid the failures
of ib_modify_port() calls from CM when the protocol is RoCE, I also see
that almost all providers that support RoCE return success from the
modify_port() callback (hns, mlx4, mlx5, ocrdma, qedr), except rxe and
vmw_pvrdma which I think they shouldn't.

So, I suggest adding a check to CM avoid calling ib_modify_port() when the
protocol is RoCE and cleanup the mess from the providers, thoughts? 

commit 61e0962d52216f2e5bab59bb055f1210e41f484f
Author: Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Wed Aug 23 01:08:07 2017 -0700

    IB: Avoid ib_modify_port() failure for RoCE devices
    
    IB CM calls ib_modify_port() irrespective of link layer. If the
    failure is returned, the mad agent gets unregistered for those
    devices. Recently, modify_port() hook was removed from some of the
    low level drivers as it was always returning success. This breaks
    rdma connection establishment over those devices.
    For ethernet devices, Qkey violation and port capabilities are not
    applicable. So returning success for RoCE when modify_port hook is
    is not implemented.
    
    Cc: Leon Romanovsky <leon@kernel.org>
    Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
    Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
    Signed-off-by: Doug Ledford <dledford@redhat.com>

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index fc6be1175183..2466ffc6362d 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1005,14 +1005,17 @@ int ib_modify_port(struct ib_device *device,
                   u8 port_num, int port_modify_mask,
                   struct ib_port_modify *port_modify)
 {
-       if (!device->modify_port)
-               return -ENOSYS;
+       int rc;
 
        if (!rdma_is_port_valid(device, port_num))
                return -EINVAL;
 
-       return device->modify_port(device, port_num, port_modify_mask,
-                                  port_modify);
+       if (device->modify_port)
+               rc = device->modify_port(device, port_num, port_modify_mask,
+                                          port_modify);
+       else
+               rc = rdma_protocol_roce(device, port_num) ? 0 : -ENOSYS;
+       return rc;
 }
 EXPORT_SYMBOL(ib_modify_port);


> 
> 
> >  	return rc;
> >  }
> >  EXPORT_SYMBOL(ib_modify_port);
> > --
> > 2.20.1
> 
