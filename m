Return-Path: <linux-rdma+bounces-21836-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IySMMLe9ImoFdAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21836-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 14:14:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D85D647FFA
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 14:14:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=rZnVx2jC;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21836-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21836-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8303B3049E3B
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 12:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C12D4DB55A;
	Fri,  5 Jun 2026 12:13:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F09D4D9918;
	Fri,  5 Jun 2026 12:13:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661625; cv=none; b=rvdZwHzz5as5T6EdvF10C8rb1BygKiZNEgF71W80xrrCtdckTF0n46lSCU4OdJngQojUDG466bRXRknfL+Sar7eIVCqikR/3E2q5lxMxuNn9VrTeR+bnbym/b0kOGx2MHSmVeuo/sG2/adH/0YlXvsNauJqUuVVTBzwHEUzb5ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661625; c=relaxed/simple;
	bh=cb5Fl7qI+QrhlAQCSG7RGxk69W8WeNmqAvtfLFDwWng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jR2Yi+u83bPCyg6mGL57258y23E7jW90X8NkvrqPaDmFugIPYs6EgszpgBFJSZPu3fT7Irl7vC1vBNd97uwwW2yWCqek4qOWui9A89NMhGpUBJHH4S5V50dX6/bKbVhuZTkfVjyE+H46A50gUX1dRlo+OIn/1l8vh6bQJAGO6sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=rZnVx2jC; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=bV6PMNPiGvqiL3b8JXSN02wKJytn/9yKMzeTnAqzokY=; b=rZnVx2jCpig91mq5gbaUGzWkZk
	xKl1RK2SXpQU1T+t48KunylPAopZdDL4e2+knZlrEQpQ9jYAF1+fXckJkqPyIZGMYLo+NOPMpQmZY
	s0smzm+ZFY2hT7qxfKhGQp4TNWscQnCG8zsexwsWQMY7Nu8HgqPX/Jn+1PyI0bn2xa9Tthe27ZAh0
	GWZd7LbYD//NtpInp6HkrnOZtYdaDMgF+yl7lBTZ5mCJdFWdmUfYTK6L6/Myjn1J/7wNDBBPJUGtq
	EJV/KHxIvFdDD9mKOXrfo6Og9xTPtVmcrpwoyB0yE3rMtIhgT6q/IgeEHFzSv1nQHj6avo4ej670p
	YLM4C6Dg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wVTQh-005HW8-1X;
	Fri, 05 Jun 2026 12:13:39 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 05 Jun 2026 05:13:25 -0700
Subject: [PATCH net-next 1/2] smc: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-getsockopt_smc-v1-1-65da62fa44c4@debian.org>
References: <20260605-getsockopt_smc-v1-0-65da62fa44c4@debian.org>
In-Reply-To: <20260605-getsockopt_smc-v1-0-65da62fa44c4@debian.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>, 
 Dust Li <dust.li@linux.alibaba.com>, 
 Sidraya Jayagond <sidraya@linux.ibm.com>, 
 Wenjia Zhang <wenjia@linux.ibm.com>, 
 Mahanta Jambigi <mjambigi@linux.ibm.com>, 
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5630; i=leitao@debian.org;
 h=from:subject:message-id; bh=cb5Fl7qI+QrhlAQCSG7RGxk69W8WeNmqAvtfLFDwWng=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqIr1pm98zJvDjVKMkIUdQ3+teQcLhsKIXeJYWP
 8NGNOrTh9uJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaiK9aQAKCRA1o5Of/Hh3
 bZtSD/92C4xNep/Ux3iA2mmf3eEIneAzD3EZ4EzGEU4SzV8OfRzjdotDLLRVbe5HMn0msclaCzH
 GxqM22kJ2jFwYd1LCCdHqp6MFleph4meCYu5RlFTKG1i8l5eW7nVLANvZD1d0L13hCF2IyboLbA
 H4yvBvqnXwMd/2LByqQZMyKDtCfqrKhU6pbPO4/vAcf09ExxFrJCT4TRh0l88pKnxr78S3uvD3c
 Av3VusTco8ldf6/ubRfbfBk+wIJojinUJRPDKcwtCWe752q0r9hACreitDBt15aZFODhhSCyeg6
 MxRa0/HC71a57z0FL5aLDy4sWQp3yGErmBFzvYktHAlsZ3hY3iFD75M8HWTpBiM5fhiB3VwLRQW
 J/QMXhCR6D728PuFogolbQncjv4Lg/ADx6tqFh9pyt5F5kDY7+KB4vBVwIcvyxsI5fIQGZsn0/h
 Q+QhFBxRFBl4QrDd/CvfI39t8TPv45cVgA5UmfxN/WgEaCM8AEZ6crExt5Bn12LbnRts6Yt3yzP
 VI6W5H0eWjXGXkF+K03dv+5W67y7SGzqAbegCfBa2JL2DfPGuHyoCPDYCSm+FYNN6WIO+4NLXi8
 FBSeKYO1ItWaQOQ4UdSVOkUaCHgicj8Ue1lXZpfAvKdAeCdxSL8SsmHC76fw2dkKP7JjfCWbRGx
 eOohPoNGpa69jiQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21836-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D85D647FFA

Convert SMC socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of put_user()/copy_to_user()
- Add linux/uio.h for copy_to_iter()

