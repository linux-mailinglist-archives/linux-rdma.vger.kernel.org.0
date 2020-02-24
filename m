Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9F1B16ABE6
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 17:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgBXQpv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 11:45:51 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46508 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727438AbgBXQpv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 11:45:51 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 24 Feb 2020 18:45:45 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 01OGji9R013647;
        Mon, 24 Feb 2020 18:45:45 +0200
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me,
        linux-rdma@vger.kernel.org, kbusch@kernel.org, hch@lst.de,
        martin.petersen@oracle.com
Cc:     vladimirk@mellanox.com, idanb@mellanox.com, maxg@mellanox.com,
        israelr@mellanox.com, axboe@kernel.dk, shlomin@mellanox.com
Subject: [PATCH 05/19] nvme-fabrics: Allow user enabling metadata/T10-PI support
Date:   Mon, 24 Feb 2020 18:45:30 +0200
Message-Id: <20200224164544.219438-7-maxg@mellanox.com>
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

Preparation for adding metadata (T10-PI) over fabric support. This will
allow end-to-end protection information passthrough and validation for
NVMe over Fabric.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/host/core.c    |  3 ++-
 drivers/nvme/host/fabrics.c | 11 +++++++++++
 drivers/nvme/host/fabrics.h |  3 +++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ab25128..c7933a8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1869,7 +1869,8 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		 * controller.
 		 */
 		if (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED) {
-			if (ns->ctrl->ops->flags & NVME_F_FABRICS ||
+			if ((ns->ctrl->ops->flags & NVME_F_FABRICS &&
+			     ns->ctrl->opts->pi_enable) ||
 			    !(ns->features & NVME_NS_EXT_LBAS))
 				ns->features |= NVME_NS_MD_HOST_SUPPORTED;
 		}
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 74b8818..c09230e 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -612,6 +612,7 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
 	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
 	{ NVMF_OPT_TOS,			"tos=%d"		},
+	{ NVMF_OPT_PI_ENABLE,		"pi_enable"		},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -634,6 +635,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->hdr_digest = false;
 	opts->data_digest = false;
 	opts->tos = -1; /* < 0 == use transport default */
+	opts->pi_enable = false;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -867,6 +869,15 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			opts->tos = token;
 			break;
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+		case NVMF_OPT_PI_ENABLE:
+			if (opts->discovery_nqn) {
+				pr_debug("Ignoring pi_enable value for discovery controller\n");
+				break;
+			}
+			opts->pi_enable = true;
+			break;
+#endif
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a0ec40a..773f748 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -56,6 +56,7 @@ enum {
 	NVMF_OPT_NR_WRITE_QUEUES = 1 << 17,
 	NVMF_OPT_NR_POLL_QUEUES = 1 << 18,
 	NVMF_OPT_TOS		= 1 << 19,
+	NVMF_OPT_PI_ENABLE	= 1 << 20,
 };
 
 /**
@@ -89,6 +90,7 @@ enum {
  * @nr_write_queues: number of queues for write I/O
  * @nr_poll_queues: number of queues for polling I/O
  * @tos: type of service
+ * @pi_enable: Enable metadata (T10-PI) support
  */
 struct nvmf_ctrl_options {
 	unsigned		mask;
@@ -111,6 +113,7 @@ struct nvmf_ctrl_options {
 	unsigned int		nr_write_queues;
 	unsigned int		nr_poll_queues;
 	int			tos;
+	bool			pi_enable;
 };
 
 /*
-- 
1.8.3.1

