Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E47662FD1
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 20:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbjAITEX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 14:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237535AbjAITEK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 14:04:10 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2118.outbound.protection.outlook.com [40.107.102.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CC138AF6
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 11:04:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2zxdYe6BkU4hdzjdXhqCKxF3dUvf8rPisjKHjb3cp1MOfbRel+i0vDi0rWVBnMQUBhtXOCNdHVg2hcKvrjrHQqbZGdMvd0x/9+kFYSxeb2gEHZdDYnyYVeLUzGdTGu0jMyuWVjSGj1S48TybCXnlLTnauAlI2FgFkd7oswhfuj3w++UJWGnvyId0f9hIMElxBGGRqiQu+uSsrHO+vT2RcmQa2Cq3GnSADu1IN1DfifjndlyDvLjNs9lemPe4uAyAd24txfSHBZ62l8Ku5OTbWSp7akX3qCyMZxbvq8igx8axuSAICeVDXFw+YeAPw/Gj+aD2c2FGiVrmn8B6xipwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2KykQ1QJG58t54DnoXH0Dsz3JHCsKv82SzoXNRmbXY=;
 b=JjxuCFSEpqe6RaeeNVVCR0OKg01zgOR8wTu10WHV5BYdV6ojxqcurFyg7s38VaTGTtgSkVkHOHiQbqOvp7x+5vX765Gta+p49L4NqrZD0etaBpKb0O++UIS65qljpt/8VUIWE2ugQvjGEDwwqdW9xZYWWh0Aq+slaup3UBDnIUo1Q5vKLIL3aVhRwUtN+ddAP8SDZFcGlFsEjhNM3Hdh3fhEAubRmK7kWc3+kHxe0bcj1LWJGSLTyTTS/SOcp3gv30vVCUlcx1+9wZathZVKA/FbOxYrZPS1tktGFnBx0W8hmj+g4S8+wcXYt16VwbnA5Dv+4b9035lMFbUwnEkJxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2KykQ1QJG58t54DnoXH0Dsz3JHCsKv82SzoXNRmbXY=;
 b=BR85GSryw3o1zHSM8IKy4kEfbmoVoFObXIlExFGInfkFm0NILEQYn6oW9qVp9EttxYv0p26FFE8uABzeYHmnJZtdI4b1+sYrY6MRQE/ahCecSYHLdTpcZ96qtSj00jQXtIvvOeF6X1mKPpad9s/Ljqz6FPtZYmzaQcwpSWfvReVEp3qawGdKnpJDTt/vR+qTF031Tef0XnRjsaMkbmlInYjM5Fqex6EID1Iv367L6wqqhZlv1pxPvRf6hK/umGM6mITZHVJ+9+nIQel1J513KkORwqizuTcepE/1sLoR0gSyqkhULyxVTgvUCLAtT6WFhhAMxiWj61ghpa4Rf3QA1w==
Received: from BN9P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::17)
 by DM5PR0102MB3384.prod.exchangelabs.com (2603:10b6:4:a4::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 19:04:04 +0000
Received: from BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::fb) by BN9P222CA0012.outlook.office365.com
 (2603:10b6:408:10c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 19:04:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 BN8NAM11FT077.mail.protection.outlook.com (10.13.177.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.17 via Frontend Transport; Mon, 9 Jan 2023 19:04:04 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 309J43bn1477904;
        Mon, 9 Jan 2023 14:04:03 -0500
Subject: [PATCH for-next 1/7] IB/hfi1: Remove redundant pageidx variable
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Mon, 09 Jan 2023 14:04:03 -0500
Message-ID: <167329104365.1472990.14264918308557487946.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
References: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT077:EE_|DM5PR0102MB3384:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea9f496-fd98-4fa9-ff23-08daf27446c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BSeT0byl2xgEC2o5ErcOR8Rn2v9iSk830JjJ449iaG8huEhG7/Ms8Pm/6wi6CUuGK9uGb8mY6QA/8gy0rb1E55NtA2yrcun1L5G6oaH4vPe4WgvsTcLy6i4zpkHjFXGGxFAE0CMBPb7d55OBo3hal2KVO4Pj3nbW7S7v3zkGNTFMoIacduc5DWvOc5wLet/2hXt/JMYtmkH7F0d9p8sJ3/GEBRFjOf1FXt2oa2tiTwpseN0oRd3AFzOUjnX8fkSbl4wJ21GouVXP7iWCZH5ClvIfvAgVY1yC0F6wugd+gC06o+UWp5vTGgvt4J7FhioS6r1LyuAXJfC41U7UBDMGvcceV9ewdI2+nzjwKKMkIs4rdAfSCdVtKfE74DZodW3VBHbSGgukLhJCEYh7gqFRlhPvNg3iF1vUrihPQe+4LAfhyIG/Ord2FB9XhD1s2n/KHPTM/uebBPTjgQilSgbKaMclHRBynEiRX7Rskh6jdaVpe0/jwlUpbwV+h4kCqX5TaCyWSXydKdNhtNx5qxlhKwfm05xyzOV1KFUPwmL36lyEpeI0MQqKdndJ1P07QcJNa+mn9htTFEmbdVSd+qlxmwj9mCCQ7IIZN5UsF3md5W97oEB4MvRFDNMon7/MEKh6S3xCqflAb8lGq5ysoCwYuoIMuVvEcsPA8bneUKFWUwNudc8FkZGJ2HR8vBusoTZvpVe5duZAh84cS8WRu47FIA==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39840400004)(396003)(346002)(451199015)(36840700001)(46966006)(103116003)(316002)(5660300002)(44832011)(40480700001)(26005)(7696005)(186003)(478600001)(7126003)(426003)(47076005)(41300700001)(336012)(4326008)(70206006)(70586007)(8676002)(82310400005)(8936002)(83380400001)(86362001)(55016003)(36860700001)(356005)(2906002)(81166007)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 19:04:04.3412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea9f496-fd98-4fa9-ff23-08daf27446c3
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0102MB3384
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

In hfi1_user_exp_rcv_setup(), variable pageidx mirrors
variable tididx.  Remove pageidx and its use as an argument
to program_rcvarray().

Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/user_exp_rcv.c |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index b02f2f0809c8..c2099510817c 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -27,8 +27,7 @@ static bool tid_cover_invalidate(struct mmu_interval_notifier *mni,
 			         const struct mmu_notifier_range *range,
 			         unsigned long cur_seq);
 static int program_rcvarray(struct hfi1_filedata *fd, struct tid_user_buf *,
-			    struct tid_group *grp,
-			    unsigned int start, u16 count,
+			    struct tid_group *grp, u16 count,
 			    u32 *tidlist, unsigned int *tididx,
 			    unsigned int *pmapped);
 static int unprogram_rcvarray(struct hfi1_filedata *fd, u32 tidinfo);
@@ -256,7 +255,7 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 	int ret = 0, need_group = 0, pinned;
 	struct hfi1_ctxtdata *uctxt = fd->uctxt;
 	struct hfi1_devdata *dd = uctxt->dd;
-	unsigned int ngroups, pageidx = 0, pageset_count,
+	unsigned int ngroups, pageset_count,
 		tididx = 0, mapped, mapped_pages = 0;
 	u32 *tidlist = NULL;
 	struct tid_user_buf *tidbuf;
@@ -337,7 +336,7 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 			tid_group_pop(&uctxt->tid_group_list);
 
 		ret = program_rcvarray(fd, tidbuf, grp,
-				       pageidx, dd->rcv_entries.group_size,
+				       dd->rcv_entries.group_size,
 				       tidlist, &tididx, &mapped);
 		/*
 		 * If there was a failure to program the RcvArray
@@ -353,11 +352,10 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 
 		tid_group_add_tail(grp, &uctxt->tid_full_list);
 		ngroups--;
-		pageidx += ret;
 		mapped_pages += mapped;
 	}
 
-	while (pageidx < pageset_count) {
+	while (tididx < pageset_count) {
 		struct tid_group *grp, *ptr;
 		/*
 		 * If we don't have any partially used tid groups, check
@@ -379,11 +377,11 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 		 */
 		list_for_each_entry_safe(grp, ptr, &uctxt->tid_used_list.list,
 					 list) {
-			unsigned use = min_t(unsigned, pageset_count - pageidx,
+			unsigned use = min_t(unsigned, pageset_count - tididx,
 					     grp->size - grp->used);
 
 			ret = program_rcvarray(fd, tidbuf, grp,
-					       pageidx, use, tidlist,
+					       use, tidlist,
 					       &tididx, &mapped);
 			if (ret < 0) {
 				hfi1_cdbg(TID,
@@ -395,11 +393,10 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 					tid_group_move(grp,
 						       &uctxt->tid_used_list,
 						       &uctxt->tid_full_list);
-				pageidx += ret;
 				mapped_pages += mapped;
 				need_group = 0;
 				/* Check if we are done so we break out early */
-				if (pageidx >= pageset_count)
+				if (tididx >= pageset_count)
 					break;
 			} else if (WARN_ON(ret == 0)) {
 				/*
@@ -643,7 +640,6 @@ static u32 find_phys_blocks(struct tid_user_buf *tidbuf, unsigned int npages)
  *	  struct tid_pageset holding information on physically contiguous
  *	  chunks from the user buffer), and other fields.
  * @grp: RcvArray group
- * @start: starting index into sets array
  * @count: number of struct tid_pageset's to program
  * @tidlist: the array of u32 elements when the information about the
  *           programmed RcvArray entries is to be encoded.
@@ -663,14 +659,14 @@ static u32 find_phys_blocks(struct tid_user_buf *tidbuf, unsigned int npages)
  * number of RcvArray entries programmed.
  */
 static int program_rcvarray(struct hfi1_filedata *fd, struct tid_user_buf *tbuf,
-			    struct tid_group *grp,
-			    unsigned int start, u16 count,
+			    struct tid_group *grp, u16 count,
 			    u32 *tidlist, unsigned int *tididx,
 			    unsigned int *pmapped)
 {
 	struct hfi1_ctxtdata *uctxt = fd->uctxt;
 	struct hfi1_devdata *dd = uctxt->dd;
 	u16 idx;
+	unsigned int start = *tididx;
 	u32 tidinfo = 0, rcventry, useidx = 0;
 	int mapped = 0;
 


