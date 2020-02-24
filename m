Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADA716ABEF
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 17:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgBXQpw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 11:45:52 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46596 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727775AbgBXQpv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 11:45:51 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 24 Feb 2020 18:45:47 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 01OGji9e013647;
        Mon, 24 Feb 2020 18:45:47 +0200
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me,
        linux-rdma@vger.kernel.org, kbusch@kernel.org, hch@lst.de,
        martin.petersen@oracle.com
Cc:     vladimirk@mellanox.com, idanb@mellanox.com, maxg@mellanox.com,
        israelr@mellanox.com, axboe@kernel.dk, shlomin@mellanox.com
Subject: [PATCH 18/19] nvmet-rdma: Implement set_mdts controller op
Date:   Mon, 24 Feb 2020 18:45:43 +0200
Message-Id: <20200224164544.219438-20-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200224164544.219438-1-maxg@mellanox.com>
References: <20200224164544.219438-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Set the maximal data transfer size according to device capabilities.
For example, for T10-DIF offload by supporting RDMA HCA, one uses
RDMA/rw API that limits the IO operation to use a single MR with 256
pages at the most. Limit the mdts according to RDMA/rw API and even
decrease it in order to avoid multiple splits by the local block layer
for large IOs to ease on the CPU on the target side.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/target/rdma.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 37d262a..2227adf 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -30,6 +30,7 @@
 #define NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE	PAGE_SIZE
 #define NVMET_RDMA_MAX_INLINE_SGE		4
 #define NVMET_RDMA_MAX_INLINE_DATA_SIZE		max_t(int, SZ_16K, PAGE_SIZE)
+#define NVMET_RDMA_T10_PI_MDTS			5
 
 struct nvmet_rdma_cmd {
 	struct ib_sge		sge[NVMET_RDMA_MAX_INLINE_SGE + 1];
@@ -1602,6 +1603,21 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
 	}
 }
 
+static u8 nvmet_rdma_set_mdts(struct nvmet_ctrl *ctrl)
+{
+	struct nvmet_port *port = ctrl->port;
+	struct rdma_cm_id *cm_id = port->priv;
+	u32 max_pages;
+
+	if (ctrl->pi_support) {
+		max_pages = rdma_rw_fr_page_list_len(cm_id->device, true);
+		/* Assume mpsmin == device_page_size == 4KB */
+		return min(ilog2(max_pages), NVMET_RDMA_T10_PI_MDTS);
+	}
+
+	return 0;
+}
+
 static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_RDMA,
@@ -1612,6 +1628,7 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
 	.queue_response		= nvmet_rdma_queue_response,
 	.delete_ctrl		= nvmet_rdma_delete_ctrl,
 	.disc_traddr		= nvmet_rdma_disc_port_addr,
+	.set_mdts		= nvmet_rdma_set_mdts,
 };
 
 static void nvmet_rdma_remove_one(struct ib_device *ib_device, void *client_data)
-- 
1.8.3.1

