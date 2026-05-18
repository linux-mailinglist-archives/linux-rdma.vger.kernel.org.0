Return-Path: <linux-rdma+bounces-20877-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EL/fI4q8CmqF7AQAu9opvQ
	(envelope-from <linux-rdma+bounces-20877-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:15:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D78567451
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C0323026C1B
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 07:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C673128A3;
	Mon, 18 May 2026 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RE/iN2XA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012021.outbound.protection.outlook.com [40.93.195.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D593CAA53;
	Mon, 18 May 2026 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088517; cv=fail; b=P7sxqASmRzgA5vCvv9/QKeKY/bAdWmmHon4PyeVS1mZ91MrxzVWI3KJRi0Iqbj5IJyJkM5gwmPEvcFX8EEtokyiq56nK60Y5Vp8EwsbXR/1TEPwVeTRQj7FhDQYpJZ2yhGPQzhgh3zOkWmU2aXluxHE3XgpsCT7zxVdmhV6NVX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088517; c=relaxed/simple;
	bh=2cTsdsQ7XcO1LlvYRM4sniBHgxylnpvQw8nu8DuC9XQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DOG9r6mQm8zH9BGcHh8LLoW53EfaZpBU2VADtvS5NaZh/ZJFe8EnQBKjRNS52u8T75bCwS4fYX1FoZ4anj0q466YySTy0nPonT61+LD7vtRrjpEoQISMKP8iZloJVL2FNu0bg7fUaay/Tl7Cx7AlPLAQxVlA8MrRoVyXYUks+kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RE/iN2XA; arc=fail smtp.client-ip=40.93.195.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nB30bzoZHNCISlHBoT6V6f4wJBGrCcj8zUk6+RJHNZn2nslPvXXOKEYa3YDkKzFVREYfh7XBoZY85eI3sb70m+1cUXLTXD38OrpCIC1rnDf1UiO+btiZdkHiMG7EcamgygXqg7fJ5ilhZ/XRfDNY7Zhi5rFbZcVMngl0tQaaO5d9FIXZRB+MIVLGJlQ4tGKQjnSsovYUqNJ1XOvM9H1ivSSgGUwYZzwswCj/+kMMVp8YVy0s+dNm/R2IrMq0zHwNmCzBgRgbLi1dpiXXV8l8CEcNNN0ZnN2Foyzt8Gm0QSMj0vB+eUY4rpIwvyH+wFR4XR25eESVUUB68WhE4r9GsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rF37Rrizk8hqh7cpSlxqoAzms0JpXYL2n7sZVWvRzpg=;
 b=rMC4J0rF5wtDVVzmwAYpXMxoLJxMbtwfJhr8lEkwSYCrO0cHXbb+Hlque2dpU7OnYMYIzcINWZH/FRcnjoUgRL3n1McxUiF7YYGKICMaFOvk9JMhb/Faj5JzL1he+zCF5wtk98DDJWdOmHMV9xdqaHjY/xOUnMzWG9uxfeF0VJoRyvvDUzlfvXjjPi23oyO2YIxsH90aL9qUP1rgjBwsYIcneBqqsZannSxOhrPjE6ZVDd893dVbZNOm02psDxQt1DnJ3G28CUir/IvP1D5FJFxZ8vscmdOmOLrUWw7o+T6VrxWxyJkOD4VKGPsy/m9tzCf6HgHxjOaUfZfRFzscpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rF37Rrizk8hqh7cpSlxqoAzms0JpXYL2n7sZVWvRzpg=;
 b=RE/iN2XAQvqT4Mu8tnlROs1YfLlB7jwnoYoKTHGrIGS67IDjwYkjIVlsRHL97YssCOf/GVkEaPqivsBqqJPclzzAimxEG7FDq+r+Y1+LEWY/D1ntacpnKUfqmCbotTBtyXBR6X+e9EgW7DAaixkTRmAM7LDEqpsBjRDEC9oB5kLfm6pWsgqU5Ah6o5DMLAAfw5qXmvc4hM3TOgkqOF0+smJ10uBaHcXFuuQI8lng0Gf7jW0PGZpf0Mz6v4+XNfjlHnOr+jjyx1OCZ6GTZMi9jPQM58Xrr6sigr70JaFmsp40n7U8gCJWzUP+gUUZY94nKfLOXRgfa+Ne9YMPD0E/Yw==
Received: from DS7PR03CA0007.namprd03.prod.outlook.com (2603:10b6:5:3b8::12)
 by IA0PPFF4B476A86.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bea) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Mon, 18 May
 2026 07:15:11 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::fb) by DS7PR03CA0007.outlook.office365.com
 (2603:10b6:5:3b8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Mon,
 18 May 2026 07:15:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 07:15:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 00:15:00 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 18 May 2026 00:15:00 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 00:14:56 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 0/8] net/mlx5: Prepare eswitch infrastructure for satellite PF support
