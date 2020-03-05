Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5A5117A879
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 16:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgCEPEZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 10:04:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:47824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgCEPEZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 10:04:25 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A1EB20801;
        Thu,  5 Mar 2020 15:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583420663;
        bh=gkMb5vr8J7Wwtxh2/kYs0bULzN58T6YimTvXotpixxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lin0YJuiwSZhsV1/GHjdNSd82kUTV7dIQ/h32AiYZoNrAWOFWqwTU/ECji4x7ESWQ
         +Ba0Ow6tZB8qdKYPoM9RB+1CnizdqqA42bIRHq6W2XG88ywPdC65+N0SD8YH39MdTs
         gr2tMyTgmsK7hlpfi+4vCFW7BsonCUIXpCUWbZ30=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [RFC PATCH rdma-core 06/11] librdmacm: Provide interface to use ECE for external QPs
Date:   Thu,  5 Mar 2020 17:03:51 +0200
Message-Id: <20200305150356.208843-7-leon@kernel.org>
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

Add the following calls to allow use of ECE for external QPs.
Those QPs are not managed by librdmacm and can be any type
and not strictly ibv_qp.

 * rdma_set_local_ece() - provide to the librdmacm the desired
   ECE options to be used in REQ/REP handshake.
 * rdma_get_remote_ece() - get ECE options received from the peer,
   so users will be able to accept/reject/mask supported ECE options.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 debian/librdmacm1.symbols |  3 +++
 librdmacm/CMakeLists.txt  |  2 +-
 librdmacm/cma.c           | 51 +++++++++++++++++++++++++++++++++++++++
 librdmacm/librdmacm.map   |  6 +++++
 librdmacm/rdma_cma.h      | 16 ++++++++++++
 5 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/debian/librdmacm1.symbols b/debian/librdmacm1.symbols
index 996122f3..cc4d7a6c 100644
--- a/debian/librdmacm1.symbols
+++ b/debian/librdmacm1.symbols
@@ -3,6 +3,7 @@ librdmacm.so.1 librdmacm1 #MINVER#
  RDMACM_1.0@RDMACM_1.0 1.0.15
  RDMACM_1.1@RDMACM_1.1 16
  RDMACM_1.2@RDMACM_1.2 23
+ RDMACM_1.3@RDMACM_1.3 28
  raccept@RDMACM_1.0 1.0.16
  rbind@RDMACM_1.0 1.0.16
  rclose@RDMACM_1.0 1.0.16
@@ -31,6 +32,7 @@ librdmacm.so.1 librdmacm1 #MINVER#
  rdma_get_cm_event@RDMACM_1.0 1.0.15
  rdma_get_devices@RDMACM_1.0 1.0.15
  rdma_get_dst_port@RDMACM_1.0 1.0.19
+ rdma_get_remote_ece@RDMACM_1.3 28
  rdma_get_request@RDMACM_1.0 1.0.15
  rdma_get_src_port@RDMACM_1.0 1.0.19
  rdma_getaddrinfo@RDMACM_1.0 1.0.15
@@ -44,6 +46,7 @@ librdmacm.so.1 librdmacm1 #MINVER#
  rdma_reject@RDMACM_1.0 1.0.15
  rdma_resolve_addr@RDMACM_1.0 1.0.15
  rdma_resolve_route@RDMACM_1.0 1.0.15
+ rdma_set_local_ece@RDMACM_1.3 28
  rdma_set_option@RDMACM_1.0 1.0.15
  rfcntl@RDMACM_1.0 1.0.16
  rgetpeername@RDMACM_1.0 1.0.16
