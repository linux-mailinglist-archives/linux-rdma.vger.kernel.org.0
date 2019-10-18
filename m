Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B560DC0A3
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 11:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633049AbfJRJMV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 05:12:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41525 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390299AbfJRJMV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Oct 2019 05:12:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id p4so5381273wrm.8
        for <linux-rdma@vger.kernel.org>; Fri, 18 Oct 2019 02:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pQzmU8+xk+35I+JF+LJX3jGfizjZS+sisr4S9g769r4=;
        b=Kw6Ib2/DD5YD7AzNpTkeeM/l4tk2OcIHK6MZ/whSd9LOsd1gCkKm6GnVRlJG28oB84
         DbbOrT/QhYT41WxHqi19OUpzwCAmQqbAXXKA0vPcBCFgEwFtRKiZCZp8VdDDqV/mcROZ
         uC/YGNU17BJuU4zRmqOtiVR3BktZohYIxKBUjvkvRVp5z1VE9tDCDvJNvbNdUVIe8mbR
         nTxJl04GOaxpb3G+gVSMEjGFpyYHzKjq9uLlnPLjpu/xt60/2wHDDAbG3Q4fc1YawH5T
         5RMX7xxPs69A8YG2tty+a4KlDSkGxdfmejjd9wc1Fxl7eAWnfrmbeJnhtfsj2UEkwh3K
         7FTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pQzmU8+xk+35I+JF+LJX3jGfizjZS+sisr4S9g769r4=;
        b=I4NO5HCBS3dfRfEhF0bmmaJel4NriJhsmqP7BJA5YbetIHossKfJOd0AVtLxi6Hpyh
         tDYuFEeZ66eAYNK3lS9OakAJxDrbHK88RWKnF95IhkAHEitg1Hq4tNy/V2wVbgQ/THsg
         keBjo9xOQJKB4PelaNWUGJHdCn+y/w33kadMhkkNOtdwKWhme3DXem6CHaafuIQvty/D
         7Bt2830On8pVPx7KHSL3FGXCRDgzQ6MMgJX99pcg/my4gKSvSGyCHvsjbdBrwraG8MhQ
         cKPoOhYF6Jli606nM9WG1Aa56Jz+tyS9mddd9hcVNJLjhcZTqnwh0qFIoE6oJmdCcyYK
         R3Rg==
X-Gm-Message-State: APjAAAUpiiSElh/zP7JrHutIlp1iFX01QvpLpefCooEYMlJbRfWOkJN1
        XcJO+4wOFK2qftldFzIUgwGaM4Kc
X-Google-Smtp-Source: APXvYqwQ64f1qdT/Yjjv7kMihF2aICxvXmF2U3/o+95nnoMdyM9U8lwYT3++grcJgvEus6iNrQa87Q==
X-Received: by 2002:adf:f0cc:: with SMTP id x12mr6907588wro.326.1571389937907;
        Fri, 18 Oct 2019 02:12:17 -0700 (PDT)
