Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4612A7E6360
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Nov 2023 06:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjKIFrK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Nov 2023 00:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjKIFq5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Nov 2023 00:46:57 -0500
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B4026BF;
        Wed,  8 Nov 2023 21:46:43 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="139093714"
X-IronPort-AV: E=Sophos;i="6.03,288,1694703600"; 
   d="scan'208";a="139093714"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 14:45:38 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 67D4AD6186;
        Thu,  9 Nov 2023 14:45:36 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id B28D8C8BFA;
        Thu,  9 Nov 2023 14:45:35 +0900 (JST)
Received: from localhost.localdomain (unknown [10.118.237.107])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 7F2062005323;
        Thu,  9 Nov 2023 14:45:35 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v7 3/7] RDMA/rxe: Move resp_states definition to rxe_verbs.h
Date:   Thu,  9 Nov 2023 14:44:48 +0900
Message-Id: <66c8c10009b4bf9e9d30ef5351976f519ee969c7.1699503619.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1699503619.git.matsuda-daisuke@fujitsu.com>
References: <cover.1699503619.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To use the resp_states values in rxe_loc.h, it is necessary to move the
definition to rxe_verbs.h, where other internal states of this driver are
defined.

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.h       | 37 ---------------------------
 drivers/infiniband/sw/rxe/rxe_verbs.h | 37 +++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index d33dd6cf83d3..9b4d044a1264 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -100,43 +100,6 @@
 #define rxe_info_mw(mw, fmt, ...) ibdev_info_ratelimited((mw)->ibmw.device, \
 		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
 
-/* responder states */
-enum resp_states {
-	RESPST_NONE,
-	RESPST_GET_REQ,
-	RESPST_CHK_PSN,
-	RESPST_CHK_OP_SEQ,
-	RESPST_CHK_OP_VALID,
-	RESPST_CHK_RESOURCE,
-	RESPST_CHK_LENGTH,
-	RESPST_CHK_RKEY,
-	RESPST_EXECUTE,
-	RESPST_READ_REPLY,
-	RESPST_ATOMIC_REPLY,
-	RESPST_ATOMIC_WRITE_REPLY,
-	RESPST_PROCESS_FLUSH,
-	RESPST_COMPLETE,
-	RESPST_ACKNOWLEDGE,
-	RESPST_CLEANUP,
-	RESPST_DUPLICATE_REQUEST,
-	RESPST_ERR_MALFORMED_WQE,
-	RESPST_ERR_UNSUPPORTED_OPCODE,
-	RESPST_ERR_MISALIGNED_ATOMIC,
-	RESPST_ERR_PSN_OUT_OF_SEQ,
-	RESPST_ERR_MISSING_OPCODE_FIRST,
-	RESPST_ERR_MISSING_OPCODE_LAST_C,
-	RESPST_ERR_MISSING_OPCODE_LAST_D1E,
-	RESPST_ERR_TOO_MANY_RDMA_ATM_REQ,
-	RESPST_ERR_RNR,
-	RESPST_ERR_RKEY_VIOLATION,
-	RESPST_ERR_INVALIDATE_RKEY,
-	RESPST_ERR_LENGTH,
-	RESPST_ERR_CQ_OVERFLOW,
-	RESPST_ERROR,
-	RESPST_DONE,
-	RESPST_EXIT,
-};
-
 void rxe_set_mtu(struct rxe_dev *rxe, unsigned int dev_mtu);
 
 int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index ccb9d19ffe8a..1058b5de8920 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -127,6 +127,43 @@ struct rxe_comp_info {
 	struct rxe_task		task;
 };
 
+/* responder states */
+enum resp_states {
+	RESPST_NONE,
+	RESPST_GET_REQ,
+	RESPST_CHK_PSN,
+	RESPST_CHK_OP_SEQ,
+	RESPST_CHK_OP_VALID,
+	RESPST_CHK_RESOURCE,
+	RESPST_CHK_LENGTH,
+	RESPST_CHK_RKEY,
+	RESPST_EXECUTE,
+	RESPST_READ_REPLY,
+	RESPST_ATOMIC_REPLY,
+	RESPST_ATOMIC_WRITE_REPLY,
+	RESPST_PROCESS_FLUSH,
+	RESPST_COMPLETE,
+	RESPST_ACKNOWLEDGE,
+	RESPST_CLEANUP,
+	RESPST_DUPLICATE_REQUEST,
+	RESPST_ERR_MALFORMED_WQE,
+	RESPST_ERR_UNSUPPORTED_OPCODE,
+	RESPST_ERR_MISALIGNED_ATOMIC,
+	RESPST_ERR_PSN_OUT_OF_SEQ,
+	RESPST_ERR_MISSING_OPCODE_FIRST,
+	RESPST_ERR_MISSING_OPCODE_LAST_C,
+	RESPST_ERR_MISSING_OPCODE_LAST_D1E,
+	RESPST_ERR_TOO_MANY_RDMA_ATM_REQ,
+	RESPST_ERR_RNR,
+	RESPST_ERR_RKEY_VIOLATION,
+	RESPST_ERR_INVALIDATE_RKEY,
+	RESPST_ERR_LENGTH,
+	RESPST_ERR_CQ_OVERFLOW,
+	RESPST_ERROR,
+	RESPST_DONE,
+	RESPST_EXIT,
+};
+
 enum rdatm_res_state {
 	rdatm_res_state_next,
 	rdatm_res_state_new,
-- 
2.39.1

