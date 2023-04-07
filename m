Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3E96DB0F5
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Apr 2023 18:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjDGQxF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Apr 2023 12:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjDGQxE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Apr 2023 12:53:04 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2116.outbound.protection.outlook.com [40.107.102.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28DD55AE
        for <linux-rdma@vger.kernel.org>; Fri,  7 Apr 2023 09:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvzhFOtbeJSExfwMS2qFjXUSnu9VdDg/o10I8FI57g5+WHFjkjd+yImY/8P+n4ERVCSUhzvOUsFSBDNs/ppQW/125rksEeqALo/EXSdijINmabCLvY8/uQUPq7DpC9bJq49/9FJs6rsFwd6EwjFSRrCiykZBxCcx3ZQMMbRUfbT2m8HpSZUk2RLGZamZmPt3f1fYOI12cGOEutJAvo57ebp8YQYNaeTq6EOljUNP+Zgjl4X08AjG2an+OSl08TQ+9tUR3zyarolUD+ehY+Y45vaGdlwJf2V4bpCJcdExP4xE1x/4X1qyCVpegYX5GXDNqV1v3kIqkt0FJS8RQAgsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhxdTIX9W6foq67chk/9qyJV8tya5ITAeo13v4GUkms=;
 b=i8uAVVLta0LrvBhjARm5XwExb+rZBLRKuS/JTIzeiSewXDFsM1puGaDcKZ9n+zXp3D4cV28hq/2XJzRBhfcfNEHLiVwj3PW0yfmrNfHKbbssoClWGpK3usS3gv8YeElbtyvwxcUz/wqSulQqBYFlGthlAbjaWuvemVkxtBwGEErFgzjm+LqPrDeUeHbtgHNUJ6ld3P544CTYk4N0/7fmJBmximSh73dozrJ1IgH7lvarxLnViDi3F+Q/sgnUfJansVw/AGNTF9iHUtkDQ+KEPEp3HeTbBFsTw+jvXyQYPtTiopQnYW4Cbf8X/taLNBEeOLUr+9qFCRS5Gjx6sZC5uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhxdTIX9W6foq67chk/9qyJV8tya5ITAeo13v4GUkms=;
 b=mWJwppkZr7d0SD3MLBmv49JsHeeKlxvbp6FSjEZw8bhHaObuZjI506u6eMcwhfYwrJjWlPO4guGCltTu8ccy6SVhstUvl4VkpEUk8TE9y0EXmyrVPI/qrcBI9wUg6ToibRqfn3IE/1HHe1t8NlUukHlQjhpSvI3INI01pwNt7O4s4xnl3Bqfcy7mHRzEFMGyUVcD3swYXA9Rx89BuggLPz0/Uednwi6qHawz4natR9bMQeOSkPMwoMIXrJPH9DojNr/T6tC65KzMLCjsG4zsgpo5P3uezRXrOkWqBkaC6f1Kf97F6crrdyk2Z4fN4g2QDVoa4PfXcePk3w2j7myNPA==
Received: from MW3PR06CA0016.namprd06.prod.outlook.com (2603:10b6:303:2a::21)
 by BN7PR01MB3988.prod.exchangelabs.com (2603:10b6:406:89::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.28; Fri, 7 Apr 2023 16:52:51 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::ae) by MW3PR06CA0016.outlook.office365.com
 (2603:10b6:303:2a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31 via Frontend
 Transport; Fri, 7 Apr 2023 16:52:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.20 via Frontend Transport; Fri, 7 Apr 2023 16:52:50 +0000
Received: from 252.162.96.66.static.eigbox.net (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 337GqnVa3027412;
        Fri, 7 Apr 2023 12:52:49 -0400
Subject: [PATCH for-next 5/5] IB/hfi1: Place struct mmu_rb_handler on cache
 line start
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Fri, 07 Apr 2023 12:52:49 -0400
Message-ID: <168088636963.3027109.16959757980497822530.stgit@252.162.96.66.static.eigbox.net>
In-Reply-To: <168088607365.3027109.2194306496858796762.stgit@252.162.96.66.static.eigbox.net>
References: <168088607365.3027109.2194306496858796762.stgit@252.162.96.66.static.eigbox.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT013:EE_|BN7PR01MB3988:EE_
X-MS-Office365-Filtering-Correlation-Id: b2aef170-d61a-4cba-43f2-08db37888639
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iEUzS/Oh9waU0Y1u8DK4dVhxeZPyd+MJyYLsUKg1tJIgimc3R2rbLKDcShZiWIvXeUZ69yIM7TVvV0Eh9BHVDjVdoZj6uBDp0Cogrtz8AvAIk81ucIUfTYM/3H5h20WonhjqOqYM2/94ccjAKzLBCNTntK3ftAuH9qjV+l5wAas+bStABU4yIcwgXDv+LJnYdNTJSW468uWgBWlLyLJ9vOeWsrjWAfAFS6rnWdl4A88+sJJ83n6kb8e/zFHU9sXKP081itC0Trsh90ZoPY5vRhdMd7ym7EI0hkVunY24V6EIVx5Prjh69MaSIXW6kmMY87zHuQGZtbbWsp0X2O3lhSM5VVr/SjLE2mTYD0yVZ1Yv1NYkeGBNFv0zdyLJAPFgSwquWde1wRCoY1T3QMoy4CpyYuR8+7GrPAwzvaG1B4qK1DaaMD5IArUBCWnwsmW0anUG8VgT09izh9A3JaQUquFnmqxbIdIXzhd/FRhkEsxa4yrle3rCtaLtbbEq6NlOFvOaIxjp4UDN4UEvEjdMt74GWVeCjw9S5xhJFKXEDo8YrMRWgobijUhwtAYhrTi5a0mqp8j+yHHgA2LWvmTyYaaA+ajVlyBZl03NAS4ZU31yOZgYa5pHeVRUXHhHWxEvW0WjhOf+xVNR3wxOHD9Hu2BYBtAmmesHDuKpE72OAoanmMrhVYnWSW6Vk8QjFpcUo3/GsoByF1eoXN7E8h3wXSpytS8bguCnKTd5CpIvDcRrmsdiJ7DgQQLAAKHnLUCRyl7B0+JC3DPi8dm+AXRPhlhiRuhGlIpnArdCntjvgWDH5ZW0StJDVrmxOj16w6yNkTZz1AE+0hTMGn3fdaaimg==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39840400004)(396003)(136003)(376002)(451199021)(46966006)(36840700001)(426003)(81166007)(44832011)(40480700001)(5660300002)(356005)(70586007)(8676002)(41300700001)(103116003)(82310400005)(55016003)(70206006)(4326008)(86362001)(8936002)(186003)(36860700001)(54906003)(47076005)(83380400001)(26005)(478600001)(7126003)(336012)(2906002)(9686003)(7696005)(316002)(9916002)(24686002)(36900700001)(102196002);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 16:52:50.8474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2aef170-d61a-4cba-43f2-08db37888639
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR01MB3988
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>

Place struct mmu_rb_handler on cache line start like so:

	struct mmu_rb_handler *h;
	void *free_ptr;
	int ret;

	free_ptr = kzalloc(sizeof(*h) + cache_line_size() - 1, GFP_KERNEL);
	if (!free_ptr)
		return -ENOMEM;

	h = PTR_ALIGN(free_ptr, cache_line_size());

Additionally, move struct mmu_rb_handler fields "root" and "ops_args" to
start after the next cacheline using the "____cacheline_aligned_in_smp"
annotation.

Allocating an additional cache_line_size() - 1 bytes to place
struct mmu_rb_handler on a cache line start does increase memory
consumption.

However, few struct mmu_rb_handler are created when hfi1 is in use.
As mmu_rb_handler->root and mmu_rb_handler->ops_args are accessed
frequently, the advantage of having them both within a cache line is
expected to outweigh the disadvantage of the additional memory
consumption per struct mmu_rb_handler.

Signed-off-by: Brendan Cunningham <bcunningham@cornelisnetworks.com>
Signed-off-by: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/mmu_rb.c |   11 +++++++----
 drivers/infiniband/hw/hfi1/mmu_rb.h |   14 ++++++++++++--
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
index 71b9ac018887..1cea8b0c78e0 100644
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
diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.h b/drivers/infiniband/hw/hfi1/mmu_rb.h
index ed75acdb7b83..c4da064188c9 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.h
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.h
@@ -33,15 +33,25 @@ struct mmu_rb_ops {
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
+	void *free_ptr;
 };
 
 int hfi1_mmu_rb_register(void *ops_arg,


