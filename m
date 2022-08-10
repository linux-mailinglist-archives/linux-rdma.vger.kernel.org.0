Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62F758E4A2
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Aug 2022 03:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiHJBno (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Aug 2022 21:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiHJBnY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Aug 2022 21:43:24 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DAE6FA27
        for <linux-rdma@vger.kernel.org>; Tue,  9 Aug 2022 18:43:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VLss29u_1660095800;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VLss29u_1660095800)
          by smtp.aliyun-inc.com;
          Wed, 10 Aug 2022 09:43:21 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-rc] RDMA/erdma: Correct the max_qp and max_cq capacities of the device
Date:   Wed, 10 Aug 2022 09:43:19 +0800
Message-Id: <20220810014320.88026-1-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
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

QP0 in HW is used for CMDQ, and the rest is for RDMA QPs. So the actual
max_qp capacity reported to core should be max_qp (reported by HW) - 1.
So does max_cq.

Fixes: 155055771704 ("RDMA/erdma: Add verbs implementation")
Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index a7a3d42e2016..699bd3f59cd3 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -280,7 +280,7 @@ int erdma_query_device(struct ib_device *ibdev, struct ib_device_attr *attr,
 	attr->vendor_id = PCI_VENDOR_ID_ALIBABA;
 	attr->vendor_part_id = dev->pdev->device;
 	attr->hw_ver = dev->pdev->revision;
-	attr->max_qp = dev->attrs.max_qp;
+	attr->max_qp = dev->attrs.max_qp - 1;
 	attr->max_qp_wr = min(dev->attrs.max_send_wr, dev->attrs.max_recv_wr);
 	attr->max_qp_rd_atom = dev->attrs.max_ord;
 	attr->max_qp_init_rd_atom = dev->attrs.max_ird;
@@ -291,7 +291,7 @@ int erdma_query_device(struct ib_device *ibdev, struct ib_device_attr *attr,
 	attr->max_send_sge = dev->attrs.max_send_sge;
 	attr->max_recv_sge = dev->attrs.max_recv_sge;
 	attr->max_sge_rd = dev->attrs.max_sge_rd;
-	attr->max_cq = dev->attrs.max_cq;
+	attr->max_cq = dev->attrs.max_cq - 1;
 	attr->max_cqe = dev->attrs.max_cqe;
 	attr->max_mr = dev->attrs.max_mr;
 	attr->max_pd = dev->attrs.max_pd;
-- 
2.27.0

