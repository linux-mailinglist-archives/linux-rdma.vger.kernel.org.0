Return-Path: <linux-rdma+bounces-12103-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B05CB03612
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 07:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6358217322A
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 05:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB575219A72;
	Mon, 14 Jul 2025 05:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PWKiyzT4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3300121772A;
	Mon, 14 Jul 2025 05:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752471660; cv=fail; b=CF55wioLm8p40OmG2zNdMVAkKrqK2hfwVI+LZwURebY9QFNzP1JWb8J6xopOMOApoHAKsaIxLVwjEaTnhAxkRTplAoas218sThj4vWw2sBIOjTt2EMVZ/mZ++9UgFHo8ijie0YNMDFk3EghUpQ0+ZSXv6v8rKC8gFPGXfuVh3oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752471660; c=relaxed/simple;
	bh=O1w5KrRmEDOj7c6oMi9IgWX7HiC9NXsRT4m1jEM3E4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZ6hk90W8IkJAEKftMZEBpA9sSk8Rs9UsuZV70lKja/iANuVr9aQajfWcHajvb/oAPRG8VGq0tgM3bxP8gO5iy86NEqakD+UzCzf8PAFEghiIc1X+7OygYQPdPojl3M8E4da6o5qAnyuGm018UEGZJuvWcFKh0I65Falm8rvy9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PWKiyzT4; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eb9pIbAQl8aBbLzWM3KD290uEs1QIw37nPSqLHmCzKrT3fbDBaqwKAZaPClQbgJS/3YbLVtf/fPHMp+f79b9BPRzTwE8CR7LLSciji7Jdgt2tpFAZSqGuNcObzBYm5WaUfj33zSYGXcNionR8/9g7GsYmGAhvDfoa+pEYH3fzH+iVqvU7BA/NlNXIDxPtx3l87qzXp4GnAMC/9gUsF18jBJVm0QGXc7ID7weFhBPVk5gJmbWeHfiOpkJr3Kq2BI9J1xHSEUAFZbTP2syHAHGGeVwXqtiPRgbrPtcYt4eg6uAr2eABATIJt51DaL9vcIr0brSPu9WOcNwnAlibcZlag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Q7jpgijUmqA6dVXeirqsOF9Kb/nGT2V4x9EafWyzkY=;
 b=fW6zTh8Qmvn58mksW58uBqWEY7oQmzIAIpFv1yvWomPyXZ5YKT7FlkftGZ079NkR7uykMRe44/h45PhesTtbjnSKUl6gUS198+/dBk0VivBWwDvkULObEUITOCSCrFqs0bby4p3fUeEDmpGLmJtLtSzRml2imV+SAgoszzZmqb4i9rZvLhzlaryXlR0OSJ4dvMl6qXhzE9wLHv+RHddqjCs1IkhqnziMhwr937jTMF0k+VYhNGcieVe8+5LIu/pcg4nc1cFi/2xciOtkcC/PL2tDhtNzUNgcjz+NXC7dR5td4jFkrutSej3S8y6nocRJJ8IALtg1f4AOQIUe7QhoPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Q7jpgijUmqA6dVXeirqsOF9Kb/nGT2V4x9EafWyzkY=;
 b=PWKiyzT4CLjzKpULAfwHU2Pwc4jAZfTVItbS/BThG98lVEmQk35yL0yYYvobJxLvn7SGtZz9fmKAbDZtWwGXiIsdbB4VyRDLM0sZZkbLosoQENgfFzVvHgfDhv9V8JTi+Ep9JHtAgi1TFZHqKhcVY7vx0Y6z83EbasI8yV+MK2/5Z5bNP9Qw1S4ocB6RvlvW/lIJyLeFfj20Y2/PYVZ+EABakRm3BqW/JDYC0Kdxn9dwmnodU/uovFuV/3ItOnBeKkTyUBp4svRsLQNTS4Mxk6ivkmz8e6/7aSwBRRp5v1iR9Oh2/0ELkXffqHyv3L+7XmZRE/ksmSg307GS1FNeQA==
