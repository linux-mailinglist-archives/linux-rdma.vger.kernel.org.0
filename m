Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965AD234F5F
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Aug 2020 04:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgHACGr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jul 2020 22:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgHACGr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 Jul 2020 22:06:47 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24054C06174A;
        Fri, 31 Jul 2020 19:06:47 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id u10so8730708plr.7;
        Fri, 31 Jul 2020 19:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sAcj65082IhQsGOrBZ9LKh6cb5Rn2ubrTYqcw2BSUig=;
        b=ef+DjqKXVHyrO+k166004zCYsBcZ9kj6mkyCiCqfAWYRMUX4d62Zp/ggUwzLSdUQJr
         59/Vco95KGPLsg2cnEZYzmRGCF0tAm3Kpz9Lj+yNRanoub5kTqUuZDXTjBVoHDMimh8I
         ftSNDwxFD7iiptXxJAyaYrUTk4AtwxXmNw8D/uph/NHQogCNBlQM6ZhmH7v8EZvfQDPZ
         lGx3diekAjbr9NdZofS6sZ5WXPmMi2mj1EvDRMC7uhmXqrRMK9OAZ+LnQX7i7FhPrUso
         LQ+vXhXiBAXnMJb/tqR6rzxk9xSH9hfemSOTuDSmPBIrY6KROzqvezp83yKGzKVwUuS+
         ufEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sAcj65082IhQsGOrBZ9LKh6cb5Rn2ubrTYqcw2BSUig=;
        b=VxlLiQuPeaTsRq2e/IPhQF21MaWTjsFI9EEQTN+vYg6kkoRK6FWg6X+SVWinTK4ZDX
         ZxQiE0uJsZ3wsxslSfNeb6YlKsTY39pq+JkZexD1gUmOhfR6jEXFhP7KlWj9sPcG3Vfa
         OR9LdT7ea5/MheZ7a5BDnSt8JOcGV0LHpM5jBk/dIjUNneN2BipVJFH91Fgpu8t1diTB
         xbTvzr63hwuHHYnFZnvgJT2boRaa1CsMnHZU01Q3Xc8Q7w5oUqxnBYYJqHLWrnf67XmS
         WFErH4ewqLZv0lUuXW5G6JIhUnThRKVo8f2C7PUCCeiGH5M4/WccwQC+fcNbIcDRdvlK
         dD/w==
X-Gm-Message-State: AOAM531B/INpjdC5voqSEWNImvB7i5ozqgfctYJ3b1RCWsiJP1OIccM4
        hBe+6kqDoC+Cs0HTMETSYGS5jMMGFH2vjedZ
X-Google-Smtp-Source: ABdhPJx3n5tVjsSAhI/Ee20nVHUD/U6ZCKFlXWwS3sA95aJwGjkiKfdtFSPIs0AFRBqDrek33IiFtg==
X-Received: by 2002:a17:902:9a42:: with SMTP id x2mr5958073plv.174.1596247606346;
        Fri, 31 Jul 2020 19:06:46 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
        by smtp.gmail.com with ESMTPSA id a6sm10614314pje.8.2020.07.31.19.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 19:06:45 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date:   Sat, 1 Aug 2020 10:06:42 +0800
