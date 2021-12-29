Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2303A48111D
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Dec 2021 09:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbhL2Izq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Dec 2021 03:55:46 -0500
Received: from mail-mw2nam12on2042.outbound.protection.outlook.com ([40.107.244.42]:55456
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239412AbhL2Izq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Dec 2021 03:55:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDOoqhbwJVkQn3WXVpL+HXUx8ypRyvmvtOoH6RHANriYTrqq3uKQE55FCpdF7hIwZ/qPF1NtWtQBYPPEFa2qzvvNsihY+B9kXKDO50S2498NKZVsK7YJ4wSnwTlB1YJ2RqUAzOKW/zfaOAhmPodcQdVS8C7j0kwcPbgY3MVFThP2+PTfev06fKPwk2SInGjTIx59rErbdzUEpTwOzOFW3somsoJD0EeSZukj/fadRL+aHF7d9GmfE4TCYWGtLRU/mM7LdnGlnPkA+4ABWSQmdVs8DHch56KKiSqalCSfpqQuvP2elv+l3RJL2snXcZaIPVypRE/cw6x+HdMOauGPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leBCODyVFOt7A0lN+Mv2DWMy9XvvxY0xsOwnmyScAyM=;
 b=P3f5EE1nuHPIOTIaUp2hoBpl8jiKW1dJwVKG2iaSzNBOXyEFQwFAFJ87AXaClHyR8qlYWO00ToHdmY1b3pP/7wjmLwfaVHArPpZ1USMJrgB8iAApgvzc/w46XDxkxaOIDrj6ufsMl0tTqJbciUuR4xkexf8ZFPCCDWTBLuSfTnBJykhmCcFDHMRr11FqY3Fv/kju9BLIJ/eCPSoyxYRX1M33N+LeJB9RGSn1i774f6Q+l+LIp/YY2OrIuOOKsQKEdfmiUMEfXTmH6D8wSoF+sekgbRvIxDNwUBPbDwJS+R5/bC277BEUDCI/ogQ9hyMwrL0OhCaISSWi4+6OkSAUfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leBCODyVFOt7A0lN+Mv2DWMy9XvvxY0xsOwnmyScAyM=;
 b=adqZAhuIJcaak5J5gkEsSuX3BlgLcmGee909jkfu/2V8BUGJO1sNQRmo6E+t0Au7G2ucG4QxK1iW6BmnATWjVWtFU98fqXhhfmY03McLIn66IbLF47yqSqp1n/jPHQ/S3sNA66A9INaAomaExhGKXepURAckFWxbMXQJnPtXQVnZkQrh3vTi+/Mz2yKryuOnLF9iMLbvysAvyB3hIfxrpB4FXiDHsMnMLPsk4ct+BhrsZ2Zh47tkz1UgIVFW7rioLzefcaHes99Z9FA7V5l55sZY0TWRqWiqgoccOv90h8wFTJZKYnUszMkVNQ2REHE1sdMCvkJpTkdW3LuXshnhVg==
Received: from DM6PR13CA0057.namprd13.prod.outlook.com (2603:10b6:5:134::34)
 by MWHPR12MB1839.namprd12.prod.outlook.com (2603:10b6:300:10b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Wed, 29 Dec
 2021 08:55:44 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::31) by DM6PR13CA0057.outlook.office365.com
 (2603:10b6:5:134::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13 via Frontend
 Transport; Wed, 29 Dec 2021 08:55:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4844.14 via Frontend Transport; Wed, 29 Dec 2021 08:55:44 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 29 Dec
 2021 08:55:43 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 29 Dec
 2021 08:55:43 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 29 Dec 2021 08:55:41 +0000
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <msanalla@nvidia.com>, <edwards@nvidia.com>
Subject: [PATCH rdma-core 3/3] pyverbs: Extend support of NDR rates
Date:   Wed, 29 Dec 2021 10:55:02 +0200
Message-ID: <20211229085502.167651-4-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211229085502.167651-1-yishaih@nvidia.com>
References: <20211229085502.167651-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d0885c4-d104-42d4-309b-08d9caa8ffaa
X-MS-TrafficTypeDiagnostic: MWHPR12MB1839:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB18392324A3F8DE6651FE5A36C3449@MWHPR12MB1839.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZvsimKQcrs4XHrSsgG4prWlkT8t7tbzhB7KuN6FQx8S+vQ+DSWHDRNAQ5K072aDo+ETrv7+nC+ecaXByRqZWm0ZpIZFuJIuS50fRy9zSSRsVoKtZWekcl+k9gc8ECE9ae5S/C0f6R4VytrS1PoNCwQ6zN+ok9gDydrYxot23VGTNB8V/zZ7wlG3+/xGuaeVx68pAmRA9vX4SMu+e1ZtzNjfqC84WT6HMx/kRd9zA2hkYlyUnBcdDCYIc5arrJZHjru48DS5u+TAmuyUSLsqVsbLXbGi61/PKcUI1nXqAxCXj/srPlsVSRDd093KITGebXk+2wWaAF+wyDILVDIfIJws01ixtBzQvfY9zpTSUR97puOOM3nm7+5q0We7zk3BDCATYfKi1JIa+gz5lUZqM5PS4AbUSmupVM6CaKyzMN7bPuh4Ff7Ges6ebIS1yVm+dQNcYnDmomRBnQB+/eypM8kx9TPhnUCerPACCktI/Sh6GOQFZHM0Du+MPtgdx+1tWdlNBMxfUso0bqsPHQj+bA6Xwn6GEWWh+gO1hEPQ6HIu7YeN3GP8b08CaY4+IuJp176/hVP2UVEBeF6yGMEjUHrnI9IMgd/M2q22r4gGiELz9+CmsUppLvtr4K/G5PYu9oznK2BGnEraHITljea1oj1guSWArCy6WAuNS15bqgowlF+zzpvmMCjx2boOroZ24FWKnI/gGJOgdWh4B/XY1BvN2Q6VVxWi/A8YLkV/XJncFfLpNbkdmcjWLyALnetT6imUqTrB97qc6XaW+HpkVn8eZHbQIK55mITJH19ospMU=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(4326008)(36756003)(36860700001)(186003)(5660300002)(8676002)(6916009)(26005)(2906002)(54906003)(316002)(107886003)(6666004)(86362001)(8936002)(1076003)(70586007)(508600001)(83380400001)(81166007)(82310400004)(336012)(356005)(7696005)(47076005)(426003)(2616005)(70206006)(40460700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 08:55:44.1196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0885c4-d104-42d4-309b-08d9caa8ffaa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1839
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Edward Srouji <edwards@nvidia.com>

Add new NDR speed definitions/enums to support the new data rates.

Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 pyverbs/device.pyx           | 3 ++-
 pyverbs/libibverbs_enums.pxd | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/pyverbs/device.pyx b/pyverbs/device.pyx
index 55d708e..6f68a68 100644
--- a/pyverbs/device.pyx
+++ b/pyverbs/device.pyx
@@ -1091,7 +1091,8 @@ def translate_port_cap_flags2(flags):
          e.IBV_PORT_VIRT_SUP: 'IBV_PORT_VIRT_SUP',
          e.IBV_PORT_SWITCH_PORT_STATE_TABLE_SUP: 'IBV_PORT_SWITCH_PORT_STATE_TABLE_SUP',
          e.IBV_PORT_LINK_WIDTH_2X_SUP: 'IBV_PORT_LINK_WIDTH_2X_SUP',
-         e.IBV_PORT_LINK_SPEED_HDR_SUP: 'IBV_PORT_LINK_SPEED_HDR_SUP'}
+         e.IBV_PORT_LINK_SPEED_HDR_SUP: 'IBV_PORT_LINK_SPEED_HDR_SUP',
+         e.IBV_PORT_LINK_SPEED_NDR_SUP: 'IBV_PORT_LINK_SPEED_NDR_SUP'}
     return str_from_flags(flags, l)
 
 
diff --git a/pyverbs/libibverbs_enums.pxd b/pyverbs/libibverbs_enums.pxd
index 93a0f13..b3ea226 100644
--- a/pyverbs/libibverbs_enums.pxd
+++ b/pyverbs/libibverbs_enums.pxd
@@ -74,6 +74,7 @@ cdef extern from '<infiniband/verbs.h>':
         IBV_PORT_SWITCH_PORT_STATE_TABLE_SUP
         IBV_PORT_LINK_WIDTH_2X_SUP
         IBV_PORT_LINK_SPEED_HDR_SUP
+        IBV_PORT_LINK_SPEED_NDR_SUP
 
     cpdef enum ibv_mtu:
         IBV_MTU_256
-- 
1.8.3.1

