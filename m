Return-Path: <linux-rdma+bounces-2493-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C4B8C6693
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2024 14:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79851C21E1E
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2024 12:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7C484DFF;
	Wed, 15 May 2024 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nx5RbzDa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5C784A37;
	Wed, 15 May 2024 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715777660; cv=none; b=OFfefZQEXhJN4J5LLHzEok8yxK2LAckIiMgG148/mM2YSorvT4UgrBy2H8bjamyv2U5APWR1l1ugH29ZmZOoylxabNLEy32tGbWHv0ZhyHB0GbilVsgjXitjWJOcEc13kGzdqvkVMO8E/mSAUnJzR+DBaLWrEr3O92vi+KOQdtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715777660; c=relaxed/simple;
	bh=EcHU8N3DwLiEKSuSv/X62OvipkQbysqSYGuBdlNY1pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVkGHTQf2y/R6lUw+ZlcCsftpPqenVgoakwlijo/WuVhIEdAEqO9eTSZUoaNzzLaZdb+NCasvJHKJKRcBFCDRwUefxArjPs3ebYnQ2k4tYKIGk9lhmJ2ppBgfrpNYBbvSUiqCSlatK0/c/DqIMHwm/NFR9Ca9MKnq/GWVbMrGMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nx5RbzDa; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44F7n2n1008508;
	Wed, 15 May 2024 12:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=u17tuwlq4ab0H7PsxNcpg5nduawD3jBBMb6XH3A+JLs=;
 b=nx5RbzDaz1Dq245+AGp/S95PwVqDgTt0TNKgvJNaBCDcQkfk3TwNfS/ECLwnuALPXUby
 O9DTkVLIt9Wae1H5H6UmjEhMW2zFyLmtAs6Z4GyKEIXaXBOQUntTYoZadrEl8l1yhy7x
 GuPeCRCjIBOnp+qTy7hCeiE4YxPUpL0l6XPDycyqT6ZB7j7OT+wSNO9v/QqUg7sxETA+
 Xp289kaa+L3d28BK2VpXZvAjLoQJ0h1BFNKTXTBgY1gs8O5tN4DKvqHnyw5qt+hbZRNT
 zP1ZK7VWDfjLhBSWgtYiaaTFvtNg8kFF9/C3eeIOT7UtZ+y8ohSOcp4F98SXX5vZh7cq ZQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3t4fcxjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 12:53:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44FCZeHO038274;
	Wed, 15 May 2024 12:53:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y24pxgun9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 12:53:58 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44FCmlrd038458;
	Wed, 15 May 2024 12:53:57 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y24pxgud9-3;
	Wed, 15 May 2024 12:53:56 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, rds-devel@oss.oracle.com
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        Mark Zhang <markzhang@nvidia.com>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH v2 2/6] rds: Brute force GFP_NOIO
Date: Wed, 15 May 2024 14:53:38 +0200
Message-Id: <20240515125342.1069999-3-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240515125342.1069999-1-haakon.bugge@oracle.com>
References: <20240515125342.1069999-1-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_06,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405150090
X-Proofpoint-ORIG-GUID: nSfqDXeJWV05AJdzTXEiPMEz7r85g8Pl
X-Proofpoint-GUID: nSfqDXeJWV05AJdzTXEiPMEz7r85g8Pl

For most entry points to RDS, we call memalloc_noio_{save,restore} in
a parenthetic fashion when enabled by the module parameter force_noio.

We skip the calls to memalloc_noio_{save,restore} in rds_ioctl(), as
no memory allocations are executed in this function or its callees.

The reason we execute memalloc_noio_{save,restore} in rds_poll(), is
due to the following call chain:

rds_poll()
        poll_wait()
                __pollwait()
                        poll_get_entry()
                                __get_free_page(GFP_KERNEL)

The function rds_setsockopt() allocates memory in its callee's
rds_get_mr() and rds_get_mr_for_dest(). Hence, we need
memalloc_noio_{save,restore} in rds_setsockopt().

In rds_getsockopt(), we have rds_info_getsockopt() that allocates
memory. Hence, we need memalloc_noio_{save,restore} in
rds_getsockopt().

All the above, in order to conditionally enable RDS to become a block I/O
device.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---

v1 -> v2:
   * s/EXPORT_SYMBOL/static/ for the rds_force_noio variable as
     pin-pointed by Simon
   * Straightened the reverse xmas tree two places
   * Fixed C/P error in rds_cancel_sent_to() where I had two _save()s
     and no _restore() as reported by Simon
---
 net/rds/af_rds.c | 59 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 8435a20968ef5..846ad20b3783a 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -37,10 +37,15 @@
 #include <linux/in.h>
 #include <linux/ipv6.h>
 #include <linux/poll.h>
+#include <linux/sched/mm.h>
 #include <net/sock.h>
 
 #include "rds.h"
 
+static bool rds_force_noio;
+module_param_named(force_noio, rds_force_noio, bool, 0444);
+MODULE_PARM_DESC(force_noio, "Force the use of GFP_NOIO (Y/N)");
+
 /* this is just used for stats gathering :/ */
 static DEFINE_SPINLOCK(rds_sock_lock);
 static unsigned long rds_sock_count;
@@ -59,8 +64,12 @@ DECLARE_WAIT_QUEUE_HEAD(rds_poll_waitq);
 static int rds_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
