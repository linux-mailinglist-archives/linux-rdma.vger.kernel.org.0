Return-Path: <linux-rdma+bounces-240-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B575804243
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 00:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7A7FB20BC9
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 23:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFC623751;
	Mon,  4 Dec 2023 23:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="gaZ4faCY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0050D5;
	Mon,  4 Dec 2023 15:03:24 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1004)
	id 116E320B74C1; Mon,  4 Dec 2023 15:03:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 116E320B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1701731004;
	bh=KZ53rh4Ej3x/cVSA+BR5/VypWc8KvcoOEKi9H+/nGFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gaZ4faCYy2T47o9n4gTUOZQ5W0GQrfhoITESrVFaJ2bm4Sw7xFjXvnjjj34QHyZu7
	 ygqbJnhW/GuhDg6m/1bwK1n6qpffyK8C4F7D27eFFnO75Ee2BQ1U05+K4ikqdVnhe6
	 7GdMeYlzeNgIUvpr/wybnEE0zyhKMInhRKcfXBUM=
From: longli@linuxonhyperv.com
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: [Patch v2 2/3] RDMA/mana_ib: query device capabilities
Date: Mon,  4 Dec 2023 15:02:58 -0800
Message-Id: <1701730979-1148-3-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701730979-1148-1-git-send-email-longli@linuxonhyperv.com>
References: <1701730979-1148-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

With RDMA device registered, use it to query on hardware capabilities and
cache this information for future query requests to the driver.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c      |  2 +-
 drivers/infiniband/hw/mana/device.c  |  7 +++
 drivers/infiniband/hw/mana/main.c    | 65 ++++++++++++++++++++++------
 drivers/infiniband/hw/mana/mana_ib.h | 50 +++++++++++++++++++++
 drivers/infiniband/hw/mana/qp.c      |  4 +-
 include/net/mana/gdma.h              |  1 +
 6 files changed, 113 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index d141cab8a1e6..09a2c263e39b 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -26,7 +26,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		return err;
 	}
 
-	if (attr->cqe > MAX_SEND_BUFFERS_PER_QUEUE) {
+	if (attr->cqe > mdev->adapter_caps.max_qp_wr) {
 		ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
 		return -EINVAL;
 	}
diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index fe025e13a45c..e9494172195b 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -85,6 +85,13 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	}
 	dev->gdma_dev = &mdev->gdma_context->mana_ib;
 
+	ret = mana_ib_query_adapter_caps(dev);
+	if (ret) {
+		ibdev_err(&dev->ib_dev, "Failed to query device caps, ret %d",
+			  ret);
+		goto free_ib_device;
+	}
+
 	ret = ib_register_device(&dev->ib_dev, "mana_%d",
 				 mdev->gdma_context->dev);
 	if (ret)
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 53730306ed9b..8d8f711121d2 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -486,20 +486,17 @@ int mana_ib_get_port_immutable(struct ib_device *ibdev, u32 port_num,
 int mana_ib_query_device(struct ib_device *ibdev, struct ib_device_attr *props,
 			 struct ib_udata *uhw)
 {
-	props->max_qp = MANA_MAX_NUM_QUEUES;
-	props->max_qp_wr = MAX_SEND_BUFFERS_PER_QUEUE;
-
-	/*
-	 * max_cqe could be potentially much bigger.
-	 * As this version of driver only support RAW QP, set it to the same
-	 * value as max_qp_wr
-	 */
-	props->max_cqe = MAX_SEND_BUFFERS_PER_QUEUE;
-
+	struct mana_ib_dev *dev = container_of(ibdev,
+			struct mana_ib_dev, ib_dev);
+
+	props->max_qp = dev->adapter_caps.max_qp_count;
+	props->max_qp_wr = dev->adapter_caps.max_qp_wr;
+	props->max_cq = dev->adapter_caps.max_cq_count;
+	props->max_cqe = dev->adapter_caps.max_qp_wr;
+	props->max_mr = dev->adapter_caps.max_mr_count;
 	props->max_mr_size = MANA_IB_MAX_MR_SIZE;
-	props->max_mr = MANA_IB_MAX_MR;
-	props->max_send_sge = MAX_TX_WQE_SGL_ENTRIES;
-	props->max_recv_sge = MAX_RX_WQE_SGL_ENTRIES;
+	props->max_send_sge = dev->adapter_caps.max_send_sge_count;
+	props->max_recv_sge = dev->adapter_caps.max_recv_sge_count;
 
 	return 0;
 }
@@ -521,3 +518,45 @@ int mana_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
 void mana_ib_disassociate_ucontext(struct ib_ucontext *ibcontext)
 {
 }
+
+int mana_ib_query_adapter_caps(struct mana_ib_dev *dev)
+{
+	struct mana_ib_adapter_caps *caps = &dev->adapter_caps;
+	struct mana_ib_query_adapter_caps_resp resp = {};
+	struct mana_ib_query_adapter_caps_req req = {};
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_GET_ADAPTER_CAP, sizeof(req),
+			     sizeof(resp));
+	req.hdr.resp.msg_version = GDMA_MESSAGE_V3;
+	req.hdr.dev_id = dev->gdma_dev->dev_id;
+
+	err = mana_gd_send_request(dev->gdma_dev->gdma_context, sizeof(req),
+				   &req, sizeof(resp), &resp);
+
+	if (err) {
+		ibdev_err(&dev->ib_dev,
+			  "Failed to query adapter caps err %d", err);
+		return err;
+	}
+
+	caps->max_sq_id = resp.max_sq_id;
+	caps->max_rq_id = resp.max_rq_id;
+	caps->max_cq_id = resp.max_cq_id;
+	caps->max_qp_count = resp.max_qp_count;
+	caps->max_cq_count = resp.max_cq_count;
+	caps->max_mr_count = resp.max_mr_count;
+	caps->max_pd_count = resp.max_pd_count;
+	caps->max_inbound_read_limit = resp.max_inbound_read_limit;
+	caps->max_outbound_read_limit = resp.max_outbound_read_limit;
+	caps->mw_count = resp.mw_count;
+	caps->max_srq_count = resp.max_srq_count;
+	caps->max_qp_wr = min_t(u32,
+				resp.max_requester_sq_size / GDMA_MAX_SQE_SIZE,
+				resp.max_requester_rq_size / GDMA_MAX_RQE_SIZE);
+	caps->max_inline_data_size = resp.max_inline_data_size;
+	caps->max_send_sge_count = resp.max_send_sge_count;
+	caps->max_recv_sge_count = resp.max_recv_sge_count;
+
+	return 0;
+}
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 502cc8672eef..7cb3d8ee4292 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -27,9 +27,28 @@
  */
 #define MANA_IB_MAX_MR		0xFFFFFFu
 
