Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4CB204E73
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 11:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbgFWJul (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 05:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731923AbgFWJuj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jun 2020 05:50:39 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C6DC061573
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2020 02:50:39 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a1so6932972ejg.12
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2020 02:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=43Y6xmU50+sLAZ5J3fXA3wX4xl6aKaZmykjUjo6gTJ8=;
        b=Klb9LvBrigVP6aasMs5mt8cmbwfEC0k02WDSzPJoiGht73X1SX4aq9sBSMTa7nYkL3
         PRKOkLTjuT1IXzffTYvBBlnH7j/vZ31zG+AzA16iuFe/Z0yhEf9NW4sTXVvQ2JPtwDkU
         Or0NcMin9HpWulHQgMzU/arC6UzsbzAqM0FVCoVvEAkdOL6uNYXwO/tnLem0T3c/5irh
         3ldgD/BAMajEscbHFTXNEl8nL3g8gC/Veu6apemx5uQDFScBIDSXbiUowplelXt54LH2
         OiU9tezBXQr+9JpRvPYYchK03bwCURFndjbHXYBJuPrtnhj9KwYUr14aM88309M6irEA
         KNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43Y6xmU50+sLAZ5J3fXA3wX4xl6aKaZmykjUjo6gTJ8=;
        b=m1xBk4GY/T4K5JW4XfBv4iHjAiFzV1v7JJYAojdyyMwpBIiDlH1/bBCF6Yq9UHxoEa
         srJ50gXioywpC3dZRQ5E5QKl3EBFHnl8Sc69zraObU8SWIi8xRvghKa4sExM9zTaj5Tv
         9NG9rC8hblUoy4R36TYoCRJzWABtK2jXj/YTbGLBnq/+q3ewshP/35LKEAfi8aAnckE0
         P6rM2Or05R/Xt1GcYgAtkLGo/HvMRwzmS/YM8f67HkuixA5rTg+b+boIzerCelv8BfaW
         pm55QksSU+9BPChowkhhbHtI6RJGYBfVrOyCQ72cgx+T8Ii+JEBKQIGoDXg4oJRf5UuT
         uezg==
X-Gm-Message-State: AOAM533RgFWE5CfPWLyYoKY8l9DkB80qDuzkG68ZXEfTJqe9AjaymoEw
        J+a+4zjUiHAOrUuqxM2tEzr0nP607XELSaT1y1qSbg==
X-Google-Smtp-Source: ABdhPJwz4oxeIjD4nOxCeZeBUDGwCkRfA2lwNAC6RaO25FamkK8rqDrozotUdVWyRFiFKXU7TYjbau9Gjm9UOo1vrwU=
X-Received: by 2002:a17:906:1682:: with SMTP id s2mr10650062ejd.532.1592905838199;
 Tue, 23 Jun 2020 02:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200617103732.10356-1-haris.iqbal@cloud.ionos.com>
 <20200617112811.GL2383158@unreal> <20200617182046.GI6578@ziepe.ca>
 <20200617190756.GA2721989@unreal> <20200617192642.GL6578@ziepe.ca>
 <CAJpMwygeJ7uaNUKxhsF-bx=ufchkx7M6G0E237=-0C7GwJ3yog@mail.gmail.com> <CAJpMwyjJSu4exkTAoFLhY-ubzNQLp6nWqq83k6vWn1Uw3eaK_Q@mail.gmail.com>
In-Reply-To: <CAJpMwyjJSu4exkTAoFLhY-ubzNQLp6nWqq83k6vWn1Uw3eaK_Q@mail.gmail.com>
From:   Haris Iqbal <haris.iqbal@cloud.ionos.com>
Date:   Tue, 23 Jun 2020 15:20:27 +0530
Message-ID: <CAJpMwygqz20=H7ovSL0nSWLbVpMv-KLOgYO=nRCLv==OC8sgHw@mail.gmail.com>
Subject: Re: [PATCH] Delay the initialization of rnbd_server module to
 late_initcall level
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>, dledford@redhat.com,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason and Leon,

Did you get a chance to look into my previous email?

On Thu, Jun 18, 2020 at 2:44 PM Haris Iqbal <haris.iqbal@cloud.ionos.com> wrote:
>
> It seems that the "rdma_bind_addr()" is called by the nvme rdma
> module; but during the following events
> 1) When a discover happens from the client side. Call trace for that looks like,
> [ 1098.409398] nvmf_dev_write
> [ 1098.409403] nvmf_create_ctrl
> [ 1098.414568] nvme_rdma_create_ctrl
> [ 1098.415009] nvme_rdma_setup_ctrl
> [ 1098.415010] nvme_rdma_configure_admin_queue
> [ 1098.415010] nvme_rdma_alloc_queue
>                              -->(rdma_create_id)
> [ 1098.415032] rdma_resolve_addr
> [ 1098.415032] cma_bind_addr
> [ 1098.415033] rdma_bind_addr
>
> 2) When a connect happens from the client side. Call trace is the same
> as above, plus "nvme_rdma_alloc_queue()" is called n number of times;
> n being the number of IO queues being created.
>
>
> On the server side, when an nvmf port is enabled, that also triggers a
> call to "rdma_bind_addr()", but that is not from the nvme rdma module.
> may be nvme target rdma? (not sure).
>
> On Thu, Jun 18, 2020 at 7:15 AM Haris Iqbal <haris.iqbal@cloud.ionos.com> wrote:
> >
> > (Apologies for multiple emails. Was having trouble with an extension,
> > cause of which emails did not get delivered to the mailing list.
> > Resolved now.)
> >
> > > Somehow nvme-rdma works:
> >
> > I think that's because the callchain during the nvme_rdma_init_module
> > initialization stops at "nvmf_register_transport()". Here only the
> > "struct nvmf_transport_ops nvme_rdma_transport" is registered, which
> > contains the function "nvme_rdma_create_ctrl()". I tested this in my
> > local setup and during kernel boot, that's the extent of the
> > callchain.
> > The ".create_ctrl"; which now points to "nvme_rdma_create_ctrl()" is
> > called later from "nvmf_dev_write()". I am not sure when this is
> > called, probably when the "discover" happens from the client side or
> > during the server config. I am trying to test this to confirm, will
> > send more details once I am done.
> > Am I missing something here?
> >
> >
> > > If the rdma_create_id() is not on a callchain from module_init then you don't have a problem.
> >
> > I am a little confused. I thought the problem occurs from a call to
> > either "rdma_resolve_addr()" which calls "rdma_bind_addr()",
> > or a direct call to "rdma_bind_addr()" as in rtrs case.
> > In both the cases, a call to "rdma_create_id()" is needed before this.
> >
> >
> > > Similarly they are supposed to be created from the client attachment.
> > I am a beginner in terms of concepts here. Did you mean when a client
> > tries to establish the first connection to an rdma server?
> >
> >
> > On Thu, Jun 18, 2020 at 12:56 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Wed, Jun 17, 2020 at 10:07:56PM +0300, Leon Romanovsky wrote:
> > > > On Wed, Jun 17, 2020 at 03:20:46PM -0300, Jason Gunthorpe wrote:
> > > > > On Wed, Jun 17, 2020 at 02:28:11PM +0300, Leon Romanovsky wrote:
> > > > > > On Wed, Jun 17, 2020 at 04:07:32PM +0530, haris.iqbal@cloud.ionos.com wrote:
> > > > > > > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > > > > > >
> > > > > > > Fixes: 2de6c8de192b ("block/rnbd: server: main functionality")
> > > > > > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > > > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > > > > > >
> > > > > > > The rnbd_server module's communication manager initialization depends on the
> > > > > > > registration of the "network namespace subsystem" of the RDMA CM agent module.
> > > > > > > As such, when the kernel is configured to load the rnbd_server and the RDMA
> > > > > > > cma module during initialization; and if the rnbd_server module is initialized
> > > > > > > before RDMA cma module, a null ptr dereference occurs during the RDMA bind
> > > > > > > operation.
> > > > > > > This patch delays the initialization of the rnbd_server module to the
> > > > > > > late_initcall level, since RDMA cma module uses module_init which puts it into
> > > > > > > the device_initcall level.
> > > > > > >  drivers/block/rnbd/rnbd-srv.c | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> > > > > > > index 86e61523907b..213df05e5994 100644
> > > > > > > +++ b/drivers/block/rnbd/rnbd-srv.c
> > > > > > > @@ -840,5 +840,5 @@ static void __exit rnbd_srv_cleanup_module(void)
> > > > > > >         rnbd_srv_destroy_sysfs_files();
> > > > > > >  }
> > > > > > >
> > > > > > > -module_init(rnbd_srv_init_module);
> > > > > > > +late_initcall(rnbd_srv_init_module);
> > > > > >
> > > > > > I don't think that this is correct change. Somehow nvme-rdma works:
> > > > > > module_init(nvme_rdma_init_module);
> > > > > > -> nvme_rdma_init_module
> > > > > >  -> nvmf_register_transport(&nvme_rdma_transport);
> > > > > >   -> nvme_rdma_create_ctrl
> > > > > >    -> nvme_rdma_setup_ctrl
> > > > > >     -> nvme_rdma_configure_admin_queue
> > > > > >      -> nvme_rdma_alloc_queue
> > > > > >       -> rdma_create_id
> > > > >
> > > > > If it does work, it is by luck.
> > > >
> > > > I didn't check every ULP, but it seems that all ULPs use the same
> > > > module_init.
> > > >
> > > > >
> > > > > Keep in mind all this only matters for kernels without modules.
> > > >
> > > > Can it be related to the fact that other ULPs call to ib_register_client()
> > > > before calling to rdma-cm? RNBD does not have such call.
> > >
> > > If the rdma_create_id() is not on a callchain from module_init then
> > > you don't have a problem.
> > >
> > > nvme has a bug here, IIRC. It is not OK to create RDMA CM IDs outside
> > > a client - CM IDs are supposed to be cleaned up when the client is
> > > removed.
> > >
> > > Similarly they are supposed to be created from the client attachment.
> > >
> > > Though listening CM IDs unbound to any device may change that
> > > slightly, I think it is probably best practice to create the listening
> > > ID only if a client is bound.
> > >
> > > Most probably that is the best way to fix rnbd
> > >
> > > > I'm not proposing this, but just loudly wondering, do we really need rdma-cm
> > > > as a separate module? Can we bring it to be part of ib_core?
> > >
> > > No idea.. It doesn't help this situation at least
> > >
> > > Jason
> >
> >
> >
> > --
> >
> > Regards
> > -Haris
>
>
>
> --
>
> Regards
> -Haris



-- 

Regards
-Haris
