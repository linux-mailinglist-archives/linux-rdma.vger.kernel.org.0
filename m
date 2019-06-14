Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87CCB46413
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 18:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbfFNQ2o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 12:28:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:52454 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfFNQ2n (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 12:28:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 09:28:43 -0700
X-ExtLoop1: 1
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga007.jf.intel.com with ESMTP; 14 Jun 2019 09:28:43 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5EGSgOH060730;
        Fri, 14 Jun 2019 09:28:42 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5EGSfip044882;
        Fri, 14 Jun 2019 12:28:41 -0400
Subject: [PATCH for-next 7/9] IB/rdmavt: Enhance trace information for FRWR
 debug
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Fri, 14 Jun 2019 12:28:41 -0400
Message-ID: <20190614162841.44714.15589.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190614162724.44714.22604.stgit@awfm-01.aw.intel.com>
References: <20190614162724.44714.22604.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

This patch enhances the MR trace information to enable
more focused debug of MR issues.

Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/sw/rdmavt/mr.c       |    2 +-
 drivers/infiniband/sw/rdmavt/trace_mr.h |   20 +++++++++++++++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
index 54f3f9c..068b23f 100644
--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -611,8 +611,8 @@ static int rvt_set_page(struct ib_mr *ibmr, u64 addr)
 	n = mapped_segs % RVT_SEGSZ;
 	mr->mr.map[m]->segs[n].vaddr = (void *)addr;
 	mr->mr.map[m]->segs[n].length = ps;
-	trace_rvt_mr_page_seg(&mr->mr, m, n, (void *)addr, ps);
 	mr->mr.length += ps;
+	trace_rvt_mr_page_seg(&mr->mr, m, n, (void *)addr, ps);
 
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rdmavt/trace_mr.h b/drivers/infiniband/sw/rdmavt/trace_mr.h
index 976e482..f43e477 100644
--- a/drivers/infiniband/sw/rdmavt/trace_mr.h
+++ b/drivers/infiniband/sw/rdmavt/trace_mr.h
@@ -64,8 +64,12 @@
 		RDI_DEV_ENTRY(ib_to_rvt(mr->pd->device))
 		__field(void *, vaddr)
 		__field(struct page *, page)
+		__field(u64, iova)
+		__field(u64, user_base)
 		__field(size_t, len)
+		__field(size_t, length)
 		__field(u32, lkey)
+		__field(u32, offset)
 		__field(u16, m)
 		__field(u16, n)
 	),
@@ -73,18 +77,28 @@
 		RDI_DEV_ASSIGN(ib_to_rvt(mr->pd->device));
 		__entry->vaddr = v;
 		__entry->page = virt_to_page(v);
+		__entry->iova = mr->iova;
+		__entry->user_base = mr->user_base;
+		__entry->lkey = mr->lkey;
 		__entry->m = m;
 		__entry->n = n;
 		__entry->len = len;
+		__entry->length = mr->length;
+		__entry->offset = mr->offset;
 	),
 	TP_printk(
-		"[%s] vaddr %p page %p m %u n %u len %ld",
+		"[%s] lkey %x iova %llx user_base %llx mr_len %lu vaddr %llx page %p m %u n %u len %lu off %u",
 		__get_str(dev),
-		__entry->vaddr,
+		__entry->lkey,
+		__entry->iova,
+		__entry->user_base,
+		__entry->length,
+		(unsigned long long)__entry->vaddr,
 		__entry->page,
 		__entry->m,
 		__entry->n,
-		__entry->len
+		__entry->len,
+		__entry->offset
 	)
 );
 

