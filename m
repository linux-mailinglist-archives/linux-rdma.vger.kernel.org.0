Return-Path: <linux-rdma+bounces-1070-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D5085B3A2
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA2E1F231F4
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDF55A4C6;
	Tue, 20 Feb 2024 07:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c7qZXbm6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7ED5A0EC;
	Tue, 20 Feb 2024 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412845; cv=none; b=lDPQNalKcfux3Nnsehk4iCCq0dF6ZpQG+SKTVo2TAF0jS0HqzTcNw49AEJQPN1Fr/ey8FGbqAvYnq8y+Du5VZizaALTJ1xCx4cNGAzA/ButuOAr1PnocNNRQ66qm7jlyyz1bmQWMVQC0oADrdk5f3ReL1N4Nl3qB8SdkE9LnMp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412845; c=relaxed/simple;
	bh=l28AfzidSu1pRTD2a6149c5GFZhgjtGOmiAePxjJGtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=b3ygX31ctN8a/eE1HmKNNLvxdIWbIxoPZJoxJSwbxShPKIRcaz+JMkTr5vNdTJqx3uUlC3nvaBV3vBPLwxJeqC2AHj+nS/33I/wI9A12tekULLHzUobOUkmsfSMlLzqyBtXfyXLnGZYrwOk9GzJyCYLNvvj1ScL9GWN9424Atlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c7qZXbm6; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708412839; h=From:To:Subject:Date:Message-Id;
	bh=0gYY+oZKSPlQwfXwQJFl5/DHmqexYu6zfCNueOj8rac=;
	b=c7qZXbm6RngmxkP3CVZN8lmBK5B+s/Pt0qWCPWuQDoMW706zZS4EYCq/Kgjbhq4WfG5ggeYcq0VZYs15DNomPFNwKTRdXcoRCw4qWOkudZ1aoxnrVRmeEgnPR7HXD+ul3rayFUQIDgK57+9uaw8HnDU6bz0z2UoCUByoWn1xWEM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W0vuXgk_1708412519;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0vuXgk_1708412519)
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
Subject: [RFC net-next 15/20] net/smc: enable access of sock flags of inet smc sock
Date: Tue, 20 Feb 2024 15:01:40 +0800
Message-Id: <1708412505-34470-16-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
References: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

Since smc_sock and tcp_sock coexist in inet version of smc, the
sock flags field are shared between tcp and smc. Like the sk_state,
we also need a extra sock flags filed for smc in inet version, and
using the icsk field to determine which is the very field needed to
be accessed or changed.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/smc.h | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index e54a30c..1675193 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -252,6 +252,7 @@ struct smc_sock {				/* smc sock container */
 	};
 	struct socket		*clcsock;	/* internal tcp socket */
 	unsigned char		smc_state;	/* smc state used in smc via inet_sk */
+	unsigned long		smc_sk_flags;	/* smc sock flags used for inet sock */
 	void			(*clcsk_state_change)(struct sock *sk);
 						/* original stat_change fct. */
 	void			(*clcsk_data_ready)(struct sock *sk);
@@ -385,10 +386,6 @@ void smc_fill_gid_list(struct smc_link_group *lgr,
 int smc_nl_enable_hs_limitation(struct sk_buff *skb, struct genl_info *info);
 int smc_nl_disable_hs_limitation(struct sk_buff *skb, struct genl_info *info);
 
-static inline void smc_sock_set_flag(struct sock *sk, enum sock_flags flag)
-{
-	set_bit(flag, &sk->sk_flags);
-}
 
 static __always_inline bool smc_sock_is_inet_sock(const struct sock *sk)
 {
@@ -409,6 +406,33 @@ static __always_inline void smc_sk_set_state(struct sock *sk, unsigned char stat
 		sk->sk_state = state;
 }
 
-#define smc_sock_flag(sk, flag)	sock_flag(sk, flag)
+static __always_inline bool smc_sock_flag(const struct sock *sk, enum sock_flags flag)
+{
+	if (smc_sock_is_inet_sock(sk)) {
+		switch (flag) {
+		case SOCK_DEAD:
+		case SOCK_DONE:
+			return test_bit(flag, &smc_sk(sk)->smc_sk_flags);
+		default:
+			break;
+		}
+	}
+	return sock_flag(sk, flag);
+}
+
+static __always_inline void smc_sock_set_flag(struct sock *sk, enum sock_flags flag)
+{
+	if (smc_sock_is_inet_sock(sk)) {
+		switch (flag) {
+		case SOCK_DEAD:
+		case SOCK_DONE:
+			__set_bit(flag, &smc_sk(sk)->smc_sk_flags);
+			return;
+		default:
+			break;
+		}
+	}
+	set_bit(flag, &sk->sk_flags);
+}
 
 #endif	/* __SMC_H */
-- 
1.8.3.1


