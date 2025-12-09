Return-Path: <linux-rdma+bounces-14940-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6346CAFFBF
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Dec 2025 13:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78E4F3015E03
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Dec 2025 12:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A00326D55;
	Tue,  9 Dec 2025 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sn8zeP31"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012047.outbound.protection.outlook.com [40.93.195.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D46B2F656E;
	Tue,  9 Dec 2025 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765285027; cv=fail; b=F+CN+rzRdMSNznNG4BbTR44OviZCgCZKo1SlQE0YLhSICwTnL6Y3Adljc/aRL1gSpFNfQaZAZ0Zo32ED/m7cVja0Y/OMGyECsyjsE6L+ZHchGVwWF2wuUNd90RvLBCvCcl25pM/+w5LjtYcL/SAJwSbbznFKc1O2FpNuzwDiLqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765285027; c=relaxed/simple;
	bh=m0x6frNi4fLldzqB/qabNKoQ3cgsj7+dzkGHPRAByJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8ChJ55k2GqiNnZYft/LXUUG31pCBUhe2D5MqktRP1OYcREhJHoIGlTGDvl9FYGAwzHP9+4xRP7gZDrYIRxOIBxgbcdPvmXA2teZ2cPm/c4fHsuh+OyaVdJfvf51l/s2qpG4TV8O0PSHqtcM3YQaSgK5DHUaUIMiXoxgDjdH7Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sn8zeP31; arc=fail smtp.client-ip=40.93.195.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ch07T09LzZJ6R+QaZE8VOwaR5c2U93FEPeOW6c1r8d+1gopWnkKNn9+5KxRNiwxtoMUSexeRupHisgwLkvCYBVAKv1DpevVhBlwWU1LtTg5N3f3OY/WhjlMQoSu4udK7mw7WYf86sJxGnMZTkG4ml8k3uFbufMXU2Z8GKwen6nz9BfzQtxSfy1V3Y+hyUjY7IUQykCuPzFdLLpAGAzmlDk2PYLIKN2U+tTEy8oZR4+dwDwtQrJTBP3rTs5hg9kmE/Jxu+zh30YUxL77i48FaEA2IOxU3xm53m6A+Ww8+mUPYc+upnJETDFYTqRPZxzY445a1cl7tF3UgFC4oWlkDzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jV2NT/14j4NeTau4p9w2Nl073uP6ZA6Lswc1lCcyG/c=;
 b=vR6wFRdraZxNkxsofkEKIYAQGbfwbDTl6NE0jZkOhbVGAlMlLh8tRlRM0OEUA/FO8kvoAP6Dm1+Rk1Cah+9ztcIUEuWTAwqefcW64BfN/snykHMRME9nCmiZdVLO/LvMEAT1YwyQ5hsksSXGGtysbgrKyq+6d2k8/TNIJ6Ae82N9B+NPSbhTPHG1VFhuacR0sEMuJ3ooTdi7mIlpZ4mnelJRYdUdqlhIheC2xUcykXsS0Uw7ty6ofMqT7QillhXO/ukt5QpvLb3VMIB6ozauS+bBT/m1uUYl6iDWvHgCZfJrNw8yQ6hggkyYdzC5+r7zk6IIa2zZDFmZYt+nF7I2RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jV2NT/14j4NeTau4p9w2Nl073uP6ZA6Lswc1lCcyG/c=;
 b=Sn8zeP31q3JphHcPAhtPWoOZKgsCCYOttg+G33iQtsJJ9sAtHj9ZrhXxuY8CsyJIAH6VCNa/FM+z8/5kdKoRO3nexfdo+3l8KZC8fzdW4lPRGctK1zJ6o/YRN3lZFA1ns27fw/MPEitvL4eyzcjPhDT61XVkfy4RjQvcKg3cYLEVgfdg8aJ9LjrH5mnUB5ETeC5Tq88Q8Yc/KtxTigxvtu/tB/CR3hCpTxrefmTjIDo4qw6iGBp/eOs5H6/TCGsoTiAhtXgGI4U2MAFXEKLMNaSTlQlfuakLtqrBFvo62Excj8QivEqzslIqXpq5tvElqXLrcGM1T9U14KJCk6Hmwg==
