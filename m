Return-Path: <linux-rdma+bounces-1062-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E6985B37F
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0BB21F227D2
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB25A109;
	Tue, 20 Feb 2024 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wJzZuHVc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BD85A4D3;
	Tue, 20 Feb 2024 07:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412528; cv=none; b=AO4kL5vd0wqOeUIMqou8CANcoEFpk8ONd0Hug/mhRvEwCYcinX6B2V83cCPUMZuaSX6cJYe59wJTviQ/pk1Xvlf9nfQHYX/rNqvJ+OmIb0lmLcQRY2VS2dUWFjnnUvLd2DPiWK+1NNfeVM0qbcZ5HOA8Xf/DcR3l9hA8RqMj2nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412528; c=relaxed/simple;
	bh=Uen6/3QA/kH5/krcRm82SDHTVPfbkLOOICuztBWUjv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BQkbu7LWHZj+mCeTLJU9+D6r0LDW0IhMO1TIfdiZhjB5lplaiyozZjBC9rB2EPM4NM+U4s0QEAN0L/aGM1KP9Z6p8uG9BJAt/xMRCLdW4V4VXYmIptNn+7J6sLr76hPhw6i/qoQgDuSupdwmom6M5D6QT7jxwGPB2dOAHdryyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wJzZuHVc; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708412518; h=From:To:Subject:Date:Message-Id;
	bh=pHoJolDSC2elBPjYqT6pbVM380kpEmMy7XkwC6XWJxQ=;
	b=wJzZuHVcvD1keusWFLwuLC+8GltiQP1/kcDljBHRgDWY6y6XvzsOE6JR9OXoxt9IgTlQSC+3u6w4+vrdsmQdWpSDEL4+GQU6ZFB650/OwKFSbI02Wlthxlzsr1ClJGVohZba/xlXs8Yd6atVYXCjAfcVj5h+tWvBNXFRMYmcMsQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W0vuXgI_1708412518;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0vuXgI_1708412518)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:01:58 +0800
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
Subject: [RFC net-next 13/20] net/smc: embedded tcp sock into smc sock
Date: Tue, 20 Feb 2024 15:01:38 +0800
Message-Id: <1708412505-34470-14-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
References: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

For inet version of SMC, one of the key goals is to make
a fallbacked smc sock can be recognazied as a tcp sock by
net tools.

So, it is necessary to embedded the tcp sock into smc sock
and make the tcp sock as the first member of smc sock.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/smc.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index fce6a7a..932d61f 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -248,7 +248,11 @@ struct smc_connection {
 };
 
 struct smc_sock {				/* smc sock container */
-	struct sock		sk;
+	union {
+		struct tcp6_sock tp6sk;
+		struct tcp_sock tpsk;
+		struct sock sk;
+	};
 	struct socket		*clcsock;	/* internal tcp socket */
 	void			(*clcsk_state_change)(struct sock *sk);
 						/* original stat_change fct. */
@@ -388,6 +392,11 @@ static inline void smc_sock_set_flag(struct sock *sk, enum sock_flags flag)
 	set_bit(flag, &sk->sk_flags);
 }
 
+static __always_inline bool smc_sock_is_inet_sock(const struct sock *sk)
+{
+	return inet_test_bit(IS_ICSK, sk);
+}
+
 #define smc_sock_flag(sk, flag)	sock_flag(sk, flag)
 
 #endif	/* __SMC_H */
-- 
1.8.3.1


