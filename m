Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 944884A08B
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 14:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfFRMPu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 08:15:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFRMPu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jun 2019 08:15:50 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 567662085A;
        Tue, 18 Jun 2019 12:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560860150;
        bh=c9CoCiEDQZKejTRhIqALphH5zsU4tj87M5+jBQbjL9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQqLpuwz8Tva40UAQzc2h3bjVgdo1wNgAs1KengLpgJlembXL5k1oBO7Ji7HYwlDf
         2r5tK4VW/L50nszk2iReQvallgeZSmnBoEs10fCNTbI1tR6i8Vj8kmNz5jnYtgwzr5
         xM7vcWmbTgPU72nqCIgNbHTYdWV+QX90PBIMK5Qg=
Date:   Tue, 18 Jun 2019 15:15:46 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
Message-ID: <20190618121546.GJ4690@mtr-leonro.mtl.com>
References: <20190614003819.19974-1-jgg@ziepe.ca>
 <20190614003819.19974-3-jgg@ziepe.ca>
 <4b271896e1f3e643ccc5824ff6ac419787c52910.camel@redhat.com>
 <20190617185443.GC25886@mellanox.com>
 <1c871dfaa2f5ddd9f07ab5f16e0a0e4f6c64917c.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c871dfaa2f5ddd9f07ab5f16e0a0e4f6c64917c.camel@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 17, 2019 at 03:27:22PM -0400, Doug Ledford wrote:
> On Mon, 2019-06-17 at 18:54 +0000, Jason Gunthorpe wrote:
> > On Fri, Jun 14, 2019 at 03:00:32PM -0400, Doug Ledford wrote:
> > > On Thu, 2019-06-13 at 21:38 -0300, Jason Gunthorpe wrote:
> > > > +       if (ibdev)
> > > > +               ret = __ib_get_client_nl_info(ibdev, client_name,
> > > > res);
> > > > +       else
> > > > +               ret = __ib_get_global_client_nl_info(client_name,
> > > > res);
> > > > +#ifdef CONFIG_MODULES
> > > > +       if (ret == -ENOENT) {
> > > > +               request_module("rdma-client-%s", client_name);
> > > > +               if (ibdev)
> > > > +                       ret = __ib_get_client_nl_info(ibdev,
> > > > client_name, res);
> > > > +               else
> > > > +                       ret =
> > > > __ib_get_global_client_nl_info(client_name, res);
> > > > +       }
> > > > +#endif
> > >
> > > I was trying to put my finger on something yesterday while reading
> > > the
> > > code, and this change makes it more clear for me.  Do we really
> > > want to
> > > limit the info type based on ibdev?  It seems to me that all global
> > > info retrieval should work whether you open a specific ibdev or
> > > not.
> >
> > Each chardev name has a specified query protocol - global chardevs
> > must not specify a ibdev, and local ones must. Each name can only be
> > global or ibdev - no mixing. Too confusing.
>
> I can see where that's the uapi as envisioned, my point though is would
> it be better to allow opening of an ibdev, retrieval of device specific
> data, and also retrieval of the available global data?  It just
> prevents having to open two files to get information that isn't device
> specific.  But, it's not a big deal either.
>
> > It is uapi so we should be strict, if the ibdev is not allowed then
> > it
> > should be checked to be absent in case we do something different
> > later.
> >
> > > The other thing I was wondering about was the module
> > > loading.  Every
> > > attempt to load a module is a fork/exec cycle and a context switch
> > > over
> > > to modprobe and back, and we make no attempt here to keep each
> >
> > It is a common pattern in the kernel, ie we did exactly this code to
> > load the ib netlink module in the netlink core.
> >
> > If there is a problem then it should be addressed globally..
>
> Yeah, I agree.  I'm not sure there is a problem.
>
> > > indicate we've attempted to load that module, and on -ENOENT, we
> > > check
> > > the table for a match to our passed in client_name, and only if we
> > > have
> > > a match, and it's load count is 0, do we call request_module() and
> > > increment the load count.  Thoughts?
> >
> > I assume it becomes single threaded and batched at some point, so it
> > is not so bad...
>
> Thanks, series applied.

Doug,

Please drop it.

Thanks

>
>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
> 2FDD


