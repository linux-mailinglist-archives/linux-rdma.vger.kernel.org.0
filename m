Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5AF663017
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 20:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjAITPN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 14:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjAITPG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 14:15:06 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2101.outbound.protection.outlook.com [40.107.101.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2975C1D3
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 11:15:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nC/toaOTUU4+5SaeV/xDlKWcXwBJdMGFbvo3pPPmLA6tnysV6wgQWyKWE/SkCw7F9jVSAyiXuum4eUMNpbGpfXHwyMOJg357XfgRbirtjBUcGY8CX9SopTyCiyZqzYSI7KOI24/qno+SJ1aO/uWygAM1KxJVI+d1THuiZ4ae10xZ03KceKstZCYnTEGAmp36bpj77bU5Wh+LPsKRyrs7foX4HngsejyqCrwz8+T5QQOsUjBHnwIa9HT4Lr5wCpFxdrPWsUMl/wziYBAHpRNHGLndQ23Fm2lXPq0nR2APteav/hT3UH5PI/puJMNfoByOJR1lGNe3iytmXt0bhXF1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQ/f9rUvSKxlzI3182rRik4In08y5+neqttwwsRRIjQ=;
 b=h+VV/YMtf3k8DPkuQuowzuNZ2Z+dJBqWC1FpgCnn3Lk0MNzzaLusM9j6A60xqLAKciVAM7ip8ks4g+8u0Fs449UJAXPJw/rnP3NZcOIXHHiCMc7bfn//jPB9YnscWSL+yuw9K5CKbmKLIlmUTS+AmWJUGvVmz8lq5bhq/baSDy4a+Qfa9Bgyw3pGj1yE+qAHLigi4Dxc4bUWr9/25mJTCoc2+kAwmoKqwh9si/m2vJAssB0Yh+PHZ/Wa9CQeHRsOFUXEnUE8dwM/IsRJvX+BxAVw6R6tLNfRlTZRmXYdjTHxQhwaCwU3Rf7gycvH4bFNlcGN8z3X3HI60EM6qTSVxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ/f9rUvSKxlzI3182rRik4In08y5+neqttwwsRRIjQ=;
 b=JDUdjD/q7o/jYwi+4RNqNSwjT0tSdqvvQLPna9lw5mvovLggn4RVjsHGrWSdqY71QFJ8ZgF12Fft1gjdLpO7dqZGD6KrtvxL+lrzTpVEXk6W1/tepydC+z90MthCcmICYjpLbqaBnzep9kP19U/WOigDWKyqpPaN5Yw7t+jLW70p/7/ZAwQ2GyM+NNS7mDaVsZrn98yQUWjK/ao9N+NXbQtE8odojXMTlixLBZFRx24dj5qPxVvxY3eOZzpz6SeHmtOtml1sESTZ61r+mjTTgPKQLPteoHYtRP3iQx4AYAP0W48lqikIhxNALJ0n71e3zMCAWe58xnhJW/xQ+DK+dA==
Received: from DM6PR12CA0029.namprd12.prod.outlook.com (2603:10b6:5:1c0::42)
 by BL0PR01MB4690.prod.exchangelabs.com (2603:10b6:208:7b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 19:15:03 +0000
Received: from DS1PEPF0000E64D.namprd02.prod.outlook.com
 (2603:10b6:5:1c0:cafe::4f) by DM6PR12CA0029.outlook.office365.com
 (2603:10b6:5:1c0::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 19:15:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 DS1PEPF0000E64D.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11 via Frontend Transport; Mon, 9 Jan 2023 19:15:01 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 309JF0Xx1478685;
        Mon, 9 Jan 2023 14:15:00 -0500
Subject: [PATCH for-next 1/3] IB/hfi1: Fix math bugs in hfi1_can_pin_pages()
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Mon, 09 Jan 2023 14:15:00 -0500
Message-ID: <167329170075.1478031.14048412547851558553.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <167329118368.1478031.13301737756220998277.stgit@awfm-02.cornelisnetworks.com>
References: <167329118368.1478031.13301737756220998277.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E64D:EE_|BL0PR01MB4690:EE_
X-MS-Office365-Filtering-Correlation-Id: ce3c47dd-004e-4b7d-c008-08daf275ceaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mGiadxDgrdAdsTg/ob1kj2jgltmezjRrhErsanJdwJqCr1Xe2lNp4ZtSKoJyNKEBQk2UlaUhXke2iQs9pvOgYVCGeBAdcnZEq4MmpZ5VkWDooe476+WELGq8fpc9TcyjpsmWvXXl1SlGkuzXbVQ7LXsAaDM5U971/KZBDEeofhkyZYSo4wxIzM/IGQhKK5+o8Sjz1UvC+IkJwctRVYPqrN5omgScbXfKBBYrDaI4Xi8QHoOZ66Bg0MGJh5tHVX7+wyJJBVXiShUGJjZNMI/J6DRs+1URure7VtukTBsz0KkAu2spAfWJkqHQ67zJV7R9MkNFTWG4Ke7+nrFYftzR9yNeOgElk193+YkTuWCqx6eL1HXbO2amkxP00Y9QshsCdW7Y0+FSNEmAcNpo7u8vL2uoeo0fX9aU3PQcZQHCe7L3/F5ZOAsGkqC47Y9HZQf3cbSS1Q91mF2Jq14j1QkL42f3asHWzw80pgKGwcNQ84vWC1s/zsIUtakRpstTkLV+yVhkof46aWRg8PnhpCcc18eGlvebt2x8qMuAeqP5bNrgXrj47uCG4eZIiGqsxQGSWrE4dkB/+NFy1OqdoXYFOPfrWsTt6GuzfJq/wUbi38g4/1jGr61J1uOZ8I28d1FfLTED5YFXtHnBK5LHSmdT/Lj019UEXxGCQVeBL48I4Hpr8qcrB+xDdqY+RbQTgDdzadlKfkVAON2B/syDWTBp+A==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39840400004)(136003)(376002)(396003)(346002)(451199015)(36840700001)(46966006)(36860700001)(356005)(2906002)(81166007)(478600001)(7126003)(103116003)(26005)(186003)(7696005)(44832011)(5660300002)(40480700001)(316002)(8936002)(83380400001)(86362001)(55016003)(82310400005)(426003)(41300700001)(47076005)(70206006)(54906003)(8676002)(70586007)(336012)(4326008)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 19:15:01.6410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3c47dd-004e-4b7d-c008-08daf275ceaf
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E64D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB4690
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

Signed-off-by: Brendan Cunningham <bcunningham@cornelisnetworks.com>
Signed-off-by: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/user_pages.c |   61 ++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_pages.c b/drivers/infiniband/hw/hfi1/user_pages.c
index 7bce963e2ae6..36aaedc65145 100644
--- a/drivers/infiniband/hw/hfi1/user_pages.c
+++ b/drivers/infiniband/hw/hfi1/user_pages.c
@@ -29,33 +29,52 @@ MODULE_PARM_DESC(cache_size, "Send and receive side cache size limit (in MB)");
 bool hfi1_can_pin_pages(struct hfi1_devdata *dd, struct mm_struct *mm,
 			u32 nlocked, u32 npages)
 {
-	unsigned long ulimit = rlimit(RLIMIT_MEMLOCK), pinned, cache_limit,
-		size = (cache_size * (1UL << 20)); /* convert to bytes */
-	unsigned int usr_ctxts =
-			dd->num_rcv_contexts - dd->first_dyn_alloc_ctxt;
-	bool can_lock = capable(CAP_IPC_LOCK);
+	unsigned long ulimit_pages;
+	unsigned long cache_limit_pages;
+	unsigned int usr_ctxts;
 
 	/*
-	 * Calculate per-cache size. The calculation below uses only a quarter
-	 * of the available per-context limit. This leaves space for other
-	 * pinning. Should we worry about shared ctxts?
+	 * Perform RLIMIT_MEMLOCK based checks unless CAP_IPC_LOCK is present.
 	 */
-	cache_limit = (ulimit / usr_ctxts) / 4;
-
-	/* If ulimit isn't set to "unlimited" and is smaller than cache_size. */
-	if (ulimit != (-1UL) && size > cache_limit)
-		size = cache_limit;
-
-	/* Convert to number of pages */
-	size = DIV_ROUND_UP(size, PAGE_SIZE);
-
-	pinned = atomic64_read(&mm->pinned_vm);
+	if (!capable(CAP_IPC_LOCK)) {
+		ulimit_pages =
+			DIV_ROUND_DOWN_ULL(rlimit(RLIMIT_MEMLOCK), PAGE_SIZE);
+
+		/*
+		 * Pinning these pages would exceed this process's locked memory
+		 * limit.
+		 */
+		if (atomic64_read(&mm->pinned_vm) + npages > ulimit_pages)
+			return false;
+
+		/*
+		 * Only allow 1/4 of the user's RLIMIT_MEMLOCK to be used for HFI
+		 * caches.  This fraction is then equally distributed among all
+		 * existing user contexts.  Note that if RLIMIT_MEMLOCK is
+		 * 'unlimited' (-1), the value of this limit will be > 2^42 pages
+		 * (2^64 / 2^12 / 2^8 / 2^2).
+		 *
+		 * The effectiveness of this check may be reduced if I/O occurs on
+		 * some user contexts before all user contexts are created.  This
+		 * check assumes that this process is the only one using this
+		 * context (e.g., the corresponding fd was not passed to another
+		 * process for concurrent access) as there is no per-context,
+		 * per-process tracking of pinned pages.  It also assumes that each
+		 * user context has only one cache to limit.
+		 */
+		usr_ctxts = dd->num_rcv_contexts - dd->first_dyn_alloc_ctxt;
+		if (nlocked + npages > (ulimit_pages / usr_ctxts / 4))
+			return false;
+	}
 
-	/* First, check the absolute limit against all pinned pages. */
-	if (pinned + npages >= ulimit && !can_lock)
+	/*
+	 * Pinning these pages would exceed the size limit for this cache.
+	 */
+	cache_limit_pages = cache_size * (1024 * 1024) / PAGE_SIZE;
+	if (nlocked + npages > cache_limit_pages)
 		return false;
 
-	return ((nlocked + npages) <= size) || can_lock;
+	return true;
 }
 
 int hfi1_acquire_user_pages(struct mm_struct *mm, unsigned long vaddr, size_t npages,


