Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D78475A1C
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 14:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243069AbhLON5t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Dec 2021 08:57:49 -0500
Received: from mail-co1nam11on2072.outbound.protection.outlook.com ([40.107.220.72]:34592
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243068AbhLON5s (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Dec 2021 08:57:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZETngyGngwnacYy7hfmdMFybDRbierdSIymNc9xqayhacl98ETGkvR+XR2nw6tnSuRV+kexZpd3D483B6JC0vxUP6/Z1FIX8JwG3DjhTQJeWyFB9GzB8+qoNRCb86kiCRs13gVOPDshZOI0Whv+Oe3NtIs2xLiNDIunHuu/OyOl6Dq7YXihpf9UeKkVdAXCnGHvgsE10ynSObldx0bU3YU8V3+3MyJ4YMYqbLU36qDd1UpbtsHIEQsswFV2IZ5Z9Dina+O/GwXDbbeRCZ7qJLy5t9H+icupqHsqThkaaaoNsfRzCRQvhzWp5cj782ABMdu+0vuZMdHdP+QcVCvmYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojG9Q+cuHH4YbFDQEVt7FEYFQlu44YU8r8kpMhfvg0c=;
 b=MjpQnofJkqXzk0ecD0vG8Xw330NRrR3Wwp9dAzGChRp9KniGMdpjq1cDh6Ci4nfsjkB3b9/RA2HAlKqK4FCTVfuXYkuGrMl8ZHIvjIgjwU2nITeewlcQXwIXiH9DMhWl/lnJIQGL2qZCMjG99/68afNypvlqU/DJtV8y//5GPyjm1VrBZzXg5k7B4iNcPNkml793rie6/a4pXfVu67MxVJp4qIWByETBGUZ3ZjDpoI+by09f6XvRiZRHmu9vGXz/A+ZPn5c3q5Ht0LC6PD0tf2w8effHTcib6Ko1dd68rEQ3x2KmGP0fb+jt1S6StemkbvOdazx1TcA1S7QvJSCNNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.13) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojG9Q+cuHH4YbFDQEVt7FEYFQlu44YU8r8kpMhfvg0c=;
 b=XzW9pve6Q5RkN0NzYZLD9ec7oMBYPtTDuRo3ncFskyC3BmczEyXwVYHKNyZ769xLahpp8q2A+rZXABmX16394qSFJop94f5JVqUUt+uXDvrVmOyfhvC64HiokoDtQnoeJwrCP3ssEJ6RS2PcFLfQGE3jcN2jK5GmXUqWOestLdyFlysT9/6WgYVr40E6uZZZQ52/hpvZdBLjEV3E0HSkcszJcmUfuSpzc8qm1+S+Fz6ofN0Zfjx5AxBw5un71L9XMNvjklYH3z1c/EM0RDGM8iOyqx0jysBzfZ2ziMeVlKMQhwqLk/0gcw8nF2VvarktVQS7YRfk5dOETfnKkWjf5g==
Received: from BN6PR11CA0010.namprd11.prod.outlook.com (2603:10b6:405:2::20)
 by BY5PR12MB5014.namprd12.prod.outlook.com (2603:10b6:a03:1c4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Wed, 15 Dec
 2021 13:57:46 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::46) by BN6PR11CA0010.outlook.office365.com
 (2603:10b6:405:2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16 via Frontend
 Transport; Wed, 15 Dec 2021 13:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.13)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.13 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.13; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.13) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 13:57:45 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Dec
 2021 13:57:35 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Dec
 2021 13:57:35 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 15 Dec 2021 13:57:33 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <sagi@grimberg.me>, <jgg@nvidia.com>
CC:     <oren@nvidia.com>, <israelr@nvidia.com>, <sergeygo@nvidia.com>,
        "Max Gurtovoy" <mgurtovoy@nvidia.com>
Subject: [PATCH 5/6] IB/iser: remove un-needed casting to/from void pointer
Date:   Wed, 15 Dec 2021 15:57:20 +0200
Message-ID: <20211215135721.3662-6-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211215135721.3662-1-mgurtovoy@nvidia.com>
References: <20211215135721.3662-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 020aed6b-ba5e-4102-24cb-08d9bfd2df48
X-MS-TrafficTypeDiagnostic: BY5PR12MB5014:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB501465932CA6271F0A3E9830DE769@BY5PR12MB5014.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:364;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FW6/W1BtmNiW35QlGI1qSQ5/lruad8tdPx28s/34pC6aFTvPetG6ny9HIvxyQn0gtZfnVlHEq0jM9ifCMLCBhk3Q+t42qMoeuZvSMdxXsdktgZj6o+BnEWO9A/8l9dWgQsnvTWNNTntchQo9q+EwCDND4tGZUIPbsZ8EN7sF4wX/osTGZhuDXJdFpMddtlcNyBwRYW8gvBvw08YeENUFW7gdLYUUFRBKg4m0lnn3i+a9+z6uYdaj9sSC67/2+gDMJjX+x2qHT6QZA3VsSYNdmMaKIHCxiL0pqD8ZyNu+6jzo3XdhJenxnVAuoWP4TnBmiGoojd+BG95QGOQ3tQv5Binv/KU93IdSo86o5Vra5IsTlni8myRe7jBfG2MrNfARYzBFZSYAGgo3ighvqMeIiL+iVzDj+Ll1QEQomFBE6WnCaBSqSUaKpS3447HS5gWLS9uCt9+1KMGeDQ0NFI4G9d+xF4dqRWs3sVzPSbGMkMr+8uBm/If2TZ5Qv6PV4WOE8Tj5YeJW7gOzvVzAABvo/BYtkngSIIxpD2gOy/LPPjo7ngU93cgWe0c9btNX1Y3egS/V1dHsLtVpqEaT4hPPXg2Bqn0IpqakKhooCQ1KuX92DPHCYkRrj1FqM8v75LXVYE4097CbtjrTNv3hHH6wyI+Tgp3eBgkee26bNKbik7TvPrMTtPrEK7Kw2xbqWOuQ6wVEPNsWrS44EIVono0tWy76vuhxl6hyFgtYFT7XXJgbUUv2dNzbZ1mIq9JXLOw2R73QE9k4BKc1drXhaD9PDthL3DoB8FpOGId4vo96I44=
X-Forefront-Antispam-Report: CIP:203.18.50.13;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(107886003)(508600001)(70206006)(70586007)(26005)(83380400001)(2616005)(5660300002)(4326008)(356005)(34020700004)(54906003)(336012)(110136005)(426003)(7636003)(8936002)(36756003)(47076005)(82310400004)(36860700001)(6666004)(1076003)(86362001)(2906002)(186003)(6636002)(8676002)(40460700001)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 13:57:45.4095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 020aed6b-ba5e-4102-24cb-08d9bfd2df48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.13];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5014
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The void pointer can be typecasted to/from any type.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/iser/iser_verbs.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index 53af7f4052ec..afef5a2a7329 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -501,7 +501,7 @@ static void iser_connect_error(struct rdma_cm_id *cma_id)
 {
 	struct iser_conn *iser_conn;
 
-	iser_conn = (struct iser_conn *)cma_id->context;
+	iser_conn = cma_id->context;
 	iser_conn->state = ISER_CONN_TERMINATING;
 }
 
