Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79A2319A2FA
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2020 02:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbgDAAiJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Mar 2020 20:38:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40099 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbgDAAiJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Mar 2020 20:38:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id c20so8653803pfi.7;
        Tue, 31 Mar 2020 17:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=fomeD+qj1TL1z8Wm9aBYPWwQwEL4Nc//JYHLcMFQPKA=;
        b=E5pCYiWIAquY1eyY/tnbP4bXxOp0fuKcj73OpTNfNJemaTe39KfJcW4cVSeyDXURnG
         /vsN/ZXhSgtR68jGBkSoElYKb8Uc296S9sZvB4NS6RhuSSkXAcEobaGdthxUm+ibrgVE
         kyEAmDeTmIWcQr3DuJKsLzglwvsbZ4Z9MDRFWKVLzYLrZv/oebGM5Orhvqa/q01W3Dvr
         D49H9K+1FnpOBxiXzfS5fJg4mH7HqC85fx0RyRZWlZ3+PHbkpV1KV15s8OWhG0VHHMdz
         vgILtiE813F1QLiTzKOx8+0/RWnyN/huAd426FZC19WnsBY3d/0b65ZuqVjf1I3EfAs9
         RHxQ==
X-Gm-Message-State: ANhLgQ0drdKh+YHjYGEwUQcd1twzuvo9GCXWJvhnSYlfSQc3ErzI1D1d
        e+kbqyQUHZRtRVtJohvOVVnjQILf
X-Google-Smtp-Source: ADFU+vvExyoYTn5mMPTAGl4okhxlbut7yoAtltbkjVzvHvAj6kBLLKjDtgjZfk9XIHBOzUs8/O7LyA==
X-Received: by 2002:aa7:9530:: with SMTP id c16mr21670949pfp.157.1585701486178;
        Tue, 31 Mar 2020 17:38:06 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:cca1:4ce7:5ea6:1461? ([2601:647:4802:9070:cca1:4ce7:5ea6:1461])
        by smtp.gmail.com with ESMTPSA id m14sm221989pje.19.2020.03.31.17.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2020 17:38:04 -0700 (PDT)
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
To:     Stephen Rust <srust@blockbridge.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Max Gurtovoy <maxg@mellanox.com>
References: <CAAFE1beMkvyRctGqpffd3o_QtDH0CrmQSb=fV4GzqMUXWzPyOw@mail.gmail.com>
 <20191203005849.GB25002@ming.t460p>
 <CAAFE1bcG8c1Q3iwh-LUjruBMAuFTJ4qWxNGsnhfKvGWHNLAeEQ@mail.gmail.com>
 <20191203031444.GB6245@ming.t460p>
 <CAAFE1besnb=HV4C_buORYpWbkXecmtybwX8d_Ka2NsKmiym53w@mail.gmail.com>
 <CAAFE1bfpUWCZrtR8v3S++0-+gi8DJ79X3e0XqDe93i8nuGTnNg@mail.gmail.com>
 <20191203124558.GA22805@ming.t460p>
 <CAAFE1bfB2Km+e=T0ahwq0r9BQrBMnSguQQ+y=yzYi3tursS+TQ@mail.gmail.com>
 <20191204010529.GA3910@ming.t460p>
 <CAAFE1bcJmRP5OSu=5asNTpvkF=kjEZu=GafaS9h52776tVgpPA@mail.gmail.com>
 <20191204230225.GA26189@ming.t460p>
 <d9d39d10-d3f3-f2d8-b32e-96896ba0cdb2@grimberg.me>
 <CAAFE1beqFBQS_zVYEXFTD2qu8PAF9hBSW4j1k9ZD6MhU_gWg5Q@mail.gmail.com>
 <d2f633f1-57ef-4618-c3a6-c5ff0afead5b@grimberg.me>
 <CAAFE1bdAbKfqbf05pKBcMUj+58fijDMT-8WBSuwiKk2Bmm4v2w@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <95750c05-eb49-d1db-311f-4edf9b4fd6ec@grimberg.me>
Date:   Tue, 31 Mar 2020 17:38:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAAFE1bdAbKfqbf05pKBcMUj+58fijDMT-8WBSuwiKk2Bmm4v2w@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------5285F564B3B650B9B7441799"
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a multi-part message in MIME format.
--------------5285F564B3B650B9B7441799
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey Stephen,

> I have run our tests against this patch and it is working well for our
> "basic" testing as well. The test case that previously failed, now
> passes with this patch. So that's encouraging! Thanks for the quick
> response and quick patch.
> 
> One question we had is regarding the hard coded header length: What
> happens if the initiator sends an extended CDB, like a WRITE32? Are
> there any concerns with an additional header segment (AHS)?

Does the attached patch work for you?

