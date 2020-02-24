Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 851C316ABF3
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 17:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgBXQpw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 11:45:52 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46575 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727750AbgBXQpv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 11:45:51 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 24 Feb 2020 18:45:47 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 01OGji9a013647;
        Mon, 24 Feb 2020 18:45:46 +0200
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me,
        linux-rdma@vger.kernel.org, kbusch@kernel.org, hch@lst.de,
        martin.petersen@oracle.com
Cc:     vladimirk@mellanox.com, idanb@mellanox.com, maxg@mellanox.com,
        israelr@mellanox.com, axboe@kernel.dk, shlomin@mellanox.com
Subject: [PATCH 14/19] nvmet: Add mdts setting op for controllers
Date:   Mon, 24 Feb 2020 18:45:39 +0200
Message-Id: <20200224164544.219438-16-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200224164544.219438-1-maxg@mellanox.com>
References: <20200224164544.219438-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Some transports, such as RDMA, would like to set the Maximum Data
Transfer Size (MDTS) according to device/port/ctrl characteristics.
This will enable the transport to set the optimal MDTS according to
controller needs and device capabilities. Add a new nvmet transport
op that is called during ctrl identification. This will not effect
transports that don't set this option.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
---
 drivers/nvme/target/admin-cmd.c | 8 ++++++--
 drivers/nvme/target/nvmet.h     | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index d446813..c4ad0dd 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -369,8 +369,12 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	/* we support multiple ports, multiples hosts and ANA: */
 	id->cmic = (1 << 0) | (1 << 1) | (1 << 3);
 
-	/* no limit on data transfer sizes for now */
-	id->mdts = 0;
+	/* Limit MDTS according to transport capability */
+	if (ctrl->ops->set_mdts)
+		id->mdts = ctrl->ops->set_mdts(ctrl);
+	else
+		id->mdts = 0;
+
 	id->cntlid = cpu_to_le16(ctrl->cntlid);
 	id->ver = cpu_to_le32(ctrl->subsys->ver);
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index d2273c7..ff34d7a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -292,6 +292,7 @@ struct nvmet_fabrics_ops {
 			struct nvmet_port *port, char *traddr);
 	u16 (*install_queue)(struct nvmet_sq *nvme_sq);
 	void (*discovery_chg)(struct nvmet_port *port);
+	u8 (*set_mdts)(struct nvmet_ctrl *ctrl);
 };
 
 #define NVMET_MAX_INLINE_BIOVEC	8
-- 
1.8.3.1

