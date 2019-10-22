Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2219E0D32
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 22:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388208AbfJVUVp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 16:21:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37237 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388034AbfJVUVp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 16:21:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id f22so17409739wmc.2
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2019 13:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9KDk3rdr3y9pULGp+F8zvwa5tR8E5HcpznJLKvQ+S2o=;
        b=BIY0JDXWJp229rPdBl5gX6X9n3zxl8HPvagGXqLQpSRQSafUXWodTiodtOC6naMzi3
         KwBUUgV1/d+0N4Q26NE77iXXlmnCT2L9emKQX1nquY/IXbRuUkadMi3eKRyd275revSl
         OJc/BVmwiKtcIqYiU1G6i0FJWzza+AGcbJWerRWkLxzYSX9dYgfxXf/FX9rnXsPCQWer
         EuLS2IMIVdLOnZ1gpNgd+Pf6AYpAAkVC+CWk3cPLV2ZMfOq9VL2L6083KVBgiy06ETf/
         YTNsi/pMZCybcEA9Klq6d1tHlQ6qwl9kqsOQ78c+XisOX8FpVyzGSqHZqAe0xruseEv/
         Lrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9KDk3rdr3y9pULGp+F8zvwa5tR8E5HcpznJLKvQ+S2o=;
        b=fFZsLe93WTc2FIB/YKcmrm8sDpVFTmoEdheks4Wv4DFk1Z9piqfrJ5JBvagZd3dmJT
         em4a42mR9CtkRpZ9kgAxVQIPNXd6S4tTiqgxNYd7l5bSOzPLH3a70+wNYxszbftesULx
         HmQ3mcdZhIDHD62IpqjtatRN2DhejQU/mEOvUw4VxxuSdJR1wGSXagkUtdOCetbLVAjC
         l++DxtFni3UuIk7rocyVqgmK0lefROnRP4m5aNp0QZAD27FjPV12Ki4unDExnFz3jEH3
         9Z9/Pd/RVinDczXs2aABa/nHf8tRSlkvotMMs7TIVCSYqxtz+21W8ghNR/mO8ZsA5/5N
         guSw==
X-Gm-Message-State: APjAAAXxemIBy/jpRyZUcxjuYttOO6g9qNH/eJSh/rg+kHdXOrqcwF/E
        jFZmO76jwRBVPMmz0sqmQ90=
X-Google-Smtp-Source: APXvYqxexzi2yWOwxiDyg3JLjMTKQoEp6sDqqFd4tUJ01S1+Iy/jY0z4SY/m3oKj21lWe/ZlJ55I2Q==
X-Received: by 2002:a7b:c0ca:: with SMTP id s10mr4492197wmh.166.1571775701988;
        Tue, 22 Oct 2019 13:21:41 -0700 (PDT)
Received: from kheib-workstation (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id 26sm6948765wmf.20.2019.10.22.13.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 13:21:41 -0700 (PDT)
Date:   Tue, 22 Oct 2019 23:21:38 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>
Subject: Re: [PATCH for-next v3 1/4] RDMA/core: Fix return code when
 modify_port isn't supported
Message-ID: <20191022202138.GA25589@kheib-workstation>
References: <20191018094115.13167-1-kamalheib1@gmail.com>
 <20191018094115.13167-2-kamalheib1@gmail.com>
 <20191022192002.GF23952@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022192002.GF23952@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 22, 2019 at 04:20:02PM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 18, 2019 at 12:41:12PM +0300, Kamal Heib wrote:
> > Improving return code from ib_modify_port() by doing the following:
> > 1- Use "-EOPNOTSUPP" instead "-ENOSYS" which is the proper return code.
> > 2- Avoid confusion by return "-EOPNOTSUPP" when modify_port() isn't
> >    supplied by the provider and the protocol is IB, otherwise return
> >    success to avoid failure of the ib_modify_port() in CM layer.
> > 
> > Fixes: 61e0962d5221 ("IB: Avoid ib_modify_port() failure for RoCE devices")
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> >  drivers/infiniband/core/device.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > index a667636f74bf..626ac18dd3a7 100644
> > +++ b/drivers/infiniband/core/device.c
> > @@ -2397,7 +2397,7 @@ int ib_modify_port(struct ib_device *device,
> >  					     port_modify_mask,
> >  					     port_modify);
> >  	else
> > -		rc = rdma_protocol_roce(device, port_num) ? 0 : -ENOSYS;
> > +		rc = rdma_protocol_ib(device, port_num) ? -EOPNOTSUPP : 0;
> >  	return rc;
> 
> Oh gross, this is such an ugly hack
> 
> roce mode should allow a fake IB_PORT_CM_SUP to be manipulated and
> nothing else.
> 
> All other cases should return EOPNOTSUPP as something has gone really
> wrong
> 
> Jason

Do you mean something like the following:

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index a667636f74bf..1db97f6f5dec 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2396,8 +2396,12 @@ int ib_modify_port(struct ib_device *device,
                rc = device->ops.modify_port(device, port_num,
                                             port_modify_mask,
                                             port_modify);
+       else if (rdma_protocol_roce(device, port_num) &&
+                ((port_modify->set_port_cap_mask & IB_PORT_CM_SUP) ||
+                (port_modify->clr_port_cap_mask & IB_PORT_CM_SUP)))
+               rc = 0;
        else
-               rc = rdma_protocol_roce(device, port_num) ? 0 : -ENOSYS;
+               rc = -EOPNOTSUPP;
        return rc;
 }
 EXPORT_SYMBOL(ib_modify_port);

