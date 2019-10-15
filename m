Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1FCD708A
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 09:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfJOHy1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 03:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbfJOHy0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Oct 2019 03:54:26 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B704C21835;
        Tue, 15 Oct 2019 07:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571126066;
        bh=fzmfYyUIBDeCYnRP+IbEyle3JpWMSQGxD3w9CCZqeM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=18O3WfjhVHYkoKwCa9yxKbcsArk00H6M6dBxawDhWl+tn3JdOoh9/NeMx05c1Nbtw
         kgFXP/rCnKioPbAbrojXgicpSNwf9cmPYtw4zXS8aqvle0nUfjN7J9Zq4gWWdVNiTm
         xWKtoaja1P1DlZFbKM7KCSPSJTdwoQ4zpnEUXMlg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next v1 1/2] RDMA/uapi: Fix and re-organize the usage of rdma_driver_id
Date:   Tue, 15 Oct 2019 10:54:18 +0300
Message-Id: <20191015075419.18185-2-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191015075419.18185-1-leon@kernel.org>
References: <20191015075419.18185-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Fix 'enum rdma_driver_id' to preserve other driver values before that
RDMA_DRIVER_CXGB3 was deleted. As this value is UAPI we can't affect
other values as of a deletion of one driver id.

Fixes: 30e0f6cf5acb ("RDMA/iw_cxgb3: Remove the iw_cxgb3 module from kernel")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 include/uapi/rdma/ib_user_ioctl_verbs.h  | 22 ++++++++++++++++++++++
 include/uapi/rdma/rdma_user_ioctl_cmds.h | 21 ---------------------
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index 72c7fc75f960..9019b2d906ea 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
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
diff --git a/include/uapi/rdma/rdma_user_ioctl_cmds.h b/include/uapi/rdma/rdma_user_ioctl_cmds.h
index b2680051047a..7b1ec806f8f9 100644
--- a/include/uapi/rdma/rdma_user_ioctl_cmds.h
+++ b/include/uapi/rdma/rdma_user_ioctl_cmds.h
@@ -84,25 +84,4 @@ struct ib_uverbs_ioctl_hdr {
 	struct ib_uverbs_attr  attrs[0];
 };
 
-enum rdma_driver_id {
-	RDMA_DRIVER_UNKNOWN,
-	RDMA_DRIVER_MLX5,
-	RDMA_DRIVER_MLX4,
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
2.20.1

