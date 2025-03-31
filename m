Return-Path: <linux-rdma+bounces-9032-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC207A760BA
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Mar 2025 10:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3174B18888C0
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Mar 2025 08:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2BD1D516A;
	Mon, 31 Mar 2025 08:00:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506BD7083C;
	Mon, 31 Mar 2025 07:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408000; cv=none; b=iTbn/GBW5d5dhO5K4rmMW1GSQAFz/8/sJ+Q9k6T4niVcbS4UwuTnRvE1ObUjJnS/AYi1h2AnWI27IfaJ+PF/vNRIW/GNY02R2hToRQ9mZT94MXHDS2aqKaY3dmHEyd5tvKNLns09cFt8c83H2lBlCm5RU/flUeQkbpjQbOwkn8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408000; c=relaxed/simple;
	bh=eQLxR96AEH+hQX8sCpZ8ht3V4w2BaVTTbv926vjsZbo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jL9Ml66oFm0xIwnE1wOk/6tmMYqybm4IcLxrUUaeaCBBYqPyaAriLGs3n7Hemg0HFn2mOT2lntwqVZtgLou4+oWvqaIe/swNox1JvQqDIbrQ8SA8jqAU3+4WJoFIlDDyM+GX7CsawXOwU0X+Ho43mIbmyynwHRHMOOD+H71j8eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZR3TR5XL8z27hPF;
	Mon, 31 Mar 2025 16:00:27 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 16F971A0188;
	Mon, 31 Mar 2025 15:59:49 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200005.china.huawei.com
 (7.202.181.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 31 Mar
 2025 15:59:47 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <ubraun@linux.vnet.ibm.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <linux-rdma@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net] net/smc: fix general protection fault in __smc_diag_dump
Date: Mon, 31 Mar 2025 16:10:03 +0800
Message-ID: <20250331081003.1503211-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200005.china.huawei.com (7.202.181.32)

Syzbot reported a general protection fault:

  CPU: 0 UID: 0 PID: 5830 Comm: syz-executor600 Not tainted 6.14.0-rc4-syzkaller-00090-gdd83757f6e68 #0
  RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
  RIP: 0010:__smc_diag_dump.constprop.0+0x3de/0x23d0 net/smc/smc_diag.c:89
  Call Trace:
   <TASK>
   smc_diag_dump_proto+0x26d/0x420 net/smc/smc_diag.c:217
   smc_diag_dump+0x84/0x90 net/smc/smc_diag.c:236
   netlink_dump+0x53c/0xd00 net/netlink/af_netlink.c:2318
   __netlink_dump_start+0x6ca/0x970 net/netlink/af_netlink.c:2433
   netlink_dump_start include/linux/netlink.h:340 [inline]
   smc_diag_handler_dump+0x1fb/0x240 net/smc/smc_diag.c:251
   __sock_diag_cmd net/core/sock_diag.c:249 [inline]
   sock_diag_rcv_msg+0x437/0x790 net/core/sock_diag.c:287
   netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2543
   netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
   netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1348
   netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1892
   sock_sendmsg_nosec net/socket.c:718 [inline]
   __sock_sendmsg net/socket.c:733 [inline]
   ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2573
   ___sys_sendmsg+0x135/0x1e0 net/socket.c:2627
   __sys_sendmsg+0x16e/0x220 net/socket.c:2659
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

When create smc socket, smc_inet_init_sock() first add sk to the smc_hash
by smc_hash_sk(), then create smc->clcsock. it is possible that, after
smc_diag_dump_proto() traverses the smc_hash, smc->clcsock is not created
when the function visit it.

The process like this:

  (CPU1)                         | (CPU2)
  inet6_create()                 |
    smc_inet_init_sock()         |
      smc_sk_init()              |
        smc_hash_sk()            |
          head = &smc_hash->ht;  |
          sk_add_node(sk, head); |
                                 | smc_diag_dump_proto
                                 |   head = &smc_hash->ht;
                                 |     sk_for_each(sk, head)
                                 |       __smc_diag_dump()
                                 |         visit smc->clcsock
      smc_create_clcsk()         |
          set smc->clcsock       |

Fix this by initialize smc->clcsock to NULL before add sk to smc_hash in
smc_sk_init().

Reported-by: syzbot+271fed3ed6f24600c364@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364
Fixes: f16a7dd5cf27 ("smc: netlink interface for SMC sockets")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/smc/af_smc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 3e6cb35baf25..454801188514 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -371,6 +371,7 @@ void smc_sk_init(struct net *net, struct sock *sk, int protocol)
 	sk->sk_protocol = protocol;
 	WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
 	WRITE_ONCE(sk->sk_rcvbuf, 2 * READ_ONCE(net->smc.sysctl_rmem));
+	smc->clcsock = NULL;
 	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
 	INIT_WORK(&smc->connect_work, smc_connect_work);
 	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);
-- 
2.34.1


