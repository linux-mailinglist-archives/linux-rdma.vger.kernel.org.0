Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7309B247E19
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 07:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHRFvD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 01:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgHRFvC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 01:51:02 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D00C061342
        for <linux-rdma@vger.kernel.org>; Mon, 17 Aug 2020 22:51:01 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a15so17027002wrh.10
        for <linux-rdma@vger.kernel.org>; Mon, 17 Aug 2020 22:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KeGkR9igrdBxFfxTdTXSVDJqTbmMDaHGdYnYocnG9Mg=;
        b=iBFlqeX7YVxCxtaiqk3e7uxwN2vI3VVYeqUYJBlLNhCRX2JjbXoIVpMHu6doOxhgYQ
         nOHAc4FvkFjo6BV1Js7ngNGu7BbsiGIp8sQXUs5VgWI52InsVJ0qXS5c55L9MgKu+4/3
         dNZVZm1DVVuEnlROx/UQ+wIaHYkfeBQiabFXI60g10nE2uyJfhamyUsGu/pRD/b4PJ6l
         iG2u7fikcsz6cZ495FBHhOTgxic5x9xYb01/SwOiZVB3oVtprqEiTuAjz1OYAVzpgEaL
         DatLGeXSVYD5X85kmLi2oQmzLDcWabYSqCELUQpKXnNO59HtD0sipFzlwNc9NYhgcGqS
         Pg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KeGkR9igrdBxFfxTdTXSVDJqTbmMDaHGdYnYocnG9Mg=;
        b=NE5FUEw3UD1Sc/5sLgJg+8wBwmAKQflOsctYu6BVHV1tl1MzAoDyrORjzan2doWp4M
         b9der2CC7BQWIRzC2Njg+QjIf4LIRtG2wqiX1bAajiE9HxBfDGsnQ2vpd/vUQQmEV98W
         X1zoStTM3gYg2GyLNN7akjTuAwhPF51wRbnGUv44q29q5eamRK764Pfdgm8H84G+dyg6
         iN098DfYIw9ZOz9I2GBjpVm0JQ7VU6RktOH1R+mdh7g+vSXqRsUTkTjPXUv3mbBhWTbP
         8894YhrujsZPs+EECucc67z16Ddu3OFSd2NAoAF878pvluXZ9AH29dWBQvl/BluOCL+e
         3mkQ==
X-Gm-Message-State: AOAM530JZ7G2qi9JSNO+0fKTstv9pOxoBj8pLD3jbCmKS4jONeg1YUuz
        4Ad1ULzrYI5C1FnK0kF3rPI=
X-Google-Smtp-Source: ABdhPJwRZNHPMysNzMdqbSQVzoXko4BYeIqDOQ+ZklxQCfHBnm6Bj6wtgjRhz1Ximi6tsQ8GMd4fHQ==
X-Received: by 2002:adf:fb01:: with SMTP id c1mr17846634wrr.119.1597729860455;
        Mon, 17 Aug 2020 22:51:00 -0700 (PDT)
Received: from kheib-workstation ([77.137.115.29])
        by smtp.gmail.com with ESMTPSA id e5sm35364779wrc.37.2020.08.17.22.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 22:50:59 -0700 (PDT)
Date:   Tue, 18 Aug 2020 08:50:57 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
Message-ID: <20200818055057.GA881164@kheib-workstation>
References: <20200812111447.256822-1-kamalheib1@gmail.com>
 <9701a68d-c377-474a-5f65-c4e045a67e11@gmail.com>
 <20200816221236.GA821081@kheib-workstation>
 <a52afe9b-e474-5412-bf33-4f3a3690a322@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a52afe9b-e474-5412-bf33-4f3a3690a322@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 18, 2020 at 09:48:43AM +0800, Zhu Yanjun wrote:
> On 8/17/2020 6:12 AM, Kamal Heib wrote:
> > On Sat, Aug 15, 2020 at 02:58:45PM +0800, Zhu Yanjun wrote:
> > > On 8/12/2020 7:14 PM, Kamal Heib wrote:
> > > > To avoid the following kernel panic when calling kmem_cache_create()
> > > > with a NULL pointer from pool_cache(),
> > > What is the root cause of this kernel panic?
> > > 
> > The kernel panic is triggered using the following command and it happen
> > because the cache is not getting initialized.
> > 
> > modprobe rdma_rxe add=eno1
> > 
> > Thanks,
> > Kamal
> > 
> > > Zhu Yanjun
> > > 
> > > >    move the rxe_cache_init() to the
> > > > context of device creation.
> > > > 
> > > >    BUG: unable to handle kernel NULL pointer dereference at 000000000000000b
> > > >    PGD 0 P4D 0
> > > >    Oops: 0000 [#1] SMP NOPTI
> > > >    CPU: 4 PID: 8512 Comm: modprobe Kdump: loaded Not tainted 4.18.0-231.el8.x86_64 #1
> > > >    Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 10/02/2018
> > > >    RIP: 0010:kmem_cache_alloc+0xd1/0x1b0
> > > >    Code: 8b 57 18 45 8b 77 1c 48 8b 5c 24 30 0f 1f 44 00 00 5b 48 89 e8 5d 41 5c 41 5d 41 5e 41 5f c3 81 e3 00 00 10 00 75 0e 4d 89 fe <41> f6 47 0b 04 0f 84 6c ff ff ff 4c 89 ff e8 cc da 01 00 49 89 c6
> > > >    RSP: 0018:ffffa2b8c773f9d0 EFLAGS: 00010246
> > > >    RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000005
> > > >    RDX: 0000000000000004 RSI: 00000000006080c0 RDI: 0000000000000000
> > > >    RBP: ffff8ea0a8634fd0 R08: ffffa2b8c773f988 R09: 00000000006000c0
> > > >    R10: 0000000000000000 R11: 0000000000000230 R12: 00000000006080c0
> > > >    R13: ffffffffc0a97fc8 R14: 0000000000000000 R15: 0000000000000000
> > > >    FS:  00007f9138ed9740(0000) GS:ffff8ea4ae800000(0000) knlGS:0000000000000000
> > > >    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > >    CR2: 000000000000000b CR3: 000000046d59a000 CR4: 00000000003406e0
> > > >    Call Trace:
> > > >     rxe_alloc+0xc8/0x160 [rdma_rxe]
> > > >     rxe_get_dma_mr+0x25/0xb0 [rdma_rxe]
> > > >     __ib_alloc_pd+0xcb/0x160 [ib_core]
> > > >     ib_mad_init_device+0x296/0x8b0 [ib_core]
> > > >     add_client_context+0x11a/0x160 [ib_core]
> > > >     enable_device_and_get+0xdc/0x1d0 [ib_core]
> > > >     ib_register_device+0x572/0x6b0 [ib_core]
> > > >     ? crypto_create_tfm+0x32/0xe0
> > > >     ? crypto_create_tfm+0x7a/0xe0
> > > >     ? crypto_alloc_tfm+0x58/0xf0
> > > >     rxe_register_device+0x19d/0x1c0 [rdma_rxe]
> > > >     rxe_net_add+0x3d/0x70 [rdma_rxe]
> > > >     ? dev_get_by_name_rcu+0x73/0x90
> > > >     rxe_param_set_add+0xaf/0xc0 [rdma_rxe]
> > > >     parse_args+0x179/0x370
> > > >     ? ref_module+0x1b0/0x1b0
> > > >     load_module+0x135e/0x17e0
> > > >     ? ref_module+0x1b0/0x1b0
> > > >     ? __do_sys_init_module+0x13b/0x180
> > > >     __do_sys_init_module+0x13b/0x180
> > > >     do_syscall_64+0x5b/0x1a0
> > > >     entry_SYSCALL_64_after_hwframe+0x65/0xca
> > > >    RIP: 0033:0x7f9137ed296e
> > > > 
> > > > Fixes: 8700e3e7c485 ("Soft RoCE driver")
> > > > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > > > ---
> > > >    drivers/infiniband/sw/rxe/rxe.c       | 14 +++++++-------
> > > >    drivers/infiniband/sw/rxe/rxe_pool.c  |  3 +++
> > > >    drivers/infiniband/sw/rxe/rxe_sysfs.c |  7 +++++++
> > > >    3 files changed, 17 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> > > > index 5642eefb4ba1..60d5086dd34d 100644
> > > > --- a/drivers/infiniband/sw/rxe/rxe.c
> > > > +++ b/drivers/infiniband/sw/rxe/rxe.c
> > > > @@ -318,6 +318,13 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
> > > >    		goto err;
> > > >    	}
> > > > +	/* initialize slab caches for managed objects */
> > > > +	err = rxe_cache_init();
> > > > +	if (err) {
> > > > +		pr_err("unable to init object pools\n");
> > > > +		goto err;
> > > > +	}
> > > > +
> > > >    	err = rxe_net_add(ibdev_name, ndev);
> > > >    	if (err) {
> > > >    		pr_err("failed to add %s\n", ndev->name);
> > > > @@ -336,13 +343,6 @@ static int __init rxe_module_init(void)
> > > >    {
> > > >    	int err;
> > > > -	/* initialize slab caches for managed objects */
> > > > -	err = rxe_cache_init();
> 
> When modprobe rdma_rxe, rxe_module_init should be called. Then
> rxe_cache_init should be also called.
> 
> Why does the above call trace occur?
> 
> Zhu Yanjun
>

As you can see in the call trace attached to the commit message, When
running the "modprobe rdma_rxe add=eno1" command the rxe_param_set_add()
is called before rxe_module_init() (without init the caches), so the
call trace occurs when trying to register the allocated rxe device from
the context of rxe_param_set_add() without initialize the caches.

Thanks,
Kamal

> > > > -	if (err) {
> > > > -		pr_err("unable to init object pools\n");
> > > > -		return err;
> > > > -	}
> > > > -
> > > >    	err = rxe_net_init();
> > > >    	if (err)
> > > >    		return err;
> > > > diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> > > > index fbcbac52290b..06c6d1f835b7 100644
> > > > --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> > > > +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> > > > @@ -139,6 +139,9 @@ int rxe_cache_init(void)
> > > >    	for (i = 0; i < RXE_NUM_TYPES; i++) {
> > > >    		type = &rxe_type_info[i];
> > > >    		size = ALIGN(type->size, RXE_POOL_ALIGN);
> > > > +		if (type->cache)
> > > > +			continue;
> > > > +
> > > >    		if (!(type->flags & RXE_POOL_NO_ALLOC)) {
> > > >    			type->cache =
> > > >    				kmem_cache_create(type->name, size,
> > > > diff --git a/drivers/infiniband/sw/rxe/rxe_sysfs.c b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> > > > index ccda5f5a3bc0..d0af48ba0110 100644
> > > > --- a/drivers/infiniband/sw/rxe/rxe_sysfs.c
> > > > +++ b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> > > > @@ -81,6 +81,13 @@ static int rxe_param_set_add(const char *val, const struct kernel_param *kp)
> > > >    		goto err;
> > > >    	}
> > > > +	/* initialize slab caches for managed objects */
> > > > +	err = rxe_cache_init();
> > > > +	if (err) {
> > > > +		pr_err("unable to init object pools\n");
> > > > +		goto err;
> > > > +	}
> > > > +
> > > >    	err = rxe_net_add("rxe%d", ndev);
> > > >    	if (err) {
> > > >    		pr_err("failed to add %s\n", intf);
> > > 
> 
