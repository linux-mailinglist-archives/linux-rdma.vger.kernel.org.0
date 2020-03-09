Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6156E17E829
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2020 20:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgCITUK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Mar 2020 15:20:10 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34439 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgCITUK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Mar 2020 15:20:10 -0400
Received: by mail-qk1-f195.google.com with SMTP id f3so10441833qkh.1
        for <linux-rdma@vger.kernel.org>; Mon, 09 Mar 2020 12:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1RmS/do2m4Rgyh3y5tct2bufiN2CafabyGe03S63dE0=;
        b=MPLMyGrv5GN5qJ7fcgdx8f7x0xTq9tEn6yrNY/LBb9RZCTZ8N7n0lXM55xh9fWPwaQ
         0x+0j/PdHcMg363D44MQKWJNh4F/nfDL8jIfwEphM/rRYZfPBlUPGT6UsUndZxrXdZFz
         xI8+x4dR3bVMWxISNARocW+wob5Ih/lTpEGZQkSqFTa75mkBCiMsnefElUeOjnLloLG9
         Hsu4emY0f+BggA5Q5bpW4gtmg2WhHQiz5Qk/gxq/kXIlM4BO8vGiU5LsjTIm0Hx1khDK
         opCE+U6uKvaA9RoP42lc/E86HUb1RRuqfInmyP96bjoXmQquHLxwUSsiq49qnoA5AkKt
         pfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1RmS/do2m4Rgyh3y5tct2bufiN2CafabyGe03S63dE0=;
        b=k3xWPIo3IoHvDw59LmyMYlkw/j9s4c78VxYk08wHHp0YUO71weDHz6sjPZUtWB1KFd
         +gh1INwW5xxtOxwlR2xtoNlt2/NdDTRjqs8lli9ntFrbPtf9Ro7OU3BAnB1GcES8ROOi
         yd3+K2nSRQ4fQ0726pmwlOjrnQQN53KQkq9Ai/fh2vTSJDa4/n9JrpmjKog3SR59fhu4
         G7GS9o9cy/vPUO3AEkwwYJd/HE//hy0QpZo+wPO/Pm5r7F0tg41FPXYkBM4r3gpE69di
         N3X3VUfEe5+bBEvE3sq90/LJ/hxjl9zuT7FnTuscfsyN9O7AihY/OnK9ruo8KBpqs8qc
         9HUQ==
X-Gm-Message-State: ANhLgQ1O+hQQ70Qb2TdPVnFtlQqNIZEVUykcyvNrmo12MNYecrhT9Vgr
        32y2W3yqpaaX+H+ubl333OrVnSIyGHY=
X-Google-Smtp-Source: ADFU+vuKJ4orucZMSaOsaXI0NI2CYFHLi8QRL+aBSMg4dT96g6i8rHZOk1jupTr63Qk5Y8xPXxBr9Q==
X-Received: by 2002:a37:2cc6:: with SMTP id s189mr16800002qkh.223.1583781608474;
        Mon, 09 Mar 2020 12:20:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 69sm7910355qki.131.2020.03.09.12.20.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Mar 2020 12:20:07 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jBNwd-00017t-DS; Mon, 09 Mar 2020 16:20:07 -0300
Date:   Mon, 9 Mar 2020 16:20:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     syzbot+da615ac67d4dbea32cbc@syzkaller.appspotmail.com
Subject: Re: [PATCH rc] RDMA/nl: Do not permit empty devices names during
 RDMA_NLDEV_CMD_NEWLINK/SET
Message-ID: <20200309192007.GW31668@ziepe.ca>
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
>  drivers/infiniband/core/nldev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> 
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index 37b433aa730610..7147a4e49167db 100644
> +++ b/drivers/infiniband/core/nldev.c
> @@ -1514,7 +1514,7 @@ static int nldev_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>  
>  	nla_strlcpy(ibdev_name, tb[RDMA_NLDEV_ATTR_DEV_NAME],
>  		    sizeof(ibdev_name));
> -	if (strchr(ibdev_name, '%'))
> +	if (strchr(ibdev_name, '%') || strlen(ibdev_name) == 0)
>  		return -EINVAL;
>  
>  	nla_strlcpy(type, tb[RDMA_NLDEV_ATTR_LINK_TYPE], sizeof(type));

Gah, a hunk got lost here:

--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -918,6 +918,10 @@ static int nldev_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 
                nla_strlcpy(name, tb[RDMA_NLDEV_ATTR_DEV_NAME],
                            IB_DEVICE_NAME_MAX);
+               if (strlen(name) == 0) {
+                       err = -EINVAL;
+                       goto done;
+               }
                err = ib_device_rename(device, name);
                goto done;
        }

Jason
