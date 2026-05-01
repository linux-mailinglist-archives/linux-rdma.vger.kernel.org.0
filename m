Return-Path: <linux-rdma+bounces-19824-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB0EFBEs9GlA+wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19824-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:29:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC674AA56A
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DEB6A303C84B
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 04:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC5E2FB965;
	Fri,  1 May 2026 04:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OmPCRlNQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013051.outbound.protection.outlook.com [40.93.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E782F6184;
	Fri,  1 May 2026 04:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777609087; cv=fail; b=MsFmco2R+cC4/PJJUNuubwxMjzsPAIAupMONBBaJszN7oLqeuALh3wce1odPt/RRtUfNSg/vDd7U4drVFPcKTOqDw4BZe07xGkMBB8A+FDCPwU35ggbONmUAeyNThBnTImc02rleqqXov2aHpPBqgFMRbx0/J727SlQsZpY3cTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777609087; c=relaxed/simple;
	bh=kRXVOzEuNO1LoWonja6ngg99LOrhbZNA/YXU22pKq7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGPCTzjtnV9NgNpVfvgphDGKr7IVdrKAr/6iBtB6noOVzv/X68Yi4+q1HcKnAZNmXsoQ9sZRxQve/Fg4CsmnUUqUaSIBWxMwwwlqs9purA0pnb86XL/tPsRuL1GMSeTnq3DwjS1iuSumumVm/0Nmo5/LxuZsQv4VEhCq2CWGVtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OmPCRlNQ; arc=fail smtp.client-ip=40.93.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/Bd4Rv+z1KK68QhMVHr6eKq3+Leme26uIGSXReUX/R+B6tJYkNuzGVFUT5U8V3tDFJB3c6eGkSTlF07H2pbLkLr2bBE6uFJ8eLODPwpKtMtQwcZcJ4sp4vlvw/KPIhdmIfDLweRJOuNJhjNPDa7zJ1jKm7mjQWuPVmRKs0f2jEX8WuFPg72pwFakXzX2g/Y6eBNNdiLoRLEnRKPSUTsWbnsmSfu+Rpp6fRpousPZ97lruqplK974zpTLqeKOmvvgKhT94ZuoQs6hI7bPJyzTITzK9O/JZgtFqiztnizCh8ZekE/qj4t/FcWbIymBwHNcHOCQO2Do0RIomkjBvKj9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgTZFWlC4b/UIair2f0ioc7IeaDP2a2LXWdZCJ5DuK4=;
 b=ZuQmB24nXPdH6EgHg7bSHFXzk1BKWhk0KDV02WHHvmOShl8PAEz1jZwFXZIgx0qD6PBnu09Nd/B0hH0y2oXMxaZNrTIlDy45Ngab0nEBCkDC0OZB1V8/344J6gdzx77lkEMz2P6B4W18iWcmDgnVh6nzKedxPwTpgw8KSH/NXYzl13dNbzy2z4cUxT7WNvSX27cHFYYv6j4uZsAsd7NkPQ3z9OFpGt+6j2GrLJ6EnV39nE6TvQXZGkZAuHm7MKEBw/45PX9tSrul3vXPEa2gWmHZr02lhjZKgl9qccZSItkJPlVYcwVspm0eg8d1k1VCk5By2lIfhPNbfKfVfYLz5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgTZFWlC4b/UIair2f0ioc7IeaDP2a2LXWdZCJ5DuK4=;
 b=OmPCRlNQhHnFQA86X4E4O2kLr/PYGgvjt5XxmSJPJ3UdSr97h/JJKIguOwvfcMrJRuZcZOFEJrfrlYx8LSSJq8lv4J57tAh7f0wo1RZs+hiE4NwtkPd+S4+20T6BWpGVXFNFCQ2dBkMXWnXzdkGxr5g+z7TnpOi7EiDR5ZH0JVA1+VqM0qSjKmFDjORGs3xtTklcTZt3GQMmMvF55yOS0dQSWtOANw04CKeZZaDJ+EydGhcCcQx7DXCfeRIDNOU0uHCEd+TW44hXTgkjGsPm4Wu5bPBgU4XVEDlIF/SwvkpYE97tRgzcU1eq9eZLOct0rDvCyDQwNb6QS8XBDGsgcg==
Received: from SN1PR12CA0067.namprd12.prod.outlook.com (2603:10b6:802:20::38)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Fri, 1 May
 2026 04:17:59 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::84) by SN1PR12CA0067.outlook.office365.com
 (2603:10b6:802:20::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Fri,
 1 May 2026 04:17:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 1 May 2026 04:17:58 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:17:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:17:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Apr 2026 21:17:35 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shay Drory <shayd@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>, Maher Sanalla
	<msanalla@nvidia.com>, Simon Horman <horms@kernel.org>, Gerd Bayer
	<gbayer@linux.ibm.com>, Moshe Shemesh <moshe@nvidia.com>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 3/7] net/mlx5: Lag, avoid LAG and representor lock cycles
