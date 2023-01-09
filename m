Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2F3662CC8
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 18:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbjAIRcP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 12:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237236AbjAIRbY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 12:31:24 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3539B7D2
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 09:31:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIGUYFoMMwVmcO2//IQzUiYOamTxtNmG5sgUFG917dDQoMl4KoNvrHbsB83sDUwlvpTx73+K39imFjpmnRhvlj3MWTaUtMGy93gMGUMgDM70iuc678eB05Eduy9ue3XxV40t5CJhZLJf79FiiDM6FkzPu+9Swj/htcnR01rxZ/G2XFTATgT7afuMb4S3IRu++YY8eERKH2RnQFckc/WdZGZ7CmyUaFuM+O3+Sllq+gLsEIRN2RZY2TxXP58zWOSZI/pjV1oLi5YF0RooFM0eqBR+1Hx9k6qdI5A3l43MTxA8AFkLZ0jaBQG7K46Do7ZYo3a2jhjTmNzv6VeYe39PXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nroqvo4SBQd95e7VAhZ0plVitykUI6oVJZjj8czpQcE=;
 b=HSHBexuqzbrFs+mHlmKkiczJ2xSoEUEdeLsc1KtuZ45B7TzarACxInGJpYmbj4bwhx0oAPn2WFXWWP4YYQT5Mr8k6HzypdAVJw0G7ySmDBSBQO9zXrh4h6DRSyFpqWq1Zt1M43yTr9NM3Ua0VHAQqhAa00Sbf6iQPaIQAk53/LbY8lTKVAf/14seZT/wooQQ+FT4R+8yHUb19buwoyPVhU0JPAJEo+/tAcQrvMTg+ImNMPa6+k7FmFObLOiIMxQNkHL5ROhUtlhloGB9UtbCxJUVedW+G3pxo+od8K8/ykrp2Wx74J+HqQ16bplhjDeCCM6c9w+K3pE9HyTg0rtB2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nroqvo4SBQd95e7VAhZ0plVitykUI6oVJZjj8czpQcE=;
 b=Q3exd5TGfveCnZc8AhNrIq2StEG2e/5XPtaZNBsSoMUUYZdJ2TKqGjAPtSUCL2PE2LxuHSqlxib7Yh+PT1eOlvCXngI2EUgRgIgFqZ46kLoXPtBgO2bKJC3h8yUSFIDUNotphy0UMt2LqDvjSsGm37vTEQg/QAHQZbONsY6yM9drh9WlHqjp5nnv9FKbqx3J/nyGkS8R1N+OhXPpHf25GUF4AEcHj8SJgMKI5drtOsKYTigleSt0pPjqXNG1RlUmxblzjT6fHIJHoO1pQByqSk5PJ+/jMHKjt+pVZoS2jlxgMpUewE/F5iQFK117NmkTBKs7GRNi/pahOJLul7IXrw==
