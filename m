Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D855687EE
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 14:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbiGFMLV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Jul 2022 08:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiGFMLQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Jul 2022 08:11:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9EE2A25E;
        Wed,  6 Jul 2022 05:11:13 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LdJDy5ftZz6889W;
        Wed,  6 Jul 2022 20:06:58 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Jul 2022 14:11:11 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Jul 2022 13:11:05 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <hch@lst.de>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>, <satishkh@cisco.com>,
        <sebaddel@cisco.com>, <kartilak@cisco.com>
CC:     <linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <mpi3mr-linuxdrv.pdl@broadcom.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nbd@other.debian.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 3/6] blk-mq: Drop blk_mq_ops.timeout 'reserved' arg
Date:   Wed, 6 Jul 2022 20:03:51 +0800
Message-ID: <1657109034-206040-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1657109034-206040-1-git-send-email-john.garry@huawei.com>
References: <1657109034-206040-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

With new API blk_mq_is_reserved_rq() we can tell if a request is from
the reserved pool, so stop passing 'reserved' arg. There is actually
only a single user of that arg for all the callback implementations, which
can use blk_mq_is_reserved_rq() instead.

This will also allow us to stop passing the same 'reserved' around the
blk-mq iter functions next.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/blk-mq.c                    | 6 +++---
 block/bsg-lib.c                   | 2 +-
 drivers/block/mtip32xx/mtip32xx.c | 5 ++---
 drivers/block/nbd.c               | 3 +--
 drivers/block/null_blk/main.c     | 2 +-
 drivers/mmc/core/queue.c          | 3 +--
 drivers/nvme/host/apple.c         | 3 +--
 drivers/nvme/host/fc.c            | 3 +--
 drivers/nvme/host/pci.c           | 2 +-
 drivers/nvme/host/rdma.c          | 3 +--
 drivers/nvme/host/tcp.c           | 3 +--
 drivers/s390/block/dasd.c         | 2 +-
 drivers/s390/block/dasd_int.h     | 2 +-
 drivers/scsi/scsi_error.c         | 3 +--
 drivers/scsi/scsi_priv.h          | 3 +--
 include/linux/blk-mq.h            | 2 +-
 16 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a00e43cc67e5..cedbec36e907 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1427,13 +1427,13 @@ bool blk_mq_queue_inflight(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_queue_inflight);
 
-static void blk_mq_rq_timed_out(struct request *req, bool reserved)
+static void blk_mq_rq_timed_out(struct request *req)
 {
 	req->rq_flags |= RQF_TIMED_OUT;
 	if (req->q->mq_ops->timeout) {
 		enum blk_eh_timer_return ret;
 
-		ret = req->q->mq_ops->timeout(req, reserved);
+		ret = req->q->mq_ops->timeout(req);
 		if (ret == BLK_EH_DONE)
 			return;
 		WARN_ON_ONCE(ret != BLK_EH_RESET_TIMER);
@@ -1482,7 +1482,7 @@ static bool blk_mq_check_expired(struct request *rq, void *priv, bool reserved)
 	 * from blk_mq_check_expired().
 	 */
 	if (blk_mq_req_expired(rq, next))
-		blk_mq_rq_timed_out(rq, reserved);
+		blk_mq_rq_timed_out(rq);
 	return true;
 }
 
diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index fd4cd5e68282..d6f5dcdce748 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -331,7 +331,7 @@ void bsg_remove_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(bsg_remove_queue);
 
-static enum blk_eh_timer_return bsg_timeout(struct request *rq, bool reserved)
+static enum blk_eh_timer_return bsg_timeout(struct request *rq)
 {
 	struct bsg_set *bset =
 		container_of(rq->q->tag_set, struct bsg_set, tag_set);
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index e116c6cf56f5..5073cb407500 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3357,12 +3357,11 @@ static int mtip_init_cmd(struct blk_mq_tag_set *set, struct request *rq,
 	return 0;
 }
 
-static enum blk_eh_timer_return mtip_cmd_timeout(struct request *req,
-								bool reserved)
+static enum blk_eh_timer_return mtip_cmd_timeout(struct request *req)
 {
 	struct driver_data *dd = req->q->queuedata;
 
-	if (reserved) {
+	if (blk_mq_is_reserved_rq(req)) {
 		struct mtip_cmd *cmd = blk_mq_rq_to_pdu(req);
 
 		cmd->status = BLK_STS_TIMEOUT;
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5c4c9c45c6ac..028f23c965df 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -393,8 +393,7 @@ static u32 req_to_nbd_cmd_type(struct request *req)
 	}
 }
 
-static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
-						 bool reserved)
+static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req)
 {
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
 	struct nbd_device *nbd = cmd->nbd;
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d695ea29efa6..4e03a020ee3c 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1578,7 +1578,7 @@ static int null_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 	return nr;
 }
 
-static enum blk_eh_timer_return null_timeout_rq(struct request *rq, bool res)
+static enum blk_eh_timer_return null_timeout_rq(struct request *rq)
 {
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 	struct nullb_cmd *cmd = blk_mq_rq_to_pdu(rq);
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index f824cfdab75a..fefaa901b50f 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -116,8 +116,7 @@ static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
 	}
 }
 
