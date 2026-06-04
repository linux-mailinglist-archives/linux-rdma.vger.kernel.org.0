Return-Path: <linux-rdma+bounces-21767-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kUXbApRoIWruFwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21767-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:59:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6998B63FA70
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:59:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=mZhaiDbl;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21767-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21767-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E50B230C0C04
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 11:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBB043DA48;
	Thu,  4 Jun 2026 11:48:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011066.outbound.protection.outlook.com [40.93.194.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133E6428830;
	Thu,  4 Jun 2026 11:48:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573729; cv=fail; b=Ghubu0HS2Ucwreclvkzw7975B3AdWMAWIP5DJCSDTSCC9tDGYrjVWbfQzo88PAPQ4JgueMfi6tXWRyFA1bq0U5PeOjGkVQ9VjabYd2i75aU+gYw5fbQOFwn8XRJF9vgWSu5HhPP33vbQr4OPI9wWMd625fekROp+BDE5PhTRUwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573729; c=relaxed/simple;
	bh=7ZJC3rbBrQ/s60FPtPJjTnuuKh6VbO71JluXU9yQbiY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kx6pon7wL7nZvAeYrxus84IdQGE8m9jG5jAW0JLNsV8dGa30cKilHXUQGbiXakSMxTvBZ8wHLy1vYM5FriRbBNnDK7rqXl/GoGiIEX3jEZup1ALbulbkYCKMnN4zreDf0WowXxXJH/6fzNsEhCVXMKZ347FY9ViFpgW25YGWAzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mZhaiDbl; arc=fail smtp.client-ip=40.93.194.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyItcwWGnNlEGXMFdHgR2Hq9e5ZnWxuMBaVw/+LP+zuoZlaGDybFxWgWYSIgw3vkbw3kH3r9axXYTJjlxic5CMBpIzVG8mmj2KvGge+u+zWg0Hs/kNrC3x9Ttbda6pHXtcuk/wN/lrr64+kd/yG327w7sBjhDYKWXiSc4yg/umqIlTBQOaBHcrTtMTLXt4nNhUK1fGyfPXG36ZKKAnuTRKKBuF/GTf3KwwyHJYIdIsK20vBRh0seCvGvxSueXpL9kbPOKpOLYNezqfGtekwPIvn4L0GFh/BzDVcenFrrkeEYE7S7/unvzJWoEoboo2skzm8UaebBQ9cSdVOxabBV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6reHVEIICX06uORq8SufgqZufI8bHiI8w5cR6b5TDM=;
 b=Iy4qQG79kjjfhb37s9if3MKks8T3spTX4CGhDfRUdeT8fumBk9d3bBmn4d9lkipgEvBB1rSqbgagFqviC+h2+6PVoRbZOvLDh7dJ+fb63HFDnMNEdsdNhiaQuVtR82Qh239Z3wzQzY/JpA3p3+YVMIy5EBjwV/6Vir1EtSzri+fF9P9I5WXHhqxSdlDlelqqWAYo3ZwVkNnx2rQBQ0VDZ7Hp/E7C6v9NgQ2IFgNb9BnhMqiOQlaXJVVqZikDmL1DZYpXLr5KhSMSo7Ty1k7MfKjLfII5X+UQhHH0DoW+FHIxLK+E8WR7jHmGG6roitMi/c32ck6HEWWzecP8p4PJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6reHVEIICX06uORq8SufgqZufI8bHiI8w5cR6b5TDM=;
 b=mZhaiDblU1ozgCk/dGy/9yp8lrSPEvJgdar3JQXLHSes0XKrotRq7CTvjvF7s5QmhU3XDqw86g+OpwFFes6UAlN0ak1KLa/gXBnOOA2/4ZJxYpIBkDs4D3bb1nUl+7FBy5Oc9pNf4O9X4aAy+49kNTV4hoSX23f9LDnnqqaj66t17m4eG0wbW6rZX8cH4irfuXcwHaIgXMpo+ynFBUbBuvIoasUHd6UEB4SeLB+wOoSH7oq+nPxWDbQ7nzzbUci4Y3PZlFmSD3NmSlMGDkZOH8xxxcxfNIdX14mywVhgit13YzkMXOwqR4X4IIWalN9v5SVOO5VWBVe48TAdQC8Axw==
Received: from BN9PR03CA0867.namprd03.prod.outlook.com (2603:10b6:408:13d::32)
 by CY3PR12MB9702.namprd12.prod.outlook.com (2603:10b6:930:103::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 11:46:01 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::8a) by BN9PR03CA0867.outlook.office365.com
 (2603:10b6:408:13d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 11:46:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 11:46:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 04:45:46 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 4 Jun 2026 04:45:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 04:45:40 -0700
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
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 03/15] net/mlx5: devcom, add DEVCOM_CANT_FAIL for non-rollback events
Date: Thu, 4 Jun 2026 14:44:43 +0300
Message-ID: <20260604114455.434711-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260604114455.434711-1-tariqt@nvidia.com>
References: <20260604114455.434711-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|CY3PR12MB9702:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c396f5-7a05-4886-8d00-08dec22ed9e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|1800799024|82310400026|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	oD5vsTYIq1VPvv0adXMVbZpo7Q9DlXEbJVbHxBX1ZYb2djBdFcctecd38AbhNnaOxhXkW+CCRQFFKD7lxEb9IC9qWxC8gpaIXfs0ZzNQdr0LF+l3DaGSQMoBm5HLiiFbmsvodrUNiFSI0mw/dvee1NSaJcptC1vxJDxVfJXsMzlQQ9+8e90YJdbjWZCREOdPDpjeWuTjBBO/BSzW/G21C0cPLP6ZxGsjibezzhTaw3bOvgEUGYEL8x9WWU3xVjDf3Zm50xcPVge1QiTsVvpNi0q1Htr50G7pYuLDuxsd5Mm2Ue2peMcMsHZdttxqVpQ80q1/2TrXSu7zKOnJ6n2iAaX/xmLTeQvfJ5dSKle622LAC7+JOZIONA+T6CN7xSz9nhKwVtb1Pii8bo2qIRJG+OElTIl0T22INfqm7FLCKEsDRqMLcX7Hl/hrWpMnKClePLauTU2Jl+7YEINC1JAn3tDpUm5XtK71TbfYo5fAHAYrms3FsEhrmXCTr2nN2SlyUHMa3ICAXGokjPdsMdEO5tfIpdCVhS6HA0NVCB5PuPpZziYGJz2czQlQeR9gT6xNw8xEnLAxrEpyyZBPOmvIAAMAUDQA+aXz2aOpaI63ZxAEj8qcwqSrf90l+YbkDlB5S4/zL1pXHjOI0m8O0S8vyHVfCEpuKiIgEUYyovCUmZ9+n7M+Eng2O4ePRGDYPktHPWylLDJMcjk1R7A+hx2yHvqzsC3CVpytEwmhv18eykU=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(1800799024)(82310400026)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PXRnQoO5Qz8QsWbw0wl8fNGaOLXHimyAK6EjFcrN4cEY33ck1p9QPfPz92MAMtBvOmU1ytIMJX8O69P1i2kNwgMwAhzvnNfEpYXcI4ytYIE5pCiVHUY91PPxsNJ/q4DKzxBxUjLtT6EtbaP9iYTmiJcuP+yULmClV5It+0LOKN/Xca4uAfUAoDY920TN/aUYqkdv8w43tGxQF1ghxVmCxbtcOU8utZqfmXKl6+3pgNSdm9eMtOBARIYRFEAw9i51EkHBealunvcPKthvyK2HiE6legJkwVMB2BEbtP0AFVtJZ8q0ClW+UntFGaQ2RaH9EgrVGoaA3mEOqLmeX4DpICk5VCWEQDI0DIfrSPuY8qBafWcjrlj5AX6aKo2+WCenokT+uqlwbrbPdPs2XQKaQQV5cdvrQ75NYdgrbmTlZw5R53OdgJE+uHLC+p6yTGWr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:46:01.1564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c396f5-7a05-4886-8d00-08dec22ed9e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9702
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-21767-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6998B63FA70

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


