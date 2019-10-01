Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56D04C37FC
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 16:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389126AbfJAOpg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 10:45:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43364 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfJAOpg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 10:45:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id c3so21886161qtv.10
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 07:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q9shm3lqv7NRccZ2e08wFHPb1VHDPCJ6mOTBTqrM99s=;
        b=H2tcgSeaoaAFQqLuk+HBmDUPZMouTWSgVdwjQZAGS2V4cGIVqIm2/Mab9WU9AQnQ7d
         MMgy3bblNWes8TPaWHJ+IOQnx8LB3m67bM+RN1WuXMmYU/NiOMNowZ7OPP4RT/efbT44
         gx9nOmi+VL+8AWwmS7VhjnJ4Se9xr8CoR48I3Nckjsb5MxYoQC1CW3jgwHfKwY9biSro
         QjlujpPNyE8gjbZMia9ZuUHlgGKxg6hS1hJQY0Yiz1j1L+Tmyib04WYvf45Ht6Y11rcB
         F0KdqqSeCP0Av1f5DQ9b+1ZtmNYnj932r/omBqQXwgFPH35Cz8SLe9eMnllUbAyJVPW4
         tTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q9shm3lqv7NRccZ2e08wFHPb1VHDPCJ6mOTBTqrM99s=;
        b=Kgt1mZIAqyWsUt9KHgKToAHp2nRWK4MjWULDyQkav6qMrVYxmH99FH5bmYyNGwFODo
         iGYF+bojwMbVfa1Oodi4Gsd8/QEIQ2fiBqc+VZYI9+G9nNIXk3212wGiekNMYgCSBL2P
         3Sm5RWX7l9gz8sjdLLzJM0InDq7CWeZM4VkP4pvpBH6LPfKEXF2bWO2/NyF/BWf3KJgj
         eSgikpRRgy3pVAQqb69tHI3s0WnanyNJ95DnTFdq2PEAhxgzI8uJWhQnklDI4saeIDVO
         +E5S/EN7La2GMR31Q49rSo72L0eYTnUY7JtQsxrWLetB5+rW19lLwrG0FUFoas98CfRE
         Hf4g==
X-Gm-Message-State: APjAAAXku/eVZaNrnZdeqAP+2ivcT0Qe1WLHDI2Agd8hs1OEhP+Rh9Fk
        biWjT6Us7ttr+2Qj0Dp5+Njog/QbiDM=
X-Google-Smtp-Source: APXvYqxdXYlL/7C4FKBQ2h4y/qxbAsr2CsXDPyABjkq7zEnWyOOoktwsLwsq3mYvEpMZARVGElLIWg==
X-Received: by 2002:ac8:730f:: with SMTP id x15mr11248258qto.248.1569941135283;
        Tue, 01 Oct 2019 07:45:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id v7sm8613075qte.29.2019.10.01.07.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 07:45:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFJPC-0003NF-86; Tue, 01 Oct 2019 11:45:34 -0300
Date:   Tue, 1 Oct 2019 11:45:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Metzmacher <metze@samba.org>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH] rdma/core: add __module_get()/module_put() to
 cma_[de]ref_dev()
Message-ID: <20191001144534.GC22532@ziepe.ca>
References: <20190930090455.10772-1-metze@samba.org>
 <20190930124122.GA24612@ziepe.ca>
 <31690de0-eef6-378b-2703-6cd13eb61461@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31690de0-eef6-378b-2703-6cd13eb61461@samba.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 30, 2019 at 03:52:51PM +0200, Stefan Metzmacher wrote:
> Am 30.09.19 um 14:41 schrieb Jason Gunthorpe:
> > On Mon, Sep 30, 2019 at 11:04:55AM +0200, Stefan Metzmacher wrote:
> >> Currently there seems to be a problem when an RDMA listener or connection
> >> is active on an ib_device.
> >>
> >> 'rmmod rdma_rxe' (the same for 'siw' and most likely all
> >> others) just hangs like this until shutdown the listeners and
> >> connections:
> >>
> >>   [<0>] remove_client_context+0x97/0xe0 [ib_core]
> >>   [<0>] disable_device+0x90/0x120 [ib_core]
> >>   [<0>] __ib_unregister_device+0x41/0xa0 [ib_core]
> >>   [<0>] ib_unregister_driver+0xbb/0x100 [ib_core]
> >>   [<0>] rxe_module_exit+0x1a/0x8aa [rdma_rxe]
> >>   [<0>] __x64_sys_delete_module+0x147/0x290
> >>   [<0>] do_syscall_64+0x5a/0x130
> >>   [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >>
> >> The following would be expected:
> >>
> >>   rmmod: ERROR: Module rdma_rxe is in use
> >>
> >> And this change provides that.
> >>
> >> Once all add listeners and connections are gone
> >> the module can be removed again.
> >>
> >> Signed-off-by: Stefan Metzmacher <metze@samba.org>
> >> Cc: stable@vger.kernel.org
> >>  drivers/infiniband/core/cma.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> > 
> > How do you even get here? Are you using in-kernel modules to access
> > rxe?
> 
> Yes, I'm testing my smbdirect driver with Samba.
> https://git.samba.org/?p=metze/linux/smbdirect.git;a=summary
> 
> Samba's 'smbd' listens for incoming connections.
> 
> > Drivers are supposed to declare a DEVICE_FATAL error when their module
> > is removed and then progress toward cleaning up. It would seem this is
> > missing in rxe.
> 
> It's a bit hard for me to follow the code path from other drivers
> and how an unload of them would trigger IB_EVENT_DEVICE_FATAL.

I think the drivers just call a ib_dispatch_event on
IB_EVENT_DEVICE_FATAL when they start to remove, ie before calling
ib_device_unregister()

> > Globally blocking module unload would break the existing dis-associate
> > flows, and blocking until listeners are removed seems like all rdma
> > drivers will instantly become permanetly blocked when things like SRP
> > or IPoIB CM mode are running?
> 
> So the design is to allow drivers to be unloaded while there are
> active connections?
> 
> If so is this specific to RDMA drivers?

No, it is normal for networking, you can ip link set down and unload a
net driver even though there are sockets open that might traverse it
 
> > I think the proper thing is to fix rxe (and probably siw) to signal
> > the DEVICE_FATAL so the CMA listeners can cleanly disconnect
>
> I just found that drivers/nvme/host/rdma.c and
> drivers/nvme/target/rdma.c both use ib_register_client();
> in order to get notified that a device is going to be removed.
> 
> Maybe I should also use ib_register_client()?

Oh, yes, all kernel clients must use register_client and related to
manage their connection to the RDMA stack otherwise they are probably
racy. The remove callback there is the same idea as the device_fatal
scheme is for userspace.

How do you discover the RDMA device to use? Just call into CM and let
it sort it out? That actually seems reasonable, but then CM should
take care of the remove() to kill connections, I suppose it doesn't..

Jason
