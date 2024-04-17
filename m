Return-Path: <linux-rdma+bounces-1968-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C3C8A85D8
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Apr 2024 16:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E1B4B23DDD
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Apr 2024 14:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC7114198E;
	Wed, 17 Apr 2024 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hYD8FKz5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F72614039D;
	Wed, 17 Apr 2024 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363668; cv=none; b=Rg8LXrt7JlRVeJqm984B3IBMVCkfuabTDRPastEl6LLl4I3wX+NqQnxqq8mUDKdALEttk//ou3wTEbP8Ghol2ASXmQ9IX4/wOb+sxx8psfH+fJ0Qmt0OiaMwxwCxnZMcNDf+bPy/S9Ov79IGEArEK9SsIfTqWsx8qlsrmQw6rfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363668; c=relaxed/simple;
	bh=yOxyY+z0luA2MN0HnxsPSXAtBt77yQT+AbxHCJCneA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YAnJdQaB75LvoAoosd5sJ4xHtHKYLZG8Q4BqrwbUtyqgHt+6OXydis9hqCQ/ZueItoo5v1hUe68+DrkE5YNnxgFo61nTlx7gHBLQ3glnVjkxFbpW2yclkiGdsZxD3QgNbiVkQ13zy2wnXemLKUpIe8ThXNCtHl/+iixMIYPtzKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hYD8FKz5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id C52FB20FD4C4;
	Wed, 17 Apr 2024 07:21:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C52FB20FD4C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713363666;
	bh=hK1BMIWP2TovnG573MEOflwiY7usqGsIMsWM2neQ+/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hYD8FKz5mbsDju2nVlKAokKtf/O8eGtVUfUq+qXui3qNiifyQUHqa7OnqjqduTWPi
	 7P4xQv5bvbKQOQrJsCyI/9Ond/emR9KnKOklzNKl110+BgQckQSNSCrrYqG5SLO/yf
	 iutr6Y1STYb/Ugrb+w9rtowALWgrWnGwLYFilrsA=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 2/2] RDMA/mana_ib: Implement get_dma_mr
Date: Wed, 17 Apr 2024 07:20:59 -0700
Message-Id: <1713363659-30156-3-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1713363659-30156-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1713363659-30156-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Implement allocation of DMA-mapped memory regions.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c |  1 +
 drivers/infiniband/hw/mana/mr.c     | 36 +++++++++++++++++++++++++++++
 include/net/mana/gdma.h             |  5 ++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 6fa902ee80a6..043cef09f1c2 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -29,6 +29,7 @@ static const struct ib_device_ops mana_ib_dev_ops = {
 	.destroy_rwq_ind_table = mana_ib_destroy_rwq_ind_table,
 	.destroy_wq = mana_ib_destroy_wq,
 	.disassociate_ucontext = mana_ib_disassociate_ucontext,
+	.get_dma_mr = mana_ib_get_dma_mr,
 	.get_port_immutable = mana_ib_get_port_immutable,
 	.mmap = mana_ib_mmap,
 	.modify_qp = mana_ib_modify_qp,
diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index 4f13423ecdbd..7c9394926a18 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -8,6 +8,8 @@
 #define VALID_MR_FLAGS                                                         \
 	(IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_READ)
 
+#define VALID_DMA_MR_FLAGS IB_ACCESS_LOCAL_WRITE
+
 static enum gdma_mr_access_flags
 mana_ib_verbs_to_gdma_access_flags(int access_flags)
 {
@@ -39,6 +41,8 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev *dev, struct mana_ib_mr *mr,
 	req.mr_type = mr_params->mr_type;
 
 	switch (mr_params->mr_type) {
+	case GDMA_MR_TYPE_GPA:
+		break;
 	case GDMA_MR_TYPE_GVA:
 		req.gva.dma_region_handle = mr_params->gva.dma_region_handle;
 		req.gva.virtual_address = mr_params->gva.virtual_address;
@@ -168,6 +172,38 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	return ERR_PTR(err);
 }
 
+struct ib_mr *mana_ib_get_dma_mr(struct ib_pd *ibpd, int access_flags)
+{
+	struct mana_ib_pd *pd = container_of(ibpd, struct mana_ib_pd, ibpd);
+	struct gdma_create_mr_params mr_params = {};
+	struct ib_device *ibdev = ibpd->device;
+	struct mana_ib_dev *dev;
+	struct mana_ib_mr *mr;
+	int err;
+
+	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+
+	if (access_flags & ~VALID_DMA_MR_FLAGS)
+		return ERR_PTR(-EINVAL);
+
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+
+	mr_params.pd_handle = pd->pd_handle;
+	mr_params.mr_type = GDMA_MR_TYPE_GPA;
+
+	err = mana_ib_gd_create_mr(dev, mr, &mr_params);
+	if (err)
+		goto err_free;
+
+	return &mr->ibmr;
+
+err_free:
+	kfree(mr);
+	return ERR_PTR(err);
+}
+
 int mana_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct mana_ib_mr *mr = container_of(ibmr, struct mana_ib_mr, ibmr);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 8d796a30ddde..dc19b5cb33a6 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -788,6 +788,11 @@ struct gdma_destory_pd_resp {
 };/* HW DATA */
 
 enum gdma_mr_type {
+	/*
+	 * Guest Physical Address - MRs of this type allow access
+	 * to any DMA-mapped memory using bus-logical address
+	 */
+	GDMA_MR_TYPE_GPA = 1,
 	/* Guest Virtual Address - MRs of this type allow access
 	 * to memory mapped by PTEs associated with this MR using a virtual
 	 * address that is set up in the MST
-- 
2.43.0


