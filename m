Return-Path: <linux-rdma+bounces-21552-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL+gOckfHGoRKAkAu9opvQ
	(envelope-from <linux-rdma+bounces-21552-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:47:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6489D615DD0
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F7C73098079
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 11:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0C8384CE6;
	Sun, 31 May 2026 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cnD5iuka"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012009.outbound.protection.outlook.com [40.107.209.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ECA385D70;
	Sun, 31 May 2026 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780227673; cv=fail; b=mjiRO+NXpxczvOInbmKkfsPRhxW53aS9WV0gR7wY+73IU9bh844bT/4tuMAs2TXu9iRfuTSiVaXSGmscGiy8PKgj+1VjVxAbWAKo9thW9V7wwSaFFkkZmCoYofIeZHfZh/3/E7j9SaV/SMVf7Mu6FAvz0NTaCHfGd+mWHwFl6hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780227673; c=relaxed/simple;
	bh=iYFVl1tkEG3DYTeIVGEzION54xNxSWEgk0c68DGW1mg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwLI0vnJDeORZjQ1LAda03EFlRzfnTNXTbj62iQVlvTDySeeSoYKWJGweeL8HZLNOIufYL3qLWBOQ79T0224fN6/1izmvcNJ0hAr1dU8TLBAyCtgAbNf0Zz8qw9h9493SiUKNCCld2DTXyA4oqAtj30WrRANsEi2WM7pl2AkHlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cnD5iuka; arc=fail smtp.client-ip=40.107.209.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+imjhwXPOkLv48lDhjDe9FYHonrPBH1CexWMmeFNntzFqOCQg2c8JJVvoGdPCPJ4YkDonIdPqtSn9EwIAyPL+IIz187k7EnuoIjzH1uG0cU0ru2GBruXvnvwGubqBNK0rkhVJCbcXOqzK2y1TezTXz1TUk7D6C/QH4ZYMiQy8MASq7OXkENoOVuD6s8CrF99zGSqj9Xaj3gxVtCloOAJABhdraeP59GnZhfiVCwPj4BbDNzRnlRQTU7/bHl5iV2giFrjsRsJPeUckAuVkO/i8eHZj5j7pBD5u5x+eUFqaj0fSCJk7m2R8LF8JMpf9CR8ILusLLbZxhsYyp4ip8hVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13bKDN+yJoAWv4Vmtd0JcCJhu6XFQTHrhY2dY+8E+so=;
 b=o5M2K5kgozr+vwMmLr75LLQWjx8x2XYWh80gXYmyaeMX/TF8U80nMVuffhlIyrG2pCD5DzGcP639d1tWWUpOTPwxp8dTuWW4/5dBIgBD1EktUejdJUtptAWmRoPt73tb5chxZ2i/Jc/zJQv48JSfGwlJ37L7MUcgVZAHasiDJJ5bhAa4BvdZNTt/6LpqVoUvQ3DAHb36UPkaW1PZpG+ZMyMlbg5vYI7kXzmDgk6DyDQ+wyOkUTwUei9Rifq+FQsFS312Z4iagtxLlZzHWx5zVJjNerzhsRjgQzfkjGeWzpCVwg2Kus9b97UC197MTE289nBpDziN4UQv/2gbSlbA8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13bKDN+yJoAWv4Vmtd0JcCJhu6XFQTHrhY2dY+8E+so=;
 b=cnD5iuka4taSNz/Gej7YkdAbqvGloRcRFn/kWoamqKFZ4dyVtyC2EGcrZ7b7YIAgEZIQxgDrldlcaPbfHigB/2nSbkkQm/SK+Vza6Xnazz65twvTAUMCOURPUJvn8WjuqZDLL5o7zkFdAsxkmfqHZ0n9qy4vofN1EMQa9KMtM/+tXeCiuhmsD6g+z99/rvffRE2lEAOdq2qpxdttnNt1gKmvCT42O2Q3YK98pd5HvhUM8lgGPFsBA8U3hHcptCqykwQkda/4W5WVbkTSnzOnvFMw+7o/SHxDEfn3Z8QGB7jrYn2uv3Fz7YsmIkbbLgeQv7WemxBQJ7t55yFJfvnUrg==
Received: from MN0P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::22)
 by CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Sun, 31 May
 2026 11:41:07 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::ab) by MN0P222CA0017.outlook.office365.com
 (2603:10b6:208:531::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Sun, 31
 May 2026 11:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sun, 31 May 2026 11:41:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 31 May
 2026 04:40:58 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 31 May 2026 04:40:57 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 31 May 2026 04:40:52 -0700
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
Subject: [PATCH net-next V2 09/13] net/mlx5: LAG, block multipath LAG for SD devices
Date: Sun, 31 May 2026 14:39:49 +0300
Message-ID: <20260531113954.395443-10-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|CY5PR12MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b9ea55a-f5ed-4ca4-7390-08debf0980ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	An2YVVIAE36hBSNv2dAr4mXhL5uAYB2pZD0GyYjxJggBo8ypnmWgmSbRHoWoNx63yPp5+qnllaUP9Vwvo0oKCFM0m/i2N3ucU3ZHw/YmoZMQ6J3rnRSremrEf+QuipoD2d8pO14dWMnEq5n/LJUEDONSFP0InKK/OB8SsrANITw/p7fB7uFneswzvZ6k6SZzhl5yIEvEcVa5rnlQaogSCjmU8XtFbw+kb0xC9WW+kHgyAhA1cLGk4sR+yO/mda7KuhYWxGHXzqFOSpq4SlSzZgRI18nLOZBbi20HqSG48q0DWl23gPQ66+WR10r/Q1CQX6oztA3N6jPs3AE9zxipM+ohW2uMTeDFNZi3kaqaJAm0/tbPIO2rYhZhtHyGIojWbgxpoRyh1waP3Gu9H/GB8F0YSspccVQvyc3+oyD7WSo/8QgnWr9StTjiA65s+L4wH5arXHQbaFvNdGrHSs5YAPGYVdU1gZQcIDnvZrN/eP2GF1LJRgT0goSgPLFcp8khF/mILWG41GQIKu6Lw27CXY6OvpzQWNVu+4ss72y07tY1IWQsK6q8eky650PIWJS2nxWmJjcuSYJDVgBPcwPsS7hmdHE6BL+uEN/oh+O+fDiRmxVnvYoUjOGUQvspyPyFdQABnGT2fxC09EFrenycg0ewp4YwCO29YN4zR1GTxWuoDaJKQavlVBntmZJIHoaLCOMxlfgVNx4EIptbcW2RUSMf1MBO45GPR+YEKLlvdSc=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jWAMEBU6h7Lt9xc6TQ5IbQXfhl7+LYIeWulzJSZfcS7g84iRtgNsbcjkOuZaf3yOB2V+RDJjjRqvi0EuC8e7hV4Xtk1ZeVzWbza5PSsVAMuTyNYmDfqt5iJYZEEcg2cCKsH8LGe9vm/ddnW/1DJ1XHmYHmRfh6QeMOdYvxf3S6lkjo+NS9TsAYEqUh2rL1PF35+etUZrWSpBjh1tpQWMuyb0JqQ3fF0Gk2Ext/ytj3frB7xBVDzgji4g0nAlU66Wpa8EO8Db6zQBllIbgWhoZXZZYorTSqz+Qp/p+pbgJuUggqE165PkfSFyAMyKOkSmkP+fY/9Zr70FbUreKZjiOAA2Ckn5SErolv5izH9p89utQfk2Gz030d+qqpMwwPWab2W6LvOzIiwSVAyq85RpNR2GLWSMvXRakrk1Kw8yogrqsvuhhJjd2x8exZ6Em+wQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 11:41:07.0177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9ea55a-f5ed-4ca4-7390-08debf0980ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6252
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
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21552-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6489D615DD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

SD devices are not compatible with multipath LAG since they use
dedicated SD LAG for cross-socket connectivity. Add an SD check
to the multipath prereq validation to prevent multipath LAG
activation on SD-configured ports.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c
index f42e051fa7e7..65c76bd748c6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c
@@ -26,6 +26,10 @@ static bool mlx5_lag_multipath_check_prereq(struct mlx5_lag *ldev)
 	if (__mlx5_lag_is_active(ldev) && !__mlx5_lag_is_multipath(ldev))
 		return false;
 
+	if (__mlx5_lag_is_sd(ldev, mlx5_lag_pf(ldev, idx0)->dev) ||
+	    __mlx5_lag_is_sd(ldev, mlx5_lag_pf(ldev, idx1)->dev))
+		return false;
+
 	if (ldev->ports > MLX5_LAG_MULTIPATH_OFFLOADS_SUPPORTED_PORTS)
 		return false;
 
-- 
2.44.0


