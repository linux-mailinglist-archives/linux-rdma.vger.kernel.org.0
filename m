Return-Path: <linux-rdma+bounces-20178-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iODlJHHN/GlhTwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20178-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 19:35:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 155294ECEBF
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 19:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0889C3022F7C
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 17:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1653B36215B;
	Thu,  7 May 2026 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d4CbfEFF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D5240DFC9;
	Thu,  7 May 2026 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175342; cv=fail; b=alco9WlqfCrh/8LTv3dawkltPjii4rLLj4NcRtJuZg2UHd+JR6TVPwqoeoCE/gdsgYYTRntXp3U2e8rcxc+YuMHZwMUdjdJzEn1RTfw4VKxCHyn84lyvpl6y2iGyCCOu9yBI8aZFaONY+vl5N7oo8wIgEKy0uNlfCWbQhCgrTrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175342; c=relaxed/simple;
	bh=kadgJvTW7uYf2Qh/UH/e7pzex/1WdAOCa5nHnNtV8tQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4FLrCrBMsWl4POYoEG54ZOD0Kx2CAZo5QYrQC6Ifmsj/u7+PQkaMG+mdGfXN2N1WdMaRCnKFSYgooJbBndIWtym3tyU8XxHStkt4VtlgVQJRYqPp+kAvOkqB4kMgUSOo+WnqeK19LhicNUk/iuS96oxXt8PgNsKMHe/FjqJQFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d4CbfEFF; arc=fail smtp.client-ip=52.101.48.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rclLRuFwjEFlO6wiie/sFPO7sK77iHXe6+MskcuoPx10EcUzDDrvK04IzOqCQZ56tA/lmKVsXd/OaqQwNT3NopJ1wquCNYDRp4dcaxw15q8OwcNGt1phkkp4DaP7fedUEbZ0Cpzo/UncLCT1GvS7Bnk2eyUm4l14bDv2NCSl6N5hjklMkgt/7xuusx4XAyCRs8HLjW6lIB9a4OWh//G957Q5RnGL0iLbbByzshcJQ+4gPjRoGW4f+LjE57EL6HG32rWMmAPSqv8knMzs4/jrKVVu9NJu2lvULfYQ+B3fZhKeNm0/R/pZxOtA52b7o4kpD+mFfsE+3L89MqlOPEt3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wczYDBeORAW0ZI87MEYcI4s9Lwv/Ry/lcyyPVlKPwg=;
 b=WaDxAcOqMBgRA+TMFugZPtnOrCM/9VUdPHfxDxlXhOs2Q6Z40QaP14lcA+0geLk6/PRK1ZmM3X/MFiiw8V7ZNnE2JkEBKLrBUvoFlmk/HjW/5nDISrmRbiL9fqD4YA3+T/6cTidw66/OH/mO9q0qm6Q7WzLmKGF+k0DcI7Y7zA7xwgYZqgtVLp6ajBIOuDzKJGIYMJo+cM73QkrNCfihIWpbbvJW2VfzyoRJh+/JXlXtqSUe2PWKQXFX9zioo57oDu9V+p94gbKYNzHuy3bB5juPzOaBmGdqbqwDVXnXDgiaR4nL1kABMosCtB/EOKj6atnlaKdeGFLfQ0d9U0D+Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=openai.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wczYDBeORAW0ZI87MEYcI4s9Lwv/Ry/lcyyPVlKPwg=;
 b=d4CbfEFFFW1LBpDsdGbHkGiG1Lkbv6tTFeLP9rwEVnRcG5w5McefQWr7Pyl6EwsFxELevIv9tqU0vxXe46vfC786wJ3qGkl2/Q1HMNPb14bVAPwbn4D8kNml7oDmjetrcQCEzI65momSJ1a9jGXzdyZgrF9gLF2FNnOPhdZKFJcfpLG61yVtLJVFj/xKbLVueTGAXmkR7RQtFAoUXa+v9NSKG6XjXQXihhsy8/mxz40KwZ211z6jJSScGlivcCFkpluzPB963IvtN2DsidUrKnHjCU/4x8/k/QynHq4BXJNVT1lTxviwgvJahROL6/JG0qe/g1zn5PR075mVgNambQ==
