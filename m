Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF091E4BD7
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2020 19:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgE0R2B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 13:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgE0R2B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 May 2020 13:28:01 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EE1C03E97D
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2020 10:28:00 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id q18so3746798ilm.5
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2020 10:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mJAkm/2glEiVLs0Ct0lkiS6x+JgNDyigN2yFHX3K2js=;
        b=hhY3TpH+TZ3+Tkc+ob7mJiR3my/FqUDcUmTYBKHpNS/JdwD/z7WSqipuTmgYoKTIdB
         6dlB3ls/wzXKCFT9gseVeYAiIHCQw4Go4o20Tq2/xvJjf88tfePrpn1bn+EPCcTRL4Vp
         n1lShewm6vSoAg2FfSYmKoOI8Pd6+47cVIPKOS0VXlY4TglgN3RS4+c+CpHw2zzWR+JM
         5aDuyWvZH0iSZ6hCCdiDUV0IIwrjPtCv2OBwO+nl7VeqRKcKxoJHkoRv32nzc3QVRYbf
         27EPiLN4Wz0S5Yutk2cRI1SzAdPGNdGloHzDY+I9sOJD2vvc9tThioHG1g5kO7absuqA
         yqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mJAkm/2glEiVLs0Ct0lkiS6x+JgNDyigN2yFHX3K2js=;
        b=oalB6rdSXiYXo2RVQiFW8fxQdDcKSpTKonlCan5kAMhbWIAXSGZKnyU5+pGtQbkHz0
         gaHp2tEtNgSwtOmaL0coD/tLg3iWWmYEQORXijyneuKVr8MLOfUPm0CA3mzpQJ9XLLlu
         YKZmHvj2Ipi6IY8XD5OIQb3m+xGtc4xQiNswLvBGHiOrdZKZoZMrDHNNCfcAkh/smOdO
         UVKAkXF/VKV+sQUUM8IqdaZ5DMs16AdSRbuqw8F8f2EadalywrfYDfxm0+xDrMAqeAeN
         iIdZI/d2G3ONEOFoeedIRu0Le4gW4lDr1q2E1lsdcPogITPYs0vmku+CSmmFZPZLUcyy
         V2pw==
X-Gm-Message-State: AOAM533/P4Oagro6Uo4qvuKYjyk/EWjaEK2AqKevqWbCDoPJNz5EkVCn
        Y3Mui3BzIX4qvGH8qenv9MlzXg==
X-Google-Smtp-Source: ABdhPJzzg7P9z334X8bMaG8dULruzUWEH80AjwBube8JI0ZfVweySJ6j7Fl4m1yghjb8grEexc1DTw==
X-Received: by 2002:a92:5a5d:: with SMTP id o90mr6706813ilb.206.1590600478864;
        Wed, 27 May 2020 10:27:58 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id p3sm1503171iog.31.2020.05.27.10.27.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 May 2020 10:27:58 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdzqP-0005w9-Gi; Wed, 27 May 2020 14:27:57 -0300
Date:   Wed, 27 May 2020 14:27:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/core: Fix double destruction of uobject
Message-ID: <20200527172757.GA22790@ziepe.ca>
References: <20200527135534.482279-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527135534.482279-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 27, 2020 at 04:55:34PM +0300, Leon Romanovsky wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> Fix use after free when user user space request uobject concurrently for
> the same object, within the RCU grace period.
> 
> In that case, remove_handle_idr_uobject() is called twice and we will have
> an extra put on the uobject which cause use after free.  Fix it by leaving
> the uobject write locked after it was removed from the idr.
> 
> Call to rdma_lookup_put_uobject with UVERBS_LOOKUP_DESTROY instead of
> UVERBS_LOOKUP_WRITE will do the work.
> 
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 0 PID: 1381 at lib/refcount.c:28 refcount_warn_saturate+0xfe/0x1a0
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 1381 Comm: syz-executor.0 Not tainted 5.5.0-rc3 #8
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  dump_stack+0x94/0xce
>  panic+0x234/0x56f
>  __warn+0x1cc/0x1e1
>  report_bug+0x200/0x310
>  fixup_bug.part.11+0x32/0x80
>  do_error_trap+0xd3/0x100
>  do_invalid_op+0x31/0x40
>  invalid_op+0x1e/0x30
> RIP: 0010:refcount_warn_saturate+0xfe/0x1a0
> Code: 0f 0b eb 9b e8 23 f6 6d ff 80 3d 6c d4 19 03 00 75 8d e8 15 f6 6d ff 48 c7 c7 c0 02 55 bd c6 05 57 d4 19 03 01 e8 a2 58 49 ff <0f> 0b e9 6e ff ff ff e8 f6 f5 6d ff 80 3d 42 d4 19 03 00 0f 85 5c
> RSP: 0018:ffffc90002df7b98 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffff88810f6a193c RCX: ffffffffba649009
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88811b0283cc
> RBP: 0000000000000003 R08: ffffed10236060e3 R09: ffffed10236060e3
> R10: 0000000000000001 R11: ffffed10236060e2 R12: ffff88810f6a193c
> R13: ffffc90002df7d60 R14: 0000000000000000 R15: ffff888116ae6a08
>  uverbs_uobject_put+0xfd/0x140
>  __uobj_perform_destroy+0x3d/0x60
>  ib_uverbs_close_xrcd+0x148/0x170
>  ib_uverbs_write+0xaa5/0xdf0
>  __vfs_write+0x7c/0x100
>  vfs_write+0x168/0x4a0
>  ksys_write+0xc8/0x200
>  do_syscall_64+0x9c/0x390
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x465b49
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f759d122c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000000000073bfa8 RCX: 0000000000465b49
> RDX: 000000000000000c RSI: 0000000020000080 RDI: 0000000000000003
> RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f759d1236bc
> R13: 00000000004ca27c R14: 000000000070de40 R15: 00000000ffffffff
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: 0x39400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> Fixes: 7452a3c745a2 ("IB/uverbs: Allow RDMA_REMOVE_DESTROY to work concurrently with disassociate")
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/rdma_core.c | 20 +++++++++++++-------
>  include/rdma/uverbs_std_types.h     |  2 +-
>  2 files changed, 14 insertions(+), 8 deletions(-)

Applied to for-rc, thanks

Jason
