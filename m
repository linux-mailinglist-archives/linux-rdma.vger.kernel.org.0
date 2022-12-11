Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C05264940D
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Dec 2022 13:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiLKMA5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Dec 2022 07:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiLKMAz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Dec 2022 07:00:55 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8C9C767
        for <linux-rdma@vger.kernel.org>; Sun, 11 Dec 2022 04:00:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 403C5CE0B30
        for <linux-rdma@vger.kernel.org>; Sun, 11 Dec 2022 12:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2227C433D2;
        Sun, 11 Dec 2022 12:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670760051;
        bh=EejKSi4dCkTJ7hHFprYRgXj8yThdUj9Gh44EjmdBI7c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aWPPHNA2w9HBB0EfXJiDRWSEojv4a5cnnjmSZmQ/jgbxA1RN70dn0qh6urT78Zb30
         9UDXkgkixRaCQBohuoS62Y2WLfqJWGnksCb0dz677rdHeLyYx+KsWaJpyEA3snd2bS
         THn5M3qHRsr6zb8wlO68z5o6/ynuSuJGNxYpYCMevTXHwfTkIsuzohWagQ1vt80Ia6
         1osCzpp/voQAXLwmMsXD/cB2h2OBaP8yH9z8OsBXdYFCu2qeurybUi+HUT1iEM2wcM
         YyrOYtXrBVTPOw2MIUYh4FHNDRZeNPa9A79j4IzBu3x91aNNBf+QyfTEugxvdcKy3L
         8BG5gS3x9dIBA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     syzbot+8d0a099c8a6d1e4e601c@syzkaller.appspotmail.com,
        syzbot+a1ed8ffe3121380cd5dd@syzkaller.appspotmail.com,
        syzbot+3fd8326d9a0812d19218@syzkaller.appspotmail.com
In-Reply-To: <0-v1-e99919867b8d+1e2-netdev_tracker2_jgg@nvidia.com>
References: <0-v1-e99919867b8d+1e2-netdev_tracker2_jgg@nvidia.com>
Subject: Re: [PATCH] RDMA: Add missed netdev_put() for the netdevice_tracker
Message-Id: <167076004731.139282.14537683866198411802.b4-ty@kernel.org>
Date:   Sun, 11 Dec 2022 14:00:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 9 Dec 2022 10:21:56 -0400, Jason Gunthorpe wrote:
> The netdev core will detect if any untracked puts are done on tracked
> pointers and throw refcount warnings:
> 
>   refcount_t: decrement hit 0; leaking memory.
>   WARNING: CPU: 1 PID: 33 at lib/refcount.c:31 refcount_warn_saturate+0x1d7/0x1f0 lib/refcount.c:31
>   Modules linked in:
>   CPU: 1 PID: 33 Comm: kworker/u4:2 Not tainted 6.1.0-rc8-next-20221207-syzkaller #0
>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
>   Workqueue: ib-unreg-wq ib_unregister_work
>   RIP: 0010:refcount_warn_saturate+0x1d7/0x1f0 lib/refcount.c:31
>   Code: 05 5a 60 51 0a 01 e8 35 0a b5 05 0f 0b e9 d3 fe ff ff e8 6c 9b 75 fd 48 c7 c7 c0 6d a6 8a c6 05 37 60 51 0a 01 e8 16 0a b5 05 <0f> 0b e9 b4 fe
>   +ff ff 48 89 ef e8 5a b5 c3 fd e9 5c fe ff ff 0f 1f
>   RSP: 0018:ffffc90000aa7b30 EFLAGS: 00010082
>   RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>   RDX: ffff8880172f9d40 RSI: ffffffff8166b1dc RDI: fffff52000154f58
>   RBP: ffff88807906c600 R08: 0000000000000005 R09: 0000000000000000
>   R10: 0000000080000001 R11: 0000000000000000 R12: 1ffff92000154f6b
>   R13: 0000000000000000 R14: ffff88807906c600 R15: ffff888046894000
>   FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00007ffe350a8ff8 CR3: 000000007a9e7000 CR4: 00000000003526e0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   Call Trace:
>    <TASK>
>    __refcount_dec include/linux/refcount.h:344 [inline]
>    refcount_dec include/linux/refcount.h:359 [inline]
>    ref_tracker_free+0x539/0x6b0 lib/ref_tracker.c:118
>    netdev_tracker_free include/linux/netdevice.h:4039 [inline]
>    netdev_put include/linux/netdevice.h:4056 [inline]
>    dev_put include/linux/netdevice.h:4082 [inline]
>    free_netdevs+0x1f8/0x470 drivers/infiniband/core/device.c:2204
>    __ib_unregister_device+0xa0/0x1a0 drivers/infiniband/core/device.c:1478
>    ib_unregister_work+0x19/0x30 drivers/infiniband/core/device.c:1586
>    process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
>    worker_thread+0x669/0x1090 kernel/workqueue.c:2436
>    kthread+0x2e8/0x3a0 kernel/kthread.c:376
>    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
> 
> [...]

Applied, thanks!

[1/1] RDMA: Add missed netdev_put() for the netdevice_tracker
      https://git.kernel.org/rdma/rdma/c/e42f9c2e6aad58

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
