Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDFDD28B3
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 14:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfJJMFr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 08:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbfJJMFr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Oct 2019 08:05:47 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D6EE20650;
        Thu, 10 Oct 2019 12:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570709145;
        bh=WwG7hcF3+2Fb9Qquld+kqX/95MLz0nWTl/uORGzBk+A=;
        h=From:To:Cc:Subject:Date:From;
        b=N3d82p/bF6w8K8rvM1Lczu1RNrzXwY9B2WxJThV4zBatOOVwcYwQHK1QML5TXQoMJ
         18SdL04cJMPZMMk70aZylbGJ8iZ6WcCk+b7qGN8S3QgVN/Tnx+XxIEUZn1TtVgweQe
         tvSlrAuHHB+p9Xjoc1d1oVu9fYuLKamaSLLP7Jo4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-next] RDMA/uapi: Fix and re-organize the usage of rdma_driver_id
Date:   Thu, 10 Oct 2019 15:05:41 +0300
Message-Id: <20191010120541.30841-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Fix 'enum rdma_driver_id' to preserve other driver values before that
RDMA_DRIVER_CXGB3 was deleted.  As this value is UAPI we can't affect
other values as of a deletion of one driver id.

In addition,
- Expose 'enum rdma_driver_id' to user applications by moving it to
  ib_user_ioctl_verbs.h which is exposed in rdma-core to applications.

- Drop the dependency of ib_user_ioctl_verbs.h on ib_user_verbs.h which
  is not really required.

Fixes: 30e0f6cf5acb ("RDMA/iw_cxgb3: Remove the iw_cxgb3 module from kernel")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 include/uapi/rdma/ib_user_ioctl_verbs.h  | 47 +++++++++++++++++++++++-
 include/uapi/rdma/ib_user_verbs.h        | 25 -------------
 include/uapi/rdma/rdma_user_ioctl_cmds.h | 21 -----------
 3 files changed, 46 insertions(+), 47 deletions(-)

diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index 72c7fc75f960..3d703be40012 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -35,7 +35,6 @@
 #define IB_USER_IOCTL_VERBS_H
 
 #include <linux/types.h>
-#include <rdma/ib_user_verbs.h>
 
 #ifndef RDMA_UAPI_PTR
 #define RDMA_UAPI_PTR(_type, _name)	__aligned_u64 _name
@@ -167,10 +166,56 @@ enum ib_uverbs_advise_mr_flag {
 	IB_UVERBS_ADVISE_MR_FLAG_FLUSH = 1 << 0,
 };
 
+struct ib_uverbs_query_port_resp {
+	__u32 port_cap_flags;		/* see ib_uverbs_query_port_cap_flags */
+	__u32 max_msg_sz;
+	__u32 bad_pkey_cntr;
+	__u32 qkey_viol_cntr;
+	__u32 gid_tbl_len;
+	__u16 pkey_tbl_len;
+	__u16 lid;
+	__u16 sm_lid;
+	__u8  state;
+	__u8  max_mtu;
+	__u8  active_mtu;
+	__u8  lmc;
+	__u8  max_vl_num;
+	__u8  sm_sl;
+	__u8  subnet_timeout;
+	__u8  init_type_reply;
+	__u8  active_width;
+	__u8  active_speed;
+	__u8  phys_state;
+	__u8  link_layer;
+	__u8  flags;			/* see ib_uverbs_query_port_flags */
+	__u8  reserved;
+};
+
 struct ib_uverbs_query_port_resp_ex {
 	struct ib_uverbs_query_port_resp legacy_resp;
 	__u16 port_cap_flags2;
 	__u8  reserved[6];
 };
 
+enum rdma_driver_id {
+	RDMA_DRIVER_UNKNOWN,
+	RDMA_DRIVER_MLX5,
+	RDMA_DRIVER_MLX4,
+	RDMA_DRIVER_CXGB4 = 4,
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
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 0474c7400268..37450f133a07 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -281,31 +281,6 @@ struct ib_uverbs_query_port {
 	__aligned_u64 driver_data[0];
 };
 
-struct ib_uverbs_query_port_resp {
-	__u32 port_cap_flags;		/* see ib_uverbs_query_port_cap_flags */
-	__u32 max_msg_sz;
-	__u32 bad_pkey_cntr;
-	__u32 qkey_viol_cntr;
-	__u32 gid_tbl_len;
-	__u16 pkey_tbl_len;
-	__u16 lid;
-	__u16 sm_lid;
-	__u8  state;
-	__u8  max_mtu;
-	__u8  active_mtu;
-	__u8  lmc;
-	__u8  max_vl_num;
-	__u8  sm_sl;
-	__u8  subnet_timeout;
-	__u8  init_type_reply;
-	__u8  active_width;
-	__u8  active_speed;
-	__u8  phys_state;
-	__u8  link_layer;
-	__u8  flags;			/* see ib_uverbs_query_port_flags */
-	__u8  reserved;
-};
-
 struct ib_uverbs_alloc_pd {
 	__aligned_u64 response;
 	__aligned_u64 driver_data[0];
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

