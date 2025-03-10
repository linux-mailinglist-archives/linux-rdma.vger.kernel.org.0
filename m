Return-Path: <linux-rdma+bounces-8541-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6682A5A633
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 22:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC891889DF2
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 21:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142531E3787;
	Mon, 10 Mar 2025 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bqk/hUtR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401DD1E5B84;
	Mon, 10 Mar 2025 21:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642102; cv=fail; b=f+uCvw+tGltUoEiIuVKB7fqW9D3JwjcQeHMZW0qlekB8NbMVkBGHExCIGFzIWNtgSY0qEkUQr18SQGKAACRdlX/Lm4qovxwcAP9IDDIqLpzivHTyHxhMzZIj9ULqLi4FRBNv0rMOspw8DpmGKo944IxoH0RIjgHK4U312S8eBnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642102; c=relaxed/simple;
	bh=DluEhYQt31UAc108j2cfIPwZ37bBCAk4qQAwDR7VyD8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LVtNe5Ta7ayhawYJowcxLciQRY6kz9aqBEjO4OIRxfC2YRpUCs9auf9GhuayAFpK7AaZOx02LgCW6ypewIvwtrGF2YWQ5g3naO9g+P1nvWQnoyEhq5jiwkUtuKLwXwy86VQpKDPg/mEc562/UQla6lfszcI6zcWXQg5/VNdTgSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bqk/hUtR; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpnEVuIEircbql/xfbYhGJtQA5m/+5NSmME2/00H7EYmM3Mp7mgakph2H0JT7NpUUXKYCmqoHmhn0Ja+v/WyBRueCpcoJ4y1eaZZWOPsJ7qTuCcowVNBjxduOztctIa8NPW9dbv264QUpd408VqEY2SsiMqF9ODLM7UDJGkbXFNRzveWAl/jWyV5N0Jv1YOTltgJZNtqRHE3bxyq4KwlJztEC2Xqjd/lTxoQmBTk2aO+UT6L/h7VVJuT4CIBoqp5D625e7eM9mSwPczpyTgaLSN0pSZr7z0kdgZnXkPL8yvGk5CiQBWe01XKXd9V9VHqlrHOOQfzFnagmzXmG8/C/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6J7XsBVEikYPTbh7AockGOO6zNvNZtEWNUZsM61hHk=;
 b=vCdQ7wi7SnO0qcVamNO4pIvUz7VWNLV4lqXk0cd/sa/FOU2RVtIDYydqag2Y5FDvOHn0tvnYqxG/AwmDWVl+w+TRKuKDQaNeCiD81SkZvDgjbSag36itu8dOXeNaMJs5AEYW3VS1CK/iN4mQEwT/fIRGDAaIwO8ybzY5kP7kb/HB7GgjAveDTlDDupmDp3h7dxcIorNDARVX29aT7OpoeXjqQ3z0eO/HTcXm6X+RhVB5jwN8sovlmfxBIw452gCF/tYEAYBrVJI4HMSUW8d6glZ9H90lEeAXDjSs8QagLBFkf668cxlBVRi+GwLqEkAgkFC3w2O3CPYCSKT9og3IhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6J7XsBVEikYPTbh7AockGOO6zNvNZtEWNUZsM61hHk=;
 b=bqk/hUtRwq5CX3JBz33fa1AQNpvyAr45RInC44DgXYzC8DPG7zDDLWlbJjV+wxlLLKxUEhWb40eqbOY5Tb57lGCa+3egkLYZQCUoTXxRlFA5j2nGe1eP64UzHilphKvwIEDrrnfOoGbMswQ65L754yd3fVhfdWgkwjOCX21qhOKqMo4CBicHisBrWFP+hY8ZV71lpI6NEoYiMdyXOv6YXVpoNl2UuILuGU9LfBW0r5TuiC7IZXXYmGq6RFgMIY7K9E02fu0zyBx/BraaaxwXml3E0KdDZeQEu0zeuSApn6sbbw5Olh9xw4FYa+PrSPan5hS/Ydu8mcOXluKcJhU7qA==
