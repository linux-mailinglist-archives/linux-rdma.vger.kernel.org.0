Return-Path: <linux-rdma+bounces-23145-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZWOAN8sHVWqVjAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23145-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:44:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C874874D32E
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:44:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="YcQ1Hnf/";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23145-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23145-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C76E830373B1
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E7B4279EA;
	Mon, 13 Jul 2026 15:39:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E456F3E00B5;
	Mon, 13 Jul 2026 15:39:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957143; cv=fail; b=JeIxxA920NuD0hqnxp1xXOI7uBvCrTF3WWD9vVMxNotdMShaqUNT+F6gtK+X7gFzayVJOq8w9ICTGZehOTE9KPoswuESrKRD8qbRpqWO7j/Z+8omDkORZsQBWHHKQPLm//wtgCOWQAbYUiaBFAMXmq2JjWc1J0Nbv4Jfz0wWtgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957143; c=relaxed/simple;
	bh=b53RpVl+1C8TTbny6KsUgXj3XNbPDLR/ZJmClX/3egs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cz7cjxXGpHq9NCUj/RUyf0bEvhKyRaRDqWgFBJ4x+yJSYLsCimRruBM6aMZqMfYiBmoXlgeSnGcN6aHIktgipn1jQBKOFkm1IRk7cIJrMISKge4DUwnxJDj2seUEazX8DaSOPQr8A6eN/cHfMeX0d2b31qh11p3q2ekukL4BPUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YcQ1Hnf/; arc=fail smtp.client-ip=52.101.46.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/AIsJgrZM0m79kqkll9ED/eD+B6vAycjlwmDzYeHaGS7d0coZMjeM+iIOdYs1pvsLWnKrZZEGAg1aoYGGs4ijxPN1dEjrosrnqN1nRRG3YdYTTSLHXRzENRUwncvi56uwZevxuqLXj/HFoEMTBo8va08iW5zSWzyevXNlXA7FYXkz5Vf6nxNOMZSQgVNomQNc3sFd/8NbxNaUMXR0+WO2FYp2ZaGc52KjDTdI6C2nhhJptB1h2s7DKXVFGeAkOx1UXs5skrkD9svNsVEhJShdp6j0QpFzmygpwO+N6kDnZtizUI10krFYDCWW/DB/ZOyREbf3lx7O2xHhuBg9DLWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beiZqJ/73+OyiMxfmnzvnXSZyEb8uZjZFfAVrMxnp5Q=;
 b=WafaW0iY1tHScj7AqzZx9NmJh7xUcxLwCXUu8qQJiJAYzIM1nnT3XMDgXixXzPGVLi0cQVhBMknwc52mzGx1/9EuxXYZGggCUyKqhYSMzpdFaL2xQXxnDqe/uTzlxa/Yfwc6FpORffXPmkrfvS3EqpJIbxC0MR+VSBPfIntyIUrrFRRXD0pHNJSRd4YOmbOx5mN24rwWrJ4zqCWdO5FFLssrM85VA6ahEieghohAysAkuHVqQaRztNyYYwtdlx1Bx9XNjUya3WO7mm0lAm1vR9lJOTXe+TAwo/61P0+qMdTBV0TmLrbZQaBZyQ3yAuKzMRzWgWY7KfoXuZilJ1hncg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beiZqJ/73+OyiMxfmnzvnXSZyEb8uZjZFfAVrMxnp5Q=;
 b=YcQ1Hnf/Ux1ZOVtSTODn3U6GWqlquAVY+tItIojf4RH/HbXRw9IVeztr6gPHd9XOasWKyYzAf4H2KTeklP7NMoEuSbj5/mgQfg6UcKBng3/8l/a8tkHQjZeFRwP/rp/F772PxIMsXqIGxXYgodzXa6a/tRD62u/zQQyJhqQpG7qi0SNlC017DRDdIef36+soKZbu98fApxQ3Izsax90pTwLrGa0Cd8eYng9HPteh0eAmQGheHOU4w0B7t3+ok3HiSKKur1S6A2lG5063utRBzo+1XAwKlrjUHrKc4n8u0UsQJjqaUVMLFysHbsKSt7inOHuIxB3RYo2np5DLjKKXoQ==
