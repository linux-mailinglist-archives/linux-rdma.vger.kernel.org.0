Return-Path: <linux-rdma+bounces-18646-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN90CDoxxGkAxQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18646-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:02:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E25DE32AF32
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 004C93059721
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 19:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A1E35F190;
	Wed, 25 Mar 2026 19:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EwanVZ/u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012003.outbound.protection.outlook.com [40.93.195.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406BA34EEE7;
	Wed, 25 Mar 2026 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465260; cv=fail; b=hJ+/BgOuj4jVy++4ZtFttZaGf1rFzHK29fG525PHNCmTNXfZfBRgoiyFbBANp0H7eBstLNJtQB+PgYNzh6VEoFVg4SIpwITogCfJrhEl0WGlqqFYuuG0MZFvsMybsubG8Ea9TX+jgvQQEKjsnwvPAsAbVe5BzkCUuZQZFNhEnSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465260; c=relaxed/simple;
	bh=OCtn3qnFkvcS1A2WnTDmu+NuoqV+KXROwIZrCpgvH0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NsFd02YFuAH2ygY4r0zVsRtYcxyR/5yd9ii3JJBkuHlabiWYPJzfjLeKqnm8A9YtsWu2E7mP9CNxBH5Pf3zPep5Rw1RqjD5zhN9NoHcA1afHZ/ZNIo43wsePUCkuppEH7EumjIyxWFideKzZfMTmW2estzDAarzECHwe1QfNFbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EwanVZ/u; arc=fail smtp.client-ip=40.93.195.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baY4icA8QCIfCj8qotmg8wpNQXTYmnNgIgl8aj4+SekAFWVWRDmdsULwo/NkWhr6ZfDk5VzEGdPlF0YhNQRd9ZahBfIaMhGn/P7RccYdJlhb7G5iqxejAWDF8v7dWk6MZuCDOM6NYL2kiGL+/XJqhvMfV4ElWdVEvtG0MVOGRx8vSWAYqbfr9vZxwIgvpWucGQJKJo1oiw54ZFDl2q1Kek6KqL/nljK0RnsCF1qLLdLbB75Ccrt/EJgLp775Dm4Ia537R37NyOBvSX5us4wSZPOk3Q1At5nbRfVkIY2BhODDO3GdjQCRT6YhqfKV+i5R6bhamVJwuXYY7XsYlVVl+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvC0+BWHcKnZIlg4ICoBk8kNOqzkSfYdpvx/S9m/RZQ=;
 b=WZrgOnTv3FxWot19DSGOwaNZc95cN0NDrKoOUXnu7gWkc+1ePW6IywLKrhTECLMsrGFMCIHvZ0orFnLvpEpnVf60XDGXaxvpQRoM0S29Kdjsq+kQ7DIwe9DWkMmyUauHXaHBjGDHe4/Ipv43b5rP3r+g10uCOB64k7ly8Rl6FXKztDEc3isYiSFDe4eOp6GaySSKtsy5xUxhd+K5c6aAp9DOHXFtuBO/q0c7EDCartFfCfnAtuKSoksMId5pHw5DCHAiQVlYLMdC2EWpQUEZK+bjZlYZVoLOJGZdx3Qedvs2MyzQ2MQEg8q1jX0lsEfxj/ZeyRjiQKAsqTpUPFEqeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvC0+BWHcKnZIlg4ICoBk8kNOqzkSfYdpvx/S9m/RZQ=;
 b=EwanVZ/uXL+911607LOawfqaHVEVCanAz1qZoKchHRjrs+dre4YukIhu/+Kh/b8WpPQbdnY64X7QRXT2KtRlex8D059Ih0KL1e5+oiVevThHc8JmWHwKACxb7FCwIjLkCNj6NUzCRnNk86gXqCJLEsDPLtRgCtAk0K6FKqOAqYybBqdKiNSJxrPLgB7xV1XICVGYpW2wT81p+FVCmkwoErB11llpMDvreA8v4mkp4jzUAt7q3jkj8LRcSexvopPfyuYk0bKvInAyDqpIJwoEc63tznILEFSwoIce2oPpIq8++sRflaxA8Rh3Gu5L8zCv9Maq731bOvKYJ95dOoZgpA==
Received: from PH8PR05CA0018.namprd05.prod.outlook.com (2603:10b6:510:2cc::21)
 by LV0PR12MB999069.namprd12.prod.outlook.com (2603:10b6:408:32a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Wed, 25 Mar
 2026 19:00:53 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::d2) by PH8PR05CA0018.outlook.office365.com
 (2603:10b6:510:2cc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Wed,
 25 Mar 2026 19:00:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 19:00:53 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:00:26 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:00:26 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 25
 Mar 2026 12:00:22 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Wed, 25 Mar 2026 21:00:02 +0200
Subject: [PATCH rdma-next 02/10] RDMA/core: Preserve restrack resource ID
 on reinsertion
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260325-security-bug-fixes-v1-2-c8332981ad26@nvidia.com>
References: <20260325-security-bug-fixes-v1-0-c8332981ad26@nvidia.com>
In-Reply-To: <20260325-security-bug-fixes-v1-0-c8332981ad26@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Dennis Dalessandro
	<dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Mark Bloch <markb@mellanox.com>, Steve Wise
	<larrystevenwise@gmail.com>, Mark Zhang <markzhang@nvidia.com>, "Neta
 Ostrovsky" <netao@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, "Doug
 Ledford" <dledford@redhat.com>, Matan Barak <matanb@mellanox.com>,
	<majd@mellanox.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774465211; l=2282;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=gcx/gxokEE4A3sI5jvtz8aq2s339e2gUf/pCqpu6bsY=;
 b=r8btx+XmVtG0PPen/oKARYWf2LxzSyCj0roOPG9vuZzB9Xo/XQFn3VHiRJHAO1Ir+ZB3P1L9E
 x/G38RIQQR1Ct07lU+8xD1QJYS4wRN8FwsXFTTcbmtUG9kq78zojYuR
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|LV0PR12MB999069:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4a3ecc-48e7-4810-c3cf-08de8aa0d6bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aGmloHAJttPN8aCLEI7hRacxLBvEcIv5eoNcLaioOGR+DzufqchqQK//9wNsUuBx6WrcelT0fjlyJM79hFuCVl3mB32D3M/xaOj/MhW+V27EsU3a6Xtei9vqEbeE1lFYHphLinVeKGOVlduugGiyWsL65XOp+OL3h5EsPqPUyfchVvPBcdnLqTKgH/WS78gA15fVSUbGsSD3VrPjsS0h2KEKUoG09HRcE6fjCmwoC5QWXRa2P7lf/BzJ2VkX85+S2yCS75cE9Q44qH/DqQwEIyWlddYmPfAL9OsRbxmwYZ5+UaYzqcGFwGWXPkrEyaALckB1USU4/qnG6SI6qsySJX5igaiRzwPudZEMGlMpa+Ruv+/IR3Kf3XDyGtc1wDpEhuq029xBV5almPlz1pHYC1chxH5DJt3kiZ7WnEwx+NTlpG4Uwy0coieF6TG2ZX+ZFsZ0divGIv3BdFpzj2m+sdKfKoJ+Uo8JvK5ejL+u3YC8jNHjo4e9yU/jc/BgC4ZwzJKST1MvMZY/o8xttkkIHLBxi+TmdJKHsVUMPRoUa9xM8Ix8GbNnjZBp0V1tndTxn+IF37dsVmsns5+8z3zSXzbKPcMqAM+oxdPikQ3q4NsFmMxTvBo4dKuNoPvE6r2ySRliTgpeX6JI5fi2dvOdKQfG6uJlZ+5IPox3EZbcWhmOtLPrtRwLrUsfK4vxwHm6Q/js1GMzT1Y3xPO5chIfaSXB5H/KK8sA5ZPYxH2cw60nCYmgRQRyh5o5O5xJUyUrYHAqb1K2xetB9srouoTvfYkQpEAlaV5V07Xb1WoSU0HWNLs+P2a90StbuWqJ2DtY
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4mj5VIRxoXWs3pkTOrbFJrXZDFkunbNIGTGQYUZKdj/yUWZKNnY1kBKAiGT0Ohc6cnovcZMCMKeQLKl6J4usK+k9OHPkK65KZyTpBsRDWuHjLeZneiXCEm4lhQdc9HbIhytNAVmxItwyF/RBt7ugoXnc6w44wF378iBqY1fq9dKrhwCblPLNwzNzUb1cYlMXtf2eg+qPI1XWVHprabMCKcpqlDcwOdhLjlpJubFquxTMlFLaM54knsVoDUHX/JMoSjC32sDEjZjeaXrwYkRUFNKyJaI2i80qrVyIciam/0RBUv1W+KoW8AsKj0ngUI0062H+IKAP6XR5AEfVG3wHR72C6C8BPma0qB2cgs0PFGuHYa/P/ziX+t0lFl7od70lToNaX2nAoblWFb60bVXm86vCg9J+18xhRhY1IfZcqKyqknakLQ8IJXmzrGQJkbGU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 19:00:53.4722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4a3ecc-48e7-4810-c3cf-08de8aa0d6bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999069
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18646-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E25DE32AF32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Patrisious Haddad <phaddad@nvidia.com>

rdma_restrack_add() currently always allocates a new ID via
xa_alloc_cyclic(), regardless of whether res->id is already set.
This change makes sure that the object’s ID remains the same across
removal and reinsertion to restrack.

This is a preparatory change for subsequent patches in the series
which will do rdma restrack removal and reinsertion.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/restrack.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index ac3688952cabbff1ebb899bacb78421f2515231b..485e7357c90a5ff9660feac38a0ec01c0deb0000 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -32,7 +32,7 @@ int rdma_restrack_init(struct ib_device *dev)
 	rt = dev->res;
 
 	for (i = 0; i < RDMA_RESTRACK_MAX; i++)
-		xa_init_flags(&rt[i].xa, XA_FLAGS_ALLOC);
+		xa_init_flags(&rt[i].xa, XA_FLAGS_ALLOC1);
 
 	return 0;
 }
@@ -71,6 +71,8 @@ int rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
 
 	xa_lock(&rt->xa);
 	xas_for_each(&xas, e, U32_MAX) {
+		if (xa_is_zero(e))
+			continue;
 		if (xa_get_mark(&rt->xa, e->id, RESTRACK_DD) && !show_details)
 			continue;
 		cnt++;
@@ -216,14 +218,24 @@ void rdma_restrack_add(struct rdma_restrack_entry *res)
 		ret = xa_insert(&rt->xa, counter->id, res, GFP_KERNEL);
 		res->id = ret ? 0 : counter->id;
 	} else {
-		ret = xa_alloc_cyclic(&rt->xa, &res->id, res, xa_limit_32b,
-				      &rt->next_id, GFP_KERNEL);
-		ret = (ret < 0) ? ret : 0;
+		/* If res->id is valid, try to reinsert at res->id index in
+		 * order to maintain the same id in case of a reinsertion.
+		 */
+		if (res->id) {
+			ret = xa_insert(&rt->xa, res->id, res, GFP_KERNEL);
+		} else {
+			ret = xa_alloc_cyclic(&rt->xa, &res->id, res,
+					      xa_limit_32b, &rt->next_id,
+					      GFP_KERNEL);
+			ret = (ret < 0) ? ret : 0;
+		}
 	}
 
 out:
 	if (!ret)
 		res->valid = true;
+	else
+		WARN_ONCE(true, "Failed to insert restrack entry at res->id %u", res->id);
 }
 EXPORT_SYMBOL(rdma_restrack_add);
 

-- 
2.49.0


