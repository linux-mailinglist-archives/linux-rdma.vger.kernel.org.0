Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A9F48111B
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Dec 2021 09:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbhL2Izn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Dec 2021 03:55:43 -0500
Received: from mail-bn8nam08on2040.outbound.protection.outlook.com ([40.107.100.40]:1857
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239391AbhL2Izm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Dec 2021 03:55:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPprQn7pEn7OJKuPXeBEN4RUEkUyHLbEKzyaBpijKkpRsDnquRqtKzoFXGOESgkvSkrLgodbZbBRD7DYG7uxMw31K2WAL8VWgyfR/mvSNSziSRBCOz8u37UZECLbzXWem1d6ffzvGTpAwgdsRXQWyn7R/rdwJpITNNRuBlLpRA9eIfUPGDt1WvC4NG6Bh9ksmeOc3HpIpgk3xV9Sfq3onMv99c7kcWGOcPsmfOxZJJIFtcCS8Nba0JOEglrp7dgeTzp2Jtcla5iXEAqRtkGDrjQkXxUVJBWFmv4tnVnm5z3o3yzZj45u5aANqeIN1/FOGPHngSN1qfmlaw9n/KT03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwlh+pNVdMWw758S/aBn54CWIlx0mXGUZRdTgEnftzc=;
 b=P9gfEe7fZOwZOWJoHDtsn1sjZylI+6vVyWJz760opTHy9YCz9VrUs3+1O5USQSssH5CHA2XILpimJQ2uG1DjDiqvaNXgSp2KzWsqyYnlDTW7Yxt5H8dy0qcGkw4H2iQebi4qCm/eVprAxutIsAYqlLCui/UlOlNCeMW+3yWhOdpwJQ6IcSgg7fg5d0EzIkVBF5OsgCmsrfZ1dVUyC94lKpYE59Xx55djNNHhgMvdICFjSVM+Yljt5GKjFTofPvjQWN6lpwIYX4x6gFs2G4IJdML6xPyUwFOVTr5ZM12wb0mPGqBCF36MPSFLnSwQiXtwi5WwAZh/84i1xe+AJBoFLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwlh+pNVdMWw758S/aBn54CWIlx0mXGUZRdTgEnftzc=;
 b=RR8xlR6Gc81nNPkxBLvrktly29iPeoM3yi5zE82twitMWmelvggGQQBGsZi3LE5+fTRWbj3QzeRZtucRQskjvPpNfKz8ErAE+eZ5DVRIjj9m1euGAvfLcWYZTPNGN/KU6hzwJxILQTA9iYRZMndwiX15JZgLRJEJbZLhZQvVhg36MDVxDLZnpaBmvhfIj8zzAeeXXfJHAzwemgFsbblmEsZtcP9WucAHKiy23AeAiZHWfKao7+Yg44ocmTNfudt5aNzfHVhvoBldzyKbiCdCpoBK0P0DjLJ/qtlMFbzUi+VTWPXwKhz4QYt9KEtURdRbH0t3cs5hav6TUzMtnPOloA==
Received: from DM5PR15CA0070.namprd15.prod.outlook.com (2603:10b6:3:ae::32) by
 CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.21; Wed, 29 Dec 2021 08:55:40 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::42) by DM5PR15CA0070.outlook.office365.com
 (2603:10b6:3:ae::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13 via Frontend
 Transport; Wed, 29 Dec 2021 08:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4844.14 via Frontend Transport; Wed, 29 Dec 2021 08:55:40 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 29 Dec
 2021 08:55:39 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 29 Dec
 2021 08:55:39 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 29 Dec 2021 08:55:37 +0000
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <msanalla@nvidia.com>, <edwards@nvidia.com>
Subject: [PATCH rdma-core 1/3] verbs: Extend support of NDR rates
Date:   Wed, 29 Dec 2021 10:55:00 +0200
Message-ID: <20211229085502.167651-2-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211229085502.167651-1-yishaih@nvidia.com>
References: <20211229085502.167651-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6de740cb-855e-4dcb-0682-08d9caa8fd3c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4166:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4166E27C0D309E33F64C291FC3449@CH2PR12MB4166.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTdcJ+GHsUA50EvbQm3L3HSMyQTJyYiTK2nZl70ucG62NkVDt/IKBt92CEQRtkpb+Oz60sx0EacupQ9qSeQocydSdetjduFSRn7gFr3uwoBa5uGPL6wCHKVgaS2OYwvSX35Y5kIC05NY/CO/LAs9guoX8wbfSPjuZX5Ej6K6fNLHAbeDA31fxncrjUh412NZ415YztRpHqRngS92Nsl3RMNgLlc00y2yP95XWbjcAtThe6uUkGHZ6iUHfOxcR8nF/cwYVzKigpvqI4aI51KLtqD8NMBGUVeJk0VSslGs0cxJkZjMFOVLRyzr5X94ne3HJHUJklPM2bgRW3X3UXJHn6OCCoUtS91g+OQSuvvAhvZTwKnp8mkVb2I+cZeW28rluAtSwnWYPRwrr6vBYTSiYzpzXyTqIkFKneYJxuiTfuzqljPmJUWBEuFeLzeBQL8FVWqdy7f8Js0nigK4if/LzYu8HN+zWQaEveVt1FP/XLMHHUaNDxz9OcoYJDhRimwPPlZFYCrmm6U9m/ZgWuZBGL9oQh2J52JzrqoxriqDuJD1g39YcaASuxC28NU9VEboHMVmb9U8awHSyPm+XTUFe9gX8YoZ2rzAYkOgnLdp7LgUIrbZmPpp6qRno3Oqcbabh+Ps6eRI8JV3j7r4UiHNbxQbPYBTiS65i0bwLfib0O7XyDKRRpzlPBd5WGLkud19IqO29awYwZEUXtA70EwWsp9ME9OXLSngLYFMYEw1itgi1A8ICIUDSUKvh8CVEwcQFLveCip9PK9v/vDtJrBWUUqrqrPuYcXn2lAo9C3kAm0=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(6916009)(2906002)(47076005)(4326008)(83380400001)(336012)(36860700001)(508600001)(82310400004)(6666004)(19627235002)(40460700001)(36756003)(186003)(26005)(7696005)(1076003)(426003)(54906003)(2616005)(86362001)(356005)(5660300002)(107886003)(70206006)(8936002)(70586007)(81166007)(316002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 08:55:40.0271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de740cb-855e-4dcb-0682-08d9caa8fd3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maher Sanalla <msanalla@nvidia.com>

NDR(106.25 Gbps) support exposed new data rates:
800 Gbps - NDR 8x.
1200 Gbps - NDR 12x.

Utility methods were updated to support the new rates mentioned above:
1) Rate to mult - Convert the IB rate enum to a multiple of 2.5 Gbps.
2) Rate to mbps - Convert IB rate enum to the mbps value.

