Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D981FD571
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 21:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgFQT0u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 15:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgFQT0u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jun 2020 15:26:50 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AFFC0613ED
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2020 12:26:45 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id d27so2510909qtg.4
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2020 12:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SvS7mqiTd5OORbqwBz/pKdzLNSNiB95wcL/LLYdKn8E=;
        b=If6WkJccpXelII7tz0xcXj7B4U7HWXBnWBrs7JOO85KDd8TPvmeJZWroEGDql8e0ik
         PchzcMgjMbwXicGYnSR5kwzrDpytVaeeM4Cf2kJ3/8I7EWZHapd9jtPcajm9Cxwlebx4
         J5OIGqQNDQpfTK6W+3YJlVk7reGcAxIkAU3nl9Vw7oX6+VlIpqOZrkB2C3QlxJYvds4N
         8vtvupq/aG0kCt6gwpanFHr1eoC+1OM7NZRQNUl5HumVO0nWD2Pb9NC5hmPb1Gl49lvD
         uISKebCLupcus1VFIjn1yVwJ58o3vbbjpkUddC2W940thsYBiYktpbYNWILOw5xJHx6a
         /TSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SvS7mqiTd5OORbqwBz/pKdzLNSNiB95wcL/LLYdKn8E=;
        b=Ijk0lzTyJIU2GUJjCYLf3XA41WHw8UoP0CUXdkDmJFw9L1rXc5qVSXRggVR/Td/6KG
         j0MvJVa2rawYdEojJD238uuJ6eBdzqohG1rmsPkCgMKCNDRWexpTBd8IJF6zloBKpkaR
         8XGkbDCKm/M6l6Go6pEUa1t41IHRIA4dbqigJmIuWPhHt/nT9ce8J1vO00z4QnbUpp9G
         WDBrAcQnUh37oGOzPtE0vAFCJqPiV4oj4tWcD9DFj1fLCGedgh9LMdT9KGQiqysdabRn
         M0gUOHoxuJQ2L7cL1R/1z9gaZ9gpBeZ+K1WNjlAmYVEC+ifcV+fRJeIo9LwqSH6H4cb3
         PRdg==
X-Gm-Message-State: AOAM531x1K909rn/aKLZ/bAv1nl8hoPmo7hErZVVc7y9SqhQGSIYwjox
        gNeDTvGeMjieOJKP1266bPg9ng==
X-Google-Smtp-Source: ABdhPJwIyA1iIL0bl32uGj989h2ADHsFIlWah91suHRsRmNCvPlIajycf/P4rm09LRQzX+DLd0ok1w==
X-Received: by 2002:ac8:339b:: with SMTP id c27mr703305qtb.210.1592422004830;
        Wed, 17 Jun 2020 12:26:44 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id z3sm773338qkl.111.2020.06.17.12.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 12:26:43 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jldhq-009lbd-1B; Wed, 17 Jun 2020 16:26:42 -0300
Date:   Wed, 17 Jun 2020 16:26:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     haris.iqbal@cloud.ionos.com, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, dledford@redhat.com,
        kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH] Delay the initialization of rnbd_server module to
 late_initcall level
Message-ID: <20200617192642.GL6578@ziepe.ca>
References: <20200617103732.10356-1-haris.iqbal@cloud.ionos.com>
 <20200617112811.GL2383158@unreal>
 <20200617182046.GI6578@ziepe.ca>
 <20200617190756.GA2721989@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617190756.GA2721989@unreal>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 17, 2020 at 10:07:56PM +0300, Leon Romanovsky wrote:
> On Wed, Jun 17, 2020 at 03:20:46PM -0300, Jason Gunthorpe wrote:
> > On Wed, Jun 17, 2020 at 02:28:11PM +0300, Leon Romanovsky wrote:
> > > On Wed, Jun 17, 2020 at 04:07:32PM +0530, haris.iqbal@cloud.ionos.com wrote:
> > > > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > > >
> > > > Fixes: 2de6c8de192b ("block/rnbd: server: main functionality")
> > > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > > >
> > > > The rnbd_server module's communication manager initialization depends on the
> > > > registration of the "network namespace subsystem" of the RDMA CM agent module.
> > > > As such, when the kernel is configured to load the rnbd_server and the RDMA
> > > > cma module during initialization; and if the rnbd_server module is initialized
> > > > before RDMA cma module, a null ptr dereference occurs during the RDMA bind
> > > > operation.
> > > > This patch delays the initialization of the rnbd_server module to the
> > > > late_initcall level, since RDMA cma module uses module_init which puts it into
> > > > the device_initcall level.
> > > >  drivers/block/rnbd/rnbd-srv.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> > > > index 86e61523907b..213df05e5994 100644
> > > > +++ b/drivers/block/rnbd/rnbd-srv.c
> > > > @@ -840,5 +840,5 @@ static void __exit rnbd_srv_cleanup_module(void)
> > > >  	rnbd_srv_destroy_sysfs_files();
> > > >  }
> > > >
> > > > -module_init(rnbd_srv_init_module);
> > > > +late_initcall(rnbd_srv_init_module);
> > >
> > > I don't think that this is correct change. Somehow nvme-rdma works:
> > > module_init(nvme_rdma_init_module);
> > > -> nvme_rdma_init_module
> > >  -> nvmf_register_transport(&nvme_rdma_transport);
> > >   -> nvme_rdma_create_ctrl
> > >    -> nvme_rdma_setup_ctrl
> > >     -> nvme_rdma_configure_admin_queue
> > >      -> nvme_rdma_alloc_queue
> > >       -> rdma_create_id
> >
> > If it does work, it is by luck.
> 
> I didn't check every ULP, but it seems that all ULPs use the same
> module_init.
> 
> >
> > Keep in mind all this only matters for kernels without modules.
> 
> Can it be related to the fact that other ULPs call to ib_register_client()
> before calling to rdma-cm? RNBD does not have such call.

If the rdma_create_id() is not on a callchain from module_init then
you don't have a problem.

nvme has a bug here, IIRC. It is not OK to create RDMA CM IDs outside
a client - CM IDs are supposed to be cleaned up when the client is
removed.

Similarly they are supposed to be created from the client attachment.

Though listening CM IDs unbound to any device may change that
slightly, I think it is probably best practice to create the listening
ID only if a client is bound.

Most probably that is the best way to fix rnbd

> I'm not proposing this, but just loudly wondering, do we really need rdma-cm
> as a separate module? Can we bring it to be part of ib_core?

No idea.. It doesn't help this situation at least

Jason
