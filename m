Return-Path: <linux-rdma+bounces-19633-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAJiMk1I8GmIRAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19633-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:40:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A06A747DB8C
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36E0A3011456
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 05:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99DD33F8D4;
	Tue, 28 Apr 2026 05:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dhz8tL35"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425DD33CEA9;
	Tue, 28 Apr 2026 05:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777354823; cv=fail; b=dHVA6FW6Pm70CNS0D3fO4dlnJkoTSItkjtWXGmnHIIVB21UDe8NkWVMWe20HZ6ZjTabur9jDHyMg1HaalWwPtXmpW7DzNb256tPZ2bvVAq86ACuNBS4pokCRyR5qkSGiaI+CaNk+BccP/N5CKsCFUzuR/NtfOaqSTcamiCVKpTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777354823; c=relaxed/simple;
	bh=rOSMYxl+0nc3KC9icZoYT2Shx7O2EqeVPHcJtg0Pw6I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VpkcXYV70AMnOQLn560PigVnpGP33dXxTAhX5Ug1IliETWtA8YRDmFJGA2WfLFmH2+RHSshyvyt3/Yzi2Ix4EMR1sIhjYYXMjLmxkZ4rmLfXwdU1dsWOVJTUSOqUaL3RQuO21fElqkuvj23DX1QtlWWlrlghEuEGlQRcw9JrJx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dhz8tL35; arc=fail smtp.client-ip=52.101.46.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrkMGyxZ82M6pejkdKCCAf1FG8bHMikNDE2RWNgqxgO7n8x+Dx8itZvXCqkAWI2JmOqZrvxdDcuvhAAcPbSN19yAWtzSkifqwghcx+n3u2CCvg+Gl04hgqFFmBBYV3EwgtqG+jeBDv8RnnsBbF1/emy/e/0AsDX9hXG8unbvSXU6X0kHN7R7QHkiRLymXFYVZsl8SKD1iWGJdZtuHY2jGNGfiK8XhFNluJ+0eV9bKSFtlnjP4UsIIQUIR3kBDP62fZS5IwMgciWdeEbDPlnD2zTJM6e8D6FxihEVROKN4v/f6MSDC3puJxwLiEchtxIl+knTmOg22pojeg5KYJohnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpB4FMeQfes268FD5WrlKA85kYZoDcYQbtwoPEBDphM=;
 b=GZI/95fud+pfbeXXUbSnGWAK5SaaJGlrirgy3fuDpiLHB0sgFAcRDikBa13mP68KiKTnsqqKROnG9kdDgFh9IzoVL3GNwxyvQOpzZyAyVwn/1+k+mLOd3/XbOoyPwUH2mWUkWK3Bms/bAlnTnLIbcO8MwooXVlnVLiO8vwCoPofqmgDBV0Jqhl9+6hgHfbbe7eZzHB6irbL94DdbhmQfv2TJJufr1WO+s24XFeynvHIz+TGAEN52uGpOuA1IHbLYWzfa4yvtkYL0ur5ho3WvAQ9Wk7MSqUgMSioOMINUx7BkdRXHKXWvt/MzgNR2noyxax4UpM55Se8zGSXkG39zDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpB4FMeQfes268FD5WrlKA85kYZoDcYQbtwoPEBDphM=;
 b=dhz8tL35JmhRqQ9tDAbu6eWK36SyifQWGPdJOVhTUU9qbEViJL7Lapa0UhgRO4h35vnJEbFnChckz3H3L0HcflA8gMXFDkeXKk3OjWUI7tKwsY0EtpYEKodBr5CZ3W/5hQ81Se5E1zFq5FLj0rXJl9uTdavkoMbP4rewExue9e5VVUIMykd2kj0o4vzygISyyoroJr+TnC6vrN34z0HHimHsHWaH5ZKfG3h0bbDf8LmkqjAvqQBjnpls0Jry6KHzrcs9M3Ri8xG4VXQGW+iX0I24ElmnxiHS1W+Z93JoKfPLz5UoFofO+OeQXn/E//JsXG7Fbr7GHYZSg0sBB+u9TA==
