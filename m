Return-Path: <linux-rdma+bounces-15080-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E44DCCCC16
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 17:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3F8130EA600
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 16:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A4A364EA2;
	Thu, 18 Dec 2025 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RVnrZbiL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8F03644DF;
	Thu, 18 Dec 2025 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073534; cv=fail; b=pjQv7H+1nDMK7keQACczB17ddeAHWZl2OzEJOkR8u71zuuoRErmdUGzk63CY+jpWJIe6CNhb0EDedB0OQvYBJxX9gloxKpDTBe1HEMPEUFZ5u96rlV6Dn5G7qGcGhcmOC017rK4su/+QkEHS4qMeZ1XnpqdirKloXvSZdTIP94M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073534; c=relaxed/simple;
	bh=stjMMxOEdX+hahM0nupX6ipaKb1dwDBNA9FM7p2wXDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOZ42B8yHAnol1cjZER/8JQHb2N5nivW9ui/ClI2h2byCU46Sz/Bjtnfb6nv9DV2JUuHpJxn7iUrUiFrBlsclwnvh7EcK/7rnbAgioup2z9Rj5R10yYMHS6ORNJSkqNYkyk99FIFkPPOYpl/dSrYwyRkIT06K6h64WpLprXr7uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RVnrZbiL; arc=fail smtp.client-ip=52.101.62.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5zpcfyaB5O+u+oADZELbrlOC8t7D7olU5/PA4weHVuBeX8VG0aFn4lkwDfK+GO9Whjo++UhU2dSI/buiF9IE18xGlHUFeMR+VBbCo9qaY5zpCpCdLvsJFVcD28tbXEwDJUdCPDe5FOswTB/JsdD8il9st3Y2O6YjdE++882DRO3rL8VFTBKkuqxwF3nFBRmXPczQK7szz+KeDd+W8odsTGWPrWt9KAZxXNUoPRtv0ReUvkj5fMNocOu2bPsN0iLyJVRTvhc0f60tqrwrwGuO42LkBp1R2vQvMWD7kbwFnTphVDzQundEbLTHROdSeBDwHxR5+PAPBvcYvt+NwsBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seCKdnhBGosn1QhG9stm50E4d1MlvCTEsjkpQ7MYvJY=;
 b=wNjTS6cI7vjKz6oiJPAqdmqyoeFud+xh25nmU6vks3KoFVxD+hONixx9THdIo4/KuMcxn6AtfS4hOpG9IDZu6XPoVl6dsk1jEwagoZH+DfgOxFuJ1fzGYUr0DsN8XFBgk+Q55PARM5h4qsKqtmlyqs/7refIHTp0N4o6wciBp+IXg1ufYSt92kZE3jnnriVDRV+nu4UIV3o+EFYAke6M/iY1ZivMcDArB6bi6YDjNlCu4cf2DS5yJx/wJu94LCiXp8QH+FKjmtBMh13UphXGx7R6I75jkRl628lUVrcILXHaFjadS9DpKtYOZCqaLmvLfegLO59L2GsbA6yx1ghyPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seCKdnhBGosn1QhG9stm50E4d1MlvCTEsjkpQ7MYvJY=;
 b=RVnrZbiL/S7AxRNGHbsRWepIO9M3RLG90cpmdFWMVQGEyerpJ1Vu36HXJ4ZPYvMh1rckQ+kNDeK0k34nUYPQ+pgV3IDMX182L9h76xoUYMJjzgXawEYh5ayr4yYxjfC+X0qeOVIfU+UtWN0fITqTBtAJ98cHhsn5Ap1LCThZZ4SoIyouhU88kUSjSKbbbcFdkrQfnjFBFLL3Ga74ZdD4cXY2zSpw1e7762sHXo6gJ+vc5ziEAHHb9TBUAzPNAv+kIgTFBacQw0x+WrScLkp+o9WX4VgHRDTo1CHHZ2pFyKSQ+3S5eBLAEvoov6F7R10Z0fcTwus0yiQ4kOSMp8P3OA==