Date: Fri, 1 May 2026 07:16:29 +0300
Message-ID: <20260501041633.231662-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260501041633.231662-1-tariqt@nvidia.com>
References: <20260501041633.231662-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|MN2PR12MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: fc06be2e-6032-42b0-b197-08dea738a0cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wfd4xCD9vuSmM/DZTv1XYAHoFDyelg4rrD9JdRjtUe250xLtAFk9BENIX8hLxmOzyFvMC77xSlFreqpgijeHKuqNqyz5VvQDPKw2vmohScmdYL/U81vv28CfGacbo+3PmGnWLYmmxsaEhUPBfhS595Ih+C2/yT6u27x1Tgvvt48HpA1g6k1uLSkLI1xS1hYtg+mRfHRxGiiT1TvUtyeJZdZq40/5UyrZXn2G9Pq4j4LnEyvdrqo1dqJE428zNW7+ZA2+jbB1S5GiNnf9f/QXCAl58TiD5yYxp+WXtRcC2lc/80SIDAs/EkmVZPa3TOC6NlQmISYxU7b/waMTVsbFslp9oAsbPn34CYAKgAHlTbVAF5t9xuQBpvEFRzhM87qBq+O1EwjWIlKDaga+aLfuDsfAxED4FZOT+Wb7b1MQ1uPC1niUoW1vqpvBEG/acp+d6esRMjGa1dbz+hkEyiSbFR06nocxHg5nvW5qmpChGEt1fEdDvMKPli+neZjj9+bM2lRrCwrrHgvCLmT1Xd2PeoksvH3I3OwNlb0TyqO8KEY2DL2oRzY7lw617YKCKx33riRxsoTJVgVd54qLGvnM+ExxT5evMpV49WU3QwcxrmDU4OzYgA46JWKKj634Y8TllTam6BbnLfvtS3ZzP3CkM8TVf0njiYTx5UR9vrlpQRv/bECGztPorQI3vMKxM8dTbWFCa1qqTcF5EZoaraDgSrgAudYuvLpRUiPAQ07rKBU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jz85U8bh0Cfl4E15umQ4DIPAbVgPx9BRp54hsUcP+BLKtJhhQhY0BJz/5PGkYRLdcz/yV2HHggcWorCRtv/TKIFKymul9Szs2LXz44iEZOstyiS/x2xFVaoVBU1wPHzVF6vfaA7ykAXdnKh4AtBSEt6ARljFyxF6rNjQ3a1feaC/IojZFEAZ4pS9rSHp4zam08HmKaGGJpHZ6Uiz11bVjKLscgepTeExgRjRkh5S39CoN7CfFEPXNZNkfXlrOfxGCLPcH05r824C55dzaTG0pInyc8pCBqa/3JfXKKRWYsS0pn+0q5mwbCO/HGumU1G05Q5lEbIjtbcrYUMjZtTtivPztKTDAuldnA2ic4x/w6EaEXXdAV6anfJKw41IGgc4mU14mMo9JT0h9Gqn1msDW+MbhVpE4Vbq83VZ0q+r5RuROOljog8DjVHqcNAt5lDo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 04:17:58.9626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc06be2e-6032-42b0-b197-08dea738a0cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176
X-Rspamd-Queue-Id: 6DC674AA56A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19824-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Mark Bloch <mbloch@nvidia.com>

The LAG shared-FDB and multiport E-Switch transitions rescan auxiliary
devices and reload IB representors while holding ldev->lock. Driver
bind/unbind paths may register or unregister E-Switch representor ops, and
representor load paths may enter LAG code, so holding ldev->lock across
those calls creates lock-order cycles with the E-Switch representor lock.

