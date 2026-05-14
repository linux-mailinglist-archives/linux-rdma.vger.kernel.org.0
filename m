Return-Path: <linux-rdma+bounces-20680-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DXCD3qpBWppZgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20680-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 12:52:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C93AC540A0F
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 12:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAEDF304351E
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 10:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D647C3B0AF8;
	Thu, 14 May 2026 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AHQuuHa3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F33A3ACA43;
	Thu, 14 May 2026 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755807; cv=fail; b=CJBckZZuG9X4UNoxvcXB9+Km5l2EonZ1WNMQZkFTDrdaA5iQPJ4Zf2+zmE6Pp5WRphLp18NklYaH2ag+csDP64hThJfRLu6AYRGxTM9ZkJhMwQNMnEu5pP8Oa5cQIqFZotPDsAUHWxB4RrgJdsFCjAPMPlXh5YzKc0yRMCzhK1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755807; c=relaxed/simple;
	bh=DAZnOU1m4MAaGt8AgXWyCciI9y4QS4Qf4BOAplYNUvM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UIyxfoTA98Zw1fH5ziUExS1QgrSs0KvuiTHVILaSA46iiONkkuxsjMeueVihjI49yA/51CM+CRKEyvfmNTsQgfEIyvenjfNpYeXOSesnAztiS7DqHk8pP9wBQyDCJmX+7BnmPNCVz3CjI1fRZAk2rhkoaO6SnuuL8jnuEfiss9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AHQuuHa3; arc=fail smtp.client-ip=52.101.52.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbeJ4bD5FN/DugTRWqhbvVzb0Qo+K3q4lfrcOeSRehUQxutGlUI2p+EfXt3YE3c+pmMxVKWtfXiYpBtKX2J1YnGO3wh2935dkq2wnm/MRgTuNw/FQX7QgWjjrgd1Ho58FTG6BskxGq6fNHgQ+ArlJzijFnVy7DuqaPeB22bBSVhysbgYKDpJda3EM6zHhcgL51lHVcpJh5IhK0Zfq3SpO30sGksRg8iMH5Yiniw1jaKcO2DLjKzjtP+uolB+TLdX/EAUJmehZ5ISWPwm7B9BZNbD2BpFN0aguBC8+Rv/9ujioBzQijWCSwEL8SIMomkruR1eLJwrBSNFHkyiWsxOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ga8opip5zKYgjwHbxgyDa0PwDvPvM+2252S4uo8WOXc=;
 b=OF6mAbnAnK/E16cvEDKuzPse8pb/G0UakCWrvGDNtM4TBdj72x7e/iF7qpCTmG30fhczssiBOA89oCW2DPr0eoUForauqIRIJJIdoIuP+ud4x+aTcBbZGix838+G3OUQlm1Sn4JDYsHrRChxFBPlr3+zoZF3xrpuiL7YgIya3ePA8lrCkZPfVOdrSonPpiyffXGXIFcYF0ZYpyGBO25VJpVadmmNUXJPxVNcZ3geNoyJe2QEgSOyUT403PJULjXTnDgzj3aadSU3dLmeSKtWF1Y8Ux8XwuHq/95be62DBF6+a0qDhfReKnXbQT1/rD0XxpgU19DwgALbUWVqB1zDKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga8opip5zKYgjwHbxgyDa0PwDvPvM+2252S4uo8WOXc=;
 b=AHQuuHa3fqpdr8jKCjmEOY5NjoBlgMYthC49Vc/Ilrai2hB/uuanHhYp0qxqX2qMCapzH14c9su3bYflXw3CJu0Wx96PLXQyww2X+7EEwdIC59lGLA+COrFf6Cx2VxZSAVzRcT7yesytSJCrpcRV2v6p6J22Eu2UXbszBaqzge4MNfOdjLnGYAco7PFJmeuxYlZz+ElLnx+5DbofB6cd4BE5P88m09rR+IUfW0i2uLo/AQZ6T7GNKbuNT59RsOv7sxfowWKkXxamHAzG9XZbN7GnhUfQ7wHH1vGHl8hnZuQtvE7HsfGHZNCUK01AEdcM4zVCdqJmQGBjLQQB3Jg3aA==
Received: from SJ0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:33a::19)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.26; Thu, 14 May
 2026 10:50:00 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::1e) by SJ0PR03CA0014.outlook.office365.com
 (2603:10b6:a03:33a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Thu,
 14 May 2026 10:50:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 10:50:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 14 May
 2026 03:49:45 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 14 May
 2026 03:49:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 14
 May 2026 03:49:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 0/2] net/mlx5: frag buffer improvements
