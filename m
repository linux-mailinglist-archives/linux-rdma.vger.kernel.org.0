Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FA759987E
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Aug 2022 11:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346923AbiHSJJS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Aug 2022 05:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347640AbiHSJJS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Aug 2022 05:09:18 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD431F0756
        for <linux-rdma@vger.kernel.org>; Fri, 19 Aug 2022 02:09:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZaWXgZ5llCQwOTr+NX9b9oYOmyHhfszJ9SmuaG79uEt/679HOqAqsXstVKvVkcWcZPDXSn/6JAAz4aWgxawLIPJ4SX/QwJOppj81/T431Rc7x7sB+Lj7bgyRaNMjkIy63KLQwxQXvruFw4XxXWgqXNSmk5C+6B7RAAvGr6k87crwius0ohrrir0sxnNJLcuAr22DqNHPkk/dCBmbw/Y2Dq7ws/XoZTF8Kxmu/JVSyYcVkC4iYXEmyrRIDXBme5i0meDsFiE0SEhO9Sr24+OX1g4lkrL7qNaGc+ohbAa6Zq1dl+RGae4MUfaCThcGTsg4yX9cj7oezRosI+h9b/N6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuORV3cwVEsz0IHWrWon+8GWXzs8xW+l9kw38cUg98g=;
 b=MECtzh6pNr6BISFkJ6/6r/jq1FNUdyVl8Io3mGT+GorkxwmqSPB0rYitcQxTcjVC+08fN96B45WKnb8Y8Lp81Szlu+jhkWzbEeVy4SpzkRqBLpGqc4skVzt332viWF6drxfuTFAfbEmMLHU9/Z1F6HZojfT9JWBcgQ8+yMZFCeHaqHamA6zoAjLB7467eNbnI2GTo52VYHsJn1TryMkK5VmAWE+HH0yk0T3ZkXpbwkKOAXSJbsbsAQ18TGcRXc1u9diVadqN2tPz3oTajozbzYEuHKJvaw/au1peLlskvjYBt1yGu3MCoJy+z2FqXJa2+r6NkTmsncdt8JgCdS5QwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuORV3cwVEsz0IHWrWon+8GWXzs8xW+l9kw38cUg98g=;
 b=AvTAI9uewSSoWCQ3mVtho5R+HGXaUoINuqPvSfjePytIeqqyd+wRYt+LKz/+RcRm3EuztjqFn+D3OSu5CFkBmTRHQcHyg0E7S21GPqELErDeH5zPRxhD/u684OhG2W6iLVbQeg0+RyXxQQZ61Pdhr35BEPSNUZDb72H9AR0euYDyyiu0z2LaKKo+Alylc1CZFAGWUtZXGK0qjZUD9btyi28Y2UrsbxEHcJuN69wDnAX6fq77YJtXvLz4yd5VKIRBEOp12DVtpWPXnfZumQHLptxgbM0I4qnyaZKzjZjRvVS/UwRhArvgUOYQmxPGU06YYyaj67IxnxEM/IxAXwzgvA==
