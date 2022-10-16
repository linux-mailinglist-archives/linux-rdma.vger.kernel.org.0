Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A0D5FFE7A
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Oct 2022 11:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJPJip (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Oct 2022 05:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJPJio (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Oct 2022 05:38:44 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838473DBE1
        for <linux-rdma@vger.kernel.org>; Sun, 16 Oct 2022 02:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4b6JX4tcp9pL9+yH2B7dUzLfohmemfB6JPvT9RG0xyupurapgzeET3foQOB0ATfBAVGUwv7XqDQVbu+fG0fD/JTa8TFkDupTg5cATEVEldZGejzH7oJMch9QA22jSDzTqMcd15WdWXSkZqbMQBdnQQfQTZuug5HLUXE6cWQKd3jBwARtQDJMrgiqxE7gCzVdknt2/s05wPqL+AXPUE8yuZzV45sOknQuucClfKiS5w0ddOufIVl6lzqgh9JMXtcUOpUpC99E3WIqLfZsKg2RlA9PtpeIGJc8DXRrFU5AwIkU/JjLcrYq5R+9dtubsUJBrRYYOdK/WYG1XZrQPSMjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3Yj4vIBGi79HAv6TBW9pdFbqK/QuD55Bu3BM1KoLIs=;
 b=Uwna3tPoDbczisrwwDoMYUJBtqV/UYiBw/g+gsYetH+nRCnkKW1Im8nez/KuRbznUq+pdJwryzqKjA9hCMs5mM7Gu2a88TSwHi8KqZ3qLR2QsR1TBzHqYrlXzPjE/U8ZTkDBq6sQqTkuxwWlarF5Uci2ZG8RtinzyMlES3lkc/aKHHUZjq/YrPT9g44fzRTAiuRrULVV1lSCoGtcfomqTNPDYZVgtbrOMqP0GSx0N0kfJyso815zUNkNfTwl3rCeigKv1NIPUKzNH0/CeZ6h29jtsapofL/bJJQJfpeUpz9JePieXL7jSJzRDCwn5WnvHTYTGQGSpTwPJUNYv4xa5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3Yj4vIBGi79HAv6TBW9pdFbqK/QuD55Bu3BM1KoLIs=;
 b=Iw6IpwYuWH4Zk4IIwDLMNZyIzGdKfo5xIkzX0CJ08yty555BUtTDLPzxIm3bxGcRrQSMQJq6jX4e5Srptp1uQv+rTd/R1CpBUhnPHUIkvG7mww7fDqoDsCyPIxlNmaz7yPRREbUCmJARhAkGMdDmQZMpqso91V4YJpAPCNfDvm4fHVH2+aWRQldbOVJEUaWfZF08yt8sqqJjefBzB40rpQ8MKANxDC40VXG7q9Ia8yv3Egavp5OJmaQyBJpPMmZEBpTwNupvD3MF7+dymJi1DbpsToN5LfPKMBY/OqqpcyXClR+1KJTRPA/IjElqBiD8KNBeBAxllzFCN9LLLuE98w==
Received: from DM6PR13CA0058.namprd13.prod.outlook.com (2603:10b6:5:134::35)
 by PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Sun, 16 Oct
 2022 09:38:41 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::c2) by DM6PR13CA0058.outlook.office365.com
 (2603:10b6:5:134::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.11 via Frontend
 Transport; Sun, 16 Oct 2022 09:38:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Sun, 16 Oct 2022 09:38:40 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 16 Oct
 2022 02:38:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sun, 16 Oct 2022 02:38:39 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Sun, 16 Oct 2022 02:38:38 -0700
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <sagi@grimberg.me>, <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <sergeygo@nvidia.com>, <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 2/3] IB/iser: add safety checks for state_mutex lock
Date:   Sun, 16 Oct 2022 12:38:32 +0300
Message-ID: <20221016093833.12537-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20221016093833.12537-1-mgurtovoy@nvidia.com>
References: <20221016093833.12537-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4756eb-ad6f-4c5d-636a-08daaf5a359c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7p2/K5hxvBst40oKDgfn/dfhbkpnJQc9AcwthXgLmuWel802kmNY/u66XMud01T3BWqVr2jLp3KfZWkf7KQT8SQRHcnxgMDSAt0h7awaTzwieGGs0q/2czMa8yO2uE6pBSF2FfjiY2OjkVH8evUtyQWxPbCE+7gP4dzDfnPgr5BAOy7iL8nhflchV/D865XX9ZvZzUUVguoF2xhFfvIEDpjkulHTg3HAgD63505jYpci0pr4AiZqDFahtKzjVjgF8rc3q2oxNBh/bdKFGIzAWVL/VuXhP26iRskg++d/nIQ7Y2MqcpKjjlK4lifQ6Gx1n4yOs4Gsag66zvR5GRUQ+4pEJHGNV99E38nwF2EMUOz8hEmd8elGjt/Ni38NHzOzfLzU1W2S2Qc5gk7A53KtkdSh5UcuMG+SxolrcsXXp0+umEDdmUyE1T5zXqrCJQCeTULGa3yoHNT5b+b9YJpY+Zc17kyoM7++I7qs1iSUsJ13t1/uyNN1b7fBJLvm2yzdpi6U7+kwchN5DL5Tcr4rPbuJqBNHJn38O2cxlGDezKEFFXZsn2FvTQSukfrJcP8pOaYvBrX2/y5vsKBtMMe6UU0uh2Dt8vL8jQkD+Dvkc+byFw6pFGN6aLqUjV2PXeytR5+OYCK/5Wm2SPDHI0bdbkZJiYgE4ruDziUxAw7UiCzKt0W0+xmK2xmz6pskvdUVQ0YIHdz5QuCJgB1zsRFhOuSpjuRajhJgWnLkqplDd4b0FIp2nq3ziYvS++LLUPMrA0qgnYtByZKGcUum00MtA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(47076005)(426003)(1076003)(2906002)(336012)(186003)(83380400001)(356005)(82310400005)(82740400003)(7636003)(40480700001)(86362001)(40460700003)(36756003)(36860700001)(316002)(478600001)(54906003)(110136005)(41300700001)(2616005)(8936002)(5660300002)(26005)(70206006)(70586007)(4326008)(8676002)(107886003)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2022 09:38:40.6143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4756eb-ad6f-4c5d-636a-08daaf5a359c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In some cases, we need to make sure that state_mutex is taken. Use
lockdep_assert_held to warn us in case it doesn't while it should.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Sergey Gorenko <sergeygo@nvidia.com>
---
 drivers/infiniband/ulp/iser/iser_verbs.c | 26 ++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index a73c30230ff9..f33e3a7f605d 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -448,6 +448,8 @@ int iser_conn_terminate(struct iser_conn *iser_conn)
 	struct ib_conn *ib_conn = &iser_conn->ib_conn;
 	int err = 0;
 
+	lockdep_assert_held(&iser_conn->state_mutex);
+
 	/* terminate the iser conn only if the conn state is UP */
 	if (iser_conn->state != ISER_CONN_UP)
 		return 0;
@@ -482,9 +484,10 @@ int iser_conn_terminate(struct iser_conn *iser_conn)
  */
 static void iser_connect_error(struct rdma_cm_id *cma_id)
 {
-	struct iser_conn *iser_conn;
+	struct iser_conn *iser_conn = cma_id->context;
+
+	lockdep_assert_held(&iser_conn->state_mutex);
 
-	iser_conn = cma_id->context;
 	iser_conn->state = ISER_CONN_TERMINATING;
 }
 
@@ -526,12 +529,13 @@ static void iser_calc_scsi_params(struct iser_conn *iser_conn,
  */
 static void iser_addr_handler(struct rdma_cm_id *cma_id)
 {
+	struct iser_conn *iser_conn = cma_id->context;
 	struct iser_device *device;
-	struct iser_conn *iser_conn;
 	struct ib_conn *ib_conn;
 	int    ret;
 
-	iser_conn = cma_id->context;
+	lockdep_assert_held(&iser_conn->state_mutex);
+
 	if (iser_conn->state != ISER_CONN_PENDING)
 		/* bailout */
 		return;
@@ -581,6 +585,8 @@ static void iser_route_handler(struct rdma_cm_id *cma_id)
 	struct ib_conn *ib_conn = &iser_conn->ib_conn;
 	struct ib_device *ib_dev = ib_conn->device->ib_device;
 
+	lockdep_assert_held(&iser_conn->state_mutex);
+
 	if (iser_conn->state != ISER_CONN_PENDING)
 		/* bailout */
 		return;
@@ -613,14 +619,18 @@ static void iser_route_handler(struct rdma_cm_id *cma_id)
 	iser_connect_error(cma_id);
 }
 
+/*
+ * Called with state mutex held
+ */
 static void iser_connected_handler(struct rdma_cm_id *cma_id,
 				   const void *private_data)
 {
-	struct iser_conn *iser_conn;
+	struct iser_conn *iser_conn = cma_id->context;
 	struct ib_qp_attr attr;
 	struct ib_qp_init_attr init_attr;
 
-	iser_conn = cma_id->context;
+	lockdep_assert_held(&iser_conn->state_mutex);
+
 	if (iser_conn->state != ISER_CONN_PENDING)
 		/* bailout */
 		return;
@@ -654,11 +664,15 @@ static void iser_disconnected_handler(struct rdma_cm_id *cma_id)
 	}
 }
 
+/*
+ * Called with state mutex held
+ */
 static void iser_cleanup_handler(struct rdma_cm_id *cma_id,
 				 bool destroy)
 {
 	struct iser_conn *iser_conn = cma_id->context;
 
+	lockdep_assert_held(&iser_conn->state_mutex);
 	/*
 	 * We are not guaranteed that we visited disconnected_handler
 	 * by now, call it here to be safe that we handle CM drep
-- 
2.18.1

