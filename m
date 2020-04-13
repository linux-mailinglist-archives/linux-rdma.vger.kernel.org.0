Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375A11A67A9
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 16:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbgDMOPr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 10:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730417AbgDMOPr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Apr 2020 10:15:47 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D45872075E;
        Mon, 13 Apr 2020 14:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586787346;
        bh=yg9kjRlhaUbO0GFwyKue04SZJXVSMHZEJaWW3dsxKTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QdOqCmVcB0iaq/RZv6QLS+az9oRGD/N+/Tn6xAqPJaBQ/syf2p2LMVmhS9khYxv5j
         yC9JJcmUUJ8Db+DVDgfRowA6aEIJ4sW5YwZGRHXDEe4aH0Xg80vRWj38xAuOWsZwoL
         pWtFNpG9/kf1yp5BrGJHY99QPnL9MwfKdjbyQDyg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 1/7] RDMA/cm: Add Enhanced Connection Establishment (ECE) bits
Date:   Mon, 13 Apr 2020 17:15:32 +0300
Message-Id: <20200413141538.935574-2-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200413141538.935574-1-leon@kernel.org>
References: <20200413141538.935574-1-leon@kernel.org>
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
according to IBTA v1.4.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 include/rdma/ibta_vol1_c12.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/rdma/ibta_vol1_c12.h b/include/rdma/ibta_vol1_c12.h
index 269904425d3f..960c86bec76c 100644
--- a/include/rdma/ibta_vol1_c12.h
+++ b/include/rdma/ibta_vol1_c12.h
@@ -38,6 +38,7 @@
 
 /* Table 106 REQ Message Contents */
 #define CM_REQ_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_req_msg, 0, 32)
+#define CM_REQ_VENDOR_ID CM_FIELD32_LOC(struct cm_req_msg, 5, 24)
 #define CM_REQ_SERVICE_ID CM_FIELD64_LOC(struct cm_req_msg, 8)
 #define CM_REQ_LOCAL_CA_GUID CM_FIELD64_LOC(struct cm_req_msg, 16)
 #define CM_REQ_LOCAL_Q_KEY CM_FIELD32_LOC(struct cm_req_msg, 28, 32)
@@ -119,8 +120,11 @@ CM_STRUCT(struct cm_rej_msg, 84 * 8 + 1184);
 #define CM_REP_REMOTE_COMM_ID CM_FIELD32_LOC(struct cm_rep_msg, 4, 32)
 #define CM_REP_LOCAL_Q_KEY CM_FIELD32_LOC(struct cm_rep_msg, 8, 32)
 #define CM_REP_LOCAL_QPN CM_FIELD32_LOC(struct cm_rep_msg, 12, 24)
+#define CM_REP_VENDOR_ID_H CM_FIELD8_LOC(struct cm_rep_msg, 15, 8)
 #define CM_REP_LOCAL_EE_CONTEXT_NUMBER CM_FIELD32_LOC(struct cm_rep_msg, 16, 24)
+#define CM_REP_VENDOR_ID_M CM_FIELD8_LOC(struct cm_rep_msg, 19, 8)
 #define CM_REP_STARTING_PSN CM_FIELD32_LOC(struct cm_rep_msg, 20, 24)
+#define CM_REP_VENDOR_ID_L CM_FIELD8_LOC(struct cm_rep_msg, 23, 8)
 #define CM_REP_RESPONDER_RESOURCES CM_FIELD8_LOC(struct cm_rep_msg, 24, 8)
 #define CM_REP_INITIATOR_DEPTH CM_FIELD8_LOC(struct cm_rep_msg, 25, 8)
 #define CM_REP_TARGET_ACK_DELAY CM_FIELD8_LOC(struct cm_rep_msg, 26, 5)
@@ -201,7 +205,9 @@ CM_STRUCT(struct cm_sidr_req_msg, 16 * 8 + 1728);
 #define CM_SIDR_REP_STATUS CM_FIELD8_LOC(struct cm_sidr_rep_msg, 4, 8)
 #define CM_SIDR_REP_ADDITIONAL_INFORMATION_LENGTH                              \
 	CM_FIELD8_LOC(struct cm_sidr_rep_msg, 5, 8)
+#define CM_SIDR_REP_VENDOR_ID_H CM_FIELD16_LOC(struct cm_sidr_rep_msg, 6, 16)
 #define CM_SIDR_REP_QPN CM_FIELD32_LOC(struct cm_sidr_rep_msg, 8, 24)
+#define CM_SIDR_REP_VENDOR_ID_L CM_FIELD8_LOC(struct cm_sidr_rep_msg, 11, 8)
 #define CM_SIDR_REP_SERVICEID CM_FIELD64_LOC(struct cm_sidr_rep_msg, 12)
 #define CM_SIDR_REP_Q_KEY CM_FIELD32_LOC(struct cm_sidr_rep_msg, 20, 32)
 #define CM_SIDR_REP_ADDITIONAL_INFORMATION                                     \
-- 
2.25.2

