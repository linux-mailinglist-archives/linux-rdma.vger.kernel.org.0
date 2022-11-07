Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD00861F8B2
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 17:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiKGQPS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 11:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiKGQPQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 11:15:16 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2050.outbound.protection.outlook.com [40.107.96.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707016466
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 08:15:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UITEUmA4h/riFfSAmumbAZOKLnd/sV5EXCyBb5ljRDJdyda2pTVsAodpu/rJG7ZE+a9qaTt+IjG9GhlXMQrVP6n2FH2MwKWDIvw/WMVhmdLodD+hRR83teu1THcdWuGX8D661GUT2SI4CcZiYE9gawBzoBHEEBTYaqvoAA5r3ZvchG+lWbNn11GseqgGuXYh5SNUqCi/iAy2uQxAkJeh4sykX/cYb5m8rT0DWH/o7TcxE8hsd9kWO79ERRodwCnPOSNAstAL1yavBZ23jgG/kLSZ0kp+/V6deGkSAdyIMFNiu4ATqEXuX+17nVwmAx3iScnMzNf+cnbiBCJUc/oUig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2VkzcA0wbArXp1xXbA4tyOBtgr6XmD0B1qi4RvkWhQ=;
 b=JNprs5fqaPypfwI2yVbqSPjP++UU6y2Qr1VFyc7ke+lRb9laKhoIz6UCOgpTGE+Rr0yR8WH1Fsyv5V4LXiOIA9Z+8Z3wYoe2igAgn1CJMusB5Tz1LS7XNHhMB4OiEqq6GWUz5uVPQjN7IgJqGyvBhXmvpKf4q+3dBJvaIzaXMLfXFPmqbctuYwfiZrj3t2EgzQ1v4YpaCrmHCPwusWE13QcgWRWcq1lrYD2XovVxrmoaca3iYE70CinZR+NJmwO1umM22NvP0tMHBNfQ9KTb/X/+dmifpycKK79eFENxHXf+bvGXgvumdcpVF7fwFTXjlIUNOppKjIFN3AqMdAwgsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2VkzcA0wbArXp1xXbA4tyOBtgr6XmD0B1qi4RvkWhQ=;
 b=R345SjWOWtdHN+tf3tNfKUz3EdO7FtJf93iefNYU5nljGhhEVlFMBVRj5jTDfb/OXYxpZVHXuMp1qM2rNQK/h6ZMlvL64ga4FThG/cIKVDC8p9/9KnDRFJd8WKz+zizJIxE0Bx5OEjg1i9XUkX5Zy94C2KuHe6yoQD8bLZSwqCzMNJHYZ63ZAAH/4ZW22vNDW2+zzD4hPfuc/LUtgf79wieo1EriaR2D3oJVEmTZ46O4kSVW5umA/QUp/WhUh06htNHvAsrZdRU4Gp6Fu9cCvvbxuDGTBuLqJ2qyx0Ryvcing0zm8u62TMdLeLgOBAmtOBNx6b/IKscEVzXKRnEzhg==
Received: from DM6PR07CA0125.namprd07.prod.outlook.com (2603:10b6:5:330::7) by
 CY5PR12MB6406.namprd12.prod.outlook.com (2603:10b6:930:3d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.22; Mon, 7 Nov 2022 16:15:09 +0000
Received: from DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::72) by DM6PR07CA0125.outlook.office365.com
 (2603:10b6:5:330::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 16:15:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT094.mail.protection.outlook.com (10.13.172.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 16:15:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 7 Nov 2022
 08:15:01 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 7 Nov 2022 08:15:01 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 7 Nov 2022 08:14:59 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>
Subject: [PATCH v1 rdma-next 4/8] RDMA/mlx5: Allow rereg all the mkeys that can load pas with UMR
Date:   Mon, 7 Nov 2022 18:14:45 +0200
Message-ID: <20221107161449.5611-5-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20221107161449.5611-1-michaelgur@nvidia.com>
References: <20221107161449.5611-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT094:EE_|CY5PR12MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a6595d-8aed-4318-6d7c-08dac0db3d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mmR6obKeGWSGfMbtPugXnT/20IUp12juxXzx3yPVNcpqQFNQf/qi7NIgdIWL4Frucie5XWvftb/tiC23NCakg22cr5/ESc0xJR/MHhqIPjLAkaXoVrLrp0aPQnMMgJxGL5k7luT3foGZqgwZc6gV6LwE/zD+AlqgJmYfzsXVdGW0DyVQZTKaygABKozuy5JgNtVTjNcaV4rioKZIJyY0AaMJi0uaz3BNygZDQq1D4DZsZXJKS/A0PJI6f+dvV//RH0hwpjg0hgTZJeqe3PU4FnTYZiRV7FiH/HRS3IMRFn+ZEU+lgwbxCoKXlfLa+bksX3kc6pepl68VZioVjV0B3ohS6fv8HjQKNpJEGZS5ojkMusvfjizcbRRB9VDYegODyE0Q2XlzuqxRxJveYRnSel4i8+7t+tiYt6st+1/SI5mB7M6TD1bYy6H19BuZySpQwYC0vm+LG8yWVAT+3poNWzjshE6J8nq9KAwVgOMX/8BYSd3XA6vhLZW2Bszwn4mubptGAmp6xYfjut0/FbL9yUwezY3qYSbwIr03D//Cxl0F6ka7bLzX1Jmtuai5fcDlFKVbFM5vpD0go7XQeR9ObCFaSYl8JxtL3w9ZRP7sFpv7zYIfrbo4zB8nDMudwgKVSG4klLnoPpO25UOI8DC/Cx/95zIZknS4aYF1XXCRzzqDu2/5+2RH4+VMs5Sz+wDxgi4s45NantvLg98jRiEf2r1TN/zuqLJyGhHrBByJTGXHZ+B/Hgp+O12h7BNXt/P3G4oFH1DwOwzjMvct8xLnM/dv0girFzMtxHk6jvt6DA4=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(82310400005)(36756003)(70586007)(2906002)(7696005)(107886003)(36860700001)(82740400003)(8936002)(6666004)(316002)(40480700001)(5660300002)(54906003)(4326008)(41300700001)(86362001)(7636003)(8676002)(2616005)(70206006)(356005)(478600001)(40460700003)(186003)(47076005)(336012)(26005)(110136005)(83380400001)(1076003)(426003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 16:15:08.7274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a6595d-8aed-4318-6d7c-08dac0db3d8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6406
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

Keep track of the mkey size of all cacheable mkeys, and by this allow to
rereg them.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 8ff10944ff16..fe5567c57897 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -709,6 +709,7 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, u8 access_mode,
 			kfree(mr);
 			return ERR_PTR(err);
 		}
+		mr->mmkey.ndescs = ndescs;
 	}
 	mr->mmkey.type = MLX5_MKEY_MR;
 	init_waitqueue_head(&mr->mmkey.wait);
@@ -1374,9 +1375,6 @@ static bool can_use_umr_rereg_pas(struct mlx5_ib_mr *mr,
 {
 	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
 
-	/* We only track the allocated sizes of MRs from the cache */
-	if (!mr->mmkey.cache_ent)
-		return false;
 	if (!mlx5r_umr_can_load_pas(dev, new_umem->length))
 		return false;
 
@@ -1384,8 +1382,7 @@ static bool can_use_umr_rereg_pas(struct mlx5_ib_mr *mr,
 		mlx5_umem_find_best_pgsz(new_umem, mkc, log_page_size, 0, iova);
 	if (WARN_ON(!*page_size))
 		return false;
-	return (1ULL << mr->mmkey.cache_ent->order) >=
-	       ib_umem_num_dma_blocks(new_umem, *page_size);
+	return mr->mmkey.ndescs >= ib_umem_num_dma_blocks(new_umem, *page_size);
 }
 
 static int umr_rereg_pas(struct mlx5_ib_mr *mr, struct ib_pd *pd,
-- 
2.17.2

