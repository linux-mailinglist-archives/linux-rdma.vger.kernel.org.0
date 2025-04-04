Return-Path: <linux-rdma+bounces-9147-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D80A7BA68
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 12:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 893597A5D22
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 10:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13516199E94;
	Fri,  4 Apr 2025 10:07:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpgw-1-2.nogo.comp.nus.edu.sg (84-20.comp.nus.edu.sg [137.132.84.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3592D158858
	for <linux-rdma@vger.kernel.org>; Fri,  4 Apr 2025 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=137.132.84.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743761246; cv=none; b=eYDynCvJ9jyVdXdw64hOIHYUNaF/cq+LlciTHjozAvpdznoDKkwo2vT0dLy4XxTZUb50SxPoQwdUpOiI6M8OEOFXjxk4nLwHctsbpCdtu+U9uVbk/0FqCdJBtPyg4156QpW9/Zv09++kbtWGvhmtH5QwqpXuFI8FaxHoQQHeCSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743761246; c=relaxed/simple;
	bh=3897f+7hwiKaoRxyUmq7GI7ztVqgyFGJt5e3hNj/ndw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGood/5Jf8i9uA6yuWRKwdsb5f6h9v5ivvf9VHs4eYhrtfKf0qE/RAuiNEzdSByonS9pBBmjcHgahZRxpqYYk6pK4jfjEPadj8HfvDV2fPunTI0Ftl5f7Tb/GCWKozTRvqfI9jOBStstnXyuw+3UYPU0sPD5zGb0V7Gkw1JVUnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comp.nus.edu.sg; spf=pass smtp.mailfrom=comp.nus.edu.sg; arc=none smtp.client-ip=137.132.84.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comp.nus.edu.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comp.nus.edu.sg
Received: from localhost (localhost [127.0.0.1])
	by smtpgw-1-2.nogo.comp.nus.edu.sg (Postfix) with ESMTP id A2E8B161213
	for <linux-rdma@vger.kernel.org>; Fri,  4 Apr 2025 18:07:15 +0800 (+08)
X-Virus-Scanned: Debian amavisd-new at smtpgw-1-2.comp.nus.edu.sg
Received: from smtpgw-1-2.nogo.comp.nus.edu.sg ([127.0.0.1])
	by localhost (smtpgw-1-2.comp.nus.edu.sg [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UbXgBzFtNjm8 for <linux-rdma@vger.kernel.org>;
	Fri,  4 Apr 2025 18:07:13 +0800 (+08)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtpgw-1-2.nogo.comp.nus.edu.sg (Postfix) with ESMTPS
	for <linux-rdma@vger.kernel.org>; Fri,  4 Apr 2025 18:07:13 +0800 (+08)
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3913aaf1e32so1130339f8f.0
        for <linux-rdma@vger.kernel.org>; Fri, 04 Apr 2025 03:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743761231; x=1744366031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ZpNezVgO9x7n4qO105SQS96YwFjL8olWX+bTsb/hm8=;
        b=LT8b7w44peZbY2RBw84BksPGIdOkWVucMJJnySji5vHPYHkM7CET98Lb0tspSkyIJr
         j9TKXQjTlrbg8la/I1nCAq/YEk0NZPNpHuHYqbXYI5IiDaoV+9ZUmaRVtqmWpqVUxBQj
         wLELFbcyFR6HBdQcuyXuhj+qFPaVh9G6YWQ+gXvBHjdMjFayw61FrVgjSc83KVyaUbp1
         dTEBn/it3YJsswzXJUqg+P7fx3Gfh4RPHjPsjjXnilWK8OzEDITgQqvuYIK4eSozwO5V
         QCwkkm3cvdhppxcPs8LVg80x1b3VasWYzb/MpgZEWnW6C6Rj6pBkqL1+AR8upBuGvYnH
         mgYw==
X-Forwarded-Encrypted: i=1; AJvYcCUBpAEjoKe64ODWB0FByLvAdqO88YnbkPXhZgt1IJqzgWsYhFJ8JzllcZfrO9jmbxbP3cq81yoiCUzU@vger.kernel.org
X-Gm-Message-State: AOJu0YxroL7YMOKotVeuAy+RIeC6SSs7+S7kksKLZ1xpKgMicZXiu1Bn
	3FHGkpWtfwYKq7wb+69thH4h7iuHXCXi3n0Pftj8ztDcPYMDuh7BKi7xcOWfSf3el3fiHlFe+iX
	bzIupwEJVzGX15EMq2m8jqro5ucv/HThzQVWxt0C5eWhD8pwqprsrdjS8FVrZ7YzEFnHxYxsuX8
	ALXKI+rchCAP5TVhV9jzN9cE+kAM/ipiG7/Iie
X-Gm-Gg: ASbGncs8S59Nq9gvWeCpthU+DpvUaFGNRdUV8myycIDW1q7RQC9rf7OcD030pw3Ypoe
	byPSBaKro3njGq0YEwOALZafbNv0DVRah104VEs/sQVpLGErIpsZTARtl8AeWA1t4Jhcws3aE
X-Received: by 2002:a05:6000:250a:b0:391:12a5:3cb3 with SMTP id ffacd0b85a97d-39d0873fd19mr1961970f8f.3.1743761231027;
        Fri, 04 Apr 2025 03:07:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnV9UwamRIyUKW4GOeVIE6okjNq3Qre3D7SkA3sH+0E9q8u3+uxXUpzfrOeOLdg3VB/t7Fg1OQd0ITTfIEdyI=
X-Received: by 2002:a05:6000:250a:b0:391:12a5:3cb3 with SMTP id
 ffacd0b85a97d-39d0873fd19mr1961925f8f.3.1743761230468; Fri, 04 Apr 2025
 03:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJeEPuJHMKo9T3GcAQH2+X3Rke3b4YH3_S6FmnBp4tQqLciYxA@mail.gmail.com>
 <d9a7af40-84f9-446e-a708-d989b322a675@redhat.com>
In-Reply-To: <d9a7af40-84f9-446e-a708-d989b322a675@redhat.com>
From: Dylan Wolff <wolffd@comp.nus.edu.sg>
Date: Fri, 4 Apr 2025 11:06:54 +0100
X-Gm-Features: ATxdqUGjSovVAVF6K8PXa6s9vuuhQUTiYOJzVc35JHTkd4RbECGCtmQYxgPvbLQ
Message-ID: <CAJeEPuLOz45eOt0_Uab-XtOxYwEOpw4Mq3SZDw21T=wUBVL2TQ@mail.gmail.com>
Subject: Re: Concurrent slab-use-after-free in netdev_next_lower_dev
To: Paolo Abeni <pabeni@redhat.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiacheng Xu <3170103308@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Please share the decoded syzkaller/kasan splat in plaintext instead of
describing it in natural language, and please avoid attachments unless
explicitly asked for.

Got it! Here is the report:

```
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in netdev_next_lower_dev
net/core/dev.c:7522 [inline]
BUG: KASAN: slab-use-after-free in
netdev_walk_all_lower_dev+0x1e6/0x4f0 net/core/dev.c:7570
Read of size 8 at addr ffff888058cdc1b8 by task syz-executor.3/14127

CPU: 1 UID: 0 PID: 14127 Comm: syz-executor.3 Not tainted 6.13.0-rc4 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Sched_ext: serialise (enabled+all), task: runnable_at=3D-10ms
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x229/0x350 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x164/0x530 mm/kasan/report.c:489
 kasan_report+0x147/0x180 mm/kasan/report.c:602
 netdev_next_lower_dev net/core/dev.c:7522 [inline]
 netdev_walk_all_lower_dev+0x1e6/0x4f0 net/core/dev.c:7570
 smc_vlan_by_tcpsk+0x45a/0x5b0 net/smc/smc_core.c:1904
 __smc_connect+0x391/0x1af0 net/smc/af_smc.c:1517
 smc_connect+0x610/0x8e0 net/smc/af_smc.c:1693
 __sys_connect+0x181/0x220 net/socket.c:2074
 __do_sys_connect net/socket.c:2080 [inline]
 __se_sys_connect net/socket.c:2077 [inline]
 __x64_sys_connect+0x9e/0xb0 net/socket.c:2077
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f168ca903ad
Code: c3 e8 a7 2b 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f168d843fc8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f168cbcc050 RCX: 00007f168ca903ad
RDX: 000000000000001c RSI: 0000000020000080 RDI: 000000000000000a
RBP: 00007f168cbcc050 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f168cbcc050 R14: 00007f168ca4fc90 R15: 00007f168d824000
 </TASK>

Allocated by task 11284:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x89/0xa0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4298 [inline]
 __kmalloc_node_noprof+0x28c/0x530 mm/slub.c:4304
 __kvmalloc_node_noprof+0x70/0x180 mm/util.c:650
 alloc_netdev_mqs+0xa7/0x1870 net/core/dev.c:11209
 rtnl_create_link+0x371/0xeb0 net/core/rtnetlink.c:3595
 rtnl_newlink_create+0x257/0x690 net/core/rtnetlink.c:3771
 __rtnl_newlink net/core/rtnetlink.c:3897 [inline]
 rtnl_newlink+0x13a9/0x1ac0 net/core/rtnetlink.c:4012
 rtnetlink_rcv_msg+0x8e1/0xf50 net/core/rtnetlink.c:6922
 netlink_rcv_skb+0x248/0x4e0 net/netlink/af_netlink.c:2542
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7b8/0x8e0 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0xb42/0xe90 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec+0x1f5/0x250 net/socket.c:711
 __sock_sendmsg net/socket.c:726 [inline]
 __sys_sendto+0x45d/0x5d0 net/socket.c:2197
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0x128/0x140 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 14126:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x5a/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kfree+0x196/0x450 mm/slub.c:4761
 device_release+0xbd/0x220
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x248/0x490 lib/kobject.c:737
 netdev_run_todo+0x10e0/0x1280 net/core/dev.c:10924
 rtnl_unlock net/core/rtnetlink.c:152 [inline]
 rtnl_net_unlock include/linux/rtnetlink.h:133 [inline]
 rtnl_dellink+0x850/0x9c0 net/core/rtnetlink.c:3526
 rtnetlink_rcv_msg+0x8e1/0xf50 net/core/rtnetlink.c:6922
 netlink_rcv_skb+0x248/0x4e0 net/netlink/af_netlink.c:2542
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7b8/0x8e0 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0xb42/0xe90 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec+0x1f5/0x250 net/socket.c:711
 __sock_sendmsg net/socket.c:726 [inline]
 sock_write_iter+0x3a5/0x4f0 net/socket.c:1147
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x7dd/0x950 fs/read_write.c:679
 ksys_write+0x24d/0x400 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xaa/0xc0 mm/kasan/generic.c:544
 insert_work+0x3d/0x330 kernel/workqueue.c:2183
 __queue_work+0xc87/0xf50 kernel/workqueue.c:2339
 queue_work_on+0x1c8/0x390 kernel/workqueue.c:2390
 queue_work include/linux/workqueue.h:662 [inline]
 schedule_work include/linux/workqueue.h:723 [inline]
 __rhashtable_remove_fast_one include/linux/rhashtable.h:1069 [inline]
 __rhashtable_remove_fast include/linux/rhashtable.h:1093 [inline]
 rhashtable_remove_fast+0xbd7/0xc60 include/linux/rhashtable.h:1122
 br_multicast_del_mdb_entry+0x7d/0x300 net/bridge/br_multicast.c:642
 br_multicast_dev_del+0x11e/0x2d0 net/bridge/br_multicast.c:4366
 br_dev_uninit+0x1c/0x40 net/bridge/br_device.c:155
 unregister_netdevice_many_notify+0x1a4f/0x2110 net/core/dev.c:11548
 rtnl_delete_link net/core/rtnetlink.c:3476 [inline]
 rtnl_dellink+0x6de/0x9c0 net/core/rtnetlink.c:3518
 rtnetlink_rcv_msg+0x8e1/0xf50 net/core/rtnetlink.c:6922
 netlink_rcv_skb+0x248/0x4e0 net/netlink/af_netlink.c:2542
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7b8/0x8e0 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0xb42/0xe90 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec+0x1f5/0x250 net/socket.c:711
 __sock_sendmsg net/socket.c:726 [inline]
 sock_write_iter+0x3a5/0x4f0 net/socket.c:1147
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x7dd/0x950 fs/read_write.c:679
 ksys_write+0x24d/0x400 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Second to last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xaa/0xc0 mm/kasan/generic.c:544
 insert_work+0x3d/0x330 kernel/workqueue.c:2183
 __queue_work+0xc87/0xf50 kernel/workqueue.c:2339
 queue_work_on+0x1c8/0x390 kernel/workqueue.c:2390
 br_multicast_dev_del+0x11e/0x2d0 net/bridge/br_multicast.c:4366
 br_dev_uninit+0x1c/0x40 net/bridge/br_device.c:155
 unregister_netdevice_many_notify+0x1a4f/0x2110 net/core/dev.c:11548
 rtnl_delete_link net/core/rtnetlink.c:3476 [inline]
 rtnl_dellink+0x6de/0x9c0 net/core/rtnetlink.c:3518
 rtnetlink_rcv_msg+0x8e1/0xf50 net/core/rtnetlink.c:6922
 netlink_rcv_skb+0x248/0x4e0 net/netlink/af_netlink.c:2542
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7b8/0x8e0 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0xb42/0xe90 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec+0x1f5/0x250 net/socket.c:711
 __sock_sendmsg net/socket.c:726 [inline]
 sock_write_iter+0x3a5/0x4f0 net/socket.c:1147
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x7dd/0x950 fs/read_write.c:679
 ksys_write+0x24d/0x400 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888058cdc000
 which belongs to the cache kmalloc-cg-8k of size 8192
The buggy address is located 440 bytes inside of
 freed 8192-byte region [ffff888058cdc000, ffff888058cde000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000
index:0xffff888058cdc000 pfn:0x58cd8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888056dd42c1
flags: 0x4fff00000000040(head|node=3D1|zone=3D1|lastcpupid=3D0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff88801d44f640 ffffea000050d800 dead000000000004
raw: ffff888058cdc000 0000000000020001 00000001f5000000 ffff888056dd42c1
head: 04fff00000000040 ffff88801d44f640 ffffea000050d800 dead000000000004
head: ffff888058cdc000 0000000000020001 00000001f5000000 ffff888056dd42c1
head: 04fff00000000003 ffffea0001633601 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask
0xd60c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_NORETRY|__=
GFP_COMP|__GFP_NOMEMALLOC),
pid 9657, tgid 9657 (syz-executor.2), ts 72098481985, free_ts
71817430134
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f6/0x240 mm/page_alloc.c:1558
 prep_new_page mm/page_alloc.c:1566 [inline]
 get_page_from_freelist+0x3586/0x36d0 mm/page_alloc.c:3476
 __alloc_pages_noprof+0x260/0x680 mm/page_alloc.c:4753
 alloc_pages_mpol_noprof+0x3c8/0x650 mm/mempolicy.c:2269
 alloc_slab_page+0x6a/0x110 mm/slub.c:2423
 allocate_slab+0x5f/0x2b0 mm/slub.c:2589
 new_slab mm/slub.c:2642 [inline]
 ___slab_alloc+0xbdf/0x1490 mm/slub.c:3830
 __slab_alloc mm/slub.c:3920 [inline]
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 __do_kmalloc_node mm/slub.c:4297 [inline]
 __kmalloc_node_noprof+0x314/0x530 mm/slub.c:4304
 __kvmalloc_node_noprof+0x70/0x180 mm/util.c:650
 alloc_netdev_mqs+0xa7/0x1870 net/core/dev.c:11209
 rtnl_create_link+0x371/0xeb0 net/core/rtnetlink.c:3595
 rtnl_newlink_create+0x257/0x690 net/core/rtnetlink.c:3771
 __rtnl_newlink net/core/rtnetlink.c:3897 [inline]
 rtnl_newlink+0x13a9/0x1ac0 net/core/rtnetlink.c:4012
 rtnetlink_rcv_msg+0x8e1/0xf50 net/core/rtnetlink.c:6922
 netlink_rcv_skb+0x248/0x4e0 net/netlink/af_netlink.c:2542
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7b8/0x8e0 net/netlink/af_netlink.c:1347
page last free pid 98 tgid 98 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_folios+0xe03/0x1860 mm/page_alloc.c:2706
 shrink_folio_list+0x5304/0x5c80 mm/vmscan.c:1551
 evict_folios+0x3b12/0x5610 mm/vmscan.c:4593
 try_to_shrink_lruvec+0x941/0xc10 mm/vmscan.c:4789
 shrink_one+0x20e/0x870 mm/vmscan.c:4834
 shrink_many mm/vmscan.c:4897 [inline]
 lru_gen_shrink_node mm/vmscan.c:4975 [inline]
 shrink_node+0x3862/0x3f20 mm/vmscan.c:5956
 kswapd_shrink_node mm/vmscan.c:6785 [inline]
 balance_pgdat mm/vmscan.c:6977 [inline]
 kswapd+0x1c9f/0x36f0 mm/vmscan.c:7246
 kthread+0x2c3/0x360 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888058cdc080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888058cdc100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888058cdc180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff888058cdc200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888058cdc280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
```

> Also, can you reproduce the issue on top of the current net tree?

No, but we are having trouble reproducing it even on 6.13.0-rc4. Since
I don't fully understand the root cause, it's hard to say if it is
fixed in the current tree or just hard to reproduce.

> netdev_walk_all_lower_dev() should not need additional refcounting, as
it is traversing the list under rtnl lock, and device should be removed
from the adjacency list before the actual device free under such lock, too.

I see. Then I confess I'm really not sure what is happening with this
crash. If you have any pointers for where to look or why it is so
difficult to reproduce, let me know. Otherwise I will keep working on
trying to find a reproducible setup.

Thanks for your help!
Dylan
On Tue, Apr 1, 2025 at 8:45=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 3/31/25 3:00 PM, Dylan Wolff wrote:
> > From the report, it looks like the net_device is freed at the end of an
> > rtnl critical section in netdev_run_todo. At the time of the crash, the
> > *use* thread has acquired rtnl_lock() in smc_vlan_by_tcpsk. The crash
> > occurred at the line preceded by `>>>` below in 6.13 rc4 while iteratin=
g
> > over devices with netdev_walk_all_lower_dev:
> >
> > ```
> > static struct net_device *netdev_next_lower_dev(struct net_device *dev,
> > struct list_head **iter)
> > {
> > struct netdev_adjacent *lower;
> >
> >>>> lower =3D list_entry((*iter)->next, struct netdev_adjacent, list);
> >
> > if (&lower->list =3D=3D &dev->adj_list.lower)
> > return NULL;
> >
> > *iter =3D &lower->list;
> >
> > return lower->dev;
> > }
> > ```
>
> Please share the decoded syzkaller/kasan splat in plaintext instead of
> describing it in natural language, and please avoid attachments unless
> explicitly asked for.
>
> Also, can you reproduce the issue on top of the current net tree?
>
> > This looks to me like it is an issue with reference counting; I see tha=
t
> > netdev_refcnt_read is checked in netdev_run_todo before the device is
> > freed, but I don't see anything in netdev_walk_all_lower_dev /
> > netdev_next_lower_dev that is incrementing netdev_refcnt_read when it i=
s
> > iterating over the devices. I'm guessing the fix is to either add refer=
ence
> > counting to netdev_walk_all_lower_dev or to use a different,
> > concurrency-safe iterator over the devices in the caller (smc_vlan_by_t=
cpsk
> > ).
> >
> > Could someone confirm if I am on the right track here? If so I am happy=
 to
> > try to come up with the patch.
>
> netdev_walk_all_lower_dev() should not need additional refcounting, as
> it is traversing the list under rtnl lock, and device should be removed
> from the adjacency list  before the actual device free under such lock, t=
oo.
>
> Thanks,
>
> Paolo
>

