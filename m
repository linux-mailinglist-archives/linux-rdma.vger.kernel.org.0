Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1312B38E2C0
	for <lists+linux-rdma@lfdr.de>; Mon, 24 May 2021 10:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhEXIxt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 May 2021 04:53:49 -0400
Received: from mail-bn8nam08on2066.outbound.protection.outlook.com ([40.107.100.66]:61952
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232318AbhEXIxt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 May 2021 04:53:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBpfOzu5GaoQokJ9Rm/A2IO1pm0wUj3NkjZUlLddHBTPZ9g7H8MBAATv3zRqxSzDvBedvABFrSoMPQw/n7ZCqXpW9Q+rgvLeOAJXJ70C1dGoQ4RI6Anydfw5rGgP9zgvDa/1Kbe7wuFZy8PPozzhMXK7FWlltu+R4OGUYHKX/Lz55Fy+TyNaXzd0fvYXwCZ+9fWlpMh/97Hfm209mxzwmitFUbf4Qwxe6sTDkuDy8LCo7PoA55+/oCU6kLeNkjGS/6s1vGi/rRT7Kpcr1thktAKdTyQNbpCz6ovQB2p34BPUtEJ9qReWUR+scKpV3bTuPfe64ZyD7/uhVg2E+tm32w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mA5GjhSCnkVqWmgej3cbMgC6PoB1PGvKjrJGTv/2EoQ=;
 b=chOILD4V+cVsjevw8MasSxNU3UK4pRmp6N7WLMzQd8G+Si3G/JLuH3jCMv8jq+cMudIKreKOEHhHI72KplkdA8+w0ejqBKERDUNriNH9FAn0xWQ4M9jJ6cgFXIA4QL+IFut42lhqCixhq++dlx7EkgJDqUWiEtafbW9L2ic90YdnPl2nguITp4TBtk1GFgYHbr+t4exO+Yt+CaQ7JxDKmdyyxnJE0QRePw92jK4DdQbKwLol7JJIy+4DSEVpFV6+BYltMJrlc9GJeZt/fOrV7MqYIavQD6IFRqwOYF8KD24ne9FhHgIcjjQLPkDhbXIxBrOlBQOCnECQfDzFex0rFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mA5GjhSCnkVqWmgej3cbMgC6PoB1PGvKjrJGTv/2EoQ=;
 b=qXLlXvd4tEUj0/ChWArb7CVZqEZXT0fHqPXWR2VVfCEsSdNmcKNdzx4yvrnCxanK1n9mFM9IH54G5E+RZX4vai9WsBU7B8T1P+CKRetMK2HkFqLiSTIPaXCCljCn80XtReDDY6+CKXGVOSSxPW9pDWkhV/kB/yFvAPc2dRrvNFMVBMxhlDMwNmzwtGJxLYq5TxMql6RQbrLOGwzZ7NuYfQzGvbu2N5xeeyTd0W/4eyej7lj+bkeE7CfqVf9wumZzj4Ws71lP7PxY1Gf4UjuLjXdfKYccx+S8Hj5sEDffTwJui6SuPYYhDeQUk3FBLtbD/3TaVYUDtnwmFf/y3pqCpQ==
Received: from DM6PR03CA0091.namprd03.prod.outlook.com (2603:10b6:5:333::24)
 by MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Mon, 24 May
 2021 08:52:19 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::d9) by DM6PR03CA0091.outlook.office365.com
 (2603:10b6:5:333::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Mon, 24 May 2021 08:52:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Mon, 24 May 2021 08:52:19 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 24 May
 2021 01:52:18 -0700
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 24 May 2021 08:52:16 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <sagi@grimberg.me>, <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>
CC:     <israelr@nvidia.com>, <alaa@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] IB/isert: align target max I/O size to initiator size
Date:   Mon, 24 May 2021 11:52:15 +0300
Message-ID: <20210524085215.29005-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55646ba4-4865-470c-ac96-08d91e913d28
X-MS-TrafficTypeDiagnostic: MW2PR12MB4684:
X-Microsoft-Antispam-PRVS: <MW2PR12MB46844DECDEA4B20870A954DFDE269@MW2PR12MB4684.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: be74rzjXufCYvWMEMaIhIZh3cioTbkQf/MDTkW29UvwvTZVMEvol8SviH5uF4MQYK25XEiIRXlQ8LbTGmYmAeiPHEj72i0IIU5STxwU/Q6u9grI9m8DE9SIh0PLIMIrvXEjND+sb/o3IWUk3DlTvdrTvIaHSw68FujJgyF0E5w+ykXW1Rvzr7uD8W6Cw6vJMgWHqiEUriX8MST3gFZ2SE1xgZ3To1n02nSrO/YQMh8A+uyLOqfNwzVS3V3zb9/QUwf9gmhPNvT8/8F7gLHhWnj+Qrz6s4GQ6p33Fxz/xcKaL6TUzX6eTwfPXmV1B3lQ1eQxHAAcGAzI9pU5EupLr/ggPvGuzXfdXfCbwgTN9Lwpi1ihjfdVCf6Q7gpW2omQuGZiWWS57GYE4UwMJEeAazwITv0vlY0wVwxggPe4cH0SKOstKNXqqPNsc6EGa1xSGNGwWL+CuTrDKGUS5oalYDweJK9OT7JYpdeVmfv5fhDwAcWUfrJIgbCYKKYBXeHl42tCl8LhlbJXKDSiOQfebThAdHGBNgsrkM7e2vKoZQ6ZJUyJgI4n24yJZcSh4t6ioYbuzqO3CaLtoXvF3gsCngaJu1sQHNFarZciHJoIb/Ay2dFERwp8qsp1DjaJyHDg/0zss9BM4GCwfFgAp+ZDs4DYCLrE0Jf7gHC2CKVsTIMM=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(36840700001)(46966006)(8936002)(5660300002)(478600001)(107886003)(26005)(186003)(47076005)(356005)(110136005)(1076003)(36860700001)(54906003)(36756003)(8676002)(83380400001)(336012)(2616005)(426003)(6636002)(316002)(70206006)(82740400003)(4326008)(82310400003)(70586007)(86362001)(2906002)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 08:52:19.3433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55646ba4-4865-470c-ac96-08d91e913d28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4684
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since the Linux iser initiator default max I/O size set to 512KB and
since there is no handshake procedure for this size in iser protocol,
set the default max IO size of the target to 512KB as well.

