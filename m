Return-Path: <linux-rdma+bounces-8796-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE48A67E49
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 21:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7DE3B84AC
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 20:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836FC212D62;
	Tue, 18 Mar 2025 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kr+U19/e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA54E20468F;
	Tue, 18 Mar 2025 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742331137; cv=fail; b=jSA49mfRTscdypjzd4Vd6hKRftOsiWrvJKF/0Wa+yAaamkCzCp3YbHEmhAENIjLPSVJ64XUUDlp6/6wPE6D/qgPYs5ye/TG+11LMJ8i1Z25cQO2Eh5n282lLfUizd4zopFMDeRJ1V3jEsHOFUaFtuWlHNKxNejf2AMTEwYN2bU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742331137; c=relaxed/simple;
	bh=0QZuZcSSojIuQLGHJ0h9k3YBA5ogEyfpKnERXmhq/KE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jXIskdTaNz+8newPYzRIPvwnvnRYQAcFB898Oe5YI+bJ1YTTzIQRjasdEiDfKJzOBsq45JIWNvJbcGI2G1NUqLdrn925Ypl7tZEZ0otpWWsFOWqX6K+Vk9lcvi1kucv3PTeF8rH9/cRYGNoYvFIGOh15iQSC+Qk8HQqiemFLB1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kr+U19/e; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ww1cfkt2N3z0StB5lC3UPDEP4zjeEwgpCmBhVBcwRdcDUUC5OC3ZK9Map/E9eBesi0TybRSAwnMIXVXUbqFMct6JcnKrWtbIwMZwZN5UGqEWAZiwJm3wcOIHtvFvMPq3Qgda+WqsILOfDH7GdVg17jg9x9DxQXoFJcxVnEbfaWulf3tO/KKEo4nDMT5DKHi3W3klil8S4+JXJiF8qRjbtzdKAuXlGbJkWbZjQetvViubyBcM/BtIvkyRr1WFToJfPTJ2K9QfvVj80RUJz0LjsSkKQjfG8DXP8Enftcz/Iv3jJR28rccwp8GzBsU9mBiXboFROAUPDSj3uKNc4sYTng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPm+vQcLrl9aWzSDlw2Uj2HM5oSC+vGEDG7Cl2VfTec=;
 b=IHm+e21WBXWmZJj+ilisPZX0rar0DC5B5IJ27bexMVjZ3TvAbxvHvOZhJ2CbF46xu3c5LSXGUZ/UYZkP/qpcYldtPMlxUIkiXFSvFfpxy2gdjhws6IADcjo/0q0AAty/isGDqeH1v2dVmUiAp1vxGryUTwcH/wmvzoqeB/R9P9TPOaiHMklfy5SmceJKW9NZwagitTr6egcHRM7w7X8rwAgyMVQA9UqBHKo/PiLnmMRn+5RJOkX8naxv7O9Pc6iJYpGMLgR8riPPwESrEjkArbjeoqwqSq+ry6rwUgw1mZRjSPVD0ENLfjbrEn3//n0mAFkseC1u6b+EfJWCLB+7Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPm+vQcLrl9aWzSDlw2Uj2HM5oSC+vGEDG7Cl2VfTec=;
 b=Kr+U19/en2i6KkfnCfNA3pXllTnlznBlgh6WvCMO9C/CaHNVlqpjcTjdOWwap4wzVznVtaIgv+GxydWP8mtEesYKiXerAY3Y9m57H2ukZf7b3EMjWAD5RrxAoe+8ublfolGRINALLtFrokHU3lfIq9s8BACmn6BtMQKvJoad6/B2gzJSap632Tngxc2xabyNWZVxEWDABTe1ZoGWVFG69cg6ULjkErMcnblOHocKsmIkffXDt0gbYzRJ6+wC83TWFzaRaJN0PzJj7AZeriXGIm+snFSNaDoEHt9Fzmmc+NAlBMnnBXeRg2KEj2rW4hxHpnQllK99/mCkfwO8plHodA==
Received: from CY8PR10CA0018.namprd10.prod.outlook.com (2603:10b6:930:4f::26)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 20:52:11 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:4f:cafe::a) by CY8PR10CA0018.outlook.office365.com
 (2603:10b6:930:4f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.32 via Frontend Transport; Tue,
 18 Mar 2025 20:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 20:52:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 13:51:55 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 13:51:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 18
 Mar 2025 13:51:51 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net 0/2] mlx5 misc fixes 2025-03-18
