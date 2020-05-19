Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C3D1D90FE
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 09:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgESH1d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 03:27:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728260AbgESH1d (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 May 2020 03:27:33 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24C9F2075F;
        Tue, 19 May 2020 07:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589873252;
        bh=wJUSDyqcDuK+kBhWDE7JYEj47u+YJJKlRlhBTHxvcSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YnrADm0yRhka5beIlI4OqK2xlr62YSGz7kVZsW1ReN8TpziQAM9xVUcLsvkpLpl2Y
         TzupRo8mrVCjPkba8/L76quPqUspUuz26gLC5Dj8BBWYEz8sqE05MQ71MH9PH5XAy8
         L5aQvVbgsScNFS9U8UEUBV9WLl1BMR8NUwDhF/tk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 4/7] IB/uverbs: Move QP, SRQ, WQ type and flags to UAPI
Date:   Tue, 19 May 2020 10:27:08 +0300
Message-Id: <20200519072711.257271-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519072711.257271-1-leon@kernel.org>
References: <20200519072711.257271-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

These constants are going to be used in the ioctl interface in coming
patches so they are part of the UAPI, place them in the correct header
for clarity.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 include/rdma/ib_verbs.h                 | 43 ++++++++++++++-----------
 include/uapi/rdma/ib_user_ioctl_verbs.h | 34 +++++++++++++++++++
 2 files changed, 58 insertions(+), 19 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index b8b5b5310529..9cf2d9d05c06 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1012,9 +1012,9 @@ enum ib_cq_notify_flags {
 };
 
 enum ib_srq_type {
-	IB_SRQT_BASIC,
-	IB_SRQT_XRC,
-	IB_SRQT_TM,
+	IB_SRQT_BASIC = IB_UVERBS_SRQT_BASIC,
+	IB_SRQT_XRC = IB_UVERBS_SRQT_XRC,
+	IB_SRQT_TM = IB_UVERBS_SRQT_TM,
 };
 
 static inline bool ib_srq_has_cq(enum ib_srq_type srq_type)