Received: from BN9P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::18)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 17:35:36 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:13e:cafe::3a) by BN9P220CA0013.outlook.office365.com
 (2603:10b6:408:13e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Thu,
 7 May 2026 17:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 17:35:35 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 10:35:13 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 10:35:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 7 May
 2026 10:35:07 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Christoph Paasch <cpaasch@openai.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Yevgeny
 Kliteynik" <kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, "Simon
 Horman" <horms@kernel.org>, Kees Cook <kees@kernel.org>, Alex Vesker
	<valex@nvidia.com>, Erez Shitrit <erezsh@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Shay Drori <shayd@nvidia.com>
Subject: [PATCH net-next 1/3] net/mlx5: HWS, Check if device is down while polling for completion
Date: Thu, 7 May 2026 20:34:41 +0300
Message-ID: <20260507173443.320465-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260507173443.320465-1-tariqt@nvidia.com>
References: <20260507173443.320465-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 32204b0d-ffa7-4b08-6701-08deac5f0c20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|1800799024|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	qWNLCPT0Y2SAA0Mzg2Rjpzrf1Cz/FkD0JpOBGGCuOJgjG2rMVm9ZG+KNAucaoN62Pq04YKdQF6uvdsITGZn0GVVGTOGYRkPxaGDRKADNCE/aXnUENOBsb1EikGywvE0CmhWXR3Cvoz8DbAa9LREbjTwBEB0YvDuQ3LxeMUMXbLRlCmH7x09jim6VOX92xGUW38NIVQmnPYiaPCxz6bSeh5WlzsXxbs5GLIS4FsghxG3UhGsW8MGh9EhnynhXsNyZ18rtkTn8DSkFF92rEfxNAgc+IGWwIxoviVNspHFamLRrIxJ8H0JZWUWWaJtzZaanOQK09q+fI1UaBSiO9hJ1k2nShXHje6PW2xkVV95jvMYap6fQg+muSWn8b+dYMx23yoQbe7jecvDHFJyaSGSSGc6Cr/e6Z06NWUZOLn0e8yzmZjFBE48v5EYb4wHBKKg7RcKuNILv+dfE3j7DDKyyUqimIdT8alTjN76L+qDbdF7U+aeYi87m8Rsyg05/0Gy47JXNXH4Jsrd+XI21GlKqIRH0DPxHJW4/gojnzsogT974jzqJgHgFJVirEDVRHr7MVb/EBMVDviqBhEAaSkrjN+FRFZZ2h2VIc2klG8Z1CeXatXoBI/sBKmKw++rElgDxwTqgz3NeZ5EZRKUNwiuIAOGnnSpViSpiaSUrqEoxCov0XHnta3QH2sPyJi4cqIhmyOlnaO+eBjFGoks209DdimAMQ+fwZ2UeR5qhv3RHluA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uTgBk/IJA+F3pIiU5KTlQQituX8B/hb63pU2EDbSghu4GS/KCMz+KAKQWY20SvKWcW7fgUqtP6CN8MxzIeTPNjSh62g6fWO8lAsZ8C51iqVjiEKBaKp9Qu4DrV+Q4LO+zRfz+k+jwo3q9Gg1QCRrjPR6IiGjFEOEozVgbXeuXErDs/HbEn8Np3WxZ+mQW8WNA4KPQ7vFnjSFqgvEiQDrdJmzQ5B1Yj5w3L9lY7Wn38107XF6gX6Qtx+NZomVm6SBVywAtsiC83/ZY4ZIYqvtL8FwqKh/ntLD5yAtDZREDxwSO/wF5Sk6ytnjw/HmVANMBJj0SWXIkeHDs0n7Bwyauy8+ekd6kZFn13mA/snEkWWoq53u59PcpklzvHIughtQlSZfmQ4oJTUMhvn2iyd08vBzFb9IgE8jfgcf9tyixL06WOTVTxPVGMjFR23c3x1H
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 17:35:35.6742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32204b0d-ffa7-4b08-6701-08deac5f0c20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456
X-Rspamd-Queue-Id: 155294ECEBF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20178-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

In case the device is down for any reason (e.g. FLR),
the HW will no longer generate completions - no point
polling and waiting for timeout.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Erez Shitrit <erezsh@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/steering/hws/bwc.c   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 6dcd9c2a78aa..eae02bc74221 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -422,6 +422,18 @@ int mlx5hws_bwc_queue_poll(struct mlx5hws_context *ctx,
 	if (!got_comp && !drain)
 		return 0;
 
+	if (unlikely(ctx->mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)) {
+		/* If the device is down for any reason (e.g. FLR), the HW will
+		 * no longer generate completions.
+		 * Note that ETIMEDOUT is returned here because the BWC layer
+		 * already has a special handling for timeouts - it breaks the
+		 * rehash / resize / shrink loops to avoid chain of timeouts.
+		 */
+		mlx5_core_warn_once(ctx->mdev,
+				    "BWC poll: device is down, polling for completion aborted\n");
+		return -ETIMEDOUT;
+	}
+
 	queue_full = mlx5hws_send_engine_full(&ctx->send_queue[queue_id]);
 	while (queue_full || ((got_comp || drain) && *pending_rules)) {
 		ret = mlx5hws_send_queue_poll(ctx, queue_id, comp, burst_th);
-- 
2.44.0