@@ -549,7 +549,7 @@ static void iser_addr_handler(struct rdma_cm_id *cma_id)
 	struct ib_conn   *ib_conn;
 	int    ret;
 
-	iser_conn = (struct iser_conn *)cma_id->context;
+	iser_conn = cma_id->context;
 	if (iser_conn->state != ISER_CONN_PENDING)
 		/* bailout */
 		return;
@@ -595,7 +595,7 @@ static void iser_route_handler(struct rdma_cm_id *cma_id)
 	struct rdma_conn_param conn_param;
 	int    ret;
 	struct iser_cm_hdr req_hdr;
-	struct iser_conn *iser_conn = (struct iser_conn *)cma_id->context;
+	struct iser_conn *iser_conn = cma_id->context;
 	struct ib_conn *ib_conn = &iser_conn->ib_conn;
 	struct ib_device *ib_dev = ib_conn->device->ib_device;
 
@@ -638,7 +638,7 @@ static void iser_connected_handler(struct rdma_cm_id *cma_id,
 	struct ib_qp_attr attr;
 	struct ib_qp_init_attr init_attr;
 
-	iser_conn = (struct iser_conn *)cma_id->context;
+	iser_conn = cma_id->context;
 	if (iser_conn->state != ISER_CONN_PENDING)
 		/* bailout */
 		return;
@@ -661,7 +661,7 @@ static void iser_connected_handler(struct rdma_cm_id *cma_id,
 
 static void iser_disconnected_handler(struct rdma_cm_id *cma_id)
 {
-	struct iser_conn *iser_conn = (struct iser_conn *)cma_id->context;
+	struct iser_conn *iser_conn = cma_id->context;
 
 	if (iser_conn_terminate(iser_conn)) {
 		if (iser_conn->iscsi_conn)
@@ -675,7 +675,7 @@ static void iser_disconnected_handler(struct rdma_cm_id *cma_id)
 static void iser_cleanup_handler(struct rdma_cm_id *cma_id,
 				 bool destroy)
 {
-	struct iser_conn *iser_conn = (struct iser_conn *)cma_id->context;
+	struct iser_conn *iser_conn = cma_id->context;
 
 	/*
 	 * We are not guaranteed that we visited disconnected_handler
@@ -692,7 +692,7 @@ static int iser_cma_handler(struct rdma_cm_id *cma_id, struct rdma_cm_event *eve
 	struct iser_conn *iser_conn;
 	int ret = 0;
 
-	iser_conn = (struct iser_conn *)cma_id->context;
+	iser_conn = cma_id->context;
 	iser_info("%s (%d): status %d conn %p id %p\n",
 		  rdma_event_msg(event->event), event->event,
 		  event->status, cma_id->context, cma_id);
@@ -784,8 +784,7 @@ int iser_connect(struct iser_conn   *iser_conn,
 	iser_conn->state = ISER_CONN_PENDING;
 
 	ib_conn->cma_id = rdma_create_id(&init_net, iser_cma_handler,
-					 (void *)iser_conn,
-					 RDMA_PS_TCP, IB_QPT_RC);
+					 iser_conn, RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(ib_conn->cma_id)) {
 		err = PTR_ERR(ib_conn->cma_id);
 		iser_err("rdma_create_id failed: %d\n", err);
-- 
2.18.1

