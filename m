Return-Path: <linux-rdma+bounces-14506-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D44DAC61B89
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 20:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A8D23440CF
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 19:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E8D276049;
	Sun, 16 Nov 2025 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gZk6/6jb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011044.outbound.protection.outlook.com [52.101.62.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9D0271A7C;
	Sun, 16 Nov 2025 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763320354; cv=fail; b=gFDQV6jfdRhF10Ngrulkx52cHSDYmTqTgpSb/TozfIjT34n7yEaQj8jB/vJ1tJKP0wJJIRj+or2MxZ2s5Ccrk5CQAVEKyU6zxoAsvJlMGWdLYwp/6uk6AeSj0zkqXJKqIfU4eQMMM1PZ+QNJNU4rOjRwYpmZQtb67wXmLigCXg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763320354; c=relaxed/simple;
	bh=U/hbhXTUOk/qsqx40FR+thGoZZE1WZ2LLxD9cEyo2Bw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OiEDc6pBy1xARuNNkSCxSNU78uYQZUL0lxX1XTH3YIMLbN0mc2SsGUHIN7ualrBq7QqKDNhXmlX7Gmr2ni+kukJ1X94otenvVrIbx8IMzij64qk+2rqLVMcTtlxisQ2M/YFLQtIsJ1X6YxplgK6Ph0XxuCNWa3/hU2VZqD7WO8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gZk6/6jb; arc=fail smtp.client-ip=52.101.62.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmBoIDFD1N9znLox6ZBahCB72q3g1ItXn2hNrRoCdDvTT3R8qVfowL/s5OXDvo0yIAENx0lfaEb1BD/5O+cFRmtXUPKtKmP0NcyrnkuMCa4MzCmnHplaAe1udlKqkaSY4k3kYYk1mjMr3Vnc0B92+eKIj78GtfAYMo5VbOF0sZz6xDlNAxuyu/ggS1R0Zaj9gohoBnGlSdPyfZjMgfZrcK+jvz+nO/oww0mZHpljJ6u8MP+Z51PDLkg3VIJlrBqhUDFnxK7tCVdv87+r2bUkE3Jjtq56gwwpBfjId5DKXBIlZQjcT+wXq/MBk1yqddwgG7zY7d9wmJwpk+OkhTFMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCn3B+uEl92GaSpTXyeYDKFDkNWWNkXuzvZfbFeab7U=;
 b=oGhd4J8rMXhHqAi+ofOsE3AN689kcVncrhiiRllz/zF4+W7zS1rN9AYmcKDTc6VqHrm5wV6sL7Ed33XsNvNTG5z3w4g+CCO9WX0UrlZ2dteosrJtysmpOk94NA7X/PHFMsBGZDT8Uj1UxwuQoJTUbzq5gt9cOJ4K47+OkAXypO/40cS5/T3E3A5JL0J+7+vIoKax5XfRy+S9h9iTyUBHjPLBkqa8XU6HSLO+jm9OTnGvELaPXA2MhfksburgkW81125c3KCVICTQQ3VwvVCw247BEe8qG1ONZzTe0jCvVwwu5gFu1JvNOjoWWiEo8HDWpXwYATr7Pd6fy8Qe/zWyYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCn3B+uEl92GaSpTXyeYDKFDkNWWNkXuzvZfbFeab7U=;
 b=gZk6/6jbgUd8lYWSpAuL9BzyRNP017aNW89U6QAN+EXVXQNz1Gfpq0EohPSVqSt0IVEA5vu6BKb8DFxsXneH+Yf7VDU3p8M4VnjYhtTxXuoogQWYFsdJDj9/2Rqy6EpzgyjCCVC960reMieaHOAeVO4LMGLqYTgrOic9wNPeqITsLOF75ZpBMei9Qm1sr3SZNOPl8WwTbzAHQaq6Gpqm/o6Qhl+Cto412zPv+/UflqegeIh6dWzY5wRCHCN/kcUse+y1aMINvkxZOf9qBL163TuT6Eo+EbtP78fh/FzsZTdRPkg2L/M/lcwC0q43WVSzPbr/u/I1JqpZ+CqzcQSEQw==
Received: from BN0PR03CA0017.namprd03.prod.outlook.com (2603:10b6:408:e6::22)
 by CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Sun, 16 Nov
 2025 19:12:29 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:e6:cafe::ae) by BN0PR03CA0017.outlook.office365.com
 (2603:10b6:408:e6::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.20 via Frontend Transport; Sun,
 16 Nov 2025 19:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Sun, 16 Nov 2025 19:12:28 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 11:12:21 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 16 Nov 2025 11:12:20 -0800
Received: from c-237-169-180-182.mtl.labs.mlnx (10.127.8.13) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Sun, 16 Nov 2025 11:12:16 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 16 Nov 2025 21:10:30 +0200
Subject: [PATCH rdma-next 9/9] RDMA/core: Add command to set pinned FRMR
 handles
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251116-frmr_pools-v1-9-5eb3c8f5c9c4@nvidia.com>
References: <20251116-frmr_pools-v1-0-5eb3c8f5c9c4@nvidia.com>
In-Reply-To: <20251116-frmr_pools-v1-0-5eb3c8f5c9c4@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763320291; l=5498;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=YQ0wDiv2bMuWaIF3WnxWy8wPAcMWZX5AiaUc80wqWf0=;
 b=M2u7ryVdMS2JZzuptOOcUbFxWDW9o3OuE7aJTT7qUfnjp+Qwynd2dw5/yhZbrnqj76fIHpo6K
 yGQxNG6X/yqBksh8Lc5l7grvCMkON62XkDn36GQAq+MnZ8B2HBkF8xK
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|CYXPR12MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: 835790a9-487d-4a83-9c2f-08de254415db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFIwN1RZaXFOTFo5TExKa290S0QyUk1tRmRLZGF6Tm9PL3BGUlU0WHpBbkQ2?=
 =?utf-8?B?V0hHb2hWbzZ2NzhFN0RpUzBCS0kyM0UrczgvZXlOMm9xYVZTQWtUV2UrTGMz?=
 =?utf-8?B?MGVsNjZwVzN5dkZIaGR2bWJSTTltZ09ERE5OTzV0TjRqUTJ2cS8xVThkWXNh?=
 =?utf-8?B?Qm9HNjRMNmd4YzNpc2pKeXlKRmZQOGhjclhmbWVJNWU1Y1l2aWhiKzJqODVu?=
 =?utf-8?B?SlBURUxOOUR2SzdnWkp2cDNteVdHdTlLc3ZFaTNrYU9nR0QvWWVCaXJ5U091?=
 =?utf-8?B?YXMrYTNVbFRrM0tGWUNpZ3kvejRpcThObEFySzdIQzZTU3UwZE1WMFBYNDQy?=
 =?utf-8?B?VDRqb2MraVFwMzBNak82NjZkWWdxb1lUYWRSeDMyK2ovY2ZJeFdKYkxOOGxy?=
 =?utf-8?B?cCtZS1pHOEpwZE45NVVLeE9mdExLS05NTXlYbWRsdENKSE1FZHZmbDZzTWw5?=
 =?utf-8?B?ekQ4RTNEQ0lWdHlmWU1WZThrb1ZLMnFEUmtaNU81L2hGd0pTSkRqQU5pTUJa?=
 =?utf-8?B?cmRLMURNdk45ZnlWNDFhenF0dHlHZ2tjeUJSaFNJY0pieExJNVZHS0VtTEI5?=
 =?utf-8?B?OC9DRDdVdVczTUZkQkVHeVNQeWN4TytoVTdXREk2aHJ0MWxjZ2QxS21UR1Er?=
 =?utf-8?B?V1lvdU9sT01sR2pXYVVTaXVaMDJWZnpSMmU2dGl3bFNnQVhxK1lSSkNVcU12?=
 =?utf-8?B?Rk9DVUVDVkI5Sll1cXNMb3FjRFpMd1ZOVEJ6aW03MTQ2QjFad2tWUmRta25T?=
 =?utf-8?B?ekdQUzBmU1N2RjRicitpeEtPYmhMdVA3WW5lQkpVcE1YZEU0VDNlei92K2s1?=
 =?utf-8?B?aWV0V2sxeFVRVEljajdtY0J5QXRkSGRXV0l3WkZ1bzFVeDZQZWFCaDMvMmFT?=
 =?utf-8?B?b0V2QTcrYTg2VnFTaVIvc1pkM2hlZ2FMUWY0SFBKY0l2WHp2K1Z0MFNIMzU4?=
 =?utf-8?B?dFprc2p6WnMxeG5BaDIzTERVRE9ENk1hTXZDY2tQbjlYc2g4aThQdGJ3TzFN?=
 =?utf-8?B?YzdQdm92UmV3ZkhHMmtQMkNsSnNuL1pmcG5CaTJZMHJORmZqLzFNRWU0M1ov?=
 =?utf-8?B?V1hLWHpNVVRRNVpXUis0b3hRSmR1WTJtU1U3Z1JWL05iOVJLTlNPT29wdjFa?=
 =?utf-8?B?Q05wMElXblM2eUZ6QjEyU096bnBBS3RNS2RGN3NWMTFGOEcvT2tkcTN2K0dl?=
 =?utf-8?B?elNXRGJoYXkxUzBFaWhwSGdXTFkrZlJzY3V1Ym93ck1JOXJEako3ZXlRRTd1?=
 =?utf-8?B?UWg2RENIZS9veUZZWHlYWkVjWEZRYVhmdzNZU0VQZDVoZlQzUnRXOW5MeU00?=
 =?utf-8?B?M2pJUDB5Ni91NDBvZ2JjVitkTnJGdXVOaXhEZHF2L2dUMHQxTVJqazhZUGU3?=
 =?utf-8?B?M1VzM1JXOFA1Y3IzVVd1RHNPTDF5S2crKzJ2V0h0YXdoT3ZvTS9XblBxU08x?=
 =?utf-8?B?U2Zzb0FORWNuTG1MTWptVk5UeGx6anp0NWdzLzlGUkhhMHYyTGNxMGpZV1Bi?=
 =?utf-8?B?MHR5RTVHMDM2cUt6RnJGTmJyUDRZSHBpUiszckQwQ3VETm1SV3JCdlBaK001?=
 =?utf-8?B?WTBlQWZaSm5MUmRaWmRuYnN2bkxHVUdwMnNwZkcwQ1hDKy9aSHp4UEwyck05?=
 =?utf-8?B?dnJrS1ZpcUNONnNLNC8rUEZMZVNFRjNzODhsNVhkdDI2Z2t4dW1ZVnFzOHhY?=
 =?utf-8?B?enZ4TEJMbzg3bEMxOXk0VFBTNXc3WmdLd25FbHExR0cxdXFWZ2Z5UmVWZkFa?=
 =?utf-8?B?MDh4M25FVERQdFhwK3p1YzFhdmZmL0crbXNYVktTV2xMajk4REE5YzBxWW9V?=
 =?utf-8?B?bmxwSWRVcGVXbnNGT2tqZ0IwVC9GMXNsQlJlQ2pESnB2bVhrUjYyNGxiakN6?=
 =?utf-8?B?OVlSTWEwa0VZMDFXNGc2bDFvZXd3WnJsQ1lzSWdRenVWOVpuZjhIWUcxd2lV?=
 =?utf-8?B?bUh0bE04MHprTFhwRC9WS1Rja0FuZGtqdGRRbEUvRHpvY0FQK2o5WWMyZHNu?=
 =?utf-8?B?a1lkOHZCMHZMQm5vR3MvbitBNDJSSzJhbkNyZmI2RUNFZ2hJNkxsTWJhWXlH?=
 =?utf-8?B?ZDBsdDBJb294RGZ1MnJJUTNHbEZ6bjVpeUFjUT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 19:12:28.6128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 835790a9-487d-4a83-9c2f-08de254415db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340

From: Michael Guralnik <michaelgur@nvidia.com>

Allow users to set through netlink, for a specific FRMR pool, the amount
of handles that are not aged, and fill the pool to this amount.

This allows users to warm-up the FRMR pools to an expected amount of
handles with specific attributes that fits their expected usage.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/frmr_pools.c |  1 +
 drivers/infiniband/core/nldev.c      | 66 +++++++++++++++++++++++++++++++++---
 include/uapi/rdma/rdma_netlink.h     |  1 +
 3 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
index b150bb78de3c4fd89990f7aed7874e4db94eac0a..9a27ff2d9aec20b415c187909ba660a94590b2d7 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -452,6 +452,7 @@ int ib_frmr_pools_set_pinned(struct ib_device *device, struct ib_frmr_key *key,
 	kfree(handles);
 
 schedule_aging:
+	/* Ensure aging is scheduled to adjust to new pinned handles count */
 	mod_delayed_work(pools->aging_wq, &pool->aging_work, 0);
 
 	return ret;
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index e22c999d164120ac070b435e92f53c15f976bf5c..5c8a4e19fdf8e82e78237d4e6ced9c519613505e 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -185,6 +185,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE]	= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE]	= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD] = { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES] = { .type = NLA_U32 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -2692,6 +2693,9 @@ static int fill_frmr_pool_entry(struct sk_buff *msg, struct ib_frmr_pool *pool)
 	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,
 			      pool->in_use, RDMA_NLDEV_ATTR_PAD))
 		goto err_unlock;
