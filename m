Return-Path: <linux-rdma+bounces-19945-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Jr1Dpzn+Gmt2wIAu9opvQ
	(envelope-from <linux-rdma+bounces-19945-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:38:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 356144C2A7D
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04F0630055FD
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 18:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE2E3E5ED2;
	Mon,  4 May 2026 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MWC5Ee0v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012059.outbound.protection.outlook.com [40.93.195.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CE73DFC74;
	Mon,  4 May 2026 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919891; cv=fail; b=W3RwjuO7MVSHdLJOqmons4pXIsA17FqaPqfLpOgQzad8xvpsnihxEvd0Whf3HK8DY19XhOXk3iRP5tkdlxEKPJfuyLIm3A1euNJ1FOMwV8tzn5bjqN0TD6AJ8fSjz0um4Wj6c37caad5cpZBko5EeQc7Ko9kwtJou1kGIO5Qw6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919891; c=relaxed/simple;
	bh=R0ju2uFByF0Pvc/XlTg3ofcfOYpNoMVS7ykVZb8emZ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XMxYEvKurPaehj5rVgnRNJqKGrKoYDTWtWkmZXuiS534B9x1TIZPriIJOSDLwjHVbsv2bGpa8i8E8GyB2198WrMtY+/OQKk1bW/09aq6TekfbZczl4jgPXM9uOtTnAKPIBMu7ROkiu3AudLknPhUZz55tfgrdvH5UQQ66ZgHZ+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MWC5Ee0v; arc=fail smtp.client-ip=40.93.195.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+VeRsIUijt4TWtNrjI2S/udAnvj/i9O1loRZl+3TwvEDcWlMqt8XZhrHgQAPnehPGb+rYuBxqsyvxdVX8maEM+LKSl9r+4Pj4mbVuBsd4U6aiCZRNkhcg8gn3kBeAxPtDoxDYPyUiLxMW51+oi5bdRddUIcdwXFRyjdceiKo91khaOkaeqfOQhXLDZTS9vzRcr1WY2X3cxjAInoI7P/qgsPIKMiy3ThGqI5stJVi86yDokB0B2O9BgnsIvmUncsoQQorGGBp1wOQAZFXgFCgaVQvUD2/jiCKfPD+j4Qygy/j2XS2IwZjBJVlb+h0Zl9ODILRW3EDOP2HfqAk+J9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqBnTYD6goI+E5w3Q1LOro3ASx1CboCZSa8jWyCWn+o=;
 b=PbHZx+tNrsP01MMVMoHKxwqW2CMtgZfPNKCgNdugohq3BDSm51Ww26lkPPlXojng/s/jRzK7q+Nd5DEpPT3wmXdNhs/aoKUbTsKtXvSYVuJUn/nLt2LUHgfTGS+Rjud+VvAuK6VzEmJeLXLxpT94SplbkPzRFQc2KfOhZeg3YBBFbDiisQmZFVE5j2FJMLhOxL8+lMR19Dgsbr8E5G4d7clLmtAS131JkjskHv9pbtUiVSGucBpb++a57aNiC+gp7GbR3OMgSPLO+jmI8dcDe953ZiKkSYVguw6sxC2e79oyz1wCRhC6p938aY8dcej7SJnZbTnHQsUGWyp3TnXv8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqBnTYD6goI+E5w3Q1LOro3ASx1CboCZSa8jWyCWn+o=;
 b=MWC5Ee0vqocXYtpDFNOkuIQ6cWXukiQ3cl2A0rjKoNUzeD1Posh/QbpHc5ooSHmqqCGv8dgi0xkcIKSKJlf9DucEKnpreOCLBib+iGgiuXDabyThtcMIsK79KtQie9YplF5DGPsE5GlkdSXA/oMS80bRFJd3C83Q6MXPtA6UdS4Xw50YiDe9j7Ez7jr8UgbE5B5LFPslMYmA5Nd4jYJ+98CyOtlzRjCE8BezfRfXiLho13ICk1ldHP6m3+WKf6FtOfWZgFEkmAziaExoopIHDkjuofz+wfXWVu78xu0b22WLWRtI1zBbWv946YB1bpr58WAP/eEOWc69km6B+f366Q==
Received: from DM6PR05CA0042.namprd05.prod.outlook.com (2603:10b6:5:335::11)
 by LV9PR12MB9757.namprd12.prod.outlook.com (2603:10b6:408:2ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:38:04 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::9e) by DM6PR05CA0042.outlook.office365.com
 (2603:10b6:5:335::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.13 via Frontend Transport; Mon,
 4 May 2026 18:38:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 18:38:04 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:37:39 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:37:38 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 4 May
 2026 11:37:34 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next V3 0/5] net/mlx5e: Report more netdev stats
Date: Mon, 4 May 2026 21:36:59 +0300
Message-ID: <20260504183704.272322-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|LV9PR12MB9757:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f13402-cdb6-466a-ba78-08deaa0c4724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	/INXJ5lH8XoONjTj9WmIg1dJi4rgb15BfcnJ3K0opzX1bniTch0StYu2nZbsoBjWDCuQbSxkKe7L2n1gP/mCACSQ2cnuRR3RUTnBCcHHRS47thgE798wSVOdH/vP/0D/omD2+BFmDxYCVs/7+rHc3yBUOoOSchp49p6T8Ykjle7NkFoJOzr98+hkS9NdJUPriqizAW18Id31J0qsdr8asYQ+Devy35/rjOO7MES9AKW7zLgIaHOedPS0KiDdjjr1HuQWh1Je1WR3untlROg3+Lw0JqEd74JCipsn5ggdpIzqeSWF8Qa8/DXnPaj8YgwRxEx0oVbjokghpMHBcJpyNK1DIAX0XPFaKOvf7RCx6lXXFfDFLlFMeJvBwAZbghEPCM71uFRSgJm2ekiqUI0KzTD1vCZA/YP/R40ZiDh1AKmq2nCK1xX1ZtONjcAliCXMFY+Rx+MsddYXwlhPsAJdROKr2DPQiffBJKkTBQ67d/zVv+jctTh3lIwTx+KU+BMLA6dxO3T8yorTha9sT8mb19oSk1qtqf6Zzhl74Ti2fKMYCrWPy/b7S18J1EYJQIPTWnREs8Zk2tNAkJ585EmpJWxbDau1gs4PX2qYJ8c/RVltHELfvE+tl7GQZzMKe3ymElCEViARBp4K11Naf6jy9r8SmLoTjXq/NajVrSnLEkKpMnYcQqxpPRuW/OXoZkLs4oZUeUwJV7HNiw0NuK87o3oYtbZ9Z1rd1UAlGwJSRtE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(56012099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hMWbiu29bPZp17LUngl+2d99mPmVLOFnkwOt2QS+IpmpvfNXLRSJP01MZDoIkIuaxAYjMixh8z3GkgBKcQI5JHQoMnsbuUKHj5DdQvPbTDd+bB8dYDLLIZdDpPVr9Hcaq3KKGq9VSup3eqKf20PTQFCGbsE1RUlaj2tTUAtKPoi6Hs4iTkFmLhEhLsyRJtWqNCf5skEIPbFvvD8Q2bAVy0dO+SAdrIF57DNlmVofVQOFWS2RBfHYJ422ToKuBZ0xfBmEVIYvH+iCAru0Fqg23QvCjq+O9qw2wX3rV3bj3poKg5dsTMV6vljTeYw48r1Tx85eN6GalPq5SwNfKWaAI0rpbeQv83Rkp67fbH314DqAvWOyw0YnvcNi5FBv+DNmzNfGY0gsFcZuBa6IAcKPhK2Yfb1Rsi+CgGI0qukzAsTNUsI3Znx/dqaKRxSh1bvh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:38:04.1603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f13402-cdb6-466a-ba78-08deaa0c4724
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9757
X-Rspamd-Queue-Id: 356144C2A7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19945-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

Hi,

This series by Gal extends the set of counters reported in netdev stats,
by adding:
- hw_gso_packets/bytes
- RX HW-GRO stats
- TX csum_none
- TX queue stop/wake

It also aligns the tso_bytes/tso_inner_bytes counters with the netdev
stats API and virtio spec definition.

Regards,
Tariq

---

V3:
- Add tso_bytes/tso_inner_bytes patch.
- Drop RX csum patch from the series.
- Reduce TX csum patch to csum_none only.

V2: https://lore.kernel.org/all/20260309095519.1854805-1-tariqt@nvidia.com/
V1: https://lore.kernel.org/all/20260204193315.1722983-1-tariqt@nvidia.com/

Gal Pressman (5):
  net/mlx5e: Count full skb length in TSO byte counters
  net/mlx5e: Report hw_gso_packets and hw_gso_bytes netdev stats
  net/mlx5e: Report RX HW-GRO netdev stats
  net/mlx5e: Report TX csum_none netdev stat
  net/mlx5e: Report stop and wake TX queue stats

 .../net/ethernet/mellanox/mlx5/core/en_main.c | 42 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |  4 +-
 2 files changed, 44 insertions(+), 2 deletions(-)


base-commit: 98878ed91b68a3150126fccef125ee7b1bb86ab2
-- 
2.44.0


