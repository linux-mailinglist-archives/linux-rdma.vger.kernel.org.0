Return-Path: <linux-rdma+bounces-16986-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DhtDvBqlWkzQwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16986-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 08:32:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C83A2153B29
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 08:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 089D53060789
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 07:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990D5310627;
	Wed, 18 Feb 2026 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rDAaMbKt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3352430F7E2;
	Wed, 18 Feb 2026 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771399795; cv=fail; b=az6Bm6+BBJukp3QhVcVDTysXuUyOvpPw3pC4rnxTATGt6QidJlFKrOPmOEl/sPr5+eUvmCSMiyN3H0WaHhPtR+9A/Ih8KeIOFgfDksFdfSNdbOeq4CGNQVKQLH1yRfJhl6m5cfDN6RHbzuqrsgSrspBpkGf8nooSHbEK1XOnDQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771399795; c=relaxed/simple;
	bh=Gkru1rg1dm5xmnrVnRAuXIwuK/PFFWqfSGf0QEzYHRg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5xRuXCuJ0OUMCmJSwXoCEObTI1Yer2+x8Q4cZ2Nozb8SzYF5kvh3UtjE8pUCaszFbi685a4Y4ZI2mGliHEmOEOHxc84QMkehCtxlQk4JMCky0w+11hnT3ZOEjU3rp1IyBLJgWYlwI0zCgweDUYgb80SGW6wgC11ACWgxfpEywE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rDAaMbKt; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrM/M2xwGpCF/+ZuNnOJR3dkIDoPkKzRU9oIM6xbQJ14RpAj4+4gi6IWbwy7vmdUbT1eGjrdvBktfvoiT3ouD6dI9oBclW63+SOouVbTSwYegttVlQguHxT0dTIsn+1QQLXp1Z79D1YrWmWuY4RmRB4xTPFz/CmLsl91ZAt0zBfjgZ39NNWZ3SwBlkwnWZnI1lATH520y/zMntqpqADRZdzSB5pzPUos5ZAkPsViq0RDF+HQx/Yo1r3hwTBDhyloylnYhEFhPGBMjkzo9fNApkW/ojLf3AkSKJw1Pl2EdGiSgwXQU5uikPKjWpUM3VM+W6E3/me0JegpEFE54j/Amg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98+gVU13aLrZGZpJkN6VY/Nfa7Edx+3FyKzAQjEzuxo=;
 b=ohuowVp18TqRPCSYvE0/WmnkGohvChjTd+TQV9EhiTXdoViA/XoizU6hMMcpYHkvTGfzK3sN72cx09sPF5dqWF1f9gD0HLP47v5qxyXNcVeKyoB2nU9ER989xJdMBWH6hui4OyOAihuZdWv7sdU83r3xs5220mon+S64AFnus/zmT2yGN+d54oeHuDh5ZGUTTIcaqgp0D1ptGx9xV0EbnCVoLIHazZHzg4Pc4PzmbwDn4a8RyHe210o2yIAB+zjoxk4xMcBQIiLiybNWis+y5NCYim34d0gPb8LE6ry1J96Rje8vT5zr7O0G9insE2SuhPZKSMb2uB6T3IBRCFMzxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98+gVU13aLrZGZpJkN6VY/Nfa7Edx+3FyKzAQjEzuxo=;
 b=rDAaMbKtDuYqtRMuOeDAs/s1lPqwpaYEQBrpeVtailGwqRwYNExU1hqaSbIdFbaGAb6ny+s2YVe8xj3b2b0GjkY6PfAvdsrVSRd8jUjB7DEI/HnhtvJ+yGp+y7ZoUFH3RfVVaA554jX+i7ayKWjPutYZABxRd9vZUF5QDszdEMTD0sGkoOiiLcTncTgUPT3PU4TAQOGGtiOcxjsJWo2STDuGYLSBrWvAAN3260S+kHhNHSM1ibeIFJxjIp3+GfTvLAGaQsKvNkCz47AKTYQwO35ZpzMnvzm4EsG81rqL9R+xd8DBWeRxh92ApBhPOXK6DrxT0KO8yGBgTrlOj+f2JA==