+	unsigned int noio_flags;
 	struct rds_sock *rs;
 
+	if (rds_force_noio)
+		noio_flags = memalloc_noio_save();
+
 	if (!sk)
 		goto out;
 
@@ -90,6 +99,8 @@ static int rds_release(struct socket *sock)
 	sock->sk = NULL;
 	sock_put(sk);
 out:
+	if (rds_force_noio)
+		memalloc_noio_restore(noio_flags);
 	return 0;
 }
 
@@ -214,9 +225,13 @@ static __poll_t rds_poll(struct file *file, struct socket *sock,
 {
 	struct sock *sk = sock->sk;
 	struct rds_sock *rs = rds_sk_to_rs(sk);
+	unsigned int noio_flags;
 	__poll_t mask = 0;
 	unsigned long flags;
 
+	if (rds_force_noio)
+		noio_flags = memalloc_noio_save();
+
 	poll_wait(file, sk_sleep(sk), wait);
 
 	if (rs->rs_seen_congestion)
@@ -249,6 +264,8 @@ static __poll_t rds_poll(struct file *file, struct socket *sock,
 	if (mask)
 		rs->rs_seen_congestion = 0;
 
+	if (rds_force_noio)
+		memalloc_noio_restore(noio_flags);
 	return mask;
 }
 
@@ -293,9 +310,13 @@ static int rds_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 static int rds_cancel_sent_to(struct rds_sock *rs, sockptr_t optval, int len)
 {
 	struct sockaddr_in6 sin6;
+	unsigned int noio_flags;
 	struct sockaddr_in sin;
 	int ret = 0;
 
+	if (rds_force_noio)
+		noio_flags = memalloc_noio_save();
+
 	/* racing with another thread binding seems ok here */
 	if (ipv6_addr_any(&rs->rs_bound_addr)) {
 		ret = -ENOTCONN; /* XXX not a great errno */
@@ -324,6 +345,8 @@ static int rds_cancel_sent_to(struct rds_sock *rs, sockptr_t optval, int len)
 
 	rds_send_drop_to(rs, &sin6);
 out:
+	if (rds_force_noio)
+		memalloc_noio_restore(noio_flags);
 	return ret;
 }
 
@@ -485,8 +508,12 @@ static int rds_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct rds_sock *rs = rds_sk_to_rs(sock->sk);
 	int ret = -ENOPROTOOPT, len;
+	unsigned int noio_flags;
 	int trans;
 
+	if (rds_force_noio)
+		noio_flags = memalloc_noio_save();
+
 	if (level != SOL_RDS)
 		goto out;
 
@@ -529,6 +556,8 @@ static int rds_getsockopt(struct socket *sock, int level, int optname,
 	}
 
 out:
+	if (rds_force_noio)
+		memalloc_noio_restore(noio_flags);
 	return ret;
 
 }
@@ -538,12 +567,16 @@ static int rds_connect(struct socket *sock, struct sockaddr *uaddr,
 {
 	struct sock *sk = sock->sk;
 	struct sockaddr_in *sin;
+	unsigned int noio_flags;
 	struct rds_sock *rs = rds_sk_to_rs(sk);
 	int ret = 0;
 
 	if (addr_len < offsetofend(struct sockaddr, sa_family))
 		return -EINVAL;
 
+	if (rds_force_noio)
+		noio_flags = memalloc_noio_save();
+
 	lock_sock(sk);
 
 	switch (uaddr->sa_family) {
@@ -626,6 +659,8 @@ static int rds_connect(struct socket *sock, struct sockaddr *uaddr,
 	}
 
 	release_sock(sk);
+	if (rds_force_noio)
+		memalloc_noio_restore(noio_flags);
 	return ret;
 }
 
@@ -697,16 +732,28 @@ static int __rds_create(struct socket *sock, struct sock *sk, int protocol)
 static int rds_create(struct net *net, struct socket *sock, int protocol,
 		      int kern)
 {
+	unsigned int noio_flags;
 	struct sock *sk;
+	int ret;
 
 	if (sock->type != SOCK_SEQPACKET || protocol)
 		return -ESOCKTNOSUPPORT;
 
+	if (rds_force_noio)
+		noio_flags = memalloc_noio_save();
+
 	sk = sk_alloc(net, AF_RDS, GFP_KERNEL, &rds_proto, kern);
-	if (!sk)
-		return -ENOMEM;
+	if (!sk) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
-	return __rds_create(sock, sk, protocol);
+	ret = __rds_create(sock, sk, protocol);
+out:
+	if (rds_force_noio)
+		memalloc_noio_restore(noio_flags);
+
+	return ret;
 }
 
 void rds_sock_addref(struct rds_sock *rs)
@@ -895,8 +942,12 @@ u32 rds_gen_num;
 
 static int __init rds_init(void)
 {
+	unsigned int noio_flags;
 	int ret;
 
+	if (rds_force_noio)
+		noio_flags = memalloc_noio_save();
+
 	net_get_random_once(&rds_gen_num, sizeof(rds_gen_num));
 
 	ret = rds_bind_lock_init();
@@ -947,6 +998,8 @@ static int __init rds_init(void)
 out_bind:
 	rds_bind_lock_destroy();
 out:
+	if (rds_force_noio)
+		memalloc_noio_restore(noio_flags);
 	return ret;
 }
 module_init(rds_init);
-- 
2.45.0