diff --git a/librdmacm/CMakeLists.txt b/librdmacm/CMakeLists.txt
index f0767cff..b01fef4f 100644
--- a/librdmacm/CMakeLists.txt
+++ b/librdmacm/CMakeLists.txt
@@ -11,7 +11,7 @@ publish_headers(infiniband

 rdma_library(rdmacm librdmacm.map
   # See Documentation/versioning.md
-  1 1.2.${PACKAGE_VERSION}
+  1 1.3.${PACKAGE_VERSION}
   acm.c
   addrinfo.c
   cma.c
diff --git a/librdmacm/cma.c b/librdmacm/cma.c
index 2ac59850..8d2342b5 100644
--- a/librdmacm/cma.c
+++ b/librdmacm/cma.c
@@ -106,6 +106,8 @@ struct cma_id_private {
 	struct ibv_qp_init_attr	*qp_init_attr;
 	uint8_t			initiator_depth;
 	uint8_t			responder_resources;
+	struct ibv_ece		local_ece;
+	struct ibv_ece		remote_ece;
 };

 struct cma_multicast {
@@ -1382,6 +1384,24 @@ void rdma_destroy_srq(struct rdma_cm_id *id)
 	ucma_destroy_cqs(id);
 }

+static int init_ece(struct rdma_cm_id *id, struct ibv_qp *qp)
+{
+	struct cma_id_private *id_priv =
+		container_of(id, struct cma_id_private, id);
+	struct ibv_ece ece = {};
+	int ret;
+
+	ret = ibv_query_ece(qp, &ece);
+	if (ret)
+		return 0;
+
+	id_priv->local_ece.vendor_id = ece.vendor_id;
+	id_priv->local_ece.options = ece.options;
+
+	return 0;
+}
+
+
 int rdma_create_qp_ex(struct rdma_cm_id *id,
 		      struct ibv_qp_init_attr_ex *attr)
 {
@@ -1429,6 +1449,9 @@ int rdma_create_qp_ex(struct rdma_cm_id *id,
 		goto err1;
 	}

+	ret = init_ece(id, qp);
+	if (ret)
+		goto err2;
 	if (ucma_is_ud_qp(id->qp_type))
 		ret = ucma_init_ud_qp(id_priv, qp);
 	else
@@ -2565,3 +2588,31 @@ __be16 rdma_get_dst_port(struct rdma_cm_id *id)
 	return ucma_get_port(&id->route.addr.dst_addr);
 }

+int rdma_set_local_ece(struct rdma_cm_id *id, struct ibv_ece *ece)
+{
+	struct cma_id_private *id_priv;
+
+	if (!id || id->qp || !ece || !ece->vendor_id || ece->comp_mask)
+		return ERR(EINVAL);
+
+	id_priv = container_of(id, struct cma_id_private, id);
+	id_priv->local_ece.vendor_id = ece->vendor_id;
+	id_priv->local_ece.options = ece->options;
+
+	return 0;
+}
+
+int rdma_get_remote_ece(struct rdma_cm_id *id, struct ibv_ece *ece)
+{
+	struct cma_id_private *id_priv;
+
+	if (id->qp || !ece)
+		return ERR(EINVAL);
+
+	id_priv = container_of(id, struct cma_id_private, id);
+	ece->vendor_id = id_priv->remote_ece.vendor_id;
+	ece->options = id_priv->remote_ece.options;
+	ece->comp_mask = 0;
+
+	return 0;
+}
diff --git a/librdmacm/librdmacm.map b/librdmacm/librdmacm.map
index 7f55e844..f29a23b4 100644
--- a/librdmacm/librdmacm.map
+++ b/librdmacm/librdmacm.map
@@ -82,3 +82,9 @@ RDMACM_1.2 {
 		rdma_establish;
 		rdma_init_qp_attr;
 } RDMACM_1.1;
+
+RDMACM_1.3 {
+	global:
+		rdma_get_remote_ece;
+		rdma_set_local_ece;
+} RDMACM_1.2;
diff --git a/librdmacm/rdma_cma.h b/librdmacm/rdma_cma.h
index 19050332..c42a28f7 100644
--- a/librdmacm/rdma_cma.h
+++ b/librdmacm/rdma_cma.h
@@ -753,6 +753,22 @@ void rdma_freeaddrinfo(struct rdma_addrinfo *res);
  */
 int rdma_init_qp_attr(struct rdma_cm_id *id, struct ibv_qp_attr *qp_attr,
 		      int *qp_attr_mask);
+
+/**
+ * rdma_set_local_ece - Set local ECE options to be used for REQ/REP
+ * communication. In use to implement ECE handshake in external QP.
+ * @id: Communication identifier to establish connection
+ * @ece: ECE parameters
+ */
+int rdma_set_local_ece(struct rdma_cm_id *id, struct ibv_ece *ece);
+
+/**
+ * rdma_get_remote_ece - Provide remote ECE parameters as received
+ * in REQ/REP events. In use to implement ECE handshake in external QP.
+ * @id: Communication identifier to establish connection
+ * @ece: ECE parameters
+ */
+int rdma_get_remote_ece(struct rdma_cm_id *id, struct ibv_ece *ece);
 #ifdef __cplusplus
 }
 #endif
--
2.24.1

