Return-Path: <linux-rdma+bounces-21949-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ow7MCfmPJmolYwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21949-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 11:48:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3765654BBB
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 11:48:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=fs0A+8qr;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21949-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21949-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28A23303C293
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 09:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6E43B8BDA;
	Mon,  8 Jun 2026 09:46:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5AF3B8127;
	Mon,  8 Jun 2026 09:46:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911974; cv=none; b=JfAb+M0L3kmzZzbNvbpqP0CFKj+8rcu4JlGn94xDZOhF0QiAZV4Tz5GjYVEQsQMuaHOnw9rWURzMEotrsvKaefqk5ud2bowq9xuqi+o22Gfzo99nbuLVtHsTvHgA5hkW5h0KEFLxkyAgB+Twzuq/zAayRKJhDrrr1ZPUpUwmAZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911974; c=relaxed/simple;
	bh=zIfiWBmE2HnYS/F0hW39kjh4eHnOUmlctnvwmiHCkRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gmIXvi7lIXcfRudQcQlsoByraPEjpMB0ymcmRPva1Z8FTg9h6dDQx1kpLsSNZqfdefgu3jHsm6rhUe0/thJBCJDzKAeJd4sJw73GPxNeG8vJrzT+32LN1hoNnDTpLEbecswHnD576vFXYEG4Tg29j2UNuuaIFkcPwRtXTKZtmEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=fs0A+8qr; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=w0e/0FhKofh2YOqY4slcg2eOBkyn0jr9EXZHJ/nOus0=; b=fs0A+8qrGfHCygVnx0cvBusPgD
	/TXoWDZ2aP4ZbP6qc/HqNDAATZ6yloCA5oqaIyFOJ/N7hoQNDLwmGplr0dhovgwSLOJ/9jECxE0n7
	33Q9gS7H1QczOF2CVsRSSfNqaSAk8f/qXPDT3RWtLBzgS7yrO7sDKTBQnSq48XKr5y/WcCkiMUbi/
	2lEqrB7V/GCGA8T03SJ9xP0dXrvz1ole7hz5g4/2mRWWal6iFrEOXIEww5EdDZJc9e4OWqHy13Fg0
	AdUVIQVg/9nlKzlgqN1nfByk09B3A45XE96bZCidmgdyat2CaoYolhAcYsRCO461/IAzvs/VLFXQ8
	irto6G7Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wWWYb-007XIa-0v;
	Mon, 08 Jun 2026 09:46:09 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 08 Jun 2026 02:44:58 -0700
Subject: [PATCH net-next v3 2/2] rds: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-getsock_more-v3-2-706ecf2ea332@debian.org>
References: <20260608-getsock_more-v3-0-706ecf2ea332@debian.org>
In-Reply-To: <20260608-getsock_more-v3-0-706ecf2ea332@debian.org>
To: Allison Henderson <achender@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Andy Grover <andy.grover@oracle.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9118; i=leitao@debian.org;
 h=from:subject:message-id; bh=zIfiWBmE2HnYS/F0hW39kjh4eHnOUmlctnvwmiHCkRw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqJo9U2FzK2OIZNxe6HZ9J6R9Otrxz6CSmukCbg
 MrjxTBfDGiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaiaPVAAKCRA1o5Of/Hh3
 bbTwD/466kvNcGZg2CIq4ipz800YlNdDMPb+QtfFTkOnmYM0KLguqto+vT7l/N1zZNgnFPJZWZ7
 oL9/nI38yrPci5AmOhu/iCM0R73vxRtpu91rwoMxFf3sBL6tWtCVF7jJ89iSzT3ynK1Ms5tO6Fy
 qAAcMxR1NVXuEuHZ2TisNlM+1b3O+tMZi4rqBf3jZj2EpDHBMp/3ugp1XZGn0/rgBf33AZKEg9a
 e/AtF+gm3mqQznsHnjcjTQaVoSCYUGtlPlKRrPTnt85AxdYV6Do9ISfiUPjBhsrZEs2u4RnzOQS
 7jz86fZ8g4wDU/rJBnv+eFek7tQR2W/C+jszcIFXrU/MwwfaAi2/rlSPjN+L2LnEpqSk68Yr2Jr
 r+rArY+iBbnWgT05/revyyhuZcxG6F7mzD4pzWSbt3jYJkY44XBfA8lXiE3FdTCyQx0Dyg3bmyt
 lHkePnnBeGGKT00x9axjJ9J4lgtK9jZMs6VAYCd27ChgNda5YU9zcBo94B8N0gudeM0rsc/9nr+
 tpo2q0eXpuYQQs5t2s/SA2prdVt7R8zEb92bX/uF4udUyfS2NakPn+lOXF/tp/9hYl3qvTvp4/H
 U6/Izq2RsaGDKdXTUPWpFzNsbu0VkGlKiEJWXQLL27sm9GQ1/g1CRQ3t8yFf0QeB+/5SL2qYsg3
 vHMABtxqSBKi+GQ==
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:andy.grover@oracle.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kselftest@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-21949-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3765654BBB

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
Reviewed-by: Allison Henderson <achender@kernel.org>
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
index f1b29994934a..499b3774860e 100644
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
2.53.0-Meta


