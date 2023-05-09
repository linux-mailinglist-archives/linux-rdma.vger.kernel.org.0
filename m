Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EDB6FC337
	for <lists+linux-rdma@lfdr.de>; Tue,  9 May 2023 11:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbjEIJvF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 May 2023 05:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbjEIJu4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 May 2023 05:50:56 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71814D9
        for <linux-rdma@vger.kernel.org>; Tue,  9 May 2023 02:50:53 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f315712406so200894285e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 09 May 2023 02:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683625852; x=1686217852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/vKrliSe2wdxq+f/rTuZKOiAboDha73w0MmDxnqvDd8=;
        b=CIJsz6llTfm3bPkAl3mLO2UMb9zo3nqOT1j6Ab1LYPxkAHA4NWN2N8fxDelWUYt+Sa
         1uwJjJrcvv1UV+eSL0A9un1NsRyJzL+P8TQnmSjMPuKgFcjQG+sXzujfHXbdIRousNld
         BSmr2u9jF1nS+E+MxbkULJci1MehpM9ExUJxC3R27ez2fCMdlOgmF7oYcO8x3b4Bj6Qy
         Lkf48xisopC/bPcAVXFXMmMlhCkxz2/Banbnw1J8a9CBrVH+FEPoWzSVbN8XvVMDCwuk
         kH7VY3ZVoKATkS2iI6EsgRjqtwIy+fCVg3URnCa0Iad52YEFPjKoNUcVJUF8yt+mDltw
         R+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683625852; x=1686217852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vKrliSe2wdxq+f/rTuZKOiAboDha73w0MmDxnqvDd8=;
        b=jUTjeT879e9oLOZvysCws8aFb7n15Bj1iQV8oPO7DnjdNQBhpc2jI75LpxwJ+htVO8
         hqHRyuQTsplwEpThXKPUr+lkQujBnrDDhpDRJORKmnOgycvqFs8Sy/cUUyJ/RUjUrEBZ
         V+m1mBhr+0WH04obqZh+uFjT8lLTjLnASaQAXVp9yUYqdDERZoNiwE6DXL1fhzqrMp5o
         bgisVaTsPTtJetRkIaJp7BL/MwRBTa8TvnctWkOMzGny6vy08S2Bdu2mHkg/eUG4jbUu
         chaX+d8rpAwvp8lMkJLkjZm7OZ189er3XWx41s2fGenthrY7QKYQdCQHZkea/rNYr/em
         Q2sQ==
X-Gm-Message-State: AC+VfDyce0D8E4zILqHBwyOARBnAVyeUB4yIk6vjLsnAKsHGXnkh4eNo
        4WTnwGfyy3PIdaQtF+lLx4XC2IBZE9MCCXpWtFw=
X-Google-Smtp-Source: ACHHUZ6MwMhNrYGORX4XpKfbIhG3TTNZOXaJxcB1H2hp4n1SNaryvJvKtD+EbUkHSkOeN0DCaCZXcw==
X-Received: by 2002:a5d:680e:0:b0:307:9693:efe1 with SMTP id w14-20020a5d680e000000b003079693efe1mr4383878wru.18.1683625851469;
        Tue, 09 May 2023 02:50:51 -0700 (PDT)
Received: from akishore-vm-u20.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c0b5600b003f40049a65bsm18157312wmr.21.2023.05.09.02.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 02:50:51 -0700 (PDT)
From:   Animesh Kishore <animesh.kishore@gmail.com>
To:     yishaih@dev.mellanox.co.il
Cc:     linux-rdma@vger.kernel.org,
        Animesh Kishore <animesh.kishore@gmail.com>
Subject: [PATCH] verbs: Add RDMA write RC pingpong test
Date:   Tue,  9 May 2023 12:50:16 +0300
Message-Id: <20230509095016.112453-1-animesh.kishore@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

- The test pingpongs data between server and client
instance using RC QPs with RDMA write BTH opcode.
- For RDMA write, there's no completion at responder. Hence,
we send a sideband ACK(using socket) from requester side
on completion. This indicates to responder that it has
received data.

Check available test arguments and help:
./build/bin/ibv_rc_wr_pingpong -h

e.g.
Run server instance:
./build/bin/ibv_rc_wr_pingpong -g 0 -d <ib_dev> -c -s 8192

