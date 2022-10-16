Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A29D5FFE7B
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Oct 2022 11:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJPJir (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Oct 2022 05:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiJPJiq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Oct 2022 05:38:46 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3503DBE0
        for <linux-rdma@vger.kernel.org>; Sun, 16 Oct 2022 02:38:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irz4R5vutisJHoDKTusg+BPKNRZTcSMMDZ7TP06RKJI+CCx0yrk7CPK21Jxi2zgiZycqyEmv29m4dbMSbfnJ0LquZagLPHxekPbAnHdEUs4oOnvvdDylpe0buysvuD8ndjt6K/aXriEz2hIe3+/CgrjJ5IhBhVOUXnCTBk7RnnfiCXV1lNJZhM4bXwumxomTzw4xE2SIxazbfY211M50INiAc9HTXSHIlulNtionK1DgcybfXhB1u8QudwkAY8sfLfVFFoQtVZFebXHDrKQ+6NjEekXu5fNoyz23oo80dtpi5N9oF0bMNTD+xrYmERVWSmFItUvnU0sCZsDSsty55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JU5sctElIOIXViOWHxp5W4hQkBkP0LvZu4HzFf3NPUM=;
 b=Lyrv+/G7IruQAV6x5DCTPmHEPDa8uKzMFhgxN8H1ulJzmtsuhyM8IQTWbFdBoqQ7NcujloXN62LdOBCXlJMCwAHXRSCxZWncTyLuExzf/hID4Ij2zPQg1W3IT2ykrLLo3wT11kyxhsInyKQi6Y2TzN43LS2pEeayaCs18mk8PnBT5RGycMzLdbNHhbejJiJWFL09YUtiULaHtzutp+jsgpQcsEL8eTtOCEX57eB0xKeg3uwPI+Ix3Yif6Vd0j4DwUE1UbqIARI8Dh5I2ESD9LSfdp1KWbGfwKj/P/2GUeJgexnt4Xp5Jn3giBp4KMNqKhqA/otPhfJn61+gJI54O9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JU5sctElIOIXViOWHxp5W4hQkBkP0LvZu4HzFf3NPUM=;
 b=qjiOs75ln03zkcA/jsDehMLc09HekXCnlj7KOQarzp929CvZjrBC5+cAKBVHJtIWzvN16foiHvjiNudE8DJARH9VvVSwSx5ZcO+g6oc0FEuoIWMbNAW7cwmp54kzJIzOv8W9SSpREfgm3TH4mA+HwGPybmbP2QTeDbZ0N5a19P3kJrDrZ3JCaYkYskOfXN9NLHJ/ReRNsAljtgL8ntgRN9uUOE+t9pE0CIwEy5/g+OxnhBHXaGeIuX54HhHYzS9QQ1V69wadT7Hyw8C2IYGZmBJ31T5tHh8ARua0hqKRWwdBcfpMojrCvLLY1dTtANS2/Hq+V6a18aCx/+hfQaL2ig==
Received: from MW4PR04CA0080.namprd04.prod.outlook.com (2603:10b6:303:6b::25)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Sun, 16 Oct
 2022 09:38:43 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::e4) by MW4PR04CA0080.outlook.office365.com
 (2603:10b6:303:6b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Sun, 16 Oct 2022 09:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Sun, 16 Oct 2022 09:38:43 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 16 Oct
 2022 02:38:42 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sun, 16 Oct 2022 02:38:41 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Sun, 16 Oct 2022 02:38:40 -0700
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <sagi@grimberg.me>, <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <sergeygo@nvidia.com>, <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 3/3] IB/iser: open code iser_disconnected_handler
Date:   Sun, 16 Oct 2022 12:38:33 +0300
Message-ID: <20221016093833.12537-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20221016093833.12537-1-mgurtovoy@nvidia.com>
References: <20221016093833.12537-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 51498a6a-ac90-4c80-30f8-08daaf5a3721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9BA45leFaNmA6YB5fHVw1si/kmKptJ9603HiFzIqDYBM+0UYPx1tYckGrhbZpK44yNx73p3d7pcLfseRtVM1YqH6nPA39ukeEAAgmM4oYCSiFvCs5BV2yXa99j//Fma7KfhFa2mF+1yNh1Uy8utfthdgWQ2KLzQlKGJ9+DNaFKohWcRc0hwj/2byKVlS7kXEHln0dDYsCg4/fwstDnv8XrXvPlY4zFyL2qfq69NL304QVFk59WVa77zsVO8dWEffOEhLKI2vGV3mhL0wVSmcMzWLte86K/jm5Ljefdb5rhArRBGjdtLMxq62YsAQt7IrKJVJtrMV0qQNNzy5OkojIZEi+x3JBQkMYJK9fdyAj36L9X+TFUi6oMxBWvlD6RUzefBZPWdGG62z6qoPbNWRhjPIroibrR+F0cXABWebBiMFt6rOB9N/4Fp5A7E9hlOSDE0Iq+utY31jn33UR27TN+z7zkw/kiY8KV4rZx6o46NAXY3KKBNoW95xhNXT0BB8xbR7tSPaD5lOZD/7ZAd271yPpHiEclUMR5Ejk8R3lGCszUpr6L19gNg72tSjZmvnIW1JdBtsG+aXuR8VH7ZjbCaSTw2fqrgUE0ACyP8eveTIycUqAKYKXiVUv+sFQn6+MFgIDrXKKzNvcQvkt3L5Xp13J+KwnVGH1pmRuT+ElAOoT86PvFdKA4KOXZElmvetWG70t1pM4t5wVmsQVmjz7dLQBeNuQUrElajwSBVPaIM3KhuxAvhZh/y7C7OoRiSXu4jRlEUsLw5bxJLrlEtmEQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(41300700001)(36860700001)(82740400003)(336012)(1076003)(356005)(2906002)(40460700003)(2616005)(8936002)(5660300002)(26005)(82310400005)(186003)(7636003)(36756003)(83380400001)(478600001)(70586007)(70206006)(426003)(86362001)(47076005)(8676002)(110136005)(54906003)(4326008)(316002)(6666004)(107886003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2022 09:38:43.2248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51498a6a-ac90-4c80-30f8-08daaf5a3721
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is a single caller to iser_disconnected_handler. Open code its
logic and remove it.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Sergey Gorenko <sergeygo@nvidia.com>
---
 drivers/infiniband/ulp/iser/iser_verbs.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index f33e3a7f605d..1b8eda0dae4e 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -651,19 +651,6 @@ static void iser_connected_handler(struct rdma_cm_id *cma_id,
 	complete(&iser_conn->up_completion);
 }
 
-static void iser_disconnected_handler(struct rdma_cm_id *cma_id)
-{
-	struct iser_conn *iser_conn = cma_id->context;
-
-	if (iser_conn_terminate(iser_conn)) {
-		if (iser_conn->iscsi_conn)
-			iscsi_conn_failure(iser_conn->iscsi_conn,
-					   ISCSI_ERR_CONN_FAILED);
-		else
-			iser_err("iscsi_iser connection isn't bound\n");
-	}
-}
-
 /*
  * Called with state mutex held
  */
@@ -678,7 +665,13 @@ static void iser_cleanup_handler(struct rdma_cm_id *cma_id,
 	 * by now, call it here to be safe that we handle CM drep
 	 * and flush errors.
 	 */
-	iser_disconnected_handler(cma_id);
+	if (iser_conn_terminate(iser_conn)) {
+		if (iser_conn->iscsi_conn)
+			iscsi_conn_failure(iser_conn->iscsi_conn,
+					   ISCSI_ERR_CONN_FAILED);
+		else
+			iser_err("iscsi_iser connection isn't bound\n");
+	}
 	iser_free_ib_conn_res(iser_conn, destroy);
 	complete(&iser_conn->ib_completion);
 }
-- 
2.18.1

