Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DCE599887
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Aug 2022 11:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347614AbiHSJKn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Aug 2022 05:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347563AbiHSJKZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Aug 2022 05:10:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD00F240C
        for <linux-rdma@vger.kernel.org>; Fri, 19 Aug 2022 02:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YG7/ruvLg1mNiQQg7pll/omE+MBV949siuaatiTVv7QvDFLK6KZ/HjPwzSBjPkEtQKfZisP7RuhrTX8NrW2LtpFVfsLnXVzcaKb18xxsgqsNy4ECj2TGH+4771rUbyf3tKj5/kdXgwt+D7B9cemG7y4kJ9pCQ7bUJg7y4aA0NNsD238GdlssYJFVPZbgJvFyTMYVJKwe+OtCLmhDfxl+GbyYCakLBzDPlJiVgJtvEH5RReFFLaO/c7ivO69E5FO9TbbZK7RukiAvvDXPcKrc759ALyyDEpPcvaI4Cnjabv4xAFauNNPmwXJl3id3iXvgViyBZW1eUnJQ9ne1pS8MBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAR/9Ce0gMYuOfcaAM8XxgQLCfo3V8Gj5VRbmnY6Scc=;
 b=O4X+DZ3BBCb5h9Xtecs7s4hDgbJDmysIWQDI1v0e54KKd5xHdtotEzzkoAZVxEDCXVXtHlY+R6a5rM1tudEGAFnFw4KTA9C/W5ZXH2Z3sgNXU1SA5dzVALFe0TIQg9LVvwwRAhzfe4CEzKs5qXH7Hwj3V2C0hz+LaaOPEvE0IJbqHZyFK6L8QvbzbO5xs7hz+9Lv4Nl/8WfzY1sJa8+7hiOydQrlDgepOYqlLZOSic6AYjWzTfaNW80xBUuOY7/D5Z897K3S9V3qrUjCM1XLvQ8J8tv3qsckrsuyry6st82TAo4NzKQZ+L67/wcT4mAhiiD60DfPx2l8XDzYMYYUzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAR/9Ce0gMYuOfcaAM8XxgQLCfo3V8Gj5VRbmnY6Scc=;
 b=jtaA3c9/E5/hNV5Obk35CfCNz72uujgbYWB2/Gb3uDJX95ugFb5cK+fyyjSW5/KJ2ism1/ul4zFNf8e/Av/zfsshnJ5jlmluidS/q5gQELE6H9Pw7mE9NXgDy8iIi1MEboZGsiWZhjapimjCGC6tDUgAijA/qhzzI7Aj0qFkbANLxXNnKXAE7Own9GkE5H+t79y5xVd/wPNNofY1cc+k2itUBsvm7QWTOth+VNwUsGMOWkyRp1Ie30v8DkWfNGY3U4ddKmcUhEQ9YdiAKn8Y/prs09mTzMSafiytOVTSBAVFFcfQJAfS5xHGduMcNPBq6IKDkRSlUmUV93NpM9Kg8Q==
Received: from DS7PR06CA0051.namprd06.prod.outlook.com (2603:10b6:8:54::21) by
 SN7PR12MB6957.namprd12.prod.outlook.com (2603:10b6:806:263::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 09:09:19 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::21) by DS7PR06CA0051.outlook.office365.com
 (2603:10b6:8:54::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Fri, 19 Aug 2022 09:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5546.15 via Frontend Transport; Fri, 19 Aug 2022 09:09:19 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Fri, 19 Aug 2022 09:09:18 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 19 Aug 2022 02:09:18 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 19 Aug 2022 02:09:16 -0700
From:   Mark Zhang <markzhang@nvidia.com>
To:     <jgg@nvidia.com>, <dledford@redhat.com>, <leonro@nvidia.com>
CC:     <jiapeng.chong@linux.alibaba.com>, <cgel.zte@gmail.com>,
        <linux-rdma@vger.kernel.org>, Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next 3/3] IB/cm: Refactor cm_insert_listen() and cm_find_listen()