+	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,
+			pool->pinned_handles))
+		goto err_unlock;
 	spin_unlock(&pool->lock);
 
 	return 0;
@@ -2789,6 +2793,54 @@ static int nldev_frmr_pools_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return ret;
 }
 
+static void nldev_frmr_pools_parse_key(struct nlattr *tb[],
+				       struct ib_frmr_key *key,
+				       struct netlink_ext_ack *extack)
+{
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS])
+		key->ats = nla_get_u8(tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS]);
+
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS])
+		key->access_flags = nla_get_u32(
+			tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS]);
+
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY])
+		key->vendor_key = nla_get_u64(
+			tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY]);
+
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS])
+		key->num_dma_blocks = nla_get_u64(
+			tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS]);
+}
+
+static int nldev_frmr_pools_set_pinned(struct ib_device *device,
+				       struct nlattr *tb[],
+				       struct netlink_ext_ack *extack)
+{
+	struct nlattr *key_tb[RDMA_NLDEV_ATTR_MAX];
+	struct ib_frmr_key key = { 0 };
+	u32 pinned_handles = 0;
+	int err = 0;
+
+	pinned_handles =
+		nla_get_u32(tb[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES]);
+
+	if (!tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY])
+		return -EINVAL;
+
+	err = nla_parse_nested(key_tb, RDMA_NLDEV_ATTR_MAX - 1,
+			       tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY], nldev_policy,
+			       extack);
+	if (err)
+		return err;
+
+	nldev_frmr_pools_parse_key(key_tb, &key, extack);
+
+	err = ib_frmr_pools_set_pinned(device, &key, pinned_handles);
+
+	return err;
+}
+
 static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
 				       struct netlink_callback *cb)
 {
@@ -2904,18 +2956,22 @@ static int nldev_frmr_pools_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (!tb[RDMA_NLDEV_ATTR_DEV_INDEX])
 		return -EINVAL;
 
-	if (!tb[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD])
-		return -EINVAL;
-
 	device = ib_device_get_by_index(
 		sock_net(skb->sk), nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]));
 	if (!device)
 		return -EINVAL;
 
-	aging_period = nla_get_u32(tb[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD]);
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD]) {
+		aging_period = nla_get_u32(
+			tb[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD]);
+		err = ib_frmr_pools_set_aging_period(device, aging_period);
+		goto done;
+	}
 
-	err = ib_frmr_pools_set_aging_period(device, aging_period);
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES])
+		err = nldev_frmr_pools_set_pinned(device, tb, extack);
 
+done:
 	ib_device_put(device);
 	return err;
 }
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index f9c295caf2b1625e3636d4279a539d481fdeb4ac..39178df104f01d19a8135554adece66be881fd15 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -601,6 +601,7 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE,	/* u64 */
 	RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,	/* u64 */
 	RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,	/* u32 */
 
 	/*
 	 * Always the end

-- 
2.47.1


