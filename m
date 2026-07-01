Return-Path: <linux-rdma+bounces-22641-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id diQCFj8MRWpq5woAu9opvQ
	(envelope-from <linux-rdma+bounces-22641-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 14:46:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2C36ED8AC
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 14:46:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=hCEqkRjJ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22641-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22641-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C73CC3214241
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 12:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E4A496905;
	Wed,  1 Jul 2026 12:29:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23C44968E7;
	Wed,  1 Jul 2026 12:29:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908971; cv=fail; b=syLhuvmlP+C+Q39+1WgyGNL+LOoBVo7qr3641EWERfzztzV9B9Ct0UN5y/xg9M3Ia1AGMNm8aE5cHJfmspwQHEhyMjV3UO9XnBpLRxjIKbyATMc2HH09eS/E9F8k4lnBQiDCpTC9fIzj7cvgm7JzfT2Hfo5KNUhe1TIlguRNQ+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908971; c=relaxed/simple;
	bh=b53RpVl+1C8TTbny6KsUgXj3XNbPDLR/ZJmClX/3egs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=q0P6xvg2HCd6nXkvzEzvu7cmsgWUoc0pZIern+Ic/2qds2J3MV3EhoprXNSOlajCCaacbnjB3iOjZTy2UTrpGJsac+13btOvuV24M67ncWXJDZEc4hBjHt+0XwqMNlOwr25WfFlOrU6KRRVHOFaZvZuH3gNwvJgLWZsxk0ei6mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hCEqkRjJ; arc=fail smtp.client-ip=40.107.208.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2y+JGL51gXgXde1YFBJFWnkDIp0/LTne5IGejzZ7vgyj8fuRxrSaqhpqtSn0x++Sygj0W+O2YAWrkhc8D9hOXQ0ybBm0amSAR15oy1njkSpZVSwLFbAUTGNlzeerxrYf4dnEua6PbrQsKPaeVazrvi3+Cb5UdkDhf9EngCWOWYwomYImj4zelCJTkWcnqcV6Nu7umH6xWAB42ht9YYBg5V+J82mQkoJb6NyTV5u4jAaGJrdVDBXyYzi7tgZmAGKp3Pi5JB+svMSDMQq+UkU0xBwnOiuDOarV88SK9zz4P1SWZ1nPZSqfJvKeQRjQIPLVdaeuj1EarKbvtRYKMCvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beiZqJ/73+OyiMxfmnzvnXSZyEb8uZjZFfAVrMxnp5Q=;
 b=xe4exZCGdxbxuh3daGecKEwiiDyrJQn4O/NrysDB+Ls+7Muj7gi23+2y6uPiWsr3yvQ9IRYIsf45qjtUs52bnwTOxcdHD2H7rP2JPTQNo5tMcXvJuZXeXgGs2uee18cHrzpz0oWDs7NssjPHpPL+3mUfKaRLwSqmMfBCKt3tnIhGpNUY4H9CYx5S4Xiy1Gp8DTsUFxiqez9IAaYuog9oGJXTpwBI/yheK0PE2axA3udb1nI1FCDjHag0w9puw28RtBSVzTpiQsvMrgttSr7fRyKIEot1OJYiO409s5jI/KNzYseVhbqzNSsVidhrQVbsYOOQMx/cemrEz5mGVcCwEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beiZqJ/73+OyiMxfmnzvnXSZyEb8uZjZFfAVrMxnp5Q=;
 b=hCEqkRjJGxGatGSRmTlp0cTADiwwrJ6Dd2/ElCYcqk/rGPUsCeZJgKemJpI75MbH1iYlakAWEiZrsB96JxXuEOTCaj38zDbemouqfdMsag15EzBYnsVGq0Vkjl+QJriBuw1JZW4FayoefjEBC9yai4c+K5sqwzIItFLWeKURnQRI/+sJotS3iPAVQ+Z/5A/sczAoSmt8sfd09b83243AXDxbhue/ZQyt9a2853IcUbvu0RG6NN4acRdyKh8koShdUeokH7G2m2DA5OjbSNo3qRpgGp9v+cKx4XmMyV25/ndwDdmOyu4e8TXRPD9mijc/7gwAh2Yi488YniTyunfIig==
Received: from BN9PR03CA0279.namprd03.prod.outlook.com (2603:10b6:408:f5::14)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 12:29:19 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::1f) by BN9PR03CA0279.outlook.office365.com
 (2603:10b6:408:f5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 12:29:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 12:29:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 1 Jul
 2026 05:29:05 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Jul 2026 05:29:04 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Jul
 2026 05:29:01 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Wed, 1 Jul 2026 15:28:20 +0300
Subject: [PATCH rdma-next 6/8] RDMA/core: Fix potential use after free in
 ib_free_cq()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260701-restrack-uaf-fix-resub-v1-6-c660cda4df2a@nvidia.com>
References: <20260701-restrack-uaf-fix-resub-v1-0-c660cda4df2a@nvidia.com>
In-Reply-To: <20260701-restrack-uaf-fix-resub-v1-0-c660cda4df2a@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782908915; l=1814;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=HX23mOgsyaK+lgHvElNXf0sQuYVHYh+GHhlZjiNNlVw=;
 b=6DqXWUJKYH8rRchE2bsxNPJN2xlq3rU4IjNS1Z8uZud433ATTD+Pw2AwjsbCUUM4R6mSNTZzu
 bEublASTMIZD1aAg96Dx1c4UkfKmMnra/OfuKYpqDJ4nDpz39slP3xz
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8d0dc5-c74e-46d6-80f9-08ded76c5f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|6133799003|56012099006|5023799004|11063799006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	18kQzQucoEdlPevHUN5eG0BfkwMaVEtoAQKJb9nje8CrPmS8IFJiFKkBmzDzfrx6bsDRdYIQPtsokH3jrRC1hAD2CF/HcmkntXoirMI6W7XNFe8t+GX2Qoikor3JRlBEAl2fG6znSFBx0KcUlmxwCM/h79HBWqG5RABKeNowllW38bNVIYJ0GGdDFsgAZFs7EZVjiuRvFx7yR4mAplI59pn88qvmz+uRr4nXXq5VqWvv6/ZS2JhJ4/fFj1PJRV84lngaDoyC5aqav3jlOoi0dwDfDkcj7kRGY/WfeQ7iCON3JOHLAdOHWRoFuDWABoKBdBfGHtikVpe8kwXyIxw/Vl7Ye8DzxbY5pgQIu/EDvNk/5UnSar8yiIhd58VX1d/hTUOF0peyWRUUwgwY5XJBquNnziZiiiZsP+RlAmL3zea+iGEGCpjwwkrL5z2mMJaCarkJSImeYhLc2fZXRPyC2vNPGTF9Ccc8NhD/DLSeXHJzbj7lAfqP8uBhwe8WtLbdTECQB3LWuUca+qqtj0hSgfM56+mzHPUiqvJ9+WY/7d5HdAkN9Jtew/Val2CXqUaE9+qmgbMU6MzpMwh/PMF9VUNWRuQhd2KEybVCedKRdhPB5Fvz6jEKJSXv8Yj2H14xiVV9f1pakzslfeiKwt4epeS7hiuV3K2HUqwpKjJnKBqwx4yU09uMj01S5Ks25M/+3GSylLtiuctgAo1a/TVQTA2uJ992sD8USrO00feQAjQaNjlDFxkinbHDx0ebCN9F
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(6133799003)(56012099006)(5023799004)(11063799006)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l3ppvFK6qPfA4WDEzrNuv06/nSZIk2qo82YnFrZktnL0ht4g1N24HQ0aQzvolQR7OByhlGyuy9mXxd1rFCMzCSclkDLo2fcI/EDzAdwnhl508DT5LvTNd9apJwkJTShfYEMjuRxgBjePC2nXvQIpjiWv8aPQBgbe0FnQAFzCdvF5m0C/95864SY/VMWytcdkmKa83ZNiqfzne1yf1LtDi1FhIL/HCOgcWVs0Wiq4RM4sXjqMVv16prJdnVpLO4EUAVeIT0Dh6spmjiwnGSuNnImkGKTtg70nFIKCWitEifP/yJ29v54OAluCINnRuILlA84s9xsJdcGz+uAw6mdTiEau5NZ0z0iQMMBmpes0JMKoORf6m0mauo3AIWwM9Fnrj7XcgkQ7fkTnQfMuYG2iyBVJiE6phTUKUkBwxnYEsOUXxU9xlu2Z2OHm6het0yqj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 12:29:18.4454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8d0dc5-c74e-46d6-80f9-08ded76c5f30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22641-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,cornelisnetworks.com,amazon.com,gmail.com,mellanox.com,nvidia.com];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:netao@nvidia.com,m:markzhang@nvidia.com,m:markz@mellanox.com,m:majd@mellanox.com,m:yishaih@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE2C36ED8AC

