Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB2216ABE7
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 17:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgBXQpw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 11:45:52 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46526 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727501AbgBXQpv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 11:45:51 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 24 Feb 2020 18:45:45 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 01OGji9O013647;
        Mon, 24 Feb 2020 18:45:45 +0200
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me,
        linux-rdma@vger.kernel.org, kbusch@kernel.org, hch@lst.de,
        martin.petersen@oracle.com
Cc:     vladimirk@mellanox.com, idanb@mellanox.com, maxg@mellanox.com,
        israelr@mellanox.com, axboe@kernel.dk, shlomin@mellanox.com
Subject: [PATCH 02/19] nvme: Add has_pi field to the nvme_req structure
Date:   Mon, 24 Feb 2020 18:45:27 +0200
Message-Id: <20200224164544.219438-4-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200224164544.219438-1-maxg@mellanox.com>
References: <20200224164544.219438-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

Transport drivers will use this field to determine if the request has PI.

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
---
 drivers/nvme/host/core.c | 6 ++++--
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3a754e0..15d0863 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -470,6 +470,7 @@ static inline void nvme_clear_nvme_request(struct request *req)
 	if (!(req->rq_flags & RQF_DONTPREP)) {
 		nvme_req(req)->retries = 0;
 		nvme_req(req)->flags = 0;
+		nvme_req(req)->has_pi = false;
 		req->rq_flags |= RQF_DONTPREP;
 	}
 }
@@ -703,6 +704,8 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		nvme_assign_write_stream(ctrl, req, &control, &dsmgmt);
 
 	if (ns->ms) {
+		nvme_req(req)->has_pi =
+			ns->features & NVME_NS_MD_CTRL_SUPPORTED;
 		/*
 		 * If formated with metadata, the block layer always provides a
 		 * metadata buffer if CONFIG_BLK_DEV_INTEGRITY is enabled.  Else
@@ -710,8 +713,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		 * namespace capacity to zero to prevent any I/O.
 		 */
 		if (!blk_integrity_rq(req)) {
-			if (WARN_ON_ONCE(!(ns->features &
-					   NVME_NS_MD_CTRL_SUPPORTED)))
+			if (WARN_ON_ONCE(!nvme_req(req)->has_pi))
 				return BLK_STS_NOTSUPP;
 			control |= NVME_RW_PRINFO_PRACT;
 		}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index fea20f1..99340d7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -139,6 +139,7 @@ struct nvme_request {
 	u8			flags;
 	u16			status;
 	struct nvme_ctrl	*ctrl;
+	bool			has_pi;
 };
 
 /*
-- 
1.8.3.1