Run client instance:
./build/bin/ibv_rc_wr_pingpong -g 0 -d <ib_dev> -c -s 8192 <server IP>

Signed-off-by: Animesh Kishore <animesh.kishore@gmail.com>
---
 debian/ibverbs-utils.install         |   2 +
 libibverbs/examples/CMakeLists.txt   |   3 +
 libibverbs/examples/rc_wr_pingpong.c | 782 +++++++++++++++++++++++++++
 libibverbs/man/CMakeLists.txt        |   1 +
 libibverbs/man/ibv_rc_wr_pingpong.1  |  63 +++
 5 files changed, 851 insertions(+)
 create mode 100644 libibverbs/examples/rc_wr_pingpong.c
 create mode 100644 libibverbs/man/ibv_rc_wr_pingpong.1

diff --git a/debian/ibverbs-utils.install b/debian/ibverbs-utils.install
index 170b8d26..3d77aa0f 100644
--- a/debian/ibverbs-utils.install
+++ b/debian/ibverbs-utils.install
@@ -2,6 +2,7 @@ usr/bin/ibv_asyncwatch
 usr/bin/ibv_devices
 usr/bin/ibv_devinfo
 usr/bin/ibv_rc_pingpong
+usr/bin/ibv_rc_wr_pingpong
 usr/bin/ibv_srq_pingpong
 usr/bin/ibv_uc_pingpong
 usr/bin/ibv_ud_pingpong
@@ -10,6 +11,7 @@ usr/share/man/man1/ibv_asyncwatch.1
 usr/share/man/man1/ibv_devices.1
 usr/share/man/man1/ibv_devinfo.1
 usr/share/man/man1/ibv_rc_pingpong.1
+usr/share/man/man1/ibv_rc_wr_pingpong.1
 usr/share/man/man1/ibv_srq_pingpong.1
 usr/share/man/man1/ibv_uc_pingpong.1
 usr/share/man/man1/ibv_ud_pingpong.1
diff --git a/libibverbs/examples/CMakeLists.txt b/libibverbs/examples/CMakeLists.txt
index dc4c4978..031faf0e 100644
--- a/libibverbs/examples/CMakeLists.txt
+++ b/libibverbs/examples/CMakeLists.txt
@@ -26,3 +26,6 @@ target_link_libraries(ibv_ud_pingpong LINK_PRIVATE ibverbs ibverbs_tools)
 
 rdma_executable(ibv_xsrq_pingpong xsrq_pingpong.c)
 target_link_libraries(ibv_xsrq_pingpong LINK_PRIVATE ibverbs ibverbs_tools)
