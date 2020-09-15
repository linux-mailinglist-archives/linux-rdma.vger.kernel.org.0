Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C3726B78E
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 02:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgIPAZA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Sep 2020 20:25:00 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:23547 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgIOOPy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Sep 2020 10:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600179353; x=1631715353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Gm7RZwkBHyh3mgsEgpi6SzyxKwkVVZvkjO8w25QTRo=;
  b=iKaqo6CMjiXvVW8g7Qkb5dFNMqeLhJpO+luWNj8TJe5I0qqCyK3XA9KT
   2c2ZypZ8d4CHtxdLw9QICmyY43wqeiXpBFlPTNxrdlSUx5SWcavAtnyJq
   5QzPud+d/8yOio3iXBuCJcuTGDYap/ieKKi3zIHPYikWRjaepb0QShV1c
   8=;
X-IronPort-AV: E=Sophos;i="5.76,430,1592870400"; 
   d="scan'208";a="55506165"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 15 Sep 2020 14:14:59 +0000
Received: from EX13D13EUA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS id F3946A077B;
        Tue, 15 Sep 2020 14:14:58 +0000 (UTC)
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D13EUA002.ant.amazon.com (10.43.165.18) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 15 Sep 2020 14:14:57 +0000
Received: from 8c85908914bf.ant.amazon.com.com (10.85.91.6) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 15 Sep 2020 14:14:55 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next 1/2] RDMA/efa: Group keep alive received counter with other SW stats
Date:   Tue, 15 Sep 2020 17:14:48 +0300
Message-ID: <20200915141449.8428-2-galpress@amazon.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915141449.8428-1-galpress@amazon.com>
References: <20200915141449.8428-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The keep alive received counter is a software stat, keep it grouped with
all other software stats.
Since all stored stats are software stats, remove the efa_sw_stats
struct and use efa_stats instead.

Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa.h       |  8 ++-----
 drivers/infiniband/hw/efa/efa_verbs.c | 31 ++++++++++++++-------------
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 64ae8ba6a7f6..e5d9712e98c4 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -33,7 +33,8 @@ struct efa_irq {
 	char name[EFA_IRQNAME_SIZE];
 };
 
-struct efa_sw_stats {
+/* Don't use anything other than atomic64 */
+struct efa_stats {
 	atomic64_t alloc_pd_err;
 	atomic64_t create_qp_err;
 	atomic64_t create_cq_err;
@@ -41,11 +42,6 @@ struct efa_sw_stats {
 	atomic64_t alloc_ucontext_err;
 	atomic64_t create_ah_err;
 	atomic64_t mmap_err;
-};
-
-/* Don't use anything other than atomic64 */
-struct efa_stats {
-	struct efa_sw_stats sw_stats;
 	atomic64_t keep_alive_rcvd;
 };
 
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 52b7ea9fd4ee..c0c4eeed14cd 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -380,7 +380,7 @@ int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 err_dealloc_pd:
 	efa_pd_dealloc(dev, result.pdn);
 err_out:
-	atomic64_inc(&dev->stats.sw_stats.alloc_pd_err);
+	atomic64_inc(&dev->stats.alloc_pd_err);
 	return err;
 }
 
@@ -742,7 +742,7 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
 err_free_qp:
 	kfree(qp);
 err_out:
-	atomic64_inc(&dev->stats.sw_stats.create_qp_err);
+	atomic64_inc(&dev->stats.create_qp_err);
 	return ERR_PTR(err);
 }
 
@@ -1128,7 +1128,7 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 			DMA_FROM_DEVICE);
 
 err_out:
-	atomic64_inc(&dev->stats.sw_stats.create_cq_err);
+	atomic64_inc(&dev->stats.create_cq_err);
 	return err;
 }
 
@@ -1581,7 +1581,7 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 err_free:
 	kfree(mr);
 err_out:
-	atomic64_inc(&dev->stats.sw_stats.reg_mr_err);
+	atomic64_inc(&dev->stats.reg_mr_err);
 	return ERR_PTR(err);
 }
 
@@ -1709,7 +1709,7 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
 err_dealloc_uar:
 	efa_dealloc_uar(dev, result.uarn);
 err_out:
-	atomic64_inc(&dev->stats.sw_stats.alloc_ucontext_err);
+	atomic64_inc(&dev->stats.alloc_ucontext_err);
 	return err;
 }
 
@@ -1742,7 +1742,7 @@ static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
 		ibdev_dbg(&dev->ibdev,
 			  "pgoff[%#lx] does not have valid entry\n",
 			  vma->vm_pgoff);
-		atomic64_inc(&dev->stats.sw_stats.mmap_err);
+		atomic64_inc(&dev->stats.mmap_err);
 		return -EINVAL;
 	}
 	entry = to_emmap(rdma_entry);
@@ -1784,7 +1784,7 @@ static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
 			"Couldn't mmap address[%#llx] length[%#zx] mmap_flag[%d] err[%d]\n",
 			entry->address, rdma_entry->npages * PAGE_SIZE,
 			entry->mmap_flag, err);
-		atomic64_inc(&dev->stats.sw_stats.mmap_err);
+		atomic64_inc(&dev->stats.mmap_err);
 	}
 
 	rdma_user_mmap_entry_put(rdma_entry);
@@ -1869,7 +1869,7 @@ int efa_create_ah(struct ib_ah *ibah,
 err_destroy_ah:
 	efa_ah_destroy(dev, ah);
 err_out:
-	atomic64_inc(&dev->stats.sw_stats.create_ah_err);
+	atomic64_inc(&dev->stats.create_ah_err);
 	return err;
 }
 
@@ -1930,13 +1930,14 @@ int efa_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
 
 	s = &dev->stats;
 	stats->value[EFA_KEEP_ALIVE_RCVD] = atomic64_read(&s->keep_alive_rcvd);
-	stats->value[EFA_ALLOC_PD_ERR] = atomic64_read(&s->sw_stats.alloc_pd_err);
-	stats->value[EFA_CREATE_QP_ERR] = atomic64_read(&s->sw_stats.create_qp_err);
-	stats->value[EFA_CREATE_CQ_ERR] = atomic64_read(&s->sw_stats.create_cq_err);
-	stats->value[EFA_REG_MR_ERR] = atomic64_read(&s->sw_stats.reg_mr_err);
-	stats->value[EFA_ALLOC_UCONTEXT_ERR] = atomic64_read(&s->sw_stats.alloc_ucontext_err);
-	stats->value[EFA_CREATE_AH_ERR] = atomic64_read(&s->sw_stats.create_ah_err);
-	stats->value[EFA_MMAP_ERR] = atomic64_read(&s->sw_stats.mmap_err);
+	stats->value[EFA_ALLOC_PD_ERR] = atomic64_read(&s->alloc_pd_err);
+	stats->value[EFA_CREATE_QP_ERR] = atomic64_read(&s->create_qp_err);
+	stats->value[EFA_CREATE_CQ_ERR] = atomic64_read(&s->create_cq_err);
+	stats->value[EFA_REG_MR_ERR] = atomic64_read(&s->reg_mr_err);
+	stats->value[EFA_ALLOC_UCONTEXT_ERR] =
+		atomic64_read(&s->alloc_ucontext_err);
+	stats->value[EFA_CREATE_AH_ERR] = atomic64_read(&s->create_ah_err);
+	stats->value[EFA_MMAP_ERR] = atomic64_read(&s->mmap_err);
 
 	return ARRAY_SIZE(efa_stats_names);
 }
-- 
2.28.0

