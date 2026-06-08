Return-Path: <linux-rdma+bounces-21960-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LrL7LqnLJmrJkgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21960-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:03:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63939656E5D
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:03:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=bw9BbPHy;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21960-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21960-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 710B5306B3A4
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 13:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2FD3C3437;
	Mon,  8 Jun 2026 13:57:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9143C0A10;
	Mon,  8 Jun 2026 13:57:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927040; cv=fail; b=Z7sNgeoLi/3n8Zq3WW1kgxEQXVd9wziic8RfprY7EFhzHctN9eQ5y+O+sPGaEcw3Gzzis4qOTtJS6KqGZloxQWz4uzNmmyJqNUJbyQSLxc9QkapqmtPOO09JUXptkwv31zIC6cRlVvuudIWwS+xNwyY3hCmLcq/5Y9qIHSe7r4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927040; c=relaxed/simple;
	bh=7ZJC3rbBrQ/s60FPtPJjTnuuKh6VbO71JluXU9yQbiY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQ0IHeELdtvds7rpnlWEIuT2XPrP4NU6v5MjnlqlEPDKqHrHNdlwgiDUd0TatCGpYMKskJAo2CmzY8ZGYiL6AoL0P2jsQ/lQ/YPercYFbWkybtj7Y9sgX94XahaX01BAXIAxSZ/d10zbZVZ7kmyssMGhsQnlnzjXOTihKJ9hga4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bw9BbPHy; arc=fail smtp.client-ip=40.93.194.4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sab8VjiqlUfMDLfB9hzOtHhLkV6sMjwykUaYlF8Y8rFprFmWUYZTVdpUyouPQsi7cgijmCFNh+jnlaM1DS0r5rqiX/3X6NyhWNDWZnae0azpiWeKEVKZ+MaBvcz5vJuypPdnpLhbaH2Ii9JZBWlpU04w+EPpZtmcf7wZPb0/mMqhU0hZ0mlqd/jH2WLB1LOvcKwzkWzdQY6+hmcrsgFDHvFQ1lUfJ56rKFWStPsTCHlFBm/GUbjns4RcQQjopEFl33Z9rsMHTBW25xy+pjrSLpi5S0czh6uH4Akr2fkJ/0bGr0TbQYKZfV5Ps9sPE4xO402aGcKRvkOsibk2tOwfUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6reHVEIICX06uORq8SufgqZufI8bHiI8w5cR6b5TDM=;
 b=Bz8PcwnbqY8F4wSMchi36ZcWOlD+E1ixkMyE/YDWPQClg2mYhPtucWhfsOjW515sy/uPCBuz029m+a6oPgvjLV7dy+/U4XCAfW4Vks8iTgcwybEFZBf6HZ3E32fV5bcgtm4eO737cGnF4g6cjhCYniFX6/3fXfqRPsgEtp0YQNbEe6YDgjXwmciYUDvsVngp4LMkVbAOhQJoZgFZ1FMIiC/C60M3bIu/4Ol1u7XiHk0e6gyXBb+msDCPU7bnJcBVhuI5zvRTMbhK810G8tMxfR9YdlBYfuo8NcWFJpckPWzLZQzzgTohO3WRYxXR8JYTmSQl9uTVqnWbJePS6F/c7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6reHVEIICX06uORq8SufgqZufI8bHiI8w5cR6b5TDM=;
 b=bw9BbPHybJG7nfCl9aT5JJu3oz1UyvRjofd8SrZPGL2E61JNz4utAud4ySqggIG9Zwi/rMan4xwH+hWFTPKw2illSu6QHxMyv1OvAMbJMnRT4qJPAFf58UnTHADbZMznmbO+hEMXhphWB/Ctk/m1St1afcgPZcrxkqpl5kxbsRyGQ/5K3hNQ/mJNqmSnrJpjb8HaTyG6bSPsW3J7S33SclIYahIJm07QYy1Ap8tDrFmhiDHf7LaQUssd14NDW4oZaXOjAu3zsPISvw2zbbBtWj+ezCZKMKKbF0XKp6pyl5hknDBA99z+6/gL7uwQNMwbVYQfswl6Vh5SyVf3X+bvMw==
Received: from BN9PR03CA0883.namprd03.prod.outlook.com (2603:10b6:408:13c::18)
 by SN7PR12MB7979.namprd12.prod.outlook.com (2603:10b6:806:32a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Mon, 8 Jun 2026
 13:57:12 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:13c:cafe::94) by BN9PR03CA0883.outlook.office365.com
 (2603:10b6:408:13c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 13:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 13:57:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 06:56:48 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Jun 2026 06:56:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Jun 2026 06:56:43 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next V2 03/15] net/mlx5: devcom, add DEVCOM_CANT_FAIL for non-rollback events
