Return-Path: <linux-rdma+bounces-5332-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8DF996030
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 08:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01DBDB22C9A
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 06:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910B0176FA4;
	Wed,  9 Oct 2024 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NES5GyDT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B542040849;
	Wed,  9 Oct 2024 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728456927; cv=none; b=d3DgnzRYdj8DSAq93xui7F/9HgBfrvttYqntTHygOPNnCeku5utwa/mO2CSb2ZT3ILgSIdwn+IaeBzIQwZ8fF74JWy9jOWyCko7fQG1zMSqWKIcJ95E8AtWeL4BCNSKGULKZJHMQmkvKJa5hVtFnvQA0p8auBRf9PUf21AJR4Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728456927; c=relaxed/simple;
	bh=Bd7iXoEa9UzFsOA5nZ4yG/NgHNPsFlJ16NHvU3fklNs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=iRFZhr12wUppK5vLxIKchkvRI76MQfD8qqPzwYTjte0Gieuu1zbi23ODakqHyB6xja4pZGuwQXcbL4p5bQZ6mTVw9b5KFIbZOhJ3vP/LAQldGDNIF9EhNjVecmf+HWv2LAEtfPFvay3He24V8RDhXh4CkeuSQaWpX0U39tzj0ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NES5GyDT; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728456921; h=From:To:Subject:Date:Message-Id;
	bh=WQW8mgJmkTslYa2D7to3QWwlV3Xf9E2iC1P1rqJMGEM=;
	b=NES5GyDTxNjsfKNKAFfA+QKeQa/mosys9CX6o9nf32QACOQMWnxpz5xd3HqiMcQaYZRkP4maZvR7G0JP2+oZl26B6ZLW0lIpzO95ld8AG7j7fVj5NkNc3mV3k7H+sErC2Mt1nzbEjxzYIKRXLmEWTO2ayK8L/IFGBGfsYVrUHoY=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WGhiQZL_1728456917)
          by smtp.aliyun-inc.com;
          Wed, 09 Oct 2024 14:55:20 +0800
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
Subject: [PATCH net] net/smc: fix lacks of icsk_syn_mss with IPPROTO_SMC
Date: Wed,  9 Oct 2024 14:55:16 +0800
Message-Id: <1728456916-67035-1-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

Eric report a panic on IPPROTO_SMC, and give the facts
that when INET_PROTOSW_ICSK was set, icsk->icsk_sync_mss must be set too.

Bug: Unable to handle kernel NULL pointer dereference at virtual address
0000000000000000
Mem abort info:
ESR = 0x0000000086000005
EC = 0x21: IABT (current EL), IL = 32 bits
SET = 0, FnV = 0
EA = 0, S1PTW = 0
FSC = 0x05: level 1 translation fault
user pgtable: 4k pages, 48-bit VAs, pgdp=00000001195d1000
[0000000000000000] pgd=0800000109c46003, p4d=0800000109c46003,
pud=0000000000000000
Internal error: Oops: 0000000086000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 UID: 0 PID: 8037 Comm: syz.3.265 Not tainted
6.11.0-rc7-syzkaller-g5f5673607153 #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 08/06/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : 0x0
lr : cipso_v4_sock_setattr+0x2a8/0x3c0 net/ipv4/cipso_ipv4.c:1910
sp : ffff80009b887a90
x29: ffff80009b887aa0 x28: ffff80008db94050 x27: 0000000000000000
x26: 1fffe0001aa6f5b3 x25: dfff800000000000 x24: ffff0000db75da00
x23: 0000000000000000 x22: ffff0000d8b78518 x21: 0000000000000000
x20: ffff0000d537ad80 x19: ffff0000d8b78000 x18: 1fffe000366d79ee
x17: ffff8000800614a8 x16: ffff800080569b84 x15: 0000000000000001
x14: 000000008b336894 x13: 00000000cd96feaa x12: 0000000000000003
x11: 0000000000040000 x10: 00000000000020a3 x9 : 1fffe0001b16f0f1
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 0000000000000000 x0 : ffff0000d8b78000
Call trace:
0x0
netlbl_sock_setattr+0x2e4/0x338 net/netlabel/netlabel_kapi.c:1000
smack_netlbl_add+0xa4/0x154 security/smack/smack_lsm.c:2593
smack_socket_post_create+0xa8/0x14c security/smack/smack_lsm.c:2973
security_socket_post_create+0x94/0xd4 security/security.c:4425
__sock_create+0x4c8/0x884 net/socket.c:1587
sock_create net/socket.c:1622 [inline]
__sys_socket_create net/socket.c:1659 [inline]
__sys_socket+0x134/0x340 net/socket.c:1706
__do_sys_socket net/socket.c:1720 [inline]
__se_sys_socket net/socket.c:1718 [inline]
__arm64_sys_socket+0x7c/0x94 net/socket.c:1718
__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: ???????? ???????? ???????? ???????? (????????)
---[ end trace 0000000000000000 ]---

This patch add a toy implementation that performs a simple return to
prevent such panic. This is because MSS can be set in sock_create_kern
or smc_setsockopt, similar to how it's done in AF_SMC. However, for
AF_SMC, there is currently no way to synchronize MSS within
__sys_connect_file. This toy implementation lays the groundwork for us
to support such feature for IPPROTO_SMC in the future.

Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/smc_inet.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
index a5b20416..a944e7d 100644
--- a/net/smc/smc_inet.c
+++ b/net/smc/smc_inet.c
@@ -108,12 +108,23 @@ struct smc6_sock {
 };
 #endif /* CONFIG_IPV6 */
 
+static unsigned int smc_sync_mss(struct sock *sk, u32 pmtu)
+{
+	/* No need pass it through to clcsock, mss can always be set by
+	 * sock_create_kern or smc_setsockopt.
+	 */
+	return 0;
+}
+
 static int smc_inet_init_sock(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
 
 	/* init common smc sock */
 	smc_sk_init(net, sk, IPPROTO_SMC);
+
+	inet_csk(sk)->icsk_sync_mss = smc_sync_mss;
+
 	/* create clcsock */
 	return smc_create_clcsk(net, sk, sk->sk_family);
 }
-- 
1.8.3.1


