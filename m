Return-Path: <linux-rdma+bounces-12801-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EABB29504
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Aug 2025 22:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2F23BCA5B
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Aug 2025 20:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EBE244186;
	Sun, 17 Aug 2025 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ltBUyRXO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1500221CC79;
	Sun, 17 Aug 2025 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755462237; cv=fail; b=nFlvoVLj2juUGnaCGTgijW/v52MdmanHAF+xAMjlAa/LrHjOyP+Pti4ofjZcrGzn94Sh6B+Zg66Du863s3nJAJnZDUoPnq6e/2j7jHKyfe2+Hv4b6RAhJd6uK5pG3gmnlaFX5d+8X4764vXcISCyO+GmQxVNfuSjorUKsI98d4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755462237; c=relaxed/simple;
	bh=LWsGyPmKtON/nEjUt5u/Fut8nBcv8GO4eYLN3y503TI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VpZyDJ1Jdb5vDiEYkPle7veJJ8Kar2faC2HfSIMrJKXwT9vVKZjNoke5opI/Ysyfn+gJlS8BEqRGyPlOnj7J+0G5wqq8MVE4Q+SlcCVllPRyQe7M67JFIgqBX0PHmKUGgKnwslHUkIN2qc+TPnPGmmG3zUseASqQ5NS6WITS+1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ltBUyRXO; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbpyHj6J5POuN8m95d60xxJNTRxZAXDnoLvnHNHezGpQTIBk0IrcJluGyU+d6VjWmUCknm6CKMPe3VInG9+zzZtBnPj9Nz82hK8tdwIvBPRrlSxvd2/zduY37H6O3zQ+jQCQyknPS0+Df55u9qW0/DerM43zI1+9aXsK0cLOpM3QFOKoAnMzrIZQToUIRH3lJdku7ZmRx0vbxzeiJDvOi+ZV5oN9qjWK9Uy00FJVqgbxwaBABvKxz6DtXw78bkq9IVEW9d4evqSKmuylZhPbOh0utOApLI6/xbJmLhgMvgWfgqcFtQFkA8DZI7Az88/uIfQX6gYNPwvEsdoI8NnbNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ltfn3BWqfFviv99KTCYbzrGLPGImrx59VT6j8XSaxno=;
 b=rtcBn0sTW6q/dkE+ReBUuI0dJ79rTAV8TOys/rBZv9XGAu7rsg59Xljh7eGD3MVZEE/7nIdhQ0YXVtjgprpwftLKlAVsfawH62JRvIZ7v8s8DC/cfRkWWs8V9VriuDuias3WRiz5dwmi7sXIhlpzXNY1FVq1BoxeNv2lI0zJtWluA1d7cnSR+n79RXGuq55T1u6sfAPlkLnJNNWXB9sEzqZNr0KAC0cwpooEDqzW5v10EfJlwjfwvZBx/9QahEp+gLCa33ajFzsVNOZefYQm8eickKFo7fw4EtMPQHbAopDoYx5yf1WAFqudLVLB0nJss/Su7gOLUutyZI6SCYZ/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ltfn3BWqfFviv99KTCYbzrGLPGImrx59VT6j8XSaxno=;
 b=ltBUyRXOQEWApastQTL7TEX9HN3AToQlhFOj3YNcST2Y3iVpG/jwVvc/izoknQ+jSGUtt1sKMOUtXjRKt3vyOdnFvAWqHk+CWT6y3bBWRWJN4iGrv1yxk2sibFFSn7BkBpLEFNaBZOjoFivN8lR/fU2oxqQzU2SMk8t2rPFBuR/8PI+kr8Sx3twc2yZpLrpl/0MynyRSIsF0f/5Ekt8/emQsHX0kk4Do7bhCn0nEHsZyYTV8wxkZ2QEpOQZc8hbY1bIDsx1kOYEuev2BBppYOelHdEQBNdGYDPfitzO8UKwTVPPrPYgPtfHKHjn8OyqVFF7DSHQzFu/t0bvEbdjfbA==
Received: from MN2PR19CA0053.namprd19.prod.outlook.com (2603:10b6:208:19b::30)
 by SA3PR12MB9107.namprd12.prod.outlook.com (2603:10b6:806:381::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Sun, 17 Aug
 2025 20:23:51 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::98) by MN2PR19CA0053.outlook.office365.com
 (2603:10b6:208:19b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.30 via Frontend Transport; Sun,
 17 Aug 2025 20:23:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Sun, 17 Aug 2025 20:23:50 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 17 Aug
 2025 13:23:49 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 17 Aug 2025 13:23:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 17 Aug 2025 13:23:45 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net 4/7] net/mlx5: HWS, prevent rehash from filling up the queues
