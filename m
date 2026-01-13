Return-Path: <linux-rdma+bounces-15505-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46269D191AD
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 14:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0401D3011767
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 13:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F35277016;
	Tue, 13 Jan 2026 13:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kZXSl4WO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A09262BD;
	Tue, 13 Jan 2026 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768311121; cv=fail; b=An+siNIfwxO5scqPrBVHFnZSdAy5HM3OEpMIO0iQnxTf+Cb79h43qvhWNz4JtKu8Uk8uvdj7NrCxEpS81mKvLprA8ChsQLKRcwLVSuMyeJR2c3S7t1RAdLuXyz++K+yFXn5LdxL02fbpICo4GO5+EZtV5Fk9zQPhbzDjnXPsjhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768311121; c=relaxed/simple;
	bh=sV8tF3b9Gje+UuNLeVGPeU8CCXdHHRVktngEVciJPgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=I3iFmFbp4RzQkMKWCCkXv5yW4eTrdVnj6d1rRDciF2X94N5KZZjKEmXBZ0R6txMgvgB5zTJ/0nlg71VymRsCuOWpWwpUg+ecAO0sXLk4r1LV+5dRyh7XAC35iUKs+whJKXoCEEbazs2FtAIYQqb/QCCkfS/bnb1fkbjJ5AOFbQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kZXSl4WO; arc=fail smtp.client-ip=52.101.62.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4T8BxjNqRITWgpSQiXg4HkWFxvTmfCOFCpJRFUEubVuU/zEEKT4jW04ZhtC93ecgLzVPMovC/ap/aZjGWB2Jiti2HoHMGWKOLobp7Bk4lWf6UgVR1eBvmTniQEXA3xPnChJddNKgrimHg4HCF5cHZnw9wpzcyegZDrctRFI9VHRjw87YpZAThkmRn0gdoYbTYby0DrUgNvhE71aMwsFZivvM/LUT5A9g8mGXbOwvaaUehC3C1yBJiMSc4JbAkAI4ng/BciNFkIN+XrIR8dfi8EY55yFA2qL4FNwy39yRRPpak1+5jE6EfD5e0vbpINd76t+Wkp4D+oLRAUo8xW6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcHHQh53uEH1eFswkvB2ynD9LruX7FXkyZzwf96eOXs=;
 b=WA7SJNzSsUCscK5DpaZE2Yk/WmAEKMItnfj4C3NxZ35tEVBGCkCEtY7gK4lLfL6QHE9MwMFBL08T1rrMcdmJwh5c7fmfRWC4iEXp3PKZNHwkUdFgYdq0bPRT2r9u46KzWn8OYokZRMm5QoRGeLIYOQ+Z0Izhh2xSI9dcn7qs/8JrTksIVOttukJxt9sFyNO37gZCgtxzUw5dvVNyrzqR8SnRyJQjTw84sbQooc/Aol5dXGRL2shaO+06ukiMjFtXDWJN0Nle/ZNJ/7574Eu8m2Dmq1asR8vPWwZdA4WV3f1ZzqxfGXFs6q4HtaCb/dXIrFMcoXoDTeaimeMEX4o43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcHHQh53uEH1eFswkvB2ynD9LruX7FXkyZzwf96eOXs=;
 b=kZXSl4WOlAbgmnr0wQeObOBRHEEnLoUipr3KUzGZ+cDa8cokO2RaM0uHsMnASlYN/Egap3xsEovYiaP4uhXDINTvhyHUSqShZ32DhaeN5MjIymER8KyitJZijKHbhwgFUqsxmpUKOW7PxZ94Riz2nda/hqwOs4Au97AVyxFg+W1aq9YpcctSTimpCIquDUOPG9weeWbCGcagDjZyRKzi5hz1MEj8U9x8v4jdl/HuN1dDn0+jchWkwqEDPhHfaluBhx2iPtxp5h7jh6TUXqmtIPtLFJHdy7/Mg2G133LFtKWDXzla0ZCvTvlyuacq1qVlGDNyWvG5yZUWr9NDc79MHg==
