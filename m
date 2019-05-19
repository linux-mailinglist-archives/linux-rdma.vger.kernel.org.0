Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E20422280B
	for <lists+linux-rdma@lfdr.de>; Sun, 19 May 2019 19:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfESRuu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 May 2019 13:50:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46939 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfESRuu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 May 2019 13:50:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id r7so11962650wrr.13
        for <linux-rdma@vger.kernel.org>; Sun, 19 May 2019 10:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=FemswvdDaC57wgshRQZajWYCE7IofynpouSTxj2rEJw=;
        b=vPeX8xXfsYBocyvaTLxwTLGobsTPnX3COO6EpaKVnObjX7FlCP7GEt8Vm6kutCvmmS
         P+wTaHl8cV9OSd2yoGI5soCD7t58yNtcPlY5eUwXI6RW/YP6Vhctur3kcsT5XxPjYLba
         h7H5dterRUDyRN2EwblJ0vGBXRjQff8sUb6RXwKwLTbiEsvYAI3bA7mV5mYvNWFRcXFs
         EGMxAOWrBqMv5LzU6FWjB54+U9TqZx3mvbOvJBF/yS81Ox2X9l2xhe5roIC+dSwiV3c/
         gd17IXz0gtk/snQZNvGXfYna6v5O02Qsy1u2HS1gtC2cPArTUPNPW2oiFRJsmC68C+V1
         QLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FemswvdDaC57wgshRQZajWYCE7IofynpouSTxj2rEJw=;
        b=YHMrJjn3Vxpy8MEN3fzX+4B3gCJWy28lpHdhlYzON/cWFLimoZfNRbcwRb31QHdChx
         nG9ocpm3KrcPybWbcdmPCEwwKfABzqbrUxJr7hJyPnBPDS4kZzGYlb37ZMyl+tylNsvA
         4An+24LWoKEzHDuaaObGUY7GCKadXhPCvPOqWfViy55q2uhLBlqcaxnNnn9YmFUNQExi
         sPGFpy4h/73SCkRs4IqF9+KWCKmar5069bbF5gndU2hkB1mspHwtIKOFc8cCD8nxjPk4
         Fd+PW3zeSx8idLTgw9kp9LKOk73qzTRDMuWuY+dDvlxvRPHdn6oThgclk0HYhMjCPweu
         EFnw==
X-Gm-Message-State: APjAAAUpjrdH6Q7A0+IbboTw0mCni+YBx6DjvG3ArqHZ8b2NHMQMVt1W
        T17dULVyq/7+Hu09t08vOQxyEw2b
X-Google-Smtp-Source: APXvYqxGMXVwlYfTyASGmoa5rswsz9LxSAzeTn3EHEvom3DF4ehcLt8l3r4757t8QEyEFfht219yQw==
X-Received: by 2002:a5d:4e09:: with SMTP id p9mr18579739wrt.218.1558260457402;
        Sun, 19 May 2019 03:07:37 -0700 (PDT)
Received: from kheib-workstation (bzq-79-181-8-139.red.bezeqint.net. [79.181.8.139])
        by smtp.gmail.com with ESMTPSA id x4sm12606412wrn.41.2019.05.19.03.07.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 19 May 2019 03:07:36 -0700 (PDT)
Message-ID: <70f95f71d1e36c29940a9eab80ac92d9943f6537.camel@gmail.com>
Subject: Re: [PATCH for-next] RDMA/providers: Simplify ib_modify_port for
 RoCE providers
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Date:   Sun, 19 May 2019 13:07:34 +0300
In-Reply-To: <20190517220118.GB14175@iweiny-DESK2.sc.intel.com>
References: <20190516105308.29450-1-kamalheib1@gmail.com>
         <20190516111607.GA22587@ziepe.ca>
         <3c53c827f287df7f46b58c7f5e2fd23207a83683.camel@gmail.com>
         <20190516113750.GB22587@ziepe.ca>
         <8f4116c03236210e3481fae7e4ff51dfbad6c980.camel@gmail.com>
         <20190516151944.GC22587@ziepe.ca>
         <20190517220118.GB14175@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 2019-05-17 at 15:01 -0700, Ira Weiny wrote:
> On Thu, May 16, 2019 at 12:19:44PM -0300, Jason Gunthorpe wrote:
> > On Thu, May 16, 2019 at 02:52:48PM +0300, Kamal Heib wrote:
> > > On Thu, 2019-05-16 at 08:37 -0300, Jason Gunthorpe wrote:
> > > > On Thu, May 16, 2019 at 02:28:40PM +0300, Kamal Heib wrote:
> > > > > On Thu, 2019-05-16 at 08:16 -0300, Jason Gunthorpe wrote:
> > > > > > On Thu, May 16, 2019 at 01:53:08PM +0300, Kamal Heib wrote:
> > > > > > > For RoCE ports the call for ib_modify_port is not
> > > > > > > meaningful,
> > > > > > > so
> > > > > > > simplify the providers of RoCE by return OK in ib_core.
> > > > > > > 
> > > > > > > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > > > > > >  drivers/infiniband/core/device.c              | 23
> > > > > > > ++++++-----
> > > > > > >  drivers/infiniband/hw/hns/hns_roce_main.c     |  7 ----
> > > > > > >  drivers/infiniband/hw/mlx4/main.c             |  8 ----
> > > > > > >  drivers/infiniband/hw/mlx5/main.c             |  6 ---
> > > > > > >  drivers/infiniband/hw/ocrdma/ocrdma_main.c    |  1 -
> > > > > > >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  6 ---
> > > > > > >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |  2 -
> > > > > > >  drivers/infiniband/hw/qedr/main.c             |  1 -
> > > > > > >  drivers/infiniband/hw/qedr/verbs.c            |  6 ---
> > > > > > >  drivers/infiniband/hw/qedr/verbs.h            |  2 -
> > > > > > >  .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  1 -
> > > > > > >  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   | 38 ---
> > > > > > > ------
> > > > > > >  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  2 -
> > > > > > >  drivers/infiniband/sw/rxe/rxe_verbs.c         | 18 ---
> > > > > > > ------
> > > > > > >  14 files changed, 14 insertions(+), 107 deletions(-)
> > > > > > 
> > > > > > We have more roce only drivers than this, why isn't
> > > > > > everything
> > > > > > changed?
> > > > > > 
> > > > > > Jason
> > > > > 
> > > > > Not all of them implements modify_port().
> > > > 
> > > > Then why didn't we just delete modify port from the other
> > > > drivers?
> > > > 
> > > > Jason
> > > 
> > > This patch is doing that for all roce drivers that implement
> > > modify
> > > port, unless you mean none-roce drivers?
> > 
> > I mean just delete it without any change to the core code.. Here we
> > are now changing some roce drivers to have a working modify_port
> > 
> > It is confusing what the intention is
> 
> I see what Jason is saying here.  If ib_modify_port() is meaningless
> then lets
> remove the call and let it return -EOPNOTSUPP.
> 

Please see below the original implementation of ib_modify_port(), if
modify_port() callback is implemented then it will be called, otherwise
for RoCE driver the return value will be "ok" and for none RoCE driver
it will be "-ENOSYS".

So, what I tried to do in this patch is to return "ok" (like how it is
done for hns, mlx4, mlx5, ocrdma, and qedr) in the ib_core instead in
the drivers, and changed rxe and vmw_pvrdma to be aligned with this
change.

int ib_modify_port(struct ib_device *device,
		   u8 port_num, int port_modify_mask,
		   struct ib_port_modify *port_modify)
{
	int rc;

	if (!rdma_is_port_valid(device, port_num))
		return -EINVAL;

	if (device->ops.modify_port)
		rc = device->ops.modify_port(device, port_num,
					     port_modify_mask,
					     port_modify);
	else
		rc = rdma_protocol_roce(device, port_num) ? 0 :
-ENOSYS;
	return rc;
}

> Returning "ok" implies that something worked.  I guess that is what
> happens
> now...
> 
> Also FWIW you are changing the return from ENOSYS to EOPNOTSUPP.  Did
> you mean
> to do that?
> 

Yes, I changed the return value to "-EOPNOTSUPP" which is the proper
return value for an unsupported option.

> Ira
> 
> > Jason

