Return-Path: <linux-rdma+bounces-17693-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNGELeQdrWnoyQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17693-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 07:57:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9F022ED1A
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 07:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 700BA30329AD
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 06:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4388313E2C;
	Sun,  8 Mar 2026 06:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f1+dZEM1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796AB2D7DF8;
	Sun,  8 Mar 2026 06:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772953011; cv=fail; b=nq83zFAJxdrSIMGLv/jmJLuQ9gm3DsORVpCe6tK2UWc0uanzYZVeNVkG7zb6WsXNXbm7GUHwXs1vuV8q/gQVG5CVh9DiMRo3U8gRnm76EE2lGgukR5FYZokdu3haAfngNDV1xy5jhFdHctUwHk9/zMS5tHBR0+imfx2hhXFlXCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772953011; c=relaxed/simple;
	bh=1jyIQU0xtoo7P4mg2sXxdwan7IBK3obhfdzH+22FC9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fx4CDjAneU36H0izF9dKRk3WDJqXQQCU6OQGLZh3wCtVQdcOYJy2aqYu9UzfGUkQOoPU0bTYmBZVqbR53g0RyGJ2f9egV5PDXaQZwAXYPZVYCiWv2vAvgUzs992+UYrGLJHi2xsGZgnAD/x2Ata4Fr7s2uTDEEZH2ZN+Vf7qgGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f1+dZEM1; arc=fail smtp.client-ip=52.101.48.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0H9cXMgHFAvZuxvhcE6yAfXmFSYWXiT5a1qN+rtjY9oq3yzS6vpdH7USwSWugCLLuMSiQDREfV+C8Xa0yWrnkmxyHzeRnv3WGtI3yY/w5c4P3bnHR+Pix2fJjm287LDmNtmK/TdWk6GWhrb6XpKVIcRdg+6WAFXLI7HLKvvrmAHMh+0wnmDda/bB98x/Zzq+IchufYQPwdak32MbsEdveTf6MR1kv5nEP5bvXqSYprvZkhGL+GZRizkA/H4dLrwMe1RdbEcx48TqAkj/+83Ai6h8IZbeSTZlKBzpewDXR0xOQ7VwQfWxFcWtub1j0MJlwVLmiB4LhURZxr0a+qT+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekn0lKde0n7movVHUf8LrLDOQm98LAswQkzCbyzukJU=;
 b=Lc3b6KtjDdD1GK7xgeYm7Its24YaudqPmtR+Ew8s4nYHnYa0z1FGiBFwRPH1IiKZKUVahAbkTt3z2ecaoZajOPHoNXP0NetBcGtoWTaNj8ERjOuAvllkiIvk9HlHmwK+4d8Z/IRkNcElibQ/c35tdlJLbgpsbvnH/1Co9lqPTtl6pTeDIrbxDdO/m8B0vKGuv801bba4engPDrYx/eUHJaMX7VLabTLeIt/FTKt2JCTwOZ0ygmu3AjVy+U0Shl6fcQKhPVEQ6nVX7092PIm/Mk2eudupID5ZPoD6s7Y7Bdbi8oSNsQrPF9PqFxWlLHvyubnFYhod04tFInddZenlwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekn0lKde0n7movVHUf8LrLDOQm98LAswQkzCbyzukJU=;
 b=f1+dZEM1W3mfgfGV2IjXr/Vj2b2FBNRm05zIoCGG8psuprfabGzFdLCkpYdyDkaXw1vqFPRwONUXmVO6mFNXhHVdXvFUMVRe4X5FqLcPxIpRqE2zvudCCRH652Yco035Waesm3m/62qHCjOGNPoNrKgvX62dcXUJzKbJajIe1MUSlaSmznR21+68C8xg2OCTn5KG9IhHM11jAMvMShKDsk6Z+yXN4OQ0pKy4yxAjeqKlPGH+1hK0j/hGVUkRhy4JEmvrxIriB8YCi3mBIpmPtj1GWkxIVZn0lFi9mf6O8ZGmTGXlXzWsGB4L6ZrE/9DUha49UaPU6CWYc/OHsQSi4w==
