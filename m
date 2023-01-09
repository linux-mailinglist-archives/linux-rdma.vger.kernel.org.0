Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCC166301B
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 20:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbjAITPP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 14:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbjAITPM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 14:15:12 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2128.outbound.protection.outlook.com [40.107.92.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F717BDD
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 11:15:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScIFMofvzegCAOXDze8KhLQEVvfr3QR1+LTramsq5KJwZSiqKefXy3ayU4nf7AzkSFlS3XU6QProME2Pzz34LCZZHnZVDAWfx5x42yRHi25Ak5HLr+K5rSbVjcmGRKwOziLYTLg0PzmZwPBCfKyKjn5S/qFY68A1pywbPLmYOGdPDsYCy1g0aALtZCX92vJB+MXevc7yKSW6X4I/bXLxUmqX+qn7C7q1+pksHgK0wJvIoU7FgrnnGTRTWWxNYWdZQOK8xamLsoXbwvlky5QqWarn78dzhFmaBHsXTqnkWJCxPHc8fPMKvTcSKXlxoIxsDbIyMiol807g64xg92fYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQefB2E+jAZU4n3Sl5j5YOydiAlVxm8ySHtskLlCmIs=;
 b=iEFPBBJHpYG35JQaY4T7YuXpUvieEdv3WUxcDq7/onc3DIPQfmnZ0G0IC6rS72cm7eKzLnCxuVJvisKQ54qWCi3TX/YYAd6lB/kG5E0Z/FjCXXpOqPLOtqK7SY/y4TxXlAKjc92riVBJj/esHrTIWrEkEXAXBVBxwDhrIKOhPtJT/wZQ4nfIuuVofTtJTUr0oHybha6YBJ3xwfb62O3diixhiemp/Xy9smLxA6DbfAFX+xNciQU4eWXe0BkzDBWoDSl47QuMTA9aGMjMSXt/sKEuXKhwtVSgErzt2vDJLmrlmUzXvp7Uhqz+ZW8DSVXrHYfhRGCQkqLVcehwcM1yFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQefB2E+jAZU4n3Sl5j5YOydiAlVxm8ySHtskLlCmIs=;
 b=PpNgEYmTLWGLJTJFizxP0ON7hIAVBifbcNVEPHJ/VJljlMAcorB6dX1tVS168q/1XTtoyqbQHLQQazpcm3sbE5ZAgZ9eLnBzkk4JlnomXEom9kmVQLIhx1fYRF0TjfWJQBD7Y75nVPvJ68Eowo+zuAcXrActH0RQaq7fClRWtGCPo252O51Txkq6LF7oPbM00yIc3GAhaxJhv2GHys8Rd6wv2zCBEFl60xIAsESAQwC1kqP4Naw/12+422ZAjNdlGBqXzbyVZw3p34Wu2pJ3SUIkp4xGEFx2+V/0dhCjpcuJVLkZRn6f+bBNSRuzM5TINdjTGfKWhBQJfabxjBRS5w==
Received: from DM6PR03CA0065.namprd03.prod.outlook.com (2603:10b6:5:100::42)
 by DM5PR0102MB3511.prod.exchangelabs.com (2603:10b6:4:a9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 19:15:08 +0000
Received: from DS1PEPF0000E65C.namprd02.prod.outlook.com
 (2603:10b6:5:100:cafe::bd) by DM6PR03CA0065.outlook.office365.com
 (2603:10b6:5:100::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 19:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 DS1PEPF0000E65C.mail.protection.outlook.com (10.167.18.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11 via Frontend Transport; Mon, 9 Jan 2023 19:15:06 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 309JF52u1478694;
        Mon, 9 Jan 2023 14:15:05 -0500
Subject: [PATCH for-next 2/3] IB/hfi1: Fix sdma.h tx->num_descs off-by-one
 errors
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Mon, 09 Jan 2023 14:15:05 -0500
Message-ID: <167329170592.1478031.675303361955824810.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <167329118368.1478031.13301737756220998277.stgit@awfm-02.cornelisnetworks.com>
References: <167329118368.1478031.13301737756220998277.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E65C:EE_|DM5PR0102MB3511:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a83f02-83ca-483d-391d-08daf275d1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eIbwWMCQdN3pgratUUuHG/Lrl+qYej6RPGZHnAc/iJ3+fUa/U9biPj89E13k9T24V3hYdY/fCwIpHQugEtKk0MzkhLx+b2dlvgBCQxNXt2DUdKVa+EhALUTOct8pTtTKtibkprZ/ni53Q3bDB/+yAvSyUOH0OblhmejcrKYGLxENYIghi5SOMA1nuZ2aux0R8CttQnu7gTLk477b6aIvTrxy4X1n+uLGqUjUBYpDOzo5IcFf0WC2So+s+L3vr4Im9VIspVJaBm6cfO4fH8EwdLF7e/YyQtuFuyGDfGYIwqiSmLoDgBgOzzLosmqzQ5j1MRIlLcWef5+kIfNlj2tesdk/iOlD9JM9ZU/03W4rGrKFWpED5UPUjAjU+459LN9H6d3lTpcK7rMEqHEq1GwgsyTb9J/pPCoRmMr5zlNa2JIKgF55Jt1g/X28F3Qnp6Kqk8xKY8BICEYXez4NBLtPDFnfChhNuO0IqBmQ88iMwyuDoAh0StPU/rW+pGf+iO5PJHbXuAiBlqBgN+Nz0qn8dzn3GUPIBJoL2Ur2i185oQ+0IV59/JbPTYuTFimnVxCNnlakZ9rF+1KFHN40zXBOqGxYEk154T2OtVvsUdOuPi4JFtS0ZwPKezd7AC5XFajikH04NhHbFus/pme5Ox6VRVghi2mKtb/FzShGbHFV/5wSyiQnas0vplQ1bjNlxM/MGp7wTm2fG0IIsomLE0J20A==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39840400004)(376002)(396003)(136003)(346002)(451199015)(36840700001)(46966006)(44832011)(8936002)(5660300002)(82310400005)(83380400001)(86362001)(478600001)(186003)(26005)(7696005)(356005)(81166007)(70586007)(70206006)(40480700001)(36860700001)(55016003)(8676002)(4326008)(336012)(103116003)(2906002)(316002)(426003)(7126003)(41300700001)(47076005)(54906003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 19:15:06.9288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a83f02-83ca-483d-391d-08daf275d1d4
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E65C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0102MB3511
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
 


