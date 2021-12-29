Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF2048111C
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Dec 2021 09:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbhL2Izp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Dec 2021 03:55:45 -0500
Received: from mail-dm6nam08on2047.outbound.protection.outlook.com ([40.107.102.47]:55393
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239412AbhL2Izp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Dec 2021 03:55:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAzQKnusYLST+NZIaBMqpYq9SDmDwarbH/PPGiu5MMTVOwj5P9EXMUX/LMNps0dVbS0+LGLjUobWxp8rcCJ3M8OSJVU7N0jkTqNjMp181eKZsbax5oEy4EX/2M4R8xPDuZbNyrDKoQmTMl7WrcLDoK4c39oRBdP6MPql8neYaLyJ6CZ/YFvCQHRKkqmlKXA1AaYU2BZl24gq0xaMPb3lkz8lvYo3O3FlJTVQnWZXTBcePqlx/bYoVRSajW7HkBKqgP34DLmW70OZ/KmRgl15viaI78tSKH0JqrC4NBiE+I1SzkAPLYnVi5EFog+76rCe3sU1dpSFSaNpLcLqdGeb/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xzYxaRt1eXkOhIWU0Rz9HKkbwTZtz+tlicKf3woDkA=;
 b=KHJxukLQiq6t2W4F/NWJ11uTz7mpO2CSvUdN3rngjoYakKMhUmv1kHiAk3hiak+1d11NADob3zgqwSPxUeCemryaLop/TBdl6qxBTl/dYZxqyptkYvsVexfV/wmVOEa1nJsBx+K6wIrfkbWoRc7Tkvmhb1cqwilUxNL/Fly7lvT++XpJvxPEJyWjJc4VIVAUOTp90YWmnVLIgX4anSDcRMKAKwmiU1jp8lvT11bJXR/lMvwvcyKWso5ykQx0MyrKtmLA6IwJYtd9eAajZD1aeYxrA9a4GIJIl4Emqjh56DxOOCSvngzNEORDEEb3iCRSuMrf1jXKPulQnxkdB2XmzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xzYxaRt1eXkOhIWU0Rz9HKkbwTZtz+tlicKf3woDkA=;
 b=N/ToRwzVqcidKDggav/wflgDFor0pJ7N9Mm5+2k0vm/AAt/GA+8sI4JNcQU3EfPBkADLtSmU6tjk579rKWJwKFbVrI/uuXZKfFJNTKV1a3sYLenJ5torGmHigU+O6Lk5CUJm4rCBqb5E7BjeQjeReBT57VXWkrCGCM7GMn+u0azmnt/2WAKizl2p1Aqc7wqHGqFuBPdu6AtejVUZdhXQgY8Uio9phImnyuQWJaHeOv4CZ4oLANDQ3wpkF8+GwV/AhzNHakMroUjh2dHIjPqYOC99WpzblAgzdWt535nuYvmUfNtVXEGL+iZs/jVNJa/a/t0iQ/wgZo3cshR6Fmhe9A==
Received: from CO2PR04CA0060.namprd04.prod.outlook.com (2603:10b6:102:1::28)
 by MW2PR12MB2588.namprd12.prod.outlook.com (2603:10b6:907:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Wed, 29 Dec
 2021 08:55:42 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::c8) by CO2PR04CA0060.outlook.office365.com
 (2603:10b6:102:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13 via Frontend
 Transport; Wed, 29 Dec 2021 08:55:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4844.14 via Frontend Transport; Wed, 29 Dec 2021 08:55:41 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 29 Dec
 2021 08:55:41 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 29 Dec
 2021 08:55:40 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 29 Dec 2021 08:55:39 +0000
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <msanalla@nvidia.com>, <edwards@nvidia.com>
Subject: [PATCH rdma-core 2/3] ibdiags: Extend support of NDR rates
Date:   Wed, 29 Dec 2021 10:55:01 +0200
Message-ID: <20211229085502.167651-3-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211229085502.167651-1-yishaih@nvidia.com>
References: <20211229085502.167651-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69ed807e-ca36-4a45-161c-08d9caa8fe58
X-MS-TrafficTypeDiagnostic: MW2PR12MB2588:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2588DF300C2F6CA2DCB71469C3449@MW2PR12MB2588.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6I14F9IxJI7B5sDtCviCS2RkH8tI4FcRXkNTVTd5x/+Bxntmc+zdaC9LDA08ng/43FCH9lgYFzVjnRbYQBYwjbsmycc+uk3Jg1/g+Dsvx57c0H4m9FH4VxMHkG4CBVYX8EpcfxUG0OHeMnWp2ilipWHopzBCBlDwJ3LKxNlg0JxhAjPcQalHwV0uUXMiMaHB6CYZAKSwT1yEne+nHRozt21ptaS/4XIqJDCkJb0Qeqv59nF4/18QXXFJmU1hf9SDSPj6FjCyvYDI8gRVvgWfXKJnsxhO5MRBwHl2gwyAsMd9oYc5ZDU8S2Mvaroi1wRzVmxm6q+/cdvGu2E3X7/D+64nKrwHMagypgkV8ZvVKMT40VAF5giKSM6c8mVKCXVPbls5baeJiXdyE2YlEN8DOjwpuuTWpK7eCU14K7lCUWYdOqrMxiFWRCulCmVg5Py+YsvMVFiEydxKid8XKt7Fd6Q6ySXgELPm0ihp5oz8yyO32Mqi6cJr4fN2hDxjIHjEZcupZXn4bYgWjjDEvoNkElIERbbeHCaPMoxeySWG5vUIWfFMyAziwwgHTEsoM7qnVMcHtIKF+Vg2AlcgfmG5TER2O0ckJibJ2RQfSbfDaE29A8fkot6EYa/SqMNM1OvMa1+RzkovkJ2Gm/uzlP2n+1c2fzrO6wEKv7R4Ya5BX17Z+dtjfD8z8YjUeA3BlX8/tx9wRAQQU1lq/UlXSKYnmWULUKhC92Poq8weDKzlt+fbLgNsgBpQVvq6/zuvBYc7ZB370stYHUtw/CLXwf1wjsiz0dWLF+OztUO+WSkbPz4=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(1076003)(83380400001)(508600001)(36860700001)(70586007)(356005)(6916009)(54906003)(81166007)(36756003)(336012)(82310400004)(19627235002)(70206006)(7696005)(316002)(6666004)(2906002)(47076005)(8936002)(4326008)(26005)(5660300002)(107886003)(86362001)(2616005)(186003)(8676002)(426003)(40460700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 08:55:41.8888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ed807e-ca36-4a45-161c-08d9caa8fe58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2588
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maher Sanalla <msanalla@nvidia.com>

NDR(106.25 Gbps) support exposed new data rates:
800 Gbps - NDR 8x.
1200 Gbps - NDR 12x.

The NDR support bit from PortInfo.CapabilityMask2 was added to libibmad
as well as the new link speeds mentioned above.

validate_extended_speed() function in infiniband-diags was adjusted to
validate NDR speed.

Reference: IB Spec Release 1.5

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 infiniband-diags/ibportstate.c | 8 +++++++-
 libibmad/iba_types.h           | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/infiniband-diags/ibportstate.c b/infiniband-diags/ibportstate.c
index 7f3afb8..5319e68 100644
--- a/infiniband-diags/ibportstate.c
+++ b/infiniband-diags/ibportstate.c
@@ -353,7 +353,13 @@ static void validate_speed(int peerspeed, int lsa)
 
 static void validate_extended_speed(int peerespeed, int lsea)
 {
-	if ((espeed & peerespeed & 0x4)) {
+
+	if ((espeed & peerespeed & 0x8)) {
+		if (lsea != 8)
+			IBWARN
+			    ("Peer ports operating at active extended speed %d rather than 8 (106.25 Gbps)",
+			     lsea);
+	} else if ((espeed & peerespeed & 0x4)) {
 		if (lsea != 4)
 			IBWARN
 			    ("Peer ports operating at active extended speed %d rather than 4 (53.125 Gbps)",
diff --git a/libibmad/iba_types.h b/libibmad/iba_types.h
index 0805aa9..f0c15ef 100644
--- a/libibmad/iba_types.h
+++ b/libibmad/iba_types.h
@@ -749,6 +749,7 @@ typedef struct {
 #define IB_PORT_CAP2_IS_SWITCH_PORT_STATE_TBL_SUPP htobe16(0x0008)
 #define IB_PORT_CAP2_IS_LINK_WIDTH_2X_SUPPORTED htobe16(0x0010)
 #define IB_PORT_CAP2_IS_LINK_SPEED_HDR_SUPPORTED htobe16(0x0020)
+#define IB_PORT_CAP2_IS_LINK_SPEED_NDR_SUPPORTED htobe16(0x0400)
 typedef struct {
 	__be32 cap_mask;
 	__be16 fec_mode_active;
@@ -803,6 +804,8 @@ typedef struct {
 #define IB_PATH_RECORD_RATE_50_GBS 20
 #define IB_PATH_RECORD_RATE_400_GBS 21
 #define IB_PATH_RECORD_RATE_600_GBS 22
+#define IB_PATH_RECORD_RATE_800_GBS 23
+#define IB_PATH_RECORD_RATE_1200_GBS 24
 #define FDR10 0x01
 typedef struct {
 	uint8_t resvd1[3];
-- 
1.8.3.1

