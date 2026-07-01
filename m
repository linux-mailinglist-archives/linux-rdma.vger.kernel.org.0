Return-Path: <linux-rdma+bounces-22642-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fuIkGkQMRWps5woAu9opvQ
	(envelope-from <linux-rdma+bounces-22642-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 14:47:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBFC6ED8AF
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 14:46:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=tfEKpNOp;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22642-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22642-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CD4B3375F30
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 12:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01090496918;
	Wed,  1 Jul 2026 12:29:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012010.outbound.protection.outlook.com [40.107.200.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDDB4968F9;
	Wed,  1 Jul 2026 12:29:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908972; cv=fail; b=rYC2lKlY052bsYm5SM3PINMUM/IBxvs7YVmmPd1XqU+gY8QwCAl8qdD8k00UwHJxZMbDrlT7oUIdGNk8D5ok9BLwImCYU36cRnQJYYMWgB/Fqbd8tDQ0/bOOJFT1GuBGbNFz9XT3BdqnmXG2NdbNyzNjtJyM3VaSGOqbEjJT26o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908972; c=relaxed/simple;
	bh=hA2VJL3RZwKxjNTnbiXcxJeYvN4ELggcsOWBeNCT0vs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ieQSuUsVI+3BXcngyO+ZwZiON+Kg7o6rBJmxEb+62cng7r6cMO2C2NdNfjoq6EtQKSPkzZSzMEIVxQps+1iwgV+aSn1pyVMXRoIpk1hWODMR2vzR1b6yDAky8Kw4a5NJEqJVxo00oqGwybPkOjNaJ5wyyLL2MnKGvGNwq4qQ+b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tfEKpNOp; arc=fail smtp.client-ip=40.107.200.10
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjAsquXixWdEq/42rqmbQYmHuXAHAbgAFfH9KnS6XSJMrdID50Q9qYc0IKppe7bFDm9Pn790NizZ1BRbvefjquc6+MY3C0/kILBj9l1DUaaCuvqZ9Bfpht1CM15qppd3eVRCIgdZ0eByV9jxzBBPlkXjlrsfAyckLSQLAjGmbAzfMZoVUAwknK62pE++N0GaPDyh2AaVr0VwIGD0vjzRlcHt4xQb4vxH1XIoQIlrmcH7qJ66gR0HIzbrKONlJgrciobmDl9SXWOfXVSa5KGT9NMdgnUuOyAE+TZh2wSfBMtlHTmwUkkxWxmKISyX+HU3b0oqM2a0h95PlQDJe0TRXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhyXlNpxtutvAXD8ugD9MHCzHPZTE8kCEVlPnR6VyuA=;
 b=TT71URxaiXZbFYRLkQsmW7Bs+J6Dv/Ix7Sk2Lz12DOZQqxnawqp1Jv0nY0Lvtdxj8cVpMp2H+gx3NX4ulynMhOwuzsf+l1UOtcH/QU7HEH+uza49QY7xY8FmvivxN5wodj4HIn97M+TCD7Z/Rm6vDQ2/RfFgsZl9CWZ9kuB7vFXJ5uMmStn9Tb4mxWK3WhOT0+owCOCvbRKd6w3OLTvFu9JPiFXggYvUbDmWyr/SDVHQsc0vWvEaIxsxZhQ0qEVew6jYw5ul/xrxz/PtdibCCcQXEvVW8Dsc+XxtsqB5FW4MlnZR0Ug6eA6ZAlOOSPQHAJxIxz5sglaLAZwdHj9lfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhyXlNpxtutvAXD8ugD9MHCzHPZTE8kCEVlPnR6VyuA=;
 b=tfEKpNOprSxYh8TQi3a0Yhc7lLuxB58Xw/yFENATqWDdwKgPkG//kkmiIyR1LmMFjtiAdylSn0J2bb68Tf/CxUqeZ1ST7cADsCEGw0HWdKnKLx1MwOoVqRpQI68ktNu3f4frRdp+jdjB7KKKDgYRfLMp+IAx0PxA31RblYNMrnsoJhnLW605799DkPTcF7q6+N2CAq0KF2KmwsWf5Usx0GhX9M/3jrY0bHvbkOLLfdT8jsSaXRizfhUCmm9sRnBxKagi09zoKJWZAPH1E+DmJ+SI1tVPRK3Fe+/Pg9j73b7mWm5LG5PmurVE1IUZYWUY19gtSgYWS2Mz/6Om5QpYCQ==
Received: from BN9PR03CA0136.namprd03.prod.outlook.com (2603:10b6:408:fe::21)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 12:29:25 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::2e) by BN9PR03CA0136.outlook.office365.com
 (2603:10b6:408:fe::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 12:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 12:29:24 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 1 Jul
 2026 05:29:09 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Jul 2026 05:29:09 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Jul
 2026 05:29:05 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Wed, 1 Jul 2026 15:28:21 +0300
Subject: [PATCH rdma-next 7/8] RDMA/core: Fix potential use after free in
 uverbs_free_dmah()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260701-restrack-uaf-fix-resub-v1-7-c660cda4df2a@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782908915; l=2177;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=Eg9C505NCnlykfgzHCbIan3jypwLn/hzfWIj6xB190s=;
 b=PrtYCy3Y+8hjfgU9+Kic80e5IXcFwhfY06pGLWsuWxIN1z/uJ2Wby3uuHxA2jCYgJPKqJD3ij
 fYIvhb7R/ehD6hFdm6mRAxdJRxtlsBqsA+bZgXp121vJmKSMea5BJe6
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f2e900-6ecf-45d2-33c7-08ded76c62ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|6133799003|5023799004|56012099006|11063799006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9030kBdxKDyUn5E/Si37Rmg2FggDl//SrUjlNLE45+tMGSW0gH+kwnaZ5wqcQcG8oq3rULU4yoD1isXQqXIHaWpH+AOguea9HhUWKCZktvYdM4NpBAg6XqrxAXlBxf13cM5QxuQj8We0yTFiAI8rH9FDkChkQfkvFcB4jFytK+X6dqmzjYjTMNVDqRiK5Jvw483iLA4OzDSY4ckHd2OPVnsPd3dif+rivBxkE5O9yVJir9HY5AoZlSDeMiPaaaP8sPtS3Q8+thMIvfVRKXMTr3zEN0PsqJbg6kC3JAmL7hhAlLLsA+Qsv2sEFedvJPR1ajFHwINPpu/kH+FVGnTDlL+NZiKV+g2tRe2VV0F5lVn6F+Aiej5xa93HdJ/cBIlC4sD7Vt2NLEfILtkcKRiOhVhbcwpJFS/5rcezEjoKEjn7fxjCIoX92DNtWimCl0wh7ObkccSXwYtd2jQEzNg9SXA/eR7IIGA/Ln95cV3Yc09+AVYfbHqIbmWyAWz9QJXce+RVijJIKHKTZ+vNcghPNgkjx9EjncbihYm8BM6+x8S06k89HPxgeEEEQ/djnt0r2AA3RcA5bMJe6AVsMQlo9ezwwqTttCogXh4a7/Yp1foEn1GKiNWAMqO4vuTb3oiHn6uxQpvaNVFCpxzo9FxdkDiM7mjTgkPzRRuaMjyK7C5p21q3YfKb9VJkLMmsHjJG0ogubow+T7CGLw2LJXrncsp2Uc8nLiFULLl0Tb9t3kWQbuj/2Fasuv68Z5pyTz+c
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(6133799003)(5023799004)(56012099006)(11063799006)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wJdQ3ovw3FsaxbwvDQyZcXt+0RRUWpfwj2bc0kp9fncLXebRIMWq61XxeQPndvsUzhQelaTQM2KgRbv4nlhFi9pCePhKN8TYXQjjknSfWIoJDm53kXq6emDeaPRMWzB26y6CGoYOCp6HVE3g4wck10YYRApDmb6gUEDgo7ha07rtwmWdNJ9uwi8aDdQ9YHn11vpbG0C2oMYa6SE7Xe6qP0F4DuknVwqVe/2t9jPwf7iDVA1MecVIz/HVUPDouSbpK/DiLrH34QZ7ymvxN5C5rUNtfopqT+hEwhkt7oXBbqw7tNLSmDyakFy3KJRf9xgKtOLlCzO6OxypmKDYfsGAK37q0yFKnbpmpAYL9ynGsTOdaZ6hfifYqNbl9/qMZndba81su1sY17h8KqOWtvxssCHBkhjvAZJCNe404ZYZSjjD64+kpGjzf/1lewfqCzEl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 12:29:24.8604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f2e900-6ecf-45d2-33c7-08ded76c62ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069
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
	TAGGED_FROM(0.00)[bounces-22642-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: BEBFC6ED8AF

From: Patrisious Haddad <phaddad@nvidia.com>

When accessing a dmah via the netlink path the only synchronization
mechanism for the said dmah is rdma_restrack_get().
Currently, rdma_restrack_del() is invoked at the end of
uverbs_free_dmah(), which is too late, since by that point
vendor-specific resources associated with the dmah might already be
freed. This can leave a short window where the dmah remains accessible
through restrack, leading to a potential use-after-free.

Fix this by moving the rdma_restrack_begin_del() call to the start of
uverbs_free_dmah(), ensuring that the dmah is removed from restrack
before its internal resources are released. This guarantees that no new
users hold references to a dmah that is in the process of destruction.

In addition, this change preserves the intended inverted order
between create and destroy routines: resources are added to
restrack at the end of successful creation, and hence shall be removed
from the restrack first thing during the destruction flow, which keeps
the lifecycle management consistent and predictable.

Fixes: d83edab562a4 ("RDMA/core: Introduce a DMAH object and its alloc/free APIs")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/uverbs_std_types_dmah.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_dmah.c b/drivers/infiniband/core/uverbs_std_types_dmah.c
index 97101e0938263d114d6c1e398895bb8335915202..9873ab49a60132ce32891b96909c1dbfc383fe60 100644
--- a/drivers/infiniband/core/uverbs_std_types_dmah.c
+++ b/drivers/infiniband/core/uverbs_std_types_dmah.c
@@ -18,11 +18,14 @@ static int uverbs_free_dmah(struct ib_uobject *uobject,
 	if (atomic_read(&dmah->usecnt))
 		return -EBUSY;
 
+	rdma_restrack_begin_del(&dmah->res);
 	ret = dmah->device->ops.dealloc_dmah(dmah, attrs);
-	if (ret)
+	if (ret) {
+		rdma_restrack_abort_del(&dmah->res);
 		return ret;
+	}
 
-	rdma_restrack_del(&dmah->res);
+	rdma_restrack_commit_del(&dmah->res);
 	kfree(dmah);
 	return 0;
 }

-- 
2.49.0


