Return-Path: <linux-rdma+bounces-16782-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAPIDtesjWmz5wAAu9opvQ
	(envelope-from <linux-rdma+bounces-16782-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 11:35:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A830712C8B4
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 11:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BC583123A31
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 10:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC68B2ED848;
	Thu, 12 Feb 2026 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Go4TP4GO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8220E2EA72A;
	Thu, 12 Feb 2026 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770892401; cv=fail; b=kc62hrz7lsEFqmIrU7Snd8kjjhnD88gv/Uj5jX6rasO/QjzWflZLY8jXA+uB9rTp78F1yWWCpE3GWP2OHUMFaY6+k6xE5f/zzM9+kNoAtHVzoXhFtKZj993SwfGD4HTxX4FeWBynd/xm+TfPucl9E298wXbVzwD9u4mmlR2cqL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770892401; c=relaxed/simple;
	bh=ll6yCjJdMSrbEgOoFvM1SgRinUAN9yGaVrZMMetrjmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YdtydvXwGth17ePgWsqmYsqzxcQB2itdYy7Y0i1B9UjPZFhBKyvO8iEB5bWzteS9iEwoL3zCBuxl9hMNmk4vFWJJyO5OZrP+Idh4/aF2Ih5Efmx4I7hKZEzvbCtTdjHGbdoJd3kcGwXDFGFb+nlJ+0UvJHXIkOWNv7oiKuSeyUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Go4TP4GO; arc=fail smtp.client-ip=40.107.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfPkNLuKbODQfEVbn/OCaA3n55Wlrc6xASQ6qvcgUiWpG0ttXsEiekLiTYYKBfbJ49eUbNmkBdpiTYZ8zqsJ2ThuQorg+oiFqCR/958X1EY8rW+7Gqh0r/sKkGDr7DTIXQ4gZXmneLOcRvNHUUPTaLHE3C4a+8jvYmjxPO4SPpMF/dLz/XpkmNVTc5SD29Wkf4BQe0XRluI14PDYZV4dMSWXKoJacYgvVhkmxQETWRxddPwJxOLa7zeW0J2iMq5lNSUgLLXX/OqRrF6NXXecnEDjpDbLZmD4oaSH7Q5bsMcS+2/oxkLAQFxsHvr3QXE8Kj9aFKktLGRSRv/qjZ9OJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=230oW1pkryGJzrahsOcxYp2lHEoTZjlxfdVVZhPjZ/o=;
 b=zUoyYNgtywj3r/7pzC+psO/icxYiYll9RDiqJvIbYBE1RHElSY4+KFXwUFkbiOxnGzJNe2C5jdgyne/RQhxm5PzU1Cna0t6TQmb+XgQOaRuCfv4QBqDmej3BpmhEHd26lWLoKTmtTVEeRbriGdhic3vIsnUpRprfPDRRYpORaojOTHd84VLqXZdheJFJGdpK9ptr6MYcA91Y3H0KcJnrDkkwhkxFOqJ2QZveF2hsG88F/mJw4FsLDeSfqit4rFW9cqzEwfend4OTdY/epJxjSE3Whu0lRAHKc8XWu01WtCni2qeLU50XQelYotlvZxP4Spsi9McugjD4gZlkBMEPeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=230oW1pkryGJzrahsOcxYp2lHEoTZjlxfdVVZhPjZ/o=;
 b=Go4TP4GOMot/NdsJSRMwqF0pXTQBUFTv5Q3fBrR77RZGN1P2QEmYLA4/Wu7+ucvyPQKOmQg6r5Rj8KV3KiX+YbBgKQJdVy6GU33Te/WvnOwn1oRz2L89KIIFo81AZbIh+AXnMI3Amk62SQTqfiXHskHC2zVM17W1ao6kBkJguHkYeZhmSsQuHPtJ9QBKC/mAr6QNkVFbdTF/TqOXKfucf4lapB2BNcBLIBRLe0odf+OpH9FvnFtBkjgsX2w9bhOaWsJ1Je72FplRarPomMHg60XeI/pIsDffk8LNBIdjhty/ju8Sg/kFc1/zVyQQlRIdTSEjU0RtW2fNFOnat2bIzQ==
Received: from PH7PR10CA0001.namprd10.prod.outlook.com (2603:10b6:510:23d::23)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 10:33:16 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::30) by PH7PR10CA0001.outlook.office365.com
 (2603:10b6:510:23d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend Transport; Thu,
 12 Feb 2026 10:33:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 10:33:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 02:33:02 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 02:33:01 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 12
 Feb 2026 02:32:57 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH net 2/6] net/mlx5: Fix misidentification of write combining CQE during poll loop