To:     Rustam Kovhaev <rkovhaevgmail.com@rk>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: KASAN: use-after-free Read in netdevice_event_work_handler
Message-ID: <20200801020642.r7ugrijelz6kdbk5@Rk>
References: <20200731211122.GA1728751 () thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200731211122.GA1728751 () thinkpad>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 31, 2020 at 09:11:22PM +0000, Rustam Kovhaev wrote:
>On Thu, Jul 09, 2020 at 04:54:19PM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    0bddd227 Documentation: update for gcc 4.9 requirement
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1418afb7100000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=66ad203c2bb6d8b
>> dashboard link: https://syzkaller.appspot.com/bug?extid=20b90969babe05609947
>> compiler:       gcc (GCC) 10.1.0-syz 20200507
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a8edff100000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167d3bb7100000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+20b90969babe05609947@syzkaller.appspotmail.com
>>
>> ==================================================================
>> BUG: KASAN: use-after-free in dev_put include/linux/netdevice.h:3853 [inline]
>> BUG: KASAN: use-after-free in netdevice_event_work_handler+0x15b/0x1b0 drivers/infiniband/core/roce_gid_mgmt.c:627
>> Read of size 8 at addr ffff88807b13e568 by task kworker/u4:0/7
>>
>> CPU: 0 PID: 7 Comm: kworker/u4:0 Not tainted 5.8.0-rc4-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Workqueue: gid-cache-wq netdevice_event_work_handler
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x18f/0x20d lib/dump_stack.c:118
>>  print_address_description.constprop.0.cold+0xae/0x436 mm/kasan/report.c:383
>>  __kasan_report mm/kasan/report.c:513 [inline]
>>  kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
>>  dev_put include/linux/netdevice.h:3853 [inline]
>>  netdevice_event_work_handler+0x15b/0x1b0 drivers/infiniband/core/roce_gid_mgmt.c:627
>>  process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
>>  worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
>>  kthread+0x3b5/0x4a0 kernel/kthread.c:291
>>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
>>
>> Allocated by task 13061:
>>  save_stack+0x1b/0x40 mm/kasan/common.c:48
>>  set_track mm/kasan/common.c:56 [inline]
>>  __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:494
>>  kmalloc_node include/linux/slab.h:578 [inline]
>>  kvmalloc_node+0x61/0xf0 mm/util.c:574
>>  kvmalloc include/linux/mm.h:753 [inline]
>>  kvzalloc include/linux/mm.h:761 [inline]
>>  alloc_netdev_mqs+0x97/0xdc0 net/core/dev.c:9938
>>  __ip_tunnel_create+0x201/0x580 net/ipv4/ip_tunnel.c:254
>>  ip_tunnel_init_net+0x32b/0x980 net/ipv4/ip_tunnel.c:1072
>>  ops_init+0xaf/0x470 net/core/net_namespace.c:151
>>  setup_net+0x2d8/0x850 net/core/net_namespace.c:341
>>  copy_net_ns+0x2cf/0x5e0 net/core/net_namespace.c:482
>>  create_new_namespaces+0x3f6/0xb10 kernel/nsproxy.c:110
>>  unshare_nsproxy_namespaces+0xbd/0x1f0 kernel/nsproxy.c:231
>>  ksys_unshare+0x36c/0x9a0 kernel/fork.c:2983
>>  __do_sys_unshare kernel/fork.c:3051 [inline]
>>  __se_sys_unshare kernel/fork.c:3049 [inline]
>>  __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3049
>>  do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
>>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> Freed by task 13061:
>>  save_stack+0x1b/0x40 mm/kasan/common.c:48
>>  set_track mm/kasan/common.c:56 [inline]
>>  kasan_set_free_info mm/kasan/common.c:316 [inline]
>>  __kasan_slab_free+0xf5/0x140 mm/kasan/common.c:455
>>  __cache_free mm/slab.c:3426 [inline]
>>  kfree+0x103/0x2c0 mm/slab.c:3757
>>  kvfree+0x42/0x50 mm/util.c:603
>>  device_release+0x71/0x200 drivers/base/core.c:1559
>>  kobject_cleanup lib/kobject.c:693 [inline]
>>  kobject_release lib/kobject.c:722 [inline]
>>  kref_put include/linux/kref.h:65 [inline]
>>  kobject_put+0x1c0/0x270 lib/kobject.c:739
>>  put_device+0x1b/0x30 drivers/base/core.c:2779
>>  free_netdev+0x35d/0x480 net/core/dev.c:10054
>>  __ip_tunnel_create+0x48f/0x580 net/ipv4/ip_tunnel.c:274
>>  ip_tunnel_init_net+0x32b/0x980 net/ipv4/ip_tunnel.c:1072
>>  ops_init+0xaf/0x470 net/core/net_namespace.c:151
>>  setup_net+0x2d8/0x850 net/core/net_namespace.c:341
>>  copy_net_ns+0x2cf/0x5e0 net/core/net_namespace.c:482
>>  create_new_namespaces+0x3f6/0xb10 kernel/nsproxy.c:110
>>  unshare_nsproxy_namespaces+0xbd/0x1f0 kernel/nsproxy.c:231
>>  ksys_unshare+0x36c/0x9a0 kernel/fork.c:2983
>>  __do_sys_unshare kernel/fork.c:3051 [inline]
>>  __se_sys_unshare kernel/fork.c:3049 [inline]
>>  __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3049
>>  do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
>>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> The buggy address belongs to the object at ffff88807b13e000
>>  which belongs to the cache kmalloc-4k of size 4096
>> The buggy address is located 1384 bytes inside of
>>  4096-byte region [ffff88807b13e000, ffff88807b13f000)
>> The buggy address belongs to the page:
>> page:ffffea0001ec4f80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 head:ffffea0001ec4f80 order:1 compound_mapcount:0
>> flags: 0xfffe0000010200(slab|head)
>> raw: 00fffe0000010200 ffffea0001ecce88 ffffea0001987988 ffff8880aa002000
>> raw: 0000000000000000 ffff88807b13e000 0000000100000001 0000000000000000
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>>  ffff88807b13e400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>  ffff88807b13e480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> >ffff88807b13e500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>                                                           ^
>>  ffff88807b13e580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>  ffff88807b13e600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ==================================================================
>>
>>
>> ---
>> This bug is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this bug report. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> syzbot can test patches for this bug, for details see:
>> https://goo.gl/tpsmEJ#testing-patches
>
>IB roce driver receives NETDEV_UNREGISTER event, calls dev_hold() and
>schedules work item to execute, and before wq gets a chance to complete
>it, we return to ip_tunnel.c:274 and call free_netdev(), and then later
>we get UAF when scheduled function references already freed net_device
>
>i added verbose logging to ip_tunnel.c to see pcpu_refcnt:
>+       pr_info("about to free_netdev(dev) dev->pcpu_refcnt %d", netdev_refcnt_read(dev));
>
>and got the following:
>[  410.220127][ T2944] ip_tunnel: about to free_netdev(dev) dev->pcpu_refcnt 8
>
>i tried to make IB roce driver flush wq and work item, but i ran into
>lockdep issues
>also tried to modify dev core and call netdev_wait_allrefs() but ran
>into rntl deadlocks
>
>any hints or help in fixing this would be appreciated, thank you!

