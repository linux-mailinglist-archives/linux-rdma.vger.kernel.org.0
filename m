Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92321699AA5
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Feb 2023 17:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjBPQ4i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Feb 2023 11:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBPQ4i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Feb 2023 11:56:38 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2126.outbound.protection.outlook.com [40.107.94.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCD82686D
        for <linux-rdma@vger.kernel.org>; Thu, 16 Feb 2023 08:56:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpq0iGORRFMLd5ZUM8EbiS3Nqg+H1zzQ65TuZ6rYeAUD/MGqGTCPLuTziFaaW754fidSZsPqWOX6bzBt+H9yQsC9JBRTJoFi+1b+jpHAytEQKb0A2Kp/s00ir15Q/vEmjnY6L+UY2lFPcLJJoHY5HhoJ2E4ss7Hp+fgHisYUPvS2J8rHMrvo6J0hW6DQJBzpH0O1ec860OScxneXleNZj9WW9zzv+zPxdAYb+vimUP5Jx2e6VlST1cn/JAWEihWFldcltYf3N/CeI4bJUKlJX8aJ73K4nYVhL4ALQdJvN/yR2uKivdmaT/GbCKfDD2edd4nFSNHteM3+smbKoIS1zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCxf/R3s4WfO+SeD/m5eM4lYgYcdEZojuXFabrdye28=;
 b=NlAr2fkz/knuxK+wQJfSw5JJPQMVKeiznTGzKBLOiSK7UkU7EvYe3K5VUTxn24CEQVr4rhgApBnTT8Qou4FvhWjvVCMgm7Hhh2xtCkhpHDv9CYrtuj3ry2Da4jRw2FQ4Hc2JDx08O3d4/d0/pspyIMGNG8eA8nCdndX+C6P00dYRjs/7gdk3p5IrvV+GLSzLwTppq8F/z4KJyqOqGnRD9RhxBPon5qHtyiwxb/tOEZ8bS2tL0jUf7YH3FfxSlJ+wgiV3izlMgeNGs45PfPW+R6G5kZgposbDAMxEDF26t2fSefGeTm7wfSPFNbB1HhoGAwntCgJshzEFVsnf3GZBTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCxf/R3s4WfO+SeD/m5eM4lYgYcdEZojuXFabrdye28=;
 b=Q/x+ZMb7oyLDWBC8nBbrQN8FGJYFvNTozoGP49eZ9ifHrPVp1lR6/cITkA1Js6qvyEqS9xWl0Y9c5pssqpnlpcDlrQ3sqx2yDTRx34MX3V33QZPD6v2pEW0oc+38COwKY1Z4mrVtsu4EdXT/wDzLTAVKFCS/jH4GuQMQtIIQyCu4Rjt/Txqfrkzvano+ItcSNQw8VHbjPhIQ8OrZUvKSf48nMd9kFztlJDFuLRzAvYFPCenfHyuuuSz0MAB6ztCeVHh9FyxEqam0FUx4Hwi/T80FdCMIL54BKYX2+RzRztyJkGfJ9CLNEL6KamMyguxio4boEFeOUJ+RpYZXk76EDw==
Received: from DS7PR03CA0020.namprd03.prod.outlook.com (2603:10b6:5:3b8::25)
 by MWHPR0101MB3005.prod.exchangelabs.com (2603:10b6:301:31::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Thu, 16 Feb
 2023 16:56:30 +0000
Received: from DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::11) by DS7PR03CA0020.outlook.office365.com
 (2603:10b6:5:3b8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13 via Frontend
 Transport; Thu, 16 Feb 2023 16:56:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 DM6NAM11FT112.mail.protection.outlook.com (10.13.173.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.13 via Frontend Transport; Thu, 16 Feb 2023 16:56:29 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 31GGuSq22223758;
        Thu, 16 Feb 2023 11:56:28 -0500
Subject: [PATCH for-next 2/3] IB/hfi1: Fix sdma.h tx->num_descs off-by-one
 errors
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Thu, 16 Feb 2023 11:56:28 -0500
Message-ID: <167656658879.2223096.10026561343022570690.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <167656602090.2223096.15523567129751109800.stgit@awfm-02.cornelisnetworks.com>
References: <167656602090.2223096.15523567129751109800.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT112:EE_|MWHPR0101MB3005:EE_
X-MS-Office365-Filtering-Correlation-Id: 6868d335-6cf7-4ef7-b9b1-08db103ec025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGK9HL+X8xYDW/1YYe63eN4SUlwBgkqlvq4ASp0VSEty3YD74AMNDvIa17uHBCHhXt/I/c/nbZ7k26pngP1OAP+Z/x6a9IjIs2peeGvPsMNNT5JKbMH+LupoofiKrdTTZL+hmCzfzvjuU0w+JhoRzeTyyouYgy9qV/KQ6pozWeSUyvojEliteop38xLVtW27M4QvEFnxytyEXhLqKRKjXe2/BU3Ut5hGIT5eApO/hBHIiXt1XXB3vaDsvELkFEnU9kFEGnMonnGkBSMV4Ss+vnZ4ovUMYq2RFszgLBe3OR21PtoGJek14K4PF6wj4JxCHU9R7ZyDMawsORBuvgEhzybTIHrrlt/EKn2ptNdOc2mqc88pInjG6LOp4IAa12rNub4YU2T2Ck/BUCLFzSzo3cZTp6855B+ep980C9iy2vi0sDD37Y4RqJy89PkIhZ4Ep5bvDezrW7yL0E+LFLNMDFDmy7zKxkqSaCSut17bUGns5mI2QyDctVT6iSfA5GgWEJ3Bc2JC9h7wh7PVrPuMTdU6EZ8gYLL6Gxq+/Bvj+yijJ3i2vSsmYekVmJM2In03JvJF1B6NkEGjdA8+2wwg5p8UuPim4byJvsGYUAnv9GzG+gukmbTuwajMceUS1l5e8xAYCZyyWKOTYz6TIAQs+nYLvXOS1Yqlbg0fS8huYlEChSDfYPrJGyup07mcb/x3WH8vYo1jXQUXfX5Bak/IRw==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39840400004)(376002)(136003)(451199018)(36840700001)(46966006)(5660300002)(2906002)(44832011)(186003)(26005)(426003)(478600001)(83380400001)(55016003)(47076005)(36860700001)(40480700001)(7126003)(356005)(316002)(70206006)(8676002)(54906003)(4326008)(8936002)(70586007)(336012)(41300700001)(81166007)(86362001)(103116003)(7696005)(82310400005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 16:56:29.9678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6868d335-6cf7-4ef7-b9b1-08db103ec025
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0101MB3005
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

Fix three sources of error involving struct sdma_txreq.num_descs.

When _extend_sdma_tx_descs() extends the descriptor array, it uses the
value of tx->num_descs to determine how many existing entries from the
tx's original, internal descriptor array to copy to the newly allocated
one.  As this value was incremented before the call, the copy loop will
access one entry past the internal descriptor array, copying its contents
into the corresponding slot in the new array.

If the call to _extend_sdma_tx_descs() fails, _pad_smda_tx_descs() then
invokes __sdma_tx_clean() which uses the value of tx->num_desc to drive a
loop that unmaps all descriptor entries in use.  As this value was
incremented before the call, the unmap loop will invoke sdma_unmap_desc()
on a descriptor entry whose contents consist of whatever random data was
copied into it during (1), leading to cascading further calls into the
kernel and driver using arbitrary data.

_sdma_close_tx() was using tx->num_descs instead of tx->num_descs - 1.

Fix all of the above by:
- Only increment .num_descs after .descp is extended.
- Use .num_descs - 1 instead of .num_descs for last .descp entry.

Fixes: f4d26d81ad7f ("staging/rdma/hfi1: Add coalescing support for SDMA TX descriptors"
Signed-off-by: Brendan Cunningham <bcunningham@cornelisnetworks.com>
Signed-off-by: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

---
Changes since v1:
Add fixes line
---
 drivers/infiniband/hw/hfi1/sdma.c |    4 ++--
 drivers/infiniband/hw/hfi1/sdma.h |   15 +++++++--------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index a95b654f5254..8ed20392e9f0 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -3160,8 +3160,7 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 {
 	int rval = 0;
 
-	tx->num_desc++;
-	if ((unlikely(tx->num_desc == tx->desc_limit))) {
+	if ((unlikely(tx->num_desc + 1 == tx->desc_limit))) {
 		rval = _extend_sdma_tx_descs(dd, tx);
 		if (rval) {
 			__sdma_txclean(dd, tx);
@@ -3174,6 +3173,7 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 		SDMA_MAP_NONE,
 		dd->sdma_pad_phys,
 		sizeof(u32) - (tx->packet_len & (sizeof(u32) - 1)));
+	tx->num_desc++;
 	_sdma_close_tx(dd, tx);
 	return rval;
 }
diff --git a/drivers/infiniband/hw/hfi1/sdma.h b/drivers/infiniband/hw/hfi1/sdma.h
index d8170fcbfbdd..b023fc461bd5 100644
--- a/drivers/infiniband/hw/hfi1/sdma.h
+++ b/drivers/infiniband/hw/hfi1/sdma.h
@@ -631,14 +631,13 @@ static inline void sdma_txclean(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 static inline void _sdma_close_tx(struct hfi1_devdata *dd,
 				  struct sdma_txreq *tx)
 {
-	tx->descp[tx->num_desc].qw[0] |=
-		SDMA_DESC0_LAST_DESC_FLAG;
-	tx->descp[tx->num_desc].qw[1] |=
-		dd->default_desc1;
+	u16 last_desc = tx->num_desc - 1;
+
+	tx->descp[last_desc].qw[0] |= SDMA_DESC0_LAST_DESC_FLAG;
+	tx->descp[last_desc].qw[1] |= dd->default_desc1;
 	if (tx->flags & SDMA_TXREQ_F_URGENT)
-		tx->descp[tx->num_desc].qw[1] |=
-			(SDMA_DESC1_HEAD_TO_HOST_FLAG |
-			 SDMA_DESC1_INT_REQ_FLAG);
+		tx->descp[last_desc].qw[1] |= (SDMA_DESC1_HEAD_TO_HOST_FLAG |
+					       SDMA_DESC1_INT_REQ_FLAG);
 }
 
 static inline int _sdma_txadd_daddr(
@@ -655,6 +654,7 @@ static inline int _sdma_txadd_daddr(
 		type,
 		addr, len);
 	WARN_ON(len > tx->tlen);
+	tx->num_desc++;
 	tx->tlen -= len;
 	/* special cases for last */
 	if (!tx->tlen) {
@@ -666,7 +666,6 @@ static inline int _sdma_txadd_daddr(
 			_sdma_close_tx(dd, tx);
 		}
 	}
-	tx->num_desc++;
 	return rval;
 }
 


