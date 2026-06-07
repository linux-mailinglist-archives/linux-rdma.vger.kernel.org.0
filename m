Return-Path: <linux-rdma+bounces-21931-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WniZE8G2JWpeKwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21931-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 20:21:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6D065139A
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 20:21:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=DIeIrju8;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21931-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21931-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4296F303CD29
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jun 2026 18:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D6813FEE;
	Sun,  7 Jun 2026 18:19:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B637315D29;
	Sun,  7 Jun 2026 18:19:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780856347; cv=fail; b=lJLZ5IQbmnIG1fFpm163Gb1YTsVt4F60ZJsmFqmLlijMHJX7MRoyLLzJt9ITJL5Vg4+PC38WNvw0mFUkn1j2uzSwsQOcf1ykX7FD6PkUpd8nNzia/Y6mDbqnppUXv/ehZ5//0JzqWtSJ38apnOggRiwKdR2R0aCQDGV0+Q9v+3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780856347; c=relaxed/simple;
	bh=+IiPZ0W0g3Ut3NCStxUG3Du9iuwFzGgi29mSnA0z1h4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZAAdUdDaipK9qMgU3uNs2Jvq/A7kAPVWE83xe/yEkhNvd8ecpntj4jSmz/2bGX4CO9YUQYGP2DEoehcGhLGJGF13tLb6jtHFwuh5JmL1Mn9pLEAVNSLk8ghUwAhh3U8r+78a9SCbgIz+QnQoZk0Ia3zh7dos6HsWs+/im7TolYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DIeIrju8; arc=fail smtp.client-ip=52.101.43.30
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGriDWktSc5R4Vp7ZALtGvCKq8/jStOJv5wOczTR6tGaTEgTlCw5SHZvMG+xP0+1rglXp9wWG79oV/RIoHJ8XcNB8p8xC8sYrkRykSh7BXttLZhfk2GJD2m6SPsBnp9oIy+zikRKe+NyFH7HDwNSKsXbC7O4A2IwDCC8PZEt+JG6A6e0nHKYfhST84i/ZQpm4rG8GSUr5qvxGBFTDySgz1EDbkf88MJuMy0s89GZrSxPlPW61KXgwVCoOjZvZQaaVLXWSCG7Y+EsuP9MNN5m/DwBazSJoAifP3WXyJgI3rGAKgDecqg8Ub01YIy13oDzapz8RqqkKvOTEXActvTH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3WxwlUBizT0en+p/d6f8jldQiRxvGCVNK127b+Pf5Q=;
 b=QExyq03WOJi17gnKqUZ0hKDmxIUcpp7/WHarro8INA0O7qf74CqCoDtSDFvWFjIn9zbrDlkSZYrA9j3huSrr6mvxthDkY18dHiu1goWEnwbuu8f6xrRy9OUL8cv1wkNHr0jxlGmh8r8qa8YAgXlbyPQO6cF5axRB6e/zd7knOo485FTOSYizuoYcZTT3lTgph4yoG28+QoOmxSrrxP3UF83K7pf0KjMjcF5dsEevRjBED25KEqqNiV/FI3KRVBPeAbJ9B0BbgbGO02L7gdh91nsMAeGIXtC4q9ej6ZwGxP7yfr85docj9hiEKPHTCyWeYUpQqLgV97IhFwKOP5zBOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3WxwlUBizT0en+p/d6f8jldQiRxvGCVNK127b+Pf5Q=;
 b=DIeIrju84Ym1oWvWOFWQUMVR8vETTZ7Wf/rCawb1iuMQFgRacpx+NnJ+uWtFc1VRIT9YZQiiwE998XYAndb5I84BugJgF4k/PbltmRSeGK9t4YqZEOQX9Cp0zDncAU/ocAVEmwAgdHnGyx+g/YlM8qlaA9LS3LBNhwAQg1YfbFG1hciq8sSwBIZ1tRGtFMTa3BJ9aG+TZXpQv2LegM12uvyXJ0lXIfBEVkGRuzCMnkchg60c89NO0R/uMX1647tMHmWP5vmRxw/dKJo3m+KQBXnl/J9goCo9u4AbCe5pSA8xoO9dH2qnNwhtNeM1STr7k259fvIdz6ANJT7Q2xcQUQ==