Received: from CH0P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::19)
 by CH3PR12MB9341.namprd12.prod.outlook.com (2603:10b6:610:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 15:58:45 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::33) by CH0P221CA0018.outlook.office365.com
 (2603:10b6:610:11c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Thu,
 18 Dec 2025 15:58:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 15:58:43 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 07:58:18 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 07:58:18 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 18
 Dec 2025 07:58:14 -0800
From: Edward Srouji <edwards@nvidia.com>
To: <edwards@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe
	<jgg@ziepe.ca>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Or Har-Toov <ohartoov@nvidia.com>, "Maher
 Sanalla" <msanalla@nvidia.com>
Subject: [PATCH mlx5-next 03/10] net/mlx5: Handle port and vport speed  change events in MPESW
Date: Thu, 18 Dec 2025 17:58:13 +0200
Message-ID: <20251218-vf-bw-lag-mode-v1-3-7d8ed4368bea@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766069544; l=10422;  i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;  bh=+3/LGyzysM6EiOwyN7R1W30WCeCKs2Ca44dFQbjCSZo=;  b=L3NWf5NDHnEv3Xk4/kM3xJSVTxWyAKoOuNfrW84jAXmVqRMK6YP34WA1BD7O50mb8yV2ob7T6  wU7F1GwhEzCAOWGT/5txXhQCJ1vQI4RC2l7ptUDeo+8+n5AoNmQ6kM4
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;  pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
Content-Transfer-Encoding: quoted-printable
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|CH3PR12MB9341:EE_
X-MS-Office365-Filtering-Correlation-Id: c589191c-f1e4-4483-e953-08de3e4e51fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGdKRzREUVM5MXA3SEE1R0FHc0JYQm44N0lGbUxTK1N0SHRLZk1FVDNrWE5U?=
 =?utf-8?B?U3owZ0hncDhmbFFwQ1Q0UnhkSlNIQVNrOEw4OEUwYUxDWWZDODRaSXRqbUJM?=
 =?utf-8?B?WDhQU2pZQmhXaFNPT1k3NFRVb1FTM1d3S0thaElHTnRCbU1NRHMrMXBUNUph?=
 =?utf-8?B?UGtxcHo2VnVFeEJ0cmNvUmsrZkZjVEpWUTZORHViM091UnBNZVE1Q1l3Z2Ra?=
 =?utf-8?B?Vk15YWt0RzR6bHN4eXhJbENlU2pyTHZkd2VwVnBqM1VHc0FTRldFQ3VHOFk5?=
 =?utf-8?B?andkdXRLNFREY0NINjE1RHlHR3BYdmdFQ1prVTRDNzJVZkcrTHJDS0EvOVVi?=
 =?utf-8?B?YmxCSWhWSzFBeGFaaDZNVkxRbTJRZ0lCWFJVQ0sraUYyTlJoMG1LdEdkemZx?=
 =?utf-8?B?cVJoSkxaZnR3aEhUa0FZeVFRcHF5SDRjZVVmcE9xWGFOeVI5TXRjM1pJYWlP?=
 =?utf-8?B?QVRLc0NVY0ZMRTlHNmRrUnh0SEYyQ1FkOE9walZuZkgraFlsM2ZXdDNWMFV3?=
 =?utf-8?B?UlBpL282N3pQeDY3ZWN0UDdIVlJsT1hLejJWbWxqalA5VVJzVng3YW9UZ3E5?=
 =?utf-8?B?UGYxKzRNYlgvY25raEM0WURBWjBFUUdnYmEzem1pQms3aENmWVQrN0JaU2hh?=
 =?utf-8?B?VXBlRGM4OGxBTlFkUFN0SExRRUxkNHRFaFhyTmhBdXY0R3FmMWZoZFh1NFRt?=
 =?utf-8?B?WEhacVl1ZHZ4Wng5Ly9YRitVZzB2LzVKLzBxUWVUTkJPR05hVkloQ1B6KzNv?=
 =?utf-8?B?RDNJcmNKN2l6TjRxUUdvQXdNclN4a3BmRGduRHBhR09ibHkvdnlTaTVsSkFt?=
 =?utf-8?B?RzNkY2NWbDl1MzFaSVVCNUZNczg4WXM1dDdKUkd4Sm8vKzJjU0JBTjh2dTJS?=
 =?utf-8?B?Qlp6WkhOdmxpaWhYb3k4MVBOVnNNeklIQi9VUldSWncvTGFjK09oOXFuTkw1?=
 =?utf-8?B?aWhLTjlWMWZHY0k4Tm9ndWZYQWViSy9MN212c3NKS3FDWm15K1BRNjVJbkwx?=
 =?utf-8?B?Mk5RVkN6TGtBV2wyemd1YVpXUDZ3a2ZITWE2a3ZqQmZaaGErOTBuZjg4QVhZ?=
 =?utf-8?B?NFdRaXRyUHRVMlZhaHBQbjhHK2lkZmRwcWJmbkY1MytoTGxhaXMwcG9pVW5l?=
 =?utf-8?B?N2YwQTBTNjBFdnMzVm5RTlB4VnNhSmp6cTFzekRXQnRxRnFVUDYrVytSaVJz?=
 =?utf-8?B?S0tUdkFvcys0ZTNMa2tUZHhiSXExMFJWUmg4K1dUYXVrZFp6ZWt3M0Z0cm9N?=
 =?utf-8?B?SWlPaXFUN2lFTVh5T0lzazVyemN2WGV1MC9lYVI2QkpjY29UMHNvak1XbDhk?=
 =?utf-8?B?d0FDU3dIaU1XSFpZRXpSMXMwdjFHTmc1YzRDRWJNYzAzUkdWRm5SZGJlT0tz?=
 =?utf-8?B?R1lpbzhtMFNreTE5VjE3d095MmJ2OU83eHJFK20yeGN2Z3ZyeVpGWXdKYjBP?=
 =?utf-8?B?YXlGa0JjbjN0N2lWN3ZzL0FNbGpSMUNnaGJiRVdtNlpqS21UaFM1UWdLcUw0?=
 =?utf-8?B?QVhRSDZvQ05yaEphY0I3T3grSzA5OWt1WlNPQm9FTnA1cUxkRk5uazh2WGlv?=
 =?utf-8?B?ZTF4alhhYjN1SkdHUXJSeDlFYWtIbEM1emREeE11OUU2Z0hGSXo4ZW5tVGRh?=
 =?utf-8?B?Vm5oVklUN0pMVkEvMUtPNis0Rmh3Qy9kdWYzWFY3SlV1cHkyWkhqRFlMVjhs?=
 =?utf-8?B?TWRjQ2NVb1hmMjFMUnNDUldNS3oyMWtmUzNRL0hTTy9HbUlzRkNaWXoyQzNv?=
 =?utf-8?B?WFlWK0dESEM1YUhySEZUOXR5aUFuVzdoQzY3TEExRkJjRWdDczRJWFQ3TnlT?=
 =?utf-8?B?REowNzR1OFNRd1BOUnZtUFpJS3pmanZyY2Rya1l6SW9LMGRnejM5bDh6dENB?=
 =?utf-8?B?TnEreVJaam1VeExTUm83dWJDWVd4QzdaZ3h0ZzViMHZQamw5dHNQYUYyYzJy?=
 =?utf-8?B?OW92dzlySStBTjNTUW5MQUtBaG96bjVWQkJSQXpsUkR3ZlhqdW1DRE9ENlBQ?=
 =?utf-8?B?TGVaUytuM2pYdi9TZmQzQW5uaGZudy9YMytIWTRGSE5KWEpYYzRMZ2JkVDd5?=
 =?utf-8?B?bmpjVlZkNlZXU1RwaENsOEsxc3M0bUZFQWpXdzQxN0pEYmdNQjAzaFZKb2Y1?=
 =?utf-8?Q?26DeM1GynPS1TpBhK9lklTdsn?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:58:43.6044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c589191c-f1e4-4483-e953-08de3e4e51fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9341

From: Or Har-Toov <ohartoov@nvidia.com>=0D
=0D
Add port change event handling logic for MPESW LAG mode, ensuring=0D
VFs are updated when the speed of LAG physical ports changes.=0D
This triggers a speed update workflow when relevant port state changes=0D
occur, enabling consistent and accurate reporting of VF bandwidth.=0D
=0D
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>=0D
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>=0D
Reviewed-by: Mark Bloch <mbloch@nvidia.com>=0D
Signed-off-by: Edward Srouji <edwards@nvidia.com>=0D
---=0D
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  | 38 ++++++++++++++++++=
---=0D
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h  |  2 ++=0D
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.c    | 39 ++++++++++++++++++=
++++=0D
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.h    | 14 ++++++++=0D
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    | 29 ++++++++++++++++=0D
 include/linux/mlx5/driver.h                        |  1 +=0D
 include/linux/mlx5/vport.h                         |  2 ++=0D
 7 files changed, 121 insertions(+), 4 deletions(-)=0D
=0D
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/ne=
t/ethernet/mellanox/mlx5/core/lag/lag.c=0D
index a042612dcde6..0b931aaecef8 100644=0D
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c=0D
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c=0D
@@ -233,14 +233,25 @@ static void mlx5_ldev_free(struct kref *ref)=0D
 {=0D
 	struct mlx5_lag *ldev =3D container_of(ref, struct mlx5_lag, ref);=0D
 	struct net *net;=0D
+	int i;=0D
 =0D
 	if (ldev->nb.notifier_call) {=0D
 		net =3D read_pnet(&ldev->net);=0D
 		unregister_netdevice_notifier_net(net, &ldev->nb);=0D
 	}=0D
 =0D
+	mlx5_ldev_for_each(i, 0, ldev) {=0D
+		if (ldev->pf[i].dev &&=0D
+		    ldev->pf[i].port_change_nb.nb.notifier_call) {=0D
+			struct mlx5_nb *nb =3D &ldev->pf[i].port_change_nb;=0D
+=0D
+			mlx5_eq_notifier_unregister(ldev->pf[i].dev, nb);=0D
+		}=0D
+	}=0D
+=0D
 	mlx5_lag_mp_cleanup(ldev);=0D
 	cancel_delayed_work_sync(&ldev->bond_work);=0D
+	cancel_work_sync(&ldev->speed_update_work);=0D
 	destroy_workqueue(ldev->wq);=0D
 	mutex_destroy(&ldev->lock);=0D
 	kfree(ldev);=0D
@@ -274,6 +285,7 @@ static struct mlx5_lag *mlx5_lag_dev_alloc(struct mlx5_=
core_dev *dev)=0D
 	kref_init(&ldev->ref);=0D
 	mutex_init(&ldev->lock);=0D
 	INIT_DELAYED_WORK(&ldev->bond_work, mlx5_do_bond_work);=0D
+	INIT_WORK(&ldev->speed_update_work, mlx5_mpesw_speed_update_work);=0D
 =0D
 	ldev->nb.notifier_call =3D mlx5_lag_netdev_event;=0D
 	write_pnet(&ldev->net, mlx5_core_net(dev));=0D
@@ -1033,6 +1045,13 @@ static int mlx5_lag_sum_devices_max_speed(struct mlx=
5_lag *ldev, u32 *max_speed)=0D
 					  mlx5_port_max_linkspeed);=0D
 }=0D
 =0D
