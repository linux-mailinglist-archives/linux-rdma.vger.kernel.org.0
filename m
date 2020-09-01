Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B9D258606
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Sep 2020 05:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgIADId (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 23:08:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45797 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgIADIb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Aug 2020 23:08:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id bh1so4225743plb.12
        for <linux-rdma@vger.kernel.org>; Mon, 31 Aug 2020 20:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N4BfyTL2rWqt4ikAsJjItA3FwEkazXD3oD/C/wTgmaU=;
        b=jfqbrpFktt9ENcfbtiwbitYmzHgSUJdxATW9x8/CwdzrJXPuHwJAYuAB4yUxEXNhV+
         uwhoYabxLCXC8G/QZw86s09QkQ7EYIDZUuXbCZOanapYSZfuGoff+5fMzzb4XInWxHrS
         O/77JiUjB2vLo91FXXWHpahXy+FRmwU2u5NAVQ9poiZSJ/jrsqqYhSNcJLYcNWwNf/6m
         wLSGYXMNO84ZtkkJ6nncOa09wLsThCc/BIumr74mm2D1O4Wx3FxUJ24YJY371nd93uDK
         ldmVyfd6LI8d0uGSSgD0CAhj0OXOalF7AFLDa0+4j71sN8QJgaLx1EegzLqL35cU43Mt
         +mUA==
X-Gm-Message-State: AOAM532fF37EiKvyG10PZnq9SOzD60UQNehBXip5+7opmrikfG2IJyF3
        RFWqGNSkElcEkYZA3edUXh8=
X-Google-Smtp-Source: ABdhPJygaMvYvHRM/I+HLc6gA45JNaRGB6aSHlptVloRxaAGRuAut6MO07UG6NoQI0z7fyIPYiH+UA==
X-Received: by 2002:a17:90a:fb84:: with SMTP id cp4mr1348668pjb.14.1598929709545;
        Mon, 31 Aug 2020 20:08:29 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:70b6:3990:a389:c0d1])
        by smtp.gmail.com with ESMTPSA id r199sm9740394pfc.98.2020.08.31.20.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 20:08:28 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Stephen Rust <srust@blockbridge.com>,
        Doug Dumitru <doug@dumitru.com>
Subject: [PATCH v2] IB/isert: fix unaligned immediate-data handling
Date:   Mon, 31 Aug 2020 20:08:26 -0700
Message-Id: <20200901030826.140880-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently we allocate rx buffers in a single contiguous buffers for
headers (iser and iscsi) and data trailer. This means that most likely
the data starting offset is aligned to 76 bytes (size of both headers).

This worked fine for years, but at some point this broke, resulting in
data corruptions in isert when a command comes with immediate data
and the underlying backend device assumes 512 bytes buffer alignment.

We assume a hard-requirement for all direct I/O buffers to be 512 bytes
aligned. To fix this, we should avoid passing unaligned buffers for I/O.

Instead, we allocate our recv buffers with some extra space such that we
can have the data portion align to 512 byte boundary. This also means
that we cannot reference headers or data using structure but rather
accessors (as they may move based on alignment). Also, get rid of the
wrong __packed annotation from iser_rx_desc as this has only harmful
effects (not aligned to anything).

This affects the rx descriptors for iscsi login and data plane.

