Return-Path: <linux-rdma+bounces-23147-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C5M6FHoHVWqLjAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23147-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:42:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C944B74D309
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:42:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=PannYXlF;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23147-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23147-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABCA1306620D
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 15:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89041426419;
	Mon, 13 Jul 2026 15:39:26 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012005.outbound.protection.outlook.com [40.107.200.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073323438B5;
	Mon, 13 Jul 2026 15:39:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957166; cv=fail; b=rc5pmxvWlgJeRo9GSt/8p9IYksiMh4IyptTmlGjIqJ3Jdit+NjMvYyNb1GxQs3kE27v0EX+X/voeiPrwYOkEKUc0CYcU5K8vc5svCMW2hshuKBxHTo0wC4IPWN+ApJxF31r+6TIktYcAH5bltf4ilMnMO2wYrtepgOlevydY4hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957166; c=relaxed/simple;
	bh=Kzyvzhrg35Mh+93QsdS16TxKMgJDgSrwHhCXnx6ejCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gkz2F+RwdlzcppRm+VQQ7vo2O1FBcCHhcCNqWuJ7zTtpGx15YDQNSPnMYxVF85jYRaKtEMeTdXTxpcGjhYNcsNjjAdOs0eUFbxdXSnDk+1KRaiZQo8sN82autfxGaH3H/8DQINPL2HvKeClXsZ4Ksaeep3ykVHfj/2B6vSjQq1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PannYXlF; arc=fail smtp.client-ip=40.107.200.5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/o7RfZh5wdUENy9G4PXrPc1pRvdrAqFnh8gNyz2IkP+6wOu8NzwruiaLavcDXXhctapeio3EOOxRGDqnHPk9nlPSFTGCjwZvCGWHF0eiwVMlknchRTq/7Tkow2MwB/CUvriQ2GaU3aratob5kAedCmV/Cvo6kUzqm1CdPLUzKFU6ILxEfrL3ZSfAS6kLrOuWVo4NOIiHSUB1bLT/wAQr9CMhfIXFWIOkW4iTnxpGcNO+VQbaKXPPdETxcKqzwsyAJUYkTZpLaLHyD/jD0bidxhEd9pspCCfUw5CVSBK2ieLFHiQMqRfxj7SDGTQaXVapYwyOqPUk2lnLXi1l/gYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDlKlhWEMI7JrKVX2pBamKwIKRZzhaSZ8J4Z7tjyPyM=;
 b=NBPm40QtAbirtu0PFgnPR3nGTUc2JK9vQ39ExKzNOL48zm9PqbpDF2ssnA2NP2mhOSHw5TlS62/wNo4kF9YlftD+FvgbVUN+n0l3Bnzl3PLnosh47xZTyj8vBULLB/vYqzV03yoi8x6r8kyKmEG688mqPXXh67NBjISRr6azdLSUyLFxDIAzgD7HhOq9kpwYEH4ggw7SGSCRRFOtfC2fxxw3yQW2AMs6BHm/BQ96eA4JG4cFdTmRCgAiVqgYj+5N84MtZ5OLFbTjvr/2hBN95MhtmMkbzlV5Uwybkg4k5dzaLusTHkzCh0nbk/82DQMLO3UClKEgGIQbRq3eJvXVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDlKlhWEMI7JrKVX2pBamKwIKRZzhaSZ8J4Z7tjyPyM=;
 b=PannYXlF43aZ3hik3Zw65LOtvQb/Nxqwq+iDZ/CubecvwAumNM3BPEnn72uChG0sfTV2f7Bh3q3DYUR3FLep+T14zS5H1Oz/p/utJ2AYuHp6VSfC92PTl9qQ0pdgDjH35ml7XrIfHNmEwj2eeD02pam5MJc1J4yVenbtde7jrvgKSeaMe0SSOrJtf/KOWJ79JfCluhHU8VjYJQQZLTl6lZ8lyXSvdbK4m7s5KCxYMzR6BEGSZ65znHy/1aP99/zjRDd/0VQzDFAYLlZB4s8rk9AYlgp9gU7Y79BRi4FXGWagYErGMZYmzTxFeXAXJ8Mn/Z3mLT/o3eORcZNQN5DTjg==
Received: from SJ0PR03CA0098.namprd03.prod.outlook.com (2603:10b6:a03:333::13)
 by BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 15:39:15 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::5f) by SJ0PR03CA0098.outlook.office365.com
 (2603:10b6:a03:333::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 15:39:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 15:39:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 08:38:47 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 08:38:46 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 13
 Jul 2026 08:38:42 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 13 Jul 2026 18:38:07 +0300
Subject: [PATCH rdma-next v2 8/8] RDMA/core: Fix potential use after free
 in ib_dealloc_pd_user()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260713-restrack-uaf-fix-resub-v2-8-bbe8bb270d51@nvidia.com>
References: <20260713-restrack-uaf-fix-resub-v2-0-bbe8bb270d51@nvidia.com>
In-Reply-To: <20260713-restrack-uaf-fix-resub-v2-0-bbe8bb270d51@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Dennis
 Dalessandro" <dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Steve Wise <larrystevenwise@gmail.com>, Mark Bloch
	<markb@mellanox.com>, Neta Ostrovsky <netao@nvidia.com>, Mark Zhang
	<markzhang@nvidia.com>, Mark Zhang <markz@mellanox.com>, Majd Dibbiny
	<majd@mellanox.com>, Yishai Hadas <yishaih@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	"Michael Guralnik" <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783957085; l=2237;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=DiZfUR8iWTusf5KGCmH8juNczeptl7qhlQRRXjLAHto=;
 b=mv6grgUZJl30X2/k+U2oEqx6ysnQaIR4dyrbBz0tdtvvXC1RN/mMD7WnEQPfqX1MqwAPGbIFG
 23tEwlzcS5XAAjWRLVktpZQoZWUo2EOxCyFfLSx25g6gX9NvzD2bwGP
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|BY5PR12MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: d66435ad-5619-4ad1-ba6a-08dee0f4e52d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|22082099003|18002099003|11063799006|5023799004|56012099006|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	uGoD/BpSTkGn9ma7j+cmEoRuOLln5IKeGy//0Ow6VTRQ5OZtXSK8vAjE9/8+nyx3ldEDUQ42q+TAVT/DZWhrGZUBrQ4cMTSvUIWiFQyUME9s8KFmDE1A+6H4kBIzTC8VpGYPUgf1GaSGfByjyTAR5Hq1i+Lm+NDObPVIoHPoHnZdTohEQkqzknbiVhzjzAbdMyu0YtOQE+TKYqOsEMWKQyprMkbZnxAwPwOQuWe0doCyuOBnN9VsZkPbEn2iVjsAz4izdCauMzGl2bmWLTheOznzzldpa4L2QDBBs1yv2lF7Ku9ayd1jlr91Eo3f4JdlImlr6OeDj6bxCJJjUvbrv2K9FoZzYI3zMXlhWw8eVQ2GnsBhHt40cspbsNJCII8myOYG9Rph1L2o62suVELuTgO+oTA2psIaXzwlySFnf85wSN2lvQD7iddwiI9M/52UjcKNv0q7FfxyUgnr4MRQsPLIOub8fSmH1kQNT2SKm1DBOd2iUPR0Wkd/g2XIw2AKguqs21pA2sADSvqeyJwi/vYwqBrgFnEn/3th16EEk1AIhshMTBwHgF3yR4sxZD65xYDF7GS7aR00ZfXUdE63r1jVQiyWMboMrZT/n6pPxPri/emDnqW/pgR10A9QNlPYbxCwap0TWfshM89JVvTdAZAo1b7VzvCccYtnMkCxiWWWGaCfjBttAR9dOCtDiZS2ZC6PLBCaBXyF0c8xMcueh+HZ/YAhZuHBERNNcpTJoFqmtU1wkYXgajH8XgBQWUoc
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kZdyPlYc6e16upxRIdbQ4DpIm0YwMqpGbQ4fSNmYvz2NU289+mOVthnvts+Ss6XsGVEOgaDvcuSd8T4PFLzNmqFIcSNern7C563+nsjDdeXdM+wTj7vUrqXz3Qi1WtfoorPiW2U13opetyWqfT+0tKAkWfQvTQezEyNjgnCv+cj1LDFqbrjUhtj4BpcLhHDDMcpPX1mW1f1zegnpfXZmhPxHDaeC/KiJ6JaZX5hHZiun7wMF+okJaDMfWFGMCOWW3GyXQjN9vCZYln56GZrk/NoVZE7atV1GjuPVMxhPt7RjGOLXoDstcaTZz78Z3jb7uGd7tQeeKg+HW/wAAmoFrEKjm3q5bnP/OXI4vBwEKGKrBBTCFfs9tP97qPLCRxvpF6W0yxp67topIU4py/LYxZsAqH/2MfPoTpj/27UIw+4Rca6qeIqlDxC5ATfdbNPM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 15:39:15.3881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d66435ad-5619-4ad1-ba6a-08dee0f4e52d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23147-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:netao@nvidia.com,m:markzhang@nvidia.com,m:markz@mellanox.com,m:majd@mellanox.com,m:yishaih@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,cornelisnetworks.com,amazon.com,gmail.com,mellanox.com,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C944B74D309

From: Patrisious Haddad <phaddad@nvidia.com>

When accessing a PD via the netlink path the only synchronization
mechanism for the said PD is rdma_restrack_get().
Currently, rdma_restrack_del() is invoked at the end of
ib_dealloc_pd_user(), which is too late, since by that point
vendor-specific resources associated with the PD might already be
freed. This can leave a short window where the PD remains accessible
through restrack, leading to a potential use-after-free.

Fix this by moving the rdma_restrack_begin_del() call to the start of
ib_dealloc_pd_user(), ensuring that the PD is removed from restrack
before its internal resources are released. This guarantees that no new
users hold references to a PD that is in the process of destruction.

In addition, this change preserves the intended inverted order
between create and destroy routines: resources are added to
restrack at the end of successful creation, and hence shall be removed
from the restrack first thing during the destruction flow, which keeps
the lifecycle management consistent and predictable.

Fixes: 91a7c58fce06 ("RDMA: Restore ability to fail on PD deallocate")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index bfbc25dee95d031f91ffef5389e81faa08170719..f86e6f30b1df08396c151000fa7184574a034e0f 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -392,6 +392,7 @@ int ib_dealloc_pd_user(struct ib_pd *pd, struct ib_udata *udata)
 {
 	int ret;
 
+	rdma_restrack_begin_del(&pd->res);
 	if (pd->__internal_mr) {
 		ret = pd->device->ops.dereg_mr(pd->__internal_mr, NULL);
 		WARN_ON(ret);
@@ -399,10 +400,12 @@ int ib_dealloc_pd_user(struct ib_pd *pd, struct ib_udata *udata)
 	}
 
 	ret = pd->device->ops.dealloc_pd(pd, udata);
-	if (ret)
+	if (ret) {
+		rdma_restrack_abort_del(&pd->res);
 		return ret;
+	}
 
-	rdma_restrack_del(&pd->res);
+	rdma_restrack_commit_del(&pd->res);
 	kfree(pd);
 	return ret;
 }

-- 
2.49.0


