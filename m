Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E28F2FF9A
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 17:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfE3Pt3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 11:49:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46810 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727105AbfE3Pt3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 May 2019 11:49:29 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 332C3AB39479B85B962E;
        Thu, 30 May 2019 23:49:27 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Thu, 30 May 2019 23:49:17 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V3 for-next 2/3] RDMA/hns: Add a group interfaces for optimizing buffers getting flow
Date:   Thu, 30 May 2019 23:47:55 +0800
Message-ID: <1559231276-67517-3-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559231276-67517-1-git-send-email-oulijun@huawei.com>
References: <1559231276-67517-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently, the code for getting umem and kmem buffers exist many files,
this patch adds a group interfaces to simplify the buffers getting flow.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
V1->V2:
1. Use new APIs instead of for_each_sg.
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c  | 99 +++++++++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_device.h | 12 ++++
 2 files changed, 111 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index dac058d..14fcc35 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -34,6 +34,7 @@
 #include <linux/platform_device.h>
 #include <linux/vmalloc.h>
 #include "hns_roce_device.h"
+#include <rdma/ib_umem.h>
 
 int hns_roce_bitmap_alloc(struct hns_roce_bitmap *bitmap, unsigned long *obj)
 {
@@ -238,6 +239,104 @@ int hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size, u32 max_direct,
 	return -ENOMEM;
 }
 
+int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
+			   int buf_cnt, int start, struct hns_roce_buf *buf)
+{
+	int i, end;
+	int total;
+
+	end = start + buf_cnt;
+	if (end > buf->npages) {
+		dev_err(hr_dev->dev,
+			"invalid kmem region,offset %d,buf_cnt %d,total %d!\n",
+			start, buf_cnt, buf->npages);
+		return -EINVAL;
+	}
+
+	total = 0;
+	for (i = start; i < end; i++)
+		if (buf->nbufs == 1)
+			bufs[total++] = buf->direct.map +
+					(i << buf->page_shift);
+		else
+			bufs[total++] = buf->page_list[i].map;
+
+	return total;
+}
+
+int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
+			   int buf_cnt, int start, struct ib_umem *umem,
+			   int page_shift)
+{
+	struct ib_block_iter biter;
+	int total = 0;
+	int idx = 0;
+	u64 addr;
+
+	if (page_shift < PAGE_SHIFT) {
+		dev_err(hr_dev->dev, "invalid page shift %d!\n", page_shift);
+		return -EINVAL;
+	}
+
+	/* convert system page cnt to hw page cnt */
+	rdma_for_each_block(umem->sg_head.sgl, &biter, umem->nmap,
+			    1 << page_shift) {
+		addr = rdma_block_iter_dma_address(&biter);
+		if (idx >= start) {
+			bufs[total++] = addr;
+			if (total >= buf_cnt)
+				goto done;
+		}
+		idx++;
+	}
+
+done:
+	return total;
+}
+
+void hns_roce_init_buf_region(struct hns_roce_buf_region *region, int hopnum,
+			      int offset, int buf_cnt)
+{
+	if (hopnum == HNS_ROCE_HOP_NUM_0)
+		region->hopnum = 0;
+	else
+		region->hopnum = hopnum;
+
+	region->offset = offset;
+	region->count = buf_cnt;
+}
+
+void hns_roce_free_buf_list(dma_addr_t **bufs, int region_cnt)
+{
+	int i;
+
+	for (i = 0; i < region_cnt; i++) {
+		kfree(bufs[i]);
+		bufs[i] = NULL;
+	}
+}
+
+int hns_roce_alloc_buf_list(struct hns_roce_buf_region *regions,
+			    dma_addr_t **bufs, int region_cnt)
+{
+	struct hns_roce_buf_region *r;
+	int i;
+
+	for (i = 0; i < region_cnt; i++) {
+		r = &regions[i];
+		bufs[i] = kcalloc(r->count, sizeof(dma_addr_t), GFP_KERNEL);
+		if (!bufs[i])
+			goto err_alloc;
+	}
+
+	return 0;
+
+err_alloc:
+	hns_roce_free_buf_list(bufs, i);
+
+	return -ENOMEM;
+}
+
 void hns_roce_cleanup_bitmap(struct hns_roce_dev *hr_dev)
 {
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ)
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 720be44..f946ece 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1211,6 +1211,18 @@ int hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size, u32 max_direct,
 int hns_roce_ib_umem_write_mtt(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_mtt *mtt, struct ib_umem *umem);
 
+void hns_roce_init_buf_region(struct hns_roce_buf_region *region, int hopnum,
+			      int offset, int buf_cnt);
+int hns_roce_alloc_buf_list(struct hns_roce_buf_region *regions,
+			    dma_addr_t **bufs, int count);
+void hns_roce_free_buf_list(dma_addr_t **bufs, int count);
+
+int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
+			   int buf_cnt, int start, struct hns_roce_buf *buf);
+int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
+			   int buf_cnt, int start, struct ib_umem *umem,
+			   int page_shift);
+
 int hns_roce_create_srq(struct ib_srq *srq,
 			struct ib_srq_init_attr *srq_init_attr,
 			struct ib_udata *udata);
-- 
1.9.1