The NDR support bit from PortInfo.CapabilityMask2 was added to
libibverbs, as well as the new link speeds mentioned above.

In addition, speed_str() of ibv_devinfo was updated to consider the new
NDR rate.

Reference: IB Spec Release 1.5

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 libibverbs/examples/devinfo.c | 1 +
 libibverbs/verbs.c            | 8 ++++++++
 libibverbs/verbs.h            | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/libibverbs/examples/devinfo.c b/libibverbs/examples/devinfo.c
index 5db568b..cef6e2e 100644
--- a/libibverbs/examples/devinfo.c
+++ b/libibverbs/examples/devinfo.c
@@ -147,6 +147,7 @@ static const char *speed_str(uint8_t speed)
 	case 16: return "14.0 Gbps";
 	case 32: return "25.0 Gbps";
 	case 64: return "50.0 Gbps";
+	case 128: return "100.0 Gbps";
 	default: return "invalid speed";
 	}
 }
diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
index ee26b1d..69f82e5 100644
--- a/libibverbs/verbs.c
+++ b/libibverbs/verbs.c
@@ -72,6 +72,8 @@ int __attribute__((const)) ibv_rate_to_mult(enum ibv_rate rate)
 	case IBV_RATE_50_GBPS:  return 20;
 	case IBV_RATE_400_GBPS: return 160;
 	case IBV_RATE_600_GBPS: return 240;
+	case IBV_RATE_800_GBPS: return 320;
+	case IBV_RATE_1200_GBPS: return 480;
 	default:           return -1;
 	}
 }
@@ -92,6 +94,8 @@ enum ibv_rate __attribute__((const)) mult_to_ibv_rate(int mult)
 	case 20: return IBV_RATE_50_GBPS;
 	case 160: return IBV_RATE_400_GBPS;
 	case 240: return IBV_RATE_600_GBPS;
+	case 320: return IBV_RATE_800_GBPS;
+	case 480: return IBV_RATE_1200_GBPS;
 	default: return IBV_RATE_MAX;
 	}
 }
@@ -120,6 +124,8 @@ int  __attribute__((const)) ibv_rate_to_mbps(enum ibv_rate rate)
 	case IBV_RATE_50_GBPS:  return 53125;
 	case IBV_RATE_400_GBPS: return 425000;
 	case IBV_RATE_600_GBPS: return 637500;
+	case IBV_RATE_800_GBPS: return 850000;
+	case IBV_RATE_1200_GBPS: return 1275000;
 	default:               return -1;
 	}
 }
@@ -148,6 +154,8 @@ enum ibv_rate __attribute__((const)) mbps_to_ibv_rate(int mbps)
 	case 53125:  return IBV_RATE_50_GBPS;
 	case 425000: return IBV_RATE_400_GBPS;
 	case 637500: return IBV_RATE_600_GBPS;
+	case 850000: return IBV_RATE_800_GBPS;
+	case 1275000: return IBV_RATE_1200_GBPS;
 	default:     return IBV_RATE_MAX;
 	}
 }
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index 36b4142..6f7910b 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -418,6 +418,7 @@ enum ibv_port_cap_flags2 {
 	IBV_PORT_SWITCH_PORT_STATE_TABLE_SUP	= 1 << 3,
 	IBV_PORT_LINK_WIDTH_2X_SUP		= 1 << 4,
 	IBV_PORT_LINK_SPEED_HDR_SUP		= 1 << 5,
+	IBV_PORT_LINK_SPEED_NDR_SUP		= 1 << 10,
 };
 
 struct ibv_port_attr {
@@ -721,6 +722,8 @@ enum ibv_rate {
 	IBV_RATE_50_GBPS  = 20,
 	IBV_RATE_400_GBPS = 21,
 	IBV_RATE_600_GBPS = 22,
+	IBV_RATE_800_GBPS = 23,
+	IBV_RATE_1200_GBPS = 24,
 };
 
 /**
-- 
1.8.3.1

