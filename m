Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB4667BB8D
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jan 2023 21:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjAYUBx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Jan 2023 15:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbjAYUBt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Jan 2023 15:01:49 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2125.outbound.protection.outlook.com [40.107.237.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C171E298EF
        for <linux-rdma@vger.kernel.org>; Wed, 25 Jan 2023 12:01:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htHkkZbcqWwBjhtb7qoGZKGLP0tlfXtssRbuDWz41RRzHG1CSaKcdt4LcX2swNd4UFhUUgmxUozrTOT2FAi9YmEHzq2JaDJC4egjFNU/kmN1GRhsCSmvsXKz0OCMu4wlcDVUumkNRYlqp+9O6CMNf4ozTECLS6rDv4cqIoig+/aUZfPjdBX1hnxgTY1/aI9F0trWTWbsBP9VOpyXKe+i0Ln88HsLUreyrcix/PQ25ZrXDIWDEbgj5qwbIqmEEQd2zLQmkrjbG4zS2G4hZgG4S6ObetJAGPaB7i4CK9afVm4SkubDbYMvnJlKoskeoigxSsJdXZjDJ9ZUr9uE/M0Fhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5u35seL4Tp43whbztnAcDMAnLc+yBUzR4Y7XSRjiDs=;
 b=LncZZlL3QWN9Hta0jQ23C5auKzrZBTXXMjEH/y1mOv1MCdLAfFN37/siSyWE2hEUQ2SMiODVVYifRKI+Xh02y0TEpfp7JcagkKpO6A9csjcPa7PrFza93+mtAu5gonzV5vZmzrN3gvy0GxiOIQU43nB2V0Hc9MZsMTwcWYet7IZOmkJSK/4F96DB2ZGXYhucpR4jUbUrlbK7NKSBcJ3Oa/eM3qe4UN+GUJQiLeFBL+Kamkdr8I3YJaPh8ff59ODnNXLdzbBRH0/nPVuC95VyLl1tUxmSOsYjD+itjNIYhgfXOaFHcXvWxo6AeEpkiWS7GU8lOHB370kC+37ErmniHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5u35seL4Tp43whbztnAcDMAnLc+yBUzR4Y7XSRjiDs=;
 b=YmQIdhnPR0A69HGNuFxVpfVO0UbOZuahu+tRZKHWsUbCHp1qrvnVYS2d0gTxjSPhmTwU/gXJbPoRTBygoBjDktWSzWMElzIMRTI+yPsfY7u0JKxABTQbm8quN1aZpcY4m1rpvnjrSbxFIWKShmVfopaVHM7kh0rH06TG0nGdkD2CvtcZ72IlUb3RpvAU6t6qusnDbjX/rkc2IhqN9tKnqJ73smklMUTqlpDf+6Plf5wtVHoY2LpW5N7USLP2q7fF0gPdZt24zvTNZxAQobKViiiaznRxIHjVeja5cZq6FO2coj8UMV22jHg/Fdh75excPoXWLpZvrQ+gseysBT6xiQ==
Received: from MW2PR16CA0043.namprd16.prod.outlook.com (2603:10b6:907:1::20)
 by LV2PR01MB7720.prod.exchangelabs.com (2603:10b6:408:172::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Wed, 25 Jan 2023 20:01:46 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::7c) by MW2PR16CA0043.outlook.office365.com
 (2603:10b6:907:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21 via Frontend
 Transport; Wed, 25 Jan 2023 20:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.16 via Frontend Transport; Wed, 25 Jan 2023 20:01:45 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 30PK1iGc3649767;
        Wed, 25 Jan 2023 15:01:44 -0500
Subject: [PATCH for-next v2 2/3] IB/hfi1: Fix sdma.h tx->num_descs off-by-one
 errors
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Wed, 25 Jan 2023 15:01:44 -0500
Message-ID: <167467690409.3649436.3092170819675547492.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <167467667721.3649436.2151007723733044404.stgit@awfm-02.cornelisnetworks.com>
References: <167467667721.3649436.2151007723733044404.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|LV2PR01MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f13b3c8-f7e6-41b5-2f65-08daff0efc5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B0AWu0VfcghPX9/Pwt+qLSqt8qzNREAnZVn2Zcb08LU14ETXHtvPV6koPUqYXvkDl0tKD5n26d91cu/mKapP1TZxPnE06t0JB8fDIP5C9qflupaZd1C4/p/XQ8GPj9vwdRsJ2nuiTwmHwp1cDqWA31LA9HW+Q9h1T43vO2l30I/T5hjQcJcUfgbOgXhQa+xOk8cuHf+m504yni6mX9YOghmrw3H7VEsl0quo5V3uVYGvDH610oHlBkj3eqrL7kM20aSLfYteMQRQixFfOVfZxQTv9soUOID256o87E98DNYUyxVSUZ6d3XcdjTwyNFef1SdQMRCpgFKQVvDv9PMrAPss9xOv6cvBhjbHlhJEPXQPXFjMQ/qvtiHxh2LFQaRW6aMy5YF3IVVUvjA+8NsgaSpMS1CTSCsfYNiWGdS+yW9o1bCogK3IPD0R7ggnqPC9PWpH31/ldO3bV4fnvm3JzT6TrV7YF6GsD2ZJbRgLaYc+cBjgCzEwHomrLjNaEx7iiuv91qtANo99Pn71kV+uzoaNSe/OXJpgBFpfnEc/gh6BBdi3d0BZmCffSF6rdIIv0ux5Lp2x654aEtPe0mEBn7lLbGQT0IsrA+dp6Yln/XiuDNhzTK3psQHB1bwqWnFJgwWAzFHwgpum18ygFiZX+TtrzrVDOf2d6kNbhcslHUN7ljGKkVErJOPayQUhJ5f0438kO6jsFuVo7WRbWW7vTQ==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39840400004)(376002)(346002)(396003)(451199018)(36840700001)(46966006)(356005)(82310400005)(41300700001)(55016003)(4326008)(47076005)(26005)(7696005)(5660300002)(36860700001)(186003)(8936002)(40480700001)(2906002)(70206006)(70586007)(83380400001)(478600001)(54906003)(81166007)(336012)(316002)(44832011)(103116003)(426003)(86362001)(8676002)(7126003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 20:01:45.3283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f13b3c8-f7e6-41b5-2f65-08daff0efc5e
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7720
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

Signed-off-by: Brendan Cunningham <bcunningham@cornelisnetworks.com>
Signed-off-by: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
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
 