+static int mlx5_lag_sum_devices_oper_speed(struct mlx5_lag *ldev,=0D
+					   u32 *oper_speed)=0D
+{=0D
+	return mlx5_lag_sum_devices_speed(ldev, oper_speed,=0D
+					  mlx5_port_oper_linkspeed);=0D
+}=0D
+=0D
 static void mlx5_lag_modify_device_vports_speed(struct mlx5_core_dev *mdev=
,=0D
 						u32 speed)=0D
 {=0D
@@ -1070,10 +1089,14 @@ void mlx5_lag_set_vports_agg_speed(struct mlx5_lag =
*ldev)=0D
 	u32 speed;=0D
 	int pf_idx;=0D
 =0D
-	speed =3D ldev->tracker.bond_speed_mbps;=0D
-=0D
-	if (speed =3D=3D SPEED_UNKNOWN)=0D
-		return;=0D
+	if (ldev->mode =3D=3D MLX5_LAG_MODE_MPESW) {=0D
+		if (mlx5_lag_sum_devices_oper_speed(ldev, &speed))=0D
+			return;=0D
+	} else {=0D
+		speed =3D ldev->tracker.bond_speed_mbps;=0D
+		if (speed =3D=3D SPEED_UNKNOWN)=0D
+			return;=0D
+	}=0D
 =0D
 	/* If speed is not set, use the sum of max speeds of all PFs */=0D
 	if (!speed && mlx5_lag_sum_devices_max_speed(ldev, &speed))=0D
@@ -1520,6 +1543,10 @@ static void mlx5_ldev_add_mdev(struct mlx5_lag *ldev=
,=0D
 =0D
 	ldev->pf[fn].dev =3D dev;=0D
 	dev->priv.lag =3D ldev;=0D
+=0D
+	MLX5_NB_INIT(&ldev->pf[fn].port_change_nb,=0D
+		     mlx5_lag_mpesw_port_change_event, PORT_CHANGE);=0D
+	mlx5_eq_notifier_register(dev, &ldev->pf[fn].port_change_nb);=0D
 }=0D
 =0D
 static void mlx5_ldev_remove_mdev(struct mlx5_lag *ldev,=0D
@@ -1531,6 +1558,9 @@ static void mlx5_ldev_remove_mdev(struct mlx5_lag *ld=
ev,=0D
 	if (ldev->pf[fn].dev !=3D dev)=0D
 		return;=0D
 =0D
+	if (ldev->pf[fn].port_change_nb.nb.notifier_call)=0D
+		mlx5_eq_notifier_unregister(dev, &ldev->pf[fn].port_change_nb);=0D
+=0D
 	ldev->pf[fn].dev =3D NULL;=0D
 	dev->priv.lag =3D NULL;=0D
 }=0D
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/ne=
t/ethernet/mellanox/mlx5/core/lag/lag.h=0D
index 8de5640a0161..be1afece5fdc 100644=0D
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h=0D
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h=0D
@@ -39,6 +39,7 @@ struct lag_func {=0D
 	struct mlx5_core_dev *dev;=0D
 	struct net_device    *netdev;=0D
 	bool has_drop;=0D
+	struct mlx5_nb port_change_nb;=0D
 };=0D
 =0D
 /* Used for collection of netdev event info. */=0D
@@ -67,6 +68,7 @@ struct mlx5_lag {=0D
 	struct lag_tracker        tracker;=0D
 	struct workqueue_struct   *wq;=0D
 	struct delayed_work       bond_work;=0D
+	struct work_struct        speed_update_work;=0D
 	struct notifier_block     nb;=0D
 	possible_net_t net;=0D
 	struct lag_mp             lag_mp;=0D
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/=
net/ethernet/mellanox/mlx5/core/lag/mpesw.c=0D
index aad52d3a90e6..31464343f642 100644=0D
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c=0D
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c=0D
@@ -103,6 +103,8 @@ static int enable_mpesw(struct mlx5_lag *ldev)=0D
 			goto err_rescan_drivers;=0D
 	}=0D
 =0D
+	mlx5_lag_set_vports_agg_speed(ldev);=0D
+=0D
 	return 0;=0D
 =0D
 err_rescan_drivers:=0D
@@ -216,3 +218,40 @@ bool mlx5_lag_is_mpesw(struct mlx5_core_dev *dev)=0D
 	return ldev && ldev->mode =3D=3D MLX5_LAG_MODE_MPESW;=0D
 }=0D
 EXPORT_SYMBOL(mlx5_lag_is_mpesw);=0D
+=0D
+void mlx5_mpesw_speed_update_work(struct work_struct *work)=0D
+{=0D
+	struct mlx5_lag *ldev =3D container_of(work, struct mlx5_lag,=0D
+					     speed_update_work);=0D
+=0D
+	mutex_lock(&ldev->lock);=0D
+	if (ldev->mode =3D=3D MLX5_LAG_MODE_MPESW) {=0D
+		if (ldev->mode_changes_in_progress)=0D
+			queue_work(ldev->wq, &ldev->speed_update_work);=0D
+		else=0D
+			mlx5_lag_set_vports_agg_speed(ldev);=0D
+	}=0D
+=0D
+	mutex_unlock(&ldev->lock);=0D
+}=0D
+=0D
+int mlx5_lag_mpesw_port_change_event(struct notifier_block *nb,=0D
+				     unsigned long event, void *data)=0D
+{=0D
+	struct mlx5_nb *mlx5_nb =3D container_of(nb, struct mlx5_nb, nb);=0D
+	struct lag_func *lag_func =3D container_of(mlx5_nb,=0D
+						 struct lag_func,=0D
+						 port_change_nb);=0D
+	struct mlx5_core_dev *dev =3D lag_func->dev;=0D
+	struct mlx5_lag *ldev =3D dev->priv.lag;=0D
+	struct mlx5_eqe *eqe =3D data;=0D
+=0D
+	if (!ldev)=0D
+		return NOTIFY_DONE;=0D
+=0D
+	if (eqe->sub_type =3D=3D MLX5_PORT_CHANGE_SUBTYPE_DOWN ||=0D
+	    eqe->sub_type =3D=3D MLX5_PORT_CHANGE_SUBTYPE_ACTIVE)=0D
+		queue_work(ldev->wq, &ldev->speed_update_work);=0D
+=0D
+	return NOTIFY_OK;=0D
+}=0D
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h b/drivers/=
net/ethernet/mellanox/mlx5/core/lag/mpesw.h=0D
index 02520f27a033..f5d9b5c97b0d 100644=0D
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h=0D
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h=0D
@@ -32,4 +32,18 @@ bool mlx5_lag_is_mpesw(struct mlx5_core_dev *dev);=0D
 void mlx5_lag_mpesw_disable(struct mlx5_core_dev *dev);=0D
 int mlx5_lag_mpesw_enable(struct mlx5_core_dev *dev);=0D
 =0D
+#ifdef CONFIG_MLX5_ESWITCH=0D
+void mlx5_mpesw_speed_update_work(struct work_struct *work);=0D
+int mlx5_lag_mpesw_port_change_event(struct notifier_block *nb,=0D
+				     unsigned long event, void *data);=0D
+#else=0D
+static inline void mlx5_mpesw_speed_update_work(struct work_struct *work) =
{}=0D
+static inline int mlx5_lag_mpesw_port_change_event(struct notifier_block *=
nb,=0D
+						   unsigned long event,=0D
+						   void *data)=0D
+{=0D
+	return NOTIFY_DONE;=0D
+}=0D
+#endif /* CONFIG_MLX5_ESWITCH */=0D
+=0D
 #endif /* __MLX5_LAG_MPESW_H__ */=0D
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/=
ethernet/mellanox/mlx5/core/vport.c=0D
index 78b1b291cfa4..cb098d3eb2fa 100644=0D
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c=0D
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c=0D
@@ -122,6 +122,35 @@ int mlx5_modify_vport_max_tx_speed(struct mlx5_core_de=
v *mdev, u8 opmod,=0D
 	return mlx5_cmd_exec_in(mdev, modify_vport_state, in);=0D
 }=0D
 =0D
+int mlx5_query_vport_max_tx_speed(struct mlx5_core_dev *mdev, u8 op_mod,=0D
+				  u16 vport, u8 other_vport, u32 *max_tx_speed)=0D
+{=0D
+	u32 out[MLX5_ST_SZ_DW(query_vport_state_out)] =3D {};=0D
+	u32 in[MLX5_ST_SZ_DW(query_vport_state_in)] =3D {};=0D
+	u32 state;=0D
+	int err;=0D
+=0D
+	MLX5_SET(query_vport_state_in, in, opcode,=0D
+		 MLX5_CMD_OP_QUERY_VPORT_STATE);=0D
+	MLX5_SET(query_vport_state_in, in, op_mod, op_mod);=0D
+	MLX5_SET(query_vport_state_in, in, vport_number, vport);=0D
+	MLX5_SET(query_vport_state_in, in, other_vport, other_vport);=0D
+=0D
+	err =3D mlx5_cmd_exec_inout(mdev, query_vport_state, in, out);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	state =3D MLX5_GET(query_vport_state_out, out, state);=0D
+	if (state =3D=3D VPORT_STATE_DOWN) {=0D
+		*max_tx_speed =3D 0;=0D
+		return 0;=0D
+	}=0D
+=0D
+	*max_tx_speed =3D MLX5_GET(query_vport_state_out, out, max_tx_speed);=0D
+	return 0;=0D
+}=0D
+EXPORT_SYMBOL_GPL(mlx5_query_vport_max_tx_speed);=0D
+=0D
 static int mlx5_query_nic_vport_context(struct mlx5_core_dev *mdev, u16 vp=
ort,=0D
 					bool other_vport, u32 *out)=0D
 {=0D
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h=0D
index 1c54aa6f74fb..9e0ab3cfab73 100644=0D
--- a/include/linux/mlx5/driver.h=0D
+++ b/include/linux/mlx5/driver.h=0D
@@ -1149,6 +1149,7 @@ int mlx5_cmd_destroy_vport_lag(struct mlx5_core_dev *=
dev);=0D
 bool mlx5_lag_is_roce(struct mlx5_core_dev *dev);=0D
 bool mlx5_lag_is_sriov(struct mlx5_core_dev *dev);=0D
 bool mlx5_lag_is_active(struct mlx5_core_dev *dev);=0D
+int mlx5_lag_query_bond_speed(struct net_device *bond_dev, u32 *speed);=0D
 bool mlx5_lag_mode_is_hash(struct mlx5_core_dev *dev);=0D
 bool mlx5_lag_is_master(struct mlx5_core_dev *dev);=0D
 bool mlx5_lag_is_shared_fdb(struct mlx5_core_dev *dev);=0D
diff --git a/include/linux/mlx5/vport.h b/include/linux/mlx5/vport.h=0D
index 2acf10e9f60a..dfa2fe32217a 100644=0D
--- a/include/linux/mlx5/vport.h=0D
+++ b/include/linux/mlx5/vport.h=0D
@@ -60,6 +60,8 @@ enum {=0D
 u8 mlx5_query_vport_state(struct mlx5_core_dev *mdev, u8 opmod, u16 vport)=
;=0D
 int mlx5_modify_vport_admin_state(struct mlx5_core_dev *mdev, u8 opmod,=0D
 				  u16 vport, u8 other_vport, u8 state);=0D
+int mlx5_query_vport_max_tx_speed(struct mlx5_core_dev *mdev, u8 op_mod,=0D
+				  u16 vport, u8 other_vport, u32 *max_tx_speed);=0D
 int mlx5_modify_vport_max_tx_speed(struct mlx5_core_dev *mdev, u8 opmod,=0D
 				   u16 vport, u8 other_vport, u16 max_tx_speed);=0D
 int mlx5_query_nic_vport_mac_address(struct mlx5_core_dev *mdev,=0D
=0D
-- =0D
2.47.1=0D
=0D

