Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4599191DEB
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2020 01:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgCYAP7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Mar 2020 20:15:59 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35409 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgCYAP7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Mar 2020 20:15:59 -0400
Received: by mail-pj1-f68.google.com with SMTP id g9so271907pjp.0;
        Tue, 24 Mar 2020 17:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=ISj8keIWc+1N2dSoXMWBKe2wCGyFqzqTm8WK0ByRHjw=;
        b=iFopmqG59m32hm3Oo3M5jjDQQmOFw7DRqgYgcQf17uHt3204Wt8UWlJug91Mqg52hl
         Bt3h+YLr2Ek+fOW1u4A7vjWzqPuW7W79md12adq8wnMiK+NMNJ5Za0f1eK+VTdgeh3+W
         sdzLJj/Rqqq3dt/L2X35KwB7ESsrCprCwCNECuMd1PNiQTeJD7dIuTqSgYk9IBOMshjf
         qoiN/5p0K9wsRXWJr4gWK5/ZA5UPwumicv013bg5+YZAEc81xGwtQAizdh0cwRbKAcR8
         4vNFmchrt8sGiEk8JzYnp//afAopWr019e0WC94PPNsw1lZtVh9Ez3I988wXbQPkKyco
         tUQg==
X-Gm-Message-State: ANhLgQ1IDdRA1RCoVp59xowz7qDWWrb1vlyNhY/pVnuoVMT5hLltpT/f
        8IB5TPjCffg2lrXiBy7MCMk=
X-Google-Smtp-Source: ADFU+vuyYLuz7SGGp2hpnt5YziJUJckYG5pE2XcQlPK85cm+1Z32P+8r7ClKodx/HsFI0LcF2R1Qhg==
X-Received: by 2002:a17:902:b088:: with SMTP id p8mr634469plr.106.1585095357484;
        Tue, 24 Mar 2020 17:15:57 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2c87:e6f8:1c11:1d73? ([2601:647:4802:9070:2c87:e6f8:1c11:1d73])
        by smtp.gmail.com with ESMTPSA id y15sm17235393pfc.206.2020.03.24.17.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 17:15:56 -0700 (PDT)
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
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d2f633f1-57ef-4618-c3a6-c5ff0afead5b@grimberg.me>
Date:   Tue, 24 Mar 2020 17:15:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAAFE1beqFBQS_zVYEXFTD2qu8PAF9hBSW4j1k9ZD6MhU_gWg5Q@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------5224E775EEFB2B7480686C18"
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a multi-part message in MIME format.
--------------5224E775EEFB2B7480686C18
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

> Hi Sagi,

Hey Stephen,

>> So it looks from the report that this is the immediate-data and
>> unsolicited data-out flows, which indeed seem to violate the alignment
>> assumption. The reason is that isert post recv a contig rx_desc which
>> has both the headers and the data, and when it gets immediate_data it
>> will set the data sg to rx_desc+offset (which are the headers).
>>
>> Stephen,
>> As a work-around for now, you should turn off immediate-data in your LIO
>> target. I'll work on a fix.
> 
> I'm writing to see if you have had a chance to work on a fix for this yet?

Sorry for the late reply, lost track of this.

> We have a couple of followups as well:
> 
> - Based on Ming's previous comments, is it safe to assume all non-brd 
> drivers and nvme in particular are able to handle unaligned data? We are 
> concerned to enable ImmedataData in general, with this bug outstanding.
> 
> - We are seeing a 5-10% performance degradation when using 
> ImmediateData=No for our workloads. That is to say, having this issue 
> fixed is important to us. Anything we can help with, to provide testing 
> or otherwise, please let us know.

Can you try attached patch and see if it solves your issue?
WARNING: very lightly tested...

--------------5224E775EEFB2B7480686C18
Content-Type: text/x-patch;
 name="0001-IB-isert-fix-unaligned-immediate-data-handling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-IB-isert-fix-unaligned-immediate-data-handling.patch"

