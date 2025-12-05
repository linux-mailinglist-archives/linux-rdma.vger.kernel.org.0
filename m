Return-Path: <linux-rdma+bounces-14903-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C02CA8167
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Dec 2025 16:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71A3B316C887
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Dec 2025 14:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5E62FF66A;
	Fri,  5 Dec 2025 14:20:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C93D2745C;
	Fri,  5 Dec 2025 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764944438; cv=none; b=cOoVvALkqmtGNz25bMzvtQyOoEPF9PX/9dOefNb1UGU9iM0CPMXycVD1aEffcG60WLTOstZglSxVn7Ff+NSBzhqpboDxqli2tnW1Oj8efscgCYXzA7LlEl626TgSLLKjNaVscOX1nJi+M2rwQySASTD3DKAo62nLgFCI+FkSRNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764944438; c=relaxed/simple;
	bh=6qWcomkKsDORhle21oPalA9U/qkT+YrO0YTpij/7ts8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=MeK7PownhtORQYzsyWaEpi88FAYb2KQqJxW7lnuuXIKCFl4ry3cfM+pbly3WlTGkwDlBYjAtjtxWbmjOtKxxBD3FF0xQp/BOqBORvRUdylmjW68dYHU+YrfwMNr3nQU8xRSIXBUHA0hahnarOJQiT1U6M+HnswtH5nntVtBK/B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5B5EKDgk082831;
	Fri, 5 Dec 2025 23:20:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5B5EKDr9082828
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 5 Dec 2025 23:20:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8f90fba8-60b9-46e2-8990-45311c7b1540@I-love.SAKURA.ne.jp>
Date: Fri, 5 Dec 2025 23:20:11 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [rdma/siw] unregister_netdevice: waiting for bond0 to become
 free. Usage count = 3
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Bernard Metzler <bernard.metzler@linux.dev>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
References: <30ec01df-6c32-490c-aa26-c41653f5a257@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <30ec01df-6c32-490c-aa26-c41653f5a257@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav404.rs.sakura.ne.jp

On 2025/11/25 23:31, Tetsuo Handa wrote:
> The output from the debug printk() patch is attached (because it has 2500 lines).
> You can see that there is one alloc_gid_entry() call in bond0[74] but there is
> no corresponding put_gid_ndev() call. I suspect that there is a refcount leak in
> "struct ib_gid_table_entry" handling. Where should we check next?

Another debug printk() patch in next-20251204 reported that there is a refcount
leak in "struct ib_gid_table_entry" handling.

Is serialization between creating a new ib_gid_table_entry and deleting existing
ib_gid_table_entry properly implemented (like a similar case explained in
https://lkml.kernel.org/r/85b701a9-511d-4cf2-8c9c-5fade945f187@I-love.SAKURA.ne.jp ) ?
Don't we need to check ndev->reg_state when creating a new ib_gid_table_entry (like
https://lkml.kernel.org/r/b9653191-d479-4c8b-8536-1326d028db5c@I-love.SAKURA.ne.jp does) ?

Regards.



unregister_netdevice: waiting for ������ to become free. Usage count = 3
ref_tracker: netdev@ffff88805e01c628 has 1/1 users at
     __netdev_tracker_alloc include/linux/netdevice.h:4415 [inline]
     netdev_hold include/linux/netdevice.h:4444 [inline]
     ib_device_set_netdev+0x2e1/0x6d0 drivers/infiniband/core/device.c:2253
     rxe_register_device+0x1bb/0x350 drivers/infiniband/sw/rxe/rxe_verbs.c:1552
     rxe_net_add+0x81/0x110 drivers/infiniband/sw/rxe/rxe_net.c:586
     rxe_newlink+0xdd/0x190 drivers/infiniband/sw/rxe/rxe.c:234
     nldev_newlink+0x4a5/0x5a0 drivers/infiniband/core/nldev.c:1797
     rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:-1 [inline]
     rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
     rdma_nl_rcv+0x6ae/0x980 drivers/infiniband/core/netlink.c:259
     netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
     netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1344
     netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1894
     sock_sendmsg_nosec+0x18f/0x1d0 net/socket.c:728
     __sock_sendmsg net/socket.c:743 [inline]
     ____sys_sendmsg+0x577/0x880 net/socket.c:2601
     ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2655
     __sys_sendmsg net/socket.c:2687 [inline]
     __do_sys_sendmsg net/socket.c:2692 [inline]
     __se_sys_sendmsg net/socket.c:2690 [inline]
     __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2690
     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
     do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

Call trace for ������@ffff8880254b5f00 +1 at
     alloc_gid_entry drivers/infiniband/core/cache.c:410 [inline]
     add_modify_gid+0x317/0xcc0 drivers/infiniband/core/cache.c:550
     __ib_cache_gid_add+0x230/0x370 drivers/infiniband/core/cache.c:681
     ib_cache_gid_set_default_gid+0x5f9/0x710 drivers/infiniband/core/cache.c:960
     add_default_gids drivers/infiniband/core/roce_gid_mgmt.c:469 [inline]
     enum_all_gids_of_dev_cb+0x17d/0x270 drivers/infiniband/core/roce_gid_mgmt.c:495
     ib_enum_roce_netdev+0x1ab/0x2e0 drivers/infiniband/core/device.c:2419
     gid_table_setup_one drivers/infiniband/core/cache.c:1033 [inline]
     ib_cache_setup_one+0x428/0x5e0 drivers/infiniband/core/cache.c:1711
     ib_register_device+0xfbe/0x1400 drivers/infiniband/core/device.c:1454
     rxe_register_device+0x1e3/0x350 drivers/infiniband/sw/rxe/rxe_verbs.c:1556
     rxe_net_add+0x81/0x110 drivers/infiniband/sw/rxe/rxe_net.c:586
     rxe_newlink+0xdd/0x190 drivers/infiniband/sw/rxe/rxe.c:234
     nldev_newlink+0x4a5/0x5a0 drivers/infiniband/core/nldev.c:1797
     rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:-1 [inline]
     rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
     rdma_nl_rcv+0x6ae/0x980 drivers/infiniband/core/netlink.c:259
     netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
     netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1344
     netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1894
     sock_sendmsg_nosec+0x18f/0x1d0 net/socket.c:728
Call trace for ������@ffff8880254b5f00 +4 at
     get_gid_entry drivers/infiniband/core/cache.c:435 [inline]
     rdma_get_gid_attr+0x2ee/0x3f0 drivers/infiniband/core/cache.c:1300
     smc_ib_fill_mac net/smc/smc_ib.c:160 [inline]
     smc_ib_remember_port_attr net/smc/smc_ib.c:369 [inline]
     smc_ib_port_event_work+0x196/0x940 net/smc/smc_ib.c:388
     process_one_work+0x93a/0x15a0 kernel/workqueue.c:3261
Call trace for ������@ffff8880254b5f00 -4 at
     put_gid_entry drivers/infiniband/core/cache.c:441 [inline]
     rdma_put_gid_attr+0x7c/0x130 drivers/infiniband/core/cache.c:1381
     smc_ib_fill_mac net/smc/smc_ib.c:165 [inline]
     smc_ib_remember_port_attr net/smc/smc_ib.c:369 [inline]
     smc_ib_port_event_work+0x1d4/0x940 net/smc/smc_ib.c:388
     process_one_work+0x93a/0x15a0 kernel/workqueue.c:3261
balance for ������@ib_gid_table_entry is 1


