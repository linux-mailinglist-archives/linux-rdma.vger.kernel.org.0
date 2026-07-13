Return-Path: <linux-rdma+bounces-23143-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xq2DLOsGVWptjAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23143-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:40:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D6074D2A8
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:40:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=OSwit6CY;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23143-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23143-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 071393042415
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 15:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E2B35202D;
	Mon, 13 Jul 2026 15:38:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013031.outbound.protection.outlook.com [40.93.196.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8C938D40D;
	Mon, 13 Jul 2026 15:38:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957137; cv=fail; b=V2cMFWGAZFQZ9VpraGi/cOqsCP9JEJvg4KBXe9TpoTI6PKVWwPxAsxI1aMXRXf0+Gftkdm6kRHdEuRS9bPxMipVzd3xrOnPVrWBXuqXzHBmuM33j51sYgjMa74jj9k/Y3scs7sgT1BZ2FEiWQuWqIq2q7JMW7ztXA5V1b8giw5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957137; c=relaxed/simple;
	bh=bKivjUzM0g23lOmBD116hSY8WJi3eYKFOeneDCEWtus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZQXqPGoOd56el+k2dsYfPQkX5FxbXuzPhbElxFDTTVwFyT2pzgYw9XtQKmjTr/3O3JCWw+KFqcZQCfFU3T9eTZbEQgm0cd2x60jHYTra1xPcCgzdgp7SBhXKB4d/5y0NDUHZaZ4onHaw2tu5nFQVoqT1hNv8JiwLxEQ/wptgUs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OSwit6CY; arc=fail smtp.client-ip=40.93.196.31
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doYnWE0bLMFvA/YkERfeT57vkH4luvlHQSXAfbAQ2FI7alZ0aomnRPZZ+UFcTPvUdji2kIwbEF9PzmJw9r/1Qn0FV3P/LDKsw/IWABhoCgH72SmH5IHJNJJR2M6CHe1MWD3KC0afLNyBt9KO/lsmB/tMVaf3QHzPCcEVuEywci9eV1LMevAbS4lhFa2DOX+y1IzHVhWMu9rcHSiSeiKydIgdSCSBgFERvtpy2hmgNyxT67WYigISEaXOaAeLw721zq8pQRTUokM2thz8Y1CQTbNRMT1I/Ilu0ayVhi9uHls6YssvAwEC0uM0/ahQcrtqww7Zd/FQws/9Z5VWND2zrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50DUI5+fmglrMPplk6TKjghnc5ITV/0t5rR9Jq91HyE=;
 b=Cqm2CJ/pqyzsfl6jMo7Yu50xJtwtcKeLZGzwPkOW7+rviCxLoYcR+ptTsyTtNhABBtIO7WACUA3oJ2mfyzBCcYQyPsHphxu8vbqIqIZpwqtXcJUduGcCJbNtIW6b/CHIyiAZu7/4IDrGyvDG5ezoXUgLHXVmxmUzqh75LfjWcOV/pClyl3l9sNeobE44GayfR0kBpFy5j18C/G2tI7TT4LcSBmW4Mh0e+Io3A9Pd3tC8Kl7k2SSKIUcbIAmzJ0i2KI4T54uqz9vrW18EU2sTx4WWB+k9m6clfbW1tclNP1UptUqEXylGLNumAPQNSjP16sjjX8Iz1x2KXm0jRlgPag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50DUI5+fmglrMPplk6TKjghnc5ITV/0t5rR9Jq91HyE=;
 b=OSwit6CY6mZW8Rd+yovdaYVOTvyJ4nDpl+ZZ3Pm6VKptP1fI52nS9KgYlz1VtD/gFEa8qTpnf77a5jDz5uUZttlR0hWVPdWrOpoByGWOTpOOU78y3kWtIkI96RQ1EJ8xoR/7mPIw6QDt+1/FTzwyhvS0qq7feK5eroKj9X2REdKYzaL5NTozo7xZ1PiqqjW2OIBRKrbCpgWLKw/6AGFUM8amSGDJHJdERmdyrWJP6bn3MB5RlA0ts/V8ia8Ed8vUXlNOpNX9jZ13tB6izPeCZs5ETIeHflCYITQ/9vgcwrA0biq1XcEKZIllEZuihDGptp1KfoYQpqxOO7ZzfZzXYA==
Received: from BLAPR03CA0153.namprd03.prod.outlook.com (2603:10b6:208:32f::19)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 15:38:34 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:32f:cafe::9f) by BLAPR03CA0153.outlook.office365.com
 (2603:10b6:208:32f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 15:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 15:38:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 08:38:14 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 08:38:14 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 13
 Jul 2026 08:38:10 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 13 Jul 2026 18:38:00 +0300
Subject: [PATCH rdma-next v2 1/8] RDMA/core: Add
 rdma_restrack_begin/abort/commit_del() operations
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260713-restrack-uaf-fix-resub-v2-1-bbe8bb270d51@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783957085; l=8159;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=Fhd9ofQ4UhlctRydb08h40+6v+kEcr4Jn1BfnBNxazA=;
 b=QAWTL+9mIBH74xfF0At/CxRBBasITl9mAYj1+y/lkgkchKYNGXcfjlsiqyyG8Y815biYZOoKm
 uXU+exmFTJpBS9wgB4YMhw3Se9OgRDN1kRIVeb+TYrYy4ywWPSEAa3H
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 3804c46c-6ab3-4c7c-e0a0-08dee0f4ccc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|921020|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ijwUSgscbNB4p+CHADRB9u4Rb+Z8sa3vESTtOv43NYxFlwgB7H4eUDTt6lMryfyufZzXzJ8WIib8n1bik6+0N/EO+PjrIjXVOXbe7ZtgknS5riZdFD6T0Xdeo3z7sGd7qMM9RjqWinKXHcCV790/zA+MEau8iNH+5DnIlh4ggpHEmIcA/B1VIflnJBEqYiAk6nQFo+ifhwyEqVuwIcFNSiP4+mU73hwJB2Wn6UGLvCeYHLsMFaBlY+hHrcdQxZYB7pxxgKQOk7tHKm2QRNbVHUlKKHfq31QbZGJ6m1sK5Xw7OER/t54F9C97ACL5UoEGo7RDiLkPv05STdo4V63xMwetPInz0IJDHu9smyWR0gICDnXZLsvrcQgfkIHo7zVpAsSdQ/a1hcE/Wj9oYP57FHTKHqSG83XXMPPFF5LjpLOM2wREnysdJF6cX6TgeT5VAl/DkWlLOUOimkCBajRPOVM8OEgcgXbxTqIakVB5ZsmyQBY9CThxe51jioIl19OFiPquQfY5L9kwxwwZ40E6xOJqeaA2JC1t6tU8JxZ8/ZmQt3bZNDkdeBZEJP4xay4V1z/wFKTtlHKJVGJGa49W3QhD3Oceu5r9glWgJBAiZSsLp71Y4CgI0xPJH3T5SskCqEsOtnSPA373/q2gJTxCjiG0ZxoeDMNX5qLJfSnGJ8FEXHs9iWXf9EFtr87X/lN+5spRlljyq/VDnMkbbtQLNIS8zrf3WIQhNrt/Y/pjhCbpWxbTvinyY1PIU9PHs0FL
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(921020)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	26ZaMjC503HYnU5Y4v2sAN7AilcnC0s9MD6B4tvd07gj0qGe0HRGVzR/MGmksvPQgIVm8eSV1rw75LxEOHVlzhqoRac6VADLl3X+71/tpoxg78JADoHPVNFrn1XOWiCwwjU8BIRCBWkLQHIPH4pR9D+8HIWmT1Hoa210gkFs0KCC9t/0M9hwKCE3a0Y3yJDs5vnp/D5KCcJSuYVnXwgCU+M5RSCzHdG/JTIS+XX3dJhhHMfJeMQhkqMVD3Un7HunFq0MJJheiEvUEyfAGBBiJorsPI9OL9Z31FHYUCXIfiLLpZ6xQSw9kmZUTJa/VY+Z7xKJ4mYyk238neagW4+cZ7VhuaBj2vLpMGq1SM7dfAhNJERwCqN/0imCbOhk6RGzuwiAYIasdjRg4ANmJz8cTdXzONlDm7Se9DV160SkYunptc9FBznm9v537lDedoyP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 15:38:34.3295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3804c46c-6ab3-4c7c-e0a0-08dee0f4ccc2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23143-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55D6074D2A8

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
 drivers/infiniband/core/restrack.c | 165 +++++++++++++++++++++++++++++--------
 drivers/infiniband/core/restrack.h |   3 +
 2 files changed, 135 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index cfee2071586c16e3dfc4e21e5d58f8488dfb277f..0d7e40f63c8a00fe53441b3d2ff14ea5fd72e82b 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -129,6 +129,46 @@ static void rdma_restrack_attach_task(struct rdma_restrack_entry *res,
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
+	if (rt) {
+		struct rdma_restrack_entry *old;
+
+		old = xa_cmpxchg(&rt->xa, res->id, res, XA_ZERO_ENTRY,
+				 GFP_KERNEL);
+		WARN_ON(old != res);
+	}
+
+	rdma_restrack_put(res);
+	wait_for_completion(&res->comp);
+}
+
+static void restrack_restore_res(struct rdma_restrack_root *rt,
+				 struct rdma_restrack_entry *res)
+{
+	reinit_completion(&res->comp);
+	kref_init(&res->kref);
+
+	if (rt) {
+		struct rdma_restrack_entry *old;
+
+		old = xa_cmpxchg(&rt->xa, res->id, XA_ZERO_ENTRY, res,
+				 GFP_KERNEL);
+		WARN_ON(old);
+	}
+}
+
 /**
  * rdma_restrack_set_name() - set the task for this resource
  * @res:  resource entry
@@ -177,22 +217,23 @@ void rdma_restrack_new(struct rdma_restrack_entry *res,
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
@@ -229,6 +270,28 @@ void rdma_restrack_add(struct rdma_restrack_entry *res)
 }
 EXPORT_SYMBOL(rdma_restrack_add);
 
+/**
+ * rdma_restrack_abort_del() - re-add object to the resource tracking database
+ * it can only be used after rdma_restrack_begin_del().
+ * @res:  resource entry
+ */
+void rdma_restrack_abort_del(struct rdma_restrack_entry *res)
+{
+	struct rdma_restrack_root *rt = NULL;
+
+	if (!res->valid)
+		return;
+
+	if (!res->no_track) {
+		rt = res_to_rt(res);
+		if (!rt)
+			return;
+	}
+
+	restrack_restore_res(rt, res);
+}
+EXPORT_SYMBOL(rdma_restrack_abort_del);
+
 int __must_check rdma_restrack_get(struct rdma_restrack_entry *res)
 {
 	return kref_get_unless_zero(&res->kref);
@@ -265,7 +328,7 @@ static void restrack_release(struct kref *kref)
 	struct rdma_restrack_entry *res;
 
 	res = container_of(kref, struct rdma_restrack_entry, kref);
-	if (res->task) {
+	if (res->task && !res->valid) {
 		put_task_struct(res->task);
 		res->task = NULL;
 	}
@@ -291,37 +354,20 @@ EXPORT_SYMBOL(rdma_restrack_put);
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
 
@@ -333,7 +379,6 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
 {
 	struct rdma_restrack_entry *old;
 	struct rdma_restrack_root *rt;
-	struct ib_device *dev;
 
 	if (!res->valid) {
 		if (res->task) {
@@ -346,12 +391,10 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
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
 
@@ -359,5 +402,61 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
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
+	struct rdma_restrack_root *rt = NULL;
+
+	if (!res->valid)
+		return;
+
+	if (!res->no_track) {
+		rt = res_to_rt(res);
+		if (!rt)
+			return;
+	}
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


