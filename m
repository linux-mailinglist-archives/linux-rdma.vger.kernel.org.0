Return-Path: <linux-rdma+bounces-8797-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6385AA67E4E
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 21:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A193B73F1
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 20:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B042139D4;
	Tue, 18 Mar 2025 20:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Va5cXs4Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0F22135B2;
	Tue, 18 Mar 2025 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742331139; cv=fail; b=Bro6x7HMizwFx+QRsBbwXKQUsEGXcRiEAGvWoIqrhSfk0tMfe58c5RVVgb6Cw7Vf8DEv1mRf6GKksSseeGwy6sEfngEWgtU9PADc+o5BL5/UToEIL+Q5ULWW2S2rZ+rjiCFJCnYi76ycSaDYS1DORky8wvC8p9ojhvmVhns1VAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742331139; c=relaxed/simple;
	bh=wm5TsKXr5BYM1Fjzgi87+DeNXLrAkucrB3kCI8RJcRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHoP7ubQ2zOJn4RodPPChz1tEX+Sir7/kfg2qnOYL2pTL5XmPDRxN3G6xawWOouL1T4EMaZG+igLxj50jrgdYYdddanrDWuQDe6Akj3YSM/oMCpMPcEuFIg9N1ATTHhCHk0UtppLV+7Or6xt8FDBVx2OzxKAxqy9j/LMP/d8f+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Va5cXs4Z; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxjmvZTqcvxFVMdGG0RGqfBouUYn0kHrqYQAhSHG5Nc+naUSUPrk/BwZqhixqqZG3CX3vU6TABPxgfsAxKG/vY5S17GVWG0wCVTL11kjNxPqLh1Xhx5gLQjrTXxxx7pJTPeEmadQ/5Li1/aZBOFcytNziLMI8InrRL0l5Gbyn4ow56C9o/wPz7jufXsZQmRO6BfGAJvNJwpgOgMq+ZWumw2NZPWkhOg8u2QWUFBl0TmjUY95c4b3vjwevldzhkGkiDQ9313C5eVGeM7png7Ip8hDFgb+YFKl2JmY4gc4kOgxy1+pXXK5czH6zGUjoPMYg6t5HFJ8ezz0WbJCsGn5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TZ3HreL6IDBrGpWZFZtwEj1JDNg7Jab6Q0qcLQdk1c=;
 b=CcoygCVaBlYaf0oitf3YOEujtscJ5toTWBpvubdpJV9gKGaxsBcodcKugOf4NEWG4987GZdwoRRni3K9Evlrdrg2MfGEVmjh0ancChZqmUSUrW7PEXlAPRoDzyC54vHfYskNqnDp6En2U0oNIJzfplwrjUc6jqRUlnx1P2vWDjtVmNbav7dM+HNpkBiTOaar4wazcdXRz+ZYOnzdYk219c7t68g+FkPEr3RzgzWfI1Pw+CfIkddzWzOvv9uDb4eo7LQctSoQKEetmKn1AfjTNJXcQNSO0NDywk/WrKCLzi3c6H5yyF1cW+X7QsMYvSN0518ydw9ub4giJjhmWoDE2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TZ3HreL6IDBrGpWZFZtwEj1JDNg7Jab6Q0qcLQdk1c=;
 b=Va5cXs4ZvW5kADmBC9qlLORBFAa+Yhsxkmq92bS0I6r9BS32TFIBlI6AUI6LOm6rqaEjOunkVkojwH3iBJIRE1qRDW2YX+0oKeIowcaUXI72+tr0v5mNzK9i4ThKSvJg7RKkyK+C9gi4jOtrk+tOuy3JxpP4jrp+Ds80vuh6fm0BGiZu6GD8GFapUB+PCTsZkIGFZBLxkLmXCaf7FKbvpMrctEeTBaXBml5Wc++RybTXY+Sg8Ea2KuFRvaL8Iw1beNTEfWB3bChfOiDwk+zrzXF//jxL+UUvpEO+nQU4jS7bvNU1weLCzMsMhX4ZnTjdB4XvrJYvSSfqJnjF/p656Q==
Received: from CY8PR10CA0015.namprd10.prod.outlook.com (2603:10b6:930:4f::13)
 by DS0PR12MB9324.namprd12.prod.outlook.com (2603:10b6:8:1b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 20:52:12 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:4f:cafe::a7) by CY8PR10CA0015.outlook.office365.com
 (2603:10b6:930:4f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 18 Mar 2025 20:52:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 20:52:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 13:51:59 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 13:51:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 18
 Mar 2025 13:51:55 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net 1/2] net/mlx5: LAG, reload representors on LAG creation failure
