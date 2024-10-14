Return-Path: <linux-rdma+bounces-5395-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6508199CB5E
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2024 15:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888E41C2317C
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2024 13:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE321AAE38;
	Mon, 14 Oct 2024 13:13:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BFB1A76C4;
	Mon, 14 Oct 2024 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911626; cv=none; b=CDnhq7TVIZ6BfZ+9eaEqqFQnDU2m39lznDbGTKhiIkbLvZugtePg54gTGhyC4C6RO1EB9+I5Ec2A1+sNoxx/yItyslytGJKTXQEDtKQuS+ZcNM79V8t14ecV6z17qwaZmLeRrEX91f8rDCfmtIkiK5+PYlk8AI8VLj7bcPkw2Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911626; c=relaxed/simple;
	bh=+oJalaAbPZRiIIEyTO9KVXvOfjokhAysff5NgUe9vmY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yp+sFM8no8I8WVlY+mtk+MKedojOP9UWGWUdJAj5H7UBFe37hmOjqeWxiR9HF8RGx2+3v9kCUUqqti7w+Fk7wAh9wx1NNpPTtmtWwwDA01q/PsXdG60NJZuNjJxSThUPdByMANg8vQXgzGRaeFY0jFJcFaIcr9KN7P4sEHyz7aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XRyL50J7pzpSsj;
	Mon, 14 Oct 2024 21:11:41 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id C55DA1800DE;
	Mon, 14 Oct 2024 21:13:39 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Oct 2024 21:13:39 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <tangchengchang@huawei.com>,
	<huangjunxian6@hisilicon.com>
Subject: [PATCH for-next] RDMA/hns: Support mmapping reset state to userspace
Date: Mon, 14 Oct 2024 21:07:31 +0800
Message-ID: <20241014130731.1650279-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: Chengchang Tang <tangchengchang@huawei.com>

