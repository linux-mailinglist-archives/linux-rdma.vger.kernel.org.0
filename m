Return-Path: <linux-rdma+bounces-15614-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1EED2E804
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 10:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 982183030D84
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 09:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1622E0B71;
	Fri, 16 Jan 2026 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Htt4EoHS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9999313E20;
	Fri, 16 Jan 2026 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768554292; cv=none; b=XB64z/UaowjUXAee1GdfoKt8541xolRui7Cq9FV487q7mvdQufoP97q3lO900/kHADR9ZDkUmIM4ZKFM9nuDgPZlYR6tJjvmz+D+8v7MLUP7/M8UOIUG5AZcrG92AnuGb+LEEnrLiH31Cdp76dBmH+6sjLphno1LxeLK55b5Okk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768554292; c=relaxed/simple;
	bh=1vpHuHoxFtGs0xJebkIFU4rG9lTjvKsauySDle3lHCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g7YTdV2cUvIDviIwMdTtniWI86dTdWRL4aPXQDKCtvk6Hzm+0tuQ4AOvyF23q3nY1OOvOU30vMbtotPDq6p2DtjDzzBwULcHpsYrVUr2ghbsKSMCZfzmQotFVLiBeu1yFbdzEm0nQcQyk8nLmUOJm55H34s218vkL/faQBrKjaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Htt4EoHS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id 4921E20B7165; Fri, 16 Jan 2026 01:04:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4921E20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768554290;
	bh=KxVrUzhlLPKSGJqOWqVDVs9Yo1GTBBK8b2vimtyELO8=;
	h=From:To:Cc:Subject:Date:From;
	b=Htt4EoHS65HLthomhpgOh5QNAnkfGh+LxNmrn8viNEG0K6CBqvEdSbEor+7IsJMnH
	 NM2I0cDBwxmeBppGXEHjFD/eH3t3Moia6c2hFYVcALb2TowcfrqAUlxnHw4AyiMv0O
	 SZVkeJqvzxD6IfOmOrtmVrMvBbLXuaQE4D8IoxBI=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: device memory support
Date: Fri, 16 Jan 2026 01:04:50 -0800
Message-ID: <20260116090450.250432-1-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Taranov <kotaranov@microsoft.com>

Basic implementation of DM allowing to create and register
DM memory and use its memory keys for networking.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c  |   7 ++
 drivers/infiniband/hw/mana/mana_ib.h |  12 +++
 drivers/infiniband/hw/mana/mr.c      | 138 +++++++++++++++++++++++++++
 include/net/mana/gdma.h              |  47 ++++++++-
 4 files changed, 201 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index bdeddb642..ccc2279ca 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -69,6 +69,12 @@ static const struct ib_device_ops mana_ib_device_stats_ops = {
 	.alloc_hw_device_stats = mana_ib_alloc_hw_device_stats,
 };
 
