Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E06BE6ECA
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 10:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387878AbfJ1JP7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 05:15:59 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:37886 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387876AbfJ1JP6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 05:15:58 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 28 Oct 2019 11:15:52 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x9S9Fq4N032487;
        Mon, 28 Oct 2019 11:15:52 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id x9S9FqL3031551;
        Mon, 28 Oct 2019 11:15:52 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id x9S9FqXZ031550;
        Mon, 28 Oct 2019 11:15:52 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     yishaih@mellanox.com, haggaie@mellanox.com, jgg@mellanox.com,
        maorg@mellanox.com
Subject: [PATCH rdma-core 1/6] Update kernel headers
Date:   Mon, 28 Oct 2019 11:14:54 +0200
Message-Id: <1572254099-30864-2-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1572254099-30864-1-git-send-email-yishaih@mellanox.com>
References: <1572254099-30864-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To commit 45b268543a8d ("RDMA/uapi: Fix and re-organize the usage of
rdma_driver_id")

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 kernel-headers/rdma/ib_user_ioctl_verbs.h  | 22 ++++++++++++++++++++++
 kernel-headers/rdma/rdma_user_ioctl_cmds.h | 22 ----------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/kernel-headers/rdma/ib_user_ioctl_verbs.h b/kernel-headers/rdma/ib_user_ioctl_verbs.h
index 72c7fc7..9019b2d 100644
--- a/kernel-headers/rdma/ib_user_ioctl_verbs.h
+++ b/kernel-headers/rdma/ib_user_ioctl_verbs.h
@@ -173,4 +173,26 @@ struct ib_uverbs_query_port_resp_ex {
 	__u8  reserved[6];
 };
 
+enum rdma_driver_id {
+	RDMA_DRIVER_UNKNOWN,
+	RDMA_DRIVER_MLX5,
+	RDMA_DRIVER_MLX4,
+	RDMA_DRIVER_CXGB3,
+	RDMA_DRIVER_CXGB4,
+	RDMA_DRIVER_MTHCA,
+	RDMA_DRIVER_BNXT_RE,
+	RDMA_DRIVER_OCRDMA,
+	RDMA_DRIVER_NES,
+	RDMA_DRIVER_I40IW,
+	RDMA_DRIVER_VMW_PVRDMA,
+	RDMA_DRIVER_QEDR,
+	RDMA_DRIVER_HNS,
+	RDMA_DRIVER_USNIC,
+	RDMA_DRIVER_RXE,
+	RDMA_DRIVER_HFI1,
+	RDMA_DRIVER_QIB,
+	RDMA_DRIVER_EFA,
+	RDMA_DRIVER_SIW,
+};
+
 #endif
diff --git a/kernel-headers/rdma/rdma_user_ioctl_cmds.h b/kernel-headers/rdma/rdma_user_ioctl_cmds.h
index b8bb285..7b1ec80 100644
--- a/kernel-headers/rdma/rdma_user_ioctl_cmds.h
+++ b/kernel-headers/rdma/rdma_user_ioctl_cmds.h
@@ -84,26 +84,4 @@ struct ib_uverbs_ioctl_hdr {
 	struct ib_uverbs_attr  attrs[0];
 };
 
-enum rdma_driver_id {
-	RDMA_DRIVER_UNKNOWN,
-	RDMA_DRIVER_MLX5,
-	RDMA_DRIVER_MLX4,
-	RDMA_DRIVER_CXGB3,
-	RDMA_DRIVER_CXGB4,
-	RDMA_DRIVER_MTHCA,
-	RDMA_DRIVER_BNXT_RE,
-	RDMA_DRIVER_OCRDMA,
-	RDMA_DRIVER_NES,
-	RDMA_DRIVER_I40IW,
-	RDMA_DRIVER_VMW_PVRDMA,
-	RDMA_DRIVER_QEDR,
-	RDMA_DRIVER_HNS,
-	RDMA_DRIVER_USNIC,
-	RDMA_DRIVER_RXE,
-	RDMA_DRIVER_HFI1,
-	RDMA_DRIVER_QIB,
-	RDMA_DRIVER_EFA,
-	RDMA_DRIVER_SIW,
-};
-
 #endif
-- 
1.8.3.1

