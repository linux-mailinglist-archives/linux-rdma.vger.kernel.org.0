Return-Path: <linux-rdma+bounces-4181-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2C4945893
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 09:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45545283AFB
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 07:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522F41BE87E;
	Fri,  2 Aug 2024 07:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gXl71wuj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585681BE849;
	Fri,  2 Aug 2024 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583479; cv=fail; b=VU2boWWdxO3uV7uT/87/gZMjKEqPLcoJF509AWFEtOZWujPqs1IYo8pwq8mGAZgzHHm2cIeNEMWewJTm14eHpY1YT1lgfcKjbczwn0w6YT7VOKb89W6R+w1bKn/QdanXuI0se2rgH8WSMPIF9DrPWfYYLY005+kKdQ9R+SGbTSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583479; c=relaxed/simple;
	bh=FUka5qk6/51H40hlKRoZOsn86GGp1j4Hu54fbEuZI5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BE2+clsVlb5jCYNhEFLGyHTto7iuQY507+Nwg333uKGSYjT4lQMFB/SjI3aXumcpOMnWnzfYVyKAFchqsGALyF7rsKy+4yDFVfjDBk2BYUyRT9vh+UspZQk9bIcM+uMrkXLHtKtbYuNaVids+Qq0mI3kOkw62dUO0o+7KkaI09w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gXl71wuj; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2m7xbz3y1a3+LL4kjGNzmyYkIQljntd3Xv0fYXcrWKyqQ9sYpEIStbq7l6+4K19Fo6d558i3/+q3AEVrrJrRuMprJCCfOkZUS50yO8uX5jROfe//Q0tKEtwh3zei5V8PCVlAnAuA68T23DC0Vp4zBMiE66GsjvccjImgOERas+y1mgLBZiRe3BE9mu3evll/vLXWQJfsT7OaCqf/xNo6GEGQMCgULWqW3yiXWDd/8oq+LfYLSGS3VIqtlcgNBbJGs5jZrC1vX3Mw3oFtCp1UeyLSx6VxZ80hIbk7nyvqk8smC1LeWgVtr+p3BLBTEMfcwrj5ToYAxQFF3z33H0gZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAfTIvEk+LAh4zqVzWI5gOR8Fd4lOSuFkkLGCyxVrMw=;
 b=er88jLycqT4nJJvXMVJki2bWPZBBpc2nbgiObgdjsAdasox47B6htXkl63LUoea3LAaI8PS3182lWULRZoYhaEMLOZepAmVx9YqPG+uYWSIczw0VkBr2n3ltEKWOuJEjE3PXZ7zeCLhr0kOpasiVOONuixY0KUGiES868Weznrv4z55oQ5Uu1l8AAiJxNUCDYDrZvgF7MuayJ9WaMTwcGqyveOobPmSnPM0MWsWyAnVveXOZuACwBAYPfhr2eIpeN1K5NviEodxkt+23/ExX5SYhEb8trczRcHE6o48axLZXG7DTbjPgidbg02KWBfK02trVgfNSoIV9qh8Eeetu1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAfTIvEk+LAh4zqVzWI5gOR8Fd4lOSuFkkLGCyxVrMw=;
 b=gXl71wujmUOMvQTJiIomGXy8eHSq3bNDeT6JTXlwvpuG+miEUySL5TKQFo0XIGgEZVIWgl5l/jGBpTuTyYK2jIQFvTf1K2AnQNLtnToOA2WAOKpt+CqzD0hcmMrew7VsUVmKUbn5TpeQXW5wKhZagEUUHreJStuih1aehaX4Nr5b31si32jut0rsePClSOHJe1QDo6ck3amYOb+9vDQ4n5AssAYI0mBpMJ/4UCILjp47XrBG9smCdjd/2AMAQoSpnTMOC3XjMUOvrkOCvIU/yfSL9fecg1lTOsQI6PWivop+TlxYrLTz1hJXNpPd5O6TIcNtTn61ZfAH+KVc4koWJg==
Received: from CH2PR10CA0022.namprd10.prod.outlook.com (2603:10b6:610:4c::32)
 by CYXPR12MB9278.namprd12.prod.outlook.com (2603:10b6:930:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 07:24:34 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::8c) by CH2PR10CA0022.outlook.office365.com
 (2603:10b6:610:4c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Fri, 2 Aug 2024 07:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 07:24:34 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 00:24:24 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 00:24:23 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 2 Aug 2024 00:24:20 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Si-Wei Liu <si-wei.liu@oracle.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH mlx5-vhost 1/7] net/mlx5: Support throttled commands from async API