Received: from BN0PR02CA0048.namprd02.prod.outlook.com (2603:10b6:408:e5::23)
 by CY4PR12MB1910.namprd12.prod.outlook.com (2603:10b6:903:128::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.25; Fri, 19 Aug
 2022 09:09:14 +0000
Received: from BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::99) by BN0PR02CA0048.outlook.office365.com
 (2603:10b6:408:e5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Fri, 19 Aug 2022 09:09:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT092.mail.protection.outlook.com (10.13.176.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5546.7 via Frontend Transport; Fri, 19 Aug 2022 09:09:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Fri, 19 Aug 2022 09:09:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 19 Aug 2022 02:09:13 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 19 Aug 2022 02:09:11 -0700
From:   Mark Zhang <markzhang@nvidia.com>
To:     <jgg@nvidia.com>, <dledford@redhat.com>, <leonro@nvidia.com>
CC:     <jiapeng.chong@linux.alibaba.com>, <cgel.zte@gmail.com>,
        <linux-rdma@vger.kernel.org>, Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next 1/3] IB/cm: Remove the service_mask parameter from ib_cm_listen()
Date:   Fri, 19 Aug 2022 12:08:57 +0300
Message-ID: <20220819090859.957943-2-markzhang@nvidia.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220819090859.957943-1-markzhang@nvidia.com>
References: <20220819090859.957943-1-markzhang@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8645a86-32df-49f1-cc55-08da81c27cfb
X-MS-TrafficTypeDiagnostic: CY4PR12MB1910:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 486MMy7Fo+GGwXLp6tKg5pcwo2RqdLKm3rpVqsW35q0o4o+H0YPQApiP23cOVzmjylqYE3zx9n088Am0u1lzr1McAOS/ea6G9unNLdD2KIpLVwQR+NhwngYhiyUkuIxlEqdMdO1az1llNVXlDVd3Y+vMEJaKgELvMHnipzFMOU/aAZTrn8rehFz1L/gYjFe/hDEKd9VXZUBKrDB1pGQWjVD4FZItq6uvsYUEzwlHxwDcM0ogRKpQK8zH/XRLA+3L9+NPtAX85fCnLtMNFLPg0rqYKt8X/PfCVjkF2azmcKWtx6NfyToZxqz5BDzRiJoBlACDt7aOauxJ4xDyqSqZNlS16BvgX+05DX4wB9Oc4XKgouY+iXcAJPP0q0ZT4dVxXvG/8kIqPwmIem2gVJvG7WHmz5r6wPWOdOvwrFMTIZVPx4XZ6jQQ131MyV5o07pA4Lc1uV61hwnyuTlAcjSw3pxDdknVA0ARDno9SWY6TtNSDDOc2aSfqhHsjibcYCpp3v5INraPfOInj1iQUxUQ7erw/EFVcMK4iJd3WOLNawzfwRwwdkAL6gUbTMosj1KZJ90/fUNcq2nrF0UhOiv49PKHe2p/4garYVAA2JV3zGT6gBMszX8MbXkZfi3VW+E3754FSWM2csxG0TfbXMwm+1UPxcibuKqhdbr7Tq3aFep+bzKPFSQuZFm2wLIZY18oDQ9IWQwK16FeFLCByU/hWyfpL3roWcSP8/YnVSOSOdSHaXar/qw0KxUlZmCmwWYO278z9VljMpc+h7alHObpzSCth3N/xyLrcbWb6QMtI5ik+PlVsjcgEA9See7otf3u
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(36840700001)(40470700004)(46966006)(6636002)(54906003)(110136005)(4326008)(40460700003)(478600001)(8676002)(82310400005)(86362001)(186003)(8936002)(316002)(36756003)(70206006)(70586007)(356005)(26005)(82740400003)(7696005)(83380400001)(5660300002)(6666004)(41300700001)(81166007)(426003)(336012)(107886003)(47076005)(2616005)(1076003)(40480700001)(2906002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 09:09:14.4986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8645a86-32df-49f1-cc55-08da81c27cfb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1910
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove the service_mask parameter of ib_cm_listen(), as all callers
use 0.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
---
 drivers/infiniband/core/cm.c            | 8 ++------
 drivers/infiniband/ulp/ipoib/ipoib_cm.c | 4 ++--
 drivers/infiniband/ulp/srpt/ib_srpt.c   | 2 +-
 include/rdma/ib_cm.h                    | 7 +------
 4 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index b985e0d9bc05..b59f864b3d79 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1185,12 +1185,8 @@ static int cm_init_listen(struct cm_id_private *cm_id_priv, __be64 service_id,
  *   and service ID resolution requests.  The service ID should be specified
  *   network-byte order.  If set to IB_CM_ASSIGN_SERVICE_ID, the CM will
  *   assign a service ID to the caller.
- * @service_mask: Mask applied to service ID used to listen across a
- *   range of service IDs.  If set to 0, the service ID is matched
- *   exactly.  This parameter is ignored if %service_id is set to
- *   IB_CM_ASSIGN_SERVICE_ID.
  */
-int ib_cm_listen(struct ib_cm_id *cm_id, __be64 service_id, __be64 service_mask)
+int ib_cm_listen(struct ib_cm_id *cm_id, __be64 service_id)
 {
 	struct cm_id_private *cm_id_priv =
 		container_of(cm_id, struct cm_id_private, id);
@@ -1203,7 +1199,7 @@ int ib_cm_listen(struct ib_cm_id *cm_id, __be64 service_id, __be64 service_mask)
 		goto out;
 	}
 
-	ret = cm_init_listen(cm_id_priv, service_id, service_mask);
+	ret = cm_init_listen(cm_id_priv, service_id, 0);
 	if (ret)
 		goto out;
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
index fd9d7f2c4d64..ebb35b809f26 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -884,8 +884,8 @@ int ipoib_cm_dev_open(struct net_device *dev)
 		goto err_cm;
 	}
 
-	ret = ib_cm_listen(priv->cm.id, cpu_to_be64(IPOIB_CM_IETF_ID | priv->qp->qp_num),
-			   0);
+	ret = ib_cm_listen(priv->cm.id,
+			   cpu_to_be64(IPOIB_CM_IETF_ID | priv->qp->qp_num));
 	if (ret) {
 		pr_warn("%s: failed to listen on ID 0x%llx\n", priv->ca->name,
 			IPOIB_CM_IETF_ID | priv->qp->qp_num);
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 21cbe30d526f..31c60aee00af 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -3191,7 +3191,7 @@ static int srpt_add_one(struct ib_device *device)
 	 * if this HCA is gone bad and replaced by different HCA
 	 */
 	ret = sdev->cm_id ?
-		ib_cm_listen(sdev->cm_id, cpu_to_be64(srpt_service_guid), 0) :
+		ib_cm_listen(sdev->cm_id, cpu_to_be64(srpt_service_guid)) :
 		0;
 	if (ret < 0) {
 		pr_err("ib_cm_listen() failed: %d (cm_id state = %d)\n", ret,
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index e23eb357b761..fbf260c1b1df 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -340,13 +340,8 @@ void ib_destroy_cm_id(struct ib_cm_id *cm_id);
  *   and service ID resolution requests.  The service ID should be specified
  *   network-byte order.  If set to IB_CM_ASSIGN_SERVICE_ID, the CM will
  *   assign a service ID to the caller.
- * @service_mask: Mask applied to service ID used to listen across a
- *   range of service IDs.  If set to 0, the service ID is matched
- *   exactly.  This parameter is ignored if %service_id is set to
- *   IB_CM_ASSIGN_SERVICE_ID.
  */
-int ib_cm_listen(struct ib_cm_id *cm_id, __be64 service_id,
-		 __be64 service_mask);
+int ib_cm_listen(struct ib_cm_id *cm_id, __be64 service_id);
 
 struct ib_cm_id *ib_cm_insert_listen(struct ib_device *device,
 				     ib_cm_handler cm_handler,
-- 
2.26.3

