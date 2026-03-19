Return-Path: <linux-rdma+bounces-18383-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPvJAH+pu2nHmQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18383-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 08:45:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 624322C76ED
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 08:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9931B3023056
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 07:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D53F3A3E6A;
	Thu, 19 Mar 2026 07:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RNdcbYP8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010061.outbound.protection.outlook.com [40.93.198.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B529A3A1A3C;
	Thu, 19 Mar 2026 07:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773906284; cv=fail; b=hf2lcpgwF6mJ8YAB6pVv967nQ0sY4Q//OlJNkPXXMEfcpsgGk3yeMDBXLKwE3e5SGelIZxJDnmdqaOOpNZYJfI+r3D7CywADJpFBi7WN1Be1r6S9HilEIL2naOLkcL54/nb3Y09Tq4SeUw34VUyzp0pw9j6aGZy6wJ7tRzCazq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773906284; c=relaxed/simple;
	bh=94xLvKwWcuTFRdHXxn3eg1rMTOKrO4pwnoVRVC0mBIc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7t/WKEHqomMeJs/XOblxlyplEUUZD9TH4aXppvFiXsJP+Vkilu4TGDkKtfuEY9PVLS+1vMYa3KG8Pqweb+bv/kvy3CdtJON9132Np3+MRvaMbOlldCn0kWR0/oMPglbdBwFPBXZlJh0gqo6p5MTqC+CO/wMDsjO1T46iE1TtCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RNdcbYP8; arc=fail smtp.client-ip=40.93.198.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ws4cNnEbLRuO9gDR+QtQc18NyoJLciICiZr5nyVw0TuQWf+oTiGC1ePWSPPFij8TNClOf8yF6EWDWOf2zo4SH7H9dHSzTEO/TMKXdvzBedT0U20rZgwcIl38ND4Z85vIT1kJFd7v5GgwZ8rKplETMwfftT6/Ysx1D2WjNjHqRZjzL3uTepw89xVHbkPQFEnXR8JuHoiHu+5M5fm0YAouxqIfXlwJfk5U2+Adnl8zsLbPxOw5/4wT6p+5hnfHaZoKp5FGnMIkIwdTA66BbymHmch3YkEI/vkLdYsKBIrBIq+fo0Jn3x+dxkHa+DS8YSmmmCbQphCnpOFNmtjR06LERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yBrfIVdQAlfppqd6uJged4pR4HLuPHERprc/MUbQV4=;
 b=NPhj+UkCJozWr80r7rGeY4r05UTYZikx9pHyHuYabrnF8/Fi/eUIB/S4yRX59HktzvQlQV5H6+i5+XMsLd8s6lfWDPun1swwWTolcAcBBlAjHBA4xomsdxyFE1Seyw85u1w5PYDOcK4iBZoer0CQTSUlWuVIdjK89vKM5W1b/iYlPyVvdDYpBCZ+wGsSdZzpCfKKq/NX0mzdoGE9x3+HgIC/HqJ8CFLhN2P1rmDPbSP0Noq8Mc+VZkrnFOxqG01rUP0mM5Jyn0BuGK3Q5mYcnPSPHsFt4HEkVeQslrLnYiaPkGjDRcdJGJNv1nkD9swFE5WPs4RH4f10MAh8w47Rcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yBrfIVdQAlfppqd6uJged4pR4HLuPHERprc/MUbQV4=;
 b=RNdcbYP8/gdKk8hQz8v4QCLFk4AB6MgTAH5fRVykowhsOjyQuKdab0lctbtJcXGWyrA4VDxxGPjiLHR2sxq2yhXRosOXLmwYXe0Qy5cAFBCJ1SBm5AM1yV92O1JeHvR33V/3t3JZo3oJLVO5gQ268y2hrwxbKLQAC9OsC/Rj/ljUv2FQvJpumZ+fVq2H3WcMeWkKj19UmGsXT7huKfCTF3pGsUX+6m4P2U3c34NtSgMKpAyh1rjqTlg20c5EEZdRqt0Ay0FoQTUOHWI9s5MWd1moWlnBIPJAK7cOdc438fDkwFQAh0WRSdlw+/T73zKwYG98qjiiGhkmQk12SKVxiQ==
Received: from PH8P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::17)
 by PH8PR12MB6938.namprd12.prod.outlook.com (2603:10b6:510:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 07:44:35 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::ce) by PH8P221CA0012.outlook.office365.com
 (2603:10b6:510:2d8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 07:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 07:44:35 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 00:44:17 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 00:44:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 19
 Mar 2026 00:44:13 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 3/3] net/mlx5e: Speed up channel creation by initializing MKEY entries via UMR WQE
