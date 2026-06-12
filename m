Return-Path: <linux-rdma+bounces-22161-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /O2zD5HwK2qOIAQAu9opvQ
	(envelope-from <linux-rdma+bounces-22161-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:42:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB52679090
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:42:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="RwhM/v2b";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22161-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22161-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1213333FD0C1
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 11:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB9D38F951;
	Fri, 12 Jun 2026 11:40:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A7B374A1A;
	Fri, 12 Jun 2026 11:40:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264411; cv=fail; b=L7G2lQO+JVwXBj3hLMsP2Zuk8QN6hzM03omjk4amtuWX1n7s6W097ahZprBG3DvXX/85d+YmhtSfQDvseK7pwO/VWXE2EwVDQGbgs+Z+SQ4iuEF9eROEB/5kQtTKyadsOrSwVcBcc3mUD3N+PvYfhwmYvVEIavZeJ0xxoiW7A/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264411; c=relaxed/simple;
	bh=7ZJC3rbBrQ/s60FPtPJjTnuuKh6VbO71JluXU9yQbiY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MaQOcHyrh1mRWW0EFvC4SvqbkLZJ1ceVj1AI3Zf4WFQU6nDE5lG9Q8l57edJreQtYfVbI2RKptSqUMBAyLHiKg84UHMl4p54ZM0RtLTZQxIRyy9OE8BJC/M9j7ht7qvtVxHZmEjx5UqhyZMVTQvId9SdEymQXgplNczmR1Vh1Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RwhM/v2b; arc=fail smtp.client-ip=52.101.201.14
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1TKDa1992YCI2pjp2ZZ65wmUjpHe+TawzbVkRrQLY9I5t7WHhvjc6cz/h3K+X+VYLhslRzxtTNiq04GjqvHhWCujdUZNGHXMyfQ2eP0manz/vlfXUEbjHFaFmTac/Z/VuMc/BMC1N7S9ELRGBRDVO3e0avkBYGFTD/Aq3oikmdo0wBZXDSizs2CcUfSjZmyLYDyzyPX2lZAzZuRD6sQ+kvFT9rF9fcdh1YdYTsAFd9/TyfBZBN0yPoocsnwBaUThmp2VsLP0mGj5qNvAYDA3YhRrJOv7LaSA3qP+ziXzReMC3EXSqtoRiTzyhAVLmR+NCa7/TjTK4zEkIRapk9HFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6reHVEIICX06uORq8SufgqZufI8bHiI8w5cR6b5TDM=;
 b=hCX8em2oFkczvg3mmNbWDOuOnFeO+MrufNZKTry/gd3fVsAfluPT015MPL+vNvIxco2EFIv60VEqejqzR+GUKa5pH6PwMfixwg5fEkAGAHgNxOouDhc3OXpXNcf2meN+J1FFh5U9JsZKtsMu6rbYoBNY4els2lT26Q5w3n7ZrpbX1TfIPf09dS6TH4xgusFWzV+miVhvPir0tpbt8IaTUDJIonVFC8FAP5hvXQYWQzOOmEq3rAkpuYGUs9hcJsr/vy8yV0YS4mlEGp4l/3NNDeG+FfDP0Hc2xkG7cwfBeO7+ZsCgBbsN8QxcIwPWMQEZOsiNUWvQvaZpbMMgyQQ9VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6reHVEIICX06uORq8SufgqZufI8bHiI8w5cR6b5TDM=;
 b=RwhM/v2bx9OX1QpLzVcEKIWyqqi2HC+NN6BNut1rJQzksn2XnasckXhacQuKW/tmn071WeewRam2PdCY4MPtF2FnqStFV7n9r+tosZwtk/zpqdKyc/Mz/UhxpTMbCYoH8RJHIQWC0cdkduq9lbAKp5l53rvtR4XxNMkcJvJrUEbuuk2+cjB7iOUh2GzFFCtl7WozLaNsInqA0UwBcMilcRHJoqHSOb2JvThUQgiYKX03HAp26mi6fT4aAER3chmJuGAildVcsQhyYLolEabrkmb+UmFBb7TzajtVaumcGMjJnjex3mWWOETr1na1SLMjZAbr8UHoipAWsr1SBbJSiA==
Received: from PH7P220CA0035.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::30)
 by SN7PR12MB7252.namprd12.prod.outlook.com (2603:10b6:806:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Fri, 12 Jun
 2026 11:40:03 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::98) by PH7P220CA0035.outlook.office365.com
 (2603:10b6:510:32b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 11:40:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 11:40:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:39:43 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:39:43 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 12
 Jun 2026 04:39:37 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next V3 03/15] net/mlx5: devcom, add DEVCOM_CANT_FAIL for non-rollback events