Date: Fri, 2 Aug 2024 10:20:18 +0300
Message-ID: <20240802072039.267446-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802072039.267446-1-dtatulea@nvidia.com>
References: <20240802072039.267446-1-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|CYXPR12MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a1b91b-e43e-43e0-1d4e-08dcb2c42888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rzRXEEst1NlFLzeHh0FsStEbzeQxVTolGxeEsQW0WAkiNsTb2U9Mp58tG1jB?=
 =?us-ascii?Q?dJmG+aoBfqs5B1Z7RNwG2LJIVi4rcrVXNC7Vbijap1EDYHBikkvA702q66ag?=
 =?us-ascii?Q?5aLYbl2E4cswGAR8BZiRBYm7NpuviRboL/0kmydtii8tyMf/E7SV8e4s1tEO?=
 =?us-ascii?Q?UNYso8jEN+jtk3FgO0I33dDDKFrTp2p2YaEBuHkVtG3Cn/Mtztk1mqDk+xQy?=
 =?us-ascii?Q?5PPitSVvtsqzspN8xS9jv/jF3O+avxX5qGICR3MG80tDBeAjblP7KeHgKx+J?=
 =?us-ascii?Q?ATEaT0ibgHIOZ5Ydab1xi99SiuH0rTISD+HUFwJ9yTwr1gS/K3ZTU32z8HvC?=
 =?us-ascii?Q?sjWiHiFULpY1wz6a7Fbh0a60G6TDSPY8rt0o2rK3RzmLZb8/9N5PMyxJ+4IU?=
 =?us-ascii?Q?fbcKSLnb6xejHJbo71RG49VWdgm27h/TAk9kZGzNXoUhqxUn6U6++MHp0Sbs?=
 =?us-ascii?Q?7+XvY4EUlr8/rznsXajQXfGuq654nCSSfq4a8lQNhaN89nRA7NYW/qrwcpYv?=
 =?us-ascii?Q?sMsyHCRVm5hTM50MHJ4nKd5SnVFMGJm2fztqpe81+jyHfeqZN/CvjrbeQkfK?=
 =?us-ascii?Q?ANsxY2cdOw/qvqoKb8cEeGcWh64FEnPPJSUWy/VrXkolWgTz9a7Z0dmG+nNA?=
 =?us-ascii?Q?rXkwocE8wSI26m6+kT6kkcwBwpETeQXy3neYtjLKGZzBL1T5CHvP9Ep8SaF8?=
 =?us-ascii?Q?beyB4BGdtapPqdgz7p3FqnoAcRnMXYej9O9SMdEKHKv8T/KorVVhIsgDUrrE?=
 =?us-ascii?Q?lPX5V4KJiv9hl3bBoetoWVjGj9u93p6XyIXKyDCReBqZGe3OqhOkCqrcfIwx?=
 =?us-ascii?Q?fQL6gygWgtnDVS5UGraBmoUmDO8QP2G6VG54LO/qXUemnf+K6LTygLQTo+Z/?=
 =?us-ascii?Q?nNnsbZoiYrNyyjKZS3qDCbh0Wne9PnaQB0nBx5Tr/BKlvZupFZLCnjdqg8df?=
 =?us-ascii?Q?cIDrkcy/2LlnqA0ErF2HlNSmCXgGqa2ylW00ikkH/yza8z3i+gWxsW48AEaz?=
 =?us-ascii?Q?I8+wQt4nkqOv+g0DGX4LqaArBKEwg3+zNtb6+nNjfca86mc2Y3MObQ47a3db?=
 =?us-ascii?Q?IX29BnKmXqCTgfJwZPaUrnqVwLzt1azFr2dpeW/tvoBldcUZc/acZspH52WK?=
 =?us-ascii?Q?WVXpq/aj8YqsVLkVQNXh8RRlxc8xGTJYSxGSHOYXCirIPvh/kgD45n2kqzuA?=
 =?us-ascii?Q?8n7Gdaro+DQPvGy6JSNRSy3BbKXib+8FTxIR4h+LDn0i/9+Ju5Ps6z8RekLH?=
 =?us-ascii?Q?nCOIA83s5/poUt92KGA9KBX203w5ocMzJ+WBSP6yslwqUZ9WIadZg/Gdiwfz?=
 =?us-ascii?Q?ZIc4uGVtsXi07CJaZwm9FLzpvq2x+5EZ1aCkS4ta4lnIfZfb15cGagXtODGl?=
 =?us-ascii?Q?Mz1WgvAjFLBzcp5dRNsb2MJfJgTrbEKaGn4683/quPqh6sTHsKtCnRRHht7H?=
 =?us-ascii?Q?J5+j0YWKu7PL2nI5clYp49mIqrJ9/oB2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 07:24:34.1392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a1b91b-e43e-43e0-1d4e-08dcb2c42888
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9278

Currently, commands that qualify as throttled can't be used via the
async API. That's due to the fact that the throttle semaphore can sleep
but the async API can't.

This patch allows throttling in the async API by using the tentative
variant of the semaphore and upon failure (semaphore at 0) returns EBUSY
to signal to the caller that they need to wait for the completion of
previously issued commands.

Furthermore, make sure that the semaphore is released in the callback.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 20768ef2e9d2..f69c977c1569 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1882,10 +1882,12 @@ static int cmd_exec(struct mlx5_core_dev *dev, void *in, int in_size, void *out,
 
 	throttle_op = mlx5_cmd_is_throttle_opcode(opcode);
 	if (throttle_op) {
-		/* atomic context may not sleep */
-		if (callback)
-			return -EINVAL;
-		down(&dev->cmd.vars.throttle_sem);
+		if (callback) {
+			if (down_trylock(&dev->cmd.vars.throttle_sem))
+				return -EBUSY;
+		} else {
+			down(&dev->cmd.vars.throttle_sem);
+		}
 	}
 
 	pages_queue = is_manage_pages(in);
@@ -2091,10 +2093,19 @@ static void mlx5_cmd_exec_cb_handler(int status, void *_work)
 {
 	struct mlx5_async_work *work = _work;
 	struct mlx5_async_ctx *ctx;
+	struct mlx5_core_dev *dev;
+	u16 opcode;
 
 	ctx = work->ctx;
-	status = cmd_status_err(ctx->dev, status, work->opcode, work->op_mod, work->out);
+	dev = ctx->dev;
+	opcode = work->opcode;
+	status = cmd_status_err(dev, status, work->opcode, work->op_mod, work->out);
 	work->user_callback(status, work);
+	/* Can't access "work" from this point on. It could have been freed in
+	 * the callback.
+	 */
+	if (mlx5_cmd_is_throttle_opcode(opcode))
+		up(&dev->cmd.vars.throttle_sem);
 	if (atomic_dec_and_test(&ctx->num_inflight))
 		complete(&ctx->inflight_done);
 }
-- 
2.45.2