Date: Thu, 19 Mar 2026 09:43:38 +0200
Message-ID: <20260319074338.24265-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260319074338.24265-1-tariqt@nvidia.com>
References: <20260319074338.24265-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|PH8PR12MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d6f343-7d07-4c04-1ee3-08de858b5dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	vYQgGIU56CxAba9eY52VQDiQejBOYm9WLQFy5eDzJyqgPpRA8G4yska85nfUkSPB7Js7g1l2vIqmxxmNRIsuQozZWHaAWOKL9xlAoLfxJ1Jn5fjiGAaItcWw0O8QYGHvXuxvIhO+UuLa3/W4KuQG3NZ1X79+uukMEEBQZ7tQKZZwaKlh4TQcyLY0+rRnYcpW4gvFTOM4IUsQYclzStp9AcfqIuurjDYaa/LgXwwMAGFHaLul/jyOBr4EXDuKfYTb+vtgp7G1+ihBYnNjTohokot0m+Ud/D9WgLpih4Ggd5UWIjOqlbpgPbk5huaHIcLHCGrD6wWUmkYU5SN4O/00dtkriC391UxZNDgLnpvyfFwU0wdwHHNmcutBifkvQ5e6mZe+elTF/QmEMBAnvtUJnRPzDLoOqjk3lhQKVJjT0nNjsKz7TCVAREskLsL8APq228Ba/wjwu/yhOazcoylYhhQ+0j9q3gNkZyQRrM/uUppqeb99BNJkQMjx7jvVjCr1v3TOjWVWd0TgcPBbKa1vBRrklvA/OtLfJi5jygxi3wjAoCS5j84wI8oGGvNUgkukyTyc5YSu8Lg2hX17AiHXE9wt9QsLlYiGLcZrNkET6XWchBvXPpNgCos+NyJzExB7asetKbeuAHr/vEjNAwV6YZnn10PtqSb/P0g7W/5qRdYCRYw/gcsFBtHHH2Xn2wPUg3nA859iCWSYZ9SFPHfAB4+5kBuXfP/CSYdvL7ORxA//9qzb2fbR0OrnONqU+ozRQ/DNeLtCnQH4+xyZcObFCQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yVobRqYMJPdt6Q5L1D08UnNTIEuMLK7hprz9f28F4YEI6G8nbjEXqGMriejzX9oPF9ILqdWhTsJWsPY8aLnN1hCDBbyThnNPwtjjLi6M0XizSLpGWftW92VhZRjHSZDHG0AOA7LG+h2CTgg7SKJqKtxhZyARczmvXZPbF4YrucptNjNRPi/UG6HPs+Wn/zrBOOqN3tTBsImkDQ0lIgQBRFcopT6TBGNNATpU1l8mNe57178jv+gNehend62qwrqqGbthQY+E+nCV2wVFVC6JW3pXNwydpnaWlB/GSFmNbCDalJJOdqgVscDe+Vvp8ZQK0mOgKbpJBDe1sPriaGKLpJMZzzw6Vi+8ByLCo05Jgdk2OV8JNDPzJjAQ69L6i7AdI5hooQxqDyox+DYx4K0tfGddJJQBAkoxJ+dx41gAlArpHVec3bscVUnZKZCG7C2l
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 07:44:35.1641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d6f343-7d07-4c04-1ee3-08de858b5dbc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6938
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
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18383-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.966];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 624322C76ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Initializing all UMR MKEY entries as part of the CREATE_MKEY firmware
command is relatively slow. Since this operation is performed per RQ,
the cumulative latency becomes significant with a large number of
queues.

