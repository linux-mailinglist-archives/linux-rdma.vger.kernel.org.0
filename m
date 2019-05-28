Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96A862C6ED
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 14:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfE1Mq6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 08:46:58 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:18895 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfE1Mq5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 May 2019 08:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559047616; x=1590583616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=412TedNaRqYWKr5HFRyPsGHXCQxVOZAtwEWzMmqCGrA=;
  b=QtgnOAVxK+G6DGKTuo1OKft9ILdrJzb48uu9nc6Xgn8bjxx7a4uyQRf6
   8PmN+jvTb0Mxj4pObHY3D+2kDLBLB1VKifiA8Xz+e3r6EvmEjsBgKOIXT
   fr5Is17T3ecyneI6xdva60pKtBGNAEnuuoXsCJdYqK/L3QQbaV4fP9CKf
   o=;
X-IronPort-AV: E=Sophos;i="5.60,523,1549929600"; 
   d="scan'208";a="735042257"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 May 2019 12:46:55 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x4SCkq9A069637
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 28 May 2019 12:46:54 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 May 2019 12:46:54 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 May 2019 12:46:52 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.129) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 28 May 2019 12:46:49 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        "Firas JahJah" <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-rc 2/6] RDMA/efa: Use kvzalloc instead of kzalloc with fallback
Date:   Tue, 28 May 2019 15:46:14 +0300
Message-ID: <20190528124618.77918-3-galpress@amazon.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528124618.77918-1-galpress@amazon.com>
References: <20190528124618.77918-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use kvzalloc which attempts to allocate a physically continuous buffer
and fallbacks to virtually continuous on failure instead of hard coding
it in the driver.

The is_vmalloc_addr function is used to determine whether the buffer is
physically continuous or not (which determines direct vs indirect MR
registration mode).

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 52 +++++++++++++--------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 0fea5d63fdbe..0640c2435f67 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1303,30 +1303,30 @@ static int pbl_create(struct efa_dev *dev,
 	int err;
 
 	pbl->pbl_buf_size_in_bytes = hp_cnt * EFA_CHUNK_PAYLOAD_PTR_SIZE;
-	pbl->pbl_buf = kzalloc(pbl->pbl_buf_size_in_bytes,
-			       GFP_KERNEL | __GFP_NOWARN);
-	if (pbl->pbl_buf) {
+	pbl->pbl_buf = kvzalloc(pbl->pbl_buf_size_in_bytes, GFP_KERNEL);
+	if (!pbl->pbl_buf)
+		return -ENOMEM;
+
+	if (is_vmalloc_addr(pbl->pbl_buf)) {
+		pbl->physically_continuous = 0;
+		err = umem_to_page_list(dev, umem, pbl->pbl_buf, hp_cnt,
+					hp_shift);
+		if (err)
+			goto err_free;
+
+		err = pbl_indirect_initialize(dev, pbl);
+		if (err)
+			goto err_free;
+	} else {
 		pbl->physically_continuous = 1;
 		err = umem_to_page_list(dev, umem, pbl->pbl_buf, hp_cnt,
 					hp_shift);
 		if (err)
-			goto err_continuous;
+			goto err_free;
+
 		err = pbl_continuous_initialize(dev, pbl);
 		if (err)
-			goto err_continuous;
-	} else {
-		pbl->physically_continuous = 0;
-		pbl->pbl_buf = vzalloc(pbl->pbl_buf_size_in_bytes);
-		if (!pbl->pbl_buf)
-			return -ENOMEM;
-
-		err = umem_to_page_list(dev, umem, pbl->pbl_buf, hp_cnt,
-					hp_shift);
-		if (err)
-			goto err_indirect;
-		err = pbl_indirect_initialize(dev, pbl);
-		if (err)
-			goto err_indirect;
+			goto err_free;
 	}
 
 	ibdev_dbg(&dev->ibdev,
@@ -1335,24 +1335,20 @@ static int pbl_create(struct efa_dev *dev,
 
 	return 0;
 
-err_continuous:
-	kfree(pbl->pbl_buf);
-	return err;
-err_indirect:
-	vfree(pbl->pbl_buf);
+err_free:
+	kvfree(pbl->pbl_buf);
 	return err;
 }
 
 static void pbl_destroy(struct efa_dev *dev, struct pbl_context *pbl)
 {
-	if (pbl->physically_continuous) {
+	if (pbl->physically_continuous)
 		dma_unmap_single(&dev->pdev->dev, pbl->phys.continuous.dma_addr,
 				 pbl->pbl_buf_size_in_bytes, DMA_TO_DEVICE);
-		kfree(pbl->pbl_buf);
-	} else {
+	else
 		pbl_indirect_terminate(dev, pbl);
-		vfree(pbl->pbl_buf);
-	}
+
+	kvfree(pbl->pbl_buf);
 }
 
 static int efa_create_inline_pbl(struct efa_dev *dev, struct efa_mr *mr,
-- 
2.21.0

