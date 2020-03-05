Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 418E817A87A
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 16:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgCEPE1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 10:04:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgCEPE1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 10:04:27 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B33B20801;
        Thu,  5 Mar 2020 15:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583420666;
        bh=wMDTDfijuk9geypgNhg2oBoL4fVQO9e6AjAtyeI4NlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HTJltErZLXPFksto7p/J+ryJdCqz0AdJV8jqcAni56xhVSDERcNGyBeraV7XnjNtl
         BgbKm84F5MqG5KWfuYRiOb9kDJXmlqlJeDK4t9chFbhFv1eZm06GfSboo+JmQA3CNM
         AO2XKSYy2xSHEgPLDubyByqfivYeD+Es/BU5tsLo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [RFC PATCH rdma-core 07/11] librdmacm: Connect rdma_connect to the ECE
Date:   Thu,  5 Mar 2020 17:03:52 +0200
Message-Id: <20200305150356.208843-8-leon@kernel.org>
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

The ECE options are handled to the kernel at the time
of connection request, e.g. rdma_connect().

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 librdmacm/cma.c          | 9 +++++++++
 librdmacm/rdma_cma_abi.h | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/librdmacm/cma.c b/librdmacm/cma.c
index 8d2342b5..e912410b 100644
--- a/librdmacm/cma.c
+++ b/librdmacm/cma.c
@@ -1547,6 +1547,13 @@ static void ucma_copy_conn_param_to_kern(struct cma_id_private *id_priv,
 	}
 }

+static void ucma_copy_ece_param_to_kern_req(struct cma_id_private *id_priv,
+					    struct ucma_abi_ece *dst)
+{
+	dst->vendor_id = id_priv->local_ece.vendor_id;
+	dst->attr_mod = id_priv->local_ece.options;
+}
+
 int rdma_connect(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
 {
 	uint32_t qp_num = (conn_param) ? conn_param->qp_num : 0;
@@ -1579,6 +1586,8 @@ int rdma_connect(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
 	ucma_copy_conn_param_to_kern(id_priv, &cmd.conn_param, conn_param,
 				     qp_num, srq);

+	ucma_copy_ece_param_to_kern_req(id_priv, &cmd.ece);
+
 	ret = write(id->channel->fd, &cmd, sizeof cmd);
 	if (ret != sizeof cmd)
 		return (ret >= 0) ? ERR(ENODATA) : -1;
diff --git a/librdmacm/rdma_cma_abi.h b/librdmacm/rdma_cma_abi.h
index ab4adb00..6451862e 100644
--- a/librdmacm/rdma_cma_abi.h
+++ b/librdmacm/rdma_cma_abi.h
@@ -223,6 +223,11 @@ struct ucma_abi_ud_param {
 	__u8 reserved2[4];  /* Round to 8-byte boundary to support 32/64 */
 };

+struct ucma_abi_ece {
+	__u32 vendor_id;
+	__u32 attr_mod;
+};
+
 struct ucma_abi_connect {
 	__u32 cmd;
 	__u16 in;
@@ -230,6 +235,7 @@ struct ucma_abi_connect {
 	struct ucma_abi_conn_param conn_param;
 	__u32 id;
 	__u32 reserved;
+	struct ucma_abi_ece ece;
 };

 struct ucma_abi_listen {
--
2.24.1

