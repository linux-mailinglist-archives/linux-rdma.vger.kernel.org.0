Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15DC01797B1
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 19:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgCDSSt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 13:18:49 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41597 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCDSSs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Mar 2020 13:18:48 -0500
Received: by mail-qt1-f193.google.com with SMTP id l21so2094434qtr.8
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2020 10:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dEGwj7wK0l2T4IP/L49dwsg0dZcykCrTPzsCnhYO2mo=;
        b=S3Es+uaVGEYhGMlYtvhEd0b/cJq2KsofvxgmDlxAO9vlC0jMZjvGzzrqH1BykvL49z
         prZd8aoiNUfc3ATlHK8i+W//ENquiJTQhiHO6PvBKxcpRSw7pHGhO39Ewznmt3TY/Nst
         78MQt3a8By5y2MCZL0AMA/Kju9cTxuqKlJKvX8XAp5r5ZgUn+kcBas4Sxhrl+bJvJpsh
         R3N4KI70QWr05+DbGSTGPzsF+e00mIOpxhpLF+VkDCAkpz4mByWZP9/0hVWFCPydXg2y
         tKjfLw1yWGLbisDRxrMysPi2vMa4kJZbvfHnSQ6fzljW38hYFuNnKkawhSgp40XNmgrx
         xnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dEGwj7wK0l2T4IP/L49dwsg0dZcykCrTPzsCnhYO2mo=;
        b=XlJ2S7XB8DWYRJDTipSSzWhxrEFg0a5EOmPB1tA4lEcI1ONLOKWcQi5Ui3pS8PzjXG
         hXu/UJkE5T7x0tvjLmor6sFnXQSd8SA2j9DRyWJQZS9DI+RhhLPblRzCm/N2DvXJr3c2
         AOia0JPO8nDe1mn6yWr9ilOP2eAFpy+kyxlcsEzzf6mv6G2tNvZb9GOVOQ1gpNWw+Qm9
         qUbPZZYXcmKXs7ivKz/ZEEoSqvTPK9TGC/oAM0dycrjgBfk+PTvT+x8lPcUrIE/a6qlr
         2XJ/xIMWjPYlhCWpz2+nXaZpYkJBx5vniRO7GzP6xTlIOtHv8SsAs48p2RvUv969L3Sg
         KUlQ==
X-Gm-Message-State: ANhLgQ0XfbrUu8YaV8szOWkddpZ4pWp/a5wHoFJO5kVhhFkKCRk1kGYF
        ckYAsdff5PPovTBhDy7HbV601pmFpntQqw==
X-Google-Smtp-Source: ADFU+vu6TnWGSVTu8AtlqfPadIpo8iQCDFf0AFeUsAS1toIs+nNU9eNNNKcW/f9iZdzxVTIdAHZoQQ==
X-Received: by 2002:ac8:51d6:: with SMTP id d22mr3553859qtn.11.1583345927331;
        Wed, 04 Mar 2020 10:18:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 138sm11638485qkg.5.2020.03.04.10.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Mar 2020 10:18:46 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j9YbW-0007DL-Am; Wed, 04 Mar 2020 14:18:46 -0400
Date:   Wed, 4 Mar 2020 14:18:46 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markz@mellanox.com>, linux-rdma@vger.kernel.org,
        Majd Dibbiny <majd@mellanox.com>,
        syzbot+bd4af81bc51ee0283445@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-rc] RDMA/nldev: Fix crash when set a QP to a new
 counter but QPN is missing
Message-ID: <20200304181846.GA27705@ziepe.ca>
References: <20200227125111.99142-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227125111.99142-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 27, 2020 at 02:51:11PM +0200, Leon Romanovsky wrote:
> From: Mark Zhang <markz@mellanox.com>
> 
> This fixes the kernel crash when a RDMA_NLDEV_CMD_STAT_SET command is
> received, but the QP number parameter is not available.
> 
> iwpm_register_pid: Unable to send a nlmsg (client = 2)
> infiniband syz1: RDMA CMA: cma_listen_on_dev, error -98
> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 0 PID: 9754 Comm: syz-executor069 Not tainted 5.6.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:nla_get_u32 include/net/netlink.h:1474 [inline]
> RIP: 0010:nldev_stat_set_doit+0x63c/0xb70 drivers/infiniband/core/nldev.c:1760
> Code: fc 01 0f 84 58 03 00 00 e8 41 83 bf fb 4c 8b a3 58 fd ff ff 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 04 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 6d
> RSP: 0018:ffffc900068bf350 EFLAGS: 00010247
> RAX: dffffc0000000000 RBX: ffffc900068bf728 RCX: ffffffff85b60470
> RDX: 0000000000000000 RSI: ffffffff85b6047f RDI: 0000000000000004
> RBP: ffffc900068bf750 R08: ffff88808c3ee140 R09: ffff8880a25e6010
> R10: ffffed10144bcddc R11: ffff8880a25e6ee3 R12: 0000000000000000
> R13: ffff88809acb0000 R14: ffff888092a42c80 R15: 000000009ef2e29a
> FS:  0000000001ff0880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f4733e34000 CR3: 00000000a9b27000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:195 [inline]
>   rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>   rdma_nl_rcv+0x5d9/0x980 drivers/infiniband/core/netlink.c:259
>   netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
>   netlink_unicast+0x59e/0x7e0 net/netlink/af_netlink.c:1329
>   netlink_sendmsg+0x91c/0xea0 net/netlink/af_netlink.c:1918
>   sock_sendmsg_nosec net/socket.c:652 [inline]
>   sock_sendmsg+0xd7/0x130 net/socket.c:672
>   ____sys_sendmsg+0x753/0x880 net/socket.c:2343
>   ___sys_sendmsg+0x100/0x170 net/socket.c:2397
>   __sys_sendmsg+0x105/0x1d0 net/socket.c:2430
>   __do_sys_sendmsg net/socket.c:2439 [inline]
>   __se_sys_sendmsg net/socket.c:2437 [inline]
>   __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2437
>   do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4403d9
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffc0efbc5c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004403d9
> RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000004
> RBP: 00000000006ca018 R08: 0000000000000008 R09: 00000000004002c8
> R10: 000000000000004a R11: 0000000000000246 R12: 0000000000401c60
> R13: 0000000000401cf0 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace 548745c787596b79 ]---
> RIP: 0010:nla_get_u32 include/net/netlink.h:1474 [inline]
> RIP: 0010:nldev_stat_set_doit+0x63c/0xb70 drivers/infiniband/core/nldev.c:1760
> Code: fc 01 0f 84 58 03 00 00 e8 41 83 bf fb 4c 8b a3 58 fd ff ff 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 04 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 6d
> RSP: 0018:ffffc900068bf350 EFLAGS: 00010247
> RAX: dffffc0000000000 RBX: ffffc900068bf728 RCX: ffffffff85b60470
> RDX: 0000000000000000 RSI: ffffffff85b6047f RDI: 0000000000000004
> RBP: ffffc900068bf750 R08: ffff88808c3ee140 R09: ffff8880a25e6010
> R10: ffffed10144bcddc R11: ffff8880a25e6ee3 R12: 0000000000000000
> R13: ffff88809acb0000 R14: ffff888092a42c80 R15: 000000009ef2e29a
> FS:  0000000001ff0880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f4733e34000 CR3: 00000000a9b27000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> Fixes: b389327df905 ("RDMA/nldev: Allow counter manual mode configration through RDMA netlink")
> Reported-by: syzbot+bd4af81bc51ee0283445@syzkaller.appspotmail.com
> Signed-off-by: Mark Zhang <markz@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/nldev.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-rc, thanks

Jason