--------------5285F564B3B650B9B7441799
Content-Type: text/x-patch;
 name="0001-IB-isert-fix-unaligned-immediate-data-handling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-IB-isert-fix-unaligned-immediate-data-handling.patch"

From 219dc38b527445b70b4b839bbb8fc920aad41f7d Mon Sep 17 00:00:00 2001
From: Sagi Grimberg <sagi@grimberg.me>
Date: Tue, 31 Mar 2020 00:39:58 -0700
Subject: [PATCH] IB/isert: fix unaligned immediate-data handling

Currently we allocate rx buffers in a single contiguous buffers
for headers (iser and iscsi) and data trailer. This means
that most likely the data starting offset is aligned to 76
bytes (size of both headers).

This worked fine for years, but at some point this broke.
To fix this, we should avoid passing unaligned buffers for
I/O.

Instead, we allocate our recv buffers with some extra space
such that we can have the data portion align to 512 byte boundary.
This also means that we cannot reference headers or data using
structure but rather accessors (as they may move based on alignment).
Also, get rid of the wrong __packed annotation from iser_rx_desc
as this has only harmful effects (not aligned to anything).

This affects the rx descriptors for iscsi login and data plane.

Reported-by: Stephen Rust <srust@blockbridge.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 93 +++++++++++++------------
 drivers/infiniband/ulp/isert/ib_isert.h | 41 ++++++++---
 2 files changed, 79 insertions(+), 55 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index a1a035270cab..60315d1a88c0 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -182,15 +182,16 @@ isert_alloc_rx_descriptors(struct isert_conn *isert_conn)
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
@@ -202,7 +203,7 @@ isert_alloc_rx_descriptors(struct isert_conn *isert_conn)
 	rx_desc = isert_conn->rx_descs;
 	for (j = 0; j < i; j++, rx_desc++) {
 		ib_dma_unmap_single(ib_dev, rx_desc->dma_addr,
-				    ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+				    ISER_RX_SIZE, DMA_FROM_DEVICE);
 	}
 	kfree(isert_conn->rx_descs);
 	isert_conn->rx_descs = NULL;
@@ -223,7 +224,7 @@ isert_free_rx_descriptors(struct isert_conn *isert_conn)
 	rx_desc = isert_conn->rx_descs;
 	for (i = 0; i < ISERT_QP_MAX_RECV_DTOS; i++, rx_desc++)  {
 		ib_dma_unmap_single(ib_dev, rx_desc->dma_addr,
-				    ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+				    ISER_RX_SIZE, DMA_FROM_DEVICE);
 	}
 
 	kfree(isert_conn->rx_descs);