SMC is a proxy socket: only the SOL_SMC level is handled locally, while
all other levels are forwarded to the underlying CLC (TCP) socket. That
socket's getsockopt() still operates on __user buffers, so the
pass-through is limited to user-backed iters: optval is reconstructed
from iter_out, the original optlen pointer (preserved in sockopt_t) is
forwarded, and the length reported by the clcsock is mirrored back into
opt->optlen so the core writes the correct value to userspace.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/smc/af_smc.c   | 41 +++++++++++++++++++++++++++++------------
 net/smc/smc.h      |  2 +-
 net/smc/smc_inet.c |  4 ++--
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index b5db69073e20..064d752388d2 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -27,6 +27,7 @@
 #include <linux/rcupdate_wait.h>
 #include <linux/ctype.h>
 #include <linux/splice.h>
+#include <linux/uio.h>
 
 #include <net/sock.h>
 #include <net/inet_common.h>
@@ -3017,17 +3018,14 @@ int smc_shutdown(struct socket *sock, int how)
 }
 
 static int __smc_getsockopt(struct socket *sock, int level, int optname,
-			    char __user *optval, int __user *optlen)
+			    sockopt_t *opt)
 {
 	struct smc_sock *smc;
 	int val, len;
 
 	smc = smc_sk(sock->sk);
 
-	if (get_user(len, optlen))
-		return -EFAULT;
-
-	len = min_t(int, len, sizeof(int));
+	len = min_t(int, opt->optlen, sizeof(int));
 
 	if (len < 0)
 		return -EINVAL;
@@ -3040,9 +3038,8 @@ static int __smc_getsockopt(struct socket *sock, int level, int optname,
 		return -EOPNOTSUPP;
 	}
 
-	if (put_user(len, optlen))
-		return -EFAULT;
-	if (copy_to_user(optval, &val, len))
+	opt->optlen = len;
+	if (copy_to_iter(&val, len, &opt->iter_out) != len)
 		return -EFAULT;
 
 	return 0;
@@ -3168,13 +3165,26 @@ int smc_setsockopt(struct socket *sock, int level, int optname,
 }
 
 int smc_getsockopt(struct socket *sock, int level, int optname,
-		   char __user *optval, int __user *optlen)
+		   sockopt_t *opt)
 {
 	struct smc_sock *smc;
 	int rc;
 
 	if (level == SOL_SMC)
-		return __smc_getsockopt(sock, level, optname, optval, optlen);
+		return __smc_getsockopt(sock, level, optname, opt);
+
+	/* Other levels apply to the CLC socket, whose getsockopt() still
+	 * operates on __user buffers. Reconstruct the userspace pointers and
+	 * forward the call; kernel-backed callers (e.g. io_uring) are not
+	 * supported for this pass-through.
+	 *
+	 * TODO: this pass-through is limited to user-backed iters because the
+	 * underlying protocols (TCP/IP) have not been converted to
+	 * getsockopt_iter() yet. Once they are, forward the sockopt_t directly
+	 * and drop this restriction so all iov_iter types are supported.
+	 */
+	if (!iter_is_ubuf(&opt->iter_out) || !opt->optlen_user)
+		return -EOPNOTSUPP;
 
 	smc = smc_sk(sock->sk);
 	mutex_lock(&smc->clcsock_release_lock);
@@ -3188,8 +3198,15 @@ int smc_getsockopt(struct socket *sock, int level, int optname,
 		return -EOPNOTSUPP;
 	}
 	rc = smc->clcsock->ops->getsockopt(smc->clcsock, level, optname,
-					   optval, optlen);
+					   opt->iter_out.ubuf, opt->optlen_user);
 	mutex_unlock(&smc->clcsock_release_lock);
+
+	/* The clcsock wrote the resulting length to the user optlen pointer;
+	 * mirror it into opt->optlen so the core writes the same value back.
+	 */
+	if (get_user(opt->optlen, opt->optlen_user))
+		return -EFAULT;
+
 	return rc;
 }
 
@@ -3341,7 +3358,7 @@ static const struct proto_ops smc_sock_ops = {
 	.listen		= smc_listen,
 	.shutdown	= smc_shutdown,
 	.setsockopt	= smc_setsockopt,
-	.getsockopt	= smc_getsockopt,
+	.getsockopt_iter = smc_getsockopt,
 	.sendmsg	= smc_sendmsg,
 	.recvmsg	= smc_recvmsg,
 	.mmap		= sock_no_mmap,
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 52145df83f6e..e62549067b67 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -59,7 +59,7 @@ int smc_shutdown(struct socket *sock, int how);
 int smc_setsockopt(struct socket *sock, int level, int optname,
 		   sockptr_t optval, unsigned int optlen);
 int smc_getsockopt(struct socket *sock, int level, int optname,
-		   char __user *optval, int __user *optlen);
+		   sockopt_t *opt);
 int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len);
 int smc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		int flags);
diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
index a94084b4a498..419240fedbc3 100644
--- a/net/smc/smc_inet.c
+++ b/net/smc/smc_inet.c
@@ -44,7 +44,7 @@ static const struct proto_ops smc_inet_stream_ops = {
 	.listen		= smc_listen,
 	.shutdown	= smc_shutdown,
 	.setsockopt	= smc_setsockopt,
-	.getsockopt	= smc_getsockopt,
+	.getsockopt_iter = smc_getsockopt,
 	.sendmsg	= smc_sendmsg,
 	.recvmsg	= smc_recvmsg,
 	.mmap		= sock_no_mmap,
@@ -91,7 +91,7 @@ static const struct proto_ops smc_inet6_stream_ops = {
 	.listen		= smc_listen,
 	.shutdown	= smc_shutdown,
 	.setsockopt	= smc_setsockopt,
-	.getsockopt	= smc_getsockopt,
+	.getsockopt_iter = smc_getsockopt,
 	.sendmsg	= smc_sendmsg,
 	.recvmsg	= smc_recvmsg,
 	.mmap		= sock_no_mmap,

-- 
2.53.0-Meta