+
+rdma_executable(ibv_rc_wr_pingpong rc_wr_pingpong.c)
+target_link_libraries(ibv_rc_wr_pingpong LINK_PRIVATE ibverbs ibverbs_tools)
diff --git a/libibverbs/examples/rc_wr_pingpong.c b/libibverbs/examples/rc_wr_pingpong.c
new file mode 100644
index 00000000..e6df96d5
--- /dev/null
+++ b/libibverbs/examples/rc_wr_pingpong.c
@@ -0,0 +1,782 @@
+// SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+/*
+ * Copyright (c) 2005 Topspin Communications.  All rights reserved.
+ */
+
+#define _GNU_SOURCE
+#include <config.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/time.h>
+#include <netdb.h>
+#include <malloc.h>
+#include <getopt.h>
+#include <arpa/inet.h>
+#include <time.h>
+#include <inttypes.h>
+#include <fcntl.h>
+
+#include "pingpong.h"
+
+#define EXCH_MSG "00000000:0000000000000000:0000:000000:000000:00000000000000000000000000000000"
+
+static int page_size;
+static int validate_buf;
+
+enum {
+	PINGPONG_RECV_WRID = 1,
+	PINGPONG_SEND_WRID = 2,
+};
+
+struct pingpong_context {
+	struct ibv_context	*context;
+	struct ibv_comp_channel *channel;
+	struct ibv_pd		*pd;
+	struct ibv_mr		*mr;
+	struct ibv_cq		*cq;
+	struct ibv_qp		*qp;
+	struct ibv_port_attr     portinfo;
+	char			*buf;
+	int			 size;
+	int			 rx_depth;
+	int			 conn_fd;
+	int			 pending;
+};
+
+struct pingpong_dest {
+	union ibv_gid		 gid;
+	uintptr_t		 addr;
+	uint32_t		 rkey;
+	int			 lid;
+	int			 qpn;
+	int			 psn;
+};
+
+static void usage(const char *argv0)
+{
+	printf("Usage:\n");
+	printf("  %s            run a basic hlib test\n", argv0);
+	printf("\n");
+	printf("Options:\n");
+	printf("  -d, --ib-dev=<dev>        use IB device <dev> (default first device found)\n");
+	printf("  -i, --ib-port=<port>      use port <port> of IB device (default 1)\n");
+	printf("  -s, --size=<size>         size of message to exchange (default 4096)\n");
+	printf("  -g, --gid-idx=<gid index> local port gid index\n");
+	printf("  -c, --chk                 validate received buffer\n");
+	printf("  -n, --iters=<iters>       number of exchanges (default 1000)\n");
+	printf("  -h, --help                display options\n");
+}
+
+static struct pingpong_context *pp_init_ctx(struct ibv_device *ib_dev, int size,
+					    int rx_depth, int port)
+{
+	struct pingpong_context *ctx;
+
+	ctx = calloc(1, sizeof(*ctx));
+	if (!ctx)
+		return NULL;
+
+	ctx->size       = size;
+	ctx->rx_depth   = rx_depth;
+
+	ctx->buf = memalign(page_size, size);
+	if (!ctx->buf) {
+		fprintf(stderr, "Couldn't allocate work buf.\n");
+		goto clean_ctx;
+	}
+
+	/* FIXME memset(ctx->buf, 0, size); */
+	memset(ctx->buf, 0x7b, size);
+
+	ctx->context = ibv_open_device(ib_dev);
+	if (!ctx->context) {
+		fprintf(stderr, "Couldn't get context for %s\n",
+			ibv_get_device_name(ib_dev));
+		goto clean_buffer;
+	}
+
+	ctx->pd = ibv_alloc_pd(ctx->context);
+	if (!ctx->pd) {
+		fprintf(stderr, "Couldn't allocate PD\n");
+		goto clean_device;
+	}
+
+	ctx->mr = ibv_reg_mr(ctx->pd, ctx->buf, size,
+				IBV_ACCESS_LOCAL_WRITE | IBV_ACCESS_REMOTE_WRITE);
+	if (!ctx->mr) {
+		fprintf(stderr, "Couldn't register MR\n");
+		goto clean_pd;
+	}
+
+	ctx->cq = ibv_create_cq(ctx->context, rx_depth + 1, NULL, NULL, 0);
+	if (!ctx->cq) {
+		fprintf(stderr, "Couldn't create CQ\n");
+		goto clean_mr;
+	}
+
+	{
+		struct ibv_qp_init_attr init_attr = {
+			.send_cq = ctx->cq,
+			.recv_cq = ctx->cq,
+			.cap     = {
+				.max_send_wr  = 1,
+				.max_send_sge = 1,
+				.max_recv_wr = 0,
+				.max_recv_sge = 1
+			},
+			.qp_type = IBV_QPT_RC
+		};
+
+		ctx->qp = ibv_create_qp(ctx->pd, &init_attr);
+		if (!ctx->qp)  {
+			fprintf(stderr, "Couldn't create QP\n");
+			goto clean_cq;
+		}
+	}
+
+	{
+		struct ibv_qp_attr attr = {
+			.qp_state        = IBV_QPS_INIT,
+			.pkey_index      = 0,
+			.port_num        = port,
+			.qp_access_flags = IBV_ACCESS_REMOTE_WRITE,
+		};
+
+		if (ibv_modify_qp(ctx->qp, &attr,
+				  IBV_QP_STATE              |
+				  IBV_QP_PKEY_INDEX         |
+				  IBV_QP_PORT               |
+				  IBV_QP_ACCESS_FLAGS)) {
+			fprintf(stderr, "Failed to modify QP to INIT\n");
+			goto clean_qp;
+		}
+	}
+
+	return ctx;
+
+clean_qp:
+	ibv_destroy_qp(ctx->qp);
+
+clean_cq:
+	ibv_destroy_cq(ctx->cq);
+
+clean_mr:
+	ibv_dereg_mr(ctx->mr);
+
+clean_pd:
+	ibv_dealloc_pd(ctx->pd);
+
+clean_device:
+	ibv_close_device(ctx->context);
+
+clean_buffer:
+	free(ctx->buf);
+
+clean_ctx:
+	free(ctx);
+
+	return NULL;
+}
+
+static int pp_close_ctx(struct pingpong_context *ctx)
+{
+	if (ctx->qp && ibv_destroy_qp(ctx->qp)) {
+		fprintf(stderr, "Couldn't destroy QP\n");
+		return 1;
+	}
+
+	if (ctx->cq && ibv_destroy_cq(ctx->cq)) {
+		fprintf(stderr, "Couldn't destroy CQ\n");
+		return 1;
+	}
+
+	if (ctx->mr && ibv_dereg_mr(ctx->mr)) {
+		fprintf(stderr, "Couldn't deregister MR\n");
+		return 1;
+	}
+
+	if (ctx->pd && ibv_dealloc_pd(ctx->pd)) {
+		fprintf(stderr, "Couldn't deallocate PD\n");
+		return 1;
+	}
+
+	if (ctx->context && ibv_close_device(ctx->context)) {
+		fprintf(stderr, "Couldn't release context\n");
+		return 1;
+	}
+
+	free(ctx->buf);
+	free(ctx);
+
+	return 0;
+}
+
+static int pp_connect_ctx(struct pingpong_context *ctx, int port, int my_psn,
+			  struct pingpong_dest *dest, int sgid_idx)
+{
+	struct ibv_qp_attr attr = {
+		.qp_state		= IBV_QPS_RTR,
+		.path_mtu		= IBV_MTU_1024,
+		.dest_qp_num		= dest->qpn,
+		.rq_psn			= dest->psn,
+		.max_dest_rd_atomic	= 1,
+		.min_rnr_timer		= 12,
+		.ah_attr		= {
+			.is_global	= 0,
+			.dlid		= dest->lid,
+			.sl		= 0,
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
+
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
+static struct pingpong_dest *pp_client_exch_dest(struct pingpong_context *ctx,
+						 const char *servername, int port,
+						 const struct pingpong_dest *my_dest)
+{
+	struct addrinfo *res, *t;
+	struct addrinfo hints = {
+		.ai_family   = AF_UNSPEC,
+		.ai_socktype = SOCK_STREAM
+	};
+	struct pingpong_dest *rem_dest = NULL;
+	char *service;
+	int n;
+	int sockfd = -1;
+	char gid[33];
+	char msg[sizeof(EXCH_MSG)];
+
+	if (asprintf(&service, "%d", port) < 0)
+		return NULL;
+
+	n = getaddrinfo(servername, service, &hints, &res);
+	if (n < 0) {
+		fprintf(stderr, "%s for %s:%d\n", gai_strerror(n), servername, port);
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
+		fprintf(stderr, "Couldn't connect to %s:%d\n", servername, port);
+		return NULL;
+	}
+
+	gid_to_wire_gid(&my_dest->gid, gid);
+	sprintf(msg, "%08x:%016" PRIxPTR ":%04x:%06x:%06x:%s", my_dest->rkey, my_dest->addr,
+							       my_dest->lid, my_dest->qpn,
+							       my_dest->psn, gid);
+	if (write(sockfd, msg, sizeof(msg)) != sizeof(msg)) {
+		fprintf(stderr, "Couldn't send local address\n");
+		goto out;
+	}
+
+	if (read(sockfd, msg, sizeof(msg)) != sizeof(msg) ||
+	    write(sockfd, "done", sizeof "done") != sizeof "done") {
+		perror("client read/write");
+		fprintf(stderr, "Couldn't read/write remote address\n");
+		goto out;
+	}
+
+	rem_dest = malloc(sizeof(*rem_dest));
+	if (!rem_dest)
+		goto out;
+
+	n = sscanf(msg, "%x:%" SCNxPTR ":%x:%x:%x:%s", &rem_dest->rkey, &rem_dest->addr,
+						       &rem_dest->lid, &rem_dest->qpn,
+						       &rem_dest->psn, gid);
+	if (n != 6) {
+		fprintf(stderr, "Couldn't parse server data\n");
+		free(rem_dest);
+		rem_dest = NULL;
+		goto out;
+	}
+	wire_gid_to_gid(gid, &rem_dest->gid);
+
+	ctx->conn_fd = sockfd;
+out:
+	return rem_dest;
+}
+
+static struct pingpong_dest *pp_server_exch_dest(struct pingpong_context *ctx,
+						 int ib_port, int port,
+						 const struct pingpong_dest *my_dest,
+						 int sgid_idx)
+{
+	struct addrinfo *res, *t;
+	struct addrinfo hints = {
+		.ai_flags    = AI_PASSIVE,
+		.ai_family   = AF_UNSPEC,
+		.ai_socktype = SOCK_STREAM
+	};
+	struct pingpong_dest *rem_dest = NULL;
+	int n;
+	int sockfd = -1, connfd;
+	char *service;
+	char gid[33];
+	char msg[sizeof(EXCH_MSG)];
+
+	if (asprintf(&service, "%d", port) < 0)
+		return NULL;
+
+	n = getaddrinfo(NULL, service, &hints, &res);
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
+			setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &n, sizeof(n));
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
+	connfd = accept(sockfd, NULL, NULL);
+	close(sockfd);
+	if (connfd < 0) {
+		fprintf(stderr, "accept() failed\n");
+		return NULL;
+	}
+
+	n = read(connfd, msg, sizeof(msg));
+	if (n != sizeof(msg)) {
+		perror("server read");
+		fprintf(stderr, "%d/%d: Couldn't read remote address\n", n, (int) sizeof(msg));
+		goto out;
+	}
+
+	rem_dest = malloc(sizeof(*rem_dest));
+	if (!rem_dest)
+		goto out;
+
+	n = sscanf(msg, "%x:%" SCNxPTR ":%x:%x:%x:%s", &rem_dest->rkey, &rem_dest->addr,
+						       &rem_dest->lid, &rem_dest->qpn,
+						       &rem_dest->psn, gid);
+	if (n != 6) {
+		fprintf(stderr, "Couldn't parse client data\n");
+		free(rem_dest);
+		rem_dest = NULL;
+		goto out;
+	}
+
+	wire_gid_to_gid(gid, &rem_dest->gid);
+
+	if (pp_connect_ctx(ctx, ib_port, my_dest->psn, rem_dest, sgid_idx)) {
+		fprintf(stderr, "Couldn't connect to remote QP\n");
+		free(rem_dest);
+		rem_dest = NULL;
+		goto out;
+	}
+
+	gid_to_wire_gid(&my_dest->gid, gid);
+	sprintf(msg, "%08x:%016" PRIxPTR ":%04x:%06x:%06x:%s", my_dest->rkey, my_dest->addr,
+							       my_dest->lid, my_dest->qpn,
+							       my_dest->psn, gid);
+	if (write(connfd, msg, sizeof(msg)) != sizeof(msg) ||
+	    read(connfd, msg, sizeof(msg)) != sizeof "done") {
+		fprintf(stderr, "Couldn't send/recv local address\n");
+		free(rem_dest);
+		rem_dest = NULL;
+		goto out;
+	}
+
+	ctx->conn_fd = connfd;
+out:
+	return rem_dest;
+}
+
+static int pp_post_send(struct pingpong_context *ctx, struct pingpong_dest *rem_dest)
+{
+	struct ibv_sge list = {
+		.addr	= (uintptr_t) ctx->buf,
+		.length = ctx->size,
+		.lkey	= ctx->mr->lkey
+	};
+	struct ibv_send_wr wr = {
+		.wr_id			= PINGPONG_SEND_WRID,
+		.sg_list		= &list,
+		.num_sge		= 1,
+		.opcode			= IBV_WR_RDMA_WRITE,
+		.send_flags		= IBV_SEND_SIGNALED,
+		.wr.rdma		= {
+			.remote_addr    = (uint64_t) rem_dest->addr,
+			.rkey		= rem_dest->rkey,
+		}
+	};
+	struct ibv_send_wr *bad_wr;
+
+	return ibv_post_send(ctx->qp, &wr, &bad_wr);
+}
+
+static inline int parse_single_wc(struct pingpong_context *ctx, int *scnt, int *rcnt,
+				  int iters, struct pingpong_dest *rem_dest,
+				  uint64_t wr_id, enum ibv_wc_status status)
+{
+	char msg[sizeof "recv_ack"];
+
+	if (status != IBV_WC_SUCCESS) {
+		fprintf(stderr, "Failed status %s (%d) for wr_id %d\n",
+			ibv_wc_status_str(status),
+			status, (int)wr_id);
+		return 1;
+	}
+
+	switch ((int)wr_id) {
+	case PINGPONG_SEND_WRID:
+		++(*scnt);
+
+		strcpy(msg, "recv_ack");
+		if (write(ctx->conn_fd, msg, sizeof(msg)) != sizeof(msg)) {
+			fprintf(stderr, "Couldn't send recv ack\n");
+			return 1;
+		}
+
+		break;
+
+	case PINGPONG_RECV_WRID:
+		++(*rcnt);
+		break;
+
+	default:
+		fprintf(stderr, "Completion for unknown wr_id %d\n", (int)wr_id);
+		return 1;
+	}
+
+	ctx->pending &= ~(int)wr_id;
+	if (*scnt < iters && !ctx->pending) {
+		if (pp_post_send(ctx, rem_dest)) {
+			fprintf(stderr, "Couldn't post send\n");
+			return 1;
+		}
+		ctx->pending = PINGPONG_RECV_WRID | PINGPONG_SEND_WRID;
+	}
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	struct ibv_device	**dev_list;
+	struct ibv_device	 *ib_dev;
+	struct pingpong_context	 *ctx;
+	struct pingpong_dest	  my_dest;
+	struct pingpong_dest	 *rem_dest;
+	struct timeval		  start, end;
+	char			 *ib_devname = NULL;
+	char			 *servername = NULL;
+	unsigned int		  size = 4096;
+	unsigned int		  rx_depth = 500;
+	unsigned int		  port = 18515;
+	unsigned int		  iters = 1000;
+	int			  ib_port = 1;
+	int			  gidx = -1;
+	int			  scnt, rcnt;
+	char			  gid[33];
+
+	srand48(getpid() * time(NULL));
+
+	while (1) {
+		int c;
+
+		static struct option long_options[] = {
+			{ .name = "ib-dev",    .has_arg = 1, .val = 'd' },
+			{ .name = "ib-port",   .has_arg = 1, .val = 'i' },
+			{ .name = "size",      .has_arg = 1, .val = 's' },
+			{ .name = "gid-idx",   .has_arg = 1, .val = 'g' },
+			{ .name = "iters",     .has_arg = 1, .val = 'n' },
+			{ .name = "chk",       .has_arg = 0, .val = 'c' },
+			{ .name = "help",      .has_arg = 0, .val = 'h' },
+			{}
+		};
+
+		c = getopt_long(argc, argv, "d:i:s:g:n:ch", long_options, NULL);
+		if (c == -1)
+			break;
+
+		switch (c) {
+		case 'd':
+			ib_devname = strdupa(optarg);
+			break;
+
+		case 'i':
+			ib_port = strtol(optarg, NULL, 0);
+			if (ib_port < 1) {
+				usage(argv[0]);
+				return 1;
+			}
+			break;
+
+		case 's':
+			size = strtoul(optarg, NULL, 0);
+			break;
+
+		case 'g':
+			gidx = strtol(optarg, NULL, 0);
+			break;
+
+		case 'n':
+			iters = strtoul(optarg, NULL, 0);
+			break;
+
+		case 'c':
+			validate_buf = 1;
+			break;
+
+		case 'h':
+			usage(argv[0]);
+			return 0;
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
+			return 1;
+		}
+	} else {
+		int i;
+
+		for (i = 0; dev_list[i]; ++i)
+			if (!strcmp(ibv_get_device_name(dev_list[i]), ib_devname))
+				break;
+		ib_dev = dev_list[i];
+		if (!ib_dev) {
+			fprintf(stderr, "IB device %s not found\n", ib_devname);
+			return 1;
+		}
+	}
+
+	printf("Running on IB device %s\n", ibv_get_device_name(ib_dev));
+
+	ctx = pp_init_ctx(ib_dev, size, rx_depth, ib_port);
+	if (!ctx)
+		return 1;
+
+	if (pp_get_port_info(ctx->context, ib_port, &ctx->portinfo)) {
+		fprintf(stderr, "Couldn't get port info\n");
+		return 1;
+	}
+
+	my_dest.lid = ctx->portinfo.lid;
+	if (ctx->portinfo.link_layer != IBV_LINK_LAYER_ETHERNET &&
+							!my_dest.lid) {
+		fprintf(stderr, "Couldn't get local LID\n");
+		return 1;
+	}
+
+	if (gidx >= 0) {
+		if (ibv_query_gid(ctx->context, ib_port, gidx, &my_dest.gid)) {
+			fprintf(stderr, "can't read sgid of index %d\n", gidx);
+			return 1;
+		}
+	} else {
+		memset(&my_dest.gid, 0, sizeof(my_dest.gid));
+	}
+
+	my_dest.qpn = ctx->qp->qp_num;
+	my_dest.psn = lrand48() & 0xffffff;
+	my_dest.rkey = ctx->mr->rkey;
+	my_dest.addr = (uintptr_t) ctx->buf;
+	inet_ntop(AF_INET6, &my_dest.gid, gid, sizeof(gid));
+	printf("  local: RKEY 0x%08x, ADDR 0x%016" PRIxPTR ", LID 0x%04x, QPN 0x%06x, PSN 0x%06x, GID %s\n",
+	       my_dest.rkey, my_dest.addr, my_dest.lid, my_dest.qpn, my_dest.psn, gid);
+
+	if (servername)
+		rem_dest = pp_client_exch_dest(ctx, servername, port, &my_dest);
+	else
+		rem_dest = pp_server_exch_dest(ctx, ib_port, port, &my_dest, gidx);
+
+	if (!rem_dest)
+		return 1;
+
+	inet_ntop(AF_INET6, &rem_dest->gid, gid, sizeof(gid));
+	printf("  remote: RKEY 0x%08x, ADDR 0x%016" PRIxPTR ", LID 0x%04x, QPN 0x%06x, PSN 0x%06x, GID %s\n",
+	       rem_dest->rkey, rem_dest->addr, rem_dest->lid, rem_dest->qpn, rem_dest->psn, gid);
+
+	if (servername)
+		if (pp_connect_ctx(ctx, ib_port, my_dest.psn, rem_dest, gidx))
+			return 1;
+
+	ctx->pending = PINGPONG_RECV_WRID;
+
+	if (servername) {
+		if (validate_buf)
+			for (int i = 0; i < size; i += page_size)
+				ctx->buf[i] = i / page_size % sizeof(char);
+
+		if (pp_post_send(ctx, rem_dest)) {
+			fprintf(stderr, "Couldn't post send\n");
+			return 1;
+		}
+		ctx->pending |= PINGPONG_SEND_WRID;
+	}
+
+	if (gettimeofday(&start, NULL)) {
+		perror("gettimeofday");
+		return 1;
+	}
+
+	scnt = rcnt = 0;
+	while (rcnt < iters || scnt < iters) {
+		int ne, i, ret;
+		struct ibv_wc wc[2];
+
+		do {
+			char msg[sizeof "recv_ack"];
+			int flags;
+
+			ne = ibv_poll_cq(ctx->cq, 2, wc);
+			if (ne < 0) {
+				fprintf(stderr, "poll CQ failed %d\n", ne);
+				return 1;
+			}
+
+			flags = fcntl(ctx->conn_fd, F_GETFL, 0);
+			fcntl(ctx->conn_fd, F_SETFL, flags | O_NONBLOCK);
+			if (read(ctx->conn_fd, msg, sizeof(msg)) > 0) {
+				if (!strcmp("recv_ack", msg)) {
+					wc[ne].status = IBV_WC_SUCCESS;
+					wc[ne].wr_id = PINGPONG_RECV_WRID;
+					ne++;
+				} else
+					fprintf(stderr, "Invalid msg %s\n", msg);
+			}
+		} while (ne < 1);
+
+		for (i = 0; i < ne; ++i) {
+			ret = parse_single_wc(ctx, &scnt, &rcnt, iters, rem_dest,
+					      wc[i].wr_id, wc[i].status);
+			if (ret) {
+				fprintf(stderr, "parse WC failed %d\n", ne);
+				return 1;
+			}
+		}
+	}
+
+	if (gettimeofday(&end, NULL)) {
+		perror("gettimeofday");
+		return 1;
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
+	if ((!servername) && (validate_buf)) {
+		for (int i = 0; i < size; i += page_size)
+			if (ctx->buf[i] != i / page_size % sizeof(char)) {
+				fprintf(stderr, "invalid data in page %d\n",
+					i / page_size);
+				return 1;
+			}
+	}
+
+	free(rem_dest);
+	close(ctx->conn_fd);
+
+	if (pp_close_ctx(ctx))
+		return 1;
+
+	ibv_free_device_list(dev_list);
+
+	return 0;
+}
diff --git a/libibverbs/man/CMakeLists.txt b/libibverbs/man/CMakeLists.txt
index 843d7f0a..40fa64cf 100644
--- a/libibverbs/man/CMakeLists.txt
+++ b/libibverbs/man/CMakeLists.txt
@@ -70,6 +70,7 @@ rdma_man_pages(
   ibv_rate_to_mbps.3.md
   ibv_rate_to_mult.3.md
   ibv_rc_pingpong.1
+  ibv_rc_wr_pingpong.1
   ibv_read_counters.3.md
   ibv_reg_mr.3
   ibv_req_notify_cq.3.md
diff --git a/libibverbs/man/ibv_rc_wr_pingpong.1 b/libibverbs/man/ibv_rc_wr_pingpong.1
new file mode 100644
index 00000000..a41fe948
--- /dev/null
+++ b/libibverbs/man/ibv_rc_wr_pingpong.1
@@ -0,0 +1,63 @@
+.\" Licensed under the OpenIB.org BSD license (FreeBSD Variant) - See COPYING.md
+.TH IBV_RC_WR_PINGPONG 1 "April 30, 2023" "libibverbs" "USER COMMANDS"
+
+.SH NAME
+ibv_rc_wr_pingpong \- simple InfiniBand RC RDMA write transport test
+
+.SH SYNOPSIS
+.B ibv_rc_wr_pingpong
+[\-d device] [\-i ib port] [\-s size]
+[\-n iters] [\-g gid index] [\-c] \fBHOSTNAME\fR
+
+.B ibv_rc_wr_pingpong
+[\-d device] [\-i ib port] [\-s size]
+[\-n iters] [\-g gid index] [\-c]
+
+.SH DESCRIPTION
+.PP
+Run a simple ping-pong test over InfiniBand via the reliable
+connected (RC) RDMA write transport.
+
+.SH OPTIONS
+
+.PP
+.TP
+\fB\-d\fR, \fB\-\-ib\-dev\fR=\fIDEVICE\fR
+use IB device \fIDEVICE\fR (default first device found)
+.TP
+\fB\-i\fR, \fB\-\-ib\-port\fR=\fIPORT\fR
+use IB port \fIPORT\fR (default port 1)
+.TP
+\fB\-s\fR, \fB\-\-size\fR=\fISIZE\fR
+ping-pong messages of size \fISIZE\fR (default 4096)
+.TP
+\fB\-m\fR, \fB\-\-mtu\fR=\fISIZE\fR
+path MTU \fISIZE\fR (default 1024)
+.TP
+\fB\-n\fR, \fB\-\-iters\fR=\fIITERS\fR
+perform \fIITERS\fR message exchanges (default 1000)
+.TP
+\fB\-g\fR, \fB\-\-gid-idx\fR=\fIGIDINDEX\fR
+local port \fIGIDINDEX\fR
+.TP
+\fB\-c\fR, \fB\-\-chk\fR
+validate received buffer
+
+.SH SEE ALSO
+.BR ibv_uc_pingpong (1),
+.BR ibv_ud_pingpong (1),
+.BR ibv_srq_pingpong (1),
+.BR ibv_xsrq_pingpong (1),
+.BR ibv_rc_pingpong (1)
+
+.SH AUTHORS
+.TP
+Animesh Kishore
+.RI < animesh.kishore@gmail.com >
+
+.SH BUGS
+The network synchronization between client and server instances is
+weak, and does not prevent incompatible options from being used on the
+two instances.  The method used for retrieving work completions is not
+strictly correct, and race conditions may cause failures on some
+systems.
-- 
2.25.1

