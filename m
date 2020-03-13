Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5AB218482B
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 14:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgCMNbS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 09:31:18 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40327 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgCMNbS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 09:31:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id n5so7441707qtv.7
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 06:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MT+D/yVil05s8jviALGlx07Y45/4YVEvBXc1yp1EOvg=;
        b=co+1nn5udgzewl8OpLr3oGgDWJxzDqx74xwjzh93W3J7XojrMwBjlCqrG7xp+3F0wX
         sT+S4+lrLURu6C+F1m05NJ13NHiI4DBvADrlbdnrwNiQAyfu5PYVwHvUKQzkxCJwJvdQ
         P30GNH/QLQhC/5IYabeyljd3HH+0ZCyEuPsxOr4JeT8ByMN9A++izUtVZyZhNavuTRnh
         jG4nx+HdeTaVPMiXtOKjEEFOT5Ve6pyAn7dYx4mT4lsQ56hB2+JAa6Q+3ddxDfG4GL85
         yfItfsKbD4hp9D8tZoKtUA1tQUtM+5SHkxWQoqDsu8OnexKiWE8Px6UH/EKF5o83ymcL
         /JcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MT+D/yVil05s8jviALGlx07Y45/4YVEvBXc1yp1EOvg=;
        b=GePbIGvuO20TgZ00CPe1mCvT0L6qh2BTaHSY5MfirLnLvaBnu8RHnEBKAdiJm3qQUr
         keQvOCOzVrazREorNfbWef7ElOUvuMwjMIC6ztxon2Nm6DeNsbsJCW8V+NYYa15NQ/0K
         9lkdz/R2wzweqwf4tzZUSayaV/o/GJmUTG6fwhcheI+OqOl0+esQa2HMzWyY51q5T2nd
         dL4DrzftH/RDfCOzymKp/nJ+L8p5IzRmGi+pXFnniBVLAEGgwhL9DD5T1ligrjxw/7ph
         orAy343iGTOKZ39aq5fRfh4DGPLu7I3fqp66RSwy4ZU84yf8Jo+29AZk0oxe2i0Yn69v
         NSQQ==
X-Gm-Message-State: ANhLgQ1BSxGIklS7gGaAKmR7nZSKwB8DPsLO0TWvQo6DYDd5ZMCzzLkI
        PmfCN6ylEaxlMj8lr5vkTjdUOKy7uxA=
X-Google-Smtp-Source: ADFU+vvVhvWEW1Ez/hKT6TmAQqf8TaX6x+Zrd2ANr4TmW6ViLg6y578XeimBwgrs9fFcEp3MmGAIQw==
X-Received: by 2002:ac8:310b:: with SMTP id g11mr2332441qtb.128.1584106276162;
        Fri, 13 Mar 2020 06:31:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id v80sm29186459qka.15.2020.03.13.06.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 06:31:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jCkPC-0004l4-HK; Fri, 13 Mar 2020 10:31:14 -0300
Date:   Fri, 13 Mar 2020 10:31:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     syzbot+da615ac67d4dbea32cbc@syzkaller.appspotmail.com
Subject: Re: [PATCH rc] RDMA/nl: Do not permit empty devices names during
 RDMA_NLDEV_CMD_NEWLINK/SET
