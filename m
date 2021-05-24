Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E21C38E013
	for <lists+linux-rdma@lfdr.de>; Mon, 24 May 2021 06:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhEXENz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 May 2021 00:13:55 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:55042 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbhEXENx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 May 2021 00:13:53 -0400
Received: by mail-pj1-f54.google.com with SMTP id g24so14061863pji.4
        for <linux-rdma@vger.kernel.org>; Sun, 23 May 2021 21:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gdbdsE3IsJLj9mxd+E3jnCSAdPkKigPpJkQYcoy6ejI=;
        b=fveyXDMLi3VTdIZ0o0CrguidcwYc69kBXQkAVk1m+oR2OCj/8qnYMAejHB6IgDlaKv
         bahh5KUz5pZYK3ZD0m6S2D3rbXKEXSXvHMIdVCT7ex7edWYdBPS2RClAAGWSGamCjVOl
         hjShNpaOMoUJMJ76rwCbLbF5u/OeW/KkAlyq7FlzrCHjgI3st2WACuZlFwkv0bDQwU+u
         O7SKA4yqDlwev1s/iPuL6F6W8yll9gkd2QYZWxCq/reoQVk5Fs52POYrsivL8bnR2SCZ
         ukuGyYJtcxy5Mpxl4sOwdCfAxty//E7/YFf7FN3ZMyQ/I7wcdW6solmh50DhjGgLfd4z
         JcAQ==
X-Gm-Message-State: AOAM533VMKS9BAgdzAl4+w5NAwn28RJbiUKQhrEKOlaC97CunXURXiQW
        DkybPPO71r6bt07W/lVclveziN7uUNpK0g==
X-Google-Smtp-Source: ABdhPJx+kegtw79B9JwyYYRX/svY5xR9NWQuPZO/MN5I+GYtq6ZzYPoGKvWXtM0Pwbtx6BM8ToYA8Q==
X-Received: by 2002:a17:90a:1f47:: with SMTP id y7mr3335150pjy.171.1621829546015;
        Sun, 23 May 2021 21:12:26 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id q9sm13141979pjm.23.2021.05.23.21.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 21:12:25 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: [PATCH v2 5/5] RDMA/srp: Make struct scsi_cmnd and struct srp_request adjacent
Date:   Sun, 23 May 2021 21:12:11 -0700
Message-Id: <20210524041211.9480-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524041211.9480-1-bvanassche@acm.org>
References: <20210524041211.9480-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Define .init_cmd_priv and .exit_cmd_priv callback functions in struct
scsi_host_template. Set .cmd_size such that the SCSI core allocates
per-command private data. Use scsi_cmd_priv() to access that private
data. Remove the req_ring pointer from struct srp_rdma_ch since it is
no longer necessary. Convert srp_alloc_req_data() and srp_free_req_data()
into functions that initialize one instance of the SRP-private command
data. This is a micro-optimization since this patch removes several
pointer dereferences from the hot path.

Note: due to commit e73a5e8e8003 ("scsi: core: Only return started requests
from scsi_host_find_tag()"), it is no longer necessary to protect the
completion path against duplicate responses.

Cc: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 153 ++++++++++++----------------
 drivers/infiniband/ulp/srp/ib_srp.h |   2 -
 2 files changed, 63 insertions(+), 92 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 70107ab0179a..71405b01b85e 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -965,67 +965,52 @@ static void srp_disconnect_target(struct srp_target_port *target)
 	}
 }
 
