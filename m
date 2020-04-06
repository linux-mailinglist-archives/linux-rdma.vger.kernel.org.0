Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65A9219FBE3
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2020 19:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgDFRon (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Apr 2020 13:44:43 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36433 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbgDFRon (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Apr 2020 13:44:43 -0400
Received: by mail-qt1-f196.google.com with SMTP id m33so436241qtb.3
        for <linux-rdma@vger.kernel.org>; Mon, 06 Apr 2020 10:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O889dxB/XJ11aoM95cldpEaus4gDgLM3yTi+BUCXaL0=;
        b=CjbhAJj3Tg6y8oKldTLzjJgMKn6v55oqoh5dQSCe0t9eI0N5Ab9KpB1ZaMBFL49hJ1
         U2YSO0kjrRgeaVmCyD1Lcyc+Iuyxswp5BwvxKn+KzvzHMaJcVK7WJhnu0m7hWXwYQAjw
         EsH9hi5e2/hmMFgImNwnk2oGoD+gqahObRsAOtHsmPfZSJNwMjQA+RrmNO7VLZb2hQ+h
         qUebv2jQpa0u/8Tixk/rjBRzO66TXyjwfdnFe1eOI2mWwFyyzG4hzRY/WnE/jl5r+6YQ
         QwHeryLLzOnmdRx3ZutBFI9zPe366Dfo41v/rVhgI7RZAv5qyT02wzORNsi1NbF9BHM3
         ubhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O889dxB/XJ11aoM95cldpEaus4gDgLM3yTi+BUCXaL0=;
        b=paQsdo2PMwoxepdhJXjlbwY3ru5hV8cedNzUsPLeNvbZu9AQz9taRr+4EBW2m9gpbh
         AyUaP7oNuG6oN/hsr2WxzT1xSuQanG/nXN+7xF1nehqsEOlAP2SZgjUxci/punxAHNdi
         djMsWXqa66EB+/18Ws3SHjdkMg9tu5mJwjcvaZYJJjdEXZkvM8G5+F88x7S12GHQSpoW
         wvM/KyvQw95BBZg7lxWPBHUvphmTcOslSrWKIGcra2367rf1tj76n4EwUdHZVA63DrUc
         ZjhweKmDPNvc0J/cYpzHdGfYy6aEeNGMwUHmTwNSSCGAc2eL1WiS+LVxS8Tm9AEZpFOE
         ZUYg==
X-Gm-Message-State: AGi0Pubp0/gXuJAqulWd8hn1R8a9xCmoH/Y521GqkO1D9QhOrbeyRTPS
        QqTGb75OvoiiniPUtgXqrCfqCA==
X-Google-Smtp-Source: APiQypLj6wnyOzro00s4tpq9gdIN+7IPdSVtnDUW7iERedT5t2IGtckVe64o2Po3xX134XMZwCxmLA==
X-Received: by 2002:ac8:4c8a:: with SMTP id j10mr602951qtv.69.1586195081480;
        Mon, 06 Apr 2020 10:44:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id u29sm13038349qkm.102.2020.04.06.10.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 10:44:40 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jLVnc-0008Sf-EB; Mon, 06 Apr 2020 14:44:40 -0300
Date:   Mon, 6 Apr 2020 14:44:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     syzbot <syzbot+9627a92b1f9262d5d30c@syzkaller.appspotmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in ib_umad_kill_port
Message-ID: <20200406174440.GR20941@ziepe.ca>
References: <00000000000075245205a2997f68@google.com>
 <20200406172151.GJ80989@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406172151.GJ80989@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 06, 2020 at 08:21:51PM +0300, Leon Romanovsky wrote:
> + RDMA
> 
> On Sun, Apr 05, 2020 at 11:37:15PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    304e0242 net_sched: add a temporary refcnt for struct tcin..
> > git tree:       net
> > console output: https://syzkaller.appspot.com/x/log.txt?x=119dd16de00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8c1e98458335a7d1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9627a92b1f9262d5d30c
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+9627a92b1f9262d5d30c@syzkaller.appspotmail.com
> >
> > sysfs group 'power' not found for kobject 'umad1'
> > WARNING: CPU: 1 PID: 31308 at fs/sysfs/group.c:279 sysfs_remove_group fs/sysfs/group.c:279 [inline]
> > WARNING: CPU: 1 PID: 31308 at fs/sysfs/group.c:279 sysfs_remove_group+0x155/0x1b0 fs/sysfs/group.c:270
> > Kernel panic - not syncing: panic_on_warn set ...
> > CPU: 1 PID: 31308 Comm: kworker/u4:10 Not tainted 5.6.0-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Workqueue: events_unbound ib_unregister_work
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x188/0x20d lib/dump_stack.c:118
> >  panic+0x2e3/0x75c kernel/panic.c:221
> >  __warn.cold+0x2f/0x35 kernel/panic.c:582
> >  report_bug+0x27b/0x2f0 lib/bug.c:195
> >  fixup_bug arch/x86/kernel/traps.c:175 [inline]
> >  fixup_bug arch/x86/kernel/traps.c:170 [inline]
> >  do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:267
> >  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
> >  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
> > RIP: 0010:sysfs_remove_group fs/sysfs/group.c:279 [inline]
> > RIP: 0010:sysfs_remove_group+0x155/0x1b0 fs/sysfs/group.c:270
> > Code: 48 89 d9 49 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c 01 00 75 41 48 8b 33 48 c7 c7 60 c3 39 88 e8 93 c3 5f ff <0f> 0b eb 95 e8 22 62 cb ff e9 d2 fe ff ff 48 89 df e8 15 62 cb ff
> > RSP: 0018:ffffc90001d97a60 EFLAGS: 00010282
> > RAX: 0000000000000000 RBX: ffffffff88915620 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: ffffffff815ca861 RDI: fffff520003b2f3e
> > RBP: 0000000000000000 R08: ffff8880a78fc2c0 R09: ffffed1015ce66a1
> > R10: ffffed1015ce66a0 R11: ffff8880ae733507 R12: ffff88808e5ba070
> > R13: ffffffff88915bc0 R14: ffff88808e5ba008 R15: dffffc0000000000
> >  dpm_sysfs_remove+0x97/0xb0 drivers/base/power/sysfs.c:794
> >  device_del+0x18b/0xd30 drivers/base/core.c:2687
> >  cdev_device_del+0x15/0x80 fs/char_dev.c:570
> >  ib_umad_kill_port+0x45/0x250 drivers/infiniband/core/user_mad.c:1327
> >  ib_umad_remove_one+0x18a/0x220 drivers/infiniband/core/user_mad.c:1409
> >  remove_client_context+0xbe/0x110 drivers/infiniband/core/device.c:724
> >  disable_device+0x13b/0x230 drivers/infiniband/core/device.c:1270
> >  __ib_unregister_device+0x91/0x180 drivers/infiniband/core/device.c:1437
> >  ib_unregister_work+0x15/0x30 drivers/infiniband/core/device.c:1547
> >  process_one_work+0x965/0x16a0 kernel/workqueue.c:2266
> >  worker_thread+0x96/0xe20 kernel/workqueue.c:2412
> >  kthread+0x388/0x470 kernel/kthread.c:268
> >  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> > Kernel Offset: disabled
> > Rebooting in 86400 seconds..

I'm not sure what could be done wrong here to elicit this:

 sysfs group 'power' not found for kobject 'umad1'

??

I've seen another similar sysfs related trigger that we couldn't
figure out.

Hard to investigate without a reproducer.

Jason