Received: from kheib-workstation (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id r2sm4767614wrm.3.2019.10.18.02.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 02:12:17 -0700 (PDT)
Date:   Fri, 18 Oct 2019 12:12:13 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [EXT] [PATCH for-next v2 1/4] RDMA/core: Fix return code when
 modify_port isn't supported
Message-ID: <20191018091213.GA9641@kheib-workstation>
References: <20191016072234.28442-1-kamalheib1@gmail.com>
 <20191016072234.28442-2-kamalheib1@gmail.com>
 <MN2PR18MB31825843C5DFA493069485D2A1920@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20191017090930.GA28093@kheib-workstation>
 <MN2PR18MB3182B29937262A44C8452CD4A16D0@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB3182B29937262A44C8452CD4A16D0@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 17, 2019 at 09:14:53AM +0000, Michal Kalderon wrote:
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Kamal Heib
> > 
> > On Wed, Oct 16, 2019 at 08:05:49AM +0000, Michal Kalderon wrote:
> > > > From: Kamal Heib <kamalheib1@gmail.com>
> > > > Sent: Wednesday, October 16, 2019 10:23 AM
> > > >
> > > > External Email
> > > >
> > > > --------------------------------------------------------------------
> > > > -- The proper return code is "-EOPNOTSUPP" when modify_port callback
> > > > is not supported.
> > > >
> > > > Fixes: 61e0962d5221 ("IB: Avoid ib_modify_port() failure for RoCE
> > > > devices")
> > > > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > > > ---
> > > >  drivers/infiniband/core/device.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/infiniband/core/device.c
> > > > b/drivers/infiniband/core/device.c
> > > > index a667636f74bf..98a01caf7850 100644
> > > > --- a/drivers/infiniband/core/device.c
> > > > +++ b/drivers/infiniband/core/device.c
> > > > @@ -2397,7 +2397,7 @@ int ib_modify_port(struct ib_device *device,
> > > >  					     port_modify_mask,
> > > >  					     port_modify);
> > > >  	else
> > > > -		rc = rdma_protocol_roce(device, port_num) ? 0 : -ENOSYS;
> > > > +		rc = rdma_protocol_roce(device, port_num) ? 0 : -
> > > > EOPNOTSUPP;
> > >
> > > This is a bit confusing, looks like for RoCE it's ok not to have a
> > > callback but for the The other protocols it's required. For iWARP for
> > example there also isn't a modify-port.
> > > Is there any other protocol except ib that this is relevant to ?
> > > If not perhaps modify rdma_protocol_roce(..)? to rdma_protocol_ib(...)? -
> > EOPNOTSUPP : 0?
> > >
> > 
> > Yes, I agree this is confusing.
> > 
> > This change was introduced by the following commit to avoid the failures of
> > ib_modify_port() calls from CM when the protocol is RoCE, I also see that
> > almost all providers that support RoCE return success from the
> > modify_port() callback (hns, mlx4, mlx5, ocrdma, qedr), except rxe and
> > vmw_pvrdma which I think they shouldn't.
> > 
> > So, I suggest adding a check to CM avoid calling ib_modify_port() when the
> > protocol is RoCE and cleanup the mess from the providers, thoughts?
> I think we can leave the logic inside the function ib_modify_port, and just return
> Success if the protocol isn't IB. 
>

OK, I'll fix it in v3.

> > 
> > commit 61e0962d52216f2e5bab59bb055f1210e41f484f
> > Author: Selvin Xavier <selvin.xavier@broadcom.com>
> > Date:   Wed Aug 23 01:08:07 2017 -0700
> > 
> >     IB: Avoid ib_modify_port() failure for RoCE devices
> > 
> >     IB CM calls ib_modify_port() irrespective of link layer. If the
> >     failure is returned, the mad agent gets unregistered for those
> >     devices. Recently, modify_port() hook was removed from some of the
> >     low level drivers as it was always returning success. This breaks
> >     rdma connection establishment over those devices.
> >     For ethernet devices, Qkey violation and port capabilities are not
> >     applicable. So returning success for RoCE when modify_port hook is
> >     is not implemented.
> > 
> >     Cc: Leon Romanovsky <leon@kernel.org>
> >     Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> >     Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> >     Signed-off-by: Doug Ledford <dledford@redhat.com>
> > 
> > diff --git a/drivers/infiniband/core/device.c
> > b/drivers/infiniband/core/device.c
> > index fc6be1175183..2466ffc6362d 100644
> > --- a/drivers/infiniband/core/device.c
> > +++ b/drivers/infiniband/core/device.c
> > @@ -1005,14 +1005,17 @@ int ib_modify_port(struct ib_device *device,
> >                    u8 port_num, int port_modify_mask,
> >                    struct ib_port_modify *port_modify)  {
> > -       if (!device->modify_port)
> > -               return -ENOSYS;
> > +       int rc;
> > 
> >         if (!rdma_is_port_valid(device, port_num))
> >                 return -EINVAL;
> > 
> > -       return device->modify_port(device, port_num, port_modify_mask,
> > -                                  port_modify);
> > +       if (device->modify_port)
> > +               rc = device->modify_port(device, port_num, port_modify_mask,
> > +                                          port_modify);
> > +       else
> > +               rc = rdma_protocol_roce(device, port_num) ? 0 : -ENOSYS;
> > +       return rc;
> >  }
> >  EXPORT_SYMBOL(ib_modify_port);
> > 
> > 
> > >
> > >
> > > >  	return rc;
> > > >  }
> > > >  EXPORT_SYMBOL(ib_modify_port);
> > > > --
> > > > 2.20.1
> > >
