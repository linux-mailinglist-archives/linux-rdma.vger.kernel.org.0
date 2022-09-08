Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02905B27F6
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 22:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiIHUzJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 16:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiIHUzF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 16:55:05 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2064.outbound.protection.outlook.com [40.107.96.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88604F396
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 13:54:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiTlaLiDO2r05yS3r/FM43AKbSwLIEXYnbqbcQE/ZIW6bRAInYBDg5QMOXPtYVNww2GlZzJmbHXzagnAal//f5WpeMZu7RcAQg4LhJFJ+3xe7mMP4EyOAvX2oQCxWedenm9I4QySGgOWoNM88GjPJlfLr1RboXRfOmhOWXBDEd93apkIzC+MB6qyiB+JhImTzfH9tXbtEA1LbOaDCmuFxwOzedOe6lvMCdukTKa7+PytuoT67jGwiISretw0UQchOLPTYC6jmBnz5Ld+CrjZSHV+8Y5CzA9MalneGUhy1PK1Cyy9NPqBkSsWVvLeIzvN5WF+kgnhymZ2pDLqYRSumw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VX8kxUEwlDeUpquLyPtvZ2Rh6UnGCoQYp5VxivZnEt8=;
 b=Cgs4wHLcjYhz/gKfVmsGZ/fBB/yCYRfMjTbi0ZsL6Fw21po3GsGQ1UeW9/loC727AgCDexB8z7rFipuiwCTk/ocTxqD6T39QNpb5+oSQEveWCWpYEet3r3e+naRwf3K+K6d4GnzG+EzjUHNa9HruJv00s5nzRZkdNnTFc2NWhX0r5gi/k5EPr66tljYnN6ia4C92e08CpmBe0duItnmagw66KxD6P4vxJfiAObYkpOc00LZRUQnakpn4R6Z/gDMbx8n7cE5sgDgoRzbRtVVpzx0GWGRCydWKeKeDJPJSrbEnLcGs4Wkj/2KXHmopJeSDULw8zNbeymm05PPXstiXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VX8kxUEwlDeUpquLyPtvZ2Rh6UnGCoQYp5VxivZnEt8=;
 b=WHnYsaAS9Fj3nVeMudP5Ax0JNIGPD4CYnH1wnia8un6mpeFn2fDTfVyDhO4wmBuj8z43lgtiL2TF7QOTS+bbXZfshtgsWIHu3KDTBj7/NsHsQJOS9KAkpn4UiDFTmrrDeOERLY0Mm65NNJa9ddVD87Kx6Zrt6e7bOQ5QvSMgRVGJzlSh/pcjkc5uvIr22HzUrNanh/MM1Xqq+ElrsUGwE0lDJWWhHklqzpVepgyVOKyTPE67eO1FwqQ2gbpXb4K+fmWZKQowfrYVmuuHqJ3YsGQvd814ZtLKaNS4c9vvb7lLGFOfm40uhgHwzIk7TibbGTSjmHvWR6hze1evVjkUbQ==
Received: from CY5PR16CA0020.namprd16.prod.outlook.com (2603:10b6:930:10::16)
 by PH7PR12MB6693.namprd12.prod.outlook.com (2603:10b6:510:1b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 8 Sep
 2022 20:54:55 +0000
Received: from CY4PEPF0000B8EA.namprd05.prod.outlook.com
 (2603:10b6:930:10:cafe::60) by CY5PR16CA0020.outlook.office365.com
 (2603:10b6:930:10::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Thu, 8 Sep 2022 20:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CY4PEPF0000B8EA.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.10 via Frontend Transport; Thu, 8 Sep 2022 20:54:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 8 Sep
 2022 20:54:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 8 Sep 2022
 13:54:49 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Thu, 8 Sep
 2022 13:54:47 -0700
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>
CC:     <maorg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <saeedm@nvidia.com>, Aharon Landau <aharonl@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 3/8] RDMA/mlx5: Remove explicit ODP cache entry
Date:   Thu, 8 Sep 2022 23:54:16 +0300
Message-ID: <20220908205421.210048-4-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220908205421.210048-1-michaelgur@nvidia.com>
References: <20220908205421.210048-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EA:EE_|PH7PR12MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: 33db76de-49c9-4469-a641-08da91dc6092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lAbuuThOZxz2d8Ie7Jg3aLT3rMWaZXN/Oo9l2OVTdY/xF9nygV2+035WLbgkOjY5tpg8QofFVG0qGYL7LDEV1Ma1Cmw4RGErDzpZlazCkN1HHcZWpcm1r2twKiQzsYJwGnJp9EIJlyoL7j7w68ssCgIgjXs0RqIjOIX/n2k7FmWq7TrX198Mibrlqi8hKB/gIOrgDJK0zceib2dmOPlXA0vRIAHAga6nKR6GsRnybKbazY1+BD/oDc1oSrKMS6cKgX3ivXfd8l8Y79FKw17HA5wsWKOEk6ed0pj6008VxAKaQcDDzkh8AwyU74/Oj7x9CJHAXR+usN0Yg48sxBZN7kFZBnIYfZcnHxl6QwycRiM+VoRvdqsnlF3pNxEYisXrPYaLpCODNJDNilOQQz2YvthbTGGWXf6w8hldfb9hsVaiTgcWNHe6JPkOvsYZv+WsmNFP2/oqiVy9738dfbhEhDV1CdmiYgwbC3JpIHJ+/upZRV/t1DT/U1zNYBrx6AOWlqJ76pqyNxFX202NQjCN9WkdjO2lqVrevokL9i2QdWd86uoMl9fH9vWGaGeml/IgKS5SXGKXLlLegWatcvm2m7EMNfgrezJ0SGaaMQ2E410VYzo0EIbs/fCXsEav5OrgSmjY2HbUhvtUzZ+0InTPp+hu74/YvY/au1tQAlGAGQZYPhc8QVKjjD3eekbgE1vrsLh0y72g0zVy5Md2m41sra3WxVMbcOR9MnHROgnunzL0jeal9FWqjgQ/NN6sgqzNSZfTwEkBnh5/PdUpvxvMFXQEzARrtz7/grM2u57QVlTn4Tl1khN4JfOQ/2NNuWY3
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(346002)(46966006)(40470700004)(36840700001)(40460700003)(5660300002)(4326008)(8676002)(47076005)(107886003)(8936002)(70206006)(6636002)(316002)(41300700001)(54906003)(6666004)(36756003)(478600001)(70586007)(110136005)(356005)(26005)(86362001)(2906002)(7696005)(186003)(82740400003)(426003)(1076003)(82310400005)(83380400001)(36860700001)(336012)(2616005)(81166007)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 20:54:52.0246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33db76de-49c9-4469-a641-08da91dc6092
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6693
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

Explicit ODP mkey doesn't have unique properties. There is no need to
devote to it a special entry. Removing it.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 16 ++--------------
 include/linux/mlx5/driver.h      |  1 -
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index f7c9eeaa8e79..137143da5959 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1591,20 +1591,8 @@ void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent)
 {
 	if (!(ent->dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
 		return;
-
-	switch (ent->order - 2) {
-	case MLX5_IMR_MTT_CACHE_ENTRY:
-		ent->ndescs = MLX5_IMR_MTT_ENTRIES;
-		ent->access_mode = MLX5_MKC_ACCESS_MODE_MTT;
-		ent->limit = 0;
-		break;
-
-	case MLX5_IMR_KSM_CACHE_ENTRY:
-		ent->ndescs = mlx5_imr_ksm_entries;
-		ent->access_mode = MLX5_MKC_ACCESS_MODE_KSM;
-		ent->limit = 0;
-		break;
-	}
+	ent->ndescs = mlx5_imr_ksm_entries;
+	ent->access_mode = MLX5_MKC_ACCESS_MODE_KSM;
 }
 
 static const struct ib_device_ops mlx5_ib_dev_odp_ops = {
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 9ccfd9dd0d0f..0f3a96df3377 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -734,7 +734,6 @@ enum {
 
 enum {
 	MKEY_CACHE_LAST_STD_ENTRY = 20,
-	MLX5_IMR_MTT_CACHE_ENTRY,
 	MLX5_IMR_KSM_CACHE_ENTRY,
 	MAX_MKEY_CACHE_ENTRIES
 };
-- 
2.17.2

