Return-Path: <linux-rdma+bounces-2104-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A048B3817
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 15:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBB3FB23B6E
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BDD14831F;
	Fri, 26 Apr 2024 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fli+4dtA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66271474D8;
	Fri, 26 Apr 2024 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137169; cv=none; b=Jhix8OTJMd8/roBskFNN7tPA/Ki2MwLV2wNA/+XTtRyfOWBNmwPdj6UhU0++jNRGL2Br+bkaa2NipB5dv6Y2q1ZyPGoOCeC1tPIVqtG+wnWEP5w8Ubf3NXY3uB9oXM2kcvN2kHJiG52bJJW8KaKTsZwuh7bBVVoXlFn1CvS1Fuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137169; c=relaxed/simple;
	bh=rr6aW1+kcjEmEqWlckgXGdFCPP642C4Jtl5MwHN1w0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FAGIOfF4H3LpNdjLCT1gEAaoDcQ9CaZOBs3/35HOnkqiW1970XPYmFOcizye+C0ip3wJbObV6UR1ztMUuRNAaKB0kv0oBSPGW8VuKIYwzCMG8+k99VOfS6TLSZsgmZlpiDl8QzhFoIqwKGn+56PVZvNPuoBAVT3lDQh+5bcj4aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fli+4dtA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 52C76210EF2A;
	Fri, 26 Apr 2024 06:12:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 52C76210EF2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714137166;
	bh=Mq+rN7E58bisCALoStLLEzSdNeZidytgD0uOuQCvnM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fli+4dtAQ6pk/mK1bVD3m43hgWdV9DhUCClxNGUdoxHKu6oGYFawF8nbLhxLyLMFW
	 GH1WY8Sh0vl8keZc/eKCpNsfrvXgHeh8wLSaX2TSNZxU3hb1+SWjh/Dp5vTY7zjHFl
	 HruaoEH57IV91QwAwSF5ohjfY52Vs0w25tB0m0cQ=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 5/5] RDMA/mana_ib: implement uapi for creation of rnic cq
Date: Fri, 26 Apr 2024 06:12:40 -0700
Message-Id: <1714137160-5222-6-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1714137160-5222-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1714137160-5222-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Enable users to create RNIC CQs using a corresponding flag.
With the previous request size, an ethernet CQ is created.
As a response, return ID of the created CQ.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c | 55 ++++++++++++++++++++++++++++++---
 include/uapi/rdma/mana-abi.h    | 12 +++++++
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 688ffe6..c6a3fd5 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -9,17 +9,22 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct ib_udata *udata)
 {
 	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
+	struct mana_ib_create_cq_resp resp = {};
+	struct mana_ib_ucontext *mana_ucontext;
 	struct ib_device *ibdev = ibcq->device;
 	struct mana_ib_create_cq ucmd = {};
 	struct mana_ib_dev *mdev;
+	bool is_rnic_cq;
+	u32 doorbell;
 	int err;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 
-	if (udata->inlen < sizeof(ucmd))
-		return -EINVAL;
-
 	cq->comp_vector = attr->comp_vector % ibdev->num_comp_vectors;
+	cq->cq_handle = INVALID_MANA_HANDLE;
+
+	if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
+		return -EINVAL;
 
 	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
 	if (err) {
@@ -28,7 +33,9 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		return err;
 	}
 
-	if (attr->cqe > mdev->adapter_caps.max_qp_wr) {
+	is_rnic_cq = !!(ucmd.flags & MANA_IB_CREATE_RNIC_CQ);
+
+	if (!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) {
 		ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
 		return -EINVAL;
 	}
@@ -40,7 +47,41 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
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
@@ -52,6 +93,12 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
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
index 5fcb31b..2c41cc3 100644
--- a/include/uapi/rdma/mana-abi.h
+++ b/include/uapi/rdma/mana-abi.h
@@ -16,8 +16,20 @@
 
 #define MANA_IB_UVERBS_ABI_VERSION 1
 
+enum mana_ib_create_cq_flags {
+	MANA_IB_CREATE_RNIC_CQ	= 1 << 0,
+};
+
 struct mana_ib_create_cq {
 	__aligned_u64 buf_addr;
+	__u16	flags;
+	__u16	reserved0;
+	__u32	reserved1;
+};
+
+struct mana_ib_create_cq_resp {
+	__u32 cqid;
+	__u32 reserved;
 };
 
 struct mana_ib_create_qp {
-- 
2.43.0


