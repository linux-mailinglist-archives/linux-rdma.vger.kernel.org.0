Return-Path: <linux-rdma+bounces-4825-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B709714CF
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 12:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637B51F23DE8
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 10:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EB21B3B2B;
	Mon,  9 Sep 2024 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dDZu2djf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E871B171E5A
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876340; cv=fail; b=mRu4417eY7H2cofzBW6ySYdGN2h/bBeE7xoy2UsiOOmunPXlFHHc5tSwxl+w9kexmwj3ylIi4AXbM37ZRoT4hzlkU8r51cgq1mqFRnX7DOqzFYYDF6nKp6Ru02uaAFZEmxCJsKZcRelGM5V8AWIGLCL3Im5xV6a3OK3IBhUKjo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876340; c=relaxed/simple;
	bh=XfGdmeJwrAdNQXtVJ/wcJICIKVlJzEmIZ4IS2AjexXE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RH6yuawtso8xgu2M5nRp1MGxdRgs5I/lM68dJP6FTDd3b+iHmVB3MRtgLspdJbncRANJ1GPg6VNd5zwH8NQou8v/vp8YO7328U54p++UHfIuEC8vQ0bu83WdtYPRoLrAsKq9rgKZaVndA8txK98KgXkUPbek/wo4Q6fAtnCl2hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dDZu2djf; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GeBXM7FQOpLgIj1Q5Xm92Bxkgi3jKibQXc2Q62MUX5v0mWmmuho6pRCzeZVCNYQDoM/70Zo0NorM5FW/1w8Jo/uU6pQYt/iFnZ5+PiFPA3gFTpm80nJ60xyi+sAlVRNN06NqplumaawFwfrd3wjB8v63zU0wvzuW7M3XLL7zcaoSfq9NOxKDbx+H3K9V3qRXiORiPecPByPSQHNChMGCAIYzDcEKEm3vIIAPvsTSqS8lTRDN1cvGY58gUuRdomtbXohCsJfPs7ZGNK41mfo+2x7txqgP5apnIkImRfr/CN7NWk90fffbXlyYbxTSTO0kQ+FNXGrvPwatZzdxYexf9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5HqaHeN2EHybHDUbaqlvfUmjZvJMB5U5BsFxBHNYks=;
 b=crvHg+sniDTMdeV4rRPUr6/Ku2n5b16I5+AKaOTqh6Ian5GeNSRwA+jxyfiKXPdgTbR3IAvL/G3Q0NJPPhgxNa7cZ4k4RLZvAWBqgFGshJPovtoIuBsepOTEnPzK0In7Q/s8u1vTCQxTHOqqaan6eKMAcnICZJ/Vfk7+PlrdW1KOuixzK4IUGN8oIVuTAGaw173l4fx0Lmb4nulRpLYMIPBeffOlhHCIJr+zSdVfiTsmxV7Lzh1tqtxjuT184q4/u7ODbweT2snbHfT+p2d695loh+AOAnTc7uOwC4kpApSJsQD2MY9VN4ENOkqt/JFSVm5lO2W6JndkEV/oPgGkUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5HqaHeN2EHybHDUbaqlvfUmjZvJMB5U5BsFxBHNYks=;
 b=dDZu2djfdj2mG0UviYv+qeIqibbuAKPByz8IXXZ/ATn5h02HLZuBiV+qViSSzpx9zCBUrZdsqgiMf/UIGZw9t45cPS0EBkSxrC5uzUqrT333B2nQnkEXfx/x6AyZAS3evJdYiTWDJ0BMqOBOrP3/PF3axYwi/vCF0Ka8PmaZyHrRrai3562XsD7tipnTOhGg173zCvW/Kd80ZI3bqBINcewsaQPFC8ZlDyIX5HEHkDkTGg0apzclxOnImDQHcrM42fYuDH9IqHMkqgZiuJgZ1tMhbJHXiAPEG1VmeLkbzhg70K0/B/q06TaaEWpioUERCp/W688jM4eq+QaPGeTmcA==