Date: Sun, 17 Aug 2025 23:23:20 +0300
Message-ID: <20250817202323.308604-5-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250817202323.308604-1-mbloch@nvidia.com>
References: <20250817202323.308604-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|SA3PR12MB9107:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b52b03-f379-4cf2-d57f-08ddddcbfa8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8iT+qY7znXiwR2Sg0uNViRqXEq8OBO7p7r39Kq/V3AJuwjQhFCUKvfQwc7u2?=
 =?us-ascii?Q?NxSa4KX8HhOqnz+9gych9y9fAs97bNWuLbM6osXy3rQVLNJVPlz4xERmiu4m?=
 =?us-ascii?Q?HQNpkQkdzr3qkRLUJ+jnp4LqMhgyadaBVI8T8YpKfj+azaZkiWQEQ3SNo8Yr?=
 =?us-ascii?Q?Ik44pxpcU/2voRCIhcQZfUNzvEuQTDaTi+121YYHOBeC0EpafQG2mTLhSRcS?=
 =?us-ascii?Q?O9zFmf1mKVcgCyXban2yObNphGyJik2Dm6uizx3mLrUrGq8A4TTJnz8ISNej?=
 =?us-ascii?Q?bNWdgfiFUa85zNdXNw9MUgCicV3TuKYfTGFo0vlPsLZJSmBXr6tFPG/W7owO?=
 =?us-ascii?Q?YJtG/D1smZsgtvMe9xel5aIo+jaaSt7oz7Qpt1HGaRWbfL303lDWRJo3id56?=
 =?us-ascii?Q?ptwTTAtBAXLvPbs0aktfqR6XKc/Sw8AalwNp/GZ0eqw8zSETEaQKt3laxVnN?=
 =?us-ascii?Q?qgG64UAAGoudZ8EnGeH3PnsCZO5YPw6wPBNHxbdDoi+G4jeQvx51/qGzjIYr?=
 =?us-ascii?Q?WJazbZ6NrTQfEqk+4XzPwFNCIiemT/HBXLON7OIaN8SBjgXejK5xF5kS0uXz?=
 =?us-ascii?Q?4dr6rVy7w+2oVBtAE8ldH/zjto5sxnkcXlSORfYiQX4NuJW1kyeiokLbMHgf?=
 =?us-ascii?Q?mfB/d7tk4X+FJtviSCmq3NSP79D6oQoqMqklvMFi5v86PlOZZALGbEZdQl9b?=
 =?us-ascii?Q?DaE2DfCtOFESYfmQIZTHeKkzjOjQJCLVnrsVhHfffEIQqGVAzoJoFnqLh8zt?=
 =?us-ascii?Q?+D5Fjkhy0XLpThQIbf9JeBI1X0nNlPGaoUx1bYLaKXRIpQsflOEV5TC3OIUa?=
 =?us-ascii?Q?i00xz/CG2+52nH8E7gPCBgvXBIT0KMsRvFOzFdWP4hr3j+UfDm1QjNcYhGtz?=
 =?us-ascii?Q?xSBVRZiYsKdGLyzXMedlBHCamgQzeDJuIA29OsrMg1AB2ENJda/MrnLqyyRN?=
 =?us-ascii?Q?wHFDpmOeFWERPeuPlB50Qvvf6Wlz3jnbVB599JhvHxckbr6d0pro+i8r+bq7?=
 =?us-ascii?Q?Mv4KQNQnDzdvwphJUdawCYwYAhqM/QeEUtj+OrjIzko2A4ecbAh7TG2UN6qV?=
 =?us-ascii?Q?sKQMLeCZWSxWc5+TTMtV55WXKeiApt252xPBk22DssZhCV397X/QRW8qZPll?=
 =?us-ascii?Q?eg09RpTmZ5keGT7mJDt8gjLLPEZ7KiIF7Z190+UAn8kQ3cD9m0RkRKSpvCa9?=
 =?us-ascii?Q?hRv4/bIf4GpIjHYrbw39HeF2BtIAMeNzNXZYYiO9uyYa2XB7oINkKHoO1DZT?=
 =?us-ascii?Q?OMxIYmb3J1hVWfnBzzZZboWe5d/ErLqmCDvOF0bsUR679z+fNg0LTH1VGMt2?=
 =?us-ascii?Q?7jKaRUDMg1QkLTljYKpllKZbIbsvn02kXRrKH3RH6cQCCY0+Z+88kdBluyyQ?=
 =?us-ascii?Q?6q7pX6g2ICi19nZZSzy2DEBxZzYE2fg/mV1VJJv+qQwrJIQ4u+QD1eGh6u4Z?=
 =?us-ascii?Q?+FSBZiqRtysEPF6ykOGzlksfx32lSkMnaJ5ftto3h/Xl3OcezKMOYztMupX0?=
 =?us-ascii?Q?Zy3Nah2QTQTFZ6bmF0wad3e2aHVI9pTTYuJY?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2025 20:23:50.6269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b52b03-f379-4cf2-d57f-08ddddcbfa8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9107

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

While moving the rules during rehash, CQ is not drained. The flush
and drain happens only when all the rules of a certain queue have been
moved. This behaviour can lead to accumulating large quantity of rules
that haven't got their completion yet, and eventually will fill up
the queue and will cause the rehash to fail.

Fix this problem by requiring drain once the number of outstanding
completions reaches a certain threshold.

Fixes: ef94799a8741 ("net/mlx5: HWS, rework rehash loop")
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 0219a49b2326..2a59be11fe55 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -84,6 +84,7 @@ hws_bwc_matcher_move_all_simple(struct mlx5hws_bwc_matcher *bwc_matcher)
 	struct list_head *rules_list;
 	u32 pending_rules;
 	int i, ret = 0;
+	bool drain;
 
 	mlx5hws_bwc_rule_fill_attr(bwc_matcher, 0, 0, &rule_attr);
 
@@ -111,10 +112,12 @@ hws_bwc_matcher_move_all_simple(struct mlx5hws_bwc_matcher *bwc_matcher)
 			}
 
 			pending_rules++;
+			drain = pending_rules >=
+				hws_bwc_get_burst_th(ctx, rule_attr.queue_id);
 			ret = mlx5hws_bwc_queue_poll(ctx,
 						     rule_attr.queue_id,
 						     &pending_rules,
-						     false);
+						     drain);
 			if (unlikely(ret)) {
 				if (ret == -ETIMEDOUT) {
 					mlx5hws_err(ctx,
-- 
2.34.1