Received: from BY3PR05CA0009.namprd05.prod.outlook.com (2603:10b6:a03:254::14)
 by MW4PR12MB6899.namprd12.prod.outlook.com (2603:10b6:303:208::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 13:31:55 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::8f) by BY3PR05CA0009.outlook.office365.com
 (2603:10b6:a03:254::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Tue,
 13 Jan 2026 13:31:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 13:31:55 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 05:31:39 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 05:31:39 -0800
Received: from c-237-150-60-063.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 13 Jan 2026 05:31:36 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Tue, 13 Jan 2026 15:31:26 +0200
Subject: [PATCH rdma-next] IB/mlx5: Fix port speed query for representors
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260113-port-speed-query-fix-v1-1-234cacc991fa@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAC1JZmkC/x2MzQqDMBAGX0X27IKJP9C+SvEQm0+7h8Z0o6KI7
 97gcQZmTkpQQaJncZJikyRzyGDKgt4fFyaw+MxkK9tVxtQcZ104RcDzb4UePMrO7cNidHZoUHe
 U06jI+t6+SP3XccC+UH9df0TO3xBxAAAA
X-Change-ID: 20260113-port-speed-query-fix-592efa2b4e36
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Mark
 Bloch" <mbloch@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Roi Dayan
	<roid@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Or Har-Toov
	<ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768311096; l=2033;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=4UGp6j4Q4BZneI6CtFSMoEUrPqXq3riQpAxT3dDtBw8=;
 b=QodsMibG4/b/c+T+wjbrf+IvGCoi3dnBe6hMU9q0o+Hej5+7G6wy3kkSYJ7OZKo0uZ5/4eOwU
 IdfFoGn0TZFCErhN4/HUAx9KfmoRgMTYbqmjMDKzkWC6lVwsNg+1aWC
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|MW4PR12MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef7430c-dd3a-4a07-0078-08de52a81e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VC9jbGRVcHlhSjRhMVp2cTBWWDI2N0kwRytXWWlIQmVHdDlVUHdPZ1I3NElj?=
 =?utf-8?B?eHI5b2RVTGJrQ24vSjJXeFVDYWtzZ050ZmlTU25rRTdIMDNkc3hKcEcwaGJ1?=
 =?utf-8?B?TGZMTm5VZ1o5dUlxTVlGT2w2NXJGMElVa1BXR0U2d1M5MU1MaHZ4dUlKa3Vw?=
 =?utf-8?B?VlEzeUhrU25pelp1Z2VEcUhEeStiSmJjdlo5WjAvZ0k5dURhZENmSE16YUYv?=
 =?utf-8?B?YnNZVHFFVlNkYWFzQ3l1Q2drUDQ1ZnJuYTBQKzNoQTdyaktwNEhuUDJQVFJB?=
 =?utf-8?B?eWQyMitjY1pXQnRUY1ZFenF6QnJoTEphYmR0aE5CMzZ0Q1YxbjFJRlhOMjdk?=
 =?utf-8?B?djFKNG9KUlNtd20vR3hjc3REcUx5OWJ5YVorelg0aC92QUR1TUdzaUZWZllF?=
 =?utf-8?B?NUduMCtWZ2ZmM0tiQTlsaEFYWlB4VzdYNlBYRjVFQkwyZzNNeWRpWEJUM2hY?=
 =?utf-8?B?NWdiVjZuUlF2SnFBVVVOODBESUpWay9JRTZ3Szh5ZmpxVGV1UmRNcEh6VjFh?=
 =?utf-8?B?Y0QrNEJIdXhSTWhCenJpOC83cm5qeW9KY1FuL3cyNVBHa0J4amFCQ3FVcG9j?=
 =?utf-8?B?bWhQdmVsSGJJQkQwU3A0QXZvSEpQQmRodXpvcGJveEQ5TVFiZk9FY3lFVUZL?=
 =?utf-8?B?OEFZVUZtcGxlR0RLY3VteVlJNFdxbW41OVBKM3NsTTMzQlIvZ2xJQmpXUGlr?=
 =?utf-8?B?Y2lNVE8wYlNYa2ZYdlFScngwNGJzaHVYUG1pWnEwMlhSUWZwN3FhWU8xcG0x?=
 =?utf-8?B?VHA0a1BTU2hqTU5aVk1aMDNOTlNVNzUwMzVZWFdwMEdpMkZMWkYzV1lRK1Jy?=
 =?utf-8?B?LzUwTXdmV2tDa2Y3MXBEc2VkNVJodmpWTHZOMHdzMVV3bDVrVzY0dll0RE1t?=
 =?utf-8?B?d3BZcHRvSnZqRXFTZ0FnVXdyTE12b1A0Unk5Vm5lYTg3WFZLSFN3RUl4MEZK?=
 =?utf-8?B?aDhHM0V4TDhjczMvaER0VnVMaWp3cDdlTUloeHJBazZOSVFGUHIwbGhRL0VE?=
 =?utf-8?B?YkZOdjNBYy90V1hNSEw3UitrV21JeVlGL2dVYkl1ZWFsVXRaRFRRY0JCa1g2?=
 =?utf-8?B?MU1BbytJTXR5aWRGMEFKbEc0WlRFZTBLcE5vTkZRSVB5T0ozV1ZJS29uTVI3?=
 =?utf-8?B?K3pGZGp2aDRicHNvUGxidDhBVC90TUlZZVhSRWFBbzROZ25OZ0luZXpKZzJP?=
 =?utf-8?B?MzhoS2VsMzhMTHZYeGFMZjBRakZZZVBUOGNXN1lKSjR5c2pKa2k0RUFGa0FD?=
 =?utf-8?B?WjJKd3hvSnRsa01qc3JERUZrOXVBRmJURE5aNTJtNElVc2pKYTNzb0kzN3pQ?=
 =?utf-8?B?VTk5YU5ZQzR2SUpjT0NvS0lXY0RVTzEzUE5VVlJFaHVvSU0yMm1DZDBZQkpM?=
 =?utf-8?B?Vjl0Rmd4UFJZdGlCU1d5aGdIdUNiSFJyeUhqTUN3ZlpvZDlQM2lKMVFJdlY2?=
 =?utf-8?B?cXdTS05Sa0c5YVhSazJ5RzJrWmlVQ3dzQUJibW5lazRqaHV2a0U4T1RZM1hG?=
 =?utf-8?B?VXUwN21xbGFXc00xN3h4WE1MRWViRG53U3VYWHRIMmkxQk1kQVNMN3VINXRT?=
 =?utf-8?B?RVVjbHlrc3B6V0tKSy9VRHRuWEd4eDkrYUdqbnNMZ1A5K3VpS2FKM2g2NlJM?=
 =?utf-8?B?RzZsd1hQanNBVC9Xd3RvMytUSzZpazh6NUNSN0JrNVNGbCtrQ1dtdHVia1pN?=
 =?utf-8?B?WjdHUXVXcTQzRlQxVkRGZjB6aWdlclJTUUp2ZjE4UjlFQ1l1UTIzNmI4RTNX?=
 =?utf-8?B?WDZEMTRneTlWRVpwQTNxQjRSVUo1eWFOQy82NmE5M0xxRWpSY0tWTzFKK0dh?=
 =?utf-8?B?YVpkM2dPU0MrRDJxT21HdDhHK2dFdnY5OW9mN0haQ2lsQk02NUZWVmIzZEFm?=
 =?utf-8?B?dzVXL2Qza2lCTVEwNnlqYklXL1dBOG51VzJqT21TMklzekV1ZDVOMElyZ0l1?=
 =?utf-8?B?dzVGWDN6Vk5ZKzFMeFF4VCtTeXltajN5bWhiQi9tc1lzSTFnRnAwSW1rZ2ZC?=
 =?utf-8?B?UXp5L3pLV3lUSEcwUVVRTTFkMHlTOFJNWlNEZ0ZIUWI1WDFma2E5KzMzcUZT?=
 =?utf-8?B?cCthcmVIakhYOVBFcWZyRjNBNk5VM3BGZFRrYSt5Q3pLeGQ0K041d3lBc3NJ?=
 =?utf-8?Q?9SEA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 13:31:55.3056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef7430c-dd3a-4a07-0078-08de52a81e97
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6899

From: Or Har-Toov <ohartoov@nvidia.com>

When querying speed information for a representor in switchdev mode,
the code previously used the first device in the eswitch, which may not
match the device that actually owns the representor. In setups such as
multi-port eswitch or LAG, this led to incorrect port attributes being
reported.

Fix this by retrieving the correct core device from the representor's
eswitch before querying its port attributes.

Fixes: 27f9e0ccb6da ("net/mlx5: Lag, Add single RDMA device in multiport mode")
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index e81080622283..d0c6648ee035 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -561,12 +561,23 @@ static int mlx5_query_port_roce(struct ib_device *device, u32 port_num,
 	 * of an error it will still be zeroed out.
 	 * Use native port in case of reps
 	 */
-	if (dev->is_rep)
-		err = mlx5_query_port_ptys(mdev, out, sizeof(out), MLX5_PTYS_EN,
-					   1, 0);
-	else
-		err = mlx5_query_port_ptys(mdev, out, sizeof(out), MLX5_PTYS_EN,
-					   mdev_port_num, 0);
+	if (dev->is_rep) {
+		struct mlx5_eswitch_rep *rep;
+		struct mlx5_core_dev *esw_mdev;
+
+		rep = dev->port[port_num - 1].rep;
+		if (rep) {
+			esw_mdev = mlx5_eswitch_get_core_dev(rep->esw);
+			if (esw_mdev)
+				mdev = esw_mdev;
+		}
+
+		mdev_port_num = 1;
+	}
+
+	err = mlx5_query_port_ptys(mdev, out, sizeof(out), MLX5_PTYS_EN,
+				   mdev_port_num, 0);
+
 	if (err)
 		goto out;
 	ext = !!MLX5_GET_ETH_PROTO(ptys_reg, out, true, eth_proto_capability);

---
base-commit: 325e3b5431ddd27c5f93156b36838a351e3b2f72
change-id: 20260113-port-speed-query-fix-592efa2b4e36

Best regards,
-- 
Edward Srouji <edwards@nvidia.com>


