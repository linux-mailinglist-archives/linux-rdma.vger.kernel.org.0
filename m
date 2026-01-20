Return-Path: <linux-rdma+bounces-15760-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2642FD3C4B5
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 11:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1B47E54A908
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B211E3D2FE2;
	Tue, 20 Jan 2026 09:59:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA74346782;
	Tue, 20 Jan 2026 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903154; cv=none; b=Z6XTVxaEPDV4SufUu+JPlyufze/P2ZCVfwu3Gfet/vCmOQu5F4zDEz/eh1ejOSXJGdvjmJ8M/EQnk5dwtSqy8xsB8N419qjYZx106e6Lq7KRvkfqLORRCFJ+MLrPBekCj6mz/IzpWoPPFhr1NZ/naPo/tmYMbwS4YXm5EO7QDq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903154; c=relaxed/simple;
	bh=joqL00WdqKenqaTwc96vjesjQqTc6gkTXH3YfHBem0c=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=qVVu32bbH0GKHFMqy9BpbWSIDZW9d/X2IwohAgl0DQhDtmxyQIxFhW2MT9kXqAmi5tXTT+5GceMtgz7rxU1yIp+yd/JRc4XpnCqpR9KsLukdstF/BMZ17XyOt802MyQSnqETsHRemd1YvP5Gc+X9+ibq3Cv8LkPZVrVNYkht/7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60K9x128038233;
	Tue, 20 Jan 2026 18:59:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60K9x1NC038229
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 20 Jan 2026 18:59:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c1f9511c-7ad0-444d-aa0c-516674702b4e@I-love.SAKURA.ne.jp>
Date: Tue, 20 Jan 2026 18:58:58 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Huy Nguyen <huyn@mellanox.com>, Parav Pandit <parav@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Maher Sanalla <msanalla@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>
Cc: OFED mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [rdma bug] del_default_gids() is not called upon NETDEV_UNREGISTER
 event
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav202.rs.sakura.ne.jp

Hello.

syzbot found in linux-next-20260116 that one of causes that appear as

  unregister_netdevice: waiting for bond1 to become free. Usage count = 2

problem ( https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84 ) is that
a refcount for "struct ib_gid_table_entry" is leaking because del_default_gids()
is not called upon NETDEV_UNREGISTER event; a debug printk() patch revealed that
only add_default_gids() was called.

Since "struct ib_gid_table_entry" takes a reference to "struct net_device" via
"struct roce_gid_ndev_storage", the corresponding NETDEV_UNREGISTER handler
must release that reference. Something was overlooked when writing commit
943bd984b108 ("RDMA/core: Allow detaching gid attribute netdevice for RoCE") ?


unregister_netdevice: waiting for bond1 to become free. Usage count = 2
Call trace for bond1@ffff888043434a00 +1 at
     alloc_gid_entry drivers/infiniband/core/cache.c:417 [inline]
     add_modify_gid+0x317/0xcc0 drivers/infiniband/core/cache.c:557
     __ib_cache_gid_add+0x230/0x370 drivers/infiniband/core/cache.c:688
     ib_cache_gid_set_default_gid+0x5f9/0x710 drivers/infiniband/core/cache.c:967
     add_default_gids drivers/infiniband/core/roce_gid_mgmt.c:492 [inline]
     enum_all_gids_of_dev_cb+0x17d/0x270 drivers/infiniband/core/roce_gid_mgmt.c:518
     ib_enum_roce_netdev+0x1ab/0x2e0 drivers/infiniband/core/device.c:2434
     gid_table_setup_one drivers/infiniband/core/cache.c:1040 [inline]
     ib_cache_setup_one+0x428/0x5e0 drivers/infiniband/core/cache.c:1719
     ib_register_device+0xfbe/0x1420 drivers/infiniband/core/device.c:1450
     rxe_register_device+0x1e3/0x350 drivers/infiniband/sw/rxe/rxe_verbs.c:1556
     rxe_net_add+0x81/0x110 drivers/infiniband/sw/rxe/rxe_net.c:618
     rxe_newlink+0xdd/0x190 drivers/infiniband/sw/rxe/rxe.c:234
     nldev_newlink+0x4a5/0x5a0 drivers/infiniband/core/nldev.c:1797
     rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:-1 [inline]
     rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
     rdma_nl_rcv+0x6ae/0x980 drivers/infiniband/core/netlink.c:259
     netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
     netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1344
     netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1894
     sock_sendmsg_nosec+0x18f/0x1d0 net/socket.c:737
Call trace for bond1@ffff888043434a00 +1 at
     get_gid_entry drivers/infiniband/core/cache.c:442 [inline]
     rdma_get_gid_attr+0x2ee/0x3f0 drivers/infiniband/core/cache.c:1307
     smc_ib_fill_mac net/smc/smc_ib.c:160 [inline]
     smc_ib_remember_port_attr net/smc/smc_ib.c:369 [inline]
     smc_ib_port_event_work+0x196/0x940 net/smc/smc_ib.c:388
     process_one_work+0x93a/0x15a0 kernel/workqueue.c:3279
Call trace for bond1@ffff888043434a00 -1 at
     put_gid_entry drivers/infiniband/core/cache.c:448 [inline]
     rdma_put_gid_attr+0x7c/0x130 drivers/infiniband/core/cache.c:1388
     smc_ib_fill_mac net/smc/smc_ib.c:165 [inline]
     smc_ib_remember_port_attr net/smc/smc_ib.c:369 [inline]
     smc_ib_port_event_work+0x1d4/0x940 net/smc/smc_ib.c:388
     process_one_work+0x93a/0x15a0 kernel/workqueue.c:3279
Call trace for bond1@ffff888043434a00 +1 !NETREG_REGISTERED at
     get_gid_entry drivers/infiniband/core/cache.c:442 [inline]
     rdma_get_gid_attr+0x2ee/0x3f0 drivers/infiniband/core/cache.c:1307
     smc_ib_fill_mac net/smc/smc_ib.c:160 [inline]
     smc_ib_remember_port_attr net/smc/smc_ib.c:369 [inline]
     smc_ib_port_event_work+0x196/0x940 net/smc/smc_ib.c:388
     process_one_work+0x93a/0x15a0 kernel/workqueue.c:3279
Call trace for bond1@ffff888043434a00 -1 !NETREG_REGISTERED at
     put_gid_entry drivers/infiniband/core/cache.c:448 [inline]
     rdma_put_gid_attr+0x7c/0x130 drivers/infiniband/core/cache.c:1388
     smc_ib_fill_mac net/smc/smc_ib.c:165 [inline]
     smc_ib_remember_port_attr net/smc/smc_ib.c:369 [inline]
     smc_ib_port_event_work+0x1d4/0x940 net/smc/smc_ib.c:388
     process_one_work+0x93a/0x15a0 kernel/workqueue.c:3279
infiniband: balance for bond1@ib_gid_table_entry is 1

