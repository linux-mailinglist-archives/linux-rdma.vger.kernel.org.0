Return-Path: <linux-rdma+bounces-11156-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B8CAD3CA0
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 17:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DDF1BA1B2A
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 15:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4852E242D61;
	Tue, 10 Jun 2025 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PALjwp57"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A23824291B;
	Tue, 10 Jun 2025 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568591; cv=fail; b=CSzmH9eP8e4u7Km90kJp3wMEjV/n7pLfIaYn1YRSVNNWo/MZdAowqyuFx/TVELsdbd073FxY9jWodVmvfnXkveL9oObgcx5Dd7f7NVsSlXZ0UdV+iiFvuO8RIkJ6R2phmj9u2IzwbMqwtXjaVQHJ0+ubAg2IW1ebrUw1Tlz5t50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568591; c=relaxed/simple;
	bh=OnJxPqoS73NLijJX9il3sKquXBepASg0F1XuW+DRT5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PeGc04p8GsJzYfI9gGGHRjYZbHX4HE4DqrWHZ04JuJNSQicWJ0WL+yu8pu+vRskX4GnM4gQ3t5ij/OjEFSeFsYb8U4XqyZ6ss7f+TwuKP64OzSX+eCAjcMKn/++3IygIVlple8kwFnQy8Vp70XTOYmZp0xq5SaeijkAIO9irOLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PALjwp57; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFLlr0tC0QlA9zDA4D6f/CiNm7uWdMw0hrdJFSJKDL67aKFrxZmze5aCiFk7ChMgohUviQDrfzbFX0rwWWuAbfu8kG8m7rAlgDSTCjZceyOh1KWht0krJ4KuD4+9iG1mImz2wEOt+lPtecqqDByVz62OP5qm68EKLOisna/Q5vpynPu97E5UaLx5PA/aeHtY0kI4C/cy0cvnOVAoiy2O/+cSaUnB3kcBdW888BTCne5cXirhmo/lhTE5QLvW9mPn5G7Nc+tAUE6alFh3a8p0fLqIGZpfYkj2Itq1IZBUGyK0hmgM05uIT/9GgB6Sxr50hc+niu0NsO/8DYj2BdasZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dpa5FCmU6oKye7T2GJ8EViwW1vRPfM3b9fLkQbwqdQs=;
 b=AsJ5mFdGaclDYxGhBQXIMgHegAg1ZL1Iie6Xe+FLrMmjkNNeF6TulacsQ51gRpxqToSpKUmHpDJ4YjMEOHqVOY0Ms97JNUkhgKNA3u3fzAyzU07kabrrCnOxo+OKG3LskS1uAcoo2Ok19GD80s74QLBA+UoVPxiA3BkgAkRnCvVbuGizQE4B/NnEEnZq7EQkDGyDioFLPs1KTnfu9faiXkZ6wksBs8T2IC5WxZLyx0HdoosHf/dvax9xkuIrTOR0lZECcp9XotKbPS8rAkOo2dhVyIzQ6EmQcca/Ktvk7mlNB/GwMV+mSZJQrhs9dLAdPLpXv6fMChk63cdULaJ3Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dpa5FCmU6oKye7T2GJ8EViwW1vRPfM3b9fLkQbwqdQs=;
 b=PALjwp57psccqnn1S2S2r4VcS35Gs/CwiTRfYNyFj47qIhOaNZwhWjNMh5y0tHjUsObp8yItrPbDEJb0IucBvwopsTXbQJ5g52bwaawlntxPIaqObp00hnRD6/hOfqi2E0B0Bsz99915PfKCX4pf+LA4/idiGVucMkAd5E5aKq1Qt4d4IiHyHIIc2QHGQKWurqQ3l21rCaGF0iXQwefzZhNUsPTDHLT3XW2M8gfDQr9WefiQxG+03IF8cDxqk3Lav0IvEjnsY1BTdz7baNRbYzvl2B9seMOO0yffc2Q/6duSJqAaVZwduTlNxXIvlcQFOgpIK2UxljA6feoGcy1xWQ==
