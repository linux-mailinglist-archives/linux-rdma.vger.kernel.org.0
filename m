Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD665687FB
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 14:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbiGFMLr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Jul 2022 08:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbiGFMLg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Jul 2022 08:11:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3DB2A402;
        Wed,  6 Jul 2022 05:11:24 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LdJGw3tgnz686qR;
        Wed,  6 Jul 2022 20:08:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Jul 2022 14:11:22 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Jul 2022 13:11:17 +0100
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
Subject: [PATCH v3 5/6] blk-mq: Drop 'reserved' arg of busy_tag_iter_fn
Date:   Wed, 6 Jul 2022 20:03:53 +0800
Message-ID: <1657109034-206040-6-git-send-email-john.garry@huawei.com>
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

We no longer use the 'reserved' arg in busy_tag_iter_fn for any iter
function so it may be dropped.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me> #nvme
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-debugfs.c              |  2 +-
 block/blk-mq-tag.c                  |  7 +++----
 block/blk-mq.c                      | 10 ++++------
 drivers/block/mtip32xx/mtip32xx.c   |  4 ++--
 drivers/block/nbd.c                 |  2 +-
 drivers/infiniband/ulp/srp/ib_srp.c |  3 +--
 drivers/nvme/host/core.c            |  2 +-
 drivers/nvme/host/fc.c              |  3 +--
 drivers/nvme/host/nvme.h            |  2 +-
 drivers/scsi/aacraid/comminit.c     |  2 +-
 drivers/scsi/aacraid/linit.c        |  2 +-
 drivers/scsi/fnic/fnic_scsi.c       | 12 ++++--------
 drivers/scsi/hosts.c                | 14 ++++++--------
 drivers/scsi/mpi3mr/mpi3mr_os.c     | 16 ++++------------
 include/linux/blk-mq.h              |  2 +-
 include/scsi/scsi_host.h            |  2 +-
 16 files changed, 33 insertions(+), 52 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b80fae7ab1d9..b11add9a95e2 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -375,7 +375,7 @@ struct show_busy_params {
  * e.g. due to a concurrent blk_mq_finish_request() call. Returns true to
  * keep iterating requests.
  */
-static bool hctx_show_busy_rq(struct request *rq, void *data, bool reserved)
+static bool hctx_show_busy_rq(struct request *rq, void *data)
 {
 	const struct show_busy_params *params = data;
 
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 3cfffef1feb3..4e9b8ec55bda 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -283,7 +283,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 		return true;
 
 	if (rq->q == q && (!hctx || rq->mq_hctx == hctx))
-		ret = iter_data->fn(rq, iter_data->data, reserved);
+		ret = iter_data->fn(rq, iter_data->data);
 	blk_mq_put_rq_ref(rq);
 	return ret;
 }
@@ -354,7 +354,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 
 	if (!(iter_data->flags & BT_TAG_ITER_STARTED) ||
 	    blk_mq_request_started(rq))
-		ret = iter_data->fn(rq, iter_data->data, reserved);
+		ret = iter_data->fn(rq, iter_data->data);
 	if (!iter_static_rqs)
 		blk_mq_put_rq_ref(rq);
 	return ret;
@@ -444,8 +444,7 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
-static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
-		void *data, bool reserved)
+static bool blk_mq_tagset_count_completed_rqs(struct request *rq, void *data)
 {
 	unsigned *count = data;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index cedbec36e907..63385742b8a8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -129,8 +129,7 @@ struct mq_inflight {
 	unsigned int inflight[2];
 };
 
-static bool blk_mq_check_inflight(struct request *rq, void *priv,
-				  bool reserved)
+static bool blk_mq_check_inflight(struct request *rq, void *priv)
 {
 	struct mq_inflight *mi = priv;
 
@@ -1400,8 +1399,7 @@ void blk_mq_delay_kick_requeue_list(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 
-static bool blk_mq_rq_inflight(struct request *rq, void *priv,
-			       bool reserved)
+static bool blk_mq_rq_inflight(struct request *rq, void *priv)
 {
 	/*
 	 * If we find a request that isn't idle we know the queue is busy
@@ -1470,7 +1468,7 @@ void blk_mq_put_rq_ref(struct request *rq)
 		__blk_mq_free_request(rq);
 }
 
-static bool blk_mq_check_expired(struct request *rq, void *priv, bool reserved)
+static bool blk_mq_check_expired(struct request *rq, void *priv)
 {
 	unsigned long *next = priv;
 
@@ -3289,7 +3287,7 @@ struct rq_iter_data {
 	bool has_rq;
 };
 
-static bool blk_mq_has_request(struct request *rq, void *data, bool reserved)
+static bool blk_mq_has_request(struct request *rq, void *data)
 {
 	struct rq_iter_data *iter_data = data;
 
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 5073cb407500..562725d222a7 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2441,7 +2441,7 @@ static void mtip_softirq_done_fn(struct request *rq)
 	blk_mq_end_request(rq, cmd->status);
 }
 
-static bool mtip_abort_cmd(struct request *req, void *data, bool reserved)
+static bool mtip_abort_cmd(struct request *req, void *data)
 {
 	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(req);
 	struct driver_data *dd = data;
@@ -2454,7 +2454,7 @@ static bool mtip_abort_cmd(struct request *req, void *data, bool reserved)
 	return true;
 }
 
-static bool mtip_queue_cmd(struct request *req, void *data, bool reserved)
+static bool mtip_queue_cmd(struct request *req, void *data)
 {
 	struct driver_data *dd = data;
 
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 028f23c965df..f5d098a148cb 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -879,7 +879,7 @@ static void recv_work(struct work_struct *work)
 	kfree(args);
 }
 
-static bool nbd_clear_req(struct request *req, void *data, bool reserved)
+static bool nbd_clear_req(struct request *req, void *data)
 {
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
 
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 6058abf42ba7..7720ea270ed8 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1282,8 +1282,7 @@ struct srp_terminate_context {
 	int scsi_result;
 };
 
-static bool srp_terminate_cmd(struct scsi_cmnd *scmnd, void *context_ptr,
-			      bool reserved)
+static bool srp_terminate_cmd(struct scsi_cmnd *scmnd, void *context_ptr)
 {
 	struct srp_terminate_context *context = context_ptr;
 	struct srp_target_port *target = context->srp_target;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b5b24998a5ab..9031d10c97dc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -418,7 +418,7 @@ blk_status_t nvme_host_path_error(struct request *req)
 }
 EXPORT_SYMBOL_GPL(nvme_host_path_error);
 
-bool nvme_cancel_request(struct request *req, void *data, bool reserved)
+bool nvme_cancel_request(struct request *req, void *data)
 {
 	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
 				"Cancelling I/O %d", req->tag);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 07fd6db5869c..9987797620b6 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2456,8 +2456,7 @@ nvme_fc_nvme_ctrl_freed(struct nvme_ctrl *nctrl)
  * status. The done path will return the io request back to the block
  * layer with an error status.
  */
-static bool
-nvme_fc_terminate_exchange(struct request *req, void *data, bool reserved)
+static bool nvme_fc_terminate_exchange(struct request *req, void *data)
 {
 	struct nvme_ctrl *nctrl = data;
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0da94b233fed..e4daa57f8bd5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -697,7 +697,7 @@ static __always_inline void nvme_complete_batch(struct io_comp_batch *iob,
 }
 
 blk_status_t nvme_host_path_error(struct request *req);
-bool nvme_cancel_request(struct request *req, void *data, bool reserved);
+bool nvme_cancel_request(struct request *req, void *data);
 void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
 void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
diff --git a/drivers/scsi/aacraid/comminit.c b/drivers/scsi/aacraid/comminit.c
index 940a6deab38f..bd99c5492b7d 100644
--- a/drivers/scsi/aacraid/comminit.c
+++ b/drivers/scsi/aacraid/comminit.c
@@ -272,7 +272,7 @@ static void aac_queue_init(struct aac_dev * dev, struct aac_queue * q, u32 *mem,
 	q->entries = qsize;
 }
 
-static bool wait_for_io_iter(struct scsi_cmnd *cmd, void *data, bool rsvd)
+static bool wait_for_io_iter(struct scsi_cmnd *cmd, void *data)
 {
 	int *active = data;
 
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 9c27bc37e5de..5ba5c18b77b4 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -633,7 +633,7 @@ struct fib_count_data {
 	int krlcnt;
 };
 
-static bool fib_count_iter(struct scsi_cmnd *scmnd, void *data, bool reserved)
+static bool fib_count_iter(struct scsi_cmnd *scmnd, void *data)
 {
 	struct fib_count_data *fib_count = data;
 
diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index e7b7f6d73429..77a4d9f8aa83 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -1350,8 +1350,7 @@ int fnic_wq_copy_cmpl_handler(struct fnic *fnic, int copy_work_to_do)
 	return wq_work_done;
 }
 
-static bool fnic_cleanup_io_iter(struct scsi_cmnd *sc, void *data,
-				 bool reserved)
+static bool fnic_cleanup_io_iter(struct scsi_cmnd *sc, void *data)
 {
 	const int tag = scsi_cmd_to_rq(sc)->tag;
 	struct fnic *fnic = data;
@@ -1548,8 +1547,7 @@ struct fnic_rport_abort_io_iter_data {
 	int term_cnt;
 };
 
-static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data,
-				     bool reserved)
+static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data)
 {
 	struct fnic_rport_abort_io_iter_data *iter_data = data;
 	struct fnic *fnic = iter_data->fnic;
@@ -2003,8 +2001,7 @@ struct fnic_pending_aborts_iter_data {
 	int ret;
 };
 
-static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc,
-				     void *data, bool reserved)
+static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc, void *data)
 {
 	struct fnic_pending_aborts_iter_data *iter_data = data;
 	struct fnic *fnic = iter_data->fnic;
@@ -2668,8 +2665,7 @@ void fnic_exch_mgr_reset(struct fc_lport *lp, u32 sid, u32 did)
 
 }
 
-static bool fnic_abts_pending_iter(struct scsi_cmnd *sc, void *data,
-				   bool reserved)
+static bool fnic_abts_pending_iter(struct scsi_cmnd *sc, void *data)
 {
 	struct fnic_pending_aborts_iter_data *iter_data = data;
 	struct fnic *fnic = iter_data->fnic;
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 8352f90d997d..315c7ac730e9 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -566,8 +566,7 @@ struct Scsi_Host *scsi_host_get(struct Scsi_Host *shost)
 }
 EXPORT_SYMBOL(scsi_host_get);
 
-static bool scsi_host_check_in_flight(struct request *rq, void *data,
-				      bool reserved)
+static bool scsi_host_check_in_flight(struct request *rq, void *data)
 {
 	int *count = data;
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
@@ -662,7 +661,7 @@ void scsi_flush_work(struct Scsi_Host *shost)
 }
 EXPORT_SYMBOL_GPL(scsi_flush_work);
 
-static bool complete_all_cmds_iter(struct request *rq, void *data, bool rsvd)
+static bool complete_all_cmds_iter(struct request *rq, void *data)
 {
 	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(rq);
 	enum scsi_host_status status = *(enum scsi_host_status *)data;
@@ -693,17 +692,16 @@ void scsi_host_complete_all_commands(struct Scsi_Host *shost,
 EXPORT_SYMBOL_GPL(scsi_host_complete_all_commands);
 
 struct scsi_host_busy_iter_data {
-	bool (*fn)(struct scsi_cmnd *, void *, bool);
+	bool (*fn)(struct scsi_cmnd *, void *);
 	void *priv;
 };
 
-static bool __scsi_host_busy_iter_fn(struct request *req, void *priv,
-				   bool reserved)
+static bool __scsi_host_busy_iter_fn(struct request *req, void *priv)
 {
 	struct scsi_host_busy_iter_data *iter_data = priv;
 	struct scsi_cmnd *sc = blk_mq_rq_to_pdu(req);
 
-	return iter_data->fn(sc, iter_data->priv, reserved);
+	return iter_data->fn(sc, iter_data->priv);
 }
 
 /**
@@ -716,7 +714,7 @@ static bool __scsi_host_busy_iter_fn(struct request *req, void *priv,
  * ithas to be provided by the caller
  **/
 void scsi_host_busy_iter(struct Scsi_Host *shost,
-			 bool (*fn)(struct scsi_cmnd *, void *, bool),
+			 bool (*fn)(struct scsi_cmnd *, void *),
 			 void *priv)
 {
 	struct scsi_host_busy_iter_data iter_data = {
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index d8c195b7ca57..59a18769a4fe 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -381,14 +381,12 @@ void mpi3mr_invalidate_devhandles(struct mpi3mr_ioc *mrioc)
  * mpi3mr_print_scmd - print individual SCSI command
  * @rq: Block request
  * @data: Adapter instance reference
- * @reserved: N/A. Currently not used
  *
  * Print the SCSI command details if it is in LLD scope.
  *
  * Return: true always.
  */
-static bool mpi3mr_print_scmd(struct request *rq,
-	void *data, bool reserved)
+static bool mpi3mr_print_scmd(struct request *rq, void *data)
 {
 	struct mpi3mr_ioc *mrioc = (struct mpi3mr_ioc *)data;
 	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(rq);
@@ -412,7 +410,6 @@ static bool mpi3mr_print_scmd(struct request *rq,
  * mpi3mr_flush_scmd - Flush individual SCSI command
  * @rq: Block request
  * @data: Adapter instance reference
- * @reserved: N/A. Currently not used
  *
  * Return the SCSI command to the upper layers if it is in LLD
  * scope.
@@ -420,8 +417,7 @@ static bool mpi3mr_print_scmd(struct request *rq,
  * Return: true always.
  */
 
-static bool mpi3mr_flush_scmd(struct request *rq,
-	void *data, bool reserved)
+static bool mpi3mr_flush_scmd(struct request *rq, void *data)
 {
 	struct mpi3mr_ioc *mrioc = (struct mpi3mr_ioc *)data;
 	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(rq);
@@ -451,7 +447,6 @@ static bool mpi3mr_flush_scmd(struct request *rq,
  * mpi3mr_count_dev_pending - Count commands pending for a lun
  * @rq: Block request
  * @data: SCSI device reference
- * @reserved: Unused
  *
  * This is an iterator function called for each SCSI command in
  * a host and if the command is pending in the LLD for the
@@ -461,8 +456,7 @@ static bool mpi3mr_flush_scmd(struct request *rq,
  * Return: true always.
  */
 
-static bool mpi3mr_count_dev_pending(struct request *rq,
-	void *data, bool reserved)
+static bool mpi3mr_count_dev_pending(struct request *rq, void *data)
 {
 	struct scsi_device *sdev = (struct scsi_device *)data;
 	struct mpi3mr_sdev_priv_data *sdev_priv_data = sdev->hostdata;
@@ -485,7 +479,6 @@ static bool mpi3mr_count_dev_pending(struct request *rq,
  * mpi3mr_count_tgt_pending - Count commands pending for target
  * @rq: Block request
  * @data: SCSI target reference
- * @reserved: Unused
  *
  * This is an iterator function called for each SCSI command in
  * a host and if the command is pending in the LLD for the
@@ -495,8 +488,7 @@ static bool mpi3mr_count_dev_pending(struct request *rq,
  * Return: true always.
  */
 
-static bool mpi3mr_count_tgt_pending(struct request *rq,
-	void *data, bool reserved)
+static bool mpi3mr_count_tgt_pending(struct request *rq, void *data)
 {
 	struct scsi_target *starget = (struct scsi_target *)data;
 	struct mpi3mr_stgt_priv_data *stgt_priv_data = starget->hostdata;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index c84c56d296fe..810a24884f7e 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -520,7 +520,7 @@ struct blk_mq_queue_data {
 	bool last;
 };
 
-typedef bool (busy_tag_iter_fn)(struct request *, void *, bool);
+typedef bool (busy_tag_iter_fn)(struct request *, void *);
 
 /**
  * struct blk_mq_ops - Callback functions that implements block driver
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 667d889b92b5..65082ecdd557 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -786,7 +786,7 @@ extern int scsi_host_block(struct Scsi_Host *shost);
 extern int scsi_host_unblock(struct Scsi_Host *shost, int new_state);
 
 void scsi_host_busy_iter(struct Scsi_Host *,
-			 bool (*fn)(struct scsi_cmnd *, void *, bool), void *priv);
+			 bool (*fn)(struct scsi_cmnd *, void *), void *priv);
 
 struct class_container;
 
-- 
2.35.3

