Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249112299D2
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 16:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbgGVOJX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 10:09:23 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:18282 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgGVOJX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 10:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595426963; x=1626962963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NObQeByPyLR/0urkZ5EnXylPUMHuNKIijYeyXRHMRSs=;
  b=vFAatw1xUQih8CegVI+9Aa/iAJndUjfHGvy0B1/5sthYMISTiTRVhHuM
   Xbxsxb16fV91sJjgb0Mgt3nnmKSNWrjXK9UXENF37s9m7hIAAAPGMYkBk
   VPo5wiWyCu7oMS5fqMZBBSaPYQ/lpT9BHtKXyrVvSsH4AQg+GFlXySBni
   c=;
IronPort-SDR: zEobFT7z/0AdngIePfj5eOESNEdIJPI/B5QMJMXbsFteqBlOdzy4b1L5T9k3kuBih7uumYUtEo
 gLbNCD+UaD8Q==
X-IronPort-AV: E=Sophos;i="5.75,383,1589241600"; 
   d="scan'208";a="60717774"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 22 Jul 2020 14:03:39 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS id C534BA2C08;
        Wed, 22 Jul 2020 14:03:38 +0000 (UTC)
Received: from EX13D02EUB003.ant.amazon.com (10.43.166.172) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 22 Jul 2020 14:03:38 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D02EUB003.ant.amazon.com (10.43.166.172) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 22 Jul 2020 14:03:37 +0000
Received: from 8c85908914bf.ant.amazon.com (10.95.83.32) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 22 Jul 2020 14:03:33 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Shadi Ammouri <sammouri@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next v4 3/4] RDMA/efa: User/kernel compatibility handshake mechanism
Date:   Wed, 22 Jul 2020 17:03:11 +0300
Message-ID: <20200722140312.3651-4-galpress@amazon.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722140312.3651-1-galpress@amazon.com>
References: <20200722140312.3651-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Introduce a mechanism that performs an handshake between the userspace
provider and kernel driver which verifies that the user supports all
required features in order to operate correctly.

The handshake verifies the needed functionality by comparing the
reported device caps and the provider caps. If the device reports a
non-zero capability the appropriate comp mask is required from the
userspace provider in order to allocate the context.

Reviewed-by: Shadi Ammouri <sammouri@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 40 +++++++++++++++++++++++++++
 include/uapi/rdma/efa-abi.h           | 10 +++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 26102ab333b2..fda175836fb6 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1501,11 +1501,39 @@ static int efa_dealloc_uar(struct efa_dev *dev, u16 uarn)
 	return efa_com_dealloc_uar(&dev->edev, &params);
 }
 
+#define EFA_CHECK_USER_COMP(_dev, _comp_mask, _attr, _mask, _attr_str) \
+	(_attr_str = (!(_dev)->dev_attr._attr || ((_comp_mask) & (_mask))) ? \
+		     NULL : #_attr)
+
+static int efa_user_comp_handshake(const struct ib_ucontext *ibucontext,
+				   const struct efa_ibv_alloc_ucontext_cmd *cmd)
+{
+	struct efa_dev *dev = to_edev(ibucontext->device);
+	char *attr_str;
+
+	if (EFA_CHECK_USER_COMP(dev, cmd->comp_mask, max_tx_batch,
+				EFA_ALLOC_UCONTEXT_CMD_COMP_TX_BATCH, attr_str))
+		goto err;
+
+	if (EFA_CHECK_USER_COMP(dev, cmd->comp_mask, min_sq_depth,
+				EFA_ALLOC_UCONTEXT_CMD_COMP_MIN_SQ_WR,
+				attr_str))
+		goto err;
+
+	return 0;
+
+err:
+	ibdev_dbg(&dev->ibdev, "Userspace handshake failed for %s attribute\n",
+		  attr_str);
+	return -EOPNOTSUPP;
+}
+
 int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
 {
 	struct efa_ucontext *ucontext = to_eucontext(ibucontext);
 	struct efa_dev *dev = to_edev(ibucontext->device);
 	struct efa_ibv_alloc_ucontext_resp resp = {};
+	struct efa_ibv_alloc_ucontext_cmd cmd = {};
 	struct efa_com_alloc_uar_result result;
 	int err;
 
@@ -1514,6 +1542,18 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
 	 * we will ack input fields in our response.
 	 */
 
+	err = ib_copy_from_udata(&cmd, udata,
+				 min(sizeof(cmd), udata->inlen));
+	if (err) {
+		ibdev_dbg(&dev->ibdev,
+			  "Cannot copy udata for alloc_ucontext\n");
+		goto err_out;
+	}
+
+	err = efa_user_comp_handshake(ibucontext, &cmd);
+	if (err)
+		goto err_out;
+
 	err = efa_com_alloc_uar(&dev->edev, &result);
 	if (err)
 		goto err_out;
diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
index 7ef2306f8dd4..507a2862bedb 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -20,6 +20,16 @@
  * hex bit offset of the field.
  */
 
+enum {
+	EFA_ALLOC_UCONTEXT_CMD_COMP_TX_BATCH  = 1 << 0,
+	EFA_ALLOC_UCONTEXT_CMD_COMP_MIN_SQ_WR = 1 << 1,
+};
+
+struct efa_ibv_alloc_ucontext_cmd {
+	__u32 comp_mask;
+	__u8 reserved_20[4];
+};
+
 enum efa_ibv_user_cmds_supp_udata {
 	EFA_USER_CMDS_SUPP_UDATA_QUERY_DEVICE = 1 << 0,
 	EFA_USER_CMDS_SUPP_UDATA_CREATE_AH    = 1 << 1,
-- 
2.27.0

