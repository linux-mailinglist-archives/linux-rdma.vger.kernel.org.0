Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E33A2C6F2
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 14:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfE1MrY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 08:47:24 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:35974 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfE1MrY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 May 2019 08:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559047643; x=1590583643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fq8UpgC+VbpVRwGArJBIVzExexzktyR9oNt+4NszXhM=;
  b=AL5pC2KIjcNnIfsenmIhCD5YizGGuuQKMmtb3lS3+Qfq4E1YdMWXd5Ud
   nvW30n97/pyqysfCWCQZN2x5SWHZkdgQsG/xPvgUuK1JWwti+1qYj63I5
   VG1LyfIjQ5fuovzq6HWr4XDvz6yfJdQ9S9cAi8IDKlfo9vU2rqCO1wJCY
   M=;
X-IronPort-AV: E=Sophos;i="5.60,523,1549929600"; 
   d="scan'208";a="767937180"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 May 2019 12:47:20 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x4SClFfq019896
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 28 May 2019 12:47:20 GMT
Received: from EX13D19EUB002.ant.amazon.com (10.43.166.78) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 May 2019 12:47:05 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D19EUB002.ant.amazon.com (10.43.166.78) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 May 2019 12:47:04 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.129) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 28 May 2019 12:47:01 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        "Shiraz Saleem" <shiraz.saleem@intel.com>,
        Firas JahJah <firasj@amazon.com>,
        "Yossi Leybovich" <sleybo@amazon.com>
Subject: [PATCH for-rc 5/6] RDMA/efa: Use rdma block iterator in chunk list creation
Date:   Tue, 28 May 2019 15:46:17 +0300
Message-ID: <20190528124618.77918-6-galpress@amazon.com>
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

When creating the chunks list the rdma_for_each_block() iterator is used
in order to iterate over the payload in EFA_CHUNK_PAYLOAD_SIZE (device
defined) strides.

Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index c1246c39f234..6d4c3f2280df 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1097,14 +1097,14 @@ static struct scatterlist *efa_vmalloc_buf_to_sg(u64 *buf, int page_cnt)
  */
 static int pbl_chunk_list_create(struct efa_dev *dev, struct pbl_context *pbl)
 {
-	unsigned int entry, payloads_in_sg, chunk_list_size, chunk_idx, payload_idx;
 	struct pbl_chunk_list *chunk_list = &pbl->phys.indirect.chunk_list;
 	int page_cnt = pbl->phys.indirect.pbl_buf_size_in_pages;
 	struct scatterlist *pages_sgl = pbl->phys.indirect.sgl;
+	unsigned int chunk_list_size, chunk_idx, payload_idx;
 	int sg_dma_cnt = pbl->phys.indirect.sg_dma_cnt;
 	struct efa_com_ctrl_buff_info *ctrl_buf;
 	u64 *cur_chunk_buf, *prev_chunk_buf;
-	struct scatterlist *sg;
+	struct ib_block_iter biter;
 	dma_addr_t dma_addr;
 	int i;
 
@@ -1138,18 +1138,15 @@ static int pbl_chunk_list_create(struct efa_dev *dev, struct pbl_context *pbl)
 	chunk_idx = 0;
 	payload_idx = 0;
 	cur_chunk_buf = chunk_list->chunks[0].buf;
-	for_each_sg(pages_sgl, sg, sg_dma_cnt, entry) {
-		payloads_in_sg = sg_dma_len(sg) >> EFA_CHUNK_PAYLOAD_SHIFT;
-		for (i = 0; i < payloads_in_sg; i++) {
-			cur_chunk_buf[payload_idx++] =
-				(sg_dma_address(sg) & ~(EFA_CHUNK_PAYLOAD_SIZE - 1)) +
-				(EFA_CHUNK_PAYLOAD_SIZE * i);
+	rdma_for_each_block(pages_sgl, &biter, sg_dma_cnt,
+			    EFA_CHUNK_PAYLOAD_SIZE) {
+		cur_chunk_buf[payload_idx++] =
+			rdma_block_iter_dma_address(&biter);
 
-			if (payload_idx == EFA_PTRS_PER_CHUNK) {
-				chunk_idx++;
-				cur_chunk_buf = chunk_list->chunks[chunk_idx].buf;
-				payload_idx = 0;
-			}
+		if (payload_idx == EFA_PTRS_PER_CHUNK) {
+			chunk_idx++;
+			cur_chunk_buf = chunk_list->chunks[chunk_idx].buf;
+			payload_idx = 0;
 		}
 	}
 
-- 
2.21.0

