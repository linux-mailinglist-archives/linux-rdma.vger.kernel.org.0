Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E480316ABEB
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 17:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgBXQpx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 11:45:53 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46571 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727736AbgBXQpw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 11:45:52 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 24 Feb 2020 18:45:46 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 01OGji9Y013647;
        Mon, 24 Feb 2020 18:45:46 +0200
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me,
        linux-rdma@vger.kernel.org, kbusch@kernel.org, hch@lst.de,
        martin.petersen@oracle.com
Cc:     vladimirk@mellanox.com, idanb@mellanox.com, maxg@mellanox.com,
        israelr@mellanox.com, axboe@kernel.dk, shlomin@mellanox.com
Subject: [PATCH 12/19] nvmet: Rename nvmet_check_data_len to nvmet_check_transfer_len
Date:   Mon, 24 Feb 2020 18:45:37 +0200
Message-Id: <20200224164544.219438-14-maxg@mellanox.com>
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

The function doesn't check only the data length, because the transfer
length includes also the metadata length in some cases. This is
preparation for adding metadata (T10-PI) support.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/nvme/target/admin-cmd.c   | 14 +++++++-------
 drivers/nvme/target/core.c        |  6 +++---
 drivers/nvme/target/discovery.c   |  8 ++++----
 drivers/nvme/target/fabrics-cmd.c |  8 ++++----
 drivers/nvme/target/io-cmd-bdev.c |  6 +++---
 drivers/nvme/target/io-cmd-file.c |  6 +++---
 drivers/nvme/target/nvmet.h       |  2 +-
 7 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 19f9495..d446813 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -294,7 +294,7 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 
 static void nvmet_execute_get_log_page(struct nvmet_req *req)
 {
-	if (!nvmet_check_data_len(req, nvmet_get_log_page_len(req->cmd)))
+	if (!nvmet_check_transfer_len(req, nvmet_get_log_page_len(req->cmd)))
 		return;
 
 	switch (req->cmd->get_log_page.lid) {
@@ -620,7 +620,7 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 
 static void nvmet_execute_identify(struct nvmet_req *req)
 {
-	if (!nvmet_check_data_len(req, NVME_IDENTIFY_DATA_SIZE))
+	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
 		return;
 
 	switch (req->cmd->identify.cns) {
@@ -649,7 +649,7 @@ static void nvmet_execute_identify(struct nvmet_req *req)
  */
 static void nvmet_execute_abort(struct nvmet_req *req)
 {
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 	nvmet_set_result(req, 1);
 	nvmet_req_complete(req, 0);
@@ -735,7 +735,7 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 status = 0;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	switch (cdw10 & 0xff) {
@@ -801,7 +801,7 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 status = 0;
 
-	if (!nvmet_check_data_len(req, nvmet_feat_data_len(req, cdw10)))
+	if (!nvmet_check_transfer_len(req, nvmet_feat_data_len(req, cdw10)))
 		return;
 
 	switch (cdw10 & 0xff) {
@@ -868,7 +868,7 @@ void nvmet_execute_async_event(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	mutex_lock(&ctrl->lock);
@@ -887,7 +887,7 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	pr_debug("ctrl %d update keep-alive timer for %d secs\n",
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 192b9ef..ce29db3 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -940,9 +940,9 @@ void nvmet_req_uninit(struct nvmet_req *req)
 }
 EXPORT_SYMBOL_GPL(nvmet_req_uninit);
 
-bool nvmet_check_data_len(struct nvmet_req *req, size_t data_len)
+bool nvmet_check_transfer_len(struct nvmet_req *req, size_t len)
 {
-	if (unlikely(data_len != req->transfer_len)) {
+	if (unlikely(len != req->transfer_len)) {
 		req->error_loc = offsetof(struct nvme_common_command, dptr);
 		nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR);
 		return false;
@@ -950,7 +950,7 @@ bool nvmet_check_data_len(struct nvmet_req *req, size_t data_len)
 
 	return true;
 }
-EXPORT_SYMBOL_GPL(nvmet_check_data_len);
+EXPORT_SYMBOL_GPL(nvmet_check_transfer_len);
 
 bool nvmet_check_data_len_lte(struct nvmet_req *req, size_t data_len)
 {
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 0c2274b..40cf0b6 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -171,7 +171,7 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	u16 status = 0;
 	void *buffer;
 
-	if (!nvmet_check_data_len(req, data_len))
+	if (!nvmet_check_transfer_len(req, data_len))
 		return;
 
 	if (req->cmd->get_log_page.lid != NVME_LOG_DISC) {
@@ -244,7 +244,7 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
 	const char model[] = "Linux";
 	u16 status = 0;
 
-	if (!nvmet_check_data_len(req, NVME_IDENTIFY_DATA_SIZE))
+	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
 		return;
 
 	if (req->cmd->identify.cns != NVME_ID_CNS_CTRL) {
@@ -298,7 +298,7 @@ static void nvmet_execute_disc_set_features(struct nvmet_req *req)
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 stat;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	switch (cdw10 & 0xff) {
@@ -324,7 +324,7 @@ static void nvmet_execute_disc_get_features(struct nvmet_req *req)
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 stat = 0;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	switch (cdw10 & 0xff) {
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index feef15c..52a6f70 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -12,7 +12,7 @@ static void nvmet_execute_prop_set(struct nvmet_req *req)
 	u64 val = le64_to_cpu(req->cmd->prop_set.value);
 	u16 status = 0;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	if (req->cmd->prop_set.attrib & 1) {
@@ -41,7 +41,7 @@ static void nvmet_execute_prop_get(struct nvmet_req *req)
 	u16 status = 0;
 	u64 val = 0;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	if (req->cmd->prop_get.attrib & 1) {
@@ -156,7 +156,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	struct nvmet_ctrl *ctrl = NULL;
 	u16 status = 0;
 
-	if (!nvmet_check_data_len(req, sizeof(struct nvmf_connect_data)))
+	if (!nvmet_check_transfer_len(req, sizeof(struct nvmf_connect_data)))
 		return;
 
 	d = kmalloc(sizeof(*d), GFP_KERNEL);
@@ -223,7 +223,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	u16 qid = le16_to_cpu(c->qid);
 	u16 status = 0;
 
-	if (!nvmet_check_data_len(req, sizeof(struct nvmf_connect_data)))
+	if (!nvmet_check_transfer_len(req, sizeof(struct nvmf_connect_data)))
 		return;
 
 	d = kmalloc(sizeof(*d), GFP_KERNEL);
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index c0337d0..6e74fdf 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -173,7 +173,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	sector_t sector;
 	int op, i;
 
-	if (!nvmet_check_data_len(req, nvmet_rw_data_len(req)))
+	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
 		return;
 
 	if (!req->sg_cnt) {
@@ -234,7 +234,7 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 {
 	struct bio *bio = &req->b.inline_bio;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
@@ -326,7 +326,7 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	sector_t nr_sector;
 	int ret;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
 	sector = le64_to_cpu(write_zeroes->slba) <<
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index ffbba88..6b098df 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -232,7 +232,7 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 {
 	ssize_t nr_bvec = req->sg_cnt;
 
-	if (!nvmet_check_data_len(req, nvmet_rw_data_len(req)))
+	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
 		return;
 
 	if (!req->sg_cnt || !nr_bvec) {
@@ -276,7 +276,7 @@ static void nvmet_file_flush_work(struct work_struct *w)
 
 static void nvmet_file_execute_flush(struct nvmet_req *req)
 {
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 	INIT_WORK(&req->f.work, nvmet_file_flush_work);
 	schedule_work(&req->f.work);
@@ -366,7 +366,7 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 
 static void nvmet_file_execute_write_zeroes(struct nvmet_req *req)
 {
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_transfer_len(req, 0))
 		return;
 	INIT_WORK(&req->f.work, nvmet_file_write_zeroes_work);
 	schedule_work(&req->f.work);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 846d1de..d2273c7 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -391,7 +391,7 @@ static inline bool nvmet_aen_bit_disabled(struct nvmet_ctrl *ctrl, u32 bn)
 bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 		struct nvmet_sq *sq, const struct nvmet_fabrics_ops *ops);
 void nvmet_req_uninit(struct nvmet_req *req);
-bool nvmet_check_data_len(struct nvmet_req *req, size_t data_len);
+bool nvmet_check_transfer_len(struct nvmet_req *req, size_t len);
 bool nvmet_check_data_len_lte(struct nvmet_req *req, size_t data_len);
 void nvmet_req_complete(struct nvmet_req *req, u16 status);
 int nvmet_req_alloc_sgl(struct nvmet_req *req);
-- 
1.8.3.1

