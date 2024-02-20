Return-Path: <linux-rdma+bounces-1069-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C9885B39F
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51FA5283496
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724ED5A0FA;
	Tue, 20 Feb 2024 07:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NTFQljrO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391B55A0EC;
	Tue, 20 Feb 2024 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412837; cv=none; b=FTM1gAZjvrR9DBwgjsNQ4nqQRfT6ixL3bJq8PbspPGySrhGHE5T7WJIT/6yHkZ/QrafZMkGJ0aatMsZ9+8xHqPKdWT/KAODoL18UhhRtHZFPh94ezlNdFWPudsfsc6RAjBm/tfIwFhPNgg1Wqw2Ci9zTou7nIkj5ZqfkXMZg1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412837; c=relaxed/simple;
	bh=V6nov/X9dAxDaB3AgtB20JCVQxqnfxoWclH6L5e9a6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KVPr2liwWG+lqq5C5KTFbBIEG7ZS3EvMdLkyqgWnHs3/5yJ+JnHjpESsqS95FUC7Sf6TSDATi9qL95PpIFMRlo3ttPdWI8vz1zRMZZkarTPfJUVJRL7fAXztrEt2kKiqoZkW/XAWa6eAkU5CKDk1ZG4fRylRm2XssdmLJdQTLwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NTFQljrO; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708412832; h=From:To:Subject:Date:Message-Id;
	bh=rqaJIEKhS63d3A/o0DP77Ow0D6PbqQ03S+zaLE+WH2M=;
	b=NTFQljrO2iSmL5lOei6W8f2R2smwKa3GazBBVtIoOIxsvColnYmzf2Ep94fj4OWEaruaSCSdKT6uwNZIt7CuKFkaHuyi5+WHROzY1o6eu4yORc32v4bjW5q4wU7DInl1nVFPM74iq6QvRPtJP0xJ02wz7yyWDAz5PZRIJwgwaaI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W0vuXdd_1708412511;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0vuXdd_1708412511)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:01:51 +0800
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
Subject: [RFC net-next 03/20] net/smc: refactor smc_setsockopt
Date: Tue, 20 Feb 2024 15:01:28 +0800
Message-Id: <1708412505-34470-4-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
References: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

Refactoring the processing of socket options in SMC, extracting common
processing functions and unsupported options.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c | 101 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 63 insertions(+), 38 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index bdb6dd7..e87af68 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3038,58 +3038,40 @@ static int __smc_setsockopt(struct socket *sock, int level, int optname,
 	return rc;
 }
 
-static int smc_setsockopt(struct socket *sock, int level, int optname,
-			  sockptr_t optval, unsigned int optlen)
+/* When an unsupported sockopt is found,
+ * SMC should try it best to fallback. If fallback is not possible,
+ * an error should be explicitly returned.
+ */
+static inline bool smc_is_unsupport_tcp_sockopt(int optname)
+{
+	switch (optname) {
+	case TCP_FASTOPEN:
+	case TCP_FASTOPEN_CONNECT:
+	case TCP_FASTOPEN_KEY:
+	case TCP_FASTOPEN_NO_COOKIE:
+		return true;
+	}
+	return false;
+}
+
+static int smc_setsockopt_common(struct socket *sock, int level, int optname,
+				 sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct smc_sock *smc;
-	int val, rc;
-
-	if (level == SOL_TCP && optname == TCP_ULP)
-		return -EOPNOTSUPP;
-	else if (level == SOL_SMC)
-		return __smc_setsockopt(sock, level, optname, optval, optlen);
+	int val, rc = 0;
 
 	smc = smc_sk(sk);
 
-	/* generic setsockopts reaching us here always apply to the
-	 * CLC socket
-	 */
-	mutex_lock(&smc->clcsock_release_lock);
-	if (!smc->clcsock) {
-		mutex_unlock(&smc->clcsock_release_lock);
-		return -EBADF;
-	}
-	if (unlikely(!smc->clcsock->ops->setsockopt))
-		rc = -EOPNOTSUPP;
-	else
-		rc = smc->clcsock->ops->setsockopt(smc->clcsock, level, optname,
-						   optval, optlen);
-	if (smc->clcsock->sk->sk_err) {
-		sk->sk_err = smc->clcsock->sk->sk_err;
-		sk_error_report(sk);
-	}
-	mutex_unlock(&smc->clcsock_release_lock);
-
 	if (optlen < sizeof(int))
 		return -EINVAL;
 	if (copy_from_sockptr(&val, optval, sizeof(int)))
 		return -EFAULT;
 
 	lock_sock(sk);
-	if (rc || smc->use_fallback)
+	if (smc->use_fallback)
 		goto out;
 	switch (optname) {
-	case TCP_FASTOPEN:
-	case TCP_FASTOPEN_CONNECT:
-	case TCP_FASTOPEN_KEY:
-	case TCP_FASTOPEN_NO_COOKIE:
-		/* option not supported by SMC */
-		if (smc_sk_state(sk) == SMC_INIT && !smc->connect_nonblock)
-			rc = smc_switch_to_fallback(smc, SMC_CLC_DECL_OPTUNSUPP);
-		else
-			rc = -EINVAL;
-		break;
 	case TCP_NODELAY:
 		if (smc_sk_state(sk) != SMC_INIT &&
 		    smc_sk_state(sk) != SMC_LISTEN &&
@@ -3116,6 +3098,13 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 		smc->sockopt_defer_accept = val;
 		break;
 	default:
+		if (smc_is_unsupport_tcp_sockopt(optname)) {
+			/* option not supported by SMC */
+			if (smc_sk_state(sk) == SMC_INIT && !smc->connect_nonblock)
+				rc = smc_switch_to_fallback(smc, SMC_CLC_DECL_OPTUNSUPP);
+			else
+				rc = -EINVAL;
+		}
 		break;
 	}
 out:
@@ -3124,6 +3113,42 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 	return rc;
 }
 
+static int smc_setsockopt(struct socket *sock, int level, int optname,
+			  sockptr_t optval, unsigned int optlen)
+{
+	struct sock *sk = sock->sk;
+	struct smc_sock *smc;
+	int rc;
+
+	if (level == SOL_TCP && optname == TCP_ULP)
+		return -EOPNOTSUPP;
+	else if (level == SOL_SMC)
+		return __smc_setsockopt(sock, level, optname, optval, optlen);
+
+	smc = smc_sk(sk);
+
+	/* generic setsockopts reaching us here always apply to the
+	 * CLC socket
+	 */
+	mutex_lock(&smc->clcsock_release_lock);
+	if (!smc->clcsock) {
+		mutex_unlock(&smc->clcsock_release_lock);
+		return -EBADF;
+	}
+	if (unlikely(!smc->clcsock->ops->setsockopt))
+		rc = -EOPNOTSUPP;
+	else
+		rc = smc->clcsock->ops->setsockopt(smc->clcsock, level, optname,
+						   optval, optlen);
+	if (smc->clcsock->sk->sk_err) {
+		sk->sk_err = smc->clcsock->sk->sk_err;
+		sk_error_report(sk);
+	}
+	mutex_unlock(&smc->clcsock_release_lock);
+
+	return rc ?: smc_setsockopt_common(sock, level, optname, optval, optlen);
+}
+
 static int smc_getsockopt(struct socket *sock, int level, int optname,
 			  char __user *optval, int __user *optlen)
 {
-- 
1.8.3.1


