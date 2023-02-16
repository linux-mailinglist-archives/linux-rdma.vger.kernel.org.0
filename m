Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD32699AA4
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Feb 2023 17:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBPQ4d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Feb 2023 11:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPQ4d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Feb 2023 11:56:33 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2134.outbound.protection.outlook.com [40.107.220.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20D02684F
        for <linux-rdma@vger.kernel.org>; Thu, 16 Feb 2023 08:56:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOStEe2RadQ65IQ/WV3sR0WJ1uWFNMeUtXeIIT+9RCbMNyjeUl3Eg/7g8RqWksVTUBOu7LEEHYf7O0ZUOGEsv97EuNj4qty6jReGVFLXZ1VEDPor4kb/iknrn6mUzVivHRyqpTapCknFacDgf3cmplSdypRMVs0QuDNICvsbUqS5w2KZM2AlE6ko5X+BNi0ObyzA+fr/Qr7ANb75lN5zLMV5gwTIX1YXocPwcCgs1LuxZ9YmSQzEfs/ZAd+rWs5XvUSsLTLfoqh9qlSzQeVru3InZG0BAKMGuR39A0G0OKsgVUShjSIDvkNXQcBzsz/mPhDL60oHxZE7m3nUifv0ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZuii7T04AdNZrOb19UEm4lGZ260L+Q6K6jfJDbUuDw=;
 b=TKQuwZoBvluSDjvNKHeKLUUfkyw24Eb6XO07x7aWfWdPJigvqJ+MjifLsDBLPO8gLJ0Hkfg8SULRtV8LC6kow+bhe8KOSNTm4BZ3FNY70ewaWqbgATJFFoHKk8kqA4Q4WtcPPsbQnguaHdPMSNcE8wcf192maDYvVCeiadoFp40hIM253wJi6IyqatwRn6Wj58qjFQ4OpXNlWlD2m3WUycXBHVsFd2qdiFlotSc9bG+RtyrxX3pbbcQW7IXEYy4DNChXt93DCsAgun81+PxJ05R7PyQEZa+G+DvCijtqxjFenXUoEwsTVY9AVAYxVyzQWFTvqEOaIc9Cq1/iIfX4eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZuii7T04AdNZrOb19UEm4lGZ260L+Q6K6jfJDbUuDw=;
 b=UOK2KzJw+F06bBxcUNpRQpK33K0S9b0sBAPwERQZtl0HXTH0B4qoOtm3cXxLtoBA6274A3QiuyffPrRy7DBO280eRl+s+YUIIjucjnCqz5xjVhjPr8PeLI084nl6sPw/3g6MxU9yO0jh8VdmT03wKcOXFPpceV/x1UITjlsF+26V1jmAUSUzyRmUDfb7qdX3uWplfU5zkWZ2u+/fy1pY0muAZzqLtRC/OaUNW5Cmhbby4drf3jF6/wRK9CoZmbVNA01HjtF4xct7+iHz+GglwlZalXcV5Gzywt6R1kcYbIptk4mILF9TO+dtb2B3KXhGqaRnwTJzEwxL9HaVm8asbQ==
Received: from MW4PR03CA0124.namprd03.prod.outlook.com (2603:10b6:303:8c::9)
 by BL3PR01MB7116.prod.exchangelabs.com (2603:10b6:208:33b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.13; Thu, 16 Feb 2023 16:56:25 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::1a) by MW4PR03CA0124.outlook.office365.com
 (2603:10b6:303:8c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13 via Frontend
 Transport; Thu, 16 Feb 2023 16:56:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.13 via Frontend Transport; Thu, 16 Feb 2023 16:56:24 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 31GGuNXb2223749;
        Thu, 16 Feb 2023 11:56:23 -0500
Subject: [PATCH for-next 1/3] IB/hfi1: Fix math bugs in hfi1_can_pin_pages()
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Thu, 16 Feb 2023 11:56:23 -0500
Message-ID: <167656658362.2223096.10954762619837718026.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <167656602090.2223096.15523567129751109800.stgit@awfm-02.cornelisnetworks.com>
References: <167656602090.2223096.15523567129751109800.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|BL3PR01MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 84951e08-df1b-4264-1dec-08db103ebd14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 00PLBThob8EvI19dmOfCvDqqySj1ET1kd1oB2cxFCNvQooW7fwzTydGHhAGwGZtdz7cIv4I+C+DyLXUeRM0lKkcgJOb5/+5SgGBcc5h8kaOixqSAPp7DSRSYk3gV1Y9DIF32rSGKY+MeLl6ZLKMeRBxXclX0Wy1GTisXFYYRN3MuAPz6WzmolMDAmKMrAUl/pzl+2hRvz6HySyJSrpg+EUVUpVaq+RurKYklahXnUz6uPe2IsbQ0Y8qvTxgAWNlaT5hXrholQzTXmcNmLzUsW8R36pE05ysbMlA8s7x71pmUMwkyef1D3iVIxiM8dHrsmAwpWXhXIKeGNBzNc+2enfmRSnJHz9EO99bmitaiRhlD/c62Nue6pRJNCGcq+WsY7RSosY8EoEbFS4TAOpgh14QJDSkveTz33qswIvYEH7dFs7d/StIaLJVsRkoH8dT+aWMWJ7s9kvSlOHkx6y29I4Y9a+T11gMwdZr8vMljk8yb+EcR12SHcYvMuknV8Z7fEU8PyrBu3MFOyexZKp8kYMH09YO7swAVevcBHwFfpOdwiHdYe0+pruWA8mLPOx0eTRr9hEAG61yLUMeOKxWtCb+Clh7C5KF16UGS/Ou1cLZ/FAUlqFDT/orG3vFOVSEm9Q/xZKFRFERjggj/3OeUQ2vxekhBzmheHfdLfTNPgEYUL86EN/I2sT14Guid5nwP4wTcdx+KM9KMxnUmiG+HMQ==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(39840400004)(376002)(396003)(136003)(451199018)(46966006)(36840700001)(36860700001)(86362001)(356005)(81166007)(103116003)(44832011)(5660300002)(70586007)(8676002)(70206006)(4326008)(55016003)(2906002)(8936002)(82310400005)(7126003)(336012)(26005)(186003)(83380400001)(47076005)(426003)(54906003)(316002)(41300700001)(7696005)(478600001)(40480700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 16:56:24.7567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84951e08-df1b-4264-1dec-08db103ebd14
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7116
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

Fixes: 2c97ce4f3c29 ("IB/hfi1: Add pin query function")
Signed-off-by: Brendan Cunningham <bcunningham@cornelisnetworks.com>
Signed-off-by: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

---
Changes since v1: Add fixes line
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


