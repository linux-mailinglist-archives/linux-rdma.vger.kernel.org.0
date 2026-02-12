Return-Path: <linux-rdma+bounces-16781-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIaYGKOsjWmz5wAAu9opvQ
	(envelope-from <linux-rdma+bounces-16781-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 11:34:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD8B12C89F
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 11:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FB3C30D689A
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 10:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CAF2EA72A;
	Thu, 12 Feb 2026 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Aos7qwD6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013041.outbound.protection.outlook.com [40.107.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DC62D8799;
	Thu, 12 Feb 2026 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770892394; cv=fail; b=LMaDIcNW/jRxUrsP1+/gHua6BDH4T5n28nZPeNVWp/parmycJucS2pwLjjJBGa+RI/FRAto5J50ot5w3AvCrlwVIwId2i1MuxULJfTjunKHguxRIwMeOKieaoSiwn9wVyO+st0ZYi2o9ikmuiboIE/6A0odHViY3oM1aN3mTnCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770892394; c=relaxed/simple;
	bh=NC4SbjaNgl9NT0tLklth9vq/J6wtLTOCbWZITMzPEBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwO9vgl2tRzSbQd8FrB5x1s5GCGYKPBIi9E3O9PEYWBJeJGIN//IrGJvEhqZt8a29NXSuhXp41SzkLk3QqvbnLBxTI/kUqdJk0DYB7T+ZPUMmGnB42IsuQ54Wo2vOJZDCZ2zRRFQO3937D9VH0Or9pPirHllX+6CiFBmQs4Q1T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Aos7qwD6; arc=fail smtp.client-ip=40.107.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIy0S4bRLnhGScSE6U0QvBDSwdzhvbIwpa6S/hVhWPUMgFBsDFUn04+VNj+ningaUzE2d1F0Bw55cEJwTqHkCZ3sRDZKQbkf0M1b/BltAnpsHioAG4IZhxniklj61fqclS+fTlcYgbs2depyBJdcXXo1pPkClOOBnLcMluyRvojwvwWMzkUWmpid0HlW8dV8VAYFf0hoouapn5iUeTJMnN7KWxNYf5ItBFdeKGKsdUGxCclvv3/KEKZhoZdheoXn6hPdSHEzeO7ESyOcjL/VhThtEt3hvIMSy7sotoVtBFe6MeHXannv9VMh8vr1atXD7NCk2GF26Il+py/wblUJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaN072eGPGCCplO/U6kCb7UgXSri9HI0w79yySV0ask=;
 b=sM2C7WShrRQQ9BwjYAt8cQbq3nuBR5kn3oYeqoMz4Abz/8RVo22IoiO2nwt3PVYLwZ14FRjYqnl1/PhokYLxvrDMZHBZ09r9PBwC02fZkBvOQgcX/4lGIOkHRXwqlp6Y7q465U3hJtYL0pvDQJXhWpPXWQntk5Gx07raZj+RVbF+MlFHz72X7bQXUnl7sKyqzYrOgpmMnUnd06TaiKNIPLBjEW0ziiHhwcGdQiD2o52rfbEhzTWJklxymceVqmJJnpbsX0Z+9S0C21sQghpXkymGOKfNxaKer9sfjdHYweSyei2egKDOccTie/tc9Vyx7a/jZXi49UeQzWRCHgymLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaN072eGPGCCplO/U6kCb7UgXSri9HI0w79yySV0ask=;
 b=Aos7qwD6Dms9WWV7SMjvBCwq4HHBoDSE2rpr5MOCKFf+qJL1A53Ep3FZj8mHBkpD8b/s2pFSbhXZPFwEL/DvnfAp42xUOF6c05F9YD7+ZsjQYtwQyM/gA6yz8tdos4uw1UBC0IHnDPreXbHkap/tkHUmbrZLgCKRfpKFOJo95uAhO+c4P6NIf6IEAYWk6Rgr1KBlD2lIoXEC24BuBMliR3ZpO6h1ci2lhp1EQQQzDsHDzbZsseaUJxvLBngVEgh0HtQNnsd3VrhBKlIjOaAEdfb37hM6XkwPC28ehMxXNV+OnXr71UxrVWRuARTp5ABvokLm+zrkuIRvDmua4NT7Cw==
Received: from CH2PR18CA0035.namprd18.prod.outlook.com (2603:10b6:610:55::15)
 by CH1PPF7A6EE32B1.namprd12.prod.outlook.com (2603:10b6:61f:fc00::616) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 12 Feb
 2026 10:33:09 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::26) by CH2PR18CA0035.outlook.office365.com
 (2603:10b6:610:55::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend Transport; Thu,
 12 Feb 2026 10:32:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 10:33:09 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 02:32:57 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 02:32:56 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 12
 Feb 2026 02:32:53 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net 1/6] net/mlx5: Fix multiport device check over light SFs
Date: Thu, 12 Feb 2026 12:32:12 +0200
Message-ID: <20260212103217.1752943-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260212103217.1752943-1-tariqt@nvidia.com>
References: <20260212103217.1752943-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|CH1PPF7A6EE32B1:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f187f3-8c68-4ba4-ba40-08de6a221dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FoFKNEAL503/u03YPea3CcWwQVGDRMLm37yEb2ztBW2NXMSkmwu9V/ME80jK?=
 =?us-ascii?Q?xuTsdJcCVyKdlyG29PPjRSZ1ddyGXIw3AA6zv2QO9hsusLO4Q4ad4/QeZ6B7?=
 =?us-ascii?Q?Uc6d2mni9vBs1NKjWzVvZvK0iKoJfc9GVyHhYcSTZQGozaHe75fg5XnL3XnK?=
 =?us-ascii?Q?SOGmNagNgcG0YmifLR9k/tVQLSqk78XK3RTqZ3NLKesTckusxrtzv+k/1FrM?=
 =?us-ascii?Q?EbyNcS16+qs7Hd4YVQEx73UTDcnunnS8Ls/+0s38pybYiNGkvJAXTpMLyE4U?=
 =?us-ascii?Q?EmX0J4wiXzfh3C4vZ1cyjbGATS9uZ7xuz224EMWG8AoRQQ+HbBa9jp0Ysqpg?=
 =?us-ascii?Q?jr3qNfs1DtXL1DvBFLdGTr03SMnbxeu6nVPANkoAf9hMmGyBSMtweVmLoe1c?=
 =?us-ascii?Q?X2XmHK3jses0wZLitPRyL8XEuGxy6SYXeMFXdlrKydUr35Wrs5D7xW5LsRaP?=
 =?us-ascii?Q?+fD3S2Sr1ItrF7YOCgFlXnoNxosW2sqkDqM5Wz++uyLLhIp7UwkZ5nAJ/Qlv?=
 =?us-ascii?Q?NwcYU2WYd/KS1kN7KUbbYaZKLq9rWkzP6e/rejWprU+zOczBpoWqHCr5LMJN?=
 =?us-ascii?Q?toZ6Ioi221VtTaHTaNF51WKfemAUdj4ow01qWP8kKjOvZ6XHLAAXcckSQcYB?=
 =?us-ascii?Q?ahwsmTubFFxV4YKUBXID3vpPySNeZAzry+XEyUdVU/rxtfaGi9HIWC8xrmu+?=
 =?us-ascii?Q?RDGTdzdF+ncmo+7k6ddzRREZBQ/isp9jWG6yemmTDlbiBmEwzEV7B+5l71mO?=
 =?us-ascii?Q?DV34u4qi7yYctM8TEwg00DtmJ+2Mreb2KeIwQLuzQ+3NM5PImp1bXxONR/bv?=
 =?us-ascii?Q?Vd9CtSMQQyy9EuYvyp81xfvxk12y874xeLnBgWHxLGsLfo39UMJrcyPa5kCw?=
 =?us-ascii?Q?dTypsWSA5XLk/uSERlr3IicoNBZKRJoqhBe10xdW4ej3j5IJ0+W7iFdw2Gu3?=
 =?us-ascii?Q?UW/DAfEtAjokbbZm3puTXcm4FxcA9WSYjwmP8XR5W9zX4/H3vrPdTLupz2E2?=
 =?us-ascii?Q?/B/9kImqaHXHCXnKBf0HkDAIXrS8aTAs8iJIbFsh9o7Z3xMuwvklfa15gOTI?=
 =?us-ascii?Q?zD2XcOQ+FWr3wbTQ4wQhCdVLIdayaPTfWcTv/VJnAXFo8BXLxW120uk+WaTk?=
 =?us-ascii?Q?E9xrvItfR3hBOyNHiGluGteSCbN+RrSNA+B9/TCzBftvNx004hTx60EbtiuB?=
 =?us-ascii?Q?0ZKKJjNFbOcX7/+wdoYFBFG87gbE5+cQOUgUzHxOoXA0a6jHPUpjqFyNFm9E?=
 =?us-ascii?Q?3zuE/+62/zSguclKy+x9OkiE5ezNu9wAYkv+Nhixy+wI0w7ef28YgshQfrYY?=
 =?us-ascii?Q?JgWRM9gKfQufkFIqM8QfRbrUmJCcBw4IRDzJt8j/fIrmhroRX5pmDYqNfiJG?=
 =?us-ascii?Q?XIIkF4xc2vHZPvc/cBojxfYK2Xg4wxeH5H1qZBe4umgIXP57FOUO2MHnoVHe?=
 =?us-ascii?Q?bysL+b043m0VvpjqpmzR+8ZiqQezam6pwe79AoQXuGvUkajyNZdcdnNeNrVt?=
 =?us-ascii?Q?HtkoDU96ETLcX0xn/1Lzqp3p0oCBIPFFzLjtHy45V10YZEeK0ZKeE6YDQcSE?=
 =?us-ascii?Q?bpK27fU/+uVAcj0Iu3PXJB03UzvvrHU823giN4ju6QImTKoRXfVkhdviZLcT?=
 =?us-ascii?Q?wn/pU2i7397G7lm/W7FNwURp2T5+zVj99j+5KJ9LrEzGua1cngWU6pIgn/ZA?=
 =?us-ascii?Q?/cSKOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VU7ENqFZVodcs+vKKhoCw34kEp7o+iCt9uSF+Zx08cyJayfgSPZjzIX45n+YqiXXa1b7bkRSHIG1D88OPzU7SGmX7K1ttj/upvRKRKfKq1JkG9KGAi7qi4aXiul79eisNQAMlgPLOicrcLTT7QKRZlOyNM94CSJHO0ZY6bjDh2GfmdwCqEQ90cBTOVEO5ndpTbqt9bldy/Fxkb6mrPq9n7rlQvk5C2VWKwb77hYnz81PpQdHorRdox7deV/1lsYuut8beNDSkSrTPxDuvrKW4MHQ3kgU39m3KMAouTwdo09P/ciJAJFYO4r+Rm2XkI7uMBLNIhTLu/OG3ZGcncwbpIeraSTAzNM/MspaiEfvYiY9WV2DKze0BVHu90H7L2MdnGTMv7Gmu4myW8zYW8+vwqua+edgBhWYXSQCc4gGfMPAxuTrDlTevlZVk2wVI3X4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 10:33:09.1597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f187f3-8c68-4ba4-ba40-08de6a221dba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF7A6EE32B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16781-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BCD8B12C89F
X-Rspamd-Action: no action

From: Shay Drory <shayd@nvidia.com>

Driver is using num_vhca_ports capability to distinguish between
multiport master device and multiport slave device. num_vhca_ports is a
capability the driver sets according to the MAX num_vhca_ports
capability reported by FW. On the other hand, light SFs doesn't set the
above capbility.

This leads to wrong results whenever light SFs is checking whether he is
a multiport master or slave.

Therefore, use the MAX capability to distinguish between master and
slave devices.

Fixes: e71383fb9cd1 ("net/mlx5: Light probe local SFs")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/driver.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 1c54aa6f74fb..1967d1c79139 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1281,12 +1281,12 @@ static inline bool mlx5_rl_is_supported(struct mlx5_core_dev *dev)
 static inline int mlx5_core_is_mp_slave(struct mlx5_core_dev *dev)
 {
 	return MLX5_CAP_GEN(dev, affiliate_nic_vport_criteria) &&
-	       MLX5_CAP_GEN(dev, num_vhca_ports) <= 1;
+	       MLX5_CAP_GEN_MAX(dev, num_vhca_ports) <= 1;
 }
 
 static inline int mlx5_core_is_mp_master(struct mlx5_core_dev *dev)
 {
-	return MLX5_CAP_GEN(dev, num_vhca_ports) > 1;
+	return MLX5_CAP_GEN_MAX(dev, num_vhca_ports) > 1;
 }
 
 static inline int mlx5_core_mp_enabled(struct mlx5_core_dev *dev)
-- 
2.44.0


