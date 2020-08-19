Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956392494EF
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Aug 2020 08:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHSGTd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Aug 2020 02:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgHSGTc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Aug 2020 02:19:32 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2A5C061389
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 23:19:32 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id o21so20063282oie.12
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 23:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UitBeQZl3IDfoUFjE1RMUg1hR1AmoSeV4TFgB4MLyEA=;
        b=MO3leS3+My2xezXE8jsorMr0Ayc7iLOaLKb592diOXpbozY8XvadyfZBA3JZOxaxwg
         GC7bTyICLmrtXl+ay3jkeq3jWIt0HtmYbR7fqPUHk62mym3k3NJrkM8vur3cMKkXA6lB
         iX7nM/+MFjko9jEg+kypu8SPSUcr353mVvoTHYaGb+Kv7698MsRzytL4xaVV6qzg9UIv
         llOggkNBsuB5How/BtpG1v1gk08aqo0jp1PuGqUXB2jgkIrXk3JjAsEjNIKxb5o40gE3
         UkGvAOX96O8XgiUXYAPA9djv0XavketvIXEn3W+r7MbLS3ltVGHQm/VnqxH9woqXcgF3
         o/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UitBeQZl3IDfoUFjE1RMUg1hR1AmoSeV4TFgB4MLyEA=;
        b=a/ZsPrd0sY7mgkXpwnevQMipy78IfAZYR+u3o63lnGKokrK4YwK++2TPZ6hRR/86WI
         4y1pFDn5PouHHFOA85S121tV4xNAYkmW1uYWoJUfqlT/uNLzSHx3G/Lx1YJvnH4nm0EO
         g2jRvUR+24TNocDNbkhld8ldNm/b/RnMYsozh6Q/Uk7YHSaRtzsYfSda2sZBuUSwKSlt
         yD/H/7hvHePCbS+MnaZXx59fymTQZZ/cgfye4WaTg63M7Gm1mR6Ala7WSA2XkNYuMO7p
         Nc2rzNCrFKLB2s+++TcRtQsTAEX+UlWpeOYICv/Y/04GfsAJA+FQd2bjRItnamhL4Ucf
         eYXg==
X-Gm-Message-State: AOAM53067deFg3IhQOdzxU076lnlHnlMf85wxcoLqW9c6pMg6AmgXcHZ
        2JjRUPBWh0eF4TAcDH3qYg0a5SkwNQsavtCBvZPaEwLe
X-Google-Smtp-Source: ABdhPJxdLchPq3xd5sqwjaRwEXK6M2kpCMNw1ODv1stfS7makBlYMCbwCgdwCfiPdg3quuy+7bn0hw2eRAxoWpP5T/I=
X-Received: by 2002:aca:b286:: with SMTP id b128mr2377127oif.89.1597817971864;
 Tue, 18 Aug 2020 23:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200812111447.256822-1-kamalheib1@gmail.com> <9701a68d-c377-474a-5f65-c4e045a67e11@gmail.com>
 <20200816221236.GA821081@kheib-workstation> <a52afe9b-e474-5412-bf33-4f3a3690a322@gmail.com>
 <20200818055057.GA881164@kheib-workstation> <20200818074956.GM7555@unreal>
 <31678b13-4db1-d454-a85c-1ba5c8029c41@gmail.com> <20200819045830.GO7555@unreal>