Received: from BN9PR03CA0502.namprd03.prod.outlook.com (2603:10b6:408:130::27)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Wed, 18 Feb
 2026 07:29:50 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::fc) by BN9PR03CA0502.outlook.office365.com
 (2603:10b6:408:130::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Wed,
 18 Feb 2026 07:29:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 07:29:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 23:29:38 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 23:29:37 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 17
 Feb 2026 23:29:33 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, Jianbo Liu
	<jianbol@nvidia.com>
Subject: [PATCH net V2 4/6] net/mlx5e: MACsec, add ASO poll loop in macsec_aso_set_arm_event
Date: Wed, 18 Feb 2026 09:29:02 +0200
Message-ID: <20260218072904.1764634-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260218072904.1764634-1-tariqt@nvidia.com>
References: <20260218072904.1764634-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e2e302-76e2-4bbf-84b9-08de6ebf8081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OLbEa1p7NczADL/cwkmQn4w1p2uyU4aHxYD1AjNjYQbyZqgIKR0aC5RRHvBA?=
 =?us-ascii?Q?grd9WGhMXOTA2Irezj3tpWLjCf0sbtsyZfXhok245gNbjtc02n0+9UIc3Xb3?=
 =?us-ascii?Q?vGAPTn5dCDr/MkRiIG+EMc6QnKnPIOB7jRZzjGEf3+jEPa3z2/xU8ZFQUHGI?=
 =?us-ascii?Q?YZLqRgnQ3e84JbAj6tCdovkJ7x+MUzWByAQrNjm1VXPve/rmbnHf5SnL9ccH?=
 =?us-ascii?Q?1Ik8q4gYXaFi6eTMHLqgYgFcBPxQE8I6V8bY/MhJwGg3QIoBmFppFhxXOcRg?=
 =?us-ascii?Q?aI9V0eB2N8oobAYcB1iAxnPoLvoMsBkO0PGGyJipmQScb9NOsmWxL6KP+SRi?=
 =?us-ascii?Q?tQnBCnFUfNLDY1X8EvJQIbr1a+a/vR9l9bmtdqu/qJJoTotreIjnZ+N0v3+L?=
 =?us-ascii?Q?EXwP0eWDdGHwNKC7tyEg3sECrEd5itKLnFuyz50RaIne2izVrcd2DFC/y7eV?=
 =?us-ascii?Q?3gTLlDKIAq9HyudM7XkxJtXfUNsi4Crt4LOdhzeAjUEpv4BTWyItpENFnXaG?=
 =?us-ascii?Q?GUIwYg+3+ZmFrAXAg2RYe1GbMAcLIf7/U60b29ObFe5678AmV9FIci4xYX2p?=
 =?us-ascii?Q?j3eny1mIU7iZmdTETnco7Gz/2QIrC5US1eOL8dnypnwDL7Sh3ucK/TqvE5ED?=
 =?us-ascii?Q?YmmUAl5OxfnNcrnwf+iYu0wiP7Cv7BTMDH/ue7gIofdbgex9HaTidG40AFq5?=
 =?us-ascii?Q?UvxkUlU3whqtJ5w+bD19AnmXFQSOWoeObzVqm1uebRd/4hSU45vf03xPYqpa?=
 =?us-ascii?Q?yWWXwYMR+4qF1hu8zYLPQ6mTXVkeznuMvYbU1/8xph5oNqwtE/lZZ9d23pRd?=
 =?us-ascii?Q?Hufc+5jObpDhRFDvgS4tXVGDJ5be9PbkQdm16fnld0v1El6PDhh67aF+3uYK?=
 =?us-ascii?Q?h15uah71EyDqPH0Ch3EH/3kXx8gePmKF1MTqsymSJ/eTKi0ySS02Q0ED/pyk?=
 =?us-ascii?Q?kHrkmNScQrNqV/xZGOSxPteopl7uOa0FQtI/aNdChKzDU8F+WYCvARP8aCDr?=
 =?us-ascii?Q?2sPg06EMThiUdkKE3NMTHuTFGY+LPSG/ftRWhGz7xj+ddFA0qJe/wWrxn1I7?=
 =?us-ascii?Q?jvuvtbZxJyqAeWwXSgm4j08Bhors54aR8pV+PcgKrc56o+uniNLyB+pO4HrB?=
 =?us-ascii?Q?RWl0iIluJCkeJnZTFx/r3ll85tchPhsE/Om3YFKrBsLCplYP7ZgJYCfC61Q6?=
 =?us-ascii?Q?/LRFJRnMWwZs2SzpqeWA2PHM/Kgd4zphGz9X/SBgbhKVua+5H5LU6/WgP9VO?=
 =?us-ascii?Q?+GcK6Q03/ecrVpdGjF6b66MXwRHybWk9eIW5+rKpX9Gu/J/BijjwsFGkAiWR?=
 =?us-ascii?Q?BYNMYfGEfIx8JcJPl77jI8hwL1RykW3pG++f224EUYXPON9lInIJ1PMPyXW7?=
 =?us-ascii?Q?0twpzT6WDOPkZyXZnQ7H3DAkWpQEXAfKi/x5iFqOtgmk+dV/KcCazNHohE7J?=
 =?us-ascii?Q?BrHY5ic6LRqNjTe9pyb4NYx+EsPTLfIkT7XkAwbDly/3B3H8GPm/gzOAWhvG?=
 =?us-ascii?Q?e0bsQxD8TlTIsBdSPxZ/nyiojmRRLmjBMFLvhL7NjC+akVXtZQ22RIPfoOvO?=
 =?us-ascii?Q?5sVu4QQEqjc7tL6mNpwcDbdYqFqjg4gLeZUaUMmnXAekevqZxtBR03Sf0qB1?=
 =?us-ascii?Q?gxa00U24LVS5MOKY4loa4Q5aMMvPE6WigNxYAEwy83hFQjiAafqVS9SggH5r?=
 =?us-ascii?Q?4P6HhQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CJXV59y5VtQaVEbUUi+7dok8/SqiPR/BBM0ypXEI5E4hZBoG/jZMmfSVRl/cnemlxJhRifl4LPYFfAJd2P7vHZjDP+W76KvJHJyq9tTqx6Mslpp1clbI4kcc+0Yx9vNiV2nm/BcfseqvaXu064Guf2cFOPDdM6kVMFPmLWyPw4G5FGRqf0Qm7hP2502dDaaQmJAw+84VtJ1Dhk47dJ8WB0lc+n+L5P+MrXKTCXnHrCLiCYnT0oi0t2IWQEVZoKPnyIh8TxJQRrU0kOdrgrY7xEn32mgPmKoQcCcsQ0bGDJwupTeNW+8q8GJow6dAzCa0yHUcRH8tJg4UQmGE2VgAaCLKyEaSuLySnVOs2BEQOby1wX4I81KzW6jRw0nqfqLWARogdpS+hFwkiaYGuQ5sJ5EJeu4d/Qoa1bEvoM7EvBW60Mh5K9Fo1zxFtvnDVOhW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 07:29:50.5007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e2e302-76e2-4bbf-84b9-08de6ebf8081
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
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
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16986-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C83A2153B29
X-Rspamd-Action: no action

From: Gal Pressman <gal@nvidia.com>

The macsec_aso_set_arm_event function calls mlx5_aso_poll_cq once
without a retry loop. If the CQE is not immediately available after
posting the WQE, the function fails unnecessarily.

Use read_poll_timeout() to poll 3-10 usecs for CQE, consistent with
other ASO polling code paths in the driver.

Fixes: 739cfa34518e ("net/mlx5: Make ASO poll CQ usable in atomic context")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index 641cd3a2cdfa..90b3bc5f9166 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -1386,7 +1386,8 @@ static int macsec_aso_set_arm_event(struct mlx5_core_dev *mdev, struct mlx5e_mac
 			   MLX5_ACCESS_ASO_OPC_MOD_MACSEC);
 	macsec_aso_build_ctrl(aso, &aso_wqe->aso_ctrl, in);
 	mlx5_aso_post_wqe(maso, false, &aso_wqe->ctrl);
-	err = mlx5_aso_poll_cq(maso, false);
+	read_poll_timeout(mlx5_aso_poll_cq, err, !err, 10, 10 * USEC_PER_MSEC,
+			  false, maso, false);
 	mutex_unlock(&aso->aso_lock);
 
 	return err;
-- 
2.44.0


