Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5BC7B22CD
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 18:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjI1Qtl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 12:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjI1Qtj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 12:49:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815CA1B5;
        Thu, 28 Sep 2023 09:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9Wsppf80vBMr8HzzP3DmQcWCTJR3jRl5xh/Rosbex7v18QH6uXVj9KRPrrC2a/Id3TP9KbaENngH41+Fj/qUckG32qquH1ff9gnsOqu2GjtQT57Y7m2MBAZ/EbcGeJYtYQHVCuKNysuF0qWa2v2Pctk1EdVsin6lKt4VXPgNJLBe85PhHbOZLp0hyxh9F4kbSf/tjiLSmrOc7G8IVGgK/vrdn8JHQio3oXbAPjJ/uU7YNLYohAvSUPq8bsBWpHOIJ+4ECb5pAmS076kPq6SxnRDtx8az9aBZgm9Utsx/vJeJe8jaSj2GIQ39sJTGhqaCBVVkhEUn+Nw7mPHiz5k0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ks0yqKFa9s2l5F9bXQdb3gSn8cxS7t2k+S80slwQQFY=;
 b=We0UjEtQZs3AWtOxR7dhfK3Cs21O+ZlQzPXEGZLY1/GQXXMWUUmcmH5Z+n6uCJg3hOvDAKLWXEkLuuD+tHKlxn5IgDy4vFzH+eRAf194com+Wa2hKOgbGESglnDULECoNstJxeTnkdsoQJ3bgYsvWfxOpWCfvI5TTdYGdpl3y6DyUjBBPPV8aQwhhcWg3h61l8F8dYVigQ7bXkVsphR1kdxpoH8QLRkxagX/Tsre3JM4eSidY7thMD5kL1TbFCWVh14XMg/+d/XgWl09MYQofP9GY3POckfInDxwMTtczNzzDUDFA5Z3utV21EFcEVKjubrPQt9UwM/0aKlq5n0clA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ks0yqKFa9s2l5F9bXQdb3gSn8cxS7t2k+S80slwQQFY=;
 b=Df7yFrKvLipqr23Zd8b6SwnWZIA/F/d4tru3Jo32Z/fxa247zNKkc6ERpkNFJCARltMrr9vhhTrPF+tNv59evEYu6npTQRwHepmwsybl+5/2VXkeXFMM4xtT0YYLlFBG98yvbBzXvmhy1QdpbM6KZ2k3AkdoQGneq87whdAmzViNgYPMomvrEEZfO9OnQQd4uQkmM80iMEhgJkZHTccQX3qHzc2nqS0vrcqDLHBu+cz+mk+KDdZb8yezKdZa/ONsfR+lGOTP56GS7TYG12nRrsBzt1pzj8bx0GSfRoL0QZ5LiT0fQyys5W+FcpGSMgyMESsNMqnkEmZYtGpG2be2fA==
Received: from CY5PR15CA0110.namprd15.prod.outlook.com (2603:10b6:930:7::29)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Thu, 28 Sep
 2023 16:49:34 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::36) by CY5PR15CA0110.outlook.office365.com
 (2603:10b6:930:7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Thu, 28 Sep 2023 16:49:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.15 via Frontend Transport; Thu, 28 Sep 2023 16:49:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Sep
 2023 09:49:21 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 28 Sep 2023 09:49:21 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41
 via Frontend Transport; Thu, 28 Sep 2023 09:49:18 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     <eperezma@redhat.com>, <gal@nvidia.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     <virtualization@lists.linux-foundation.org>,
        Dragos Tatulea <dtatulea@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH mlx5-next 01/16] vdpa/mlx5: Expose descriptor group mkey hw capability
Date:   Thu, 28 Sep 2023 19:45:12 +0300
Message-ID: <20230928164550.980832-3-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928164550.980832-2-dtatulea@nvidia.com>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: b6fe711b-33dc-4994-433b-08dbc042e4c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dLzEG8kepgKj4K00FkPk+9JeOis6Msf1MlonDwB0XiGU9ifdbOAkm1qBHtnsyzlYfjb6L7e+rue+W+Stuxabv54PbT3YpqEBzsfiBqWyrGIDC5j1GHHZ0rkQrnZ4L6ZsHQ6u+YxqGaonfysrcPvfvwFEH7tgK+WQZYGjKfWAoONWdst8G/VRNliijgSnob9TkEWzUo9tatR3bhPo+y9CenkNmosejYza+BFsdXAkydamFj23qcLWPiS6dkspldIDvW3bBBBXMgWSzELQn/NhFvo59mOj6XkU6PyBRecTKrVjjPI/jZ9E9vU6HULjiZgBfBBtaUfBDZHMZDzcTUePaR6QnMeBPmQWbLonD0K+u92rRauo1TEvJoScfOVJx313FpDelEXtu6bhbDpr0f1Eg7VSIBp7EVcH60DxRYxE8jB+HqkjMzjHdmiV5N4xTURDV+YfWygB6pa5mDEyZHwPqEHtFdIdI7MFSXj45mVHxOYwfaYqI2qD/t9gfBoBqpyBmc12XluwQjbdRuhxZnF0oR48Nod6xrl3o/BBSTFsjFLkjwIluoc4E7APXpou5ZiJ0vEJHNlrK4+VVLgI+MZ13SdrLECQ1M5vbz+vUfh+lAb8Ky+1/4Px8cF56K30gQoviE+wnOuud+wA7XVp6mvMJDYqUaL2n5j2FNb4MGvQvh1IzOWuXqkFR5LqyA3keDLYuCdvddddzbNFmbrKpWOEXVGCteXS1OQL5J/lpbYF8J7WBLkxtqE3ZlrDmm9epjns
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(82310400011)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(2906002)(7636003)(2616005)(82740400003)(70586007)(6666004)(1076003)(5660300002)(110136005)(86362001)(478600001)(47076005)(70206006)(54906003)(83380400001)(36860700001)(426003)(356005)(26005)(336012)(4326008)(36756003)(40480700001)(41300700001)(316002)(8936002)(8676002)(4744005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:49:34.0733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fe711b-33dc-4994-433b-08dbc042e4c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Necessary for improved live migration flow. Actual support will be added
in a downstream patch.

Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index dd8421d021cf..ec15330b970d 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1231,7 +1231,13 @@ struct mlx5_ifc_virtio_emulation_cap_bits {
 	u8         max_emulated_devices[0x8];
 	u8         max_num_virtio_queues[0x18];
 
-	u8         reserved_at_a0[0x60];
+	u8         reserved_at_a0[0x20];
+
+	u8	   reserved_at_c0[0x13];
+	u8         desc_group_mkey_supported[0x1];
+	u8         reserved_at_d4[0xc];
+
+	u8         reserved_at_e0[0x20];
 
 	u8         umem_1_buffer_param_a[0x20];
 
-- 
2.41.0

