Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE87709CFB
	for <lists+linux-rdma@lfdr.de>; Fri, 19 May 2023 18:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjESQyi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 May 2023 12:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjESQyh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 May 2023 12:54:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2130.outbound.protection.outlook.com [40.107.92.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECBE114
        for <linux-rdma@vger.kernel.org>; Fri, 19 May 2023 09:54:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDsMIcOBpwcfWnuM58/UWpxMF0SlFqISU9gVX+saPpY7py81x+bcDgengh9/YK/8HzZ799Fr8D5xFRqdl6jjgDtGjde21Z+IT9fQ/d3IZBZjLqR0IEkRNtKhVOExiMeSL0XyplHAEBg0skvdRk0HkA4OIFwHI2d6HiAVMAThrI9yYSSWyCKgjLTWPdFCPAQvjkM/MhKOLH3OtB/n5/qRE6vCN5FAl9gtqanEF/kcpAr6ijwEqR5K5mT4uYQSAEUApeONn+I2X2kX3NuNcH5u4TbaxpTCJ9EX1FEWJ86r2OedittQT2ysrrD+9xPst/rTlKhISr+OlscrGTRS55p2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjvprGW/9NVl4v1UlTSxnkhJnqxS7We1nSpRCeYQ+lo=;
 b=Iz22AV0DN/CMwMtyAaRN2tEedU9mUByeJHU6dLA2BldmwX29/5eSaIS67MOtWGWoN7tTXYFlBobdEYGW4uSv30M2Pd9jna4oxV7PWCedY/FWuVUsvH/l2J4qZ0DvPptnOW/qYeR3AX5H1xU0+XdXlFDf+8pkH9+MW63kDpCBx7DiLaeyy9F5AT/TWXMeJbTWDf1vXGRp+6Da9DDDRdXTWxpKnBWMaj7rBdxGb0VT0FpkHXMxYZAAnEUo/uVgYyqok5993RYer56WXuEIypOOiMv9FwuNZ8RNDtLGHJbrDokzn+VZ/1+z+9z66sCUISAdrCafLeOc3LrfU6xImSYWwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjvprGW/9NVl4v1UlTSxnkhJnqxS7We1nSpRCeYQ+lo=;
 b=QgT2L7LMIEPCCzwwf1DSLkRLuLsuNg02UMx9mW9Hk6I7A3V4nBnM1RNYbZFVkKSSIMHuhgKTbK5+s89zRqoM8N49fci9ktlIZHHVGqNYfuCYYt6BRwF7/fcSFBFZ1unfuWq5H9LhGJbt80YFMb5lpz4QfwlD+8EpdbnZTrQjz3AhodAxgvHtE9ez5rrYWP7AZfo4su0dpDIR/6Z8iwO8IPACT0T7+92vlvHlggTpesWh7iQbejL+cIw/DD5ILc0d2czfxQT/FLIIvOT6LVELQxP+Ko8LQvJFQL93iiyCiZzvGbHJmQ+sWBQI2A0P0CTxYEi11JXZhapFZHs2TZXaHQ==
Received: from MW4PR03CA0293.namprd03.prod.outlook.com (2603:10b6:303:b5::28)
 by SN6PR01MB5024.prod.exchangelabs.com (2603:10b6:805:bb::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.19; Fri, 19 May 2023 16:54:27 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::3a) by MW4PR03CA0293.outlook.office365.com
 (2603:10b6:303:b5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 16:54:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 16:54:26 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 34JGsPtx3702383;
        Fri, 19 May 2023 12:54:25 -0400
Subject: [PATCH for-next 2/3] IB/hfi1: Remove unused struct mmu_rb_ops fields
 .insert, .invalidate
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Fri, 19 May 2023 12:54:25 -0400
Message-ID: <168451526508.3702129.8677714753157495310.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <168451505181.3702129.3429054159823295146.stgit@awfm-02.cornelisnetworks.com>
References: <168451505181.3702129.3429054159823295146.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT009:EE_|SN6PR01MB5024:EE_
X-MS-Office365-Filtering-Correlation-Id: 75995fff-6b97-4a77-c5c4-08db5889b474
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +WchLCeh/Qj2wMUBOI6ljSRkV6Jt+541u4JVT34Hd7XncgIHpO9GBKG8dJMlc2XcwgghX87AhQGN32WmWuEgdmEHrEIT09jJnnvL0GgdvjjC8afO8hBQyQ70G8R2UuGRjLLGy0REt6aaylGdmAMSDjrWp0WF5vf9oSKwygsK6ckaEPswpGJw+q4zi4NAqscGO5J2HDaU5uPOP77OlJiSWUkeaiB/0BMnVAGY22ln4RZNGhVXddHDb8HGyrU1tvJm7ULR6Cch5Hj19nJhWew3tJAkIC4+C1jxQwvSCtxKRsSCK4ejQNzH/TGYLtG55vFrTvvgvOlY1CJHc1ersZq+COO77P4XvD0RyzyP5WZ2SzfJ0CsuCLyFc2kXhhjaMVdWdTVqLy8D2S5bh4kaNZsKfp2pq5OIwopBiPjLciskm1DVIXWc1t1Qgz+vQaxyiAPSLAsgvg4joFBOIjuss4wzybI59MC9CZilYtBLleTNEm8y1rhbBQmrrvNDmhd5Ux4jDb1bVAMOemjesBp7L4aCwKSLR6pZIftvlEHx9LnwrfoL+GmXAzhHtLXGamuVntkAgj7fCTkxyC/ahI+vLSNkxKK5N87JfqDPSLlh/d6VQsaaZtaO+AuZed7BBwWC7q6jlAHEBrgMYPVW29PMj/ozoMh0B5OqC/m7U1Sq5Juvr146jrXx01RNHEpm2i9eUeY72OTX0UDd/YMRyCRh42tUbzfaOnUkzLv5/57yeSAqHkKcMZXHbnHLEiaDVWqDzNr+mmR96xWEsJAonGHBL5qk8Q==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39840400004)(396003)(376002)(346002)(451199021)(36840700001)(46966006)(8936002)(2906002)(316002)(478600001)(4326008)(41300700001)(8676002)(44832011)(70206006)(70586007)(5660300002)(7696005)(26005)(103116003)(186003)(81166007)(55016003)(356005)(83380400001)(40480700001)(336012)(7126003)(36860700001)(86362001)(82310400005)(47076005)(426003)(142923001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 16:54:26.2654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75995fff-6b97-4a77-c5c4-08db5889b474
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB5024
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

The struct mmu_rb_ops function pointers .insert, .invalidate were only
used to increment and decrement struct sdma_mmu_node.refcount.

With the deletion of struct sdma_mmu_node.refcount and the addition of
struct mmu_rb_node.refcount  these function pointers are not called and
there are no implementations of them. So it is safe to delete these from
struct mmu_rb_ops.

Signed-off-by: Brendan Cunningham <bcunningham@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/mmu_rb.h |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.h b/drivers/infiniband/hw/hfi1/mmu_rb.h
index 82c505a04fc6..751dc3fe1e02 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.h
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.h
@@ -19,16 +19,11 @@ struct mmu_rb_node {
 	struct kref refcount;
 };
 
-/*
- * NOTE: filter, insert, invalidate, and evict must not sleep.  Only remove is
- * allowed to sleep.
- */
+/* filter and evict must not sleep. Only remove is allowed to sleep. */
 struct mmu_rb_ops {
 	bool (*filter)(struct mmu_rb_node *node, unsigned long addr,
 		       unsigned long len);
-	int (*insert)(void *ops_arg, struct mmu_rb_node *mnode);
 	void (*remove)(void *ops_arg, struct mmu_rb_node *mnode);
-	int (*invalidate)(void *ops_arg, struct mmu_rb_node *node);
 	int (*evict)(void *ops_arg, struct mmu_rb_node *mnode,
 		     void *evict_arg, bool *stop);
 };


