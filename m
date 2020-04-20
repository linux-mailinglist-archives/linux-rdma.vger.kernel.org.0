Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8331B0DEF
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 16:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgDTOHc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 10:07:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728298AbgDTOHc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Apr 2020 10:07:32 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C23ED20722;
        Mon, 20 Apr 2020 14:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587391651;
        bh=lsTsK4tMTQTTg2oR94IVZpIA3Jlj2j2FlMak3udifXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=08y0Obow73hyezLQLio+EKYZVQ2rqnOZcXbv+a1Pz73raz1VqmPP3vICIkgMtSsgP
         Ts2Kzb28JTQR3J1wmxB36RdaHY5zRNc1lqA4h9N6Lg+zhPUkzFCRJTyB6Iuh2qSt+X
         haeDtJgrS5QILlz/r4U5mRps6B1YgEMqqTdUM/iE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-core 06/12] librdmacm: Connect rdma_connect to the ECE
Date:   Mon, 20 Apr 2020 17:06:42 +0300
Message-Id: <20200420140648.275554-7-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200420140648.275554-1-leon@kernel.org>
References: <20200420140648.275554-1-leon@kernel.org>
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
index a12ed1e0..91735225 100644
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
 	uint32_t qp_num = conn_param ? conn_param->qp_num : 0;
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
2.25.2