Move the entries initialization out of the CREATE_MKEY command and
perform it in the fast path by posting an appropriate UMR WQE on the
ICOSQ.

The UMR WQE is prepared and written to the ICOSQ before activation,
making it safe without additional locking, as it does not race with NOP
postings or early NAPI refills.

Performance results:
Setup: 248 channels, MTU 9000, RX/TX ring size 8K.

Interface up:
Before: 5.618 secs
After:  3.537 secs (2.081 secs faster)

Saves ~8.4 msec per channel.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   6 +
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 237 +++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   1 +
 4 files changed, 185 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 6c773a75b514..1a6c86b5919a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -247,6 +247,7 @@ struct mlx5e_umr_wqe {
 		DECLARE_FLEX_ARRAY(struct mlx5_mtt, inline_mtts);
 		DECLARE_FLEX_ARRAY(struct mlx5_klm, inline_klms);
 		DECLARE_FLEX_ARRAY(struct mlx5_ksm, inline_ksms);
+		DECLARE_FLEX_ARRAY(struct mlx5_wqe_data_seg, dseg);
 	};
 };
 static_assert(offsetof(struct mlx5e_umr_wqe, inline_mtts) == sizeof(struct mlx5e_umr_wqe_hdr),
@@ -747,6 +748,11 @@ struct mlx5e_rq {
 	struct mlx5e_dma_info  wqe_overflow;
 	struct {
 		__be32 umr_mkey_be;
+		struct {
+			void *p_unaligned;
+			int sz;
+			dma_addr_t addr;
+		} init_data;
 	} mpwqe_sp;
 
 	/* XDP read-mostly */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index f2a8453d8dce..948d22f508b0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -64,6 +64,7 @@ ktime_t mlx5e_cqe_ts_to_ns(cqe_ts_to_ns func, struct mlx5_clock *clock, u64 cqe_
 
 enum mlx5e_icosq_wqe_type {
 	MLX5E_ICOSQ_WQE_NOP,
+	MLX5E_ICOSQ_WQE_UMR_RX_INIT,
 	MLX5E_ICOSQ_WQE_UMR_RX,
 #ifdef CONFIG_MLX5_EN_TLS
 	MLX5E_ICOSQ_WQE_UMR_TLS,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5a31c79cec06..eaed05865042 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -348,7 +348,6 @@ static inline void mlx5e_build_umr_wqe(struct mlx5e_rq *rq,
 	ucseg->flags = MLX5_UMR_TRANSLATION_OFFSET_EN | MLX5_UMR_INLINE;
 	octowords = mlx5e_mpwrq_umr_octowords(rq->mpwqe.pages_per_wqe, rq->mpwqe.umr_mode);
 	ucseg->xlt_octowords = cpu_to_be16(octowords);
-	ucseg->mkey_mask     = cpu_to_be64(MLX5_MKEY_MASK_FREE);
 }
 
 static int mlx5e_rq_alloc_mpwqe_info(struct mlx5e_rq *rq, int node)
@@ -397,57 +396,61 @@ static u8 mlx5e_mpwrq_access_mode(enum mlx5e_mpwrq_umr_mode umr_mode)
 	return 0;
 }
 
-static int mlx5e_create_umr_mkey(struct mlx5_core_dev *mdev,
-				 u32 npages, u8 page_shift, u32 *umr_mkey,
-				 dma_addr_t filler_addr,
-				 enum mlx5e_mpwrq_umr_mode umr_mode,
-				 u32 xsk_chunk_size)
+static void mlx5e_rq_umr_mkey_data_free(struct mlx5e_rq *rq)
 {
-	struct mlx5_mtt *mtt;
-	struct mlx5_ksm *ksm;
-	struct mlx5_klm *klm;
-	u32 octwords;
-	int inlen;
-	void *mkc;
-	u32 *in;
-	int err;
-	int i;
+	if (!rq->mpwqe_sp.init_data.p_unaligned)
+		return;
 
-	if ((umr_mode == MLX5E_MPWRQ_UMR_MODE_UNALIGNED ||
-	     umr_mode == MLX5E_MPWRQ_UMR_MODE_TRIPLE) &&
-	    !MLX5_CAP_GEN(mdev, fixed_buffer_size)) {
-		mlx5_core_warn(mdev, "Unaligned AF_XDP requires fixed_buffer_size capability\n");
-		return -EINVAL;
-	}
+	dma_unmap_single(rq->pdev, rq->mpwqe_sp.init_data.addr,
+			 rq->mpwqe_sp.init_data.sz, DMA_TO_DEVICE);
+	kfree(rq->mpwqe_sp.init_data.p_unaligned);
+	rq->mpwqe_sp.init_data.p_unaligned = NULL;
+}
 
-	octwords = mlx5e_mpwrq_umr_octowords(npages, umr_mode);
+static int mlx5e_rq_umr_mkey_data_alloc(struct mlx5e_rq *rq, u32 npages,
+					struct mlx5_wqe_data_seg *dseg)
+{
+	dma_addr_t data_addr;
+	int data_sz;
+	void *data;
 
-	inlen = MLX5_FLEXIBLE_INLEN(mdev, MLX5_ST_SZ_BYTES(create_mkey_in),
-				    MLX5_OCTWORD, octwords);
-	if (inlen < 0)
-		return inlen;
+	data_sz = mlx5e_mpwrq_umr_octowords(npages, rq->mpwqe.umr_mode) *
+		MLX5_OCTWORD;
+	rq->mpwqe_sp.init_data.p_unaligned =
+		kzalloc(data_sz + MLX5_UMR_ALIGN - 1, GFP_KERNEL);
+	if (!rq->mpwqe_sp.init_data.p_unaligned)
+		return -ENOMEM;
 
-	in = kvzalloc(inlen, GFP_KERNEL);
-	if (!in)
+	data = PTR_ALIGN(rq->mpwqe_sp.init_data.p_unaligned, MLX5_UMR_ALIGN);
+	data_addr = dma_map_single(rq->pdev, data, data_sz, DMA_TO_DEVICE);
+	if (dma_mapping_error(rq->pdev, data_addr)) {
+		kfree(rq->mpwqe_sp.init_data.p_unaligned);
+		rq->mpwqe_sp.init_data.p_unaligned = NULL;
 		return -ENOMEM;
+	}
 
-	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
+	rq->mpwqe_sp.init_data.sz = data_sz;
+	rq->mpwqe_sp.init_data.addr = data_addr;
 
-	MLX5_SET(mkc, mkc, free, 1);
-	MLX5_SET(mkc, mkc, umr_en, 1);
-	MLX5_SET(mkc, mkc, lw, 1);
-	MLX5_SET(mkc, mkc, lr, 1);
-	MLX5_SET(mkc, mkc, access_mode_1_0, mlx5e_mpwrq_access_mode(umr_mode));
-	mlx5e_mkey_set_relaxed_ordering(mdev, mkc);
-	MLX5_SET(mkc, mkc, qpn, 0xffffff);
-	MLX5_SET(mkc, mkc, pd, mdev->mlx5e_res.hw_objs.pdn);
-	MLX5_SET64(mkc, mkc, len, npages << page_shift);
-	MLX5_SET(mkc, mkc, translations_octword_size, octwords);
-	if (umr_mode == MLX5E_MPWRQ_UMR_MODE_TRIPLE)
-		MLX5_SET(mkc, mkc, log_page_size, page_shift - 2);
-	else if (umr_mode != MLX5E_MPWRQ_UMR_MODE_OVERSIZED)
-		MLX5_SET(mkc, mkc, log_page_size, page_shift);
-	MLX5_SET(create_mkey_in, in, translations_octword_actual_size, octwords);
+	dseg->addr = cpu_to_be64(data_addr);
+	dseg->byte_count = cpu_to_be32(data_sz);
+	dseg->lkey = rq->mkey_be;
+
+	return 0;
+}
+
+static void mlx5e_rq_umr_mkey_data_fill(struct mlx5e_rq *rq, u32 npages)
+{
+	struct mlx5_core_dev *mdev = rq->mdev;
+	u32 xsk_chunk_size, xsk_rem;
+	dma_addr_t filler_addr;
+	struct mlx5_mtt *mtt;
+	struct mlx5_ksm *ksm;
+	struct mlx5_klm *klm;
+	__be32 mkey_be;
+	void *data;
+	u8 pad;
+	int i;
 
 	/* Initialize the mkey with all MTTs pointing to a default
 	 * page (filler_addr). When the channels are activated, UMR
@@ -455,48 +458,152 @@ static int mlx5e_create_umr_mkey(struct mlx5_core_dev *mdev,
 	 * the RQ's pool, while the gaps (wqe_overflow) remain mapped
 	 * to the default page.
 	 */
-	switch (umr_mode) {
+	filler_addr = rq->wqe_overflow.addr;
+
+	mkey_be = cpu_to_be32(mdev->mlx5e_res.hw_objs.mkey);
+	data = PTR_ALIGN(rq->mpwqe_sp.init_data.p_unaligned, MLX5_UMR_ALIGN);
+
+	switch (rq->mpwqe.umr_mode) {
 	case MLX5E_MPWRQ_UMR_MODE_OVERSIZED:
-		klm = MLX5_ADDR_OF(create_mkey_in, in, klm_pas_mtt);
+		/* Must have xsk_pool != NULL at this point */
+		xsk_chunk_size = rq->xsk_pool->chunk_size;
+		xsk_rem = (1 << rq->mpwqe.page_shift) - xsk_chunk_size;
+		klm = data;
 		for (i = 0; i < npages; i++) {
 			klm[i << 1] = (struct mlx5_klm) {
 				.va = cpu_to_be64(filler_addr),
 				.bcount = cpu_to_be32(xsk_chunk_size),
-				.key = cpu_to_be32(mdev->mlx5e_res.hw_objs.mkey),
+				.key = mkey_be,
 			};
 			klm[(i << 1) + 1] = (struct mlx5_klm) {
 				.va = cpu_to_be64(filler_addr),
-				.bcount = cpu_to_be32((1 << page_shift) - xsk_chunk_size),
-				.key = cpu_to_be32(mdev->mlx5e_res.hw_objs.mkey),
+				.bcount = cpu_to_be32(xsk_rem),
+				.key = mkey_be,
 			};
 		}
 		break;
 	case MLX5E_MPWRQ_UMR_MODE_UNALIGNED:
-		ksm = MLX5_ADDR_OF(create_mkey_in, in, klm_pas_mtt);
+		ksm = data;
 		for (i = 0; i < npages; i++)
 			ksm[i] = (struct mlx5_ksm) {
-				.key = cpu_to_be32(mdev->mlx5e_res.hw_objs.mkey),
+				.key = mkey_be,
 				.va = cpu_to_be64(filler_addr),
 			};
 		break;
 	case MLX5E_MPWRQ_UMR_MODE_ALIGNED:
-		mtt = MLX5_ADDR_OF(create_mkey_in, in, klm_pas_mtt);
+		mtt = data;
 		for (i = 0; i < npages; i++)
 			mtt[i] = (struct mlx5_mtt) {
 				.ptag = cpu_to_be64(filler_addr),
 			};
 		break;
 	case MLX5E_MPWRQ_UMR_MODE_TRIPLE:
-		ksm = MLX5_ADDR_OF(create_mkey_in, in, klm_pas_mtt);
-		for (i = 0; i < npages * 4; i++) {
+		ksm = data;
+		for (i = 0; i < npages * 4; i++)
 			ksm[i] = (struct mlx5_ksm) {
-				.key = cpu_to_be32(mdev->mlx5e_res.hw_objs.mkey),
+				.key = mkey_be,
 				.va = cpu_to_be64(filler_addr),
 			};
-		}
 		break;
 	}
 
+	/* Pad is not expected, as we init the whole MKEY here */
+	pad = mlx5e_mpwrq_umr_entries_pad(npages, rq->mpwqe.umr_mode);
+	WARN_ONCE(pad, "MPWRQ pad is not expected! UMR mode %u npages %d pad %u\n",
+		  rq->mpwqe.umr_mode, npages, pad);
+}
+
+static int mlx5e_rq_umr_mkey_data_init(struct mlx5e_rq *rq, u32 npages)
+
+{
+	struct mlx5_wqe_ctrl_seg      *cseg;
+	struct mlx5_wqe_umr_ctrl_seg *ucseg;
+	struct mlx5e_icosq *sq = rq->icosq;
+	struct mlx5e_umr_wqe *umr_wqe;
+	u16 pi, num_wqebbs, octowords;
+	u8 ds_cnt;
+	int err;
+
+	/* + 1 for the data segment */
+	ds_cnt = 1 + DIV_ROUND_UP(offsetof(struct mlx5e_umr_wqe, dseg),
+				  MLX5_SEND_WQE_DS);
+	num_wqebbs = DIV_ROUND_UP(ds_cnt, MLX5_SEND_WQEBB_NUM_DS);
+	pi = mlx5e_icosq_get_next_pi(sq, num_wqebbs);
+	umr_wqe = mlx5_wq_cyc_get_wqe(&sq->wq, pi);
+	memset(umr_wqe, 0, num_wqebbs * MLX5_SEND_WQE_BB);
+
+	cseg = &umr_wqe->hdr.ctrl;
+	ucseg = &umr_wqe->hdr.uctrl;
+
+	cseg->opmod_idx_opcode =
+		cpu_to_be32((sq->pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) |
+			    MLX5_OPCODE_UMR);
+	cseg->qpn_ds = cpu_to_be32((sq->sqn << MLX5_WQE_CTRL_QPN_SHIFT) |
+				   ds_cnt);
+	cseg->umr_mkey = rq->mpwqe_sp.umr_mkey_be;
+
+	octowords = mlx5e_mpwrq_umr_octowords(npages, rq->mpwqe.umr_mode);
+	ucseg->xlt_octowords = cpu_to_be16(octowords);
+	ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_FREE);
+
+	err = mlx5e_rq_umr_mkey_data_alloc(rq, npages, umr_wqe->dseg);
+	if (err)
+		return err;
+
+	mlx5e_rq_umr_mkey_data_fill(rq, npages);
+
+	sq->db.wqe_info[pi] = (struct mlx5e_icosq_wqe_info) {
+		.wqe_type   = MLX5E_ICOSQ_WQE_UMR_RX_INIT,
+		.num_wqebbs = num_wqebbs,
+		.umr.rq     = rq,
+	};
+
+	sq->pc += num_wqebbs;
+
+	sq->doorbell_cseg = cseg;
+
+	return 0;
+}
+
+static int mlx5e_create_umr_mkey(struct mlx5_core_dev *mdev,
+				 u32 npages, u8 page_shift, u32 *umr_mkey,
+				 enum mlx5e_mpwrq_umr_mode umr_mode)
+{
+	int inlen;
+	void *mkc;
+	u32 *in;
+	int err;
+
+	if ((umr_mode == MLX5E_MPWRQ_UMR_MODE_UNALIGNED ||
+	     umr_mode == MLX5E_MPWRQ_UMR_MODE_TRIPLE) &&
+	    !MLX5_CAP_GEN(mdev, fixed_buffer_size)) {
+		mlx5_core_warn(mdev, "Unaligned AF_XDP requires fixed_buffer_size capability\n");
+		return -EINVAL;
+	}
+
+	inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
+	in = kvzalloc(inlen, GFP_KERNEL);
+	if (!in)
+		return -ENOMEM;
+
+	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
+
+	MLX5_SET(mkc, mkc, free, 1);
+	MLX5_SET(mkc, mkc, umr_en, 1);
+	MLX5_SET(mkc, mkc, lw, 1);
+	MLX5_SET(mkc, mkc, lr, 1);
+	MLX5_SET(mkc, mkc, access_mode_1_0, mlx5e_mpwrq_access_mode(umr_mode));
+	mlx5e_mkey_set_relaxed_ordering(mdev, mkc);
+	MLX5_SET(mkc, mkc, qpn, 0xffffff);
+	MLX5_SET(mkc, mkc, pd, mdev->mlx5e_res.hw_objs.pdn);
+	MLX5_SET64(mkc, mkc, len, npages << page_shift);
+	MLX5_SET(mkc, mkc, translations_octword_size,
+		 mlx5e_mpwrq_umr_octowords(npages, umr_mode));
+	if (umr_mode == MLX5E_MPWRQ_UMR_MODE_TRIPLE)
+		MLX5_SET(mkc, mkc, log_page_size, page_shift - 2);
+	else if (umr_mode != MLX5E_MPWRQ_UMR_MODE_OVERSIZED)
+		MLX5_SET(mkc, mkc, log_page_size, page_shift);
+
 	err = mlx5_core_create_mkey(mdev, umr_mkey, in, inlen);
 
 	kvfree(in);
@@ -505,7 +612,6 @@ static int mlx5e_create_umr_mkey(struct mlx5_core_dev *mdev,
 
 static int mlx5e_create_rq_umr_mkey(struct mlx5_core_dev *mdev, struct mlx5e_rq *rq)
 {
-	u32 xsk_chunk_size = rq->xsk_pool ? rq->xsk_pool->chunk_size : 0;
 	u32 wq_size = mlx5_wq_ll_get_size(&rq->mpwqe.wq);
 	u32 num_entries, max_num_entries;
 	u32 umr_mkey;
@@ -522,9 +628,16 @@ static int mlx5e_create_rq_umr_mkey(struct mlx5_core_dev *mdev, struct mlx5e_rq
 			      max_num_entries);
 
 	err = mlx5e_create_umr_mkey(mdev, num_entries, rq->mpwqe.page_shift,
-				    &umr_mkey, rq->wqe_overflow.addr,
-				    rq->mpwqe.umr_mode, xsk_chunk_size);
+				    &umr_mkey, rq->mpwqe.umr_mode);
+	if (err)
+		return err;
+
 	rq->mpwqe_sp.umr_mkey_be = cpu_to_be32(umr_mkey);
+
+	err = mlx5e_rq_umr_mkey_data_init(rq, num_entries);
+	if (err)
+		mlx5_core_destroy_mkey(mdev, umr_mkey);
+
 	return err;
 }
 
@@ -1097,6 +1210,7 @@ static void mlx5e_free_rq(struct mlx5e_rq *rq)
 	case MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ:
 		mlx5e_rq_free_shampo(rq);
 		kvfree(rq->mpwqe.info);
+		mlx5e_rq_umr_mkey_data_free(rq);
 		mlx5_core_destroy_mkey(rq->mdev,
 				       be32_to_cpu(rq->mpwqe_sp.umr_mkey_be));
 		mlx5e_free_mpwqe_rq_drop_page(rq);
@@ -1275,8 +1389,11 @@ int mlx5e_wait_for_min_rx_wqes(struct mlx5e_rq *rq, int wait_time)
 	u16 min_wqes = mlx5_min_rx_wqes(rq->wq_type, mlx5e_rqwq_get_size(rq));
 
 	do {
-		if (mlx5e_rqwq_get_cur_sz(rq) >= min_wqes)
+		if (mlx5e_rqwq_get_cur_sz(rq) >= min_wqes) {
+			/* memory usage completed, can be freed already */
+			mlx5e_rq_umr_mkey_data_free(rq);
 			return 0;
+		}
 
 		msleep(20);
 	} while (time_before(jiffies, exp_time));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 580bb51ad7ef..5edaa416cedd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -837,6 +837,7 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
 				wi->umr.rq->mpwqe.umr_completed++;
 				break;
 			case MLX5E_ICOSQ_WQE_NOP:
+			case MLX5E_ICOSQ_WQE_UMR_RX_INIT:
 				break;
 #ifdef CONFIG_MLX5_EN_TLS
 			case MLX5E_ICOSQ_WQE_UMR_TLS:
-- 
2.44.0


