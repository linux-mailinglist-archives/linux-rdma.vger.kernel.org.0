Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05B22459CD
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Aug 2020 00:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgHPWMv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Aug 2020 18:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgHPWMm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Aug 2020 18:12:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CCFC061786
        for <linux-rdma@vger.kernel.org>; Sun, 16 Aug 2020 15:12:41 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so12403138wme.4
        for <linux-rdma@vger.kernel.org>; Sun, 16 Aug 2020 15:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O4F2AYLQy8LOM5tD4F3KBNtU/QZhBW6A0VPwarbcDMM=;
        b=QvivdCH9gBnGl0fk2KTmfoa+sWGZ2UTrwjSeKIdoceWIfMPePSjAz0U4xrar0QmT3f
         zsy9otYUq22l8K3b1UC5XouYyr1TbBcGSjgil9GgvK7FeKy5r7ZLPmkMGPwYhAonyAQN
         QUfWzKx2YuAJ8zpTB33p/Eu87xuS7LkA7A/KgbNk0xqVZiAakLFivn4DZqUgeDkXaGEl
         Ua6ZvgzL6bv0FiPYQh6QP1UXSRb32R7U9fCfWx6UKeBk73nq3WYczthKA5dw70+I4D0r
         oe0KBQsOSWOz9ubDvAKe7dvpqdkHft365pRX1mGWyMTyXQsCx7bN1zSKl2LhUbbL+eBj
         oftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O4F2AYLQy8LOM5tD4F3KBNtU/QZhBW6A0VPwarbcDMM=;
        b=stHep3OiKdLsEk50RqXhsot26dIqpQ6q1AkFI8+qTqHnY9GjTN6t02gQXCLmQ6EJ0x
         HTuXl0vz+V/jKtDAWfw8ADMFvxfuSR12qQc0sBcv180A8VHAdAAsYBX45HrsjjgP/kbd
         4Kc/pHLN4IR6YIJSW0G9MVksWWIVGHNTe/B8Ny8NyTfmSpPHBmBsli1zCUdHecHmIOQu
         C/9fopzFp+ec2bpci3UVnwHmHFObZg3iyqzKRjAihqbOn6tuRGh/1k3kABS3vGbX3Lts
         1IsoWzWo65eegLE1IX37eWm2wBNsBizo7nlG7VzXEPcQVGJW9vPZwy61PlRXRGdc0DeV
         oewA==
X-Gm-Message-State: AOAM531R0IUlwMRbV0csutbVgbYfVMEvP24v+xu17IF2E3dYPKzmxLDB
        oVIpp1b0n8V0NgHqLSwbTPh+wE7vCrPCpg==
X-Google-Smtp-Source: ABdhPJx+APdZ/cnbq3fmpuZxUmZwGM6XX9q2D5rGV1KXf/9y+X+bTywutnPB5XA2DYBFg4/TX1trlQ==
X-Received: by 2002:a1c:7405:: with SMTP id p5mr11839225wmc.130.1597615960185;
        Sun, 16 Aug 2020 15:12:40 -0700 (PDT)
Received: from kheib-workstation ([77.137.118.46])
        by smtp.gmail.com with ESMTPSA id i9sm27715814wmb.11.2020.08.16.15.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 15:12:39 -0700 (PDT)
Date:   Mon, 17 Aug 2020 01:12:36 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
Message-ID: <20200816221236.GA821081@kheib-workstation>
References: <20200812111447.256822-1-kamalheib1@gmail.com>
 <9701a68d-c377-474a-5f65-c4e045a67e11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9701a68d-c377-474a-5f65-c4e045a67e11@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Aug 15, 2020 at 02:58:45PM +0800, Zhu Yanjun wrote:
> On 8/12/2020 7:14 PM, Kamal Heib wrote:
> > To avoid the following kernel panic when calling kmem_cache_create()
> > with a NULL pointer from pool_cache(),
> 
> What is the root cause of this kernel panic?
>

The kernel panic is triggered using the following command and it happen
because the cache is not getting initialized.

modprobe rdma_rxe add=eno1

Thanks,
Kamal