Received: from MW4PR03CA0033.namprd03.prod.outlook.com (2603:10b6:303:8e::8)
 by CHAPR12MB999250.namprd12.prod.outlook.com (2603:10b6:610:300::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 15:38:57 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::55) by MW4PR03CA0033.outlook.office365.com
 (2603:10b6:303:8e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 15:38:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 15:38:57 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 08:38:38 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 08:38:37 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 13
 Jul 2026 08:38:33 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 13 Jul 2026 18:38:05 +0300
Subject: [PATCH rdma-next v2 6/8] RDMA/core: Fix potential use after free
 in ib_free_cq()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260713-restrack-uaf-fix-resub-v2-6-bbe8bb270d51@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783957085; l=1814;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=HX23mOgsyaK+lgHvElNXf0sQuYVHYh+GHhlZjiNNlVw=;
 b=GgsSvbK6ANcSiwnG58t2GPF188CMDLGz1zR103d6fQz/rrvF1O9mRgXkuAWdRXpAdznV2rFsv
 zdiNLfr7e1nD42LL84Z5nCa5Tig7wqbvBVGTtNDXWmDoNDfTZcsvG4/
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|CHAPR12MB999250:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aad7b5a-94c9-47f6-66f5-08dee0f4da60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|22082099003|18002099003|921020|6133799003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	0japJunHpb/O95XRY8QJ35M27kQO7rCUzIucTEesle2J9X5hw/09AS9/kCOWqPKQMX3AJF3AiuJYPDoyhDo6r3KCxr91vLVcF7bKb0jXl568GJm5BPkRt6F4X0+Z4PyH2P7wEiGmmN6OvxZ2tOdFvjCSQNaNiLfWflF5MMQnBwgedoZv6GiswenSfMWgEoFtj15uim3XoBcmleH3FGvsCS3hVXgoWpVs+RNo/DUw/ttEF8gI/+okHQJ5TdVaPkYQmMbRSAk+TIC8xFA2EmqFSCFTqPGDap5WTHO0iU7Qojig0cOXWskTWBtIxSIqK5ztUDnhmxkuK1sBlZvfdu83dEgxM3tLKQl4jj3yUQpqRdA+4Hfj3iRHID/DKZgcU7LOolflBgJJkzoQdyyaa+dmKFk8rcJH7KLt5vwY8QppRBsfbrnYZDQrl4EE8gqJF4EH56ChAl1/92tVZdAi4fggVFS7WHcM7esND3CwFgFVeMPbRuC2I3fKbiCGYuBgYmLtO6+sN9MkkrRJPOSc67q9YRVvT6PBVMr1ahbv5YOdeMRjymJhfTFL0aa2NDhwSEI3EivNXb1vlzhwFhix0J195o1BCWh4PDC3SHxlfo+oBY+7kHdTVRMvByeJ4wuONKwBY4+rSv1mPf3oiTwW8IeZ5QAYydq43BckWL3vaa2WYT8VE7lfUeHDuw+A886Kxltwf2qd57oSxdlbX1WgYgMLD7Ki7AHeWcrUTab4IpnuRdKAHsI6jS5kuVYXjtLxnDZ8
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(921020)(6133799003)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	juQ0zRzEKl2ebGtjCeLra02q3RZtGMS3YbF/53Q42wmmNeJHWoNNB9PaZ5i882FZ/1fgD8W9fAGgCByifa7PFZPX2nAeEnWdtByH6j0f1CJ5TPipj1dMnIG3JeCPGOzwaAfXlNPn5gXwvNOeTye8ffd2SP5SLttenSqgjK1TJVwcXQwdc9h3DNsG65Sy3RTnw1u8WwRC6tNxZB2ya3Ki37x4p1RoJIkQti1DAIFycHc75MsMsGtrL0Z15yjPdCo/sfVIOa1kNKGua16telPmGkgHIBygDmkOe8wT83Yg1AP3Ckhfgl7b8xwttf+noufHI7uv+UH7gr8cIWhCqU5ufkzpNzbxpiaAYUhfBJS4sKbQZzGUDyCrbkzhKtAyQuvb+nlCst4bniUjIhdmkkgzK+ltMf2fe5HJftKlRAErWTnFxLZU0WR/vPTQ423sqpac
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 15:38:57.3306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aad7b5a-94c9-47f6-66f5-08dee0f4da60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999250
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23145-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C874874D32E

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


