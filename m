Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3262225994
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jul 2020 10:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgGTIBz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jul 2020 04:01:55 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:14447 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgGTIBy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jul 2020 04:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595232114; x=1626768114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nd5cTpzvBEW3bME0QgeJ7poe/+hUeRst1fyzSB7rY54=;
  b=smS+ZstHMAFS+QKFVvsFYm0cRv2r4piXQqMEVpTrpHmBA7/SUHEOJ5t3
   0Wz2yTYaHjvvLdkWsfGn4Um3+rF7+MVLaCdHf0JVIVKT/6vIlBgEJvJN5
   qBSrI2z9/S4zSOfv4m8nXC5m525TFEhJyAH/8nQpLtiRXvedCiVgOughh
   g=;
IronPort-SDR: WWfOUMbHNLnQfeAKrZI1T4jIHs62VmgCJmXmR3gaowdGd9Vd7RRKZckgsIFsB9pCCcjMwUl76E
 sCEo3ozFDR8w==
X-IronPort-AV: E=Sophos;i="5.75,374,1589241600"; 
   d="scan'208";a="42882035"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 20 Jul 2020 08:01:53 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id 57A8EA403F;
        Mon, 20 Jul 2020 08:01:52 +0000 (UTC)
Received: from EX13D22EUA003.ant.amazon.com (10.43.165.210) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 20 Jul 2020 08:01:51 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D22EUA003.ant.amazon.com (10.43.165.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 20 Jul 2020 08:01:50 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.212.12) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 20 Jul 2020 08:01:46 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Shadi Ammouri <sammouri@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next v2 3/4] RDMA/efa: User/kernel compatibility handshake mechanism
Date:   Mon, 20 Jul 2020 11:01:12 +0300
Message-ID: <20200720080113.13055-4-galpress@amazon.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720080113.13055-1-galpress@amazon.com>
References: <20200720080113.13055-1-galpress@amazon.com>
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
 drivers/infiniband/hw/efa/efa_verbs.c | 60 +++++++++++++++++++++++++++
 include/uapi/rdma/efa-abi.h           | 10 +++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 26102ab333b2..f60bf9ce656f 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1501,11 +1501,59 @@ static int efa_dealloc_uar(struct efa_dev *dev, u16 uarn)
 	return efa_com_dealloc_uar(&dev->edev, &params);
 }
 
+#define DEFINE_GET_DEV_ATTR_FUNC(_attr)                                        \
+	bool dev_attr_##_attr(const struct efa_dev *dev)                       \
+	{                                                                      \
+		return dev->dev_attr._attr;                                    \
+	}
+
+#define DEFINE_CHECK_COMP_FUNC(_attr, _mask)                                   \
+	bool check_comp_##_attr(const struct efa_dev *dev, u32 comp_mask)      \
+	{                                                                      \
+		return !dev_attr_##_attr(dev) || (comp_mask & (_mask));        \
+	}
+
+#define DEFINE_COMP_HANDSHAKE(_attr, _mask)                                    \
+	{                                                                      \
+		.attr = #_attr,                                                \
+		.check_comp = ({                                               \
+			DEFINE_GET_DEV_ATTR_FUNC(_attr)                        \
+			DEFINE_CHECK_COMP_FUNC(_attr, _mask)                   \
+			check_comp_##_attr;                                    \
+		}),                                                            \
+	}
+
+int efa_user_comp_handshake(const struct ib_ucontext *ibucontext,
+			    const struct efa_ibv_alloc_ucontext_cmd *cmd)
+{
+	struct {
+		char *attr;
+		bool (*check_comp)(const struct efa_dev *dev, u32 comp_mask);
+	} user_comp_handshakes[] = {
+		DEFINE_COMP_HANDSHAKE(max_tx_batch, EFA_ALLOC_UCONTEXT_CMD_COMP_TX_BATCH),
+		DEFINE_COMP_HANDSHAKE(min_sq_depth, EFA_ALLOC_UCONTEXT_CMD_COMP_MIN_SQ_WR),
+	};
+	struct efa_dev *dev = to_edev(ibucontext->device);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(user_comp_handshakes); i++) {
+		if (!user_comp_handshakes[i].check_comp(dev, cmd->comp_mask)) {
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
 
@@ -1514,6 +1562,18 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
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

