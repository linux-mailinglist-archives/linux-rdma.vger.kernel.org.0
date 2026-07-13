Return-Path: <linux-rdma+bounces-23141-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IL4xAJYGVWpTjAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23141-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:39:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8799974D24B
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:39:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=NAEyUTMK;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23141-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23141-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4EC63300F756
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 15:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D583BF676;
	Mon, 13 Jul 2026 15:38:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BF73DF00B;
	Mon, 13 Jul 2026 15:38:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957132; cv=fail; b=g+PL92ApI4TYMudq+EK7XhatF9verx61DGKJJx0tzGULZheDhunGrGgmv9NA+cYjhVmLx2NXwEq8iCbAZi47epEYup6qhAwmgCuQTYjvcZEPkYip0vn6SXkYw7JYjzIu/JCf4p0oBt0RDShnp4oUvfDvzlpUpl5gZ/nOrhraUHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957132; c=relaxed/simple;
	bh=eDMhseWuOEgZ+n+3gA6lnopUnT0yII4WZ2zjPykid2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=l6q2yjyyD1+akc3Pz2a7hXlG0dRGwcW6NPoln+VqHfFyRyn6sMj6H+7m1eYZxnYTc6ZOOmmxHA2n4ok+Cbq5y3GJtULqwyOSb0AmyqU4Ngnhj+cFsGwOr7NYvjIauW81qSiWpuNZeJcwc09dFA3uN4QjaHA4VzaAjHy6WEBFaEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NAEyUTMK; arc=fail smtp.client-ip=52.101.56.50
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVS/EaAf9MQZEqlHExkiJMy5MglW+6sWP+NwrCk8CodHYP0zE3okAdnbDbpfogvvSHRM395I+Owfzgp+zsRzd5aKjQh4wYoXMIpO+dobqBoN+HphOFuLU+JDCEPsT3cq5W/qdMImOl8wo+op3SlF4LV0rD2doPfhZ94Ew8k7fC3LKYm7+IcTjo2xg+WGTyh9aKb+1rJqqHrUnqQm/U8TFyfBD1qOP6fprRzzIW7sfrhe6nOUickVHuHk/N0mClO2iKfkO3KGaPexHK7uzPYAvJPjKTyONnBIa3dLW1NEFW1uJKsa24m9ofghng3iYMTypHYR81MrHOXUeGkXZ2CwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSsZlEr4sftCZO0An4cBC6NS6aCPmOAVGQFKHHs2o6k=;
 b=q9xZI95mgSztf7qAEx11jq3kTj+WEPlgirgLTyJo5DSITBkszeLknQjwcjGMXAqGy9LL38z/iXfB3tANdJ/FNMKMrRWPEEwkd9q9iLNAcoo9V+8ZhghD2Dv+dmppS6TccmXs/+BuXFKjVptGwsdQ6xrEeORIIWK6UoQHwZmHTJxGtO8HhlWPJy7MxBHNZHeiJvJU10vi8pRDm3b0650lCEx2VPfmhlr4sFgSP6hiIZMZ3dvXUMgOtWm8fia+BpPjPfX1afeKkGprTXnoCrSakAFwhKn0jyL0gmRa8+yf0f6T9ibb/iI4bjB8THeZcXV/IB4h8jUizMbExlsARl86uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSsZlEr4sftCZO0An4cBC6NS6aCPmOAVGQFKHHs2o6k=;
 b=NAEyUTMKSdpuElGSxjDCxB7TgT2CTdCHTHOLJJPlaCw5B5+56SXVsYZYD+dV0uzm8a4YQMU9QdMUgHP/DTxWJ/+PwnTbfOinAliaTUU8oMjg0UlqmEHV9soBdII17AJcL+6b0jr5TFBThH93/ySXdvOXnpXJmlIhL5NGyf99aW2Vq/xyxbBcIhq4f76xVhfNCfP13x/fwCFzttz6yJ2+5p/yMr5S/7AGRPo5kOOp3ymN4s3F3LOBSuTpRFOXQkiyNTT8wFM39P7iaUWjo1euzyC34j8dOo8RZfxK6hN+RSyAsjPyzHlgIurcTRqMom5RsVrLiSW4YRdotHUj9o5XVA==
