Return-Path: <linux-rdma+bounces-4660-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5D69658A1
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 09:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D3328713C
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 07:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138E016A382;
	Fri, 30 Aug 2024 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KcyUprGu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509C116B38E
	for <linux-rdma@vger.kernel.org>; Fri, 30 Aug 2024 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003116; cv=fail; b=D7gk7Hm/DQ0pVgpcm/Fu5z3t4X8O+hMi89uhZh3AA8Q+/zH/QJQON/0zbmc6696H8pt++XzKOvDuwuM/ZKQNJbNQIjXzOkLluT3YO5q96mUyE/31jWYa6/9dRAr6eEx9ikJPQr5aIOF/IeErW45iwx4ODaU0NMwnweTQNDeQ9Xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003116; c=relaxed/simple;
	bh=lLEMnxsxyqW9JKAvem3D0RAljr/RlvLLG90QJIOYFXs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g63N3d2QBzaN5GEN4bJVq8wNtibGWkugBGPcNm5Q97Vro5Pn844ZmGF+Ha1TNhwv/1BU52Mt4UnkPDzu5dPejBNib8uWVft3ygJmGpQ4dCavdlAmAQbx/FMCRsYLmWcPsJmiCemOrCN/y1sN9wRjfUXexSBcd52LwFxTu99XsSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KcyUprGu; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGPHjXdKCXo5rMI5EZmAYBZK6SBM5X/hM6qvMNRSughH0wzqIctTZoIPcQx7TOQEsJYDUAKMv/5YDpBpjX8Sk3dEpJeEBbj4wtWcgzxAgi3omQ77T7SQ6AC1EmIiM0NvoP1E+7XfJtb6nue4I/uaW7/h1zWIx6wQ5xAJT1dYNBSIDI1ZNe+fKCMBk5bzlkW4Fy75ohiTa55IYLqoGErxbTatjQZ5XhCgCOEcamvs8wxNrqR2HagvxMerq5PKt0ALlk2u8Ccc1oVcLdA3BgXZqFJEtaU1O8yfHmr/d6NIzRqL3ZtYDHxZ4erOulmD37KbHNCHHYQaxiThv2eafkMY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2OqhVHk8El4CAjcA45dc2j34faTtRc0H2tjll4NbU0=;
 b=p27kUGByLy9E19MpbyGgqnklDr3+QKy2bID7V+tzkpFgFzqyuKJx5lP3jwv79SECARUidggDS6y1ld6IUAycASFeRCgcJy5RIVxTyden+/4zX94/Nz6eW8ultPMlA6nWiTm6vHNirNo/B/INE6CqYWfcok3eIY/fLeSPbsp5CTs7X+pzHbOJtvHGHDH+szgqwcYNQnpWqZtqqqdHV6mBE8+Q2+71bw5erd2WwA3ojnUDaoq39K2Yc2XbWVNNWcmzJvQPpKyF5ZxGfPAiuun9T6sjN/B7w3dIzANbSbc5k/klGScomdGSnAy+cSJw9FUBHszH8a1E86yAh4l1GfF0JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2OqhVHk8El4CAjcA45dc2j34faTtRc0H2tjll4NbU0=;
 b=KcyUprGul2+xfcUB8dEdJx67LtpcDkckaig0T0WYnPH+rekgJvAcZ9nYENfp8c+uIm7UuMaAuEtlaC1oYl39dqYF8NTOJpJi11SuH4kGppqktQgr8Ya0FIv15CztOqPpvdrn60ynS49ha1CEBYXIZc3g3hALyZVLZ5dVuCkRMhFSQDf0uKkP++3nGM+n+CRwIKTvAqQ2JDzk1tsC9X0BUmj8MEYxT7kBafz2lvjG9tzr/NaHoMOOWThSfyLJPbZ1ieaR9axd+ZMXWFcpMjXzxOfEGGNlrT98qpb3y7eAr/QrGfxK0UpQW5TQWLHEJmbrJJqCjJkzbspaEHawDtOW3g==
