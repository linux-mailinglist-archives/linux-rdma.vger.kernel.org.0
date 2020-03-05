Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69C7B17A875
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 16:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCEPEP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 10:04:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbgCEPEP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 10:04:15 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC8F720801;
        Thu,  5 Mar 2020 15:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583420654;
        bh=VYhYPTjgDkK+nvCUFS7bPbO7KMEK+kRds+4MKKKKZng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NybvDAncQPa8WLMlhgNSctxkWLWuwEy6hi2tRp64HipmTYf9dW7cmmgpf/zIrjzOz
         s1Fkf3XkhPwYbvloNfnjTfnK7GSJJ5g6LCyxkvWdBd6JL7kTMWgJdm1MOiZtZ2Vo9Z
         SKjPKIwRC/kr++eM7eWoo+DAcrnDkqYY0+zURit8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [RFC PATCH rdma-core 02/11] libibverbs: Add interfaces to configure and use ECE
Date:   Thu,  5 Mar 2020 17:03:47 +0200
Message-Id: <20200305150356.208843-3-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305150356.208843-1-leon@kernel.org>
References: <20200305150356.208843-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

ECE parameters are vendor specific information per-QP,
provide a way to set, query and commit ECE data.

 * ibv_set_ece() - overwrite default ECE options and instruct
	libibverbs to use ECE data while enabling QP.
 * ibv_query_ece() - get ECE options.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 CMakeLists.txt               |  2 +-
 debian/libibverbs1.symbols   |  5 ++++-
 libibverbs/CMakeLists.txt    |  2 +-
 libibverbs/driver.h          |  2 ++
 libibverbs/dummy_ops.c       | 14 ++++++++++++++
 libibverbs/libibverbs.map.in |  6 ++++++
 libibverbs/verbs.c           | 15 +++++++++++++++
 libibverbs/verbs.h           | 18 ++++++++++++++++++
 8 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index fcc50e86..6cff4a94 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -72,7 +72,7 @@ set(PACKAGE_VERSION "29.0")
 # When this is changed the values in these files need changing too:
 #   debian/control
 #   debian/libibverbs1.symbols
-set(IBVERBS_PABI_VERSION "25")
+set(IBVERBS_PABI_VERSION "26")
 set(IBVERBS_PROVIDER_SUFFIX "-rdmav${IBVERBS_PABI_VERSION}.so")

 #-------------------------
diff --git a/debian/libibverbs1.symbols b/debian/libibverbs1.symbols
index ec40b29b..0a6b3e70 100644
--- a/debian/libibverbs1.symbols
+++ b/debian/libibverbs1.symbols
@@ -6,7 +6,8 @@ libibverbs.so.1 libibverbs1 #MINVER#
  IBVERBS_1.6@IBVERBS_1.6 24
  IBVERBS_1.7@IBVERBS_1.7 25
  IBVERBS_1.8@IBVERBS_1.8 28
- (symver)IBVERBS_PRIVATE_25 25
+ IBVERBS_1.9@IBVERBS_1.9 28
+ (symver)IBVERBS_PRIVATE_26 26
  ibv_ack_async_event@IBVERBS_1.0 1.1.6
  ibv_ack_async_event@IBVERBS_1.1 1.1.6
  ibv_ack_cq_events@IBVERBS_1.0 1.1.6
@@ -76,6 +77,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
  ibv_qp_to_qp_ex@IBVERBS_1.6 24
  ibv_query_device@IBVERBS_1.0 1.1.6
  ibv_query_device@IBVERBS_1.1 1.1.6
+ ibv_query_ece@IBVERBS_1.9 28
  ibv_query_gid@IBVERBS_1.0 1.1.6
  ibv_query_gid@IBVERBS_1.1 1.1.6
  ibv_query_pkey@IBVERBS_1.0 1.1.6
@@ -98,6 +100,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
  ibv_resize_cq@IBVERBS_1.0 1.1.6
  ibv_resize_cq@IBVERBS_1.1 1.1.6
  ibv_resolve_eth_l2_from_gid@IBVERBS_1.1 1.2.0
+ ibv_set_ece@IBVERBS_1.9 28
  ibv_wc_status_str@IBVERBS_1.1 1.1.6
  mbps_to_ibv_rate@IBVERBS_1.1 1.1.8
  mult_to_ibv_rate@IBVERBS_1.0 1.1.6
