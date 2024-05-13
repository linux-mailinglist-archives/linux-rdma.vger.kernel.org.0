Return-Path: <linux-rdma+bounces-2453-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5518C411F
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 14:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309B028298B
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 12:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A065F14F9E5;
	Mon, 13 May 2024 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H1CTU6Yp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A1B1534F4;
	Mon, 13 May 2024 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604891; cv=none; b=gypymViPqYa3fcxpnW0iXpouGQDTSyF6Uy8o7CSAHM4u+UEl+AA20uWLMtcy6MJ33Zyu3Y7UOMuEbiXCKBsUIqVrWAslEX8zl58ThrO7VwRK3Wio8bgYBzvjLgezNgFYaB/Hns8fW9tyoSpAZMUUM1K5wAlNnaey4NmQAtJOar4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604891; c=relaxed/simple;
	bh=Vsjx1moAWxymxjHTfMA0IlPMSj1ljy6hwYjl/d0z0xQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtA7cy88j5+G8CdEK92HhlzC0tX3sS7z9130RoUJzBRVxTgLStawO5cYHUEdCAsZ0pZsj9V4Ks4J7QvCck0P6sG6c6/O8q6l4h6qacdMjebiXs7VDwICPrHhE+8DkvXvdfMXY0iQJvAfGJihmSMRXkXZge27ZAKksjVSsAYu+Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H1CTU6Yp; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44DCXm4q006066;
	Mon, 13 May 2024 12:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=/HmYsL17mQIeqtCLxnw9yCav8R0DfG0iy1Zt0d+b1J8=;
 b=H1CTU6Yp7537EWE7J74D1Vyi2UH8d64keA9BQjLAuK5Uh3OlIIzQ8i//jQZsriT+4ml3
 NrPYllvtuT9FYzteJYLCLe+lj6KK9gsCIqi6mpIO7ST7X0FW7uWNRddQ8r5GfNhEb/ir
 c/K+sAKaFg+2LKyKJ/ujfmerDDESD5TqMn3c6WcmfZvmYmRTUVVFPzJUGkxCjkrA27GW
 qMZtxGGZgZRgwpuyIMxVxG/Luthhi3i4lzxxMsXjO/QIGaTjsdLSPwESTjkqFOEoqe+A
 rf63WhgpDVBqZ/Si+7LImbnnV10wVobkS0k42RN1YFM1fMY/BJKCj5g321wNUhLHop/u hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3jygr1h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 12:54:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44DBUCPB018158;
	Mon, 13 May 2024 12:54:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4c137y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 12:54:20 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44DCq982001819;
	Mon, 13 May 2024 12:54:20 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y1y4c12sj-3;
	Mon, 13 May 2024 12:54:19 +0000
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
Subject: [PATCH 2/6] rds: Brute force GFP_NOIO
Date: Mon, 13 May 2024 14:53:42 +0200
Message-Id: <20240513125346.764076-3-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240513125346.764076-1-haakon.bugge@oracle.com>
References: <20240513125346.764076-1-haakon.bugge@oracle.com>
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
 definitions=2024-05-13_08,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405130082
X-Proofpoint-ORIG-GUID: yQqe6sDAyaj4B4VhjcDdfWbca_tFey57
X-Proofpoint-GUID: yQqe6sDAyaj4B4VhjcDdfWbca_tFey57

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
 net/rds/af_rds.c | 60 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 8435a20968ef5..a89d192aabc0b 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -37,10 +37,16 @@
 #include <linux/in.h>
 #include <linux/ipv6.h>
 #include <linux/poll.h>
+#include <linux/sched/mm.h>
 #include <net/sock.h>
 
 #include "rds.h"
 
+bool rds_force_noio;
+EXPORT_SYMBOL(rds_force_noio);
+module_param_named(force_noio, rds_force_noio, bool, 0444);
+MODULE_PARM_DESC(force_noio, "Force the use of GFP_NOIO (Y/N)");
+
 /* this is just used for stats gathering :/ */
 static DEFINE_SPINLOCK(rds_sock_lock);
 static unsigned long rds_sock_count;
@@ -60,6 +66,10 @@ static int rds_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
 	struct rds_sock *rs;
+	unsigned int noio_flags;
+
+	if (rds_force_noio)
+		noio_flags = memalloc_noio_save();
 
 	if (!sk)
 		goto out;
@@ -90,6 +100,8 @@ static int rds_release(struct socket *sock)
 	sock->sk = NULL;
 	sock_put(sk);
 out:
+	if (rds_force_noio)
+		memalloc_noio_restore(noio_flags);
 	return 0;
 }
 
@@ -214,9 +226,13 @@ static __poll_t rds_poll(struct file *file, struct socket *sock,
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
@@ -249,6 +265,8 @@ static __poll_t rds_poll(struct file *file, struct socket *sock,
 	if (mask)
 		rs->rs_seen_congestion = 0;
 
+	if (rds_force_noio)
+		memalloc_noio_restore(noio_flags);
 	return mask;
 }
 
@@ -294,8 +312,12 @@ static int rds_cancel_sent_to(struct rds_sock *rs, sockptr_t optval, int len)
 {
 	struct sockaddr_in6 sin6;
 	struct sockaddr_in sin;
+	unsigned int noio_flags;
 	int ret = 0;
 
+	if (rds_force_noio)
+		noio_flags = memalloc_noio_save();
+
 	/* racing with another thread binding seems ok here */
 	if (ipv6_addr_any(&rs->rs_bound_addr)) {
 		ret = -ENOTCONN; /* XXX not a great errno */
@@ -324,6 +346,8 @@ static int rds_cancel_sent_to(struct rds_sock *rs, sockptr_t optval, int len)
 
 	rds_send_drop_to(rs, &sin6);
 out:
+	if (rds_force_noio)
+		noio_flags = memalloc_noio_save();
 	return ret;
 }
 
@@ -485,8 +509,12 @@ static int rds_getsockopt(struct socket *sock, int level, int optname,
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
 
@@ -529,6 +557,8 @@ static int rds_getsockopt(struct socket *sock, int level, int optname,
 	}
 
 out:
+	if (rds_force_noio)
+		memalloc_noio_restore(noio_flags);
 	return ret;
 
 }
@@ -538,12 +568,16 @@ static int rds_connect(struct socket *sock, struct sockaddr *uaddr,
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
@@ -626,6 +660,8 @@ static int rds_connect(struct socket *sock, struct sockaddr *uaddr,
 	}
 
 	release_sock(sk);
+	if (rds_force_noio)
+		memalloc_noio_restore(noio_flags);
 	return ret;
 }
 
@@ -697,16 +733,28 @@ static int __rds_create(struct socket *sock, struct sock *sk, int protocol)
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
@@ -895,8 +943,12 @@ u32 rds_gen_num;
 
 static int __init rds_init(void)
 {
+	unsigned int noio_flags;
 	int ret;
 
+	if (rds_force_noio)
+		noio_flags = memalloc_noio_save();
+
 	net_get_random_once(&rds_gen_num, sizeof(rds_gen_num));
 
 	ret = rds_bind_lock_init();
@@ -947,6 +999,8 @@ static int __init rds_init(void)
 out_bind:
 	rds_bind_lock_destroy();
 out:
+	if (rds_force_noio)
+		memalloc_noio_restore(noio_flags);
 	return ret;
 }
 module_init(rds_init);
-- 
2.39.3


