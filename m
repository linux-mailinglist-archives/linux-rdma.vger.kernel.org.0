Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 274006AE73
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 20:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388384AbfGPSUh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 14:20:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49364 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfGPSUh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 14:20:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIIssL116436;
        Tue, 16 Jul 2019 18:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=NqG3j3nyFBoR1mnlWOTmyKfH12rmGjFVGjt5rkeEMz4=;
 b=QmsMApYsT3fCp4uKuVak5XXDNozDf7n17941zoYM6NYKPRM21vfxGJW3xLKnuWRImZ4l
 LZrQmAFzovtShPOTpi3JUByepJeAB+Z9FBpsrRT7Uiwk5MCAW+9MgvMbJrxab8lh5J4L
 Ot87B2VPLP/BH6Cth8q/rNcjBXaaXfq3+gZeSXwNJB7hvoYO8ODeD4+L6jedG8KS3q2X
 zkT6NplSf8RgP8QBRK+kyR53/SB6xkIZIMUmAcuWce3hxPxmXLwXaRP8JIs8YBYGGV8U
 icFD4twrwMx2cTtLc9eyaq5bIObBj0PuuKjW7y4JmpEqGUrtKi7hBuX/IwNbg13c4BTt dQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2tq6qtp9pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:20:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIHqrh149827;
        Tue, 16 Jul 2019 18:20:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2tsctwch4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:20:10 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6GIKAQj003672;
        Tue, 16 Jul 2019 18:20:10 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 18:20:09 +0000
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        monis@mellanox.com, parav@mellanox.com, danielj@mellanox.com,
        kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, shamir.rabinovitch@oracle.com,
        johannes.berg@intel.com, willy@infradead.org,
        michaelgur@mellanox.com, markb@mellanox.com,
        yuval.shaia@oracle.com, dan.carpenter@oracle.com,
        bvanassche@acm.org, maxg@mellanox.com, israelr@mellanox.com,
        galpress@amazon.com, denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, will@kernel.org, ereza@mellanox.com,
        jgg@mellanox.com, linux-rdma@vger.kernel.org
Cc:     Shamir Rabinovitch <srabinov7@gmail.com>
Subject: [PATCH rdma-core 12/12] verbs: pinpong test using shared objects API
Date:   Tue, 16 Jul 2019 21:18:40 +0300
Message-Id: <20190716181840.4579-13-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190716181840.4579-1-yuval.shaia@oracle.com>
References: <20190716181840.4579-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160224
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160224
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>

Implementation of pingpong test using the shared object API.
The example is compose of two processes, one creates all the resources,
shared them on with second process via SCM socket and then act as a
server and wait for incoming messages. The second process imports the
shared objects and use them for a communicaion with the server process.

This commit add the ibv_shpd_pingpong sample that demonstrate the use
of the new shared PD capability added to libibverbs and the kernel.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
---
 libibverbs/examples/CMakeLists.txt  |    3 +
 libibverbs/examples/shpd_pingpong.c | 1142 +++++++++++++++++++++++++++
 2 files changed, 1145 insertions(+)
 create mode 100644 libibverbs/examples/shpd_pingpong.c

diff --git a/libibverbs/examples/CMakeLists.txt b/libibverbs/examples/CMakeLists.txt
index dc4c4978..d738aa41 100644
--- a/libibverbs/examples/CMakeLists.txt
+++ b/libibverbs/examples/CMakeLists.txt
@@ -26,3 +26,6 @@ target_link_libraries(ibv_ud_pingpong LINK_PRIVATE ibverbs ibverbs_tools)
 
 rdma_executable(ibv_xsrq_pingpong xsrq_pingpong.c)
 target_link_libraries(ibv_xsrq_pingpong LINK_PRIVATE ibverbs ibverbs_tools)
