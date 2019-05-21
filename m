Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7247C25797
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 20:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfEUSaI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 14:30:08 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39744 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbfEUSaI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 14:30:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id y42so21701195qtk.6
        for <linux-rdma@vger.kernel.org>; Tue, 21 May 2019 11:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vxRXMql9RCC2/75Ytw9iy7NyXM0lmf724vGo7xYhaYE=;
        b=A3KgT73uml7AQoXGLSqkQLU6rH599MT/Ans3CCrS+lheh8dWbc31etBh2Q/PFubjPx
         aQDEknvE/omdUmjKQhaxu3Ta742BcpdLAkISjk+8lCCfP8BnZlj19J8Mzhv7/VyiLh4k
         UJJRpk/Y+ypBqSgfmisViK6zz5xPqnloJDe15DJ0rwqiD1baxNG9IWK6B3Wo4M96xNWz
         cHbmGzhTIpw1tlNaK2i577WNlCe17OVpfpd7GZzS8X9ERxeI0LTe7/kEZxUK9RGdNa81
         UsBxmA7Idu5OtlBtMXy7TiUKjGEdR1HsnJL7xEAv/gMH3dM0eY9Z2T3U4rsSYa39yuaH
         ChHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vxRXMql9RCC2/75Ytw9iy7NyXM0lmf724vGo7xYhaYE=;
        b=q9i4HJxWPuOPFPY9bAwDXNfngAbo3ismaz8Io2dDNPUAf+jX3V74RQdGnkS9V8LLU4
         eQtNBeMo0qF3rK7V2FWOX2cnFegUcuP5OLqlTAFbKUl/NIgpTfjl2GRgGD80Bfy4qYdb
         jo7ccmGX7YvE+AlX2LNoJoKC7Vj6ZMiQbBh03JqDR+65+kMrWVuaJdh9vXS5ZNc6h75C
         2zvkf5HPVP928Pv4EoUmGiNvff3FP4VR1bqfPh5w/CgSNzY7qeyja954HBiwq5F0idzb
         b4Y5tVA023V9xtt80+B4ivt67CMaf3xBIrG4XJ/1oQj4A/FG9b/7302bChPPV9OJuKeL
         hlpQ==
X-Gm-Message-State: APjAAAVIs29BJr5EIjdwMg/yhOC2ujPuhN8EHLho9KSmuJcSpJhNDu/m
        0nxmjyaxYBXeBOXSh6fGhCzYqQ==
X-Google-Smtp-Source: APXvYqx9/jxCS3fWfQM5s8LppSdhenJZ3jvZYNOxIWuj4cQsyN7gABkHnvkvITM8dlNfWpEQMDw+ag==
X-Received: by 2002:ac8:43c2:: with SMTP id w2mr69872442qtn.274.1558463406901;
        Tue, 21 May 2019 11:30:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id d85sm11158396qkc.64.2019.05.21.11.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 11:30:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hT9WX-00049g-KG; Tue, 21 May 2019 15:30:05 -0300
Date:   Tue, 21 May 2019 15:30:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/providers: Simplify ib_modify_port for
 RoCE providers
Message-ID: <20190521183005.GB2922@ziepe.ca>
References: <20190516105308.29450-1-kamalheib1@gmail.com>
 <20190516111607.GA22587@ziepe.ca>
 <3c53c827f287df7f46b58c7f5e2fd23207a83683.camel@gmail.com>
 <20190516113750.GB22587@ziepe.ca>
 <8f4116c03236210e3481fae7e4ff51dfbad6c980.camel@gmail.com>
 <20190516151944.GC22587@ziepe.ca>
 <20190517220118.GB14175@iweiny-DESK2.sc.intel.com>
 <70f95f71d1e36c29940a9eab80ac92d9943f6537.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70f95f71d1e36c29940a9eab80ac92d9943f6537.camel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 19, 2019 at 01:07:34PM +0300, Kamal Heib wrote:
> On Fri, 2019-05-17 at 15:01 -0700, Ira Weiny wrote:
> > On Thu, May 16, 2019 at 12:19:44PM -0300, Jason Gunthorpe wrote:
> > > On Thu, May 16, 2019 at 02:52:48PM +0300, Kamal Heib wrote:
> > > > On Thu, 2019-05-16 at 08:37 -0300, Jason Gunthorpe wrote:
> > > > > On Thu, May 16, 2019 at 02:28:40PM +0300, Kamal Heib wrote:
> > > > > > On Thu, 2019-05-16 at 08:16 -0300, Jason Gunthorpe wrote:
> > > > > > > On Thu, May 16, 2019 at 01:53:08PM +0300, Kamal Heib wrote:
> > > > > > > > For RoCE ports the call for ib_modify_port is not
> > > > > > > > meaningful,
> > > > > > > > so
> > > > > > > > simplify the providers of RoCE by return OK in ib_core.
> > > > > > > > 
> > > > > > > > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > > > > > > >  drivers/infiniband/core/device.c              | 23
> > > > > > > > ++++++-----
> > > > > > > >  drivers/infiniband/hw/hns/hns_roce_main.c     |  7 ----
> > > > > > > >  drivers/infiniband/hw/mlx4/main.c             |  8 ----
> > > > > > > >  drivers/infiniband/hw/mlx5/main.c             |  6 ---
> > > > > > > >  drivers/infiniband/hw/ocrdma/ocrdma_main.c    |  1 -
> > > > > > > >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  6 ---
> > > > > > > >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |  2 -
> > > > > > > >  drivers/infiniband/hw/qedr/main.c             |  1 -
> > > > > > > >  drivers/infiniband/hw/qedr/verbs.c            |  6 ---
> > > > > > > >  drivers/infiniband/hw/qedr/verbs.h            |  2 -
> > > > > > > >  .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  1 -
> > > > > > > >  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   | 38 ---
> > > > > > > >  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  2 -
> > > > > > > >  drivers/infiniband/sw/rxe/rxe_verbs.c         | 18 ---
> > > > > > > >  14 files changed, 14 insertions(+), 107 deletions(-)
> > > > > > > 
> > > > > > > We have more roce only drivers than this, why isn't
> > > > > > > everything
> > > > > > > changed?
> > > > > > > 
> > > > > > > Jason
> > > > > > 
> > > > > > Not all of them implements modify_port().
> > > > > 
> > > > > Then why didn't we just delete modify port from the other
> > > > > drivers?
> > > > > 
> > > > > Jason
> > > > 
> > > > This patch is doing that for all roce drivers that implement
> > > > modify
> > > > port, unless you mean none-roce drivers?
> > > 
> > > I mean just delete it without any change to the core code.. Here we
> > > are now changing some roce drivers to have a working modify_port
> > > 
> > > It is confusing what the intention is
> > 
> > I see what Jason is saying here.  If ib_modify_port() is meaningless
> > then lets
> > remove the call and let it return -EOPNOTSUPP.
> > 
> 
> Please see below the original implementation of ib_modify_port(), if
> modify_port() callback is implemented then it will be called, otherwise
> for RoCE driver the return value will be "ok" and for none RoCE driver
> it will be "-ENOSYS".
> 
> So, what I tried to do in this patch is to return "ok" (like how it is
> done for hns, mlx4, mlx5, ocrdma, and qedr) in the ib_core instead in
> the drivers, and changed rxe and vmw_pvrdma to be aligned with this
> change.

Well, you should explain this in the commit message

And explain in the commit why one return code is more correct than the
other

Jason
