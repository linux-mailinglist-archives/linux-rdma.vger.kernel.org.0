Return-Path: <linux-rdma+bounces-22636-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kdE/DxUMRWpO5woAu9opvQ
	(envelope-from <linux-rdma+bounces-22636-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 14:46:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 875356ED87B
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 14:46:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=bWtIPk7s;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22636-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22636-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B33D335415F
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 12:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ED548BD4D;
	Wed,  1 Jul 2026 12:29:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010025.outbound.protection.outlook.com [52.101.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F7748C402;
	Wed,  1 Jul 2026 12:29:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908950; cv=fail; b=mEY2fgOE8h7NzyqWSJJpbCisRHFTeKCKIYROk8+6x95kFz37N5htnL7JQCXs2eldJZ56/uEKxo2fWIRaorVWXGV+59ZAq59qQU8R+FhpUnEKfkt31q9tASbcnOmzHpmCwuRXf0iyO8HEbMG913d10AsFVHz6tLgVapd7j2LsMt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908950; c=relaxed/simple;
	bh=aElQkit2QWbljQVuyw1HtPwF3Swjb/4gjE6ipQXp/oY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EJXc1MQM3Xdz6X9AsFgZnA3ifNhQJKurkgMDHu8KVEIrKhY20lkCVMYA2xzdF3g0hohpQddsSUQ5xDZYyjiiWa52Tkl+SPGv/+ZJlio3pnMt06lcIghcGW0CBVEC2+O1YxqZEUJqNXYPUG3FN/pJRvwvRif5PvX3947F/Sthrfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bWtIPk7s; arc=fail smtp.client-ip=52.101.201.25
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nq1iB0KrQJcA0ghtvlLxSgL5S7Nqf+giQNshaSddQ9/jun+KVUrdJF9l4yko1GMdMX/b9GLX9nw8g8jDwm/h2un7c/1mDUdCrLgpV8YdkKoxbhLxExyXnjjyV7fDuCRv7BMRm9GI4TCbMH92ErwbLBHoqHqlF9YsxqnFPxOq7/KeLdru656PV3bn1XVXfQjuWq8k+EysN4So6AbdoWehXhVeQPVItvClwmwEZqoOO+pCkD3FJOMyneYeY0x/HhIFvoR61TJG5BSV/ckJujkIP2cLCz7yG3AbghqL9MYJq+4uKwpDi0EN/DYhqNsmD0BuddekEs9Gqf5iph++K6monA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WjfHqYAFGtMSOHhYmq5uLlo+oTzXQOUhGug8boAhqg=;
 b=s5UUpar4yK6sUXT1Y/qs8PfOjIbZX9kfTD1TvCgQi8XBR5R9SBxGdcUTpujuhVxvTP3Dz0/a7EDxfPlj3HZor/c29XUKoZZyFPsBCJQcvkqGo92NQ7BO66hY2t9inwYcJ4m6wOHQjgGlIayn/ukAUZpEzpYP2iPZA2w+LAxuWfj4kd0vdu/CyPXzJZdIHPHRHEX2m9lH6VtQpFFHkYCjhp8juGSs/YygZ+K0c4RRVNnQdC3Z6WFN2nS4pO2YiEfxXdctn4QD5RATzj2TKWSRDOWXK+Fs4Qo/oe+z/bDZWPPTunZtcsYc1NWmzPPRWvweciQdjPmIIUGL9nU2Q0X5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WjfHqYAFGtMSOHhYmq5uLlo+oTzXQOUhGug8boAhqg=;
 b=bWtIPk7sTxiYJSisq14DtTesvzJPg1GsK+p1wt9e4Jh61mrzPCDYmgbghUb95jGgGzLdI1vPbsklraDk+d04yZ1tc4m6u3wDf8nRBmzEMBBtdASKmM0reNxDBMApt8c7F4lQn4BaD0t7H3yXK2iakqnyDWY8/ddE+Uv9iMw8vY/a8K11NJ0C747kdKpqeoYPuvQ8VUvfYhxkX//8YMx0z1r1x8uQXum5Jm7FA55wTafjKQ9iObFCKcPWjxJj8RwnL13MlG7vPvKOojgg62hF2k5ceDV5p5UGzcqDIPukr78nFOjwHE55I3s4UVYk9KWkNNrqKT6v3J54W/spYgq49Q==
Received: from BN0PR04CA0172.namprd04.prod.outlook.com (2603:10b6:408:eb::27)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Wed, 1 Jul 2026 12:28:57 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:408:eb:cafe::21) by BN0PR04CA0172.outlook.office365.com
 (2603:10b6:408:eb::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 12:28:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 12:28:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 05:28:44 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Jul 2026 05:28:43 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Jul
 2026 05:28:39 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Wed, 1 Jul 2026 15:28:15 +0300
Subject: [PATCH rdma-next 1/8] RDMA/core: Add
 rdma_restrack_begin/abort/commit_del() operations
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260701-restrack-uaf-fix-resub-v1-1-c660cda4df2a@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782908915; l=8238;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=5M8+yMd+ylBKuLnZ65J3B5Dj9NCF06u1XGI4QiTdPOA=;
 b=xSKlF3gLUMLmHLp1U0xKHE45pFG7ci3ZcbMbSe+9vY7PCl1jKhYM3W68eHEIEOCx3IrwR/GtZ
 QUUvI0b58KtBucWpyH7/RutlyziZ38mcN8KpwEzj6RISLGOgy66dhBX
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ec2037-2afd-4778-c323-08ded76c529c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|6133799003|921020|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UdJI7HFIf/ozmkR+/GHVoxE4GfNr+HJiRS9LWbm0pYzB5Gztpv9v6JfpxKvPDJqkyl7LW1v4sEb9uH1f+19EoH3rHNbq4f4KeIzSSeT6fsBagei86Et6wNEFR1ewtGRBopsVKtKjTGWgvEkv3SlYKBXu7TwGEnf8OFbVYc7SEOm4VMczOaJ+ikwVyqI1bUPOnVHyuBzJN+wpusbz3lGSezAltkkktk96vAotHCieKEOTTo7EwIgvInEpCnofMsG4hxn5ekD+xOeu1BRoihnIh/yK+YQyJw5CB89EctAP/SiEM3eHdAoDhgZJtGpNpoGSV3vI166viVxt3pbJKInSKcfJcS0oaOgbjC2+wrmkmyOHHvxrA8Pn06BnuzH+gq8zC2aTkdOM502Tl3A1+sEDBVtnYjAwDF9cVbhBcdpm/Pu74o7grb0P5NmcvGy/9kXhnDwcy0VhTo2PRo3R2IeB8EpzzXMWGN1B+m9Sw5ZA1IwFbBvLaflZzinJTn9IO157cqj7/JQzk7gEaj46X1Ba4jAXlQZZSesYi3uoyhw0nNVxq/Edosm2drFoIpSYC4uCB7vvcDkMXAUpbgaXnQR7D+8axvCUjjl1sWy+3mUenE1HElDRe/r7MdWozE3OboNTDm1pgoAjIc4VQyY61FP+SuqIgiVlqQtr74hUUoJZF2BCdgGW+EXF8aVwPv+sikxvhAvNIpqLBZabYvYy85nX4HD/DbHm5UnjokQ/tPFtCF5HBZ63s0l7WvheMTLhvw7N
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(6133799003)(921020)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gkhc9896xbkyd7Q3t3DyMdq136dAgALYemBA9+5z406kdKCoxi+AUwE9ScoE0dBTYBwEsENmlwN4st1ATwcvhfkjHNQ8G+2rduvll8l0LfyF+YfD6QYa1V2y0iKxRMePZKnKbJiZsdSws4KDZq9urNm1rUttzznM/S2siX57uOpbr1Y+BrsV55BPF7vomIKYvbmaodteXDmWLx52auUVEbpEJEi49yH8AvhVrcaijIeszwTlWEeCJ1SmCrygpLaWQyqWTnsRJnWKIAEIJ+tNpLz86NKWHCk5z2ai/rqvgxnkQ6JXSModhev11wE0j8YOAEiYmHYAU9/CFlFQEa9wna0dIamYAUUBv9oPaZVpEynj502cWznT4GPEMixEK5t0+FIzJ7F1JPNpD0GfRmcr9GQADKWem8MYxswVIID+UUr/lUtP/yFLP3x3X1d7chIQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 12:28:57.3782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ec2037-2afd-4778-c323-08ded76c529c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272
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
	TAGGED_FROM(0.00)[bounces-22636-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,cornelisnetworks.com,amazon.com,gmail.com,mellanox.com,nvidia.com];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:netao@nvidia.com,m:markzhang@nvidia.com,m:markz@mellanox.com,m:majd@mellanox.com,m:yishaih@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime];
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
X-Rspamd-Queue-Id: 875356ED87B

From: Patrisious Haddad <phaddad@nvidia.com>

Add rdma_restrack_abort_del(), rdma_restrack_begin_del() and
rdma_restrack_commit_del() functions to allow deleting a resource from
the xarray to effectively prevent future access to it and wait for all
current users to finish while preserving its index in the xarray to
allow to re-insert it if needed with guaranteed success.

This is a preparatory change for subsequent patches in the series
which will use these functions to fix the cleanup flow.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/restrack.c | 167 +++++++++++++++++++++++++++++--------
 drivers/infiniband/core/restrack.h |   3 +
 2 files changed, 137 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index cfee2071586c16e3dfc4e21e5d58f8488dfb277f..30d433ee79a042fe270c9ed2f47b0e2d4a388ff9 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -129,6 +129,40 @@ static void rdma_restrack_attach_task(struct rdma_restrack_entry *res,
 	res->user = true;
 }
 
+static struct rdma_restrack_root *res_to_rt(struct rdma_restrack_entry *res)
+{
+	struct ib_device *dev = res_to_dev(res);
+
+	if (WARN_ON(!dev))
+		return NULL;
+
+	return &dev->res[res->type];
+}
+
+static void restrack_drain_res(struct rdma_restrack_root *rt,
+			       struct rdma_restrack_entry *res)
+{
+	struct rdma_restrack_entry *old;
+
+	old = xa_cmpxchg(&rt->xa, res->id, res, XA_ZERO_ENTRY, GFP_KERNEL);
+	WARN_ON(old != res);
+
+	rdma_restrack_put(res);
+	wait_for_completion(&res->comp);
+}
+
+static void restrack_restore_res(struct rdma_restrack_root *rt,
+				 struct rdma_restrack_entry *res)
+{
+	struct rdma_restrack_entry *old;
+
+	reinit_completion(&res->comp);
+	kref_init(&res->kref);
+
+	old = xa_cmpxchg(&rt->xa, res->id, XA_ZERO_ENTRY, res, GFP_KERNEL);
+	WARN_ON(old);
+}
+
 /**
  * rdma_restrack_set_name() - set the task for this resource
  * @res:  resource entry
@@ -177,22 +211,23 @@ void rdma_restrack_new(struct rdma_restrack_entry *res,
 EXPORT_SYMBOL(rdma_restrack_new);
 
 /**
- * rdma_restrack_add() - add object to the resource tracking database
+ * rdma_restrack_add() - add object to the resource tracking database.
+ * If this resource reuses an ID of a resource that was already destroyed
+ * after calling rdma_restrack_begin() but didn't yet call
+ * rdma_restrack_commit_del() it can result in an untracked QP.
  * @res:  resource entry
  */
 void rdma_restrack_add(struct rdma_restrack_entry *res)
 {
-	struct ib_device *dev = res_to_dev(res);
 	struct rdma_restrack_root *rt;
 	int ret = 0;
 
-	if (!dev)
-		return;
-
 	if (res->no_track)
 		goto out;
 
-	rt = &dev->res[res->type];
+	rt = res_to_rt(res);
+	if (!rt)
+		return;
 
 	if (res->type == RDMA_RESTRACK_QP) {
 		/* Special case to ensure that LQPN points to right QP */
@@ -229,6 +264,32 @@ void rdma_restrack_add(struct rdma_restrack_entry *res)
 }
 EXPORT_SYMBOL(rdma_restrack_add);
 
+/**
+ * rdma_restrack_abort_del() - re-add object to the resource tracking database
+ * it can only be used after rdma_restrack_begin_del().
+ * @res:  resource entry
+ */
+void rdma_restrack_abort_del(struct rdma_restrack_entry *res)
+{
+	struct rdma_restrack_root *rt;
+
+	if (!res->valid)
+		return;
+
+	if (res->no_track) {
+		reinit_completion(&res->comp);
+		kref_init(&res->kref);
+		return;
+	}
+
+	rt = res_to_rt(res);
+	if (!rt)
+		return;
+
+	restrack_restore_res(rt, res);
+}
+EXPORT_SYMBOL(rdma_restrack_abort_del);
+
 int __must_check rdma_restrack_get(struct rdma_restrack_entry *res)
 {
 	return kref_get_unless_zero(&res->kref);
@@ -265,7 +326,7 @@ static void restrack_release(struct kref *kref)
 	struct rdma_restrack_entry *res;
 
 	res = container_of(kref, struct rdma_restrack_entry, kref);
-	if (res->task) {
+	if (res->task && !res->valid) {
 		put_task_struct(res->task);
 		res->task = NULL;
 	}
@@ -291,37 +352,20 @@ EXPORT_SYMBOL(rdma_restrack_put);
  */
 void rdma_restrack_sync(struct rdma_restrack_entry *res)
 {
-	struct rdma_restrack_entry *old;
 	struct rdma_restrack_root *rt;
-	struct task_struct *task;
-	struct ib_device *dev;
 
 	if (!res->valid || res->no_track)
 		return;
 
-	dev = res_to_dev(res);
-	if (WARN_ON(!dev))
+	rt = res_to_rt(res);
+	if (!rt)
 		return;
 
-	rt = &dev->res[res->type];
 	if (WARN_ON(xa_get_mark(&rt->xa, res->id, RESTRACK_DD)))
 		return;
 
-	old = xa_cmpxchg(&rt->xa, res->id, res, XA_ZERO_ENTRY, GFP_KERNEL);
-	if (WARN_ON(old != res))
-		return;
-
-	task = res->task;
-	if (task)
-		get_task_struct(task);
-	rdma_restrack_put(res);
-	wait_for_completion(&res->comp);
-	reinit_completion(&res->comp);
-	if (task)
-		res->task = task;
-	kref_init(&res->kref);
-
-	xa_cmpxchg(&rt->xa, res->id, XA_ZERO_ENTRY, res, GFP_KERNEL);
+	restrack_drain_res(rt, res);
+	restrack_restore_res(rt, res);
 }
 EXPORT_SYMBOL(rdma_restrack_sync);
 
@@ -333,7 +377,6 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
 {
 	struct rdma_restrack_entry *old;
 	struct rdma_restrack_root *rt;
-	struct ib_device *dev;
 
 	if (!res->valid) {
 		if (res->task) {
@@ -346,12 +389,10 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
 	if (res->no_track)
 		goto out;
 
-	dev = res_to_dev(res);
-	if (WARN_ON(!dev))
+	rt = res_to_rt(res);
+	if (!rt)
 		return;
 
-	rt = &dev->res[res->type];
-
 	old = xa_erase(&rt->xa, res->id);
 	WARN_ON(old != res);
 
@@ -359,5 +400,65 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
 	res->valid = false;
 	rdma_restrack_put(res);
 	wait_for_completion(&res->comp);
+	if (res->task) {
+		put_task_struct(res->task);
+		res->task = NULL;
+	}
 }
 EXPORT_SYMBOL(rdma_restrack_del);
+
+/**
+ * rdma_restrack_begin_del() - invalidate the object from the resource tracking
+ * database but preserve its index in the array.
+ * Since this preserves the index in the array until rdma_restrack_commit_del()
+ * is called, if rdma_restrack_add() is called in between with an old QP ID it
+ * can result in an untracked QP.
+ * @res:  resource entry
+ */
+void rdma_restrack_begin_del(struct rdma_restrack_entry *res)
+{
+	struct rdma_restrack_root *rt;
+
+	if (!res->valid)
+		return;
+
+	if (res->no_track) {
+		rdma_restrack_put(res);
+		wait_for_completion(&res->comp);
+		return;
+	}
+
+	rt = res_to_rt(res);
+	if (!rt)
+		return;
+
+	restrack_drain_res(rt, res);
+}
+EXPORT_SYMBOL(rdma_restrack_begin_del);
+
+/**
+ * rdma_restrack_commit_del() - delete object from the resource tracking
+ * database and free the task.
+ * @res:  resource entry
+ */
+void rdma_restrack_commit_del(struct rdma_restrack_entry *res)
+{
+	struct rdma_restrack_root *rt;
+
+	if (!res->valid || res->no_track)
+		goto out;
+
+	rt = res_to_rt(res);
+	if (!rt)
+		return;
+
+	xa_erase(&rt->xa, res->id);
+
+out:
+	res->valid = false;
+	if (res->task) {
+		put_task_struct(res->task);
+		res->task = NULL;
+	}
+}
+EXPORT_SYMBOL(rdma_restrack_commit_del);
diff --git a/drivers/infiniband/core/restrack.h b/drivers/infiniband/core/restrack.h
index 75b8d1005a984b21896e296ac6ace1415a90905f..2df78e084e107c517a2468982add74ce3562e5f2 100644
--- a/drivers/infiniband/core/restrack.h
+++ b/drivers/infiniband/core/restrack.h
@@ -26,8 +26,11 @@ struct rdma_restrack_root {
 int rdma_restrack_init(struct ib_device *dev);
 void rdma_restrack_clean(struct ib_device *dev);
 void rdma_restrack_add(struct rdma_restrack_entry *res);
+void rdma_restrack_abort_del(struct rdma_restrack_entry *res);
 void rdma_restrack_del(struct rdma_restrack_entry *res);
 void rdma_restrack_sync(struct rdma_restrack_entry *res);
+void rdma_restrack_begin_del(struct rdma_restrack_entry *res);
+void rdma_restrack_commit_del(struct rdma_restrack_entry *res);
 void rdma_restrack_new(struct rdma_restrack_entry *res,
 		       enum rdma_restrack_type type);
 void rdma_restrack_set_name(struct rdma_restrack_entry *res,

-- 
2.49.0