In-Reply-To: <20200819045830.GO7555@unreal>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 19 Aug 2020 14:19:20 +0800
Message-ID: <CAD=hENfJOZHWpekR1eFT5vejqUFL8M47bGxhh5wAto0878uLsQ@mail.gmail.com>
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix panic when calling kmem_cache_create()
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Kamal Heib <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 19, 2020 at 12:58 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Aug 19, 2020 at 11:07:56AM +0800, Zhu Yanjun wrote:
> > On 8/18/2020 3:49 PM, Leon Romanovsky wrote:
> > > On Tue, Aug 18, 2020 at 08:50:57AM +0300, Kamal Heib wrote:
> > > > On Tue, Aug 18, 2020 at 09:48:43AM +0800, Zhu Yanjun wrote:
> > > > > On 8/17/2020 6:12 AM, Kamal Heib wrote:
> > > > > > On Sat, Aug 15, 2020 at 02:58:45PM +0800, Zhu Yanjun wrote:
> > > > > > > On 8/12/2020 7:14 PM, Kamal Heib wrote:
> > > > > > > > To avoid the following kernel panic when calling kmem_cache_create()
> > > > > > > > with a NULL pointer from pool_cache(),
> > > > > > > What is the root cause of this kernel panic?
> > > > > > >
> > > > > > The kernel panic is triggered using the following command and it happen
> > > > > > because the cache is not getting initialized.
> > > > > >
> > > > > > modprobe rdma_rxe add=eno1
> > > > > >
> > > > > > Thanks,
> > > > > > Kamal
> > > > > >
> > > > > > > Zhu Yanjun
> > > > > > >
> > > > > > > >     move the rxe_cache_init() to the
> > > > > > > > context of device creation.
> > > > > > > >
> > > > > > > >     BUG: unable to handle kernel NULL pointer dereference at 000000000000000b
> > > > > > > >     PGD 0 P4D 0
> > > > > > > >     Oops: 0000 [#1] SMP NOPTI
> > > > > > > >     CPU: 4 PID: 8512 Comm: modprobe Kdump: loaded Not tainted 4.18.0-231.el8.x86_64 #1
> > > > > > > >     Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 10/02/2018
> > > > > > > >     RIP: 0010:kmem_cache_alloc+0xd1/0x1b0
> > > > > > > >     Code: 8b 57 18 45 8b 77 1c 48 8b 5c 24 30 0f 1f 44 00 00 5b 48 89 e8 5d 41 5c 41 5d 41 5e 41 5f c3 81 e3 00 00 10 00 75 0e 4d 89 fe <41> f6 47 0b 04 0f 84 6c ff ff ff 4c 89 ff e8 cc da 01 00 49 89 c6
> > > > > > > >     RSP: 0018:ffffa2b8c773f9d0 EFLAGS: 00010246
> > > > > > > >     RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000005
> > > > > > > >     RDX: 0000000000000004 RSI: 00000000006080c0 RDI: 0000000000000000
> > > > > > > >     RBP: ffff8ea0a8634fd0 R08: ffffa2b8c773f988 R09: 00000000006000c0
> > > > > > > >     R10: 0000000000000000 R11: 0000000000000230 R12: 00000000006080c0
> > > > > > > >     R13: ffffffffc0a97fc8 R14: 0000000000000000 R15: 0000000000000000
> > > > > > > >     FS:  00007f9138ed9740(0000) GS:ffff8ea4ae800000(0000) knlGS:0000000000000000
> > > > > > > >     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > > >     CR2: 000000000000000b CR3: 000000046d59a000 CR4: 00000000003406e0
> > > > > > > >     Call Trace:
> > > > > > > >      rxe_alloc+0xc8/0x160 [rdma_rxe]
> > > > > > > >      rxe_get_dma_mr+0x25/0xb0 [rdma_rxe]
> > > > > > > >      __ib_alloc_pd+0xcb/0x160 [ib_core]
> > > > > > > >      ib_mad_init_device+0x296/0x8b0 [ib_core]
> > > > > > > >      add_client_context+0x11a/0x160 [ib_core]
> > > > > > > >      enable_device_and_get+0xdc/0x1d0 [ib_core]
> > > > > > > >      ib_register_device+0x572/0x6b0 [ib_core]
> > > > > > > >      ? crypto_create_tfm+0x32/0xe0
> > > > > > > >      ? crypto_create_tfm+0x7a/0xe0
> > > > > > > >      ? crypto_alloc_tfm+0x58/0xf0
> > > > > > > >      rxe_register_device+0x19d/0x1c0 [rdma_rxe]
> > > > > > > >      rxe_net_add+0x3d/0x70 [rdma_rxe]
> > > > > > > >      ? dev_get_by_name_rcu+0x73/0x90
> > > > > > > >      rxe_param_set_add+0xaf/0xc0 [rdma_rxe]
> > > > > > > >      parse_args+0x179/0x370
> > > > > > > >      ? ref_module+0x1b0/0x1b0
> > > > > > > >      load_module+0x135e/0x17e0
> > > > > > > >      ? ref_module+0x1b0/0x1b0
> > > > > > > >      ? __do_sys_init_module+0x13b/0x180
> > > > > > > >      __do_sys_init_module+0x13b/0x180
> > > > > > > >      do_syscall_64+0x5b/0x1a0
> > > > > > > >      entry_SYSCALL_64_after_hwframe+0x65/0xca
> > > > > > > >     RIP: 0033:0x7f9137ed296e
> > > > > > > >
> > > > > > > > Fixes: 8700e3e7c485 ("Soft RoCE driver")
> > > > > > > > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > > > > > > > ---
> > > > > > > >     drivers/infiniband/sw/rxe/rxe.c       | 14 +++++++-------
> > > > > > > >     drivers/infiniband/sw/rxe/rxe_pool.c  |  3 +++
> > > > > > > >     drivers/infiniband/sw/rxe/rxe_sysfs.c |  7 +++++++
> > > > > > > >     3 files changed, 17 insertions(+), 7 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> > > > > > > > index 5642eefb4ba1..60d5086dd34d 100644
> > > > > > > > --- a/drivers/infiniband/sw/rxe/rxe.c
> > > > > > > > +++ b/drivers/infiniband/sw/rxe/rxe.c
> > > > > > > > @@ -318,6 +318,13 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
> > > > > > > >                   goto err;
> > > > > > > >           }
> > > > > > > > + /* initialize slab caches for managed objects */
> > > > > > > > + err = rxe_cache_init();
> > > > > > > > + if (err) {
> > > > > > > > +         pr_err("unable to init object pools\n");
> > > > > > > > +         goto err;
> > > > > > > > + }
> > > > > > > > +
> > > > > > > >           err = rxe_net_add(ibdev_name, ndev);
> > > > > > > >           if (err) {
> > > > > > > >                   pr_err("failed to add %s\n", ndev->name);
> > > > > > > > @@ -336,13 +343,6 @@ static int __init rxe_module_init(void)
> > > > > > > >     {
> > > > > > > >           int err;
> > > > > > > > - /* initialize slab caches for managed objects */
> > > > > > > > - err = rxe_cache_init();
> > > > > When modprobe rdma_rxe, rxe_module_init should be called. Then
> > > > > rxe_cache_init should be also called.
> > > > >
> > > > > Why does the above call trace occur?
> > > > >
> > > > > Zhu Yanjun
> > > > >
> > > > As you can see in the call trace attached to the commit message, When
> > > > running the "modprobe rdma_rxe add=eno1" command the rxe_param_set_add()
> > > > is called before rxe_module_init() (without init the caches), so the
> > > > call trace occurs when trying to register the allocated rxe device from
> > > > the context of rxe_param_set_add() without initialize the caches.
> > > I would expect the fix being in rxe_init() instead of putting calls to
> > > rxe_cache_init() in all places.
> >
> > I agree with you.
> >
> > Is it possible to make rxe_module_init be called before rxe_param_set_add?
>
> The best solution will be to delete module_parameters() from RXE.

Sure. I am curious why the parameters are set before rxe_module_init.
Is this a bug?

Zhu Yanjun
>
> Thanks
>
> >
> > Thanks
> >
> > >
> > > Thanks
> >
> >