Received: from PH2PEPF00003852.namprd17.prod.outlook.com (2603:10b6:518:1::77)
 by PH7PR12MB9065.namprd12.prod.outlook.com (2603:10b6:510:1f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Mon, 9 Sep
 2024 10:05:33 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2a01:111:f403:f912::5) by PH2PEPF00003852.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Mon, 9 Sep 2024 10:05:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 10:05:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 03:05:19 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Sep 2024 03:05:18 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Sep 2024 03:05:17 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v2 rdma-next 5/8] RDMA/mlx5: Split ODP mkey search logic
Date: Mon, 9 Sep 2024 13:05:01 +0300
Message-ID: <20240909100504.29797-6-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240909100504.29797-1-michaelgur@nvidia.com>
References: <20240909100504.29797-1-michaelgur@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|PH7PR12MB9065:EE_
X-MS-Office365-Filtering-Correlation-Id: 74bf0a93-7e65-4e12-b93c-08dcd0b6f16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gn6sxe0xtSdPWs92Vaxgx5RAlu4SwbAE+ZKljJQg8rmxjSVMLKN1yqOSf3BS?=
 =?us-ascii?Q?0Tvwr7W609FLCKdT7kYwGblyJSrSIN6kTRkX9jSKQsi7hGP3BpKJ7D/YKXis?=
 =?us-ascii?Q?Y8Kdciqadr3+xFMy/ow+SMG9KZ0dS9jQiXX7a61PsyrHUrpKTFt6a6jAQ+uQ?=
 =?us-ascii?Q?H4MjR7pg83CmIhZcHMb6nth4pyCqYPrbmCO4B5N7kpECFAPH2LT79szCiRet?=
 =?us-ascii?Q?bERBYJ0MhUAuPHMEfWBS1IKzsOLGWW2NXKSQ12bsnQtaf2fbsR8gkjGaYJ9W?=
 =?us-ascii?Q?jE1myiJbDDBF/W+/0ktecSniWoqYQvDP3cT+t63v9aFOVIQ8Tg5SPfsPqbxC?=
 =?us-ascii?Q?MKwjPpRGm2H2dSowXxMlRkFBEc7KvBv2rj8M4YIchLnGeo2wh+jZFTQCazSN?=
 =?us-ascii?Q?wkPls+9al05H+DTLKT0s7D6P783IBLcdiz0w2hjc30ChDoYWiXDRSPfIv27L?=
 =?us-ascii?Q?7H9ZL/1z9t0FxB8NtfqMsZ0g3h5ar5U5s2BzHxWQO4kChHp+YVoTQK+8a32t?=
 =?us-ascii?Q?fI4q/CWczmRSwW9M4nkXqLJjg0k5fsKntXoSpaLt0AwgrXvP63Cd/QVo9tgF?=
 =?us-ascii?Q?I79kO0c8kB6acQdz9nNX4Wb016gREkWnxMO9eo6UAM9f4s9bjn9JhrE++6JS?=
 =?us-ascii?Q?nJz34pzoVS51jFlU/v97gkIi7N4bEzHYyC4zif4sg9U0/kYqVVNwVCcQIeuP?=
 =?us-ascii?Q?rTaA3vkTwK4X53IpcphTzCUTjeLUrzCGJtPTGl/DW2ia3RD+v4OwGMqG55DO?=
 =?us-ascii?Q?TAb7vqMoJWRbFuZqi2nPyLMBg5GEZUPsAx6em2T/GIuAJ8wgNcxUyAomOH0n?=
 =?us-ascii?Q?Dd5giyel7ResjKZgudWXmvW71QRTVEkSEVW+XdyZO1qwspFroVxlOUeRdYSU?=
 =?us-ascii?Q?/A6WD0QmkHSahwDSTgXESV/WR/Rx+f7nqT9Ofh7x9Yul7dIu7D6ozhDOtEi1?=
 =?us-ascii?Q?3OLSeH0w6rY3emqk3bfaiM3LvTgg6HWS9bHqPR3dQWy/pUd61ay7Rul5KH/y?=
 =?us-ascii?Q?ebDj8aTUIcZrmrb7R1XfeMCcYbujntXpGQXF+Wxlv5tLT/jzpVat8Ia/Jsrl?=
 =?us-ascii?Q?Qy2e+vYUu1pKh4Kjia40EWngI+s4U3+z1a8TSWHQrIlNjLSkUan/AIZ+caxQ?=
 =?us-ascii?Q?AmsLMFg5FSy2L8YsMJ4Jkn+5qHwmTonHCAsWVsFmbiBqZZyL3x46Ts6fq19K?=
 =?us-ascii?Q?OQ7O/qRe/8pHFPHZpx1Ut5Yo4NOA4Qc2VmfMuPO0/Ne6GHQLKrQcGXe+k3AE?=
 =?us-ascii?Q?BmFq0Y10N78YAbM0R/FH47vmzyAJG/ttBNibHVAAkMUzSowJYvyRBauoLuXb?=
 =?us-ascii?Q?EdTFzzOvh8HyY0RASH6oGJxxxR8z/IuG4DJ45BVq76u481pq5sx6NeI3grIf?=
 =?us-ascii?Q?xVTCYOWfM2XFGY/dLd4cpbKB7t+fYqF8A3macyw7Pq7wY/pk78LP8mnaMIdO?=
 =?us-ascii?Q?j5tWpYef5QOAJaiaKH9/3iOTcnmi7zTg?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 10:05:33.1824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bf0a93-7e65-4e12-b93c-08dcd0b6f16b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9065