Keep the devcom component locked for the transition, but drop ldev->lock
before rescanning auxiliary devices or reloading IB representors. Mark the
LAG transition as in progress while the lock is dropped and assert the
devcom lock where the helper relies on it. This preserves LAG serialization
while avoiding ldev->lock nesting under E-Switch representor registration.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 142 ++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |   7 +-
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  10 +-
 .../ethernet/mellanox/mlx5/core/lib/devcom.c  |   8 +
 .../ethernet/mellanox/mlx5/core/lib/devcom.h  |   1 +
 5 files changed, 134 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index a474f970e056..e77f9931c39c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1063,37 +1063,99 @@ bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 	return true;
 }
 
-void mlx5_lag_add_devices(struct mlx5_lag *ldev)
+static void mlx5_lag_assert_locked_transition(struct mlx5_lag *ldev)
 {
+	struct mlx5_devcom_comp_dev *devcom = NULL;
 	struct lag_func *pf;
 	int i;
 
-	mlx5_ldev_for_each(i, 0, ldev) {
-		pf = mlx5_lag_pf(ldev, i);
-		if (pf->dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV)
-			continue;
+	lockdep_assert_held(&ldev->lock);
 
-		pf->dev->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
-		mlx5_rescan_drivers_locked(pf->dev);
+	i = mlx5_get_next_ldev_func(ldev, 0);
+	if (i < MLX5_MAX_PORTS) {
+		pf = mlx5_lag_pf(ldev, i);
+		devcom = pf->dev->priv.hca_devcom_comp;
 	}
+	mlx5_devcom_comp_assert_locked(devcom);
 }
 
-void mlx5_lag_remove_devices(struct mlx5_lag *ldev)
+static void mlx5_lag_drop_lock_for_reps(struct mlx5_lag *ldev)
+{
+	mlx5_lag_assert_locked_transition(ldev);
+
+	/* Keep PF membership stable while ldev->lock is dropped. Device add
+	 * and remove paths observe mode_changes_in_progress and retry.
+	 */
+	ldev->mode_changes_in_progress++;
+	mutex_unlock(&ldev->lock);
+}
+
+static void mlx5_lag_retake_lock_after_reps(struct mlx5_lag *ldev)
 {
+	mutex_lock(&ldev->lock);
+	ldev->mode_changes_in_progress--;
+}
+
+void mlx5_lag_rescan_dev_locked(struct mlx5_lag *ldev,
+				struct mlx5_core_dev *dev,
+				bool enable)
+{
+	if (dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV)
+		return;
+
+	if (enable)
+		dev->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
+	else
+		dev->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
+
+	/* Auxiliary bus probe/remove can register or unregister representor
+	 * callbacks and take reps_lock. Drop ldev->lock so the only ordering
+	 * remains reps_lock -> ldev->lock from representor callbacks.
+	 */
+	mlx5_lag_drop_lock_for_reps(ldev);
+	mlx5_rescan_drivers_locked(dev);
+	mlx5_lag_retake_lock_after_reps(ldev);
+}
+
+static void mlx5_lag_rescan_devices_locked(struct mlx5_lag *ldev, bool enable)
+{
+	struct mlx5_core_dev *devs[MLX5_MAX_PORTS];
 	struct lag_func *pf;
+	int num_devs = 0;
 	int i;
 
+	mlx5_lag_assert_locked_transition(ldev);
+
 	mlx5_ldev_for_each(i, 0, ldev) {
 		pf = mlx5_lag_pf(ldev, i);
 		if (pf->dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV)
 			continue;
 
-		pf->dev->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
-		mlx5_rescan_drivers_locked(pf->dev);
+		if (enable)
+			pf->dev->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
+		else
+			pf->dev->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
+		devs[num_devs++] = pf->dev;
 	}
+
+	mlx5_lag_drop_lock_for_reps(ldev);
+	for (i = 0; i < num_devs; i++)
+		mlx5_rescan_drivers_locked(devs[i]);
+	mlx5_lag_retake_lock_after_reps(ldev);
 }
 
-int mlx5_lag_reload_ib_reps(struct mlx5_lag *ldev, u32 flags, bool cont_on_fail)
+void mlx5_lag_add_devices(struct mlx5_lag *ldev)
+{
+	mlx5_lag_rescan_devices_locked(ldev, true);
+}
+
+void mlx5_lag_remove_devices(struct mlx5_lag *ldev)
+{
+	mlx5_lag_rescan_devices_locked(ldev, false);
+}
+
+static int mlx5_lag_reload_ib_reps_unlocked(struct mlx5_lag *ldev, u32 flags,
+					    bool cont_on_fail)
 {
 	struct lag_func *pf;
 	int ret;
@@ -1105,7 +1167,9 @@ int mlx5_lag_reload_ib_reps(struct mlx5_lag *ldev, u32 flags, bool cont_on_fail)
 			struct mlx5_eswitch *esw;
 
 			esw = pf->dev->priv.eswitch;
+			mlx5_esw_reps_block(esw);
 			ret = mlx5_eswitch_reload_ib_reps(esw);
+			mlx5_esw_reps_unblock(esw);
 			if (ret && !cont_on_fail)
 				return ret;
 		}
@@ -1114,6 +1178,34 @@ int mlx5_lag_reload_ib_reps(struct mlx5_lag *ldev, u32 flags, bool cont_on_fail)
 	return 0;
 }
 