Received: from BN0PR02CA0047.namprd02.prod.outlook.com (2603:10b6:408:e5::22)
 by DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 12:57:00 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::ed) by BN0PR02CA0047.outlook.office365.com
 (2603:10b6:408:e5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 12:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 12:56:59 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 04:56:53 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 9 Dec 2025 04:56:52 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Dec 2025 04:56:48 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Breno Leitao <leitao@debian.org>, Alexandre Cassen
	<acassen@corp.free.fr>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net 4/9] net/mlx5: fw_tracer, Handle escaped percent properly
Date: Tue, 9 Dec 2025 14:56:12 +0200
Message-ID: <1765284977-1363052-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1765284977-1363052-1-git-send-email-tariqt@nvidia.com>
References: <1765284977-1363052-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|DS0PR12MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b131c5-c21f-43b8-cccb-08de3722711a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|13003099007|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?amzCsN/Ay/cnNtu587skKPxwN8NR/46T5kzF0fcAN34a8j6SFM33Rt6+QY3b?=
 =?us-ascii?Q?D0cjTc5PJalJafHSFsHFzFFsmyZjGbxoluNDQrSAXlJZsiIDEN5yn9BTuYi7?=
 =?us-ascii?Q?txYOihvfLvUfZuYgBR8Z4+v+iXSRV1DTP+647tpM4q/MxZBxlM9jsEk4Y5fW?=
 =?us-ascii?Q?LCgmcf8MriCFGOsl1r115xUt6c2gwUxHgkKIBleJ45jB2Vm+VMUz89EDYIKs?=
 =?us-ascii?Q?MBJ+HFETuGCE+9iKa313zfiWRo7CnZaFh2X0qL/yaEoC3zPtPHZhlqku5wyC?=
 =?us-ascii?Q?ssuaacik/7i4AdcLIftuaksp/JaMrm/gya5fhkY4ACJLo3Wd08/3A0tzP+qt?=
 =?us-ascii?Q?PoGMBVE/dk9gcbn5mxIJeUTpIOEzrcJmuw9DYlZkFjovMkb1j0eJVHgQqj8O?=
 =?us-ascii?Q?NlYGB+c1TnKQx42zKCbwGf6OpRLK36n7U5HKqZNFRn1ObFq4IjN5mfkNY+9h?=
 =?us-ascii?Q?FByxmrsVBMzc1xM4867nnM57N3o0eaduX2ZsvWnPufnIZS6BF0sw75uOn34Q?=
 =?us-ascii?Q?h+wZsnZ+mXRfwnkgP5mBMDSgBiInNEooLuH+v/ifQCpuzlieKxYWZHpLhnmP?=
 =?us-ascii?Q?T024kI/HbjXkZonYbf7LG2jTHC/IbAt6a7yKI4cYC52O7CaT1WlgeCL1YnjQ?=
 =?us-ascii?Q?08Lh8+4L+TG2S9rrJ6n1epRXs8p2O2J+1WswVgNtw0C6cMpWMQ0OQgZL52XU?=
 =?us-ascii?Q?vnYx7ySW8EzVf3Byc/tdqE0mUs4B358hkqklAFONyNI359TxNF84WIUua7Pi?=
 =?us-ascii?Q?ax4Wk4Jni2sKgVeiVcqMgxWbRMRGmoOObk9hr6Bz4KaMZJ37mL0igpNns3Cz?=
 =?us-ascii?Q?TuVqwcJddLAlSWwIMoLt1HjQNTt9MpqInkKiER8b6b92Ch0ZW/A9P2S3AA/P?=
 =?us-ascii?Q?B3L+mS+kXmOhaWi1xvN022BVLkoau5eGeoYMtmS/xSZbSR5jlXbJD8Ms6RBP?=
 =?us-ascii?Q?X1ECWNDO8nUHJImcklJhmJ9lK+DRN/mWfbPIPfGx2e12Bvo6zmz692x/Tw2t?=
 =?us-ascii?Q?E9KoGlU4LYLDKl/lLWJgNVIm0PGMuUJwQeT4A8AuZZvVP806wwmdXWMnOrQl?=
 =?us-ascii?Q?SG/ICfBaMTtfNabmDieQz9jQV+ysnutjUkoRri3ChrGb1VGgZdxH7wJkZW8S?=
 =?us-ascii?Q?MrwbeqbP0U09ahFqZe/JV04zRlUaNcoaRhZRdhCXDvJ5/cM+h3j1YxAQlXWE?=
 =?us-ascii?Q?7iADGxxsc3/HhsbSaCYoAJCgi3hZb6G4pezA599WrdxpUmAfjeyemeOwUttf?=
 =?us-ascii?Q?JmREXBmt7NChBS4r/OUltIRgmAfJPXHZtcJmnooXLQeHfOhgjJ77y07tR+wW?=
 =?us-ascii?Q?0nUl3BJtZTyL8Aat1272JSDT5vWtZ5qZutwQJj+CI647YCBZJ53xibhzRq9P?=
 =?us-ascii?Q?0E7NR9pSeb6wNt6GdcjiEVQbK1WjI0YE/uj+tx9HB553b9sJhTYysFg37SEj?=
 =?us-ascii?Q?LOj6/Y4WowoKWsU4XT3cTKM3vQjD/t8D2ua30aL5YH2L660QaL1d/4pxnm3V?=
 =?us-ascii?Q?rLKBGunoUwGtLV++vkq757r4Xf+EFY6Tm8lwvSgQDRbI2E9OrWHwGX4U7kI6?=
 =?us-ascii?Q?6CxMP41g/FzReBSdItN429qyrc4PYED5vo0aD4Rx0HsHfSuui8fNq9GpnY55?=
 =?us-ascii?Q?BQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(13003099007)(41080700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 12:56:59.7516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b131c5-c21f-43b8-cccb-08de3722711a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9038

From: Shay Drory <shayd@nvidia.com>

The firmware tracer's format string validation and parameter counting
did not properly handle escaped percent signs (%%). This caused
fw_tracer to count more parameters when trace format strings contained
literal percent characters.

To fix it, allow %% to pass string validation and skip %% sequences when
counting parameters since they represent literal percent signs rather
than format specifiers.

Fixes: 70dd6fdb8987 ("net/mlx5: FW tracer, parse traces and kernel tracing support")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reported-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Closes: https://lore.kernel.org/netdev/hanz6rzrb2bqbplryjrakvkbmv4y5jlmtthnvi3thg5slqvelp@t3s3erottr6s/
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/diag/fw_tracer.c       | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
index b415dfe5de45..6b4ec457ce22 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
@@ -368,11 +368,11 @@ static bool mlx5_is_valid_spec(const char *str)
 	while (isdigit(*str) || *str == '#' || *str == '.' || *str == 'l')
 		str++;
 
-	/* Check if it's a valid integer/hex specifier:
+	/* Check if it's a valid integer/hex specifier or %%:
 	 * Valid formats: %x, %d, %i, %u, etc.
 	 */
 	if (*str != 'x' && *str != 'X' && *str != 'd' && *str != 'i' &&
-	    *str != 'u' && *str != 'c')
+	    *str != 'u' && *str != 'c' && *str != '%')
 		return false;
 
 	return true;
@@ -390,7 +390,11 @@ static bool mlx5_tracer_validate_params(const char *str)
 		if (!mlx5_is_valid_spec(substr + 1))
 			return false;
 
-		substr = strstr(substr + 1, PARAM_CHAR);
+		if (*(substr + 1) == '%')
+			substr = strstr(substr + 2, PARAM_CHAR);
+		else
+			substr = strstr(substr + 1, PARAM_CHAR);
+
 	}
 
 	return true;
@@ -469,11 +473,15 @@ static int mlx5_tracer_get_num_of_params(char *str)
 		substr = strstr(pstr, VAL_PARM);
 	}
 
-	/* count all the % characters */
+	/* count all the % characters, but skip %% (escaped percent) */
 	substr = strstr(str, PARAM_CHAR);
 	while (substr) {
-		num_of_params += 1;
-		str = substr + 1;
+		if (*(substr + 1) != '%') {
+			num_of_params += 1;
+			str = substr + 1;
+		} else {
+			str = substr + 2;
+		}
 		substr = strstr(str, PARAM_CHAR);
 	}
 
-- 
2.31.1