Date: Thu, 12 Feb 2026 12:32:13 +0200
Message-ID: <20260212103217.1752943-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef2ba0b-1ab0-488b-c767-08de6a2221dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fe88+JyhI/fWw10CnvHy9SZ94aKK4ieEUcXCcgG52zV24htYB8nJDPfikHVo?=
 =?us-ascii?Q?JhqB239pVt79+zv99dHW1hJ36t9nUQJprIq5sh3WjSl8gEucbBUabHUsd8fo?=
 =?us-ascii?Q?Vx3zvE66uqW4uF/BrkVvArBbSzlgX1iUXwgjzLgn6j7L9brSFBLASEN//kGD?=
 =?us-ascii?Q?A+FIR+ZCGPJvcYCggQJ+wa6nJQWc5maS3mZByKihguzp/g8DXgURYjHMyxQO?=
 =?us-ascii?Q?D9BnKSZT5DdW+vwJS3fka3nV08J6b2FU46neTf5b70XMKnQ8A7rIwn1Lqexy?=
 =?us-ascii?Q?T9x8NOOaz9wvZ0yo85BTnSPwNCls1j8Dh/Asi+Xq2gmpgIrH2u8zJ61OZgrM?=
 =?us-ascii?Q?rfHqwGhLN3ZTQuZDdrM3OQjq5Fba3SiOljhpjHCqJ6eZC81YOn/Woc+nKMox?=
 =?us-ascii?Q?3DVLsI00zcMxGkcTk/P5h72Y0d0C1n9Ux7j0Khc0eJPqp7dQ4AfqmLuPe86j?=
 =?us-ascii?Q?ieMtLM7MFTwGa5HchIaFuCyFxP9p1rurFnnUVyCMpPW/jtHIz3XKof9eH3tV?=
 =?us-ascii?Q?gFSIAE69TugkBvVMUNQusDDP3VPt2PRUo8jAlHnTlGL4m9p/wmJXKMmcJfVO?=
 =?us-ascii?Q?rk+lbG1v7XcHTjFpU2dfOeWfooPlcXKQ6KY15rklUwTQpfU6fFACXsFxEJYo?=
 =?us-ascii?Q?40wZK24gMw5zrgWcF+wTqhWhul9EdBJqMK6PnkUN6ISfF67JmcWh43JNBmsZ?=
 =?us-ascii?Q?mVFPs4LElMmuNBU4hw8aotHkTQfMRh2tFoGhBtcnNOpKUp9HLDSpa9rDJCCk?=
 =?us-ascii?Q?EXVlwSptC7lGn8Y2mR5CCTteNREX/9bknxzs8o42Z7VLVJCPVIuvVCk3etRq?=
 =?us-ascii?Q?9f9IF72Ol2wtLKb9WRGd048H0ML8QfYw5YmN69Afyl9p1wPOC8aolzpQkq79?=
 =?us-ascii?Q?EzLIiJlnOEM8MINvjQC64vgGl5vzDKS13FuBfxLG9A9KzkI6MEUWrp7zmRZK?=
 =?us-ascii?Q?aHLM3o5Lmmy/73IOnvSTvJFLbJb2cD92dPYwwfhuSlKIa1vvAN0nrq++lbkg?=
 =?us-ascii?Q?wz5fsgJh9DNHTDAq/PY4+eD9SdQf4pc78XBQwsmqs9SM2o06EYCbqtI+6Eph?=
 =?us-ascii?Q?XJXJYSa/KcCiZKOEuvAWpEea9LB+5j88Wmh60hYcR5n9JH3SOCdx9R+ujLGe?=
 =?us-ascii?Q?qPnHJmmgmmmmzDifWDpWuKDj1S7eyfz0ACW8mbKteBDyIaNBgDVWQpa2KUup?=
 =?us-ascii?Q?MzJJCtojgWn2CJ/l+lNDfVLinMfpzm+YCTwRxv+QKjXhjJomFaOsyQSHz8wu?=
 =?us-ascii?Q?7H507xMo4NOaYieR9cRoDz5fR4iOtpF+KUBBQ1MWOvpCJd4xBD6GrkT8FBeX?=
 =?us-ascii?Q?2Cy39KxMfuEgl7j+IUmH3bdpKTSipqVqq87HkCZs7XOGes7ly2aJUzK0bRVc?=
 =?us-ascii?Q?FlhGBpuq5lBAqy0tCzJJ48Kbwfl81A26A6hRu6cWWnG4IPFidEDtiisAo02/?=
 =?us-ascii?Q?KZkxGCibjcemBLS7VsJUDZ85/Y4390xhAbsjKhUafXoX/zgI7uti6e4uNsot?=
 =?us-ascii?Q?XPrIj5MDsZpND2XU+olCp4U4iJwB1x7JaCqCsHyPzRd9TP5XC99ZoA0D89EF?=
 =?us-ascii?Q?EtGqCFqbXmr9zPZzzF4S0UWMWZ9cuZO15Jonyt3DkREgkkp4Gd9YWc+Rl62K?=
 =?us-ascii?Q?y2qnAg+E1FZdAVPFP8rr+ZDgedU3zkSwKkxPL9Pl3S+a7UkNXb3pl34zVAOh?=
 =?us-ascii?Q?Tt2VHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E4MY2jNHXrx2rb5wkjFWw+d2mZUPLy8xgwC7Ns4GjRs2LhRTB8qxb6yMxGJjQcJasY+4HEpxrKx8KG42Ucz6q8k8z+R2laF+Z/3UbNOXYfzFFfCycxW81M3lx6RS2IO56h6vUuk+NYALrIgBGyWQ/oQWWTqMitew9mpiqkGSD4bU2uyy9HTALjBp/n1529LaAOjtNoR8z0AcEAx3HMq8nSL+0RhUaeKcknWgXn2dX3kdRbT957fLDTV2NEkYADXokQzRKTPJGj0GYPScXC9Xt9r3pTi0NY/qSI2+JdFSZhFuYVWEBXz0Qdorr/2k6O3uUP3GXOAETZuG/wKQE/vcqd01OW4vWttpXXnoI9scKxFv3TTrLTJ84k857whtd1I9qRiZyt/iEvqeX4m+LrYYAGVJI7aH+NY43OTPy39TBMRcO5rb7nGQXevu8Ji3Bmds
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 10:33:16.1287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef2ba0b-1ab0-488b-c767-08de6a2221dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16782-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: A830712C8B4
X-Rspamd-Action: no action