Received: from BN7PR06CA0043.namprd06.prod.outlook.com (2603:10b6:408:34::20)
 by DS7PR12MB8251.namprd12.prod.outlook.com (2603:10b6:8:e3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Mon, 10 Mar 2025 21:28:16 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:408:34:cafe::7e) by BN7PR06CA0043.outlook.office365.com
 (2603:10b6:408:34::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 21:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:28:15 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Mar
 2025 14:27:50 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 14:27:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 10 Mar 2025 14:27:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 0/4] mlx5: Support setting a parent for a devlink rate node
Date: Mon, 10 Mar 2025 23:26:52 +0200
Message-ID: <1741642016-44918-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|DS7PR12MB8251:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ba7f13-88f2-4e6e-4381-08dd601a7866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzFabkZUL3dUMEp4b0ZNUG5YejlOS0NkcmJQdWJTRkZOM1V0bGh3MGFPQ1ZZ?=
 =?utf-8?B?NkZhY2trd1ZIYjRwWjlGRDVvVWlJN3RrMU5ReE9Xb01vRmNrRmQ2M0Uwb3Ft?=
 =?utf-8?B?TG1rKzFZTDhISys0NWZnbUZETlJ0STJxUUgxa3NrV01YQWVJN0dHeUNGK2dv?=
 =?utf-8?B?K0tsTzhHeVJxWktEMWJkOGt0UjdhVHVVb1VDYThLUUhtVXZtbEcyUERlU1dQ?=
 =?utf-8?B?Nm5KUHlRY2h6Y2srdi9iRzZ5cG5xRzNvanJTaEtiSjVSWHI2cmNlQjJ3WEpV?=
 =?utf-8?B?MExVOU9IYXdXM0hadUdDRFBpVmhGMUFLV1E5UnkzNThERE9JRmtRZ2pEUnJW?=
 =?utf-8?B?a3QwbVVMeUg1aXdDODBNSVZLMFdMdklMc09nTE5TSDN0Q1NKTlNmSDVVWkd6?=
 =?utf-8?B?M0wxdDNKeTRLdmh2dzZvWEN1RkJlcDllY1dqWHJRdERKWHd2MkhrV2JLcHVw?=
 =?utf-8?B?ZTJQVVRRR05EcEN1MGVQOEtFNktubTJ6bXREa0FwQlhIbkc3OWJKYktDd0xD?=
 =?utf-8?B?dDZnVGJ6V1BFWHU0d3lvL3RGYk05d2dkSDVKYzRXTFNjQWRVM0FEZDlNUUJ6?=
 =?utf-8?B?WFBqTVdZOTVuTUs3cHNjTE52UGd0UXg1M2NHZ25DRDJlQ29raWtTTlJuMThX?=
 =?utf-8?B?R3NBd1I1cDJwOEJJdjhIUURpRGtoenJreDBBeTNTZkNPSEdwZ25IczJ5WlJU?=
 =?utf-8?B?OVZmTmFuVWVUV0pTS2dJcEh3TmVnK204MzdlY0xjbXVkdWk1Z2sySjN1aDlp?=
 =?utf-8?B?MlJQbEkzYnhmaXFnRDVJREFrVTZVOEpzRU8zTWpYVGd5QjhsRnR4N0R6aXdh?=
 =?utf-8?B?ZU9iV1Y1Z3RpajcvdUMyQVVHNGZ6bExGMmpCbUoyQml5SGRXQUtscVc1c0pJ?=
 =?utf-8?B?aFFPaW9YY3NOa1ZNOEpzYlZXc29QTXR2SEI4Sy8wTFhlWlE3WTh1WCttakJ0?=
 =?utf-8?B?dFNrWUkxWnRPK2wvL3pVOCtwV2tEZ1pFU1pMVkxYTTJyWEplNi9zclIwYUpO?=
 =?utf-8?B?Qml1azgxQVRqNE1WZHlQZlhEOURydDJYaEFVclc5Tk5HbGw1R3VFVTU3NDBM?=
 =?utf-8?B?Y3pqTmVVb0tRS0pDUzZ1eWlxMU9VMWxXSC9ZYnNJZkFoVm1WaDhMYWh1eWg2?=
 =?utf-8?B?UGRwZFIyZ0VDb25rMWtaaXQwa1FZWEdHZmdvK0tMMEZQQUt0QkIwQWJoNUth?=
 =?utf-8?B?Nk9kT3JwUDB6cW5tS3lqKzI3d21NQ04rbEdFWHpseE5iTFRtMUZiZU40WDdL?=
 =?utf-8?B?NkFia0FHVFFVdVBpQ2I4ZGpGUFY0UUFaTE1ocmFKbUtJbmNZTVVyQTJ1MlVW?=
 =?utf-8?B?WVdsZk15aE9KUlRwbFczU2RGTmgxTFBJUmdmbnZvSFJ5UjZsNzVZdzFGOGQv?=
 =?utf-8?B?dGNCbzRRaXZrMEdyT2pjbkJYeTZFc05Cem1WUXZTeTlteTI0S0NkUDRzekhT?=
 =?utf-8?B?djR3bENvTzc2NlFBQlV4RWcrMlFaMEo5SndNbmM5aU9GQUhPenF6T1liei9n?=
 =?utf-8?B?V0t0WHN0cVBza0JRZVAvbVFsbXFYMVhSaUsvUnp5dnZocUN0S0IxM0wwZSta?=
 =?utf-8?B?eGJUcWtETmM0V0Y2QTRDTm55cTU5WFBVUE96MTRjNXRjNWZRdFBYMk5wc21J?=
 =?utf-8?B?cHZkb0JxUENXUy9zVHNFTG5QV05YMFNqRU9oLzVkMXZJV0o5MG9IUys4bXVV?=
 =?utf-8?B?aE50RVB6RWNJMTJiTmRSa3NIL1VUd3VCcUxzK3lqSnN3Q0QzMjQzK2FweU5S?=
 =?utf-8?B?akxCN05FUmczOWtrd1ZKWm9pYStSZWdzUjlSYUIxNHNLZ2dNSUtOZllYczJQ?=
 =?utf-8?B?MUNSZ20xd0ZLSjErRUVTQTZweW1vTzVkZ1Bhc1MxTXF4NjdBQUVHTnNHV2xE?=
 =?utf-8?B?VFZMY0s5T3UvMmJrT3FXMnRVSEY0bGtEekgyMVRLMm1kL0JmemVLc25FMU9k?=
 =?utf-8?B?MXQ3QmdLSnYrbFR4OEJHdWFKZ2IzWUppR1p1a2V5NlpkUk53NWVkQUExc3Fi?=
 =?utf-8?B?c01EOXFwNGFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:28:15.9987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ba7f13-88f2-4e6e-4381-08dd601a7866
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8251

Hi,

This series by Carolina adds mlx5 support for the setting of a parent to
devlink rate nodes.

By introducing a hierarchical level to scheduling nodes, these changes
allow for more granular control over bandwidth allocation and isolation
of Virtual Functions.

Function renaming for parent setting on leafs:
- net/mlx5: Rename devlink rate parent set function for leaf nodes

Add support for hierarchy level tracking:
- net/mlx5: Introduce hierarchy level tracking on scheduling nodes
- net/mlx5: Preserve rate settings when creating a rate node

Support setting parent for rate nodes:
- net/mlx5: Add support for setting parent of nodes

Regards,
Tariq

Carolina Jubran (4):
  net/mlx5: Rename devlink rate parent set function for leaf nodes
  net/mlx5: Introduce hierarchy level tracking on scheduling nodes
  net/mlx5: Preserve rate settings when creating a rate node
  net/mlx5: Add support for setting parent of nodes

 .../net/ethernet/mellanox/mlx5/core/devlink.c |   3 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 146 ++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |  12 +-
 3 files changed, 143 insertions(+), 18 deletions(-)


base-commit: 8ef890df4031121a94407c84659125cbccd3fdbe
-- 
2.31.1


