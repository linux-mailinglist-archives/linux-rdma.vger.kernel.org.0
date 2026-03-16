Return-Path: <linux-rdma+bounces-18180-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFjdEh0IuGkWYQEAu9opvQ
	(envelope-from <linux-rdma+bounces-18180-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 14:39:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E05F329A96E
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 14:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E79B303137B
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 13:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81BB39A071;
	Mon, 16 Mar 2026 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sv+4UcRc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767F239A062;
	Mon, 16 Mar 2026 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773668221; cv=fail; b=HVhYpWSqJeL2/C0jkXzzP5o58PtjgIckk63PyJiAotlS1YkzNtDCuQFRsF/3aFH07SdHmk9Wz81zTfEPfhSiPdaruWLg4C+ErZcP9XwPumV6cWCC+QdFZOGDjh1nU3l+92kPf3xkioAHqP6wmQFnIsD39pMIlDbAdVmRtyln9ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773668221; c=relaxed/simple;
	bh=96sTWPHV4GYGkTrIPYXasV++4NyJhWD7k0jyq4zkZWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHGAqE5iATB8H3qOhhXtrtGVNFk8dFaFN4g4XQ/f2vjB4e/3PjsJPdyQW7+MMHLeeoXPPVilXL2vd5XDYGBhrnHBbYvbxXwMUyZzE8EGlxuepM0t7gfMFkRyF98lFkFhAR3fsCKOVmelVpPhTeDpUEwA34FQG6GB96H1IQqOXgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sv+4UcRc; arc=fail smtp.client-ip=52.101.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSYrFualPunPi4yPlX4yg873x9kvHIF5r7fR21KYVZuso2SMGM2INzpsYmuUL/EqTIbAyfLoo+CVZyUpezSr+hRG65k7rDu9TZgP16pHbWEd9ASPddhyWHd7uVT7LQDuYHKiaAgPjZWhFn3uAmO3XcuLDJMQ1brYdz/M7t9qQjbX6WEi2Nx8fFAj3kHNEf1q2j2ImAW3gm8+KmXeNwdfAXzxmxWRkXgMAL3KIO4g0lLDDRGw/NUWdAN6+yhNgdYCGvD89mxGeKIIERamreNEPnoyYU/40kjXxQy8sC7DX23T+viCCPpBlyk82NgrhU1CfSnESZZKm6pH5FNkCx5Cug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2BK8v4O4yN/KJ7xv9phKPxCl5RdLrZw2LN7GUMGPJs=;
 b=vgQhS5MPEhxLIP7x3cTw2uHtO2JpRMo6xqSW4ncBQNKLsHqUgp53ZIyHGoKNEEjdTXInyv6hHWCKl1u4RkFvc9p1fBUqaKCBDS4CjWeSwkULSOasPxOusgRizqpJW0LpnyY8m10qHSZkeYVXuOUwehqrQqf97S6/KZsN1UcLRFSCQKKQVOD6BmEO3y/jVdDHMCOKOTu2P3GWXobZLKFChLguWBGrzq1EJtCl2oZW/SXgBg9VmkTmzqzagLipmIquleNlxmpzTy5dCvV6o7CLjR+NTUPgssLeKgCqWEidtnH8sWYksy2zuHPvsu8nlfSQWVq9YJeYyAzh2AASgxHUFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2BK8v4O4yN/KJ7xv9phKPxCl5RdLrZw2LN7GUMGPJs=;
 b=sv+4UcRc9Zs8Iq1wxSzjyk1vFz7n5fRtv9RLpzs5O2HcTX8m2hr7M+QxMW6zKg7r7g66ReCN0uKGGmI7jsdb8rQdeHnGE/r8E+W4XrMi2slDsWKD3E/RXsK0Z9DWrY2cGdvJs0GshyQX0WDp9CxrXniLxCcFoRGBr7M3m3Jk7Z4JHSI9wfUkIVDYhHU/eah7divf8pWW/9lrG5zQapxnE2FqkMKQWTznukEfn6WmsuYSK/2NSDwo1yIET8J5pTNfLGjGMPrGc1Oey9PzglK4gmFCYAkU7lPSFzouTuVhjUp1FLxOnZbLl1QQOG8aLMOIY3qJbNxmZ8l/mRXepPXfTA==
Received: from PH0PR07CA0074.namprd07.prod.outlook.com (2603:10b6:510:f::19)
 by SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 13:36:56 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::bb) by PH0PR07CA0074.outlook.office365.com
 (2603:10b6:510:f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 13:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 13:36:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 06:36:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 16 Mar 2026 06:36:39 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 06:36:35 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>
Subject: [PATCH net-next 2/2] net/mlx5: Support cross-timestamping on ARM architectures
Date: Mon, 16 Mar 2026 15:36:07 +0200
Message-ID: <20260316133607.8738-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260316133607.8738-1-tariqt@nvidia.com>
References: <20260316133607.8738-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|SA0PR12MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: acdef7aa-400e-414a-f7d6-08de83611719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	a2mUfQEAfgEFr4uK3v23A4ARhgz1F6mMVHMjzQcgOqYQzfHcwyyLvx7/pVcxwpZT6DjJ0gidnU4b33XFxevOEPg/7Z6+gccE34bHSg3eZK5WEHzXkpgvt8+p3QV8bzxRzTcE4wDc5otQzC3jNhvgZ4YwyoNk3Z4vbUTUZyN/ceORbwp4Y7BOujsZBYXI9dzxTsZH5ZvjcVoVFo+shaTNBtz8YCsMhXWgBukm74OQFgALu2TTxDmzWjLDJfRS/hMBvTz5F76mCxspHeIJqIMwt+QB7+pMbXtOSraeeJ5mMKY4iy4sik63UPeiG9cQiFC+efoHfnbXtiPdbg/1cvE82PIIiHgMIyHkNwSPkw4P5LWZ8NaSm/vrY50C7XewZXuj6mlhvsWjiNB9YcrMRxyaub3aAESyIpva57uNWeQLNVV0G/M9sUIvkLoqgH1mVqlRNiUoOucMVZhchoSvv10gpeDJ9A5/A8X3Moz1BOKF13phA2Wa9uuPhTT3PmIpiU5QNHfZpaKHY7vGqIARKiUASmmORz5oXTEDYsc/8a1hS+yh6Fl42XTf1kUhpcuuqfa1aCd/u7CyTFzSeDkMcuqgvY1nkaGO1LLVTnPA2/cTa+xVgf457//MMO1ommCBYu/xHo+RLPVZP6A3mimASkUthebt/zslCTqsPI8PS1xc66Kf8RPLHluBtBCwRskI4zgEaRCMMguUNtI/mnDv9LI2UtedJppMH/yJBwIVmdHR0LbZLritBHJ+c1srJOGRGzo5RjT4Tbt5j2wiQtPftInTJA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5ktpcTuczmsO6ghdSPEPFvfdnpWcKO9J02szR2dv1+jRKj3elUbLTMjwZ6ehHBLedMcxnG8F6fDmE98kQo5R/WDMQMkrEWEfXRp2qfqrVQmHeKVAIT1fvt3SuUBB/3GDVcu0o+amMG/M3lbvRxc2clpiu5VzXEjCpEEmGL5nEfBJCMcR/X6rZrXNEs9SnANqfS2hDhz3g05wVOqy/b9J5t3Ro6iM0lIgP3WUqYa+keO15oQnpDzAIUKYRpDZXANN+t0rfVn09yjTkHsRon71Ph+ccZKgl8EmUySVneY5PB2E6ByslsdthSP5oiu0wkD/sSuK+sBHh06KXq2peNtu9mW4s/lr+Xofzeu7KYvbTRXS1DDQbHtzonB6qS2MAJm3erEvk1/byXrLp8sSRbIeZOvMZQDZkgdif/td1qjlEuvnH01WWv8AXOErD5V/CSXf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 13:36:55.4389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acdef7aa-400e-414a-f7d6-08de83611719
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18180-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E05F329A96E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carolina Jubran <cjubran@nvidia.com>

Extend cross-timestamp support for ARM systems that implement the ARM
architected timer.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c  | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 3322814819ea..d785f1b4f2e1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -38,10 +38,10 @@
 #include "lib/eq.h"
 #include "en.h"
 #include "clock.h"
-#ifdef CONFIG_X86
+#if defined(CONFIG_X86) || defined(CONFIG_ARM_ARCH_TIMER)
 #include <linux/timekeeping.h>
 #include <linux/cpufeature.h>
-#endif /* CONFIG_X86 */
+#endif /* CONFIG_X86 || CONFIG_ARM_ARCH_TIMER */
 
 #define MLX5_RT_CLOCK_IDENTITY_SIZE MLX5_FLD_SZ_BYTES(mrtcq_reg, rt_clock_identity)
 
@@ -229,7 +229,7 @@ static int mlx5_set_mtutc(struct mlx5_core_dev *dev, u32 *mtutc, u32 size)
 				    MLX5_REG_MTUTC, 0, 1);
 }
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_X86) || defined(CONFIG_ARM_ARCH_TIMER)
 static bool mlx5_is_ptm_source_time_available(struct mlx5_core_dev *dev)
 {
 	u32 out[MLX5_ST_SZ_DW(mtptm_reg)] = {0};
@@ -275,7 +275,8 @@ static int mlx5_mtctr_read(struct mlx5_core_dev *mdev,
 	host = MLX5_GET64(mtctr_reg, out, first_clock_timestamp);
 	*sys_counterval = (struct system_counterval_t) {
 			.cycles = host,
-			.cs_id = CSID_X86_ART,
+			.cs_id = IS_ENABLED(CONFIG_X86) ? CSID_X86_ART :
+							  CSID_ARM_ARCH_COUNTER,
 			.use_nsecs = true,
 	};
 	*device = MLX5_GET64(mtctr_reg, out, second_clock_timestamp);
@@ -373,7 +374,7 @@ static int mlx5_ptp_getcrosscycles(struct ptp_clock_info *ptp,
 	mlx5_clock_unlock(clock);
 	return err;
 }
-#endif /* CONFIG_X86 */
+#endif /* CONFIG_X86 || CONFIG_ARM_ARCH_TIMER */
 
 static u64 mlx5_read_time(struct mlx5_core_dev *dev,
 			  struct ptp_system_timestamp *sts,
@@ -1307,7 +1308,8 @@ static void mlx5_init_crosststamp(struct mlx5_core_dev *mdev,
 #if defined(CONFIG_X86)
 	if (!boot_cpu_has(X86_FEATURE_ART))
 		return;
-
+#endif /* CONFIG_X86 */
+#if defined(CONFIG_X86) || defined(CONFIG_ARM_ARCH_TIMER)
 	if (!MLX5_CAP_MCAM_REG3(mdev, mtptm) ||
 	    !MLX5_CAP_MCAM_REG3(mdev, mtctr))
 		return;
@@ -1316,7 +1318,7 @@ static void mlx5_init_crosststamp(struct mlx5_core_dev *mdev,
 	if (expose_cycles)
 		clock->ptp_info.getcrosscycles = mlx5_ptp_getcrosscycles;
 
-#endif /* CONFIG_X86 */
+#endif /* CONFIG_X86 || CONFIG_ARM_ARCH_TIMER */
 }
 
 static void mlx5_init_timer_clock(struct mlx5_core_dev *mdev)
-- 
2.44.0


