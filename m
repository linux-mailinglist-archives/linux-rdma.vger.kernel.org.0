Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C31B195C44
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2020 18:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgC0RPx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Mar 2020 13:15:53 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:44769 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727393AbgC0RPw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Mar 2020 13:15:52 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 27 Mar 2020 20:15:46 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02RHFjj5004869;
        Fri, 27 Mar 2020 20:15:46 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     idanb@mellanox.com, axboe@kernel.dk, maxg@mellanox.com,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
Subject: [PATCH 02/17] nvme: Add has_md field to the nvme_req structure
Date:   Fri, 27 Mar 2020 20:15:30 +0300
Message-Id: <20200327171545.98970-4-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200327171545.98970-1-maxg@mellanox.com>
References: <20200327171545.98970-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

Transport drivers will use this field to determine if the request has
metadata.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
---
 drivers/nvme/host/core.c | 6 ++++--
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3a184f..f34ff34 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -461,6 +461,7 @@ static inline void nvme_clear_nvme_request(struct request *req)
 	if (!(req->rq_flags & RQF_DONTPREP)) {
 		nvme_req(req)->retries = 0;
 		nvme_req(req)->flags = 0;
+		nvme_req(req)->has_md = false;
 		req->rq_flags |= RQF_DONTPREP;
 	}
 }
@@ -694,6 +695,8 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		nvme_assign_write_stream(ctrl, req, &control, &dsmgmt);
 
 	if (ns->ms) {
+		nvme_req(req)->has_md =
+			ns->features & NVME_NS_MD_CTRL_SUPPORTED;
 		/*
 		 * If formated with metadata, the block layer always provides a
 		 * metadata buffer if CONFIG_BLK_DEV_INTEGRITY is enabled.  Else
@@ -701,8 +704,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		 * namespace capacity to zero to prevent any I/O.
 		 */
 		if (!blk_integrity_rq(req)) {
-			if (WARN_ON_ONCE(!(ns->features &
-					   NVME_NS_MD_CTRL_SUPPORTED)))
+			if (WARN_ON_ONCE(!nvme_req(req)->has_md))
 				return BLK_STS_NOTSUPP;
 			control |= NVME_RW_PRINFO_PRACT;
 		}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 83296d0..a353255 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -139,6 +139,7 @@ struct nvme_request {
 	u8			flags;
 	u16			status;
 	struct nvme_ctrl	*ctrl;
+	bool			has_md;
 };
 
 /*
-- 
1.8.3.1