diff --git a/libibverbs/CMakeLists.txt b/libibverbs/CMakeLists.txt
index 43285489..a10bf103 100644
--- a/libibverbs/CMakeLists.txt
+++ b/libibverbs/CMakeLists.txt
@@ -21,7 +21,7 @@ configure_file("libibverbs.map.in"

 rdma_library(ibverbs "${CMAKE_CURRENT_BINARY_DIR}/libibverbs.map"
   # See Documentation/versioning.md
-  1 1.8.${PACKAGE_VERSION}
+  1 1.9.${PACKAGE_VERSION}
   all_providers.c
   cmd.c
   cmd_ah.c
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index a0e6f89a..f14ce537 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -348,6 +348,7 @@ struct verbs_context_ops {
 			       const struct ibv_query_device_ex_input *input,
 			       struct ibv_device_attr_ex *attr,
 			       size_t attr_size);
+	int (*query_ece)(struct ibv_qp *qp, struct ibv_ece *ece);
 	int (*query_port)(struct ibv_context *context, uint8_t port_num,
 			  struct ibv_port_attr *port_attr);
 	int (*query_qp)(struct ibv_qp *qp, struct ibv_qp_attr *attr,
@@ -368,6 +369,7 @@ struct verbs_context_ops {
 	int (*rereg_mr)(struct verbs_mr *vmr, int flags, struct ibv_pd *pd,
 			void *addr, size_t length, int access);
 	int (*resize_cq)(struct ibv_cq *cq, int cqe);
+	int (*set_ece)(struct ibv_qp *qp, struct ibv_ece *ece);
 };

 static inline struct verbs_device *
diff --git a/libibverbs/dummy_ops.c b/libibverbs/dummy_ops.c
index 46efe1e9..8d7b4e1a 100644
--- a/libibverbs/dummy_ops.c
+++ b/libibverbs/dummy_ops.c
@@ -439,6 +439,16 @@ static int resize_cq(struct ibv_cq *cq, int cqe)
 	return EOPNOTSUPP;
 }

+static int set_ece(struct ibv_qp *qp, struct ibv_ece *ece)
+{
+	return EOPNOTSUPP;
+}
+
+static int query_ece(struct ibv_qp *qp, struct ibv_ece *ece)
+{
+	return EOPNOTSUPP;
+}
+
 /*
  * Ops in verbs_dummy_ops simply return an EOPNOTSUPP error code when called, or
  * do nothing. They are placed in the ops structures if the provider does not
@@ -508,6 +518,7 @@ const struct verbs_context_ops verbs_dummy_ops = {
 	post_srq_recv,
 	query_device,
 	query_device_ex,
+	query_ece,
 	query_port,
 	query_qp,
 	query_rt_values,
@@ -518,6 +529,7 @@ const struct verbs_context_ops verbs_dummy_ops = {
 	req_notify_cq,
 	rereg_mr,
 	resize_cq,
+	set_ece,
 };

 /*
@@ -624,6 +636,7 @@ void verbs_set_ops(struct verbs_context *vctx,
 	SET_OP(ctx, post_srq_recv);
 	SET_PRIV_OP(ctx, query_device);
 	SET_OP(vctx, query_device_ex);
+	SET_PRIV_OP_IC(vctx, query_ece);
 	SET_PRIV_OP_IC(ctx, query_port);
 	SET_PRIV_OP(ctx, query_qp);
 	SET_OP(vctx, query_rt_values);
@@ -634,6 +647,7 @@ void verbs_set_ops(struct verbs_context *vctx,
 	SET_OP(ctx, req_notify_cq);
 	SET_PRIV_OP(ctx, rereg_mr);
 	SET_PRIV_OP(ctx, resize_cq);
+	SET_PRIV_OP_IC(vctx, set_ece);

 #undef SET_OP
 #undef SET_OP2
diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
index 5280cfe6..52ce0c80 100644
--- a/libibverbs/libibverbs.map.in
+++ b/libibverbs/libibverbs.map.in
@@ -126,6 +126,12 @@ IBVERBS_1.8 {
 		ibv_reg_mr_iova2;
 } IBVERBS_1.7;

+IBVERBS_1.9 {
+	global:
+		ibv_query_ece;
+		ibv_set_ece;
+} IBVERBS_1.8;
+
 /* If any symbols in this stanza change ABI then the entire staza gets a new symbol
    version. See the top level CMakeLists.txt for this setting. */

diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
index 629f24c2..35d471e4 100644
--- a/libibverbs/verbs.c
+++ b/libibverbs/verbs.c
@@ -1080,3 +1080,18 @@ free_resources:

 	return ret;
 }
+
+int ibv_set_ece(struct ibv_qp *qp, struct ibv_ece *ece)
+{
+	if (!ece->vendor_id || ece->comp_mask) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	return get_ops(qp->context)->set_ece(qp, ece);
+}
+
+int ibv_query_ece(struct ibv_qp *qp, struct ibv_ece *ece)
+{
+	return get_ops(qp->context)->query_ece(qp, ece);
+}
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index 1601f225..bd76c7e8 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -1401,6 +1401,21 @@ static inline void ibv_wr_abort(struct ibv_qp_ex *qp)
 	qp->wr_abort(qp);
 }

+struct ibv_ece {
+	/*
+	 * Unique identifier of the provider vendor on the network.
+	 * The providers will set IEEE OUI here to distinguish
+	 * itself in non-homogenius network.
+	 */
+	uint32_t vendor_id;
+	/*
+	 * Provider specific attributes which are supported or
+	 * needed to be enabled by ECE users.
+	 */
+	uint32_t options;
+	uint32_t comp_mask;
+};
+
 struct ibv_comp_channel {
 	struct ibv_context     *context;
 	int			fd;
@@ -3325,6 +3340,9 @@ static inline int ibv_read_counters(struct ibv_counters *counters,
 	return vctx->read_counters(counters, counters_value, ncounters, flags);
 }

+int ibv_set_ece(struct ibv_qp *qp, struct ibv_ece *ece);
+int ibv_query_ece(struct ibv_qp *qp, struct ibv_ece *ece);
+
 #ifdef __cplusplus
 }
 #endif
--
2.24.1

