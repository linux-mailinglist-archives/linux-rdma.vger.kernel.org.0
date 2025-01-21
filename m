Return-Path: <linux-rdma+bounces-7148-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE88A17C49
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 11:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0B63A1C43
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 10:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595F81F0E32;
	Tue, 21 Jan 2025 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="j8iHg7Wc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D486E1A8409;
	Tue, 21 Jan 2025 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737456771; cv=none; b=kf6fOwbZo0sxb3DmPFfHLg6YwYxPtrszZ61c4A6MU0t33wNOEt/cDrLV/Lo9piQGBrt8LsOSfEPDt9WGZniCPMapkPkHTNvmS0uiAM2CmI+r18sT+jxVvvRM17OR+TWM8eT0CrziNYpABq4/CwM6k4Jna4XXlT0+EI7vaJipVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737456771; c=relaxed/simple;
	bh=0R48WJkUpGKSFqPeM7L4K3mJRPAcN5JYm/BLNSGSXIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N6Uya5bTX660jfMwrx0wsX2XeLTqeF1TUaft2Kgg8aGCF4QFSAxO3xRJyZzXSQ5MWUQ/hUc6nogZb/tyBnUmsSzh1HIpD+VERP5mC1Jdo5WEcHgb8+NDFtBfPXlrMia2BYJZvQ8GfZO/ZlaCORPVyvw7FGS+RqscmphrXcLdAWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=j8iHg7Wc; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1737456758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o2UMJAE0rSMu4do0LJ3F7njadk4L3n4HwNwxYUayb9w=;
	b=j8iHg7WcbcSJ/ENqDEUU36RgLKCJvxwYbLOH0SMsRBGcFWkyPXMFNXUqEmDVod+ZBFIQ73
	i1mNfkWtwoENlHw4hqtqh/m0b9MDt9w8VOfRmRtIeY5MDyt3wIWC0wU/zm0zkHFXA/YbrM
	OPmAIPvNHtkFyGRQv3qKkjP/qH7TckM=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lijun Ou <oulijun@huawei.com>,
	"Wei Hu(Xavier)" <huwei87@hisilicon.com>,
	Weihang Li <liweihang@huawei.com>,
	Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 5.10] RDMA/hns: Fix deadlock on SRQ async events.
Date: Tue, 21 Jan 2025 13:52:36 +0300
Message-ID: <20250121105238.15409-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengchang Tang <tangchengchang@huawei.com>

commit b46494b6f9c19f141114a57729e198698f40af37 upstream.  

xa_lock for SRQ table may be required in AEQ. Use xa_store_irq()/
xa_erase_irq() to avoid deadlock.

Fixes: 81fce6291d99 ("RDMA/hns: Add SRQ asynchronous event support")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://lore.kernel.org/r/20240412091616.370789-5-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
[Denis: minor fix to resolve merge conflict.]                                           
Signed-off-by: Denis Arefev <arefev@swemel.ru>                                    
---
Backport fix for CVE-2024-38591 
Link: https://nvd.nist.gov/vuln/detail/cve-2024-38591
---
 drivers/infiniband/hw/hns/hns_roce_main.c | 1 +
 drivers/infiniband/hw/hns/hns_roce_srq.c  | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index f62162771db5..a0f243ffa5b5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -37,6 +37,7 @@
 #include <rdma/ib_smi.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/ib_cache.h>
+#include "hnae3.h"
 #include "hns_roce_common.h"
 #include "hns_roce_device.h"
 #include <rdma/hns-abi.h>
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 02e2416b5fed..6a510dbe5849 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -120,7 +120,7 @@ static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 		goto err_out;
 	}
 
-	ret = xa_err(xa_store(&srq_table->xa, srq->srqn, srq, GFP_KERNEL));
+	ret = xa_err(xa_store_irq(&srq_table->xa, srq->srqn, srq, GFP_KERNEL));
 	if (ret) {
 		ibdev_err(ibdev, "failed to store SRQC, ret = %d.\n", ret);
 		goto err_put;
@@ -149,7 +149,7 @@ static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 	return ret;
 
 err_xa:
-	xa_erase(&srq_table->xa, srq->srqn);
+	xa_erase_irq(&srq_table->xa, srq->srqn);
 
 err_put:
 	hns_roce_table_put(hr_dev, &srq_table->table, srq->srqn);
@@ -169,7 +169,7 @@ static void free_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 		dev_err(hr_dev->dev, "DESTROY_SRQ failed (%d) for SRQN %06lx\n",
 			ret, srq->srqn);
 
-	xa_erase(&srq_table->xa, srq->srqn);
+	xa_erase_irq(&srq_table->xa, srq->srqn);
 
 	if (atomic_dec_and_test(&srq->refcount))
 		complete(&srq->free);
-- 
2.43.0


