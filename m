Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A56180501
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 18:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCJRij (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 13:38:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43082 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgCJRii (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Mar 2020 13:38:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id l13so5186097qtv.10
        for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2020 10:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ctcr2CLnsNVUzVTsrUKSbGgn+f7Un/Qtii6jNuSXN1w=;
        b=PUNu8c+ULwHOTYlP4KR5M7cZoT4JQuJRaH7vNitUcghl4MgWjdNPM/JbLU8qOQbkVh
         /oAhG08q4EtxUI8la0TGkKGXP+WzJfF7BjakdnbMhW63xFke9uCnIDpfO9q6yB2zOG+b
         NvS7ZNaeKPlgUySJtiQbBol2OLCErrXy8Ex+6jIiKBbWr1CMYrtey1iZlSRq6KXI611I
         By3Z1mDuDkvBaSkX4nwysheE+WIEkO4Txej7ySsvyygXSBmJquwcrX/d9lP56zdB14/B
         n8KQRpmXYiGxn4mO18AUe2ClyTyp5ElkkkV915vwndpMT4dFCBb5073uOICdJSWcWLf1
         sHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ctcr2CLnsNVUzVTsrUKSbGgn+f7Un/Qtii6jNuSXN1w=;
        b=tonenv1yIORp1A5QyPWAy9bL7rB/dY7FbP8c430sU2vWn82WwdBmW57Cx09ROE0DaX
         qxmHIp72kPXas68MHbjWSHN/RI9tqqMD7RveuzAKU3tbd6K6FEWMSuXyM5pd9Ms3Uv6Y
         o3Vb31WE0M5aMUheVY+0DxtkRdTSsYuMga9GvEyzbpKWpf1S2idpJAhVm08zvNcKO7NP
         X64x6JlIP7bKIaY6p7YQavnwPkHzu5SxXXH+Jy8S1PUf8vRGlt2rXD0R2TOC36BNQFu8
         Qyb3n+Xbiq1AyRGYSQ6cudsEc77nD6aPspwpFef9CIAABgIAWNdY6GEeohdbMWIwFeW1
         0jag==
X-Gm-Message-State: ANhLgQ1wObc5GAawt9ScmdzOg80aFyHWMWMKwUE4I6P1y38KgrCtr3dn
        cV3h11t5Ysj5kwghPjkxQrkUaA==
X-Google-Smtp-Source: ADFU+vupQJpCUJ6katqNtuq+dR4ArJhjLZz4afX/PBXkRtubS8ZXbCmgR0GQrY/aLHIAVpHbIfZL1A==
X-Received: by 2002:ac8:6b87:: with SMTP id z7mr20385201qts.52.1583861917404;
        Tue, 10 Mar 2020 10:38:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id j4sm4032024qtn.78.2020.03.10.10.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Mar 2020 10:38:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jBipw-0005tr-Iu; Tue, 10 Mar 2020 14:38:36 -0300
Date:   Tue, 10 Mar 2020 14:38:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markz@mellanox.com>, linux-rdma@vger.kernel.org,
        Majd Dibbiny <majd@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix the number of hwcounters of a
 dynamic counter
Message-ID: <20200310173836.GA22623@ziepe.ca>
References: <20200305124052.196688-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305124052.196688-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 05, 2020 at 02:40:52PM +0200, Leon Romanovsky wrote:
> From: Mark Zhang <markz@mellanox.com>
> 
> When read the global counter and there's any dynamic counter allocated,
> the value of a hwcounter is the sum of the default counter and all
> dynamic counters. So the number of hwcounters of a dynamically allocated
> counter must be same as of the default counter, otherwise there will
> be read violations.
> 
> This fixes the KASAN slab-out-of-bounds bug:
> 
> [ 1736.292832] ==================================================================
> [ 1736.294938] BUG: KASAN: slab-out-of-bounds in rdma_counter_get_hwstat_value+0x36d/0x390 [ib_core]
> [ 1736.297071] Read of size 8 at addr ffff8884192a5778 by task rdma/10138
> [ 1736.298462]
> [ 1736.299257] CPU: 7 PID: 10138 Comm: rdma Not tainted 5.5.0-for-upstream-dbg-2020-02-06_18-30-19-27 #1
> [ 1736.301476] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> [ 1736.303923] Call Trace:
> [ 1736.304771]  dump_stack+0xb7/0x10b
> [ 1736.305750]  print_address_description.constprop.4+0x1e2/0x400
> [ 1736.307072]  ? rdma_counter_get_hwstat_value+0x36d/0x390 [ib_core]
> [ 1736.308429]  __kasan_report+0x15c/0x1e0
> [ 1736.309467]  ? mlx5_ib_query_q_counters+0x13f/0x270 [mlx5_ib]
> [ 1736.310780]  ? rdma_counter_get_hwstat_value+0x36d/0x390 [ib_core]
> [ 1736.312139]  kasan_report+0xe/0x20
> [ 1736.313124]  rdma_counter_get_hwstat_value+0x36d/0x390 [ib_core]
> [ 1736.314477]  ? rdma_counter_query_stats+0xd0/0xd0 [ib_core]
> [ 1736.315742]  ? memcpy+0x34/0x50
> [ 1736.316683]  ? nla_put+0xe2/0x170
> [ 1736.317665]  nldev_stat_get_doit+0x9c7/0x14f0 [ib_core]
> ...
> [ 1736.350888]  do_syscall_64+0x95/0x490
> [ 1736.351901]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [ 1736.353095] RIP: 0033:0x7fcc457fe65a
> [ 1736.354089] Code: bb 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 8b 05 fa f1 2b 00 45 89 c9 4c 63 d1 48 63 ff 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 76 f3 c3 0f 1f 40 00 41 55 41 54 4d 89 c5 55
> [ 1736.358062] RSP: 002b:00007ffc0586f868 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> [ 1736.360021] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcc457fe65a
> [ 1736.361490] RDX: 0000000000000020 RSI: 00000000013db920 RDI: 0000000000000003
> [ 1736.362967] RBP: 00007ffc0586fa90 R08: 00007fcc45ac10e0 R09: 000000000000000c
> [ 1736.364438] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004089c0
> [ 1736.365909] R13: 0000000000000000 R14: 00007ffc0586fab0 R15: 00000000013dc9a0
> [ 1736.367423]
> [ 1736.368139] Allocated by task 9700:
> [ 1736.369129]  save_stack+0x19/0x80
> [ 1736.370091]  __kasan_kmalloc.constprop.7+0xa0/0xd0
> [ 1736.371261]  mlx5_ib_counter_alloc_stats+0xd1/0x1d0 [mlx5_ib]
> [ 1736.372557]  rdma_counter_alloc+0x16d/0x3f0 [ib_core]
> [ 1736.373758]  rdma_counter_bind_qpn_alloc+0x216/0x4e0 [ib_core]
> [ 1736.375067]  nldev_stat_set_doit+0x8c2/0xb10 [ib_core]
> [ 1736.376283]  rdma_nl_rcv_msg+0x3d2/0x730 [ib_core]
> [ 1736.377451]  rdma_nl_rcv+0x2a8/0x400 [ib_core]
> [ 1736.378565]  netlink_unicast+0x448/0x620
> [ 1736.379605]  netlink_sendmsg+0x731/0xd10
> [ 1736.380649]  sock_sendmsg+0xb1/0xf0
> [ 1736.381635]  __sys_sendto+0x25d/0x2c0
> [ 1736.382647]  __x64_sys_sendto+0xdd/0x1b0
> [ 1736.383694]  do_syscall_64+0x95/0x490
> [ 1736.384700]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [ 1736.385897]
> ...
> [ 1736.409522]
> [ 1736.410242] The buggy address belongs to the object at ffff8884192a5600
> [ 1736.410242]  which belongs to the cache kmalloc-512 of size 512
> [ 1736.412928] The buggy address is located 376 bytes inside of
> [ 1736.412928]  512-byte region [ffff8884192a5600, ffff8884192a5800)
> [ 1736.415511] The buggy address belongs to the page:
> [ 1736.416693] page:ffffea001064a800 refcount:1 head refcount:1 mapcount:0 mapping:ffff88841c011300 index:0x0 compound_mapcount:0 compound_pincount:0
> [ 1736.419474] raw: 002fffff80010200 ffffea0010173208 ffffea0010034808 ffff88841c011300
> [ 1736.421472] raw: 0000000000000000 0000000000150015 00000001ffffffff 0000000000000000
> [ 1736.423492] page dumped because: kasan: bad access detected
> [ 1736.424787]
> [ 1736.425508] Memory state around the buggy address:
> [ 1736.426694]  ffff8884192a5600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [ 1736.428648]  ffff8884192a5680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [ 1736.430610] >ffff8884192a5700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
> [ 1736.432556]                                                                 ^
> [ 1736.434071]  ffff8884192a5780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [ 1736.436027]  ffff8884192a5800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [ 1736.437987] ==================================================================
> [ 1736.439939] Disabling lock debugging due to kernel taint
> 
> Fixes: 18d422ce8ccf ("IB/mlx5: Add counter_alloc_stats() and counter_update_stats() support")
> Signed-off-by: Mark Zhang <markz@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