Received: from BYAPR03CA0002.namprd03.prod.outlook.com (2603:10b6:a02:a8::15)
 by MW4PR12MB5603.namprd12.prod.outlook.com (2603:10b6:303:16a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Fri, 30 Aug
 2024 07:31:52 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::7f) by BYAPR03CA0002.outlook.office365.com
 (2603:10b6:a02:a8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20 via Frontend
 Transport; Fri, 30 Aug 2024 07:31:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 30 Aug 2024 07:31:52 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 00:31:40 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 00:31:39 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 30 Aug
 2024 00:31:37 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>
Subject: [PATCH rdma-next v2 2/7] RDMA/mlx5: Obtain upper net device only when needed
Date: Fri, 30 Aug 2024 10:31:25 +0300
Message-ID: <20240830073130.29982-3-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240830073130.29982-1-michaelgur@nvidia.com>
References: <20240830073130.29982-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|MW4PR12MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: 563eeb72-27dc-416c-931b-08dcc8c5d112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r9LWwGS/EbL+fN99Uum/fwpIIWMYg7ZM0AsyrPzS/f32Ym07tSUYL68YeOgh?=
 =?us-ascii?Q?4D+Ix9SkPpLWtEaL7Bkp8Uwu1jTMCJG8Z2uijn+GzVFhJhWfoH3r3goj3Mi7?=
 =?us-ascii?Q?mqHc4c7T4shHN2RZ8YI5Cmgf5CBarclcN7VwzB2Atfa8iiELkBvC0cjoqhxu?=
 =?us-ascii?Q?2w8l6iZxE8CTFoId2CH47fv7lFFb9xsM8e+JSgTQU+bBNNYNmo0swRxbNTYP?=
 =?us-ascii?Q?TLd6XJFwf/afCDf3J2GT3HyX+zCjDuLG10CJHqiB30bXIVGMaSz0ka7HPzLW?=
 =?us-ascii?Q?jd/QzbRdzAx6XgAEhgHlQz5jx3tnLI1iobQkb0yLF1HLojlL1GPr9H3fD/zJ?=
 =?us-ascii?Q?IO6ED1GAA0JQzM7gc57b9vS2WNgabPaH9st8mCA7znmxXFsewIY17kzuM26w?=
 =?us-ascii?Q?ZBWEZwH/KYe51d9ev5+rRJF/+iRrziSctNu3MzPQ7ObwRkC6d38/mEDqRJDH?=
 =?us-ascii?Q?tOJdrFzR01V/hrkq6BiVsSWfjVh/K06Sn3B/S/Sg7l+/eCzDxtCvMK7sMbpQ?=
 =?us-ascii?Q?+IHJwA4sw10wfVNNEFzXPLGdP+ARo3CMcnIJY/dJ+mV3Cp9Ce2wOGNqb8Lb7?=
 =?us-ascii?Q?mVw0ijqzDqblRXxdYMkk+R/OuniRbR27GS4GXWaO8BM711hi7WZISTxK2MqU?=
 =?us-ascii?Q?LZ05Mq4UKA0oO/OzImX9PkJVMz8LJ66ZUv0lqCwDutmEnNUt1+LxSRstM43/?=
 =?us-ascii?Q?X1oYcoccpkA9KnNIBEcdoxM/itkTqoR7bkP8V+cKJ1ewAPSXQXguLrbj+KXB?=
 =?us-ascii?Q?Ja9iFF4nxvGjsPdRbgyYTbQ6uQjA95k/DRpmLdhuq3WsDyPW84Cv+5Pk0yXH?=
 =?us-ascii?Q?/DIL+qzsI3b8mRMB1Y2KvNs5XRauMLc2J/kYaADjQmEs5qbEWN3P2gDMhmnC?=
 =?us-ascii?Q?QQ1cn6mVQC10gCvgxRQDTdNq5G9zOx3+fEszQ5auRxqjLBA+ZWHy7XurFX6K?=
 =?us-ascii?Q?Gzo8f8QKsQZbBcnaAvvz0HfNokmNJVWTtD7dMw94chCnT5soKxDIzoLJWI4H?=
 =?us-ascii?Q?+pYw+72tHAt+iPlGv1rdWOZPyxs9wVyP1HQdg2OZ4ss1Acb1WOlw924wppT0?=
 =?us-ascii?Q?HVo5Jp6u+3EXhmDprb001biuEa/kmYkVKumjRdHf58Uh+uLBWv/7Dx+Sl3IM?=
 =?us-ascii?Q?y6BwX95bjnlowqhH0Q6w2nV3LPemSfsXY+RgTXOD33xRBB2Lr3uADQYDpqdW?=
 =?us-ascii?Q?GZ+PldVcorvFx6dt3XP6TJ82OKBHuQDfm2b6OyFTBoozDTNE303wzv4/ELMd?=
 =?us-ascii?Q?Mh7R2u4W2pzkie+GabIN+p8l5g0BESfAJKrATCvTNtwRdcQYPeos93Cx0YXy?=
 =?us-ascii?Q?bVwwopWbYLDQNF7sUKZZo8q4SJgHLxeWq/rbAJBB3CSJPbjZCJ8oZG3A097L?=
 =?us-ascii?Q?z2YhlP3FRylPylmpnqp0HnUHe92HcjCCE2sTNQlzVTNnfuDFoNoHlHkZoKXJ?=
 =?us-ascii?Q?+VAFh0OE3RKemw+MIV0Il63k8ICihxRH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 07:31:52.1067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 563eeb72-27dc-416c-931b-08dcc8c5d112
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5603

From: Mark Bloch <mbloch@nvidia.com>

Report the upper device's state as the RDMA port state only in RoCE LAG or
switchdev LAG.

Fixes: 27f9e0ccb6da ("net/mlx5: Lag, Add single RDMA device in multiport mode")
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index cdf1ce0f6b34..c75cc3d14e74 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -558,7 +558,7 @@ static int mlx5_query_port_roce(struct ib_device *device, u32 port_num,
 	if (!ndev)
 		goto out;
 
-	if (dev->lag_active) {
+	if (mlx5_lag_is_roce(mdev) || mlx5_lag_is_sriov(mdev)) {
 		rcu_read_lock();
 		upper = netdev_master_upper_dev_get_rcu(ndev);
 		if (upper) {
-- 
2.17.2