+const struct ib_device_ops mana_ib_dev_dm_ops = {
+	.alloc_dm = mana_ib_alloc_dm,
+	.dealloc_dm = mana_ib_dealloc_dm,
+	.reg_dm_mr = mana_ib_reg_dm_mr,
+};
+
 static int mana_ib_netdev_event(struct notifier_block *this,
 				unsigned long event, void *ptr)
 {
@@ -139,6 +145,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 		ib_set_device_ops(&dev->ib_dev, &mana_ib_stats_ops);
 		if (dev->adapter_caps.feature_flags & MANA_IB_FEATURE_DEV_COUNTERS_SUPPORT)
 			ib_set_device_ops(&dev->ib_dev, &mana_ib_device_stats_ops);
+		ib_set_device_ops(&dev->ib_dev, &mana_ib_dev_dm_ops);
 
 		ret = mana_ib_create_eqs(dev);
 		if (ret) {
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 9d36232ed..e447acfd2 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -131,6 +131,11 @@ struct mana_ib_mr {
 	mana_handle_t mr_handle;
 };
 
+struct mana_ib_dm {
+	struct ib_dm ibdm;
+	mana_handle_t dm_handle;
+};
+
 struct mana_ib_cq {
 	struct ib_cq ibcq;
 	struct mana_ib_queue queue;
@@ -735,4 +740,11 @@ struct ib_mr *mana_ib_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start, u64 leng
 					 u64 iova, int fd, int mr_access_flags,
 					 struct ib_dmah *dmah,
 					 struct uverbs_attr_bundle *attrs);
+
+struct ib_dm *mana_ib_alloc_dm(struct ib_device *dev, struct ib_ucontext *context,
+			       struct ib_dm_alloc_attr *attr, struct uverbs_attr_bundle *attrs);
+int mana_ib_dealloc_dm(struct ib_dm *dm, struct uverbs_attr_bundle *attrs);
+struct ib_mr *mana_ib_reg_dm_mr(struct ib_pd *pd, struct ib_dm *dm, struct ib_dm_mr_attr *attr,
+				struct uverbs_attr_bundle *attrs);
+
 #endif
diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index 3d0245a4c..a367fa415 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -40,6 +40,7 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev *dev, struct mana_ib_mr *mr,
 
 	mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_MR, sizeof(req),
 			     sizeof(resp));
+	req.hdr.req.msg_version = GDMA_MESSAGE_V2;
 	req.pd_handle = mr_params->pd_handle;
 	req.mr_type = mr_params->mr_type;
 
@@ -55,6 +56,12 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev *dev, struct mana_ib_mr *mr,
 		req.zbva.dma_region_handle = mr_params->zbva.dma_region_handle;
 		req.zbva.access_flags = mr_params->zbva.access_flags;
 		break;
+	case GDMA_MR_TYPE_DM:
+		req.da_ext.length = mr_params->da.length;
+		req.da.dm_handle = mr_params->da.dm_handle;
+		req.da.offset = mr_params->da.offset;
+		req.da.access_flags = mr_params->da.access_flags;
+		break;
 	default:
 		ibdev_dbg(&dev->ib_dev,
 			  "invalid param (GDMA_MR_TYPE) passed, type %d\n",
@@ -317,3 +324,134 @@ int mana_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 
 	return 0;
 }
+
+static int mana_ib_gd_alloc_dm(struct mana_ib_dev *mdev, struct mana_ib_dm *dm,
+			       struct ib_dm_alloc_attr *attr)
+{
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	struct gdma_alloc_dm_resp resp = {};
+	struct gdma_alloc_dm_req req = {};
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, GDMA_ALLOC_DM, sizeof(req), sizeof(resp));
+	req.length = attr->length;
+	req.alignment = attr->alignment;
+	req.flags =  attr->flags;
+
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	if (err || resp.hdr.status) {
+		ibdev_dbg(&mdev->ib_dev, "Failed to alloc dm err %d, %u", err,
+			  resp.hdr.status);
+		if (!err)
+			err = -EPROTO;
+
+		return err;
+	}
+
+	dm->dm_handle = resp.dm_handle;
+
+	return 0;
+}
+
+struct ib_dm *mana_ib_alloc_dm(struct ib_device *ibdev,
+			       struct ib_ucontext *context,
+			       struct ib_dm_alloc_attr *attr,
+			       struct uverbs_attr_bundle *attrs)
+{
+	struct mana_ib_dev *dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+	struct mana_ib_dm *dm;
+	int err;
+
+	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
+	if (!dm)
+		return ERR_PTR(-ENOMEM);
+
+	err = mana_ib_gd_alloc_dm(dev, dm, attr);
+	if (err) {
+		ibdev_dbg(ibdev, "Failed allocate dm memory, %d\n", err);
+		goto err_free;
+	}
+
+	return &dm->ibdm;
+
+err_free:
+	kfree(dm);
+	return ERR_PTR(err);
+}
+
+static int mana_ib_gd_destroy_dm(struct mana_ib_dev *mdev, struct mana_ib_dm *dm)
+{
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	struct gdma_destroy_dm_resp resp = {};
+	struct gdma_destroy_dm_req req = {};
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_DM, sizeof(req), sizeof(resp));
+	req.dm_handle = dm->dm_handle;
+
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	if (err || resp.hdr.status) {
+		ibdev_dbg(&mdev->ib_dev, "Failed to destroy dm err %d, %u", err,
+			  resp.hdr.status);
+		if (!err)
+			err = -EPROTO;
+
+		return err;
+	}
+
+	return 0;
+}
+
+int mana_ib_dealloc_dm(struct ib_dm *ibdm, struct uverbs_attr_bundle *attrs)
+{
+	struct mana_ib_dev *dev = container_of(ibdm->device, struct mana_ib_dev, ib_dev);
+	struct mana_ib_dm *dm = container_of(ibdm, struct mana_ib_dm, ibdm);
+	int err;
+
+	err = mana_ib_gd_destroy_dm(dev, dm);
+	if (err)
+		ibdev_dbg(ibdm->device, "Failed destroy dm memory, %d\n", err);
+	/* Free dm even on HW errors as we do not use the DM anymore.
+	 * Since DM is a purely HW resource, faulty HW cannot harm the kernel.
+	 */
+	kfree(dm);
+	return err;
+}
+
+struct ib_mr *mana_ib_reg_dm_mr(struct ib_pd *ibpd, struct ib_dm *ibdm,
+				struct ib_dm_mr_attr *attr,
+				struct uverbs_attr_bundle *attrs)
+{
+	struct mana_ib_dev *dev = container_of(ibpd->device, struct mana_ib_dev, ib_dev);
+	struct mana_ib_dm *mana_dm = container_of(ibdm, struct mana_ib_dm, ibdm);
+	struct mana_ib_pd *pd = container_of(ibpd, struct mana_ib_pd, ibpd);
+	struct gdma_create_mr_params mr_params = {};
+	struct mana_ib_mr *mr;
+	int err;
+
+	attr->access_flags &= ~IB_ACCESS_OPTIONAL;
+	if (attr->access_flags & ~VALID_MR_FLAGS)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+
+	mr_params.pd_handle = pd->pd_handle;
+	mr_params.mr_type = GDMA_MR_TYPE_DM;
+	mr_params.da.dm_handle = mana_dm->dm_handle;
+	mr_params.da.offset = attr->offset;
+	mr_params.da.length = attr->length;
+	mr_params.da.access_flags =
+		mana_ib_verbs_to_gdma_access_flags(attr->access_flags);
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
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index eaa27483f..8649eb789 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -35,6 +35,8 @@ enum gdma_request_type {
 	GDMA_CREATE_MR			= 31,
 	GDMA_DESTROY_MR			= 32,
 	GDMA_QUERY_HWC_TIMEOUT		= 84, /* 0x54 */
+	GDMA_ALLOC_DM			= 96, /* 0x60 */
+	GDMA_DESTROY_DM			= 97, /* 0x61 */
 };
 
 #define GDMA_RESOURCE_DOORBELL_PAGE	27
@@ -861,6 +863,8 @@ enum gdma_mr_type {
 	GDMA_MR_TYPE_GVA = 2,
 	/* Guest zero-based address MRs */
 	GDMA_MR_TYPE_ZBVA = 4,
+	/* Device address MRs */
+	GDMA_MR_TYPE_DM = 5,
 };
 
 struct gdma_create_mr_params {
@@ -876,6 +880,12 @@ struct gdma_create_mr_params {
 			u64 dma_region_handle;
 			enum gdma_mr_access_flags access_flags;
 		} zbva;
+		struct {
+			u64 dm_handle;
+			u64 offset;
+			u64 length;
+			enum gdma_mr_access_flags access_flags;
+		} da;
 	};
 };
 
