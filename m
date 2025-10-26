Return-Path: <linux-rdma+bounces-14055-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0E5C0B1A3
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Oct 2025 21:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A273B2DAA
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Oct 2025 20:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750EB2FF163;
	Sun, 26 Oct 2025 20:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ViIKQeFz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2A72FF140;
	Sun, 26 Oct 2025 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761509043; cv=fail; b=Wt0XRYHy47q/KoM9OAyXuvxVjAcic3KFrPUBKDzM848onRdGxY1GXnIgurZ+qiggo8SmFXAvHGe37aIzzAdMyEFI+0tSGUnfzDVZfmuI+cAi5pknud5HEjLK/0AJFDo7bC16XZig1BPSiO6JSecjc4+T9z2PaF4vrEAiw8368xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761509043; c=relaxed/simple;
	bh=0XQmqLSnZtondQBKr6dIoOmJfq/h93B8mGI4T/LdpLI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIELbs0pStgtTp5GBSftPwgUfASuxzztFCv689emQmqzhqtRNrcJgwEjIqBKLbzs/c/fYxZaF+SVq8mEBje8lKOotuQfKB3RERhbFpzYef4t6jdqf6WLt7eakikDWYz6p8sicGjJ+deZJNVDvb/zcgGnm6Juwc0c5GHNSu6om/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ViIKQeFz; arc=fail smtp.client-ip=40.107.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1fPlZvTtZDafiai4rPGQFtuJfH8SWqteoZ3bl7m5dUeeazNFI54EiKKIT8H7nS1DTws4gCgbB/7ATlBOg3emFcCOl/kcFyTppgxjDxEb2u9dq6e8FAlaCQjIlzxP4/ypCNGHgvhUOfiAion1EfFi6+6gCxd0oIzxzKT/MavgIH2VoVp2a2DDyhcUU63UbMKx2IZqim8knBamk7Qben1Bs2cgwG7XdepChOMp+lrYhDGz1ZRgNNHO6btbnEIvqwbOLKto9HqZdwuT3aya87pOxtGmVa4qAiRSsGWfQ9VDtcDVLByCqH70YdTrHLEow2UgTQ/nanoEYhDmAwjcEPtVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfNDU2CHKIYQYdrRasmn8MGl4GS6/vQdi0twJYXCm+Y=;
 b=usRA4i/kvSll9OzRdkF+BPPfR8fiarfuz9pfx7RwtVHUAaN0rD0zl1wK3cA8Bz7h/5UjMwnZftV9pacxqOurbFtWbi0QBG+u93peUREfL5gFpbmwhikEJtA+IXXCGqaNLSNuouS5kRi7c6ZOvorMX6uVUl1zRYMIUO6xeiJJgrb6kx03LZh2Thkr/dxbglPw+tYoWN2dvF0oWdmJ9oA6NtlSNTmCp5RN/QFCoSOcTxo3udo4loCNkoDrDNhrQgilmEuJkHRvFnHhRWH+VPQvq9FJ3ArV7EC52KyVW2LBvx83zU3HCwirgvPj0ZjpINU+fBaj75Se5yDvGoUlFNNtLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=queasysnail.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfNDU2CHKIYQYdrRasmn8MGl4GS6/vQdi0twJYXCm+Y=;
 b=ViIKQeFzP+aSjzOVr/NeJyTi0ZUgtP9YBG9f8+cVF5WAMp9b19gXyo4JtWMW05Uf+PCiwqaYqDOJVPOIyLbiye/amgTkTCLABs0WZ7hYR0LudGsHY3sfBKoUGdf+uZ8rJ8I8nHxrZCXI6SdZ9rZHHU1cdIiuvXuFj893S7vcrv39bFHoaOgYTcNw4vM8M6O9zTovQ2uBq+IWDriQQ3SVNUugEM63Y9Ppw+ksm7bS0uoY0uwUYwbPqERTM6YaYMuAHD0USYSEdcwFlQ3xiBXIhUg3NCBlzlX+hIlpriWT3reLZDXly3AbOH+CKVp4mSoec0c6gaU+quMDCSX+vh9dwA==