Received: from CH0PR03CA0428.namprd03.prod.outlook.com (2603:10b6:610:10e::23)
 by SN7PR12MB7936.namprd12.prod.outlook.com (2603:10b6:806:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Mon, 14 Jul
 2025 05:40:56 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::a3) by CH0PR03CA0428.outlook.office365.com
 (2603:10b6:610:10e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 05:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 05:40:55 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 13 Jul
 2025 22:40:44 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 13 Jul 2025 22:40:43 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 13 Jul 2025 22:40:40 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>
Subject: [PATCH net-next 2/6] net/mlx5e: fix kdoc warning on eswitch.h
Date: Mon, 14 Jul 2025 08:39:41 +0300
Message-ID: <1752471585-18053-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752471585-18053-1-git-send-email-tariqt@nvidia.com>
References: <1752471585-18053-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|SN7PR12MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: 02551c7e-4342-4899-5b5e-08ddc2990113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uB7VFJ7pvdlhrZJOof6H1KBYGAREgPIV26Dx2761R7ABw9GDVjLXW1a5aM/c?=
 =?us-ascii?Q?VcUsmyM2b5+qJRJoYAjL8WQmUsLLkP1LKP9lrzvQGNb8KwsLyO10f4zBziZu?=
 =?us-ascii?Q?OmFTBNi5JGSv+l3qUU6Uz4KMzyv7O54TEooE0wBOVAtTlLJet7mQyf4mpeH5?=
 =?us-ascii?Q?N7xjeDYLPsIJ1DwmE3PvxfHH7FqBMm8/Tst8WlqXZ9liEUgNUEuqmTSOR4j1?=
 =?us-ascii?Q?XTCZ89n3spThpIEjLH5Z8PePjxNt9+k8AprhG04PZMP5x3Rsgr5jVHnIny3w?=
 =?us-ascii?Q?iKh17RHUpJbYXj34W52ymKcCxA9A1E9GHFaXOjXJMOwqjUBHozg1z+nlTkwf?=
 =?us-ascii?Q?hpYGQgI0YDjp32dm2CdNKxNeuMDyRgCYmJhDD9zLRUO29cjsj5YibeGh/w6l?=
 =?us-ascii?Q?S6xCCOP3VUNLmddSWxmgWLL+K5zM61LpEIDMiXOLYrBXUakcrGuAuIhLhGqG?=
 =?us-ascii?Q?WZNJOTC9rl4S1wKVzO0i2vnJYtUZx2D1fk8tlnzK5No2z6WtVF1CX0F9XBFW?=
 =?us-ascii?Q?acHz1248aYAui43QfPYcaReY0K6qcrY1XM5fNS93SCC7QxdyKRUMfVhwoeAk?=
 =?us-ascii?Q?KZNpGS8cUoXcF3ZttesiKo38EsATgB0P3SuVlHTUc/0p0abJElDPrMD48CVt?=
 =?us-ascii?Q?R6T+HDewwa5lRKR8NcQ/stnZBjzAxNVOpH/qzcHXMONsiuA9616wKXRlugIu?=
 =?us-ascii?Q?hvGvd2YU1bDP0CxfwdnalyMCV/RXzbasOZDQxZCFZK4VmS24ckmFeU223fq5?=
 =?us-ascii?Q?nYKd7huqAAPnMOhARVCjQ8qWP/mwijejbViHtge8btYDrhLDzS8ILLEq00g6?=
 =?us-ascii?Q?lS7gBaFjsWwdWyTJdj5HZoK2CYhf5BlK3Mx3W6oFDUCZ0mx+vKgy5VA05fsx?=
 =?us-ascii?Q?Bu8FTm7blk474voyhmvVnjpTvnao5tLOBMXlPalB0BxJqtcrNVpvC4aOnPBK?=
 =?us-ascii?Q?C741Y5Q7fs5ZG1V5LpSJv24vIEYb8DJ6ccmNDbkwfqeXzfLzIcCeR1X/FbvA?=
 =?us-ascii?Q?E+PdGnuxElmfTDp/OrXid1ljBxTRg6scUVHn6wmnOaG07BLrvSfKzGYFYNwZ?=
 =?us-ascii?Q?dVxI7SNMFxqkGz866B1EdTGWyIv4QU5y+jzh9ToKlz0gS++horskYBxzAW2n?=
 =?us-ascii?Q?RyZusmVldbefZxA0M3k4SUEvn2dR+5eS2CCxpVP+3nu9cxc71jlhuzp0D8fY?=
 =?us-ascii?Q?nUWVEk1A0UXlIPJuSFdTMhpb5aQFC8+SUG4K1wkEoUeMjKuxfIEo6FGOEOan?=
 =?us-ascii?Q?29Zzti9Hnk4aX3zTvgLJ5iw5zzqcd6QTL2msnd7SDw/IeUHC0nsjseRLG2ow?=
 =?us-ascii?Q?VUsX/OKxfv+yvg5mlN4J90Z3sO88eeSXt6/9FCH9yPv0N3wdFaZ4Oe8eBtOo?=
 =?us-ascii?Q?AUflLbnzbrbZzGW6D6MX9f7OUhQ5FICcCTkImSFQiQ+WzFsWviTZjhnknyCm?=
 =?us-ascii?Q?ZCdlAb8VX0F7lZGWjC7iZD0eHX0k/0fP3xdo69e+jeJRD+w9kksOfCxG8DCB?=
 =?us-ascii?Q?SO2HZXuV1YBlCtPoxBqSsLTlbuj8NsQcQa/1?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 05:40:55.8852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02551c7e-4342-4899-5b5e-08ddc2990113
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7936

From: Moshe Shemesh <moshe@nvidia.com>

Fix the following kdoc warning:
git ls-files *.[ch] | egrep drivers/net/ethernet/mellanox/mlx5/core/ |\
xargs scripts/kernel-doc --none
drivers/net/ethernet/mellanox/mlx5/core/eswitch.h:824: warning: cannot
understand function prototype: 'struct mlx5_esw_event_info '

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index d59fdcb29cb8..b0b8ef3ec3c4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -827,7 +827,7 @@ void mlx5_esw_vport_vhca_id_clear(struct mlx5_eswitch *esw, u16 vport_num);
 int mlx5_eswitch_vhca_id_to_vport(struct mlx5_eswitch *esw, u16 vhca_id, u16 *vport_num);
 
 /**
- * mlx5_esw_event_info - Indicates eswitch mode changed/changing.
+ * struct mlx5_esw_event_info - Indicates eswitch mode changed/changing.
  *
  * @new_mode: New mode of eswitch.
  */
-- 
2.40.1