Date: Tue, 18 Mar 2025 22:51:16 +0200
Message-ID: <1742331077-102038-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1742331077-102038-1-git-send-email-tariqt@nvidia.com>
References: <1742331077-102038-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DS0PR12MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c3e994-c9cd-4d30-aa72-08dd665ec21b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o4+byGOWIy9XOHl0rwK/9g5Z0m1mBSVe5TQ+xdwHaPo4UFOEwnumytr77Hzl?=
 =?us-ascii?Q?/P2AF2HTZJsK9a5nfgXpywi8SbluXHij6XCMZyZsaAbVuO/tywR95DdM3MLe?=
 =?us-ascii?Q?CYAp9cwlxiWQqxLDuCUgnDLAoxMa0NYfahSdh5Jv6nw5nwE5wWLUfaftu00G?=
 =?us-ascii?Q?gQanIsXSxJPBwIU9BYqv0BZPb/GN48XaHPEDH9KqZ8RP/yMpBgBDvp/iRc97?=
 =?us-ascii?Q?aLO5eOVE5UR7pGQz4IK0+QWV9xBc8MIj89n69WKLb57c5TzxNLW1doLL/eLi?=
 =?us-ascii?Q?BhhSkpRQU3LhvBaZF+b5QW0vGUhS2tboTEsS3fsVsmKEBuFnoT+brR9au3vJ?=
 =?us-ascii?Q?UiG8e0pIX7Lazm6kqZ2rU6Bet8KzHTX45tru8x3k8J+9ZWjqlcUSelTLMYox?=
 =?us-ascii?Q?cu+/jNlD7XsUahVaNU+QzDxrrTTH3Q3MVuHbYFhOUrabf2Hg8i0QA4KqSsRe?=
 =?us-ascii?Q?cUFRsjfQa1gSdom+HZqZBwFYmcM0FsrlDCkxWD/4VAO3X4A1BdK220+y8+GQ?=
 =?us-ascii?Q?elc+3Z+58kzk9oFKsoxuui25yral2jlgfquI36rKP61/ulCOXjZDMprPpL0c?=
 =?us-ascii?Q?1vMBy20r76lOvHa88LW+QmQ0kmjhpG941TiLy1VpLw0ZFIyS/0VOEKwkXMzi?=
 =?us-ascii?Q?OoLjgdYfCubkGAEE8NmzxRbPIJMecME9wgIqP0/YjfHmqy6ElKAdXOwcdjNK?=
 =?us-ascii?Q?MFxucQTSrSh0zoA1sX2dw9+cvNV21f+zfubIiYNxZiH5RavffRJ3f882BseN?=
 =?us-ascii?Q?V06h5YVXbBP66ZY8DQ5/pEPrTip41pyG1kODg8vp03dtNrwkbfbUcX2g1p/+?=
 =?us-ascii?Q?qA6ITX5/7nG/Q4IuHTJ6XsPvX+EYwJSEQH8EtsAaXbxSrRPf5OBgCn3bIbgs?=
 =?us-ascii?Q?NNezj4lx8wImqomJC9RTW1X0h1wWxWlpIjwUhtXPZYO18DN2XFFIdsuN5/3x?=
 =?us-ascii?Q?tPXwC9vP/bRkMXHLYPRZ+aH1krtq1gehoHRghbtbdzIiUjwGvicL3qlwTMHD?=
 =?us-ascii?Q?4bbARZdewgTkZkTTme+I6VR/J1H0PS8IeVGXU+8KLkVY1RW6Azf7JwViCQlM?=
 =?us-ascii?Q?ZbPDmy5lF6FNbAMMNzHHxuGhb0hUSXoCDA56gZ1SIktUhaLVoKwo6ax8TVRW?=
 =?us-ascii?Q?SNDuUZPOrdlVfTzdkS0OGx6RWUAUWasB5ci38tpgSogKRR1i6XV5dsz0Rbgb?=
 =?us-ascii?Q?jDPZ4BlsT2iN2DxXWmDW7SZVOlyIjSY1w6ZssLQDf/8WKQr94xwb9KpLynao?=
 =?us-ascii?Q?bx6RK+J+NtgYxof3tp1IUy8NxIlEK1L961A95oJ8y/QBGllDzsDvCPO4l583?=
 =?us-ascii?Q?34D7NZg/OcWivaL9lpP2GOobSMsER+8xnopDCQTekids6bQ9GVC7YlKBkxKX?=
 =?us-ascii?Q?XCCK7Il9WcPEChGM8nSinU3ZN6KgG3l+cyNF2c2Ig341LUmsXLRkggxiRMt2?=
 =?us-ascii?Q?BlSdWGGBaxJjc+P/odYAh+CWaKyLxrEXWIYCjENXsTMoD5wSuEE+fYeEIBNy?=
 =?us-ascii?Q?p6iuupYHf8I3k4M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 20:52:12.4624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c3e994-c9cd-4d30-aa72-08dd665ec21b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9324

From: Mark Bloch <mbloch@nvidia.com>

When LAG creation fails, the driver reloads the RDMA devices. If RDMA
representors are present, they should also be reloaded. This step was
missed in the cited commit.

Fixes: 598fe77df855 ("net/mlx5: Lag, Create shared FDB when in switchdev mode")
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index ed2ba272946b..6c9737c53734 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1052,6 +1052,10 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 		if (err) {
 			if (shared_fdb || roce_lag)
 				mlx5_lag_add_devices(ldev);
+			if (shared_fdb) {
+				mlx5_ldev_for_each(i, 0, ldev)
+					mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
+			}
 
 			return;
 		} else if (roce_lag) {
-- 
2.31.1