Received: from SJ0PR03CA0276.namprd03.prod.outlook.com (2603:10b6:a03:39e::11)
 by BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 18:19:02 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::68) by SJ0PR03CA0276.outlook.office365.com
 (2603:10b6:a03:39e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.12 via Frontend Transport; Sun, 7
 Jun 2026 18:19:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Sun, 7 Jun 2026 18:19:01 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 11:18:53 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 11:18:52 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 7 Jun
 2026 11:18:49 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 7 Jun 2026 21:18:12 +0300
Subject: [PATCH rdma-next 5/6] RDMA/core: Fix potential use after free in
 ib_destroy_cq_user()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260607-restrack-uaf-fix-v1-5-d72e45eb76c2@nvidia.com>
References: <20260607-restrack-uaf-fix-v1-0-d72e45eb76c2@nvidia.com>
In-Reply-To: <20260607-restrack-uaf-fix-v1-0-d72e45eb76c2@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Maor Gottlieb <maorg@mellanox.com>, "Dennis
 Dalessandro" <dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Steve Wise <larrystevenwise@gmail.com>, Mark Bloch
	<markb@mellanox.com>, Mark Zhang <markzhang@nvidia.com>, Neta Ostrovsky
	<netao@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	"Michael Guralnik" <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780856308; l=2096;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=Q8CAjTX07uKKljXC1OQ7XgmIrYoxgRfRP1wBjIiCAec=;
 b=2xJ5kuaGVF8PJtbRGyaUx2Lv2QKLYcF8P93rE1ztXI6dnIzYG99eJ3bl6h6OVAQ4+CK38dOZa
 svReh5jJveaAKcnetMu0BCxuv+NZDjfInfhoRPDk6jUCN4B5U2ybnqr
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|BL1PR12MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f330ce-1ec6-4aea-e77f-08dec4c1403e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|22082099003|6133799003|921020|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	VLAhY//Gec5miHH2Xxg6PofWZJrFsM1wlnCReJBuAaibJyDr2NG+wLaaCgYur31Eu9CC6gdiJcZW5SlWCilKdISE0zSY4EmMvO/f9Dh94zHbHFPoD7oRGbPGbwAQyqlPGINwBy5UaKPSob1vaPyu5fmy84oQ2RH0EWucSU5nTcsiGsCVJz7j0BAYdGxLFjgPS+K032rF6JjDfrOweRKBQ0yUwm5A3tORH3keMDYlvEQclM4yy/mKmQmbED03i1nyly+sq7notprY1gtwWAbHRcow+IgVvuC4JiXm26+wiY+2AcWLF0LGnHTl0GriKgXDhrupN/eDFadUQAciEBPKebDd2HI6TKJ/ET4E/YhujhETl0kbLmKtra1/mPuWA77k/N+meDA1b1hqY00tdM6jzFfZ6sm75TZwP1OtVALUj2VViWWUzVsO0a6/0ppwrfB4uCALzuMpmwzjFz7K0LAAVvNZieb0WZAPmoS/KCX+1GvkfDFFQn46z97g8na9wU/p/VPARUzKGSZ4/WOyLVo0g5eYafdamHxy8eNLMHPtZYGgNKLCrn8S0YdSdxo74IjNiqzEvVF5wbeTXBMU1RnN2cTs9e2Rf3pAwoS3ktBkL7ArZTJ+YRO8TUJQanZjnsGB/lVGvnhqHJ/v4W+VlpDcrbULdi3IhRddhVOE37boAEjDLldiamMujkDPTqJjz8l2W1b5m8QUu894TuSegvfCDONFYUNpFlEh0xKte24Izt3Pgj1kYaRl0tSwikXIck1W82a4xtij49MGRW9q82GCzA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(22082099003)(6133799003)(921020)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MTov0Gf6fmaSHG8MdB0EtbL12IFecvkPUyyH41VaVNJQCaLI97W9VoCFBsKjp+4dp9nFToPn9ERSJI3WFGLw1wiIou7SJvdLbZTqmmsR5E3dFZUdugDK3so93Wl11AnRLQeEFSJebSuHfGCsK7HJ0B3ZwXwP/WH/Kmnmbi18pJ9hGd0ZyPrGUTgRxnFNeoU28DwmpPsWjKWqEW/BxZgDFV9GU9tPabq4x4trbmWJNgnsl+puKNyQCNLEU26i8AUS3Q3As9yDDp/nV611DOrIuSOwHDizG0wO14FYen7OyEH7lEiFDvlC9V9gihIz3qP4dvMuNAiWmCkkFqqsjMSJ5RRZxq7GiO/gmAwfiSzWTKhD5kvM3G6k4TX9SZ+a8gQ1UYf7FnwCWtVFqVebEA4RZkARpgcjJldoLlht69KZkt9/ITrJCphF/Yx8ltmKGp7d
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 18:19:01.8439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f330ce-1ec6-4aea-e77f-08dec4c1403e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21931-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:cmeiohas@nvidia.com,m:maorg@mellanox.com,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:markzhang@nvidia.com,m:netao@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,mellanox.com,cornelisnetworks.com,amazon.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email];
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
X-Rspamd-Queue-Id: 9A6D065139A

From: Patrisious Haddad <phaddad@nvidia.com>

When accessing a CQ via the netlink path the only synchronization
mechanism for the said CQ is rdma_restrack_get().
Currently, rdma_restrack_del() is invoked at the end of
ib_destroy_cq_user(), which is too late, since by that point
vendor-specific resources associated with the CQ might already be
freed. This can leave a short window where the CQ remains accessible
through restrack, leading to a potential use-after-free.

Fix this by moving the rdma_restrack_begin_del() call to the start of
ib_destroy_cq_user(), ensuring that the CQ is removed from restrack
before its internal resources are released. This guarantees that no new
users hold references to a CQ that is in the process of destruction.

In addition, this change preserves the intended asymmetric behavior
between create and destroy routines: resources are added to
restrack at the end of successful creation, and hence shall be removed
from the restrack first thing during the destruction flow, which keeps
the lifecycle management consistent and predictable.

Fixes: 08f294a1524b ("RDMA/core: Add resource tracking for create and destroy CQs")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 8bd39cfcf41bce3a20cfbc41be6f51a1f7f95a8a..bca0e48f6805e87554e77139ce6812d6b7236802 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2250,11 +2250,15 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 	if (atomic_read(&cq->usecnt))
 		return -EBUSY;
 
+	rdma_restrack_begin_del(&cq->res);
+
 	ret = cq->device->ops.destroy_cq(cq, udata);
-	if (ret)
+	if (ret) {
+		rdma_restrack_abort_del(&cq->res);
 		return ret;
+	}
 
-	rdma_restrack_del(&cq->res);
+	rdma_restrack_commit_del(&cq->res);
 	kfree(cq);
 	return ret;
 }

-- 
2.49.0


