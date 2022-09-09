Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D625B3428
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Sep 2022 11:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiIIJil (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Sep 2022 05:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiIIJib (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Sep 2022 05:38:31 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680DEA2216
        for <linux-rdma@vger.kernel.org>; Fri,  9 Sep 2022 02:38:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VP9-tfX_1662716307;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VP9-tfX_1662716307)
          by smtp.aliyun-inc.com;
          Fri, 09 Sep 2022 17:38:27 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 4/4] RDMA/erdma: Support dynamic mtu
Date:   Fri,  9 Sep 2022 17:38:22 +0800
Message-Id: <20220909093822.33868-5-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220909093822.33868-1-chengyou@linux.alibaba.com>
References: <20220909093822.33868-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hardware now support jumbo frame for RDMA. So we introduce a new CMDQ
message to support mtu change notification.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma.h       |  1 +
 drivers/infiniband/hw/erdma/erdma_hw.h    |  6 ++++++
 drivers/infiniband/hw/erdma/erdma_main.c  |  8 +++++++-
 drivers/infiniband/hw/erdma/erdma_verbs.c | 11 +++++++++++
 drivers/infiniband/hw/erdma/erdma_verbs.h |  1 +
 5 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
index cc5e4eb3a21e..730783fbc894 100644
--- a/drivers/infiniband/hw/erdma/erdma.h
+++ b/drivers/infiniband/hw/erdma/erdma.h
@@ -197,6 +197,7 @@ struct erdma_dev {
 	struct erdma_devattr attrs;
 	/* physical port state (only one port per device) */
 	enum ib_port_state state;
+	u32 mtu;
 
 	/* cmdq and aeq use the same msix vector */
 	struct erdma_irq comm_irq;
diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index 3004cf3ac481..e788887732e1 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -153,6 +153,7 @@ enum CMDQ_COMMON_OPCODE {
 	CMDQ_OPCODE_CREATE_EQ = 0,
 	CMDQ_OPCODE_DESTROY_EQ = 1,
 	CMDQ_OPCODE_QUERY_FW_INFO = 2,
+	CMDQ_OPCODE_CONF_MTU = 3,
 };
 
 /* cmdq-SQE HDR */
@@ -190,6 +191,11 @@ struct erdma_cmdq_destroy_eq_req {
 	u8 qtype;
 };
 
+struct erdma_cmdq_config_mtu_req {
+	u64 hdr;
+	u32 mtu;
+};
+
 /* create_cq cfg0 */
 #define ERDMA_CMD_CREATE_CQ_DEPTH_MASK GENMASK(31, 24)
 #define ERDMA_CMD_CREATE_CQ_PAGESIZE_MASK GENMASK(23, 20)
diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 6d3e02ba9e77..49778bb294ae 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -34,10 +34,15 @@ static int erdma_netdev_event(struct notifier_block *nb, unsigned long event,
 		dev->state = IB_PORT_DOWN;
 		erdma_port_event(dev, IB_EVENT_PORT_ERR);
 		break;
+	case NETDEV_CHANGEMTU:
+		if (dev->mtu != netdev->mtu) {
+			erdma_set_mtu(dev, netdev->mtu);
+			dev->mtu = netdev->mtu;
+		}
+		break;
 	case NETDEV_REGISTER:
 	case NETDEV_UNREGISTER:
 	case NETDEV_CHANGEADDR:
-	case NETDEV_CHANGEMTU:
 	case NETDEV_GOING_DOWN:
 	case NETDEV_CHANGE:
 	default:
@@ -95,6 +100,7 @@ static int erdma_device_register(struct erdma_dev *dev)
 	if (ret)
 		return ret;
 
+	dev->mtu = dev->netdev->mtu;
 	addrconf_addr_eui48((u8 *)&ibdev->node_guid, dev->netdev->dev_addr);
 
 	ret = ib_register_device(ibdev, "erdma_%d", &dev->pdev->dev);
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index aea93d08af95..62be98e2b941 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1436,6 +1436,17 @@ int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	return ret;
 }
 
+void erdma_set_mtu(struct erdma_dev *dev, u32 mtu)
+{
+	struct erdma_cmdq_config_mtu_req req;
+
+	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_COMMON,
+				CMDQ_OPCODE_CONF_MTU);
+	req.mtu = mtu;
+
+	erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+}
+
 void erdma_port_event(struct erdma_dev *dev, enum ib_event_type reason)
 {
 	struct ib_event event;
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index fe93e1ac9674..ab6380635e9e 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -330,5 +330,6 @@ struct ib_mr *erdma_ib_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 int erdma_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 		    unsigned int *sg_offset);
 void erdma_port_event(struct erdma_dev *dev, enum ib_event_type reason);
+void erdma_set_mtu(struct erdma_dev *dev, u32 mtu);
 
 #endif
-- 
2.27.0

