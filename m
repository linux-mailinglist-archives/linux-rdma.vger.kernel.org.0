Return-Path: <linux-rdma+bounces-18802-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KENlEdLRymnZAQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18802-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 21:41:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AF13608D8
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 21:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC7BC3076371
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 19:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1438739A05F;
	Mon, 30 Mar 2026 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qDVnkHw4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011030.outbound.protection.outlook.com [52.101.57.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4EC824A3;
	Mon, 30 Mar 2026 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899341; cv=fail; b=jmmPrOvC3ocg1BCx4Vw4uUxTW+WVCJ/1ymQyLa9EAQA3nrQSELgwZUcoQZSnB0j4h7A1YEaSkKd+Z1sf2cF3dUpSfGXB/yVCWzQDYmcCU8AhIHWUcfre1xE7PZ9WrdWz/yMc3DbLFlan2m77r4ON6vmLU7NN84e35YlcHP6+SGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899341; c=relaxed/simple;
	bh=21EuWInpqsLIKs4K1DBHICODqzkUISpFAJCL0lQQCdg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cL29H/wY3kAM5ksNak54xfddcn/Bf7FakG42IEIrYGHuz/z70yXeOe3ZJJMPCLQGScVw+yAQB+BZWdwvW3cbJh8KGy8TaqmvXqeHfqT/bZlQfzdVu4xJfeDl4qadlnZpGpB9smqqYFWCnrvtJZhEpjJr9eVYMV6tSArlRxuKmjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qDVnkHw4; arc=fail smtp.client-ip=52.101.57.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKs2LiACVzItXyoG9Wd/8OgRATlnxBEb/d+gs+Qknn6+MjC+iIEGA8dXnM6dYY8KVxeEwnZaFmo4zhHWnjP038fKc9K0ds3RiewFbSleTcTZcRSlu1C3sLDVVXha3Kfo7dpQ4Lksj8+5i4DMk89cEy9IVKZP72q3VJobp3/d/4tWplzxX8/gElmZPva/n/MapPrtLArY7QvejwAYp4K1pb1jihei5Xy1lEY/kL4QWOK3Dr4hEk44bUjZCk0M4h+LMn3Aas6xv8soT6uC4CV9ZblcrRtzwkvsoRQ5Xv+ZI1djhulxZQ7Su0y8LnWmxd/KzY9rMh4L8Y+ifVK+J5qH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AGtQDBIv3pczNqEKOqse2Xcqs9yJP8cXime15PDZRc=;
 b=Zs7n+cVIdQcKkFxg/Ia5bw9y+MseOPQAmGIRv0fvcURRciguQA8Kxt1ReyOr2xfxLaYNdyx0H3OdRTiFT/bTO9l6P2TMBuwehLX8anDtBVCOOifNNN4iK2LB7Zj1tUOHxsU5WwbxXUYEwi4V0T5q2iNOyvZ9qm+GD3A8V1P2TUfIOO2cOpNTR5RTBOD3O1qlrtcajEzNqtqOxJJFVoozE7lOgJR8HGJxIGT4gYdCtt7CiOId2nMDKTF+1c0oXOiuiK7aTsa4vRVJIb8RruLUgvMV9bFRYdzKec7v1uq6N0OMdvfdFHOv6zEAnSlQYiYzbEHx52ecg5buPZdB9nHIMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AGtQDBIv3pczNqEKOqse2Xcqs9yJP8cXime15PDZRc=;
 b=qDVnkHw43LeOE2gVv+7IrpFT2+Neqk9FVWZXdn266Cq1xkLg8+EWGJyQr+sVdMTPDyeawo+Hd4udpKFA2NpK3++hmwkVvfJ8TPff5gLNuOvFyhmvAcETo84zknz92Z3uLQXhtWvyOl/2gy7JVcQKAl32AfeKMdrp2uyDXj8HCuS1tvyCP/WpO8HLSj5WKAs3fAb6LNG8y8r56y8tQhsOoRsP+Bsl+Ntulk8Yd9yW/+dbRflxu81Y9sVfOaRqxEmheuq9R5KPk9lfFNMXd3/VSXyamliLBbK+vxQWy2ato5lH6pHLlQUNbqtocOYKxIpFLufFe8t2EfJkty2tD9koZw==
Received: from SJ0PR03CA0066.namprd03.prod.outlook.com (2603:10b6:a03:331::11)
 by SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 19:35:34 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::42) by SJ0PR03CA0066.outlook.office365.com
 (2603:10b6:a03:331::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 19:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 19:35:34 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 12:35:14 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 12:35:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 30
 Mar 2026 12:35:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shay
 Drory <shayd@nvidia.com>, Simon Horman <horms@kernel.org>, Kees Cook
	<kees@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 0/3] net/mlx5: Fixes for Socket-Direct