From: Gal Pressman <gal@nvidia.com>

The write combining completion poll loop uses usleep_range() which can
sleep much longer than requested due to scheduler latency. Under load,
we witnessed a 20ms+ delay until the process was rescheduled, causing
the jiffies based timeout to expire while the thread is sleeping.

The original do-while loop structure (poll, sleep, check timeout) would
exit without a final poll when waking after timeout, missing a CQE that
arrived during sleep.

Restructure the loop by moving the poll into the while condition,
ensuring we always poll after sleeping, catching CQEs that arrived
during that time.
While at it, remove the redundant 'err' assignment.

Fixes: d98995b4bf98 ("net/mlx5: Reimplement write combining test")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/wc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
index 815a7c97d6b0..29db15c4b978 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
@@ -390,12 +390,10 @@ static void mlx5_core_test_wc(struct mlx5_core_dev *mdev)
 	mlx5_wc_post_nop(sq, &offset, true);
 
 	expires = jiffies + TEST_WC_POLLING_MAX_TIME_JIFFIES;
-	do {
-		err = mlx5_wc_poll_cq(sq);
-		if (err)
-			usleep_range(2, 10);
-	} while (mdev->wc_state == MLX5_WC_STATE_UNINITIALIZED &&
-		 time_is_after_jiffies(expires));
+	while ((mlx5_wc_poll_cq(sq),
+		mdev->wc_state == MLX5_WC_STATE_UNINITIALIZED) &&
+	       time_is_after_jiffies(expires))
+		usleep_range(2, 10);
 
 	mlx5_wc_destroy_sq(sq);
 
-- 
2.44.0


