Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2695C195C40
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2020 18:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgC0RPx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Mar 2020 13:15:53 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:51185 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727495AbgC0RPw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Mar 2020 13:15:52 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 27 Mar 2020 20:15:46 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02RHFjj4004869;
        Fri, 27 Mar 2020 20:15:46 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     idanb@mellanox.com, axboe@kernel.dk, maxg@mellanox.com,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
Subject: [PATCH 01/17] nvme: introduce namespace features flag
Date:   Fri, 27 Mar 2020 20:15:29 +0300
Message-Id: <20200327171545.98970-3-maxg@mellanox.com>
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

Centralize all the metadata checks to one place and make the code more
readable. Introduce a new enum nvme_ns_features for that matter.
The features flag description:
 - NVME_NS_EXT_LBAS - NVMe namespace supports extended LBA format.
 - NVME_NS_MD_HOST_SUPPORTED - NVMe namespace supports getting metadata
   from host's block layer.
 - NVME_NS_MD_CTRL_SUPPORTED - NVMe namespace supports metadata actions
   by the controller (generate/strip).

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
---
 drivers/nvme/host/core.c | 42 ++++++++++++++++++++++++++++--------------
 drivers/nvme/host/nvme.h |  8 +++++++-
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1cab3c6..f3a184f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -203,11 +203,6 @@ static void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 	nvme_put_ctrl(ctrl);
 }
 
-static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
-{
-	return ns->pi_type && ns->ms == sizeof(struct t10_pi_tuple);
-}
-
 static blk_status_t nvme_error_status(u16 status)
 {
 	switch (status & 0x7ff) {
@@ -706,7 +701,8 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		 * namespace capacity to zero to prevent any I/O.
 		 */
 		if (!blk_integrity_rq(req)) {
-			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns)))
+			if (WARN_ON_ONCE(!(ns->features &
+					   NVME_NS_MD_CTRL_SUPPORTED)))
 				return BLK_STS_NOTSUPP;
 			control |= NVME_RW_PRINFO_PRACT;
 		}
@@ -1277,7 +1273,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	meta_len = (io.nblocks + 1) * ns->ms;
 	metadata = (void __user *)(uintptr_t)io.metadata;
 
-	if (ns->ext) {
+	if (ns->features & NVME_NS_EXT_LBAS) {
 		length += meta_len;
 		meta_len = 0;
 	} else if (meta_len) {
@@ -1837,11 +1833,12 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_queue_io_min(disk->queue, phys_bs);
 	blk_queue_io_opt(disk->queue, io_opt);
 
-	if (ns->ms && !ns->ext &&
-	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
+	if (ns->features & NVME_NS_MD_HOST_SUPPORTED)
 		nvme_init_integrity(disk, ns->ms, ns->pi_type);
-	if ((ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk)) ||
-	    ns->lba_shift > PAGE_SHIFT)
+
+	if ((ns->ms && !(ns->features & NVME_NS_MD_CTRL_SUPPORTED) &&
+	     !(ns->features & NVME_NS_MD_HOST_SUPPORTED) &&
+	     !blk_get_integrity(disk)) || ns->lba_shift > PAGE_SHIFT)
 		capacity = 0;
 
 	set_capacity(disk, capacity);
@@ -1870,12 +1867,29 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		ns->lba_shift = 9;
 	ns->noiob = le16_to_cpu(id->noiob);
 	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
-	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
+	ns->features = 0;
 	/* the PI implementation requires metadata equal t10 pi tuple size */
-	if (ns->ms == sizeof(struct t10_pi_tuple))
+	if (ns->ms == sizeof(struct t10_pi_tuple)) {
 		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
-	else
+		if (ns->pi_type)
+			ns->features |= NVME_NS_MD_CTRL_SUPPORTED;
+	} else {
 		ns->pi_type = 0;
+	}
+
+	if (ns->ms) {
+		if (id->flbas & NVME_NS_FLBAS_META_EXT)
+			ns->features |= NVME_NS_EXT_LBAS;
+
+		/*
+		 * For PCI, Extended logical block will be generated by the
+		 * controller.
+		 */
+		if (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED) {
+			if (!(ns->features & NVME_NS_EXT_LBAS))
+				ns->features |= NVME_NS_MD_HOST_SUPPORTED;
+		}
+	}
 
 	if (ns->noiob)
 		nvme_set_chunk_size(ns);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2e04a36..83296d0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -363,6 +363,12 @@ struct nvme_ns_head {
 #endif
 };
 
+enum nvme_ns_features {
+	NVME_NS_EXT_LBAS = 1 << 0,
+	NVME_NS_MD_HOST_SUPPORTED = 1 << 1,
+	NVME_NS_MD_CTRL_SUPPORTED = 1 << 2,
+};
+
 struct nvme_ns {
 	struct list_head list;
 
@@ -382,8 +388,8 @@ struct nvme_ns {
 	u16 ms;
 	u16 sgs;
 	u32 sws;
-	bool ext;
 	u8 pi_type;
+	unsigned long features;
 	unsigned long flags;
 #define NVME_NS_REMOVING	0
 #define NVME_NS_DEAD     	1
-- 
1.8.3.1