-static void srp_free_req_data(struct srp_target_port *target,
-			      struct srp_rdma_ch *ch)
+static int srp_exit_cmd_priv(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 {
+	struct srp_target_port *target = host_to_target(shost);
 	struct srp_device *dev = target->srp_host->srp_dev;
 	struct ib_device *ibdev = dev->dev;
-	struct srp_request *req;
-	int i;
+	struct srp_request *req = scsi_cmd_priv(cmd);
 
-	if (!ch->req_ring)
-		return;
-
-	for (i = 0; i < target->req_ring_size; ++i) {
-		req = &ch->req_ring[i];
-		if (dev->use_fast_reg)
-			kfree(req->fr_list);
-		if (req->indirect_dma_addr) {
-			ib_dma_unmap_single(ibdev, req->indirect_dma_addr,
-					    target->indirect_size,
-					    DMA_TO_DEVICE);
-		}
-		kfree(req->indirect_desc);
+	kfree(req->fr_list);
+	if (req->indirect_dma_addr) {
+		ib_dma_unmap_single(ibdev, req->indirect_dma_addr,
+				    target->indirect_size,
+				    DMA_TO_DEVICE);
 	}
+	kfree(req->indirect_desc);
 
-	kfree(ch->req_ring);
-	ch->req_ring = NULL;
+	return 0;
 }
 
-static int srp_alloc_req_data(struct srp_rdma_ch *ch)
+static int srp_init_cmd_priv(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 {
-	struct srp_target_port *target = ch->target;
+	struct srp_target_port *target = host_to_target(shost);
 	struct srp_device *srp_dev = target->srp_host->srp_dev;
 	struct ib_device *ibdev = srp_dev->dev;
-	struct srp_request *req;
+	struct srp_request *req = scsi_cmd_priv(cmd);
 	dma_addr_t dma_addr;
-	int i, ret = -ENOMEM;
+	int ret = -ENOMEM;
 
-	ch->req_ring = kcalloc(target->req_ring_size, sizeof(*ch->req_ring),
-			       GFP_KERNEL);
-	if (!ch->req_ring)
-		goto out;
-
-	for (i = 0; i < target->req_ring_size; ++i) {
-		req = &ch->req_ring[i];
-		if (srp_dev->use_fast_reg) {
-			req->fr_list = kmalloc_array(target->mr_per_cmd,
-						sizeof(void *), GFP_KERNEL);
-			if (!req->fr_list)
-				goto out;
-		}
-		req->indirect_desc = kmalloc(target->indirect_size, GFP_KERNEL);
-		if (!req->indirect_desc)
-			goto out;
-
-		dma_addr = ib_dma_map_single(ibdev, req->indirect_desc,
-					     target->indirect_size,
-					     DMA_TO_DEVICE);
-		if (ib_dma_mapping_error(ibdev, dma_addr))
+	if (srp_dev->use_fast_reg) {
+		req->fr_list = kmalloc_array(target->mr_per_cmd, sizeof(void *),
+					GFP_KERNEL);
+		if (!req->fr_list)
 			goto out;
+	}
+	req->indirect_desc = kmalloc(target->indirect_size, GFP_KERNEL);
+	if (!req->indirect_desc)
+		goto out;
 
-		req->indirect_dma_addr = dma_addr;
+	dma_addr = ib_dma_map_single(ibdev, req->indirect_desc,
+				     target->indirect_size,
+				     DMA_TO_DEVICE);
+	if (ib_dma_mapping_error(ibdev, dma_addr)) {
+		srp_exit_cmd_priv(shost, cmd);
+		goto out;
 	}
+
+	req->indirect_dma_addr = dma_addr;
 	ret = 0;
 
 out:
@@ -1067,10 +1052,6 @@ static void srp_remove_target(struct srp_target_port *target)
 	}
 	cancel_work_sync(&target->tl_err_work);
 	srp_rport_put(target->rport);
-	for (i = 0; i < target->ch_count; i++) {
-		ch = &target->ch[i];
-		srp_free_req_data(target, ch);
-	}
 	kfree(target->ch);
 	target->ch = NULL;
 
@@ -1289,22 +1270,32 @@ static void srp_finish_req(struct srp_rdma_ch *ch, struct srp_request *req,
 	}
 }
 
-static void srp_terminate_io(struct srp_rport *rport)
+struct srp_terminate_context {
+	struct srp_target_port *srp_target;
+	int scsi_result;
+};
+
+static bool srp_terminate_cmd(struct scsi_cmnd *scmnd, void *context_ptr,
+			      bool reserved)
 {
-	struct srp_target_port *target = rport->lld_data;
-	struct srp_rdma_ch *ch;
-	int i, j;
+	struct srp_terminate_context *context = context_ptr;
+	struct srp_target_port *target = context->srp_target;
+	u32 tag = blk_mq_unique_tag(scmnd->request);
+	struct srp_rdma_ch *ch = &target->ch[blk_mq_unique_tag_to_hwq(tag)];
+	struct srp_request *req = scsi_cmd_priv(scmnd);
 
-	for (i = 0; i < target->ch_count; i++) {
-		ch = &target->ch[i];
+	srp_finish_req(ch, req, NULL, context->scsi_result);
 
-		for (j = 0; j < target->req_ring_size; ++j) {
-			struct srp_request *req = &ch->req_ring[j];
+	return true;
+}
 
-			srp_finish_req(ch, req, NULL,
-				       DID_TRANSPORT_FAILFAST << 16);
-		}
-	}
+static void srp_terminate_io(struct srp_rport *rport)
+{
+	struct srp_target_port *target = rport->lld_data;
+	struct srp_terminate_context context = { .srp_target = target,
+		.scsi_result = DID_TRANSPORT_FAILFAST << 16 };
+
+	scsi_host_busy_iter(target->scsi_host, srp_terminate_cmd, &context);
 }
 
 /* Calculate maximum initiator to target information unit length. */
@@ -1360,13 +1351,12 @@ static int srp_rport_reconnect(struct srp_rport *rport)
 		ch = &target->ch[i];
 		ret += srp_new_cm_id(ch);
 	}
-	for (i = 0; i < target->ch_count; i++) {
-		ch = &target->ch[i];
-		for (j = 0; j < target->req_ring_size; ++j) {
-			struct srp_request *req = &ch->req_ring[j];
+	{
+		struct srp_terminate_context context = {
+			.srp_target = target, .scsi_result = DID_RESET << 16};
 
-			srp_finish_req(ch, req, NULL, DID_RESET << 16);
-		}
+		scsi_host_busy_iter(target->scsi_host, srp_terminate_cmd,
+				    &context);
 	}
 	for (i = 0; i < target->ch_count; i++) {
 		ch = &target->ch[i];
@@ -1962,13 +1952,10 @@ static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp)
 		spin_unlock_irqrestore(&ch->lock, flags);
 	} else {
 		scmnd = scsi_host_find_tag(target->scsi_host, rsp->tag);
-		if (scmnd && scmnd->host_scribble) {
-			req = (void *)scmnd->host_scribble;
+		if (scmnd) {
+			req = scsi_cmd_priv(scmnd);
 			scmnd = srp_claim_req(ch, req, NULL, scmnd);
 		} else {
-			scmnd = NULL;
-		}
-		if (!scmnd) {
 			shost_printk(KERN_ERR, target->scsi_host,
 				     "Null scmnd for RSP w/tag %#016llx received on ch %td / QP %#x\n",
 				     rsp->tag, ch - target->ch, ch->qp->qp_num);
@@ -2000,7 +1987,6 @@ static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp)
 		srp_free_req(ch, req, scmnd,
 			     be32_to_cpu(rsp->req_lim_delta));
 
-		scmnd->host_scribble = NULL;
 		scmnd->scsi_done(scmnd);
 	}
 }
@@ -2168,13 +2154,12 @@ static int srp_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd)
 {
 	struct srp_target_port *target = host_to_target(shost);
 	struct srp_rdma_ch *ch;
-	struct srp_request *req;
+	struct srp_request *req = scsi_cmd_priv(scmnd);
 	struct srp_iu *iu;
 	struct srp_cmd *cmd;
 	struct ib_device *dev;
 	unsigned long flags;
 	u32 tag;
-	u16 idx;
 	int len, ret;
 
 	scmnd->result = srp_chkready(target->rport);
@@ -2184,10 +2169,6 @@ static int srp_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd)
 	WARN_ON_ONCE(scmnd->request->tag < 0);
 	tag = blk_mq_unique_tag(scmnd->request);
 	ch = &target->ch[blk_mq_unique_tag_to_hwq(tag)];
-	idx = blk_mq_unique_tag_to_tag(tag);
-	WARN_ONCE(idx >= target->req_ring_size, "%s: tag %#x: idx %d >= %d\n",
-		  dev_name(&shost->shost_gendev), tag, idx,
-		  target->req_ring_size);
 
 	spin_lock_irqsave(&ch->lock, flags);
 	iu = __srp_get_tx_iu(ch, SRP_IU_CMD);
@@ -2196,13 +2177,10 @@ static int srp_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd)
 	if (!iu)
 		goto err;
 
