Return-Path: <linux-rdma+bounces-2311-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BDA8BDF02
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 11:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5B9281605
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 09:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304AA14EC59;
	Tue,  7 May 2024 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="T4EycvTV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFEC14D45A;
	Tue,  7 May 2024 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075610; cv=none; b=SZjs+XWJS9k9OIAe2EQ47UvNO85/66UyhracP25fy/s9a8PHCZNpn8Mxo7aTdg2VQ0Wnm/tvTlcpbXhfCvD151/qIjk3uDiLHKXEddykdblta8TnUkUxqljFKLZp/uEDwBAWIA9n21GS0m8ohF3hx0nvmHYI46vSDj2lLbg/fgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075610; c=relaxed/simple;
	bh=u3XlFpdCZ9lsFZRrUJFSR4+wTHMs3ygIZOXDPyq0WKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hgYuNCnwMuR/5arFAuCRpz8lIo9up51erXxNK1DULxpRllhpqQRohFtQi/Y8IL3t4o9eo0wywZ4vqjnsSu1JPFfbKIMZGvI7FeKiWKzsUh+/+4JuCOVt/EUuZnAbUPvN0DtO2oau0Tz4H2DAUJZCG2QbxWzhOI1ynfLvBZBTzk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=T4EycvTV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id F147220B2C86;
	Tue,  7 May 2024 02:53:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F147220B2C86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715075601;
	bh=4IpG279K1314hm6XloYIsMyL8H8ZvnpfqAe1xFTc+j4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T4EycvTV03aj4Ye/USGOa+KC00CUAqw5K00E5+Rdy9rK7uooB9/3ygcUf/DQjmM30
	 9P2IaJsNSs7rZe4DegoBpzrmieI9KiMcGSy+zioUaJtKWs7V9JRqW+n9AVcDde42rq
	 AtlseccUzKGQcFwcXB0HPkBaElm6lI1J8xl0oMeU=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 2/3] RDMA/mana_ib: Implement uapi to create and destroy RC QP
Date: Tue,  7 May 2024 02:53:14 -0700
Message-Id: <1715075595-24470-3-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1715075595-24470-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1715075595-24470-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Implement user requests to create and destroy an RC QP.
As the user does not have an FMR queue, it is skipped and NO_FMR flag
is used.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/mana_ib.h |  4 ++
 drivers/infiniband/hw/mana/qp.c      | 93 +++++++++++++++++++++++++++-
 include/uapi/rdma/mana-abi.h         |  9 +++
 3 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index a3e229c..5cccbe3 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -248,6 +248,10 @@ struct mana_rnic_destroy_cq_resp {
 	struct gdma_resp_hdr hdr;
 }; /* HW Data */
 
+enum mana_rnic_create_rc_flags {
+	MANA_RC_FLAG_NO_FMR = 2,
+};
+
 struct mana_rnic_create_qp_req {
 	struct gdma_req_hdr hdr;
 	mana_handle_t adapter;
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index ba13c5a..14e6adb 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -398,6 +398,78 @@ err_free_vport:
 	return err;
 }
 
