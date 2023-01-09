Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71A9662FD5
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 20:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbjAITE2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 14:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237323AbjAITE0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 14:04:26 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2099.outbound.protection.outlook.com [40.107.220.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A72D3750A
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 11:04:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJ2SpCvf1/TEMDsfqio9yWB2kICh69UWDoa9menCFW75ckUShNuhF0AcD+Ff8GEHHVtRTsHQo/6j2aEA/jrQ1YAyBDPhkndqeeMKIRG6mlx1IQuwvc7lZm8jrcutzBqO164jfLryuhL4gJYGpXJr8P/yCBGu7J0zC82bKjdPfXbBAeBkp/M+qsaUleO+AGyDzkDaEuDBLl0UAUof/qn4YA/T4i1N2HVAZhit0I81O7871mfqYTCXq14AJ0FuOajOLdt3Syg+1BWBjZufDP5DAxnJ6yWDJ/xYbfAok9gNyCf+tjTXgeYFPH7FpPBaUgGfTGU9j+dtvEsE3TbyFf2EbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OMom0q0yxg4zGECCkDunAWRLuE1eQ5avHJxkd+qaH4=;
 b=FQ2SP7d7E4o2bgGrE/KC2JS2QK/GjSgfrFwKiOg4sIhTkJ7FFO1ElrF6wk4QydzZjAlXAlzLKnz345W7Xs+wX4gqjui5ijJVnGYfi9/s+A+VL15k31t17t8OE2it1F6T6nVsp+5T8I1DUQO1j8R130OAe2Zf3zoMxxX00HmYo0FrKbldTWsE2WmSBtubX5s+O6Tg6oGXQ7LucbPzeDpV4Lec/CyOXbsdXa5jYfEm4ZRmU019+bEsg3bf+jGHq9SqmNBE72eAoM3CW6MQmtC3AnHY+EgUEzcuhqeSiKlaf+rn+530HzCtJIGiespdA/XYNCn2BV8bc1toxfPhsoGv5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OMom0q0yxg4zGECCkDunAWRLuE1eQ5avHJxkd+qaH4=;
 b=nEolYV6pUhocfEUSWm6BSPEOFTzjJefLl0B0mRqmxZx3yuO0bFhXhBhy0KlfeluajoDJxLbc+ict1axMRdEX+gW0j/WdcFhnheLbXgoqpSkCIdP2gXOk02dngFO6eeN6ALJV31J0xvnWB0+ZjsCUkSBHBQeCTz4MbcdYDUC2VLwhi1NJ3UsAceSExIUJ/Ckc8g+btuQ2AsoIzGkqMoDxv/T03bYs+cZrmUUA0iFvm59ffd31wxGtCBZum2wuBwmRlF4P2YKlqn/7i+JFJyB7FzObnz9tCKV9NCrMHcKGxONGbAcBo6Y6uiZDt1EJZGL82mvftkpNbMRv2w/RoHmnMQ==
Received: from BN9PR03CA0749.namprd03.prod.outlook.com (2603:10b6:408:110::34)
 by BN6PR0101MB2980.prod.exchangelabs.com (2603:10b6:405:31::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 19:04:20 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::a1) by BN9PR03CA0749.outlook.office365.com
 (2603:10b6:408:110::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 19:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 19:04:19 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 309J4JYP1477928;
        Mon, 9 Jan 2023 14:04:19 -0500
Subject: [PATCH for-next 4/7] IB/hfi1: Improve TID validity checking
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Mon, 09 Jan 2023 14:04:19 -0500
Message-ID: <167329105916.1472990.9915542468337924727.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
References: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT097:EE_|BN6PR0101MB2980:EE_
X-MS-Office365-Filtering-Correlation-Id: 2748ef14-c371-43fb-15a9-08daf2745005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0VTydzsTMskiQbGn/Moj5bCv6mshYlsHUB38vWbC85/LvmGT7xU85lqpiKIaRDJXSOSAMoca4zlIRkAAOr+wnvgQU8L/A538EfPcQ7GFaCcFuf/g4/LGwZGMMj+VAzjYKc0ErDdo2MyvX6KVaNLuCIHgoXAmusW93NPgTr3AcWC2ePMn9FQHaoN5dbuIc2Nh3b+wmln991+c5s//VuKW4V/20b8zXpJKvsvjJkZSAQNmn0mkU/bDq3tdtO6avlGm1P6/rLdaQrub/i6/Ns9GtXSVEh///kzhcYDFow28J+zLWcoP0N5HBn3TjFSsxYXtOgBJI/Iw/4A39x4VODpB+vHEtbG+q+efiS8+M9MVB9bHKKV7mSGfZ8oubWRgzCzwJ3LMC5bVkdob2xigAKkYSMuHQfZTk4udKS0MezTdcM+W1ONBlZD0vmDrw7NNLGmBIXDKChYBbuv/oTPHF33Wa4Ze78sm97dcEJurJTpHo0ASmXmIht83yNkmMZU/JblHgaXrZy8WJR46OoZZMhweoJ93vFB3DX/knJetYSXAB2or0Y//2ps5tLb8BQtd1nEztBd6JX/4xOr806/wvKzdy3LioOxu5UywkI++gtlDzgbfkv39HppsVzf809lYT2qMRLIRNBIQpmtmZ1D7OSZ0NhLmDUVCNHVhdEuyTh6ASe9MjrN5x6CxuvDE1M4yskaaKD0MaQsCvDhaI2DmnPWddw==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39840400004)(376002)(136003)(396003)(451199015)(46966006)(36840700001)(41300700001)(26005)(103116003)(44832011)(8936002)(5660300002)(36860700001)(186003)(478600001)(7126003)(336012)(83380400001)(47076005)(426003)(82310400005)(316002)(8676002)(70206006)(4326008)(86362001)(356005)(40480700001)(55016003)(70586007)(7696005)(81166007)(2906002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 19:04:19.8516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2748ef14-c371-43fb-15a9-08daf2745005
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR0101MB2980
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

Correct and improve validity checking of user supplied TIDs.
A tidctrl value of 0 is invalid.  Verify that the final
index is in range, not an intermediate value.

Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/user_exp_rcv.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index 0229cf210431..96058baf36ed 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -790,20 +790,20 @@ static int unprogram_rcvarray(struct hfi1_filedata *fd, u32 tidinfo)
 	struct hfi1_ctxtdata *uctxt = fd->uctxt;
 	struct hfi1_devdata *dd = uctxt->dd;
 	struct tid_rb_node *node;
-	u8 tidctrl = EXP_TID_GET(tidinfo, CTRL);
+	u32 tidctrl = EXP_TID_GET(tidinfo, CTRL);
 	u32 tididx = EXP_TID_GET(tidinfo, IDX) << 1, rcventry;
 
-	if (tididx >= uctxt->expected_count) {
-		dd_dev_err(dd, "Invalid RcvArray entry (%u) index for ctxt %u\n",
-			   tididx, uctxt->ctxt);
-		return -EINVAL;
-	}
-
-	if (tidctrl == 0x3)
+	if (tidctrl == 0x3 || tidctrl == 0x0)
 		return -EINVAL;
 
 	rcventry = tididx + (tidctrl - 1);
 
+	if (rcventry >= uctxt->expected_count) {
+		dd_dev_err(dd, "Invalid RcvArray entry (%u) index for ctxt %u\n",
+			   rcventry, uctxt->ctxt);
+		return -EINVAL;
+	}
+
 	node = fd->entry_to_rb[rcventry];
 	if (!node || node->rcventry != (uctxt->expected_base + rcventry))
 		return -EBADF;


