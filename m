Return-Path: <linux-rdma+bounces-2547-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFFD8CAA0B
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2024 10:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193B51F215BD
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2024 08:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C531656475;
	Tue, 21 May 2024 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="L+WJDTSV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4412E54BDB;
	Tue, 21 May 2024 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280468; cv=none; b=jiEsqWBbZ/RQ6ag/f5BMHF3WmP3shv14X0FNpBL1lGQrVjrYLG1cUpPmVn7E16dmfoauYy5ym0R/23u69ZwelZXrIvJnuqVREzccDha5VqpwpbcImxSdTRXfXqbWxo3W/Y2Gww9vShDuIR3QxH3LP2xwWZioZ/aBkLM7QI0Vf3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280468; c=relaxed/simple;
	bh=8xIrcSsMBBV2jgmyiuuCFv9sZ37iqZe+S3q/uAAT0PY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Y5SIx3iFQDnX0YA0/TSUM3hj3GMhCyj1GsfS0vi99EdmQ9SYMcVkbqC2eI1AH7ZZNuMyZcjaXjXGWTsW3NixjDH+eTOhsBuWLVaznc6vl6Qb3NhWbWLvqdfV6I2J77o8tvC2Se/j7nxmTEYcSr+lcB/6DzQS6NH8JzdJ3fFpAeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=L+WJDTSV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 70B9120B9260;
	Tue, 21 May 2024 01:34:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 70B9120B9260
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1716280461;
	bh=GD/8MpyjarpL+XDoIQ4Awd3EAh+LeKHOL9i4FANimok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L+WJDTSV5tVfb0Q96F56v7cgRFOqjxSIY9SvPVo3DVY8bHj50TdBAv4uQzCjdXW2A
	 kKBympEkTOKNTllPaF2pldIe05U7EpGNlX/DT4xTqvutxx78Sl9c8pJ0cfxR7VK1s+
	 uNweDzo+uu3ebMp905BkYOg8FGiEBoqSONXXUA6k=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 2/3] RDMA/mana_ib: Implement uapi to create and destroy RC QP
Date: Tue, 21 May 2024 01:34:12 -0700
Message-Id: <1716280453-24387-3-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1716280453-24387-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1716280453-24387-1-git-send-email-kotaranov@linux.microsoft.com>
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
 drivers/infiniband/hw/mana/qp.c      | 94 +++++++++++++++++++++++++++-
 include/uapi/rdma/mana-abi.h         |  9 +++
 3 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index a3e229c83..5cccbe397 100644
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
index ba13c5abf..e04e5e778 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -398,6 +398,78 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
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
@@ -409,8 +481,9 @@ int mana_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 						     udata);
 
 		return mana_ib_create_qp_raw(ibqp, ibqp->pd, attr, udata);
+	case IB_QPT_RC:
+		return mana_ib_create_rc_qp(ibqp, ibqp->pd, attr, udata);
 	default:
-		/* Creating QP other than IB_QPT_RAW_PACKET is not supported */
 		ibdev_dbg(ibqp->device, "Creating QP type %u not supported\n",
 			  attr->qp_type);
 	}
@@ -473,6 +546,22 @@ static int mana_ib_destroy_qp_raw(struct mana_ib_qp *qp, struct ib_udata *udata)
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
@@ -484,7 +573,8 @@ int mana_ib_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 						      udata);
 
 		return mana_ib_destroy_qp_raw(qp, udata);
-
+	case IB_QPT_RC:
+		return mana_ib_destroy_rc_qp(qp, udata);
 	default:
 		ibdev_dbg(ibqp->device, "Unexpected QP type %u\n",
 			  ibqp->qp_type);
diff --git a/include/uapi/rdma/mana-abi.h b/include/uapi/rdma/mana-abi.h
index 2c41cc315..45c2df619 100644
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


