Return-Path: <linux-rdma+bounces-13912-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91070BE619D
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 04:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AED424E42FB
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 02:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688DA23EA9E;
	Fri, 17 Oct 2025 02:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="i3wI7OWN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983572253EE;
	Fri, 17 Oct 2025 02:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760667927; cv=none; b=QWwDAXXAv85PobqSQ6xf1W7g00IdGLhmeUST4BjsMKGWa6rfLgr6JaGF3Iwgl6mRlPlGdQWkbtwa8ViOsbcwk235LRrtUkZWFDN+OwtVHxNXpK7N9shXIZXGhJvOfkvCyg5tvHUmwv3aiO5653Bdk8CPVOYjU3f1Sg5dvp45Kg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760667927; c=relaxed/simple;
	bh=NSAdDY6cOXJW8eAr5he09srQ7MDvbUAWxEozTBGCJXk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XYL11qA5ZVeDhPFcJo/dv9+CRFGw+eRorBjTS+BGQBc3nzKXleXCLUCJukEJqLhoxsTt4deOx+r9lWYzaG2yupB3R45RkifiUU4/TgCKyXi30Yesa90DvB9QaQ9kVdvufiBV5JhGnYcsk+9h1JODx9l4xKRgXHt0ZbcDUWbZKvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=i3wI7OWN; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4EEMOhWg0s2E8Viik8fWlWI2UNFHPWp8xQDcxLWMscU=;
	b=i3wI7OWNKLUgaZLDP541UpggD2J5a8Xs8Ne4W/vSQ4+PMqlX6lHG146yE6X2zh22vOmFtvslT
	vXAf2v26u4oeREDCJHmaoChXf57lU0qDejFwDFdAf9HHo5cwC/fex43uporM331BqaIHphn0y2e
	ixixN/OzqB20euvK2YLfDrk=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4cnpZ30L6vz1prMP;
	Fri, 17 Oct 2025 10:24:59 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id B90D2140123;
	Fri, 17 Oct 2025 10:25:20 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Oct
 2025 10:25:19 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <alibuda@linux.alibaba.com>, <dust.li@linux.alibaba.com>,
	<sidraya@linux.ibm.com>, <wenjia@linux.ibm.com>, <mjambigi@linux.ibm.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>
Subject: [PATCH net v2] net/smc: fix general protection fault in __smc_diag_dump
Date: Fri, 17 Oct 2025 10:48:27 +0800
Message-ID: <20251017024827.3137512-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500016.china.huawei.com (7.185.36.197)

The syzbot report a crash:

  Oops: general protection fault, probably for non-canonical address 0xfbd5a5d5a0000003: 0000 [#1] SMP KASAN NOPTI
  KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xdead4ead0000001f]
  CPU: 1 UID: 0 PID: 6949 Comm: syz.0.335 Not tainted syzkaller #0 PREEMPT(full)
  Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
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
in inet_init_csk_locks(). The INET_PROTOSW_ICSK flag is no need by smc,
just remove it.

After removing the INET_PROTOSW_ICSK flag, this patch alse revert
commit 6fd27ea183c2 ("net/smc: fix lacks of icsk_syn_mss with IPPROTO_SMC")
to avoid casting smc_sock to inet_connection_sock.

Reported-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e
Tested-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
v2: remove INET_PROTOSW_ICSK flag instead of init inet_connection_sock.
v1: https://lore.kernel.org/netdev/20250922121818.654011-1-wangliang74@huawei.com/
---
 net/smc/smc_inet.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
index a944e7dcb8b9..a94084b4a498 100644
--- a/net/smc/smc_inet.c
+++ b/net/smc/smc_inet.c
@@ -56,7 +56,6 @@ static struct inet_protosw smc_inet_protosw = {
 	.protocol	= IPPROTO_SMC,
 	.prot		= &smc_inet_prot,
 	.ops		= &smc_inet_stream_ops,
-	.flags		= INET_PROTOSW_ICSK,
 };
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -104,27 +103,15 @@ static struct inet_protosw smc_inet6_protosw = {
 	.protocol	= IPPROTO_SMC,
 	.prot		= &smc_inet6_prot,
 	.ops		= &smc_inet6_stream_ops,
-	.flags		= INET_PROTOSW_ICSK,
 };
 #endif /* CONFIG_IPV6 */
 
-static unsigned int smc_sync_mss(struct sock *sk, u32 pmtu)
-{
-	/* No need pass it through to clcsock, mss can always be set by
-	 * sock_create_kern or smc_setsockopt.
-	 */
-	return 0;
-}
-
 static int smc_inet_init_sock(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
 
 	/* init common smc sock */
 	smc_sk_init(net, sk, IPPROTO_SMC);
-
-	inet_csk(sk)->icsk_sync_mss = smc_sync_mss;
-
 	/* create clcsock */
 	return smc_create_clcsk(net, sk, sk->sk_family);
 }
-- 
2.34.1


