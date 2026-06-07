Return-Path: <linux-rdma+bounces-21929-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zd2VIRm2JWpDKwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21929-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 20:19:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E939765137C
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 20:19:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=puvrGNHJ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21929-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21929-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB5C0300954A
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jun 2026 18:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ED53148D3;
	Sun,  7 Jun 2026 18:18:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013052.outbound.protection.outlook.com [40.93.196.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748E32BE026;
	Sun,  7 Jun 2026 18:18:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780856336; cv=fail; b=J34hr/laFOPbPjvj0KQUdxys58xzAvwtLoJC722THvczuIuuHw6McOeiPTIxOXyd+Pqn3jbuMahps3Cj7Otue18578Xb2mUu3pL5MEZwcUrfIXf1wNR4UmFMm1vPpxnzToFqe1ro8Uarv/B/YhHZWywYHvmreVlj526w2ocxwfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780856336; c=relaxed/simple;
	bh=Cx1flle/7XD7chI4sJWp87NBCr7T3R7OMDdsvcz1kJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=F5OnxHEqEm5S9uGWZAelZY9YNQgYVT+Ewa78NLODiQVUIz3EueQyXrbHIw7wHpE2FjaJECWv+efsWQJH1SKhZVo5hY+U08TwTHkoXseWfDHuFEpU+TxezfhbrKcjFyWSthaGCCx3yxlF5W5myJZq+zhfrsoFeQRc3lfbbJ8Yqfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=puvrGNHJ; arc=fail smtp.client-ip=40.93.196.52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDzFM1SJruoMRMT1d8At7pP1rB0clH7a9R9CPoR1IdbDtzs7EJkFLBVN24rzZo6XpCVgTqYyi5w8bjVCso7m7q90uZBdgREmOJc1p7RRhmc0JxfuFhmhZgtPU8/RA2flvLcX7PLrCukIgsGbMR+MHtiv4sZSOuDMt9XBPGVJ4hFnQztQ3bYLl+Wt+iqa1K4zVeNDfW7DEiQpnOP8yTK59L54aG4j9H/MHU+BGq3Esc/8D7mX0FhaKDwaTiC0GPlzttnJCRb7xLf0pBZFiZ66gxmHAg0aszEWiVh4YtPBrS5NNAwcnL7llC6nOtZIlMXYYQ2Ffe3z2SFVX5Kaa7LhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlUsdSe+uvMgCzXrknpA5KkFgML5XCyxy8pBZjumdEs=;
 b=hauYbLYxqseexPsznKGIuuzM8irEpjR9/6ne1AyRxiCQBMawx97y8RX0ueRbeQLY5kQ4kNzjOQ/g600d4VlgdzyNPcE5FM5AZxf+BZDQZDxXWqf9L5N3SIDeUqXNCDtOV7W/q9iXHFoys/gObiiYFmTY8bPF4vRB4Q7XfUY/VZ76n6awbL0bresB8O2pgzDhc+KyblKM8173b2ko+vWJiUIEN5/eTY7m0P9N/88ImSbDZt66NXQX7t9HsH+y1FEv2lAJ6ixnIhey47aEK/VBFqGCLSL3Jp1LW5368bbrfaMmNn2d5aN1D05AFROccqN0lKT5HMzrkoF/j8RxPz57TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlUsdSe+uvMgCzXrknpA5KkFgML5XCyxy8pBZjumdEs=;
 b=puvrGNHJ32XNPiAOAZ3wOQaiNRM82VucMqtTdbB59D0ghlgyJ+soweW4NbP1JHqEnmVw5SiqPtN7K4vrRX5PwPR2S2X35tfrIVWjPJSg31INrxmD2TiNuT5wiuUpIdA/D/tRm2oLfQPUBmdHvNB0lZxh0f0Cf8z8qNfsdW/wUCtydtzaH7MRucxPd3teE1uPAgifd/eZ7Th26/ociAf7sET+lSLMZPMyMRuNcdkMJkYQSzFcO2OzAxWqJrzzEVzBsbfuXBnT/ZOLq26rVGZ3WL6OQm7wAlIRcFbl0cyKEpOsgSmDg7eCHtulvj6sTLtlKftyeYNPrRMtzNf5+tiG2Q==
Received: from MW4PR04CA0102.namprd04.prod.outlook.com (2603:10b6:303:83::17)
 by EAYPR12MB999180.namprd12.prod.outlook.com (2603:10b6:303:2c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Sun, 7 Jun
 2026 18:18:50 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::98) by MW4PR04CA0102.outlook.office365.com
 (2603:10b6:303:83::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.12 via Frontend Transport; Sun, 7
 Jun 2026 18:18:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Sun, 7 Jun 2026 18:18:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 11:18:45 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 11:18:44 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 7 Jun
 2026 11:18:41 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 7 Jun 2026 21:18:10 +0300
Subject: [PATCH rdma-next 3/6] RDMA/core: Add
 rdma_restrack_begin/abort/commit_del() operations
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260607-restrack-uaf-fix-v1-3-d72e45eb76c2@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780856308; l=6491;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=hn7OBqlvlq8hHFKWz1FXL5TLVjD6IgfP5TDgfn2sUw8=;
 b=UPI67wwJX+6Q8OQ4IEACV55E5X5UZLj9A2A1nVqIjaaSw0nuXJr3DpqRLz2Kf9FvjjDnH5yM7
 KBT3KcJmSvsB4Mf+EndD11EThvTi7erSbYgs7sP78HPaDw4xd336/nO
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|EAYPR12MB999180:EE_
X-MS-Office365-Filtering-Correlation-Id: b92344e3-3cb5-4568-9f9f-08dec4c1392d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|18002099003|921020|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	CBmdwe380cO8XwMPvIVQW/l54grelFBpfglza0olp0rQmOc6VCTyMa5YL4yw4gavZgQ+V8GrFMhYDLsb0FOIgNwlxVcbX9CZIfJP6xxJvfqFo22LZPsOAhV6GXjGqt0Z8IN3YUGoUTEevuSm+VBgRhNRSc0FHXO2U3OhuNL5xnHYCyp5OrSzUaq55HdOZz/u++rQL/4ro9m9rMArm+90VXTREH5MkXw4Is8OAJYazcWw1JELVjSYw+h8xAEYO7zwwmrngMT8Xri/sTsgVKaJNPOX30RLvydqFuGjbuitHermyWXYC+5nDKHgijfT/NRL+WASWoQtfo9pYdDx30BpbMXL0qimOWQaZUTHxiGHyAsZJMZkbqI2HyUH7o6pki0eMNQv6KW3/m0/KWYevzBrN5d5mNFE0LGc0+bfjUlTzGFkzv10/ZWOrArcRM8PjsPd8bCJnCPnf8rAI3/YrNDXOR1RM0Ukqarxt5DBvLUs1fPGP6P95RTOQOWUBsLNvswbjPHszldf+Z1sJ/2ixv0ScXMdVOkmCnrhcobd4pcKI3A7orXvzZ4poUfKJ5me45fusZqa0jkewLRRbQWZOBVfym9oSEPALaVombrncXbVKyK2ciBrtY/2xeoo8Tk1j9FApxtG2dIPiozBX7yWb2Ta83ImsujboniPSSIQgCRW3OhF8MwdZsFvfdrTkEaWeJN8vVKQ3+6rA5Bwxp/VU7jPdX1yxfvuxblWL3qWNIl1lH6zn3+m/XFM6oBp/kO9Mgwtxv1ulZf2QsVWslZdyLzSWg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(921020)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NQ6V7+Sl2WcXWTw9c0IuF0mYU+vduLeha2lCjykCTAaIVfrqDlRd19aNQa2rzE5s4SJQ5HDDFjuEgkmaPlN4jHI3El5YmG5MSGOaGvONB7oY16YmJKJLAZSuGO5FNp8JaaIhxRL22NPAvpmu4swTa+34mCtdU+AVB5V0zOD4S6iImVLL1ULrQsNVx0e9H9PwC3csNduI+umGPiIHBOYWlaFkftNBjN8kEmJCXkwCxVesA0WNKPNJVU31ezuhkJopxAvdFeWmMfjL/CQbYmBP1yctVq8bkZ0AqAb8ekbmhhQPCrpbFLQ3zVrs3b8PEjBYSB42xwfOW8bB5XJKw7Uiog3FciLlS9AhJzpUHl0SkVnG7zPQjgXKkWqhVoS4kYATWEzwfqpDeOG1V3oRF34M1FQpsT4kfjFy7VP6ssVP6chVQ/kmeXxYeR70yzAg26p0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 18:18:49.9925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b92344e3-3cb5-4568-9f9f-08dec4c1392d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999180
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21929-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:cmeiohas@nvidia.com,m:maorg@mellanox.com,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:markzhang@nvidia.com,m:netao@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,mellanox.com,cornelisnetworks.com,amazon.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E939765137C

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
 drivers/infiniband/core/restrack.c | 120 +++++++++++++++++++++++++++++++++----
 drivers/infiniband/core/restrack.h |   3 +
 2 files changed, 112 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index ac3688952cabbff1ebb899bacb78421f2515231b..97c8991081a49ff4f74d65c6c1bd8ca647aa72d1 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -71,6 +71,8 @@ int rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
 
 	xa_lock(&rt->xa);
 	xas_for_each(&xas, e, U32_MAX) {
+		if (xa_is_zero(e))
+			continue;
 		if (xa_get_mark(&rt->xa, e->id, RESTRACK_DD) && !show_details)
 			continue;
 		cnt++;
@@ -127,6 +129,16 @@ static void rdma_restrack_attach_task(struct rdma_restrack_entry *res,
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
 /**
  * rdma_restrack_set_name() - set the task for this resource
  * @res:  resource entry
@@ -180,17 +192,15 @@ EXPORT_SYMBOL(rdma_restrack_new);
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
@@ -227,6 +237,37 @@ void rdma_restrack_add(struct rdma_restrack_entry *res)
 }
 EXPORT_SYMBOL(rdma_restrack_add);
 
+/**
+ * rdma_restrack_abort_del() - readd object to the resource tracking database
+ * it can only be used after rdma_restrack_begin_del().
+ * @res:  resource entry
+ */
+void rdma_restrack_abort_del(struct rdma_restrack_entry *res)
+{
+	struct rdma_restrack_entry *old;
+	struct rdma_restrack_root *rt;
+
+	if (!res->valid)
+		return;
+
+	if (res->no_track) {
+		rdma_restrack_new(res, res->type);
+		return;
+	}
+
+	rt = res_to_rt(res);
+	if (!rt)
+		return;
+
+	rdma_restrack_new(res, res->type);
+	old = xa_cmpxchg(&rt->xa, res->id, XA_ZERO_ENTRY, res, 0);
+	/* The only way this can fail if someone called this function
+	 * without first calling rdma_restrack_begin_del().
+	 */
+	WARN_ON(old);
+}
+EXPORT_SYMBOL(rdma_restrack_abort_del);
+
 int __must_check rdma_restrack_get(struct rdma_restrack_entry *res)
 {
 	return kref_get_unless_zero(&res->kref);
@@ -263,7 +304,7 @@ static void restrack_release(struct kref *kref)
 	struct rdma_restrack_entry *res;
 
 	res = container_of(kref, struct rdma_restrack_entry, kref);
-	if (res->task) {
+	if (res->task && !res->valid) {
 		put_task_struct(res->task);
 		res->task = NULL;
 	}
@@ -284,7 +325,6 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
 {
 	struct rdma_restrack_entry *old;
 	struct rdma_restrack_root *rt;
-	struct ib_device *dev;
 
 	if (!res->valid) {
 		if (res->task) {
@@ -297,12 +337,10 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
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
 
@@ -310,5 +348,65 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
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
+ * @res:  resource entry
+ */
+void rdma_restrack_begin_del(struct rdma_restrack_entry *res)
+{
+	struct rdma_restrack_entry *old;
+	struct rdma_restrack_root *rt;
+
+	if (!res->valid)
+		return;
+
+	if (res->no_track)
+		goto out;
+
+	rt = res_to_rt(res);
+	if (!rt)
+		return;
+
+	old = xa_cmpxchg(&rt->xa, res->id, res, XA_ZERO_ENTRY, 0);
+	WARN_ON(old != res);
+
+out:
+	rdma_restrack_put(res);
+	wait_for_completion(&res->comp);
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
index 6a04fc41f738010a90d96f88dbcc88bc36d3a289..45f2f06825f402324304113014fa90da03ec6f88 100644
--- a/drivers/infiniband/core/restrack.h
+++ b/drivers/infiniband/core/restrack.h
@@ -26,7 +26,10 @@ struct rdma_restrack_root {
 int rdma_restrack_init(struct ib_device *dev);
 void rdma_restrack_clean(struct ib_device *dev);
 void rdma_restrack_add(struct rdma_restrack_entry *res);
+void rdma_restrack_abort_del(struct rdma_restrack_entry *res);
 void rdma_restrack_del(struct rdma_restrack_entry *res);
+void rdma_restrack_begin_del(struct rdma_restrack_entry *res);
+void rdma_restrack_commit_del(struct rdma_restrack_entry *res);
 void rdma_restrack_new(struct rdma_restrack_entry *res,
 		       enum rdma_restrack_type type);
 void rdma_restrack_set_name(struct rdma_restrack_entry *res,

-- 
2.49.0


