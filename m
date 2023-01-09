Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26BA662CCB
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 18:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbjAIRcR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 12:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237472AbjAIRbl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 12:31:41 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2126.outbound.protection.outlook.com [40.107.92.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E38B70
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 09:31:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CX/JeJyCZ8y6tvhXs3Ehh9CiO+eU/19lG1c8y5+jD6xyC7/4zWLv24muRHQ6Ghkue+aJgfe6LBpXybh+wZw3psbMZjdOh+7Riq77Kostv91byF61+cnJbY9DBN+MhWyc5CAkVfWCPJVNTwACbbb5vEXjsVPRTqmYbZLGF/s2LJvKACAUxapZLOQbS5Z1s0/5RYy6ofvGys9isBGYkKUHAkSYVBzjNNAqt7q5W/km4uRkATHgx3jN5/DXwoXyvlt5LQUsAPu+6RoL/PxpGm32EqXJUSYHLnZbrqawyMY3EqLNLT1jqotNIJK5kW/0E2BsHYXt4nShNfEl1n1Jv6BnKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWHxjjSGrA1VujlrgEPpdNoPmLLlOYYVETSIr2Eqjlo=;
 b=bKyLeRn3lcTtoqO4hNnXarhiWS2PbjVgRG9sdktXD6xhTt9gIkMGYwKb1MVgUub1YRdaLsv/i7QuKDPh5h0pPn8Q2cwFk3PII9tQqyz4mAk8lNE/MowTs6iqFw7Q/5jPtlXi5T6irmxVM8LYbR0HfpZhp03l+FMbqDtjsOvZ3il4Va7VDgPK16YPs+ysvWzEO1zGZ4NnFz19Txgrj5v1tlZR7BL+DDrPs5pKwK5KyT2hi3gCisDFu+c7Bl8FB0ftGmuQegRxex5EyWCK3bzR/yJsJYntFLR9XUp7ZAz/ON5PCa7G+hCw2OIzLUYdmhI8MOlv7EaDEM4UE4d/xAALcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWHxjjSGrA1VujlrgEPpdNoPmLLlOYYVETSIr2Eqjlo=;
 b=RMdng6yELmkWdzAW8encjPPSX1hE/+XBXmY0eceMsWO/TW5GcncyXUHPAPbrb15r2Sba+7gtG+LJ3biR7xkjMED4x7xuwhLMbdRKgYUVppkSIIHHMUqB9TgIxWV1cdNlDgZc4c+5azqpVLPkZ2iizZShi6uIGaTsATh0sxhrkhhotVruVGCdSt+FiBmkuNzR4FCzISZA8f1QJ+lA/Mg2qeowLWGh05px9ULLvK0P7R3hJiPFCX5167O2Db+T2TUctz6Fnu8B2Q+kl0wRV5/k30tGxsCnDA2yEwjB9U27RASz4Oo4RFsnI8E3hs2gDAfYMlGwFcyRDEG9U5wh/zspWQ==
Received: from BL1PR13CA0248.namprd13.prod.outlook.com (2603:10b6:208:2ba::13)
 by SJ0PR01MB6176.prod.exchangelabs.com (2603:10b6:a03:29c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 17:31:34 +0000
Received: from BL02EPF00010209.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::4e) by BL1PR13CA0248.outlook.office365.com
 (2603:10b6:208:2ba::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.6 via Frontend
 Transport; Mon, 9 Jan 2023 17:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 BL02EPF00010209.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.15 via Frontend Transport; Mon, 9 Jan 2023 17:31:32 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 309HVV7C1472625;
        Mon, 9 Jan 2023 12:31:31 -0500
Subject: [PATCH for-rc 6/6] IB/hfi1: Remove user expected buffer invalidate
 race
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Mon, 09 Jan 2023 12:31:31 -0500
Message-ID: <167328549178.1472310.9867497376936699488.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <167328512911.1472310.3529280633243532911.stgit@awfm-02.cornelisnetworks.com>
References: <167328512911.1472310.3529280633243532911.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010209:EE_|SJ0PR01MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: e65188c3-2a6e-480c-f2a8-08daf26759e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Or42fr9YDVpTtjhSivcrh17Zpod66l0ogVnzJJ9uVxUntuQsBrhey7sn1sFxljvl5Xnl4soP8Fli/DkYcg41sZEsWJPI3zzAUs6kWqA4L+fh6F9uau61Fh5qpp8D9gvNydr5oClRW6mktDOeoKO32lrKIS0fnKqBfBkii2UWY+gcEFyaBrO30qsMqa+KwIKjfAt6WxyaYmeWYpnvFj8sMpbjF7Tzcn5XqkVhQIykffuJyUApFvDyjdsH3hpJn5IAr7U2iQGpNWwHoPvNr+wtBRzqY4apS1c0P6/MPiRBA7uuSn6jh9b2tZNlTTXITUt0/svut2JFwtWMvg06vdSqaHRyqlzeAATfG7ouBIdXLYtqkwqqI3tAcXaMMLq9EFT5zfhIzxYREOth4ESOm+syb8haArpidEFAELPmGTdVBdCx9Mex0r6hqpeWbnosnOrXgAyl27yFECmdC+LJhANVHN/5JvfIwBBLhoQbj8NhN0D58282BnNQF7G3ygpWh8r5RcVojbCOyQCoT1TfbUsBvG5hZWjmZ1rJhX9CIsw+4slKUYwdUAHsoldiP/RbXW4QkxJob3B6+bDSPFqBK3VQh+WtoQ9yYFs9/T5A62/H6VOwNRjkmuLR87qf2oYRNwC5ROHTaAedQs1a+BAMpuePcJmuL/g9oOWOwuzaH4fbpHcCsB761YtUu7pzqCQVQNrGnHAInpMDtSKssu3w2RjQkw==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39840400004)(396003)(451199015)(36840700001)(46966006)(41300700001)(7696005)(478600001)(86362001)(70206006)(70586007)(40480700001)(8936002)(5660300002)(4326008)(2906002)(26005)(186003)(8676002)(55016003)(356005)(336012)(7126003)(83380400001)(426003)(44832011)(47076005)(36860700001)(103116003)(82310400005)(81166007)(316002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 17:31:32.8942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e65188c3-2a6e-480c-f2a8-08daf26759e1
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6176
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

During setup, there is a possible race between a page invalidate
and hardware programming.  Add a covering invalidate over the user
target range during setup.  If anything within that range is
invalidated during setup, fail the setup.  Once set up, each
TID will have its own invalidate callback and invalidate.

Fixes: 3889551db212 ("RDMA/hfi1: Use mmu_interval_notifier_insert for user_exp_rcv")
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/user_exp_rcv.c |   58 +++++++++++++++++++++++++++--
 drivers/infiniband/hw/hfi1/user_exp_rcv.h |    2 +
 2 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index f402af1e2903..b02f2f0809c8 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -23,6 +23,9 @@ static void cacheless_tid_rb_remove(struct hfi1_filedata *fdata,
 static bool tid_rb_invalidate(struct mmu_interval_notifier *mni,
 			      const struct mmu_notifier_range *range,
 			      unsigned long cur_seq);
+static bool tid_cover_invalidate(struct mmu_interval_notifier *mni,
+			         const struct mmu_notifier_range *range,
+			         unsigned long cur_seq);
 static int program_rcvarray(struct hfi1_filedata *fd, struct tid_user_buf *,
 			    struct tid_group *grp,
 			    unsigned int start, u16 count,
@@ -36,6 +39,9 @@ static void clear_tid_node(struct hfi1_filedata *fd, struct tid_rb_node *node);
 static const struct mmu_interval_notifier_ops tid_mn_ops = {
 	.invalidate = tid_rb_invalidate,
 };
+static const struct mmu_interval_notifier_ops tid_cover_ops = {
+	.invalidate = tid_cover_invalidate,
+};
 
 /*
  * Initialize context and file private data needed for Expected
@@ -254,6 +260,7 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 		tididx = 0, mapped, mapped_pages = 0;
 	u32 *tidlist = NULL;
 	struct tid_user_buf *tidbuf;
+	unsigned long mmu_seq = 0;
 
 	if (!PAGE_ALIGNED(tinfo->vaddr))
 		return -EINVAL;
@@ -264,6 +271,7 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 	if (!tidbuf)
 		return -ENOMEM;
 
+	mutex_init(&tidbuf->cover_mutex);
 	tidbuf->vaddr = tinfo->vaddr;
 	tidbuf->length = tinfo->length;
 	tidbuf->psets = kcalloc(uctxt->expected_count, sizeof(*tidbuf->psets),
@@ -273,6 +281,16 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 		goto fail_release_mem;
 	}
 
+	if (fd->use_mn) {
+		ret = mmu_interval_notifier_insert(
+			&tidbuf->notifier, current->mm,
+			tidbuf->vaddr, tidbuf->npages * PAGE_SIZE,
+			&tid_cover_ops);
+		if (ret)
+			goto fail_release_mem;
+		mmu_seq = mmu_interval_read_begin(&tidbuf->notifier);
+	}
+
 	pinned = pin_rcv_pages(fd, tidbuf);
 	if (pinned <= 0) {
 		ret = (pinned < 0) ? pinned : -ENOSPC;
@@ -415,6 +433,20 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 	unpin_rcv_pages(fd, tidbuf, NULL, mapped_pages, pinned - mapped_pages,
 			false);
 
+	if (fd->use_mn) {
+		/* check for an invalidate during setup */
+		bool fail = false;
+
+		mutex_lock(&tidbuf->cover_mutex);
+		fail = mmu_interval_read_retry(&tidbuf->notifier, mmu_seq);
+		mutex_unlock(&tidbuf->cover_mutex);
+
+		if (fail) {
+			ret = -EBUSY;
+			goto fail_unprogram;
+		}
+	}
+
 	tinfo->tidcnt = tididx;
 	tinfo->length = mapped_pages * PAGE_SIZE;
 
@@ -424,6 +456,8 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 		goto fail_unprogram;
 	}
 
+	if (fd->use_mn)
+		mmu_interval_notifier_remove(&tidbuf->notifier);
 	kfree(tidbuf->pages);
 	kfree(tidbuf->psets);
 	kfree(tidbuf);
@@ -442,6 +476,8 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 	fd->tid_used -= pageset_count;
 	spin_unlock(&fd->tid_lock);
 fail_unpin:
+	if (fd->use_mn)
+		mmu_interval_notifier_remove(&tidbuf->notifier);
 	if (pinned > 0)
 		unpin_rcv_pages(fd, tidbuf, NULL, 0, pinned, false);
 fail_release_mem:
@@ -740,11 +776,6 @@ static int set_rcvarray_entry(struct hfi1_filedata *fd,
 			&tid_mn_ops);
 		if (ret)
 			goto out_unmap;
-		/*
-		 * FIXME: This is in the wrong order, the notifier should be
-		 * established before the pages are pinned by pin_rcv_pages.
-		 */
-		mmu_interval_read_begin(&node->notifier);
 	}
 	fd->entry_to_rb[node->rcventry - uctxt->expected_base] = node;
 
@@ -919,6 +950,23 @@ static bool tid_rb_invalidate(struct mmu_interval_notifier *mni,
 	return true;
 }
 
+static bool tid_cover_invalidate(struct mmu_interval_notifier *mni,
+			         const struct mmu_notifier_range *range,
+			         unsigned long cur_seq)
+{
+	struct tid_user_buf *tidbuf =
+		container_of(mni, struct tid_user_buf, notifier);
+
+	/* take action only if unmapping */
+	if (range->event == MMU_NOTIFY_UNMAP) {
+		mutex_lock(&tidbuf->cover_mutex);
+		mmu_interval_set_seq(mni, cur_seq);
+		mutex_unlock(&tidbuf->cover_mutex);
+	}
+
+	return true;
+}
+
 static void cacheless_tid_rb_remove(struct hfi1_filedata *fdata,
 				    struct tid_rb_node *tnode)
 {
diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.h b/drivers/infiniband/hw/hfi1/user_exp_rcv.h
index 2ddb3dac7d91..f8ee997d0050 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.h
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.h
@@ -16,6 +16,8 @@ struct tid_pageset {
 };
 
 struct tid_user_buf {
+	struct mmu_interval_notifier notifier;
+	struct mutex cover_mutex;
 	unsigned long vaddr;
 	unsigned long length;
 	unsigned int npages;


