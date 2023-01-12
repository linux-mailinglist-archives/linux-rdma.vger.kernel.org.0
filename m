Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869B2667E67
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jan 2023 19:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjALStv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Jan 2023 13:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbjALStS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Jan 2023 13:49:18 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2118.outbound.protection.outlook.com [40.107.96.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F0A82F70
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jan 2023 10:21:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ui5k2RUyJg6cBr9pfpb3FLOQFhxMvJXTSYLPUsUBoSNFRrUYfqlMcvGdD+BSkRiCUthskwyR/cTUSsv7dRW+FuNe8W3Gp02i1ZzCDXS1icqFT6gEY6Fwd9DaQKrMXa31fP0h5L8nWV3iZh3yDjW10Dlrurro1OkTDgU6C9YoURob7cs5v3lQg/2TK7A62ftWCRCITHSKVIxTxHKEvmGROezCxGvUrGbz5NbY65EWIoFBGJTNTaPDdP24rwTEeYt1Hnwp7r4qElDWyJ6bAE5tksawDTbGp/TqbIp2s1UuSeNd1xIkz845RA2bBtMkrT5s3poPI/oOExiIpFf0YTvYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9rRTk/OfyYHtOlVRfws165Ky+v0lgWfvaYYxkkYP6o=;
 b=UpFZTBmp0sx8/Wg8+AOBTYOu9+nUjcJp+n955BwrOdHe0iEu4DzukwNSk6VvjsHw9GV6CRCQ4olmNN1gkxg5V1vbeaPu3TqvKyHzEvSeOZis81arCzyNKBPlih+s5puHPmYIBk4TovD4dmbEMBPZsPeVki/3cH0d6bbLdOi/hk+gkbpkwzd1EK4kF1PKIQMU03qwAZrfDLa5liinkzSdBRBz08qIK2OWCCH3PKwiKhQPRKBSgaZsrSA1QWAVVI6iCovyFZu9eSArAlnAymP1UiY0uiE6Jcxs7WZyVwgln3xEDoo+/uMR2986SRBBGEU+yv5lu9er7TL+KKxvpA1pJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9rRTk/OfyYHtOlVRfws165Ky+v0lgWfvaYYxkkYP6o=;
 b=UIaxluX9w1XT3pr4rsOqezltlswS8LRM/wFhyyr61avRD+6RPNO2fIVex9cvk1wibM2Qly3anOdxBpYWt0RxWQRHWfJUi/2Mn+II6LSWe7HiybWP5hq44D5bh94mvABhP7vNLZ6cK1HuG3V8wXi099xREg4w3ceR20yGHpQgQtdJ9ZQxoOIo95h+19WDDWoexYChy+SPWqkqntJFI/1qDd2vRKAgtUOYwOMsVLAyJH4kgMW7YEofs38l9hZa/BsbTyVA3//EsBnH2kp5C0eZDf/SafqNnAZNjRCa8Ptj3L7Hy4+07ZzoLkMJWojCw/6rxpDt1+YWvnlw68JVu8whUA==
Received: from MW4PR04CA0050.namprd04.prod.outlook.com (2603:10b6:303:6a::25)
 by BL3PR01MB7178.prod.exchangelabs.com (2603:10b6:208:345::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Thu, 12 Jan 2023 18:21:51 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::5b) by MW4PR04CA0050.outlook.office365.com
 (2603:10b6:303:6a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Thu, 12 Jan 2023 18:21:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.12 via Frontend Transport; Thu, 12 Jan 2023 18:21:50 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 30CILnhU2132946;
        Thu, 12 Jan 2023 13:21:49 -0500
Subject: [PATCH for-next v2] IB/hfi1: Fix math bugs in hfi1_can_pin_pages()
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Thu, 12 Jan 2023 13:21:49 -0500
Message-ID: <167354770932.2132928.11030458831125514361.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <Y719rou2XS3HdVjY@nvidia.com>
References: <Y719rou2XS3HdVjY@nvidia.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|BL3PR01MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d7c4aff-cdd7-461a-a44d-08daf4c9dfeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TbOru7cisGrqEHwOUW4yy3Pnhv46FXWhwL/WuZv8Mx2LqDIUeS8zD4kySAask8DGM9s59jHYbcCj3KeeaGiu2pphbUdgD4wlWgIwvbnUX4egUjiwPHwm4aR/HuXdY0sRmIR6wlX7RWVYHW0XuxqjOGV5WLsebWCL4KkPhHh5kiRNJI8ZH5JPIXvaoGkWxHxvcAwBndyUMM0QPM2H2bnYKdB6cAgWSwMcWIdYLUlXbLHTXUG4gZb+pxvjXDTVKuqzxu5DJMCEr5737V5E2OD6daB2kR1+4MHOdV36XjvODh6BZzBp8FwmWfFcgimhyv+uQSp2I7ugD6/JjQITh/01UnoVvy92jux2WA3BlaiC43szAgA6aIyyqXb8L9VIsoP6NURzgCQMwij7+gTGhYU+hE0gfI8k7UhQICm1UB+IHhq67dJCHc1voFDB6sba7m5fDSJdfHcoTUj8sFtBvTwq7xyX7TkBjBGJ4q4wjSDcYv3+T7N9fPxGwSrGNiu6Aki46JU68RUhpc1txo2jK7SWA3OdsEaYxbiFXVgtbJuNXLxxH5JxUs+S3a2VokoQJEqdq85sKe+VIrVIb3FqugHE9y/JCNiWYKFgprQNm/zR3Hh4Yf8nSMwV5ibRu7F/17AiatLLIVnQn3nW1UcHOr/CmptUjovJCCYbi9FHU0it+JI0LYRvPlMboUOsItzzlmxyL3oJZJtcPtT4ktr3mhtaHw==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39840400004)(136003)(346002)(376002)(451199015)(36840700001)(46966006)(36860700001)(2906002)(70206006)(4326008)(5660300002)(8936002)(83380400001)(44832011)(8676002)(47076005)(478600001)(81166007)(356005)(41300700001)(103116003)(426003)(336012)(70586007)(40480700001)(26005)(82310400005)(186003)(7696005)(55016003)(86362001)(7126003)(316002)(54906003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 18:21:50.6993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7c4aff-cdd7-461a-a44d-08daf4c9dfeb
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7178
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
Changes since v1: Update commit message only.
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