Mmap reset state to notify userspace about HW reset. The mmaped flag
hw_ready will be initiated to a non-zero value. When HW is reset,
the mmap page will be zapped and userspace will get a zero value of
hw_ready.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  4 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 47 ++++++++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_main.c   | 36 ++++++++++++++++
 include/uapi/rdma/hns-abi.h                 |  6 +++
 4 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 0b1e21cb6d2d..59bca8067a7f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -202,6 +202,7 @@ struct hns_roce_uar {
 enum hns_roce_mmap_type {
 	HNS_ROCE_MMAP_TYPE_DB = 1,
 	HNS_ROCE_MMAP_TYPE_DWQE,
+	HNS_ROCE_MMAP_TYPE_RESET,
 };
 
 struct hns_user_mmap_entry {
@@ -216,6 +217,7 @@ struct hns_roce_ucontext {
 	struct list_head	page_list;
 	struct mutex		page_mutex;
 	struct hns_user_mmap_entry *db_mmap_entry;
+	struct hns_user_mmap_entry *reset_mmap_entry;
 	u32			config;
 };
 
@@ -1020,6 +1022,8 @@ struct hns_roce_dev {
 	int			loop_idc;
 	u32			sdb_offset;
 	u32			odb_offset;
+	struct page		*reset_page; /* store reset state */
+	void			*reset_kaddr; /* addr of reset page */
 	const struct hns_roce_hw *hw;
 	void			*priv;
 	struct workqueue_struct *irq_workq;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f1feaa79f78e..2f72074b7cf9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -37,6 +37,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <linux/vmalloc.h>
 #include <net/addrconf.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
@@ -2865,6 +2866,36 @@ static int free_mr_init(struct hns_roce_dev *hr_dev)
 	return ret;
 }
 
+static int hns_roce_v2_get_reset_page(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_reset_state *state;
+
+	hr_dev->reset_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!hr_dev->reset_page)
+		return -ENOMEM;
+
+	hr_dev->reset_kaddr = vmap(&hr_dev->reset_page, 1, VM_MAP, PAGE_KERNEL);
+	if (!hr_dev->reset_kaddr)
+		goto err_with_vmap;
+
+	state = hr_dev->reset_kaddr;
+	state->hw_ready = 1;
+
+	return 0;
+
+err_with_vmap:
+	put_page(hr_dev->reset_page);
+	return -ENOMEM;
+}
+
+static void hns_roce_v2_put_reset_page(struct hns_roce_dev *hr_dev)
+{
+	vunmap(hr_dev->reset_kaddr);
+	hr_dev->reset_kaddr = NULL;
+	put_page(hr_dev->reset_page);
+	hr_dev->reset_page = NULL;
+}
+
 static int get_hem_table(struct hns_roce_dev *hr_dev)
 {
 	unsigned int qpc_count;
@@ -2944,14 +2975,21 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 {
 	int ret;
 
+	ret = hns_roce_v2_get_reset_page(hr_dev);
+	if (ret) {
+		dev_err(hr_dev->dev,
+			"reset state init failed, ret = %d.\n", ret);
+		return ret;
+	}
+
 	/* The hns ROCEE requires the extdb info to be cleared before using */
 	ret = hns_roce_clear_extdb_list_info(hr_dev);
 	if (ret)
-		return ret;
+		goto err_clear_extdb_failed;
 
 	ret = get_hem_table(hr_dev);
 	if (ret)
-		return ret;
+		goto err_clear_extdb_failed;
 
 	if (hr_dev->is_vf)
 		return 0;
@@ -2967,6 +3005,9 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 err_llm_init_failed:
 	put_hem_table(hr_dev);
 
+err_clear_extdb_failed:
+	hns_roce_v2_put_reset_page(hr_dev);
+
 	return ret;
 }
 
@@ -2980,6 +3021,8 @@ static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
 	if (!hr_dev->is_vf)
 		hns_roce_free_link_table(hr_dev);
 
+	hns_roce_v2_put_reset_page(hr_dev);
+
 	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP09)
 		free_dip_list(hr_dev);
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 49315f39361d..1620d4318480 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -324,6 +324,7 @@ hns_roce_user_mmap_entry_insert(struct ib_ucontext *ucontext, u64 address,
 				ucontext, &entry->rdma_entry, length, 0);
 		break;
 	case HNS_ROCE_MMAP_TYPE_DWQE:
+	case HNS_ROCE_MMAP_TYPE_RESET:
 		ret = rdma_user_mmap_entry_insert_range(
 				ucontext, &entry->rdma_entry, length, 1,
 				U32_MAX);
@@ -341,6 +342,20 @@ hns_roce_user_mmap_entry_insert(struct ib_ucontext *ucontext, u64 address,
 	return entry;
 }
 
+static int hns_roce_alloc_reset_entry(struct ib_ucontext *uctx)
+{
+	struct hns_roce_ucontext *context = to_hr_ucontext(uctx);
+	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
+
+	context->reset_mmap_entry = hns_roce_user_mmap_entry_insert(
+		uctx, (u64)page_to_phys(hr_dev->reset_page), PAGE_SIZE,
+		HNS_ROCE_MMAP_TYPE_RESET);
+	if (!context->reset_mmap_entry)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static void hns_roce_dealloc_uar_entry(struct hns_roce_ucontext *context)
 {
 	if (context->db_mmap_entry)
@@ -369,6 +384,7 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
 	struct hns_roce_ib_alloc_ucontext_resp resp = {};
 	struct hns_roce_ib_alloc_ucontext ucmd = {};
+	struct rdma_user_mmap_entry *rdma_entry;
 	int ret = -EAGAIN;
 
 	if (!hr_dev->active)
@@ -421,6 +437,13 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 
 	resp.cqe_size = hr_dev->caps.cqe_sz;
 
+	ret = hns_roce_alloc_reset_entry(uctx);
+	if (ret)
+		goto error_fail_reset_entry;
+
+	rdma_entry = &context->reset_mmap_entry->rdma_entry;
+	resp.reset_mmap_key = rdma_user_mmap_get_offset(rdma_entry);
+
 	ret = ib_copy_to_udata(udata, &resp,
 			       min(udata->outlen, sizeof(resp)));
 	if (ret)
@@ -429,6 +452,9 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 	return 0;
 
 error_fail_copy_to_udata:
+	rdma_user_mmap_entry_remove(&context->reset_mmap_entry->rdma_entry);
+
+error_fail_reset_entry:
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
 	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB)
 		mutex_destroy(&context->page_mutex);
@@ -448,6 +474,8 @@ static void hns_roce_dealloc_ucontext(struct ib_ucontext *ibcontext)
 	struct hns_roce_ucontext *context = to_hr_ucontext(ibcontext);
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibcontext->device);
 
+	rdma_user_mmap_entry_remove(&context->reset_mmap_entry->rdma_entry);
+
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
 	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB)
 		mutex_destroy(&context->page_mutex);
@@ -485,6 +513,14 @@ static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
 	case HNS_ROCE_MMAP_TYPE_DWQE:
 		prot = pgprot_device(vma->vm_page_prot);
 		break;
+	case HNS_ROCE_MMAP_TYPE_RESET:
+		if (vma->vm_flags & (VM_WRITE | VM_EXEC)) {
+			ret = -EINVAL;
+			goto out;
+		}
+		vm_flags_set(vma, VM_DONTEXPAND);
+		prot = vma->vm_page_prot;
+		break;
 	default:
 		ret = -EINVAL;
 		goto out;
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 94e861870e27..065eb2e0a690 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -136,6 +136,7 @@ struct hns_roce_ib_alloc_ucontext_resp {
 	__u32	max_inline_data;
 	__u8	congest_type;
 	__u8	reserved0[7];
+	__aligned_u64 reset_mmap_key;
 };
 
 struct hns_roce_ib_alloc_ucontext {
@@ -153,4 +154,9 @@ struct hns_roce_ib_create_ah_resp {
 	__u8 tc_mode;
 };
 
+struct hns_roce_reset_state {
+	__u32 hw_ready;
+	__u32 reserved;
+};
+
 #endif /* HNS_ABI_USER_H */
-- 
2.33.0