Received: from BYAPR07CA0021.namprd07.prod.outlook.com (2603:10b6:a02:bc::34)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.42; Tue, 10 Jun
 2025 15:16:26 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::86) by BYAPR07CA0021.outlook.office365.com
 (2603:10b6:a02:bc::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.22 via Frontend Transport; Tue,
 10 Jun 2025 15:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:16:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:15:55 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:15:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 10
 Jun 2025 08:15:51 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yevgeny Kliteynik <kliteyn@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>
Subject: [PATCH net 5/9] net/mlx5: HWS, fix missing ip_version handling in definer
Date: Tue, 10 Jun 2025 18:15:10 +0300
Message-ID: <20250610151514.1094735-6-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610151514.1094735-1-mbloch@nvidia.com>
References: <20250610151514.1094735-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 47768931-6bea-4c9c-fb3e-08dda831c06b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iysY89eMpAcffzUWHfWFvNjlF5wRI3v/HvQhQKUgFEy97d5eJa4oGEt3IpKL?=
 =?us-ascii?Q?r7b1QqPvKVBzCbEikE/rRczwEAvEX/6QpdRurN4n2T2KuotU/WAjw4RX8x5s?=
 =?us-ascii?Q?9DuwfUGMpI0CnPYHgERaf8g5M5ZE0rFTlyFHyfcYYW7H3mnAn5FxxSdYmIrx?=
 =?us-ascii?Q?+aX+x3jL+34otrYEaFympLUMJ6ThWZAwgf+hkB+PTWvZvyDo1c9uzUkqmwkk?=
 =?us-ascii?Q?Q9eC8XnBCFXqKv1jENwhHUy8Vta/EhSl136mDwxjnr+Yh+215l6gb0dJGVqh?=
 =?us-ascii?Q?EHa9x03Ij7ZKIJ53+xnDoU01j79vefYACNv8PT22RPX2dv+Jypfeczeua5qD?=
 =?us-ascii?Q?CkQj4DGr0zSmSO5RI8JKREtHqvwDZzjfoMepda7HhLIYW5/1EjtgPYU2yYny?=
 =?us-ascii?Q?ApIQCId+a5ZttSKloJrI3nHkb0zSMTrN8H68EL1VYEih/cz3Y9XByH9guzUr?=
 =?us-ascii?Q?J62g2kbeb7pkPh6qSdInig76tJvvTb1j8EZWzJHAf1vcIXM5umz+frUxITSN?=
 =?us-ascii?Q?Ti/dP/07gqgukKZcH98DznA+R+CoRRUUBjipgS4u2eSv25vc1dp+a7V+kFr2?=
 =?us-ascii?Q?sh81M5cpT6zd/ePiB+yiTh0Vj+mCB7ICOPLoQ7KucGqpT7iT36AmWOfmkV1E?=
 =?us-ascii?Q?TUXDGXShiiJqAAjSIkT/MppqQoNwWdKnsn4fQ/LYA1eCWNCGnkXi4+VDLRcW?=
 =?us-ascii?Q?3OJz84iVqJdIIvAW9c/rWIL+XSh0R2eKXKHTMT8VktOtCTWK9o5rXTXmcLry?=
 =?us-ascii?Q?eUCvSe7H6jvmjl0FiRZzDHkUepkiUHmvjtDSYakEFK+4K3LxxchFuq1gykK2?=
 =?us-ascii?Q?3hJYvwpCpLLyt42qN+3TTj3lRhf3tyul/Hw+B9cLR5gTYgxj1an0SNcq6hWt?=
 =?us-ascii?Q?FFVeWTeCZ92/BHiHNj2BodtlPWnKspg2c6Rc1yHaRhSca5dAlNw8Ee/nSW9B?=
 =?us-ascii?Q?ZjMXgf2sXjEYGfzhkf6Vj/hKfHIdoI1bXMMk7cIqop/rg05PQMg/lKILPP8/?=
 =?us-ascii?Q?ITLv5LlqiOPBzQl3IRUGm3USCqksiHe5D2VxvEw8/OrCpXpJfTmwLmqpXEUC?=
 =?us-ascii?Q?XncwWuGTbRYDnnH4Oo9z/TOZhG0QFhVy4yUfoYP+BX8lWEsASIblnyh9bRBU?=
 =?us-ascii?Q?T/4TOb9qjcMQfEHClQ/OONr5/7x1CnDFtryf14Df5as5QxA4zvosOycSkwKk?=
 =?us-ascii?Q?C6yIXkCGLNF1+iuY5IhixG2DI0Kq2dWTpobfvhU/KCdq+3vyKJq1t6VH0Ygh?=
 =?us-ascii?Q?HbsWX8SEap0FN8tqOzLySdNKOXBxSPRO1lDZ7JCQFMlavDn20fzQ1Otq5Usq?=
 =?us-ascii?Q?Cq298kSA7wRoPqXIAfrQGp9aWh8lSPmyMFM4CGoJVcwOBc5G+f0O3FwsUqon?=
 =?us-ascii?Q?/L4eZNY5ati4D74vq1gHPks1SPrPXd9p36qzRszRIjwupG3eZ9Tq9QMHSe/p?=
 =?us-ascii?Q?Pf+LQTfNtpzpNY8LiubpyBUrwDs+OXSnYPn1smyz3t2BLbydFld47DwOYM0d?=
 =?us-ascii?Q?wk/S2Wo7l6kSGdOiLkCfDQWGZLX+EBUws5g5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:16:19.0148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47768931-6bea-4c9c-fb3e-08dda831c06b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Fix missing field handling in definer - outer IP version.

Fixes: 74a778b4a63f ("net/mlx5: HWS, added definers handling")
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
index 5cc0dc002ac1..d45e1145d197 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
@@ -785,6 +785,9 @@ hws_definer_conv_outer(struct mlx5hws_definer_conv_data *cd,
 	HWS_SET_HDR(fc, match_param, IP_PROTOCOL_O,
 		    outer_headers.ip_protocol,
 		    eth_l3_outer.protocol_next_header);
+	HWS_SET_HDR(fc, match_param, IP_VERSION_O,
+		    outer_headers.ip_version,
+		    eth_l3_outer.ip_version);
 	HWS_SET_HDR(fc, match_param, IP_TTL_O,
 		    outer_headers.ttl_hoplimit,
 		    eth_l3_outer.time_to_live_hop_limit);
-- 
2.34.1