Received: from BY5PR20CA0011.namprd20.prod.outlook.com (2603:10b6:a03:1f4::24)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Sun, 8 Mar
 2026 06:56:45 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::de) by BY5PR20CA0011.outlook.office365.com
 (2603:10b6:a03:1f4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Sun,
 8 Mar 2026 06:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sun, 8 Mar 2026 06:56:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 7 Mar
 2026 22:56:30 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 7 Mar 2026 22:56:30 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 7 Mar 2026 22:56:26 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
Subject: [PATCH mlx5-next 1/8] net/mlx5: Add IFC bits for shared headroom pool PBMC support
Date: Sun, 8 Mar 2026 08:55:52 +0200
Message-ID: <20260308065559.1837449-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260308065559.1837449-1-tariqt@nvidia.com>
References: <20260308065559.1837449-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 0429953c-ab7c-4610-844d-08de7cdfdc8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	C2Fr7KYNLforKtEFJYMdbqITKN0bwmcegPDFvA6mAAHitkCZcqU4Khlugzg4lDHyaFZrpd8ncx0gfFSt9AHXGrh8Jv+x7/bSzEabbVaKDxycuFMOfPnVXHKZnAwfVsyksWQtBEUq+8Vm9ocJRTgATYeFC50bqa3i8BvDCa2CSuT+rMka9fGyYREVxMnAgksr9a4YYOzZGQ1mRm5ggyqfG7rfzMeHmmrzjC/AV0g81/8MwNieOwYHdOFG6o+DeN5ecUurG3hnGKgFf4C8dH09gJ4Dd5cRkKrPHLZX0kR+50xpbn0B+ckUZpUkKvnfOrg6PG8wXFjctDJBSkaVro7lXPO/WDbAP9Fa8kh4kjR0cY0Omdr8zdI6RQ/DKb66sKydHdFnJmWELjsl1H24z3ad0vjOjNjmiHUi3AGMmysJcwyX4FrvXrLAbKtKhPi0wWV6U45IuS55c4EFv4J5Ht4vH/WVTqVarA034Ej6bAIZ543kIACka0E+DLK1j9Ns4o9mPjZ61gTISq2DzzdjSfIiMAPwKspryWd8WVDQFQ4rzw9TDtAwntuSS583zIR18CuIFm5SxZyFHpYbxu8oFzZ9Kqnx39Km4ZboKIcbC9x46bJjzkAZFd9h8vLmbgSSWbYnRFVtevNpNxjolWrBamnwlKuLvyKlNUqr9nuehbhyWNBMG2gKUnviN7wZVqu0RCqzQ0ASLcIGDa/8XWB4bLl33uj68zdIE5PDeayP92RNA7zkIi8gJge8M7tFvefqCjBnUrL3vofAW0G/Se67918Rzg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vIlnLXqNw2V+kT08+R1F4fwcB1y/PS9FfLvOzd7IhhOP+L5wDKGesjzVDhtPQn5I7QWhWgoLDxbrplTT1HiPLR2nn+nY6S3I5vO4qzFkYQT/A77RIUrWcnP9YqXkUOZM+fiM4JCIDFUIgJ5esyiBlISUIo9ZhTEP+S72ihaabzpwZTIZBHSqvuz0U5VAZGnWpoUmhTPX2DWyIe0h+evy5OvpTqWJ0jHqiC4n9yj7DNkpMWbxk2jrRUyLfrn2Uoyz5rAoMtAQ2H4+GAdBFK4dVmcQxfcEkgaalTOSNxCIyWbOlXYAtcXX7IDej6fYehicdrxJmHeWzGdzWiqDRC3hZqmDUT7WQunkvd75NeepJJKbZPPyYZAIU2jaxtm50kTQS/DVRXvN8B9TWwY5DgsOi+9na9V7da7SHr4UlS3ahnCvy9b48JaxHT0Vko/1Uwte
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 06:56:45.2601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0429953c-ab7c-4610-844d-08de7cdfdc8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526
X-Rspamd-Queue-Id: 1E9F022ED1A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17693-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Alexei Lazar <alazar@nvidia.com>

Add hardware interface definitions for shared headroom pool (SHP) in
port buffer management:

- shp_pbmc_pbsr_support: capability bit in PCAM enhanced features
  indicating device support for shared headroom pool in PBMC/PBSR.
- shared_headroom_pool: buffer entry in PBMC register (pbmc_reg_bits)
  for the shared headroom pool configuration, reusing the bufferx
  layout; reduce trailing reserved region accordingly.

Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index a3948b36820d..a76c54bf1927 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -10845,7 +10845,9 @@ struct mlx5_ifc_pcam_enhanced_features_bits {
 	u8         fec_200G_per_lane_in_pplm[0x1];
 	u8         reserved_at_1e[0x2a];
 	u8         fec_100G_per_lane_in_pplm[0x1];
-	u8         reserved_at_49[0xa];
+	u8         reserved_at_49[0x2];
+	u8         shp_pbmc_pbsr_support[0x1];
+	u8         reserved_at_4c[0x7];
 	u8	   buffer_ownership[0x1];
 	u8	   resereved_at_54[0x14];
 	u8         fec_50G_per_lane_in_pplm[0x1];
@@ -12090,8 +12092,9 @@ struct mlx5_ifc_pbmc_reg_bits {
 	u8         port_buffer_size[0x10];
 
 	struct mlx5_ifc_bufferx_reg_bits buffer[10];
+	struct mlx5_ifc_bufferx_reg_bits shared_headroom_pool;
 
-	u8         reserved_at_2e0[0x80];
+	u8         reserved_at_320[0x40];
 };
 
 struct mlx5_ifc_sbpr_reg_bits {
-- 
2.44.0