Date: Thu, 14 May 2026 13:49:23 +0300
Message-ID: <20260514104925.337570-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|SJ0PR12MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3c4959-af4e-4895-8975-08deb1a68bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	bYgvv6gTXim9XPFYL5/0t7pA+QCav8ZNmnHJpFaf6spki4rfJnwY18P4wdzWAfqpNi9IkyEtjM3JxnYZVr93q4BG1ixx7kqGXWXgPRHSu5T06JGRrdqsCAFG5Zy3N9MfAPWwZe94v5i+3z6RI4BBwMYkPy4k4ilpb5ddU8LvdqfHPWabkw+JRdmCrV3uF+V0JcSZBs+qg3cfmgXf+V90y/PBqwwQv23KEjFy9nilhvDdM0EKwtbQFCinvrb5xRpcAOCjACqNpxToEGGPuOUPde5gwo1VEU8NRbob2dlH4p43ZU6gSiGQFOI2DGjTst4rCloW/18jxDXkCck5k/jFi56b1KjhsjlYwvUKE5aNt94IsHLrseqnhFpny+f8HiL19Fry7wa04sY05k7Ofd9lMjmmMMyh5DS5I9+gSFrut8tuLpjB7MAYt2Su1iiRHyoURT6S/e7nTd9Kta+u4pp9nyubvGMqK6EYO1v2nvVdtun/P1V7tSRQrK0J6ZH+marLLUbH9crSIsPybp5/PnDvaZVOLUSWFu6C9+2Fq/TCaTebwb9IDep9LiwveB8frXv1duF/QHyGmAKSKS79E7vrlbvHsiWEL/m5zO3lsEpFR2c2aiAI+d7Y1iLVSjGWo7eyNN4nHQrxY0hdGoD30y4/CDJOHu8nsyJvAUHyxqokEnmHBQ0pupbB7mPMpGYDYR8tevjEFxiOD5cjHxbnLMmtWsBaA3I1O2uD7NAm2vcVM/M=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Dy7EJ5/3Ve5+v+ApjpWOluqVAM+G7JaImxlwJDKkLA9K3kZ7nUC1vNS9DbB4EGmd5KaqABzr+KiHp3Legh8VG2fp3yuueQsLkh38WsTaPuk6Nj/9rspZ7aQQHEE8g0JPbhBbNBXEJD4IbLBfQRdGi4dlkbk6b36qOUg1+DN/b4Qg/eOXmdHsWBXQ7ussr9wr7JFiOF64+Ox2GIImJ14ZvNLCMkd6dRgl1Nt7qzH1GBGd44c2RWEOs6ZC37VWYTL2iEUkxkm+h//A2/q5ioZHKn6Is60LMY79jMIFxsIQYSD6A2emmVkVSLnK82/2uoHGcHJr5iPhj6DSMZ8yAiUQppGhs6lX9NVBN759rF/Y5cdsof02zOe6swGneBhAmwO8DdJUjc7J1RvSr2xEA9UeKsSacyJrqqsICG0vF59cTzPWh3uRaI9g0Wgyjuc7dIon
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 10:50:00.0599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3c4959-af4e-4895-8975-08deb1a68bd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033
X-Rspamd-Queue-Id: C93AC540A0F
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20680-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Hi,

This series adds observability for mlx5 fragment buffer DMA pools and
improves the default NUMA placement policy for fragment buffer
allocations.

Patch 1 adds a debugfs interface exposing per-node DMA pool usage
statistics for mlx5_frag_buf allocations, helping with debugging and
visibility into pool utilization.

Patch 2 improves locality of default fragment buffer allocations by
using numa_mem_id() when no explicit NUMA node is requested, allowing
allocations to prefer the current CPU's local memory node.

Together, these changes improve both introspection and memory locality
behavior of mlx5 fragment buffer allocations.

Regards,
Tariq

Nimrod Oren (2):
  net/mlx5: use numa_mem_id() for default frag buf allocations
  net/mlx5: add debugfs stats for frag buf dma pools

 .../net/ethernet/mellanox/mlx5/core/alloc.c   | 88 ++++++++++++++++++-
 include/linux/mlx5/driver.h                   |  1 +
 2 files changed, 88 insertions(+), 1 deletion(-)


base-commit: 18dc8e6d15d7a30888beec46a1e01ca0f98508fa
-- 
2.44.0


