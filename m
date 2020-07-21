Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0542280F5
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jul 2020 15:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgGUNbY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jul 2020 09:31:24 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:57976 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgGUNbY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jul 2020 09:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595338284; x=1626874284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nxXCRA5OJEQr4Oj2d2r5A1eK1DPDEZaZ6EqrRtba188=;
  b=Ql8lpi6L65rhpJs5iatzQ5SH39xAgPo0VN9zZHhLpNBCC2htSwp8K6Px
   Tgu3FwOkIJb2lHqRBPzhPN4WdcX+atUNeFu5j7fc/ss787KEqlRDPoIBg
   1fnSlI9+5WuprRJbLMobCYLIhPFTG/Lmopsy7bA3WCbu7khRko1p5x5pN
   U=;
IronPort-SDR: MDic4SsZeK4tlAugTIHrpoJYs2/29FHFkeZr1abANaZ3daGAXTxBoIZpeqzR38VOz9pz1SkCkj
 zKCJoX3jkxoQ==
X-IronPort-AV: E=Sophos;i="5.75,378,1589241600"; 
   d="scan'208";a="61579205"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 21 Jul 2020 13:31:22 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 308A0224949;
        Tue, 21 Jul 2020 13:31:21 +0000 (UTC)
Received: from EX13D22EUB002.ant.amazon.com (10.43.166.131) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 21 Jul 2020 13:31:20 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D22EUB002.ant.amazon.com (10.43.166.131) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 21 Jul 2020 13:31:19 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.213.11) by
 mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 21 Jul 2020 13:31:15 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Shadi Ammouri <sammouri@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next v3 3/4] RDMA/efa: User/kernel compatibility handshake mechanism
Date:   Tue, 21 Jul 2020 16:30:48 +0300
Message-ID: <20200721133049.74349-4-galpress@amazon.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721133049.74349-1-galpress@amazon.com>
References: <20200721133049.74349-1-galpress@amazon.com>
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
 drivers/infiniband/hw/efa/efa_verbs.c | 49 +++++++++++++++++++++++++++
 include/uapi/rdma/efa-abi.h           | 10 ++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 26102ab333b2..7ca40df81ee5 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1501,11 +1501,48 @@ static int efa_dealloc_uar(struct efa_dev *dev, u16 uarn)
 	return efa_com_dealloc_uar(&dev->edev, &params);
 }
 
+#define EFA_CHECK_COMP(_dev, _comp_mask, _attr, _mask)                         \
+	(!(_dev)->dev_attr._attr || ((_comp_mask) & (_mask)))
+
+#define DEFINE_COMP_HANDSHAKE(_dev, _comp_mask, _attr, _mask)                  \
+	{                                                                      \
+		.attr = #_attr,                                                \
+		.check_comp = EFA_CHECK_COMP(_dev, _comp_mask, _attr, _mask)   \
+	}
+
+int efa_user_comp_handshake(const struct ib_ucontext *ibucontext,
+			    const struct efa_ibv_alloc_ucontext_cmd *cmd)
+{
+	struct efa_dev *dev = to_edev(ibucontext->device);
+	int i;
+	struct {
+		char *attr;
+		bool check_comp;
+	} user_comp_handshakes[] = {
+		DEFINE_COMP_HANDSHAKE(dev, cmd->comp_mask, max_tx_batch,
+				      EFA_ALLOC_UCONTEXT_CMD_COMP_TX_BATCH),
+		DEFINE_COMP_HANDSHAKE(dev, cmd->comp_mask, min_sq_depth,
+				      EFA_ALLOC_UCONTEXT_CMD_COMP_MIN_SQ_WR),
+	};
+
+	for (i = 0; i < ARRAY_SIZE(user_comp_handshakes); i++) {
+		if (!user_comp_handshakes[i].check_comp) {
+			ibdev_dbg(&dev->ibdev,
+				  "Userspace handshake failed for %s attribute\n",
+				  user_comp_handshakes[i].attr);
+			return -EOPNOTSUPP;
+		}
+	}
+
+	return 0;
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
 
@@ -1514,6 +1551,18 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
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

