Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D3278437B
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 16:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbjHVOJg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 10:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjHVOJf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 10:09:35 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD74AE40
        for <linux-rdma@vger.kernel.org>; Tue, 22 Aug 2023 07:09:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVV//AYiPEszADIqlislx5jY8TECHdSY/L7+nRScikzYXlu6YS1IE//6nuXc3oQkuPrUpINome+6zJc5UtuMcMZWpeyi/0WSO6x/jEVq73aGDvphqUN7ToZMO9WgegcLumfSitpp2+yM3Wh0Y7bsTUMLJ7jxshv6Kl1zcalsWenst1oCX9bF3lSuq0++zvAAFWX0yEL2C9Y8hxd4SKXtgqQ8RBPE1/gjrmmdOsD4+fNef+c9L0iG5gHmz+T0iG8JVwsN9dGyhgxt/QSkS65oEGnUbNYtgHdK18PpXDO+et3gjoDQwHZHGrAvUMqy5llRZF7JxvsCdu6LUxZ0CTnM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NP7WJx7KpTjlA8uxV19xm50JaWtl37C+d3GNPpY+oaI=;
 b=DkloN4hsvZaKUEtGz6Dkzry8WpZ3XSuo6cjoTTNy3UBaJJendAgP5yftqAgIh3XqEO+GyOe0TXQiCA4O4FbjoEndHA/r43KpazzhPlAr4h72SWDpLO+B5zKvmwFa+/Vo9ofv+yHhpbLJpTHgXPgdXs/VfVL0Re0TThfY9zQCf46g35NIU114C60ZLLVvYqXfKYlEOOWya+1Pz7qYU32K4rnuJMi1SrTeHiqphVpKNSKIWFI/cTmn9D5viaatza6333bdS4wqJ6NJsqTbBgLc14p8o75E+NezoojP3JbFOAjkE9iQDNd+0b8ADFua1HUQtxy/NQmID2MQi3tksb6dhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NP7WJx7KpTjlA8uxV19xm50JaWtl37C+d3GNPpY+oaI=;
 b=P54g+eaADK1YDOiSrImGqwfsWr/D4s256rDDhGIzZ/9xnOsmbu8uD7RBxk/i9xTpmLO+uhfOo/hmO+9jmhogNdB//Xb9guBGyvKnEmukbKH7Rel1ZJiTa+nk/8xLDe7dAiKI5mjyUsISTayteDyuHGQqnAYmSnYPkjzPXxn8EuQX/nUC5XbsG13DT9O5sHYbK6PLqioYYCSGk7/yZeCCh0G7y3m74czQkEiwJ013grd6XPBKUfD6+iZKNc1c+WlrYNDQPj6y8rjBjODQNbM/OyprI8wflN9m1KQ4+F1Ne3sDWmus0NIkZpSBwLienYzJMPLU9G4tETBWN0tOdV5z9Q==
