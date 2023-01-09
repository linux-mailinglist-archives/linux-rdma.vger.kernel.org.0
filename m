Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E917662CCA
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 18:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjAIRcQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 12:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237450AbjAIRbe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 12:31:34 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2095.outbound.protection.outlook.com [40.107.94.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673211AD9B
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 09:31:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxhA8xaTZvQ/DXnJ/WeabJKB0xVwsBkGovAEQfJsLA+UZdi4l0x4CBGFnMwcLZI0eA0JE2NiIrVo+9knifxt9ZX6G0Bw9u61X+duEWHIQqTL6kzgV80Cj3ibbnAedZ2QcVKLpj+dyg19ogoXEqdH5fdGU3mtlZWnVZrdxtntqlVGxnxKrKvOiOOlYVCsYNTTBXrFhO3dpmSTtD756qJuN0WOeeNciEK6CZqn9WTo3gfC4izLns6vHsOE6L3LN8V/q9UUXWTqqirfUXVBwTiu0h0sgTiUVsDUSXMu0ks7Gi9xy4hj/d4munjj8Tfa7mbGG04zqLhHUA/CMDRK/4AJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DEWAf8QVcGJU9hBCwApXzw/3hU0O1Hc4bHLQf4ThCU=;
 b=mypbuO78uRv48Jf1dfD+IhhfggY9vx0V7JlCvaOmW1yBRd4kU/h97unt72YF5Y1u6xb7kWrE9SJYWlIbbPDZvvGyKGI9mUcTuMh2nQ0cpovnTjTiE681pahyxQY7nbM3ZBPre/lAHfA4ij+kBE7aJO0LwakAtUwNGFBXtbgtM1DkKQQ+UzdBpDebydzmshEkfwTzR2TettXet+MPdEvQAXpLwut04w/TPHrS2Q+gHAPabmQ+hv2o4Z7WWnBlCatvBPydYlBlm9WZihE53qDPwOrQ5gco7OvNW9Z3q4TdYUqmc2YiyfPfFZUFsH/YnoUp4lNls0GL9cvPKeNulGj8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DEWAf8QVcGJU9hBCwApXzw/3hU0O1Hc4bHLQf4ThCU=;
 b=XlrzUr0uzrRnpXFRi8MrabnNcVv6sj/PSFyvlMowLGtp7PVeMcRa5zSHx/p4Q0Bfdb+ARleP43rqMmeUlkclSwmh7yMgSJ254RUmxNpVlX6KfWROSUjPP2aH1snOmr9SHF0n9wydeDNVYqhdyPw6S5WPYleiPE6o7EbMAVPdo+nZ/5xMEKz/p8Rg0WR41QnaDF9PHkG0sl2OR3i7FMZEjpuWkx6dznfjXMS59+zbWxeidr+EzxN/2dqxRiwwb16cosoy+Hg6AemvrMGL7mnVFJ+jMdns62DsPATDNSOaqhmSCs34BUG3zL9Ehk+1lQK6kIHs+xgv39nglWW3oxqB+g==
Received: from BL1PR13CA0291.namprd13.prod.outlook.com (2603:10b6:208:2bc::26)
 by CO1PR01MB6616.prod.exchangelabs.com (2603:10b6:303:da::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 17:31:28 +0000
Received: from BL02EPF00010206.namprd05.prod.outlook.com
 (2603:10b6:208:2bc:cafe::82) by BL1PR13CA0291.outlook.office365.com
 (2603:10b6:208:2bc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11 via Frontend
 Transport; Mon, 9 Jan 2023 17:31:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 BL02EPF00010206.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.15 via Frontend Transport; Mon, 9 Jan 2023 17:31:27 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 309HVQEe1472615;
        Mon, 9 Jan 2023 12:31:26 -0500
Subject: [PATCH for-rc 5/6] IB/hfi1: Immediately remove invalid memory from
 hardware
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Mon, 09 Jan 2023 12:31:26 -0500
Message-ID: <167328548663.1472310.7871808081861622659.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <167328512911.1472310.3529280633243532911.stgit@awfm-02.cornelisnetworks.com>
References: <167328512911.1472310.3529280633243532911.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010206:EE_|CO1PR01MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: 50aacbc9-f748-4e75-ec96-08daf26756bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JQdLgAkaOAq00vlLZ74PdjdqQ815ypFfxh8CsYxri/z18UsI6cE8Hv18I0/BSyGvRrO17D59q8cFnGtCXN5UUz/vM7N8xXUu9eHXc5mUn8cisR+aKvXeqAC9GFUTxLymPZrmAWrwMI1wAgSOOaNADs3HgNc+0ezESHPd50Eg79ro0gJhYLch1Z4KkyqlSFAz5NGNxZL1XoaIoZ1KpE/0rZaCMJlG3SRsZZlztT3zTJRBKv5EQtiJRd0PnF8cuRlL/v4NLraAhMzI3DMt0brehXlAClUyRVQn2GquSY+e7DoP+T9aV+onh5VErGTw0AKa4spLLQOADpQM36+sNR1RqIQUEhnqs+8CERNOg4tvvTQ4iD3dA9Ek8Y51D3oYis+oJxHeBmn5Igwy72loyUay91r1mrAAQ9Woa44KImvh3/Hh4zVu8lgp95KRu52cITZAidjvXtdHKLovii1IgzyGlUfQbnXVtq4W60mSh/Lz4ahG8x8+0x9EcM5Fivwy2EL6KsyDIsZSquRbCKlwH3bwX6bl9Wme5PTEZchyC2cB33Y89hIrSb414txiq0UXBkEGwbGi5F/x9VA5tClWAHaYYVfcQ/GJ2Bh5p0EHagO1Gis8ceGQif+RHvM4LiLLNZUvifpcWFVpsxaOa73UslH4jMOFCx/wecvafEtJdWYg0HgTkwsrbXsDwF5CylPEHRiml+DW5OPx960W5lCQyS3cCtYSsuMiqWHWaUsZqikRtxM=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39840400004)(136003)(451199015)(36840700001)(46966006)(103116003)(41300700001)(4326008)(83380400001)(8676002)(70206006)(70586007)(5660300002)(8936002)(26005)(55016003)(40480700001)(186003)(356005)(7126003)(336012)(81166007)(7696005)(478600001)(86362001)(36860700001)(316002)(82310400005)(426003)(47076005)(2906002)(44832011)(14773001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 17:31:27.5755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50aacbc9-f748-4e75-ec96-08daf26756bf
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6616
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

When a user expected receive page is unmapped, it should be
immediately removed from hardware rather than depend on a
reaction from user space.

Fixes: 2677a7680e77 ("IB/hfi1: Fix memory leak during unexpected shutdown")
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/user_exp_rcv.c |   43 ++++++++++++++++++++---------
 drivers/infiniband/hw/hfi1/user_exp_rcv.h |    1 +
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index 88df8ca4bb57..f402af1e2903 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -28,8 +28,9 @@ static int program_rcvarray(struct hfi1_filedata *fd, struct tid_user_buf *,
 			    unsigned int start, u16 count,
 			    u32 *tidlist, unsigned int *tididx,
 			    unsigned int *pmapped);
-static int unprogram_rcvarray(struct hfi1_filedata *fd, u32 tidinfo,
-			      struct tid_group **grp);
+static int unprogram_rcvarray(struct hfi1_filedata *fd, u32 tidinfo);
+static void __clear_tid_node(struct hfi1_filedata *fd,
+			     struct tid_rb_node *node);
 static void clear_tid_node(struct hfi1_filedata *fd, struct tid_rb_node *node);
 
 static const struct mmu_interval_notifier_ops tid_mn_ops = {
@@ -469,7 +470,7 @@ int hfi1_user_exp_rcv_clear(struct hfi1_filedata *fd,
 
 	mutex_lock(&uctxt->exp_mutex);
 	for (tididx = 0; tididx < tinfo->tidcnt; tididx++) {
-		ret = unprogram_rcvarray(fd, tidinfo[tididx], NULL);
+		ret = unprogram_rcvarray(fd, tidinfo[tididx]);
 		if (ret) {
 			hfi1_cdbg(TID, "Failed to unprogram rcv array %d",
 				  ret);
@@ -723,6 +724,7 @@ static int set_rcvarray_entry(struct hfi1_filedata *fd,
 	}
 
 	node->fdata = fd;
+	mutex_init(&node->invalidate_mutex);
 	node->phys = page_to_phys(pages[0]);
 	node->npages = npages;
 	node->rcventry = rcventry;
@@ -762,8 +764,7 @@ static int set_rcvarray_entry(struct hfi1_filedata *fd,
 	return -EFAULT;
 }
 
-static int unprogram_rcvarray(struct hfi1_filedata *fd, u32 tidinfo,
-			      struct tid_group **grp)
+static int unprogram_rcvarray(struct hfi1_filedata *fd, u32 tidinfo)
 {
 	struct hfi1_ctxtdata *uctxt = fd->uctxt;
 	struct hfi1_devdata *dd = uctxt->dd;
@@ -786,9 +787,6 @@ static int unprogram_rcvarray(struct hfi1_filedata *fd, u32 tidinfo,
 	if (!node || node->rcventry != (uctxt->expected_base + rcventry))
 		return -EBADF;
 
-	if (grp)
-		*grp = node->grp;
-
 	if (fd->use_mn)
 		mmu_interval_notifier_remove(&node->notifier);
 	cacheless_tid_rb_remove(fd, node);
@@ -796,23 +794,34 @@ static int unprogram_rcvarray(struct hfi1_filedata *fd, u32 tidinfo,
 	return 0;
 }
 
-static void clear_tid_node(struct hfi1_filedata *fd, struct tid_rb_node *node)
+static void __clear_tid_node(struct hfi1_filedata *fd, struct tid_rb_node *node)
 {
 	struct hfi1_ctxtdata *uctxt = fd->uctxt;
 	struct hfi1_devdata *dd = uctxt->dd;
 
+	mutex_lock(&node->invalidate_mutex);
+	if (node->freed)
+		goto done;
+	node->freed = true;
+
 	trace_hfi1_exp_tid_unreg(uctxt->ctxt, fd->subctxt, node->rcventry,
 				 node->npages,
 				 node->notifier.interval_tree.start, node->phys,
 				 node->dma_addr);
 
-	/*
-	 * Make sure device has seen the write before we unpin the
-	 * pages.
-	 */
+	/* Make sure device has seen the write before pages are unpinned */
 	hfi1_put_tid(dd, node->rcventry, PT_INVALID_FLUSH, 0, 0);
 
 	unpin_rcv_pages(fd, NULL, node, 0, node->npages, true);
+done:
+	mutex_unlock(&node->invalidate_mutex);
+}
+
+static void clear_tid_node(struct hfi1_filedata *fd, struct tid_rb_node *node)
+{
+	struct hfi1_ctxtdata *uctxt = fd->uctxt;
+
+	__clear_tid_node(fd, node);
 
 	node->grp->used--;
 	node->grp->map &= ~(1 << (node->rcventry - node->grp->base));
@@ -871,10 +880,16 @@ static bool tid_rb_invalidate(struct mmu_interval_notifier *mni,
 	if (node->freed)
 		return true;
 
+	/* take action only if unmapping */
+	if (range->event != MMU_NOTIFY_UNMAP)
+		return true;
+
 	trace_hfi1_exp_tid_inval(uctxt->ctxt, fdata->subctxt,
 				 node->notifier.interval_tree.start,
 				 node->rcventry, node->npages, node->dma_addr);
-	node->freed = true;
+
+	/* clear the hardware rcvarray entry */
+	__clear_tid_node(fdata, node);
 
 	spin_lock(&fdata->invalid_lock);
 	if (fdata->invalid_tid_idx < uctxt->expected_count) {
diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.h b/drivers/infiniband/hw/hfi1/user_exp_rcv.h
index 8c53e416bf84..2ddb3dac7d91 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.h
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.h
@@ -27,6 +27,7 @@ struct tid_user_buf {
 struct tid_rb_node {
 	struct mmu_interval_notifier notifier;
 	struct hfi1_filedata *fdata;
+	struct mutex invalidate_mutex; /* covers hw removal */
 	unsigned long phys;
 	struct tid_group *grp;
 	u32 rcventry;