Date: Tue, 18 Mar 2025 22:51:15 +0200
Message-ID: <1742331077-102038-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 945f3fe7-d683-464e-cbba-08dd665ec0f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pjSyBnvyNjx5vGXSPFelq+pRAcg8KD4QHv/UY+FmhHbZvR0DNmtfpfnzgbLe?=
 =?us-ascii?Q?6FAAKbMS5x9maRegiqHdg54Y6YxfIpvnYVoW0agGa3NCAw2IVanZmV8mQ/xv?=
 =?us-ascii?Q?jPTi/PxrZi7DeHNlhO7q3J/v3/v85Gm/CevnBMtLEF5yYZ1BlG6F9DmwF4QG?=
 =?us-ascii?Q?J8jDQBWqAse+qhxwDysrcLcDeRh4fUrX6bvs483wskSx/v5ubVqcdGYIktev?=
 =?us-ascii?Q?FVeDsWrStyzjcxwAdiHh/lMx6mmjsWB6QXgm5ZqumrJvlrCPNppGhySdsPsp?=
 =?us-ascii?Q?AiIYtE9dhtM1YCQ3909OtZZicBZ9kxki7h+ELqj/UOIR2pG0UkWYKCy9MaLF?=
 =?us-ascii?Q?PiGgZNZ61dHfg3NYSfrt2c9lcOPCpn6OwdpnvyEFrcP2p2/Pt/v7ZLSRjx8u?=
 =?us-ascii?Q?gVz1wx8n2X0o8Ohp+WdQFong1/rd6U9iRBXzMMUKUljO7fUXgNHIwm1/6WDo?=
 =?us-ascii?Q?F0ZCY6Dw5r9gpsehn7IXlukmBayg6WeVA6ySfViVeTogbgyXe+3zUMyv/OCs?=
 =?us-ascii?Q?WCILMkBT3x8Fk3AwzknDBoCj15njBYxKIiHG6CzzYtnrIoBTD53CvqEA/EJe?=
 =?us-ascii?Q?/oPsa/T1A6skEpcL9x75bCVaC5N663pyqu1mZAxY5WcxCsxwzgz15Pqgts79?=
 =?us-ascii?Q?CF5pNSwi+kSzC6tP/sx1z3JJWdy/yWQLfyfi6xGY4Ba+dKR514QZ9QNSVosG?=
 =?us-ascii?Q?ZGfxgYERwZfNONhz5SjkxyUXGweRW9qfQcWbh/vnJMsEWEGhnfF4rQEByOZw?=
 =?us-ascii?Q?FI3nnABJLDENEbcYuWU0EbpCkgKpteCq9b7gIE44+1MWW4ESi8GnqzCOhKl5?=
 =?us-ascii?Q?Cr+De7tMBtYHSxQF92MfY7+xLx82YE9/GRNuHNkXWhzitTO2OAtBRQuzotxZ?=
 =?us-ascii?Q?UTEvoTHBtG85+O0+jzSCRX0B3GMMT40BHWgd6wo8v31QQZQw3qQgpANivRCT?=
 =?us-ascii?Q?l05O3Sk4D0Zm3mEzYgsZi8Vt7wZ7AJW5e3klWTJeAVKK9mVNmKSuQu/IbYnx?=
 =?us-ascii?Q?cnPaxtrufP1i/pVngpSTMFLA6DsK3icH+pFn3OA7nCIOpyf1XW03IqI5L1wx?=
 =?us-ascii?Q?GLZzOG9Fvjc7ia7C1f0T0Hy5uepPfEZ2EoH+urPhm+XBESsmZEEyrB8FrL+r?=
 =?us-ascii?Q?JNY5uQa51Pu1j7ls1rUW+W2BWZshtTH76LqNqAOmdDpzXlnUxrSh6TIG/XJr?=
 =?us-ascii?Q?wpRfHI8TaOfDQiGNHjc8J6L5gOVqWoIBz9eYCAfCNx5qecAZnBCiD6GFtQWq?=
 =?us-ascii?Q?pOTSmKu63US8TRpYuLObMy1pXrb2VKoyfLhztCaZXE0djAh0JFH4FG5aLj8m?=
 =?us-ascii?Q?B3rHT5SLVqwC42E4rC1Fx2z/HB4fQHE61JZQHQ7jU4dDfB7dHmuVv4N+Hydp?=
 =?us-ascii?Q?cEXgJCgFSiK2OGI/At/3M1SHiH6G+bWkYG++vUvXPzuc5hIxyWzre0WWBwL3?=
 =?us-ascii?Q?6LakG8skj9czyd9jDu0qYyB+H8l6Bs0dNe/xRbnevl+QptP8SEfwFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 20:52:10.5561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 945f3fe7-d683-464e-cbba-08dd665ec0f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765

Hi,

This small patchset provides misc bug fixes to the mlx5 core driver.

Thanks,
Tariq.


Mark Bloch (1):
  net/mlx5: LAG, reload representors on LAG creation failure

Moshe Shemesh (1):
  net/mlx5: Start health poll after enable hca

 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c |  4 ++++
 drivers/net/ethernet/mellanox/mlx5/core/main.c    | 15 +++++++--------
 2 files changed, 11 insertions(+), 8 deletions(-)


base-commit: daa624d3c2ddffdcbad140a9625a4064371db44f
-- 
2.31.1


