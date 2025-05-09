Return-Path: <linux-rdma+bounces-10187-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FD5AB0AE3
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 08:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C634A3F26
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 06:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA84526FA42;
	Fri,  9 May 2025 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="XBkvGcR+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023119.outbound.protection.outlook.com [40.107.44.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDED126F445;
	Fri,  9 May 2025 06:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746773386; cv=fail; b=c8xYK599uQYfls+zV3wq2ULUm9AJv7GdEJPyv+Mw18rDU13xIe9K1lt/gpKNaol8ZdrMYF/8tqBRnSl0WxYIWmTqHBlBm7QGJM6jhkLZbtzYAWhFOlEfuyRxFGS2yuE6eSeRWcyoUoEQXYEhO3cAZEAYYHzxCBGqK1TQzmfa7Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746773386; c=relaxed/simple;
	bh=xt8OB/aJQN0Ddo9QxGUdZXtJDQYla6+O0uv3Un/Sevs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=N/JAur5TBMzXiEBcguzLVjjFeB4sG7oEI+PWYwm9xrpmA+tO/f6XwvWMdKQ9siK3mXruFC2AHpDAXCafvwXRHdO8jWfcCH6ikZVdpqkM+WTibwqDvqvvLROkuR3l+DtZNz0vdsrILsm78YP4Qj3tnHWw+yV9ojBAGg6mFmOHQms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=XBkvGcR+; arc=fail smtp.client-ip=40.107.44.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNjNAYd4wYYNIlgA4UZz/9DecV95xHfHYH4rG8R9vV+S3JKN04sdE68iYZHnIzXwTvLvPMy5eWkAGTRXMqRAJWc50r7TB5GByA8WnoELKeGmSXNkjxsyw69xuoSNjhv56U8IxkhHB3b+BiaMJm4s4HEVZRCj0l2qkfUtsMXgZZnFEIIHTfZOspZ2k1b065m30uLGvJU3NEJEdmTs0tEwtomZbGPyGfJKH3jtFGmowy0V+EM7niS+I5SOXjnq0Mljlf5eQHk0qxw5hBFdKPqyeYJBdbnPtAe4cshltc6yAgB2qewsdIUlLEAiOcBaXqStsUH5EgNjLqt8XD+avMfNcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6x6VVZvrhoj8ob412jpI+sfOCuh1GYFe7WxyAs43yns=;
 b=qu9GQ+ziJGbz8r8ukfvDKNoFVRSDUVsieG7t4YRiq2MlgDjCgk7oSCOxxq43xhsdztPsV969XZWlmGgz4oInwD4pWAPXFNkK8+pn63RTSLItc8ZsR26mPlAjj9J4v4Yki3aHQ7/gychiF6GrgUazwmeWl6Mp2RcpBPGVWtK/x1KfPxnSlF9v5+eeTflrdovJzhhqxO8egY9rte1hrX6QotJD3odTRb+DmItABXyDVi2gEdQd0lhcKeEiiiXdeLj+V0jUEnDiFnNjmhyRH/4TeWNZKL2OjCe3WK6As21A+bBSP0G6/x6zITrkxLasER1h5zy9mfnqmeM5BUJai9i41Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6x6VVZvrhoj8ob412jpI+sfOCuh1GYFe7WxyAs43yns=;
 b=XBkvGcR+PxhuVfs/cQu45L4FnKBRHzYTAiaSLYr8KXRwGVlA3TxJNcXMvgZZdg4l3tIoZGvU44diYMS6oJAqAnXm4jfgaGdFSQc/AZ2cooXyfACYA0XDmfTaEJWslQqUA4o8dVrx2AT39Ks0QYvkfZdBuLxbkMf0Maale38Y6bIkTvmxZHms3ufdYKAT1Pgl0Cg/iQ5tyUhBEnBjYTyv6fuH4iUqa0t0fi2gDyVxKBLmZU7f+jISSbvf8raAlEFi3emuY5KrfFv1p4Hii1SSw7pjLyu4XxV2wGyQCUmLwmRnYmZ+8yUq/pcMZBeMSrL/fxdKt0BwB0J+Gu0k4oGUVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from OS8PR06MB7382.apcprd06.prod.outlook.com (2603:1096:604:285::13)
 by TY0PR06MB5125.apcprd06.prod.outlook.com (2603:1096:400:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 06:49:38 +0000
Received: from OS8PR06MB7382.apcprd06.prod.outlook.com
 ([fe80::ef5e:e453:87ac:ba54]) by OS8PR06MB7382.apcprd06.prod.outlook.com
 ([fe80::ef5e:e453:87ac:ba54%6]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 06:49:38 +0000
From: "Shawn.Shao" <shawn.shao@jaguarmicro.com>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: xiaowu.ding@jaguarmicro.com,
	Shawn Shao <shawn.shao@jaguarmicro.com>
Subject: [PATCH] MLX5: Fix semaphore leak on command timeout
Date: Fri,  9 May 2025 14:48:48 +0800
Message-Id: <20250509064848.164-1-shawn.shao@jaguarmicro.com>
X-Mailer: git-send-email 2.37.2.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:4:7c::27) To OS8PR06MB7382.apcprd06.prod.outlook.com
 (2603:1096:604:285::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7382:EE_|TY0PR06MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c705967-2aa9-4b90-3e3e-08dd8ec5aaa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6P4CAlxyI5CCW6EmabSN3zwQTTJnY3krQULSZz6NVc/GLMu3aI53mIPEXtu3?=
 =?us-ascii?Q?1cmgXNX3uh2/3UySik8JYlzBgDzSU1WOHBdwYAbyCLFJa8qSsBQUusdHkIze?=
 =?us-ascii?Q?oZGkTN8/kK9XsNRz4MJi4uUwfqKWixeVAjk+C5bYjOT4qtOvBNTjYtwCUJL5?=
 =?us-ascii?Q?YNuYMo9r1K3rOxdxRIjLQ7FepKrMf8GAe1nvAVmSqiiKYaE1GDYAaPlNtPjk?=
 =?us-ascii?Q?GxHrRVZW+HxIKaBKkcaD5xCjJj+UmQaxZcUnrZH5f2dMFRMTsGu0ttS87lsZ?=
 =?us-ascii?Q?KiXtXWh+opt5j41+QgwZ8Ld0QutAIAMIszGhoT+mv4AHnxMz8DIa/W3W9DKw?=
 =?us-ascii?Q?QbFjelLlZu20IzqjTF7Vv7Ezeu40z9lT8U6+5mOS/Tw6/FbxU2r37Fd7SPhI?=
 =?us-ascii?Q?Grepa1SMXM7w+7asjLW3OuO0/o0pb5FDT0mHC+YqVL8a1mEwzpjs3Y3kfECo?=
 =?us-ascii?Q?zKiOQIvOV9gkDdYAR/mthm5X+xIj6mA24ET5LiPr8e4sqz1ZVBWi61Ho3f0Q?=
 =?us-ascii?Q?LgSKh/JR85K+7mLNjo+mjwMnJUDsbra2SwWzvL19YBnl9YH++csbhMdSuD09?=
 =?us-ascii?Q?AWK0eRvVZDlku4tVtKzATZrCM/cdMuvxB56dSE2+5Rht1NyVu6E9p2yOK6rz?=
 =?us-ascii?Q?tZvANdBJ5LyvtgmqwavThq+rBcFw/UTDwBCuInobxgM/XjFrDb87a0mZoYQN?=
 =?us-ascii?Q?28+uIonvZ0SjHQKKtBVmsfuF0LzcvbzqvN5tNftEszCVHwjpAE/t0eogAC9n?=
 =?us-ascii?Q?jWWv5LQAFCjGXvLyoy08bOHu46DUh1du7xdtBTYzCBC0aIwRDYqrPS0BPBcS?=
 =?us-ascii?Q?A8aPGuMcAvLkSE+aqynSA3uW+ty4wxsmLns9QQ9BrwsFOAF90IkuxGy56MUM?=
 =?us-ascii?Q?HYYPR1ySBsH8w6nE1fXWlSYGJPa4XUHAlaUGrLSMFAfOb/F8UYBMnJ8GSF4M?=
 =?us-ascii?Q?Gy6QWgTHb769n5reHg6WEB8NbicFAvPbnlTQujKa6nTn82gXF/ehu+98Dt5+?=
 =?us-ascii?Q?W9rWQV8NLSI7zI2Nf5XYa2u9MYAsRfn8/1sHpgmtdRY42i9kcgPHa5LziDur?=
 =?us-ascii?Q?VDYfyCwIUds1SxbQDiI7k/UJQsNimvFyCK/JBSMxld9wivbMP6WfOtjV6hmM?=
 =?us-ascii?Q?fSyYwXEok3u4FJSjQU4+3h9jAGvqkvg6kOM8m/xM0BuCopNSmmjphkZYgvYb?=
 =?us-ascii?Q?2uXSjwEG1ecX6dHL6ombWUOjXKd0bd3IJY8xzjCydUwKFacTZFWP8tbR3jUl?=
 =?us-ascii?Q?YDSGugZ8Qx6k5oRjnUPudu1Nxu55ndpw/K5cyq5DCVBVP0O9W20F+gKQUm4y?=
 =?us-ascii?Q?9QIjQv4dd0pC37nR6GcS7vSElA06Pa/yctXc6JljN8B8kVVXqyBqOfufCh2E?=
 =?us-ascii?Q?anMi13aACQK17BIPQ/fciAbNhgk7AY4y80h8bYVAsyV/X1TlPoQn8xLw2tUS?=
 =?us-ascii?Q?nAqUh6j8yFfkCvpJILflOajhn3EGlpBpQD2gTDb6dgnMptiaNo+hCwwoACpN?=
 =?us-ascii?Q?Ykk5fs1+FL15PEs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7382.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5piNW9QBM9PDTzhDiQ0/bDuRL6OYZEwPcxzw9xP2SjSqHlfHVlxP7qC+/93/?=
 =?us-ascii?Q?puBfJy99J0HWuX4ngz4l9/pn8HA+eDFEByb0UibPd3Tw7sNcBxpDtI/+jwTS?=
 =?us-ascii?Q?YYttpox7LbFQgjHlyKNqCD9CiN8Ejpb0EnXqYTV96fUs6P/OvChGTPd/9d5k?=
 =?us-ascii?Q?CZcp9RIc9KsnbMNfRoZghpWve1Mf5/tPdOTiLB9GzsifvSXx/efzQ0+lg+UL?=
 =?us-ascii?Q?ENG6kMqmFA6shDUJMIZ2Pasz8mcRuCqSPm6KYXWnH/OC7y/xOAucADjPs8Ce?=
 =?us-ascii?Q?KcJ3yFHSiE27vCFPJzsPlAFmXwZ/ZnPKQQtQ1SGikYAQSjXrvfcWonFEGGwW?=
 =?us-ascii?Q?ehBXzcDEUBAl/sj5VDPgOXvio5/4Aov4gfOKr+gQ9Ze8W8V57jEdHIH+hIRn?=
 =?us-ascii?Q?Nt8yfw0g+GHDgIpYcadvGfvOdT8fwCS/9DGjjOwEnbpuCKb+AHduj+/S+mCK?=
 =?us-ascii?Q?wL6EGnS9uAik3OZdy3QssJYR4Ppiwgt0ZXInIr5YaJzJHU39CXD4vpmuQGed?=
 =?us-ascii?Q?CdFENZxR5ObTC7yFwyYe/67X3PkUQ+kLaQbfHshA7pJfvJqGm78NAo9QkeGm?=
 =?us-ascii?Q?cmtBNBAEIRP5nUFNf7fPn8yCye7a9KTLAYkWtlw373IYHGLzTCQdWjuns5hp?=
 =?us-ascii?Q?OpVEEJ5pLv7RrtyqAYGsZ3JdEWBdc1QeY1+JphFQor4DLVtQlJTHh6ZRQmbR?=
 =?us-ascii?Q?zpna1kPEnozoGGzW43W5N7u8VOBNKZHni5gnWVNhWtMgm26na9UpBJuWfs3j?=
 =?us-ascii?Q?nGpalsSfafqGUaH8N087TCOFLyus14HvLHs3yZMQp+SAqJ/euW5gwZSAoPos?=
 =?us-ascii?Q?teiQwvKPT2kXW1Pm9oOWoM99g3boDMgyMyCWIGqhUb3m3/67XE32G2vVToPS?=
 =?us-ascii?Q?fISOnSlZ+AWyfaXiBdtuJo9Ju1FPhBO0pgmXH6qO2otqByOE+Z7uLsSzFCif?=
 =?us-ascii?Q?Pz70WyiFnEFX6GTzkWDu+Ph/tCE+7Msa9/M57eXRV7tp/3xrUMQ9paadpXpX?=
 =?us-ascii?Q?11HsipgD4U7BidwE8x3Hdo3cI7qSl5wN5AoQJMml+RxsLkKFU8Sq5yEJk8Dz?=
 =?us-ascii?Q?ZgYqT53Dd74PKTlxVppDQAvkM434yBiy72bcIuWFZVRckd1S2+3G66bV5IL0?=
 =?us-ascii?Q?gGz0W0TGIywYPt0mGJ1maDNKQYLWZYEL3oXTjC0truFV9M6XritXVwGv3Ce4?=
 =?us-ascii?Q?PqzgscAP/mjJHqf+jyViz5yWcn2qpCP5/7yOOuL8rDL5LYwRXkqM9pBag10j?=
 =?us-ascii?Q?XgXycxebaw+VExaPBQ6B4MOS82xUOW5jUEAQNkknjb7vzX9TmP6ZcLLefCIm?=
 =?us-ascii?Q?J9hFE/dwkxXXBA1Xh16RyKzy8vBcankBK5pCU5C8xVuXYNzy1v4QYEL79TDE?=
 =?us-ascii?Q?j+tHvatqSOAwvmrgqmSSQ7KYb9ATb7MRptjo9u8IjW5HlqrS9JKy3eVbmV2e?=
 =?us-ascii?Q?p/ixjnx2QhcUjuHswfFK+8z2/X7IGt40WXMoIbz3lyqs3pLNKkpF/JJyjpmb?=
 =?us-ascii?Q?O8Mjd2SchmT2tHCH2g0Z/6YGp1PLuW5mg5vnlU+lCnN8Q/wlyZPSZWcRlHx0?=
 =?us-ascii?Q?NmM11ZJaRXzqK/FBATb/q2ErBY8CEnQ83+d76Vdpo/NMaf9UMVMf/o7RDKuh?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c705967-2aa9-4b90-3e3e-08dd8ec5aaa5
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7382.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 06:49:38.3417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0if/xbIJl/b3/Cjh7SzeanuX9ZnDzg8sXrk6Fo9qjneP4bKUBbPqulktphzNPOZdfxKZFT9+3av4U3JBbJCyGEMVMEZR61Kpoi2chqO3ShI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5125

From: Shawn Shao <shawn.shao@jaguarmicro.com>

Fixes a resource leak in the MLX5 driver when handling command timeouts.
The command entry reference count (`mlx5_cmd_work_ent`) was not properly
decremented during timeouts, causing the semaphore to remain unreleased.

In the current flow, the reference count is incremented but not decremented
in timeout cases. This prevents proper release of the semaphore.

Add a condition to decrement the reference count when a timeout occurs,
ensuring the semaphore is released and preventing resource leaks:

    if (!forced || mlx5_cmd_is_down(dev)
	    ||!opcode_allowed(cmd, ent->op)
	    || ent->ret == -ETIMEDOUT)
        cmd_ent_put(ent);

This ensures the semaphore is released properly on command timeouts.

Signed-off-by: Shawn Shao <shawn.shao@jaguarmicro.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index e53dbdc0a7a1..7f1f6345d90c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1714,7 +1714,8 @@ static void mlx5_cmd_comp_handler(struct mlx5_core_dev *dev, u64 vec, bool force
 
 			if (!forced || /* Real FW completion */
 			     mlx5_cmd_is_down(dev) || /* No real FW completion is expected */
-			     !opcode_allowed(cmd, ent->op))
+			     !opcode_allowed(cmd, ent->op) ||
+			     ent->ret == -ETIMEDOUT)
 				cmd_ent_put(ent);
 
 			ent->ts2 = ktime_get_ns();
-- 
2.34.1


