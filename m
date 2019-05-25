Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEC072A3CD
	for <lists+linux-rdma@lfdr.de>; Sat, 25 May 2019 11:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfEYJv3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 May 2019 05:51:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17568 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726651AbfEYJv3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 25 May 2019 05:51:29 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5B31068A3054A48C91E5;
        Sat, 25 May 2019 17:51:27 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Sat, 25 May 2019 17:51:19 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/3] RDMA/hns: add a group interfaces for optimizing buffers getting flow
Date:   Sat, 25 May 2019 17:50:07 +0800
Message-ID: <1558777808-93864-3-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558777808-93864-1-git-send-email-oulijun@huawei.com>
References: <1558777808-93864-1-git-send-email-oulijun@huawei.com>
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
 drivers/infiniband/hw/hns/hns_roce_alloc.c  | 131 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_device.h |  12 +++
 2 files changed, 143 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index dac058d..7a08064 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -34,6 +34,7 @@
 #include <linux/platform_device.h>
 #include <linux/vmalloc.h>
 #include "hns_roce_device.h"
+#include <rdma/ib_umem.h>
 
 int hns_roce_bitmap_alloc(struct hns_roce_bitmap *bitmap, unsigned long *obj)
 {
@@ -238,6 +239,136 @@ int hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size, u32 max_direct,
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
+	struct scatterlist *sg;
+	int npage_per_buf;
+	int npage_per_sg;
+	dma_addr_t addr;
+	int n, entry;
+	int idx, end;
+	int npage;
+	int total;
+
+	if (page_shift < PAGE_SHIFT || page_shift > umem->page_shift) {
+		dev_err(hr_dev->dev, "invalid page shift %d, umem shift %d!\n",
+			page_shift, umem->page_shift);
+		return -EINVAL;
+	}
+
+	/* convert system page cnt to hw page cnt */
+	npage_per_buf = (1 << (page_shift - PAGE_SHIFT));
+	total = DIV_ROUND_UP(ib_umem_page_count(umem), npage_per_buf);
+	end = start + buf_cnt;
+	if (end > total) {
+		dev_err(hr_dev->dev,
+			"invalid umem region,offset %d,buf_cnt %d,total %d!\n",
+			start, buf_cnt, total);
+		return -EINVAL;
+	}
+
+	idx = 0;
+	npage = 0;
+	total = 0;
+	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, entry) {
+		npage_per_sg = sg_dma_len(sg) >> PAGE_SHIFT;
+		for (n = 0; n < npage_per_sg; n++) {
+			if (!(npage % npage_per_buf)) {
+				addr = sg_dma_address(sg) +
+					(n << umem->page_shift);
+				if (addr & ((1 << page_shift) - 1)) {
+					dev_err(hr_dev->dev,
+						"not align to page_shift %d!\n",
+						page_shift);
+					return -ENOBUFS;
+				}
+
+				/* get buf addr between start and end */
+				if (start <= idx && idx < end) {
+					bufs[total++] = addr;
+					if (total >= buf_cnt)
+						goto done;
+				}
+
+				idx++;
+			}
+			npage++;
+		}
+	}
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