Split the search for the ODP mkey when handling an rdma type page fault to
a helper function, later to be used in other page fault types.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 65 +++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 20ad2616bed0..05b92f4cac0e 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -819,6 +819,27 @@ static bool mkey_is_eq(struct mlx5_ib_mkey *mmkey, u32 key)
 	return mmkey->key == key;
 }
 
+static struct mlx5_ib_mkey *find_odp_mkey(struct mlx5_ib_dev *dev, u32 key)
+{
+	struct mlx5_ib_mkey *mmkey;
+
+	xa_lock(&dev->odp_mkeys);
+	mmkey = xa_load(&dev->odp_mkeys, mlx5_base_mkey(key));
+	if (!mmkey) {
+		mmkey = ERR_PTR(-ENOENT);
+		goto out;
+	}
+	if (!mkey_is_eq(mmkey, key)) {
+		mmkey = ERR_PTR(-EFAULT);
+		goto out;
+	}
+	refcount_inc(&mmkey->usecount);
+out:
+	xa_unlock(&dev->odp_mkeys);
+
+	return mmkey;
+}
+
 /*
  * Handle a single data segment in a page-fault WQE or RDMA region.
  *
@@ -846,32 +867,24 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 
 	io_virt += *bytes_committed;
 	bcnt -= *bytes_committed;
-
 next_mr:
-	xa_lock(&dev->odp_mkeys);
-	mmkey = xa_load(&dev->odp_mkeys, mlx5_base_mkey(key));
-	if (!mmkey) {
-		xa_unlock(&dev->odp_mkeys);
-		mlx5_ib_dbg(
-			dev,
-			"skipping non ODP MR (lkey=0x%06x) in page fault handler.\n",
-			key);
-		if (bytes_mapped)
-			*bytes_mapped += bcnt;
-		/*
-		 * The user could specify a SGL with multiple lkeys and only
-		 * some of them are ODP. Treat the non-ODP ones as fully
-		 * faulted.
-		 */
-		ret = 0;
-		goto end;
-	}
-	refcount_inc(&mmkey->usecount);
-	xa_unlock(&dev->odp_mkeys);
-
-	if (!mkey_is_eq(mmkey, key)) {
-		mlx5_ib_dbg(dev, "failed to find mkey %x\n", key);
-		ret = -EFAULT;
+	mmkey = find_odp_mkey(dev, key);
+	if (IS_ERR(mmkey)) {
+		ret = PTR_ERR(mmkey);
+		if (ret == -ENOENT) {
+			mlx5_ib_dbg(
+				dev,
+				"skipping non ODP MR (lkey=0x%06x) in page fault handler.\n",
+				key);
+			if (bytes_mapped)
+				*bytes_mapped += bcnt;
+			/*
+			 * The user could specify a SGL with multiple lkeys and
+			 * only some of them are ODP. Treat the non-ODP ones as
+			 * fully faulted.
+			 */
+			ret = 0;
+		}
 		goto end;
 	}
 
@@ -966,7 +979,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 	}
 
 end:
-	if (mmkey)
+	if (!IS_ERR(mmkey))
 		mlx5r_deref_odp_mkey(mmkey);
 	while (head) {
 		frame = head;
-- 
2.17.2


