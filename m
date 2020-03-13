Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B9818482C
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 14:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgCMNba (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 09:31:30 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42115 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgCMNba (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 09:31:30 -0400
Received: by mail-qk1-f196.google.com with SMTP id e11so12396654qkg.9
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 06:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F+DLY2+0HScyM8f6GeGB72MNJIQEOCLyyI+rWsPjjl4=;
        b=HdpkarQ7GxgEqqiPY5SQ3t39X1j01QG8LHuXimNd4LZ4eDucQpTbqpazj16TUkXbpN
         kCPYkx4GQInBPvyX3jxje5WjkbMWIOHlo+3vb/pEfNpd8TLHE/9G1Dl4vFzkDmcowZCD
         SMULk539gSw8fbf38oRB7i9/frKt1rAhOxeEdsKyi8iUYbtD8AGblDH7KSDOkMkw6Mkq
         5uO85UnuXZ0Bgf9HsPbitdkq0WInsJN67QPd5sonZXvaFmC9lbh3RlziWgE1mu1k71kP
         onWdDqtwYP+GgXyc88bgdvFgMA1gPmmehC7JbeaAsKAJg7a7CB/mfX3HSkW7rPU3jX8r
         29XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F+DLY2+0HScyM8f6GeGB72MNJIQEOCLyyI+rWsPjjl4=;
        b=id0IMZMrikKt01al8JCJ8+BvCsZzIk0vSf7VmyCWM/b3+Ynz2WMEzdicQq92hqXqjU
         s+DoCjKTp40sAwrOlir3XTklWVpIk2VbIQRm+RwxZU04ZFl6z/AB7kRqthqVx6geTKsc
         vQ0qIy5VBtCAnYcvF3w5AEjYnO8GzFutGZrV0Ud/+KFpo7BY2Uql3P7NqneXmrn+8X4o
         4i/ERhwtBmz22YQ+KjnB72KwwYXnBoaBp1lKuB3MKdgDaw6GNz/c12PBdewM/PbySEb1
         K7AvAF5AZEtcaRJzk0CBQxCX5QO81eUQ9GxUNYtDk62L0LN9VPmxvlMpyQv4V8TqGeKL
         Khvg==
X-Gm-Message-State: ANhLgQ2oGiugyiyJlk0c45maSD1+FtmUGEUDo5yLx4J8SlSBptJzPfyD
        Po/Oq2x6O07EXRVCifo76VaPK+6Ynvw=
X-Google-Smtp-Source: ADFU+vvNXw43gbn1/T2lJr3zCNeBB/Xp8//mf5zqj7r8aKgcdrCAvcw4Y+ALgsyHMrSY78mR3ecZgw==
X-Received: by 2002:a37:404d:: with SMTP id n74mr12916072qka.73.1584106288773;
        Fri, 13 Mar 2020 06:31:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d141sm9054605qke.68.2020.03.13.06.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 06:31:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jCkPP-0004lH-Oc; Fri, 13 Mar 2020 10:31:27 -0300
Date:   Fri, 13 Mar 2020 10:31:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, Parav Pandit <parav@mellanox.com>
Cc:     syzbot+ab4dae63f7d310641ded@syzkaller.appspotmail.com
Subject: Re: [PATCH rc] RDMA/core: Fix missing error check on dev_set_name()
Message-ID: <20200313133127.GB18232@ziepe.ca>
References: <20200309193200.GA10633@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309193200.GA10633@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 09, 2020 at 04:32:00PM -0300, Jason Gunthorpe wrote:
> If name memory allocation fails the name will be left empty and
> device_add_one() will crash:
> 
>   kobject: (0000000004952746): attempted to be registered with empty name!
>   WARNING: CPU: 0 PID: 329 at lib/kobject.c:234 kobject_add_internal+0x7ac/0x9a0 lib/kobject.c:234
>   Kernel panic - not syncing: panic_on_warn set ...
>   CPU: 0 PID: 329 Comm: syz-executor.5 Not tainted 5.6.0-rc2-syzkaller #0
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
>   Code: 1a 98 ca f9 e9 f0 f8 ff ff 4c 89 f7 e8 6d 98 ca f9 e9 95 f9 ff ff e8 c3 f0 8b f9 4c 89 e6 48 c7 c7 a0 0e 1a 89 e8 e3 41 5c f9 <0f> 0b 41 bd ea ff ff ff e9 52 ff ff ff e8 a2 f0 8b f9 0f 0b e8 9b
>   RSP: 0018:ffffc90005b27908 EFLAGS: 00010286
>   RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>   RDX: 0000000000040000 RSI: ffffffff815eae46 RDI: fffff52000b64f13
>   RBP: ffffc90005b27960 R08: ffff88805aeba480 R09: ffffed1015d06659
>   R10: ffffed1015d06658 R11: ffff8880ae8332c7 R12: ffff8880a37fd000
>   R13: 0000000000000000 R14: ffff888096691780 R15: 0000000000000001
>    kobject_add_varg lib/kobject.c:390 [inline]
>    kobject_add+0x150/0x1c0 lib/kobject.c:442
>    device_add+0x3be/0x1d00 drivers/base/core.c:2412
>    add_one_compat_dev drivers/infiniband/core/device.c:901 [inline]
>    add_one_compat_dev+0x46a/0x7e0 drivers/infiniband/core/device.c:857
>    rdma_dev_init_net+0x2eb/0x490 drivers/infiniband/core/device.c:1120
>    ops_init+0xb3/0x420 net/core/net_namespace.c:137
>    setup_net+0x2d5/0x8b0 net/core/net_namespace.c:327
>    copy_net_ns+0x29e/0x5a0 net/core/net_namespace.c:468
>    create_new_namespaces+0x403/0xb50 kernel/nsproxy.c:108
>    unshare_nsproxy_namespaces+0xc2/0x200 kernel/nsproxy.c:229
>    ksys_unshare+0x444/0x980 kernel/fork.c:2955
>    __do_sys_unshare kernel/fork.c:3023 [inline]
>    __se_sys_unshare kernel/fork.c:3021 [inline]
>    __x64_sys_unshare+0x31/0x40 kernel/fork.c:3021
>    do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Cc: stable@kernel.org
> Fixes: 4e0f7b907072 ("RDMA/core: Implement compat device/sysfs tree in net namespace")
> Reported-by: syzbot+ab4dae63f7d310641ded@syzkaller.appspotmail.com
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to for-rc

Jason
