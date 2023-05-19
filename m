Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE03709CF9
	for <lists+linux-rdma@lfdr.de>; Fri, 19 May 2023 18:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjESQy0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 May 2023 12:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjESQyZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 May 2023 12:54:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2113.outbound.protection.outlook.com [40.107.223.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577B011F
        for <linux-rdma@vger.kernel.org>; Fri, 19 May 2023 09:54:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAEywwJAKCXjz05FokKRLEDlkMHrZ+TZVAu/Q55Z27yX9RncF43ydkmVe/UoQand24xzbEssvZkoBVRLglI3DsJZamMPY21hiXsDJMp+KZPD3ZdpwINmOZ8kJTh0MiQELCUh7zJsg9TXlTaZeYWE5Fou2G4aebPp5LfzMytIbsThRPG3kWFAdgHh9Fukx2AbaXN35Fbi3oZr9t2+vxsVffMff7L9GGxm5qGI8E8VKoJOymLl1ij6GTjh38PR8PvAY5drTqMSsEx1AKIYAL26BJBJ2xKi9lYLbELXbTHArqeNjHAnGNmm3iYPUXeODEP5Ef5vSP3z8NGfx+irlDnf6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+cedQLMw9vghL34Lz55LC7/SsOldKqjZ9jp0LS0HOY=;
 b=dlVZYNbVDqCffFa8j4+flDGeyJNa39iz0N8i9CVUUoWfS050zeWrKxoKRUoqMD5n5BD8pal64jl6808p9rOdrwqB+oiaqHfa8ZLHNz3T61zAU2SW2dFxuPxGS3QjgHQU19fuial29nRje7QpAvw7R/Ub7mA7FMK/a0g/FSCb/P7jhUY8ppLhc3lGZ06Tl8R1dHEYrYZTwR/tjyhnVAbLan+P6AbT29Tn6yVjdksOvlomVbCpk1MzdOc97gHBY+XmnyaG8ezEblXqeJ3cyrX0KcrGnvs/TDqAdQJbTXJPJqKiaPgtI8YdnCSga/cbfP3p6fO1ztAfnMKngGMksw7EqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+cedQLMw9vghL34Lz55LC7/SsOldKqjZ9jp0LS0HOY=;
 b=Icqze2mKY0Rk5/uerqa7GsmZ2/ZfTI6nQV205r8ZZZ6LX+tE7vq/RoR7LVKT03ttqfT/AXtcXvNHETUTEfCMM/CsqxNrHdmUF+yhAb8Ge50x4C3gSSJcwTNMxrcZ8oc4gzG+pPNuE9Le/WgXVLncm2ryFR8EKDf1V0O53dKNIqOtEJ94exH/0asfTFAgz6LhDlEC/PAvqwuJUGeQHjAlZJj+E8K59p3JLgYHfHKYjLMx34DMKSEgW/avFddMx+30vYEjnbhpryxjXhws8J16b6V0zaK4hAdnvJPZsoxq0Nkr+PA6NRJh2+toVzWnMmMHgMq8BBYWEc3BCmb7fczdVA==
Received: from BN7PR02CA0035.namprd02.prod.outlook.com (2603:10b6:408:20::48)
 by MN2PR01MB5407.prod.exchangelabs.com (2603:10b6:208:118::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.21; Fri, 19 May 2023 16:54:20 +0000
Received: from BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::74) by BN7PR02CA0035.outlook.office365.com
 (2603:10b6:408:20::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.22 via Frontend
 Transport; Fri, 19 May 2023 16:54:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 BN8NAM11FT112.mail.protection.outlook.com (10.13.176.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 16:54:20 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 34JGsJ9t3702373;
        Fri, 19 May 2023 12:54:19 -0400
Subject: [PATCH for-next 1/3] IB/hfi1: Add mmu_rb_node refcount to
 hfi1_mmu_rb_template tracepoints
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Fri, 19 May 2023 12:54:19 -0400
Message-ID: <168451525987.3702129.12824880387615916700.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <168451505181.3702129.3429054159823295146.stgit@awfm-02.cornelisnetworks.com>
References: <168451505181.3702129.3429054159823295146.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT112:EE_|MN2PR01MB5407:EE_
X-MS-Office365-Filtering-Correlation-Id: 32676101-29e6-4adb-ca3c-08db5889b0fe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PgUmFg9qAu65PUgvhiS6iOEH5xmiRhSXujrGelBSTaCyZUmuTYlmL3SPj7I06HqxtbpTICLPO7sgwa0aCrMLy5sClLaEMw8Pv8/yNiycosU2fq1VQ8bRpSR7XSHsUL5QBSgvbWjH9IKYcuQ2jLYjXpoGCuWv/Ng00om+KZ7EeCcCnXQyoMVmthri1J1a2+zxCC+opaNNA1+DDNzjifBNmLHpWeI2pjIuoxnmLEc/YfulGZn8PPxg+FNdj9Hv6606JxAsEhliPt3Iffr24CylN8ew/W6IdhdKGLKFv5ex3h63CU6gL5f8Q/RmcUeP50x80hqKVAGJMxfUYrYFgO7WsWIqHjvH2RlDKBeNWX9gmC8Qe39cvkPuB6HqZEP8IxW6z05AARpj4yFrvD1z8ntshWvseSsascbERoLHmnKHtfQmuDPX+Qwo/RPouLbaaIq7VKuQ/k56Q+92raFKkgwBcXY7dPoD96aulHLq5DXnopFRK0k/dOG06/OzyCZdWz36jaMmxBXgfXiF4idmdUC2SCe66u2yXKioiqWHOcK1ILaWRNn+hLe7P3rdXdlhg3vugOW5k/7zMbgZ8MbWgg8/O0fr904IvumWPkM6uqA30+rTNmPAEiKq8OdgCLFIkFS9Hzi5D2f2YofmSZtQNiJDAzkTw8Tr3cBSG/XoN0Z+2cm5rXgusVRJCNzcSFZH2GakINCQ6wCmipwpIxC/f0MlcestIaEGSTut2xI7jislKms=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39840400004)(376002)(396003)(136003)(451199021)(46966006)(36840700001)(41300700001)(7696005)(44832011)(26005)(82310400005)(36860700001)(5660300002)(83380400001)(7126003)(186003)(47076005)(426003)(336012)(103116003)(2906002)(86362001)(356005)(81166007)(8676002)(8936002)(40480700001)(55016003)(478600001)(70586007)(70206006)(4326008)(54906003)(316002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 16:54:20.5996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32676101-29e6-4adb-ca3c-08db5889b0fe
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR01MB5407
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Brendan Cunningham <bcunningham@cornelisnetworks.com>

Add kref_read() of mmu_rb_node.refcount in hfi1_mmu_rb_template-type
tracepoint output.

Change hfi1_mmu_rb_template tracepoint to take a struct mmu_rb_node* and
record the values it needs from that. This makes the trace_hfi1_mmu*()
calls shorter and easier to read.

Add hfi1_mmu_release_node() tracepoint before all
mmu_rb_node->handler->ops->remove() calls.

Make hfi1_mmu_rb_search() tracepoint its own tracepoint type separate
from hfi1_mmu_rb_template since hfi1_mmu_rb_search() does not take a
struct mmu_rb_node*.

Reviewed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Brendan Cunningham <bcunningham@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/mmu_rb.c    |    7 +++--
 drivers/infiniband/hw/hfi1/trace_mmu.h |   48 +++++++++++++++++++++++---------
 2 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
index a864423c256d..7a51f7d73b61 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.c
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
@@ -124,7 +124,7 @@ int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
 	unsigned long flags;
 	int ret = 0;
 
-	trace_hfi1_mmu_rb_insert(mnode->addr, mnode->len);
+	trace_hfi1_mmu_rb_insert(mnode);
 
 	if (current->mm != handler->mn.mm)
 		return -EPERM;
@@ -189,6 +189,7 @@ static void release_immediate(struct kref *refcount)
 {
 	struct mmu_rb_node *mnode =
 		container_of(refcount, struct mmu_rb_node, refcount);
+	trace_hfi1_mmu_release_node(mnode);
 	mnode->handler->ops->remove(mnode->handler->ops_arg, mnode);
 }
 
@@ -252,6 +253,7 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 	spin_unlock_irqrestore(&handler->lock, flags);
 
 	list_for_each_entry_safe(rbnode, ptr, &del_list, list) {
+		trace_hfi1_mmu_rb_evict(rbnode);
 		kref_put(&rbnode->refcount, release_immediate);
 	}
 }
@@ -271,7 +273,7 @@ static int mmu_notifier_range_start(struct mmu_notifier *mn,
 		/* Guard against node removal. */
 		ptr = __mmu_int_rb_iter_next(node, range->start,
 					     range->end - 1);
-		trace_hfi1_mmu_mem_invalidate(node->addr, node->len);
+		trace_hfi1_mmu_mem_invalidate(node);
 		/* Remove from rb tree and lru_list. */
 		__mmu_int_rb_remove(node, root);
 		list_del_init(&node->list);
@@ -304,6 +306,7 @@ static void handle_remove(struct work_struct *work)
 	while (!list_empty(&del_list)) {
 		node = list_first_entry(&del_list, struct mmu_rb_node, list);
 		list_del(&node->list);
+		trace_hfi1_mmu_release_node(node);
 		handler->ops->remove(handler->ops_arg, node);
 	}
 }
diff --git a/drivers/infiniband/hw/hfi1/trace_mmu.h b/drivers/infiniband/hw/hfi1/trace_mmu.h
index 57900ebb7702..82cc12aa3fb8 100644
--- a/drivers/infiniband/hw/hfi1/trace_mmu.h
+++ b/drivers/infiniband/hw/hfi1/trace_mmu.h
@@ -15,31 +15,53 @@
 #define TRACE_SYSTEM hfi1_mmu
 
 DECLARE_EVENT_CLASS(hfi1_mmu_rb_template,
-		    TP_PROTO(unsigned long addr, unsigned long len),
-		    TP_ARGS(addr, len),
+		    TP_PROTO(struct mmu_rb_node *node),
+		    TP_ARGS(node),
 		    TP_STRUCT__entry(__field(unsigned long, addr)
 				     __field(unsigned long, len)
+				     __field(unsigned int, refcount)
 			    ),
-		    TP_fast_assign(__entry->addr = addr;
-				   __entry->len = len;
+		    TP_fast_assign(__entry->addr = node->addr;
+				   __entry->len = node->len;
+				   __entry->refcount = kref_read(&node->refcount);
 			    ),
-		    TP_printk("MMU node addr 0x%lx, len %lu",
+		    TP_printk("MMU node addr 0x%lx, len %lu, refcount %u",
 			      __entry->addr,
-			      __entry->len
+			      __entry->len,
+			      __entry->refcount
 			    )
 );
 
 DEFINE_EVENT(hfi1_mmu_rb_template, hfi1_mmu_rb_insert,
-	     TP_PROTO(unsigned long addr, unsigned long len),
-	     TP_ARGS(addr, len));
+	     TP_PROTO(struct mmu_rb_node *node),
+	     TP_ARGS(node));
 
-DEFINE_EVENT(hfi1_mmu_rb_template, hfi1_mmu_rb_search,
-	     TP_PROTO(unsigned long addr, unsigned long len),
-	     TP_ARGS(addr, len));
+TRACE_EVENT(hfi1_mmu_rb_search,
+	    TP_PROTO(unsigned long addr, unsigned long len),
+	    TP_ARGS(addr, len),
+	    TP_STRUCT__entry(__field(unsigned long, addr)
+			     __field(unsigned long, len)
+		    ),
+	    TP_fast_assign(__entry->addr = addr;
+			   __entry->len = len;
+		    ),
+	    TP_printk("MMU node addr 0x%lx, len %lu",
+		      __entry->addr,
+		      __entry->len
+		    )
+);
 
 DEFINE_EVENT(hfi1_mmu_rb_template, hfi1_mmu_mem_invalidate,
-	     TP_PROTO(unsigned long addr, unsigned long len),
-	     TP_ARGS(addr, len));
+	     TP_PROTO(struct mmu_rb_node *node),
+	     TP_ARGS(node));
+
+DEFINE_EVENT(hfi1_mmu_rb_template, hfi1_mmu_rb_evict,
+	     TP_PROTO(struct mmu_rb_node *node),
+	     TP_ARGS(node));
+
+DEFINE_EVENT(hfi1_mmu_rb_template, hfi1_mmu_release_node,
+	     TP_PROTO(struct mmu_rb_node *node),
+	     TP_ARGS(node));
 
 #endif /* __HFI1_TRACE_RC_H */
 