> Zhu Yanjun
> 
> >   move the rxe_cache_init() to the
> > context of device creation.
> > 
> >   BUG: unable to handle kernel NULL pointer dereference at 000000000000000b
> >   PGD 0 P4D 0
> >   Oops: 0000 [#1] SMP NOPTI
> >   CPU: 4 PID: 8512 Comm: modprobe Kdump: loaded Not tainted 4.18.0-231.el8.x86_64 #1
> >   Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 10/02/2018
> >   RIP: 0010:kmem_cache_alloc+0xd1/0x1b0
> >   Code: 8b 57 18 45 8b 77 1c 48 8b 5c 24 30 0f 1f 44 00 00 5b 48 89 e8 5d 41 5c 41 5d 41 5e 41 5f c3 81 e3 00 00 10 00 75 0e 4d 89 fe <41> f6 47 0b 04 0f 84 6c ff ff ff 4c 89 ff e8 cc da 01 00 49 89 c6
> >   RSP: 0018:ffffa2b8c773f9d0 EFLAGS: 00010246
> >   RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000005
> >   RDX: 0000000000000004 RSI: 00000000006080c0 RDI: 0000000000000000
> >   RBP: ffff8ea0a8634fd0 R08: ffffa2b8c773f988 R09: 00000000006000c0
> >   R10: 0000000000000000 R11: 0000000000000230 R12: 00000000006080c0
> >   R13: ffffffffc0a97fc8 R14: 0000000000000000 R15: 0000000000000000
> >   FS:  00007f9138ed9740(0000) GS:ffff8ea4ae800000(0000) knlGS:0000000000000000
> >   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   CR2: 000000000000000b CR3: 000000046d59a000 CR4: 00000000003406e0
> >   Call Trace:
> >    rxe_alloc+0xc8/0x160 [rdma_rxe]
> >    rxe_get_dma_mr+0x25/0xb0 [rdma_rxe]
> >    __ib_alloc_pd+0xcb/0x160 [ib_core]
> >    ib_mad_init_device+0x296/0x8b0 [ib_core]
> >    add_client_context+0x11a/0x160 [ib_core]
> >    enable_device_and_get+0xdc/0x1d0 [ib_core]
> >    ib_register_device+0x572/0x6b0 [ib_core]
> >    ? crypto_create_tfm+0x32/0xe0
> >    ? crypto_create_tfm+0x7a/0xe0
> >    ? crypto_alloc_tfm+0x58/0xf0
> >    rxe_register_device+0x19d/0x1c0 [rdma_rxe]
> >    rxe_net_add+0x3d/0x70 [rdma_rxe]
> >    ? dev_get_by_name_rcu+0x73/0x90
> >    rxe_param_set_add+0xaf/0xc0 [rdma_rxe]
> >    parse_args+0x179/0x370
> >    ? ref_module+0x1b0/0x1b0
> >    load_module+0x135e/0x17e0
> >    ? ref_module+0x1b0/0x1b0
> >    ? __do_sys_init_module+0x13b/0x180
> >    __do_sys_init_module+0x13b/0x180
> >    do_syscall_64+0x5b/0x1a0
> >    entry_SYSCALL_64_after_hwframe+0x65/0xca
> >   RIP: 0033:0x7f9137ed296e
> > 
> > Fixes: 8700e3e7c485 ("Soft RoCE driver")
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > ---
> >   drivers/infiniband/sw/rxe/rxe.c       | 14 +++++++-------
> >   drivers/infiniband/sw/rxe/rxe_pool.c  |  3 +++
> >   drivers/infiniband/sw/rxe/rxe_sysfs.c |  7 +++++++
> >   3 files changed, 17 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> > index 5642eefb4ba1..60d5086dd34d 100644
> > --- a/drivers/infiniband/sw/rxe/rxe.c
> > +++ b/drivers/infiniband/sw/rxe/rxe.c
> > @@ -318,6 +318,13 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
> >   		goto err;
> >   	}
> > +	/* initialize slab caches for managed objects */
> > +	err = rxe_cache_init();
> > +	if (err) {
> > +		pr_err("unable to init object pools\n");
> > +		goto err;
> > +	}
> > +
> >   	err = rxe_net_add(ibdev_name, ndev);
> >   	if (err) {
> >   		pr_err("failed to add %s\n", ndev->name);
> > @@ -336,13 +343,6 @@ static int __init rxe_module_init(void)
> >   {
> >   	int err;
> > -	/* initialize slab caches for managed objects */
> > -	err = rxe_cache_init();
> > -	if (err) {
> > -		pr_err("unable to init object pools\n");
> > -		return err;
> > -	}
> > -
> >   	err = rxe_net_init();
> >   	if (err)
> >   		return err;
> > diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> > index fbcbac52290b..06c6d1f835b7 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> > @@ -139,6 +139,9 @@ int rxe_cache_init(void)
> >   	for (i = 0; i < RXE_NUM_TYPES; i++) {
> >   		type = &rxe_type_info[i];
> >   		size = ALIGN(type->size, RXE_POOL_ALIGN);
> > +		if (type->cache)
> > +			continue;
> > +
> >   		if (!(type->flags & RXE_POOL_NO_ALLOC)) {
> >   			type->cache =
> >   				kmem_cache_create(type->name, size,
> > diff --git a/drivers/infiniband/sw/rxe/rxe_sysfs.c b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> > index ccda5f5a3bc0..d0af48ba0110 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_sysfs.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> > @@ -81,6 +81,13 @@ static int rxe_param_set_add(const char *val, const struct kernel_param *kp)
> >   		goto err;
> >   	}
> > +	/* initialize slab caches for managed objects */
> > +	err = rxe_cache_init();
> > +	if (err) {
> > +		pr_err("unable to init object pools\n");
> > +		goto err;
> > +	}
> > +
> >   	err = rxe_net_add("rxe%d", ndev);
> >   	if (err) {
> >   		pr_err("failed to add %s\n", intf);
> 
> 
