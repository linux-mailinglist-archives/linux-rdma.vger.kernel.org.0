Return-Path: <linux-rdma+bounces-17222-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBdrH7dVoGlLiQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17222-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:16:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D951A7560
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15D1330DED31
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 13:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F973B52ED;
	Thu, 26 Feb 2026 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pq1j1hMS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010049.outbound.protection.outlook.com [52.101.56.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2203D3B52EE;
	Thu, 26 Feb 2026 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113984; cv=fail; b=VHbirxtNPLEiO8RbyfXXP4STubYAqy624WEIDs96Hpqu+lFoj0vxCoSjYhUejMkNjc5qXJZKLzdOcAF+Ls6ocfIs/87UQ+96VYb6jiueSO8lt/tsQJ9Ucf9raq+1OQrKtzy9wUnauFMYmhMT5+iBOT0pG9QgUh2C/ta7WhRmg9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113984; c=relaxed/simple;
	bh=umLVSfBZdjWzLMSJ+HQy1vT9l7tQhzEb31HMb7o8FGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UUNAfc7oAG+AFFmw+mvSZG+eOP0X9ERe50JvzN8lNz9NdyDP1s4K9kSucIbf/lGc7wIad8HeEqcoH8E8J0tZQ+Ytdsfzm+F/lfL31N/CGQ88x1n4VGrnQ0IYCKY/AuWyMP53qls4cLDN4hensd0CY6NRaKGLVZZ1cSCkJe+lR48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pq1j1hMS; arc=fail smtp.client-ip=52.101.56.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I30QZcDK+C516/sdiB4dQKRUqLll27CS97LYIXlkytheeX8Ak8Uqj+VKd84RipaFUm+pBZu7Gs0yNsMV7Tw3Ks9amc+FwFKiGAqQpQ412e+o8MHGbhJ0LRB5wZQ5QJtSydJZSYAykIavZAL/IWIzhjbDC7zqxBBhrVSMsm2gHR03oQtlEVSUFtoBo+2kHW1K86eCSmxsI1LANWKAxzKv/z+KgEfXWt+2FCuhfGekMLoVBZiLkP6mIBN2Ghiwd1JHGmz8kJA0Nn7fM5/l7rrM2h3L+YUs0tr7ZWvrGWG7nxi2Dk/QuAhbVbsFHkzWWFD0nVZMcmPFJ6cSgQ1sFZBXog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vn4nGnfdMaBoxgecVdzl19D8PCmZBMsAuaji1Z1LA7c=;
 b=JgJlbsSI5Wqe9Fj4KFYexbwHfv9VzF4tDJhGIpwCpW0EdmhC1uGFecnwE2rQKssrh59FMf3KNO0NozZRCBP7Br29yP+GQeolYAXwfzG+6pzeF+zh0tYiBBdI0nb8nTNmr0nO7ppuAoqU5tSFllsqGWSG0724mmI1tqFZfWpT86Cwdx4jbM6ZbQq6WlGtLvYeM8sROiaYFDWyDm3S0uLOudu2S29IUBaOVUgg4NhFFmWyNiXVCUVMmmOOyIH6R/gnrImI4XcdFfxPIpXuUheyHLZSJbcGbWEfdU5B74yVBjUKqNrIb72S6uvVo2gp45WlslKYsGJa7BfU+/h2iN/EDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn4nGnfdMaBoxgecVdzl19D8PCmZBMsAuaji1Z1LA7c=;
 b=pq1j1hMSiyScWIu4asILWFtZAqIB64QRsAXOGhUVNYRN+Ye6hwXHVZfKAhZJdHrccbbKt9S1aknairNvvjfbYfta9IXq33WMPb1n0Zc6kFj91wRu9ncz9Xu2vKPZ2siWuElr1o9yG6d41NYZNQQzpt3EYNNUY7zwdzhDCnwoAcGhhPbAsY2zO8ZQdt8wGcuzdHNhHlUQ6dY1qL8ifhRLJaJ4Agc0VC3LCaWs26vBF2RtRjkwYhUPO0rlWd7fbsnLunAl3n3fj3ZPZFhq0ilo70N5XC6e68Z2kcYsrZ1h4A51pztrfXDsDD40cjRAzin7kI+y54zlo1slC5TRDTXB9Q==
Received: from BLAPR03CA0179.namprd03.prod.outlook.com (2603:10b6:208:32f::33)
 by DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Thu, 26 Feb
 2026 13:52:56 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::3d) by BLAPR03CA0179.outlook.office365.com
 (2603:10b6:208:32f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 13:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 13:52:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 05:52:39 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Feb 2026 05:52:39 -0800
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 05:52:35 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Thu, 26 Feb 2026 15:52:09 +0200
Subject: [PATCH rdma-next v4 04/11] RDMA/core: Add FRMR pools statistics
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260226-frmr_pools-v4-4-95360b54f15e@nvidia.com>
References: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
In-Reply-To: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772113939; l=2288;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=B3GyyVazeWCM42MsRe7vAVOOkH6HA/CwfvnyQhzF0pI=;
 b=r3ADsGBuKoHxvxesdoBRyciP55UMJemefaNQAFrzdn6kU8I9faAStl3KBqOcCjLSFOJe2W6X2
 XC0CZl0rcdEBqeE3a2bzwI9q3ejzDE0JCpz2znOOVUetyMxtAYanMdZ
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d48424-ad52-4bea-d4f7-08de753e584d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	uQzHtZ/IdnQp2LmQxH67qbUJ5GM+iQvBAbSvNHw/9+HkmSRdQMdw3+/MxPIsVVZkX0h11feXKzNujSWL1qvm1UaIylIp2qkgXqSR4pVvMIHvOgHRYHbOI+hRmqWRpE9q5YBeYxakvV3SmJv9ArmJGqLM+ecK2tauM10p+1nOVlXLGZkVU/b5mHK0XZf99AaLOXZhwAkL+ha5Vm0U7vAJBIQfMzIVkohZpyPtWXIEGRZG/p6kGe+SuZ5V7Ejgna/hP6Hju1JJtIUjCmNgbs9LBtVetYwliQSv33zzpWHySAlKYkD9MMH/tPYx5/oRlC/zGS82bYOa/tP4tDC0NjpgxGAPG4WC6wfmJmOXtCeinFpLZQ7nE/IvYJzAypNiwRYEV/J6T+PkamRveUAK0gmabfK7h1P+yMeM6CxPpBx8LaOoz8Cd2ebnZS3s26vZSlRmu2K3PX7C+77bwPM32oEJwl82Qn0iuM29bqvm0GkU4VePNmzhOpHbA2eYo/yXxbqK5sNP7vmQeGLp7EViBVH9AFh5N7Nre1chyXPj5J6A+tmFxBrNi4s1NEXRAiifYBete7UUW9PrBJiI+JsskgPFTviMsUdgSMpv69d51XbG/nmgrCTpyqY8F0KkHwhg4YmKD3kEBRC3YkYFIqKkHlDXKvzGSrBKatS1zYM2LFySw8PJkqFi8EYbooe+fhbS5H/5xFLzkzzY0cpDAutV1/B1JwFj4S2Hp1Xu34O8ibHVe72WOnl9fb6L5C11nqIdMj6OMV255+VUFZ2z7BijDkPZXCjOMn/l3FyPaO7pyAx0OyXVT3ng5P3GhQeA/DnH9GnapL9g+torV1A5latIprhVN1I3tiw1Kvdd7rXIskGSe4U=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LHmghFwPQfX8NReenfKCpngUs4nAP547r0cqycQZg+5tom16QYHLbNBCMsYmHjnH8Was9pM9MXleYxiql5taSUT86ym67TLkmXSgPOIWDVyAvs6uDPedG+Y/Tp+e3oHhkh8QtaKgyEUuOHWSLHOJYHnrmuB4hej1q2W+9derQBsm4BQnCLtmg/EZreok2iuWT4i+2bqHlQ3zzqy9/hjlGb1hbzWCaj41VibvHMXOfA/MghlgUlkQ9D5kvCew8PnzoRQJEErxYni7WbnkXYEr7HdWAW+q8C6jHFhoJBrutkJQITaKV1D4GAqirXIi3B50PKm/KlHbsik6mmdDb2OUuKFwbW3UKUUjhMii6bUlljOxqNpUNPv3vqwgW4LvmRVlYoWrthYjOXygx49mMrAA3F9vOxEqN5nZ+2XOH7C4N3XM4KApAI4fmO9xjfXC7JCi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:52:56.1306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d48424-ad52-4bea-d4f7-08de753e584d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-17222-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 67D951A7560
X-Rspamd-Action: no action

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
index 7bfa001b2c731df2de24ebc61cfc8e419ae0de5d..6a3d1cc75cb0d305ce125a0da1e31d530252514c 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -310,19 +310,24 @@ static int get_frmr_from_pool(struct ib_device *device,
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
 
@@ -374,6 +379,9 @@ int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr)
 	if (pool->queue.ci == 0)
 		schedule_aging = true;
 	ret = push_handle_to_queue_locked(&pool->queue, mr->frmr.handle);
+	if (ret == 0)
+		pool->in_use--;
+
 	spin_unlock(&pool->lock);
 
 	if (ret == 0 && schedule_aging)
diff --git a/drivers/infiniband/core/frmr_pools.h b/drivers/infiniband/core/frmr_pools.h
index a20323e03e3f446856dda921811e2359232e0b82..814d8a2106c2978a1a1feca3ba50420025fca994 100644
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


