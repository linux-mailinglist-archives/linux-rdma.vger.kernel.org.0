Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27F3B184833
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 14:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgCMNdn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 09:33:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44574 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgCMNdn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 09:33:43 -0400
Received: by mail-qk1-f195.google.com with SMTP id f198so12397606qke.11
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 06:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dW5BEpUn/nZQCllYRXO4/lkk+6651SLd9COBqzHFQmU=;
        b=aDzROjVVBcG7Qx1yU6QGAVmQ+hfsVEn49eTkTNVJZerDd3WWV5Jd2LFp6dkP3xfHpp
         hhMF/fPX6xNJLM2f2EF6rvIsqqUmSW8fiXnTgZa0rDNblxc9L3/o5erWxowMbcFyWB0m
         kiY+7QepQsGZeKpSvJ3CmV49PIMUQiDQ7jNKaTEFAxhi7n7Fv/xIj4KaP7tBiFM8KoFW
         vs7/rN8SPzd43SnsQ+iUGdp7b/mX5qM5Fa/M1pfF2r2umfEPAYoZwpgVE6iB232soi1G
         +f2I8HnSpAps2osgCb13U80RTbL5Sh9bVXtPPECrZdYqFzscjmfVrJveWyaDEywJtDgy
         3H7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dW5BEpUn/nZQCllYRXO4/lkk+6651SLd9COBqzHFQmU=;
        b=YpIl/Ero0mn3+Ojp0O2UG5D3DFXh3w4Hfwr1KVdce//4HTKhlzUkNUNL2bJYZZrNpP
         zKnT+4O8qyMSKM8hFMjO3XmiYVJ0oxo61Seeka8G/TXfIGr81L/5FFX1ehIHsLivlZfj
         S2OELm5WdcW1hRPZQbnWvrabTKLttTsPDhEozu71CpflwpHcF07p1wjDp7tSGkQI36C4
         28cfSk0FOxqarDKm8gpMM4rv2aJbM7KJjzTSSCPyGvNHnKEKqY/0xheHtcX0SIaEOsOZ
         KVpj9gvE390ftIybagaYtzsQPxtCFWo5f3qrSez7dCqkr1cGt75T6HpNdC/wGx0YuO6v
         +Y8g==
X-Gm-Message-State: ANhLgQ1BZ8VwoUuvEuTsRkXSMlR08+qHl2tdsXmBlTz91snQe9UTivkg
        P5vSEQ6iGR0uvEYLkfJPgeoyAw==
X-Google-Smtp-Source: ADFU+vt2gNQBuyX1j0aVQviSPyct2AlixYUfZsFxwA4thFfKRaxeMwQcPANBDlx9nxSKaQgqeoCqbg==
X-Received: by 2002:a37:b886:: with SMTP id i128mr13225889qkf.410.1584106421968;
        Fri, 13 Mar 2020 06:33:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g49sm10530648qtk.1.2020.03.13.06.33.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 06:33:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jCkRY-00068S-RY; Fri, 13 Mar 2020 10:33:40 -0300
Date:   Fri, 13 Mar 2020 10:33:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        syzbot+46fe08363dbba223dec5@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-rc] RDMA/mad: Do not crash if the rdma device does
 not have a umad interface
Message-ID: <20200313133340.GA23557@ziepe.ca>
References: <20200310075339.238090-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310075339.238090-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 10, 2020 at 09:53:39AM +0200, Leon Romanovsky wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> Non-IB devices do not have a umad interface and the client_data will be
> left set to NULL. In this case calling get_nl_info() will try to kref a
> NULL cdev causing a crash:
> 
>   general protection fault, probably for non-canonical address 0xdffffc00000000ba: 0000 [#1] PREEMPT SMP KASAN
>   KASAN: null-ptr-deref in range [0x00000000000005d0-0x00000000000005d7]
>   CPU: 0 PID: 20851 Comm: syz-executor.0 Not tainted 5.6.0-rc2-syzkaller #0
>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>   RIP: 0010:kobject_get+0x35/0x150 lib/kobject.c:640
>   Code: 53 e8 3f b0 8b f9 4d 85 e4 0f 84 a2 00 00 00 e8 31 b0 8b f9 49 8d 7c 24 3c 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f  b6 04 02 48 89 fa
> +83 e2 07 38 d0 7f 08 84 c0 0f 85 eb 00 00 00
>   RSP: 0018:ffffc9000946f1a0 EFLAGS: 00010203
>   RAX: dffffc0000000000 RBX: ffffffff85bdbbb0 RCX: ffffc9000bf22000
>   RDX: 00000000000000ba RSI: ffffffff87e9d78f RDI: 00000000000005d4
>   RBP: ffffc9000946f1b8 R08: ffff8880581a6440 R09: ffff8880581a6cd0
>   R10: fffffbfff154b838 R11: ffffffff8aa5c1c7 R12: 0000000000000598
>   R13: 0000000000000000 R14: ffffc9000946f278 R15: ffff88805cb0c4d0
>   FS:  00007faa9e8af700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000001b30121000 CR3: 000000004515d000 CR4: 00000000001406f0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   Call Trace:
>    get_device+0x25/0x40 drivers/base/core.c:2574
>    __ib_get_client_nl_info+0x205/0x2e0 drivers/infiniband/core/device.c:1861
>    ib_get_client_nl_info+0x35/0x180 drivers/infiniband/core/device.c:1881
>    nldev_get_chardev+0x575/0xac0 drivers/infiniband/core/nldev.c:1621
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
> Fixes: 8f71bb0030b8 ("RDMA: Report available cdevs through RDMA_NLDEV_CMD_GET_CHARDEV")
> Reported-by: syzbot+46fe08363dbba223dec5@syzkaller.appspotmail.com
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/user_mad.c | 33 ++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 11 deletions(-)

Applied to for-rc

Jason