Date: Mon, 8 Jun 2026 16:55:35 +0300
Message-ID: <20260608135547.482825-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260608135547.482825-1-tariqt@nvidia.com>
References: <20260608135547.482825-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|SN7PR12MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 61034475-b866-42e1-7210-08dec565d6ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|11063799006|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	OYPRdwmPYPDAvW2wMJ+t8MD42RXtKXIUnFrlNJZ3BC7sGh03tiy+eYN98KLdEX7E5dMi3e0D2Y1U3MgVbj9C+ugNZcm68Hdj0uLfxkRPDXYLpNC3BgQEUlUORRXb43JVMEHGtICIDXFUKhY6Eu/vxqAUwsqDfa/NKbx47iC0Y2x0A6VJR10rmolSz6ixECTCg3pHLBsFl4ag49Gm04nmgLMHoYGRK6bPs/LHME4dl0Y/frgP8NwCTcUNhofyOfSwej3JiUT5QDKi8sv/gEA+055eKX1wm6k/da/zlTvZWA9aTLdJd/WckWu+mqBZnsaGG7SmhmgtakN+iMj86s/Ty6f74dP0UZ2zwVocmscherYytIkfpRcUEdS/XqOqDnuooLmrA0xbWy9PrIP8dX6aH6amBGg22gBWUjed86/hX8AsTGGosZEnx44fZnkb9glE0YY6wipHXUS+Nu+nhWcbqKxLaFeoPhCP9uR6lshycm3lSeONT056eTFUyrLjPI9WMpzbzeUUqwi9NAZ78aNRExeJ+/H29U0S7ujiWUBFMR9gw+diFa95gblLRGWZfq8fMvOi349rTrS7SCb3gGTlksnnoB3+XXyLjHbBO+vQMO9xC3Q8OntOZJXV8ppK/s7U445E1bOwqpcLxeACwsSkffmPXJ1zsY6GobDFDrhFDr7prak7UruKg3Xqi+8PpAJ1Npjrq9i80ccE8k8WueMQ9bWADyfP9vcfAEcOYCOcQcY=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LIVsKsWWyEWxVKsHeLHL14wQx4xLH/ynfq+aheRJVpgZFYLwkZNH1FpFFGYnTYu+VnPLfw4caQtulSvmIyedfy0wN6of0Y1N+yVvkyUjhH0bDWIr/ktbQcmzAH6XKMfaQUdOmO+Wxf33y5SoYEubt01ubQehhNVNV7XxlOxgVPgOOxHNI4+aZMOTHAF0fYpCqaxSRAkpjJ0+uFXaBwtrLv+rom0Erd2cChzg0h+sz/RggCT5UNMyWzD4slmgHu2j1W8eeqpbiMY8ZyCyNubeMO869WJQ0aM99q+DgEc+M8OSrlhoJcat+0uMI+r/mfBv4xY3NvlCZzHATcXgsJq5HBrjwdjvyjakS+96sjAEIGBQWtbmX5WU2ZtpvuTvDUTby4CJro5qxpR2iQ2Aq2HQezmGID5+R2J1Y72Rt8BHW/lA56A8wEV2n4ghB3n2iHra
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 13:57:11.7516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61034475-b866-42e1-7210-08dec565d6ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7979
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-21960-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63939656E5D

From: Shay Drory <shayd@nvidia.com>

Some devcom events are not expected to fail. Rather than attempting
a rollback that may not be meaningful, allow callers to pass
DEVCOM_CANT_FAIL as the rollback_event to indicate that the event
handler should not fail. If it does, emit a warning and stop
propagating to further peers, but skip the rollback path.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c | 7 ++++++-
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
index 96b4f06d6184..64f92427602d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -306,8 +306,13 @@ int mlx5_devcom_locked_send_event(struct mlx5_devcom_comp_dev *devcom,
 
 		if (pos != devcom && data) {
 			err = comp->handler(event, data, event_data);
-			if (err)
+			if (err && rollback_event != DEVCOM_CANT_FAIL) {
 				goto rollback;
+			} else if (err && rollback_event == DEVCOM_CANT_FAIL) {
+				WARN_ONCE(1, "devcom component %d event %d failed: %d\n",
+					  comp->id, event, err);
+				return err;
+			}
 		}
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
index d5c60c03e55c..7a704fafdbd3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
@@ -46,6 +46,8 @@ mlx5_devcom_register_component(struct mlx5_devcom_dev *devc,
 			       void *data);
 void mlx5_devcom_unregister_component(struct mlx5_devcom_comp_dev *devcom);
 
+#define DEVCOM_CANT_FAIL (INT_MAX)
+
 int mlx5_devcom_locked_send_event(struct mlx5_devcom_comp_dev *devcom,
 				  int event, int rollback_event,
 				  void *event_data);
-- 
2.44.0


