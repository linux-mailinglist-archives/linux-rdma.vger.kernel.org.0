Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DED7FD708B
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 09:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfJOHya (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 03:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbfJOHya (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Oct 2019 03:54:30 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E03292089C;
        Tue, 15 Oct 2019 07:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571126069;
        bh=D9gSbgOWgzRWyD3FpGUn4JyfOe44/LL2l+kpzsTF0bY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g0CHjko5T1Ir6IzIPJZ6dWLbMDNc6J7c4uHHv8i4F/lRwiRmoTDtOvtTfVVnayHJ9
         2bWqWG+X/H+eQDN7JoOvNHyJJ76GH5GB5DY+N0nCy7loCrIMZQvMFWJ7MM/56H81dw
         LCA8b9vNaDronDBfQr/X3BW5huQhhJNSvd2f9/24=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next v1 2/2] RDMA/uapi: Drop the dependency of ib_user_ioctl_verbs.h on ib_user_verbs.h
Date:   Tue, 15 Oct 2019 10:54:19 +0300
Message-Id: <20191015075419.18185-3-leon@kernel.org>
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

Drop the dependency of ib_user_ioctl_verbs.h on ib_user_verbs.h which
is not really required.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 include/uapi/rdma/ib_user_ioctl_verbs.h | 26 ++++++++++++++++++++++++-
 include/uapi/rdma/ib_user_verbs.h       | 25 ------------------------
 2 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index 9019b2d906ea..8bdfdd4ef8b5 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -35,7 +35,6 @@
 #define IB_USER_IOCTL_VERBS_H
 
 #include <linux/types.h>
-#include <rdma/ib_user_verbs.h>
 
 #ifndef RDMA_UAPI_PTR
 #define RDMA_UAPI_PTR(_type, _name)	__aligned_u64 _name
@@ -167,6 +166,31 @@ enum ib_uverbs_advise_mr_flag {
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
-- 
2.20.1

