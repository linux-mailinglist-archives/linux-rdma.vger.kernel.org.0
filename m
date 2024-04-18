Return-Path: <linux-rdma+bounces-1980-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3537D8AA065
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Apr 2024 18:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B391C20DF5
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Apr 2024 16:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D011174EF7;
	Thu, 18 Apr 2024 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aQuP8NeG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E815D171E4D;
	Thu, 18 Apr 2024 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459134; cv=none; b=ULQ6nLC1RSlFNU17G+Os6cggLbhesWx+rfcu2RbiGHq3pcv++HftY7tJO7TgMP3SXdRo9wHbGpFpU2Dej7NHKxB/VBTD0cS1zW7fVt0tBFK4sTatmI4tgG9tZn2EBowPAdYAsFw9oOtYWvLHG/iJYNIoUfiHFp5pkVazw+sdDfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459134; c=relaxed/simple;
	bh=P1jKaaFIVDCOd1shZPQNQUq8dSyyRB+AouxP+iSFsSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=p7xM8B9oGQKgzkXU14dApZ11byQwhm0875uvbeaUvL3Yvfw/TrgBnYkYVGKenA/pZOTJh8q8nyhrO1RJ2BeypW36x/0WDFwf8Q5UY1lC71+I4uI2+onE80mvjiwadrIp0p+HL6qgOFinWjNGr23i5bl7poa6Kk8PWAmyfzVZ3x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aQuP8NeG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id A3EAB20FD8F6;
	Thu, 18 Apr 2024 09:52:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A3EAB20FD8F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713459131;
	bh=LYgSVLk66YgQdAnxAyejIaaET5e5BXdpX71D97ms0eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aQuP8NeGhL4bt890gwh6NwiSRFptH/Qr8r5eIRLYUX8T6fPhwjiEV2fB9btUWDDwa
	 Md0JoDc8qSvsjGgZVYXz49HW2uKUu0PWtYhsAkiHgK9TJFNwOthO9rRoMjcQ3aaHEv
	 BRlbZpSA6BkagarwLmOE/bpFeBeFxvz39UQgL2OU=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 6/6] RDMA/mana_ib: implement uapi for creation of rnic cq
Date: Thu, 18 Apr 2024 09:52:05 -0700
Message-Id: <1713459125-14914-7-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Enable users to create RNIC CQs.
With the previous request size, an ethernet CQ is created.
Use the cq_buf_size from the user to create an RNIC CQ and return its ID.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c | 56 ++++++++++++++++++++++++++++++---
 include/uapi/rdma/mana-abi.h    |  7 +++++
 2 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 8323085..a62bda7 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -9,17 +9,25 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct ib_udata *udata)
 {
 	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
+	struct mana_ib_create_cq_resp resp = {};
+	struct mana_ib_ucontext *mana_ucontext;
 	struct ib_device *ibdev = ibcq->device;
 	struct mana_ib_create_cq ucmd = {};
 	struct mana_ib_dev *mdev;
+	bool is_rnic_cq = true;
+	u32 doorbell;
 	int err;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 
-	if (udata->inlen < sizeof(ucmd))
+	cq->comp_vector = attr->comp_vector % ibdev->num_comp_vectors;
+	cq->cq_handle = INVALID_MANA_HANDLE;
+
+	if (udata->inlen < offsetof(struct mana_ib_create_cq, cq_buf_size))
 		return -EINVAL;
 
-	cq->comp_vector = attr->comp_vector % ibdev->num_comp_vectors;
+	if (udata->inlen == offsetof(struct mana_ib_create_cq, cq_buf_size))
+		is_rnic_cq = false;
 
 	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
 	if (err) {
@@ -28,19 +36,53 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		return err;
 	}
 
-	if (attr->cqe > mdev->adapter_caps.max_qp_wr) {
+	if (!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) {
 		ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
 		return -EINVAL;
 	}
 
-	cq->buf_size = attr->cqe * COMP_ENTRY_SIZE;
+	cq->buf_size = is_rnic_cq ? ucmd.cq_buf_size : attr->cqe * COMP_ENTRY_SIZE;
 	err = mana_ib_create_queue(mdev, ucmd.buf_addr, cq->buf_size, &cq->queue);
 	if (err) {
 		ibdev_dbg(ibdev, "Failed to create queue for create cq, %d\n", err);
 		return err;
 	}
 
+	mana_ucontext = rdma_udata_to_drv_context(udata, struct mana_ib_ucontext,
+						  ibucontext);
+	doorbell = mana_ucontext->doorbell;
+
+	if (is_rnic_cq) {
+		err = mana_ib_gd_create_cq(mdev, cq, doorbell);
+		if (err) {
+			ibdev_dbg(ibdev, "Failed to create RNIC cq, %d\n", err);
+			goto err_destroy_queue;
+		}
+
+		err = mana_ib_install_cq_cb(mdev, cq);
+		if (err) {
+			ibdev_dbg(ibdev, "Failed to install cq callback, %d\n", err);
+			goto err_destroy_rnic_cq;
+		}
+	}
+
+	resp.cqid = cq->queue.id;
+	err = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
+	if (err) {
+		ibdev_dbg(&mdev->ib_dev, "Failed to copy to udata, %d\n", err);
+		goto err_remove_cq_cb;
+	}
+
 	return 0;
+
+err_remove_cq_cb:
+	mana_ib_remove_cq_cb(mdev, cq);
+err_destroy_rnic_cq:
+	mana_ib_gd_destroy_cq(mdev, cq);
+err_destroy_queue:
+	mana_ib_destroy_queue(mdev, &cq->queue);
+
+	return err;
 }
 
 int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
@@ -52,6 +94,12 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 
 	mana_ib_remove_cq_cb(mdev, cq);
+
+	/* Ignore return code as there is not much we can do about it.
+	 * The error message is printed inside.
+	 */
+	mana_ib_gd_destroy_cq(mdev, cq);
+
 	mana_ib_destroy_queue(mdev, &cq->queue);
 
 	return 0;
diff --git a/include/uapi/rdma/mana-abi.h b/include/uapi/rdma/mana-abi.h
index 5fcb31b..8fc9d32 100644
--- a/include/uapi/rdma/mana-abi.h
+++ b/include/uapi/rdma/mana-abi.h
@@ -18,6 +18,13 @@
 
 struct mana_ib_create_cq {
 	__aligned_u64 buf_addr;
+	__u32 cq_buf_size;
+	__u32 reserved;
+};
+
+struct mana_ib_create_cq_resp {
+	__u32 cqid;
+	__u32 reserved;
 };
 
 struct mana_ib_create_qp {
-- 
2.43.0


