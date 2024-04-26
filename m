Return-Path: <linux-rdma+bounces-2100-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0AE8B380E
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 15:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B7C281A60
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 13:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65B8147C62;
	Fri, 26 Apr 2024 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="e4Gzd42/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEB5146D52;
	Fri, 26 Apr 2024 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137167; cv=none; b=JIxL8+iiNvK7xBhqB5sQQI47FSb2VKjcNiST57CYspCzjHlvpAQPip5ON3wuQl47BHPFkXvoQE8eHANrnmEa93y+cOecve2ua2gRIi1g4DTmQq9NqTvCd1aengJ3rPBxTOdK2Hr76nB81RbFoqfDFMF/Lh4vFUlAOonWDRqXNns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137167; c=relaxed/simple;
	bh=IgGML0fgJ8FIxgu9wUJmI92FBHaBdGYmeXjsJuCWcd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=axmpQR7xCnGT/ukViB7fQ5PDffczoHJYPmdBKSxHjqaehSTS/AtIZ1xNvqmjZi2VDlA7J1NBMafZWex7PwESNgXSjutjcrVCBf+zRnsTbPSgsviYslzZ5dSDmQXibTocV3lEhm1cJT5Cpa7SIhayj+c4N0teW/rw07atltnihFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=e4Gzd42/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0827B210EF27;
	Fri, 26 Apr 2024 06:12:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0827B210EF27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714137166;
	bh=gE7Ou1irGU+YLTnkid1jAQnRHHkTvBHMHZzISwJetCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e4Gzd42/wsr4nsQ4VCDE/BJDTrKmPveakT64D/+F8p1PV5cKyhfwOnrxw9SakOsif
	 mzubS1w6bn5GIawW5+8mewLASjRBf6vbaoZBL6m6b/aZVxZ6aslJy+1i9HuHRViNCa
	 tVziAoUMkysO3ukzVfJHsLwQF2V5syCqXeoTJqW4=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 2/5] RDMA/mana_ib: create and destroy RNIC cqs
Date: Fri, 26 Apr 2024 06:12:37 -0700
Message-Id: <1714137160-5222-3-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1714137160-5222-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1714137160-5222-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Implement RNIC requests for creation and destruction of RNIC CQs.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c    | 54 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h | 32 +++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 546d059..2a41135 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -834,3 +834,57 @@ int mana_ib_gd_config_mac(struct mana_ib_dev *mdev, enum mana_ib_addr_op op, u8
 
 	return 0;
 }
+
+int mana_ib_gd_create_cq(struct mana_ib_dev *mdev, struct mana_ib_cq *cq, u32 doorbell)
+{
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	struct mana_rnic_create_cq_resp resp = {};
+	struct mana_rnic_create_cq_req req = {};
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_CQ, sizeof(req), sizeof(resp));
+	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.adapter = mdev->adapter_handle;
+	req.gdma_region = cq->queue.gdma_region;
+	req.eq_id = mdev->eqs[cq->comp_vector]->id;
+	req.doorbell_page = doorbell;
+
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+
+	if (err) {
+		ibdev_err(&mdev->ib_dev, "Failed to create cq err %d", err);
+		return err;
+	}
+
+	cq->queue.id  = resp.cq_id;
+	cq->cq_handle = resp.cq_handle;
+	/* The GDMA region is now owned by the CQ handle */
+	cq->queue.gdma_region = GDMA_INVALID_DMA_REGION;
+
+	return 0;
+}
+
+int mana_ib_gd_destroy_cq(struct mana_ib_dev *mdev, struct mana_ib_cq *cq)
+{
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	struct mana_rnic_destroy_cq_resp resp = {};
+	struct mana_rnic_destroy_cq_req req = {};
+	int err;
+
+	if (cq->cq_handle == INVALID_MANA_HANDLE)
+		return 0;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_CQ, sizeof(req), sizeof(resp));
+	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.adapter = mdev->adapter_handle;
+	req.cq_handle = cq->cq_handle;
+
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+
+	if (err) {
+		ibdev_err(&mdev->ib_dev, "Failed to destroy cq err %d", err);
+		return err;
+	}
+
+	return 0;
+}
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index bfcf6df..9162f29 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -92,6 +92,7 @@ struct mana_ib_cq {
 	struct mana_ib_queue queue;
 	int cqe;
 	u32 comp_vector;
+	mana_handle_t  cq_handle;
 };
 
 struct mana_ib_qp {
@@ -119,6 +120,8 @@ enum mana_ib_command_code {
 	MANA_IB_DESTROY_ADAPTER = 0x30003,
 	MANA_IB_CONFIG_IP_ADDR	= 0x30004,
 	MANA_IB_CONFIG_MAC_ADDR	= 0x30005,
+	MANA_IB_CREATE_CQ       = 0x30008,
+	MANA_IB_DESTROY_CQ      = 0x30009,
 };
 
 struct mana_ib_query_adapter_caps_req {
@@ -202,6 +205,31 @@ struct mana_rnic_config_mac_addr_resp {
 	struct gdma_resp_hdr hdr;
 }; /* HW Data */
 
+struct mana_rnic_create_cq_req {
+	struct gdma_req_hdr hdr;
+	mana_handle_t adapter;
+	u64 gdma_region;
+	u32 eq_id;
+	u32 doorbell_page;
+}; /* HW Data */
+
+struct mana_rnic_create_cq_resp {
+	struct gdma_resp_hdr hdr;
+	mana_handle_t cq_handle;
+	u32 cq_id;
+	u32 reserved;
+}; /* HW Data */
+
+struct mana_rnic_destroy_cq_req {
+	struct gdma_req_hdr hdr;
+	mana_handle_t adapter;
+	mana_handle_t cq_handle;
+}; /* HW Data */
+
+struct mana_rnic_destroy_cq_resp {
+	struct gdma_resp_hdr hdr;
+}; /* HW Data */
+
 static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev)
 {
 	return mdev->gdma_dev->gdma_context;
@@ -321,4 +349,8 @@ int mana_ib_gd_add_gid(const struct ib_gid_attr *attr, void **context);
 int mana_ib_gd_del_gid(const struct ib_gid_attr *attr, void **context);
 
 int mana_ib_gd_config_mac(struct mana_ib_dev *mdev, enum mana_ib_addr_op op, u8 *mac);
+
+int mana_ib_gd_create_cq(struct mana_ib_dev *mdev, struct mana_ib_cq *cq, u32 doorbell);
+
+int mana_ib_gd_destroy_cq(struct mana_ib_dev *mdev, struct mana_ib_cq *cq);
 #endif
-- 
2.43.0


