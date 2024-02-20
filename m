Return-Path: <linux-rdma+bounces-1064-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7693385B385
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F201C2184E
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1DD5C04C;
	Tue, 20 Feb 2024 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kdc3+ao2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out199-8.us.a.mail.aliyun.com (out199-8.us.a.mail.aliyun.com [47.90.199.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2F85B5AC;
	Tue, 20 Feb 2024 07:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412529; cv=none; b=Yl1zLABuzPGPCUlV5LUe/m/r1svyEFS2I4WUvfIel3SkX3yCzWzA6jo8q/07hqflc6vuHticIY9UMfc7lo6kEUGhmlgzCQ+ln4r5PgM1+4+M4F4PuJNSRShMClvhZuw5aZ1z5fOjAiWYHLPyifwP1JLLyT6us1hEdQJmd/oloZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412529; c=relaxed/simple;
	bh=Vq2GJFM2PilCsHlhHrVOnLtULh/FY3L0ZNEdj2Ed1Ow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=R/PTybB3nBmyJmgFs0EXWI/xp1mECwReGMGwfjywQm/eUihqG22vN3qfzTmSzpKF2x95L55SBQuBo936VtyAs7AawkdO/Ge7H9EAkzw1MHIMp34ihI3rPc/UZkLSwa9IU1185zflIPle80Q4cnXRlFHmMjDMayxx2OoS+r3ZbRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kdc3+ao2; arc=none smtp.client-ip=47.90.199.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708412514; h=From:To:Subject:Date:Message-Id;
	bh=ttf3fJ5jheHkxjVZhrFoGQBtw9rERuzk9kWvV/P+5tc=;
	b=kdc3+ao2/FweqjF8Hyd0V3AbkAL7SuH2Fme1wOtQKVE7t1kJzx2tZSjWUhjvm3lUxEo+CB+8HKMhDc1E3g3Aq7GtgSQz7Udb400/jrbShlHFeNat61n/yNOcKiVx0UO93bfxSFuOaIneUtHRcMw1lw5WPVfsuyY5AeiJfRnx5vs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W0vuXeI_1708412513;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0vuXeI_1708412513)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:01:53 +0800
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
Subject: [RFC net-next 06/20] net/smc: fast return on unconcernd TCP options
Date: Tue, 20 Feb 2024 15:01:31 +0800
Message-Id: <1708412505-34470-7-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
References: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

SMC does not require additional processing of every TCP options,
hence that when options that do not require additional processing,
we can immediately return.

Note that options which are explicitly not supported require a try
to fallback, and shall not simplt returned.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index b7c9f5c..40cf0569 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3054,6 +3054,28 @@ static inline bool smc_is_unsupport_tcp_sockopt(int optname)
 	return false;
 }
 
+/* Return true if smc might modify the semantics of
+ * the imcoming TCP options. Specifically, it includes
+ * unsupported TCP options.
+ */
+static inline bool smc_need_override_tcp_sockopt(struct sock *sk, int optname)
+{
+	switch (optname) {
+	case TCP_NODELAY:
+	case TCP_CORK:
+		if (smc_sk_state(sk) == SMC_INIT ||
+		    smc_sk_state(sk) == SMC_LISTEN ||
+		    smc_sk_state(sk) == SMC_CLOSED)
+			return false;
+		fallthrough;
+	case TCP_DEFER_ACCEPT:
+		return true;
+	default:
+		break;
+	}
+	return smc_is_unsupport_tcp_sockopt(optname);
+}
+
 static int smc_setsockopt_common(struct socket *sock, int level, int optname,
 				 sockptr_t optval, unsigned int optlen)
 {
@@ -3063,6 +3085,10 @@ static int smc_setsockopt_common(struct socket *sock, int level, int optname,
 
 	smc = smc_sk(sk);
 
+	/* Fast path, just go away if no extra action needed */
+	if (!smc_need_override_tcp_sockopt(sk, optname))
+		return 0;
+
 	if (optlen < sizeof(int))
 		return -EINVAL;
 	if (copy_from_sockptr(&val, optval, sizeof(int)))
-- 
1.8.3.1


