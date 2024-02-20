Return-Path: <linux-rdma+bounces-1068-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F2D85B391
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 312FC1F2253C
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B585A4CA;
	Tue, 20 Feb 2024 07:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XWPm01l4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com [47.90.199.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26EC5A11A;
	Tue, 20 Feb 2024 07:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412539; cv=none; b=RZ63M9WDfVFtxUBlsHQq81Bf61krAsr5QkR7h0TEX9YBHjlQ031wm+nO6tINOk9bUQs39Q670KPQXtSMNB6DeMuIMbM6yuOzzlSeWk4Rr9/bRh61/0wgAJwkvLJhafaV3lo0Z8EsK4KPtO92ik3Fww3Y6OFO7BaABZ0YRtoI7sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412539; c=relaxed/simple;
	bh=KHH6nqnlO3XtD52ILwZrK3g1QIawp8D8BY/Ro4dbtak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=p8aSBpvfxqIWt5/QXYEk9RmXO3SyLnNed0ScLy5JmUj/fdiDLDg+UHFq3/B4AXSsIEVx/Ng6gr+3Tl5Bl6jwhJITD6M6A5T1Fj/mnAso1HwvG//SC9m2DG1yvlkBhBF3pULyzsVEZIrQjgTcgZnbxttd5T16ufItwRd7fIVwMTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XWPm01l4; arc=none smtp.client-ip=47.90.199.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708412519; h=From:To:Subject:Date:Message-Id;
	bh=H78lH3tbMyek+0jhdG1eR22ohdujG/bHb3E38Wi9Cac=;
	b=XWPm01l4aLFFCwB+Vg4bOlijxRSMtRYHH1WstCdaH/A6bNSJBf5jVjAx9QBlQwl5Z8grg7ABjYAY+d7wLopgoKPw28JY91xkdR/FCQea6fj3VTGqS0fpxVIyb69cCAUeMeQOnlWlm2RH6v7fxvMQqGgjU6eDPgW8aPTH93R17+M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W0vuXgV_1708412518;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0vuXgV_1708412518)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:01:59 +0800
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
Subject: [RFC net-next 14/20] net/smc: allow to access the state of inet smc sock
Date: Tue, 20 Feb 2024 15:01:39 +0800
Message-Id: <1708412505-34470-15-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
References: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

As we know, in inet version of smc, smc_sock and tcp_sock coexist,
this will result in the sk_state field has been accessed and modified by
both protocols, which can cause obvious exceptions. Therefore, this
patch modify the state macro for reading and setting the smc state,
using the icsk field to determine which is the very field needed to
be accessed or changed.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/smc.h | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 932d61f..e54a30c 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -38,9 +38,6 @@
 #define KERNEL_HAS_ATOMIC64
 #endif
 
-#define smc_sk_state(sk)		((sk)->sk_state)
-#define smc_sk_set_state(sk, state)	(smc_sk_state(sk) = (state))
-
 enum smc_state {		/* possible states of an SMC socket */
 	SMC_ACTIVE	= 1,
 	SMC_INIT	= 2,
@@ -254,6 +251,7 @@ struct smc_sock {				/* smc sock container */
 		struct sock sk;
 	};
 	struct socket		*clcsock;	/* internal tcp socket */
+	unsigned char		smc_state;	/* smc state used in smc via inet_sk */
 	void			(*clcsk_state_change)(struct sock *sk);
 						/* original stat_change fct. */
 	void			(*clcsk_data_ready)(struct sock *sk);
@@ -397,6 +395,20 @@ static __always_inline bool smc_sock_is_inet_sock(const struct sock *sk)
 	return inet_test_bit(IS_ICSK, sk);
 }
 
+#define smc_sk_state(sk)	({				\
+	struct sock *__sk = (sk);				\
+	smc_sock_is_inet_sock(__sk) ?				\
+		smc_sk(__sk)->smc_state : (__sk)->sk_state;	\
+})
+
+static __always_inline void smc_sk_set_state(struct sock *sk, unsigned char state)
+{
+	if (smc_sock_is_inet_sock(sk))
+		smc_sk(sk)->smc_state = state;
+	else
+		sk->sk_state = state;
+}
+
 #define smc_sock_flag(sk, flag)	sock_flag(sk, flag)
 
 #endif	/* __SMC_H */
-- 
1.8.3.1


