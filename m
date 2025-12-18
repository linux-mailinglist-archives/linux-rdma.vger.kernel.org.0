Return-Path: <linux-rdma+bounces-15081-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D309CCCAA1
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 17:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1831D3076C89
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 16:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7045365A03;
	Thu, 18 Dec 2025 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rFyBFGXy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EDC364EA0;
	Thu, 18 Dec 2025 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073536; cv=fail; b=PBYxQlRdOp77tfM0XVaowBMPWVvCsawHyAq6aHW6DyvttHQQaM/dJ0yrdGJ46ncrLB+jhm/l0MKIVaZHrDOPK/Ajo1NPVJGT9FojrtsVRXYLXNc0Bd3vxhzDWeEzcjWdDRGSEe0rPZj/2S+KBiBf95gzysK0Q+/ArSObGNNhOdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073536; c=relaxed/simple;
	bh=T+Hkmh9aG1NFKuvuaAXNutDwYdMNEbScyHwDTQR0tQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KoDl7+ZaP+t0qQNYNb1FItAI6wgo5uVa80M4UlPGdKXTDg39VkFIRp41uFRlCIcpaEuP5MLqFiQuDGInFfDp5yuMEHMLO+LYjEfwlMMlTrhVvDYbdxZttS8VtHNDVC0yUNSyJ3SRCvs0VrnvhYV1rhoD5k2FXiZG8AZPIiNiJOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rFyBFGXy; arc=fail smtp.client-ip=52.101.56.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMaooYaYiPfieuQs8Z562Rw/zl9+ws9/BEQjAAaEOq3emot0JVQxuxVd9fnGkj3XrUBH0mnJNyTkx2FAbumiekM9jb4VRoMAhusFMLvU/cES8+og0iNjOhcb1AHL1z+x+KxKwuP3yBjw5np0bNVmfuIzfRbjB45pIbcWk9ryeeG65vsafUZYgpK+p8vin/1QEoAI0o3V2vKl14+GsWtub6sIUlBS3eA56W+x6SIt/gK1akIlo9phgSBA+86gYfq4aCiXvyHXDcRoQQejZQIVMXMYvFQd1NhA310t3ShK6+Fo9PxvnJtRX87CnJL2vuZx8kL7uywTgMckMX+VAtvRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pu/AML4uTmyVf8+PaULE0FDm4BHQbXu/z9uoNWDgiWw=;
 b=IX5VnxUaqcJfwTkNGBGNq/2vZ9XfgKdr5heynlJsrX8frw1M7BjY2anK/rpxBzh2luEa/eRnz1D8d84t7KFyxjFzNe5g00Hx5frImMxCUmuAio1CNS93Z4hFF4gZ2S2R4V3VbpmfMSlo90nqZK0yMk/yk0xC810om6YGVEWCPB3J+E7e2KwhWeHaO/uYwi/dJkkcf3ReLiOjk1Yw8MaGNuw+NMVz8BkUNDXdqd0+Z+VHK4ONgjveRIwbkiWxH/zYzJV+5JZrlCieb3R8Gvj7MrA8yU7hd4lqaLxcomcM+joHruzPlWUbC6kk8s6JzAKk+jsLidiRS/xGGAiWHUjcXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pu/AML4uTmyVf8+PaULE0FDm4BHQbXu/z9uoNWDgiWw=;
 b=rFyBFGXyB928GGtY1jNjhMTOZ9KYaVP6ul1mhQmOG5phXmAkl8jd1CZf3Z6yYmXtJ7yZFK1VW/kMQbQ6z8riIQklMW64UIDU2ImdhEffEw4c3TI/tL2Iqu9LkMBSV4nSHNRtmikPOPsBvnCzPWOtgD+GB43Ccxlz2b8a1a7e4ccCvSuxqMIKPDHcuFeoSvDd6y5Z1SgUSA1fX9tKoAX2BWiYJua1DsSNeypkOmONGA+89rIpPImYwHsGN6R/hyq0L1kOtoqd4Ec6lskkETT9pcERFM5Gi3AvfEh0YfCjSj7NDVc81tEHmQExup16RYxAS0nbnlsBE+Mjg+BJuWSR3g==
