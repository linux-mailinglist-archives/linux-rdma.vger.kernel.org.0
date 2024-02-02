Return-Path: <linux-rdma+bounces-870-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3413384729B
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 16:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA1D2975EF
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 15:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A05145B1E;
	Fri,  2 Feb 2024 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="J/s/unMB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD0114463E;
	Fri,  2 Feb 2024 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886413; cv=none; b=iYYAY7i1HQMYKuHD5cIZsZDTZmpbOsblObWb/oo2XMDqW8QOdImXMz+cGrSeaRMTIpdhtLYA7Gi/8z1TGS3rT5TSrSiNtm3sY83bi8x3UqRCynyWhtJtE7nVdgz8jADQQQv8sjFYXNA+ZU/SE7wGK5X9YCk4BuloKugUfSrNOQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886413; c=relaxed/simple;
	bh=GI6QY98SEMz0zqOuQidUbYonmgSgitJXQUyspqe4rNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PWVvSadJq5ghWeiQJauKfmQP3AYkMhnaMEDlQpsKztHrcXMNp0jblNE3isR5gYtUKXg6+U6uF2O5R4uvze16zGKIqark1qyzeyQs5TzLGCJsV1TvhpiMmcK0w3jg1eMktse3CUwm5fTsOmDy7df1boIlpct6v+E7PpnyNH0iF6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=J/s/unMB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6C4A720B2002;
	Fri,  2 Feb 2024 07:06:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6C4A720B2002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706886405;
	bh=FQMJvC08Xx+rruS+xJDdv53mAl3GJPxfohVLYNulxEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J/s/unMBx0HErlSr3q27qi3Jy0v2LjutTru7nKUQkJ9T77pL2tqEGDkOMfiGlNRj8
	 gIM2iy/jCEsVFWuNugwTIUrtTc/gFpmjWJkT6kLhawfrSP7Q2tpXr/BTMkrDmXNEAU
	 nozq7QsV7+RUKp87FRko2QuYQA0dBH129DfsThbw=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 2/5] RDMA/mana_ib: Create and destroy rnic adapter
Date: Fri,  2 Feb 2024 07:06:34 -0800
Message-Id: <1706886397-16600-3-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1706886397-16600-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1706886397-16600-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

This patch adds RNIC creation and destruction.
If creation of RNIC fails, we support only RAW QPs as they are served by
ethernet driver.

Signed-off-by: Konstantin Taranov <kotaranov@linux.microsoft.com>
---
 drivers/infiniband/hw/mana/main.c    | 31 +++++++++++++++++++++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index c64d569..33cd69e 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -581,14 +581,31 @@ static void mana_ib_destroy_eqs(struct mana_ib_dev *mdev)
 
 void mana_ib_gd_create_rnic_adapter(struct mana_ib_dev *mdev)
 {
+	struct mana_rnic_create_adapter_resp resp = {};
+	struct mana_rnic_create_adapter_req req = {};
+	struct gdma_context *gc = mdev_to_gc(mdev);
 	int err;
 
+	mdev->adapter_handle = INVALID_MANA_HANDLE;
+
 	err = mana_ib_create_eqs(mdev);
 	if (err) {
 		ibdev_err(&mdev->ib_dev, "Failed to create EQs for RNIC err %d", err);
 		goto cleanup;
 	}
 
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_ADAPTER, sizeof(req), sizeof(resp));
+	req.hdr.req.msg_version = GDMA_MESSAGE_V2;
+	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.notify_eq_id = mdev->fatal_err_eq->id;
+
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	if (err) {
+		ibdev_err(&mdev->ib_dev, "Failed to create RNIC adapter err %d", err);
+		goto cleanup;
+	}
+	mdev->adapter_handle = resp.adapter;
+
 	return;
 
 cleanup:
@@ -599,5 +616,19 @@ void mana_ib_gd_create_rnic_adapter(struct mana_ib_dev *mdev)
 
 void mana_ib_gd_destroy_rnic_adapter(struct mana_ib_dev *mdev)
 {
+	struct mana_rnic_destroy_adapter_resp resp = {};
+	struct mana_rnic_destroy_adapter_req req = {};
+	struct gdma_context *gc;
+
+	if (!rnic_is_enabled(mdev))
+		return;
+
+	gc = mdev_to_gc(mdev);
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_ADAPTER, sizeof(req), sizeof(resp));
+	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.adapter = mdev->adapter_handle;
+
+	mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	mdev->adapter_handle = INVALID_MANA_HANDLE;
 	mana_ib_destroy_eqs(mdev);
 }
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index a4b94ee..96454cf 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -48,6 +48,7 @@ struct mana_ib_adapter_caps {
 struct mana_ib_dev {
 	struct ib_device ib_dev;
 	struct gdma_dev *gdma_dev;
+	mana_handle_t adapter_handle;
 	struct gdma_queue *fatal_err_eq;
 	struct mana_ib_adapter_caps adapter_caps;
 };
@@ -115,6 +116,8 @@ struct mana_ib_rwq_ind_table {
 
 enum mana_ib_command_code {
 	MANA_IB_GET_ADAPTER_CAP = 0x30001,
+	MANA_IB_CREATE_ADAPTER  = 0x30002,
+	MANA_IB_DESTROY_ADAPTER = 0x30003,
 };
 
 struct mana_ib_query_adapter_caps_req {
@@ -143,6 +146,32 @@ struct mana_ib_query_adapter_caps_resp {
 	u32 max_inline_data_size;
 }; /* HW Data */
 
+struct mana_rnic_create_adapter_req {
+	struct gdma_req_hdr hdr;
+	u32 notify_eq_id;
+	u32 reserved;
+	u64 feature_flags;
+}; /*HW Data */
+
+struct mana_rnic_create_adapter_resp {
+	struct gdma_resp_hdr hdr;
+	mana_handle_t adapter;
+}; /* HW Data */
+
+struct mana_rnic_destroy_adapter_req {
+	struct gdma_req_hdr hdr;
+	mana_handle_t adapter;
+}; /*HW Data */
+
+struct mana_rnic_destroy_adapter_resp {
+	struct gdma_resp_hdr hdr;
+}; /* HW Data */
+
+static inline bool rnic_is_enabled(struct mana_ib_dev *mdev)
+{
+	return mdev->adapter_handle != INVALID_MANA_HANDLE;
+}
+
 static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev)
 {
 	return mdev->gdma_dev->gdma_context;
-- 
1.8.3.1