Date: Mon, 30 Mar 2026 22:34:09 +0300
Message-ID: <20260330193412.53408-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|SA1PR12MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb9aca7-e267-4665-497c-08de8e938315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	faxjlwdQLN6WzDxynXAshgtvckc9GyOCXpxEU9K8PcLQ4cbiqYDM0OwEg4AF5K5z15Y41bCVMKKGD5ZEo6428ZzkHcGu6s2E3Pn4kj38lRx2I9q8vqVINu7gTDOmBB5IGNHdnEIfenMj938F9NpQAPywbwk8L0RSgO6MbY5VuQ8bqaJAiMFEA9hAr1osxd4OrdxnvSPiU3Apg0KdK9gWyM82Rx2ETeKuj0L7jtwibq7WCNsM82Aup5hw0NIgdEuqXDJRC/dxg1chXfjZl+thjF43/brTK/4tYfcRQ7SMkxwN9lwXw7kuHY1f1n2/L5ZDAik8rgUpK+V+010qArDUVBp2ClVybQYi486QGkA4s0IRZGKEzOjYGJA2Q7+catwUKhkDdBjxfrqVXWw73X3T1a5fsIgsn/mzqJ+b/GuWi4YGRf8jJA7exrBvQGYS79cSES1lPLZJctDd4I3oL12R3Vj78pcefW1eEcOGIYoabXNGN0CIgV/gAkAtMtGPTIoYj5YyLwPUCRI08YMsM48VSVl+lr+LR8c2Xb+lMdl/T9LJD8SnBxqzIXMrZMoBluQqWH3638zwtyezHoeAA/WRfjNVZwT9Xfx65YNbXQCUDOo8Tf7pRPgzv3E7AoAdxmobRCmDsspbcM57pvlmv3yMa0jnG0zNVno1TByQQqZUz5794Ypp9RgDzUYbhHeru2LcSMUqEUHAYnH4B5Ozs8M7jeGChWrDHOttuUFYtbSLSkPH6htoDS6rcfoUpsflAzIU0R5gTfj1VfOaGDiyqBpUEA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DM9B0LCqoGkCuSsu7h9ujjIjLBQg6n9N5Rs7tXPE5LqbDDuyWWvPuGUjIHwK+HMLgqcqsIlPXQ1yB8aNDH9uvi/lIVWUeXYvdKGZpqV4GC5mdRo/g/d++bH7sbEVzK3Pi3NsQ3yY+pYNprDwQI3a9D5nQ/QpugPWQvHNTRvPZETLgMQ2nLPfk9Uy3La5UjwX5deAuVmrlwbmd9ZEXq+uKfKW0iLYFTYYsWNBQcWuVCjGJm7wD0uZ6gSnWoSGm0fnyMM9aP04CwFbOTQ+LidqmgZaE3VJbgwVuadbTF43vSXgk7eVtg6wdygu8sSZnxpwVuwDtMpAQ45iWYxGpqsIOLi300OAlL4/kU/Ns1uaeOP4lDIU5VdFYIAChuc7AmZXTbzLkkax2OtaoprwWMMLufS2jEvkZ7XqyZRf2+Rhj5PsgvikFO++BQ7iBSPnvoHE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 19:35:34.3303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb9aca7-e267-4665-497c-08de8e938315
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18802-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 95AF13608D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series by Shay addresses issues in the Socket Direct (SD) layer.
It includes adding proper locking for auxiliary device access, fixing
a debugfs dentry mismatch in multi-PF setups, and serializing SD
init/cleanup using devcom locks.

Regards,
Tariq

Shay Drory (3):
  net/mlx5e: SD, Fix race condition in secondary device probe/remove
  net/mlx5: SD, Keep multi-pf debugfs entries on primary
  net/mlx5: SD: Serialize init/cleanup

 .../net/ethernet/mellanox/mlx5/core/en_main.c | 18 ++++--
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 64 ++++++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h  |  2 +
 3 files changed, 71 insertions(+), 13 deletions(-)


base-commit: d9c2a509c96378d77435e5845561c4afd3eaedad
-- 
2.44.0


