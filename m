Return-Path: <linux-rdma+bounces-4442-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ACD9593DF
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 07:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E8D2846BB
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 05:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184D715C147;
	Wed, 21 Aug 2024 05:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ols2QTFV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE6A2599
	for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724217043; cv=fail; b=DQk+7YuNfpOTaUUJaQrXmTmQxXsMC8FLZRfcCftqACh8Z9QiGVgBWME5wXru5vj/5a7GgUYKc1K0L8N74npQdzsCrCwfTpfoKoFZPoRIKbQbAcl8Kp2NZnFFicwdUzZcFvmDm3S5oOrkF8QB8gBvrB9IBxuWBXTYWww2FkjxjkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724217043; c=relaxed/simple;
	bh=EQFkdF98ImVIpiz+D5z6Qiggi1JO6HFXBAoFITwzt6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7uQ428Wxbn2NEhXi6EomHhHSUVzrW3D0/QPYymqFzZDUvAyuU5HLVNAZGOS5LNElNGW8Rgz9OQVhh0fI1iXndzsG/fCqiAo0mCi1e8NyRFVofaepQ9QZXr8y2jC15tEHyJQOulb2G0gUdwfhDBn6KuFdfJPZhMga4eBQjUggUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ols2QTFV; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwZcdF8cYsgRvHIUigMsjqxNeT+hMQuv8pwP8ooE5eYF6XuWsEeUzqVjVJfXu8KfOyQldZ+yVW9+xgG/1D1OpaoffWoujw1wtMnl58trdzZrVnZdO7c3opi1jV13GkwFlINq3Aw/w3dk1If+p02kY6PHiLzGH1vmVEhisJzho1QnkqOwvDzIwMqDG5t3KoiKjIwhAEnfvTVCduyP53fFdZSTML5INFAu0ELwkzDepsiJmietZs20d0BnJ8dRhx7vB3VM+xw83cPnVR8dwofsX48e/Y3+5Pdmwopg1QTxtFxk9uTdDNSo18+Ln3nqIHhMKhCbX2V1sGsB4rjxwZON3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cY+B4Nsuo7WtmAU1ohBNCsMm+kGOeHPENTxEA13abtY=;
 b=n94LeZEx3VgRKTEN4IrQMEGBy8i+ljlJeXnNqrO9rIa3XKgZ1NPCIhoOX+edEI6pC7kfBNYAANze3jnhK+lJ7R2ajYt6cKdAukuJ/fKI7x0U2UWSv9LPW+1OD3it+A1lW+jT5IcSPXg0wOgJXVYV5JZ9eUjSReK7NN5yZNnAP/Ydm/mWE5rETXVV+7WnBtjTApzh+FAXCxoEbNEFjgGc4nwYJ+VzZQtt7Ty70hXQaX2lVLupv2kOphqxqjTj7UEtw0mwc8ZuBeOnzXmOgEBlc6UsH7gnWaeWxVjyjnuGYBJA2aNaWWWPleJSYVlfux8X6zP+Ci+J/wBK2o/ehQHtvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cY+B4Nsuo7WtmAU1ohBNCsMm+kGOeHPENTxEA13abtY=;
 b=ols2QTFV3VuU9fFaIQEDIv18B29WSprXNekth1pr1JkOc64lifa81GrCg9f2/c2JqfH0lNcDQEgXxHqxqSbKirTo2i0N10RW6kv0OviUZpzkXF37CeVxgcgCku2RpKazJajlhD3o19k+xFJR6LjeWfPTW5/qpzZvNXi5ZqnqlcdoxHsGRFaf5+jTNd38R3XJjTbbNghC5Q3Tg77NF519AzjilBt1YRQEpdmYGhHSjqUJkoilODIRrTZBwjjAgqBUzNg9lvtrLgRNa0s8g7z9BfkA9iqsdSmAaM9Y5MeFBoDqb7j62M5Lm2EAsf5qUHP6joIPNrVd/7Z4OVun5tVg/w==