@@ -1083,16 +1083,16 @@ enum ib_qp_type {
 	IB_QPT_SMI,
 	IB_QPT_GSI,
 
-	IB_QPT_RC,
-	IB_QPT_UC,
-	IB_QPT_UD,
+	IB_QPT_RC = IB_UVERBS_QPT_RC,
+	IB_QPT_UC = IB_UVERBS_QPT_UC,
+	IB_QPT_UD = IB_UVERBS_QPT_UD,
 	IB_QPT_RAW_IPV6,
 	IB_QPT_RAW_ETHERTYPE,
-	IB_QPT_RAW_PACKET = 8,
-	IB_QPT_XRC_INI = 9,
-	IB_QPT_XRC_TGT,
+	IB_QPT_RAW_PACKET = IB_UVERBS_QPT_RAW_PACKET,
+	IB_QPT_XRC_INI = IB_UVERBS_QPT_XRC_INI,
+	IB_QPT_XRC_TGT = IB_UVERBS_QPT_XRC_TGT,
 	IB_QPT_MAX,
-	IB_QPT_DRIVER = 0xFF,
+	IB_QPT_DRIVER = IB_UVERBS_QPT_DRIVER,
 	/* Reserve a range for qp types internal to the low level driver.
 	 * These qp types will not be visible at the IB core layer, so the
 	 * IB_QPT_MAX usages should not be affected in the core layer
@@ -1111,17 +1111,21 @@ enum ib_qp_type {
 
 enum ib_qp_create_flags {
 	IB_QP_CREATE_IPOIB_UD_LSO		= 1 << 0,
-	IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK	= 1 << 1,
+	IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK	=
+		IB_UVERBS_QP_CREATE_BLOCK_MULTICAST_LOOPBACK,
 	IB_QP_CREATE_CROSS_CHANNEL              = 1 << 2,
 	IB_QP_CREATE_MANAGED_SEND               = 1 << 3,
 	IB_QP_CREATE_MANAGED_RECV               = 1 << 4,
 	IB_QP_CREATE_NETIF_QP			= 1 << 5,
 	IB_QP_CREATE_INTEGRITY_EN		= 1 << 6,
 	/* FREE					= 1 << 7, */
-	IB_QP_CREATE_SCATTER_FCS		= 1 << 8,
-	IB_QP_CREATE_CVLAN_STRIPPING		= 1 << 9,
+	IB_QP_CREATE_SCATTER_FCS		=
+		IB_UVERBS_QP_CREATE_SCATTER_FCS,
+	IB_QP_CREATE_CVLAN_STRIPPING		=
+		IB_UVERBS_QP_CREATE_CVLAN_STRIPPING,
 	IB_QP_CREATE_SOURCE_QPN			= 1 << 10,
-	IB_QP_CREATE_PCI_WRITE_END_PADDING	= 1 << 11,
+	IB_QP_CREATE_PCI_WRITE_END_PADDING	=
+		IB_UVERBS_QP_CREATE_PCI_WRITE_END_PADDING,
 	/* reserve bits 26-31 for low level drivers' internal use */
 	IB_QP_CREATE_RESERVED_START		= 1 << 26,
 	IB_QP_CREATE_RESERVED_END		= 1 << 31,
@@ -1626,7 +1630,7 @@ enum ib_raw_packet_caps {
 };
 
 enum ib_wq_type {
-	IB_WQT_RQ
+	IB_WQT_RQ = IB_UVERBS_WQT_RQ,
 };
 
 enum ib_wq_state {
@@ -1649,10 +1653,11 @@ struct ib_wq {
 };
 
 enum ib_wq_flags {
-	IB_WQ_FLAGS_CVLAN_STRIPPING	= 1 << 0,
-	IB_WQ_FLAGS_SCATTER_FCS		= 1 << 1,
-	IB_WQ_FLAGS_DELAY_DROP		= 1 << 2,
-	IB_WQ_FLAGS_PCI_WRITE_END_PADDING = 1 << 3,
+	IB_WQ_FLAGS_CVLAN_STRIPPING	= IB_UVERBS_WQ_FLAGS_CVLAN_STRIPPING,
+	IB_WQ_FLAGS_SCATTER_FCS		= IB_UVERBS_WQ_FLAGS_SCATTER_FCS,
+	IB_WQ_FLAGS_DELAY_DROP		= IB_UVERBS_WQ_FLAGS_DELAY_DROP,
+	IB_WQ_FLAGS_PCI_WRITE_END_PADDING =
+				IB_UVERBS_WQ_FLAGS_PCI_WRITE_END_PADDING,
 };
 
 struct ib_wq_init_attr {
diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index a640bb814be0..b1662dfe86a6 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -64,6 +64,40 @@ enum ib_uverbs_access_flags {
 		~(IB_UVERBS_ACCESS_OPTIONAL_FIRST - 1)
 };
 
+enum ib_uverbs_srq_type {
+	IB_UVERBS_SRQT_BASIC,
+	IB_UVERBS_SRQT_XRC,
+	IB_UVERBS_SRQT_TM,
+};
+
+enum ib_uverbs_wq_type {
+	IB_UVERBS_WQT_RQ,
+};
+
+enum ib_uverbs_wq_flags {
+	IB_UVERBS_WQ_FLAGS_CVLAN_STRIPPING = 1 << 0,
+	IB_UVERBS_WQ_FLAGS_SCATTER_FCS = 1 << 1,
+	IB_UVERBS_WQ_FLAGS_DELAY_DROP = 1 << 2,
+	IB_UVERBS_WQ_FLAGS_PCI_WRITE_END_PADDING = 1 << 3,
+};
+
+enum ib_uverbs_qp_type {
+	IB_UVERBS_QPT_RC = 2,
+	IB_UVERBS_QPT_UC,
+	IB_UVERBS_QPT_UD,
+	IB_UVERBS_QPT_RAW_PACKET = 8,
+	IB_UVERBS_QPT_XRC_INI,
+	IB_UVERBS_QPT_XRC_TGT,
+	IB_UVERBS_QPT_DRIVER = 0xFF,
+};
+
+enum ib_uverbs_qp_create_flags {
+	IB_UVERBS_QP_CREATE_BLOCK_MULTICAST_LOOPBACK = 1 << 1,
+	IB_UVERBS_QP_CREATE_SCATTER_FCS = 1 << 8,
+	IB_UVERBS_QP_CREATE_CVLAN_STRIPPING = 1 << 9,
+	IB_UVERBS_QP_CREATE_PCI_WRITE_END_PADDING = 1 << 11,
+};
+
 enum ib_uverbs_query_port_cap_flags {
 	IB_UVERBS_PCF_SM = 1 << 1,
 	IB_UVERBS_PCF_NOTICE_SUP = 1 << 2,
-- 
2.26.2