Congratulations on your latest patch [1] which has fixed this issue! I've
also been trying to fix this bug. Your solution is the right one and simpler
than mine:) I've also realized struct device shouldn't be freed at all
since dev_hold is called but haven't figured out why,
     // drivers/infiniband/core/roce_gid_mgmt.c
     static int netdevice_queue_work(struct netdev_event_work_cmd *cmds,
     				struct net_device *ndev)
     {
         ...
     	for (i = 0; i < ARRAY_SIZE(ndev_work->cmds) && ndev_work->cmds[i].cb; i++) {
     		dev_hold(ndev_work->cmds[i].ndev);
             ...
     	}
         ...
     	return NOTIFY_DONE;
     }

But maybe we could make an improvement which is to fix what makes the
nofitied callback functions mpls_dev_notify and addrconf_notify fail in
the first place. Currently I simply let mpls_dev_notify and addrconf_notify
return NOTIFY_DONE [2] [3] so call_netdevice_notifiers and register_netdevice
would succeed.

My observation is that mpls_dev_notify and addrconf_notify are not per-netns
netdevice callback functions of the notified (the subscriber) and they could
fail.

When per-netns netdevice callback functions are successful and global ones
like mpls_dev_notify fail, register_netdevice would then fails.

     // net/core/dev.c
     static int call_netdevice_notifiers_info(unsigned long val,
     					 struct netdev_notifier_info *info)
     {
     	struct net *net = dev_net(info->dev);
     	int ret;

     	ASSERT_RTNL();

     	/* Run per-netns notifier block chain first, then run the global one.
     	 * Hopefully, one day, the global one is going to be removed after
     	 * all notifier block registrators get converted to be per-netns.
     	 */
     	ret = raw_notifier_call_chain(&net->netdev_chain, val, info);
     	if (ret & NOTIFY_STOP_MASK)
     		return ret;
     	return raw_notifier_call_chain(&netdev_chain, val, info);
     }


This causes the created net_device struct to be destroyed. Since per-netns
netdevice callback functions have been successful, the netdevice is still
used by netdevice_event_work_handler which cause this "KASAN: use-after-free"
bug.


[1] https://syzkaller.appspot.com/text?tag=Patch&x=1799f8a2900000
[2] https://github.com/coiby/linux/commit/859f817317c8cd4a17af8879094db8697a2c7754
[3] https://github.com/coiby/linux/commit/260ddb9ec9b124ca7ad93f368eadb90b16edf2ef
