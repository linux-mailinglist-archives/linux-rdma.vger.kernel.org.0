Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D5A6DB0F4
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Apr 2023 18:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDGQxB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Apr 2023 12:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjDGQw6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Apr 2023 12:52:58 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2131.outbound.protection.outlook.com [40.107.244.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BC86A47
        for <linux-rdma@vger.kernel.org>; Fri,  7 Apr 2023 09:52:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiP7RFMqINfdxfxosD71O7tlsrFSasORDwV+l2sD+viBN5QS6xA0dgDX4+BxBhAZ2OhrysAKczZJ/aytCgCXfn6zrP4IlbKQvaX7C6PgtQE2xYemSXcBbKN9I5QMeA5cIMFdwv222dqoH4Wf/vHlGXsxUxd3X2Te/pvVxHoKWTSC87MkoJQWknHvdLU+lk+WQorNP82CmoJvYaqdO7R0RHwXcQSeOGXWaWp7hZ5z84Rm6T98Q92TYU5KIAcF4JU666QBCd1GmU+pcv1ouCyTYoYT/JZqYNJB3hTuh3q58bj0GYaqCumY/1MkxUphAKW4iNoWe5yrSkIEB7E6kEbQZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTMhFpOmAxlxh5lSOHCkOdq7X/L+adOgRkAAZGOt/nk=;
 b=W3s4+ViDKhxbnHtfWaXvaxAgNzdEJev+nVzjxMSw3A3oi3Pdu4QNwDXRZDZDUYhWExo0+eFncKZWfwNCa5bLhKcf1wQC2WYR9VSNiJUuQLflwITzKdizRSqV1xD+bR5Cqx/2lLKvtRTn21ri71EviUgXwWER2PFXGiAFm5reXap3kRlDcPfMWNwi9C7ks1/RFS9DjJzhKIyvwIaoJfp75AsCluzNTE1y8RuopeL/8axe2RVD3poS17Ht9A2izVwMJ1YpHqH6PRs3ficLm5nL8bWF4Ip/wH7tPP3xWOtvvOSR0CwMb1Osg9kQW7E+V1ikpTI6WzFosHsg3UDXbe/jlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTMhFpOmAxlxh5lSOHCkOdq7X/L+adOgRkAAZGOt/nk=;
 b=OkXpkN8BlshN4rWZAarU6rfIOJEYdZ5EAKQDRx0kfedothgwCFcDO7EVrMKygurnY8B7xVQt3o+XfEOyoKZAa28Ig2085wkF/YEUIJejcvqGetavW3Btzc8Ra3zKwBsa8T3wz80GjAR6Ni7/wGI+jK9EdejSyn90hMBJudSOmekyTj1vPm5uhgV+DnjwxP0Pg18s/hcCu+oRqoQEycvvT2WJ0nkIHSU+oyG67BBx64l/hrPFo1AcrhDdk06d9SzZk6r/qMvwyC2C1Ujejm8nNyonDBntUYe0x181hZiW2LcBQKOxt8UZCQ1qtDZsOLHN2QKt+Dx+L3r4yh34HCpc1A==
Received: from MW2PR2101CA0030.namprd21.prod.outlook.com (2603:10b6:302:1::43)
 by DM5PR0101MB3132.prod.exchangelabs.com (2603:10b6:4:2c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.16; Fri, 7 Apr 2023 16:52:46 +0000
Received: from CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::29) by MW2PR2101CA0030.outlook.office365.com
 (2603:10b6:302:1::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.16 via Frontend
 Transport; Fri, 7 Apr 2023 16:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT097.mail.protection.outlook.com (10.13.175.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.20 via Frontend Transport; Fri, 7 Apr 2023 16:52:45 +0000
Received: from 252.162.96.66.static.eigbox.net (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 337Gqic43027403;
        Fri, 7 Apr 2023 12:52:44 -0400
Subject: [PATCH for-next 4/5] IB/hfi1: Fix bugs with non-PAGE_SIZE-end
 multi-iovec user SDMA requests
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Fri, 07 Apr 2023 12:52:44 -0400
Message-ID: <168088636445.3027109.10054635277810177889.stgit@252.162.96.66.static.eigbox.net>
In-Reply-To: <168088607365.3027109.2194306496858796762.stgit@252.162.96.66.static.eigbox.net>
References: <168088607365.3027109.2194306496858796762.stgit@252.162.96.66.static.eigbox.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT097:EE_|DM5PR0101MB3132:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0a7836-1bfc-4dc3-cd71-08db37888311
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9HTpdINnHYJ75xyxupcXJYz2k7wtDSQ37SjRfnk8jUuZfdzplYUVjp6rwcNlGGTpm7wDcOSxu7JH27paSz+yrtGfgkBno162wenB+r+vQ/hXxwm88Rwu7g0UgN3Wl8piNxTeumPlD0MAnqbtBcUOW9TEQ8IvLIhkT7sjOaxoC5fVUR3vQAUgGbBAFvbl6gbAdEus0ESSFlrAKe1aS7qsjqYM7Nu2vehRkiMvU2axkyRc1XHslt8kEK1h5OXIJrXkvnhNSZDuoAXg7gcc5AyPBp8wiJGVKEyRI8TwyeLpJa6MbSBrpljmgbTk2bDMPew1wpJNfEd3oQst6BbcmC/TnznskUV8xVuiSkXV1vUpA18SlnWtm1wjE4sdIFMPRO2JvNfrD2nqJUH9CSArKIva/A0IXTev9tezUrGdoE43240/XxQbyq7NjC/zPRd+1irg5Zv7y4GGB1c4WNudgQjpprO3NemnBkIwFH/3Lk+eoQnuv03jbb2olC7xf3PK8Cer69AeB0Y7ZuHPqZizfbPVVrgstvZdZtRxw9Yad2JdemTFJFoj7BF9736/HPDC6JJVKf97QXNjeQQvXHe9oAM+iJaHFl+j8dEN56MZkqT6XMwFO84svCB4GatjOBoBwoFw0ILHAA0VuwYbLmDvFGR3q6wDtKDbUJQ2PPyOv24sbwG0wcpRgcqkNgCBRLB9Mm0BMK+hQ2mxeN56upgvLPJnzxWvDwgBHEIzMlWUv+VV3q92o61Jp6Kd7YPzAS6SGntqlVn0IQo0mARQBo1VE+qPQ==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(346002)(376002)(136003)(396003)(451199021)(36840700001)(46966006)(70586007)(9686003)(8676002)(70206006)(86362001)(26005)(4326008)(186003)(54906003)(7696005)(316002)(36860700001)(40480700001)(55016003)(7126003)(103116003)(82310400005)(81166007)(44832011)(8936002)(5660300002)(2906002)(30864003)(426003)(47076005)(478600001)(336012)(356005)(41300700001)(83380400001)(9916002)(24686002)(102196002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 16:52:45.5400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0a7836-1bfc-4dc3-cd71-08db37888311
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0101MB3132
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>

hfi1 user SDMA request processing has two bugs that can cause data
corruption for user SDMA requests that have multiple payload iovecs
where an iovec other than the tail iovec does not run up to the page
boundary for the buffer pointed to by that iovec.a

Here are the specific bugs:
1. user_sdma_txadd() does not use struct user_sdma_iovec->iov.iov_len.
   Rather, user_sdma_txadd() will add up to PAGE_SIZE bytes from iovec
   to the packet, even if some of those bytes are past
   iovec->iov.iov_len and are thus not intended to be in the packet.
2. user_sdma_txadd() and user_sdma_send_pkts() fail to advance to the
   next iovec in user_sdma_request->iovs when the current iovec
   is not PAGE_SIZE and does not contain enough data to complete the
   packet. The transmitted packet will contain the wrong data from the
   iovec pages.

This has not been an issue with SDMA packets from hfi1 Verbs or PSM2
because they only produce iovecs that end short of PAGE_SIZE as the tail
iovec of an SDMA request.

Fixing these bugs exposes other bugs with the SDMA pin cache
(struct mmu_rb_handler) that get in way of supporting user SDMA requests
with multiple payload iovecs whose buffers do not end at PAGE_SIZE. So
this commit fixes those issues as well.

Here are the mmu_rb_handler bugs that non-PAGE_SIZE-end multi-iovec
payload user SDMA requests can hit:
1. Overlapping memory ranges in mmu_rb_handler will result in duplicate
   pinnings.
2. When extending an existing mmu_rb_handler entry (struct mmu_rb_node),
   the mmu_rb code (1) removes the existing entry under a lock, (2)
   releases that lock, pins the new pages, (3) then reacquires the lock
   to insert the extended mmu_rb_node.

   If someone else comes in and inserts an overlapping entry between (2)
   and (3), insert in (3) will fail.

   The failure path code in this case unpins _all_ pages in either the
   original mmu_rb_node or the new mmu_rb_node that was inserted between
   (2) and (3).
3. In hfi1_mmu_rb_remove_unless_exact(), mmu_rb_node->refcount is
   incremented outside of mmu_rb_handler->lock. As a result, mmu_rb_node
   could be evicted by another thread that gets mmu_rb_handler->lock and
   checks mmu_rb_node->refcount before mmu_rb_node->refcount is
   incremented.
4. Related to #2 above, SDMA request submission failure path does not
   check mmu_rb_node->refcount before freeing mmu_rb_node object.

   If there are other SDMA requests in progress whose iovecs have
   pointers to the now-freed mmu_rb_node(s), those pointers to the
   now-freed mmu_rb nodes will be dereferenced when those SDMA requests
   complete.

Fixes: 7be85676f1d1 ("IB/hfi1: Don't remove RB entry when not needed.")
Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Signed-off-by: Brendan Cunningham <bcunningham@cornelisnetworks.com>
Signed-off-by: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/ipoib_tx.c   |    1 
 drivers/infiniband/hw/hfi1/mmu_rb.c     |   66 +--
 drivers/infiniband/hw/hfi1/mmu_rb.h     |    8 
 drivers/infiniband/hw/hfi1/sdma.c       |   21 -
 drivers/infiniband/hw/hfi1/sdma.h       |   16 +
 drivers/infiniband/hw/hfi1/sdma_txreq.h |    1 
 drivers/infiniband/hw/hfi1/trace_mmu.h  |    4 
 drivers/infiniband/hw/hfi1/user_sdma.c  |  600 ++++++++++++++++++++-----------
 drivers/infiniband/hw/hfi1/user_sdma.h  |    5 
 drivers/infiniband/hw/hfi1/verbs.c      |    4 
 drivers/infiniband/hw/hfi1/vnic_sdma.c  |    1 
 11 files changed, 423 insertions(+), 304 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index 349eb4139136..8973a081d641 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -215,6 +215,7 @@ static int hfi1_ipoib_build_ulp_payload(struct ipoib_txreq *tx,
 		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
 		ret = sdma_txadd_page(dd,
+				      NULL,
 				      txreq,
 				      skb_frag_page(frag),
 				      frag->bv_offset,
diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
index af46ff203342..71b9ac018887 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.c
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
@@ -126,7 +126,7 @@ int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
 	spin_lock_irqsave(&handler->lock, flags);
 	node = __mmu_rb_search(handler, mnode->addr, mnode->len);
 	if (node) {
-		ret = -EINVAL;
+		ret = -EEXIST;
 		goto unlock;
 	}
 	__mmu_int_rb_insert(mnode, &handler->root);
@@ -143,6 +143,19 @@ int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
 	return ret;
 }
 
+/* Caller must hold handler lock */
+struct mmu_rb_node *hfi1_mmu_rb_get_first(struct mmu_rb_handler *handler,
+					  unsigned long addr, unsigned long len)
+{
+	struct mmu_rb_node *node;
+
+	trace_hfi1_mmu_rb_search(addr, len);
+	node = __mmu_int_rb_iter_first(&handler->root, addr, (addr + len) - 1);
+	if (node)
+		list_move_tail(&node->list, &handler->lru_list);
+	return node;
+}
+
 /* Caller must hold handler lock */
 static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *handler,
 					   unsigned long addr,
@@ -167,34 +180,6 @@ static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *handler,
 	return node;
 }
 
-bool hfi1_mmu_rb_remove_unless_exact(struct mmu_rb_handler *handler,
-				     unsigned long addr, unsigned long len,
-				     struct mmu_rb_node **rb_node)
-{
-	struct mmu_rb_node *node;
-	unsigned long flags;
-	bool ret = false;
-
-	if (current->mm != handler->mn.mm)
-		return ret;
-
-	spin_lock_irqsave(&handler->lock, flags);
-	node = __mmu_rb_search(handler, addr, len);
-	if (node) {
-		if (node->addr == addr && node->len == len) {
-			list_move_tail(&node->list, &handler->lru_list);
-			goto unlock;
-		}
-		__mmu_int_rb_remove(node, &handler->root);
-		list_del(&node->list); /* remove from LRU list */
-		ret = true;
-	}
-unlock:
-	spin_unlock_irqrestore(&handler->lock, flags);
-	*rb_node = node;
-	return ret;
-}
-
 void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 {
 	struct mmu_rb_node *rbnode, *ptr;
@@ -225,29 +210,6 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 	}
 }
 
-/*
- * It is up to the caller to ensure that this function does not race with the
- * mmu invalidate notifier which may be calling the users remove callback on
- * 'node'.
- */
-void hfi1_mmu_rb_remove(struct mmu_rb_handler *handler,
-			struct mmu_rb_node *node)
-{
-	unsigned long flags;
-
-	if (current->mm != handler->mn.mm)
-		return;
-
-	/* Validity of handler and node pointers has been checked by caller. */
-	trace_hfi1_mmu_rb_remove(node->addr, node->len);
-	spin_lock_irqsave(&handler->lock, flags);
-	__mmu_int_rb_remove(node, &handler->root);
-	list_del(&node->list); /* remove from LRU list */
-	spin_unlock_irqrestore(&handler->lock, flags);
-
-	handler->ops->remove(handler->ops_arg, node);
-}
-
 static int mmu_notifier_range_start(struct mmu_notifier *mn,
 		const struct mmu_notifier_range *range)
 {
diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.h b/drivers/infiniband/hw/hfi1/mmu_rb.h
index 7417be2b9dc8..ed75acdb7b83 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.h
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.h
@@ -52,10 +52,8 @@ void hfi1_mmu_rb_unregister(struct mmu_rb_handler *handler);
 int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
 		       struct mmu_rb_node *mnode);
 void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg);
-void hfi1_mmu_rb_remove(struct mmu_rb_handler *handler,
-			struct mmu_rb_node *mnode);
-bool hfi1_mmu_rb_remove_unless_exact(struct mmu_rb_handler *handler,
-				     unsigned long addr, unsigned long len,
-				     struct mmu_rb_node **rb_node);
+struct mmu_rb_node *hfi1_mmu_rb_get_first(struct mmu_rb_handler *handler,
+					  unsigned long addr,
+					  unsigned long len);
 
 #endif /* _HFI1_MMU_RB_H */
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 8ed20392e9f0..bb2552dd29c1 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -1593,22 +1593,7 @@ static inline void sdma_unmap_desc(
 	struct hfi1_devdata *dd,
 	struct sdma_desc *descp)
 {
-	switch (sdma_mapping_type(descp)) {
-	case SDMA_MAP_SINGLE:
-		dma_unmap_single(
-			&dd->pcidev->dev,
-			sdma_mapping_addr(descp),
-			sdma_mapping_len(descp),
-			DMA_TO_DEVICE);
-		break;
-	case SDMA_MAP_PAGE:
-		dma_unmap_page(
-			&dd->pcidev->dev,
-			sdma_mapping_addr(descp),
-			sdma_mapping_len(descp),
-			DMA_TO_DEVICE);
-		break;
-	}
+	system_descriptor_complete(dd, descp);
 }
 
 /*
@@ -3128,7 +3113,7 @@ int ext_coal_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx,
 
 		/* Add descriptor for coalesce buffer */
 		tx->desc_limit = MAX_DESC;
-		return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, tx,
+		return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, NULL, tx,
 					 addr, tx->tlen);
 	}
 
@@ -3167,10 +3152,12 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 			return rval;
 		}
 	}
