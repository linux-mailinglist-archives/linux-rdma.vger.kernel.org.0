Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FFF58A5C2
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Aug 2022 08:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbiHEGCV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Aug 2022 02:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiHEGCU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Aug 2022 02:02:20 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF91E2253D
        for <linux-rdma@vger.kernel.org>; Thu,  4 Aug 2022 23:02:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aldByA1eTEGZ1iW2GKpTrp1etIEMFIwAM9OwUlQc1aGKmcwj4GXMZTdZz/mDV/GrNyVYmdJbZz2OjF9FelEmi3/HmEG20haWrUP1yqW9np5DArlkikwrzLKyR7zG99NJUSmRerLyWlGBVPrZBJAV/u/vobotUbY5CG6gKf7Vs1NfbffffsdaqRfZPqC1kJFsvxTvLzTF7IfsYwQdfsX/QFCNVwSHeY9JRHjuxNIRCimt5xisGeIX1T/0Eps44rCcdws98+FjqwlAgz2DaIZiiPcr/gSC2xfmbE7hXk9aIr5K4BGJW6XYlnoPXF57MZ0yBeJNKEvp20xx797SJX+h1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PESGkVw60GZlgmlpS7i2+qGgmjjPMDjl0ENmX2yMYI=;
 b=ITfSvEyZA7lMMK+tEe5pMdLoZYlzrTi2jbROhjtXaH3sVD11cFdFCxJ4+9bpLuUZCPJhmqwrSP0fJYSjk1va3T1fswv7Wr5adDKcTRXJO0A6sZhwLQ0nbG5V4KvMOLxQzXTZ2H3R+4CUKshTJwvvcJvfbaUgTC/phvVpo+K1M32h5QjR+ZWKTp8lko5GEweogjQkOAjoOgVD+2jAYv+qqcwbRTkI3qYd886rz4B/mX/Tc1IpUuWG6Bx+mx4gqClIy6VJLQkz2kCk+dyZ8BCuRNw9eC3hHDqnfIqoteUMqqsXn8eWMdPmfkdUCgSDL2pkkL74oMHcutrDupucSU4UYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PESGkVw60GZlgmlpS7i2+qGgmjjPMDjl0ENmX2yMYI=;
 b=MkCp7FXYcGW6DjLFapdbXnpXjy3W4srlRqtANu3ScC/hYLgYMM9EzXwziQz/7WUQCvoqv7vXHO6meEoPOMTt2na0g05oRkn4Frv1TIOhwoMrCyttUFQH8JtZ3J/Cb3TCfWVh10xCdw3YdlsBW6IR+Pe8n3vPc1dBxa3UAPJnQjddUtKxxOAjYu260K8hVxAXUNKwzeVix/MowgnzzatwRqyjWCm/Yk4dYY546FUZkEgzVxpSYUypN7AagSqYfz2VlC+vwmiC/6kT0hto1dIFdU8buTK6ftUb26B5/hQ47+ufVf97NVGjOvEc4AMkTxPh9jqqV6onmb28jKdnkzrj3Q==
