Return-Path: <linux-rdma+bounces-4003-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A41B193CEF7
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 09:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D94DEB22DF5
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 07:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2822D17625B;
	Fri, 26 Jul 2024 07:43:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2375D3C30;
	Fri, 26 Jul 2024 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721979784; cv=none; b=ASIygHKRe41SRmjNIijQCdbMG3jSDjJ4/c7M8iujVb0ohff5oc2aKDgxjeKsD3qjQnzkIyGoG3iasKclpr70inbEUSzBddj2w/BqvchdqwXIJxO4DlSM+qPGKiPvwxcdGz+oJhkblYfBP33EEE7BFzZAG3OykG/MVXp4Lsa1Nmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721979784; c=relaxed/simple;
	bh=JQmFk8P1wPUArmo8G9Bh19XTV93zp5zIYy4AuLYz+4M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkJUXM5jYzLZjWpZzVhkVugztan1PZuTGTQuSXHdKPxIFqymbhsY90IENyXfQlfQmIEcmCHDF+CPHK5CCCMlVUVw5aksa91sqsK3DnxaMwFFzUWwtVM58bEDuyRSr/CYdLL3CCY4dbMAj/ueeD3uuE2UYx7IBBX6Cg31OScKa4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WVfKP6rdLz1S6pN;
	Fri, 26 Jul 2024 15:20:09 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A3251400CB;
	Fri, 26 Jul 2024 15:24:37 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 26 Jul 2024 15:24:37 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 2/3] RDMA/hns: Link all uctx to uctx_list on a device
Date: Fri, 26 Jul 2024 15:19:09 +0800
Message-ID: <20240726071910.626802-3-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240726071910.626802-1-huangjunxian6@hisilicon.com>
References: <20240726071910.626802-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: Chengchang Tang <tangchengchang@huawei.com>

Link all uctx to uctx_list on a device.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  4 ++++
 drivers/infiniband/hw/hns/hns_roce_main.c   | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 0b1e21cb6d2d..93768660569d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -217,6 +217,7 @@ struct hns_roce_ucontext {
 	struct mutex		page_mutex;
 	struct hns_user_mmap_entry *db_mmap_entry;
 	u32			config;
+	struct list_head list; /* link all uctx to uctx_list on hr_dev */
 };
 
 struct hns_roce_pd {
@@ -1030,6 +1031,9 @@ struct hns_roce_dev {
 	u64 dwqe_page;
 	struct hns_roce_dev_debugfs dbgfs;
 	atomic64_t *dfx_cnt;
+
+	struct list_head	uctx_list; /* list of all uctx on this dev */
+	struct mutex		uctx_list_mutex; /* protect @uctx_list */
 };
 
 static inline struct hns_roce_dev *to_hr_dev(struct ib_device *ib_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 4cb0af733587..e19871ebc315 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -426,6 +426,10 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 	if (ret)
 		goto error_fail_copy_to_udata;
 
+	mutex_lock(&hr_dev->uctx_list_mutex);
+	list_add(&context->list, &hr_dev->uctx_list);
+	mutex_unlock(&hr_dev->uctx_list_mutex);
+
 	return 0;
 
 error_fail_copy_to_udata:
@@ -448,6 +452,10 @@ static void hns_roce_dealloc_ucontext(struct ib_ucontext *ibcontext)
 	struct hns_roce_ucontext *context = to_hr_ucontext(ibcontext);
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibcontext->device);
 
+	mutex_lock(&hr_dev->uctx_list_mutex);
+	list_del(&context->list);
+	mutex_unlock(&hr_dev->uctx_list_mutex);
+
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
 	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB)
 		mutex_destroy(&context->page_mutex);
@@ -943,6 +951,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 static void hns_roce_teardown_hca(struct hns_roce_dev *hr_dev)
 {
 	hns_roce_cleanup_bitmap(hr_dev);
+	mutex_destroy(&hr_dev->uctx_list_mutex);
 
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
 	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB)
@@ -961,6 +970,9 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 
 	spin_lock_init(&hr_dev->sm_lock);
 
+	INIT_LIST_HEAD(&hr_dev->uctx_list);
+	mutex_init(&hr_dev->uctx_list_mutex);
+
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
 	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB) {
 		INIT_LIST_HEAD(&hr_dev->pgdir_list);
@@ -1000,6 +1012,7 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
 	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB)
 		mutex_destroy(&hr_dev->pgdir_mutex);
+	mutex_destroy(&hr_dev->uctx_list_mutex);
 
 	return ret;
 }
-- 
2.33.0