Date:   Fri, 19 Aug 2022 12:08:59 +0300
Message-ID: <20220819090859.957943-4-markzhang@nvidia.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220819090859.957943-1-markzhang@nvidia.com>
References: <20220819090859.957943-1-markzhang@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92fa61bc-adb9-479f-0cf6-08da81c27fd4
X-MS-TrafficTypeDiagnostic: SN7PR12MB6957:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bSFktiNvr+Z3f/KJTFLTwPCc68vrBj8XBgMYOI1uJxT65nF8jpBgek9gHLu7h4qd7ScK7cosCnWG4j2k3ghutUdJAyei9wkSc6BacWpuRkhX5thWAaI6SnRb5WN8QHndxEyLZNYhc19MMm6ThPQ3LLLQqPvY+/wRN4NFLJMPiLYhHGTLGrU5nC9CfXesK7JEwXoDTIxucatmnvKR3rClPPGLpLwlcUgOt42d0O29QlAiIEnlxM4u/KLzx+z04zFNxYHbREigBw7imMsaq4DlLTJJdsnQGHukNHzry7LGgTAaSShIq7CRnNSP7/gw2Gs8hnZ16IE5rg3pTtrIDgM9f5IBGheSf9fv1VqhvxmaGh0TvzUJ3g79s+N3rjtQH9HHn0T6lbvwyBZ7cs9XumMnhCUUQHqvUtz8JN7GjQeKz/I4bKyu5K6tkKMhLeRCGvJ0q9Et88/5UVqcNHK9NkXyT3Q8uG5yLoqTwglQVZfQ7awSdlJv4JqcJfhTED38F0pfe/X6WajMo18JcE6QKo2Ib7EABYU3eOKKNwZJNN4lxxT4gpfrNUv5NJlBRc27cvA6kQ8R2vWlaD6jm3uD1yiu1438Hm/hh8bHFLw9ivfa1qrM87awxY0OLxCkngE4vFUyduqBMyoY6EX29vlJePpoaXERvaHRJqpnh4FnP/VfBBoGn/QwgD02i3O5qHWF3RDx+r+BLOjD/sTOTs/csXRKRmG8zpgFKuor5wPmDiOuGvdh0+P8n9XS2vmuOXOHwrFtaWkOO1q0X5BL43Ke5xiwlL4fxYZTnT8ycQQ+C0lQY5w=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(376002)(136003)(36840700001)(46966006)(40470700004)(2906002)(36756003)(478600001)(4326008)(8676002)(70206006)(70586007)(40480700001)(41300700001)(82310400005)(316002)(6666004)(86362001)(26005)(107886003)(7696005)(6636002)(110136005)(54906003)(356005)(1076003)(81166007)(2616005)(336012)(40460700003)(83380400001)(186003)(82740400003)(8936002)(5660300002)(36860700001)(426003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 09:09:19.3338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fa61bc-adb9-479f-0cf6-08da81c27fd4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move the device and service_id match code at the top of
cm_insert_listen() and cm_find_listen() into the final else branch.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
---
 drivers/infiniband/core/cm.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 84bb10799467..d7410ee2ade7 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -624,8 +624,16 @@ static struct cm_id_private *cm_insert_listen(struct cm_id_private *cm_id_priv,
 		parent = *link;
 		cur_cm_id_priv = rb_entry(parent, struct cm_id_private,
 					  service_node);
-		if ((service_id == cur_cm_id_priv->id.service_id) &&
-		    (cm_id_priv->id.device == cur_cm_id_priv->id.device)) {
+
+		if (cm_id_priv->id.device < cur_cm_id_priv->id.device)
+			link = &(*link)->rb_left;
+		else if (cm_id_priv->id.device > cur_cm_id_priv->id.device)
+			link = &(*link)->rb_right;
+		else if (be64_lt(service_id, cur_cm_id_priv->id.service_id))
+			link = &(*link)->rb_left;
+		else if (be64_gt(service_id, cur_cm_id_priv->id.service_id))
+			link = &(*link)->rb_right;
+		else {
 			/*
 			 * Sharing an ib_cm_id with different handlers is not
 			 * supported
@@ -641,17 +649,6 @@ static struct cm_id_private *cm_insert_listen(struct cm_id_private *cm_id_priv,
 			spin_unlock_irqrestore(&cm.lock, flags);
 			return cur_cm_id_priv;
 		}
-
-		if (cm_id_priv->id.device < cur_cm_id_priv->id.device)
-			link = &(*link)->rb_left;
-		else if (cm_id_priv->id.device > cur_cm_id_priv->id.device)
-			link = &(*link)->rb_right;
-		else if (be64_lt(service_id, cur_cm_id_priv->id.service_id))
-			link = &(*link)->rb_left;
-		else if (be64_gt(service_id, cur_cm_id_priv->id.service_id))
-			link = &(*link)->rb_right;
-		else
-			link = &(*link)->rb_right;
 	}
 	cm_id_priv->listen_sharecount++;
 	rb_link_node(&cm_id_priv->service_node, parent, link);
@@ -668,11 +665,7 @@ static struct cm_id_private *cm_find_listen(struct ib_device *device,
 
 	while (node) {
 		cm_id_priv = rb_entry(node, struct cm_id_private, service_node);
-		if ((service_id == cm_id_priv->id.service_id) &&
-		    (cm_id_priv->id.device == device)) {
-			refcount_inc(&cm_id_priv->refcount);
-			return cm_id_priv;
-		}
+
 		if (device < cm_id_priv->id.device)
 			node = node->rb_left;
 		else if (device > cm_id_priv->id.device)
@@ -681,8 +674,10 @@ static struct cm_id_private *cm_find_listen(struct ib_device *device,
 			node = node->rb_left;
 		else if (be64_gt(service_id, cm_id_priv->id.service_id))
 			node = node->rb_right;
-		else
-			node = node->rb_right;
+		else {
+			refcount_inc(&cm_id_priv->refcount);
+			return cm_id_priv;
+		}
 	}
 	return NULL;
 }
-- 
2.26.3

