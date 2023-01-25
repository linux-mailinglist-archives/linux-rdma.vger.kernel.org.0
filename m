Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A0167BB8E
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jan 2023 21:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjAYUCF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Jan 2023 15:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbjAYUCE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Jan 2023 15:02:04 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2104.outbound.protection.outlook.com [40.107.237.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952DB3AAC
        for <linux-rdma@vger.kernel.org>; Wed, 25 Jan 2023 12:01:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evnJU53pZHGySKCMjrE5dqpsc9FiZI3fOmQRiWFreaJFVh9eUun6YLz8Qo/oxmYc56QHUTbeO3QR6Xo9ElybSHEC65o0FOFwjHJ7QTvsRmcj7x7LhOyz7TXldPO5mXRUaAWrg+3FjucJbdd+P1DFVZQodzHYu4v0ULNioB03ZH5tOrQu6+aDL8ujHVPvdzFF15tf+CJleGQFpLPn/Q7B7TS59MW+bKWSSnyyUrMjEgEHt3/DxZvHCD+qijILGMLIAeM0ztrq3i3h6T1Tg8jwlD1PS8lsnSrYHEgWYd7BNEnEfKB8t/2NefvoDe1UEzu6mM8BRECJMUzNME9NzoagvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NmxXR0rVEunyMO4I+pupTdqGYqBS6jOVhGBQOJzMdg=;
 b=muLVQViOTAQ4/ZnCxsDwJ95154qwzixl/wPSRURACQbvz3AwUiGtd5NwqLaEYi5h3OJb7dzsAAbYVB5gZgBHRTi8iX2FjzWaFJU7jr0PYnvex7/xCpHd2amMdbBRUPBez5FBTvdovprCj45LMSNUlKcsxsIR0dKdgTMjoGzzdD3iHqKxfW/M3x4bLjqI4VMk446wHYa676tBT1/3NvWvgvnsgiV2rtZm7YUYj06ECXnHz0byVLUmPoXNUFEb30TRrKgmWIixzaqkirUfa7sLTPrum6ApKfkIympZytgBCWk1GKuTtTFoEjPVEdae5ORTrsbfIerVXURGj4ZPCTv5+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NmxXR0rVEunyMO4I+pupTdqGYqBS6jOVhGBQOJzMdg=;
 b=TUQmZAA4fc/kvfNXBoFjPMvFeRYhSmIsNkpcqMur0DkLZoI4koSlsPBsqtxcWqO9l8mKk3q8AT0xxfl5/7Bw7NEIp/K5DClD35FPFKYnCpLG0XD1Ta1o60YPmsLyf+uvWT2P3W3/4n6+xifKMRu0lMB3tOs+imVZp0WhHZ2UcXVa77ugAP6qwvIWlYnFV+AU+T6soRYos5MrmB0jCgOLPqgAPaEapIHquVF7aAEyu7W6Unq+RSBfIpMf1nlP/Zugr38bX0mIjQ8WMrg4vN4KKZoDA4/zAk4ogJtQc2CDvQhG0eIpiZXFJEII2hjUh9vq1946hnzgD2IH/UiCXi4BlA==
Received: from MW4PR03CA0270.namprd03.prod.outlook.com (2603:10b6:303:b4::35)
 by BY3PR01MB6564.prod.exchangelabs.com (2603:10b6:a03:363::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.21; Wed, 25 Jan 2023 20:01:51 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::c8) by MW4PR03CA0270.outlook.office365.com
 (2603:10b6:303:b4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21 via Frontend
 Transport; Wed, 25 Jan 2023 20:01:51 +0000
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
 15.20.6043.17 via Frontend Transport; Wed, 25 Jan 2023 20:01:50 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 30PK1nXZ3649778;
        Wed, 25 Jan 2023 15:01:49 -0500
Subject: [PATCH for-next v2 3/3] IB/hfi1: Do all memory-pinning through hfi1's
 pinning interface
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Wed, 25 Jan 2023 15:01:49 -0500
Message-ID: <167467690923.3649436.11426965323185168102.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <167467667721.3649436.2151007723733044404.stgit@awfm-02.cornelisnetworks.com>
References: <167467667721.3649436.2151007723733044404.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|BY3PR01MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c9b8ce-55c7-42c7-a3c5-08daff0eff66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qfAcBgTsq2RHxULLXxgbCnkN9tJMjeXEni6wMFNszo5JFDc0uLpPeg6NF6rT5bbHSEBqEYZfxMvXHh72ylj/yqvsBegjdkFhefc0w9kavNZH1qD+DkytlZW6dTFDfWlkkM0Twq2uEmnY5XquGlyfM7Ukuj3gB0AcTcst0qz7ZBybFfYkHlTR/TuGeanvGlIfqAc3Hn2+wAykkw84lCEUIZwrUCxavamIRvyf/RJ21Iw98idgA3LuXs5en90vTdZR0/obtS+ycSol+UQhjo9f0jI/78qava+NrlZ/gb1XItuT8mwZJjzc7iH8BXtMGaKpXMgUrv8+iy+SEEnxqrssBDaLl07C3U5O3lu7SSak6M+Hp7fBSH8rHk9YAJDN1AB+Ozh/rC5Ju7JV4RsFK1kinnBwO7LsqgS4eNX6y+uDtCwn6HiFSACwt0R42oIsnMeikLXThLuRvL6DcxTrgLM15OCSGHtozQlx9RyOZNI805nNx+655Cdhd+BbrxYacL3BoB2JmC3ZB/Geqg7UF0L1LkesS6xOzDBz4JmsNXLeVESF+HM2j/zUWTShsf/3HkC/4R3LGtdoPSyogvRI4G1bto3EW7SqxcbU80ffXdDCTwUVqf2l9zTbbkxyfHZSpMBFhnwZQ7Tk/rv7wgsCbTeNizQ5m0Nx6AqRIovbCLPGds5Y51UGbLOyvBxRDWzNaj6DQBcSgrztEIPkwpCMDILu2g==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(39840400004)(136003)(451199018)(46966006)(36840700001)(5660300002)(186003)(2906002)(70206006)(70586007)(8676002)(8936002)(41300700001)(4326008)(83380400001)(7696005)(478600001)(336012)(426003)(26005)(7126003)(30864003)(82310400005)(316002)(47076005)(44832011)(54906003)(356005)(81166007)(103116003)(86362001)(40480700001)(55016003)(36860700001)(36900700001)(559001)(579004);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 20:01:50.4169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c9b8ce-55c7-42c7-a3c5-08daff0eff66
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6564
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>

Modify hfi1 memory pinning so all hfi1 memory pinning operations go
through hfi1's internal pinning interface. This allows hfi1 to maintain
a pin-cache for DMA operations without knowing the actual pinned memory
type.

The pin cache stats ioctl has been updated to support multiple cache
instances per (memory type, pkt queue), as well as to distinguish
between evictions originating in the corresponding HFI pin cache
backend and those originating elsewhere in the system (mmu notifier,
GPU vendor drivers, etc...).

Signed-off-by: Brendan Cunningham <bcunningham@cornelisnetworks.com>
Signed-off-by: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/Makefile     |    2 
 drivers/infiniband/hw/hfi1/file_ops.c   |   51 +++
 drivers/infiniband/hw/hfi1/init.c       |    5 
 drivers/infiniband/hw/hfi1/ipoib_tx.c   |    7 
 drivers/infiniband/hw/hfi1/mmu_rb.c     |   96 ++---
 drivers/infiniband/hw/hfi1/mmu_rb.h     |   30 +-
 drivers/infiniband/hw/hfi1/pin_system.c |  567 +++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi1/pinning.c    |   55 +++
 drivers/infiniband/hw/hfi1/pinning.h    |   94 +++++
 drivers/infiniband/hw/hfi1/sdma.c       |   29 --
 drivers/infiniband/hw/hfi1/sdma.h       |   62 +--
 drivers/infiniband/hw/hfi1/sdma_txreq.h |    2 
 drivers/infiniband/hw/hfi1/trace_mmu.h  |    4 
 drivers/infiniband/hw/hfi1/user_sdma.c  |  354 +++----------------
 drivers/infiniband/hw/hfi1/user_sdma.h  |   24 +
 drivers/infiniband/hw/hfi1/verbs.c      |    5 
 drivers/infiniband/hw/hfi1/vnic_sdma.c  |    6 
 include/uapi/rdma/hfi/hfi1_ioctl.h      |   18 +
 include/uapi/rdma/hfi/hfi1_user.h       |   31 ++
 include/uapi/rdma/rdma_user_ioctl.h     |    3 
 20 files changed, 997 insertions(+), 448 deletions(-)
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
diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index 06c71b6d8a38..fbc19671b547 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -22,6 +22,7 @@
 #include "user_sdma.h"
 #include "user_exp_rcv.h"
 #include "aspm.h"
+#include "pinning.h"
 
 #undef pr_fmt
 #define pr_fmt(fmt) DRIVER_NAME ": " fmt
@@ -73,6 +74,8 @@ static int manage_rcvq(struct hfi1_ctxtdata *uctxt, u16 subctxt,
 static vm_fault_t vma_fault(struct vm_fault *vmf);
 static long hfi1_file_ioctl(struct file *fp, unsigned int cmd,
 			    unsigned long arg);
+static int get_pinning_stats(struct hfi1_filedata *fd, unsigned long arg,
+			     u32 len);
 
 static const struct file_operations hfi1_file_ops = {
 	.owner = THIS_MODULE,
@@ -248,7 +251,9 @@ static long hfi1_file_ioctl(struct file *fp, unsigned int cmd,
 		if (put_user(uval, (int __user *)arg))
 			return -EFAULT;
 		break;
-
+	case HFI1_IOCTL_PIN_STATS:
+		ret = get_pinning_stats(fd, arg, _IOC_SIZE(cmd));
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1711,3 +1716,47 @@ void hfi1_device_remove(struct hfi1_devdata *dd)
 {
 	user_remove(dd);
 }
+
+static int get_pinning_stats(struct hfi1_filedata *fd, unsigned long arg,
+			     u32 len)
+{
+	struct hfi1_pin_stats stats;
+	unsigned int memtype;
+	int index;
+	int ret;
+	struct hfi1_user_sdma_pkt_q *pq;
+	int lockidx;
+
+	if (sizeof(stats) != len)
+		return -EINVAL;
+
+	if (copy_from_user(&stats, (void __user *)arg, len))
+		return -EFAULT;
+
+	if (!pinning_type_supported(stats.memtype))
+		return -EINVAL;
+
+	memtype = stats.memtype;
+	index = stats.index;
+	memset(&stats, 0, sizeof(stats));
+	stats.memtype = memtype;
+	stats.index = index;
+
+	lockidx = srcu_read_lock(&fd->pq_srcu);
+	pq = srcu_dereference(fd->pq, &fd->pq_srcu);
+	if (!pq) {
+		srcu_read_unlock(&fd->pq_srcu, lockidx);
+		return -EIO;
+	}
+
+	ret = pinning_interfaces[memtype].get_stats(pq, index, &stats);
+	srcu_read_unlock(&fd->pq_srcu, lockidx);
+
+	if (ret)
+		return ret;
+
+	if (copy_to_user((void __user *)arg, &stats, len))
+		return -EFAULT;
+
+	return 0;
+}
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 62b6c5020039..cab12407049d 100644
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
diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index 5d9a7b09ca37..dc2e0bb65a06 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -214,11 +214,8 @@ static int hfi1_ipoib_build_ulp_payload(struct ipoib_txreq *tx,
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
-		ret = sdma_txadd_page(dd,
-				      txreq,
-				      skb_frag_page(frag),
-				      frag->bv_offset,
-				      skb_frag_size(frag));
+		ret = sdma_txadd_page(dd, NULL, txreq, skb_frag_page(frag),
+				      frag->bv_offset, skb_frag_size(frag));
 		if (unlikely(ret))
 			break;
 	}
diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
index 7333646021bb..8617024d9cf8 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.c
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
@@ -46,12 +46,14 @@ int hfi1_mmu_rb_register(void *ops_arg,
 			 struct mmu_rb_handler **handler)
 {
 	struct mmu_rb_handler *h;
+	void *free_ptr;
 	int ret;
 
-	h = kzalloc(sizeof(*h), GFP_KERNEL);
-	if (!h)
+	free_ptr = kzalloc(sizeof(*h) + cache_line_size() - 1, GFP_KERNEL);
+	if (!free_ptr)
 		return -ENOMEM;
 
+	h = PTR_ALIGN(free_ptr, cache_line_size());
 	h->root = RB_ROOT_CACHED;
 	h->ops = ops;
 	h->ops_arg = ops_arg;
@@ -62,10 +64,11 @@ int hfi1_mmu_rb_register(void *ops_arg,
 	INIT_LIST_HEAD(&h->del_list);
 	INIT_LIST_HEAD(&h->lru_list);
 	h->wq = wq;
+	h->free_ptr = free_ptr;
 
 	ret = mmu_notifier_register(&h->mn, current->mm);
 	if (ret) {
-		kfree(h);
+		kfree(free_ptr);
 		return ret;
 	}
 
@@ -108,7 +111,7 @@ void hfi1_mmu_rb_unregister(struct mmu_rb_handler *handler)
 	/* Now the mm may be freed. */
 	mmdrop(handler->mn.mm);
 
-	kfree(handler);
+	kfree(handler->free_ptr);
 }
 
 int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
@@ -126,11 +129,11 @@ int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
 	spin_lock_irqsave(&handler->lock, flags);
 	node = __mmu_rb_search(handler, mnode->addr, mnode->len);
 	if (node) {
-		ret = -EINVAL;
+		ret = -EEXIST;
 		goto unlock;
 	}
 	__mmu_int_rb_insert(mnode, &handler->root);
-	list_add(&mnode->list, &handler->lru_list);
+	list_add_tail(&mnode->list, &handler->lru_list);
 
 	ret = handler->ops->insert(handler->ops_arg, mnode);
 	if (ret) {
@@ -143,6 +146,19 @@ int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
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
@@ -167,32 +183,6 @@ static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *handler,
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
-		if (node->addr == addr && node->len == len)
-			goto unlock;
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
@@ -206,47 +196,42 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 	INIT_LIST_HEAD(&del_list);
 
 	spin_lock_irqsave(&handler->lock, flags);
-	list_for_each_entry_safe_reverse(rbnode, ptr, &handler->lru_list,
-					 list) {
+	list_for_each_entry_safe(rbnode, ptr, &handler->lru_list, list) {
 		if (handler->ops->evict(handler->ops_arg, rbnode, evict_arg,
 					&stop)) {
 			__mmu_int_rb_remove(rbnode, &handler->root);
 			/* move from LRU list to delete list */
 			list_move(&rbnode->list, &del_list);
+			++handler->internal_evictions;
 		}
 		if (stop)
 			break;
 	}
 	spin_unlock_irqrestore(&handler->lock, flags);
 
-	while (!list_empty(&del_list)) {
-		rbnode = list_first_entry(&del_list, struct mmu_rb_node, list);
-		list_del(&rbnode->list);
+	list_for_each_entry_safe(rbnode, ptr, &del_list, list) {
 		handler->ops->remove(handler->ops_arg, rbnode);
 	}
 }
 
-/*
- * It is up to the caller to ensure that this function does not race with the
- * mmu invalidate notifier which may be calling the users remove callback on
- * 'node'.
- */
-void hfi1_mmu_rb_remove(struct mmu_rb_handler *handler,
-			struct mmu_rb_node *node)
+unsigned long hfi1_mmu_rb_for_n(struct mmu_rb_handler *handler,
+				unsigned long start, int count,
+				void (*fn)(const struct mmu_rb_node *rb_node, void *),
+				void *arg)
 {
-	unsigned long flags;
-
-	if (current->mm != handler->mn.mm)
-		return;
+	struct mmu_rb_node *node = NULL, *next;
+	int i;
 
-	/* Validity of handler and node pointers has been checked by caller. */
-	trace_hfi1_mmu_rb_remove(node->addr, node->len);
-	spin_lock_irqsave(&handler->lock, flags);
-	__mmu_int_rb_remove(node, &handler->root);
-	list_del(&node->list); /* remove from LRU list */
-	spin_unlock_irqrestore(&handler->lock, flags);
+	next = __mmu_int_rb_iter_first(&handler->root, start, ~0ULL - start);
+	for (i = 0; i < count; i++) {
+		node = next;
+		if (!node)
+			return ~0UL;
 
-	handler->ops->remove(handler->ops_arg, node);
+		next = __mmu_int_rb_iter_next(node, start + node->len, ~0ULL);
+		fn(node, arg);
+	}
+	return node->addr;
 }
 
 static int mmu_notifier_range_start(struct mmu_notifier *mn,
@@ -269,6 +254,7 @@ static int mmu_notifier_range_start(struct mmu_notifier *mn,
 		if (handler->ops->invalidate(handler->ops_arg, node)) {
 			__mmu_int_rb_remove(node, root);
 			/* move from LRU list to delete list */
+			handler->external_evictions++;
 			list_move(&node->list, &handler->del_list);
 			added = true;
 		}
diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.h b/drivers/infiniband/hw/hfi1/mmu_rb.h
index 7417be2b9dc8..508a7a7c568a 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.h
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.h
@@ -33,15 +33,29 @@ struct mmu_rb_ops {
 };
 
 struct mmu_rb_handler {
+	/*
+	 * struct mmu_notifier is 56 bytes, and spinlock_t is 4 bytes, so
+	 * they fit together in one cache line.  mn is relatively rarely
+	 * accessed, so co-locating the spinlock with it achieves much of
+	 * the cacheline contention reduction of giving the spinlock its own
+	 * cacheline without the overhead of doing so.
+	 */
 	struct mmu_notifier mn;
-	struct rb_root_cached root;
-	void *ops_arg;
 	spinlock_t lock;        /* protect the RB tree */
+
+	/* Begin on a new cachline boundary here */
+	struct rb_root_cached root ____cacheline_aligned_in_smp;
+	void *ops_arg;
 	struct mmu_rb_ops *ops;
 	struct list_head lru_list;
 	struct work_struct del_work;
 	struct list_head del_list;
 	struct workqueue_struct *wq;
+	size_t hits;
+	size_t misses;
+	size_t internal_evictions;
+	size_t external_evictions;
+	void *free_ptr;
 };
 
 int hfi1_mmu_rb_register(void *ops_arg,
@@ -52,10 +66,12 @@ void hfi1_mmu_rb_unregister(struct mmu_rb_handler *handler);
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
+unsigned long hfi1_mmu_rb_for_n(struct mmu_rb_handler *handler,
+				unsigned long start, int count,
+				void (*fn)(const struct mmu_rb_node *rb_node, void *),
+				void *arg);
 
 #endif /* _HFI1_MMU_RB_H */
diff --git a/drivers/infiniband/hw/hfi1/pin_system.c b/drivers/infiniband/hw/hfi1/pin_system.c
new file mode 100644
index 000000000000..ab8d4a24b644
--- /dev/null
+++ b/drivers/infiniband/hw/hfi1/pin_system.c
@@ -0,0 +1,567 @@
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
+static int sdma_rb_insert(void *arg, struct mmu_rb_node *mnode);
+static int sdma_rb_evict(void *arg, struct mmu_rb_node *mnode, void *arg2,
+			 bool *stop);
+static void sdma_rb_remove(void *arg, struct mmu_rb_node *mnode);
+static int sdma_rb_invalidate(void *arg, struct mmu_rb_node *mnode);
+
+static struct mmu_rb_ops sdma_rb_ops = { .filter = sdma_rb_filter,
+					 .insert = sdma_rb_insert,
+					 .evict = sdma_rb_evict,
+					 .remove = sdma_rb_remove,
+					 .invalidate = sdma_rb_invalidate };
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
+		handler->misses++;
+		spin_unlock_irqrestore(&handler->lock, flags);
+		return NULL;
+	}
+	handler->hits++;
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
+	struct mmu_rb_handler *handler =
+		PINNING_STATE(req->pq, HFI1_MEMINFO_TYPE_SYSTEM);
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
+static void system_descriptor_complete(struct hfi1_devdata *dd,
+				       struct sdma_desc *descp)
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
+static void add_system_stats(const struct mmu_rb_node *rb_node, void *arg)
+{
+	struct sdma_mmu_node *node =
+		container_of(rb_node, struct sdma_mmu_node, rb);
+	struct hfi1_pin_stats *stats = arg;
+
+	stats->cache_entries++;
+	stats->total_refcounts += atomic_read(&node->refcount);
+	stats->total_bytes += node->rb.len;
+}
+
+static int get_system_stats(struct hfi1_user_sdma_pkt_q *pq, int index,
+			    struct hfi1_pin_stats *stats)
+{
+	struct mmu_rb_handler *handler =
+		PINNING_STATE(pq, HFI1_MEMINFO_TYPE_SYSTEM);
+	unsigned long next = 0;
+
+	if (index == -1) {
+		stats->index = 1;
+		return 0;
+	}
+
+	if (index != 0)
+		return -EINVAL;
+
+	stats->id = 0;
+	while (next != ~0UL) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&handler->lock, flags);
+		/* Take stats on 100 nodes at a time.
+		 * This is a balance between time/cost of the operation and
+		 * the latency of other operations waiting for the lock.
+		 */
+		next = hfi1_mmu_rb_for_n(handler, next, 100, add_system_stats,
+					 stats);
+		spin_unlock_irqrestore(&handler->lock, flags);
+		/* This is to allow the lock to be acquired from other places. */
+		ndelay(100);
+	}
+
+	stats->hits = handler->hits;
+	stats->misses = handler->misses;
+	stats->internal_evictions = handler->internal_evictions;
+	stats->external_evictions = handler->external_evictions;
+
+	return 0;
+};
+
+static struct pinning_interface system_pinning_interface = {
+	.init = init_system_pinning_interface,
+	.free = free_system_pinning_interface,
+	.add_to_sdma_packet = add_system_pages_to_sdma_packet,
+	.descriptor_complete = system_descriptor_complete,
+	.get_stats = get_system_stats,
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
+static int sdma_rb_insert(void *arg, struct mmu_rb_node *mnode)
+{
+	struct sdma_mmu_node *node =
+		container_of(mnode, struct sdma_mmu_node, rb);
+
+	atomic_inc(&node->refcount);
+	return 0;
+}
+
+/*
+ * Return 1 to remove the node from the rb tree and call the remove op.
+ *
+ * Called with the rb tree lock held.
+ */
+static int sdma_rb_evict(void *arg, struct mmu_rb_node *mnode, void *evict_arg,
+			 bool *stop)
+{
+	struct sdma_mmu_node *node =
+		container_of(mnode, struct sdma_mmu_node, rb);
+	struct evict_data *evict_data = evict_arg;
+
+	/* is this node still being used? */
+	if (atomic_read(&node->refcount))
+		return 0; /* keep this node */
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
+
+static int sdma_rb_invalidate(void *arg, struct mmu_rb_node *mnode)
+{
+	struct sdma_mmu_node *node =
+		container_of(mnode, struct sdma_mmu_node, rb);
+
+	if (!atomic_read(&node->refcount))
+		return 1;
+	return 0;
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
index 000000000000..0932eb63c2d8
--- /dev/null
+++ b/drivers/infiniband/hw/hfi1/pinning.h
@@ -0,0 +1,94 @@
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
+
+	/*
+	 * At completion of a txreq, this is invoked for each descriptor.
+	 */
+	void (*descriptor_complete)(struct hfi1_devdata *dd,
+				    struct sdma_desc *descp);
+	int (*get_stats)(struct hfi1_user_sdma_pkt_q *pq, int index,
+			 struct hfi1_pin_stats *stats);
+};
+
+#define PINNING_MAX_INTERFACES (1 << HFI1_MEMINFO_TYPE_ENTRY_BITS)
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
+void register_dmabuf_pinning_interface(void);
+void deregister_dmabuf_pinning_interface(void);
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
+static inline void sdma_descriptor_complete(unsigned int type,
+					    struct hfi1_devdata *dd,
+					    struct sdma_desc *descp)
+{
+	pinning_interfaces[type].descriptor_complete(dd, descp);
+}
+
+void release_sdma_request_pages(struct user_sdma_request *req, bool unpin);
+
+#endif /* _HFI1_PINNING_H */
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 8ed20392e9f0..38d4e69df71e 100644
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
+	sdma_descriptor_complete(descp->mem_type, dd, descp);
 }
 
 /*
@@ -3128,7 +3113,8 @@ int ext_coal_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx,
 
 		/* Add descriptor for coalesce buffer */
 		tx->desc_limit = MAX_DESC;
-		return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, tx,
+		return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE,
+					 HFI1_MEMINFO_TYPE_SYSTEM, NULL, tx,
 					 addr, tx->tlen);
 	}
 
@@ -3167,12 +3153,11 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 			return rval;
 		}
 	}
+
 	/* finish the one just added */
-	make_tx_sdma_desc(
-		tx,
-		SDMA_MAP_NONE,
-		dd->sdma_pad_phys,
-		sizeof(u32) - (tx->packet_len & (sizeof(u32) - 1)));
+	make_tx_sdma_desc(tx, SDMA_MAP_NONE, HFI1_MEMINFO_TYPE_SYSTEM, NULL,
+			  dd->sdma_pad_phys,
+			  sizeof(u32) - (tx->packet_len & (sizeof(u32) - 1)));
 	tx->num_desc++;
 	_sdma_close_tx(dd, tx);
 	return rval;
diff --git a/drivers/infiniband/hw/hfi1/sdma.h b/drivers/infiniband/hw/hfi1/sdma.h
index b023fc461bd5..45266b14d327 100644
--- a/drivers/infiniband/hw/hfi1/sdma.h
+++ b/drivers/infiniband/hw/hfi1/sdma.h
@@ -591,27 +591,27 @@ static inline dma_addr_t sdma_mapping_addr(struct sdma_desc *d)
 		>> SDMA_DESC0_PHY_ADDR_SHIFT;
 }
 
-static inline void make_tx_sdma_desc(
-	struct sdma_txreq *tx,
-	int type,
-	dma_addr_t addr,
-	size_t len)
+static inline void make_tx_sdma_desc(struct sdma_txreq *tx, int map_type,
+				     int mem_type, void *pinning_ctx,
+				     dma_addr_t addr, size_t len)
 {
 	struct sdma_desc *desc = &tx->descp[tx->num_desc];
 
 	if (!tx->num_desc) {
 		/* qw[0] zero; qw[1] first, ahg mode already in from init */
-		desc->qw[1] |= ((u64)type & SDMA_DESC1_GENERATION_MASK)
-				<< SDMA_DESC1_GENERATION_SHIFT;
+		desc->qw[1] |= ((u64)map_type & SDMA_DESC1_GENERATION_MASK)
+			       << SDMA_DESC1_GENERATION_SHIFT;
 	} else {
 		desc->qw[0] = 0;
-		desc->qw[1] = ((u64)type & SDMA_DESC1_GENERATION_MASK)
-				<< SDMA_DESC1_GENERATION_SHIFT;
+		desc->qw[1] = ((u64)map_type & SDMA_DESC1_GENERATION_MASK)
+			      << SDMA_DESC1_GENERATION_SHIFT;
 	}
 	desc->qw[0] |= (((u64)addr & SDMA_DESC0_PHY_ADDR_MASK)
 				<< SDMA_DESC0_PHY_ADDR_SHIFT) |
 			(((u64)len & SDMA_DESC0_BYTE_COUNT_MASK)
 				<< SDMA_DESC0_BYTE_COUNT_SHIFT);
+	desc->mem_type = mem_type;
+	desc->pinning_ctx = pinning_ctx;
 }
 
 /* helper to extend txreq */
@@ -640,19 +640,14 @@ static inline void _sdma_close_tx(struct hfi1_devdata *dd,
 					       SDMA_DESC1_INT_REQ_FLAG);
 }
 
-static inline int _sdma_txadd_daddr(
-	struct hfi1_devdata *dd,
-	int type,
-	struct sdma_txreq *tx,
-	dma_addr_t addr,
-	u16 len)
+static inline int _sdma_txadd_daddr(struct hfi1_devdata *dd, int map_type,
+				    int mem_type, void *pinning_ctx,
+				    struct sdma_txreq *tx, dma_addr_t addr,
+				    u16 len)
 {
 	int rval = 0;
 
-	make_tx_sdma_desc(
-		tx,
-		type,
-		addr, len);
+	make_tx_sdma_desc(tx, map_type, mem_type, pinning_ctx, addr, len);
 	WARN_ON(len > tx->tlen);
 	tx->num_desc++;
 	tx->tlen -= len;
@@ -672,6 +667,7 @@ static inline int _sdma_txadd_daddr(
 /**
  * sdma_txadd_page() - add a page to the sdma_txreq
  * @dd: the device to use for mapping
+ * @pinning_ctx: supplied to pinning interface at descriptor retirement
  * @tx: tx request to which the page is added
  * @page: page to map
  * @offset: offset within the page
@@ -685,12 +681,9 @@ static inline int _sdma_txadd_daddr(
  * 0 - success, -ENOSPC - mapping fail, -ENOMEM - couldn't
  * extend/coalesce descriptor array
  */
-static inline int sdma_txadd_page(
-	struct hfi1_devdata *dd,
-	struct sdma_txreq *tx,
-	struct page *page,
-	unsigned long offset,
-	u16 len)
+static inline int sdma_txadd_page(struct hfi1_devdata *dd, void *pinning_ctx,
+				  struct sdma_txreq *tx, struct page *page,
+				  unsigned long offset, u16 len)
 {
 	dma_addr_t addr;
 	int rval;
@@ -714,8 +707,8 @@ static inline int sdma_txadd_page(
 		return -ENOSPC;
 	}
 
-	return _sdma_txadd_daddr(
-			dd, SDMA_MAP_PAGE, tx, addr, len);
+	return _sdma_txadd_daddr(dd, SDMA_MAP_PAGE, HFI1_MEMINFO_TYPE_SYSTEM,
+				 pinning_ctx, tx, addr, len);
 }
 
 /**
@@ -734,11 +727,9 @@ static inline int sdma_txadd_page(
  * 0 - success, -ENOMEM - couldn't extend descriptor array
  */
 
-static inline int sdma_txadd_daddr(
-	struct hfi1_devdata *dd,
-	struct sdma_txreq *tx,
-	dma_addr_t addr,
-	u16 len)
+static inline int sdma_txadd_daddr(struct hfi1_devdata *dd, int mem_type,
+				   void *pinning_ctx, struct sdma_txreq *tx,
+				   dma_addr_t addr, u16 len)
 {
 	int rval;
 
@@ -749,7 +740,8 @@ static inline int sdma_txadd_daddr(
 			return rval;
 	}
 
-	return _sdma_txadd_daddr(dd, SDMA_MAP_NONE, tx, addr, len);
+	return _sdma_txadd_daddr(dd, SDMA_MAP_NONE, mem_type, pinning_ctx, tx,
+				 addr, len);
 }
 
 /**
@@ -795,8 +787,8 @@ static inline int sdma_txadd_kvaddr(
 		return -ENOSPC;
 	}
 
-	return _sdma_txadd_daddr(
-			dd, SDMA_MAP_SINGLE, tx, addr, len);
+	return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, HFI1_MEMINFO_TYPE_SYSTEM,
+				 NULL, tx, addr, len);
 }
 
 struct iowait_work;
diff --git a/drivers/infiniband/hw/hfi1/sdma_txreq.h b/drivers/infiniband/hw/hfi1/sdma_txreq.h
index e262fb5c5ec6..6cbb3f6966b1 100644
--- a/drivers/infiniband/hw/hfi1/sdma_txreq.h
+++ b/drivers/infiniband/hw/hfi1/sdma_txreq.h
@@ -19,6 +19,8 @@
 struct sdma_desc {
 	/* private:  don't use directly */
 	u64 qw[2];
+	u8 mem_type;
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
index a71c5a36ceba..54d73edb4597 100644
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
@@ -65,21 +60,6 @@ static int defer_packet_queue(
 	uint seq,
 	bool pkts_sent);
 static void activate_packet_queue(struct iowait *wait, int reason);
-static bool sdma_rb_filter(struct mmu_rb_node *node, unsigned long addr,
-			   unsigned long len);
-static int sdma_rb_insert(void *arg, struct mmu_rb_node *mnode);
-static int sdma_rb_evict(void *arg, struct mmu_rb_node *mnode,
-			 void *arg2, bool *stop);
-static void sdma_rb_remove(void *arg, struct mmu_rb_node *mnode);
-static int sdma_rb_invalidate(void *arg, struct mmu_rb_node *mnode);
-
-static struct mmu_rb_ops sdma_rb_ops = {
-	.filter = sdma_rb_filter,
-	.insert = sdma_rb_insert,
-	.evict = sdma_rb_evict,
-	.remove = sdma_rb_remove,
-	.invalidate = sdma_rb_invalidate
-};
 
 static int defer_packet_queue(
 	struct sdma_engine *sde,
@@ -189,12 +169,9 @@ int hfi1_user_sdma_alloc_queues(struct hfi1_ctxtdata *uctxt,
 
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
@@ -247,14 +224,13 @@ int hfi1_user_sdma_free_queues(struct hfi1_filedata *fd,
 		spin_unlock(&fd->pq_rcu_lock);
 		synchronize_srcu(&fd->pq_srcu);
 		/* at this point there can be no more new requests */
-		if (pq->handler)
-			hfi1_mmu_rb_unregister(pq->handler);
 		iowait_sdma_drain(&pq->busy);
 		/* Wait until all requests have been freed. */
 		wait_event_interruptible(
 			pq->wait,
 			!atomic_read(&pq->n_reqs));
 		kfree(pq->reqs);
+		free_pinning_interfaces(pq);
 		bitmap_free(pq->req_in_use);
 		kmem_cache_destroy(pq->txreq_cache);
 		flush_pq_iowait(pq);
@@ -312,6 +288,7 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 	u8 pcount = initial_pkt_count;
 	struct sdma_req_info info;
 	struct user_sdma_request *req;
+	size_t header_offset;
 	u8 opcode, sc, vl;
 	u16 pkey;
 	u32 slid;
@@ -396,8 +373,7 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 	if (req_opcode(info.ctrl) == EXPECTED) {
 		/* expected must have a TID info and at least one data vector */
 		if (req->data_iovs < 2) {
-			SDMA_DBG(req,
-				 "Not enough vectors for expected request");
+			SDMA_DBG(req, "Not enough vectors for expected request: 0x%x", info.ctrl);
 			ret = -EINVAL;
 			goto free_req;
 		}
@@ -410,8 +386,25 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 		ret = -EINVAL;
 		goto free_req;
 	}
+
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
@@ -451,6 +444,7 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 	slid = be16_to_cpu(req->hdr.lrh[3]);
 	if (egress_pkey_check(dd->pport, slid, pkey, sc, PKEY_CHECK_INVALID)) {
 		ret = -EINVAL;
+		SDMA_DBG(req, "P_KEY check failed\n");
 		goto free_req;
 	}
 
@@ -479,14 +473,23 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 
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
@@ -584,7 +587,7 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 		if (req->seqsubmitted)
 			wait_event(pq->busy.wait_dma,
 				   (req->seqcomp == req->seqsubmitted - 1));
-		user_sdma_free_request(req, true);
+		user_sdma_free_request(req);
 		pq_update(pq);
 		set_comp_state(pq, cq, info.comp_idx, ERROR, ret);
 	}
@@ -696,48 +699,6 @@ static int user_sdma_txadd_ahg(struct user_sdma_request *req,
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
@@ -769,8 +730,7 @@ static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts)
 		maxpkts = req->info.npkts - req->seqnum;
 
 	while (npkts < maxpkts) {
-		u32 datalen = 0, queued = 0, data_sent = 0;
-		u64 iov_offset = 0;
+		u32 datalen = 0;
 
 		/*
 		 * Check whether any of the completions have come back
@@ -863,27 +823,17 @@ static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts)
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
+			ret = add_to_sdma_packet(iovec->type, req, tx, iovec,
+						 &datalen);
+			if (ret)
+				goto free_txreq;
+			iovec = &req->iovs[req->iov_idx];
+		}
 		list_add_tail(&tx->txreq.list, &req->txps);
 		/*
 		 * It is important to increment this here as it is used to
@@ -917,136 +867,6 @@ static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts)
 	return ret;
 }
 
-static u32 sdma_cache_evict(struct hfi1_user_sdma_pkt_q *pq, u32 npages)
-{
-	struct evict_data evict_data;
-
-	evict_data.cleared = 0;
-	evict_data.target = npages;
-	hfi1_mmu_rb_evict(pq->handler, &evict_data);
-	return evict_data.cleared;
-}
-
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
@@ -1388,7 +1208,7 @@ static void user_sdma_txreq_cb(struct sdma_txreq *txreq, int status)
 	if (req->seqcomp != req->info.npkts - 1)
 		return;
 
-	user_sdma_free_request(req, false);
+	user_sdma_free_request(req);
 	set_comp_state(pq, cq, req->info.comp_idx, state, status);
 	pq_update(pq);
 }
@@ -1399,10 +1219,8 @@ static inline void pq_update(struct hfi1_user_sdma_pkt_q *pq)
 		wake_up(&pq->wait);
 }
 
-static void user_sdma_free_request(struct user_sdma_request *req, bool unpin)
+static void user_sdma_free_request(struct user_sdma_request *req)
 {
-	int i;
-
 	if (!list_empty(&req->txps)) {
 		struct sdma_txreq *t, *p;
 
@@ -1415,21 +1233,6 @@ static void user_sdma_free_request(struct user_sdma_request *req, bool unpin)
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
@@ -1447,62 +1250,3 @@ static inline void set_comp_state(struct hfi1_user_sdma_pkt_q *pq,
 					idx, state, ret);
 }
 
-static bool sdma_rb_filter(struct mmu_rb_node *node, unsigned long addr,
-			   unsigned long len)
-{
-	return (bool)(node->addr == addr);
-}
-
-static int sdma_rb_insert(void *arg, struct mmu_rb_node *mnode)
-{
-	struct sdma_mmu_node *node =
-		container_of(mnode, struct sdma_mmu_node, rb);
-
-	atomic_inc(&node->refcount);
-	return 0;
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
-	/* is this node still being used? */
-	if (atomic_read(&node->refcount))
-		return 0; /* keep this node */
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
-	unpin_sdma_pages(node);
-	kfree(node);
-}
-
-static int sdma_rb_invalidate(void *arg, struct mmu_rb_node *mnode)
-{
-	struct sdma_mmu_node *node =
-		container_of(mnode, struct sdma_mmu_node, rb);
-
-	if (!atomic_read(&node->refcount))
-		return 1;
-	return 0;
-}
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.h b/drivers/infiniband/hw/hfi1/user_sdma.h
index ea56eb57e656..fc0b0bae0dc3 100644
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
@@ -78,6 +84,10 @@ enum pkt_q_sdma_state {
 		 (req)->pq->ctxt, (req)->pq->subctxt, (req)->info.comp_idx, \
 		 ##__VA_ARGS__)
 
+#define SDMA_PQ_DBG(pq, fmt, ...)                                      \
+	hfi1_cdbg(SDMA, "[%u:%u:%u] " fmt, (pq)->dd->unit, (pq)->ctxt, \
+		  (pq)->subctxt, ##__VA_ARGS__)
+
 struct hfi1_user_sdma_pkt_q {
 	u16 ctxt;
 	u16 subctxt;
@@ -92,7 +102,7 @@ struct hfi1_user_sdma_pkt_q {
 	enum pkt_q_sdma_state state;
 	wait_queue_head_t wait;
 	unsigned long unpinned;
-	struct mmu_rb_handler *handler;
+	struct pinning_state pinning_state;
 	atomic_t n_locked;
 };
 
@@ -112,16 +122,15 @@ struct sdma_mmu_node {
 struct user_sdma_iovec {
 	struct list_head list;
 	struct iovec iov;
-	/* number of pages in this vector */
-	unsigned int npages;
-	/* array of pinned pages for this vector */
-	struct page **pages;
+	/* memory type for this vector */
+	unsigned int type;
+	/* memory type context for this vector */
+	u64 context;
 	/*
 	 * offset into the virtual address space of the vector at
 	 * which we last left off.
 	 */
 	u64 offset;
-	struct sdma_mmu_node *node;
 };
 
 /* evict operation argument */
@@ -134,6 +143,9 @@ struct user_sdma_request {
 	/* This is the original header from user space */
 	struct hfi1_pkt_header hdr;
 
+	/* Memory type information for each data iovec entry. */
+	struct sdma_req_meminfo meminfo;
+
 	/* Read mostly fields */
 	struct hfi1_user_sdma_pkt_q *pq ____cacheline_aligned_in_smp;
 	struct hfi1_user_sdma_comp_q *cq;
diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 7f6d7fc7951d..8c2b000affef 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -778,8 +778,9 @@ static int build_verbs_tx_desc(
 
 	/* add icrc, lt byte, and padding to flit */
 	if (extra_bytes)
-		ret = sdma_txadd_daddr(sde->dd, &tx->txreq,
-				       sde->dd->sdma_pad_phys, extra_bytes);
+		ret = sdma_txadd_daddr(sde->dd, HFI1_MEMINFO_TYPE_SYSTEM, NULL,
+				       &tx->txreq, sde->dd->sdma_pad_phys,
+				       extra_bytes);
 
 bail_txadd:
 	return ret;
diff --git a/drivers/infiniband/hw/hfi1/vnic_sdma.c b/drivers/infiniband/hw/hfi1/vnic_sdma.c
index c3f0f8d877c3..ed7a167a0ad7 100644
--- a/drivers/infiniband/hw/hfi1/vnic_sdma.c
+++ b/drivers/infiniband/hw/hfi1/vnic_sdma.c
@@ -63,10 +63,8 @@ static noinline int build_vnic_ulp_payload(struct sdma_engine *sde,
 		skb_frag_t *frag = &skb_shinfo(tx->skb)->frags[i];
 
 		/* combine physically continuous fragments later? */
-		ret = sdma_txadd_page(sde->dd,
-				      &tx->txreq,
-				      skb_frag_page(frag),
-				      skb_frag_off(frag),
+		ret = sdma_txadd_page(sde->dd, NULL, &tx->txreq,
+				      skb_frag_page(frag), skb_frag_off(frag),
 				      skb_frag_size(frag));
 		if (unlikely(ret))
 			goto bail_txadd;
diff --git a/include/uapi/rdma/hfi/hfi1_ioctl.h b/include/uapi/rdma/hfi/hfi1_ioctl.h
index 8f3d9fe7b141..86be7574469d 100644
--- a/include/uapi/rdma/hfi/hfi1_ioctl.h
+++ b/include/uapi/rdma/hfi/hfi1_ioctl.h
@@ -171,4 +171,22 @@ struct hfi1_base_info {
 	__aligned_u64 subctxt_rcvegrbuf;
 	__aligned_u64 subctxt_rcvhdrbuf;
 };
+
+struct hfi1_pin_stats {
+	int memtype;
+	/*
+	 * If -1, driver returns total number of stats entries for the given
+	 * memtype, otherwise returns stats for the given { memtype, index }.
+	 */
+	int index;
+	__u64 id;
+	__u64 cache_entries;
+	__u64 total_refcounts;
+	__u64 total_bytes;
+	__u64 hits;
+	__u64 misses;
+	__u64 internal_evictions; /* due to self-imposed size limit */
+	__u64 external_evictions; /* system-driven evictions */
+};
+
 #endif /* _LINIUX__HFI1_IOCTL_H */
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
diff --git a/include/uapi/rdma/rdma_user_ioctl.h b/include/uapi/rdma/rdma_user_ioctl.h
index 53c55188dd2a..a2dbcf231f45 100644
--- a/include/uapi/rdma/rdma_user_ioctl.h
+++ b/include/uapi/rdma/rdma_user_ioctl.h
@@ -81,5 +81,8 @@
 #define HFI1_IOCTL_TID_INVAL_READ	_IOWR(RDMA_IOCTL_MAGIC, 0xED, struct hfi1_tid_info)
 /* get the version of the user cdev */
 #define HFI1_IOCTL_GET_VERS		_IOR(RDMA_IOCTL_MAGIC,  0xEE, int)
+/* Retrieve pin cache statistics */
+#define HFI1_IOCTL_PIN_STATS \
+	_IOWR(RDMA_IOCTL_MAGIC, 0xEF, struct hfi1_pin_stats)
 
 #endif /* RDMA_USER_IOCTL_H */