Received: from CH2PR12CA0012.namprd12.prod.outlook.com (2603:10b6:610:57::22)
 by DM4PR12MB6062.namprd12.prod.outlook.com (2603:10b6:8:b2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Thu, 18 Dec 2025 15:58:48 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::e4) by CH2PR12CA0012.outlook.office365.com
 (2603:10b6:610:57::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Thu,
 18 Dec 2025 15:58:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 15:58:48 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 07:58:25 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 07:58:25 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 18
 Dec 2025 07:58:21 -0800
From: Edward Srouji <edwards@nvidia.com>
To: <edwards@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe
	<jgg@ziepe.ca>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Or Har-Toov <ohartoov@nvidia.com>
Subject: [PATCH mlx5-next 04/10] net/mlx5: Add support for querying bond  speed
Date: Thu, 18 Dec 2025 17:58:20 +0200
Message-ID: <20251218-vf-bw-lag-mode-v1-4-7d8ed4368bea@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251218-vf-bw-lag-mode-v1-0-7d8ed4368bea@nvidia.com>
References: <20251218-vf-bw-lag-mode-v1-0-7d8ed4368bea@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766069544; l=2387;  i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;  bh=DYA3j1FbMdWMjw+VR2DyyLdvAFv7QQDyFWSQpq59lhE=;  b=9V31cIlnHJMoUT+XFcs9UlYbsU0B9ZtSEoFNLSdQ5EejhW8NVj8GTx7YuIKWtYdFduW3U3YSL  af/3hfhiyrDDyieKtyczgU0AtGfUGUdeSepoYROAHd6OQjKgCWdc90C
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;  pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
Content-Transfer-Encoding: quoted-printable
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|DM4PR12MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dbbc216-24a6-4f69-7473-08de3e4e5509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzJGMlNUaUF3ZHRHSG5ZRDRuWjlBWmthVlVQUzZPaFNJREh2UmQyY29qZ3A1?=
 =?utf-8?B?RG14SXlnVngwLzd2N2F2eTBxR3UxNG9PbE5vQTRlcThKME1FcENUa3pYZG5q?=
 =?utf-8?B?K1dSNERnWHZobDRocDVwZzhWVTNEU1JjUmJORXFFUWZlRnZlSXFETFAxUVZQ?=
 =?utf-8?B?M1NxNG5XbHd4cTIxOGdaS1FqQ0dGVzkrbExhTXdCUGcvbGpxeDQ1TUdXMGhY?=
 =?utf-8?B?YytBSzYydTZTYmxjUHEwV05Qcmx0SitnUW5peWZOWE5LdDhDZXVuK1dSQTgv?=
 =?utf-8?B?YmlvYTNKRFhDU0YvRStxY1RlK0lLdjBYMzlUN01sK1ZQaFNpVXZjQ3JIWUtt?=
 =?utf-8?B?NzhqeEs4Q2E1c2lTYWp3RnJzbzB1THZ3VkUwb1FyeTVuNnY5NFg1cWxuTXM0?=
 =?utf-8?B?czVSTlJiaHZMM01xV0dycnhqYmxxTm9UYU81Rm9BNVBISWUrcHM1MkVXTVk1?=
 =?utf-8?B?endwZ0xQK3FkZU1DQ0IrM2xSQlRYdm1LQTcyZ3lpcWFQQWlnTnNpS3RkckxS?=
 =?utf-8?B?a3A5U1k5QWxDL0VIbVBmKzhxc0hFNDlkaGp5MHNOUVpFK0pGaTVMYmtSa0Ux?=
 =?utf-8?B?QmFXYlRmYkRvQlYzaFpINzRjNjI5WlpuR3dyRlBHVk5leGNVYi8zYm9YTEdY?=
 =?utf-8?B?dXVPOXJyT1NuSW9HaW13UUE5Y1ZDb1ArUWk2MjJwdVRhbld3akJBdGFzaUIw?=
 =?utf-8?B?bnd4QUNKbjgyUUh0SzI2S1Myb3RteC9DUHJPSEpxNXY1cWJvdC9lMk5VT3lq?=
 =?utf-8?B?UWJBYlhqbisyYXJsK0grcUgzNklUN1RLd21rYy9MSi9vTHRLY1VCTmtJM3Rs?=
 =?utf-8?B?RWt5dmx3c2I5d0laN3lGS2lVYWJwQ0c3bVR1T1UxRnBFU24vazNldWxFekl4?=
 =?utf-8?B?NFk2KzNFVGMyUC9CTFBnRW03NUJscjV3WlkwOUVSRXVza3RaSmJMdnBQZSt4?=
 =?utf-8?B?cmRXMTRiTXJHTjhGakQzVDFaOWtIaDA5a3FyQVJ1RmJlb21NYXo5YUJKeVJ1?=
 =?utf-8?B?ZmlFaEJTd2N0TEkxMzd1dnkrRGM1azFRQmh6YnFOd3ppYVhob0twdThwTUNS?=
 =?utf-8?B?b0ZSVTFkL2taK3hTeG9HdkZkeTN3V0JMa0dFQlV5eU9vbzVtZVNCN2x2RHdC?=
 =?utf-8?B?dkU4Mk1VVnFRbk9XdjVpOEQyS0tpOWR0dCtEc0dUb1RSMHkwRzlpbHA3d3Jh?=
 =?utf-8?B?Y00rUXhSTFg1S2tqc2h5djVBWVpaeDZuWVFqazhCU3VvTnBuVVUrb3dSbmpM?=
 =?utf-8?B?aEw2SDdzS3dtL1BKV0RDelR4WmpMQnd5OGtKdk1RdGtZd2JBaHdSTnpXQ0Ex?=
 =?utf-8?B?ODd5TUdPZFpERFM3dXdMKzBhNXF0Q25PT1Z6SHZyM3VsaUFleWRwQm05Z1lI?=
 =?utf-8?B?NHBON3dDM1pjMWJDRFFUbGFpSkRoL2RVdWw3cmRTNThZZ29tanVpbmtFcDhj?=
 =?utf-8?B?cnRPbTdRTFpLaDVrMmtQT2c5VnVuRE1xZkJXdk40dzlyODdaNGFIbWR0WS8x?=
 =?utf-8?B?aVdmR1FBdXg5QjF4NEFCd0p0RHdZa1Rkak5CekJCdW5hUUxMRnFUTE4vRmYy?=
 =?utf-8?B?R1RHTmVlZ2E0YWlWSWIzNCtXTDlteGplbnVJM2pOSy9ZcnhTNVd5QlJidzdh?=
 =?utf-8?B?MUErUHNldkN1TU1JSml1d2t4U3Y2cGx4Szh3ckFkNUxaNTNoRWFURTJmaHJS?=
 =?utf-8?B?Wi9lSFlaN0t5YjMxeU1vV1pMWks3enBtd2ZacDRYTjl1bmwwTUtNeHVKUTlk?=
 =?utf-8?B?UDBHcFYwZytDRlczSmhpNzh4Z2psVmlWUnRKeHgvVWNKd3RkZWErbWc5TW1a?=
 =?utf-8?B?UkhYNVllbjQvM1hrOFZ5Z2NnRGFheUR5UVBpUGlVQzF4UUdJTGhIK3BWWld3?=
 =?utf-8?B?RVZXTllWRWszOUcwTkRYd3hkRE1CWnFkaWtiaDZhTjNOWjdVNHJWMnJUVnZz?=
 =?utf-8?B?aWdKR1VJREFDVFgxenRXemNNMTRXWlBYeWFOM1hCbCsvR3NQWWtDQzdhbEM1?=
 =?utf-8?B?dzhDMGlwYjgxd2RrWHhkUzZ0NUErNERyRElxTnQ4TWwwdHFMOGJZVWIvUk9C?=
 =?utf-8?B?K1Q3NjNlYm1Fd2VONklYamRjV0lWQ0ZteDRIdXpMdytaQXJCWEJCeGE4ZjJK?=
 =?utf-8?Q?wSWcOWGz4WXRJvg3HQeLkba04?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:58:48.6649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbbc216-24a6-4f69-7473-08de3e4e5509
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6062

From: Or Har-Toov <ohartoov@nvidia.com>=0D
=0D
Add mlx5_lag_query_bond_speed() to query the aggregated speed of=0D
lag configurationsi with a bond device.=0D
=0D
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>=0D
Reviewed-by: Mark Bloch <mbloch@nvidia.com>=0D
Signed-off-by: Edward Srouji <edwards@nvidia.com>=0D
---=0D
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 27 +++++++++++++++++++=
++++=0D
 include/linux/mlx5/driver.h                       |  2 +-=0D
 2 files changed, 28 insertions(+), 1 deletion(-)=0D
=0D
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/ne=
t/ethernet/mellanox/mlx5/core/lag/lag.c=0D
index 0b931aaecef8..187ea8219ca9 100644=0D
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c=0D
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c=0D
@@ -1464,6 +1464,33 @@ static void mlx5_lag_update_tracker_speed(struct lag=
_tracker *tracker,=0D
 		tracker->bond_speed_mbps =3D lksettings.base.speed;=0D
 }=0D
 =0D
+/* Returns speed in Mbps. */=0D
+int mlx5_lag_query_bond_speed(struct mlx5_core_dev *mdev, u32 *speed)=0D
+{=0D
+	struct mlx5_lag *ldev;=0D
+	unsigned long flags;=0D
+	int ret =3D 0;=0D
+=0D
+	spin_lock_irqsave(&lag_lock, flags);=0D
+	ldev =3D mlx5_lag_dev(mdev);=0D
+	if (!ldev) {=0D
+		ret =3D -ENODEV;=0D
+		goto unlock;=0D
+	}=0D
+=0D
+	*speed =3D ldev->tracker.bond_speed_mbps;=0D
+=0D
+	if (*speed =3D=3D SPEED_UNKNOWN) {=0D
+		mlx5_core_dbg(mdev, "Bond speed is unknown\n");=0D
+		ret =3D -EINVAL;=0D
+	}=0D
+=0D
+unlock:=0D
+	spin_unlock_irqrestore(&lag_lock, flags);=0D
+	return ret;=0D
+}=0D
+EXPORT_SYMBOL_GPL(mlx5_lag_query_bond_speed);=0D
+=0D
 /* this handler is always registered to netdev events */=0D
 static int mlx5_lag_netdev_event(struct notifier_block *this,=0D
 				 unsigned long event, void *ptr)=0D
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h=0D
index 9e0ab3cfab73..e2d067b1e67b 100644=0D
--- a/include/linux/mlx5/driver.h=0D
+++ b/include/linux/mlx5/driver.h=0D
@@ -1149,7 +1149,7 @@ int mlx5_cmd_destroy_vport_lag(struct mlx5_core_dev *=
dev);=0D
 bool mlx5_lag_is_roce(struct mlx5_core_dev *dev);=0D
 bool mlx5_lag_is_sriov(struct mlx5_core_dev *dev);=0D
 bool mlx5_lag_is_active(struct mlx5_core_dev *dev);=0D
-int mlx5_lag_query_bond_speed(struct net_device *bond_dev, u32 *speed);=0D
+int mlx5_lag_query_bond_speed(struct mlx5_core_dev *dev, u32 *speed);=0D
 bool mlx5_lag_mode_is_hash(struct mlx5_core_dev *dev);=0D
 bool mlx5_lag_is_master(struct mlx5_core_dev *dev);=0D
 bool mlx5_lag_is_shared_fdb(struct mlx5_core_dev *dev);=0D
=0D
-- =0D
2.47.1=0D
=0D

