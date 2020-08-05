Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BCA23D166
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Aug 2020 22:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgHEUAB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Aug 2020 16:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgHEQkH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Aug 2020 12:40:07 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850CBC061A1C
        for <linux-rdma@vger.kernel.org>; Wed,  5 Aug 2020 04:18:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a15so40300169wrh.10
        for <linux-rdma@vger.kernel.org>; Wed, 05 Aug 2020 04:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a8Xl0N8gpF1FNzq/1cGal4TNsCzxDEF1alNaagcJBMM=;
        b=ScNGCLIXi4vxWRwJCaCnKcGcfbOn6phz0aCjR43BcVgwmh5u0tKCM7pVc3kw/F6tw1
         B11ZbX7UX+aiqII/YinvosNgTlS/pPzy8+tlt7XV2U7tRNVmx2YQUp91CnFQQlb5Rod0
         //R6rE0geCvvED3Dajif8QscN7LoP52Lwkuf2kMgl2vzQ7L/DJTeOcLAq1mMK5mmu40h
         JlKHTGkBf99YExVReGdK3dePaguoBmGNgAwUHysFo0PoOohdhVHDl30sPbgrJ7c2KFrB
         OnplxOCyw7j2nkd5Ww1t08BLdtSuEp7TkJAUe2jMiECJZWwIGEf9hkVzDEbaw9i3fvro
         92GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8Xl0N8gpF1FNzq/1cGal4TNsCzxDEF1alNaagcJBMM=;
        b=J6XYjjUi5hoxObarpbdJPQoJrVCPzMkYm/OMJ2nVtItFLboA3Vs9VAp8TsGLMQimZa
         HKVvnmgMrBbUKDyV+WzOckrOeNB30ZdddlLaezqFr/JkX/f+I15sWqltm0yzCcRPXHNy
         wwYGCSS+LQgDtz1t38k7VUihDCMR7IURsH406jJcQ787oTVHiR7DB3Ia/6Kne9qU+Fly
         2Phel41FXPjiWussFMczP/pVNx9KsCufT0CPgu/9T6MMypGcT7sHJioj16f/hG++DpHU
         G0WaA4H0atJ4yTMMpe7ednSchUu5ntrcPmmDIyT80UmzoqJcaEJGFW1pPsuGlzO/6Qr7
         GdEw==
X-Gm-Message-State: AOAM5339Brhwrz7ImDDne63HEMDaeSDGcBTXK5rPryT/RsqlV+pcvRva
        hSCMixl2GgrUvpXbPui0p1ZxtdKtYn/iQebTxWpjHd9D6g==
X-Google-Smtp-Source: ABdhPJxZOz12gUZnEl+W3F9ixkvxJC6CFJe1macjUpVC9uYhpCqed6sjOWZF9XRfzhLnAnRJXRq3iZzK+l38cfk2BLA=
X-Received: by 2002:a5d:43c4:: with SMTP id v4mr2465855wrr.426.1596626296001;
 Wed, 05 Aug 2020 04:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200623172321.GC6578@ziepe.ca> <20200804133759.377950-1-haris.iqbal@cloud.ionos.com>
 <20200805055712.GE4432@unreal> <CAHg0HuzmfrKqy_SfwEqRh33Ymx8j6DhkLC0=11T7Djrc7z-SWQ@mail.gmail.com>
 <20200805091644.GG4432@unreal>
In-Reply-To: <20200805091644.GG4432@unreal>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Wed, 5 Aug 2020 13:18:05 +0200
Message-ID: <CAHg0Huy-xXopLpdU1Bx1een2vuDv6o27YZz+x-zN_enChESsQw@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/rtrs-srv: Incorporate ib_register_client into
 rtrs server init
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, linux-block@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Chen, Rong A" <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 5, 2020 at 11:16 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Aug 05, 2020 at 11:09:00AM +0200, Danil Kipnis wrote:
> > Hi Leon,
> >
> > On Wed, Aug 5, 2020 at 7:57 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Tue, Aug 04, 2020 at 07:07:58PM +0530, Md Haris Iqbal wrote:
> > > > The rnbd_server module's communication manager (cm) initialization depends
> > > > on the registration of the "network namespace subsystem" of the RDMA CM
> > > > agent module. As such, when the kernel is configured to load the
> > > > rnbd_server and the RDMA cma module during initialization; and if the
> > > > rnbd_server module is initialized before RDMA cma module, a null ptr
> > > > dereference occurs during the RDMA bind operation.
> > > >
> > > > Call trace below,
> > > >
> > > > [    1.904782] Call Trace:
> > > > [    1.904782]  ? xas_load+0xd/0x80
> > > > [    1.904782]  xa_load+0x47/0x80
> > > > [    1.904782]  cma_ps_find+0x44/0x70
> > > > [    1.904782]  rdma_bind_addr+0x782/0x8b0
> > > > [    1.904782]  ? get_random_bytes+0x35/0x40
> > > > [    1.904782]  rtrs_srv_cm_init+0x50/0x80
> > > > [    1.904782]  rtrs_srv_open+0x102/0x180
> > > > [    1.904782]  ? rnbd_client_init+0x6e/0x6e
> > > > [    1.904782]  rnbd_srv_init_module+0x34/0x84
> > > > [    1.904782]  ? rnbd_client_init+0x6e/0x6e
> > > > [    1.904782]  do_one_initcall+0x4a/0x200
> > > > [    1.904782]  kernel_init_freeable+0x1f1/0x26e
> > > > [    1.904782]  ? rest_init+0xb0/0xb0
> > > > [    1.904782]  kernel_init+0xe/0x100
> > > > [    1.904782]  ret_from_fork+0x22/0x30
> > > > [    1.904782] Modules linked in:
> > > > [    1.904782] CR2: 0000000000000015
> > > > [    1.904782] ---[ end trace c42df88d6c7b0a48 ]---
> > > >
> > > > All this happens cause the cm init is in the call chain of the module init,
> > > > which is not a preferred practice.
> > > >
> > > > So remove the call to rdma_create_id() from the module init call chain.
> > > > Instead register rtrs-srv as an ib client, which makes sure that the
> > > > rdma_create_id() is called only when an ib device is added.
> > > >
> > > > Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> > > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > > > ---
> > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 77 +++++++++++++++++++++++++-
> > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.h |  7 +++
> > > >  2 files changed, 81 insertions(+), 3 deletions(-)
> > >
> > > Please don't send vX patches as reply-to in "git send-email" command.
> >
> > I thought vX + in-reply-to makes it clear that a new version of a
> > patch is proposed in response to a mail reporting a problem in the
> > first version. Why is that a bad idea?
>
> It looks very messy in e-mail client. It is hard to follow and requires
> multiple iterations to understand if the reply is on previous variant or
> on new one.
>
> See attached print screen or see it in lore, where thread view is used.
> https://lore.kernel.org/linux-rdma/20200623172321.GC6578@ziepe.ca/T/#t

I see, thanks. Just a related question: In this particular case the
commit message changed in the second version of the patch. Should one
still use v2 in that case, or should the second version be submitted
without the vX tag at all?

>
> Thanks