From ca7b6374d22efa8592a35d9d191672e7cbf84a44 Mon Sep 17 00:00:00 2001
From: Sagi Grimberg <sagi@grimberg.me>
Date: Tue, 24 Mar 2020 11:14:44 -0700
Subject: [PATCH] IB/isert: fix unaligned immediate-data handling

Currently we allocate rx buffers in a single contiguous buffers
for headers (iser and iscsi) and data trailer. This means
that most likely the data starting offset is aligned to 76
bytes (size of both headers).

This worked fine for years, but at some point this broke.
To fix this, we should avoid passing unaligned buffers for
I/O.

The fix is rather simple (although a bit invasive). Simply
allocate a buffer for the headers and a buffer for the data
and post a 2-entry recv work request.

Reported-by: Stephen Rust <srust@blockbridge.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 207 +++++++++++++-----------
 drivers/infiniband/ulp/isert/ib_isert.h |  18 +--
 2 files changed, 123 insertions(+), 102 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index a1a035270cab..bd27679d2a1b 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -129,7 +129,7 @@ isert_create_qp(struct isert_conn *isert_conn,
 	attr.cap.max_recv_wr = ISERT_QP_MAX_RECV_DTOS + 1;
 	attr.cap.max_rdma_ctxs = ISCSI_DEF_XMIT_CMDS_MAX;
 	attr.cap.max_send_sge = device->ib_device->attrs.max_send_sge;
-	attr.cap.max_recv_sge = 1;
+	attr.cap.max_recv_sge = 2;
 	attr.sq_sig_type = IB_SIGNAL_REQ_WR;
 	attr.qp_type = IB_QPT_RC;
 	if (device->pi_capable)
@@ -163,15 +163,74 @@ isert_conn_setup_qp(struct isert_conn *isert_conn, struct rdma_cm_id *cma_id)
 	return ret;
 }
 
