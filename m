Return-Path: <linux-rdma+bounces-15149-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6728CD605E
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 13:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E245309F274
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 12:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ED32BE7D9;
	Mon, 22 Dec 2025 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TyWpoqw6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013034.outbound.protection.outlook.com [40.107.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4026629AAF8;
	Mon, 22 Dec 2025 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766407287; cv=fail; b=fXRuWuhYty3hrPkDun85/fl9gTG0awNu2dHGtcxV5rgl5OyfXXYSUJlre3+QlY8Bwu/FHtybXlCKtR+9Bcpyx+YACkA8zJVgL2t1PwAenwFY2hKHo+TLKB2aI8DqCnw8QZy/lBwX/TDoRNSFyZ4bv45513rKeeuRssNntnFx8LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766407287; c=relaxed/simple;
	bh=0QHcpSTotl/LrXuuKvHhdZK6bY2KLNtm4xG93ixoCJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CbGOt+9wTxd1b1uPrYS3q0dSRCYuBNGxfdObV6+DQ99vMUD12l+k8jXwEaJKIkoc/d+wnvMLIK2XR5HbTmaXrvhrzpdRKNxJDVwf1U8UWZ7um2Yo7txBYUep5F9rIkjtAhAcAWnLHzYF0VcYh8FaQ87CnoS6moJGw0WtuwF2Wmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TyWpoqw6; arc=fail smtp.client-ip=40.107.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QR3u2oEuqSNkqOgf6+8Uc+9gQiYbewel6U9EXOVH0LRODWMDhlKnN8vOvQtkTu1s+9iUBHIWyGZ4tYoj0MydVBq8FpuCcBAq3w3uItKtEtWIul50eANTuGAokVfpnSbYgc/OROZ0QnjjPJ6fNZ82/QjMOBmw7FeEZpE/NisNNjLgIGuuQvcscG+rtXc8Nv38DDYpjzAPLM/q4HaN26nvKrORqkIMcpHe7g+WTTjrMe1kYS0nH9541xgV4HNntzNQRViL+CEd0ulUqv7bVp1v85g4AO1KDzCmlaIns1jbfDMkBRByPNx0bxnR+z0J8J5R8XEWWU6/8r1JZveX/dMqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJTvK61HtnkNEBy6kc3EyofKhFkogO4yzUG/iTvXSTA=;
 b=RLf4ZYBArnBByTPkVVlABKPvS4yCAmlYRQMBRA+enjtS9kKpSUSPJ2G+dkpqumDGhSbXwDb7k94mzL45CVZMbLhMipPQ/jYX4kfm8jo5oAd/nXVKjmLTEdlUkmlgJ9HyA50QrIFj+YhIQdE4c/4uKQCJoMM3Ul17vCViiZetwZZGu3b9c3cLOHGnixr1D3iEyDsv9BOdxQk1WEBSqasYyonPuLnG1haS9mkloyCxBhFFajbD1qQq+Zb3uzA2/rK1UE4DnHXC6SkfXelql5TuoV4U+rshGxxK2hl/cxG5KMlvLe0LQOxarFq1/yJgdMIkbIns2jgLKmbSdYgOwewuzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJTvK61HtnkNEBy6kc3EyofKhFkogO4yzUG/iTvXSTA=;
 b=TyWpoqw6g73GplLZuGMsAuNOKIrdyFtYAGT/PC6yKWeoa7qJc3kf6EC2JGBO1tkwHzyzF9RFXQ5DBtLOOGKBIg2VWRUzqY96fbF0trTI7YbY3jN3KUuK1wWxl4s3KNEIzPcy9OkYUN+6pjSBH8CZ06BlMCxz0TZzmURghZkJFZBP/nGqnJa9F0neE4O8iAIDvKjYK72aDuAhv+fNCXl/WiPKgkQK0/UTgubaEYMVhsOusdKKUU8g99MOsf/eTswPHP/kxtCLVcwtU2yJfWqZvm5KdOOb3/cbODzuaIDH+0DPvkSB+NGfC8w/NK+KTi42iU8nsvBla0jPzLIbysrMFg==
Received: from CH0P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::7)
 by DS4PR12MB9771.namprd12.prod.outlook.com (2603:10b6:8:29b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 12:41:21 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::a4) by CH0P223CA0019.outlook.office365.com
 (2603:10b6:610:116::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 12:40:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 12:41:21 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 04:41:08 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 04:41:08 -0800
Received: from c-237-150-60-063.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Dec 2025 04:41:04 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 22 Dec 2025 14:40:39 +0200
Subject: [PATCH rdma-next v2 04/11] RDMA/core: Add FRMR pools statistics
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251222-frmr_pools-v2-4-f06a99caa538@nvidia.com>
References: <20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com>
In-Reply-To: <20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766407244; l=2176;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=zwfUIhwts6RBHeViB+OFLstwOmMi9F6kEOMLBl/KkmE=;
 b=jh8PeXMpDLbgE5sXAhePkMbi9xBIJucikMBvaIV69LWy/MljGrsUIJJeHYj8W78wyt78J5A34
 N56hOv/hUcIBOxowRVsAv/FpM4jZNSMbF+wZndPK+ZgSYueA2n5iLNR
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|DS4PR12MB9771:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f7e281-cba5-45c9-ebc5-08de4157694d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1FvMS9MZEtkVTJuZlY4SlRsM1JnNVcrUFFINzkzQkhqSlJRc0hMb09rSzhm?=
 =?utf-8?B?MTh6R3d4ZzhFeGJ6VlJiZDZINk55Mnlxek5UblJLWDZUSXZHZUc2M1JzaGpx?=
 =?utf-8?B?OEkxUjIxTEZCYTdvNERTU3h2UjM3L0RYZVgzZzErL0poSFdWclN0Q3BuTjZi?=
 =?utf-8?B?SjVYZFJ1aEJubm4yNURwdmx6SWlCMnJuZi9ZY3Q0RU0xMGRFVy9oRTRnRkhM?=
 =?utf-8?B?SXNpU2pKMVgwWDhjVUFUYkhvZDdDK3BTSllRekZsb2VtUnprZVNsWkJ5aGR0?=
 =?utf-8?B?bnpiTkRiYnVXZ0R0WHZPRDdNZEtaMTh5dEtxS0RLWDVxZTNyUS9raDFyTzlx?=
 =?utf-8?B?MituWjRBSlhCZElGR1JnL1F0b3oyaVZiQlJFalVMTS8yRFQ2MEFQT2dRK1JZ?=
 =?utf-8?B?N1hEWUhiY0JLNUpEdmJsTGJVd2pOS09TTzhORTVZeTJOLzBUbUFaRWNBU0tn?=
 =?utf-8?B?Q1FZY3lkNXRPRldhMVJ6MkZXKzM1UVpnNFpwVldhYm54TGwyYXN2bW1lekVo?=
 =?utf-8?B?eUU3Z2NuYXMwcnhlYkxGdlEvcnpwMmRKVCtoN2ZVY3ZacmJwOEV6K2RibmhX?=
 =?utf-8?B?anI1dlczOVpKSlo3SlZqWHp0VGhJTjBITGFFNmxxZ0MxRi9tV0p4NzZ2N0Va?=
 =?utf-8?B?MVkyMmxSdVM5MFpLN05UOGVNb2tHZG1vbWgydVFzYXJOcGRLQWRFYVRlNVZK?=
 =?utf-8?B?N3Yrb1d6bXJPK2pHWG5PbDR4WkVqSlNROW9BcGw3bmlDQ0Q0dWFEcDNKN3Bj?=
 =?utf-8?B?Tkd0UDhsSWxtQUlRdU9zRk5WM0JMSlV3THdSNjRGYmhmbko5cjFPUDdDSXNm?=
 =?utf-8?B?VG5hRGE3WGx6dk9ZaS9NWlk2ZE1HZUdrTjJ0amVkeG5ueFBwSk9rc3JXMHFR?=
 =?utf-8?B?dkRtWFBPNGRYNHNHUVFmNUQ3TG8zRFdGNGkvRStpWm5KVXRhZ1NRSWJtckRm?=
 =?utf-8?B?aVFrTFhuV0dMbEU1VWwyL1dSUUFKWmpjU0VpOHNDNEpnRU1KRnA0cWQxckdV?=
 =?utf-8?B?QkU5RVQwWG95aU52ZnNDT0tEdVRxM2NpWUdzWWRMZ29JZkFmNDZ3QVJsTlJY?=
 =?utf-8?B?V1ZoUHBOV1Z3UklIV2hlVm1EWjJxcUdwMnFsNUwyMVpiUG1XZ00xTnZsT1RH?=
 =?utf-8?B?ZDlkQUgxNXU2VytqeUxxMWU1bG1rK1NRaTZGWmIwZllmQkRMeTYwUVJhVlVC?=
 =?utf-8?B?dTJHYnBnZWk4UDNIUytwQUw3TS9kdTF1ZDRCcWkvOTZRRDJpRDl4dnVwSGFN?=
 =?utf-8?B?OXkzVU1maUtyRWw0Q1R4WmIrT3c2YnY4U2tFMUFwZkVnbVRQQU1LT1c5S3Z5?=
 =?utf-8?B?V2RQaks3UkdadW1MTzgrVHg3bjdmenE4d1NhQTVXMEdmVE5Nb1JKeXg0cUdO?=
 =?utf-8?B?anNPU0ZrS0kxRGxVQmI0WFp5Sk1sWmZMMHFKZ1grdnh5S05FSFlqOWlTV1ZN?=
 =?utf-8?B?Q2wyaUJvbDBEOHEyMThDNk4ycGNXd0NjZmtLOEJNTXU2V2V4UTVsVDN4K3Vq?=
 =?utf-8?B?M0xmOUl0OWYxb0lpRy9qY08ybTRrRGhyOWM4OURBWEV3WTloV1FpQWNyNXRU?=
 =?utf-8?B?UTNqaGE4NkRYZm56SHVuZm1OK1A1WmxtTEhsSXI4SGdOT0oxbk9teWNBbzRE?=
 =?utf-8?B?Y1lHRlRwZWg3MWJ4anowYk9QenNzME1qb1Axb1E5dEhtWFdKWHEzU2lsK0VT?=
 =?utf-8?B?SHN2UlJOanJDKzFyNkE4N095TWwyV2RmYWZjdlVYZGRQSTFGTTluK2tEbjNQ?=
 =?utf-8?B?Wk9zYnh3amFQeTAyRWpxMVZZbmlHUWJjR0FFQWtFVURWOHBBR3R5NU5LZ3hZ?=
 =?utf-8?B?MWtGUytEclZZRHp6VHlFQjMwWE50Nnp1VmNnc0pRZWhYRFZJVDN5aENWTUFB?=
 =?utf-8?B?YkFHUW5SL0NsTVRnNnJZTDY1c1ZFNGRnNEJhUWdXU2EzdVRhL2dWbU4xdkZo?=
 =?utf-8?B?ckxKTGFVSEFLTExDVDY5dDQvWHpFSDVQSmcvNmpFWkdFcU9teis3UnNxdjF1?=
 =?utf-8?B?bWRDRU5YWGtsbFhTN3QrYXIzYklSSTl5c2FkQUpqWjRMZXJCNFRoS3RQd2hl?=
 =?utf-8?B?S0drQnFPQTlPQUFiWU9QUGhIS0tYOVllMVlIMG1KRThMUm9MTVRYNkJYYkVR?=
 =?utf-8?Q?g72YIWRxdNm6oLIVd1DkSQfCD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 12:41:21.6419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f7e281-cba5-45c9-ebc5-08de4157694d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9771

From: Michael Guralnik <michaelgur@nvidia.com>

Count for each pool the number of FRMR handles popped and held by user
MRs.
Also keep track of the max value of this counter.

Next patches will expose the statistics through netlink.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/frmr_pools.c | 12 ++++++++++--
 drivers/infiniband/core/frmr_pools.h |  3 +++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
index 406664a6e209..9af2f6aa6c06 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -319,19 +319,24 @@ static int get_frmr_from_pool(struct ib_device *device,
 		if (pool->inactive_queue.ci > 0) {
 			handle = pop_handle_from_queue_locked(
 				&pool->inactive_queue);
-			spin_unlock(&pool->lock);
 		} else {
 			spin_unlock(&pool->lock);
 			err = pools->pool_ops->create_frmrs(device, &pool->key,
 							    &handle, 1);
 			if (err)
 				return err;
+			spin_lock(&pool->lock);
 		}
 	} else {
 		handle = pop_handle_from_queue_locked(&pool->queue);
-		spin_unlock(&pool->lock);
 	}
 
+	pool->in_use++;
+	if (pool->in_use > pool->max_in_use)
+		pool->max_in_use = pool->in_use;
+
+	spin_unlock(&pool->lock);
+
 	mr->frmr.pool = pool;
 	mr->frmr.handle = handle;
 
@@ -383,6 +388,9 @@ int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr)
 	if (pool->queue.ci == 0)
 		schedule_aging = true;
 	ret = push_handle_to_queue_locked(&pool->queue, mr->frmr.handle);
+	if (ret == 0)
+		pool->in_use--;
+
 	spin_unlock(&pool->lock);
 
 	if (ret == 0 && schedule_aging)
diff --git a/drivers/infiniband/core/frmr_pools.h b/drivers/infiniband/core/frmr_pools.h
index a20323e03e3f..814d8a2106c2 100644
--- a/drivers/infiniband/core/frmr_pools.h
+++ b/drivers/infiniband/core/frmr_pools.h
@@ -42,6 +42,9 @@ struct ib_frmr_pool {
 
 	struct delayed_work aging_work;
 	struct ib_device *device;
+
+	u32 max_in_use;
+	u32 in_use;
 };
 
 struct ib_frmr_pools {

-- 
2.49.0


