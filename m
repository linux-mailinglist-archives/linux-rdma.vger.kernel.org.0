Return-Path: <linux-rdma+bounces-21833-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YIBSO5aoImqLbgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21833-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 12:44:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC7064775B
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 12:44:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=gFB8rLUi;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21833-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21833-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90B13306E50B
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 10:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2531F4C6F12;
	Fri,  5 Jun 2026 10:32:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BD14ADD91;
	Fri,  5 Jun 2026 10:32:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780655526; cv=none; b=DcefUCIWDwNFR30w3msZobhTddwHiyHikc8R++UmVQ3JOHuPp5KGaZNlHoRF1IGXTK8tHy63BhlUEssa5Y24VKWVDoO0J2Jcz2ZxCNRMphiIRv7210Sh9Z/4fUCh+1ukRyM7nqVYwGwLDnquO9v1S878LsbP8wNBcS+prs4zj3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780655526; c=relaxed/simple;
	bh=4JzxiyHuzVHV5u6xPLo9a96EavCnG+zUg49sD/rGMvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t8VYUA9W5GhrGnNdi+f7nNd1n8aBoSOHrDH21D+SRQ1+yfrE8lz2QXJIiVoAFh1tRwdSINA/xZmI/y3R+M+ALUzFqFgTTcxcsv1Pzo6g3GlTHl86EN5qyoPpIJaF7aho1l2oXISo569Bq6Q+gsKpTR+M4wLjjw3BEIp9pO9WY5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=gFB8rLUi; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=hz7RK7vwPIuok63s9GZ4PpfT4BdFxPOdoyp+D6Hshek=; b=gFB8rLUiKwhKNLuk1v5vyhI+fY
	yFrancLNEruQ+LUh94AtzRl/WZUFYHEJVkzHesOHExSFdTghhE5phL7GhYbQ8xV2fxGaGpo0drjHK
	oVbKjzeqhd83CIrT907Yx3I6SCw1JYrwYJHPdV/o43wGOLCXn68cpH1/2G4VSAsEoV0DX4VZATc9Z
	rsJslc8+TFsxqhq99cc8AgeffOf4boHlRrbiPrXhwLvnhYPd+x2IAq+LM3bkoI6NfTPGZpHCkvKC1
	6RJAdLsloo18OMTlVlCw+/mftGwIlDBleabgl22nWcLBXywRzwzPTs1F2B1e1j3qYOLTUiwKTfNmQ
	3GmfnX8A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wVRqI-005EFA-1u;
	Fri, 05 Jun 2026 10:31:58 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 05 Jun 2026 03:31:40 -0700
Subject: [PATCH net-next v2 3/3] rds: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-getsock_more-v2-3-80f38cdb8706@debian.org>
References: <20260605-getsock_more-v2-0-80f38cdb8706@debian.org>
In-Reply-To: <20260605-getsock_more-v2-0-80f38cdb8706@debian.org>
To: Allison Henderson <achender@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9081; i=leitao@debian.org;
 h=from:subject:message-id; bh=4JzxiyHuzVHV5u6xPLo9a96EavCnG+zUg49sD/rGMvI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqIqWNPsa6CpdJh4dvuEhZUZ8+jLGq5cBu0MEeG
 sKPw0LgBUyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaiKljQAKCRA1o5Of/Hh3
 bQ91EACkyOJGyYbxqcqRFMP4CLI1rDkhLKBmc2Jqcz/2nKLJ/XMa2BiDP9wjpTwdjiqjY4rvCsj
 AFfa/qZE78VlUnP3VWid1QenRkzHFgr2u+AP80UK7PUsh5URErdShVmOccu4vc0JJArWyP+/YH0
 hjWaCtx/GAO+EUGS5SpPV3suPWvykiVEVl2ifrlgUPuWbPHd6rKXLmATALzbX6afs3YXGyIjb4/
 +JsbXs21/nBzYMZJu4KOkqGobDFiqoKgyF3WcXvq+s2EvEaPvmPdMRtg4elMhx4Ep8IXsbRPa1G
 LunlQCrW0BjtEg671mRyZ+6A8P8VoKyBfjocVyOiBaXikP1SXi+ieM45vmc5tC7RBorx6R+W6hF
 H/u8omYzrUbl/5m/TWB4m7ZXTSSLRmTZ7q5IsZ2d4ugONsrW+K/JRlyhpqvIKBp+B2d3dcDOw2W
 Hb8e7bY/knRqs1DYnet0RHTnyBM99/A5wD4tXUEuYSn6BBUp20EcIf1Iatt8DIZjP2r2wEsImhP
 xNWiPFYLwOBFtXyTD/sm8uGcV2ZWdOc/UnvTcftl2k4fDDoJr6QOzVuPidLj3tciGAqzIs3EYXG
 LuF+xleoOVCMk8LYg2O/pvonZ3kaNDOOnWRVBOdYVxJxcMSaOZeNyQD94paHJMClPZzKW2A+XsU
 RUqybvcSkxe2utQ==
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
	TAGGED_FROM(0.00)[bounces-21833-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 6DC7064775B

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
 net/rds/af_rds.c | 36 +++++++++++++++------------
 net/rds/info.c   | 76 ++++++++++++++++++++++++++++++++------------------------
 net/rds/info.h   |  3 +--
 3 files changed, 65 insertions(+), 50 deletions(-)

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
index 17061f6ff74e..21b32eb16559 100644
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
+	if (!user_backed_iter(&opt->iter_out)) {
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
@@ -230,13 +239,16 @@ int rds_info_getsockopt(struct socket *sock, int optname, char __user *optval,
 		ret = lens.each;
 	}
 
-	if (put_user(len, optlen))
-		ret = -EFAULT;
+	opt->optlen = len;
 
 out:
-	if (pages)
+	/*
+	 * iov_iter_extract_pages() pins only user-backed (ubuf) iters;
+	 * iov_iter_extract_will_pin() reports whether an unpin is owed here.
+	 */
+	if (pages && iov_iter_extract_will_pin(&opt->iter_out))
 		unpin_user_pages_dirty_lock(pages, nr_pages, true);
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
2.53.0-Meta


