Return-Path: <linux-rdma+bounces-19279-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOvjL1rL3GmcWQkAu9opvQ
	(envelope-from <linux-rdma+bounces-19279-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 12:54:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C72063EAED6
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 12:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABAB93004D95
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 10:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE3D3BB9F5;
	Mon, 13 Apr 2026 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CMXe39VO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010071.outbound.protection.outlook.com [52.101.56.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE37392C5A;
	Mon, 13 Apr 2026 10:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077652; cv=fail; b=Y7NKwExxKZIINI9NdeJ9C8Yn3twpU98QMGJnSJlwrp1CLRnfmrNutKONFQc4XIP5Tar9XT/qvoVgx4pFj7H0SEVk37Y1M/QRHzCt8OUTU42YLn8aQMTod6vKJT45CzAOt1bxAbHeG5grNM9x8XNEz7xt5BgfjZWPPOlQn5MyoKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077652; c=relaxed/simple;
	bh=mZ8qECvNjDcSWOrvAK2oR9Z2oM9cAD284q58RgIAQ2o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JJkYgnultjThy6/Wva/L3NXC5XganDIPd82WUIdnPBF9SOexboAizDCQNeBjBHNuX8/D3ZjVB8rOZ1ai8KQ0SoEIDiVg/veoxffV1hMevhOyOxxBgp0MTkqOK25+OwMwFtehD2KhUJwgXwL/oPuUufQdczNzg8TLuqXL+XPMmlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CMXe39VO; arc=fail smtp.client-ip=52.101.56.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOadEEPczaaaJeWZPu1oK2hg9w1C8Lj4aE/Y1Sfrgogg4ibLUH8UUjwz4s1dt6gxHy2gmpL2amnm5svxkQ9PFPXsM2H4pDPSMFWdqL64ku70AKcF2vkf8uCEyhzMZ19LdtYe05WPaoKN5q6DI6BHEtVCYNh90F6/2sMoV327ji+Q30f2AqtKF7ElpFBfepuxL9DiXXyMMKP+LFJhE+iLcoVvTR/RTNxnA5daLtR0ecC+RWy4X3Dm2iUqAdXr2rYkhVwOG7/1JEZjG4oEzypnaklesV27WDJjT5SZKK2H0np+Ki8ONZ2y15eEKdugXvb8NNLIgLxZnw0s8LU5dMvItg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWqHgC/8p9mLsPv+tc+P6uZgSbev3ESY/WbkBKEfK04=;
 b=BHvNSKUnf7u82OYv0QrWb7Yr++xrYDZ0zPXmLWaGHYYyVm85uxbotm1hdKJjWKA5tW+1ng8RbHl1KDwK9QswUbRH+AWa1ndbcidTrql+TRttpOj2RpCAO3cu+kOGtiAUnpAWn891byYAWlx+Aa5Vhc4TQSYnWM+9vtNYHd9daP/Kyq3+w84GklrDmQ9JvEnkOOGC3AwxPAWRYq1vTaoVGqxwHsHXkdaTtuavvwjrYRzOXf1E+25vq6UNR4m4rHLa9Uj+0LKAEE/DSwHsJmfaIsI4nvev1GNNHBZCK6JWQm2f3LwAogJGH1Gs6nZzEMPpXQXc6VvSnnu8KO6qSaKbjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWqHgC/8p9mLsPv+tc+P6uZgSbev3ESY/WbkBKEfK04=;
 b=CMXe39VOldEkC3ubVbvT6H118Kd+1sYevW+5JntEgZnOp38NmlOmRwB726hOJv9lGKfmb8kzR79OCCf0sH/tIgTZR8DeH7ygDlxp91h2NQxkcmxoMbQsU3ewcv6TB9rXmn5tpQ41zVLrEU3r5gzzgWsai7GtWJU+2t6FW1lwnkDUZchgS8sqsuHWlP8jSe6FubdfGhi4wV2qYwt+b3bvE9TW0sbM4ISNX9NboQmZLw3TGoXoddM7OobZZpOnn+Mhloax71k7x2N7hSru4I2tTPYIIYmPoYWarkPrm3pAQzZJGRIQsmrLNtCLJn9QHENXw49Dw7NJo50OK9oPPd6hzg==
Received: from PH8PR07CA0027.namprd07.prod.outlook.com (2603:10b6:510:2cf::25)
 by PH8PR12MB7280.namprd12.prod.outlook.com (2603:10b6:510:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.19; Mon, 13 Apr
 2026 10:54:06 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::f2) by PH8PR07CA0027.outlook.office365.com
 (2603:10b6:510:2cf::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 10:54:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 10:54:05 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 03:53:58 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 13 Apr 2026 03:53:58 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Apr 2026 03:53:54 -0700
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
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net V2 0/3] net/mlx5: Fixes for Socket-Direct
Date: Mon, 13 Apr 2026 13:53:20 +0300
Message-ID: <20260413105323.186411-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|PH8PR12MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: 87dd58ec-042e-4b52-a5f8-08de994afb8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|7416014|1800799024|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sbwkdJF7CTCjxGI+5PScA7QOANxkikmdnypXE84E+Y0J9/D0Cykd6tOYChLkrCcvWsvkfN90bux8HPkfM8KPgbFJO6FGSe64G46Oz4oRhEzBvfYDMF1SGNBLi3R5rAhaUmlJS3uw/6qiEwYW9gCY7MgnzNs3lw8g/bHnXty2nK+gTCJ9SxFJzqJMaBwToAXuDj8WlVN/v0NX6DxcQUDuMmdF+DcgU9F5bVnea8u7PCKSKE6VT8BPjlGMnNjPAw95x/oAO5riVlsCOb0Qj/AHABfIKXuKrbsaE6vHk5/gHNLBEUzSrhJUqKaf8XG5JcwWXxzjrSS2hUjZiiP6Gt2tS+XQ4yspmObwDO2g9iUh0GBSM4KsxYmTQ4DZLWpoXdjEOcvstg0yaLdFOAbXRyk6EuqGa2effrC4xCBfWPNpo53tEc7DBVg5ifetLuCX460+ojs+WxeBBRbpdtgZV3mgpCZ3zkd39448MDIAK9VuIKebM5Slf72ZDuFjPy7ZmTbbXrvVqJULgEFCy+Hf4pmWpmI2OeBw6Xkc1vLob+ahBFX0mXeAe7q2Jyf8FRQ1bXVr3SNeewWW99/+AF/cAowz0qWW64bVOO4jzR7Pf4MI5yXs5RgQqHoigJrgfDi03T05e5XCej78FMjsqgmaEdhAYZVF2tKXNeI7KsW7l7kjcL1EeZp94Qet5bjcooQIGHqayFeQtB1/s3++okEFwpaL+wFxfrLy/r0IFpqNTD4Wl2MLVUQOUv69UnXz99MQjPs6wuSUZJz8RzygqlgpQ3jDzw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(7416014)(1800799024)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fZFZIzDRMJ/nF6huSos5jQEg2BaBlvAirsfokA16G1Ib3gdzsfHH6GuugPz91crIXc3V2jZYCK4V4jCxpowcWKXOq7WVT0oR5ogE4Yx3LjacJNT48HefijbP1VRAiV+I/1rFGCtQR5PnSIMHrGOFCgUErZmX9Lcg+CD13qWzFllOHbwjEVuQ+1N/SoeVIrUFs465tkXw0RufcgBlWEWr2KdUKd1E0LFgf3N5xRDR/X3HIhDYqHcC1dYLYQR9Wi37kpKlEWbRtcSVo8A4RwQHLUoQhuV30NiMONp1msupVU2SghwxUXUo6SvBP6hV6Qvp0s5ntaQ53zj4uObFoZtlChSZ8vcclrutQGunFMkVpn3wqyd/L3tx575sk/G12ZHsMGqdAIeB5SotJjkQUsN+jToI5F9jZERPP2OHpkgPmX0/wminATd22gWNTbCfi6AZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 10:54:05.8643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87dd58ec-042e-4b52-a5f8-08de994afb8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7280
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19279-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C72063EAED6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series fixes several race conditions and bugs in the mlx5
Socket-Direct (SD) single netdev flow.

Patch 1 serializes mlx5_sd_init()/mlx5_sd_cleanup() with
mlx5_devcom_comp_lock() and tracks the SD group state on the primary
device, preventing concurrent or duplicate bring-up/tear-down.

Patch 2 fixes the debugfs "multi-pf" directory being stored on the
calling device's sd struct instead of the primary's, which caused
memory leaks and recreation errors when cleanup ran from a different PF.

Patch 3 fixes a race where a secondary PF could access the primary's
auxiliary device after it had been unbound, by holding the primary's
device lock while operating on its auxiliary device.

Regards,
Tariq

V2:
- Link to V1:
  https://lore.kernel.org/all/20260330193412.53408-1-tariqt@nvidia.com/
- Reorder the patches so that "net/mlx5: SD: Serialize init/cleanup"
  is first.
- Add MLX5_SD_STATE_DESTROYING to the patch above to solve a concurrent
  edge case.
- Expend commit message of "net/mlx5e: SD, Fix race condition in
  secondary device probe/remove"

Shay Drory (3):
  net/mlx5: SD: Serialize init/cleanup
  net/mlx5: SD, Keep multi-pf debugfs entries on primary
  net/mlx5e: SD, Fix race condition in secondary device probe/remove

 .../net/ethernet/mellanox/mlx5/core/en_main.c | 18 +++--
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 70 ++++++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h  |  2 +
 3 files changed, 77 insertions(+), 13 deletions(-)


base-commit: 2dddb34dd0d07b01fa770eca89480a4da4f13153
-- 
2.44.0


