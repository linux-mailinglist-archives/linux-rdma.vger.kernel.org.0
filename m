Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E7F3E7BFE
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Aug 2021 17:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242900AbhHJPUv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Aug 2021 11:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbhHJPUp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Aug 2021 11:20:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2927C0613D3
        for <linux-rdma@vger.kernel.org>; Tue, 10 Aug 2021 08:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=9tRyLIS/G/EojZQ0NiU59Qz7uSxMx7oAe+MZwuC18iM=; b=fQ1Q4IMSn7OqAESHc0eqjxjzay
        JuicShNngPtfZdVFjIqM2/ZbbzHE8TDx14i1xIHnByc8WFkkle4qI1mjW4ldxfKmWq9dpKpKc6cd6
        UgD+lkQdBULhpqqw+/SE51BSEC8F/MSqxO9owR28GUprTWpEwm/L1OUS9S1iwqOE2rpi6aT7XyrZ/
        LLlTFoTRvUnJNEeo1nAKyu883IvlIo/TE4nP7MnDEc4ETdsa/owTblsLn/uu/1DvqbZBmMGfpnOqe
        ywIjkoGv941r1oRESc8nzZHse9SPBa6cSXiflH51f86XUJ6Sk9Hytgn9aaja7fVf0C4VVEykMtlsU
        QypmRBoA==;
Received: from 089144200071.atnat0009.highway.a1.net ([89.144.200.71] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDTVA-00CH4Z-Q1; Tue, 10 Aug 2021 15:17:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/hfi1: stop using seq_get_buf in _driver_stats_seq_show
Date:   Tue, 10 Aug 2021 17:17:11 +0200
Message-Id: <20210810151711.1795374-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Just use seq_write to copy the stats into the seq_file buffer instead
of poking holes into the seq_file abstraction.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/infiniband/hw/hfi1/debugfs.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/debugfs.c b/drivers/infiniband/hw/hfi1/debugfs.c
index 2ced236e1553..250079bca68e 100644
--- a/drivers/infiniband/hw/hfi1/debugfs.c
+++ b/drivers/infiniband/hw/hfi1/debugfs.c
@@ -1358,7 +1358,7 @@ static void _driver_stats_seq_stop(struct seq_file *s, void *v)
 {
 }
 
-static u64 hfi1_sps_ints(void)
+static void hfi1_sps_show_ints(struct seq_file *s)
 {
 	unsigned long index, flags;
 	struct hfi1_devdata *dd;
@@ -1369,24 +1369,19 @@ static u64 hfi1_sps_ints(void)
 		sps_ints += get_all_cpu_total(dd->int_counter);
 	}
 	xa_unlock_irqrestore(&hfi1_dev_table, flags);
-	return sps_ints;
+	seq_write(s, &sps_ints, sizeof(u64));
 }
 
 static int _driver_stats_seq_show(struct seq_file *s, void *v)
 {
 	loff_t *spos = v;
-	char *buffer;
 	u64 *stats = (u64 *)&hfi1_stats;
-	size_t sz = seq_get_buf(s, &buffer);
 
-	if (sz < sizeof(u64))
-		return SEQ_SKIP;
 	/* special case for interrupts */
 	if (*spos == 0)
-		*(u64 *)buffer = hfi1_sps_ints();
+		hfi1_sps_show_ints(s);
 	else
-		*(u64 *)buffer = stats[*spos];
-	seq_commit(s,  sizeof(u64));
+		seq_write(s, stats + *spos, sizeof(u64));
 	return 0;
 }
 
-- 
2.30.2