+
+rdma_executable(ibv_shpd_pingpong shpd_pingpong.c)
+target_link_libraries(ibv_shpd_pingpong LINK_PRIVATE ibverbs ibverbs_tools)
diff --git a/libibverbs/examples/shpd_pingpong.c b/libibverbs/examples/shpd_pingpong.c
new file mode 100644
index 00000000..739c36fd
--- /dev/null
+++ b/libibverbs/examples/shpd_pingpong.c
@@ -0,0 +1,1142 @@
+/*
+ * Copyright (c) 2019 Oracle.  All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Authors:
+ *	Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
+ *	Yuval Shaia <yuval.shaia@oracle.com>
+ *	Shamir Rabinovitch <srabinov7@gmail.com>
+ *
+ */
+
+#if HAVE_CONFIG_H
+#  include <config.h>
+#endif /* HAVE_CONFIG_H */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <sys/time.h>
+#include <netdb.h>
+#include <malloc.h>
+#include <getopt.h>
+#include <arpa/inet.h>
+#include <time.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
+#include <errno.h>
+#include <signal.h>
+#include <infiniband/driver.h>
+#include <rdma/ib_user_ioctl_cmds.h>
+
+#include "pingpong.h"
+
+enum {
+	PINGPONG_RECV_WRID = 1,
+	PINGPONG_SEND_WRID = 2,
+};
+
+static int page_size;
+
+struct ppshm {
+	void		*shmaddr;
+	volatile int	status;
+	uint32_t	shared_pd;
+	uint32_t	shared_mr;
+	char		buf[1];
+};
+
+struct pingpong_context {
+	struct ibv_context	*context;
+	struct ibv_comp_channel	*channel;
+	struct ibv_pd		*pd;
+	struct ibv_mr		*mr;
+	struct ibv_cq		*cq;
+	struct ibv_qp		*qp;
+	void			*buf;
+	int			size;
+	int			rx_depth;
+	int			pending;
+	struct ibv_port_attr	portinfo;
+	int			is_server;
+	key_t			key;
+	int			shmsize;
+	int			shmid;
+	uintptr_t		shmoffset;
+	struct ppshm		*shm;
+	int			sock;
+};
+
+struct pingpong_dest {
+	int lid;
+	int qpn;
+	int psn;
+	union ibv_gid gid;
+};
+
+static int pp_connect_ctx(struct pingpong_context *ctx, int port, int my_psn,
+			  enum ibv_mtu mtu, int sl,
+			  struct pingpong_dest *dest, int sgid_idx)
+{
+	struct ibv_qp_attr attr = {
+		.qp_state		= IBV_QPS_RTR,
+		.path_mtu		= mtu,
+		.dest_qp_num		= dest->qpn,
+		.rq_psn			= dest->psn,
+		.max_dest_rd_atomic	= 1,
+		.min_rnr_timer		= 12,
+		.ah_attr		= {
+			.is_global	= 0,
+			.dlid		= dest->lid,
+			.sl		= sl,
+			.src_path_bits	= 0,
+			.port_num	= port
+		}
+	};
+
+	if (dest->gid.global.interface_id) {
+		attr.ah_attr.is_global = 1;
+		attr.ah_attr.grh.hop_limit = 1;
+		attr.ah_attr.grh.dgid = dest->gid;
+		attr.ah_attr.grh.sgid_index = sgid_idx;
+	}
+	if (ibv_modify_qp(ctx->qp, &attr,
+			  IBV_QP_STATE              |
+			  IBV_QP_AV                 |
+			  IBV_QP_PATH_MTU           |
+			  IBV_QP_DEST_QPN           |
+			  IBV_QP_RQ_PSN             |
+			  IBV_QP_MAX_DEST_RD_ATOMIC |
+			  IBV_QP_MIN_RNR_TIMER)) {
+		fprintf(stderr, "Failed to modify QP to RTR\n");
+		return 1;
+	}
+
+	attr.qp_state	    = IBV_QPS_RTS;
+	attr.timeout	    = 14;
+	attr.retry_cnt	    = 7;
+	attr.rnr_retry	    = 7;
+	attr.sq_psn	    = my_psn;
+	attr.max_rd_atomic  = 1;
+	if (ibv_modify_qp(ctx->qp, &attr,
+			  IBV_QP_STATE              |
+			  IBV_QP_TIMEOUT            |
+			  IBV_QP_RETRY_CNT          |
+			  IBV_QP_RNR_RETRY          |
+			  IBV_QP_SQ_PSN             |
+			  IBV_QP_MAX_QP_RD_ATOMIC)) {
+		fprintf(stderr, "Failed to modify QP to RTS\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+static struct
+pingpong_dest *pp_client_exch_dest(const char *servername,
+				   int port,
+				   const struct pingpong_dest *my_dest)
+{
+	struct addrinfo *res, *t;
+	struct addrinfo hints = {
+		.ai_family   = AF_UNSPEC,
+		.ai_socktype = SOCK_STREAM
+	};
+	char *service;
+	char msg[sizeof "0000:000000:000000:00000000000000000000000000000000"];
+	int n;
+	int sockfd = -1;
+	struct pingpong_dest *rem_dest = NULL;
+	char gid[33];
+
+	if (asprintf(&service, "%d", port) < 0)
+		return NULL;
+
+	n = getaddrinfo(servername, service, &hints, &res);
+
+	if (n < 0) {
+		fprintf(stderr, "%s for %s:%d\n", gai_strerror(n), servername,
+			port);
+		free(service);
+		return NULL;
+	}
+
+	for (t = res; t; t = t->ai_next) {
+		sockfd = socket(t->ai_family, t->ai_socktype, t->ai_protocol);
+		if (sockfd >= 0) {
+			if (!connect(sockfd, t->ai_addr, t->ai_addrlen))
+				break;
+			close(sockfd);
+			sockfd = -1;
+		}
+	}
+
+	freeaddrinfo(res);
+	free(service);
+
+	if (sockfd < 0) {
+		fprintf(stderr, "Couldn't connect to %s:%d\n", servername,
+			port);
+		return NULL;
+	}
+
+	gid_to_wire_gid(&my_dest->gid, gid);
+	sprintf(msg, "%04x:%06x:%06x:%s", my_dest->lid, my_dest->qpn,
+		my_dest->psn, gid);
+	if (write(sockfd, msg, sizeof(msg)) != sizeof(msg)) {
+		fprintf(stderr, "Couldn't send local address\n");
+		goto out;
+	}
+
+	if (read(sockfd, msg, sizeof(msg)) != sizeof(msg)) {
+		perror("client read");
+		fprintf(stderr, "Couldn't read remote address\n");
+		goto out;
+	}
+
+	write(sockfd, "done", sizeof("done"));
+
+	rem_dest = malloc(sizeof(*rem_dest));
+	if (!rem_dest)
+		goto out;
+
+	sscanf(msg, "%x:%x:%x:%s", &rem_dest->lid, &rem_dest->qpn,
+	       &rem_dest->psn, gid);
+	wire_gid_to_gid(gid, &rem_dest->gid);
+
+out:
+	close(sockfd);
+	return rem_dest;
+}
+
+static struct
+pingpong_dest *pp_server_exch_dest(struct pingpong_context *ctx, int ib_port,
+				   enum ibv_mtu mtu, int port, int sl,
+				   const struct pingpong_dest *my_dest,
+				   int sgid_idx)
+{
+	struct addrinfo *res, *t;
+	struct addrinfo hints = {
+		.ai_flags    = AI_PASSIVE,
+		.ai_family   = AF_UNSPEC,
+		.ai_socktype = SOCK_STREAM
+	};
+	char *service;
+	char msg[sizeof "0000:000000:000000:00000000000000000000000000000000"];
+	int n;
+	int sockfd = -1, connfd;
+	struct pingpong_dest *rem_dest = NULL;
+	char gid[33];
+
+	if (asprintf(&service, "%d", port) < 0)
+		return NULL;
+
+	n = getaddrinfo(NULL, service, &hints, &res);
+
+	if (n < 0) {
+		fprintf(stderr, "%s for port %d\n", gai_strerror(n), port);
+		free(service);
+		return NULL;
+	}
+
+	for (t = res; t; t = t->ai_next) {
+		sockfd = socket(t->ai_family, t->ai_socktype, t->ai_protocol);
+		if (sockfd >= 0) {
+			n = 1;
+
+			setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &n,
+				   sizeof(n));
+
+			if (!bind(sockfd, t->ai_addr, t->ai_addrlen))
+				break;
+			close(sockfd);
+			sockfd = -1;
+		}
+	}
+
+	freeaddrinfo(res);
+	free(service);
+
+	if (sockfd < 0) {
+		fprintf(stderr, "Couldn't listen to port %d\n", port);
+		return NULL;
+	}
+
+	listen(sockfd, 1);
+	connfd = accept(sockfd, NULL, 0);
+	close(sockfd);
+	if (connfd < 0) {
+		fprintf(stderr, "accept() failed\n");
+		return NULL;
+	}
+
+	n = read(connfd, msg, sizeof(msg));
+	if (n != sizeof(msg)) {
+		perror("server read");
+		fprintf(stderr, "%d/%d: Couldn't read remote address\n", n,
+			(int) sizeof(msg));
+		goto out;
+	}
+
+	rem_dest = malloc(sizeof(*rem_dest));
+	if (!rem_dest)
+		goto out;
+
+	sscanf(msg, "%x:%x:%x:%s", &rem_dest->lid, &rem_dest->qpn,
+	       &rem_dest->psn, gid);
+	wire_gid_to_gid(gid, &rem_dest->gid);
+
+	if (pp_connect_ctx(ctx, ib_port, my_dest->psn, mtu, sl, rem_dest,
+			   sgid_idx)) {
+		fprintf(stderr, "Couldn't connect to remote QP\n");
+		free(rem_dest);
+		rem_dest = NULL;
+		goto out;
+	}
+
+
+	gid_to_wire_gid(&my_dest->gid, gid);
+	sprintf(msg, "%04x:%06x:%06x:%s", my_dest->lid, my_dest->qpn,
+		my_dest->psn, gid);
+	if (write(connfd, msg, sizeof(msg)) != sizeof(msg)) {
+		fprintf(stderr, "Couldn't send local address\n");
+		free(rem_dest);
+		rem_dest = NULL;
+		goto out;
+	}
+
+	read(connfd, msg, sizeof(msg));
+
+out:
+	close(connfd);
+	return rem_dest;
+}
+
+static int pp_setup_shm(struct pingpong_context *ctx)
+{
+	ctx->shmid = shmget(ctx->key, ctx->shmsize, IPC_CREAT|IPC_EXCL|0666);
+	if (ctx->shmid == -1) {
+		fprintf(stderr, "shm with id %d already exists\n", ctx->key);
+		return 1;
+	}
+
+	ctx->shm = shmat(ctx->shmid, NULL, 0);
+	if (ctx->shm == (void *)-1) {
+		fprintf(stderr, "attach failed\n");
+		return 1;
+	}
+
+	ctx->shm->shmaddr = ctx->shm;
+
+	return 0;
+}
+
+static int pp_waitfor_shm(struct pingpong_context *ctx)
+{
+retry:
+	ctx->shmid = shmget(ctx->key, ctx->shmsize, 0666);
+	if (ctx->shmid == -1) {
+		sleep(1);
+		goto retry;
+	}
+	ctx->shm = shmat(ctx->shmid, NULL, 0);
+	if (ctx->shm == (void *)-1) {
+		fprintf(stderr, "attach failed\n");
+		return 1;
+	}
+
+	/* wait for status 2 */
+
+	while (ctx->shm->status == 0)
+		sleep(1);
+
+	if (ctx->shm->status == 1)
+		return 1;
+
+	return 0;
+}
+
+static int pp_delete_shm(struct pingpong_context *ctx)
+{
+	if (shmdt(ctx->shm)) {
+		fprintf(stderr, "Couldn't detach shm\n");
+		return 1;
+	}
+
+	if (ctx->is_server)
+		shmctl(ctx->shmid, IPC_RMID, 0);
+
+	return 0;
+}
+
+static int pp_share_context(struct pingpong_context *ctx)
+{
+	struct	 msghdr msg;
+	struct	 cmsghdr *cmsghdr;
+	char	 buf[CMSG_SPACE(sizeof(int))];
+	int	 ret, *fd, tmp;
+	struct	 iovec vec = {
+		.iov_base = &tmp,
+		.iov_len = sizeof(tmp),
+	};
+
+	memset(buf, 0, sizeof(buf));
+	cmsghdr = (struct cmsghdr *)buf;
+	cmsghdr->cmsg_len = CMSG_LEN(sizeof(int));
+	cmsghdr->cmsg_level = SOL_SOCKET;
+	cmsghdr->cmsg_type = SCM_RIGHTS;
+	msg.msg_name = NULL;
+	msg.msg_namelen = 0;
+	msg.msg_iov = &vec;
+	msg.msg_iovlen = 1;
+	msg.msg_control = cmsghdr;
+	msg.msg_controllen = CMSG_LEN(sizeof(int));
+	msg.msg_flags = 0;
+	fd = (int *)CMSG_DATA(cmsghdr);
+
+	if (ctx->is_server) {
+		*fd = ibv_context_to_fd(ctx->context);
+		ret = sendmsg(ctx->sock, &msg, 0);
+		if (ret < 0) {
+			fprintf(stderr, "Couldn't share fd. ret %d\n", ret);
+			return -1;
+		}
+	} else {
+		ret = recvmsg(ctx->sock, &msg, 0);
+		if (ret < 0) {
+			fprintf(stderr, "Couldn't shared fd. ret %d\n", ret);
+			return -1;
+		}
+		for (cmsghdr = CMSG_FIRSTHDR(&msg); cmsghdr != NULL;
+		     cmsghdr = CMSG_NXTHDR(&msg, cmsghdr)) {
+			if (cmsghdr->cmsg_level == SOL_SOCKET &&
+			    cmsghdr->cmsg_type == SCM_RIGHTS)
+				break;
+		}
+		if (!cmsghdr) {
+			fprintf(stderr, "Couldn't find cmsg\n");
+			return -1;
+		}
+		fd = (int *)CMSG_DATA(cmsghdr);
+
+		ctx->pd = ibv_import_pd(ctx->context, *fd, ctx->shm->shared_pd);
+		if (!ctx->pd) {
+			fprintf(stderr, "Couldn't import PD\n");
+			return -1;
+		}
+
+		ctx->mr = ibv_import_mr(ctx->context, *fd, ctx->shm->shared_mr);
+		if (!ctx->pd) {
+			fprintf(stderr, "Couldn't import MR\n");
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static int pp_open_unix_socket(int port, struct pingpong_context *ctx)
+{
+	struct sockaddr_un addr = {0};
+	int srv_sock;
+	int ret;
+
+	addr.sun_family = AF_LOCAL;
+
+	ret = snprintf(addr.sun_path, sizeof(addr.sun_path),
+		       "/tmp/shpd_pingpong.%d", port);
+	if (ret < 0 || ret >= sizeof(addr.sun_path)) {
+		fprintf(stderr, "Couldn't format unix socket name\n");
+		return -1;
+	}
+
+	if (ctx->is_server) {
+		unlink(addr.sun_path);
+
+		srv_sock = socket(PF_LOCAL, SOCK_STREAM, 0);
+		if (srv_sock < 0) {
+			perror("Couldn't create unix socket");
+			return -1;
+		}
+		ret = bind(srv_sock, (struct sockaddr *)&addr, sizeof(addr));
+		if (ret < 0) {
+			perror("Couldn't bind unix socket");
+			return -1;
+		}
+		ret = listen(srv_sock, 1);
+		if (ret < 0) {
+			perror("Couldn't listen on unix socket");
+			return -1;
+		}
+		ctx->sock = accept(srv_sock, NULL, 0);
+		if (ctx->sock < 0) {
+			perror("Couldn't accept on unix socket");
+			return -1;
+		}
+	} else {
+		ctx->sock = socket(PF_LOCAL, SOCK_STREAM, 0);
+		if (ctx->sock < 0) {
+			perror("Couldn't create unix socket");
+			return -1;
+		}
+		ret = connect(ctx->sock, (struct sockaddr *)&addr,
+			      sizeof(addr));
+		if (ret < 0) {
+			perror("Couldn't connect unix socket");
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static struct pingpong_context *pp_init_ctx(struct ibv_device *ib_dev,
+					    int size, int rx_depth,
+					    int ib_port, int use_event,
+					    key_t key, int is_server,
+					    int port)
+{
+	struct pingpong_context *ctx;
+
+	ctx = calloc(1, sizeof(*ctx));
+	if (!ctx)
+		return NULL;
+
+	ctx->size     = size;
+	ctx->rx_depth = rx_depth;
+	ctx->is_server = is_server;
+	ctx->key = key;
+	ctx->shmsize = sizeof(*(ctx->shm)) + ctx->size * 2 + page_size * 2;
+	ctx->shmoffset = 0;
+
+	ctx->context = ibv_open_device(ib_dev);
+	if (!ctx->context) {
+		fprintf(stderr, "Couldn't get context for %s\n",
+			ibv_get_device_name(ib_dev));
+		return NULL;
+	}
+
+	if (use_event) {
+		ctx->channel = ibv_create_comp_channel(ctx->context);
+		if (!ctx->channel) {
+			fprintf(stderr, "Couldn't create completion channel\n");
+			goto err;
+		}
+	} else
+		ctx->channel = NULL;
+
+	if (is_server) {
+		if (pp_setup_shm(ctx))
+			goto err;
+
+		ctx->pd = ibv_alloc_pd(ctx->context);
+		if (!ctx->pd) {
+			fprintf(stderr, "Couldn't allocate PD\n");
+			goto err;
+		}
+
+		ctx->shm->shared_pd = ibv_pd_to_handle(ctx->pd);
+
+#define PAGE_ALIGN(addr, page) (uintptr_t)(((uintptr_t)addr + page - 1) \
+					 & ~(page - 1))
+
+		/* use shared memory are as buffer */
+		ctx->buf = (char *)PAGE_ALIGN(ctx->shm->buf, page_size);
+
+		ctx->mr = ibv_reg_mr(ctx->pd, ctx->shm, ctx->shmsize,
+				     IBV_ACCESS_LOCAL_WRITE);
+		if (!ctx->mr) {
+			fprintf(stderr, "Couldn't register MR\n");
+			ctx->shm->status = 1;
+			goto err;
+		}
+
+		ctx->shm->shared_mr = ibv_mr_to_handle(ctx->mr);
+
+		/* all details initialized ready to go */
+		ctx->shm->status = 2;
+	} else {
+		if (pp_waitfor_shm(ctx)) {
+			fprintf(stderr, "Couldn't get shm working\n");
+			goto err;
+		}
+
+		/* The memory address at which shm is mapped in the client
+		 * may not be same as that in server. All WR to HCA should
+		 * give local VA's w.r.t server's shared memory address
+		 */
+		ctx->shmoffset = (uintptr_t)(ctx->shm->shmaddr) -
+				 (uintptr_t)ctx->shm;
+		ctx->buf = (char *)PAGE_ALIGN(ctx->shm->buf, page_size) +
+			   PAGE_ALIGN(size, page_size);
+	}
+
+	memset(ctx->buf, 0x7b + is_server, size);
+
+	ctx->cq = ibv_create_cq(ctx->context, rx_depth + 1, NULL,
+				ctx->channel, 0);
+	if (!ctx->cq) {
+		fprintf(stderr, "Couldn't create CQ\n");
+		goto err;
+	}
+
+	if (pp_open_unix_socket(port, ctx)) {
+		fprintf(stderr, "Couldn't open UNIX socket\n");
+		goto err;
+	}
+
+	if (pp_share_context(ctx)) {
+		fprintf(stderr, "Couldn't share PD\n");
+		goto err;
+	}
+
+	{
+		struct ibv_qp_init_attr attr = {
+			.send_cq = ctx->cq,
+			.recv_cq = ctx->cq,
+			.cap     = {
+				.max_send_wr  = 1,
+				.max_recv_wr  = rx_depth,
+				.max_send_sge = 1,
+				.max_recv_sge = 1
+			},
+			.qp_type = IBV_QPT_RC
+		};
+
+		ctx->qp = ibv_create_qp(ctx->pd, &attr);
+		if (!ctx->qp)  {
+			fprintf(stderr, "Couldn't create QP\n");
+			goto err;
+		}
+	}
+
+	{
+		struct ibv_qp_attr attr = {
+			.qp_state        = IBV_QPS_INIT,
+			.pkey_index      = 0,
+			.port_num        = ib_port,
+			.qp_access_flags = 0
+		};
+
+		if (ibv_modify_qp(ctx->qp, &attr,
+				  IBV_QP_STATE              |
+				  IBV_QP_PKEY_INDEX         |
+				  IBV_QP_PORT               |
+				  IBV_QP_ACCESS_FLAGS)) {
+			fprintf(stderr, "Failed to modify QP to INIT\n");
+			goto err;
+		}
+	}
+
+	return ctx;
+
+err:
+	if (ctx->qp)
+		ibv_destroy_qp(ctx->qp);
+	if (ctx->cq)
+		ibv_destroy_cq(ctx->cq);
+	if (ctx->mr)
+		ibv_dereg_mr(ctx->mr);
+	if (ctx->pd)
+		ibv_dealloc_pd(ctx->pd);
+	if (ctx->channel)
+		ibv_destroy_comp_channel(ctx->channel);
+	if (ctx->context)
+		ibv_close_device(ctx->context);
+
+	free(ctx);
+
+	return NULL;
+}
+
+static int pp_close_ctx(struct pingpong_context *ctx)
+{
+	if (pp_delete_shm(ctx)) {
+		fprintf(stderr, "couldn't destroy shared memory\n");
+		return 1;
+	}
+
+	if (ctx->channel) {
+		if (ibv_destroy_comp_channel(ctx->channel)) {
+			fprintf(stderr,
+				"Couldn't destroy completion channel\n");
+			return 1;
+		}
+	}
+
+	if (ibv_destroy_qp(ctx->qp)) {
+		fprintf(stderr, "Couldn't destroy QP\n");
+		return 1;
+	}
+
+	if (ibv_destroy_cq(ctx->cq)) {
+		fprintf(stderr, "Couldn't destroy CQ\n");
+		return 1;
+	}
+
+	if (ibv_dereg_mr(ctx->mr)) {
+		fprintf(stderr, "Couldn't deregister MR\n");
+		return 1;
+	}
+
+	if (ibv_dealloc_pd(ctx->pd)) {
+		fprintf(stderr, "Couldn't deallocate PD\n");
+		return 1;
+	}
+
+	if (ibv_close_device(ctx->context)) {
+		fprintf(stderr, "Couldn't release context\n");
+		return 1;
+	}
+
+	free(ctx);
+
+	return 0;
+}
+
+static int pp_post_recv(struct pingpong_context *ctx, int n)
+{
+	struct ibv_sge list = {
+		.addr	= (uintptr_t) ctx->buf + ctx->shmoffset,
+		.length = ctx->size,
+		.lkey	= ctx->mr->lkey
+	};
+	struct ibv_recv_wr wr = {
+		.wr_id	    = PINGPONG_RECV_WRID,
+		.sg_list    = &list,
+		.num_sge    = 1,
+	};
+	struct ibv_recv_wr *bad_wr;
+	int i;
+
+	for (i = 0; i < n; ++i)
+		if (ibv_post_recv(ctx->qp, &wr, &bad_wr))
+			break;
+
+	return i;
+}
+
+static int pp_post_send(struct pingpong_context *ctx)
+{
+	struct ibv_sge list = {
+		.addr	= (uintptr_t) ctx->buf + ctx->shmoffset,
+		.length = ctx->size,
+		.lkey	= ctx->mr->lkey
+	};
+	struct ibv_send_wr wr = {
+		.wr_id	    = PINGPONG_SEND_WRID,
+		.sg_list    = &list,
+		.num_sge    = 1,
+		.opcode     = IBV_WR_SEND,
+		.send_flags = IBV_SEND_SIGNALED,
+	};
+	struct ibv_send_wr *bad_wr;
+
+	return ibv_post_send(ctx->qp, &wr, &bad_wr);
+}
+
+static void usage(const char *argv0)
+{
+	printf("Usage:\n");
+	printf("  %s            start a server and wait for connection\n",
+	       argv0);
+	printf("  %s <host>     connect to server at <host>\n", argv0);
+	printf("\n");
+	printf("Options:\n");
+	printf("  -p, --port=<port>      listen on/connect to port <port> (default 18515)\n");
+	printf("  -d, --ib-dev=<dev>     use IB device <dev> (default first device found)\n");
+	printf("  -i, --ib-port=<port>   use port <port> of IB device (default 1)\n");
+	printf("  -s, --size=<size>      size of message to exchange (default 4096)\n");
+	printf("  -m, --mtu=<size>       path MTU (default 1024)\n");
+	printf("  -r, --rx-depth=<dep>   number of receives to post at a time (default 500)\n");
+	printf("  -n, --iters=<iters>    number of exchanges (default 1000)\n");
+	printf("  -l, --sl=<sl>          service level value\n");
+	printf("  -e, --events           sleep on CQ events (default poll)\n");
+	printf("  -g, --gid-idx=<gid index> local port gid index\n");
+	printf("  -S, --shm-key=<shm key> shared memory key for the test (default 18515)\n");
+}
+
+int main(int argc, char *argv[])
+{
+	struct pingpong_context *ctx;
+	struct ibv_device      **dev_list;
+	struct ibv_device	*ib_dev;
+	struct pingpong_dest     my_dest;
+	struct pingpong_dest    *rem_dest = NULL;
+	struct timeval           start, end;
+	char                    *ib_devname = NULL;
+	char                    *servername = NULL;
+	int                      port = 18515;
+	int                      ib_port = 1;
+	int                      size = 4096;
+	enum ibv_mtu		 mtu = IBV_MTU_1024;
+	int                      rx_depth = 500;
+	int                      iters = 1000;
+	int                      use_event = 0;
+	int                      routs;
+	int                      rcnt, scnt;
+	int                      num_cq_events = 0;
+	int                      sl = 0;
+	int			 gidx = -1;
+	char			 gid[33];
+	key_t			 key = 18515;
+
+	srand48(getpid() * time(NULL));
+
+	while (1) {
+		int c;
+
+		static struct option long_options[] = {
+			{ .name = "port",     .has_arg = 1, .val = 'p' },
+			{ .name = "ib-dev",   .has_arg = 1, .val = 'd' },
+			{ .name = "ib-port",  .has_arg = 1, .val = 'i' },
+			{ .name = "size",     .has_arg = 1, .val = 's' },
+			{ .name = "mtu",      .has_arg = 1, .val = 'm' },
+			{ .name = "rx-depth", .has_arg = 1, .val = 'r' },
+			{ .name = "iters",    .has_arg = 1, .val = 'n' },
+			{ .name = "sl",       .has_arg = 1, .val = 'l' },
+			{ .name = "events",   .has_arg = 0, .val = 'e' },
+			{ .name = "gid-idx",  .has_arg = 1, .val = 'g' },
+			{ .name = "shm-key",  .has_arg = 1, .val = 'S' },
+			{ 0 }
+		};
+
+		c = getopt_long(argc, argv, "p:d:i:s:m:r:n:l:eg:S:",
+				long_options, NULL);
+		if (c == -1)
+			break;
+
+		switch (c) {
+		case 'p':
+			port = strtol(optarg, NULL, 0);
+			if (port < 0 || port > 65535) {
+				usage(argv[0]);
+				return 1;
+			}
+			break;
+
+		case 'd':
+			ib_devname = strdupa(optarg);
+			break;
+
+		case 'i':
+			ib_port = strtol(optarg, NULL, 0);
+			if (ib_port < 0) {
+				usage(argv[0]);
+				return 1;
+			}
+			break;
+
+		case 's':
+			size = strtol(optarg, NULL, 0);
+			break;
+
+		case 'm':
+			mtu = pp_mtu_to_enum(strtol(optarg, NULL, 0));
+			break;
+
+		case 'r':
+			rx_depth = strtol(optarg, NULL, 0);
+			break;
+
+		case 'n':
+			iters = strtol(optarg, NULL, 0);
+			break;
+
+		case 'l':
+			sl = strtol(optarg, NULL, 0);
+			break;
+
+		case 'e':
+			++use_event;
+			break;
+
+		case 'g':
+			gidx = strtol(optarg, NULL, 0);
+			break;
+
+		case 'S':
+			key = strtol(optarg, NULL, 0);
+			break;
+
+		default:
+			usage(argv[0]);
+			return 1;
+		}
+	}
+
+	if (optind == argc - 1)
+		servername = strdupa(argv[optind]);
+	else if (optind < argc) {
+		usage(argv[0]);
+		return 1;
+	}
+
+	page_size = sysconf(_SC_PAGESIZE);
+
+	dev_list = ibv_get_device_list(NULL);
+	if (!dev_list) {
+		perror("Failed to get IB devices list");
+		return 1;
+	}
+
+	if (!ib_devname) {
+		ib_dev = *dev_list;
+		if (!ib_dev) {
+			fprintf(stderr, "No IB devices found\n");
+			goto err_dev_list;
+		}
+	} else {
+		int i;
+
+		for (i = 0; dev_list[i]; ++i)
+			if (!strcmp(ibv_get_device_name(dev_list[i]),
+				    ib_devname))
+				break;
+		ib_dev = dev_list[i];
+		if (!ib_dev) {
+			fprintf(stderr, "IB device %s not found\n", ib_devname);
+			goto err_dev_list;
+		}
+	}
+
+	ctx = pp_init_ctx(ib_dev, size, rx_depth, ib_port, use_event, key,
+			  !servername, port);
+	if (!ctx)
+		goto err_dev_list;
+
+	routs = pp_post_recv(ctx, ctx->rx_depth);
+	if (routs < ctx->rx_depth) {
+		fprintf(stderr, "Couldn't post receive (%d)\n", routs);
+		goto err_ctx;
+	}
+
+	if (use_event)
+		if (ibv_req_notify_cq(ctx->cq, 0)) {
+			fprintf(stderr, "Couldn't request CQ notification\n");
+			goto err_ctx;
+		}
+
+
+	if (pp_get_port_info(ctx->context, ib_port, &ctx->portinfo)) {
+		fprintf(stderr, "Couldn't get port info\n");
+		goto err_ctx;
+	}
+
+	my_dest.lid = ctx->portinfo.lid;
+	if (ctx->portinfo.link_layer == IBV_LINK_LAYER_INFINIBAND &&
+	    !my_dest.lid) {
+		fprintf(stderr, "Couldn't get local LID\n");
+		goto err_ctx;
+	}
+
+	if (gidx >= 0) {
+		if (ibv_query_gid(ctx->context, ib_port, gidx, &my_dest.gid)) {
+			fprintf(stderr,
+				"Could not get local gid for gid index %d\n",
+				gidx);
+			goto err_ctx;
+		}
+	} else
+		memset(&my_dest.gid, 0, sizeof(my_dest.gid));
+
+	my_dest.qpn = ctx->qp->qp_num;
+	my_dest.psn = lrand48() & 0xffffff;
+	inet_ntop(AF_INET6, &my_dest.gid, gid, sizeof(gid));
+	printf("  local address:  LID 0x%04x, QPN 0x%06x, PSN 0x%06x, GID %s\n",
+	       my_dest.lid, my_dest.qpn, my_dest.psn, gid);
+
+	if (servername)
+		rem_dest = pp_client_exch_dest(servername, port, &my_dest);
+	else
+		rem_dest = pp_server_exch_dest(ctx, ib_port, mtu, port, sl,
+					       &my_dest, gidx);
+
+	if (!rem_dest)
+		goto err_ctx;
+
+	inet_ntop(AF_INET6, &rem_dest->gid, gid, sizeof(gid));
+	printf("  remote address: LID 0x%04x, QPN 0x%06x, PSN 0x%06x, GID %s\n",
+	       rem_dest->lid, rem_dest->qpn, rem_dest->psn, gid);
+
+	if (servername)
+		if (pp_connect_ctx(ctx, ib_port, my_dest.psn, mtu, sl, rem_dest,
+				   gidx))
+			goto err_rem_dest;
+
+	ctx->pending = PINGPONG_RECV_WRID;
+
+	if (servername) {
+		if (pp_post_send(ctx)) {
+			fprintf(stderr, "Couldn't post send\n");
+			goto err_rem_dest;
+		}
+		ctx->pending |= PINGPONG_SEND_WRID;
+	}
+
+	if (gettimeofday(&start, NULL)) {
+		perror("gettimeofday");
+		goto err_rem_dest;
+	}
+
+	rcnt = scnt = 0;
+	while (rcnt < iters || scnt < iters) {
+		if (use_event) {
+			struct ibv_cq *ev_cq;
+			void          *ev_ctx;
+
+			if (ibv_get_cq_event(ctx->channel, &ev_cq, &ev_ctx)) {
+				fprintf(stderr, "Failed to get cq_event\n");
+				goto err_rem_dest;
+			}
+
+			++num_cq_events;
+
+			if (ev_cq != ctx->cq) {
+				fprintf(stderr, "CQ event for unknown CQ %p\n",
+					ev_cq);
+				goto err_rem_dest;
+			}
+
+			if (ibv_req_notify_cq(ctx->cq, 0)) {
+				fprintf(stderr,
+					"Couldn't request CQ notification\n");
+				goto err_rem_dest;
+			}
+		}
+
+		{
+			struct ibv_wc wc[2];
+			int ne, i;
+
+			do {
+				ne = ibv_poll_cq(ctx->cq, 2, wc);
+				if (ne < 0) {
+					fprintf(stderr, "poll CQ failed %d\n",
+						ne);
+					goto err_rem_dest;
+				}
+
+			} while (!use_event && ne < 1);
+
+			for (i = 0; i < ne; ++i) {
+				if (wc[i].status != IBV_WC_SUCCESS) {
+					fprintf(stderr,
+						"Failed status %s (%d) for wr_id %d\n",
+						ibv_wc_status_str(wc[i].status),
+						wc[i].status,
+						(int) wc[i].wr_id);
+					goto err_rem_dest;
+				}
+
+				switch ((int) wc[i].wr_id) {
+				case PINGPONG_SEND_WRID:
+					++scnt;
+					break;
+
+				case PINGPONG_RECV_WRID:
+					if (--routs <= 1) {
+						routs += pp_post_recv(ctx,
+								ctx->rx_depth -
+								routs);
+						if (routs < ctx->rx_depth) {
+							fprintf(stderr,
+								"Couldn't post receive (%d)\n",
+								routs);
+							goto err_rem_dest;
+						}
+					}
+
+					++rcnt;
+					break;
+
+				default:
+					fprintf(stderr,
+						"Completion for unknown wr_id %d\n",
+						(int) wc[i].wr_id);
+					goto err_rem_dest;
+				}
+
+				ctx->pending &= ~(int) wc[i].wr_id;
+				if (scnt < iters && !ctx->pending) {
+					if (pp_post_send(ctx)) {
+						fprintf(stderr,
+							"Couldn't post send\n");
+						goto err_rem_dest;
+					}
+					ctx->pending = PINGPONG_RECV_WRID |
+						       PINGPONG_SEND_WRID;
+				}
+			}
+		}
+	}
+
+	if (gettimeofday(&end, NULL)) {
+		perror("gettimeofday");
+		goto err_rem_dest;
+	}
+
+	{
+		float usec = (end.tv_sec - start.tv_sec) * 1000000 +
+			(end.tv_usec - start.tv_usec);
+		long long bytes = (long long) size * iters * 2;
+
+		printf("%lld bytes in %.2f seconds = %.2f Mbit/sec\n",
+		       bytes, usec / 1000000., bytes * 8. / usec);
+		printf("%d iters in %.2f seconds = %.2f usec/iter\n",
+		       iters, usec / 1000000., usec / iters);
+	}
+
+	ibv_ack_cq_events(ctx->cq, num_cq_events);
+
+	if (pp_close_ctx(ctx))
+		fprintf(stderr, "Couldn't close context\n");
+
+	ibv_free_device_list(dev_list);
+	free(rem_dest);
+
+	return 0;
+
+err_rem_dest:
+	free(rem_dest);
+
+err_ctx:
+	pp_close_ctx(ctx);
+
+err_dev_list:
+	ibv_free_device_list(dev_list);
+
+	return 1;
+}
-- 
2.20.1

