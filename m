Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352281E8C78
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2020 02:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgE3ANg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 May 2020 20:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgE3ANf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 May 2020 20:13:35 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A31BC03E969
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 17:13:35 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id q14so3207600qtr.9
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 17:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BB7q8j3uCCC8/ultcQGLSpK4vao4QQcxtlnaqtT1Ok4=;
        b=iBoMdsgKOpjOPpZSbx8c+EbAA7EDn5DGFRBJXalhqPDNp2TsPL4svfDhpjPkzQi2AH
         2cfokxfCO/laduXwRw4Sz7QHoJiUChgl84wZPfv9abA5n6xzFp2L9gVH/GIQ79Rn5YUQ
         Oplq7Dk/rJxTUKP86Lwdi/Eoec1Ho1bY70bdVu8r1w5pOeUyUV4G4uTLZz6VjzL8Zeu3
         sIY37v48t83rfQVvJ2DVN/HlEAsag+KWLafV4tkvMnaWk/pdpVxTLoQhtIj+PIcQsRP7
         FWT4PqCTBJAFRMev68PbMmTwKiBO84vas9O/nGyvyXMBAEshtnZVgaGargMLmcEfkMks
         UsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BB7q8j3uCCC8/ultcQGLSpK4vao4QQcxtlnaqtT1Ok4=;
        b=HjJhPkpMYeqkrfBJSBPK9UBCyg8IL2cmTa276VfNa4kibDl/ZGWUQi5cRWjHW2t5K5
         ShmRmCOpCgJnYK0G1kFWOj0nhpIKs0GWq2htFaGBOPzdQicpUR+/7VwmxMK8GxnpTmZM
         65Cv4Z/nsZYp1u8Bqpsh4ixqXCFjFQeh20dNh/uUV5lyf+5WN5zLbMTeoEWvlMu1ULrz
         UF1N82OoYjBRBTpt1i+WQvyA6pgcvcewgDiu/tgBkTS7P9wkMMCBaHsA5j/dPnIF8LQ/
         Mc7XCF94u0yELS4KZXGd9yPSsbsKmL6G2/V/dCnwCCyL1iQH5/Ku4AcUxrlDH+UjIxMy
         lvRg==
X-Gm-Message-State: AOAM532dImliZSEZEr4s0SUScQyM8GZjJlLqtnee5/hI51ESGXfw9ZPQ
        Fi4WuezLwH5nSsIWA4ca9DN3Jg==
X-Google-Smtp-Source: ABdhPJxckRZyUIIGhQlVm3p3u6CjBHHyaol6clFYDvHkZ+OW8FjSOTXeYOsyIQS7T+4alCYXk6EV2Q==
X-Received: by 2002:ac8:2aed:: with SMTP id c42mr6110172qta.202.1590797614242;
        Fri, 29 May 2020 17:13:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id p12sm7722524qkp.129.2020.05.29.17.13.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 17:13:33 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jep80-0002G2-Ue; Fri, 29 May 2020 21:13:32 -0300
Date:   Fri, 29 May 2020 21:13:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+478fd0d54412b8759e0d@syzkaller.appspotmail.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, michal.kalderon@marvell.com,
        syzkaller-bugs@googlegroups.com, yishaih@mellanox.com
