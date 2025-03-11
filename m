Return-Path: <linux-rdma+bounces-8573-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5FCA5BB4F
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 09:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 481D17A4B27
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 08:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C871231A3F;
	Tue, 11 Mar 2025 08:56:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABC322FF32
	for <linux-rdma@vger.kernel.org>; Tue, 11 Mar 2025 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683403; cv=none; b=HTPftzwANU06nc1sxpc4CMytzUp581QHoHInzxoDgmPO1YfhJ36i3Geirh/0XF1N+REaSpEz2rj4wDNfYO5pk0vrDtyvTzx1XG5WDBwoK+vmFrCz3Jw1FOQ3oNI5zEdvMBUy5X7NtNOLg2/Fi3l6T4hhciM1EC/36boat4R3STU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683403; c=relaxed/simple;
	bh=VM2Z+S25vvNuZuGx4q9H/VtDpeoJeNgv7wzFMfCF/UA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZ2Nt5YPYxJVbFhlv6hsHkRfO6pZow6qGuK1+bZoIjHqtdRVggH4i4PVIaQn6sIN7PTQKv5HiXv8dgoJtWlXFJbhEFDrz9Gboo0DExGducqq+CzYLj0FE5dGEyrwvMJQP58Q5znbiKtM3dKHN69QwqjUUdB7FGjmyNBiQcuCP0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZBngL6zQqz1cykD;
	Tue, 11 Mar 2025 16:56:30 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 13FCD1800B3;
	Tue, 11 Mar 2025 16:56:34 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Mar 2025 16:56:33 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 6/7] RDMA/hns: Fix missing xa_destroy()
Date: Tue, 11 Mar 2025 16:48:56 +0800
Message-ID: <20250311084857.3803665-7-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250311084857.3803665-1-huangjunxian6@hisilicon.com>
References: <20250311084857.3803665-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Add xa_destroy() for xarray in driver.

Fixes: 5c1f167af112 ("RDMA/hns: Init SRQ table for hip08")
Fixes: 27e19f451089 ("RDMA/hns: Convert cq_table to XArray")
Fixes: 736b5a70db98 ("RDMA/hns: Convert qp_table_tree to XArray")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c | 4 +++-
 drivers/infiniband/hw/hns/hns_roce_cq.c    | 1 +
 drivers/infiniband/hw/hns/hns_roce_qp.c    | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index 950c133d4220..6ee911f6885b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -175,8 +175,10 @@ void hns_roce_cleanup_bitmap(struct hns_roce_dev *hr_dev)
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC)
 		ida_destroy(&hr_dev->xrcd_ida.ida);
 
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ)
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ) {
 		ida_destroy(&hr_dev->srq_table.srq_ida.ida);
+		xa_destroy(&hr_dev->srq_table.xa);
+	}
 	hns_roce_cleanup_qp_table(hr_dev);
 	hns_roce_cleanup_cq_table(hr_dev);
 	ida_destroy(&hr_dev->mr_table.mtpt_ida.ida);
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 4106423a1b39..3a5c93c9fb3e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -537,5 +537,6 @@ void hns_roce_cleanup_cq_table(struct hns_roce_dev *hr_dev)
 
 	for (i = 0; i < HNS_ROCE_CQ_BANK_NUM; i++)
 		ida_destroy(&hr_dev->cq_table.bank[i].ida);
+	xa_destroy(&hr_dev->cq_table.array);
 	mutex_destroy(&hr_dev->cq_table.bank_mutex);
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 2c1c08f37334..9f376a2232b0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1603,6 +1603,7 @@ void hns_roce_cleanup_qp_table(struct hns_roce_dev *hr_dev)
 	for (i = 0; i < HNS_ROCE_QP_BANK_NUM; i++)
 		ida_destroy(&hr_dev->qp_table.bank[i].ida);
 	xa_destroy(&hr_dev->qp_table.dip_xa);
+	xa_destroy(&hr_dev->qp_table_xa);
 	mutex_destroy(&hr_dev->qp_table.bank_mutex);
 	mutex_destroy(&hr_dev->qp_table.scc_mutex);
 }
-- 
2.33.0


