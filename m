Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE02709D00
	for <lists+linux-rdma@lfdr.de>; Fri, 19 May 2023 18:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjESQzF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 May 2023 12:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjESQyt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 May 2023 12:54:49 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2114.outbound.protection.outlook.com [40.107.93.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D99183
        for <linux-rdma@vger.kernel.org>; Fri, 19 May 2023 09:54:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a579LRVraGEEsfrofme8He6NQeBzKxcJleSJU4KBRYo/RYTDHrZ9SJg+3EPtJxFgPuuQD+PI+1qtlbokjCDDkX62JOkWgM2nXKwBMhWSeT1afRrttm3VAmDF7teE3FoESuTcoplTas7NT67LvvWbmomu8ih2Bqn0ZsaFcAI/QHeKjNL5Deuf7F/Xb8CFPMsc50C1xg7+/J69eN3YZMbngBHXkWvNDjsyU/OJjsnQmL/GvhAfJ6MJSvdPKIhiEbbGP1QncZteanGRr9J7vgR0U91S2Teakf3iNePPHt9/9zkBrj/jeAVMm3vjVwZRliNyd3LFRnYLxXJxkXW0BSnW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03MXzgn554KeXZTD3NfdkvVcXyFGvqPM8qKrnQgUyZI=;
 b=PcHfb07o7jTLGb2vtt9vm94o0cZT8xezvzQ1Pv6roXpoo8M0bYxTWxPgg/z8Pwo+NMxNwC+3qFCicMLvIPHw63oTJ381a/A6dVHzEahWlgGzKK2W3EkMYicoEiSi4AaAxSFxALTpW8f5e7fDBpM+J7UPebopnog3wL66ZOSR68WIq1fBDU5BUpzclokq3juIH55AzTAhC0GPelPEB4X0W3VxJk5nBrf09AN9ZZxr8Z5fbFyJjU2qQwiZw0syiJDFr/1KL41aKuJEc48yX0pWnhHLfelUsVsdAJ6bvXEWFYj3v6G2Xpa/6URsD6DA7X1uPHuklhEA/+c4v094VMzYmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03MXzgn554KeXZTD3NfdkvVcXyFGvqPM8qKrnQgUyZI=;
 b=SehGa++fOkoUbaOFMCOFWsc6EiDloJDANeJT3apmWUwwBy69JBJt6AUfMs/vxupNqdgcfCMn0pNXmUPgtPjqkp5DrUngD2KJtUykUYf2DPtSkU24n/zhc4Wpq1VKFwqcSDX/ILxld502UJLRHYlr8ba0SgpsFKolT8sdRjUklrIXQYAzEdtO3EQhy/qvK157JBV6IzxgAYm/fYiE+jBtzatz97qSR1ntvHFi9ps+GkQ3Q+AjWYANFPrkLWPVRXfzkD6jyl7/YF/+SVo2gyPmJn+wJfXjk70aIbg8usKdtF3wD1yDVSuNUf5FRHVWhBWcLa3rUw3kbC+9aRSRfs5OHQ==
Received: from BYAPR08CA0030.namprd08.prod.outlook.com (2603:10b6:a03:100::43)
 by CH3PR01MB8246.prod.exchangelabs.com (2603:10b6:610:17e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.21; Fri, 19 May 2023 16:54:33 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:100:cafe::6a) by BYAPR08CA0030.outlook.office365.com
 (2603:10b6:a03:100::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 16:54:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.22 via Frontend Transport; Fri, 19 May 2023 16:54:31 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 34JGsUuY3702394;
        Fri, 19 May 2023 12:54:30 -0400
Subject: [PATCH for-next 3/3] IB/hfi1: Separate user SDMA page-pinning from
 memory type
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Fri, 19 May 2023 12:54:30 -0400
Message-ID: <168451527025.3702129.12415971836404455256.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <168451505181.3702129.3429054159823295146.stgit@awfm-02.cornelisnetworks.com>
References: <168451505181.3702129.3429054159823295146.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|CH3PR01MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: 3242aa18-4249-4510-21a6-08db5889b78e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NAukCij7uLOYB7k5IlC3VEuXyjewj5gausKtpdJJHdRnh2ytAokZQw6AhIlPfUjBEgIDi2oaRfLDc5M9hYv7FJB/tfvoDYM0LBg7IMe1KN1CHHmpBTYUD7PPwj8ALpcVkLVBX+G0RYp73ZINP8GPd9cyxYelhc4XFHc4QKGq58aEkIoL5T+jaLWsMYkp+QYVKnNGk22n6BJuPjTKsLOz9WG9+GfRlkXD+XdQwF2d2dliAGNRp1jsWyLu0S77UPMjPoPYBQh5Yoc/RN/VpZUhmVc5Bf6nRciUF3v3J7Xq7feykdSxW9HeUNniKWASFOa1bbtgADgUQUBCjPSkR80kztkxIl0wXJ+y36wDKwOVwhjdNGDHF4c/s8WsoTKelWxSkGzheXDTFndxWBkiza5MIGb4jrL9WRAcBD9ivCOHpRDqJJt7BdmtEUWAmdSaeZr8nRFKI5040wtUpRW1unEMKzE1UMptkxRG+ommXm9NO+YnXKosUdlpQPfN3Xl0YpfR3wGkMngxIzWGO8boB+WJ67lou0mxTIZ5AeXIOQ8taDN4fu8NHpt7EzIKMDw4uSpyodDonkSOLnRhaQ2CECoSJD0lv6VP6z8mAsLj7eky4vMvpUM2RyPakGGjrpACT52CenUMns9LKnADF4eJua+E1fbbWOj9nidRT8y9QYhAYv+dyEtdLiwwO8UeH942ffK45tJhoBNs7JeLB5G7beH8GlsPofq1Aew0AJ7huzqNi8kx0h4z2IUlxf2fdXUvuNV/
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39840400004)(376002)(451199021)(46966006)(36840700001)(44832011)(86362001)(8676002)(8936002)(70586007)(70206006)(2906002)(30864003)(316002)(4326008)(54906003)(478600001)(41300700001)(5660300002)(356005)(7696005)(82310400005)(81166007)(55016003)(426003)(47076005)(7126003)(336012)(186003)(26005)(40480700001)(103116003)(83380400001)(36860700001)(36900700001)(579004);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 16:54:31.4647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3242aa18-4249-4510-21a6-08db5889b78e
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8246
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>

In order to handle user SDMA requests where the packet payload is to be
constructed from memory other than system memory, do user SDMA
page-pinning through the page-pinning interface. The page-pinning
interface lets the user SDMA code operate on user_sdma_iovec objects
without caring which type of memory that iovec's iov.iov_base points to.

Userspace can request that the SDMA payload be assembled from memory
other than system memory by setting the HFI1_SDMA_REQ_MEMINFO_SHIFT bit
in struct sdma_req_info.ctrl and setting the memory type for each iovec
in struct user_sdma_request.meminfo.types[].

Current userspace SDMA request code to construct packet payloads from
system memory will continue to work without changes.

Signed-off-by: Brendan Cunningham <bcunningham@cornelisnetworks.com>
Signed-off-by: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
V2 -> V3: Removed HFI1_IOCTL_PIN_STATS ioctl from uapi and backing code
from hfi1. Removed declarations for functions that were not defined or
used. Clarify in commit message that pinning changes apply to hfi1 SDMA
path.
V3 -> V4: split-off changes that can stand on their own
- remove more counters that are only for HFI1_IOCTL_PIN_STATS.
- Move mmu_rb_handler cache-line-start allocation to its own commit.
- Move LRU fix to separate commit.
- Move many-iovec-SDMA and mmu_rb cache fixes to separate commit.
- Undo some whitespace & formatting changes to reduce diff size.
---
 drivers/infiniband/hw/hfi1/Makefile     |    2 
 drivers/infiniband/hw/hfi1/init.c       |    5 
 drivers/infiniband/hw/hfi1/pin_system.c |  487 +++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi1/pinning.c    |   55 ++++
 drivers/infiniband/hw/hfi1/pinning.h    |   75 +++++
 drivers/infiniband/hw/hfi1/user_sdma.c  |  472 ++----------------------------
 drivers/infiniband/hw/hfi1/user_sdma.h  |   15 +
 include/uapi/rdma/hfi/hfi1_user.h       |   31 ++
 8 files changed, 702 insertions(+), 440 deletions(-)
 create mode 100644 drivers/infiniband/hw/hfi1/pin_system.c
 create mode 100644 drivers/infiniband/hw/hfi1/pinning.c
 create mode 100644 drivers/infiniband/hw/hfi1/pinning.h

diff --git a/drivers/infiniband/hw/hfi1/Makefile b/drivers/infiniband/hw/hfi1/Makefile
index 2e89ec10efed..9daea77f4164 100644
--- a/drivers/infiniband/hw/hfi1/Makefile
+++ b/drivers/infiniband/hw/hfi1/Makefile
@@ -31,6 +31,8 @@ hfi1-y := \
 	netdev_rx.o \
 	opfn.o \
 	pcie.o \
+	pinning.o \
+	pin_system.o \
 	pio.o \
 	pio_copy.o \
 	platform.o \
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 6de37c5d7d27..b2bf8472570f 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -29,6 +29,7 @@
 #include "vnic.h"
 #include "exp_rcv.h"
 #include "netdev.h"
+#include "pinning.h"
 
 #undef pr_fmt
 #define pr_fmt(fmt) DRIVER_NAME ": " fmt
@@ -1380,6 +1381,8 @@ static int __init hfi1_mod_init(void)
 {
 	int ret;
 
+	register_system_pinning_interface();
+
 	ret = dev_init();
 	if (ret)
 		goto bail;
@@ -1473,6 +1476,8 @@ static void __exit hfi1_mod_cleanup(void)
 	WARN_ON(!xa_empty(&hfi1_dev_table));
 	dispose_firmware();	/* asymmetric with obtain_firmware() */
 	dev_cleanup();
+
+	deregister_system_pinning_interface();
 }
 
 module_exit(hfi1_mod_cleanup);
diff --git a/drivers/infiniband/hw/hfi1/pin_system.c b/drivers/infiniband/hw/hfi1/pin_system.c
new file mode 100644
index 000000000000..2774efb442e3
--- /dev/null
+++ b/drivers/infiniband/hw/hfi1/pin_system.c
@@ -0,0 +1,487 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+/*
+ * Copyright(c) 2022 - Cornelis Networks, Inc.
+ */
+
+#include <linux/types.h>
+
+#include "hfi.h"
+#include "common.h"
+#include "device.h"
+#include "pinning.h"
+#include "mmu_rb.h"
+#include "sdma.h"
+#include "user_sdma.h"
+#include "trace.h"
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
+static int add_system_pages_to_sdma_packet(struct user_sdma_request *req,
+					   struct user_sdma_txreq *tx,
+					   struct user_sdma_iovec *iovec,
+					   u32 *pkt_remaining);
+
+static int init_system_pinning_interface(struct hfi1_user_sdma_pkt_q *pq)
+{
+	struct hfi1_devdata *dd = pq->dd;
+	struct mmu_rb_handler **handler = (struct mmu_rb_handler **)
+		&PINNING_STATE(pq, HFI1_MEMINFO_TYPE_SYSTEM);
+	int ret;
+
+	ret = hfi1_mmu_rb_register(pq, &sdma_rb_ops, dd->pport->hfi1_wq,
+				   handler);
+	if (ret)
+		dd_dev_err(dd,
+			   "[%u:%u] Failed to register system memory DMA support with MMU: %d\n",
+			   pq->ctxt, pq->subctxt, ret);
+	return ret;
+}
+
+static void free_system_pinning_interface(struct hfi1_user_sdma_pkt_q *pq)
+{
+	struct mmu_rb_handler *handler =
+		PINNING_STATE(pq, HFI1_MEMINFO_TYPE_SYSTEM);
+
+	if (handler)
+		hfi1_mmu_rb_unregister(handler);
+}
+
+static u32 sdma_cache_evict(struct hfi1_user_sdma_pkt_q *pq, u32 npages)
+{
+	struct evict_data evict_data;
+	struct mmu_rb_handler *handler =
+		PINNING_STATE(pq, HFI1_MEMINFO_TYPE_SYSTEM);
+
+	evict_data.cleared = 0;
+	evict_data.target = npages;
+	hfi1_mmu_rb_evict(handler, &evict_data);
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
+		ret = hfi1_mmu_rb_insert(PINNING_STATE(pq, HFI1_MEMINFO_TYPE_SYSTEM), &node->rb);
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
+	struct mmu_rb_handler *handler =
+		PINNING_STATE(pq, HFI1_MEMINFO_TYPE_SYSTEM);
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
+static int add_system_pages_to_sdma_packet(struct user_sdma_request *req,
+					   struct user_sdma_txreq *tx,
+					   struct user_sdma_iovec *iovec,
+					   u32 *pkt_data_remaining)
+{
+	size_t remaining_to_add = *pkt_data_remaining;
+	/*
+	 * Walk through iovec entries, ensure the associated pages
+	 * are pinned and mapped, add data to the packet until no more
+	 * data remains to be added or the iovec entry type changes.
+	 */
+	while ((remaining_to_add > 0) &&
+	       (iovec->type == HFI1_MEMINFO_TYPE_SYSTEM)) {
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
+static struct pinning_interface system_pinning_interface = {
+	.init = init_system_pinning_interface,
+	.free = free_system_pinning_interface,
+	.add_to_sdma_packet = add_system_pages_to_sdma_packet,
+};
+
+void register_system_pinning_interface(void)
+{
+	register_pinning_interface(HFI1_MEMINFO_TYPE_SYSTEM,
+				   &system_pinning_interface);
+	pr_info("%s System memory DMA support enabled\n", class_name());
+}
+
+void deregister_system_pinning_interface(void)
+{
+	deregister_pinning_interface(HFI1_MEMINFO_TYPE_SYSTEM);
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
diff --git a/drivers/infiniband/hw/hfi1/pinning.c b/drivers/infiniband/hw/hfi1/pinning.c
new file mode 100644
index 000000000000..82e99128478e
--- /dev/null
+++ b/drivers/infiniband/hw/hfi1/pinning.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+/*
+ * Copyright(c) 2022 - Cornelis Networks, Inc.
+ */
+
+#include <linux/types.h>
+#include <linux/string.h>
+
+#include "pinning.h"
+
+struct pinning_interface pinning_interfaces[PINNING_MAX_INTERFACES];
+
+void register_pinning_interface(unsigned int type,
+				struct pinning_interface *interface)
+{
+	pinning_interfaces[type] = *interface;
+}
+
+void deregister_pinning_interface(unsigned int type)
+{
+	memset(&pinning_interfaces[type], 0, sizeof(pinning_interfaces[type]));
+}
+
+int init_pinning_interfaces(struct hfi1_user_sdma_pkt_q *pq)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < PINNING_MAX_INTERFACES; i++) {
+		if (pinning_interfaces[i].init) {
+			ret = pinning_interfaces[i].init(pq);
+			if (ret)
+				goto fail;
+		}
+	}
+
+	return 0;
+
+fail:
+	while (--i >= 0) {
+		if (pinning_interfaces[i].free)
+			pinning_interfaces[i].free(pq);
+	}
+	return ret;
+}
+
+void free_pinning_interfaces(struct hfi1_user_sdma_pkt_q *pq)
+{
+	unsigned int i;
+
+	for (i = 0; i < PINNING_MAX_INTERFACES; i++) {
+		if (pinning_interfaces[i].free)
+			pinning_interfaces[i].free(pq);
+	}
+}
diff --git a/drivers/infiniband/hw/hfi1/pinning.h b/drivers/infiniband/hw/hfi1/pinning.h
new file mode 100644
index 000000000000..cacb4425351a
--- /dev/null
+++ b/drivers/infiniband/hw/hfi1/pinning.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/*
+ * Copyright(c) 2022 Cornelis Networks, Inc.
+ */
+#ifndef _HFI1_PINNING_H
+#define _HFI1_PINNING_H
+
+#include <rdma/hfi/hfi1_user.h>
+
+struct page;
+struct sg_table;
+
+struct hfi1_devdata;
+struct hfi1_user_sdma_pkt_q;
+struct sdma_desc;
+struct user_sdma_request;
+struct user_sdma_txreq;
+struct user_sdma_iovec;
+
+struct pinning_interface {
+	int (*init)(struct hfi1_user_sdma_pkt_q *pq);
+	void (*free)(struct hfi1_user_sdma_pkt_q *pq);
+
+	/*
+	 * Add up to pkt_data_remaining bytes to the txreq, starting at the
+	 * current offset in the given iovec entry and continuing until all
+	 * data has been added to the iovec or the iovec entry type changes.
+	 * On success, prior to returning, the implementation must adjust
+	 * pkt_data_remaining, req->iov_idx, and the offset value in
+	 * req->iov[req->iov_idx] to reflect the data that has been
+	 * consumed.
+	 */
+	int (*add_to_sdma_packet)(struct user_sdma_request *req,
+				  struct user_sdma_txreq *tx,
+				  struct user_sdma_iovec *iovec,
+				  u32 *pkt_data_remaining);
+};
+
+#define PINNING_MAX_INTERFACES BIT(HFI1_MEMINFO_TYPE_ENTRY_BITS)
+
+struct pinning_state {
+	void *interface[PINNING_MAX_INTERFACES];
+};
+
+#define PINNING_STATE(pq, i) ((pq)->pinning_state.interface[(i)])
+
+extern struct pinning_interface pinning_interfaces[PINNING_MAX_INTERFACES];
+
+void register_pinning_interface(unsigned int type,
+				struct pinning_interface *interface);
+void deregister_pinning_interface(unsigned int type);
+
+void register_system_pinning_interface(void);
+void deregister_system_pinning_interface(void);
+
+int init_pinning_interfaces(struct hfi1_user_sdma_pkt_q *pq);
+void free_pinning_interfaces(struct hfi1_user_sdma_pkt_q *pq);
+
+static inline bool pinning_type_supported(unsigned int type)
+{
+	return (type < PINNING_MAX_INTERFACES &&
+		pinning_interfaces[type].add_to_sdma_packet);
+}
+
+static inline int add_to_sdma_packet(unsigned int type,
+				     struct user_sdma_request *req,
+				     struct user_sdma_txreq *tx,
+				     struct user_sdma_iovec *iovec,
+				     u32 *pkt_data_remaining)
+{
+	return pinning_interfaces[type].add_to_sdma_packet(req, tx, iovec,
+							   pkt_data_remaining);
+}
+
+#endif /* _HFI1_PINNING_H */
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index 02bd62b857b7..ba26822cde19 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
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
+	ret = init_pinning_interfaces(pq);
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
+		free_pinning_interfaces(pq);
 		bitmap_free(pq->req_in_use);
 		kmem_cache_destroy(pq->txreq_cache);
 		flush_pq_iowait(pq);
@@ -308,6 +288,7 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 	u8 pcount = initial_pkt_count;
 	struct sdma_req_info info;
 	struct user_sdma_request *req;
+	size_t header_offset;
 	u8 opcode, sc, vl;
 	u16 pkey;
 	u32 slid;
@@ -392,8 +373,7 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 	if (req_opcode(info.ctrl) == EXPECTED) {
 		/* expected must have a TID info and at least one data vector */
 		if (req->data_iovs < 2) {
-			SDMA_DBG(req,
-				 "Not enough vectors for expected request");
+			SDMA_DBG(req, "Not enough vectors for expected request: 0x%x", info.ctrl);
 			ret = -EINVAL;
 			goto free_req;
 		}
@@ -407,8 +387,24 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 		goto free_req;
 	}
 
+	if (req_has_meminfo(info.ctrl)) {
+		/* Copy the meminfo from the user buffer */
+		ret = copy_from_user(&req->meminfo,
+				     iovec[idx].iov_base + sizeof(info),
+				     sizeof(req->meminfo));
+		if (ret) {
+			SDMA_DBG(req, "Failed to copy meminfo (%d)", ret);
+			ret = -EFAULT;
+			goto free_req;
+		}
+		header_offset = sizeof(info) + sizeof(req->meminfo);
+	} else {
+		req->meminfo.types = 0;
+		header_offset = sizeof(info);
+	}
+
 	/* Copy the header from the user buffer */
-	ret = copy_from_user(&req->hdr, iovec[idx].iov_base + sizeof(info),
+	ret = copy_from_user(&req->hdr, iovec[idx].iov_base + header_offset,
 			     sizeof(req->hdr));
 	if (ret) {
 		SDMA_DBG(req, "Failed to copy header template (%d)", ret);
@@ -448,6 +444,7 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 	slid = be16_to_cpu(req->hdr.lrh[3]);
 	if (egress_pkey_check(dd->pport, slid, pkey, sc, PKEY_CHECK_INVALID)) {
 		ret = -EINVAL;
+		SDMA_DBG(req, "P_KEY check failed\n");
 		goto free_req;
 	}
 
@@ -476,6 +473,16 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 
 	/* Save all the IO vector structures */
 	for (i = 0; i < req->data_iovs; i++) {
+		req->iovs[i].type =
+			HFI1_MEMINFO_TYPE_ENTRY_GET(req->meminfo.types, i);
+		if (!pinning_type_supported(req->iovs[i].type)) {
+			SDMA_DBG(req, "Pinning type not supported: %u\n",
+				 req->iovs[i].type);
+			req->data_iovs = i;
+			ret = -EINVAL;
+			goto free_req;
+		}
+		req->iovs[i].context = req->meminfo.context[i];
 		req->iovs[i].offset = 0;
 		INIT_LIST_HEAD(&req->iovs[i].list);
 		memcpy(&req->iovs[i].iov,
@@ -821,8 +828,8 @@ static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts)
 			req->tidoffset += datalen;
 		req->sent += datalen;
 		while (datalen) {
-			ret = add_system_pages_to_sdma_packet(req, tx, iovec,
-							      &datalen);
+			ret = add_to_sdma_packet(iovec->type, req, tx, iovec,
+						 &datalen);
 			if (ret)
 				goto free_txreq;
 			iovec = &req->iovs[req->iov_idx];
@@ -860,17 +867,6 @@ static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts)
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
@@ -1253,401 +1249,3 @@ static inline void set_comp_state(struct hfi1_user_sdma_pkt_q *pq,
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
index 548347d4c5bc..8e3289556518 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.h
+++ b/drivers/infiniband/hw/hfi1/user_sdma.h
@@ -13,9 +13,13 @@
 #include "iowait.h"
 #include "user_exp_rcv.h"
 #include "mmu_rb.h"
+#include "pinning.h"
+#include "sdma.h"
 
 /* The maximum number of Data io vectors per message/request */
 #define MAX_VECTORS_PER_REQ 8
+static_assert(MAX_VECTORS_PER_REQ <= HFI1_MAX_MEMINFO_ENTRIES);
+
 /*
  * Maximum number of packet to send from each message/request
  * before moving to the next one.
@@ -30,6 +34,8 @@
 	(((x) >> HFI1_SDMA_REQ_VERSION_SHIFT) & HFI1_SDMA_REQ_OPCODE_MASK)
 #define req_iovcnt(x) \
 	(((x) >> HFI1_SDMA_REQ_IOVCNT_SHIFT) & HFI1_SDMA_REQ_IOVCNT_MASK)
+#define req_has_meminfo(x) \
+	(((x) >> HFI1_SDMA_REQ_MEMINFO_SHIFT) & HFI1_SDMA_REQ_MEMINFO_MASK)
 
 /* Number of BTH.PSN bits used for sequence number in expected rcvs */
 #define BTH_SEQ_MASK 0x7ffull
@@ -92,7 +98,7 @@ struct hfi1_user_sdma_pkt_q {
 	enum pkt_q_sdma_state state;
 	wait_queue_head_t wait;
 	unsigned long unpinned;
-	struct mmu_rb_handler *handler;
+	struct pinning_state pinning_state;
 	atomic_t n_locked;
 };
 
@@ -111,6 +117,10 @@ struct sdma_mmu_node {
 struct user_sdma_iovec {
 	struct list_head list;
 	struct iovec iov;
+	/* memory type for this vector */
+	unsigned int type;
+	/* memory type context for this vector */
+	u64 context;
 	/*
 	 * offset into the virtual address space of the vector at
 	 * which we last left off.
@@ -128,6 +138,9 @@ struct user_sdma_request {
 	/* This is the original header from user space */
 	struct hfi1_pkt_header hdr;
 
+	/* Memory type information for each data iovec entry. */
+	struct sdma_req_meminfo meminfo;
+
 	/* Read mostly fields */
 	struct hfi1_user_sdma_pkt_q *pq ____cacheline_aligned_in_smp;
 	struct hfi1_user_sdma_comp_q *cq;
diff --git a/include/uapi/rdma/hfi/hfi1_user.h b/include/uapi/rdma/hfi/hfi1_user.h
index 1106a7c90b29..f79d3d03be86 100644
--- a/include/uapi/rdma/hfi/hfi1_user.h
+++ b/include/uapi/rdma/hfi/hfi1_user.h
@@ -192,14 +192,17 @@ enum sdma_req_opcode {
 #define HFI1_SDMA_REQ_VERSION_SHIFT 0x0
 #define HFI1_SDMA_REQ_OPCODE_MASK 0xF
 #define HFI1_SDMA_REQ_OPCODE_SHIFT 0x4
-#define HFI1_SDMA_REQ_IOVCNT_MASK 0xFF
+#define HFI1_SDMA_REQ_IOVCNT_MASK 0x7F
 #define HFI1_SDMA_REQ_IOVCNT_SHIFT 0x8
+#define HFI1_SDMA_REQ_MEMINFO_MASK 0x1
+#define HFI1_SDMA_REQ_MEMINFO_SHIFT 0xF
 
 struct sdma_req_info {
 	/*
 	 * bits 0-3 - version (currently unused)
 	 * bits 4-7 - opcode (enum sdma_req_opcode)
-	 * bits 8-15 - io vector count
+	 * bits 8-14 - io vector count
+	 * bit  15 - meminfo present
 	 */
 	__u16 ctrl;
 	/*
@@ -222,6 +225,30 @@ struct sdma_req_info {
 	__u16 comp_idx;
 } __attribute__((__packed__));
 
+#define HFI1_MEMINFO_TYPE_ENTRY_BITS 4
+#define HFI1_MEMINFO_TYPE_ENTRY_MASK ((1 << HFI1_MEMINFO_TYPE_ENTRY_BITS) - 1)
+#define HFI1_MEMINFO_TYPE_ENTRY_GET(m, n)              \
+	(((m) >> ((n) * HFI1_MEMINFO_TYPE_ENTRY_BITS)) & \
+	 HFI1_MEMINFO_TYPE_ENTRY_MASK)
+#define HFI1_MEMINFO_TYPE_ENTRY_SET(m, n, e)    \
+	((m) |= ((e) & HFI1_MEMINFO_TYPE_ENTRY_MASK) \
+	     << ((n) * HFI1_MEMINFO_TYPE_ENTRY_BITS))
+#define HFI1_MAX_MEMINFO_ENTRIES \
+	(sizeof(__u64) * 8 / HFI1_MEMINFO_TYPE_ENTRY_BITS)
+
+#define HFI1_MEMINFO_TYPE_SYSTEM 0
+
+struct sdma_req_meminfo {
+	/*
+	 * Packed memory type indicators for each data iovec entry.
+	 */
+	__u64 types;
+	/*
+	 * Type-specific context for each data iovec entry.
+	 */
+	__u64 context[HFI1_MAX_MEMINFO_ENTRIES];
+};
+
 /*
  * SW KDETH header.
  * swdata is SW defined portion.