From: Patrisious Haddad <phaddad@nvidia.com>

When accessing a CQ via the netlink path the only synchronization
mechanism for the said CQ is rdma_restrack_get().
Currently, rdma_restrack_del() is invoked at the end of
ib_free_cq(), which is too late, since by that point
vendor-specific resources associated with the CQ might already be
freed. This can leave a short window where the CQ remains accessible
through restrack, leading to a potential use-after-free.

Fix this by moving the rdma_restrack_del() call to be before the freeing
of the vendor-specific resources ensuring that the CQ is removed from
restrack before its internal resources are released.
This guarantees that no new users hold references to a CQ that is in
the process of destruction.

Fixes: 43d781b9fa56 ("RDMA: Allow fail of destroy CQ")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/cq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 3d7b6cddd131c4ed07082719fc9e3b4bfdb51459..1379808e1404096654e8dc73a11f90d939910e54 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -327,6 +327,7 @@ void ib_free_cq(struct ib_cq *cq)
 	if (WARN_ON_ONCE(cq->cqe_used))
 		return;
 
+	rdma_restrack_del(&cq->res);
 	if (cq->device->ops.pre_destroy_cq) {
 		ret = cq->device->ops.pre_destroy_cq(cq);
 		WARN_ONCE(ret, "Disable of kernel CQ shouldn't fail");
@@ -353,7 +354,6 @@ void ib_free_cq(struct ib_cq *cq)
 	else
 		ret = cq->device->ops.destroy_cq(cq, NULL);
 	WARN_ONCE(ret, "Destroy of kernel CQ shouldn't fail");
-	rdma_restrack_del(&cq->res);
 	kfree(cq->wc);
 	kfree(cq);
 }

-- 
2.49.0