Received: from BN9P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::21)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 06:02:18 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::e0) by BN9P220CA0016.outlook.office365.com
 (2603:10b6:408:13e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16 via Frontend
 Transport; Fri, 5 Aug 2022 06:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 06:02:17 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 5 Aug
 2022 06:02:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 4 Aug 2022
 23:02:16 -0700
Received: from rsws38-eth1.mtr.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 4 Aug 2022 23:02:15 -0700
From:   Sergey Gorenko <sergeygo@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>
CC:     <linux-rdma@vger.kernel.org>, Sergey Gorenko <sergeygo@nvidia.com>,
        "Max Gurtovoy" <mgurtovoy@nvidia.com>
Subject: [PATCH] IB/iser: Fix login with authentication
Date:   Fri, 5 Aug 2022 09:01:35 +0300
Message-ID: <20220805060135.18493-1-sergeygo@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db3198f9-cd32-4623-ec51-08da76a80d92
X-MS-TrafficTypeDiagnostic: DM6PR12MB4417:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QzDMGzPV+OCQ3w0Ss1vCCwDrNwlV9Fw4BW2MVXO/48NglkJcs5HgRuzI5EmvW+SzVYcNmPck/Y9jJAp1Uu+z+W0PSUIeIbEuylZ91hfC80cfFawHh6VP5i1hkjxbvRkybrTVSFMiOiw+DPGJnL1sfdLEI1AVy0pcfrvv5IhDJuo/1qWeE9D7j22gE3jXj4xuo9BkatVT746OzYaQ6D1nSym3H7wrVfJUzr9CsR+niyU4MOpKtJuE4J6XYfUgzQ7dE+SV214ajUp1ay1uTPx7pHYA7ooNR85l8Fr1M58DTiyakI6cW9dUXCnGt0fJLMnbsqHVHN7YDEAjtovEGCQ6WpB3YIV0Y9AuZ+bOZi0qArQRjOjr4a61e7FjtcIUGJ5Vj1hn+OPmpY5UCzXMyhLpy+wlgNvYR9G1nP1Ddy253cbQGZyZ01Qj/0DXU3sPVTNDMjie39bSvtABmRRpp6e44kQi37lCqyjdDHLw1MgfxM4BVv9QgCxwVV8tFggoqMCYT0rWHpZD0YuqvRfOCzJO7JetAdYa5pNK3GXm/G3mNjuDPsKlJWi5znwfECvlc6+OYBwXWWFJzf3x0sfpt+eICkso9m2zTp7f26VE/h4RCeI+WK6/gju3e2fvFhuU0XsyfDSA5IdHjjxB1zOPW5A5m9PWkWIPpsEVWSqJ2M2rKeWX/j2L++AChFJmPj0rqcXZjITq4NVTNEhzeqcDY3dQ7JzdjROv9m03hWvkAsmLXlwuGEbyvv/g9D4h8a28ewFcj2WkhB9t0cEOI7qf46cIGDtux3iJv5rWFPTmWRyX6A+3dqU3fuPWDUo2Sm8mcJXxA+tLwPWmYlnpiGFDl+SJvA==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(136003)(346002)(40470700004)(36840700001)(46966006)(426003)(47076005)(1076003)(2616005)(82310400005)(186003)(107886003)(54906003)(36756003)(336012)(6916009)(316002)(83380400001)(26005)(40480700001)(82740400003)(478600001)(36860700001)(70586007)(81166007)(4326008)(40460700003)(8936002)(8676002)(70206006)(86362001)(356005)(5660300002)(2906002)(6666004)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 06:02:17.8943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db3198f9-cd32-4623-ec51-08da76a80d92
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The iSER Initiator uses two types of receive buffers:

  - one big login buffer posted by iser_post_recvl();
  - several small message buffers posted by iser_post_recvm().

The login buffer is used at the login phase and full feature phase in
the discovery session. It may take a few requests and responses to
complete the login phase. The message buffers are only used in the
normal operational session at the full feature phase.

After the commit referred in the fixes line, the login operation fails
if the authentication is enabled. That happens because the Initiator
posts a small receive buffer after the first response from Target. So,
the next send operation fails because Target's second response does not
fit into the small receive buffer.

This commit adds additional checks to prevent posting small receive
buffers until the full feature phase.

Fixes: 39b169ea0d36 ("IB/iser: Fix RNR errors")
Signed-off-by: Sergey Gorenko <sergeygo@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/iser/iser_initiator.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/iser/iser_initiator.c b/drivers/infiniband/ulp/iser/iser_initiator.c
index bd5f3b5e1727..7b83f48f60c5 100644
--- a/drivers/infiniband/ulp/iser/iser_initiator.c
+++ b/drivers/infiniband/ulp/iser/iser_initiator.c
@@ -537,6 +537,7 @@ void iser_login_rsp(struct ib_cq *cq, struct ib_wc *wc)
 	struct iscsi_hdr *hdr;
 	char *data;
 	int length;
+	bool full_feature_phase;
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
 		iser_err_comp(wc, "login_rsp");
@@ -550,6 +551,9 @@ void iser_login_rsp(struct ib_cq *cq, struct ib_wc *wc)
 	hdr = desc->rsp + sizeof(struct iser_ctrl);
 	data = desc->rsp + ISER_HEADERS_LEN;
 	length = wc->byte_len - ISER_HEADERS_LEN;
+	full_feature_phase = ((hdr->flags & ISCSI_FULL_FEATURE_PHASE) ==
+			      ISCSI_FULL_FEATURE_PHASE) &&
+			     (hdr->flags & ISCSI_FLAG_CMD_FINAL);
 
 	iser_dbg("op 0x%x itt 0x%x dlen %d\n", hdr->opcode,
 		 hdr->itt, length);
@@ -560,7 +564,8 @@ void iser_login_rsp(struct ib_cq *cq, struct ib_wc *wc)
 				      desc->rsp_dma, ISER_RX_LOGIN_SIZE,
 				      DMA_FROM_DEVICE);
 
-	if (iser_conn->iscsi_conn->session->discovery_sess)
+	if (!full_feature_phase ||
+	    iser_conn->iscsi_conn->session->discovery_sess)
 		return;
 
 	/* Post the first RX buffer that is skipped in iser_post_rx_bufs() */
-- 
2.34.1

