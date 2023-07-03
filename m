Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30158745FEE
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jul 2023 17:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjGCPeR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jul 2023 11:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGCPeR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jul 2023 11:34:17 -0400
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F78E58
        for <linux-rdma@vger.kernel.org>; Mon,  3 Jul 2023 08:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1688398456; x=1719934456;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QdJsZGHElp+59iYnPZCsEvqhb2xdWB4h9Y8DcL1miFw=;
  b=Xp+V/QiqrGrbpHYLGvF4c4VbFzsJuXGZ6fd86rXbsmkyQIvOXAlXe1uu
   94o6IAyjynJkyOz3YIauM8XGaQdVCM6R2JLIMe8zmbgapX1KgKu0y8tF/
   OkmTk4K3O5h4qinKwH+xSGzNgIkjW3YhVhFoaFSSqplhUbX8V8LsEK0EB
   Q=;
X-IronPort-AV: E=Sophos;i="6.01,178,1684800000"; 
   d="scan'208";a="658409821"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 15:34:08 +0000
Received: from EX19D019EUA004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com (Postfix) with ESMTPS id 49172806B1;
        Mon,  3 Jul 2023 15:34:08 +0000 (UTC)
Received: from EX19D022EUA002.ant.amazon.com (10.252.50.201) by
 EX19D019EUA004.ant.amazon.com (10.252.50.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 3 Jul 2023 15:34:07 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D022EUA002.ant.amazon.com (10.252.50.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 3 Jul 2023 15:34:06 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server id 15.2.1118.30 via Frontend Transport; Mon, 3 Jul 2023 15:34:05 +0000
From:   Michael Margolin <mrgolin@amazon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
        "Daniel Kranzdorf" <dkkranzd@amazon.com>,
        Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH] RDMA/efa: Add RDMA write HW statistics counters
Date:   Mon, 3 Jul 2023 15:34:04 +0000
Message-ID: <20230703153404.30877-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Update device API and request RDMA write counters if RDMA write is
supported by device. Expose newly added counters through ib core
counters mechanism.

Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 .../infiniband/hw/efa/efa_admin_cmds_defs.h    | 13 +++++++++++++
 drivers/infiniband/hw/efa/efa_com_cmd.c        |  8 +++++++-
 drivers/infiniband/hw/efa/efa_com_cmd.h        | 10 +++++++++-
 drivers/infiniband/hw/efa/efa_verbs.c          | 18 ++++++++++++++++++
 4 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index 4e93ef7f84ee..9c65bd27bae0 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -66,6 +66,7 @@ enum efa_admin_get_stats_type {
 	EFA_ADMIN_GET_STATS_TYPE_BASIC              = 0,
 	EFA_ADMIN_GET_STATS_TYPE_MESSAGES           = 1,
 	EFA_ADMIN_GET_STATS_TYPE_RDMA_READ          = 2,
+	EFA_ADMIN_GET_STATS_TYPE_RDMA_WRITE         = 3,
 };
 
 enum efa_admin_get_stats_scope {
@@ -570,6 +571,16 @@ struct efa_admin_rdma_read_stats {
 	u64 read_resp_bytes;
 };
 
+struct efa_admin_rdma_write_stats {
+	u64 write_wrs;
+
+	u64 write_bytes;
+
+	u64 write_wr_err;
+
+	u64 write_recv_bytes;
+};
+
 struct efa_admin_acq_get_stats_resp {
 	struct efa_admin_acq_common_desc acq_common_desc;
 
@@ -579,6 +590,8 @@ struct efa_admin_acq_get_stats_resp {
 		struct efa_admin_messages_stats messages_stats;
 
 		struct efa_admin_rdma_read_stats rdma_read_stats;
+
+		struct efa_admin_rdma_write_stats rdma_write_stats;
 	} u;
 };
 
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 8f8885e002ba..576811885d59 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2023 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include "efa_com.h"
@@ -794,6 +794,12 @@ int efa_com_get_stats(struct efa_com_dev *edev,
 		result->rdma_read_stats.read_wr_err = resp.u.rdma_read_stats.read_wr_err;
 		result->rdma_read_stats.read_resp_bytes = resp.u.rdma_read_stats.read_resp_bytes;
 		break;
+	case EFA_ADMIN_GET_STATS_TYPE_RDMA_WRITE:
+		result->rdma_write_stats.write_wrs = resp.u.rdma_write_stats.write_wrs;
+		result->rdma_write_stats.write_bytes = resp.u.rdma_write_stats.write_bytes;
+		result->rdma_write_stats.write_wr_err = resp.u.rdma_write_stats.write_wr_err;
+		result->rdma_write_stats.write_recv_bytes = resp.u.rdma_write_stats.write_recv_bytes;
+		break;
 	}
 
 	return 0;
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index 0898ad5bc340..fc97f37bb39b 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2023 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_COM_CMD_H_
@@ -262,10 +262,18 @@ struct efa_com_rdma_read_stats {
 	u64 read_resp_bytes;
 };
 
+struct efa_com_rdma_write_stats {
+	u64 write_wrs;
+	u64 write_bytes;
+	u64 write_wr_err;
+	u64 write_recv_bytes;
+};
+
 union efa_com_get_stats_result {
 	struct efa_com_basic_stats basic_stats;
 	struct efa_com_messages_stats messages_stats;
 	struct efa_com_rdma_read_stats rdma_read_stats;
+	struct efa_com_rdma_write_stats rdma_write_stats;
 };
 
 int efa_com_create_qp(struct efa_com_dev *edev,
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 2a195c4b0f17..7a27d79c0541 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -61,6 +61,10 @@ struct efa_user_mmap_entry {
 	op(EFA_RDMA_READ_BYTES, "rdma_read_bytes") \
 	op(EFA_RDMA_READ_WR_ERR, "rdma_read_wr_err") \
 	op(EFA_RDMA_READ_RESP_BYTES, "rdma_read_resp_bytes") \
+	op(EFA_RDMA_WRITE_WRS, "rdma_write_wrs") \
+	op(EFA_RDMA_WRITE_BYTES, "rdma_write_bytes") \
+	op(EFA_RDMA_WRITE_WR_ERR, "rdma_write_wr_err") \
+	op(EFA_RDMA_WRITE_RECV_BYTES, "rdma_write_recv_bytes") \
 
 #define EFA_STATS_ENUM(ename, name) ename,
 #define EFA_STATS_STR(ename, nam) \
@@ -2080,6 +2084,7 @@ static int efa_fill_port_stats(struct efa_dev *dev, struct rdma_hw_stats *stats,
 {
 	struct efa_com_get_stats_params params = {};
 	union efa_com_get_stats_result result;
+	struct efa_com_rdma_write_stats *rws;
 	struct efa_com_rdma_read_stats *rrs;
 	struct efa_com_messages_stats *ms;
 	struct efa_com_basic_stats *bs;
@@ -2121,6 +2126,19 @@ static int efa_fill_port_stats(struct efa_dev *dev, struct rdma_hw_stats *stats,
 	stats->value[EFA_RDMA_READ_WR_ERR] = rrs->read_wr_err;
 	stats->value[EFA_RDMA_READ_RESP_BYTES] = rrs->read_resp_bytes;
 
+	if (EFA_DEV_CAP(dev, RDMA_WRITE)) {
+		params.type = EFA_ADMIN_GET_STATS_TYPE_RDMA_WRITE;
+		err = efa_com_get_stats(&dev->edev, &params, &result);
+		if (err)
+			return err;
+
+		rws = &result.rdma_write_stats;
+		stats->value[EFA_RDMA_WRITE_WRS] = rws->write_wrs;
+		stats->value[EFA_RDMA_WRITE_BYTES] = rws->write_bytes;
+		stats->value[EFA_RDMA_WRITE_WR_ERR] = rws->write_wr_err;
+		stats->value[EFA_RDMA_WRITE_RECV_BYTES] = rws->write_recv_bytes;
+	}
+
 	return ARRAY_SIZE(efa_port_stats_descs);
 }
 
-- 
2.40.1