-	req = &ch->req_ring[idx];
 	dev = target->srp_host->srp_dev->dev;
 	ib_dma_sync_single_for_cpu(dev, iu->dma, ch->max_it_iu_len,
 				   DMA_TO_DEVICE);
 
-	scmnd->host_scribble = (void *) req;
-
 	cmd = iu->buf;
 	memset(cmd, 0, sizeof *cmd);
 
@@ -3083,6 +3061,8 @@ static struct scsi_host_template srp_template = {
 	.target_alloc			= srp_target_alloc,
 	.slave_configure		= srp_slave_configure,
 	.info				= srp_target_info,
+	.init_cmd_priv			= srp_init_cmd_priv,
+	.exit_cmd_priv			= srp_exit_cmd_priv,
 	.queuecommand			= srp_queuecommand,
 	.change_queue_depth             = srp_change_queue_depth,
 	.eh_timed_out			= srp_timed_out,
@@ -3096,6 +3076,7 @@ static struct scsi_host_template srp_template = {
 	.cmd_per_lun			= SRP_DEFAULT_CMD_SQ_SIZE,
 	.shost_attrs			= srp_host_attrs,
 	.track_queue_depth		= 1,
+	.cmd_size			= sizeof(struct srp_request),
 };
 
 static int srp_sdev_count(struct Scsi_Host *host)
@@ -3675,8 +3656,6 @@ static ssize_t srp_create_target(struct device *dev,
 	if (ret)
 		goto out;
 
-	target->req_ring_size = target->queue_size - SRP_TSK_MGMT_SQ_SIZE;
-
 	if (!srp_conn_unique(target->srp_host, target)) {
 		if (target->using_rdma_cm) {
 			shost_printk(KERN_INFO, target->scsi_host,
@@ -3779,10 +3758,6 @@ static ssize_t srp_create_target(struct device *dev,
 		if (ret)
 			goto err_disconnect;
 
-		ret = srp_alloc_req_data(ch);
-		if (ret)
-			goto err_disconnect;
-
 		ret = srp_connect_ch(ch, max_iu_len, multich);
 		if (ret) {
 			char dst[64];
@@ -3801,7 +3776,6 @@ static ssize_t srp_create_target(struct device *dev,
 				goto free_ch;
 			} else {
 				srp_free_ch_ib(target, ch);
-				srp_free_req_data(target, ch);
 				target->ch_count = ch - target->ch;
 				goto connected;
 			}
@@ -3862,7 +3836,6 @@ static ssize_t srp_create_target(struct device *dev,
 	for (i = 0; i < target->ch_count; i++) {
 		ch = &target->ch[i];
 		srp_free_ch_ib(target, ch);
-		srp_free_req_data(target, ch);
 	}
 
 	kfree(target->ch);
diff --git a/drivers/infiniband/ulp/srp/ib_srp.h b/drivers/infiniband/ulp/srp/ib_srp.h
index 6818cac0a3b7..abccddeea1e3 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.h
+++ b/drivers/infiniband/ulp/srp/ib_srp.h
@@ -174,7 +174,6 @@ struct srp_rdma_ch {
 
 	struct srp_iu	      **tx_ring;
 	struct srp_iu	      **rx_ring;
-	struct srp_request     *req_ring;
 	int			comp_vector;
 
 	u64			tsk_mgmt_tag;
@@ -220,7 +219,6 @@ struct srp_target_port {
 	int			mr_pool_size;
 	int			mr_per_cmd;
 	int			queue_size;
-	int			req_ring_size;
 	int			comp_vector;
 	int			tl_retry_count;
 
