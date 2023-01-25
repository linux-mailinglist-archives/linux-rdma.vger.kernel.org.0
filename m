Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8208B67BB8C
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jan 2023 21:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbjAYUBv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Jan 2023 15:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbjAYUBp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Jan 2023 15:01:45 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7903C36
        for <linux-rdma@vger.kernel.org>; Wed, 25 Jan 2023 12:01:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjlnjoLK0lJ24uhUcFypueoxGFntk5VKUGZqMJttA0bbK5E7W7OI+jFUnRnN93lgqX6Rg7ICgolznuPJppsYUq8VO7YyAhVGGH4Yim65TjGfFU2H2PKa2qJQaLj8B/+2UOBJwRbGuxdZwVmDQJ/FvqxThn90GuY0rdxQG9g7E55rvGcl2Tp3VC9pLUwp3PskKuyIKY4rwJ5g08kjHdpeT+wMt+udyS8FKm8vtvWeHYeG9y77LZ3y7k8/ilVq0290D15WNGUUy9tgQbags97ULVHxQ0yvLeCjZe3EdsS10DOld295vdVpJxOm8KzOFWw7Y3EHxeE7bmaYZaf76vRfrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dM9MseBgXWG1G/IyFeNOfhoM5cS02jsRXcEkot0LenI=;
 b=n9w6PcQyB2yxRxGlnKk/cvUt6/v3bTGjlTc5ynSMUu5GFbnPdJq+Sc97XPkPt4j62xIdOQyl1MmJhXtHzPA1EAdKzKBBF+sb3CYM3cAXPSNR9nQ0QoOjotnk2L4s3SVNxIBNPye7fHNU6ElcqYF4wS5i6YCxF9kmbLQYeWQvW3mOHllPZgwhUAmkS6s+Av992mWzydpIOyHwNWicfwo/LLrHSOR9Ps6Wtb7LAYaPoYNiURXmYl/1Ru7GJ3kTK5NagBp217tUrDS7Ujtcwktiy09COKU14bEBy+1xK2h4dAX8QSpCH/SIhR8dJzGYKQDZhjtiuB1Uh0+oXraqmgb/Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dM9MseBgXWG1G/IyFeNOfhoM5cS02jsRXcEkot0LenI=;
 b=eJKyyj+ybxWbSj+S1HrBPT5zZ/BPz8/9K+2dYlCIBDjcWjiLNvHZEG8XNcEtdHh6Z4FY/gSkOFBEBQDzovYGCh1SgM7AyxgNFYEIUwt4rUn1rdnK/pkpdVSVWEEfwr0bPjexjFpMUTBPGjzTWIzi2ngbSomgDuueWa9dyGH2Y/vvCJ4YeGTTO0/2e0uBL3wvCfe8PtzL0G14Nfmt4RE2NDGctj/XYzDGdFnwHaBpY3MfHvXm5o6g/Q3dEA1HEp9jBONcUC8diy1viBaQ8jPu++jq+pMvO722MVgBSoPEfOT8Wm7jlMsEgtuKKvTWygZhxE/Eh1YpDsQfpTANEQo2VQ==
Received: from MW4PR03CA0323.namprd03.prod.outlook.com (2603:10b6:303:dd::28)
 by SN6PR01MB4815.prod.exchangelabs.com (2603:10b6:805:cf::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Wed, 25 Jan 2023 20:01:40 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::b7) by MW4PR03CA0323.outlook.office365.com
 (2603:10b6:303:dd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Wed, 25 Jan 2023 20:01:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.16 via Frontend Transport; Wed, 25 Jan 2023 20:01:40 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 30PK1cmR3649756;
        Wed, 25 Jan 2023 15:01:38 -0500
Subject: [PATCH for-next v2 1/3] IB/hfi1: Fix math bugs in
 hfi1_can_pin_pages()
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Wed, 25 Jan 2023 15:01:38 -0500
Message-ID: <167467689891.3649436.5979603883827786631.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <167467667721.3649436.2151007723733044404.stgit@awfm-02.cornelisnetworks.com>
References: <167467667721.3649436.2151007723733044404.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|SN6PR01MB4815:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3a00ab-fa99-4787-3ccb-08daff0ef93d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zi35fm6UPbFaxhSUnIOed9wh8oC3LDFlNukUQ2Y3UG870/AOkHsxJB6V0A4uY+vfm2b9L7NfhLHt+4mL+XSYaI5Qib+imJ6Gc8LOAVtPDQU+yWm0XESXAN/GJBuvSZ4/lCNXRXFFXw49H2BtbvgPdq9wwCNVSSWFfA//rey6QnVfsR4wmKMY76SLMIhe8q+TdoE0OAceff9nlWmSEBvG/cwRWBWjoI+REDvte6+5uvMXRiuCGp8zXYz7cidwFb27KwHX1MzvPX9mSB608pZZSyyXUiYeg78rXKA/yvK0wmGjT/yGoOMV5ERN+jeVVPCqUTB/Rk3ERB1O8GnzncGsR9quNFu10V4XU56jik7tXequR2GZ2PmhdC37xKDGa187xlbfGHsq0D3J1d7nih0RXCCESq6Z4yYFs+yPtVX/mruEVWIxOcvV2tfDrVNPbBJAFMPc1aGwt8zUZMEDH81lBq9qLdclT4ZTSKMHKn5JhoSnVUsdjQMs6i9DJzl/qY/YR6617yx2zXL7+0KRTpaAjntwOKCZGuyffxwP8kEiCA7bauFAOrhxJzXDr6ugfMH8yqjxA6ey5/ILV/7dUd+8THIDkFSFdAcXfr7yWloUL1UhYKxzyjFsIO2pJ8Zxql3dO+ep9VtAtGx3NbzBk3ns90fzJ5DblMs08q9QwGsjqL3/ZzPMN2zdKj2gL6xlfQOCGXM1X/VdXxEF5dWz96tBCQ==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(39840400004)(396003)(346002)(136003)(451199018)(36840700001)(46966006)(2906002)(36860700001)(81166007)(5660300002)(4326008)(83380400001)(7126003)(7696005)(316002)(54906003)(26005)(8936002)(41300700001)(55016003)(86362001)(40480700001)(44832011)(103116003)(356005)(478600001)(426003)(336012)(47076005)(70586007)(8676002)(186003)(70206006)(82310400005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 20:01:40.0792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3a00ab-fa99-4787-3ccb-08daff0ef93d
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4815
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

Fix arithmetic and logic errors in hfi1_can_pin_pages() that  would allow
hfi1 to attempt pinning pages in cases where it should not because of
resource limits or lack of required capability.

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


