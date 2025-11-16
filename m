Return-Path: <linux-rdma+bounces-14504-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF25C61B5C
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 20:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F113C4E183C
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 19:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE86C26C38C;
	Sun, 16 Nov 2025 19:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rDfEBoGg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012042.outbound.protection.outlook.com [40.93.195.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DCE264634;
	Sun, 16 Nov 2025 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763320349; cv=fail; b=GCt+yVYQh/xuRwyFH2whs08UhZr82fNWOPJo3k6Zw+RXm6gBfbwhSUrqLnirhF6Nmt/+xuvtrqQof4Fp7dq4A3U/zOOQ7gFQrEXq6kdXJ1doXrjnPDgiSslkAWFBDHD6djCdaXfZgSGMUx5THeveLX8CNQP4g+dFY7J+g4CmpIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763320349; c=relaxed/simple;
	bh=uqQn5skiwK+NHlOtgIkSsd+mzFGbjV6ymkSupmlMpnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=e7IFSoZbhCL+QAu6t9ox8f+B1VZITX5Cysp8gUbSmMgm0Baejy+cNH/Eko2QMNRdClCFbI0eUa6a8zSfnVFAIYxl2U3nMLGAOypKPbsSC7z5kwRWz7009baYpY+jJg5GYy7K+Q2TngUmY3XJU7XbWnHCKYUd+VG5xCioIDmcA2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rDfEBoGg; arc=fail smtp.client-ip=40.93.195.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsgfLqIm88w5tls7FqO9Gb81HPDNm4W+n51LPDuQE7dhyzuWIpTVoqjRwzjgAjN1niuxZj2GG8mZ605Tv8nErcOc19Y6ujQZKL40/q+u8g+ntiFt8mPxg1O8g/tAEd3fBvJ0+LmpXTRaSf66Qkj52N/90+IISpFMi+TV1UDq5XlB66pXMdEGkYxu8kTNF2D3wLpV1/v44OneAtqJio5CokjLtECFAGNTJfyFdxVemdGJlYbbfp30JHYTOuV2bH3dB6fE8+WpRe8qJNfaQhrMj7m52q625b5TTBzppyVK6WOXlAfcNLSk+QtM3L5VNuFvD+SK65yc9wOrE2zlN2rZRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlI34x+acXNRGhdY/GLmDU280njjFMJCfME6J+57OCw=;
 b=hoNy0orPwlje6/i4n67hHksUMcQdDmdxRis4vqkuIvt4OBD+XkfiPWCffM5DYY3g1M+waGd6TAmhhgAAIg/DAN1Cmr15NrLLoHSmM2LuXFDusWWOMXJjxHHX9RYI6b1tY2rB8ovZI7+En+iBC/r5REOKfFIUr3gdaNa9BDg6NteP7QZY4RyZCQDy3th6Kr7+pPu/02HY9UOFW+tq+aGGNrVBDB6WEtk0nTWXLR+EdgKppfnmt8AdWAFM33QhfS0wgsxQl/UI3uC/mOaKaytpH/LpRW/EdXBCxR5h2Kexr92qxXoByfHuu1Q8W+d50NjkQhzbgNUbtgrQZXpEfip88Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlI34x+acXNRGhdY/GLmDU280njjFMJCfME6J+57OCw=;
 b=rDfEBoGgeKVWPYe6RQo6CU6Mqxir6ks6GUqrfitetge0owK/UKBemQqqkOdPCP8GUSdz4DiB7OH4BqLCg3pXebEv122qaHmyrC4TItAiJdo6Dm3R7ifidPL6GBmoG/K059LGBrNLw7jbah89OHEYDT8Oke22KytRbjlFXG+VUIMF97TCgp3dwZhR0rZl4ubgCgOZ5u+dq+c9zDHKDAavz94KgAxO1Un6sy8ku3TMFxF1+l/xDs8CfjrvC4M0uB4B8OSj20NSdTA8yJGJ7c6+DQujsePKtU3U5Vu65lVHxCc2tslR7+xq7G4TgvpJCR3gN21swg9bvnbgaNJNBTYskQ==
Received: from BN0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:408:e6::33)
 by DM3PR12MB9390.namprd12.prod.outlook.com (2603:10b6:0:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Sun, 16 Nov
 2025 19:12:22 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:e6:cafe::54) by BN0PR03CA0028.outlook.office365.com
 (2603:10b6:408:e6::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.20 via Frontend Transport; Sun,
 16 Nov 2025 19:12:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Sun, 16 Nov 2025 19:12:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 11:12:11 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 16 Nov 2025 11:12:11 -0800
Received: from c-237-169-180-182.mtl.labs.mlnx (10.127.8.13) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Sun, 16 Nov 2025 11:12:06 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 16 Nov 2025 21:10:28 +0200
Subject: [PATCH rdma-next 7/9] RDMA/nldev: Add command to get FRMR pools
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251116-frmr_pools-v1-7-5eb3c8f5c9c4@nvidia.com>
References: <20251116-frmr_pools-v1-0-5eb3c8f5c9c4@nvidia.com>
In-Reply-To: <20251116-frmr_pools-v1-0-5eb3c8f5c9c4@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763320291; l=9894;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=d8fzqTLM74WjuysCnKadxQhfGJH3QGyAqw4/JcNtRSE=;
 b=tStZgbiQomqcayRTesSwaaG3JXn73dUOewpmTooUCwoK82FZyOBxLAXtOcBu6mycjG6n2MwQ4
 /hJPun2knovD9/FfC31Fve8ybK1e5Ndti0YM5BQLxeTKW4E3g5E/dkO
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|DM3PR12MB9390:EE_
X-MS-Office365-Filtering-Correlation-Id: e608a44d-1602-42ad-d69a-08de2544121f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXk1ZlFoWnhsVXE4eGNFSEwybm1UcU9PMlpxK0FRTzE0SkRCMjRqaStpVWlD?=
 =?utf-8?B?dGNvajBsbGc4R25vUGtLdWZJZWN4UDdXMFpUa0tvdFk0YXpMK3l0TjNsWk8r?=
 =?utf-8?B?bkU5Ryt6aXcwd3VoNUdmenVkcENXWFJTMW9SdGF2Z1NUTzhXWVZvS2ZwQ2Y5?=
 =?utf-8?B?QVNmdmhBZkxQdmRwK0Y0bURYck9mb2FCY3R1ZmhJVHNOUnQ1K1RoUm50R0Zp?=
 =?utf-8?B?Vm9KVktmMzI5QStLL1p4SHNkRWFrR3ZyWUJjT05qZ1BJL0ZPVDE3Tno4NzVw?=
 =?utf-8?B?WDZ4Q01rSkhVWnRodWYzdCs2YzFhQWhmMGdsUDcxTWRpU0dFc3lqN094QVc2?=
 =?utf-8?B?MjFpeW1ZZHQ3aHNKY1gvUWZIQUtWWUVBTWNabHlQditqQUZJTzd6STM3K1pR?=
 =?utf-8?B?RWhad1k3RUtCR2J4UmdkNEh1bGZvSjFDWFVsY3NaWmNjTVpMRnFhcC85N1Mv?=
 =?utf-8?B?VjYyVzhRdU5OZmNmWmZzTlR5aTkzSGR4cEErQWpjcVpHVmtRb0x0WlgzelVs?=
 =?utf-8?B?RE0vc1JjQUwwMkJpZjZMNFBaMUpQcnUyTTUvUzg3cXFHdjFERWpkY1RxM0lv?=
 =?utf-8?B?SGlUN004Y3JKMFdHczlUUGlSUDJGamZpQkVkeDV0cTRWczdYS3lJazZqZFIw?=
 =?utf-8?B?ci9DMTRaZ2FNVmRkZFJremJITVl0Y1M5dlVNaTFtSzdPU1JsUHdQZmhuM290?=
 =?utf-8?B?czBpVEFUKzRVKzIyeVk5UWtyQ0kzaTZaTklZU1JzdFBBQ0ZQY0d3eXhFNnEr?=
 =?utf-8?B?cEUyMldRck8xekpVOGhQN1hNZGNObGFtSEI4cGgwL09DK0VkTWIxN2szWG9s?=
 =?utf-8?B?UzRJamk0bytjamlzbEJWeXpaQm1XeE9EY1ZpOG5DYzlKejB5ZGwrajRrV2xD?=
 =?utf-8?B?cXJqamM2TzI3NVVFOEoyOCt4ZytzbmNSbXhmeVEvQXVPVUMva3MvSGl5bGpI?=
 =?utf-8?B?SW45eGVWMTVaSStrRlFtUkx4NWpuS2tCbndmVkpsQUhJS2VjQlVnSHhOckk5?=
 =?utf-8?B?bGdGakhid2pEM0M2TFZpNWxIVjE5TXZQcXVHZEEwZjVaTjVDelF4emJZYk1H?=
 =?utf-8?B?Rk8yZ3RJRDVZWjZKRmYvREsyWDRZZzA2UDRLNnVQWThjcWlCS2p3OW9hWklh?=
 =?utf-8?B?aE12bzI4L25GV1JEK1FBYXp5ZVBSWEdBcjlybEROQnZ2RDI5UEdISExTbTlm?=
 =?utf-8?B?d1kraUNkVVoyVnlGbXF1eEhJL3owRGJadWpiVkJ4dllqMWcwTFFPU1dzWHFT?=
 =?utf-8?B?S1E0Y3cxc2FjMXp5TERQQzhaWGR1Qnd6dzB5VWcwS05iWVRmNmRtRTJkVVVX?=
 =?utf-8?B?VVIxclZGaytRS3UyZVdXZVBJZFdYQnRMUXdOMTZkSHdhSFFqVXRMb0F0bzNG?=
 =?utf-8?B?bkxlNFpXRkhVNGhiczZvWVdxNy91VkNQQ252eEpnckpSWjVkNVoyZ0hWR1NY?=
 =?utf-8?B?N2tDelhXYm5aR0dDNmxJWEVmN2h2b2ZNR0dFV1BZdHNCdWxCK2Vvc0FpQU5n?=
 =?utf-8?B?ZVJwQ1lTYmhBTEZLWGdEM2NjdExETzdaNFh1QkdMTHJ2c0t6NGlBVG5zcy9i?=
 =?utf-8?B?ZUhub0MwNkdTUVFvZkR5VlJQUEN3N0tLejJFUlZlQ1VxbWd6RzZiNWpEbHJ6?=
 =?utf-8?B?M0xROTVCNU1aV3dNZ2ovbzhFQWRrZ0p2MFVUcEEwYytERVBRZ3dYdzdQS1Yx?=
 =?utf-8?B?b1Q4WWdkS1doUHg2NktCbVh4MWsyd2M4bU51YTI5V0hDSXV1S1RLbWtpR0pL?=
 =?utf-8?B?c3BlcHFUVllhTE1iaE0vRzQrUzlpbzQ3WERwOTM0NS9oZFRWcmEzRG9RVkZD?=
 =?utf-8?B?MmYweWxrUHc3WHpXSjcvV2lPRXlxdTd4T24vbVJhU21teHRnOEpEQ21rdWQ2?=
 =?utf-8?B?enRwTVdOK1RaSFFVWm1IQzZMdDFHUGkvNU1KamtUYk93bnJMeUo0aEdxcUx1?=
 =?utf-8?B?Qjdob21zcDJsUm9Ld0RoQTlmZGJ6MTJUL0J0bTI0dEJyWFNuN2hDUExmWExn?=
 =?utf-8?B?cFVWVEZIQm9Celkxd09hYUpzUnczbGZLZUtBS0o4dDVFUjFadUgrMHltQmRM?=
 =?utf-8?B?OGhYRDdsdjE1UmcvTUJUK1Rlc3U4NTl4NHoyQT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 19:12:22.3529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e608a44d-1602-42ad-d69a-08de2544121f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9390

From: Michael Guralnik <michaelgur@nvidia.com>

Add support for a new command in netlink to dump to user the state of
the FRMR pools on the devices.
Expose each pool with its key and the usage statistics for it.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/nldev.c  | 254 +++++++++++++++++++++++++++++++++++++++
 include/uapi/rdma/rdma_netlink.h |  17 +++
 2 files changed, 271 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 2220a2dfab240eaef2eb64d8e45cb221dfa25614..6cdf6073fdf9c51ee291a63bb86ac690b094aa9f 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -37,11 +37,13 @@
 #include <net/netlink.h>
 #include <rdma/rdma_cm.h>
 #include <rdma/rdma_netlink.h>
+#include <rdma/frmr_pools.h>
 
 #include "core_priv.h"
 #include "cma_priv.h"
 #include "restrack.h"
 #include "uverbs.h"
+#include "frmr_pools.h"
 
 /*
  * This determines whether a non-privileged user is allowed to specify a
@@ -172,6 +174,16 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_NAME_ASSIGN_TYPE]	= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_EVENT_TYPE]		= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED] = { .type = NLA_U8 },
+	[RDMA_NLDEV_ATTR_FRMR_POOLS]		= { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_ENTRY]	= { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY]		= { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS]	= { .type = NLA_U8 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS] = { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY] = { .type = NLA_U64 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS] = { .type = NLA_U64 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES] = { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE]	= { .type = NLA_U64 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE]	= { .type = NLA_U64 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -2637,6 +2649,244 @@ static int nldev_deldev(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return ib_del_sub_device_and_put(device);
 }
 
+static int fill_frmr_pool_key(struct sk_buff *msg, struct ib_frmr_key *key)
+{
+	struct nlattr *key_attr;
+
+	key_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_FRMR_POOL_KEY);
+	if (!key_attr)
+		return -EMSGSIZE;
+
+	if (nla_put_u8(msg, RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS, key->ats))
+		goto err;
+	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS,
+			key->access_flags))
+		goto err;
+	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY,
+			      key->vendor_key, RDMA_NLDEV_ATTR_PAD))
+		goto err;
+	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS,
+			      key->num_dma_blocks, RDMA_NLDEV_ATTR_PAD))
+		goto err;
+
+	nla_nest_end(msg, key_attr);
+	return 0;
+
+err:
+	return -EMSGSIZE;
+}
+
+static int fill_frmr_pool_entry(struct sk_buff *msg, struct ib_frmr_pool *pool)
+{
+	if (fill_frmr_pool_key(msg, &pool->key))
+		return -EMSGSIZE;
+
+	spin_lock(&pool->lock);
+	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES,
+			pool->queue.ci + pool->inactive_queue.ci))
+		goto err_unlock;
+	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE,
+			      pool->max_in_use, RDMA_NLDEV_ATTR_PAD))
+		goto err_unlock;
+	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,
+			      pool->in_use, RDMA_NLDEV_ATTR_PAD))
+		goto err_unlock;
+	spin_unlock(&pool->lock);
+
+	return 0;
+
+err_unlock:
+	spin_unlock(&pool->lock);
+	return -EMSGSIZE;
+}
+
+static int fill_frmr_pools_info(struct sk_buff *msg, struct ib_device *device)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	struct ib_frmr_pool *pool;
+	struct nlattr *table_attr;
+	struct rb_node *node;
+
+	if (!pools)
+		return 0;
+
+	read_lock(&pools->rb_lock);
+	if (RB_EMPTY_ROOT(&pools->rb_root)) {
+		read_unlock(&pools->rb_lock);
+		return 0;
+	}
+	read_unlock(&pools->rb_lock);
+
+	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_FRMR_POOLS);
+	if (!table_attr)
+		return -EMSGSIZE;
+
+	read_lock(&pools->rb_lock);
+	for (node = rb_first(&pools->rb_root); node; node = rb_next(node)) {
+		pool = rb_entry(node, struct ib_frmr_pool, node);
+		if (fill_frmr_pool_entry(msg, pool))
+			goto err;
+	}
+	read_unlock(&pools->rb_lock);
+
+	nla_nest_end(msg, table_attr);
+	return 0;
+
+err:
+	read_unlock(&pools->rb_lock);
+	nla_nest_cancel(msg, table_attr);
+	return -EMSGSIZE;
+}
+
+static int nldev_frmr_pools_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
+				     struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
+	struct ib_device *device;
+	struct sk_buff *msg;
+	u32 index;
+	int ret;
+
+	ret = __nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1, nldev_policy,
+			    NL_VALIDATE_LIBERAL, extack);
+	if (ret || !tb[RDMA_NLDEV_ATTR_DEV_INDEX])
+		return -EINVAL;
+
+	index = nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
+	device = ib_device_get_by_index(sock_net(skb->sk), index);
+	if (!device)
+		return -EINVAL;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
+			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
+					 RDMA_NLDEV_CMD_FRMR_POOLS_GET),
+			0, 0);
+	if (!nlh || fill_nldev_handle(msg, device)) {
+		ret = -EMSGSIZE;
+		goto err_free;
+	}
+
+	ret = fill_frmr_pools_info(msg, device);
+	if (ret)
+		goto err_free;
+
+	nlmsg_end(msg, nlh);
+	ib_device_put(device);
+
+	return rdma_nl_unicast(sock_net(skb->sk), msg, NETLINK_CB(skb).portid);
+
+err_free:
+	nlmsg_free(msg);
+err:
+	ib_device_put(device);
+	return ret;
+}
+
+static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
+				       struct netlink_callback *cb)
+{
+	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
+	struct ib_frmr_pools *pools;
+	int err, ret = 0, idx = 0;
+	struct ib_frmr_pool *pool;
+	struct nlattr *table_attr;
+	struct nlattr *entry_attr;
+	struct ib_device *device;
+	int start = cb->args[0];
+	struct rb_node *node;
+	struct nlmsghdr *nlh;
+	bool filled = false;
+
+	err = __nlmsg_parse(cb->nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
+			    nldev_policy, NL_VALIDATE_LIBERAL, NULL);
+	if (err || !tb[RDMA_NLDEV_ATTR_DEV_INDEX])
+		return -EINVAL;
+
+	device = ib_device_get_by_index(
+		sock_net(skb->sk), nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]));
+	if (!device)
+		return -EINVAL;
+
+	pools = device->frmr_pools;
+	if (!pools) {
+		ib_device_put(device);
+		return 0;
+	}
+
+	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
+					 RDMA_NLDEV_CMD_FRMR_POOLS_GET),
+			0, NLM_F_MULTI);
+
+	if (!nlh || fill_nldev_handle(skb, device)) {
+		ret = -EMSGSIZE;
+		goto err;
+	}
+
+	table_attr = nla_nest_start_noflag(skb, RDMA_NLDEV_ATTR_FRMR_POOLS);
+	if (!table_attr) {
+		ret = -EMSGSIZE;
+		goto err;
+	}
+
+	read_lock(&pools->rb_lock);
+	for (node = rb_first(&pools->rb_root); node; node = rb_next(node)) {
+		pool = rb_entry(node, struct ib_frmr_pool, node);
+		if (pool->key.kernel_vendor_key)
+			continue;
+
+		if (idx < start) {
+			idx++;
+			continue;
+		}
+
+		filled = true;
+
+		entry_attr = nla_nest_start_noflag(
+			skb, RDMA_NLDEV_ATTR_FRMR_POOL_ENTRY);
+		if (!entry_attr) {
+			ret = -EMSGSIZE;
+			goto end_msg;
+		}
+
+		if (fill_frmr_pool_entry(skb, pool)) {
+			nla_nest_cancel(skb, entry_attr);
+			ret = -EMSGSIZE;
+			goto end_msg;
+		}
+
+		nla_nest_end(skb, entry_attr);
+		idx++;
+	}
+end_msg:
+	read_unlock(&pools->rb_lock);
+
+	nla_nest_end(skb, table_attr);
+	nlmsg_end(skb, nlh);
+	cb->args[0] = idx;
+
+	/*
+	 * No more entries to fill, cancel the message and
+	 * return 0 to mark end of dumpit.
+	 */
+	if (!filled)
+		goto err;
+
+	ib_device_put(device);
+	return skb->len;
+
+err:
+	nlmsg_cancel(skb, nlh);
+	ib_device_put(device);
+	return ret;
+}
+
 static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 	[RDMA_NLDEV_CMD_GET] = {
 		.doit = nldev_get_doit,
@@ -2743,6 +2993,10 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 		.doit = nldev_deldev,
 		.flags = RDMA_NL_ADMIN_PERM,
 	},
+	[RDMA_NLDEV_CMD_FRMR_POOLS_GET] = {
+		.doit = nldev_frmr_pools_get_doit,
+		.dump = nldev_frmr_pools_get_dumpit,
+	},
 };
 
 static int fill_mon_netdev_rename(struct sk_buff *msg,
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index f41f0228fcd0e0b74e74b4d87611546b00f799a1..8f17ffe0190cb86131109209c45caec155ab36da 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -308,6 +308,8 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_MONITOR,
 
+	RDMA_NLDEV_CMD_FRMR_POOLS_GET, /* can dump */
+
 	RDMA_NLDEV_NUM_OPS
 };
 
@@ -582,6 +584,21 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_SYS_ATTR_MONITOR_MODE,	/* u8 */
 
 	RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED,	/* u8 */
+
+	/*
+	 * FRMR Pools attributes
+	 */
+	RDMA_NLDEV_ATTR_FRMR_POOLS,		/* nested table */
+	RDMA_NLDEV_ATTR_FRMR_POOL_ENTRY,	/* nested table */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY,		/* nested table */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS,	/* u8 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,	/* u64 */
+
 	/*
 	 * Always the end
 	 */

-- 
2.47.1


