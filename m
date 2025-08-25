Return-Path: <linux-rdma+bounces-12893-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3118FB3441C
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 16:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22A547AB205
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 14:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE803002B3;
	Mon, 25 Aug 2025 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eI5N5iZ9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088342FE073;
	Mon, 25 Aug 2025 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132520; cv=fail; b=EFzyq59YWp7yBofZAsdZ39ap7EbngPa1Bfi5enHACTPeEMmut07TgPs3gVhTG9hmIaNkKy5SQ5SlC+B3UQfEQ4/HZileFIB0n1DmK+fKgxCFoRVS2pFBZHEk8M3ZHFQd9uNSdUBjGK7W63dWDcwSy9Z8tQA1wMNNkwp8G2lnP1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132520; c=relaxed/simple;
	bh=7ChNzEaQLFlsO2WjEH7AXRUiAJQKNfUgOEYuOX6oBHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5uCeAqpFKz/grSmgmyqlzOk6Hq3orNm87Yp07lwDsr+7X/0pxDYCiZ1QKrC0qpd75XBgO0nA6HS/aJ834ROL5gacPDGCjElM+wp7eDU3y9QJPDwA5VBnoNfrtR7w3FdGg/7o+/UfxT94POc//z1gvOw02rp2rC8/NZlN2//ADs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eI5N5iZ9; arc=fail smtp.client-ip=40.107.101.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhkTYSBwgxukCAH1oqBU1JF0FfaLs9KY8XyQbu41F+PQ3IvQN/fg2bPU1qUhZ0MmWPd8JjjYcdqHIXAOl17jjaBFXdOW+fWB4nBjOq1vS6V0Okw/6jdwHZyGvOXM3IqfAVU4+iciB9zCl3z7cdc8SC/pvkkiM8nWS52Tsx/WloxChlSqWygHxgdqte3DV1MRCHJibTOc2CjorMcUd7GEIzksjIK2lim2doY3OnzoIRmqlMOqemxvPHsxp01RWLObjx7Fa5KhMdAAZaFpPIZP9Gs5UprqLhVX1t6gCxHHMwl5g8cdJ7+YV47U7p6smSNHvym8UJRNSKL7liIeXvdNxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oujauajvAA6RUwv7amXBr2Xi9IDx0ezImXkQ1LIG6yo=;
 b=JarJAj/LaZtIVGBiMiyggS/RT8+bAnbmo9xyUD7FIPNsu3xDI+iuIy220x/IC9hh6krOxZ7qZtjWDorXZTZFVRBiTD05+ygheoNZXrsQ1mpw/fdLvZKINwx/OL54vP8GYdx94xlD5oj25ZgqYppP6R5rxBEE2HKyC1Y2DArrWRMMP/6UWURxQ+qZ/yqkZHWPCPfMnRXuGggQYqDsc8P2cqyYMxrkEdSzsFx/l4ivqCT/TOMNB2srbMCuIL+JRC6g1ZGKsGqjSWmEezKICkzJMT2AF9P+o4mGO0nUMURp/Vj/GkyLMdlv5lK+r2mvHMJSWGzDwDZ3P1R3CPUkXhr08g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oujauajvAA6RUwv7amXBr2Xi9IDx0ezImXkQ1LIG6yo=;
 b=eI5N5iZ9Pnas4cxa0o5YUvtw402fkPur3ERlHRbZW3GmONywR/FOJddq09sH1DY4LYgwPJiM4ttOuVz65zubit6s8fAyswNIjgBz7w2Zh7r5ohAEFuQs+1PIemnC/4pW8BA8uiKbvDj1LmDTC0IhG4VG3LnnxvSErS/5UwlE3keyTZ5guzd3lrBn7bRs/sz2PvteN0P2eEPYo4DeV2Xcmxey60R1dNjt+6uOcdicMwIv/MQLPyAFA4tX3TnGX+Aq2+OHgHFC0wMNyPYzbFcT0ubuV2wq+7xmxNwBrrMxSOblx8aVwk6K1B6GziGvs0Tlq/pMCy9NLkQa+bFvZj5tHw==