Message-ID: <20200313133114.GA18232@ziepe.ca>
References: <20200309191648.GA30852@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309191648.GA30852@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 09, 2020 at 04:16:48PM -0300, Jason Gunthorpe wrote:
> Empty device names cannot be added to sysfs and crash with:
> 
>   kobject: (00000000f9de3792): attempted to be registered with empty name!
>   WARNING: CPU: 1 PID: 10856 at lib/kobject.c:234 kobject_add_internal+0x7ac/0x9a0 lib/kobject.c:234
>   Kernel panic - not syncing: panic_on_warn set ...
>   CPU: 1 PID: 10856 Comm: syz-executor459 Not tainted 5.6.0-rc3-syzkaller #0
>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>   Call Trace:
>    __dump_stack lib/dump_stack.c:77 [inline]
>    dump_stack+0x197/0x210 lib/dump_stack.c:118
>    panic+0x2e3/0x75c kernel/panic.c:221
>    __warn.cold+0x2f/0x3e kernel/panic.c:582
>    report_bug+0x289/0x300 lib/bug.c:195
>    fixup_bug arch/x86/kernel/traps.c:174 [inline]
>    fixup_bug arch/x86/kernel/traps.c:169 [inline]
>    do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
>    do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
>    invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
>   RIP: 0010:kobject_add_internal+0x7ac/0x9a0 lib/kobject.c:234
>   Code: 7a ca ca f9 e9 f0 f8 ff ff 4c 89 f7 e8 cd ca ca f9 e9 95 f9 ff ff e8 13 25 8c f9 4c 89 e6 48 c7 c7 a0 08 1a 89 e8 a3 76 5c f9 <0f> 0b 41 bd ea ff ff ff e9 52 ff ff ff e8 f2 24 8c f9 0f 0b e8 eb
>   RSP: 0018:ffffc90002006eb0 EFLAGS: 00010286
>   RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>   RDX: 0000000000000000 RSI: ffffffff815eae46 RDI: fffff52000400dc8
>   RBP: ffffc90002006f08 R08: ffff8880972ac500 R09: ffffed1015d26659
>   R10: ffffed1015d26658 R11: ffff8880ae9332c7 R12: ffff888093034668
>   R13: 0000000000000000 R14: ffff8880a69d7600 R15: 0000000000000001
>    kobject_add_varg lib/kobject.c:390 [inline]
>    kobject_add+0x150/0x1c0 lib/kobject.c:442
>    device_add+0x3be/0x1d00 drivers/base/core.c:2412
>    ib_register_device drivers/infiniband/core/device.c:1371 [inline]
>    ib_register_device+0x93e/0xe40 drivers/infiniband/core/device.c:1343
>    rxe_register_device+0x52e/0x655 drivers/infiniband/sw/rxe/rxe_verbs.c:1231
>    rxe_add+0x122b/0x1661 drivers/infiniband/sw/rxe/rxe.c:302
>    rxe_net_add+0x91/0xf0 drivers/infiniband/sw/rxe/rxe_net.c:539
>    rxe_newlink+0x39/0x90 drivers/infiniband/sw/rxe/rxe.c:318
>    nldev_newlink+0x28a/0x430 drivers/infiniband/core/nldev.c:1538
>    rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:195 [inline]
>    rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>    rdma_nl_rcv+0x5d9/0x980 drivers/infiniband/core/netlink.c:259
>    netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
>    netlink_unicast+0x59e/0x7e0 net/netlink/af_netlink.c:1329
>    netlink_sendmsg+0x91c/0xea0 net/netlink/af_netlink.c:1918
>    sock_sendmsg_nosec net/socket.c:652 [inline]
>    sock_sendmsg+0xd7/0x130 net/socket.c:672
>    ____sys_sendmsg+0x753/0x880 net/socket.c:2343
>    ___sys_sendmsg+0x100/0x170 net/socket.c:2397
>    __sys_sendmsg+0x105/0x1d0 net/socket.c:2430
>    __do_sys_sendmsg net/socket.c:2439 [inline]
>    __se_sys_sendmsg net/socket.c:2437 [inline]
>    __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2437
>    do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Prevent empty names when checking the name provided from userspace during
> newlink and rename.
> 
> Cc: stable@kernel.org
> Fixes: 3856ec4b93c9 ("RDMA/core: Add RDMA_NLDEV_CMD_NEWLINK/DELLINK support")
> Fixes: 05d940d3a3ec ("RDMA/nldev: Allow IB device rename through RDMA netlink")
> Reported-by: syzbot+da615ac67d4dbea32cbc@syzkaller.appspotmail.com
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/nldev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc

Jason
