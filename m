Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC735B27F4
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 22:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiIHUzH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 16:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiIHUy5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 16:54:57 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E87E4DB54
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 13:54:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMcPLoMayApWR31P/cYzLE+90ug0CdlJRlPSPX3tEH1eMCassPcFjVRvvpXyEHUNQ08fGMNzl/NnqNPfq5b0AIhad9JDZVpugJYDPzHI3t0GU3FDQL3AQpvAe4LZ47TxKg0H/XaqiV0JpxYEHIW4r/M7ugdVjpyRv+R+W7wjuoe2QHvE9NkAOvivZpYpFpvWW/CJ9GzJbXi3ljOaasHLicC+S9AO+NmzRqi350a/KdLj9MSNZVkSBp3Q/uko3/xDJ9oPmsoEfr+KczRZW3OoRAFvwJD8urYIba0OLTHUH2ZmSJfPkzZ1Q55wRKrT0STGW+y8+1BtiqUFKWtaH7QzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFVwuAC07SL+VYyBVnItsK+1LKspgtV4dNl6EMG2CMM=;
 b=QRnGRAeg88L/v6zWf4xIsCBfvr5hYtw9rwgMP2d3tIxbPOOwES0fQfD/Cy2wt3E4iIgq99hHd2Bq8HSlUqtF3N/dktYo+Fm3MYs3+rONsazjFhdhG32qce/flzOJns+cziorco1HnQBSAME4sGFGTU3wWgwl4hHMplHLicIJ97LdJaDNw7IwZkYXRL8HEe1aSfzI3Zm8OGw0gf5x2C8fkpEQBlNbjb6bLk+dlusBtKac9wfaQZwgzLOfCXOVDI4spdJLU51+VW2LaPtZDp8YRHcBjYCgzkALcHUmt2ZRF3grvY/mNtph3l8rQp0p10ILcP6sdHWmh9/CfiNfCuax0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFVwuAC07SL+VYyBVnItsK+1LKspgtV4dNl6EMG2CMM=;
 b=Eks+FzfrU6d3qsj9tu+dZ8GQ0wgLcx2U7QSdJjzyUAtocyT8wLt0PizNzixAh9Wa37A2cdBOvhpDIXn9KULs36vwBgF2xRZAJEaSNhhbUHrAVdAbU7DU6zbr7nc4i4BEysNZ4gPt0c04g/kZrwArCDYKtX+3TUYmE8WbCT+D46ZhqF1qI4jSD/190e4ZjJG5v+HbHpBgsGbC2MbHimCSxKx2I+8nBsm4r2MUsWK5h0o+SKoXCjquDTuX4ekw/IvaVz4ZhQGoYmfm2cemZZwQrxbcadg5alPU2uIPgm9tvF5JbST3u2Y8y2zRRTft9rUtDgdea3xauQbxZhAP47wUUA==
Received: from BN9P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::8)
 by CH0PR12MB5154.namprd12.prod.outlook.com (2603:10b6:610:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Thu, 8 Sep
 2022 20:54:53 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::b7) by BN9P221CA0017.outlook.office365.com
 (2603:10b6:408:10a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Thu, 8 Sep 2022 20:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 20:54:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 8 Sep
 2022 20:54:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 8 Sep 2022
 13:54:51 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Thu, 8 Sep
 2022 13:54:49 -0700
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>
CC:     <maorg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <saeedm@nvidia.com>, Aharon Landau <aharonl@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 4/8] RDMA/mlx5: Allow rereg all the mkeys that can load pas with UMR
Date:   Thu, 8 Sep 2022 23:54:17 +0300
Message-ID: <20220908205421.210048-5-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220908205421.210048-1-michaelgur@nvidia.com>
References: <20220908205421.210048-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT064:EE_|CH0PR12MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: ee871d96-f7ca-4cf7-58b1-08da91dc6131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SnJRY1+cXC/LQ3knZyPM0PafaSjCVJ7w+OAUvsaYVxuifVnEt03WaUfRAQn6VWC5Lo1EqzeFkmhw8EHrv0bMQu/W8WYO86m4itgI1ClJ9z+NC1nyC6VfzsWn5yK6ZH0wl9es7z33KCmm8G0gDiw74MCNORGX9lSGhJiyMBWeoZ6o2V91DAPUawgTOuvKhgIfknkc9jRV4l9rWEAj2iX1BNgLhFPCUKGCbCS7HCumgpl+g8mjgTMNbl+vtoBOnfjjO6L/jGPAQffT+BFtXZppiuyf2j1nX3dVN5NJ6GqmlCcxdzCaLS0iDsN1cX60p6bnYjMItH4lshnh3Hipro8ejUQXJqMx3u9NicL40HrNOEemTRbiQ4X+oYn5yxisQ030af8ly5rf5zOHJ2NOnzxu29yoktHeBNvd6Ce4KVXVXDpcQYO11kqhq68hIktiSDCXktSe0v1WNUXFTa1zol5s5oJH3r6ak4TV/YbGHJaJyTFVLnPAjWVEo0bSjWG4bUQmMnRJ0lE1GyhqVL8wJ0kZWTY0TFG91K87qX1WUhXz3s6HPl6A7J1jIT5lE9GPPveqgl4mkuQh6/9Sgq30j6NClpNmS3NM8Lphd//gW54N43p1Px8t3COvdkbz/U+vOCzmqnrOVK+j+3WMqnivBUDCUKTopfzmz6AqA2zhLbDD18EcMExy87YssP9ydfV4Yf3UZvup7IvMLk00Qy1OZzwjryBIog3mBBtqq/OHPRb+XT8oDrplTDcxUjDkXgGsVoFTBHxDyqia/VEcORhaj5w4La4xp05cqqj2f4vr5iGC0fTAuOPZkx3MLC1glN+DkDLc
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(39860400002)(36840700001)(46966006)(40470700004)(8676002)(82310400005)(40480700001)(70586007)(70206006)(86362001)(4326008)(2616005)(82740400003)(6636002)(336012)(1076003)(8936002)(5660300002)(40460700003)(54906003)(316002)(110136005)(36756003)(2906002)(426003)(7696005)(356005)(36860700001)(41300700001)(26005)(478600001)(107886003)(81166007)(6666004)(186003)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 20:54:53.4084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee871d96-f7ca-4cf7-58b1-08da91dc6131
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5154
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

Keep track of the mkey size of all cacheable mkeys, and by this allow to
rereg them.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index b8529f73b306..ea8634cafa9c 100644
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
@@ -1372,9 +1373,6 @@ static bool can_use_umr_rereg_pas(struct mlx5_ib_mr *mr,
 {
 	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
 
-	/* We only track the allocated sizes of MRs from the cache */
-	if (!mr->mmkey.cache_ent)
-		return false;
 	if (!mlx5r_umr_can_load_pas(dev, new_umem->length))
 		return false;
 
@@ -1382,8 +1380,7 @@ static bool can_use_umr_rereg_pas(struct mlx5_ib_mr *mr,
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

