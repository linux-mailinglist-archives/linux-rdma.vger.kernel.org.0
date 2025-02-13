Return-Path: <linux-rdma+bounces-7725-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 047ECA340DC
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 14:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DAE1188F15F
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 13:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1ED70830;
	Thu, 13 Feb 2025 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BOMK+YWj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40A024BC1E;
	Thu, 13 Feb 2025 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454868; cv=none; b=DNjRmyAWgzYewkxMjPAxbg9DkVXf8IXwu0yWaSz+U10wuYiNdpV33/lBQTPLIJC10heEQekgAk/yxlLr8oq8M7mAkt0Qa/BDHOlde0S9omlZNLjfYiW1RDWfMtjv7dg3AwEMot8Ubdwdw8wTmufYu8XckgARdBhit+NOZvFYqhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454868; c=relaxed/simple;
	bh=zMItyBbGSYmQAzpnqDQb9rWBpA1LWiBaLeVIOo1yVAg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ZwJg8GjT+xeU9TPc7bUElhUf6pTDpdKq6l7fvxzd0jUj2Lj7ClSAanS/RzPR79k7bu8mTotYvbQ6Fs8ZVhFO3nddo7O3Rk3pKWTjjGrxqym75JhWv5ap3qZrFPEHvfrvcGjp2/ah96THmqez+4c71LhG5CVjsQWcpTLUPdWgVKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BOMK+YWj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3E2C3203F3E2;
	Thu, 13 Feb 2025 05:54:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3E2C3203F3E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739454866;
	bh=JFaxEVSYN6WgTX1bl5HT8/R/u9MBfItqs9d9HDLPgJ8=;
	h=From:To:Cc:Subject:Date:From;
	b=BOMK+YWjJX01//ga3wPRLySsh0KaIIguB1ImY8ocatYv9Kjz8rsUmglfYTuz0zaYq
	 pbqDNUvQwE3ckVwlWOru7EiRgmtzh/BfKmAUVnlYPcMemM3iEQItFetmeqeRJwqqfz
	 bP1A6HJi/wxUO3d5FPWe8QCi4FMUos+pfioLJWg8=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 1/1] RDMA/mana_ib: implement reg_user_mr_dmabuf
Date: Thu, 13 Feb 2025 05:54:21 -0800
Message-Id: <1739454861-4456-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Add support of dmabuf MRs to mana_ib.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
---

v2: removed debug prints

 drivers/infiniband/hw/mana/device.c  |  1 +
 drivers/infiniband/hw/mana/mana_ib.h |  4 ++
 drivers/infiniband/hw/mana/mr.c      | 69 ++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 97502bc..9324a5d 100644
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
index cd771af..8332154 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -635,4 +635,8 @@ int mana_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 
 int mana_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 int mana_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
+
+struct ib_mr *mana_ib_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start, u64 length,
+					 u64 iova, int fd, int mr_access_flags,
+					 struct uverbs_attr_bundle *attrs);
 #endif
diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index 3a047f8..f99557e 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -173,6 +173,75 @@ err_free:
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


