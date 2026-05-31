Return-Path: <linux-rdma+bounces-21557-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBJCEs8fHGoRKAkAu9opvQ
	(envelope-from <linux-rdma+bounces-21557-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:47:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 60821615DD7
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C70D8302A5B7
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 11:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C0E38423B;
	Sun, 31 May 2026 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jVvxWH7a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50147265606;
	Sun, 31 May 2026 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780227703; cv=fail; b=JdAQ8+Vu4PwyJEL9B4N/iZdbW2XSoLl7axyX6sorzOQjfRykpBNd5oJY4fJ2XIC7hLfAKOwkVTrGsDlS6aiHyzbJaZtumxipqjXNz/pjUgIzEgCgx5fh7NEg8sMPaMTdShRim1mXJ7Q8zS9mV/JSVhtMKljXHvQs0eYEib55rYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780227703; c=relaxed/simple;
	bh=sQnAtlXhG2K63oWZXFT8sP4DXuosorjINpoJdmM0QKk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+AjXmOSDwqgU4OOIFqAcWc3gjbDk2sibD886MCzV1aoqP9GR+OR0FdgfmdS48QMTOApo3v/trRdNUVBGL3gtE6/bkmz2WOiprwe/HOrG0viVfcPlENhbxBTf3ZvKZMtMoqGljas5MLdpaPzTCrwwm7jBSoYdVyzNAuh4djTlWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jVvxWH7a; arc=fail smtp.client-ip=52.101.53.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCbgMdNYPr+QAPNRyfClUy6S91Ag25hnZgDpaefHeFTCpns2G3nsufjFoowK+908NMp6bt0y8+IiI9zUXK+8dlXW6/qiHijI7IZ9OWoqR5ciSJI+jMgcQMgoM7qHUUk/OSmeHo5haV3FgQj3cPautEISOdKHMCGgqs1OMlqHIeISUBPxiNY82WedeSaeLfWlwS5CdEnyppgZXW9VP4nfsLLn6YNZmCXJAz+Bf2TjyNkBVPNHqbkSViqhuTpHU0bV3OJGRQjZ6HKJOHWXS9VzcdI0ICOwmbHBubdCrorhNjZxbdXEkw8V4VjMVANny6VrdFIXfNnw7GQeyLwoloxosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBc5T5e3GYCM4CIelkXZlhrl5shwcWKAKGIY5D40HZA=;
 b=rJFJhVFsuwYgc1KY6Y7xVmWAbwgLDodlu2DGWFWZpMRkxZMV8vVASeFwrZgThFvA02W+QZ3gfCmmxkFSUpFcA0N4ABwvQKZJXo171QZtrFwXx77i1ESdCW0xFOtG6W5bVwOaXFBRyykxmatTgmr9YOLfvZSFh2aGfM2nhaeq2tsITVjaDdk+vJZb/TU51fSS72tQmeTsbEpf25qub8lzY76w39YLnU5D/KDPvh1/0r89BmdlYhtnh4IVgzhqogdc8ZahGUHQWxc4tz0XVnucbgwZZx9ogfK+YDWgC6TQN36COMNX0r7rnIrKZ1fvIQrpIVQco1eSJ4t5hVmVRFNtJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBc5T5e3GYCM4CIelkXZlhrl5shwcWKAKGIY5D40HZA=;
 b=jVvxWH7a8fXRnPFthI5y6HP0i92Wxl9RbWNQx2S7R88Xg4h1WhD5p+TAM+s4zmd+e9O6spFap34IX8iPcc+jtHCOBqd9T6LKTlQyF9vHFGTE3DwGZDvtsfJsllNUG+hNitcy9BQT9ZEsyOCV7On5wKpVN4A++LiuTum0V3aazj2XRqW64Nxn6AMEZrlVq2lYouze1m4CJ5sy7kBHSh1FQUKAdJv3X95D+5Zdk8+sTqdOdIFTkW4qEiUVvmbGcrmgMxZHNtV7g0qY0MzDadsQZOnyNJpd9tL8Dz1x3n4SdsaecLgsqjkj+ULcz2ctBzoBzlLR1nzcuyLjryoRld4DAg==
Received: from BLAPR03CA0109.namprd03.prod.outlook.com (2603:10b6:208:32a::24)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sun, 31 May
 2026 11:41:37 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::a3) by BLAPR03CA0109.outlook.office365.com
 (2603:10b6:208:32a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Sun, 31
 May 2026 11:41:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sun, 31 May 2026 11:41:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 31 May
 2026 04:41:22 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 31 May 2026 04:41:22 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 31 May 2026 04:41:16 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>
Subject: [PATCH net-next V2 13/13] net/mlx5e: Verify unique vhca_id count instead of range
Date: Sun, 31 May 2026 14:39:53 +0300
Message-ID: <20260531113954.395443-14-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260531113954.395443-1-tariqt@nvidia.com>
References: <20260531113954.395443-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b315a3d-ff9c-4ad8-73cb-08debf0992ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	yYKgLdd9M67OMGSkbslgSD2jv/pwpRd0RTl79JpRLymfPK43nWbRMbDXJjFp0UNWZ0zpsTNY70isfiJu/n8Qi8GwLUT3ZkFgwyI2+Pr5XLepgi7qhaNzW/YMWq0Te9lRg6xo9P3W0Jeprnsvd8ld928exalc9gvWS2XpX6xuBLJwOsJmSJKZv/l9RCO49v5/bhlNdjcSQQOa+MG7N2OGTmzst5JS4qaSmN7XMc2l11/Gb0cjeIdgtVuO6uHf4GNZv0XLtkT2t36BlgfPaTr8gQTetS4A4aO7qFibv76yxCOcHQ1fMnCoh4Smf1GEY9ojjCQVw6a1LSwCub36cG0ynOhs4q1MMKDkt0PbxEtY3Nvu/rfpZvzHlfxYwQenBBA2NQpnU3t8myiV0SObTdS5aLVji/s3YFExrGN2SHwD2zAlks9JtNS/mSOeY9Ld6Vb11hiTxtlqQEjcFzv5FSpfOwrnOzBpMhYG8MYGpd7c4YuM/01S5aQ5O4JV5WPR3x4Hzpf/IXv76yKZKUDY4GR+2hWLMdXlWpiaX3Due/ee8VvVtBEoE4o6MAgelp7d0OwsTUf2efxiMTOAr83H/D6OTdNeJm4fULFnNvLGzlQ/vRDTjNBErUcX06Pnc9dRSq91xASL/UKpUs5FlCD66mh0XffqPn1fAeF+ovq0DysehzfUTCdhDilhLbKLq0d+AOdSIrRX4FqjhzrkOFyEoiduGV+EMzl/W0vQVNBPuZZ7K7U=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4+gdGzjJjtZuCTrXu7WeA6xQ0s1Ccpr8LBj56hOMxiYBCKJ6mvSDLRHPraRS74O4xHbjDEsY7DBUvlieAXyOYiDMbREuuSCxE9IuJgw39a55/9Y5J6KnpT4ph9Bb1bqpS0NRWAJor5j+skW6ZaShxGsCE+ilPYIZd2AvwfWZYMP2PVBmdzey6oPCZs9SOib+N6t2+NljwXbvQj4Q5TAz56bIeJ35PIir0eAub5M0841+pJTWOKq9DpHJvVK+FxxM2DpN9cE4QiDPCKTJ4vgKoY1zXgBFKEqhOek+/t+NSWEcSq0SCOPAR7LRk88Rr21+M6GapNnra3BV8fsXx6X3IKzvWxjp44zlaoqis0PUU/KJhBlyR4nqR5af49qn1qah8jCbLTI0MiE2Nz+2WOA50cl5BSGIlhCmoJGcPT75vbRYS90bajKST9FKsq6aIxAO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 11:41:37.1731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b315a3d-ff9c-4ad8-73cb-08debf0992ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21557-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 60821615DD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

Change verify_num_vhca_ids() to count the number of unique vhca_ids
and verify this count doesn't exceed max_num_vhca_id, rather than
validating individual vhca_id values are within a specific range.

The previous implementation checked if each vhca_id was in the range
[0, max_num_vhca_id - 1], which is overly restrictive. The hardware
capability max_rqt_vhca_id represents the maximum number of unique
vhca_ids that can be used, not a range constraint on individual IDs.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/rqt.c  | 27 ++++++++++++++-----
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
index a3382f6a6b74..8511363f7bec 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
@@ -8,13 +8,28 @@ static bool verify_num_vhca_ids(struct mlx5_core_dev *mdev, u32 *vhca_ids,
 				unsigned int size)
 {
 	unsigned int max_num_vhca_id = MLX5_CAP_GEN_2(mdev, max_rqt_vhca_id);
-	int i;
+	unsigned int unique_count = 0;
+	int i, j;
+
+	/* Count unique vhca_ids */
+	for (i = 0; i < size; i++) {
+		bool is_unique = true;
+
+		/* Check if vhca_ids[i] was already seen */
+		for (j = 0; j < i; j++) {
+			if (vhca_ids[j] == vhca_ids[i]) {
+				is_unique = false;
+				break;
+			}
+		}
+		if (is_unique)
+			unique_count++;
+	}
 
-	/* Verify that all vhca_ids are in range [0, max_num_vhca_ids - 1] */
-	for (i = 0; i < size; i++)
-		if (vhca_ids[i] >= max_num_vhca_id)
-			return false;
-	return true;
+	/* Verify that number of unique vhca_ids doesn't exceed
+	 * max_num_vhca_id
+	 */
+	return unique_count <= max_num_vhca_id;
 }
 
 static bool rqt_verify_vhca_ids(struct mlx5_core_dev *mdev, u32 *vhca_ids,
-- 
2.44.0


