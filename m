Return-Path: <linux-rdma+bounces-18969-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHZbCVmCz2nLwwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18969-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 11:03:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5E8392854
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 11:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5165A304B2FA
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Apr 2026 09:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C866388367;
	Fri,  3 Apr 2026 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rhcuLR+s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013047.outbound.protection.outlook.com [40.107.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AE5386557;
	Fri,  3 Apr 2026 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206887; cv=fail; b=q2jcUxpuBdHFpC85bz3LiqfhoM+ThUoHXfpsByoJ5euEd/tmQjrZNdm5WhK6hSLQMDmzUGg5MLtUm6G8Lj87+hHUMvRaj0Vy6ZjGkxeq71A4i8WMdl6dmvC51ILcV1KL1vy7KcomsR2VJkM7t0uWgC03ddBxR78+vWfk3PA0z7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206887; c=relaxed/simple;
	bh=aL6TJDFM9tUPBQFCFiMcgMjMuMuMc3XXOynnTDm6bRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRP01zo6eZGHwl+ihT7VqJagn4qWf/9gHV9f4OdkoviQcJ81nCUZ1lmgVVUpyQ9UHFPCsJh8y3la58jA/swZrPcnxFFcq2J7wagBluhCLsdtVZ05Shy7ERxljlQLQAiDuACdvRWSWLxNwfIZsaE+aAREdqRYQ+tmVsuVNRJX46s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rhcuLR+s; arc=fail smtp.client-ip=40.107.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mM0aHVAvVzlnTvDXLESM4xhnGM4s2FUnV2m0CPOQOgJ5nVrX9fAEy11M2TyoazN0vYFN6rb590AJIgH2zeH2iwn3a9APjQ3SXBFVHqUkILYTwJs81joNCkeAwhLmqqhP902njMgCwVCnLTIATYRyp+vaH0t0SIcLg7+MFNqcRsDNYFK22KICwxEgDsXpR8ykC5CwVELtxPQayKXQrFax1Sc9Zam5cdCJnfcRFX1lAeJMLnl9MF9bc9POx3E7N5luru+7VIAxZBLT8J9QeqjUgLQmBfVdDma+yqMQFNSDztIxhbmhmFFa5pj9wxCjtVX9pfM6GmQxiH5FK3R0S7uqGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oS+nKx/LiKTtrfGHuoK2wYXhyJBbkyWqwL8UvqM5GOo=;
 b=jkIduDwPcvfUfwfYSVxDS8ykJk9z2ut7+9rn5zsnOp/F+KEl8X5TeFKGI8RAFYvh9nsgTlp+pzWcBqsj6a5GlKBgL33fo7Zw7jRL7jXQfihNXnWOqspG3wwbxcPdUkQw1dB+L6x7aw8Ue0grXctBhjpaxhAaWJjx2vPDAQhVz6IRQBc2gj2eNvg7m+9dl3VejszbahrUuB/nqO1VKntFxpxGYbYlgNh4gu+LEGdGWtIFle7HyA7YnCvADNN0Bwvi+wC8EPrbT27rMMLtVZaYcb03jghPO/nQiYr18/qJjVvNgmwZKNucQE+I6chSMuk3gHzTwjVJJrbvCWnFS0gMUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oS+nKx/LiKTtrfGHuoK2wYXhyJBbkyWqwL8UvqM5GOo=;
 b=rhcuLR+sNMEKfVCQOJ8BbDWoCVHfn3m1cqgklXfNgaviJGSlCyaUtIiHGEBy9iR4mUnD49oW9RyzazMGZuO0jX38A5PDkUG5yrKVi2XwQjzplqceSCb2LyTaUPPCn6U8HdFx8UDc/LdmyTq1Yw4N0uibtwAPskD8y+zZitjmNtKXO8MdAzrPoXnAMs4gIBgknDgkjxBcOMj7f3dqK+QkaDxtyRgzz+rQ6s3UhWUhCgqonID3P8qITDWOCw5ycQFL1yxhFKM0w0qPDBSMAUGU/c/fkmXTZfP2gx42aVfkJWWw7y7oAInvRIZ1dOKycxpfpu3D9uzWdB7t9b5hOMJDVw==
Received: from BN9PR03CA0309.namprd03.prod.outlook.com (2603:10b6:408:112::14)
 by DM4PR12MB6663.namprd12.prod.outlook.com (2603:10b6:8:8f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 09:01:21 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:112:cafe::69) by BN9PR03CA0309.outlook.office365.com
 (2603:10b6:408:112::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.21 via Frontend Transport; Fri,
 3 Apr 2026 09:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 09:01:20 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 02:01:01 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 02:01:01 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 3 Apr
 2026 02:00:56 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Akiva Goldberger
	<agoldberger@nvidia.com>
Subject: [PATCH mlx5-next 2/2] net/mlx5: Add icm_mng_function_id_mode cap bit
Date: Fri, 3 Apr 2026 12:00:28 +0300
Message-ID: <20260403090028.137783-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260403090028.137783-1-tariqt@nvidia.com>
References: <20260403090028.137783-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|DM4PR12MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0ecf9d-6b5c-4194-f723-08de915f9332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iyBX7BJBNuJqDFQb/TH0RemwDFwmRETgViIjZC3fcCyd477ZLg4C9PSK3jYJMbFI2rEiE9RAI/x9qT1HW0gj0MJYzkAKsUlb6hCNo1u1/bTWl+mb5Q9urp+fPOjzCDNH0BjtGxIAMjqDNfHFnJbMeCoFCTUz/BXU2szMNMXIpJjYM/Tk6wvrrEfTM8xjE/a+gfDJG+MuJm4bjO3hft1XckfMz/Xk2paJAvJmcd6Zn80FLvbm1o28TJJ5wQJqF93M4R30RhR4Nq9g1/tSft5K6extM4HWSSWXxDc6HryjsgONjKAL6w2fbMA0bd5Lcz+BQtYniSpYE5oAqc3bAFsCQ/JaZoRJ/oDIWzjlpQEyVu7QvqgW1A63HoPfVGXfF5mDaiAccvXin40Wyq6uZU4E88ilhGuYExJk5jLUrsd7j4s+6Jqk+AnCmQrLZCTSe68hW7PzWHisvzYUvFZzZr/fTKecyCa4+j/1zeOycLf+yO/txgExRPS4tFT5FftC6E/9JY5+JdSTVbk5nfz5pVRs7VnzISERYADc6AHmVfMZrQA5+9o0Uf0OSRjV8RYWv8a0RvRFnnooEFDTVPZw4Qwkb4Dkx8kxsURLLSdYzkvaz6nic8wyw1m+8gig5X/I5QlMv4hoRXZlnAO8MNhzn7ZZouuGc02kFPmTCGt2N+utEmnRgUR0G5FwXUBKMejEYz3AefwkKINJTy4OSC25p2d43PIRZwp1R/BPCyMKR/pptyF+suDustMEvv7bwtLr1IgEzkUb/QB3ASZscYEhp5Om9g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4IlagCWwVr3puM4ULL8lBk+3jHnSyIgxgQdDzGkJOvXjzVW0sSqrpLlZOw3+fRM6L7+pJrI3zLzGTWp6kjzXw98NflBeuDF5Nr9udJQ9PCOh38ZB/DvTeLh72YUC3a4+eG1CxTEDzmPeV/Ty9jpSTuYT5agJi7ksemK+sq4vziD8J97vMKHMhnMUBvn1j8D2c048N85qx1AzerDp0QZT463fMn9yAIAFMs433YOAaEb+HyNR+mpIw0jXKqyNx2tAUiAaOgDxk4LtWn3xWsYeU7zLEgKusz0AEz/7ofW6r3TKIhrwYunHRaNg4OAQ2EsH1ucLbyZyeYF8QpONa2XHsqgXiLVR9riEkgFtCKf5CDto0Zswho4lDQV+z+q1Eir2OWSIR50zkudXMGPUzS6lfc/XD8RAgxjVGjP2JyFFd8vbg7rZswsqH1AZHWsxI+ul
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 09:01:20.8752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0ecf9d-6b5c-4194-f723-08de915f9332
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6663
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18969-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DF5E8392854
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Moshe Shemesh <moshe@nvidia.com>

Introduce the capability bit icm_mng_function_id_mode to indicate that
the device firmware uses vhca_id instead of function_id as the effective
identifier for the firmware commands MANAGE_PAGES, QUERY_PAGES, and page
request event.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Akiva Goldberger <agoldberger@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 2400b4c38c77..007f5138db2b 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1654,6 +1654,11 @@ enum {
 	MLX5_STEERING_FORMAT_CONNECTX_8   = 3,
 };
 
+enum {
+	MLX5_ID_MODE_FUNCTION_INDEX   = 0,
+	MLX5_ID_MODE_FUNCTION_VHCA_ID = 1,
+};
+
 struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_0[0x6];
 	u8         page_request_disable[0x1];
@@ -1916,7 +1921,8 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_280[0x10];
 	u8         max_wqe_sz_sq[0x10];
 
-	u8         reserved_at_2a0[0x7];
+	u8         icm_mng_function_id_mode[0x1];
+	u8         reserved_at_2a1[0x6];
 	u8         mkey_pcie_tph[0x1];
 	u8         reserved_at_2a8[0x1];
 	u8         tis_tir_td_order[0x1];
-- 
2.44.0


