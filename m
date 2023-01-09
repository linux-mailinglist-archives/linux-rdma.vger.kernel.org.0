Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8EE662FD7
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 20:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbjAITEf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 14:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbjAITEe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 14:04:34 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2106.outbound.protection.outlook.com [40.107.96.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6EC32EA2
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 11:04:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hU9HastQRX0khIGXpM+9kXKqt+6d7CJtp19uAJ1z1Ce7TcHeBPlavJSMHZouPT4wvRgqHhjjr+mkOqP1gwz1jEFxDdLCbH5ehBwt5BK2sq7vIZI1deO9RQnf64kUDatRrLCNh0CCA3ZVE1CDbkabBKZdT6uQMSB+SpPNvs3/p8U4Kt1j1CTOc6036k/UGjlAQHzw/u3sY8dwPfguDujvRPn5lhXIbPnY9bqyq1L5zomKNw2rMbjP1mA5APt+Q0PAxdkpcmU7WWyHVpfASif2hJMw/6FzgiLhnzg7BFh/spX2yzkNllBCeWM4yg1+fAWuvA/Yoxdg18/Z1Z7yYe8Ujw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qy28ws4X2FxSiPV+NgaKBr6iU8xsmGUdCP6dSpvcwaE=;
 b=ZqjFQqdZlSqB4yqlQAvFip9tW7kGjYXHKcbC8CpoqicV1HmjYxLQ9i3fb5UDf5doeKIfFh+ZZ9nsxy9tdgBeSfCa86k02au1nd5EbxOgRdjzc7AhmIioUBCUjhXJbEeG9/eVOBdgMJibsFN6PrPnDhl7UFKS09OGp8/Ttqv8yzyIFvOfJYr/UqQURiXRlah75jLeFaWby9blvSs7oY1TKsIyRuHsmJBVOoOj9V+PzSTebhJ9TmCo7DyZjuCbxA93xqX0L/Elq1ffC52yLbXaAbI1LaStAZhGY1qPoC/FAYcIdfh1tcuocKbSXrvVbPGfHCCkuwXr5jw2QrsagLp5KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qy28ws4X2FxSiPV+NgaKBr6iU8xsmGUdCP6dSpvcwaE=;
 b=J/Tko96TLCHRUfeCrNGMbX21ciwdfmbtF0vkBN84w4zxnOOfDzXM5d4yJul5mjpJGNeI1iuy/gnsYALoixtujYKHJH5trMM3w5lWc358ZPxJfbZ7wV4G5Y78tsTe8chGW4+0fkjMC0lx5bMvDbHcoDxSJ8Nxswt5jGX2k2nNlU+uxy6/eEzx0yXuwXnOn9GNia48/UuW9qC83nNUj3jRERySipAEdI7rFOHfnVNuqjhpJ3+tMwdTzTbdjoYRMiuPxLfMFM+iZm0h4aedY/6mEAldHRdodTc54eiQy/FIwHDQw5SeUWPNaspZfjT9sJWWsyVJyk/sbHzfA5JMLMQglw==
Received: from MW4PR04CA0357.namprd04.prod.outlook.com (2603:10b6:303:8a::32)
 by MN2PR01MB5472.prod.exchangelabs.com (2603:10b6:208:113::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 19:04:31 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::df) by MW4PR04CA0357.outlook.office365.com
 (2603:10b6:303:8a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 19:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.6 via Frontend Transport; Mon, 9 Jan 2023 19:04:30 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 309J4TDO1477945;
        Mon, 9 Jan 2023 14:04:29 -0500
Subject: [PATCH for-next 6/7] IBh/hfi1: Update RMT size calculation
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Mon, 09 Jan 2023 14:04:29 -0500
Message-ID: <167329106946.1472990.18385495251650939054.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
References: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT047:EE_|MN2PR01MB5472:EE_
X-MS-Office365-Filtering-Correlation-Id: ff91af65-5048-4965-973b-08daf274567e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZmfo7ElmClcl2gQpQ8aM4UCLFPnC4IGAP/In02Ri3D7QC14rItXL/5FjY5xw8cmddJrUsyzIBuZLo6BcKERERp1WLTtvZPCXADs7im4/4t2ZL9aRJD98MyEcMLiryJWY5SI6WF56iIV0MjsQbdj9F47TXnSnFYfQPuPggxm1TabKcfEy4+044W+i1GtbPWLM58trZHA4G4FmcJDr2Z7ZFHXPH0wMiL4ePnkgPLsZZdGSAJPD2/ge+qcqsW4mal8xsshNbFfD3ZxWVhaR6W3y0WedeeB60nKajzHXHBEgHTqdN7IPd4vccnq38rdIm3VtcGLu//oMBPbNkUo+G3j9/Ww7WetyeAIzcM2RzS/guvIKU6mECCYogmEJO9/VBZAoNI3hSNBuvdoBRnGzeHeImnZa9RAbYFPEfHIJMzQqc5vKUsBgzN0hfxofk3bJZNOFSdU7yEBMzz17nEYmqPoTOZpAlR2fPXsknI4oSCwOJ9/F6+wPPxIKVORCvvLuBaJX+66l2NfI47xoyP0jly6gnnnqrP2mzZ4lUjEeE0GRS83w0DLKaoloYkbLEw52kDNYwf3Yej7yyaLo/fgnes5phCPHKDb1VKLa614lMfwnzWgVgRBu0anx5cVSYHyrk09PqXZ58QsKLtDqs4krhBTEW7+lesFtRQkyIGwl/0HZTC/VY51VH076M1MVtL3ZTrC7ag/7Hz6TB5XCc+kroGVJw==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39840400004)(376002)(346002)(451199015)(36840700001)(46966006)(82310400005)(2906002)(15650500001)(8936002)(44832011)(5660300002)(41300700001)(70586007)(8676002)(70206006)(7696005)(316002)(4326008)(103116003)(478600001)(26005)(40480700001)(186003)(336012)(55016003)(7126003)(426003)(86362001)(47076005)(36860700001)(83380400001)(356005)(81166007)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 19:04:30.6049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff91af65-5048-4965-973b-08daf274567e
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR01MB5472
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

Fix possible RMT overflow:  Use the correct netdev size.
Don't allow adjusted user contexts to go negative.

Fix QOS calculation: Send kernel context count as an argument since
dd->n_krcv_queues is not yet set up in earliest call.  Do not include
the control context in the QOS calculation.  Use the same sized
variable to find the max of krcvq[] entries.

Update the RMT count explanation to make more sense.

Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/chip.c |   59 ++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index ebe970f76232..90b672feed83 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -1056,7 +1056,7 @@ static void read_link_down_reason(struct hfi1_devdata *dd, u8 *ldr);
 static void handle_temp_err(struct hfi1_devdata *dd);
 static void dc_shutdown(struct hfi1_devdata *dd);
 static void dc_start(struct hfi1_devdata *dd);
-static int qos_rmt_entries(struct hfi1_devdata *dd, unsigned int *mp,
+static int qos_rmt_entries(unsigned int n_krcv_queues, unsigned int *mp,
 			   unsigned int *np);
 static void clear_full_mgmt_pkey(struct hfi1_pportdata *ppd);
 static int wait_link_transfer_active(struct hfi1_devdata *dd, int wait_ms);
@@ -13362,7 +13362,6 @@ static int set_up_context_variables(struct hfi1_devdata *dd)
 	int ret;
 	unsigned ngroups;
 	int rmt_count;
-	int user_rmt_reduced;
 	u32 n_usr_ctxts;
 	u32 send_contexts = chip_send_contexts(dd);
 	u32 rcv_contexts = chip_rcv_contexts(dd);
@@ -13421,28 +13420,34 @@ static int set_up_context_variables(struct hfi1_devdata *dd)
 					 (num_kernel_contexts + n_usr_ctxts),
 					 &node_affinity.real_cpu_mask);
 	/*
-	 * The RMT entries are currently allocated as shown below:
-	 * 1. QOS (0 to 128 entries);
-	 * 2. FECN (num_kernel_context - 1 + num_user_contexts +
-	 *    num_netdev_contexts);
-	 * 3. netdev (num_netdev_contexts).
-	 * It should be noted that FECN oversubscribe num_netdev_contexts
-	 * entries of RMT because both netdev and PSM could allocate any receive
-	 * context between dd->first_dyn_alloc_text and dd->num_rcv_contexts,
-	 * and PSM FECN must reserve an RMT entry for each possible PSM receive
-	 * context.
+	 * RMT entries are allocated as follows:
+	 * 1. QOS (0 to 128 entries)
+	 * 2. FECN (num_kernel_context - 1 [a] + num_user_contexts +
+	 *          num_netdev_contexts [b])
+	 * 3. netdev (NUM_NETDEV_MAP_ENTRIES)
+	 *
+	 * Notes:
+	 * [a] Kernel contexts (except control) are included in FECN if kernel
+	 *     TID_RDMA is active.
+	 * [b] Netdev and user contexts are randomly allocated from the same
+	 *     context pool, so FECN must cover all contexts in the pool.
 	 */
-	rmt_count = qos_rmt_entries(dd, NULL, NULL) + (num_netdev_contexts * 2);
-	if (HFI1_CAP_IS_KSET(TID_RDMA))
-		rmt_count += num_kernel_contexts - 1;
-	if (rmt_count + n_usr_ctxts > NUM_MAP_ENTRIES) {
-		user_rmt_reduced = NUM_MAP_ENTRIES - rmt_count;
-		dd_dev_err(dd,
-			   "RMT size is reducing the number of user receive contexts from %u to %d\n",
-			   n_usr_ctxts,
-			   user_rmt_reduced);
-		/* recalculate */
-		n_usr_ctxts = user_rmt_reduced;
+	rmt_count = qos_rmt_entries(num_kernel_contexts - 1, NULL, NULL)
+		    + (HFI1_CAP_IS_KSET(TID_RDMA) ? num_kernel_contexts - 1
+						  : 0)
+		    + n_usr_ctxts
+		    + num_netdev_contexts
+		    + NUM_NETDEV_MAP_ENTRIES;
+	if (rmt_count > NUM_MAP_ENTRIES) {
+		int over = rmt_count - NUM_MAP_ENTRIES;
+		/* try to squish user contexts, minimum of 1 */
+		if (over >= n_usr_ctxts) {
+			dd_dev_err(dd, "RMT overflow: reduce the requested number of contexts\n");
+			return -EINVAL;
+		}
+		dd_dev_err(dd, "RMT overflow: reducing # user contexts from %u to %u\n",
+			   n_usr_ctxts, n_usr_ctxts - over);
+		n_usr_ctxts -= over;
 	}
 
 	/* the first N are kernel contexts, the rest are user/netdev contexts */
@@ -14299,15 +14304,15 @@ static void clear_rsm_rule(struct hfi1_devdata *dd, u8 rule_index)
 }
 
 /* return the number of RSM map table entries that will be used for QOS */
-static int qos_rmt_entries(struct hfi1_devdata *dd, unsigned int *mp,
+static int qos_rmt_entries(unsigned int n_krcv_queues, unsigned int *mp,
 			   unsigned int *np)
 {
 	int i;
 	unsigned int m, n;
-	u8 max_by_vl = 0;
+	uint max_by_vl = 0;
 
 	/* is QOS active at all? */
-	if (dd->n_krcv_queues <= MIN_KERNEL_KCTXTS ||
+	if (n_krcv_queues < MIN_KERNEL_KCTXTS ||
 	    num_vls == 1 ||
 	    krcvqsset <= 1)
 		goto no_qos;
@@ -14365,7 +14370,7 @@ static void init_qos(struct hfi1_devdata *dd, struct rsm_map_table *rmt)
 
 	if (!rmt)
 		goto bail;
-	rmt_entries = qos_rmt_entries(dd, &m, &n);
+	rmt_entries = qos_rmt_entries(dd->n_krcv_queues - 1, &m, &n);
 	if (rmt_entries == 0)
 		goto bail;
 	qpns_per_vl = 1 << m;