@@ -890,13 +900,23 @@ struct gdma_create_mr_request {
 			u64 dma_region_handle;
 			u64 virtual_address;
 			enum gdma_mr_access_flags access_flags;
-		} gva;
+		} __packed gva;
 		struct {
 			u64 dma_region_handle;
 			enum gdma_mr_access_flags access_flags;
-		} zbva;
-	};
+		} __packed zbva;
+		struct {
+			u64 dm_handle;
+			u64 offset;
+			enum gdma_mr_access_flags access_flags;
+		} __packed da;
+	} __packed;
 	u32 reserved_2;
+	union {
+		struct {
+			u64 length;
+		} da_ext;
+	};
 };/* HW DATA */
 
 struct gdma_create_mr_response {
@@ -915,6 +935,27 @@ struct gdma_destroy_mr_response {
 	struct gdma_resp_hdr hdr;
 };/* HW DATA */
 
+struct gdma_alloc_dm_req {
+	struct gdma_req_hdr hdr;
+	u64 length;
+	u32 alignment;
+	u32 flags;
+}; /* HW Data */
+
+struct gdma_alloc_dm_resp {
+	struct gdma_resp_hdr hdr;
+	u64 dm_handle;
+}; /* HW Data */
+
+struct gdma_destroy_dm_req {
+	struct gdma_req_hdr hdr;
+	u64 dm_handle;
+}; /* HW Data */
+
+struct gdma_destroy_dm_resp {
+	struct gdma_resp_hdr hdr;
+}; /* HW Data */
+
 int mana_gd_verify_vf_version(struct pci_dev *pdev);
 
 int mana_gd_register_device(struct gdma_dev *gd);
-- 
2.43.0