For changing the default values, there is a module parameter for both
drivers.

Reviewed-by: Alaa Hleihel <alaa@nvidia.com>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 4 ++--
 drivers/infiniband/ulp/isert/ib_isert.h | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 160efef66031..97214329c571 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -35,10 +35,10 @@ static const struct kernel_param_ops sg_tablesize_ops = {
 	.get = param_get_int,
 };
 
-static int isert_sg_tablesize = ISCSI_ISER_DEF_SG_TABLESIZE;
+static int isert_sg_tablesize = ISCSI_ISER_MIN_SG_TABLESIZE;
 module_param_cb(sg_tablesize, &sg_tablesize_ops, &isert_sg_tablesize, 0644);
 MODULE_PARM_DESC(sg_tablesize,
-		 "Number of gather/scatter entries in a single scsi command, should >= 128 (default: 256, max: 4096)");
+		 "Number of gather/scatter entries in a single scsi command, should >= 128 (default: 128, max: 4096)");
 
 static DEFINE_MUTEX(device_list_mutex);
 static LIST_HEAD(device_list);
diff --git a/drivers/infiniband/ulp/isert/ib_isert.h b/drivers/infiniband/ulp/isert/ib_isert.h
index 6c5af13db4e0..ca8cfebe26ca 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.h
+++ b/drivers/infiniband/ulp/isert/ib_isert.h
@@ -65,9 +65,6 @@
  */
 #define ISER_RX_SIZE		(ISCSI_DEF_MAX_RECV_SEG_LEN + 1024)
 
-/* Default I/O size is 1MB */
-#define ISCSI_ISER_DEF_SG_TABLESIZE 256
-
 /* Minimum I/O size is 512KB */
 #define ISCSI_ISER_MIN_SG_TABLESIZE 128
 
-- 
2.18.1

