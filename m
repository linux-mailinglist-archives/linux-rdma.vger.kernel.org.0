Return-Path: <linux-rdma+bounces-21362-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TypuBo3sFmr7wwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21362-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:07:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9115E4A32
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BE6D30AE169
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 12:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D20E40DFC5;
	Wed, 27 May 2026 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UHvSX97m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011057.outbound.protection.outlook.com [40.93.194.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CB840F8C6;
	Wed, 27 May 2026 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886588; cv=fail; b=XtfBw/iZkYq363xHB3mztDeB7pR5HGDjnBORbcQHAhuJPOTe/HNCZaxNDuxwwr2Xm+aabBX5GurvSPBA8iDajE0/LyqLiQ+ZPiMULaY3x38szr8T+Kk3C8f5ic4Z2M2K6N/FNCe3Uwgxp+fKytv4qTOYiWw6tQE7SMkDDdJYuos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886588; c=relaxed/simple;
	bh=8aEtJSvkX+Wy2OZy7XextSOd8T2DOYhOqwEsNbAt0dM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPu3VFhispWRMk0qQvrMyNyo5HyXTs/F5KpXZJc5f7j97K0qNuVZTZ14vyx6uZ3sorADGEfj527Ie4zqiJYsLHNx6xRxrZVPHrcZeF4Oqegng3Q8oU/fNI9N9JvwFXIIfONvvN8rMX7JxR8YkruLym/MVRIbmfYRazej2joLdRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UHvSX97m; arc=fail smtp.client-ip=40.93.194.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8lOtP7gMD0w+gG+zOlvRkTtCUJxWOBK7wwaYcQ+JNg8oN2wRESTDcVYWaHub5yT7rETgcpLg9Ag2UsTbMbyak/Afj31X6dKaV3WkMWTdyU1wn7l89uiMJ6GVbhVXY+ViZHyxKLRJn4eg8ePcdfHKFhNGpOGUkXifyp4xN8UzD1OiLba8ueuQBzdvafCcM2BiDBXr/OZH7LnkF68DGBrM+rjwcCrrUf5KD02aPQh26bGTx1bj4J3PnoBnNWmgWqXf4udw0MAuGuM9NfaLf99hElScNuulKl7cXQwc+5VQRhQCWp0Zq9wTaLRdwFcJhLWTFL+ldng03JS75i4Z2Y4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1L3P692k+ByaDkv9O+CK5sp+LoLKIziCYQETiEvfZ1E=;
 b=eR17nn2aPuLbZ0HmZkber9wvBWEvX7x9SsbeVpo+BXrqh1A5Mpkgihk/XhO6vwF1bywYiKbR4gBOuabS+3fF9LD4kADP+LV3f+MDWE6qkfohyj+ccelhUJXk3ZrXipbaCuExK3fqeyW5gINuI28nYv+TFENRDb3bfZRt5gIV0Q6Kq8xHMvyLN10aZ13iWE1BulFb6Xw9KjpiSt+ULDdv/mCjMQ4cqzmPU9mP7T4HGaV3n7Eno2kgKSxRmgg2yfFZ73dtBr4/f40KbWfJDJ69GGtV0lePrK1zLWlUKNmb2B4yMwnc1UQDQizlqGwWh4Bf3TJR+Mk57COwkpftD6sk5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L3P692k+ByaDkv9O+CK5sp+LoLKIziCYQETiEvfZ1E=;
 b=UHvSX97mBFQvZaSVjGL354rLwy/qAphoErkaurvWW1J8Ykc7IlnG3D62TTjX9HQOxvWIxkF+2SAodX0ZVOBhkOSASgwCnPfq0nZHTa3Wl0QBcv7NShG7RtIPJn+ZpcIsH/V/tRKEeA59YjgX1HNjSXm6SbD7xcQqOErLwMc/ikfae3vhM69f8FMZWLOJ0BMIOOrczucolnKxxknwv9ki37yswVUJ9ritfyQkov3YOTx2xoHjwRMTNJi/dGNlRKSkoaJrNQs87h3SxVlB3Jitnl0EWzmTigm1TW6qteAziU+pNMUb4prp1B0z59Vb/9AUUYHTkYpKibtpmF4u/nzEgA==
Received: from BL1PR13CA0126.namprd13.prod.outlook.com (2603:10b6:208:2bb::11)
 by SN7PR12MB8148.namprd12.prod.outlook.com (2603:10b6:806:351::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 12:56:20 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::b) by BL1PR13CA0126.outlook.office365.com
 (2603:10b6:208:2bb::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.3 via Frontend Transport; Wed, 27
 May 2026 12:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 12:56:19 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 05:56:04 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 27 May 2026 05:56:04 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 27 May 2026 05:55:58 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Kees Cook <kees@kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 10/13] net/mlx5: SD, keep netdev resources on same PF in switchdev mode
Date: Wed, 27 May 2026 15:54:24 +0300
Message-ID: <20260527125427.385976-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260527125427.385976-1-tariqt@nvidia.com>
References: <20260527125427.385976-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|SN7PR12MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: d648af9b-302b-432c-d90c-08debbef591a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	n8cGs1Pre3SnaEVbcwh7H6aVqZppEC7vU/Uye67zpPHkVLtoabeOBLCJCHrHYHL4rN+UTVtl7V0deuSyRqX2xOju7fSISC6JOtyE1/7xyIvANG9o2/0GQzsxqWFUrbnxrLwYnhhgE43b5h5/jBfKjT1CxE4rQSPUQYTPR1ud1Xp7F5Vtx2o7QIUJ+V0R4IkHoU8KQsqy54xRbjxW+/6CCLc4p1l+yyAKLCBVxN5rHihIjHjOX1cbIHergH1GWeMEpL0+ASTAc4eV/HNmaU/p37DO48UsKkzpBTiUtqAiwwJRPJw6PPeGQOqfYBR/ZkejzBGEw3sRjWtYqifKHb6OsYT/5YEEmTuj+urdbfxSyNfJfDDE3B1dhfzeMWCUu4pKopETPE6su5++1b8VBziw3Dz8lTsxGsZXE4VGdb7PiPD56KfT5KOjYheN2OB1ssjkfMQKxSP9iMhvC0BuuzB92M/Nb9FVqmkxjGGWvUHtts14CgCYxwAc3voNEaDtSZpC2ZRRIX0ppEo4wPEPjLq3OxBfGdTqmEAz4EsJxrKtupzuskY1rD75Yp6xnCo1wvKXC6n/5Ijv2E8MiJLw/3x9b612a88Z/hrElACZUnlJEWrngzQW/83h8ag2TJEiH5aRfyBI+X8lI1Q+ivHVzAcB4UTj3dcszGqjgMEiNWLmtyJsUs99X6X6qogPObyUuLKEBfI8iNprLy3vv29kSTcoO8yCCWTFs3CVeX+8fTDT+EM=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BImaJqjo8kMR0EnBGUQhrLhac3zYM3eYjkXpbqTaOu3kY/tW8pCYZ+f+zPTt5jhsxXO9AmZ8s7lQ9eA6PQ40gaqk9dIkXguPn6taYIZYnyWlELhAVEkPcCLfgVon4RhmMREOaFAWHYg1Rhh1Aeyo55VJt5Ida+WNKr5BtzOH+bzOKWNOC9nNpekduSQEOxsyTc9u27BXNQtpRJ0VfDI51FUFNUB8/71e344SzX+47ZIq7W2BLYPoXwaJBsEnCv2AFn4omFf/sf3ZlirL+0+gQNUUE8uKD/nCT9d4JgPtXxveo2g68f8RublebCfMGpQPfgdJnA5n+Q81F1jku3iJ4X8IrftRdFUAYeUcMhS9T5PmAjrlUiTPGIM1qeDrNMHqpqb/Nh/s7M8QTHx196BKTjrxEAa1dWdghQbWN75BQI9JugXOy6BU/25lVVhZ0xdb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 12:56:19.7791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d648af9b-302b-432c-d90c-08debbef591a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8148
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
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21362-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7A9115E4A32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

In SD switchdev mode, network device resources such as channels and
completion vectors must remain on the same PF rather than being
distributed across SD group members.

Modify mlx5_sd_ch_ix_get_dev_ix() to return 0 and
mlx5_sd_ch_ix_get_vec_ix() to return the channel index directly when
in switchdev mode, keeping resources local to the requesting PF.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 8991db3a19cf..ec606851feb8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -6,6 +6,7 @@
 #include "mlx5_core.h"
 #include "lib/mlx5.h"
 #include "fs_cmd.h"
+#include <linux/mlx5/eswitch.h>
 #include <linux/mlx5/vport.h>
 #include <linux/debugfs.h>
 
@@ -85,11 +86,17 @@ mlx5_sd_primary_get_peer(struct mlx5_core_dev *primary, int idx)
 
 int mlx5_sd_ch_ix_get_dev_ix(struct mlx5_core_dev *dev, int ch_ix)
 {
+	if (is_mdev_switchdev_mode(dev))
+		return 0;
+
 	return ch_ix % mlx5_sd_get_host_buses(dev);
 }
 
 int mlx5_sd_ch_ix_get_vec_ix(struct mlx5_core_dev *dev, int ch_ix)
 {
+	if (is_mdev_switchdev_mode(dev))
+		return ch_ix;
+
 	return ch_ix / mlx5_sd_get_host_buses(dev);
 }
 
-- 
2.44.0


