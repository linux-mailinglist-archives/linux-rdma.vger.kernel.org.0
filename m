Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6F0911C9A7
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfLLJlI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:41:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728502AbfLLJlH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:41:07 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6567924654;
        Thu, 12 Dec 2019 09:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143667;
        bh=iFwda6z+vNdO4cuTzIsNZeZBiFK7U/cCbN1syCdcSYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=15I+nJWZ1GcnkFPKP+Bzmdkn9GuEqMB1snUGA5c7wtQW6Wh4/1YZVuxedcUjBYjik
         AnVC5Au5RZmMVzQvsrWGDhThlpyBtKE2rLZEg2/k/FfV2UlU7AOxbj29SUaXec7v6E
         s0FyPuaHf3dotRbpm8oWPUJurhXiFDhUqfURuRgE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 47/48] RDMA/cm: Add Enhanced Connection Establishment (ECE) bits
Date:   Thu, 12 Dec 2019 11:38:29 +0200
Message-Id: <20191212093830.316934-48-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212093830.316934-1-leon@kernel.org>
References: <20191212093830.316934-1-leon@kernel.org>
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
 include/rdma/ib_cm.h         | 3 ++-
 include/rdma/ibta_vol1_c12.h | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

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
diff --git a/include/rdma/ibta_vol1_c12.h b/include/rdma/ibta_vol1_c12.h
index f937865fe6b5..6fc4f1b89ca6 100644
--- a/include/rdma/ibta_vol1_c12.h
+++ b/include/rdma/ibta_vol1_c12.h
@@ -112,8 +112,11 @@
 #define CM_REP_REMOTE_COMM_ID CM_FIELD32_LOC(struct cm_rep_msg, 4, 32)
 #define CM_REP_LOCAL_Q_KEY CM_FIELD32_LOC(struct cm_rep_msg, 8, 32)
 #define CM_REP_LOCAL_QPN CM_FIELD32_LOC(struct cm_rep_msg, 12, 24)
+#define CM_REP_VENDORID_H CM_FIELD8_LOC(struct cm_rep_msg, 15, 8)
 #define CM_REP_LOCAL_EE_CONTEXT_NUMBER CM_FIELD32_LOC(struct cm_rep_msg, 16, 24)
+#define CM_REP_VENDORID_M CM_FIELD8_LOC(struct cm_rep_msg, 19, 8)
 #define CM_REP_STARTING_PSN CM_FIELD32_LOC(struct cm_rep_msg, 20, 24)
+#define CM_REP_VENDORID_L CM_FIELD8_LOC(struct cm_rep_msg, 23, 8)
 #define CM_REP_RESPONDER_RESOURCES CM_FIELD8_LOC(struct cm_rep_msg, 24, 8)
 #define CM_REP_INITIATOR_DEPTH CM_FIELD8_LOC(struct cm_rep_msg, 25, 8)
 #define CM_REP_TARGET_ACK_DELAY CM_FIELD8_LOC(struct cm_rep_msg, 26, 5)
@@ -194,7 +197,9 @@
 #define CM_SIDR_REP_STATUS CM_FIELD8_LOC(struct cm_sidr_rep_msg, 4, 8)
 #define CM_SIDR_REP_ADDITIONAL_INFORMATION_LENGTH                              \
 	CM_FIELD8_LOC(struct cm_sidr_rep_msg, 5, 8)
+#define CM_SIDR_REP_VENDORID_H CM_FIELD16_LOC(struct cm_sidr_rep_msg, 6, 16)
 #define CM_SIDR_REP_QPN CM_FIELD32_LOC(struct cm_sidr_rep_msg, 8, 24)
+#define CM_SIDR_REP_VENDORID_L CM_FIELD8_LOC(struct cm_sidr_rep_msg, 11, 8)
 #define CM_SIDR_REP_SERVICEID CM_FIELD64_LOC(struct cm_sidr_rep_msg, 12, 64)
 #define CM_SIDR_REP_Q_KEY CM_FIELD32_LOC(struct cm_sidr_rep_msg, 20, 32)
 #define CM_SIDR_REP_ADDITIONAL_INFORMATION                                     \
-- 
2.20.1