Received: from BN8PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:d4::19)
 by CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 15:38:46 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:408:d4:cafe::1f) by BN8PR04CA0045.outlook.office365.com
 (2603:10b6:408:d4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 15:38:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 15:38:44 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 08:38:24 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 08:38:23 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 13
 Jul 2026 08:38:19 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 13 Jul 2026 18:38:02 +0300
Subject: [PATCH rdma-next v2 3/8] RDMA/core: Fix potential use after free
 in ib_destroy_cq_user()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260713-restrack-uaf-fix-resub-v2-3-bbe8bb270d51@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783957085; l=2091;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=59+xBgMrEC1iEA9mz6DuYykfQTNa0ycMh8hgh3/0epM=;
 b=WFrGV9/TPdD4K2yDMu2FSTd7LMYbss5lyJKxBIoI33wPaaFfm5yHzaxgmYKmdzinKJ1DepJ28
 44iuc1EG7+MDXqQyPHn+hIWWePvUqERFSP/5aEg21Wb4VkwNl1bHQNg
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: a227a14e-71ef-4328-4f01-08dee0f4d28e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|921020|18002099003|22082099003|6133799003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	uM3kGmJZDjMS7iBujaC2XenpnKQQlLEamyYhtvzqMdgcUmMe43P+QwewPEm73flLGWH+zB0nu7Xe0x11oUsaPzOOZ9PdtyUi87aWfPmJmd0Og5yrVHEXDAO7M/0cHOvTDLQSs9j8FUJl5GStf5F07wElsfpNM00LDBXMlE+2jHx7HbQQCsPS/BaJn1gSriafiI8xGtdigA5zyxqcrlup9TyYR+tcG5mMnRkAKe7Hv38y8qbp/8T7XEAqoRvYsdbdo0ky1ZgFyo6zQyms85LkYkkYtdxgy/pFnkZxAzyZNB2eqPMtbhyadklUzMywd5CMtmx943uBr0kirEtwpQisUjRzoHii4NqeBU/joxmoJYGuFonxt4wpodwiLwQA0h2Vhapfq06+bPcR/1c9XvXjMq7/r/5QJxGrYFM4D2seDUpwF3pAScpqmm8oHsdZsMQvtxUrAwextBYijRo/EixxydkiS/LaCB460WGhwHCaMl6la0DjqniBzheFdvmILnshxUqxJeRuGrzp91hEVw3e0SYjQArTX3inCxY1V07wIiofp4Z2S5Gs3SkNiPZbeUoZz/XbCerWwY2fF3WhyNZ9A+na88kBifgRAfGUf+3BKWfQkoILGsxdrlqJtEKhn4DupcpIrSIHfY3uEuJjA+SUUQDQn73+O2IDrKiTNAgAbbIFnmg3ilt4OhXOsDGRcu37TDB/mlHzF1HkikINcPva37/Jc4fpmgYlHvgTkepi7aT1JsFYB7mqxbnrw9RVAL4P
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(921020)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/SbThsMu0WQKbC1ZktgxwssBXui0ISLND3RkRCHVIyHoH1L++HvbgphP7FCfL+itEy0atxJFbtjjjC+HFDxAvSdCY6qLiU3TUiR9SBv0yIOW0jEhOd7gGEDpwNMclrL5UilRMkuCCPu6gLBHTrxj0G2Z9wpnDfhdeYe4Sdl7C+4miuYF5EUz7EoxpniXHCBVsS3adZNWBud4RGPEhFQ9ZXjTGYBNGYtcOtwZKZWacKTWacnYVDMSH4pEU5xsJuPSLuiEE9unJ3iEJiLlz+WQlzBSoEZYLpYM4K55TpvDlpeUN8Zc2HQYnAXDXlofP6xViCDVS1H/x2IKLuXevvuFupH611VrcRPkJ15+1/DzAKodby4vuGyl5ttjKXNA8fwKDBdcp2TSENB5uGA4SkboI5bJLEHeVUbg/3y8LiiRISdG5vdx2DffK28qoijm3qQQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 15:38:44.0358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a227a14e-71ef-4328-4f01-08dee0f4d28e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23141-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8799974D24B

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

In addition, this change preserves the intended inverted order
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
index 7abb89a4e6a019b965d36446d64609ed2c33d1c0..568cb71da726a61997149e92aa570e0bcb76926c 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2247,11 +2247,15 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
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


