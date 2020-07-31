Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E335D233EE0
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jul 2020 08:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbgGaGEv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jul 2020 02:04:51 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:16455 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbgGaGEv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 Jul 2020 02:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596175491; x=1627711491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kxLr1SK8RuiduvBQVfVS0+UMmlXNvkG3luFus9Lq6HI=;
  b=fTO7KxSo4GE7AEyiPCLw0/oeWbnlob072YcLyXPH6c5CtLW0JgrGWFSy
   GiWyKiHcpqJfMLb1Xjq7ojJs5JdQqErRqPyuiX/KCsJfUSb7giNraKbhU
   M/06lf1wDMssWYhDjXTHld/+/Jqua8e7wrNNstNzjB89wizijNTpJhzLi
   0=;
IronPort-SDR: t6NENh0QERjo/PloZperoTCBlH7a9c0VMW/hHfpPog54JRIbNOd1G5B8WztTB/TsrehDwcfXpJ
 SxlAnoKgUp5w==
X-IronPort-AV: E=Sophos;i="5.75,417,1589241600"; 
   d="scan'208";a="46638251"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 31 Jul 2020 06:04:49 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id A3F8FA2041;
        Fri, 31 Jul 2020 06:04:48 +0000 (UTC)
Received: from EX13D19EUB004.ant.amazon.com (10.43.166.61) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 31 Jul 2020 06:04:47 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D19EUB004.ant.amazon.com (10.43.166.61) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 31 Jul 2020 06:04:46 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.212.6) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 31 Jul 2020 06:04:44 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        "Yossi Leybovich" <sleybo@amazon.com>
Subject: [PATCH for-next 2/4] RDMA/efa: Be consistent with modify QP bitmask
Date:   Fri, 31 Jul 2020 09:04:18 +0300
Message-ID: <20200731060420.17053-3-galpress@amazon.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200731060420.17053-1-galpress@amazon.com>
References: <20200731060420.17053-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The modify QP bitmask was not consistent with other bitmasks used in the
device interface. Remove the bitmask enum and allow usage with
EFA_GET/SET.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 24 +++++++++++--------
 drivers/infiniband/hw/efa/efa_verbs.c         | 14 ++++++-----
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index bef2bd291054..fadf1ad2e13a 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -68,14 +68,6 @@ enum efa_admin_get_stats_scope {
 	EFA_ADMIN_GET_STATS_SCOPE_QUEUE             = 1,
 };
 
-enum efa_admin_modify_qp_mask_bits {
-	EFA_ADMIN_QP_STATE_BIT                      = 0,
-	EFA_ADMIN_CUR_QP_STATE_BIT                  = 1,
-	EFA_ADMIN_QKEY_BIT                          = 2,
-	EFA_ADMIN_SQ_PSN_BIT                        = 3,
-	EFA_ADMIN_SQ_DRAINED_ASYNC_NOTIFY_BIT       = 4,
-};
-
 /*
  * QP allocation sizes, converted by fabric QueuePair (QP) create command
  * from QP capabilities.
@@ -199,8 +191,13 @@ struct efa_admin_modify_qp_cmd {
 	struct efa_admin_aq_common_desc aq_common_desc;
 
 	/*
-	 * Mask indicating which fields should be updated see enum
-	 * efa_admin_modify_qp_mask_bits
+	 * Mask indicating which fields should be updated
+	 * 0 : qp_state
+	 * 1 : cur_qp_state
+	 * 2 : qkey
+	 * 3 : sq_psn
+	 * 4 : sq_drained_async_notify
+	 * 31:5 : reserved
 	 */
 	u32 modify_mask;
 
@@ -851,6 +848,13 @@ struct efa_admin_host_info {
 #define EFA_ADMIN_CREATE_QP_CMD_SQ_VIRT_MASK                BIT(0)
 #define EFA_ADMIN_CREATE_QP_CMD_RQ_VIRT_MASK                BIT(1)
 
+/* modify_qp_cmd */
+#define EFA_ADMIN_MODIFY_QP_CMD_QP_STATE_MASK               BIT(0)
+#define EFA_ADMIN_MODIFY_QP_CMD_CUR_QP_STATE_MASK           BIT(1)
+#define EFA_ADMIN_MODIFY_QP_CMD_QKEY_MASK                   BIT(2)
+#define EFA_ADMIN_MODIFY_QP_CMD_SQ_PSN_MASK                 BIT(3)
+#define EFA_ADMIN_MODIFY_QP_CMD_SQ_DRAINED_ASYNC_NOTIFY_MASK BIT(4)
+
 /* reg_mr_cmd */
 #define EFA_ADMIN_REG_MR_CMD_PHYS_PAGE_SIZE_SHIFT_MASK      GENMASK(4, 0)
 #define EFA_ADMIN_REG_MR_CMD_MEM_ADDR_PHY_MODE_EN_MASK      BIT(7)
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index d5654fecf430..c66bfe1b386a 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -803,25 +803,27 @@ int efa_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	params.qp_handle = qp->qp_handle;
 
 	if (qp_attr_mask & IB_QP_STATE) {
-		params.modify_mask |= BIT(EFA_ADMIN_QP_STATE_BIT) |
-				      BIT(EFA_ADMIN_CUR_QP_STATE_BIT);
+		EFA_SET(&params.modify_mask, EFA_ADMIN_MODIFY_QP_CMD_QP_STATE,
+			1);
+		EFA_SET(&params.modify_mask,
+			EFA_ADMIN_MODIFY_QP_CMD_CUR_QP_STATE, 1);
 		params.cur_qp_state = qp_attr->cur_qp_state;
 		params.qp_state = qp_attr->qp_state;
 	}
 
 	if (qp_attr_mask & IB_QP_EN_SQD_ASYNC_NOTIFY) {
-		params.modify_mask |=
-			BIT(EFA_ADMIN_SQ_DRAINED_ASYNC_NOTIFY_BIT);
+		EFA_SET(&params.modify_mask,
+			EFA_ADMIN_MODIFY_QP_CMD_SQ_DRAINED_ASYNC_NOTIFY, 1);
 		params.sq_drained_async_notify = qp_attr->en_sqd_async_notify;
 	}
 
 	if (qp_attr_mask & IB_QP_QKEY) {
-		params.modify_mask |= BIT(EFA_ADMIN_QKEY_BIT);
+		EFA_SET(&params.modify_mask, EFA_ADMIN_MODIFY_QP_CMD_QKEY, 1);
 		params.qkey = qp_attr->qkey;
 	}
 
 	if (qp_attr_mask & IB_QP_SQ_PSN) {
-		params.modify_mask |= BIT(EFA_ADMIN_SQ_PSN_BIT);
+		EFA_SET(&params.modify_mask, EFA_ADMIN_MODIFY_QP_CMD_SQ_PSN, 1);
 		params.sq_psn = qp_attr->sq_psn;
 	}
 
-- 
2.27.0