Subject: Re: KASAN: use-after-free Read in ib_uverbs_remove_one
Message-ID: <20200530001332.GD21651@ziepe.ca>
References: <00000000000095442505a6b63551@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000095442505a6b63551@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 28, 2020 at 07:33:16AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    c11d28ab Add linux-next specific files for 20200522
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12fc3e72100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3f6dbdea4159fb66
> dashboard link: https://syzkaller.appspot.com/bug?extid=478fd0d54412b8759e0d
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+478fd0d54412b8759e0d@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in ib_uverbs_remove_one+0x411/0x4e0 drivers/infiniband/core/uverbs_main.c:1210
> Read of size 4 at addr ffff888096324578 by task syz-executor.2/15847
> 
> CPU: 1 PID: 15847 Comm: syz-executor.2 Not tainted 5.7.0-rc6-next-20200522-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x18f/0x20d lib/dump_stack.c:118
>  print_address_description.constprop.0.cold+0xd3/0x413 mm/kasan/report.c:383
>  __kasan_report mm/kasan/report.c:513 [inline]
>  kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
>  ib_uverbs_remove_one+0x411/0x4e0 drivers/infiniband/core/uverbs_main.c:1210
>  remove_client_context+0xbe/0x110 drivers/infiniband/core/device.c:732
>  disable_device+0x13b/0x230 drivers/infiniband/core/device.c:1278
>  __ib_unregister_device+0x91/0x180 drivers/infiniband/core/device.c:1445
>  ib_unregister_device_and_put+0x57/0x80 drivers/infiniband/core/device.c:1508
>  nldev_dellink+0x20a/0x310 drivers/infiniband/core/nldev.c:1571
>  rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:195 [inline]
>  rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>  rdma_nl_rcv+0x586/0x900 drivers/infiniband/core/netlink.c:259
>  netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
>  netlink_unicast+0x537/0x740 net/netlink/af_netlink.c:1329
>  netlink_sendmsg+0x882/0xe10 net/netlink/af_netlink.c:1918
>  sock_sendmsg_nosec net/socket.c:652 [inline]
>  sock_sendmsg+0xcf/0x120 net/socket.c:672
>  ____sys_sendmsg+0x6e6/0x810 net/socket.c:2352
>  ___sys_sendmsg+0x100/0x170 net/socket.c:2406
>  __sys_sendmsg+0xe5/0x1b0 net/socket.c:2439
>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
>  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> RIP: 0033:0x45ca29
> Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fd6764d1c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00000000004ffa00 RCX: 000000000045ca29
> RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000000000003
> RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000000009af R14: 00000000004d61b0 R15: 00007fd6764d26d4
> 
> Allocated by task 9061:
>  save_stack+0x1b/0x40 mm/kasan/common.c:48
>  set_track mm/kasan/common.c:56 [inline]
>  __kasan_kmalloc mm/kasan/common.c:494 [inline]
>  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:467
>  kmem_cache_alloc_trace+0x153/0x7d0 mm/slab.c:3551
>  kmalloc include/linux/slab.h:555 [inline]
>  kzalloc include/linux/slab.h:669 [inline]
>  ib_uverbs_add_one+0x80/0x7c0 drivers/infiniband/core/uverbs_main.c:1107
>  add_client_context+0x400/0x5e0 drivers/infiniband/core/device.c:677
>  enable_device_and_get+0x1cd/0x3b0 drivers/infiniband/core/device.c:1326
>  ib_register_device drivers/infiniband/core/device.c:1392 [inline]
>  ib_register_device+0xa12/0xda0 drivers/infiniband/core/device.c:1353
>  siw_device_register drivers/infiniband/sw/siw/siw_main.c:70 [inline]
>  siw_newlink drivers/infiniband/sw/siw/siw_main.c:565 [inline]
>  siw_newlink+0xd37/0x1240 drivers/infiniband/sw/siw/siw_main.c:542
>  nldev_newlink+0x29e/0x420 drivers/infiniband/core/nldev.c:1541
>  rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:195 [inline]
>  rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>  rdma_nl_rcv+0x586/0x900 drivers/infiniband/core/netlink.c:259
>  netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
>  netlink_unicast+0x537/0x740 net/netlink/af_netlink.c:1329
>  netlink_sendmsg+0x882/0xe10 net/netlink/af_netlink.c:1918
>  sock_sendmsg_nosec net/socket.c:652 [inline]
>  sock_sendmsg+0xcf/0x120 net/socket.c:672
>  ____sys_sendmsg+0x6e6/0x810 net/socket.c:2352
>  ___sys_sendmsg+0x100/0x170 net/socket.c:2406
>  __sys_sendmsg+0xe5/0x1b0 net/socket.c:2439
>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
>  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> 
> Freed by task 15847:
>  save_stack+0x1b/0x40 mm/kasan/common.c:48
>  set_track mm/kasan/common.c:56 [inline]
>  kasan_set_free_info mm/kasan/common.c:316 [inline]
>  __kasan_slab_free+0xf7/0x140 mm/kasan/common.c:455
>  __cache_free mm/slab.c:3426 [inline]
>  kfree+0x109/0x2b0 mm/slab.c:3757
>  device_release+0x71/0x200 drivers/base/core.c:1541
>  kobject_cleanup lib/kobject.c:701 [inline]
>  kobject_release lib/kobject.c:732 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x1c8/0x2f0 lib/kobject.c:749
>  cdev_device_del+0x69/0x80 fs/char_dev.c:575
>  ib_uverbs_remove_one+0x31/0x4e0 drivers/infiniband/core/uverbs_main.c:1209

I still can't figure out how this is possible, but I can say
cdev_device_del should not be freeing this memory - it can only mean
the uverbs_dev->dev.kref has become put several more times than it
should have.

Hopefully syzkaller will hit a refcount underflow and tell us where as
I checked every put_device obviously connected to uverbs_dev and found
nothing..

Jason
