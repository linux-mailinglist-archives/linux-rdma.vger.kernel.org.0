Return-Path: <linux-rdma+bounces-13946-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 810B8BEF979
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Oct 2025 09:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6B054ECEB7
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Oct 2025 07:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319C62DECD3;
	Mon, 20 Oct 2025 07:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PtNRV6G0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012052.outbound.protection.outlook.com [40.107.200.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACC82DEA67;
	Mon, 20 Oct 2025 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944017; cv=fail; b=Sl8oWxvLsxIXNeClFxHhFipaq8Zb63QIlDkXWQNsZDZKM8773lt1tvbdp1slRu9eHbj3HYfNRqI6H2WTYJ3Tljq8cPgJJ3IKr9BUnlyef3gE3NtePcWCqqS9SU6zC97YGDMI7WAtoltcjMYT46QhyZLP61syjiJr2r6/gWIkCNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944017; c=relaxed/simple;
	bh=2/yp/BLG1fH1PvE/j9IQo24k2sazFl9D6tb9qV0phLY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzR/LNPrJeI18fS5p70e/Qf6mEL3vA+IN+PkkcXUEvW8tkaf8OfKNBaHs78StbJHVOMXLZndtDixq+nFfvex6j30kiKo0WJuDS/jLjCS+aOhXstOiFZKvzuuXNAvieqK4MUvL6CpmRjjZFmZYOWhg2b2M1GOPIr3YEOWrOxD564=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PtNRV6G0; arc=fail smtp.client-ip=40.107.200.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dckD2RzOg2x3A0fJxQR7hfOc05ZLCZu781gOkKdQKbmD6Fsx/nvENxNBVskeqsK6VJuU896YXRqz9e0X5T36hOnnyAJQfvmzlFiNn//Stkypc8fcuZTZyStv/j496jVRsXgpUnsUs1ZEdNylPVa5nT7BUi2rIX//mNXv+Kpj0/cYEcXXh8QcsJuDss+7gc0jyO6wthn8w4PkIhFUHrPiu+b5zcGFzPU+iC7805X7mYIg0j3pfyOSiYcPpfLFviLp/vyiuYGNNjxu+AbZGZriqDKhKEIac9ll9WA6DVYdoImKeVRD3GNWPcpEmAa3Lror3IHkFTuMgSWL+nIUdzgNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxVPYfMHR4g2ZA/9peTbc47Bjq8KlHigxBBwTkNliFs=;
 b=emafW9ildqxlptLqdbvCdE40GvDIp2oYNMNuBqTl9xt5xy+2Qc95D7/wpH4MBSks6mpP7Jv+Rw2PeX10xSrsPqen3RYwAVWdaKuvCWeemMP+cC92TtZUDdKpeegqhwMjxA5uPKolsciKA4nKD0sVOJxx8lztsCVgUuPdFcJp4MI1rpOv2P5jB0eGenY03goblq8drZNANGm2rwoNrh/Iqap9OvfD9y4PXSFkSvJuNCFIejwFDCXzcGSKIDtqPotbsBZnuJb4rCSxjnp2bZ8tnu8OUPRmlylQMdeZ3Ox/lSq0Fj0bWas5i+bNE6K9OMyavVD4WfG33zxY63jn1dcx9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxVPYfMHR4g2ZA/9peTbc47Bjq8KlHigxBBwTkNliFs=;
 b=PtNRV6G0z2l3SYPE4skcY7h6aAJJeERuprj/MLE/oufpQQ7fo/cYsCsya0p35UvwfwQNYKz0stWjrNBjvKhx5jYOeF6UGcz5jVNQ0zZOZP0nmYmFVWNj24q8qVTyRC4vmPsz+THzC+GH1eb1ey8dTkETOofMRww+fYSx02cPvSvQ81QH+PPjaxH3+jy+u15c2c8NsfsLkHX9GDlmgIscs+KZXffourWN2Z/b2COIygBNFTuX2vg4UhDRGonFfirPSpJkqc9A3XyWM6aO/ALPRXLretY9AKLC7noaPaQEnlZQcNS0Doy2kAfF++NAdAAkP/jyl/9b67+YwBKt1cswgQ==
Received: from BN0PR04CA0204.namprd04.prod.outlook.com (2603:10b6:408:e9::29)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Mon, 20 Oct 2025 07:06:52 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::e1) by BN0PR04CA0204.outlook.office365.com
 (2603:10b6:408:e9::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.15 via Frontend Transport; Mon,
 20 Oct 2025 07:06:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 07:06:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 20 Oct
 2025 00:06:41 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 20 Oct 2025 00:06:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Oct 2025 00:06:36 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "John
 Fastabend" <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>
Subject: [PATCH net V2 2/3] net: tls: Cancel RX async resync request on rdc_delta overflow
Date: Mon, 20 Oct 2025 10:05:53 +0300
Message-ID: <1760943954-909301-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1760943954-909301-1-git-send-email-tariqt@nvidia.com>
References: <1760943954-909301-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: ce3a7587-4bd2-4989-3d07-08de0fa73f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VCR+4nRzkQfJymLleMSldWlpFEk4F/YtBzNu/YW5lzpKs2QFCDaGyqt4BPMY?=
 =?us-ascii?Q?+0e9G7HzZDU0aXyYb/2TO8X+5Ftb8HNKO4k3MfmL4kTeo1V8rIKrvgzaZZnJ?=
 =?us-ascii?Q?6iS/uJNMV1KyPyBJYmA9T/Z04unuivRa1NuzKwvKHr4FpmrWgQZO9sBbmNZj?=
 =?us-ascii?Q?eP5ffAqSeMYexCdt89lRZ3yfhKyypE1XE+/AH14l8YPn7BBgDqXsI80F6pWE?=
 =?us-ascii?Q?X2pN98xl971qH5H00B2UWInWmM7TKGs+iQla1H/6K7WX3a09/C5w4hofwG1d?=
 =?us-ascii?Q?cWmeW/WXKXwDA0UJFKCPjLK5hVFjF1j7WWsiwFxukrcUF0nbCem+HU3I6VUv?=
 =?us-ascii?Q?LEKz5s0oUxwxbzcAPAZCLKxdbmJ8n0mS3SxINVAvKAMWkY8cLtZNknwk6deK?=
 =?us-ascii?Q?lTw/8F82z0FD3zC86amgUllvICJXdrz3uW0CuXsxtCg9CSQd3GmSwHM3nuOM?=
 =?us-ascii?Q?mYJeATfoyZ38PasN5+ZuECdTXJKaSyg3/LSbTK66aSj+o8R65fYiQMaBpy8Q?=
 =?us-ascii?Q?UDNR07NBEYaTCnQ/eGzfXaAzRwypcoOFCUgTqq1aw+91T4q0diopwQ8wZ2Wx?=
 =?us-ascii?Q?I3aj5ga/WB4Zbr2eTdKuSDGENSGvUavv1q5ab0PZMr2pcHfhRepjP2wN4YMn?=
 =?us-ascii?Q?tKtUoefr3iRhOxJ387GlK9dWqBNfuV7FZIMPeIa1kot4voRrKZzxg2YAK0TL?=
 =?us-ascii?Q?N9vQ82UWhzBZ0afLUl4YYVXd9x82Kq+5jsWRXNSxP/ATSw/cK9qV9I+eEdSL?=
 =?us-ascii?Q?DMzhVEsPZ05RjxxbIWvHEhdly+sIJ+zCflm6VsIQgD+MZ8PEDS5MTq5jx3G6?=
 =?us-ascii?Q?OxwStkkb7LQDEA2osrisYS59ehOvJCWZGS6zkEKAe5hQaE0nSmg3tqQHem5p?=
 =?us-ascii?Q?ju+StLep3M+5NseRBqMpw/PJiLQdywtnDpntihFjMH3zmoG1u8WugQLDBZ3v?=
 =?us-ascii?Q?0p3DV1xVs+c3zeiBSje9xFiJgQH2OmC9QCHs4tGjio6fWJoWrQdZhqCVGl/u?=
 =?us-ascii?Q?x4Wq5aC/usV8uwoB8qFYFxAQKLJn+6ZvSSCNH+omY9A4Klm5sSwIa3mURvnQ?=
 =?us-ascii?Q?nZBBvKbWO5dKwYtjYfcV7O/y2kqk/JqaUfWcCpo4ifNqSDiKU+a5IAnJFyo3?=
 =?us-ascii?Q?CeV7eXbipEQo6D+la1RWJOzIZl2c/VPbpR867rBMPWjU9FvxkQenh0mgsUWN?=
 =?us-ascii?Q?1MGP5X5kLVKVh8z3NvPHzzphtO12Dz3gzj1V5SNwG13bPTEvsdMGguJtLCAy?=
 =?us-ascii?Q?mSN2dPAV/rno03uflqa2LcYXqHnAT1id1gL+VRNaIcMVkoF8Ikb1d23pg9Ek?=
 =?us-ascii?Q?LMIKQatj4T0ULg0tTcHEOAi0NUqIW7viDLZzQytBluKdsJdAEpjPGKslBvCW?=
 =?us-ascii?Q?NCSvNpuDPyW/tVi3MvDQ2CAccE6w5NNn2ImrBm6Sc555ZXM9PrkV6OlTAjSh?=
 =?us-ascii?Q?wqz1ByACDS5yeKiMyIs9XFQyDtsrFV8vAQsVweoSTARzlqpxx1UiQD9w8sHc?=
 =?us-ascii?Q?wf1nWO/1ieuQwA4C0pjNFSB7Y2SAXPvKQB8AAc60VY4ZP02oyeMb3VMab/g8?=
 =?us-ascii?Q?S0iXMDcjaXaCbSOEGYE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 07:06:52.4621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3a7587-4bd2-4989-3d07-08de0fa73f23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416

From: Shahar Shitrit <shshitrit@nvidia.com>

When a netdev issues a RX async resync request for a TLS connection,
the TLS module handles it by logging record headers and attempting to
match them to the tcp_sn provided by the device. If a match is found,
the TLS module approves the tcp_sn for resynchronization.

While waiting for a device response, the TLS module also increments
rcd_delta each time a new TLS record is received, tracking the distance
from the original resync request.

However, if the device response is delayed or fails (e.g due to
unstable connection and device getting out of tracking, hardware
errors, resource exhaustion etc.), the TLS module keeps logging and
incrementing, which can lead to a WARN() when rcd_delta exceeds the
threshold.

To address this, introduce tls_offload_rx_resync_async_request_cancel()
to explicitly cancel resync requests when a device response failure is
detected. Call this helper also as a final safeguard when rcd_delta
crosses its threshold, as reaching this point implies that earlier
cancellation did not occur.

Fixes: 138559b9f99d ("net/tls: Fix wrong record sn in async mode of device resync")
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/net/tls.h    | 6 ++++++
 net/tls/tls_device.c | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index b90f3b675c3c..c7bcdb3afad7 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -467,6 +467,12 @@ tls_offload_rx_resync_async_request_end(struct tls_offload_resync_async *resync_
 	atomic64_set(&resync_async->req, ((u64)ntohl(seq) << 32) | RESYNC_REQ);
 }
 
+static inline void
+tls_offload_rx_resync_async_request_cancel(struct tls_offload_resync_async *resync_async)
+{
+	atomic64_set(&resync_async->req, 0);
+}
+
 static inline void
 tls_offload_rx_resync_set_type(struct sock *sk, enum tls_offload_sync_type type)
 {
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index a64ae15b1a60..71734411ff4c 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -723,8 +723,10 @@ tls_device_rx_resync_async(struct tls_offload_resync_async *resync_async,
 		/* shouldn't get to wraparound:
 		 * too long in async stage, something bad happened
 		 */
-		if (WARN_ON_ONCE(resync_async->rcd_delta == USHRT_MAX))
+		if (WARN_ON_ONCE(resync_async->rcd_delta == USHRT_MAX)) {
+			tls_offload_rx_resync_async_request_cancel(resync_async);
 			return false;
+		}
 
 		/* asynchronous stage: log all headers seq such that
 		 * req_seq <= seq <= end_seq, and wait for real resync request
-- 
2.31.1