Reported-by: Stephen Rust <srust@blockbridge.com>
Tested-by: Doug Dumitru <doug@dumitru.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- revised change log

 drivers/infiniband/ulp/isert/ib_isert.c | 93 +++++++++++++------------
 drivers/infiniband/ulp/isert/ib_isert.h | 41 ++++++++---
 2 files changed, 79 insertions(+), 55 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 61e2f7fc513d..5b6a0ad9faaa 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -140,15 +140,16 @@ isert_alloc_rx_descriptors(struct isert_conn *isert_conn)
 	rx_desc = isert_conn->rx_descs;
 
 	for (i = 0; i < ISERT_QP_MAX_RECV_DTOS; i++, rx_desc++)  {
-		dma_addr = ib_dma_map_single(ib_dev, (void *)rx_desc,
-					ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+		dma_addr = ib_dma_map_single(ib_dev,
+					rx_desc->buf,
+					ISER_RX_SIZE, DMA_FROM_DEVICE);
 		if (ib_dma_mapping_error(ib_dev, dma_addr))
 			goto dma_map_fail;
 
 		rx_desc->dma_addr = dma_addr;
 
 		rx_sg = &rx_desc->rx_sg;
-		rx_sg->addr = rx_desc->dma_addr;
+		rx_sg->addr = rx_desc->dma_addr + isert_get_hdr_offset(rx_desc);
 		rx_sg->length = ISER_RX_PAYLOAD_SIZE;
 		rx_sg->lkey = device->pd->local_dma_lkey;
 		rx_desc->rx_cqe.done = isert_recv_done;
@@ -160,7 +161,7 @@ isert_alloc_rx_descriptors(struct isert_conn *isert_conn)
 	rx_desc = isert_conn->rx_descs;
 	for (j = 0; j < i; j++, rx_desc++) {
 		ib_dma_unmap_single(ib_dev, rx_desc->dma_addr,
-				    ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+				    ISER_RX_SIZE, DMA_FROM_DEVICE);
 	}
 	kfree(isert_conn->rx_descs);
 	isert_conn->rx_descs = NULL;
@@ -181,7 +182,7 @@ isert_free_rx_descriptors(struct isert_conn *isert_conn)
 	rx_desc = isert_conn->rx_descs;
 	for (i = 0; i < ISERT_QP_MAX_RECV_DTOS; i++, rx_desc++)  {
 		ib_dma_unmap_single(ib_dev, rx_desc->dma_addr,
-				    ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+				    ISER_RX_SIZE, DMA_FROM_DEVICE);
 	}
 
 	kfree(isert_conn->rx_descs);
@@ -299,10 +300,10 @@ isert_free_login_buf(struct isert_conn *isert_conn)
 			    ISER_RX_PAYLOAD_SIZE, DMA_TO_DEVICE);
 	kfree(isert_conn->login_rsp_buf);
 
-	ib_dma_unmap_single(ib_dev, isert_conn->login_req_dma,
-			    ISER_RX_PAYLOAD_SIZE,
+	ib_dma_unmap_single(ib_dev, isert_conn->login_desc->dma_addr,
+			    ISER_RX_SIZE,
 			    DMA_FROM_DEVICE);
-	kfree(isert_conn->login_req_buf);
+	kfree(isert_conn->login_desc);
 }
 
 static int
@@ -311,25 +312,25 @@ isert_alloc_login_buf(struct isert_conn *isert_conn,
 {
 	int ret;
 
-	isert_conn->login_req_buf = kzalloc(sizeof(*isert_conn->login_req_buf),
+	isert_conn->login_desc = kzalloc(sizeof(*isert_conn->login_desc),
 			GFP_KERNEL);
-	if (!isert_conn->login_req_buf)
+	if (!isert_conn->login_desc)
 		return -ENOMEM;
 
-	isert_conn->login_req_dma = ib_dma_map_single(ib_dev,
-				isert_conn->login_req_buf,
-				ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
-	ret = ib_dma_mapping_error(ib_dev, isert_conn->login_req_dma);
+	isert_conn->login_desc->dma_addr = ib_dma_map_single(ib_dev,
+				isert_conn->login_desc->buf,
+				ISER_RX_SIZE, DMA_FROM_DEVICE);
+	ret = ib_dma_mapping_error(ib_dev, isert_conn->login_desc->dma_addr);
 	if (ret) {
-		isert_err("login_req_dma mapping error: %d\n", ret);
-		isert_conn->login_req_dma = 0;
-		goto out_free_login_req_buf;
+		isert_err("login_desc dma mapping error: %d\n", ret);
+		isert_conn->login_desc->dma_addr = 0;
+		goto out_free_login_desc;
 	}
 
 	isert_conn->login_rsp_buf = kzalloc(ISER_RX_PAYLOAD_SIZE, GFP_KERNEL);
 	if (!isert_conn->login_rsp_buf) {
 		ret = -ENOMEM;
-		goto out_unmap_login_req_buf;
+		goto out_unmap_login_desc;
 	}
 
 	isert_conn->login_rsp_dma = ib_dma_map_single(ib_dev,
@@ -346,11 +347,11 @@ isert_alloc_login_buf(struct isert_conn *isert_conn,
 
 out_free_login_rsp_buf:
 	kfree(isert_conn->login_rsp_buf);
-out_unmap_login_req_buf:
-	ib_dma_unmap_single(ib_dev, isert_conn->login_req_dma,
-			    ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
-out_free_login_req_buf:
-	kfree(isert_conn->login_req_buf);
+out_unmap_login_desc:
+	ib_dma_unmap_single(ib_dev, isert_conn->login_desc->dma_addr,
+			    ISER_RX_SIZE, DMA_FROM_DEVICE);
+out_free_login_desc:
+	kfree(isert_conn->login_desc);
 	return ret;
 }
 
@@ -476,7 +477,7 @@ isert_connect_release(struct isert_conn *isert_conn)
 	if (isert_conn->qp)
 		isert_destroy_qp(isert_conn);
 
-	if (isert_conn->login_req_buf)
+	if (isert_conn->login_desc)
 		isert_free_login_buf(isert_conn);
 
 	isert_device_put(device);
@@ -862,17 +863,18 @@ isert_login_post_recv(struct isert_conn *isert_conn)
 	int ret;
 
 	memset(&sge, 0, sizeof(struct ib_sge));
-	sge.addr = isert_conn->login_req_dma;
+	sge.addr = isert_conn->login_desc->dma_addr +
+		isert_get_hdr_offset(isert_conn->login_desc);
 	sge.length = ISER_RX_PAYLOAD_SIZE;
 	sge.lkey = isert_conn->device->pd->local_dma_lkey;
 
 	isert_dbg("Setup sge: addr: %llx length: %d 0x%08x\n",
 		sge.addr, sge.length, sge.lkey);
 
-	isert_conn->login_req_buf->rx_cqe.done = isert_login_recv_done;
+	isert_conn->login_desc->rx_cqe.done = isert_login_recv_done;
 
 	memset(&rx_wr, 0, sizeof(struct ib_recv_wr));
-	rx_wr.wr_cqe = &isert_conn->login_req_buf->rx_cqe;
+	rx_wr.wr_cqe = &isert_conn->login_desc->rx_cqe;
 	rx_wr.sg_list = &sge;
 	rx_wr.num_sge = 1;
 
@@ -949,7 +951,7 @@ isert_put_login_tx(struct iscsi_conn *conn, struct iscsi_login *login,
 static void
 isert_rx_login_req(struct isert_conn *isert_conn)
 {
-	struct iser_rx_desc *rx_desc = isert_conn->login_req_buf;
+	struct iser_rx_desc *rx_desc = isert_conn->login_desc;
 	int rx_buflen = isert_conn->login_req_len;
 	struct iscsi_conn *conn = isert_conn->conn;
 	struct iscsi_login *login = conn->conn_login;
@@ -961,7 +963,7 @@ isert_rx_login_req(struct isert_conn *isert_conn)
 
 	if (login->first_request) {
 		struct iscsi_login_req *login_req =
-			(struct iscsi_login_req *)&rx_desc->iscsi_header;
+			(struct iscsi_login_req *)isert_get_iscsi_hdr(rx_desc);
 		/*
 		 * Setup the initial iscsi_login values from the leading
 		 * login request PDU.
@@ -980,13 +982,13 @@ isert_rx_login_req(struct isert_conn *isert_conn)
 		login->tsih		= be16_to_cpu(login_req->tsih);
 	}
 
-	memcpy(&login->req[0], (void *)&rx_desc->iscsi_header, ISCSI_HDR_LEN);
+	memcpy(&login->req[0], isert_get_iscsi_hdr(rx_desc), ISCSI_HDR_LEN);
 
 	size = min(rx_buflen, MAX_KEY_VALUE_PAIRS);
 	isert_dbg("Using login payload size: %d, rx_buflen: %d "
 		  "MAX_KEY_VALUE_PAIRS: %d\n", size, rx_buflen,
 		  MAX_KEY_VALUE_PAIRS);
-	memcpy(login->req_buf, &rx_desc->data[0], size);
+	memcpy(login->req_buf, isert_get_data(rx_desc), size);
 
 	if (login->first_request) {
 		complete(&isert_conn->login_comp);
@@ -1051,14 +1053,15 @@ isert_handle_scsi_cmd(struct isert_conn *isert_conn,
 	if (imm_data_len != data_len) {
 		sg_nents = max(1UL, DIV_ROUND_UP(imm_data_len, PAGE_SIZE));
 		sg_copy_from_buffer(cmd->se_cmd.t_data_sg, sg_nents,
-				    &rx_desc->data[0], imm_data_len);
+				    isert_get_data(rx_desc), imm_data_len);
 		isert_dbg("Copy Immediate sg_nents: %u imm_data_len: %d\n",
 			  sg_nents, imm_data_len);
 	} else {
 		sg_init_table(&isert_cmd->sg, 1);
 		cmd->se_cmd.t_data_sg = &isert_cmd->sg;
 		cmd->se_cmd.t_data_nents = 1;
-		sg_set_buf(&isert_cmd->sg, &rx_desc->data[0], imm_data_len);
+		sg_set_buf(&isert_cmd->sg, isert_get_data(rx_desc),
+				imm_data_len);
 		isert_dbg("Transfer Immediate imm_data_len: %d\n",
 			  imm_data_len);
 	}
@@ -1127,9 +1130,9 @@ isert_handle_iscsi_dataout(struct isert_conn *isert_conn,
 	}
 	isert_dbg("Copying DataOut: sg_start: %p, sg_off: %u "
 		  "sg_nents: %u from %p %u\n", sg_start, sg_off,
-		  sg_nents, &rx_desc->data[0], unsol_data_len);
+		  sg_nents, isert_get_data(rx_desc), unsol_data_len);
 
-	sg_copy_from_buffer(sg_start, sg_nents, &rx_desc->data[0],
+	sg_copy_from_buffer(sg_start, sg_nents, isert_get_data(rx_desc),
 			    unsol_data_len);
 
 	rc = iscsit_check_dataout_payload(cmd, hdr, false);
@@ -1188,7 +1191,7 @@ isert_handle_text_cmd(struct isert_conn *isert_conn, struct isert_cmd *isert_cmd
 	}
 	cmd->text_in_ptr = text_in;
 
-	memcpy(cmd->text_in_ptr, &rx_desc->data[0], payload_length);
+	memcpy(cmd->text_in_ptr, isert_get_data(rx_desc), payload_length);
 
 	return iscsit_process_text_cmd(conn, cmd, hdr);
 }
@@ -1198,7 +1201,7 @@ isert_rx_opcode(struct isert_conn *isert_conn, struct iser_rx_desc *rx_desc,
 		uint32_t read_stag, uint64_t read_va,
 		uint32_t write_stag, uint64_t write_va)
 {
-	struct iscsi_hdr *hdr = &rx_desc->iscsi_header;
+	struct iscsi_hdr *hdr = isert_get_iscsi_hdr(rx_desc);
 	struct iscsi_conn *conn = isert_conn->conn;
 	struct iscsi_cmd *cmd;
 	struct isert_cmd *isert_cmd;
@@ -1296,8 +1299,8 @@ isert_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct isert_conn *isert_conn = wc->qp->qp_context;
 	struct ib_device *ib_dev = isert_conn->cm_id->device;
 	struct iser_rx_desc *rx_desc = cqe_to_rx_desc(wc->wr_cqe);
-	struct iscsi_hdr *hdr = &rx_desc->iscsi_header;
-	struct iser_ctrl *iser_ctrl = &rx_desc->iser_header;
+	struct iscsi_hdr *hdr = isert_get_iscsi_hdr(rx_desc);
+	struct iser_ctrl *iser_ctrl = isert_get_iser_hdr(rx_desc);
 	uint64_t read_va = 0, write_va = 0;
 	uint32_t read_stag = 0, write_stag = 0;
 
@@ -1311,7 +1314,7 @@ isert_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	rx_desc->in_use = true;
 
 	ib_dma_sync_single_for_cpu(ib_dev, rx_desc->dma_addr,
-			ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+			ISER_RX_SIZE, DMA_FROM_DEVICE);
 
 	isert_dbg("DMA: 0x%llx, iSCSI opcode: 0x%02x, ITT: 0x%08x, flags: 0x%02x dlen: %d\n",
 		 rx_desc->dma_addr, hdr->opcode, hdr->itt, hdr->flags,
@@ -1346,7 +1349,7 @@ isert_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 			read_stag, read_va, write_stag, write_va);
 
 	ib_dma_sync_single_for_device(ib_dev, rx_desc->dma_addr,
-			ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+			ISER_RX_SIZE, DMA_FROM_DEVICE);
 }
 
 static void
@@ -1360,8 +1363,8 @@ isert_login_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		return;
 	}
 
-	ib_dma_sync_single_for_cpu(ib_dev, isert_conn->login_req_dma,
-			ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+	ib_dma_sync_single_for_cpu(ib_dev, isert_conn->login_desc->dma_addr,
+			ISER_RX_SIZE, DMA_FROM_DEVICE);
 
 	isert_conn->login_req_len = wc->byte_len - ISER_HEADERS_LEN;
 
@@ -1376,8 +1379,8 @@ isert_login_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	complete(&isert_conn->login_req_comp);
 	mutex_unlock(&isert_conn->mutex);
 
-	ib_dma_sync_single_for_device(ib_dev, isert_conn->login_req_dma,
-				ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+	ib_dma_sync_single_for_device(ib_dev, isert_conn->login_desc->dma_addr,
+				ISER_RX_SIZE, DMA_FROM_DEVICE);
 }
 
 static void
diff --git a/drivers/infiniband/ulp/isert/ib_isert.h b/drivers/infiniband/ulp/isert/ib_isert.h
index c55f7d9bfced..7fee4a65e181 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.h
+++ b/drivers/infiniband/ulp/isert/ib_isert.h
@@ -59,9 +59,11 @@
 				ISERT_MAX_TX_MISC_PDUS	+ \
 				ISERT_MAX_RX_MISC_PDUS)
 
-#define ISER_RX_PAD_SIZE	(ISCSI_DEF_MAX_RECV_SEG_LEN + 4096 - \
-		(ISER_RX_PAYLOAD_SIZE + sizeof(u64) + sizeof(struct ib_sge) + \
-		 sizeof(struct ib_cqe) + sizeof(bool)))
+/*
+ * RX size is default of 8k plus headers, but data needs to align to
+ * 512 boundary, so use 1024 to have the extra space for alignment.
+ */
+#define ISER_RX_SIZE		(ISCSI_DEF_MAX_RECV_SEG_LEN + 1024)
 
 /* Maximum support is 16MB I/O size */
 #define ISCSI_ISER_MAX_SG_TABLESIZE	4096
@@ -81,21 +83,41 @@ enum iser_conn_state {
 };
 
 struct iser_rx_desc {
-	struct iser_ctrl iser_header;
-	struct iscsi_hdr iscsi_header;
-	char		data[ISCSI_DEF_MAX_RECV_SEG_LEN];
+	char		buf[ISER_RX_SIZE];
 	u64		dma_addr;
 	struct ib_sge	rx_sg;
 	struct ib_cqe	rx_cqe;
 	bool		in_use;
-	char		pad[ISER_RX_PAD_SIZE];
-} __packed;
+};
 
 static inline struct iser_rx_desc *cqe_to_rx_desc(struct ib_cqe *cqe)
 {
 	return container_of(cqe, struct iser_rx_desc, rx_cqe);
 }
 
+static void *isert_get_iser_hdr(struct iser_rx_desc *desc)
+{
+	return PTR_ALIGN(desc->buf + ISER_HEADERS_LEN, 512) - ISER_HEADERS_LEN;
+}
+
+static size_t isert_get_hdr_offset(struct iser_rx_desc *desc)
+{
+	return isert_get_iser_hdr(desc) - (void *)desc->buf;
+}
+
+static void *isert_get_iscsi_hdr(struct iser_rx_desc *desc)
+{
+	return isert_get_iser_hdr(desc) + sizeof(struct iser_ctrl);
+}
+
+static void *isert_get_data(struct iser_rx_desc *desc)
+{
+	void *data = isert_get_iser_hdr(desc) + ISER_HEADERS_LEN;
+
+	WARN_ON((uintptr_t)data & 511);
+	return data;
+}
+
 struct iser_tx_desc {
 	struct iser_ctrl iser_header;
 	struct iscsi_hdr iscsi_header;
@@ -142,9 +164,8 @@ struct isert_conn {
 	u32			responder_resources;
 	u32			initiator_depth;
 	bool			pi_support;
-	struct iser_rx_desc	*login_req_buf;
+	struct iser_rx_desc	*login_desc;
 	char			*login_rsp_buf;
-	u64			login_req_dma;
 	int			login_req_len;
 	u64			login_rsp_dma;
 	struct iser_rx_desc	*rx_descs;
-- 
2.25.1