Received: from BYAPR07CA0062.namprd07.prod.outlook.com (2603:10b6:a03:60::39)
 by CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Wed, 21 Aug
 2024 05:10:37 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::f1) by BYAPR07CA0062.outlook.office365.com
 (2603:10b6:a03:60::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 05:10:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 05:10:37 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 Aug
 2024 22:10:26 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 Aug
 2024 22:10:26 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 20 Aug
 2024 22:10:24 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>
Subject: [PATCH rdma-next 1/7] RDMA/mlx5: Check RoCE LAG status before getting netdev
Date: Wed, 21 Aug 2024 08:10:11 +0300
Message-ID: <20240821051017.7730-2-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240821051017.7730-1-michaelgur@nvidia.com>
References: <20240821051017.7730-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|CH2PR12MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff5cd66-6823-4826-6386-08dcc19f97e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YMl7Bk3/0T8i/bjHfxe2iHLl6kVu+P2JzYz7nQswvP+hG6Hn6VHzPcok0xnU?=
 =?us-ascii?Q?DhkP8Zk7kqzrPSSR3SGauJFDh7HoKkyonuiyFgavtcbX/5zZTGnu5igw4Xu7?=
 =?us-ascii?Q?2MVYWKdBd9s7Upv7qy/gn8QQRrS+Vs+AgCnIeqbQjor7xB5UnnZw/eOUSM9G?=
 =?us-ascii?Q?uOM3XSUpIyB0ikPQKzD/3NVz0wC0Sf6y0xv0DsK5hBwJrNe6tdmcCkMqrlJB?=
 =?us-ascii?Q?ANNpTFU+I+lCwhgH8Muz7IHFUIETathTz7vYf6P0wFl268PkI33QJMluajeE?=
 =?us-ascii?Q?+wVKeI/5dLzBwPDqsA60GatBwo99VqNjP4SzJMTr7QSpuYIwY2S2JhoWNOOt?=
 =?us-ascii?Q?0Y3xbvODN0NPsA03Q0F6o6zj8zyGREmxbIo3CoEu+0w9d7uoQUjjkpP6oC5I?=
 =?us-ascii?Q?ZrNh63dkKNNdjcsx+Tb+aGFZ9F0BZ6SEHsPdzmqc7f7+do+eaCTRpEIrCif4?=
 =?us-ascii?Q?UZWepmzuunGJ7i2I+UE3qrmu881C5AowJD9TB0Be4eHkUU/AOeXRDk1ywcF2?=
 =?us-ascii?Q?DFmouUyviR4qNoGnSvw+mNYNxn/xJo8qu12bZv1EEiprV/cmnQEwUGc5FvZx?=
 =?us-ascii?Q?xVhZJjs0U+zUepSo9DljInxA8VSNxXHdKvJE++Gf+bC20TrpL1AfUXveZp5k?=
 =?us-ascii?Q?/M1IV/VxkD9+a76WZjVg/Id9N0C+N2IwPjm1QP3hTvh9wQZxrtRblyqeHrHn?=
 =?us-ascii?Q?bIrqIA+yj4WwccE0QJcZtsc5idkO2Lg2CDfLzi2RvglCPojKFegtCFZnHtr1?=
 =?us-ascii?Q?06SBM2IREtGwT9MBUccXe5pyNz3HVs9SE/NNCiS+/L82YePQpsmpTQBukfV/?=
 =?us-ascii?Q?DoCogK3lCDSKUCvGjSVpv/Dd6wTDTWZ+lKVk0R1Pbpz41MnqJQaKVe4InGHb?=
 =?us-ascii?Q?LML0UBCUqHQTMeH36EDLMfcW9wcfA9hrqVKeAhb2ox/AuGRe90Z+yRCS8tHl?=
 =?us-ascii?Q?olh1uNffgmQ3W5lEuVnBc9rlAaHPdy6syKqCBCFXc1jPVvA7RNbl9JRe/WgS?=
 =?us-ascii?Q?u4E7FLYJVyy/RyXycMiVh07XP6XxZAR3Zu9lnHfGntXPU+t/ZioL4GKLUPnO?=
 =?us-ascii?Q?mFmah/CpEf0ly3O3+PCosor0BsCCjEwTQGih1cQtZ3wEDg/ILFFDZVy0GlLv?=
 =?us-ascii?Q?9k7I5TsWEMA7/Q/ElcP8aM3ThWP6VL0kkgmEIodxlDj0Er20dcPkiyI/hKON?=
 =?us-ascii?Q?QgcogL1lWuT6Yy3gv887obKFzMI+KBXABWgS5eXqkuR/Difg+TZqnJAFPLoI?=
 =?us-ascii?Q?OueOhdbMwUHT//ouA2qg4vowIX9XPTeAiitGFwQ1n+PK2/DjBUyUHeVCBdfy?=
 =?us-ascii?Q?PsyfpoL62A4BadsCg9x9wft4wXUcwxv6JpMLkOBMEUBIavivXbFt18/Gcq5E?=
 =?us-ascii?Q?mdIFMAAL2yVf1rESUv8KFioqfHahQyTNsFWyIEG5UZMzDRMgpMz0LZxykN1r?=
 =?us-ascii?Q?GdeKMKcnLg1AbRr9IuMotEED10KE7JBL?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 05:10:37.1703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff5cd66-6823-4826-6386-08dcc19f97e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295

From: Mark Bloch <mbloch@nvidia.com>

Check if RoCE LAG is active before calling the LAG layer for netdev.
This clarifies if LAG is active. No behavior changes with this patch.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index b85ad3c0bfa1..cdf1ce0f6b34 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -198,12 +198,18 @@ static int mlx5_netdev_event(struct notifier_block *this,
 	case NETDEV_CHANGE:
 	case NETDEV_UP:
 	case NETDEV_DOWN: {
-		struct net_device *lag_ndev = mlx5_lag_get_roce_netdev(mdev);
 		struct net_device *upper = NULL;
 
-		if (lag_ndev) {
-			upper = netdev_master_upper_dev_get(lag_ndev);
-			dev_put(lag_ndev);
+		if (mlx5_lag_is_roce(mdev)) {
+			struct net_device *lag_ndev;
+
+			lag_ndev = mlx5_lag_get_roce_netdev(mdev);
+			if (lag_ndev) {
+				upper = netdev_master_upper_dev_get(lag_ndev);
+				dev_put(lag_ndev);
+			} else {
+				goto done;
+			}
 		}
 
 		if (ibdev->is_rep)
@@ -257,9 +263,10 @@ static struct net_device *mlx5_ib_get_netdev(struct ib_device *device,
 	if (!mdev)
 		return NULL;
 
-	ndev = mlx5_lag_get_roce_netdev(mdev);
-	if (ndev)
+	if (mlx5_lag_is_roce(mdev)) {
+		ndev = mlx5_lag_get_roce_netdev(mdev);
 		goto out;
+	}
 
 	/* Ensure ndev does not disappear before we invoke dev_hold()
 	 */
-- 
2.17.2