Date: Fri, 12 Jun 2026 14:38:52 +0300
Message-ID: <20260612113904.537595-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260612113904.537595-1-tariqt@nvidia.com>
References: <20260612113904.537595-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SN7PR12MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: abe9ede6-c7a4-4ead-f7e9-08dec87757cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|82310400026|23010399003|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	fTQlrzlqAHC4KhiSvLm/Y6dQ1EvZ4ZQruiE13jChrQ7HAaPeiL8bbYBmat4N8w4pLyI1E2SOvwcVGgpBPXZgMqfGbISJjgDjQl9JlG9uzLCtu89k1bHtG7mVHbUXt2mS3DWc4J4xOT0Cs7nkYjUNggW/kuRqbZwieZjQRiMvopCYx0QgR60NweYbLQEeJnOb2t9WHR8wfg0+QE8cH/T6Ipwwhi4QOWOvy6wOi8EMAuMWYyRKM5M+ninnQjQkRoVJ7WE+Ran/RzjL7dmTeuE/qbmkb5/6NdijvdRuLt6MeWoKsiUIbsHkVAKt4B1H3eHJicIQCZxs3aibFdmuR0KYgkmCh5dRvTQzAl9wUo/2I2sRZf5i5UnFnuG10RBmlbMZ6SgE9zTn5U5jHZcSVQGcYTZvyDpu8n6sNvNaOTeuvpvxGlDNdyM8GmKUvN0IdUNV+IJskPWz3MJ4DEBX9caDny0p77raEdqp+A6V5KLa7BykZyRHIaiWUB9skZo8XlzvLIFc4BksOCuk3AvvtSoEXFWB2On+6o2vCoVW/dKtVs13RtpSU236Rhh6yOWKBGDmkSwK0+vrz032cU9fP/uMbyndQQsGborMFj06El4Go3OanRcZbpEz3m3KgAvOKUgQbABu1MdxCt/NDDtGmK8OjA9d3S/IHnOy9R5XDfBspy/LR8DoPyLlax+pKw9HdqMRhfI97WbnP0MSxNy57l9GGJuQCZ/SD6T5IJKw9XihwsE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wLnlEmxOqA2SC4JAS/u1ZnLzUS//+m3vryJ5wB81BVP+3s1x4ZLDNMLnqebgJoLkjQxJmv+SDJQhTQ0678yVeZ0d5zABx34cGE/P1gOAa4HAnLWEuvQ594mj0nAlvnE68xRPeaoXSO7VorF1/94ApRgjdc0kin2hWBmWMGwG34zccmsD7m9vQintWep9JxnwSTGKPLTlLgLTys39i5dnWkJB+a0grhEYzUWHqf/YqZuItVR6CcGqlC+GyqGhYS738TY9kDW4RRJSFUQROUQ3GFKspDzrBpQjLw/SCTGv+3RNCFvTIykLBgb4njmYLOdrusEY7HqUt6YA+Kni3+e7l0UUttReZfajghE3i3CQmAqWW5/sjXK+jH9FkJZVuIfhmGtE4PL31aq1Oy8v3AZSFVDkxxNbmlJrLu0kVS4U8b+2ikvv/QB5Qk9jH3c0iJax
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:40:03.1567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abe9ede6-c7a4-4ead-f7e9-08dec87757cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7252
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22161-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:msanalla@nvidia.com,m:horms@kernel.org,m:gbayer@linux.ibm.com,m:kees@kernel.org,m:moshe@nvidia.com,m:parav@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CB52679090

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