@@ -408,10 +409,10 @@ isert_free_login_buf(struct isert_conn *isert_conn)
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
@@ -420,25 +421,25 @@ isert_alloc_login_buf(struct isert_conn *isert_conn,
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
@@ -455,11 +456,11 @@ isert_alloc_login_buf(struct isert_conn *isert_conn,
 
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
 
@@ -578,7 +579,7 @@ isert_connect_release(struct isert_conn *isert_conn)
 		ib_destroy_qp(isert_conn->qp);
 	}
 
-	if (isert_conn->login_req_buf)
+	if (isert_conn->login_desc)
 		isert_free_login_buf(isert_conn);
 
 	isert_device_put(device);
@@ -964,17 +965,18 @@ isert_login_post_recv(struct isert_conn *isert_conn)
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
 
@@ -1051,7 +1053,7 @@ isert_put_login_tx(struct iscsi_conn *conn, struct iscsi_login *login,
 static void
 isert_rx_login_req(struct isert_conn *isert_conn)
 {
-	struct iser_rx_desc *rx_desc = isert_conn->login_req_buf;
+	struct iser_rx_desc *rx_desc = isert_conn->login_desc;
 	int rx_buflen = isert_conn->login_req_len;
 	struct iscsi_conn *conn = isert_conn->conn;
 	struct iscsi_login *login = conn->conn_login;
@@ -1063,7 +1065,7 @@ isert_rx_login_req(struct isert_conn *isert_conn)
 
 	if (login->first_request) {
 		struct iscsi_login_req *login_req =
-			(struct iscsi_login_req *)&rx_desc->iscsi_header;
+			(struct iscsi_login_req *)isert_get_iscsi_hdr(rx_desc);
 		/*
 		 * Setup the initial iscsi_login values from the leading
 		 * login request PDU.
@@ -1082,13 +1084,13 @@ isert_rx_login_req(struct isert_conn *isert_conn)
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
@@ -1153,14 +1155,15 @@ isert_handle_scsi_cmd(struct isert_conn *isert_conn,
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
@@ -1229,9 +1232,9 @@ isert_handle_iscsi_dataout(struct isert_conn *isert_conn,
 	}
 	isert_dbg("Copying DataOut: sg_start: %p, sg_off: %u "
 		  "sg_nents: %u from %p %u\n", sg_start, sg_off,
-		  sg_nents, &rx_desc->data[0], unsol_data_len);
+		  sg_nents, isert_get_data(rx_desc), unsol_data_len);
 
-	sg_copy_from_buffer(sg_start, sg_nents, &rx_desc->data[0],
+	sg_copy_from_buffer(sg_start, sg_nents, isert_get_data(rx_desc),
 			    unsol_data_len);
 
 	rc = iscsit_check_dataout_payload(cmd, hdr, false);
@@ -1290,7 +1293,7 @@ isert_handle_text_cmd(struct isert_conn *isert_conn, struct isert_cmd *isert_cmd
 	}
 	cmd->text_in_ptr = text_in;
 
-	memcpy(cmd->text_in_ptr, &rx_desc->data[0], payload_length);
+	memcpy(cmd->text_in_ptr, isert_get_data(rx_desc), payload_length);
 
 	return iscsit_process_text_cmd(conn, cmd, hdr);
 }
@@ -1300,7 +1303,7 @@ isert_rx_opcode(struct isert_conn *isert_conn, struct iser_rx_desc *rx_desc,
 		uint32_t read_stag, uint64_t read_va,
 		uint32_t write_stag, uint64_t write_va)
 {
-	struct iscsi_hdr *hdr = &rx_desc->iscsi_header;
+	struct iscsi_hdr *hdr = isert_get_iscsi_hdr(rx_desc);
 	struct iscsi_conn *conn = isert_conn->conn;
 	struct iscsi_cmd *cmd;
 	struct isert_cmd *isert_cmd;
@@ -1398,8 +1401,8 @@ isert_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct isert_conn *isert_conn = wc->qp->qp_context;
 	struct ib_device *ib_dev = isert_conn->cm_id->device;
 	struct iser_rx_desc *rx_desc = cqe_to_rx_desc(wc->wr_cqe);
-	struct iscsi_hdr *hdr = &rx_desc->iscsi_header;
-	struct iser_ctrl *iser_ctrl = &rx_desc->iser_header;
+	struct iscsi_hdr *hdr = isert_get_iscsi_hdr(rx_desc);
+	struct iser_ctrl *iser_ctrl = isert_get_iser_hdr(rx_desc);
 	uint64_t read_va = 0, write_va = 0;
 	uint32_t read_stag = 0, write_stag = 0;
 
@@ -1413,7 +1416,7 @@ isert_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	rx_desc->in_use = true;
 
 	ib_dma_sync_single_for_cpu(ib_dev, rx_desc->dma_addr,
-			ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+			ISER_RX_SIZE, DMA_FROM_DEVICE);
 
 	isert_dbg("DMA: 0x%llx, iSCSI opcode: 0x%02x, ITT: 0x%08x, flags: 0x%02x dlen: %d\n",
 		 rx_desc->dma_addr, hdr->opcode, hdr->itt, hdr->flags,
@@ -1448,7 +1451,7 @@ isert_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 			read_stag, read_va, write_stag, write_va);
 
 	ib_dma_sync_single_for_device(ib_dev, rx_desc->dma_addr,
-			ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+			ISER_RX_SIZE, DMA_FROM_DEVICE);
 }
 
 static void
@@ -1462,8 +1465,8 @@ isert_login_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		return;
 	}
 
-	ib_dma_sync_single_for_cpu(ib_dev, isert_conn->login_req_dma,
-			ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+	ib_dma_sync_single_for_cpu(ib_dev, isert_conn->login_desc->dma_addr,
+			ISER_RX_SIZE, DMA_FROM_DEVICE);
 
 	isert_conn->login_req_len = wc->byte_len - ISER_HEADERS_LEN;
 
@@ -1478,8 +1481,8 @@ isert_login_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	complete(&isert_conn->login_req_comp);
 	mutex_unlock(&isert_conn->mutex);
 
-	ib_dma_sync_single_for_device(ib_dev, isert_conn->login_req_dma,
-				ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+	ib_dma_sync_single_for_device(ib_dev, isert_conn->login_desc->dma_addr,
+				ISER_RX_SIZE, DMA_FROM_DEVICE);
 }
 
 static void
diff --git a/drivers/infiniband/ulp/isert/ib_isert.h b/drivers/infiniband/ulp/isert/ib_isert.h
index 3b296bac4f60..d267a6d60d87 100644
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
 
 #define ISCSI_ISER_SG_TABLESIZE		256
 
@@ -80,21 +82,41 @@ enum iser_conn_state {
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
@@ -141,9 +163,8 @@ struct isert_conn {
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
2.20.1


--------------5285F564B3B650B9B7441799--