+
 	/* finish the one just added */
 	make_tx_sdma_desc(
 		tx,
 		SDMA_MAP_NONE,
+		NULL,
 		dd->sdma_pad_phys,
 		sizeof(u32) - (tx->packet_len & (sizeof(u32) - 1)));
 	tx->num_desc++;
diff --git a/drivers/infiniband/hw/hfi1/sdma.h b/drivers/infiniband/hw/hfi1/sdma.h
index b023fc461bd5..95aaec14c6c2 100644
--- a/drivers/infiniband/hw/hfi1/sdma.h
+++ b/drivers/infiniband/hw/hfi1/sdma.h
@@ -594,6 +594,7 @@ static inline dma_addr_t sdma_mapping_addr(struct sdma_desc *d)
 static inline void make_tx_sdma_desc(
 	struct sdma_txreq *tx,
 	int type,
+	void *pinning_ctx,
 	dma_addr_t addr,
 	size_t len)
 {
@@ -612,6 +613,7 @@ static inline void make_tx_sdma_desc(
 				<< SDMA_DESC0_PHY_ADDR_SHIFT) |
 			(((u64)len & SDMA_DESC0_BYTE_COUNT_MASK)
 				<< SDMA_DESC0_BYTE_COUNT_SHIFT);
+	desc->pinning_ctx = pinning_ctx;
 }
 
 /* helper to extend txreq */