Received: from BN9P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::28)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Mon, 25 Aug
 2025 14:35:15 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:408:10a:cafe::5a) by BN9P221CA0005.outlook.office365.com
 (2603:10b6:408:10a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Mon,
 25 Aug 2025 14:35:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 14:35:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 07:35:00 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 25 Aug 2025 07:34:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 25 Aug 2025 07:34:55 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Lama Kayal <lkayal@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>
Subject: [PATCH net V2 03/11] net/mlx5: HWS, Fix uninitialized variables in mlx5hws_pat_calc_nop error flow
Date: Mon, 25 Aug 2025 17:34:26 +0300
Message-ID: <20250825143435.598584-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825143435.598584-1-mbloch@nvidia.com>
References: <20250825143435.598584-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|BY5PR12MB4114:EE_
X-MS-Office365-Filtering-Correlation-Id: 38af0249-8848-4852-57f0-08dde3e49ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FIJ+hul5VOYYUreNLAHbFSkaZ+si7n30OfsLZYsCn+EttKFaCwifYxoUP1ZR?=
 =?us-ascii?Q?+WL/gUZXJiFo4223C5k/Dcu3shvepyx5+b3lxtjYeSK/HBwOXqUYVdNpYTEK?=
 =?us-ascii?Q?09nyfcVkTxl9/OykbAbSJGgiEXmZqvTjinqqFfN6GzC88BO/mWGaL98mo84r?=
 =?us-ascii?Q?EFpM7Qb4cgvpaVzNsoVY2aYONY+XcrnLy8rnoBeRk7KO+d82TQXyefA32FLN?=
 =?us-ascii?Q?+Bxm4LOcM8hCSRBJPInYkExLf9CZj6xwZviG+HD8XB1dZ400pgyvaVmglL3/?=
 =?us-ascii?Q?v8lKKLHIcLQ6UyP/2MC8NVIpzj+vJ0Ct5bg5qqqehD+zYvSNo5BLf113gIAX?=
 =?us-ascii?Q?JZkEkH54ouujqjC0c1DsZmqKGU3Q+iN4xbCfJjObXwUTg6TGPrhBu4jAC7OC?=
 =?us-ascii?Q?Ix49FOd+DeJE+xo7BeK0wgQNM+iZK6dVcRPozFqLZF9fzgtjq8o8qlavqZan?=
 =?us-ascii?Q?YWFlBXdZTTaq+1SsTQhgMb2GpH5KAFgxatySDzqye+aZLzqumADryn81G+V3?=
 =?us-ascii?Q?R+NMCc0aZSTNQp1jKy2a7kX1B2+M3MQ3FuOZUOfvcVPYxtfKWVL+144dMK0S?=
 =?us-ascii?Q?zbytk4ygwjCGA07CD55wQishPwxLTsIPMJm++kUOEBNLHHmP/dsqfZeU4dDP?=
 =?us-ascii?Q?5ZYEpwq8Ksy2omoo03ZUDVURKmRWOO7XivihK5E9r+lecGTq1F7wyDkEho+h?=
 =?us-ascii?Q?hyosh7BGBQQMRZtS5BZxSjMCMvHL/KHq5CzEpRsegJVT1g/i9xqLiLMW+17R?=
 =?us-ascii?Q?QwuLIcOPc6BugVcOyxRReOkN6lmKm4eHOF53zGfqRchMp9MLQqkacyBhgfHn?=
 =?us-ascii?Q?cdZGLKLCvHAoygbHD4KF4/6c5Inab4SCQnnCTUnNZljQP5AWThzW8T/xdK2F?=
 =?us-ascii?Q?LPEKKVe8uwPcj1jTN8fDwruCekGtfPl6VvyboRLWX96pKqPBZBhYrVg8LWWk?=
 =?us-ascii?Q?j0zdOJFUgl21bPqQZ9l+K9fV1vLDO7VxRJgjfPDtQX+vGUW8NFrTCzjNOzYG?=
 =?us-ascii?Q?8DmmMG/0vFnl1JuZFXIQTrWcMgYbgiZ87J5VquEwXp8j1Gi9oeea7NZTVpXo?=
 =?us-ascii?Q?DsuKOR43uJ8HFArQHSfFlCAM1iUU389IrJuqdb1N7eLYrjfKfjiDebRjsIpW?=
 =?us-ascii?Q?3dz96SefjtVE+9n2qYdyY2hEn81wEkVVlcz/1fsZx7twg+Tj3KZw+z1S88Xo?=
 =?us-ascii?Q?PORUFp8i6INO6rXRKYE7irZN8jhBEMKCzoYBSJguy2Gs1uY9Vb2PoeGoUHmh?=
 =?us-ascii?Q?fnNsAFLI4jl0lzRhYzeEbGPrpc8tgAPiVni7S2O+cYy7DCqsQYCZ03T3z0fs?=
 =?us-ascii?Q?5jml/83hDW/ksDPwmyTxXAl0W89rX2nJJufdgGkrJG5wPL0gt8mZkOmBVY3y?=
 =?us-ascii?Q?bmOtE+K51TvWc1xiLaRyaSFKj+XBM1x89ZDlRNxxOmuuSP1dsbxYArj267CA?=
 =?us-ascii?Q?V+zl/1dLiQpS+waseQ2LgTB2z76A1FJ52VkPjvq6aSq0yIpYofSJj0rSFlb1?=
 =?us-ascii?Q?BOsL+7MgRvFyy5stNyhhEDUzYeajuqzrRRYt?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:35:14.5544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38af0249-8848-4852-57f0-08dde3e49ae7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114

From: Lama Kayal <lkayal@nvidia.com>

In mlx5hws_pat_calc_nop(), src_field and dst_field are passed to
hws_action_modify_get_target_fields() which should set their values.
However, if an invalid action type is encountered, these variables
remain uninitialized and are later used to update prev_src_field
and prev_dst_field.

Initialize both variables to INVALID_FIELD to ensure they have
defined values in all code paths.

Fixes: 01e035fd0380 ("net/mlx5: HWS, handle modify header actions dependency")
Signed-off-by: Lama Kayal <lkayal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
index 51e4c551e0ef..622fd579f140 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
@@ -527,7 +527,6 @@ int mlx5hws_pat_calc_nop(__be64 *pattern, size_t num_actions,
 			 u32 *nop_locations, __be64 *new_pat)
 {
 	u16 prev_src_field = INVALID_FIELD, prev_dst_field = INVALID_FIELD;
-	u16 src_field, dst_field;
 	u8 action_type;
 	bool dependent;
 	size_t i, j;
@@ -539,6 +538,9 @@ int mlx5hws_pat_calc_nop(__be64 *pattern, size_t num_actions,
 		return 0;
 
 	for (i = 0, j = 0; i < num_actions; i++, j++) {
+		u16 src_field = INVALID_FIELD;
+		u16 dst_field = INVALID_FIELD;
+
 		if (j >= max_actions)
 			return -EINVAL;
 
-- 
2.34.1


