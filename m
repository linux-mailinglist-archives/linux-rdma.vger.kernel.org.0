Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0039717A87F
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 16:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCEPEn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 10:04:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgCEPEn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 10:04:43 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16ED920801;
        Thu,  5 Mar 2020 15:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583420682;
        bh=p9wbVk2wlTsw0ye170t1cB3dqxEt4KgAyiufvmssuLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z0xGeQdVtae5jBFIJ4wStwYi5vULZ6alcE3sS4zCW591YklSZQ5HpOrojzXKLc/Js
         uXzsA9Jz6JFwyoUnNMa0DxMzAexhiLcnERTM3bGLv7OR1mK46wDB2cURUJUHVzXwQa
         eHTHKmT1d+wSPk4v4HUUN+M3/UG/Ev7Ma9pP33F4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [RFC PATCH rdma-core 09/11] librdmacm: Add an option to reject ECE request
Date:   Thu,  5 Mar 2020 17:03:54 +0200
Message-Id: <20200305150356.208843-10-leon@kernel.org>
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

IBTA has specific rejected reason for users who doesn't
want proposed ECE options in request messages. Provide special
version (rdma_reject_ece) to mark such rejects.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 debian/librdmacm1.symbols |  1 +
 librdmacm/cma.c           | 19 +++++++++++++++++--
 librdmacm/librdmacm.map   |  1 +
 librdmacm/rdma_cma.h      |  8 ++++++++
 librdmacm/rdma_cma_abi.h  |  7 ++++++-
 5 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/debian/librdmacm1.symbols b/debian/librdmacm1.symbols
index cc4d7a6c..ce5ffd20 100644
--- a/debian/librdmacm1.symbols
+++ b/debian/librdmacm1.symbols
@@ -44,6 +44,7 @@ librdmacm.so.1 librdmacm1 #MINVER#
  rdma_migrate_id@RDMACM_1.0 1.0.15
  rdma_notify@RDMACM_1.0 1.0.15
  rdma_reject@RDMACM_1.0 1.0.15
+ rdma_reject_ece@RDMACM_1.3 28
  rdma_resolve_addr@RDMACM_1.0 1.0.15
  rdma_resolve_route@RDMACM_1.0 1.0.15
  rdma_set_local_ece@RDMACM_1.3 28
diff --git a/librdmacm/cma.c b/librdmacm/cma.c
index 30a5de75..ba8a9a57 100644
--- a/librdmacm/cma.c
+++ b/librdmacm/cma.c
@@ -1735,8 +1735,9 @@ int rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
 	return ucma_complete(id);
 }

-int rdma_reject(struct rdma_cm_id *id, const void *private_data,
-		uint8_t private_data_len)
+static int reject_with_reason(struct rdma_cm_id *id, const void *private_data,
+			      uint8_t private_data_len,
+			      enum ucm_abi_reject_reason reason)
 {
 	struct ucma_abi_reject cmd;
 	struct cma_id_private *id_priv;
@@ -1750,6 +1751,7 @@ int rdma_reject(struct rdma_cm_id *id, const void *private_data,
 		memcpy(cmd.private_data, private_data, private_data_len);
 		cmd.private_data_len = private_data_len;
 	}
+	cmd.reason = reason;

 	ret = write(id->channel->fd, &cmd, sizeof cmd);
 	if (ret != sizeof cmd)
@@ -1758,6 +1760,19 @@ int rdma_reject(struct rdma_cm_id *id, const void *private_data,
 	return 0;
 }

+int rdma_reject(struct rdma_cm_id *id, const void *private_data,
+		uint8_t private_data_len)
+{
+	return reject_with_reason(id, private_data, private_data_len, 0);
+}
+
+int rdma_reject_ece(struct rdma_cm_id *id, const void *private_data,
+		    uint8_t private_data_len)
+{
+	return reject_with_reason(id, private_data, private_data_len,
+				  RDMA_USER_CM_REJ_VENDOR_OPTION_NOT_SUPPORTED);
+}
+
 int rdma_notify(struct rdma_cm_id *id, enum ibv_event_type event)
 {
 	struct ucma_abi_notify cmd;
diff --git a/librdmacm/librdmacm.map b/librdmacm/librdmacm.map
index f29a23b4..d162ef09 100644
--- a/librdmacm/librdmacm.map
+++ b/librdmacm/librdmacm.map
@@ -86,5 +86,6 @@ RDMACM_1.2 {
 RDMACM_1.3 {
 	global:
 		rdma_get_remote_ece;
+		rdma_reject_ece;
 		rdma_set_local_ece;
 } RDMACM_1.2;
diff --git a/librdmacm/rdma_cma.h b/librdmacm/rdma_cma.h
index c42a28f7..e1f4e236 100644
--- a/librdmacm/rdma_cma.h
+++ b/librdmacm/rdma_cma.h
@@ -524,6 +524,14 @@ int rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param);
 int rdma_reject(struct rdma_cm_id *id, const void *private_data,
 		uint8_t private_data_len);

+/**
+ * rdma_reject_ece - Called to reject a connection request with ECE
+ * rejected reason.
+ * The same as rdma_reject()
+ */
+int rdma_reject_ece(struct rdma_cm_id *id, const void *private_data,
+		uint8_t private_data_len);
+
 /**
  * rdma_notify - Notifies the librdmacm of an asynchronous event.
  * @id: RDMA identifier.
diff --git a/librdmacm/rdma_cma_abi.h b/librdmacm/rdma_cma_abi.h
index 4639941b..911863cc 100644
--- a/librdmacm/rdma_cma_abi.h
+++ b/librdmacm/rdma_cma_abi.h
@@ -73,6 +73,10 @@ enum {
 	UCMA_CMD_JOIN_MCAST
 };

+enum ucm_abi_reject_reason {
+	RDMA_USER_CM_REJ_VENDOR_OPTION_NOT_SUPPORTED = 35
+};
+
 struct ucma_abi_cmd_hdr {
 	__u32 cmd;
 	__u16 in;
@@ -263,7 +267,8 @@ struct ucma_abi_reject {
 	__u16 out;
 	__u32 id;
 	__u8  private_data_len;
-	__u8  reserved[3];
+	__u8  reason; /* enum ucm_abi_reject_reason */
+	__u8  reserved[2];
 	__u8  private_data[RDMA_MAX_PRIVATE_DATA];
 };

--
2.24.1

