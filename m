Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A63F1B0DEA
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 16:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgDTOHN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 10:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:32802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728096AbgDTOHN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Apr 2020 10:07:13 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0F9020722;
        Mon, 20 Apr 2020 14:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587391632;
        bh=auOebHeb9DM0OYl0HYTXRpyHXNQgPHZmCx1EZ+5NncQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RS1QeTD/RECfXew4fvyq547htiF2OH4LSomoH9CDKQ4frbGGML0aZuoKKGMF+itXc
         gW6oX4xmlSzur4JKPsjc9r//j1OTfBN1sGNF2ztPxMuLUnc0q2nI8b0sYiXLc9gD+U
         UPeH7L5PvESvMPIS7wC5cpTnEiOosLPZhRFrz92E=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-core 01/12] Update kernel headers
Date:   Mon, 20 Apr 2020 17:06:37 +0300
Message-Id: <20200420140648.275554-2-leon@kernel.org>
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

To commit ?? ("RDMA/mlx5: Verify that QP is created with RQ or SQ")

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 kernel-headers/rdma/mlx5_user_ioctl_cmds.h |  6 ++++++
 kernel-headers/rdma/rdma_user_cm.h         | 15 ++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel-headers/rdma/mlx5_user_ioctl_cmds.h b/kernel-headers/rdma/mlx5_user_ioctl_cmds.h
index 24f3388c..8e316ef8 100644
--- a/kernel-headers/rdma/mlx5_user_ioctl_cmds.h
+++ b/kernel-headers/rdma/mlx5_user_ioctl_cmds.h
@@ -241,6 +241,11 @@ enum mlx5_ib_flow_type {
 	MLX5_IB_FLOW_TYPE_MC_DEFAULT,
 };

+enum mlx5_ib_create_flow_flags {
+	MLX5_IB_ATTR_CREATE_FLOW_FLAGS_DEFAULT_MISS = 1 << 0,
+	MLX5_IB_ATTR_CREATE_FLOW_FLAGS_DROP = 1 << 1,
+};
+
 enum mlx5_ib_create_flow_attrs {
 	MLX5_IB_ATTR_CREATE_FLOW_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
 	MLX5_IB_ATTR_CREATE_FLOW_MATCH_VALUE,
@@ -251,6 +256,7 @@ enum mlx5_ib_create_flow_attrs {
 	MLX5_IB_ATTR_CREATE_FLOW_TAG,
 	MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX,
 	MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX_OFFSET,
+	MLX5_IB_ATTR_CREATE_FLOW_FLAGS,
 };

 enum mlx5_ib_destoy_flow_attrs {
diff --git a/kernel-headers/rdma/rdma_user_cm.h b/kernel-headers/rdma/rdma_user_cm.h
index e42940a2..e545f2de 100644
--- a/kernel-headers/rdma/rdma_user_cm.h
+++ b/kernel-headers/rdma/rdma_user_cm.h
@@ -78,6 +78,10 @@ enum rdma_ucm_port_space {
 	RDMA_PS_UDP   = 0x0111,
 };

+enum rdma_ucm_reject_reason {
+	RDMA_USER_CM_REJ_VENDOR_OPTION_NOT_SUPPORTED = 35
+};
+
 /*
  * command ABI structures.
  */
@@ -206,10 +210,16 @@ struct rdma_ucm_ud_param {
 	__u8  reserved[7];
 };

+struct rdma_ucm_ece {
+	__u32 vendor_id;
+	__u32 attr_mod;
+};
+
 struct rdma_ucm_connect {
 	struct rdma_ucm_conn_param conn_param;
 	__u32 id;
 	__u32 reserved;
+	struct rdma_ucm_ece ece;
 };

 struct rdma_ucm_listen {
@@ -222,12 +232,14 @@ struct rdma_ucm_accept {
 	struct rdma_ucm_conn_param conn_param;
 	__u32 id;
 	__u32 reserved;
+	struct rdma_ucm_ece ece;
 };

 struct rdma_ucm_reject {
 	__u32 id;
 	__u8  private_data_len;
-	__u8  reserved[3];
+	__u8  reason; /* enum rdma_ucm_reject_reason */
+	__u8  reserved[2];
 	__u8  private_data[RDMA_MAX_PRIVATE_DATA];
 };

@@ -287,6 +299,7 @@ struct rdma_ucm_event_resp {
 		struct rdma_ucm_ud_param   ud;
 	} param;
 	__u32 reserved;
+	struct rdma_ucm_ece ece;
 };

 /* Option levels */
--
2.25.2

