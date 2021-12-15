Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98178475A16
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 14:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237608AbhLON5l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Dec 2021 08:57:41 -0500
Received: from mail-dm6nam08on2061.outbound.protection.outlook.com ([40.107.102.61]:11488
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243063AbhLON5j (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Dec 2021 08:57:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imycCkg1kvY7gDIsZKHThCDY084HvzuqbereG4UzyJ1uZYNPPxfE19X9ko1ReJQ/ainijPV6Xh5FN6M4dWDDUAxdyyZ/KgCQZBnSH3JsDLipFqYwxAq4jGATAsEqo8h8IN7dw0Q5JSSv9+tjyem1EFCARI4DncJcZ38G9vf5vmPYcTjxeWSOhAk+L5nQwHOz3TGjp4HPqmB1x54TR4AhiyUAGKCKmBueInU/q6CaUbiBa4/pOlVBQSbnEeHCqJl332Oz5YaH3B2MW3UaBhTMptQibjbwGZjD/F+fa4C6SeEhy9e8TevwVgrdM5gzX5wwtflXu7nROLSts1v8Jeta+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iv0KcDm258TJTXrwR5VqH8raU5ue8gFCHfguG/PLhDY=;
 b=e5i9pro9jN/xcnQ91CHLVY3zLxL/dWQ6hiFs3kxO21K9ulOw74UlvUEuIIYwkmQv4y3SlUcBywLj8aJSWSiXLALvdSGMocuV9Nz/ucIq+cVliM1J53fX8fUgKfs9usf7Bc3h4y60tHEKkl+gbQOSAhKZyj2xpuxApbEqu/WE48NTJHGBccViQ8HIZmI3Yt0h3H96/EAtPDMAWIFTWamigtfTBgVuLZGfT9SeE89pUgqiYS/WGAv7KYObEgCtWWK+YpwghU/nz5tdHD8IwZfXlBc8xtx/Fglq2GsUDL/gPFAqxVDxHP8gfsFXjNSAgEl6c774Jr4pl234X09OXQ6MJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv0KcDm258TJTXrwR5VqH8raU5ue8gFCHfguG/PLhDY=;
 b=CKDXmlBZFY2+xyVNPT+MOjdkiao7e8hL7SyaptaTaL4LljCFDQ7TD1kdujozj0K76A54/NvFWPCTlgci+NgFnZR3WsuZnUZ+ERsrSc2sHvj8O1SsMUqdhi+KEJoYUOeXwD/xemmcOE/nF9bVHufRAmTK9qAjpvQdOk/DxPfWc4srYfHBgMr+3a/Ej4mfyU2Ace7KP1hGpZw/HafvBXL2M6IeJck0JUTU6BYJjHotqJ8hqXuj5aWDB5twUc+9fj8VnXUpNV7gxmbF24THNGHrfaGuKam3HRY/697AsydVb/THVlbd9RXmlA44r74eIM79TFRSIfClwFVy79DUauZ65w==
Received: from CO2PR04CA0010.namprd04.prod.outlook.com (2603:10b6:102:1::20)
 by BYAPR12MB2855.namprd12.prod.outlook.com (2603:10b6:a03:12c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Wed, 15 Dec
 2021 13:57:37 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::fa) by CO2PR04CA0010.outlook.office365.com
 (2603:10b6:102:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14 via Frontend
 Transport; Wed, 15 Dec 2021 13:57:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.12) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 13:57:36 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Dec
 2021 13:57:32 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Dec
 2021 13:57:30 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 15 Dec 2021 13:57:28 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <sagi@grimberg.me>, <jgg@nvidia.com>
CC:     <oren@nvidia.com>, <israelr@nvidia.com>, <sergeygo@nvidia.com>,
        "Max Gurtovoy" <mgurtovoy@nvidia.com>
Subject: [PATCH 3/6] IB/iser: rename ib_ret local variable
Date:   Wed, 15 Dec 2021 15:57:18 +0200
Message-ID: <20211215135721.3662-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211215135721.3662-1-mgurtovoy@nvidia.com>
References: <20211215135721.3662-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ddae44f-d987-4971-9327-08d9bfd2da16
X-MS-TrafficTypeDiagnostic: BYAPR12MB2855:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2855B2BB767D9BDEF384A97EDE769@BYAPR12MB2855.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wlERHlK9JTUdN1pmdJee6uoMZquTpmIrMYyieMrTowROzyLXWoCJtQVSA5KdY8XOQ7b/oL88jkMG/6Hu1OkU+HQKSpeoJ9l9OvHOW93Onx0Adn5dH3pUb2ltHWWkoU0DggN6uAgdO23bpNQ+N75EovAwGkrS3FunpRC5ANC682z9olD98pa8Ksmy9V2IXcAbaEAooh/Z8kma0hN8WHJJhawTEDSpX14irv5pHrh8STRCP2/dbP86+rgR3Hh3KNg/ijUya1BqWu+o9s1t4ony5FgCCvETL+HId+m1TeT3T3NL6XKuZJXKI5L1d44c0se4v6un0t5pM0zYZM1EUyLO+R/6f3EkoHqxwQl/aTzdSCrm/5rs2wygSh7fyqi6q+SKQixUkgDyo0+soX7jhKlmY/iSOl0yaC2boyyGbsCHUM0ssCFW1RryeOnmZ8H3ZlfNrK2IVebKZaZN1yyvW53BQSq3dK3Am5o2ccJ2WUYUnZcers0esg6p1zbTh5TgvgxXkmxq1HgJwDzmZ/NAC3KppvH872vJXdcxx+Z/adqjs53Nbyvmlmew0x2wmRMtKOsToGlGvYYY8uhosYOeJqnqX8IWimNgOQWOhPQHwldcdf3cN5T+ZM1r9pnyvMsdKAOLtXo5cdAuuM2VoptwmDhWJD5igPj4SOt8AzCTb8kQbAH2u7Rpe6pIXw2knigJC8NmVM2QsldZyAGkM7ADDbUNhXF2XTrqoIbDkj8Z8Rr9ySdRW35CglUKNvmHxgPggMNeeKonp0oNCYBs4L7eyGWdXQw4Hkswk4mLXllwxak6fWo=
X-Forefront-Antispam-Report: CIP:203.18.50.12;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(8936002)(47076005)(4326008)(1076003)(5660300002)(54906003)(6666004)(26005)(110136005)(7636003)(2616005)(82310400004)(508600001)(186003)(86362001)(2906002)(83380400001)(40460700001)(356005)(34020700004)(426003)(316002)(70586007)(8676002)(6636002)(70206006)(336012)(36860700001)(107886003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 13:57:36.8992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ddae44f-d987-4971-9327-08d9bfd2da16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.12];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2855
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use more common name for return values ("ret"). This commit doesn't
change any logic.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
---
 drivers/infiniband/ulp/iser/iser_verbs.c | 30 ++++++++++++------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index e272390bc492..e0d7119a2c40 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -828,7 +828,7 @@ int iser_post_recvl(struct iser_conn *iser_conn)
 	struct ib_conn *ib_conn = &iser_conn->ib_conn;
 	struct iser_login_desc *desc = &iser_conn->login_desc;
 	struct ib_recv_wr wr;
-	int ib_ret;
+	int ret;
 
 	desc->sge.addr = desc->rsp_dma;
 	desc->sge.length = ISER_RX_LOGIN_SIZE;
@@ -840,18 +840,18 @@ int iser_post_recvl(struct iser_conn *iser_conn)
 	wr.num_sge = 1;
 	wr.next = NULL;
 
-	ib_ret = ib_post_recv(ib_conn->qp, &wr, NULL);
-	if (unlikely(ib_ret))
-		iser_err("ib_post_recv login failed ret=%d\n", ib_ret);
+	ret = ib_post_recv(ib_conn->qp, &wr, NULL);
+	if (unlikely(ret))
+		iser_err("ib_post_recv login failed ret=%d\n", ret);
 
-	return ib_ret;
+	return ret;
 }
 
 int iser_post_recvm(struct iser_conn *iser_conn, struct iser_rx_desc *rx_desc)
 {
 	struct ib_conn *ib_conn = &iser_conn->ib_conn;
 	struct ib_recv_wr wr;
-	int ib_ret;
+	int ret;
 
 	rx_desc->cqe.done = iser_task_rsp;
 	wr.wr_cqe = &rx_desc->cqe;
@@ -859,11 +859,11 @@ int iser_post_recvm(struct iser_conn *iser_conn, struct iser_rx_desc *rx_desc)
 	wr.num_sge = 1;
 	wr.next = NULL;
 
-	ib_ret = ib_post_recv(ib_conn->qp, &wr, NULL);
-	if (unlikely(ib_ret))
-		iser_err("ib_post_recv failed ret=%d\n", ib_ret);
+	ret = ib_post_recv(ib_conn->qp, &wr, NULL);
+	if (unlikely(ret))
+		iser_err("ib_post_recv failed ret=%d\n", ret);
 
-	return ib_ret;
+	return ret;
 }
 
 
@@ -880,7 +880,7 @@ int iser_post_send(struct ib_conn *ib_conn, struct iser_tx_desc *tx_desc,
 {
 	struct ib_send_wr *wr = &tx_desc->send_wr;
 	struct ib_send_wr *first_wr;
-	int ib_ret;
+	int ret;
 
 	ib_dma_sync_single_for_device(ib_conn->device->ib_device,
 				      tx_desc->dma_addr, ISER_HEADERS_LEN,
@@ -900,12 +900,12 @@ int iser_post_send(struct ib_conn *ib_conn, struct iser_tx_desc *tx_desc,
 	else
 		first_wr = wr;
 
-	ib_ret = ib_post_send(ib_conn->qp, first_wr, NULL);
-	if (unlikely(ib_ret))
+	ret = ib_post_send(ib_conn->qp, first_wr, NULL);
+	if (unlikely(ret))
 		iser_err("ib_post_send failed, ret:%d opcode:%d\n",
-			 ib_ret, wr->opcode);
+			 ret, wr->opcode);
 
-	return ib_ret;
+	return ret;
 }
 
 u8 iser_check_task_pi_status(struct iscsi_iser_task *iser_task,
-- 
2.18.1

