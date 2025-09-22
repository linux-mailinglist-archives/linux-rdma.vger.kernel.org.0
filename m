Return-Path: <linux-rdma+bounces-13566-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFCEB90F18
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 13:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED10423A1E
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 11:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A3A305964;
	Mon, 22 Sep 2025 11:57:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C925B303A1E;
	Mon, 22 Sep 2025 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758542245; cv=none; b=PuOJenppUBjLpszfqHNhMN5azO5QxgQjBE1Llsc9ISf0kNMLU/XtP1vNMKYh516X8W8cZFLfo7rkVGcEGYdVnApg9an6qx7+9KxRQ+J8X1wk/34CdGPZn1cevTslUV+d10zPyrTvurTZpDfU6q0Uk+SIjPHYvINAIXFvRqQZelA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758542245; c=relaxed/simple;
	bh=GvG5ejXGXPafTAj+efoN2UKdHGx1hTFLARGVrTbUyiQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D2lGYzgMuFpPr/FX5MtGiGdXMA9SC9m/ulkuM9ohFAZpt3HmnHQa48qET+vQd/oJGkdgxbP1aJX3m+xWe4kY07auLcMJHYD/XRBlSyXtvsFN5+On88TbriAJFytJTjoRTHYUy7XD3G92ulzBWFW7J5+Z4ed8tdWnlIxcQQwP+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cVhNG3dpDz1R9BM;
	Mon, 22 Sep 2025 19:54:06 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 874181800B2;
	Mon, 22 Sep 2025 19:57:14 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Sep
 2025 19:57:13 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <alibuda@linux.alibaba.com>, <dust.li@linux.alibaba.com>,
	<sidraya@linux.ibm.com>, <wenjia@linux.ibm.com>, <mjambigi@linux.ibm.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-s390@vger.kernel.org>
Subject: [PATCH net] net/smc: fix general protection fault in __smc_diag_dump
Date: Mon, 22 Sep 2025 20:18:18 +0800
Message-ID: <20250922121818.654011-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500016.china.huawei.com (7.185.36.197)

The syzbot report a crash:

  Oops: general protection fault, probably for non-canonical address 0xfbd5a5d5a0000003: 0000 [#1] SMP KASAN NOPTI
  KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xdead4ead0000001f]
  CPU: 1 UID: 0 PID: 6949 Comm: syz.0.335 Not tainted syzkaller #0 PREEMPT(full)
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
  RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
  RIP: 0010:__smc_diag_dump.constprop.0+0x3ca/0x2550 net/smc/smc_diag.c:89
  Call Trace:
   <TASK>
   smc_diag_dump_proto+0x26d/0x420 net/smc/smc_diag.c:217
   smc_diag_dump+0x27/0x90 net/smc/smc_diag.c:234
   netlink_dump+0x539/0xd30 net/netlink/af_netlink.c:2327
   __netlink_dump_start+0x6d6/0x990 net/netlink/af_netlink.c:2442
   netlink_dump_start include/linux/netlink.h:341 [inline]
   smc_diag_handler_dump+0x1f9/0x240 net/smc/smc_diag.c:251
   __sock_diag_cmd net/core/sock_diag.c:249 [inline]
   sock_diag_rcv_msg+0x438/0x790 net/core/sock_diag.c:285
   netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
   netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
   netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1346
   netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
   sock_sendmsg_nosec net/socket.c:714 [inline]
   __sock_sendmsg net/socket.c:729 [inline]
   ____sys_sendmsg+0xa95/0xc70 net/socket.c:2614
   ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
   __sys_sendmsg+0x16d/0x220 net/socket.c:2700
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

The process like this:

               (CPU1)              |             (CPU2)
  ---------------------------------|-------------------------------
  inet_create()                    |
    // init clcsock to NULL        |
    sk = sk_alloc()                |
                                   |
    // unexpectedly change clcsock |
    inet_init_csk_locks()          |
                                   |
    // add sk to hash table        |
    smc_inet_init_sock()           |
      smc_sk_init()                |
        smc_hash_sk()              |
                                   | // traverse the hash table
                                   | smc_diag_dump_proto
                                   |   __smc_diag_dump()
                                   |     // visit wrong clcsock
                                   |     smc_diag_msg_common_fill()
    // alloc clcsock               |
    smc_create_clcsk               |
      sock_create_kern             |

With CONFIG_DEBUG_LOCK_ALLOC=y, the smc->clcsock is unexpectedly changed
in inet_init_csk_locks(), because the struct smc_sock does not have struct
inet_connection_sock as the first member.

Previous commit 60ada4fe644e ("smc: Fix various oops due to inet_sock type
confusion.") add inet_sock as the first member of smc_sock. For protocol
with INET_PROTOSW_ICSK, use inet_connection_sock instead of inet_sock is
more appropriate.

Reported-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e
Tested-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/smc/smc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 2c9084963739..1b20f0c927d3 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -285,7 +285,7 @@ struct smc_connection {
 struct smc_sock {				/* smc sock container */
 	union {
 		struct sock		sk;
-		struct inet_sock	icsk_inet;
+		struct inet_connection_sock	inet_conn;
 	};
 	struct socket		*clcsock;	/* internal tcp socket */
 	void			(*clcsk_state_change)(struct sock *sk);
-- 
2.34.1


