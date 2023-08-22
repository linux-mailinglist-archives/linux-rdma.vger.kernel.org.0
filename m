Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F048C783BB8
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 10:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbjHVI1f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 04:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjHVI1e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 04:27:34 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A426A19C
        for <linux-rdma@vger.kernel.org>; Tue, 22 Aug 2023 01:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1692692852; x=1724228852;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iGB2NN4dZVZuggxY1t/eqGBjGc5hRzV5an8ooaesPZk=;
  b=Fx4NNUtvppIpZ9fGv7gJsQtieA7GlVRu5LpruLTv8g/wXTfeppfNljiX
   rafTjSCO1NxJFTiy92UJ0twSO0meqdvdara2q33W3rcQFQSYv43u7G28o
   asuUH++uWo+SWzEGWqaYid/KjB5d3fwPnpyGlQcN/WcF+aBa0NCuo3GmZ
   U=;
X-IronPort-AV: E=Sophos;i="6.01,192,1684800000"; 
   d="scan'208";a="346664273"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 08:27:29 +0000
Received: from EX19D002EUC003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com (Postfix) with ESMTPS id 666EBA0BB1;
        Tue, 22 Aug 2023 08:27:28 +0000 (UTC)
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D002EUC003.ant.amazon.com (10.252.51.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 22 Aug 2023 08:27:27 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1118.30 via Frontend Transport; Tue, 22 Aug 2023 08:27:26
 +0000
From:   <ynachum@amazon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <sleybo@amazon.com>, <matua@amazon.com>,
        Yonatan Nachum <ynachum@amazon.com>,
        Michael Margolin <mrgolin@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Fix wrong resources deallocation order
Date:   Tue, 22 Aug 2023 08:27:25 +0000
Message-ID: <20230822082725.31719-1-ynachum@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yonatan Nachum <ynachum@amazon.com>

When trying to destroy QP or CQ, we first decrease the refcount and
potentially free memory regions allocated for the object and then
request the device to destroy the object. If the device fails, the
object isn't fully destroyed so the user/IB core can try to destroy the
object again which will lead to underflow when trying to decrease an
already zeroed refcount.
Deallocate resources in reverse order of allocating them to safely free
them.

Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 7a27d79c0541..0f8ca99d0827 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -453,12 +453,12 @@ int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 
 	ibdev_dbg(&dev->ibdev, "Destroy qp[%u]\n", ibqp->qp_num);
 
-	efa_qp_user_mmap_entries_remove(qp);
-
 	err = efa_destroy_qp_handle(dev, qp->qp_handle);
 	if (err)
 		return err;
 
+	efa_qp_user_mmap_entries_remove(qp);
+
 	if (qp->rq_cpu_addr) {
 		ibdev_dbg(&dev->ibdev,
 			  "qp->cpu_addr[0x%p] freed: size[%lu], dma[%pad]\n",
@@ -1017,8 +1017,8 @@ int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 		  "Destroy cq[%d] virt[0x%p] freed: size[%lu], dma[%pad]\n",
 		  cq->cq_idx, cq->cpu_addr, cq->size, &cq->dma_addr);
 
-	efa_cq_user_mmap_entries_remove(cq);
 	efa_destroy_cq_idx(dev, cq->cq_idx);
+	efa_cq_user_mmap_entries_remove(cq);
 	if (cq->eq) {
 		xa_erase(&dev->cqs_xa, cq->cq_idx);
 		synchronize_irq(cq->eq->irq.irqn);
-- 
2.40.1