Received: from MW4PR03CA0030.namprd03.prod.outlook.com (2603:10b6:303:8f::35)
 by SA1PR12MB8698.namprd12.prod.outlook.com (2603:10b6:806:38b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 05:40:16 +0000
Received: from MWH0EPF000C6187.namprd02.prod.outlook.com
 (2603:10b6:303:8f:cafe::29) by MW4PR03CA0030.outlook.office365.com
 (2603:10b6:303:8f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 05:40:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6187.mail.protection.outlook.com (10.167.249.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Tue, 28 Apr 2026 05:40:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 22:39:59 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 22:39:58 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Apr 2026 22:39:52 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Parav Pandit <parav@nvidia.com>, Shay Drori
	<shayd@nvidia.com>, Kees Cook <kees@kernel.org>, Daniel Jurgens
	<danielj@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Simon Horman
	<horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH mlx5-next 3/4] net/mlx5: Remove unused host_sf_enable field
Date: Tue, 28 Apr 2026 08:38:50 +0300
Message-ID: <20260428053851.220089-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260428053851.220089-1-tariqt@nvidia.com>
References: <20260428053851.220089-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6187:EE_|SA1PR12MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: 761940e0-58ec-42b8-2937-08dea4e8a03a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	WrK4Odv88Xk+q6uK5O1ecitghey+veELwwHnrgQ4O46q3T5Gte9F+S3PKYfN+C6eDej/crKO2ygFx8zJ5s1jBWZ1NnHMldVzI41Qjop68BGSh7N/UAvef9/S7B3SWXfbsjDIJeGkIXd6HQIimk8bGreyzZhf/Tblw5OCNu2dBB+JquFRKp0otyyhtOKzXgD/mpERrpHLf3tvAlGsJ2RqhAkWcRMcLk3i+Sujb3txEQYr20timxxJqTBOwEZd9IkHwrgR6ixM1HE5500BLyyovb6hP8CZUOPnM+UKQNUbSVnZlkdD049hJoHxUz/3xN8iSnkWXDmkb4YmIUU9t1z3LrFVhhn/wp88HEasxaLD7PSq5kvACfchA5LP2lnrsBSTILeAf74XkSL3mKmZKFqXQ5qr0j/dbo0xI81IqrT5dz4VZwzxQT79InKgu8RH2ZUw4uqGU0vCnKXJB2klHy4CXCgeVEYwjkCO6ieYWzvg3NNk/hmZxWNdXF7sxlgV0mLMURTYNFPFULfI77MgaAWYImT4bOUhycjNSGU3mgylMfgoSaUdXAhijB8T7GgdNEO1AuaZ0KnqV2djcyBrWJ/O0FM9g2TEV8mVPZAkXmcvDrsLS6DRUcXKvrhH0JVY8agI5qYLnPkehpRfd3HDUXuv1wXLmZKXdcq9QqIgAC9rWFH8Y5Nb7jXT+rb+ak4BVet7znbxqRbipqyEpysC4vwQTXGG6M87xuzg1W5z7Py+QO6DyOgGNnaYaeWY0icwyu4wgPwNLZX8Z+7v24Rzo28zfQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lNUTBgGE6x4fZLbiWRC0E7cv12B5m6MjkywmFoWvDTifsbKtIH12g1bNwl9FgZgTn0KjOdzDBDOnYfQzDDifUIUxVW31ahb5ZzNPxgP2spe5ySf895f8jRt1isOSeltyOcBt+IIPEWj1yvnIhztP1G4i9tf8KMij3oTk9DM3R+R9vgFs3yJ89yjJv93FJH0OO8V6hniYYv7k/jogO/LEafNWn1egYsgxeVb8Zwhf7ExovuVVgUDtxi14fjHDR9VriOsX+3KQa6WNC5a9IJjg4dcC1uIh/FEcnf28TTpOZb6NOy0T6ryOMVPthD6I8jQwrKTx29nz1yPMd0LlModMlLnzu8cx3uk6Bu47NSys+NbMObpsezE/vAQI7NJr6l+G+v+3jyKAi3Ug3UBNwVAd4gzdonCbfgF3ayzqw5lW3EngWNzqDrWeMgwKW/WF090G
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 05:40:15.9658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 761940e0-58ec-42b8-2937-08dea4e8a03a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6187.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8698
X-Rspamd-Queue-Id: A06A747DB8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19633-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Moshe Shemesh <moshe@nvidia.com>

Drop the unused host_sf_enable array from
mlx5_ifc_query_esw_functions_out_bits layout. This field has been
deprecated in firmware and is not referenced by the mlx5 driver, so it
can be safely removed.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 06ec1f5d2c6c..02b57b2286da 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -12725,7 +12725,6 @@ struct mlx5_ifc_query_esw_functions_out_bits {
 	struct mlx5_ifc_host_params_context_bits host_params_context;
 
 	u8         reserved_at_280[0x180];
-	u8         host_sf_enable[][0x40];
 };
 
 struct mlx5_ifc_sf_partition_bits {
-- 
2.44.0