Date: Mon, 18 May 2026 10:13:48 +0300
Message-ID: <20260518071356.345723-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|IA0PPFF4B476A86:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef01f6c-d88f-494a-62ac-08deb4ad32de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700016|56012099003|18002099003|13003099007|11063799003;
X-Microsoft-Antispam-Message-Info:
	JVhcbrAwz+cndQ3NAi8CFrW9TnF8ey/VDfisoUbfPuqkGhq7iZADoPrYmsHigIsCUaujrF+GrQTSZopeVRq3fLow2eY06ioXMeN7XZpZyiQX/6XjNPO1iYNzhLRoh6mcciC6LCQ2jv5gOSKj9FbP98X5f7mBZv1ZVOYneAd4ssGflzG9NVSUBl8lupu7+D9HB2R+SXW5d7kmGInoTrBN2URTWz8Pr8WmMM7/L4TqnSNj66AVDmmhIsUn/56FmJzBBmKfYn+JgFRmZ6wJpjlxAJtmMqmvyVuMnkC2yMhLM27WL+RTeHfIQoMMl2xCmbDwumqP+CekIn+EAyxovHOmwKADLWerpqgtMu9AtHTBdU7V3leo7HlIO9ezVRBuJutgbGfXo9V9R02ludhWftMfv7UGhKSdTkh1gY6JvodwX74BILMQRYcawkijvnvmmre15jVU2soc5vwPxO0zmYz2KJE/RkeLLOPs1Ry0ZN91niOWSA2NOFfTVhvzDbVP+ElGEnJwJW5uWv0+Espp8gHomJC+0nIQ34DGSvgsEWSrEtjqBeOus87vzdcN6XsPh2sfWKgf9ciCmQRtb8+hr2uAyPSLx7eeV5VBzOlQLX91bx+yRudBPmqoj4tu62w88FDbd1TiUY8CRNzSFlQLMRvXg+frtSSr2zjnRUyxGB9lb2wyDhQnXSazOIueJt03VfIluJHsb79HTAQKe6kufGnsLLIOwcn2Z9oNmndCiDrWibk=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(18002099003)(13003099007)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0yqgBS0wfTE9LntWQmx6Ygk1Wv2jM3Ypc9I4AokDbZibH07h9wlYOOeM4Fku1tB06eCD7UGkBpRFmvVRg2QEAlKu1F1gXqD118xhjWY9QV4nY/KQJ/zn0OBXkBaQQ+AHNB2SoFNAi6qAUcSWksBtEauX1/0Jh4wORy/n11TJFvWhPtTMsNjMyuz/qehez98yDML5gioE3f5TEkeIyHpU4az93NOEZ5t9BvJnIW3GkH/u6HLZNdBofGbvNRbudg1cakq23T8YBOwI95X9f56uLEtuVHcHAe85OrO0TqhDsrJbed7y4uAhGHPhExkvwfDs25u4qkIkWmPNRJZgTVZVT39BKGMu1IHqPKNcrU3PgcYT6ywRfzbMVL7yo/r2tP4fpQw6iKBiWx3iGtq1EO6rkmX9Wj8j5boerE6L1jX+1LblUWdMHiTlcDKQRBlC8siD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:15:10.7502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef01f6c-d88f-494a-62ac-08deb4ad32de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFF4B476A86
X-Rspamd-Queue-Id: E8D78567451
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20877-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Hi,

See detailed description by Moshe below.

Regards,
Tariq

A satellite PF is a new SmartNIC configuration that adds another
physical function on the DPU that is not an eswitch manager and not a
page manager. The satellite PF can have its own SFs and can be passed
through to a VM on the DPU, providing an isolated function for users who
should not have access to the privileged ECPF. The ECPF handles the
satellite PF and the host PF in a similar way, using the same management
framework.

This series prepares the mlx5 eswitch command interface and vport
infrastructure for satellite PF support.

The first two patches abstract host PF data parsing behind a helper and
switch to the v1 response layout for query_esw_functions when supported,
so callers are insulated from layout differences.

The IPsec VF checks are tightened to use mlx5_eswitch_is_vf_vport()
instead of comparing against a specific vport number.

The remaining patches refactor SET_HCA_CAP and enable/disable_hca
command helpers to support vhca_id-based addressing, which is required
for managing functions that are not directly addressable by function_id.

A follow-up series will introduce satellite PF discovery and management
using this infrastructure.

V2:
- Add clarifications on vhca states of PFs.
- Add background on satellite PF feature.

V1:
https://lore.kernel.org/all/20260510053448.326823-1-tariqt@nvidia.com/

Moshe Shemesh (8):
  net/mlx5: Use helper to parse host PF info
  net/mlx5: Use v1 response layout for query_esw_functions
  net/mlx5: Use mlx5_eswitch_is_vf_vport() for IPsec VF checks
  net/mlx5: Switch vport HCA cap helpers to kvzalloc
  net/mlx5: Add mlx5_vport_set_other_func_general_cap macro
  net/mlx5: Refactor mlx5_set_msix_vec_count() SET_HCA_CAP
  net/mlx5: Use vport helper for IPsec eswitch set caps
  net/mlx5: Generalize enable/disable HCA for any PF vport

 .../net/ethernet/mellanox/mlx5/core/ecpf.c    |  24 ++-
 .../net/ethernet/mellanox/mlx5/core/ecpf.h    |   4 +-
 .../ethernet/mellanox/mlx5/core/esw/ipsec.c   |  83 +++------
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 157 +++++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  16 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     |  38 ++---
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |   6 +
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c |  27 +--
 .../net/ethernet/mellanox/mlx5/core/sriov.c   |   8 +-
 .../net/ethernet/mellanox/mlx5/core/vport.c   |  12 +-
 10 files changed, 227 insertions(+), 148 deletions(-)


base-commit: 627ac78f2741e2ebd2225e2e953b6964a8a9182f
-- 
2.44.0


