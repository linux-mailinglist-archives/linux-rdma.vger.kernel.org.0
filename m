Return-Path: <linux-rdma+bounces-7618-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22661A2E829
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 10:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B89164255
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 09:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC4D1C5D6F;
	Mon, 10 Feb 2025 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Tb/FvzT/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0646D1BEF85;
	Mon, 10 Feb 2025 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180916; cv=none; b=VWskafoF6QKow/jFeZRTULaIhOAW/N/VfJlzYSj5wxBBelMn9PFksZ4FBkuj3RR5P/f1jrB+WOOHU/v0zeOISxz6Ad8KuuaslDBfA4SbwmMLHD+y5f1R2K++crOIl09h883Y1DKWdyg0RPpqHFexXcdG4w8OStLVV27NiCoNgXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180916; c=relaxed/simple;
	bh=QXxFLv/j55m3F1CLUx6V7C8gEfaBysmB9SNCjDd4q9E=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kO6Nd5BABAFqo25lUlWmtPPW5//w9SpLIEX8gm8iZV1lOcob5XQylFJjjYnZyK2ujnNFX7/YB7P8j9p+kcAA/TafnQZfcHmQ6unbo6wETFWe5JbmreiVhnJu3JQ4etVUZMD4xL8hoO9iaXAAE01ljEv5x4enBMFoaZns7CvSwP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Tb/FvzT/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5B4BC203F58D;
	Mon, 10 Feb 2025 01:48:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5B4BC203F58D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739180914;
	bh=d4GW/5n0ac9tJd9vAk0woPL3c0JLitEk6/+0bnQUBXY=;
	h=From:To:Cc:Subject:Date:From;
	b=Tb/FvzT/q3RCuflYnkOKs1dv55bUmngbXEEPWtOox6ri/vrzXNWeZbHwtcHrHxRgh
	 af/k29L836NkZ3fC7uC3zXbu4OyRfjKeBqlXozt3IsXUO4SL2f5pGi8RBtrtsPTwxP
	 mZ9S/MKHIudcugBJQODpZfNzqj+PvnNRB3A3hF4Q=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH next 1/1] RDMA/mana_ib: implement reg_user_mr_dmabuf
Date: Mon, 10 Feb 2025 01:48:28 -0800
Message-Id: <1739180908-2833-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Add support of dmabuf MRs to mana_ib.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c  |  1 +
 drivers/infiniband/hw/mana/mana_ib.h |  4 ++
 drivers/infiniband/hw/mana/mr.c      | 77 ++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index cb8941a..34973ca 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -48,6 +48,7 @@ static const struct ib_device_ops mana_ib_dev_ops = {
 	.query_pkey = mana_ib_query_pkey,
 	.query_port = mana_ib_query_port,
 	.reg_user_mr = mana_ib_reg_user_mr,
+	.reg_user_mr_dmabuf = mana_ib_reg_user_mr_dmabuf,
 	.req_notify_cq = mana_ib_arm_cq,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, mana_ib_ah, ibah),
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 9eaf983..bd47b7f 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -699,4 +699,8 @@ int mana_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 
 int mana_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 int mana_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
+
+struct ib_mr *mana_ib_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start, u64 length,
+					 u64 iova, int fd, int mr_access_flags,
+					 struct uverbs_attr_bundle *attrs);
 #endif
diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index ac3041f..7a71607 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -186,6 +186,83 @@ err_free:
 	return ERR_PTR(err);
 }
 
+struct ib_mr *mana_ib_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start, u64 length,
+					 u64 iova, int fd, int access_flags,
+					 struct uverbs_attr_bundle *attrs)
+{
+	struct mana_ib_pd *pd = container_of(ibpd, struct mana_ib_pd, ibpd);
+	struct gdma_create_mr_params mr_params = {};
+	struct ib_device *ibdev = ibpd->device;
+	struct ib_umem_dmabuf *umem_dmabuf;
+	struct mana_ib_dev *dev;
+	struct mana_ib_mr *mr;
+	u64 dma_region_handle;
+	int err;
+
+	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+
+	ibdev_dbg(ibdev,
+		  "dmabuf 0x%llx, iova 0x%llx length 0x%llx access_flags 0x%x",
+		  start, iova, length, access_flags);
+
+	access_flags &= ~IB_ACCESS_OPTIONAL;
+	if (access_flags & ~VALID_MR_FLAGS)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+
+	umem_dmabuf = ib_umem_dmabuf_get_pinned(ibdev, start, length, fd, access_flags);
+	if (IS_ERR(umem_dmabuf)) {
+		err = PTR_ERR(umem_dmabuf);
+		ibdev_dbg(ibdev, "Failed to get dmabuf umem, %d\n", err);
+		goto err_free;
+	}
+
+	mr->umem = &umem_dmabuf->umem;
+
+	err = mana_ib_create_dma_region(dev, mr->umem, &dma_region_handle, iova);
+	if (err) {
+		ibdev_dbg(ibdev, "Failed create dma region for user-mr, %d\n",
+			  err);
+		goto err_umem;
+	}
+
+	ibdev_dbg(ibdev,
+		  "created dma region for user-mr 0x%llx\n",
+		  dma_region_handle);
+
+	mr_params.pd_handle = pd->pd_handle;
+	mr_params.mr_type = GDMA_MR_TYPE_GVA;
+	mr_params.gva.dma_region_handle = dma_region_handle;
+	mr_params.gva.virtual_address = iova;
+	mr_params.gva.access_flags =
+		mana_ib_verbs_to_gdma_access_flags(access_flags);
+
+	err = mana_ib_gd_create_mr(dev, mr, &mr_params);
+	if (err)
+		goto err_dma_region;
+
+	/*
+	 * There is no need to keep track of dma_region_handle after MR is
+	 * successfully created. The dma_region_handle is tracked in the PF
+	 * as part of the lifecycle of this MR.
+	 */
+
+	return &mr->ibmr;
+
+err_dma_region:
+	mana_gd_destroy_dma_region(mdev_to_gc(dev), dma_region_handle);
+
+err_umem:
+	ib_umem_release(mr->umem);
+
+err_free:
+	kfree(mr);
+	return ERR_PTR(err);
+}
+
 struct ib_mr *mana_ib_get_dma_mr(struct ib_pd *ibpd, int access_flags)
 {
 	struct mana_ib_pd *pd = container_of(ibpd, struct mana_ib_pd, ibpd);
-- 
2.43.0


