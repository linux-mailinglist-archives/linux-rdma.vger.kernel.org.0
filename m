Return-Path: <linux-rdma+bounces-4049-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3703893EBE9
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 05:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEEABB20FE8
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 03:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF06780027;
	Mon, 29 Jul 2024 03:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fiztWSzo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out199-17.us.a.mail.aliyun.com (out199-17.us.a.mail.aliyun.com [47.90.199.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4CE548E0;
	Mon, 29 Jul 2024 03:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722224441; cv=none; b=AwIGlhPyY7kZWJW+SlDSfnygRr9miTO+wgbxmWPHCVWjhwLUB1USC1VjGtNeiSLQhb0t0Q0twc8MpHmA0Mc8iDEHWiIJXsZ6B5J8MmBRaia/hGpsp0GEM3WAAw798c4c7g94g+tFrI/nYdVoOLHxlc7tL4axdwG0A+AGMc/uea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722224441; c=relaxed/simple;
	bh=Pl2mAYecSbs63N8+b662YR5QQytBTGJdoCGxa+LQagw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=f5UL9nUvpPPJXhrRmNFDgbGqp9kL0cINc6gXEv89g0HcT25+cSAn++2q3BEq+zKtpuvgZLmq4jAFG6W9rRBr9BjBdCF/DE//ImyhRHttKbWYKKMGmfy4oPnB5Iog+2/ZFGbqz/s3zvrCKLFI0qTHS0EkgMMnIadvPfMIWIf+vzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fiztWSzo; arc=none smtp.client-ip=47.90.199.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722224420; h=From:To:Subject:Date:Message-Id;
	bh=HyCbXU9PzFJ3yffIQLKWXqiSSnTu4lQL7SXvyxDPhyU=;
	b=fiztWSzo4ZHrIGJ/xwSHwk7xetqe5Pm9XKuFKbC2QMMnCe8EChfAe+3wxSBxBuacBZlod3bCAUL9vJixKo/v19gpakAPRrKgrrB58DWhLdu3gvG8Vw3h1heVr3h+fSWgFquweXb5o3ocWnjib5fU9of5yQEMNRGkwiiFqPgXEBQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0WBT3TmC_1722224415;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WBT3TmC_1722224415)
          by smtp.aliyun-inc.com;
          Mon, 29 Jul 2024 11:40:19 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	wintera@linux.ibm.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	tonylu@linux.alibaba.com,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH net] net/smc: prevent UAF in inet_create()
Date: Mon, 29 Jul 2024 11:40:15 +0800
Message-Id: <1722224415-30999-1-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

Following syzbot repro crashes the kernel:

socketpair(0x2, 0x1, 0x100, &(0x7f0000000140)) (fail_nth: 13)

Fix this by not calling sk_common_release() from smc_create_clcsk().

Stack trace:
socket: no more sockets
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
 WARNING: CPU: 1 PID: 5092 at lib/refcount.c:28
refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
Modules linked in:
CPU: 1 PID: 5092 Comm: syz-executor424 Not tainted
6.10.0-syzkaller-04483-g0be9ae5486cd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 06/27/2024
 RIP: 0010:refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
Code: 80 f3 1f 8c e8 e7 69 a8 fc 90 0f 0b 90 90 eb 99 e8 cb 4f e6 fc c6
05 8a 8d e8 0a 01 90 48 c7 c7 e0 f3 1f 8c e8 c7 69 a8 fc 90 <0f> 0b 90
90 e9 76 ff ff ff e8 a8 4f e6 fc c6 05 64 8d e8 0a 01 90
RSP: 0018:ffffc900034cfcf0 EFLAGS: 00010246
RAX: 3b9fcde1c862f700 RBX: ffff888022918b80 RCX: ffff88807b39bc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000003 R08: ffffffff815878a2 R09: fffffbfff1c39d94
R10: dffffc0000000000 R11: fffffbfff1c39d94 R12: 00000000ffffffe9
R13: 1ffff11004523165 R14: ffff888022918b28 R15: ffff888022918b00
FS:  00005555870e7380(0000) GS:ffff8880b9500000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000140 CR3: 000000007582e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inet_create+0xbaf/0xe70
  __sock_create+0x490/0x920 net/socket.c:1571
  sock_create net/socket.c:1622 [inline]
  __sys_socketpair+0x2ca/0x720 net/socket.c:1769
  __do_sys_socketpair net/socket.c:1822 [inline]
  __se_sys_socketpair net/socket.c:1819 [inline]
  __x64_sys_socketpair+0x9b/0xb0 net/socket.c:1819
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbcb9259669
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffe931c6d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000035
RAX: ffffffffffffffda RBX: 00007fffe931c6f0 RCX: 00007fbcb9259669
RDX: 0000000000000100 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 0000000000000002 R08: 00007fffe931c476 R09: 00000000000000a0
R10: 0000000020000140 R11: 0000000000000246 R12: 00007fffe931c6ec
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Link: https://lore.kernel.org/r/20240723175809.537291-1-edumazet@google.com/
Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 73a875573e7a..8e3093938cd2 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3319,10 +3319,8 @@ int smc_create_clcsk(struct net *net, struct sock *sk, int family)
 
 	rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
 			      &smc->clcsock);
-	if (rc) {
-		sk_common_release(sk);
+	if (rc)
 		return rc;
-	}
 
 	/* smc_clcsock_release() does not wait smc->clcsock->sk's
 	 * destruction;  its sk_state might not be TCP_CLOSE after
@@ -3368,6 +3366,9 @@ static int __smc_create(struct net *net, struct socket *sock, int protocol,
 		smc->clcsock = clcsock;
 	else
 		rc = smc_create_clcsk(net, sk, family);
+
+	if (rc)
+		sk_common_release(sk);
 out:
 	return rc;
 }
-- 
2.34.0