@@ -643,6 +645,7 @@ static inline void _sdma_close_tx(struct hfi1_devdata *dd,
 static inline int _sdma_txadd_daddr(
 	struct hfi1_devdata *dd,
 	int type,
+	void *pinning_ctx,
 	struct sdma_txreq *tx,
 	dma_addr_t addr,
 	u16 len)
@@ -652,6 +655,7 @@ static inline int _sdma_txadd_daddr(
 	make_tx_sdma_desc(
 		tx,
 		type,
+		pinning_ctx,
 		addr, len);
 	WARN_ON(len > tx->tlen);
 	tx->num_desc++;
@@ -672,6 +676,7 @@ static inline int _sdma_txadd_daddr(
 /**
  * sdma_txadd_page() - add a page to the sdma_txreq
  * @dd: the device to use for mapping
+ * @pinning_ctx: context to be released at descriptor retirement
  * @tx: tx request to which the page is added
  * @page: page to map
  * @offset: offset within the page
@@ -687,6 +692,7 @@ static inline int _sdma_txadd_daddr(
  */
 static inline int sdma_txadd_page(
 	struct hfi1_devdata *dd,
+	void *pinning_ctx,
 	struct sdma_txreq *tx,
 	struct page *page,
 	unsigned long offset,
@@ -714,8 +720,7 @@ static inline int sdma_txadd_page(
 		return -ENOSPC;
 	}
 
-	return _sdma_txadd_daddr(
-			dd, SDMA_MAP_PAGE, tx, addr, len);
+	return _sdma_txadd_daddr(dd, SDMA_MAP_PAGE, pinning_ctx, tx, addr, len);
 }
 
 /**
@@ -749,7 +754,8 @@ static inline int sdma_txadd_daddr(
 			return rval;
 	}
 
-	return _sdma_txadd_daddr(dd, SDMA_MAP_NONE, tx, addr, len);
+	return _sdma_txadd_daddr(dd, SDMA_MAP_NONE, NULL, tx,
+				 addr, len);
 }
 
 /**
@@ -795,8 +801,7 @@ static inline int sdma_txadd_kvaddr(
 		return -ENOSPC;
 	}
 
-	return _sdma_txadd_daddr(
-			dd, SDMA_MAP_SINGLE, tx, addr, len);
+	return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, NULL, tx, addr, len);
 }
 
 struct iowait_work;
@@ -1030,4 +1035,5 @@ extern uint mod_num_sdma;
 
 void sdma_update_lmc(struct hfi1_devdata *dd, u64 mask, u32 lid);
 
+void system_descriptor_complete(struct hfi1_devdata *dd, struct sdma_desc *descp);
 #endif
diff --git a/drivers/infiniband/hw/hfi1/sdma_txreq.h b/drivers/infiniband/hw/hfi1/sdma_txreq.h
index e262fb5c5ec6..fad946cb5e0d 100644
--- a/drivers/infiniband/hw/hfi1/sdma_txreq.h
+++ b/drivers/infiniband/hw/hfi1/sdma_txreq.h
@@ -19,6 +19,7 @@
 struct sdma_desc {
 	/* private:  don't use directly */
 	u64 qw[2];
+	void *pinning_ctx;
 };
 
 /**
diff --git a/drivers/infiniband/hw/hfi1/trace_mmu.h b/drivers/infiniband/hw/hfi1/trace_mmu.h
index 187e9244fe5e..57900ebb7702 100644
--- a/drivers/infiniband/hw/hfi1/trace_mmu.h
+++ b/drivers/infiniband/hw/hfi1/trace_mmu.h
@@ -37,10 +37,6 @@ DEFINE_EVENT(hfi1_mmu_rb_template, hfi1_mmu_rb_search,
 	     TP_PROTO(unsigned long addr, unsigned long len),
 	     TP_ARGS(addr, len));
 
-DEFINE_EVENT(hfi1_mmu_rb_template, hfi1_mmu_rb_remove,
-	     TP_PROTO(unsigned long addr, unsigned long len),
-	     TP_ARGS(addr, len));
-
 DEFINE_EVENT(hfi1_mmu_rb_template, hfi1_mmu_mem_invalidate,
 	     TP_PROTO(unsigned long addr, unsigned long len),
 	     TP_ARGS(addr, len));
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index a71c5a36ceba..ae58b48afe07 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -24,7 +24,6 @@
 
 #include "hfi.h"
 #include "sdma.h"
-#include "mmu_rb.h"
 #include "user_sdma.h"
 #include "verbs.h"  /* for the headers */
 #include "common.h" /* for struct hfi1_tid_info */
@@ -39,11 +38,7 @@ static unsigned initial_pkt_count = 8;
 static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts);
 static void user_sdma_txreq_cb(struct sdma_txreq *txreq, int status);
 static inline void pq_update(struct hfi1_user_sdma_pkt_q *pq);
-static void user_sdma_free_request(struct user_sdma_request *req, bool unpin);
-static int pin_vector_pages(struct user_sdma_request *req,
-			    struct user_sdma_iovec *iovec);
-static void unpin_vector_pages(struct mm_struct *mm, struct page **pages,
-			       unsigned start, unsigned npages);
+static void user_sdma_free_request(struct user_sdma_request *req);
 static int check_header_template(struct user_sdma_request *req,
 				 struct hfi1_pkt_header *hdr, u32 lrhlen,
 				 u32 datalen);
@@ -81,6 +76,11 @@ static struct mmu_rb_ops sdma_rb_ops = {
 	.invalidate = sdma_rb_invalidate
 };
 
+static int add_system_pages_to_sdma_packet(struct user_sdma_request *req,
+					   struct user_sdma_txreq *tx,
+					   struct user_sdma_iovec *iovec,
+					   u32 *pkt_remaining);
+
 static int defer_packet_queue(
 	struct sdma_engine *sde,
 	struct iowait_work *wait,
@@ -410,6 +410,7 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 		ret = -EINVAL;
 		goto free_req;
 	}
+
 	/* Copy the header from the user buffer */
 	ret = copy_from_user(&req->hdr, iovec[idx].iov_base + sizeof(info),
 			     sizeof(req->hdr));
@@ -484,9 +485,8 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 		memcpy(&req->iovs[i].iov,
 		       iovec + idx++,
 		       sizeof(req->iovs[i].iov));
-		ret = pin_vector_pages(req, &req->iovs[i]);
-		if (ret) {
-			req->data_iovs = i;
+		if (req->iovs[i].iov.iov_len == 0) {
+			ret = -EINVAL;
 			goto free_req;
 		}
 		req->data_len += req->iovs[i].iov.iov_len;
@@ -584,7 +584,7 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 		if (req->seqsubmitted)
 			wait_event(pq->busy.wait_dma,
 				   (req->seqcomp == req->seqsubmitted - 1));
-		user_sdma_free_request(req, true);
+		user_sdma_free_request(req);
 		pq_update(pq);
 		set_comp_state(pq, cq, info.comp_idx, ERROR, ret);
 	}
@@ -696,48 +696,6 @@ static int user_sdma_txadd_ahg(struct user_sdma_request *req,
 	return ret;
 }
 
-static int user_sdma_txadd(struct user_sdma_request *req,
-			   struct user_sdma_txreq *tx,
-			   struct user_sdma_iovec *iovec, u32 datalen,
-			   u32 *queued_ptr, u32 *data_sent_ptr,
-			   u64 *iov_offset_ptr)
-{
-	int ret;
-	unsigned int pageidx, len;
-	unsigned long base, offset;
-	u64 iov_offset = *iov_offset_ptr;
-	u32 queued = *queued_ptr, data_sent = *data_sent_ptr;
-	struct hfi1_user_sdma_pkt_q *pq = req->pq;
-
-	base = (unsigned long)iovec->iov.iov_base;
-	offset = offset_in_page(base + iovec->offset + iov_offset);
-	pageidx = (((iovec->offset + iov_offset + base) - (base & PAGE_MASK)) >>
-		   PAGE_SHIFT);
-	len = offset + req->info.fragsize > PAGE_SIZE ?
-		PAGE_SIZE - offset : req->info.fragsize;
-	len = min((datalen - queued), len);
-	ret = sdma_txadd_page(pq->dd, &tx->txreq, iovec->pages[pageidx],
-			      offset, len);
-	if (ret) {
-		SDMA_DBG(req, "SDMA txreq add page failed %d\n", ret);
-		return ret;
-	}
-	iov_offset += len;
-	queued += len;
-	data_sent += len;
-	if (unlikely(queued < datalen && pageidx == iovec->npages &&
-		     req->iov_idx < req->data_iovs - 1)) {
-		iovec->offset += iov_offset;
-		iovec = &req->iovs[++req->iov_idx];
-		iov_offset = 0;
-	}
-
-	*queued_ptr = queued;
-	*data_sent_ptr = data_sent;
-	*iov_offset_ptr = iov_offset;
-	return ret;
-}
-
 static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts)
 {
 	int ret = 0;
@@ -769,8 +727,7 @@ static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts)
 		maxpkts = req->info.npkts - req->seqnum;
 
 	while (npkts < maxpkts) {
-		u32 datalen = 0, queued = 0, data_sent = 0;
-		u64 iov_offset = 0;
+		u32 datalen = 0;
 
 		/*
 		 * Check whether any of the completions have come back
@@ -863,27 +820,17 @@ static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts)
 				goto free_txreq;
 		}
 
-		/*
-		 * If the request contains any data vectors, add up to
-		 * fragsize bytes to the descriptor.
-		 */
-		while (queued < datalen &&
-		       (req->sent + data_sent) < req->data_len) {
-			ret = user_sdma_txadd(req, tx, iovec, datalen,
-					      &queued, &data_sent, &iov_offset);
-			if (ret)
-				goto free_txreq;
-		}
-		/*
-		 * The txreq was submitted successfully so we can update
-		 * the counters.
-		 */
 		req->koffset += datalen;
 		if (req_opcode(req->info.ctrl) == EXPECTED)
 			req->tidoffset += datalen;
-		req->sent += data_sent;
-		if (req->data_len)
-			iovec->offset += iov_offset;
+		req->sent += datalen;
+		while (datalen) {
+			ret = add_system_pages_to_sdma_packet(req, tx, iovec,
+							      &datalen);
+			if (ret)
+				goto free_txreq;
+			iovec = &req->iovs[req->iov_idx];
+		}
 		list_add_tail(&tx->txreq.list, &req->txps);
 		/*
 		 * It is important to increment this here as it is used to
@@ -920,133 +867,14 @@ static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts)
 static u32 sdma_cache_evict(struct hfi1_user_sdma_pkt_q *pq, u32 npages)
 {
 	struct evict_data evict_data;
+	struct mmu_rb_handler *handler = pq->handler;
 
 	evict_data.cleared = 0;
 	evict_data.target = npages;
-	hfi1_mmu_rb_evict(pq->handler, &evict_data);
+	hfi1_mmu_rb_evict(handler, &evict_data);
 	return evict_data.cleared;
 }
 
-static int pin_sdma_pages(struct user_sdma_request *req,
-			  struct user_sdma_iovec *iovec,
-			  struct sdma_mmu_node *node,
-			  int npages)
-{
-	int pinned, cleared;
-	struct page **pages;
-	struct hfi1_user_sdma_pkt_q *pq = req->pq;
-
-	pages = kcalloc(npages, sizeof(*pages), GFP_KERNEL);
-	if (!pages)
-		return -ENOMEM;
-	memcpy(pages, node->pages, node->npages * sizeof(*pages));
-
-	npages -= node->npages;
-retry:
-	if (!hfi1_can_pin_pages(pq->dd, current->mm,
-				atomic_read(&pq->n_locked), npages)) {
-		cleared = sdma_cache_evict(pq, npages);
-		if (cleared >= npages)
-			goto retry;
-	}
-	pinned = hfi1_acquire_user_pages(current->mm,
-					 ((unsigned long)iovec->iov.iov_base +
-					 (node->npages * PAGE_SIZE)), npages, 0,
-					 pages + node->npages);
-	if (pinned < 0) {
-		kfree(pages);
-		return pinned;
-	}
-	if (pinned != npages) {
-		unpin_vector_pages(current->mm, pages, node->npages, pinned);
-		return -EFAULT;
-	}
-	kfree(node->pages);
-	node->rb.len = iovec->iov.iov_len;
-	node->pages = pages;
-	atomic_add(pinned, &pq->n_locked);
-	return pinned;
-}
-
-static void unpin_sdma_pages(struct sdma_mmu_node *node)
-{
-	if (node->npages) {
-		unpin_vector_pages(mm_from_sdma_node(node), node->pages, 0,
-				   node->npages);
-		atomic_sub(node->npages, &node->pq->n_locked);
-	}
-}
-
-static int pin_vector_pages(struct user_sdma_request *req,
-			    struct user_sdma_iovec *iovec)
-{
-	int ret = 0, pinned, npages;
-	struct hfi1_user_sdma_pkt_q *pq = req->pq;
-	struct sdma_mmu_node *node = NULL;
-	struct mmu_rb_node *rb_node;
-	struct iovec *iov;
-	bool extracted;
-
-	extracted =
-		hfi1_mmu_rb_remove_unless_exact(pq->handler,
-						(unsigned long)
-						iovec->iov.iov_base,
-						iovec->iov.iov_len, &rb_node);
-	if (rb_node) {
-		node = container_of(rb_node, struct sdma_mmu_node, rb);
-		if (!extracted) {
-			atomic_inc(&node->refcount);
-			iovec->pages = node->pages;
-			iovec->npages = node->npages;
-			iovec->node = node;
-			return 0;
-		}
-	}
-
-	if (!node) {
-		node = kzalloc(sizeof(*node), GFP_KERNEL);
-		if (!node)
-			return -ENOMEM;
-
-		node->rb.addr = (unsigned long)iovec->iov.iov_base;
-		node->pq = pq;
-		atomic_set(&node->refcount, 0);
-	}
-
-	iov = &iovec->iov;
-	npages = num_user_pages((unsigned long)iov->iov_base, iov->iov_len);
-	if (node->npages < npages) {
-		pinned = pin_sdma_pages(req, iovec, node, npages);
-		if (pinned < 0) {
-			ret = pinned;
-			goto bail;
-		}
-		node->npages += pinned;
-		npages = node->npages;
-	}
-	iovec->pages = node->pages;
-	iovec->npages = npages;
-	iovec->node = node;
-
-	ret = hfi1_mmu_rb_insert(req->pq->handler, &node->rb);
-	if (ret) {
-		iovec->node = NULL;
-		goto bail;
-	}
-	return 0;
-bail:
-	unpin_sdma_pages(node);
-	kfree(node);
-	return ret;
-}
-
-static void unpin_vector_pages(struct mm_struct *mm, struct page **pages,
-			       unsigned start, unsigned npages)
-{
-	hfi1_release_user_pages(mm, pages + start, npages, false);
-	kfree(pages);
-}
-
 static int check_header_template(struct user_sdma_request *req,
 				 struct hfi1_pkt_header *hdr, u32 lrhlen,
 				 u32 datalen)
@@ -1388,7 +1216,7 @@ static void user_sdma_txreq_cb(struct sdma_txreq *txreq, int status)
 	if (req->seqcomp != req->info.npkts - 1)
 		return;
 
-	user_sdma_free_request(req, false);
+	user_sdma_free_request(req);
 	set_comp_state(pq, cq, req->info.comp_idx, state, status);
 	pq_update(pq);
 }
@@ -1399,10 +1227,8 @@ static inline void pq_update(struct hfi1_user_sdma_pkt_q *pq)
 		wake_up(&pq->wait);
 }
 
-static void user_sdma_free_request(struct user_sdma_request *req, bool unpin)
+static void user_sdma_free_request(struct user_sdma_request *req)
 {
-	int i;
-
 	if (!list_empty(&req->txps)) {
 		struct sdma_txreq *t, *p;
 
@@ -1415,21 +1241,6 @@ static void user_sdma_free_request(struct user_sdma_request *req, bool unpin)
 		}
 	}
 
-	for (i = 0; i < req->data_iovs; i++) {
-		struct sdma_mmu_node *node = req->iovs[i].node;
-
-		if (!node)
-			continue;
-
-		req->iovs[i].node = NULL;
-
-		if (unpin)
-			hfi1_mmu_rb_remove(req->pq->handler,
-					   &node->rb);
-		else
-			atomic_dec(&node->refcount);
-	}
-
 	kfree(req->tids);
 	clear_bit(req->info.comp_idx, req->pq->req_in_use);
 }
@@ -1447,6 +1258,368 @@ static inline void set_comp_state(struct hfi1_user_sdma_pkt_q *pq,
 					idx, state, ret);
 }
 
+static void unpin_vector_pages(struct mm_struct *mm, struct page **pages,
+			       unsigned int start, unsigned int npages)
+{
+	hfi1_release_user_pages(mm, pages + start, npages, false);
+	kfree(pages);
+}
+
+static void free_system_node(struct sdma_mmu_node *node)
+{
+	if (node->npages) {
+		unpin_vector_pages(mm_from_sdma_node(node), node->pages, 0,
+				   node->npages);
+		atomic_sub(node->npages, &node->pq->n_locked);
+	}
+	kfree(node);
+}
+
+static inline void acquire_node(struct sdma_mmu_node *node)
+{
+	atomic_inc(&node->refcount);
+	WARN_ON(atomic_read(&node->refcount) < 0);
+}
+
+static inline void release_node(struct mmu_rb_handler *handler,
+				struct sdma_mmu_node *node)
+{
+	atomic_dec(&node->refcount);
+	WARN_ON(atomic_read(&node->refcount) < 0);
+}
+
+static struct sdma_mmu_node *find_system_node(struct mmu_rb_handler *handler,
+					      unsigned long start,
+					      unsigned long end)
+{
+	struct mmu_rb_node *rb_node;
+	struct sdma_mmu_node *node;
+	unsigned long flags;
+
+	spin_lock_irqsave(&handler->lock, flags);
+	rb_node = hfi1_mmu_rb_get_first(handler, start, (end - start));
+	if (!rb_node) {
+		spin_unlock_irqrestore(&handler->lock, flags);
+		return NULL;
+	}
+	node = container_of(rb_node, struct sdma_mmu_node, rb);
+	acquire_node(node);
+	spin_unlock_irqrestore(&handler->lock, flags);
+
+	return node;
+}
+
+static int pin_system_pages(struct user_sdma_request *req,
+			    uintptr_t start_address, size_t length,
+			    struct sdma_mmu_node *node, int npages)
+{
+	struct hfi1_user_sdma_pkt_q *pq = req->pq;
+	int pinned, cleared;
+	struct page **pages;
+
+	pages = kcalloc(npages, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+retry:
+	if (!hfi1_can_pin_pages(pq->dd, current->mm, atomic_read(&pq->n_locked),
+				npages)) {
+		SDMA_DBG(req, "Evicting: nlocked %u npages %u",
+			 atomic_read(&pq->n_locked), npages);
+		cleared = sdma_cache_evict(pq, npages);
+		if (cleared >= npages)
+			goto retry;
+	}
+
+	SDMA_DBG(req, "Acquire user pages start_address %lx node->npages %u npages %u",
+		 start_address, node->npages, npages);
+	pinned = hfi1_acquire_user_pages(current->mm, start_address, npages, 0,
+					 pages);
+
+	if (pinned < 0) {
+		kfree(pages);
+		SDMA_DBG(req, "pinned %d", pinned);
+		return pinned;
+	}
+	if (pinned != npages) {
+		unpin_vector_pages(current->mm, pages, node->npages, pinned);
+		SDMA_DBG(req, "npages %u pinned %d", npages, pinned);
+		return -EFAULT;
+	}
+	node->rb.addr = start_address;
+	node->rb.len = length;
+	node->pages = pages;
+	node->npages = npages;
+	atomic_add(pinned, &pq->n_locked);
+	SDMA_DBG(req, "done. pinned %d", pinned);
+	return 0;
+}
+
+static int add_system_pinning(struct user_sdma_request *req,
+			      struct sdma_mmu_node **node_p,
+			      unsigned long start, unsigned long len)
+
+{
+	struct hfi1_user_sdma_pkt_q *pq = req->pq;
+	struct sdma_mmu_node *node;
+	int ret;
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	node->pq = pq;
+	ret = pin_system_pages(req, start, len, node, PFN_DOWN(len));
+	if (ret == 0) {
+		ret = hfi1_mmu_rb_insert(pq->handler, &node->rb);
+		if (ret)
+			free_system_node(node);
+		else
+			*node_p = node;
+
+		return ret;
+	}
+
+	kfree(node);
+	return ret;
+}
+
+static int get_system_cache_entry(struct user_sdma_request *req,
+				  struct sdma_mmu_node **node_p,
+				  size_t req_start, size_t req_len)
+{
+	struct hfi1_user_sdma_pkt_q *pq = req->pq;
+	u64 start = ALIGN_DOWN(req_start, PAGE_SIZE);
+	u64 end = PFN_ALIGN(req_start + req_len);
+	struct mmu_rb_handler *handler = pq->handler;
+	int ret;
+
+	if ((end - start) == 0) {
+		SDMA_DBG(req,
+			 "Request for empty cache entry req_start %lx req_len %lx start %llx end %llx",
+			 req_start, req_len, start, end);
+		return -EINVAL;
+	}
+
+	SDMA_DBG(req, "req_start %lx req_len %lu", req_start, req_len);
+
+	while (1) {
+		struct sdma_mmu_node *node =
+			find_system_node(handler, start, end);
+		u64 prepend_len = 0;
+
+		SDMA_DBG(req, "node %p start %llx end %llu", node, start, end);
+		if (!node) {
+			ret = add_system_pinning(req, node_p, start,
+						 end - start);
+			if (ret == -EEXIST) {
+				/*
+				 * Another execution context has inserted a
+				 * conficting entry first.
+				 */
+				continue;
+			}
+			return ret;
+		}
+
+		if (node->rb.addr <= start) {
+			/*
+			 * This entry covers at least part of the region. If it doesn't extend
+			 * to the end, then this will be called again for the next segment.
+			 */
+			*node_p = node;
+			return 0;
+		}
+
+		SDMA_DBG(req, "prepend: node->rb.addr %lx, node->refcount %d",
+			 node->rb.addr, atomic_read(&node->refcount));
+		prepend_len = node->rb.addr - start;
+
+		/*
+		 * This node will not be returned, instead a new node
+		 * will be. So release the reference.
+		 */
+		release_node(handler, node);
+
+		/* Prepend a node to cover the beginning of the allocation */
+		ret = add_system_pinning(req, node_p, start, prepend_len);
+		if (ret == -EEXIST) {
+			/* Another execution context has inserted a conficting entry first. */
+			continue;
+		}
+		return ret;
+	}
+}
+
+static int add_mapping_to_sdma_packet(struct user_sdma_request *req,
+				      struct user_sdma_txreq *tx,
+				      struct sdma_mmu_node *cache_entry,
+				      size_t start,
+				      size_t from_this_cache_entry)
+{
+	struct hfi1_user_sdma_pkt_q *pq = req->pq;
+	unsigned int page_offset;
+	unsigned int from_this_page;
+	size_t page_index;
+	void *ctx;
+	int ret;
+
+	/*
+	 * Because the cache may be more fragmented than the memory that is being accessed,
+	 * it's not strictly necessary to have a descriptor per cache entry.
+	 */
+
+	while (from_this_cache_entry) {
+		page_index = PFN_DOWN(start - cache_entry->rb.addr);
+
+		if (page_index >= cache_entry->npages) {
+			SDMA_DBG(req,
+				 "Request for page_index %zu >= cache_entry->npages %u",
+				 page_index, cache_entry->npages);
+			return -EINVAL;
+		}
+
+		page_offset = start - ALIGN_DOWN(start, PAGE_SIZE);
+		from_this_page = PAGE_SIZE - page_offset;
+
+		if (from_this_page < from_this_cache_entry) {
+			ctx = NULL;
+		} else {
+			/*
+			 * In the case they are equal the next line has no practical effect,
+			 * but it's better to do a register to register copy than a conditional
+			 * branch.
+			 */
+			from_this_page = from_this_cache_entry;
+			ctx = cache_entry;
+		}
+
+		ret = sdma_txadd_page(pq->dd, ctx, &tx->txreq,
+				      cache_entry->pages[page_index],
+				      page_offset, from_this_page);
+		if (ret) {
+			/*
+			 * When there's a failure, the entire request is freed by
+			 * user_sdma_send_pkts().
+			 */
+			SDMA_DBG(req,
+				 "sdma_txadd_page failed %d page_index %lu page_offset %u from_this_page %u",
+				 ret, page_index, page_offset, from_this_page);
+			return ret;
+		}
+		start += from_this_page;
+		from_this_cache_entry -= from_this_page;
+	}
+	return 0;
+}
+
+static int add_system_iovec_to_sdma_packet(struct user_sdma_request *req,
+					   struct user_sdma_txreq *tx,
+					   struct user_sdma_iovec *iovec,
+					   size_t from_this_iovec)
+{
+	struct mmu_rb_handler *handler = req->pq->handler;
+
+	while (from_this_iovec > 0) {
+		struct sdma_mmu_node *cache_entry;
+		size_t from_this_cache_entry;
+		size_t start;
+		int ret;
+
+		start = (uintptr_t)iovec->iov.iov_base + iovec->offset;
+		ret = get_system_cache_entry(req, &cache_entry, start,
+					     from_this_iovec);
+		if (ret) {
+			SDMA_DBG(req, "pin system segment failed %d", ret);
+			return ret;
+		}
+
+		from_this_cache_entry = cache_entry->rb.len - (start - cache_entry->rb.addr);
+		if (from_this_cache_entry > from_this_iovec)
+			from_this_cache_entry = from_this_iovec;
+
+		ret = add_mapping_to_sdma_packet(req, tx, cache_entry, start,
+						 from_this_cache_entry);
+		if (ret) {
+			/*
+			 * We're guaranteed that there will be no descriptor
+			 * completion callback that releases this node
+			 * because only the last descriptor referencing it
+			 * has a context attached, and a failure means the
+			 * last descriptor was never added.
+			 */
+			release_node(handler, cache_entry);
+			SDMA_DBG(req, "add system segment failed %d", ret);
+			return ret;
+		}
+
+		iovec->offset += from_this_cache_entry;
+		from_this_iovec -= from_this_cache_entry;
+	}
+
+	return 0;
+}
+
+static int add_system_pages_to_sdma_packet(struct user_sdma_request *req,
+					   struct user_sdma_txreq *tx,
+					   struct user_sdma_iovec *iovec,
+					   u32 *pkt_data_remaining)
+{
+	size_t remaining_to_add = *pkt_data_remaining;
+	/*
+	 * Walk through iovec entries, ensure the associated pages
+	 * are pinned and mapped, add data to the packet until no more
+	 * data remains to be added.
+	 */
+	while (remaining_to_add > 0) {
+		struct user_sdma_iovec *cur_iovec;
+		size_t from_this_iovec;
+		int ret;
+
+		cur_iovec = iovec;
+		from_this_iovec = iovec->iov.iov_len - iovec->offset;
+
+		if (from_this_iovec > remaining_to_add) {
+			from_this_iovec = remaining_to_add;
+		} else {
+			/* The current iovec entry will be consumed by this pass. */
+			req->iov_idx++;
+			iovec++;
+		}
+
+		ret = add_system_iovec_to_sdma_packet(req, tx, cur_iovec,
+						      from_this_iovec);
+		if (ret)
+			return ret;
+
+		remaining_to_add -= from_this_iovec;
+	}
+	*pkt_data_remaining = remaining_to_add;
+
+	return 0;
+}
+
+void system_descriptor_complete(struct hfi1_devdata *dd,
+				struct sdma_desc *descp)
+{
+	switch (sdma_mapping_type(descp)) {
+	case SDMA_MAP_SINGLE:
+		dma_unmap_single(&dd->pcidev->dev, sdma_mapping_addr(descp),
+				 sdma_mapping_len(descp), DMA_TO_DEVICE);
+		break;
+	case SDMA_MAP_PAGE:
+		dma_unmap_page(&dd->pcidev->dev, sdma_mapping_addr(descp),
+			       sdma_mapping_len(descp), DMA_TO_DEVICE);
+		break;
+	}
+
+	if (descp->pinning_ctx) {
+		struct sdma_mmu_node *node = descp->pinning_ctx;
+
+		release_node(node->rb.handler, node);
+	}
+}
+
 static bool sdma_rb_filter(struct mmu_rb_node *node, unsigned long addr,
 			   unsigned long len)
 {
@@ -1493,8 +1666,7 @@ static void sdma_rb_remove(void *arg, struct mmu_rb_node *mnode)
 	struct sdma_mmu_node *node =
 		container_of(mnode, struct sdma_mmu_node, rb);
 
-	unpin_sdma_pages(node);
-	kfree(node);
+	free_system_node(node);
 }
 
 static int sdma_rb_invalidate(void *arg, struct mmu_rb_node *mnode)
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.h b/drivers/infiniband/hw/hfi1/user_sdma.h
index ea56eb57e656..a241836371dc 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.h
+++ b/drivers/infiniband/hw/hfi1/user_sdma.h
@@ -112,16 +112,11 @@ struct sdma_mmu_node {
 struct user_sdma_iovec {
 	struct list_head list;
 	struct iovec iov;
-	/* number of pages in this vector */
-	unsigned int npages;
-	/* array of pinned pages for this vector */
-	struct page **pages;
 	/*
 	 * offset into the virtual address space of the vector at
 	 * which we last left off.
 	 */
 	u64 offset;
-	struct sdma_mmu_node *node;
 };
 
 /* evict operation argument */
diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 7f6d7fc7951d..fbdcfecb1768 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -778,8 +778,8 @@ static int build_verbs_tx_desc(
 
 	/* add icrc, lt byte, and padding to flit */
 	if (extra_bytes)
-		ret = sdma_txadd_daddr(sde->dd, &tx->txreq,
-				       sde->dd->sdma_pad_phys, extra_bytes);
+		ret = sdma_txadd_daddr(sde->dd, &tx->txreq, sde->dd->sdma_pad_phys,
+				       extra_bytes);
 
 bail_txadd:
 	return ret;
diff --git a/drivers/infiniband/hw/hfi1/vnic_sdma.c b/drivers/infiniband/hw/hfi1/vnic_sdma.c
index c3f0f8d877c3..727eedfba332 100644
--- a/drivers/infiniband/hw/hfi1/vnic_sdma.c
+++ b/drivers/infiniband/hw/hfi1/vnic_sdma.c
@@ -64,6 +64,7 @@ static noinline int build_vnic_ulp_payload(struct sdma_engine *sde,
 
 		/* combine physically continuous fragments later? */
 		ret = sdma_txadd_page(sde->dd,
+				      NULL,
 				      &tx->txreq,
 				      skb_frag_page(frag),
 				      skb_frag_off(frag),


