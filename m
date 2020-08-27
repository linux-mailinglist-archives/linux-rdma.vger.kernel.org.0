Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8222D2546D2
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 16:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgH0OaK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 10:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgH0OaA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 10:30:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F11C06121B
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 07:29:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so5597604wrl.4
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KMR6gPKx4Iusd775broNtcC5EoDFrRdaHB14KOj+7Q4=;
        b=TOfH5BijQEVvcWtU0GoVnKbJmwIyg6N5WBw53XWdIE6WZ7thpzMqpE/MwsdjfACVbY
         XqEerat/XMmBJCsPttDenNqB51a56KnoY6NpoCnP74MQBOowVJL04+Dg8/HyhT7ItV1r
         66SgaHPr6ExHkgAs3/DFZP98gU/kkSpNX9xxcBNahn1Ferpx4JE9qBFMQ79uTckK1Lq+
         L+kU4tttS02csI8Qpg6KVQA7RBL73O/1SGm0JMAeVwaKidtdvAvIjfUhVjtiAHPyPplU
         vWZfZA2prmfqnz8ZjVn/Za/HAUocFopZYHvD/nvXrzuqwf5FmkoT6ATohXTDnUA9KU9g
         mEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KMR6gPKx4Iusd775broNtcC5EoDFrRdaHB14KOj+7Q4=;
        b=RE8kFu815tR70EcIxSrJd/1pfn+TPg2A/rwapi05OJ+g54KxtbGLx2JGK1R0ZGpEdu
         D5H6VaHwoxuJWcYjnB3q/9v6tgLA07IM3A1Gcq91FU54GwX7w8hS7+7c4IC7iWC3mQMu
         YyijGapHi/WfikcFwbAr7hou5u285XGHt0W5HpjE28ZqmTvwFoTnSC6Tw+ujy3pjBeWo
         zuV3do1XpY9RyGu9DruAA1Vw+VXtwV8w5XQfpoeC6zjhIpelp8Pd7TCFPW0IBsWXMIWo
         kWEb0ARtpdUlW/PuUv7hyp+R4LBu0eCqSPHybcYcG2k7l7CRcX/DcCiXwCCH6DOkuDbs
         THpQ==
X-Gm-Message-State: AOAM53056pGYZUXXmI9aarP5LVAVAt7JxOKGHd9FIf4SoMmCn7vEXB1I
        jMOPKCZsaYixOgnxpAj5JNy46XsCkvs=
X-Google-Smtp-Source: ABdhPJyhmq8ru/r1ixoAajw00UasH53/lREHKOcOLwlm/a9mhxIHOZiR/yDuQHBix6rvGeg6PDE2wQ==
X-Received: by 2002:adf:e30e:: with SMTP id b14mr20080041wrj.215.1598538598554;
        Thu, 27 Aug 2020 07:29:58 -0700 (PDT)
Received: from kheib-workstation ([37.142.0.228])
        by smtp.gmail.com with ESMTPSA id n18sm6112940wrp.58.2020.08.27.07.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 07:29:57 -0700 (PDT)
Date:   Thu, 27 Aug 2020 17:29:55 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH v4 for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
Message-ID: <20200827142955.GA406793@kheib-workstation>
References: <20200825151725.254046-1-kamalheib1@gmail.com>
 <20200827121822.GA4014126@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827121822.GA4014126@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 27, 2020 at 09:18:22AM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 25, 2020 at 06:17:25PM +0300, Kamal Heib wrote:
> > To avoid the following kernel panic when calling kmem_cache_create()
> > with a NULL pointer from pool_cache(), Block the rxe_param_set_add()
> > from running if the rdma_rxe module is not initialized.
> > 
> >  BUG: unable to handle kernel NULL pointer dereference at 000000000000000b
> >  PGD 0 P4D 0
> >  Oops: 0000 [#1] SMP NOPTI
> >  CPU: 4 PID: 8512 Comm: modprobe Kdump: loaded Not tainted 4.18.0-231.el8.x86_64 #1
> >  Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 10/02/2018
> >  RIP: 0010:kmem_cache_alloc+0xd1/0x1b0
> >  Code: 8b 57 18 45 8b 77 1c 48 8b 5c 24 30 0f 1f 44 00 00 5b 48 89 e8 5d 41 5c 41 5d 41 5e 41 5f c3 81 e3 00 00 10 00 75 0e 4d 89 fe <41> f6 47 0b 04 0f 84 6c ff ff ff 4c 89 ff e8 cc da 01 00 49 89 c6
> >  RSP: 0018:ffffa2b8c773f9d0 EFLAGS: 00010246
> >  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000005
> >  RDX: 0000000000000004 RSI: 00000000006080c0 RDI: 0000000000000000
> >  RBP: ffff8ea0a8634fd0 R08: ffffa2b8c773f988 R09: 00000000006000c0
> >  R10: 0000000000000000 R11: 0000000000000230 R12: 00000000006080c0
> >  R13: ffffffffc0a97fc8 R14: 0000000000000000 R15: 0000000000000000
> >  FS:  00007f9138ed9740(0000) GS:ffff8ea4ae800000(0000) knlGS:0000000000000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 000000000000000b CR3: 000000046d59a000 CR4: 00000000003406e0
> >  Call Trace:
> >   rxe_alloc+0xc8/0x160 [rdma_rxe]
> >   rxe_get_dma_mr+0x25/0xb0 [rdma_rxe]
> >   __ib_alloc_pd+0xcb/0x160 [ib_core]
> >   ib_mad_init_device+0x296/0x8b0 [ib_core]
> >   add_client_context+0x11a/0x160 [ib_core]
> >   enable_device_and_get+0xdc/0x1d0 [ib_core]
> >   ib_register_device+0x572/0x6b0 [ib_core]
> >   ? crypto_create_tfm+0x32/0xe0
> >   ? crypto_create_tfm+0x7a/0xe0
> >   ? crypto_alloc_tfm+0x58/0xf0
> >   rxe_register_device+0x19d/0x1c0 [rdma_rxe]
> >   rxe_net_add+0x3d/0x70 [rdma_rxe]
> >   ? dev_get_by_name_rcu+0x73/0x90
> >   rxe_param_set_add+0xaf/0xc0 [rdma_rxe]
> >   parse_args+0x179/0x370
> >   ? ref_module+0x1b0/0x1b0
> >   load_module+0x135e/0x17e0
> >   ? ref_module+0x1b0/0x1b0
> >   ? __do_sys_init_module+0x13b/0x180
> >   __do_sys_init_module+0x13b/0x180
> >   do_syscall_64+0x5b/0x1a0
> >   entry_SYSCALL_64_after_hwframe+0x65/0xca
> >  RIP: 0033:0x7f9137ed296e
> > 
> > Fixes: 8700e3e7c485 ("Soft RoCE driver")
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > ---
> >  drivers/infiniband/sw/rxe/rxe.c       | 4 ++++
> >  drivers/infiniband/sw/rxe/rxe.h       | 2 ++
> >  drivers/infiniband/sw/rxe/rxe_sysfs.c | 5 +++++
> >  3 files changed, 11 insertions(+)
> 
> Can you send a PR to rdma-core to delete rxe_cfg as well? In
> preperation to remove the module parameters
>

Someone already did that :-)

commit 0d2ff0e1502ebc63346bc9ffd37deb3c4fd0dbc9
Author: Jason Gunthorpe <jgg@ziepe.ca>
Date:   Tue Jan 28 15:53:07 2020 -0400

    rxe: Remove rxe_cfg

    This is obsoleted by iproute2's 'rdma link add' command.

    Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Thanks,
Kamal

> Applied to for-rc
> 
> Thanks,
> Jason