+static int num_pages(int len)
+{
+	return 1 + (((len - 1) & PAGE_MASK) >> PAGE_SHIFT);
+}
+
+static void
+isert_free_rx_descriptor(struct iser_rx_desc *rx_desc, struct ib_device *ib_dev)
+{
+	struct ib_sge *rx_sg;
+
+	rx_sg = &rx_desc->rx_sg[1];
+	ib_dma_unmap_single(ib_dev, rx_sg->addr,
+			ISCSI_DEF_MAX_RECV_SEG_LEN, DMA_FROM_DEVICE);
+	free_pages((unsigned long)rx_desc->data,
+			num_pages(ISCSI_DEF_MAX_RECV_SEG_LEN));
+	rx_sg = &rx_desc->rx_sg[0];
+	ib_dma_unmap_single(ib_dev, rx_sg->addr,
+			ISER_HEADERS_LEN, DMA_FROM_DEVICE);
+}
+
+static int
+isert_alloc_rx_descriptor(struct iser_rx_desc *rx_desc, struct isert_device *device)
+{
+	struct ib_device *ib_dev = device->ib_device;
+	struct ib_sge *rx_sg;
+
+	/* headers */
+	rx_sg = &rx_desc->rx_sg[0];
+	rx_sg->addr = ib_dma_map_single(ib_dev, (void *)rx_desc,
+				ISER_HEADERS_LEN, DMA_FROM_DEVICE);
+	if (ib_dma_mapping_error(ib_dev, rx_sg->addr))
+		return -ENOMEM;
+
+	rx_sg->length = ISER_HEADERS_LEN;
+	rx_sg->lkey = device->pd->local_dma_lkey;
+
+	/* data */
+	rx_sg = &rx_desc->rx_sg[1];
+	rx_desc->data = (char *)__get_free_pages(GFP_KERNEL,
+				num_pages(ISCSI_DEF_MAX_RECV_SEG_LEN));
+	if (!rx_desc->data)
+		goto alloc_fail;
+
+	rx_sg->addr = ib_dma_map_single(ib_dev, (void *)rx_desc->data,
+				ISCSI_DEF_MAX_RECV_SEG_LEN, DMA_FROM_DEVICE);
+	if (ib_dma_mapping_error(ib_dev, rx_sg->addr))
+		goto data_map_fail;
+
+	rx_sg->length = ISCSI_DEF_MAX_RECV_SEG_LEN;
+	rx_sg->lkey = device->pd->local_dma_lkey;
+
+	return 0;
+
+data_map_fail:
+	kfree(rx_desc->data);
+alloc_fail:
+	rx_sg = &rx_desc->rx_sg[0];
+	ib_dma_unmap_single(ib_dev, rx_sg->addr,
+			ISER_HEADERS_LEN, DMA_FROM_DEVICE);
+	return -ENOMEM;
+}
+
 static int
 isert_alloc_rx_descriptors(struct isert_conn *isert_conn)
 {
 	struct isert_device *device = isert_conn->device;
 	struct ib_device *ib_dev = device->ib_device;
-	struct iser_rx_desc *rx_desc;
-	struct ib_sge *rx_sg;
-	u64 dma_addr;
-	int i, j;
+	int i;
 
 	isert_conn->rx_descs = kcalloc(ISERT_QP_MAX_RECV_DTOS,
 				       sizeof(struct iser_rx_desc),
@@ -179,32 +238,16 @@ isert_alloc_rx_descriptors(struct isert_conn *isert_conn)
 	if (!isert_conn->rx_descs)
 		return -ENOMEM;
 
-	rx_desc = isert_conn->rx_descs;
-
-	for (i = 0; i < ISERT_QP_MAX_RECV_DTOS; i++, rx_desc++)  {
-		dma_addr = ib_dma_map_single(ib_dev, (void *)rx_desc,
-					ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
-		if (ib_dma_mapping_error(ib_dev, dma_addr))
-			goto dma_map_fail;
-
-		rx_desc->dma_addr = dma_addr;
-
-		rx_sg = &rx_desc->rx_sg;
-		rx_sg->addr = rx_desc->dma_addr;
-		rx_sg->length = ISER_RX_PAYLOAD_SIZE;
-		rx_sg->lkey = device->pd->local_dma_lkey;
-		rx_desc->rx_cqe.done = isert_recv_done;
+	for (i = 0; i < ISERT_QP_MAX_RECV_DTOS; i++)  {
+		if (isert_alloc_rx_descriptor(&isert_conn->rx_descs[i], device))
+			goto alloc_fail;
 	}
 
 	return 0;
 
-dma_map_fail:
-	rx_desc = isert_conn->rx_descs;
-	for (j = 0; j < i; j++, rx_desc++) {
-		ib_dma_unmap_single(ib_dev, rx_desc->dma_addr,
-				    ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
-	}
-	kfree(isert_conn->rx_descs);
+alloc_fail:
+	while (--i)
+		isert_free_rx_descriptor(&isert_conn->rx_descs[i], ib_dev);
 	isert_conn->rx_descs = NULL;
 	isert_err("conn %p failed to allocate rx descriptors\n", isert_conn);
 	return -ENOMEM;
@@ -214,17 +257,13 @@ static void
 isert_free_rx_descriptors(struct isert_conn *isert_conn)
 {
 	struct ib_device *ib_dev = isert_conn->device->ib_device;
-	struct iser_rx_desc *rx_desc;
 	int i;
 
 	if (!isert_conn->rx_descs)
 		return;
 
-	rx_desc = isert_conn->rx_descs;
-	for (i = 0; i < ISERT_QP_MAX_RECV_DTOS; i++, rx_desc++)  {
-		ib_dma_unmap_single(ib_dev, rx_desc->dma_addr,
-				    ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
-	}
+	for (i = 0; i < ISERT_QP_MAX_RECV_DTOS; i++)
+		isert_free_rx_descriptor(&isert_conn->rx_descs[i], ib_dev);
 
 	kfree(isert_conn->rx_descs);
 	isert_conn->rx_descs = NULL;
@@ -407,11 +446,7 @@ isert_free_login_buf(struct isert_conn *isert_conn)
 	ib_dma_unmap_single(ib_dev, isert_conn->login_rsp_dma,
 			    ISER_RX_PAYLOAD_SIZE, DMA_TO_DEVICE);
 	kfree(isert_conn->login_rsp_buf);
-
-	ib_dma_unmap_single(ib_dev, isert_conn->login_req_dma,
-			    ISER_RX_PAYLOAD_SIZE,
-			    DMA_FROM_DEVICE);
-	kfree(isert_conn->login_req_buf);
+	isert_free_rx_descriptor(&isert_conn->login_desc, ib_dev);
 }
 
 static int
@@ -420,25 +455,15 @@ isert_alloc_login_buf(struct isert_conn *isert_conn,
 {
 	int ret;
 
-	isert_conn->login_req_buf = kzalloc(sizeof(*isert_conn->login_req_buf),
-			GFP_KERNEL);
-	if (!isert_conn->login_req_buf)
-		return -ENOMEM;
-
-	isert_conn->login_req_dma = ib_dma_map_single(ib_dev,
-				isert_conn->login_req_buf,
-				ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
-	ret = ib_dma_mapping_error(ib_dev, isert_conn->login_req_dma);
-	if (ret) {
-		isert_err("login_req_dma mapping error: %d\n", ret);
-		isert_conn->login_req_dma = 0;
-		goto out_free_login_req_buf;
-	}
+	ret = isert_alloc_rx_descriptor(&isert_conn->login_desc,
+					isert_conn->device);
+	if (ret)
+		return ret;
 
 	isert_conn->login_rsp_buf = kzalloc(ISER_RX_PAYLOAD_SIZE, GFP_KERNEL);
 	if (!isert_conn->login_rsp_buf) {
 		ret = -ENOMEM;
-		goto out_unmap_login_req_buf;
+		goto out_free_login_desc;
 	}
 
 	isert_conn->login_rsp_dma = ib_dma_map_single(ib_dev,
@@ -455,11 +480,8 @@ isert_alloc_login_buf(struct isert_conn *isert_conn,
 
 out_free_login_rsp_buf:
 	kfree(isert_conn->login_rsp_buf);
-out_unmap_login_req_buf:
-	ib_dma_unmap_single(ib_dev, isert_conn->login_req_dma,
-			    ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
-out_free_login_req_buf:
-	kfree(isert_conn->login_req_buf);
+out_free_login_desc:
+	isert_free_rx_descriptor(&isert_conn->login_desc, ib_dev);
 	return ret;
 }
 
@@ -516,10 +538,6 @@ isert_connect_request(struct rdma_cm_id *cma_id, struct rdma_cm_event *event)
 	isert_init_conn(isert_conn);
 	isert_conn->cm_id = cma_id;
 
-	ret = isert_alloc_login_buf(isert_conn, cma_id->device);
-	if (ret)
-		goto out;
-
 	device = isert_device_get(cma_id);
 	if (IS_ERR(device)) {
 		ret = PTR_ERR(device);
@@ -527,6 +545,10 @@ isert_connect_request(struct rdma_cm_id *cma_id, struct rdma_cm_event *event)
 	}
 	isert_conn->device = device;
 
+	ret = isert_alloc_login_buf(isert_conn, cma_id->device);
+	if (ret)
+		goto out;
+
 	isert_set_nego_params(isert_conn, &event->param.conn);
 
 	ret = isert_conn_setup_qp(isert_conn, cma_id);
@@ -578,7 +600,7 @@ isert_connect_release(struct isert_conn *isert_conn)
 		ib_destroy_qp(isert_conn->qp);
 	}
 
-	if (isert_conn->login_req_buf)
+	if (isert_conn->login_rsp_buf)
 		isert_free_login_buf(isert_conn);
 
 	isert_device_put(device);
@@ -809,9 +831,10 @@ isert_post_recvm(struct isert_conn *isert_conn, u32 count)
 	for (rx_wr = isert_conn->rx_wr, i = 0; i < count; i++, rx_wr++) {
 		rx_desc = &isert_conn->rx_descs[i];
 
+		rx_desc->rx_cqe.done = isert_recv_done;
 		rx_wr->wr_cqe = &rx_desc->rx_cqe;
-		rx_wr->sg_list = &rx_desc->rx_sg;
-		rx_wr->num_sge = 1;
+		rx_wr->sg_list = rx_desc->rx_sg;
+		rx_wr->num_sge = 2;
 		rx_wr->next = rx_wr + 1;
 		rx_desc->in_use = false;
 	}
@@ -840,9 +863,10 @@ isert_post_recv(struct isert_conn *isert_conn, struct iser_rx_desc *rx_desc)
 	}
 
 	rx_desc->in_use = false;
+	rx_desc->rx_cqe.done = isert_recv_done;
 	rx_wr.wr_cqe = &rx_desc->rx_cqe;
-	rx_wr.sg_list = &rx_desc->rx_sg;
-	rx_wr.num_sge = 1;
+	rx_wr.sg_list = rx_desc->rx_sg;
+	rx_wr.num_sge = 2;
 	rx_wr.next = NULL;
 
 	ret = ib_post_recv(isert_conn->qp, &rx_wr, NULL);
@@ -960,23 +984,13 @@ static int
 isert_login_post_recv(struct isert_conn *isert_conn)
 {
 	struct ib_recv_wr rx_wr;
-	struct ib_sge sge;
 	int ret;
 
-	memset(&sge, 0, sizeof(struct ib_sge));
-	sge.addr = isert_conn->login_req_dma;
-	sge.length = ISER_RX_PAYLOAD_SIZE;
-	sge.lkey = isert_conn->device->pd->local_dma_lkey;
-
-	isert_dbg("Setup sge: addr: %llx length: %d 0x%08x\n",
-		sge.addr, sge.length, sge.lkey);
-
-	isert_conn->login_req_buf->rx_cqe.done = isert_login_recv_done;
-
+	isert_conn->login_desc.rx_cqe.done = isert_login_recv_done;
 	memset(&rx_wr, 0, sizeof(struct ib_recv_wr));
-	rx_wr.wr_cqe = &isert_conn->login_req_buf->rx_cqe;
-	rx_wr.sg_list = &sge;
-	rx_wr.num_sge = 1;
+	rx_wr.wr_cqe = &isert_conn->login_desc.rx_cqe;
+	rx_wr.sg_list = isert_conn->login_desc.rx_sg;
+	rx_wr.num_sge = 2;
 
 	ret = ib_post_recv(isert_conn->qp, &rx_wr, NULL);
 	if (ret)
@@ -1051,7 +1065,7 @@ isert_put_login_tx(struct iscsi_conn *conn, struct iscsi_login *login,
 static void
 isert_rx_login_req(struct isert_conn *isert_conn)
 {
-	struct iser_rx_desc *rx_desc = isert_conn->login_req_buf;
+	struct iser_rx_desc *rx_desc = &isert_conn->login_desc;
 	int rx_buflen = isert_conn->login_req_len;
 	struct iscsi_conn *conn = isert_conn->conn;
 	struct iscsi_login *login = conn->conn_login;
@@ -1412,11 +1426,13 @@ isert_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 
 	rx_desc->in_use = true;
 
-	ib_dma_sync_single_for_cpu(ib_dev, rx_desc->dma_addr,
-			ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+	ib_dma_sync_single_for_cpu(ib_dev, rx_desc->rx_sg[0].addr,
+			ISER_HEADERS_LEN, DMA_FROM_DEVICE);
+	ib_dma_sync_single_for_cpu(ib_dev, rx_desc->rx_sg[1].addr,
+			ISCSI_DEF_MAX_RECV_SEG_LEN, DMA_FROM_DEVICE);
 
-	isert_dbg("DMA: 0x%llx, iSCSI opcode: 0x%02x, ITT: 0x%08x, flags: 0x%02x dlen: %d\n",
-		 rx_desc->dma_addr, hdr->opcode, hdr->itt, hdr->flags,
+	isert_dbg("iSCSI opcode: 0x%02x, ITT: 0x%08x, flags: 0x%02x dlen: %d\n",
+		 hdr->opcode, hdr->itt, hdr->flags,
 		 (int)(wc->byte_len - ISER_HEADERS_LEN));
 
 	switch (iser_ctrl->flags & 0xF0) {
@@ -1447,8 +1463,10 @@ isert_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	isert_rx_opcode(isert_conn, rx_desc,
 			read_stag, read_va, write_stag, write_va);
 
-	ib_dma_sync_single_for_device(ib_dev, rx_desc->dma_addr,
-			ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+	ib_dma_sync_single_for_device(ib_dev, rx_desc->rx_sg[0].addr,
+			ISER_HEADERS_LEN, DMA_FROM_DEVICE);
+	ib_dma_sync_single_for_device(ib_dev, rx_desc->rx_sg[1].addr,
+			ISCSI_DEF_MAX_RECV_SEG_LEN, DMA_FROM_DEVICE);
 }
 
 static void
@@ -1456,14 +1474,17 @@ isert_login_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct isert_conn *isert_conn = wc->qp->qp_context;
 	struct ib_device *ib_dev = isert_conn->device->ib_device;
+	struct iser_rx_desc *rx_desc = &isert_conn->login_desc;
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
 		isert_print_wc(wc, "login recv");
 		return;
 	}
 
-	ib_dma_sync_single_for_cpu(ib_dev, isert_conn->login_req_dma,
-			ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+	ib_dma_sync_single_for_cpu(ib_dev, rx_desc->rx_sg[0].addr,
+			ISER_HEADERS_LEN, DMA_FROM_DEVICE);
+	ib_dma_sync_single_for_cpu(ib_dev, rx_desc->rx_sg[1].addr,
+			ISCSI_DEF_MAX_RECV_SEG_LEN, DMA_FROM_DEVICE);
 
 	isert_conn->login_req_len = wc->byte_len - ISER_HEADERS_LEN;
 
@@ -1478,8 +1499,10 @@ isert_login_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	complete(&isert_conn->login_req_comp);
 	mutex_unlock(&isert_conn->mutex);
 
-	ib_dma_sync_single_for_device(ib_dev, isert_conn->login_req_dma,
-				ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+	ib_dma_sync_single_for_device(ib_dev, rx_desc->rx_sg[0].addr,
+			ISER_HEADERS_LEN, DMA_FROM_DEVICE);
+	ib_dma_sync_single_for_device(ib_dev, rx_desc->rx_sg[1].addr,
+			ISCSI_DEF_MAX_RECV_SEG_LEN, DMA_FROM_DEVICE);
 }
 
 static void
diff --git a/drivers/infiniband/ulp/isert/ib_isert.h b/drivers/infiniband/ulp/isert/ib_isert.h
index 3b296bac4f60..407bd6c9eb1f 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.h
+++ b/drivers/infiniband/ulp/isert/ib_isert.h
@@ -80,14 +80,13 @@ enum iser_conn_state {
 };
 
 struct iser_rx_desc {
-	struct iser_ctrl iser_header;
-	struct iscsi_hdr iscsi_header;
-	char		data[ISCSI_DEF_MAX_RECV_SEG_LEN];
-	u64		dma_addr;
-	struct ib_sge	rx_sg;
-	struct ib_cqe	rx_cqe;
-	bool		in_use;
-	char		pad[ISER_RX_PAD_SIZE];
+	struct iser_ctrl    iser_header;
+	struct iscsi_hdr    iscsi_header;
+	char                *data;
+	u64                 dma_addr[2];
+	struct ib_sge       rx_sg[2];
+	struct ib_cqe       rx_cqe;
+	bool	            in_use;
 } __packed;
 
 static inline struct iser_rx_desc *cqe_to_rx_desc(struct ib_cqe *cqe)
@@ -141,9 +140,8 @@ struct isert_conn {
 	u32			responder_resources;
 	u32			initiator_depth;
 	bool			pi_support;
-	struct iser_rx_desc	*login_req_buf;
+	struct iser_rx_desc	login_desc;
 	char			*login_rsp_buf;
-	u64			login_req_dma;
 	int			login_req_len;
 	u64			login_rsp_dma;
 	struct iser_rx_desc	*rx_descs;
-- 
2.20.1


--------------5224E775EEFB2B7480686C18--