-static enum blk_eh_timer_return mmc_mq_timed_out(struct request *req,
-						 bool reserved)
+static enum blk_eh_timer_return mmc_mq_timed_out(struct request *req)
 {
 	struct request_queue *q = req->q;
 	struct mmc_queue *mq = q->queuedata;
diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 2d23b7d41f7e..5c352d5d8ee6 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -862,8 +862,7 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
 	}
 }
 
-static enum blk_eh_timer_return apple_nvme_timeout(struct request *req,
-						   bool reserved)
+static enum blk_eh_timer_return apple_nvme_timeout(struct request *req)
 {
 	struct apple_nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct apple_nvme_queue *q = iod->q;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a96aa831684c..07fd6db5869c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2565,8 +2565,7 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 	nvme_reset_ctrl(&ctrl->ctrl);
 }
 
-static enum blk_eh_timer_return
-nvme_fc_timeout(struct request *rq, bool reserved)
+static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
 {
 	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
 	struct nvme_fc_ctrl *ctrl = op->ctrl;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 247a74aba336..4232192e10dd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1344,7 +1344,7 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
 		 "Try \"nvme_core.default_ps_max_latency_us=0 pcie_aspm=off\" and report a bug\n");
 }
 
-static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
+static enum blk_eh_timer_return nvme_timeout(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = iod->nvmeq;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0fb7c8e7ab0b..a6eaf38b9646 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2013,8 +2013,7 @@ static void nvme_rdma_complete_timed_out(struct request *rq)
 	nvmf_complete_timed_out_request(rq);
 }
 
-static enum blk_eh_timer_return
-nvme_rdma_timeout(struct request *rq, bool reserved)
+static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_rdma_queue *queue = req->queue;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index b81942fa5f95..ff502172accd 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2321,8 +2321,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 	nvmf_complete_timed_out_request(rq);
 }
 
-static enum blk_eh_timer_return
-nvme_tcp_timeout(struct request *rq, bool reserved)
+static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 {
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index e8489331f12b..4df8bf6505fc 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3145,7 +3145,7 @@ static blk_status_t do_dasd_request(struct blk_mq_hw_ctx *hctx,
  * BLK_EH_DONE if the request is handled or terminated
  *		      by the driver.
  */
-enum blk_eh_timer_return dasd_times_out(struct request *req, bool reserved)
+enum blk_eh_timer_return dasd_times_out(struct request *req)
 {
 	struct dasd_block *block = req->q->queuedata;
 	struct dasd_device *device;
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 83b918b84b4a..333a399f754e 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -795,7 +795,7 @@ void dasd_free_device(struct dasd_device *);
 struct dasd_block *dasd_alloc_block(void);
 void dasd_free_block(struct dasd_block *);
 
-enum blk_eh_timer_return dasd_times_out(struct request *req, bool reserved);
+enum blk_eh_timer_return dasd_times_out(struct request *req);
 
 void dasd_enable_device(struct dasd_device *);
 void dasd_set_target_state(struct dasd_device *, int);
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index a8b71b73a5a5..266ce414589c 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -318,7 +318,6 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
 /**
  * scsi_timeout - Timeout function for normal scsi commands.
  * @req:	request that is timing out.
- * @reserved:	whether the request is a reserved request.
  *
  * Notes:
  *     We do not need to lock this.  There is the potential for a race
@@ -326,7 +325,7 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
  *     normal completion function determines that the timer has already
  *     fired, then it mustn't do anything.
  */
-enum blk_eh_timer_return scsi_timeout(struct request *req, bool reserved)
+enum blk_eh_timer_return scsi_timeout(struct request *req)
 {
 	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(req);
 	enum blk_eh_timer_return rtn = BLK_EH_DONE;
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 695d0c83ffe0..6eeaa0a7f86d 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -72,8 +72,7 @@ extern void scsi_exit_devinfo(void);
 
 /* scsi_error.c */
 extern void scmd_eh_abort_handler(struct work_struct *work);
-extern enum blk_eh_timer_return scsi_timeout(struct request *req,
-					     bool reserved);
+extern enum blk_eh_timer_return scsi_timeout(struct request *req);
 extern int scsi_error_handler(void *host);
 extern enum scsi_disposition scsi_decide_disposition(struct scsi_cmnd *cmd);
 extern void scsi_eh_wakeup(struct Scsi_Host *shost);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 7c62b7fabec7..c84c56d296fe 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -575,7 +575,7 @@ struct blk_mq_ops {
 	/**
 	 * @timeout: Called on request timeout.
 	 */
-	enum blk_eh_timer_return (*timeout)(struct request *, bool);
+	enum blk_eh_timer_return (*timeout)(struct request *);
 
 	/**
 	 * @poll: Called to poll for completion of a specific tag.
-- 
2.35.3

