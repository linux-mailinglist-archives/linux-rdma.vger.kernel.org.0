Return-Path: <linux-rdma+bounces-14091-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DE8C1334E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 07:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FA51A27E7B
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 06:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07CD2D2390;
	Tue, 28 Oct 2025 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PWYv7aGn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011010.outbound.protection.outlook.com [40.93.194.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77BD2C3244;
	Tue, 28 Oct 2025 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761634087; cv=fail; b=nbMk1gw9qaS/MrnHF8MT8lGkGf9VC6+K6+T5WPALEuF6ZrwaK50MBaECs6UUrb9zYzOd/+jy/A+74gQOJl8OVPvl5xLe/1mfvspIh9iDmouJehoddzYrMPtcFvRRqr7aNZ/E1p/6v2HbwI7F0QprnPwi5MKkUyVAUeSnPZWBDNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761634087; c=relaxed/simple;
	bh=1kMNmrjvQ2Pvp+9Nz6HgoaZmU0/mGyFNciWJkDa4q5A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GpdLNWgqevYzrdZN9nFLMA1sJgTZux2yLRL/E7DI256JpKh8wxXIPvrzUEi4Nk/1ic4sikeMBFZ3erkkBhAZvMd5CFb6kZv9NeJUGAVpUe5hdSnBYXJ0+CPeGpq2BGl/K+djdqboxqjJyFhaIv3pszYYDxHAjTVRJ30ejFiuSrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PWYv7aGn; arc=fail smtp.client-ip=40.93.194.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1+KWzwi3vJ2rr7cgHnuTOrKpYofOC0PbeiQQgVE2vb7Jhgec55vzuK8Ur6xFQwOwardbRr3uXrQgyuukOmitdaVx8ZF0sWZ0/ND74hoAZk+pz0h/I4la7kbzXBWC6cYN15tdZ3jV5GWoQmgX3QOymkIgjXKq31huPwwcbvYKuCHkvHCRBazCCtL2zsFdGe5b9b2hrzogDc1vo8MOjFkvopWyFJFM1Glcv2t50swvy2xMq3BgyheNcGqRbt4zN/ErpSpIt2v5vRHosY+W924hUK3/4FoY8VkYFX+h5j5mbICEwJUuty9SEsfRUen1jFRJbrgV/A4OjyfNDB67J30lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSgLrGzmcQ62QybiAGbQCIzvNmVaaeLzO0hIZUrHekM=;
 b=I3p2uAjSl0FvyDgCQcVr9VzafprUMXzVLBrlq212yktVjxHlLYubiYnEGTha4oWqXFE7sRt1pLmqsN+3/O1Hpkx+nMHdIIDCseeNRlY4+NcFykQ9+GmIyxzGec7ojZB3hE8wFbLlA17U5KPk7TQC/iOn+/Uk7kbT8EL0sQEsT4d0NBxuUIhwmVdepOdvfu7KXuq1AvZM+sYqqvpLs58OXwlgQIKe3fg1DVUeJrD9qVUxTd+SOZ+R98wuwqZm8t4luqyCbGcKQVnbfbYAtuXOv6I9fIkyuCxrZg1W0+9cfMT6P4tjUc0O2CyzIzMZrN44S4QTUkJ/ODQIzqHy1PS7aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSgLrGzmcQ62QybiAGbQCIzvNmVaaeLzO0hIZUrHekM=;
 b=PWYv7aGnlRHmrnqvNvykRS65Fku/k7kgZO0Tiyagm8cm0zp/Z7m9j9ztxXUeRqOTHnlz3p4SgL1qcjGo/tJUyx84W+S33PJpmZZcgKESIIYToyeaI8gHIXllatczvHTog4epFmnSHZLcQ657jdbNFbShXr3CaiHzaIT4hbOeyNMhImv2TKZRh7M5/EnGd4UJn29h9LnAUlYLt+5u9C1vo/zMuiN2mFtrMDe04TTGHybc/oeTQ6VJnrMhD1Y0cFFT4ScVz3gaT+lArLyccwtSUtXBmkz4kH1dvtYbdfvLHNHaYjPUhVBfqoSWVPLz6M8Bz/uiyJIrtVzwy691+NhtWA==
Received: from MN2PR11CA0013.namprd11.prod.outlook.com (2603:10b6:208:23b::18)
 by LV8PR12MB9641.namprd12.prod.outlook.com (2603:10b6:408:295::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Tue, 28 Oct
 2025 06:48:01 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::ef) by MN2PR11CA0013.outlook.office365.com
 (2603:10b6:208:23b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Tue,
 28 Oct 2025 06:48:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 06:48:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 27 Oct
 2025 23:47:49 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Oct 2025 23:47:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 23:47:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net 2/3] net/mlx5e: SHAMPO, Fix skb size check for 64K pages
Date: Tue, 28 Oct 2025 08:47:18 +0200
Message-ID: <1761634039-999515-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761634039-999515-1-git-send-email-tariqt@nvidia.com>
References: <1761634039-999515-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|LV8PR12MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: c8763629-614b-430a-bf8b-08de15edf065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uM1JG6itYSsZvq8S/YbDCa8tz8acfvWKB2uxRugzBWODSqRhdP6vwzLOIs5i?=
 =?us-ascii?Q?gvPFlqAbNn8KVMOX+8w71fBddNLP9yeiJxz+aIxFmjfQ9pf369Ks0K4rYas5?=
 =?us-ascii?Q?l2YDO9+aejxarQEDRFv4XUviJhm1iPj/Wc97OblRgX4jtbizS2RgUJk1UwcG?=
 =?us-ascii?Q?XitI5hTIUpCl014I7WuZiC/oprfHF6dsEwb7Gr0jljPMoqWZqb6HUsZ1aTAd?=
 =?us-ascii?Q?GshIOaW9bo/Yllwt1Upd4j+zHGMonkHHV2zkKD9pXtm5LWtbJLeFELgO/zLS?=
 =?us-ascii?Q?WCFCpQDOMOFtd2tKyV0YpBBIHFNS+38pXh5JJOW/6pGqDJrpz/pbIP9ctJVW?=
 =?us-ascii?Q?uJ9j7TSuupiC4MYHMzSJq7/8g1hFeOKX4dZk8OMC1Bpykca/STxpDE96gu+n?=
 =?us-ascii?Q?kmu9zW2MfmNLZBC5sw2N6pc3z+OPsyITKsb6KgP/bjYBmTMVHhF4OQCznmbK?=
 =?us-ascii?Q?JB5AEam8t1kETLAF3m10ThIS1OOMxddajazpExh882T3ligZShKa3fTh7V5g?=
 =?us-ascii?Q?iscfTKvEHxE4QMU1e/cCLx1YmSW6ubjq7jgCS1whl68i38FiBTrm0JEEPF//?=
 =?us-ascii?Q?8WsCYzxWtNOjKyV2+jkQ43xlpp8frUcN7oR1K9e41sbf7h23i1D63JvSCcR3?=
 =?us-ascii?Q?lKgjp0gy89wJH/38mcl5dOyDiSaDM00YirYOhN7ILloHD59KiY6GhHIGWpcG?=
 =?us-ascii?Q?2vl2TVxJhkKkP0HYA0JbLFNL35C/nmHtdmkqLJcBA+kS6mn7SmrpMGnI+9Hb?=
 =?us-ascii?Q?M+DgGhYH60gyQKj+V/mPrQMCEe/3ZIvx+oxc8u9ItmOj1jkoo1nsh//teHDW?=
 =?us-ascii?Q?ZFDMxS1H1xcG3u8s0dAHR/lNgu9OhCh/AqK6O+YbvDxm7zYDXPEptnLN4Cmo?=
 =?us-ascii?Q?pzO0UFJtDp3majUDqmMwf67cM0BMF3T99XUaHv69UHZS5Ioi1AsoPtE2sJbt?=
 =?us-ascii?Q?D0ymi3zDhjzblxsgFuTdVumW8aqL8D/9Tpla4Y3moUXPiy3lru2srgtGJhv4?=
 =?us-ascii?Q?9uv2qrGC6hzCOuKOWEDi/hk1t8COfB1F2+eToK112ibab44GTqN1FnsBTw6I?=
 =?us-ascii?Q?2rLP4tdTwd+GHIEq+B2mw2wwrwWozNGUeKce29vcRpsALgX0u4ZJ9pdiaD+s?=
 =?us-ascii?Q?2eduYnO1oDh81Yd9Zp8onXuOn0VyAYqGAPoDRif7HESXSi8U4M1EcaHQguxN?=
 =?us-ascii?Q?+4eidUS76JUqSe1NZmoBM2UoSIkgmQtnx5vTNfDgZhjYNVQS5St2AIblNi3o?=
 =?us-ascii?Q?y3955xsG2lqij4G75zk4B+Wy2s4a3/A4iAzPWX2Uhk+qU0Ilj8X3co8+4eeZ?=
 =?us-ascii?Q?sGXcW3buVKFEzb/lLGFnhtUOPNeu55dfETUbePOo4K0PScnipiWyB7/2a19Y?=
 =?us-ascii?Q?oEoEANJiLU9sYt/2U42+OyBeueYaLx3IbBSXr+bWBBVM/35mqRLxM+S+lKDS?=
 =?us-ascii?Q?LgMD4vFSOK79GNgn6LLyrjXlLXwDZoJhoVtwlPX8WQ3KRRjxGxe+h4I5IaUu?=
 =?us-ascii?Q?EGlrA/aC3EFWupOe2O3s6rv81HXrOirSW6eideWDln8hOOiFLqdDvxXQtvCh?=
 =?us-ascii?Q?zfqOA5JhQZLXSMjm2kQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 06:48:01.6155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8763629-614b-430a-bf8b-08de15edf065
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9641

From: Dragos Tatulea <dtatulea@nvidia.com>

mlx5e_hw_gro_skb_has_enough_space() uses a formula to check if there is
enough space in the skb frags to store more data. This formula is
incorrect for 64K page sizes and it triggers early GRO session
termination because the first fragment will blow up beyond
GRO_LEGACY_MAX_SIZE.

This patch adds a special case for page sizes >= GRO_LEGACY_MAX_SIZE
(64K) which will uses the skb->data_len instead. Within this context,
this check will be safe from fragment overflow.

It is expected that the if statement will be optimized out as the
check is done with constants.

Fixes: 92552d3abd32 ("net/mlx5e: HW_GRO cqe handler implementation")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 77f7a1ca091d..ea4e7f486c8b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2350,7 +2350,10 @@ mlx5e_hw_gro_skb_has_enough_space(struct sk_buff *skb, u16 data_bcnt)
 {
 	int nr_frags = skb_shinfo(skb)->nr_frags;
 
-	return PAGE_SIZE * nr_frags + data_bcnt <= GRO_LEGACY_MAX_SIZE;
+	if (PAGE_SIZE >= GRO_LEGACY_MAX_SIZE)
+		return skb->len + data_bcnt <= GRO_LEGACY_MAX_SIZE;
+	else
+		return PAGE_SIZE * nr_frags + data_bcnt <= GRO_LEGACY_MAX_SIZE;
 }
 
 static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
-- 
2.31.1


