Return-Path: <linux-rdma+bounces-21691-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pcEqACpcIGqe1wAAu9opvQ
	(envelope-from <linux-rdma+bounces-21691-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 18:54:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B34639F36
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 18:54:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b="H/HUtQBC";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21691-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21691-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30843320374A
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 16:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0077A3E9F93;
	Wed,  3 Jun 2026 16:11:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827923E9F8D;
	Wed,  3 Jun 2026 16:11:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503117; cv=none; b=fsO3DkRkmMY/dwjhvXoiSQF88G1lmZekwUoS6SkB4WRvFh86/GqvTA5k14NPc9DmCqMo7mgVSQY77XoTeXMn13F2eiMOh2A/YcFAleVXHZNUi461NQPfiK37cpxWiJiTfSDXrSFsTSfpAuy2BR+eKEutdb7JGSatDUeIZQwis9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503117; c=relaxed/simple;
	bh=6fMELYGkhYE50ppwIKhYlMn+RLtbDS8gK474KPu3eXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CuUEx8EsapYbDoIMD0Puq3WoLeMf4qOhRvYwska+vQkanWwJR1G34q9c0aCXVhyB0uhs4/GmJSwgHjWzNAZ+EE6xh9St4fPUzxDmbd/StgW8SjokLbO8MMBALkSn9WP8DC8B78mP+cYL+8CxsQ/815BaAofmbot9xoWAsf8cCdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=H/HUtQBC; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=nUK84ZQmWp56Pci5yTo1v82qsWxJDWZ4hzDMHV7htNE=; b=H/HUtQBCCMC/Jdp/u9WFvnTm1/
	EW8h1/r7Xwv4azW/l6OjO8O9FoaJYTFkRIHlTG4Hpj93zCN/GWYPXXWF2UYzTJw0qDZFkx+/+1Srv
	ukLhBZcNU6h5+r9fqCvOsisk6fz9bFqFqlj03Io2npvjXyMb4pEKhaNfTSvZY4KroJLmOjg90b21l
	0WXy0xmjDjCNH2fjg5/ztLF4fo1gRMjuCJfDJyWzmD8c1AW86ROaE1UVdWD4y9mW/YTAp5G9R57sM
	I+uSXBBtNHcgBtb9bnDU02oaYjmXdAiPn4qBd71UrDrW+Q7woGAfenKCf1p1DAROxcu9UJnUvEhSr
	oFW62Xig==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wUoC3-003rAW-1a;
	Wed, 03 Jun 2026 16:11:47 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 03 Jun 2026 09:11:33 -0700
Subject: [PATCH net-next 1/2] rds: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-getsock_more-v1-1-43b8d40c8849@debian.org>
References: <20260603-getsock_more-v1-0-43b8d40c8849@debian.org>
In-Reply-To: <20260603-getsock_more-v1-0-43b8d40c8849@debian.org>
To: Allison Henderson <achender@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8848; i=leitao@debian.org;
 h=from:subject:message-id; bh=6fMELYGkhYE50ppwIKhYlMn+RLtbDS8gK474KPu3eXo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqIFI54xERf3HKv9fRnwrZYoDWPrZc/q4TWM+cp
 o5t+7nguBuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaiBSOQAKCRA1o5Of/Hh3
 bd9uD/0Zy8WOwm5ZZSvViRUzQ+SQwktiWDMJYRlBNegXvX+tmnzMG8auh48CDzKX7G06JoKNGH8
 ObrMItZUquyOSmEcmEebV0omB3Lhe9+cQ1tw8e9oX4Fr3oRnJrftz4pE0cJToJUgKMYSd562483
 zt5MwH3VMXgKNYrUjHMlpqyXwiItfFGLd5+43QNQwl0RwB20GU92bkZiSHwmi2nfg6McHr0O8PL
 hJrCmvET8L8d0AtdRjaHhGcsBfKcBEXuQ9fn3CqAKqmkDqLJUMS8iQLZqte8mWGFRPhAajFwU5c
 L4TQt+/Pv4nCkSaPserCvvJ3aCX+mgFz+6l0YgcWavf2HBLBZi+bGrfohuzCNz+7U8bufEELaMv
 DU1din+OKu9l9XWq0YRAQ8yqecwDJqZW9E39VLpltSlILsPMtJGpEK6rjzItMRajkVq8ZYwN0GV
 09oZ4lY0IHkRWyg48XksxLDdNZImNJXLUpTW6DN2RaMsXfUc3S0yHszxqOoRSyNJWrn9fXmMcOx
 r2HUwhPFSUZSXoeVMPCDvPxX2pdKzcqzu3SZZM/ZOZTeENEaiucqTJ4b3C3h//5pymy4GRmhNvh
 3CyIC0bgN5TQ1Ii+Zh1LvPGijg/3+ju13odJ6VK8xmIH3glAgYewqzQ0HfHOOR8V7x0Hi+X4bEY
 dzwf08rCAetxs4w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kselftest@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-21691-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48B34639F36

Convert RDS socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of put_user()/copy_to_user()

The RDS_INFO_* snapshot path in rds_info_getsockopt() used to pin the
userspace buffer with pin_user_pages_fast() on the raw optval address;
the info producers then memcpy into those pages under a spinlock via
kmap_atomic() and so must not fault. Obtain the same page array and
starting offset from opt->iter_out with iov_iter_extract_pages(), which
pins for write because iter_out is ITER_DEST.

The page array is preallocated here (sized with iov_iter_npages()) and
passed in, so iov_iter_extract_pages() fills it in place rather than
allocating one for us; RDS therefore keeps ownership of the array on
every return path and frees it itself. The rds_info_iterator /
rds_info_copy machinery and all producer callbacks are unchanged.

Kernel buffers (ITER_KVEC) are not page-backed in a way the info
producers can use, so the RDS_INFO path returns -EOPNOTSUPP for them;
this matches the previous behaviour, where a kernel-buffer getsockopt
hit the WARN_ONCE() path in do_sock_getsockopt() and returned
-EOPNOTSUPP. The simple RDS_RECVERR and SO_RDS_TRANSPORT options keep
working for kernel buffers via copy_to_iter().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/rds/af_rds.c | 36 ++++++++++++++++-------------
 net/rds/info.c   | 70 +++++++++++++++++++++++++++++++-------------------------
 net/rds/info.h   |  3 +--
 3 files changed, 60 insertions(+), 49 deletions(-)

diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 6f4f9cf352bd..d5defe9172e3 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -37,6 +37,7 @@
 #include <linux/in.h>
 #include <linux/ipv6.h>
 #include <linux/poll.h>
+#include <linux/uio.h>
 #include <net/sock.h>
 
 #include "rds.h"
@@ -485,35 +486,36 @@ static int rds_setsockopt(struct socket *sock, int level, int optname,
 }
 
 static int rds_getsockopt(struct socket *sock, int level, int optname,
-			  char __user *optval, int __user *optlen)
+			  sockopt_t *opt)
 {
 	struct rds_sock *rs = rds_sk_to_rs(sock->sk);
 	int ret = -ENOPROTOOPT, len;
 	int trans;
+	int val;
 
 	if (level != SOL_RDS)
 		goto out;
 
-	if (get_user(len, optlen)) {
-		ret = -EFAULT;
-		goto out;
-	}
+	len = opt->optlen;
 
 	switch (optname) {
 	case RDS_INFO_FIRST ... RDS_INFO_LAST:
-		ret = rds_info_getsockopt(sock, optname, optval,
-					  optlen);
+		ret = rds_info_getsockopt(sock, optname, opt);
 		break;
 
 	case RDS_RECVERR:
-		if (len < sizeof(int))
+		if (len < sizeof(int)) {
 			ret = -EINVAL;
-		else
-		if (put_user(rs->rs_recverr, (int __user *) optval) ||
-		    put_user(sizeof(int), optlen))
+			break;
+		}
+		val = rs->rs_recverr;
+		if (copy_to_iter(&val, sizeof(int), &opt->iter_out) !=
+		    sizeof(int)) {
 			ret = -EFAULT;
-		else
+		} else {
+			opt->optlen = sizeof(int);
 			ret = 0;
+		}
 		break;
 	case SO_RDS_TRANSPORT:
 		if (len < sizeof(int)) {
@@ -522,11 +524,13 @@ static int rds_getsockopt(struct socket *sock, int level, int optname,
 		}
 		trans = (rs->rs_transport ? rs->rs_transport->t_type :
 			 RDS_TRANS_NONE); /* unbound */
-		if (put_user(trans, (int __user *)optval) ||
-		    put_user(sizeof(int), optlen))
+		if (copy_to_iter(&trans, sizeof(int), &opt->iter_out) !=
+		    sizeof(int)) {
 			ret = -EFAULT;
-		else
+		} else {
+			opt->optlen = sizeof(int);
 			ret = 0;
+		}
 		break;
 	default:
 		break;
@@ -653,7 +657,7 @@ static const struct proto_ops rds_proto_ops = {
 	.listen =	sock_no_listen,
 	.shutdown =	sock_no_shutdown,
 	.setsockopt =	rds_setsockopt,
-	.getsockopt =	rds_getsockopt,
+	.getsockopt_iter =	rds_getsockopt,
 	.sendmsg =	rds_sendmsg,
 	.recvmsg =	rds_recvmsg,
 	.mmap =		sock_no_mmap,
diff --git a/net/rds/info.c b/net/rds/info.c
index f1b29994934a..171838782595 100644
--- a/net/rds/info.c
+++ b/net/rds/info.c
@@ -35,6 +35,7 @@
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
 #include <linux/export.h>
+#include <linux/uio.h>
 
 #include "rds.h"
 
@@ -144,60 +145,68 @@ void rds_info_copy(struct rds_info_iterator *iter, void *data,
 EXPORT_SYMBOL_GPL(rds_info_copy);
 
 /*
- * @optval points to the userspace buffer that the information snapshot
- * will be copied into.
- *
- * @optlen on input is the size of the buffer in userspace.  @optlen
- * on output is the size of the requested snapshot in bytes.
+ * @opt->iter_out describes the buffer that the information snapshot will be
+ * copied into, and @opt->optlen is the size of that buffer on input.  On
+ * output @opt->optlen is set to the size of the requested snapshot in bytes.
  *
  * This function returns -errno if there is a failure, particularly -ENOSPC
- * if the given userspace buffer was not large enough to fit the snapshot.
- * On success it returns the positive number of bytes of each array element
- * in the snapshot.
+ * if the given buffer was not large enough to fit the snapshot.  On success
+ * it returns the positive number of bytes of each array element in the
+ * snapshot.
  */
-int rds_info_getsockopt(struct socket *sock, int optname, char __user *optval,
-			int __user *optlen)
+int rds_info_getsockopt(struct socket *sock, int optname, sockopt_t *opt)
 {
 	struct rds_info_iterator iter;
 	struct rds_info_lengths lens;
 	unsigned long nr_pages = 0;
-	unsigned long start;
 	rds_info_func func;
 	struct page **pages = NULL;
+	size_t offset0 = 0;
+	int npages = 0;
 	int ret;
 	int len;
 	int total;
 
-	if (get_user(len, optlen)) {
-		ret = -EFAULT;
-		goto out;
-	}
+	len = opt->optlen;
 
 	/* check for all kinds of wrapping and the like */
-	start = (unsigned long)optval;
-	if (len < 0 || len > INT_MAX - PAGE_SIZE + 1 || start + len < start) {
+	if (len < 0 || len > INT_MAX - PAGE_SIZE + 1) {
 		ret = -EINVAL;
 		goto out;
 	}
 
+	/* The info producers write into the pages with kmap_atomic() while
+	 * holding a spinlock, so they need a genuine page-backed user buffer.
+	 */
+	if (iov_iter_is_kvec(&opt->iter_out)) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	/* a 0 len call is just trying to probe its length */
 	if (len == 0)
 		goto call_func;
 
-	nr_pages = (PAGE_ALIGN(start + len) - (start & PAGE_MASK))
-			>> PAGE_SHIFT;
-
-	pages = kmalloc_objs(struct page *, nr_pages);
+	/*
+	 * Preallocate the page array and pass it in so that
+	 * iov_iter_extract_pages() fills it in place rather than allocating
+	 * one for us.  Handing it a non-NULL array keeps ownership of the
+	 * array with us on every return path, instead of depending on the
+	 * iterator code to allocate and hand it back.
+	 */
+	npages = iov_iter_npages(&opt->iter_out, INT_MAX);
+	pages = kvmalloc_array(npages, sizeof(*pages), GFP_KERNEL);
 	if (!pages) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	ret = pin_user_pages_fast(start, nr_pages, FOLL_WRITE, pages);
-	if (ret != nr_pages) {
-		if (ret > 0)
-			nr_pages = ret;
-		else
-			nr_pages = 0;
+
+	ret = iov_iter_extract_pages(&opt->iter_out, &pages, len, npages,
+				     0, &offset0);
+	if (ret < 0)
+		goto out;
+	nr_pages = DIV_ROUND_UP(offset0 + ret, PAGE_SIZE);
+	if (ret != len) {
 		ret = -EAGAIN; /* XXX ? */
 		goto out;
 	}
@@ -213,7 +222,7 @@ int rds_info_getsockopt(struct socket *sock, int optname, char __user *optval,
 
 	iter.pages = pages;
 	iter.addr = NULL;
-	iter.offset = start & (PAGE_SIZE - 1);
+	iter.offset = offset0;
 
 	func(sock, len, &iter, &lens);
 	BUG_ON(lens.each == 0);
@@ -230,13 +239,12 @@ int rds_info_getsockopt(struct socket *sock, int optname, char __user *optval,
 		ret = lens.each;
 	}
 
-	if (put_user(len, optlen))
-		ret = -EFAULT;
+	opt->optlen = len;
 
 out:
 	if (pages)
 		unpin_user_pages(pages, nr_pages);
-	kfree(pages);
+	kvfree(pages);
 
 	return ret;
 }
diff --git a/net/rds/info.h b/net/rds/info.h
index a069b51c4679..1aab62ab6d00 100644
--- a/net/rds/info.h
+++ b/net/rds/info.h
@@ -21,8 +21,7 @@ typedef void (*rds_info_func)(struct socket *sock, unsigned int len,
 
 void rds_info_register_func(int optname, rds_info_func func);
 void rds_info_deregister_func(int optname, rds_info_func func);
-int rds_info_getsockopt(struct socket *sock, int optname, char __user *optval,
-			int __user *optlen);
+int rds_info_getsockopt(struct socket *sock, int optname, sockopt_t *opt);
 void rds_info_copy(struct rds_info_iterator *iter, void *data,
 		   unsigned long bytes);
 void rds_info_iter_unmap(struct rds_info_iterator *iter);

-- 
2.54.0


