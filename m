Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCC8E8067
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 07:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbfJ2GaT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 02:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730227AbfJ2GaT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 02:30:19 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9989121835;
        Tue, 29 Oct 2019 06:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572330618;
        bh=WRWKQ1Emfoh6cnSSrhJQSNRmwJk9YI/WUZKIEIy7Wyw=;
        h=From:To:Cc:Subject:Date:From;
        b=RFMFa1ky9ghj8dyHk5w1jmicbBn0QCZKwvIzBVK8YowoxnDhjaQYyDBb/DmJm9map
         EMvL+ihflV8Fqf57tBSmhSDXstaOAditYjKiH7OP62gwCrrnpq2/VOhKSWOvxBaAZo
         FcEduAx7kLpqfJzQK6Frg+5YQCDkeOg5MKeKcqNs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next] RDMA/cm: Add Enhanced Connection Establishment (ECE) bits
Date:   Tue, 29 Oct 2019 08:30:14 +0200
Message-Id: <20191029063014.10437-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Extend REQ (request for communications), REP (reply to request
for communication), rejected reason and SIDR_REP (service ID
resolution response) structures with hardware vendor ID bits
according to approved IBA Comment #9434.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm_msgs.h | 12 ++++++++++++
 include/rdma/ib_cm.h              |  3 ++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index dba60f8dfafb..8c92e71b55ca 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -91,6 +91,8 @@
 
 #define CM_REQ_LOCAL_COMM_ID_OFFSET 0
 #define CM_REQ_LOCAL_COMM_ID_MASK GENMASK(31, 0)
+#define CM_REQ_VENDORID_OFFSET 5
+#define CM_REQ_VENDORID_MASK GENMASK(24, 0)
 #define CM_REQ_SERVICE_ID_OFFSET 8
 #define CM_REQ_SERVICE_ID_MASK GENMASK_ULL(63, 0)
 #define CM_REQ_LOCAL_CA_GUID_OFFSET 16
@@ -220,10 +222,16 @@
 #define CM_REP_LOCAL_Q_KEY_MASK GENMASK(31, 0)
 #define CM_REP_LOCAL_QPN_OFFSET 12
 #define CM_REP_LOCAL_QPN_MASK GENMASK(23, 0)
+#define CM_REP_VENDORID_H_OFFSET 15
+#define CM_REP_VENDORID_H_MASK GENMASK(7, 0)
 #define CM_REP_LOCAL_EE_CONTEXT_NUMBER_OFFSET 16
 #define CM_REP_LOCAL_EE_CONTEXT_NUMBER_MASK GENMASK(23, 0)
+#define CM_REP_VENDORID_M_OFFSET 19
+#define CM_REP_VENDORID_M_MASK GENMASK(7, 0)
 #define CM_REP_STARTING_PSN_OFFSET 20
 #define CM_REP_STARTING_PSN_MASK GENMASK(23, 0)
+#define CM_REP_VENDORID_L_OFFSET 23
+#define CM_REP_VENDORID_L_MASK GENMASK(7, 0)
 #define CM_REP_RESPONDER_RESOURCES_OFFSET 24
 #define CM_REP_RESPONDED_RESOURCES_MASK GENMASK(7, 0)
 #define CM_REP_INITIATOR_DEPTH_OFFSET 25
@@ -333,8 +341,12 @@
 #define CM_SIDR_REP_STATUS_MASK GENMASK(7, 0)
 #define CM_SIDR_REP_ADDITIONAL_INFORMATION_LENGTH_OFFSET 5
 #define CM_SIDR_REP_ADDITIONAL_INFORMATION_LENGTH_MASK GENMASK(7, 0)
+#define CM_SIDR_REP_VENDORID_H_OFFSET 6
+#define CM_SIDR_REP_VENDORID_H_MASK GENMASK(15, 0)
 #define CM_SIDR_REP_QPN_OFFSET 8
 #define CM_SIDR_REP_QPN_MASK GENMASK(23, 0)
+#define CM_SIDR_REP_VENDORID_L_OFFSET 11
+#define CM_SIDR_REP_VENDORID_L_MASK GENMASK(7, 0)
 #define CM_SIDR_REP_SERVICEID_OFFSET 12
 #define CM_SIDR_REP_SERVICEID_MASK GENMASK_ULL(63, 0)
 #define CM_SIDR_REP_Q_KEY_OFFSET 20
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index adccdc12b8e3..72348475eee8 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -147,7 +147,8 @@ enum ib_cm_rej_reason {
 	IB_CM_REJ_DUPLICATE_LOCAL_COMM_ID	= 30,
 	IB_CM_REJ_INVALID_CLASS_VERSION		= 31,
 	IB_CM_REJ_INVALID_FLOW_LABEL		= 32,
-	IB_CM_REJ_INVALID_ALT_FLOW_LABEL	= 33
+	IB_CM_REJ_INVALID_ALT_FLOW_LABEL	= 33,
+	IB_CM_REJ_VENDOR_OPTION_NOT_SUPPORTED	= 35
 };
 
 struct ib_cm_rej_event_param {
-- 
2.20.1

