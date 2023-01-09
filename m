Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AC6662FD4
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 20:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237128AbjAITEY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 14:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbjAITET (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 14:04:19 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2099.outbound.protection.outlook.com [40.107.220.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06C03750A
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 11:04:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbcqOOmLLl5XnooB2gOGtFOk5UyZZOK8brN4KWR6fqKHHiI1e0kBBkM3hbBjLTtlIzMsM/WkkoRx7+/xE2sqvK5uYEM4ljQg4ZYg0nRSoHvV8gsHVamL328WA04HTJTHXTjkYmMuhrbBoSxPr36MT/tq1YaQRc3yCYWWEjvE+HyQCDVLAAY488rlYTIGy9GvV6kpKwvZAmXPRofJN4pZlOepbri0cwpQAO2H55fS8pvdJzjaHogJQozL3eZMZYORMDIAjMx9pdlBmj2dcQXepSgyBZQe4hIDhR4rkFfY1ThIu9wl2dEizwr5MU6l5L90yuK+zkDeK3QZRis/RLJUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rq8hUMv66znCK9moyrQos/tUEw1InqtcthJW316MBY=;
 b=k02rF2dYrUopfadHpmX7NboY2UEo9917zFNsalVRIs1opa4mS8y5FbhDJgc4QHiPUhOMt0Qbr5T33KQoLmfItyvPOod17tIMs4NXS+P2SJS+gDEV1kxQlzusozWXE9EVWlNh8S1m76rwI3ND+WmeB/ldDi5MYutPrDepnjXmfAbqSuy02dWJ0Apf2XPutVj8JRyBtcdXe+JB+f8l/LN27DfmUamYfsNnudROC6ike8HlL548WoKFdfntElVuY2Vjppce1F/rUn1HEEuDKi50aGtnczVL9fqYKb8Yomhflo3KrtXX0HUJ6zzflDXpJKpfhrZaW9pHxqGkVj4D6+ZKIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rq8hUMv66znCK9moyrQos/tUEw1InqtcthJW316MBY=;
 b=G8nIr2HmNvhwGHBAve2x9yr3bwiihIvU0/Q3srfpqomh1qD3FTjfFklKZD+Al9gBAtod5p1vOmrVAf0KFa/1oTIFj4b8B3DDlgMFrMTvIk1U+VUol9veIJPHtsN3IGsSYsCX4pgNwTD3iUScsc+qG/kdkAYTwzzMuC7bpeYgGz7Pt2dtqSmWwGP48D/CbvbjxKzRstB6DsdGtSpGtVaaRHfnpIMNGoDnf6cDkGxhK4sWXhf08Bc81H4z0vEXE0P4nkXrXqlkHAKyA37xryHmZ3JpD7DTOd8xmCiwIqH3LHXwlLe4h/trn8oRg93a2nF5nuA+YSxE7zGanZ0IJiM1ag==
Received: from BN9PR03CA0949.namprd03.prod.outlook.com (2603:10b6:408:108::24)
 by DM6PR01MB4953.prod.exchangelabs.com (2603:10b6:5:8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 19:04:15 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::b) by BN9PR03CA0949.outlook.office365.com
 (2603:10b6:408:108::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 19:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 19:04:14 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 309J4ER71477920;
        Mon, 9 Jan 2023 14:04:14 -0500
Subject: [PATCH for-next 3/7] IB/hfi1: Consolidate the creation of user TIDs
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Mon, 09 Jan 2023 14:04:14 -0500
Message-ID: <167329105402.1472990.9685946655723333660.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
References: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|DM6PR01MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: 2642d7d5-18ac-4cd2-6184-08daf2744cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aWacF+dLxxrhJBWAh+OoOrDt0P0F6RjYDY5Ggcu6z4R6G3W8n6aZgqjj7oLzE5CISqHcvZyQxFfg0+4povPg1FPyQQjIvMEe7YKC4MXUr1xVRrj0UgdvczLS94EzpY8ecY/ZZfkj4ZAEVma7pI5DCNmbYFuvsQ5cR00aGUPo5qL6Z/buBjdFHLDpBBQy/fNe5ldgAKp8SxVHAynIrPGRFloXTGn9u8sS76xp97rjehMS9HcmwSFp6jFDepQMimiKjdbRvPGzxK3X2hSejm8ZI9MSWNnV3bHk/SdMh30Ib6TBoJpc3XdEGJVoM4mvzr5uBU1megIMk6UimQxT/5G1RNhzU/Em/hiUpUDoLDCqXvSrBwPDXLTIHUJMmlmU50xjYUPedSaBg+euJny/JXPYeUrQwYfR0SbvSEpYLJqPYVOv8qiiQF1E5Cb/Ccs+TfdqfKT73IbOwgC6xol2mdQiBQJh42yRENrArqkpriPR9JrPvUO+dd+tRC2i6nI+y1mv/7s4fo8i9uweiOqU6tVeIR/0AfTh/Fn973S7su04zEA4ANnSVv24dEVtYFK1OWux7JfoQqE9Qsyl1sYu+GbziOALTV/9crIf+AJcIjEd173yX6mubHz1F9T093XenrNfMV/Ag42PhJ1YzYIqGPM38JeVGo3RGtMf1MPMy4jhrdqsB/PXsTvl/IebsMyd62d2KDG4eR/081pO7JEhOf8QSg==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39840400004)(451199015)(46966006)(36840700001)(82310400005)(8936002)(2906002)(5660300002)(47076005)(426003)(41300700001)(81166007)(7696005)(70206006)(4326008)(70586007)(8676002)(316002)(356005)(44832011)(186003)(26005)(40480700001)(7126003)(336012)(55016003)(86362001)(83380400001)(36860700001)(103116003)(478600001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 19:04:14.7901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2642d7d5-18ac-4cd2-6184-08daf2744cfe
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4953
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

The function rcventry2tidinfo() only creates part of
a TID and all calls to it are only used to make a user
TID.  Consolidate all usage into a single routine.

Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/exp_rcv.h      |    5 +++--
 drivers/infiniband/hw/hfi1/user_exp_rcv.c |    8 +++-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/exp_rcv.h b/drivers/infiniband/hw/hfi1/exp_rcv.h
index c6291bbf723c..41f7fe5d1839 100644
--- a/drivers/infiniband/hw/hfi1/exp_rcv.h
+++ b/drivers/infiniband/hw/hfi1/exp_rcv.h
@@ -133,12 +133,13 @@ static inline struct tid_group *tid_group_pop(struct exp_tid_set *set)
 	return grp;
 }
 
-static inline u32 rcventry2tidinfo(u32 rcventry)
+static inline u32 create_tid(u32 rcventry, u32 npages)
 {
 	u32 pair = rcventry & ~0x1;
 
 	return EXP_TID_SET(IDX, pair >> 1) |
-		EXP_TID_SET(CTRL, 1 << (rcventry - pair));
+		EXP_TID_SET(CTRL, 1 << (rcventry - pair)) |
+		EXP_TID_SET(LEN, npages);
 }
 
 /**
diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index 0e51c95d3f1d..0229cf210431 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -706,8 +706,7 @@ static int program_rcvarray(struct hfi1_filedata *fd, struct tid_user_buf *tbuf,
 			return ret;
 		mapped += npages;
 
-		tidinfo = rcventry2tidinfo(rcventry - uctxt->expected_base) |
-			EXP_TID_SET(LEN, npages);
+		tidinfo = create_tid(rcventry - uctxt->expected_base, npages);
 		tidlist[(*tididx)++] = tidinfo;
 		grp->used++;
 		grp->map |= 1 << useidx++;
@@ -916,9 +915,8 @@ static bool tid_rb_invalidate(struct mmu_interval_notifier *mni,
 	spin_lock(&fdata->invalid_lock);
 	if (fdata->invalid_tid_idx < uctxt->expected_count) {
 		fdata->invalid_tids[fdata->invalid_tid_idx] =
-			rcventry2tidinfo(node->rcventry - uctxt->expected_base);
-		fdata->invalid_tids[fdata->invalid_tid_idx] |=
-			EXP_TID_SET(LEN, node->npages);
+			create_tid(node->rcventry - uctxt->expected_base,
+				   node->npages);
 		if (!fdata->invalid_tid_idx) {
 			unsigned long *ev;
 