+static int mlx5_lag_reload_ib_reps(struct mlx5_lag *ldev, u32 flags,
+				   bool cont_on_fail)
+{
+	int ret;
+
+	/* The HCA devcom component lock serializes LAG mode transitions while
+	 * ldev->lock is dropped here. Dropping ldev->lock is required because
+	 * the reload takes the per-E-Switch reps_lock, and representor
+	 * load/unload callbacks can re-enter LAG netdev add/remove and take
+	 * ldev->lock. Keep the ordering reps_lock -> ldev->lock.
+	 */
+	mlx5_lag_drop_lock_for_reps(ldev);
+	ret = mlx5_lag_reload_ib_reps_unlocked(ldev, flags, cont_on_fail);
+	mlx5_lag_retake_lock_after_reps(ldev);
+
+	return ret;
+}
+
+int mlx5_lag_reload_ib_reps_from_locked(struct mlx5_lag *ldev, u32 flags,
+					bool cont_on_fail)
+{
+	int ret;
+
+	ret = mlx5_lag_reload_ib_reps(ldev, flags, cont_on_fail);
+
+	return ret;
+}
+
 void mlx5_disable_lag(struct mlx5_lag *ldev)
 {
 	bool shared_fdb = test_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, &ldev->mode_flags);
@@ -1132,10 +1224,7 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 	if (shared_fdb) {
 		mlx5_lag_remove_devices(ldev);
 	} else if (roce_lag) {
-		if (!(dev0->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV)) {
-			dev0->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
-			mlx5_rescan_drivers_locked(dev0);
-		}
+		mlx5_lag_rescan_dev_locked(ldev, dev0, false);
 		mlx5_ldev_for_each(i, 0, ldev) {
 			if (i == idx)
 				continue;
@@ -1151,8 +1240,9 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 		mlx5_lag_add_devices(ldev);
 
 	if (shared_fdb)
-		mlx5_lag_reload_ib_reps(ldev, MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV,
-					true);
+		mlx5_lag_reload_ib_reps_from_locked(ldev,
+						    MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV,
+						    true);
 }
 
 bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
@@ -1409,7 +1499,8 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 			if (shared_fdb || roce_lag)
 				mlx5_lag_add_devices(ldev);
 			if (shared_fdb)
-				mlx5_lag_reload_ib_reps(ldev, 0, true);
+				mlx5_lag_reload_ib_reps_from_locked(ldev, 0,
+								    true);
 
 			return;
 		}
