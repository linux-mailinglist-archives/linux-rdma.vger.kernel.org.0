Return-Path: <linux-rdma+bounces-1059-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9CE85B375
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87B61F2223C
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608EF5B68C;
	Tue, 20 Feb 2024 07:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Bwk2sb7i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71A65B5CD;
	Tue, 20 Feb 2024 07:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412527; cv=none; b=uo3tTeOjr1z80ayoJXMMIuR1+vYqf+YDeseA7mUlZKHhVj85ShGrnFQ8/QgZ+vTQRLsJRIJ6JRWb3TwuY7sPfUWNqrdcHP/CXQVbT0kMX+evho7I8UBLz08ngwj9d+E1xRoJyU/QMl82Y3ITyg9X8JwTpTrqB5kA/gJGt/IP/PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412527; c=relaxed/simple;
	bh=1oITY5bmGcT4RsZmcB213lVYZ7JyMbqVj5Ni7/GeoqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OTcKQ9XRTCdo2fWv1GzBijUMEBXbMLvLbcmITnMi8vhletOL2OCI8Q8XsF5L83DGHJFHvK19QvjfFLiLSNCAe/civy5cOuzqkaqgPvqcByVnchwF+Lqg/paFflQyEaHSdfYV6vdPmdMCIvXpEwM8To+aV8E1nc7lgsVsWP6lUUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Bwk2sb7i; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708412517; h=From:To:Subject:Date:Message-Id;
	bh=L4lhr6Rrf/wRN1/5nDyGfaaPTD10iK9aCrz3lMKLFJ0=;
	b=Bwk2sb7iYokAqz5YS5neMN/Bf16OTHcYQcqm018TRzVQYXDPD9DKEMQmWKl34YGlJUU6ihVzg3GgUvEh60IrSaARXtsBLdYCSxn+ctM/qMH2LU7KydhhNC3W3Xc+YfZ9QWGNa4M1+GUMQY+QZp+hCAZmCdZvg+tyF3wh6EsUIn0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W0vuXfK_1708412515;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0vuXfK_1708412515)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:01:56 +0800
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
Subject: [RFC net-next 10/20] net/smc: make initialization code in smc_listen independent
Date: Tue, 20 Feb 2024 15:01:35 +0800
Message-Id: <1708412505-34470-11-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
References: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

This patch make the initialization code in smc_listen independent
as smc_init_listen, we will use it in the inet version of SMC.
This patch clearly has no side effects, logically speaking, it only
refactored this smc_listen() function.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c | 49 +++++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 20abdda..484e981 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2610,6 +2610,34 @@ static void smc_clcsock_data_ready(struct sock *listen_clcsock)
 	read_unlock_bh(&listen_clcsock->sk_callback_lock);
 }
 
+static inline void smc_init_listen(struct smc_sock *smc)
+{
+	struct sock *clcsk;
+
+	clcsk = smc_sock_is_inet_sock(&smc->sk) ? &smc->sk : smc->clcsock->sk;
+
+	/* save original sk_data_ready function and establish
+	 * smc-specific sk_data_ready function
+	 */
+	write_lock_bh(&clcsk->sk_callback_lock);
+	clcsk->sk_user_data =
+		(void *)((uintptr_t)smc | SK_USER_DATA_NOCOPY);
+	smc_clcsock_replace_cb(&clcsk->sk_data_ready,
+			       smc_clcsock_data_ready, &smc->clcsk_data_ready);
+	write_unlock_bh(&clcsk->sk_callback_lock);
+
+	/* save original ops */
+	smc->ori_af_ops = inet_csk(clcsk)->icsk_af_ops;
+
+	smc->af_ops = *smc->ori_af_ops;
+	smc->af_ops.syn_recv_sock = smc_tcp_syn_recv_sock;
+
+	inet_csk(clcsk)->icsk_af_ops = &smc->af_ops;
+
+	if (smc->limit_smc_hs)
+		tcp_sk(clcsk)->smc_hs_congested = smc_hs_congested;
+}
+
 static int smc_listen(struct socket *sock, int backlog)
 {
 	struct sock *sk = sock->sk;
@@ -2636,26 +2664,7 @@ static int smc_listen(struct socket *sock, int backlog)
 	if (!smc->use_fallback)
 		tcp_sk(smc->clcsock->sk)->syn_smc = 1;
 
-	/* save original sk_data_ready function and establish
-	 * smc-specific sk_data_ready function
-	 */
-	write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
-	smc->clcsock->sk->sk_user_data =
-		(void *)((uintptr_t)smc | SK_USER_DATA_NOCOPY);
-	smc_clcsock_replace_cb(&smc->clcsock->sk->sk_data_ready,
-			       smc_clcsock_data_ready, &smc->clcsk_data_ready);
-	write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
-
-	/* save original ops */
-	smc->ori_af_ops = inet_csk(smc->clcsock->sk)->icsk_af_ops;
-
-	smc->af_ops = *smc->ori_af_ops;
-	smc->af_ops.syn_recv_sock = smc_tcp_syn_recv_sock;
-
-	inet_csk(smc->clcsock->sk)->icsk_af_ops = &smc->af_ops;
-
-	if (smc->limit_smc_hs)
-		tcp_sk(smc->clcsock->sk)->smc_hs_congested = smc_hs_congested;
+	smc_init_listen(smc);
 
 	rc = kernel_listen(smc->clcsock, backlog);
 	if (rc) {
-- 
1.8.3.1