+struct mana_ib_adapter_caps {
+	u32 max_sq_id;
+	u32 max_rq_id;
+	u32 max_cq_id;
+	u32 max_qp_count;
+	u32 max_cq_count;
+	u32 max_mr_count;
+	u32 max_pd_count;
+	u32 max_inbound_read_limit;
+	u32 max_outbound_read_limit;
+	u32 mw_count;
+	u32 max_srq_count;
+	u32 max_qp_wr;
+	u32 max_send_sge_count;
+	u32 max_recv_sge_count;
+	u32 max_inline_data_size;
+};
+
 struct mana_ib_dev {
 	struct ib_device ib_dev;
 	struct gdma_dev *gdma_dev;
+	struct mana_ib_adapter_caps adapter_caps;
 };
 
 struct mana_ib_wq {
@@ -92,6 +111,36 @@ struct mana_ib_rwq_ind_table {
 	struct ib_rwq_ind_table ib_ind_table;
 };
 
+enum mana_ib_command_code {
+	MANA_IB_GET_ADAPTER_CAP = 0x30001,
+};
+
+struct mana_ib_query_adapter_caps_req {
+	struct gdma_req_hdr hdr;
+}; /*HW Data */
+
+struct mana_ib_query_adapter_caps_resp {
+	struct gdma_resp_hdr hdr;
+	u32 max_sq_id;
+	u32 max_rq_id;
+	u32 max_cq_id;
+	u32 max_qp_count;
+	u32 max_cq_count;
+	u32 max_mr_count;
+	u32 max_pd_count;
+	u32 max_inbound_read_limit;
+	u32 max_outbound_read_limit;
+	u32 mw_count;
+	u32 max_srq_count;
+	u32 max_requester_sq_size;
+	u32 max_responder_sq_size;
+	u32 max_requester_rq_size;
+	u32 max_responder_rq_size;
+	u32 max_send_sge_count;
+	u32 max_recv_sge_count;
+	u32 max_inline_data_size;
+}; /* HW Data */
+
 int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 				 mana_handle_t *gdma_region);
 
@@ -159,4 +208,5 @@ int mana_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
 
 void mana_ib_disassociate_ucontext(struct ib_ucontext *ibcontext);
 
+int mana_ib_query_adapter_caps(struct mana_ib_dev *mdev);
 #endif
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index ae45d28eef5e..4667b18ec1dd 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -130,7 +130,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		return ret;
 	}
 
-	if (attr->cap.max_recv_wr > MAX_SEND_BUFFERS_PER_QUEUE) {
+	if (attr->cap.max_recv_wr > mdev->adapter_caps.max_qp_wr) {
 		ibdev_dbg(&mdev->ib_dev,
 			  "Requested max_recv_wr %d exceeding limit\n",
 			  attr->cap.max_recv_wr);
@@ -296,7 +296,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	if (port < 1 || port > mc->num_ports)
 		return -EINVAL;
 
-	if (attr->cap.max_send_wr > MAX_SEND_BUFFERS_PER_QUEUE) {
+	if (attr->cap.max_send_wr > mdev->adapter_caps.max_qp_wr) {
 		ibdev_dbg(&mdev->ib_dev,
 			  "Requested max_send_wr %d exceeding limit\n",
 			  attr->cap.max_send_wr);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 000f0d7670f7..797971e2d5a5 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -150,6 +150,7 @@ struct gdma_general_req {
 
 #define GDMA_MESSAGE_V1 1
 #define GDMA_MESSAGE_V2 2
+#define GDMA_MESSAGE_V3 3
 
 struct gdma_general_resp {
 	struct gdma_resp_hdr hdr;
-- 
2.25.1