Received: from SA9P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::23)
 by DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Sun, 26 Oct
 2025 20:03:58 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:25:cafe::c4) by SA9P221CA0018.outlook.office365.com
 (2603:10b6:806:25::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Sun,
 26 Oct 2025 20:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Sun, 26 Oct 2025 20:03:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 26 Oct
 2025 13:03:47 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Oct
 2025 13:03:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 26
 Oct 2025 13:03:43 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Sabrina Dubroca <sd@queasysnail.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "John
 Fastabend" <john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>
Subject: [PATCH net V3 2/3] net: tls: Cancel RX async resync request on rcd_delta overflow
Date: Sun, 26 Oct 2025 22:03:02 +0200
Message-ID: <1761508983-937977-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761508983-937977-1-git-send-email-tariqt@nvidia.com>
References: <1761508983-937977-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|DM4PR12MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: 27646fd4-5566-4d64-f438-08de14caccd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MgbJS6+dT/tTR7CPCFhezRK73Fp+QCKcmaDC80KXfL2a8MXwx311FakeBg7V?=
 =?us-ascii?Q?P4Vjx8Z2anWt7UxDThLrZpgrjg5KpWQFmezlmF+XFhpbmfBDAasH/HQbd2Mp?=
 =?us-ascii?Q?vvM4X/DeLxUtzFjVL8l99UCu94F6rpwNwdDNOvZeyJI/lkz1KKmiT0LglDXl?=
 =?us-ascii?Q?tEsg0jvm5xO2Z6IrKVQH5hYDHloIR36iEF5WnSXXa91eca/pnGvazsvx1C+1?=
 =?us-ascii?Q?86kwJrsp7UP99MVi0vMTQqDU8DT9TVtCxxo14eGkf7V96o/nL1PMbNZKzgL4?=
 =?us-ascii?Q?GpTbEHgbkTvLQfELnoZ04wC+2X9erQCwmk5pBcovJ8hZdv3zsSjWcweoz38b?=
 =?us-ascii?Q?biG+6w/MkJYCohAGW1i5h5/xw8JtHP+dAo29ExPKQP46vsVqMUP2Ew6kXDNU?=
 =?us-ascii?Q?bSXAtn7KPgHiSdRRLLOZk8OS3nDahSv76YmqjpC3v6rp9GPfPphBYiaHaV0Q?=
 =?us-ascii?Q?qZcC5Wy473Ea3UkKST//YzkoTvwZCNNAzeYBIHm7Z6FVAZ37XO/feiJ/Ugfr?=
 =?us-ascii?Q?eeWBXvOSCby6scJ8jTR7ZSo01CGxISEBimZCZ7oKG1tUCyTI80RY5O9wmX9H?=
 =?us-ascii?Q?sUzPfK2Vwx2jgMIqE4XpkLHDQXAENJYlUwP9hFHMlCOLPBPuP9KSmLdGI6OO?=
 =?us-ascii?Q?QlrNJRdyw3TXNjkFTDsIjwyDBQHIsKlKMIHLURvwZDlISMCGsVtcvdGpqt9v?=
 =?us-ascii?Q?J7isPGesBKKolofdwpNGYFWIdTbhsPZ0PNW7dpCH2xA3Dm47b4n8P7iX4a5g?=
 =?us-ascii?Q?lB7Js9ICOiRXtfA42aGa2OdO+5lmHNUESbCyGEfZXjT8TAGou/7uCTp7N08f?=
 =?us-ascii?Q?Plj8x8tNShf/bxkOZswyKg0FYLRLvAkacy9zWs2GmEwwUJVsJKrUugY3V2PH?=
 =?us-ascii?Q?hpCQX3JgpWN0Wvs2BWnIuFRrVMK8Wacjs9lrPnpXGVbniXxxo0tU06rvly/P?=
 =?us-ascii?Q?np2JYNlXgIz6GisO0eEaGmkYlLWkleoc5vnCReg4D1PgmqdMzznB7xt1Y1DM?=
 =?us-ascii?Q?Lq8aVFtGt8c2b6SvqTiuDw+aGZQJzGBNIivI7zXYf2D0T7fMRi6y6FmKOk8y?=
 =?us-ascii?Q?ywdzfKZ1t+8XWKeIMNS9HFaaxvHxMkze43XnS/1doYCUrXW5t25IMmsyJHrl?=
 =?us-ascii?Q?9O6dWH7tKJo5Q0QwmRNhWNESeGCeZ1NvQ9j00wZyh9qQ0970OTRxmCDFykIg?=
 =?us-ascii?Q?AiNmxAoBq1ECsybIQpbe4QInZJdV+migpALP/dUlDpblx85zv+9R+lZIIls1?=
 =?us-ascii?Q?f/kyZ/O7yuHirenEKze9yijorxtwCvZrL144Qb+EgZq4ZaLrj0s16QHt7GXM?=
 =?us-ascii?Q?27kkVqXM06GvD8hmJvmTzdNKH+ixMW9Gltt0WjRw+Exfit+7MnljkhinY34R?=
 =?us-ascii?Q?eiQ+uMvigIzwgq3vkkAHnT8HizxQL4IeSfN84LOQKnQoVOE+VwpAp869JaIa?=
 =?us-ascii?Q?b6XphhVVyvGZjWqVO5oXUPaAuzc0g2a9zBY7M/Xmb+Mrqk3QXtMejPKRdV04?=
 =?us-ascii?Q?4EjGxiFJPiR2BYUCPo0cnQWGsl/sG4gSJOuKOsa6sJ+Yh7vWoBvxd8QBkV26?=
 =?us-ascii?Q?T+L7/hh8aXAlSTS/MUY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2025 20:03:58.4102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27646fd4-5566-4d64-f438-08de14caccd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560

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

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
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