@@ -1417,8 +1508,7 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 		if (roce_lag) {
 			struct mlx5_core_dev *dev;
 
-			dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
-			mlx5_rescan_drivers_locked(dev0);
+			mlx5_lag_rescan_dev_locked(ldev, dev0, true);
 			mlx5_ldev_for_each(i, 0, ldev) {
 				if (i == idx)
 					continue;
@@ -1427,15 +1517,15 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 					mlx5_nic_vport_enable_roce(dev);
 			}
 		} else if (shared_fdb) {
-			dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
-			mlx5_rescan_drivers_locked(dev0);
-			err = mlx5_lag_reload_ib_reps(ldev, 0, false);
+			mlx5_lag_rescan_dev_locked(ldev, dev0, true);
+			err = mlx5_lag_reload_ib_reps_from_locked(ldev, 0,
+								  false);
 			if (err) {
-				dev0->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
-				mlx5_rescan_drivers_locked(dev0);
+				mlx5_lag_rescan_dev_locked(ldev, dev0, false);
 				mlx5_deactivate_lag(ldev);
 				mlx5_lag_add_devices(ldev);
-				mlx5_lag_reload_ib_reps(ldev, 0, true);
+				mlx5_lag_reload_ib_reps_from_locked(ldev, 0,
+								    true);
 				mlx5_core_err(dev0, "Failed to enable lag\n");
 				return;
 			}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index daca8ebd5256..6afe7707d076 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -164,6 +164,9 @@ void mlx5_disable_lag(struct mlx5_lag *ldev);
 void mlx5_lag_remove_devices(struct mlx5_lag *ldev);
 int mlx5_deactivate_lag(struct mlx5_lag *ldev);
 void mlx5_lag_add_devices(struct mlx5_lag *ldev);
+void mlx5_lag_rescan_dev_locked(struct mlx5_lag *ldev,
+				struct mlx5_core_dev *dev,
+				bool enable);
 struct mlx5_devcom_comp_dev *mlx5_lag_get_devcom_comp(struct mlx5_lag *ldev);
 
 #ifdef CONFIG_MLX5_ESWITCH
@@ -199,6 +202,6 @@ int mlx5_get_next_ldev_func(struct mlx5_lag *ldev, int start_idx);
 int mlx5_lag_get_dev_index_by_seq(struct mlx5_lag *ldev, int seq);
 int mlx5_lag_num_devs(struct mlx5_lag *ldev);
 int mlx5_lag_num_netdevs(struct mlx5_lag *ldev);
-int mlx5_lag_reload_ib_reps(struct mlx5_lag *ldev, u32 flags,
-			    bool cont_on_fail);
+int mlx5_lag_reload_ib_reps_from_locked(struct mlx5_lag *ldev, u32 flags,
+					bool cont_on_fail);
 #endif /* __MLX5_LAG_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index edcd06f3be7a..8a349f8fd823 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -100,9 +100,8 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
 		goto err_add_devices;
 	}
 
-	dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
-	mlx5_rescan_drivers_locked(dev0);
-	err = mlx5_lag_reload_ib_reps(ldev, 0, false);
+	mlx5_lag_rescan_dev_locked(ldev, dev0, true);
+	err = mlx5_lag_reload_ib_reps_from_locked(ldev, 0, false);
 	if (err)
 		goto err_rescan_drivers;
 
@@ -111,12 +110,11 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
 	return 0;
 
 err_rescan_drivers:
-	dev0->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
-	mlx5_rescan_drivers_locked(dev0);
+	mlx5_lag_rescan_dev_locked(ldev, dev0, false);
 	mlx5_deactivate_lag(ldev);
 err_add_devices:
 	mlx5_lag_add_devices(ldev);
-	mlx5_lag_reload_ib_reps(ldev, 0, true);
+	mlx5_lag_reload_ib_reps_from_locked(ldev, 0, true);
 	mlx5_mpesw_metadata_cleanup(ldev);
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
index 4b5ac2db55ce..d40c53193ea8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -3,6 +3,7 @@
 
 #include <linux/mlx5/vport.h>
 #include <linux/list.h>
+#include <linux/lockdep.h>
 #include "lib/devcom.h"
 #include "lib/mlx5.h"
 #include "mlx5_core.h"
@@ -438,3 +439,10 @@ int mlx5_devcom_comp_trylock(struct mlx5_devcom_comp_dev *devcom)
 		return 0;
 	return down_write_trylock(&devcom->comp->sem);
 }
+
+void mlx5_devcom_comp_assert_locked(struct mlx5_devcom_comp_dev *devcom)
+{
+	if (!devcom)
+		return;
+	lockdep_assert_held_write(&devcom->comp->sem);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
index 91e5ae529d5c..316052a85ca5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
@@ -75,5 +75,6 @@ void *mlx5_devcom_get_next_peer_data_rcu(struct mlx5_devcom_comp_dev *devcom,
 void mlx5_devcom_comp_lock(struct mlx5_devcom_comp_dev *devcom);
 void mlx5_devcom_comp_unlock(struct mlx5_devcom_comp_dev *devcom);
 int mlx5_devcom_comp_trylock(struct mlx5_devcom_comp_dev *devcom);
+void mlx5_devcom_comp_assert_locked(struct mlx5_devcom_comp_dev *devcom);
 
 #endif /* __LIB_MLX5_DEVCOM_H__ */
-- 
2.44.0