Received: from DS7P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::13) by
 SJ0PR01MB8082.prod.exchangelabs.com (2603:10b6:a03:4e2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 17:31:17 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::fb) by DS7P222CA0024.outlook.office365.com
 (2603:10b6:8:2e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 17:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.17 via Frontend Transport; Mon, 9 Jan 2023 17:31:17 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 309HVGeA1472598;
        Mon, 9 Jan 2023 12:31:16 -0500
Subject: [PATCH for-rc 3/6] IB/hfi1: Reserve user expected TIDs
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Mon, 09 Jan 2023 12:31:16 -0500
Message-ID: <167328547636.1472310.7419712824785353905.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <167328512911.1472310.3529280633243532911.stgit@awfm-02.cornelisnetworks.com>
References: <167328512911.1472310.3529280633243532911.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|SJ0PR01MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 924bc644-bfea-40e4-3bb5-08daf267508b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awMlE205fGE1T//9YBpBpgogBnOeyGK3wtuSePd/YcXeFMEyWt1Mp9GhnUtsCjBxUw8l6e8kSnC4lFG1iuKMTQRE7cH2YuL5oq+PNo5Qbos0ziiyTEfrzTdbVBvwLhD5426IAQBcPa/94CUry/83lHwNSL26eFpzDSOQwC44dg1tJ5fgpP4mVQdWoVNPkcdHJ7SCDybvei5qA+sKa0Ucj4Htepr16RgZhVzwgka1bReQRFKafbUHjneRgKkiV949yBXGjlbWHaXywMcEZw/el8SHqZDRW65/8X2Zwz+1/U8++KFGqa9B/RiI9WTRC44pL8TahGwuv71Zw/hKVm+Inlep2z78tzPYe2lbcmTXkPMNNbz2qByZCflfYZWdvkNa41vL0TcyzysE5jh5q1SDy/n7gfVZH9JakARWdXFoFZdgKRIPXsRLlT0vB+jyAjGaPIA6GX6qDF0Q3jR2eTQ93jNFvO+BByme9cGKUt06FzS0RSPWYv2/SseRdqc3ZvLfPJP4pbfLIYrhLMOcKf7/A42gKoh3/CUX07jZ5P3MoWw+bXhRsm3mRy0axY4DWRLflNOf8NJvQD/P+VZQxwLcKW7T8RDjfho1CxHs+uUKVScQyIrBjpF8M6RHZBazQIWc5K/igAcyh/58sWD+xJ0EsfNA5oX5ZRxsNYVJ4mUlKOerXMhV5t6QQSvikTCtaWoAgDA3nULIsP3EAo7Zd4GlFw==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39840400004)(346002)(451199015)(46966006)(36840700001)(478600001)(103116003)(40480700001)(47076005)(7126003)(4326008)(336012)(186003)(26005)(55016003)(70206006)(70586007)(8676002)(316002)(7696005)(83380400001)(36860700001)(86362001)(81166007)(356005)(426003)(41300700001)(82310400005)(5660300002)(2906002)(44832011)(8936002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 17:31:17.2108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 924bc644-bfea-40e4-3bb5-08daf267508b
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB8082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Dean Luick <dean.luick@cornelisnetworks.com>

To avoid a race, reserve the number of user expected
TIDs before setup.

Fixes: 7e7a436ecb6e ("staging/hfi1: Add TID entry program function body")
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/user_exp_rcv.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index 3c609b11e71c..d7487555d109 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -282,16 +282,13 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 	/* Find sets of physically contiguous pages */
 	tidbuf->n_psets = find_phys_blocks(tidbuf, pinned);
 
-	/*
-	 * We don't need to access this under a lock since tid_used is per
-	 * process and the same process cannot be in hfi1_user_exp_rcv_clear()
-	 * and hfi1_user_exp_rcv_setup() at the same time.
-	 */
+	/* Reserve the number of expected tids to be used. */
 	spin_lock(&fd->tid_lock);
 	if (fd->tid_used + tidbuf->n_psets > fd->tid_limit)
 		pageset_count = fd->tid_limit - fd->tid_used;
 	else
 		pageset_count = tidbuf->n_psets;
+	fd->tid_used += pageset_count;
 	spin_unlock(&fd->tid_lock);
 
 	if (!pageset_count)
@@ -400,10 +397,11 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 nomem:
 	hfi1_cdbg(TID, "total mapped: tidpairs:%u pages:%u (%d)", tididx,
 		  mapped_pages, ret);
+	/* adjust reserved tid_used to actual count */
+	spin_lock(&fd->tid_lock);
+	fd->tid_used -= pageset_count - tididx;
+	spin_unlock(&fd->tid_lock);
 	if (tididx) {
-		spin_lock(&fd->tid_lock);
-		fd->tid_used += tididx;
-		spin_unlock(&fd->tid_lock);
 		tinfo->tidcnt = tididx;
 		tinfo->length = mapped_pages * PAGE_SIZE;
 


