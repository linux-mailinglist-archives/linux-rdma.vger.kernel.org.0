Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3212517A87B
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 16:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCEPEa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 10:04:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:47888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgCEPEa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 10:04:30 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7142C20848;
        Thu,  5 Mar 2020 15:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583420670;
        bh=ua1xOqup6drGO1JtpsPE0qivAIgNyJMgZ7hgG1E34uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Er8gR6i6t31Rv4cEXVVqBrVLF5RUysyyyZZPQko4oBHmiHX2QwQ5ntC4zqi7Bb8Vb
         iJlDiGo50dqeksvS70pmwYC7ZcRxNDCk7vukFOYTO5VRxg2jDJgHmcp1XQusIB2b9M
         rW/4SV5d1020dKV20/dBdXGwmO02n7IdsaVyP0XU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [RFC PATCH rdma-core 08/11] librdmacm: Return ECE results through rdma_accept
Date:   Thu,  5 Mar 2020 17:03:53 +0200
Message-Id: <20200305150356.208843-9-leon@kernel.org>
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

Passive side (server) returns its answer through REP message,
which is constructed as a result of rdma_accept().

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 librdmacm/cma.c          | 9 +++++++++
 librdmacm/rdma_cma_abi.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/librdmacm/cma.c b/librdmacm/cma.c
index e912410b..30a5de75 100644
--- a/librdmacm/cma.c
+++ b/librdmacm/cma.c
@@ -1668,6 +1668,14 @@ err:
 	return ret;
 }

+static void ucma_copy_ece_param_to_kern_rep(struct cma_id_private *id_priv,
+					    struct ucma_abi_ece *dst)
+{
+	/* Return result with same ID as received. */
+	dst->vendor_id = id_priv->remote_ece.vendor_id;
+	dst->attr_mod = id_priv->local_ece.options;
+}
+
 int rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
 {
 	uint32_t qp_num = (conn_param) ? conn_param->qp_num : 0;
@@ -1713,6 +1721,7 @@ int rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
 	}
 	ucma_copy_conn_param_to_kern(id_priv, &cmd.conn_param, conn_param,
 				     qp_num, srq);
+	ucma_copy_ece_param_to_kern_rep(id_priv, &cmd.ece);

 	ret = write(id->channel->fd, &cmd, sizeof cmd);
 	if (ret != sizeof cmd) {
diff --git a/librdmacm/rdma_cma_abi.h b/librdmacm/rdma_cma_abi.h
index 6451862e..4639941b 100644
--- a/librdmacm/rdma_cma_abi.h
+++ b/librdmacm/rdma_cma_abi.h
@@ -254,6 +254,7 @@ struct ucma_abi_accept {
 	struct ucma_abi_conn_param conn_param;
 	__u32 id;
 	__u32 reserved;
+	struct ucma_abi_ece ece;
 };

 struct ucma_abi_reject {
--
2.24.1