Received: from SA1P222CA0132.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::15)
 by BL1PR01MB7577.prod.exchangelabs.com (2603:10b6:208:385::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Tue, 22 Aug 2023 14:07:55 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:3c2:cafe::d8) by SA1P222CA0132.outlook.office365.com
 (2603:10b6:806:3c2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Tue, 22 Aug 2023 14:07:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Tue, 22 Aug 2023 14:07:54 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 37ME7rf41856194;
        Tue, 22 Aug 2023 10:07:53 -0400
Subject: [PATCH for-next 1/2] RDMA/hfi1: Move user SDMA system memory pinning
 code to its own file
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Tue, 22 Aug 2023 10:07:53 -0400
Message-ID: <169271327311.1855761.4736714053318724062.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <169271289743.1855761.7584504317823143869.stgit@awfm-02.cornelisnetworks.com>
References: <169271289743.1855761.7584504317823143869.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|BL1PR01MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: d8cab821-2b55-4f90-6236-08dba3192e0b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +MTCpp7+5lbRU2ChFrpAv9S9VR1FNjxvE1JZMbAEijDVVnhJ5k+Rn6MUlr8FLB7yB3j6o8GACWSRhwTfNzKWATcfo7PIaqLi6mGp2sxe2TwpAvSgbZJsGDu6iyQ4zFAgLgmgVVkD8wbsX4luk2RBQhbQ0i/IKXqntrDao+0zIvgQPhe5G4A/T3o8tIRdPVLyfsFKlFvkb+7YwudtUg1eGG77CDlxkkl4S4V8JgHSkFH9cYfC4Qq1iEFSQ3kRV5BSRxIQdjDIkDkxzRwLNv/i0ts4lnJxxXuTudY/6EtB57TiydwSppy5GJ5SphOq5bzTrHIt/zeWffAIBmPku3VmoiNnLEPnsGrjSoHra1aP6p/pedH01Oiv6gfpPvMbC5WPE4g8jUTisxDFADLGy3YyDEL3nAygyciUsuV0pxb9iITGTEyFF4fJX2aeIdwzbIA9JwrKBY6fTM+JVC1fpuSrzGVlvmji/CMM7G8nHrC8RDDOB1q4EMFH42uwMjGgxvVcIux59tgZva4IZyu0DcW7wKTrpQFEEKbIwoPKD+kWFzbScKBGMR9GbFT7AYw+Z1JVGvdrQp+aWBSxiyFHKl/pZmMG5K7Z/HG2s+IQ8lVHAADeDAIBvSVhzg2PRNu/3yxa1K3N8+2pL87uwRGyyWHmJSB2Ew6jPWsa3Y/JQMKRl4IwgEFzYcnj0B6L4iXe9gRZ4SFBXK3MLJN6Job5YJ7zPgyaak5Itm9Cj3eTGc3XT3e6O2Wgvba5Mqs92MCDr9tR
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39840400004)(346002)(1800799009)(186009)(451199024)(82310400011)(46966006)(36840700001)(54906003)(70586007)(316002)(70206006)(8676002)(7126003)(8936002)(4326008)(41300700001)(356005)(81166007)(478600001)(55016003)(40480700001)(83380400001)(30864003)(2906002)(103116003)(47076005)(7696005)(36860700001)(86362001)(336012)(44832011)(426003)(5660300002)(26005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:07:54.1627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cab821-2b55-4f90-6236-08dba3192e0b
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7577
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Brendan Cunningham <bcunningham@cornelisnetworks.com>

Move user SDMA system memory page-pinning code from user_sdma.c to
pin_system.c. Put declarations for non-static functions in pinning.h.

System memory pinning is necessary for processing user SDMA requests but
actual steps are invisible to user SDMA request-processing code. Moving
system memory pinning code for user SDMA to its own file makes this
distinction apparent.

These changes have no effect on userspace.

Signed-off-by: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
Signed-off-by: Brendan Cunningham <bcunningham@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/Makefile     |    1 
 drivers/infiniband/hw/hfi1/hfi.h        |    4 
 drivers/infiniband/hw/hfi1/pin_system.c |  474 +++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi1/pinning.h    |   20 +
 drivers/infiniband/hw/hfi1/user_sdma.c  |  441 -----------------------------
 drivers/infiniband/hw/hfi1/user_sdma.h  |   17 -
 6 files changed, 505 insertions(+), 452 deletions(-)
 create mode 100644 drivers/infiniband/hw/hfi1/pin_system.c
 create mode 100644 drivers/infiniband/hw/hfi1/pinning.h

diff --git a/drivers/infiniband/hw/hfi1/Makefile b/drivers/infiniband/hw/hfi1/Makefile
index 2e89ec10efed..5d977f363684 100644
--- a/drivers/infiniband/hw/hfi1/Makefile
+++ b/drivers/infiniband/hw/hfi1/Makefile
@@ -31,6 +31,7 @@ hfi1-y := \
 	netdev_rx.o \
 	opfn.o \
 	pcie.o \
+	pin_system.o \
 	pio.o \
 	pio_copy.o \
 	platform.o \
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index 7fa9cd39254f..38772e52d7ed 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
 /*
- * Copyright(c) 2020 Cornelis Networks, Inc.
+ * Copyright(c) 2020-2023 Cornelis Networks, Inc.
  * Copyright(c) 2015-2020 Intel Corporation.
  */
 
@@ -1378,8 +1378,6 @@ struct hfi1_devdata {
 #define PT_INVALID        3
 
 struct tid_rb_node;
-struct mmu_rb_node;
-struct mmu_rb_handler;
 
 /* Private data for file operations */
 struct hfi1_filedata {
diff --git a/drivers/infiniband/hw/hfi1/pin_system.c b/drivers/infiniband/hw/hfi1/pin_system.c
new file mode 100644
index 000000000000..384f722093e0
--- /dev/null
+++ b/drivers/infiniband/hw/hfi1/pin_system.c
@@ -0,0 +1,474 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+/*
+ * Copyright(c) 2023 - Cornelis Networks, Inc.
+ */
+
+#include <linux/types.h>
+
+#include "hfi.h"
+#include "common.h"
+#include "device.h"
+#include "pinning.h"
+#include "mmu_rb.h"
+#include "user_sdma.h"
+#include "trace.h"
+
+struct sdma_mmu_node {
+	struct mmu_rb_node rb;
+	struct hfi1_user_sdma_pkt_q *pq;
+	struct page **pages;
+	unsigned int npages;
+};
+
+static bool sdma_rb_filter(struct mmu_rb_node *node, unsigned long addr,
+			   unsigned long len);
+static int sdma_rb_evict(void *arg, struct mmu_rb_node *mnode, void *arg2,
+			 bool *stop);
+static void sdma_rb_remove(void *arg, struct mmu_rb_node *mnode);
+
+static struct mmu_rb_ops sdma_rb_ops = {
+	.filter = sdma_rb_filter,
+	.evict = sdma_rb_evict,
+	.remove = sdma_rb_remove,
+};
+
+int hfi1_init_system_pinning(struct hfi1_user_sdma_pkt_q *pq)
+{
+	struct hfi1_devdata *dd = pq->dd;
+	int ret;
+
+	ret = hfi1_mmu_rb_register(pq, &sdma_rb_ops, dd->pport->hfi1_wq,
+				   &pq->handler);
+	if (ret)
+		dd_dev_err(dd,
+			   "[%u:%u] Failed to register system memory DMA support with MMU: %d\n",
+			   pq->ctxt, pq->subctxt, ret);
+	return ret;
+}
+
+void hfi1_free_system_pinning(struct hfi1_user_sdma_pkt_q *pq)
+{
+	if (pq->handler)
+		hfi1_mmu_rb_unregister(pq->handler);
+}
+
+static u32 sdma_cache_evict(struct hfi1_user_sdma_pkt_q *pq, u32 npages)
+{
+	struct evict_data evict_data;
+
+	evict_data.cleared = 0;
+	evict_data.target = npages;
+	hfi1_mmu_rb_evict(pq->handler, &evict_data);
+	return evict_data.cleared;
+}
+
+static void unpin_vector_pages(struct mm_struct *mm, struct page **pages,
+			       unsigned int start, unsigned int npages)
+{
+	hfi1_release_user_pages(mm, pages + start, npages, false);
+	kfree(pages);
+}
+
+static inline struct mm_struct *mm_from_sdma_node(struct sdma_mmu_node *node)
+{
+	return node->rb.handler->mn.mm;
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
+/*
+ * kref_get()'s an additional kref on the returned rb_node to prevent rb_node
+ * from being released until after rb_node is assigned to an SDMA descriptor
+ * (struct sdma_desc) under add_system_iovec_to_sdma_packet(), even if the
+ * virtual address range for rb_node is invalidated between now and then.
+ */
+static struct sdma_mmu_node *find_system_node(struct mmu_rb_handler *handler,
+					      unsigned long start,
+					      unsigned long end)
+{
+	struct mmu_rb_node *rb_node;
+	unsigned long flags;
+
+	spin_lock_irqsave(&handler->lock, flags);
+	rb_node = hfi1_mmu_rb_get_first(handler, start, (end - start));
+	if (!rb_node) {
+		spin_unlock_irqrestore(&handler->lock, flags);
+		return NULL;
+	}
+
+	/* "safety" kref to prevent release before add_system_iovec_to_sdma_packet() */
+	kref_get(&rb_node->refcount);
+	spin_unlock_irqrestore(&handler->lock, flags);
+
+	return container_of(rb_node, struct sdma_mmu_node, rb);
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
+/*
+ * kref refcount on *node_p will be 2 on successful addition: one kref from
+ * kref_init() for mmu_rb_handler and one kref to prevent *node_p from being
+ * released until after *node_p is assigned to an SDMA descriptor (struct
+ * sdma_desc) under add_system_iovec_to_sdma_packet(), even if the virtual
+ * address range for *node_p is invalidated between now and then.
+ */
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
+	/* First kref "moves" to mmu_rb_handler */
+	kref_init(&node->rb.refcount);
+
+	/* "safety" kref to prevent release before add_system_iovec_to_sdma_packet() */
+	kref_get(&node->rb.refcount);
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
+			find_system_node(pq->handler, start, end);
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
+		SDMA_DBG(req, "prepend: node->rb.addr %lx, node->rb.refcount %d",
+			 node->rb.addr, kref_read(&node->rb.refcount));
+		prepend_len = node->rb.addr - start;
+
+		/*
+		 * This node will not be returned, instead a new node
+		 * will be. So release the reference.
+		 */
+		kref_put(&node->rb.refcount, hfi1_mmu_rb_release);
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
+static void sdma_mmu_rb_node_get(void *ctx)
+{
+	struct mmu_rb_node *node = ctx;
+
+	kref_get(&node->refcount);
+}
+
+static void sdma_mmu_rb_node_put(void *ctx)
+{
+	struct sdma_mmu_node *node = ctx;
+
+	kref_put(&node->rb.refcount, hfi1_mmu_rb_release);
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
+		ret = sdma_txadd_page(pq->dd, &tx->txreq,
+				      cache_entry->pages[page_index],
+				      page_offset, from_this_page,
+				      ctx,
+				      sdma_mmu_rb_node_get,
+				      sdma_mmu_rb_node_put);
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
+
+		/*
+		 * Done adding cache_entry to zero or more sdma_desc. Can
+		 * kref_put() the "safety" kref taken under
+		 * get_system_cache_entry().
+		 */
+		kref_put(&cache_entry->rb.refcount, hfi1_mmu_rb_release);
+
+		if (ret) {
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
+/*
+ * Add up to pkt_data_remaining bytes to the txreq, starting at the current
+ * offset in the given iovec entry and continuing until all data has been added
+ * to the iovec or the iovec entry type changes.
+ *
+ * On success, prior to returning, adjust pkt_data_remaining, req->iov_idx, and
+ * the offset value in req->iov[req->iov_idx] to reflect the data that has been
+ * consumed.
+ */
+int hfi1_add_pages_to_sdma_packet(struct user_sdma_request *req,
+				  struct user_sdma_txreq *tx,
+				  struct user_sdma_iovec *iovec,
+				  u32 *pkt_data_remaining)
+{
+	size_t remaining_to_add = *pkt_data_remaining;
+	/*
+	 * Walk through iovec entries, ensure the associated pages
+	 * are pinned and mapped, add data to the packet until no more
+	 * data remains to be added or the iovec entry type changes.
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
+static bool sdma_rb_filter(struct mmu_rb_node *node, unsigned long addr,
+			   unsigned long len)
+{
+	return (bool)(node->addr == addr);
+}
+
+/*
+ * Return 1 to remove the node from the rb tree and call the remove op.
+ *
+ * Called with the rb tree lock held.
+ */
+static int sdma_rb_evict(void *arg, struct mmu_rb_node *mnode,
+			 void *evict_arg, bool *stop)
+{
+	struct sdma_mmu_node *node =
+		container_of(mnode, struct sdma_mmu_node, rb);
+	struct evict_data *evict_data = evict_arg;
+
+	/* this node will be evicted, add its pages to our count */
+	evict_data->cleared += node->npages;
+
+	/* have enough pages been cleared? */
+	if (evict_data->cleared >= evict_data->target)
+		*stop = true;
+
+	return 1; /* remove this node */
+}
+
+static void sdma_rb_remove(void *arg, struct mmu_rb_node *mnode)
+{
+	struct sdma_mmu_node *node =
+		container_of(mnode, struct sdma_mmu_node, rb);
+
+	free_system_node(node);
+}
diff --git a/drivers/infiniband/hw/hfi1/pinning.h b/drivers/infiniband/hw/hfi1/pinning.h
new file mode 100644
index 000000000000..a814a3aa9654
--- /dev/null
+++ b/drivers/infiniband/hw/hfi1/pinning.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/*
+ * Copyright(c) 2023 Cornelis Networks, Inc.
+ */
+#ifndef _HFI1_PINNING_H
+#define _HFI1_PINNING_H
+
+struct hfi1_user_sdma_pkt_q;
+struct user_sdma_request;
+struct user_sdma_txreq;
+struct user_sdma_iovec;
+
+int hfi1_init_system_pinning(struct hfi1_user_sdma_pkt_q *pq);
+void hfi1_free_system_pinning(struct hfi1_user_sdma_pkt_q *pq);
+int hfi1_add_pages_to_sdma_packet(struct user_sdma_request *req,
+				  struct user_sdma_txreq *tx,
+				  struct user_sdma_iovec *iovec,
+				  u32 *pkt_data_remaining);
+
+#endif /* _HFI1_PINNING_H */
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index 02bd62b857b7..29ae7beb9b03 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
 /*
- * Copyright(c) 2020 - Cornelis Networks, Inc.
+ * Copyright(c) 2020 - 2023 Cornelis Networks, Inc.
  * Copyright(c) 2015 - 2018 Intel Corporation.
  */
 
@@ -60,22 +60,6 @@ static int defer_packet_queue(
 	uint seq,
 	bool pkts_sent);
 static void activate_packet_queue(struct iowait *wait, int reason);
-static bool sdma_rb_filter(struct mmu_rb_node *node, unsigned long addr,
-			   unsigned long len);
-static int sdma_rb_evict(void *arg, struct mmu_rb_node *mnode,
-			 void *arg2, bool *stop);
-static void sdma_rb_remove(void *arg, struct mmu_rb_node *mnode);
-
-static struct mmu_rb_ops sdma_rb_ops = {
-	.filter = sdma_rb_filter,
-	.evict = sdma_rb_evict,
-	.remove = sdma_rb_remove,
-};
-
-static int add_system_pages_to_sdma_packet(struct user_sdma_request *req,
-					   struct user_sdma_txreq *tx,
-					   struct user_sdma_iovec *iovec,
-					   u32 *pkt_remaining);
 
 static int defer_packet_queue(
 	struct sdma_engine *sde,
@@ -185,12 +169,9 @@ int hfi1_user_sdma_alloc_queues(struct hfi1_ctxtdata *uctxt,
 
 	cq->nentries = hfi1_sdma_comp_ring_size;
 
-	ret = hfi1_mmu_rb_register(pq, &sdma_rb_ops, dd->pport->hfi1_wq,
-				   &pq->handler);
-	if (ret) {
-		dd_dev_err(dd, "Failed to register with MMU %d", ret);
+	ret = hfi1_init_system_pinning(pq);
+	if (ret)
 		goto pq_mmu_fail;
-	}
 
 	rcu_assign_pointer(fd->pq, pq);
 	fd->cq = cq;
@@ -249,8 +230,7 @@ int hfi1_user_sdma_free_queues(struct hfi1_filedata *fd,
 			pq->wait,
 			!atomic_read(&pq->n_reqs));
 		kfree(pq->reqs);
-		if (pq->handler)
-			hfi1_mmu_rb_unregister(pq->handler);
+		hfi1_free_system_pinning(pq);
 		bitmap_free(pq->req_in_use);
 		kmem_cache_destroy(pq->txreq_cache);
 		flush_pq_iowait(pq);
@@ -821,8 +801,8 @@ static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts)
 			req->tidoffset += datalen;
 		req->sent += datalen;
 		while (datalen) {
-			ret = add_system_pages_to_sdma_packet(req, tx, iovec,
-							      &datalen);
+			ret = hfi1_add_pages_to_sdma_packet(req, tx, iovec,
+							    &datalen);
 			if (ret)
 				goto free_txreq;
 			iovec = &req->iovs[req->iov_idx];
@@ -860,17 +840,6 @@ static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts)
 	return ret;
 }
 
-static u32 sdma_cache_evict(struct hfi1_user_sdma_pkt_q *pq, u32 npages)
-{
-	struct evict_data evict_data;
-	struct mmu_rb_handler *handler = pq->handler;
-
-	evict_data.cleared = 0;
-	evict_data.target = npages;
-	hfi1_mmu_rb_evict(handler, &evict_data);
-	return evict_data.cleared;
-}
-
 static int check_header_template(struct user_sdma_request *req,
 				 struct hfi1_pkt_header *hdr, u32 lrhlen,
 				 u32 datalen)
@@ -1253,401 +1222,3 @@ static inline void set_comp_state(struct hfi1_user_sdma_pkt_q *pq,
 	trace_hfi1_sdma_user_completion(pq->dd, pq->ctxt, pq->subctxt,
 					idx, state, ret);
 }
-
-static void unpin_vector_pages(struct mm_struct *mm, struct page **pages,
-			       unsigned int start, unsigned int npages)
-{
-	hfi1_release_user_pages(mm, pages + start, npages, false);
-	kfree(pages);
-}
-
-static void free_system_node(struct sdma_mmu_node *node)
-{
-	if (node->npages) {
-		unpin_vector_pages(mm_from_sdma_node(node), node->pages, 0,
-				   node->npages);
-		atomic_sub(node->npages, &node->pq->n_locked);
-	}
-	kfree(node);
-}
-
-/*
- * kref_get()'s an additional kref on the returned rb_node to prevent rb_node
- * from being released until after rb_node is assigned to an SDMA descriptor
- * (struct sdma_desc) under add_system_iovec_to_sdma_packet(), even if the
- * virtual address range for rb_node is invalidated between now and then.
- */
-static struct sdma_mmu_node *find_system_node(struct mmu_rb_handler *handler,
-					      unsigned long start,
-					      unsigned long end)
-{
-	struct mmu_rb_node *rb_node;
-	unsigned long flags;
-
-	spin_lock_irqsave(&handler->lock, flags);
-	rb_node = hfi1_mmu_rb_get_first(handler, start, (end - start));
-	if (!rb_node) {
-		spin_unlock_irqrestore(&handler->lock, flags);
-		return NULL;
-	}
-
-	/* "safety" kref to prevent release before add_system_iovec_to_sdma_packet() */
-	kref_get(&rb_node->refcount);
-	spin_unlock_irqrestore(&handler->lock, flags);
-
-	return container_of(rb_node, struct sdma_mmu_node, rb);
-}
-
-static int pin_system_pages(struct user_sdma_request *req,
-			    uintptr_t start_address, size_t length,
-			    struct sdma_mmu_node *node, int npages)
-{
-	struct hfi1_user_sdma_pkt_q *pq = req->pq;
-	int pinned, cleared;
-	struct page **pages;
-
-	pages = kcalloc(npages, sizeof(*pages), GFP_KERNEL);
-	if (!pages)
-		return -ENOMEM;
-
-retry:
-	if (!hfi1_can_pin_pages(pq->dd, current->mm, atomic_read(&pq->n_locked),
-				npages)) {
-		SDMA_DBG(req, "Evicting: nlocked %u npages %u",
-			 atomic_read(&pq->n_locked), npages);
-		cleared = sdma_cache_evict(pq, npages);
-		if (cleared >= npages)
-			goto retry;
-	}
-
-	SDMA_DBG(req, "Acquire user pages start_address %lx node->npages %u npages %u",
-		 start_address, node->npages, npages);
-	pinned = hfi1_acquire_user_pages(current->mm, start_address, npages, 0,
-					 pages);
-
-	if (pinned < 0) {
-		kfree(pages);
-		SDMA_DBG(req, "pinned %d", pinned);
-		return pinned;
-	}
-	if (pinned != npages) {
-		unpin_vector_pages(current->mm, pages, node->npages, pinned);
-		SDMA_DBG(req, "npages %u pinned %d", npages, pinned);
-		return -EFAULT;
-	}
-	node->rb.addr = start_address;
-	node->rb.len = length;
-	node->pages = pages;
-	node->npages = npages;
-	atomic_add(pinned, &pq->n_locked);
-	SDMA_DBG(req, "done. pinned %d", pinned);
-	return 0;
-}
-
-/*
- * kref refcount on *node_p will be 2 on successful addition: one kref from
- * kref_init() for mmu_rb_handler and one kref to prevent *node_p from being
- * released until after *node_p is assigned to an SDMA descriptor (struct
- * sdma_desc) under add_system_iovec_to_sdma_packet(), even if the virtual
- * address range for *node_p is invalidated between now and then.
- */
-static int add_system_pinning(struct user_sdma_request *req,
-			      struct sdma_mmu_node **node_p,
-			      unsigned long start, unsigned long len)
-
-{
-	struct hfi1_user_sdma_pkt_q *pq = req->pq;
-	struct sdma_mmu_node *node;
-	int ret;
-
-	node = kzalloc(sizeof(*node), GFP_KERNEL);
-	if (!node)
-		return -ENOMEM;
-
-	/* First kref "moves" to mmu_rb_handler */
-	kref_init(&node->rb.refcount);
-
-	/* "safety" kref to prevent release before add_system_iovec_to_sdma_packet() */
-	kref_get(&node->rb.refcount);
-
-	node->pq = pq;
-	ret = pin_system_pages(req, start, len, node, PFN_DOWN(len));
-	if (ret == 0) {
-		ret = hfi1_mmu_rb_insert(pq->handler, &node->rb);
-		if (ret)
-			free_system_node(node);
-		else
-			*node_p = node;
-
-		return ret;
-	}
-
-	kfree(node);
-	return ret;
-}
-
-static int get_system_cache_entry(struct user_sdma_request *req,
-				  struct sdma_mmu_node **node_p,
-				  size_t req_start, size_t req_len)
-{
-	struct hfi1_user_sdma_pkt_q *pq = req->pq;
-	u64 start = ALIGN_DOWN(req_start, PAGE_SIZE);
-	u64 end = PFN_ALIGN(req_start + req_len);
-	struct mmu_rb_handler *handler = pq->handler;
-	int ret;
-
-	if ((end - start) == 0) {
-		SDMA_DBG(req,
-			 "Request for empty cache entry req_start %lx req_len %lx start %llx end %llx",
-			 req_start, req_len, start, end);
-		return -EINVAL;
-	}
-
-	SDMA_DBG(req, "req_start %lx req_len %lu", req_start, req_len);
-
-	while (1) {
-		struct sdma_mmu_node *node =
-			find_system_node(handler, start, end);
-		u64 prepend_len = 0;
-
-		SDMA_DBG(req, "node %p start %llx end %llu", node, start, end);
-		if (!node) {
-			ret = add_system_pinning(req, node_p, start,
-						 end - start);
-			if (ret == -EEXIST) {
-				/*
-				 * Another execution context has inserted a
-				 * conficting entry first.
-				 */
-				continue;
-			}
-			return ret;
-		}
-
-		if (node->rb.addr <= start) {
-			/*
-			 * This entry covers at least part of the region. If it doesn't extend
-			 * to the end, then this will be called again for the next segment.
-			 */
-			*node_p = node;
-			return 0;
-		}
-
-		SDMA_DBG(req, "prepend: node->rb.addr %lx, node->rb.refcount %d",
-			 node->rb.addr, kref_read(&node->rb.refcount));
-		prepend_len = node->rb.addr - start;
-
-		/*
-		 * This node will not be returned, instead a new node
-		 * will be. So release the reference.
-		 */
-		kref_put(&node->rb.refcount, hfi1_mmu_rb_release);
-
-		/* Prepend a node to cover the beginning of the allocation */
-		ret = add_system_pinning(req, node_p, start, prepend_len);
-		if (ret == -EEXIST) {
-			/* Another execution context has inserted a conficting entry first. */
-			continue;
-		}
-		return ret;
-	}
-}
-
-static void sdma_mmu_rb_node_get(void *ctx)
-{
-	struct mmu_rb_node *node = ctx;
-
-	kref_get(&node->refcount);
-}
-
-static void sdma_mmu_rb_node_put(void *ctx)
-{
-	struct sdma_mmu_node *node = ctx;
-
-	kref_put(&node->rb.refcount, hfi1_mmu_rb_release);
-}
-
-static int add_mapping_to_sdma_packet(struct user_sdma_request *req,
-				      struct user_sdma_txreq *tx,
-				      struct sdma_mmu_node *cache_entry,
-				      size_t start,
-				      size_t from_this_cache_entry)
-{
-	struct hfi1_user_sdma_pkt_q *pq = req->pq;
-	unsigned int page_offset;
-	unsigned int from_this_page;
-	size_t page_index;
-	void *ctx;
-	int ret;
-
-	/*
-	 * Because the cache may be more fragmented than the memory that is being accessed,
-	 * it's not strictly necessary to have a descriptor per cache entry.
-	 */
-
-	while (from_this_cache_entry) {
-		page_index = PFN_DOWN(start - cache_entry->rb.addr);
-
-		if (page_index >= cache_entry->npages) {
-			SDMA_DBG(req,
-				 "Request for page_index %zu >= cache_entry->npages %u",
-				 page_index, cache_entry->npages);
-			return -EINVAL;
-		}
-
-		page_offset = start - ALIGN_DOWN(start, PAGE_SIZE);
-		from_this_page = PAGE_SIZE - page_offset;
-
-		if (from_this_page < from_this_cache_entry) {
-			ctx = NULL;
-		} else {
-			/*
-			 * In the case they are equal the next line has no practical effect,
-			 * but it's better to do a register to register copy than a conditional
-			 * branch.
-			 */
-			from_this_page = from_this_cache_entry;
-			ctx = cache_entry;
-		}
-
-		ret = sdma_txadd_page(pq->dd, &tx->txreq,
-				      cache_entry->pages[page_index],
-				      page_offset, from_this_page,
-				      ctx,
-				      sdma_mmu_rb_node_get,
-				      sdma_mmu_rb_node_put);
-		if (ret) {
-			/*
-			 * When there's a failure, the entire request is freed by
-			 * user_sdma_send_pkts().
-			 */
-			SDMA_DBG(req,
-				 "sdma_txadd_page failed %d page_index %lu page_offset %u from_this_page %u",
-				 ret, page_index, page_offset, from_this_page);
-			return ret;
-		}
-		start += from_this_page;
-		from_this_cache_entry -= from_this_page;
-	}
-	return 0;
-}
-
-static int add_system_iovec_to_sdma_packet(struct user_sdma_request *req,
-					   struct user_sdma_txreq *tx,
-					   struct user_sdma_iovec *iovec,
-					   size_t from_this_iovec)
-{
-	while (from_this_iovec > 0) {
-		struct sdma_mmu_node *cache_entry;
-		size_t from_this_cache_entry;
-		size_t start;
-		int ret;
-
-		start = (uintptr_t)iovec->iov.iov_base + iovec->offset;
-		ret = get_system_cache_entry(req, &cache_entry, start,
-					     from_this_iovec);
-		if (ret) {
-			SDMA_DBG(req, "pin system segment failed %d", ret);
-			return ret;
-		}
-
-		from_this_cache_entry = cache_entry->rb.len - (start - cache_entry->rb.addr);
-		if (from_this_cache_entry > from_this_iovec)
-			from_this_cache_entry = from_this_iovec;
-
-		ret = add_mapping_to_sdma_packet(req, tx, cache_entry, start,
-						 from_this_cache_entry);
-
-		/*
-		 * Done adding cache_entry to zero or more sdma_desc. Can
-		 * kref_put() the "safety" kref taken under
-		 * get_system_cache_entry().
-		 */
-		kref_put(&cache_entry->rb.refcount, hfi1_mmu_rb_release);
-
-		if (ret) {
-			SDMA_DBG(req, "add system segment failed %d", ret);
-			return ret;
-		}
-
-		iovec->offset += from_this_cache_entry;
-		from_this_iovec -= from_this_cache_entry;
-	}
-
-	return 0;
-}
-
-static int add_system_pages_to_sdma_packet(struct user_sdma_request *req,
-					   struct user_sdma_txreq *tx,
-					   struct user_sdma_iovec *iovec,
-					   u32 *pkt_data_remaining)
-{
-	size_t remaining_to_add = *pkt_data_remaining;
-	/*
-	 * Walk through iovec entries, ensure the associated pages
-	 * are pinned and mapped, add data to the packet until no more
-	 * data remains to be added.
-	 */
-	while (remaining_to_add > 0) {
-		struct user_sdma_iovec *cur_iovec;
-		size_t from_this_iovec;
-		int ret;
-
-		cur_iovec = iovec;
-		from_this_iovec = iovec->iov.iov_len - iovec->offset;
-
-		if (from_this_iovec > remaining_to_add) {
-			from_this_iovec = remaining_to_add;
-		} else {
-			/* The current iovec entry will be consumed by this pass. */
-			req->iov_idx++;
-			iovec++;
-		}
-
-		ret = add_system_iovec_to_sdma_packet(req, tx, cur_iovec,
-						      from_this_iovec);
-		if (ret)
-			return ret;
-
-		remaining_to_add -= from_this_iovec;
-	}
-	*pkt_data_remaining = remaining_to_add;
-
-	return 0;
-}
-
-static bool sdma_rb_filter(struct mmu_rb_node *node, unsigned long addr,
-			   unsigned long len)
-{
-	return (bool)(node->addr == addr);
-}
-
-/*
- * Return 1 to remove the node from the rb tree and call the remove op.
- *
- * Called with the rb tree lock held.
- */
-static int sdma_rb_evict(void *arg, struct mmu_rb_node *mnode,
-			 void *evict_arg, bool *stop)
-{
-	struct sdma_mmu_node *node =
-		container_of(mnode, struct sdma_mmu_node, rb);
-	struct evict_data *evict_data = evict_arg;
-
-	/* this node will be evicted, add its pages to our count */
-	evict_data->cleared += node->npages;
-
-	/* have enough pages been cleared? */
-	if (evict_data->cleared >= evict_data->target)
-		*stop = true;
-
-	return 1; /* remove this node */
-}
-
-static void sdma_rb_remove(void *arg, struct mmu_rb_node *mnode)
-{
-	struct sdma_mmu_node *node =
-		container_of(mnode, struct sdma_mmu_node, rb);
-
-	free_system_node(node);
-}
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.h b/drivers/infiniband/hw/hfi1/user_sdma.h
index 548347d4c5bc..742ec1470cc5 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.h
+++ b/drivers/infiniband/hw/hfi1/user_sdma.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
 /*
- * Copyright(c) 2020 - Cornelis Networks, Inc.
+ * Copyright(c) 2023 - Cornelis Networks, Inc.
  * Copyright(c) 2015 - 2018 Intel Corporation.
  */
 #ifndef _HFI1_USER_SDMA_H
@@ -13,6 +13,8 @@
 #include "iowait.h"
 #include "user_exp_rcv.h"
 #include "mmu_rb.h"
+#include "pinning.h"
+#include "sdma.h"
 
 /* The maximum number of Data io vectors per message/request */
 #define MAX_VECTORS_PER_REQ 8
@@ -101,13 +103,6 @@ struct hfi1_user_sdma_comp_q {
 	struct hfi1_sdma_comp_entry *comps;
 };
 
-struct sdma_mmu_node {
-	struct mmu_rb_node rb;
-	struct hfi1_user_sdma_pkt_q *pq;
-	struct page **pages;
-	unsigned int npages;
-};
-
 struct user_sdma_iovec {
 	struct list_head list;
 	struct iovec iov;
@@ -203,10 +198,4 @@ int hfi1_user_sdma_free_queues(struct hfi1_filedata *fd,
 int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 				   struct iovec *iovec, unsigned long dim,
 				   unsigned long *count);
-
-static inline struct mm_struct *mm_from_sdma_node(struct sdma_mmu_node *node)
-{
-	return node->rb.handler->mn.mm;
-}
-
 #endif /* _HFI1_USER_SDMA_H */