+static int mana_ib_create_rc_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
+				struct ib_qp_init_attr *attr, struct ib_udata *udata)
+{
+	struct mana_ib_dev *mdev = container_of(ibpd->device, struct mana_ib_dev, ib_dev);
+	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
+	struct mana_ib_create_rc_qp_resp resp = {};
+	struct mana_ib_ucontext *mana_ucontext;
+	struct mana_ib_create_rc_qp ucmd = {};
+	int i, err, j;
+	u64 flags = 0;
+	u32 doorbell;
+
+	if (!udata || udata->inlen < sizeof(ucmd))
+		return -EINVAL;
+
+	mana_ucontext = rdma_udata_to_drv_context(udata, struct mana_ib_ucontext, ibucontext);
+	doorbell = mana_ucontext->doorbell;
+	flags = MANA_RC_FLAG_NO_FMR;
+	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
+	if (err) {
+		ibdev_dbg(&mdev->ib_dev, "Failed to copy from udata, %d\n", err);
+		return err;
+	}
+
+	for (i = 0, j = 0; i < MANA_RC_QUEUE_TYPE_MAX; ++i) {
+		// skip FMR for user-level RC QPs
+		if (i == MANA_RC_SEND_QUEUE_FMR) {
+			qp->rc_qp.queues[i].id = INVALID_QUEUE_ID;
+			qp->rc_qp.queues[i].gdma_region = GDMA_INVALID_DMA_REGION;
+			continue;
+		}
+		err = mana_ib_create_queue(mdev, ucmd.queue_buf[j], ucmd.queue_size[j],
+					   &qp->rc_qp.queues[i]);
+		if (err) {
+			ibdev_err(&mdev->ib_dev, "Failed to create queue %d, err %d\n", i, err);
+			goto destroy_queues;
+		}
+		j++;
+	}
+
+	err = mana_ib_gd_create_rc_qp(mdev, qp, attr, doorbell, flags);
+	if (err) {
+		ibdev_err(&mdev->ib_dev, "Failed to create rc qp  %d\n", err);
+		goto destroy_queues;
+	}
+	qp->ibqp.qp_num = qp->rc_qp.queues[MANA_RC_RECV_QUEUE_RESPONDER].id;
+	qp->port = attr->port_num;
+
+	if (udata) {
+		for (i = 0, j = 0; i < MANA_RC_QUEUE_TYPE_MAX; ++i) {
+			if (i == MANA_RC_SEND_QUEUE_FMR)
+				continue;
+			resp.queue_id[j] = qp->rc_qp.queues[i].id;
+			j++;
+		}
+		err = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
+		if (err) {
+			ibdev_dbg(&mdev->ib_dev, "Failed to copy to udata, %d\n", err);
+			goto destroy_qp;
+		}
+	}
+
+	return 0;
+
+destroy_qp:
+	mana_ib_gd_destroy_rc_qp(mdev, qp);
+destroy_queues:
+	while (i-- > 0)
+		mana_ib_destroy_queue(mdev, &qp->rc_qp.queues[i]);
+	return err;
+}
+
 int mana_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 		      struct ib_udata *udata)
 {
@@ -409,6 +481,8 @@ int mana_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 						     udata);
 
 		return mana_ib_create_qp_raw(ibqp, ibqp->pd, attr, udata);
+	case IB_QPT_RC:
+		return mana_ib_create_rc_qp(ibqp, ibqp->pd, attr, udata);
 	default:
 		/* Creating QP other than IB_QPT_RAW_PACKET is not supported */
 		ibdev_dbg(ibqp->device, "Creating QP type %u not supported\n",
@@ -473,6 +547,22 @@ static int mana_ib_destroy_qp_raw(struct mana_ib_qp *qp, struct ib_udata *udata)
 	return 0;
 }
 
+static int mana_ib_destroy_rc_qp(struct mana_ib_qp *qp, struct ib_udata *udata)
+{
+	struct mana_ib_dev *mdev =
+		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
+	int i;
+
+	/* Ignore return code as there is not much we can do about it.
+	 * The error message is printed inside.
+	 */
+	mana_ib_gd_destroy_rc_qp(mdev, qp);
+	for (i = 0; i < MANA_RC_QUEUE_TYPE_MAX; ++i)
+		mana_ib_destroy_queue(mdev, &qp->rc_qp.queues[i]);
+
+	return 0;
+}
+
 int mana_ib_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 {
 	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
@@ -484,7 +574,8 @@ int mana_ib_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 						      udata);
 
 		return mana_ib_destroy_qp_raw(qp, udata);
-
+	case IB_QPT_RC:
+		return mana_ib_destroy_rc_qp(qp, udata);
 	default:
 		ibdev_dbg(ibqp->device, "Unexpected QP type %u\n",
 			  ibqp->qp_type);
diff --git a/include/uapi/rdma/mana-abi.h b/include/uapi/rdma/mana-abi.h
index 2c41cc3..45c2df6 100644
--- a/include/uapi/rdma/mana-abi.h
+++ b/include/uapi/rdma/mana-abi.h
@@ -45,6 +45,15 @@ struct mana_ib_create_qp_resp {
 	__u32 reserved;
 };
 
+struct mana_ib_create_rc_qp {
+	__aligned_u64 queue_buf[4];
+	__u32 queue_size[4];
+};
+
+struct mana_ib_create_rc_qp_resp {
+	__u32 queue_id[4];
+};
+
 struct mana_ib_create_wq {
 	__aligned_u64 wq_buf_addr;
 	__u32 wq_buf_size;
-- 
2.43.0


