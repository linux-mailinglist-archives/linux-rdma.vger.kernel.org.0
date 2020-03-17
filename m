Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E74E11885FE
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 14:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgCQNkg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 09:40:36 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41445 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726278AbgCQNkg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Mar 2020 09:40:36 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 17 Mar 2020 15:40:30 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02HDeUhd028750;
        Tue, 17 Mar 2020 15:40:30 +0200
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        loberman@redhat.com, bvanassche@acm.org, linux-rdma@vger.kernel.org
Cc:     kbusch@kernel.org, leonro@mellanox.com, jgg@mellanox.com,
        dledford@redhat.com, idanb@mellanox.com, shlomin@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 2/5] nvmet-rdma: add srq pointer to rdma_cmd
Date:   Tue, 17 Mar 2020 15:40:27 +0200
Message-Id: <20200317134030.152833-3-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200317134030.152833-1-maxg@mellanox.com>
References: <20200317134030.152833-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a preparetion patch for the SRQ per completion vector feature.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/target/rdma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 37d262a..04062af 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -38,6 +38,7 @@ struct nvmet_rdma_cmd {
 	struct scatterlist	inline_sg[NVMET_RDMA_MAX_INLINE_SGE];
 	struct nvme_command     *nvme_cmd;
 	struct nvmet_rdma_queue	*queue;
+	struct ib_srq		*srq;
 };
 
 enum {
@@ -461,8 +462,8 @@ static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
 		cmd->sge[0].addr, cmd->sge[0].length,
 		DMA_FROM_DEVICE);
 
-	if (ndev->srq)
-		ret = ib_post_srq_recv(ndev->srq, &cmd->wr, NULL);
+	if (cmd->srq)
+		ret = ib_post_srq_recv(cmd->srq, &cmd->wr, NULL);
 	else
 		ret = ib_post_recv(cmd->queue->cm_id->qp, &cmd->wr, NULL);
 
@@ -882,6 +883,7 @@ static int nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
 	ndev->srq_size = srq_size;
 
 	for (i = 0; i < srq_size; i++) {
+		ndev->srq_cmds[i].srq = srq;
 		ret = nvmet_rdma_post_recv(ndev, &ndev->srq_cmds[i]);
 		if (ret)
 			goto out_free_cmds;
-- 
1.8.3.1

