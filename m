Return-Path: <linux-rdma+bounces-18573-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DT0Nr2GwmkAegQAu9opvQ
	(envelope-from <linux-rdma+bounces-18573-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:42:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 856883087B7
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 140C831E2E4B
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 12:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8163FAE04;
	Tue, 24 Mar 2026 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g0x1fSv/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185C23F8819;
	Tue, 24 Mar 2026 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355496; cv=fail; b=Xz4hDN9UOiwLw6rTOtTnrzvwqReHRldcJAS/JTR8g+EPpaR8dmR3zOxdwtsusxF3EYrkw8Wt1C6CwWbv5Ddx/BLQVYnfZhQxBMYzMGH0Axfkczt+jRnXRTYOIFYjJOQnjgezau1n0UlHt34ZV3mHwatwAVOzLyUsork+UytMWbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355496; c=relaxed/simple;
	bh=573vPQcV0zX6NFJtf/UgijYMZip/+iyqU1XSjq4NqxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anTd3rR0iVC6Hl9zGxjUL7oHQTA7u2rLY4z5Iu6sysiwBuswF3y+g6d5wZr4HvVYeFDUXlgwWiTbsiCeY3xT46wQVXhPab2ICNLIFkZqHDeoTljECltGBhH+edwssu2ykl2hoCuTiNrQ6+/gL79VQR8UpXQAfGET4OoNorJ7flU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g0x1fSv/; arc=fail smtp.client-ip=52.101.57.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkdhgKFrIBi8kzbvm//7vSKe67muoS38PzKeLInp7z+J/ArMyAJ58M8MWCSfLz0Q6Fr0QBBQG0kRq2ahDKwOm3Gu4jyQwjqSspuo2Rk+Y4K/kcWd746UdirFBBvJOknTEEyU4xM4aXv2JTRUKMY4weAV8m/fxgS4rXVgh6L4dJUiOqnb5cftNO4Ujktv8Sd5QLy5ecQM6Gv6tSvQXhHrWTh9CybogzBlc6yTOipGTg10Iu+jt9NgR9I7q/g84TfSDF8PsmvowCgUNFEr0OQ63jg8z0HGUrMf0cFm+uQw5o2a+ZDRAkC2TPfhrXlKEk307/uGNY+aF3hrnzpe9TGnUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UelZdGhxgciL1Fw9fVgiZM8dLl6EVgyGmmDi8N/hfA4=;
 b=m/xthZciz4/Qia8V41QesQ7eDFQMMTuAsjhDJkJpL5AyLJMPJv+EGOGTsUCDI1qaRYDnARIZZx4aD3LvEpYaczJAyg4y9g4kIyc6HYZ4D7XE68uQjmOLJwsGkgljrBYrMCVV+X2g+PUm2daKli9bEFgQUQbUi3JECmOeeTzsRf0RuLEe85Y2tYK3feQS1LQzLEpExXiTqC6gDiOhxSu4mPpQeRAOCQvekeMUnjfSZT1r6Teh9KFDJjLy34HSJ9+pkSP2/YFngjlqeXcE/b1D9KgEMIZVa6onaE4pkGvhZPDCCYmszvuePUSS0cXZXfO4kXzyM56jMFwVdw20+A7keA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UelZdGhxgciL1Fw9fVgiZM8dLl6EVgyGmmDi8N/hfA4=;
 b=g0x1fSv/20iDg9tc4mbnFObWPLtd0rpqBBiDHPOilm4GN/OXxBQNhpEPV0yU9pgK4nnUCGdDYMwvu1gx1KMatg7KPtHB2cGabNGQMFQb/gcaVFptTQK+tPde5KMT7XjsjZOnGOo+2mjBQiL5HCpIfxwvJuFTGUqI8MsoSHek7O4uMvSDsegjIfFoQbyHtneT3cmn4TBK6v1LkmAQ5K5Wt5oSJCUKSK0G02R0gnji6aOqDFLggYP9epcmfvusmU7/AqIjRVPoyj45BGZbKU3Ux0U9dEuoeseLtLotA2QFPI0fK0ZfJOnsT38h0Mk78KNb0fEwMT8QE3U9tfXhoQq/zQ==
Received: from SN6PR05CA0036.namprd05.prod.outlook.com (2603:10b6:805:de::49)
 by MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:31:20 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::ab) by SN6PR05CA0036.outlook.office365.com
 (2603:10b6:805:de::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:31:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:31:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:30:57 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:30:56 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 24
 Mar 2026 05:30:48 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Chuck Lever <chuck.lever@oracle.com>, "Matthieu Baerts
 (NGI0)" <matttbe@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, "Shay
 Drory" <shayd@nvidia.com>, Kees Cook <kees@kernel.org>, Daniel Jurgens
	<danielj@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, Willem de Bruijn <willemb@google.com>, David Wei
	<dw@davidwei.uk>, Petr Machata <petrm@nvidia.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: [PATCH net-next V8 10/14] net/mlx5: qos: Model the root node in the scheduling hierarchy
Date: Tue, 24 Mar 2026 14:28:44 +0200
Message-ID: <20260324122848.36731-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260324122848.36731-1-tariqt@nvidia.com>
References: <20260324122848.36731-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|MN6PR12MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 401d4f52-51a6-4bd1-ec0c-08de89a1411d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tvfY7z8Fhbrc3fU/jEt7D9l2IUX9ZNBi1g3bo64Gq1YB7EJhyFoxnnIpsOCF9qcbReaMUCRlnwNqnCbzs6XbZe0QtXa3Wg3DCPRN+o5zMjBQSoc7qxGGKkZhDbmV6tqTsiMGIUwFx340AyUA2OO9UTKDpREEhOwzjfutE5WLyW2+G7JALYgHTs0hGSx5fxZ9xbthQ5O/K6KWSNMRMWNLXH5SawlUbCAO1Z7w/wMcaITTrqyB/wqtHUmUCOwqMKi9WZljiUYBJSJ0ny2GJSGNsuxoVbeAmCYWa+gaIgbOkwjLyofX00DiowsAdO2Jl445hvmMSKvK1kWtxh76lGnT9PZkPRMm8+jZHBdQy21ZMiYsqe//1m37u74uTkgAF1jXcyQijY+bbPEZ+BVH0OQ3RQ6idCkOMtuEXW6/stQgWPRpQT+2muT0fNzxUaqtM+zCG9tHXlYyyAxwF/JEmBybhkGtryx6yj3luvtNO0fz3jNp5Hmn5CjyJ1fczeAbh0Kk+YH+fdCM/u427WRJSoR0EoHcZndxL3UfKw2k2wry9iu8YrtQnC0bZvcDHTHiZ5dGDLnilp3Y531uIep91BHdmwJ/rFmnEk0sWrEzM9MQC+XPysSdUTSPN73pxeb0bj4Ge+dS5ru2wJ61PwEbO5Kqa6qmKKLQj9EDoTzzXX1UypeIn+CjVde3jzOQ3bMkTRd2ovHIXx6zW7sWYWC0fhUBD5nrQTstmClgm4E6bTBpC8oRv5jQhTLHmU2P4ruTzhrTn/UGiBVoWTY/PmD8Z0tjsA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UzZN8RzgFIxlKLA53n58jRr0zHSlDqrqkJiI+PepXJz8pfrPQ6/6cHpSPmm92XEFoRsaHsDV0Ir7Vr8Nb7E4QbT2heivIuDHyR/kXF0/Jl1n18Cbf/RcCpmC+MmrJyBIP2TO8s3+4hVgJY3mp9rxKj4+5OGHaz94EkpD/CU3xX0umEjmROUlPUbPJo93Fir/T6JBd7ym7sMdwVgZ8JrJOe8fHxLGzoaUX2zSJzmgEsWxfg0hJOE+9v+9W7hi5qecePmHtgahg45qlj/8+IrQB4AsgOIuYQ1+yr3vJNj01xWYAQFQzjrQMsW1pvQaOvvv0hF3C88lcJrOZwIz0YJxsYlekwPJCEFmqOr1OMR0kHXUCJwiZ/V5ufxJvMG9rbwTbUdgU9PClETRmrjq+U/cQMnaHUiz4Viee0IZ7TezxHis2U6TVCtPSUtwxxi2lEGa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:31:20.6888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 401d4f52-51a6-4bd1-ec0c-08de89a1411d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,google.com,davidwei.uk,fomichev.me,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18573-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 856883087B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cosmin Ratiu <cratiu@nvidia.com>

In commit [1] the concept of the root node in the qos hierarchy was
removed due to a bug with how tx_share worked. The side effect is that
in many places, there are now corner cases related to parent handling.
However, since that change, support for tc_bw was added and now, with
upcoming cross-esw support, the code is about to become even more
complicated, increasing the number of such corner cases.

Bring back the concept of the root node, to which all esw vports and
nodes are connected to. This benefits multiple operations which can
assume there's always a valid parent and don't have to do ternary
gymnastics to determine the correct esw to talk to.

As side effect, there's no longer a need to store the groups in the
qos domain, since normalization can simply iterate over all children of
the root node. Normalization gets simplified as a result.

There should be no functionality changes as a result of this change.

[1] commit 330f0f6713a3 ("net/mlx5: Remove default QoS group and attach
vports directly to root TSAR")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 183 ++++++++----------
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   3 +-
 2 files changed, 78 insertions(+), 108 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 4781a1a42f1a..12cc9bb8d08b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -15,8 +15,6 @@
 struct mlx5_qos_domain {
 	/* Serializes access to all qos changes in the qos domain. */
 	struct mutex lock;
-	/* List of all mlx5_esw_sched_nodes. */
-	struct list_head nodes;
 };
 
 static void esw_qos_lock(struct mlx5_eswitch *esw)
@@ -43,7 +41,6 @@ static struct mlx5_qos_domain *esw_qos_domain_alloc(void)
 		return NULL;
 
 	mutex_init(&qos_domain->lock);
-	INIT_LIST_HEAD(&qos_domain->nodes);
 
 	return qos_domain;
 }
@@ -62,6 +59,7 @@ static void esw_qos_domain_release(struct mlx5_eswitch *esw)
 }
 
 enum sched_node_type {
+	SCHED_NODE_TYPE_ROOT,
 	SCHED_NODE_TYPE_VPORTS_TSAR,
 	SCHED_NODE_TYPE_VPORT,
 	SCHED_NODE_TYPE_TC_ARBITER_TSAR,
@@ -106,18 +104,6 @@ struct mlx5_esw_sched_node {
 	u32 tc_bw[DEVLINK_RATE_TCS_MAX];
 };
 
-static void esw_qos_node_attach_to_parent(struct mlx5_esw_sched_node *node)
-{
-	if (!node->parent) {
-		/* Root children are assigned a depth level of 2. */
-		node->level = 2;
-		list_add_tail(&node->entry, &node->esw->qos.domain->nodes);
-	} else {
-		node->level = node->parent->level + 1;
-		list_add_tail(&node->entry, &node->parent->children);
-	}
-}
-
 static int esw_qos_num_tcs(struct mlx5_core_dev *dev)
 {
 	int num_tcs = mlx5_max_tc(dev) + 1;
@@ -125,14 +111,14 @@ static int esw_qos_num_tcs(struct mlx5_core_dev *dev)
 	return num_tcs < DEVLINK_RATE_TCS_MAX ? num_tcs : DEVLINK_RATE_TCS_MAX;
 }
 
-static void
-esw_qos_node_set_parent(struct mlx5_esw_sched_node *node, struct mlx5_esw_sched_node *parent)
+static void esw_qos_node_set_parent(struct mlx5_esw_sched_node *node,
+				    struct mlx5_esw_sched_node *parent)
 {
-	list_del_init(&node->entry);
 	node->parent = parent;
-	if (parent)
-		node->esw = parent->esw;
-	esw_qos_node_attach_to_parent(node);
+	node->esw = parent->esw;
+	node->level = parent->level + 1;
+	list_del(&node->entry);
+	list_add_tail(&node->entry, &parent->children);
 }
 
 static void esw_qos_nodes_set_parent(struct list_head *nodes,
@@ -321,22 +307,19 @@ static int esw_qos_create_rate_limit_element(struct mlx5_esw_sched_node *node,
 	return esw_qos_node_create_sched_element(node, sched_ctx, extack);
 }
 
-static u32 esw_qos_calculate_min_rate_divider(struct mlx5_eswitch *esw,
-					      struct mlx5_esw_sched_node *parent)
+static u32
+esw_qos_calculate_min_rate_divider(struct mlx5_esw_sched_node *parent)
 {
-	struct list_head *nodes = parent ? &parent->children : &esw->qos.domain->nodes;
-	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
+	u32 fw_max_bw_share = MLX5_CAP_QOS(parent->esw->dev, max_tsar_bw_share);
 	struct mlx5_esw_sched_node *node;
 	u32 max_guarantee = 0;
 
 	/* Find max min_rate across all nodes.
 	 * This will correspond to fw_max_bw_share in the final bw_share calculation.
 	 */
-	list_for_each_entry(node, nodes, entry) {
-		if (node->esw == esw && node->ix != esw->qos.root_tsar_ix &&
-		    node->min_rate > max_guarantee)
+	list_for_each_entry(node, &parent->children, entry)
+		if (node->min_rate > max_guarantee)
 			max_guarantee = node->min_rate;
-	}
 
 	if (max_guarantee)
 		return max_t(u32, max_guarantee / fw_max_bw_share, 1);
@@ -368,18 +351,13 @@ static void esw_qos_update_sched_node_bw_share(struct mlx5_esw_sched_node *node,
 	esw_qos_sched_elem_config(node, node->max_rate, bw_share, extack);
 }
 
-static void esw_qos_normalize_min_rate(struct mlx5_eswitch *esw,
-				       struct mlx5_esw_sched_node *parent,
+static void esw_qos_normalize_min_rate(struct mlx5_esw_sched_node *parent,
 				       struct netlink_ext_ack *extack)
 {
-	struct list_head *nodes = parent ? &parent->children : &esw->qos.domain->nodes;
-	u32 divider = esw_qos_calculate_min_rate_divider(esw, parent);
+	u32 divider = esw_qos_calculate_min_rate_divider(parent);
 	struct mlx5_esw_sched_node *node;
 
-	list_for_each_entry(node, nodes, entry) {
-		if (node->esw != esw || node->ix == esw->qos.root_tsar_ix)
-			continue;
-
+	list_for_each_entry(node, &parent->children, entry) {
 		/* Vports TC TSARs don't have a minimum rate configured,
 		 * so there's no need to update the bw_share on them.
 		 */
@@ -391,7 +369,7 @@ static void esw_qos_normalize_min_rate(struct mlx5_eswitch *esw,
 		if (list_empty(&node->children))
 			continue;
 
-		esw_qos_normalize_min_rate(node->esw, node, extack);
+		esw_qos_normalize_min_rate(node, extack);
 	}
 }
 
@@ -412,14 +390,11 @@ static u32 esw_qos_calculate_tc_bw_divider(u32 *tc_bw)
 static int esw_qos_set_node_min_rate(struct mlx5_esw_sched_node *node,
 				     u32 min_rate, struct netlink_ext_ack *extack)
 {
-	struct mlx5_eswitch *esw = node->esw;
-
 	if (min_rate == node->min_rate)
 		return 0;
 
 	node->min_rate = min_rate;
-	esw_qos_normalize_min_rate(esw, node->parent, extack);
-
+	esw_qos_normalize_min_rate(node->parent, extack);
 	return 0;
 }
 
@@ -472,8 +447,7 @@ esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT);
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
 	MLX5_SET(vport_element, attr, vport_number, vport_node->vport->vport);
-	MLX5_SET(scheduling_context, sched_ctx, parent_element_id,
-		 parent ? parent->ix : vport_node->esw->qos.root_tsar_ix);
+	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, parent->ix);
 	MLX5_SET(scheduling_context, sched_ctx, max_average_bw,
 		 vport_node->max_rate);
 
@@ -513,7 +487,7 @@ esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vport_tc_node,
 }
 
 static struct mlx5_esw_sched_node *
-__esw_qos_alloc_node(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type type,
+__esw_qos_alloc_node(u32 tsar_ix, enum sched_node_type type,
 		     struct mlx5_esw_sched_node *parent)
 {
 	struct mlx5_esw_sched_node *node;
@@ -522,20 +496,12 @@ __esw_qos_alloc_node(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type
 	if (!node)
 		return NULL;
 
-	node->esw = esw;
 	node->ix = tsar_ix;
 	node->type = type;
-	node->parent = parent;
 	INIT_LIST_HEAD(&node->children);
-	esw_qos_node_attach_to_parent(node);
-	if (!parent) {
-		/* The caller is responsible for inserting the node into the
-		 * parent list if necessary. This function can also be used with
-		 * a NULL parent, which doesn't necessarily indicate that it
-		 * refers to the root scheduling element.
-		 */
-		list_del_init(&node->entry);
-	}
+	INIT_LIST_HEAD(&node->entry);
+	if (parent)
+		esw_qos_node_set_parent(node, parent);
 
 	return node;
 }
@@ -570,7 +536,7 @@ static int esw_qos_create_vports_tc_node(struct mlx5_esw_sched_node *parent,
 					  SCHEDULING_HIERARCHY_E_SWITCH))
 		return -EOPNOTSUPP;
 
-	vports_tc_node = __esw_qos_alloc_node(parent->esw, 0,
+	vports_tc_node = __esw_qos_alloc_node(0,
 					      SCHED_NODE_TYPE_VPORTS_TC_TSAR,
 					      parent);
 	if (!vports_tc_node) {
@@ -665,7 +631,6 @@ static int esw_qos_create_tc_arbiter_sched_elem(
 		struct netlink_ext_ack *extack)
 {
 	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
-	u32 tsar_parent_ix;
 	void *attr;
 
 	if (!mlx5_qos_tsar_type_supported(tc_arbiter_node->esw->dev,
@@ -678,10 +643,8 @@ static int esw_qos_create_tc_arbiter_sched_elem(
 
 	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
 	MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_TC_ARB);
-	tsar_parent_ix = tc_arbiter_node->parent ? tc_arbiter_node->parent->ix :
-			 tc_arbiter_node->esw->qos.root_tsar_ix;
 	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id,
-		 tsar_parent_ix);
+		 tc_arbiter_node->parent->ix);
 	MLX5_SET(scheduling_context, tsar_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
 	MLX5_SET(scheduling_context, tsar_ctx, max_average_bw,
@@ -694,37 +657,36 @@ static int esw_qos_create_tc_arbiter_sched_elem(
 }
 
 static struct mlx5_esw_sched_node *
-__esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sched_node *parent,
+__esw_qos_create_vports_sched_node(struct mlx5_esw_sched_node *parent,
 				   struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *node;
-	u32 tsar_ix;
 	int err;
+	u32 ix;
 
-	err = esw_qos_create_node_sched_elem(esw->dev, esw->qos.root_tsar_ix, 0,
-					     0, &tsar_ix);
+	err = esw_qos_create_node_sched_elem(parent->esw->dev, parent->ix, 0, 0,
+					     &ix);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch create TSAR for node failed");
 		return ERR_PTR(err);
 	}
 
-	node = __esw_qos_alloc_node(esw, tsar_ix, SCHED_NODE_TYPE_VPORTS_TSAR, parent);
+	node = __esw_qos_alloc_node(ix, SCHED_NODE_TYPE_VPORTS_TSAR, parent);
 	if (!node) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch alloc node failed");
 		err = -ENOMEM;
 		goto err_alloc_node;
 	}
 
-	list_add_tail(&node->entry, &esw->qos.domain->nodes);
-	esw_qos_normalize_min_rate(esw, NULL, extack);
-	trace_mlx5_esw_node_qos_create(esw->dev, node, node->ix);
+	esw_qos_normalize_min_rate(parent, extack);
+	trace_mlx5_esw_node_qos_create(parent->esw->dev, node, node->ix);
 
 	return node;
 
 err_alloc_node:
-	if (mlx5_destroy_scheduling_element_cmd(esw->dev,
+	if (mlx5_destroy_scheduling_element_cmd(parent->esw->dev,
 						SCHEDULING_HIERARCHY_E_SWITCH,
-						tsar_ix))
+						ix))
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR for node failed");
 	return ERR_PTR(err);
 }
@@ -746,7 +708,7 @@ esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct netlink_ext_ac
 	if (err)
 		return ERR_PTR(err);
 
-	node = __esw_qos_create_vports_sched_node(esw, NULL, extack);
+	node = __esw_qos_create_vports_sched_node(esw->qos.root, extack);
 	if (IS_ERR(node))
 		esw_qos_put(esw);
 
@@ -762,38 +724,47 @@ static void __esw_qos_destroy_node(struct mlx5_esw_sched_node *node, struct netl
 
 	trace_mlx5_esw_node_qos_destroy(esw->dev, node, node->ix);
 	esw_qos_destroy_node(node, extack);
-	esw_qos_normalize_min_rate(esw, NULL, extack);
+	esw_qos_normalize_min_rate(esw->qos.root, extack);
 }
 
 static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = esw->dev;
+	struct mlx5_esw_sched_node *root;
+	u32 root_ix;
 	int err;
 
 	if (!MLX5_CAP_GEN(dev, qos) || !MLX5_CAP_QOS(dev, esw_scheduling))
 		return -EOPNOTSUPP;
 
-	err = esw_qos_create_node_sched_elem(esw->dev, 0, 0, 0,
-					     &esw->qos.root_tsar_ix);
+	err = esw_qos_create_node_sched_elem(esw->dev, 0, 0, 0, &root_ix);
 	if (err) {
 		esw_warn(dev, "E-Switch create root TSAR failed (%d)\n", err);
 		return err;
 	}
 
+	root = __esw_qos_alloc_node(root_ix, SCHED_NODE_TYPE_ROOT, NULL);
+	if (!root) {
+		esw_warn(dev, "E-Switch create root node failed\n");
+		err = -ENOMEM;
+		goto out_err;
+	}
+	root->esw = esw;
+	root->level = 1;
+	esw->qos.root = root;
 	refcount_set(&esw->qos.refcnt, 1);
 
 	return 0;
+out_err:
+	mlx5_destroy_scheduling_element_cmd(dev, SCHEDULING_HIERARCHY_E_SWITCH,
+					    root_ix);
+	return err;
 }
 
 static void esw_qos_destroy(struct mlx5_eswitch *esw)
 {
-	int err;
-
-	err = mlx5_destroy_scheduling_element_cmd(esw->dev,
-						  SCHEDULING_HIERARCHY_E_SWITCH,
-						  esw->qos.root_tsar_ix);
-	if (err)
-		esw_warn(esw->dev, "E-Switch destroy root TSAR failed (%d)\n", err);
+	esw_qos_destroy_node(esw->qos.root, NULL);
+	esw->qos.root = NULL;
 }
 
 static int esw_qos_get(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
@@ -866,8 +837,7 @@ esw_qos_create_vport_tc_sched_node(struct mlx5_vport *vport,
 	u8 tc = vports_tc_node->tc;
 	int err;
 
-	vport_tc_node = __esw_qos_alloc_node(vport_node->esw, 0,
-					     SCHED_NODE_TYPE_VPORT_TC,
+	vport_tc_node = __esw_qos_alloc_node(0, SCHED_NODE_TYPE_VPORT_TC,
 					     vports_tc_node);
 	if (!vport_tc_node)
 		return -ENOMEM;
@@ -959,7 +929,7 @@ esw_qos_vport_tc_enable(struct mlx5_vport *vport, enum sched_node_type type,
 		/* Increase the parent's level by 2 to account for both the
 		 * TC arbiter and the vports TC scheduling element.
 		 */
-		new_level = (parent ? parent->level : 2) + 2;
+		new_level = parent->level + 2;
 		max_level = 1 << MLX5_CAP_QOS(vport_node->esw->dev,
 					      log_esw_max_sched_depth);
 		if (new_level > max_level) {
@@ -997,7 +967,7 @@ esw_qos_vport_tc_enable(struct mlx5_vport *vport, enum sched_node_type type,
 err_sched_nodes:
 	if (type == SCHED_NODE_TYPE_RATE_LIMITER) {
 		esw_qos_node_destroy_sched_element(vport_node, NULL);
-		esw_qos_node_attach_to_parent(vport_node);
+		esw_qos_node_set_parent(vport_node, vport_node->parent);
 	} else {
 		esw_qos_tc_arbiter_scheduling_teardown(vport_node, NULL);
 	}
@@ -1055,7 +1025,7 @@ static void esw_qos_vport_disable(struct mlx5_vport *vport, struct netlink_ext_a
 	vport_node->bw_share = 0;
 	memset(vport_node->tc_bw, 0, sizeof(vport_node->tc_bw));
 	list_del_init(&vport_node->entry);
-	esw_qos_normalize_min_rate(vport_node->esw, vport_node->parent, extack);
+	esw_qos_normalize_min_rate(vport_node->parent, extack);
 
 	trace_mlx5_esw_vport_qos_destroy(vport_node->esw->dev, vport);
 }
@@ -1068,7 +1038,7 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
 	int err;
 
-	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
+	esw_assert_qos_lock_held(vport_node->esw);
 
 	esw_qos_node_set_parent(vport_node, parent);
 	if (type == SCHED_NODE_TYPE_VPORT)
@@ -1079,7 +1049,7 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 		return err;
 
 	vport_node->type = type;
-	esw_qos_normalize_min_rate(vport_node->esw, parent, extack);
+	esw_qos_normalize_min_rate(parent, extack);
 	trace_mlx5_esw_vport_qos_create(vport->dev, vport, vport_node->max_rate,
 					vport_node->bw_share);
 
@@ -1092,7 +1062,6 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	struct mlx5_esw_sched_node *sched_node;
-	struct mlx5_eswitch *parent_esw;
 	int err;
 
 	esw_assert_qos_lock_held(esw);
@@ -1100,14 +1069,13 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 	if (err)
 		return err;
 
-	parent_esw = parent ? parent->esw : esw;
-	sched_node = __esw_qos_alloc_node(parent_esw, 0, type, parent);
+	if (!parent)
+		parent = esw->qos.root;
+	sched_node = __esw_qos_alloc_node(0, type, parent);
 	if (!sched_node) {
 		esw_qos_put(esw);
 		return -ENOMEM;
 	}
-	if (!parent)
-		list_add_tail(&sched_node->entry, &esw->qos.domain->nodes);
 
 	sched_node->max_rate = max_rate;
 	sched_node->min_rate = min_rate;
@@ -1147,7 +1115,8 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 		goto unlock;
 
 	parent = vport->qos.sched_node->parent;
-	WARN(parent, "Disabling QoS on port before detaching it from node");
+	WARN(parent != esw->qos.root,
+	     "Disabling QoS on port before detaching it from node");
 
 	mlx5_esw_qos_vport_disable_locked(vport);
 unlock:
@@ -1319,11 +1288,9 @@ static int esw_qos_switch_tc_arbiter_node_to_vports(
 	struct mlx5_esw_sched_node *node,
 	struct netlink_ext_ack *extack)
 {
-	u32 parent_tsar_ix = node->parent ?
-			     node->parent->ix : node->esw->qos.root_tsar_ix;
 	int err;
 
-	err = esw_qos_create_node_sched_elem(node->esw->dev, parent_tsar_ix,
+	err = esw_qos_create_node_sched_elem(node->esw->dev, node->parent->ix,
 					     node->max_rate, node->bw_share,
 					     &node->ix);
 	if (err) {
@@ -1378,8 +1345,8 @@ esw_qos_move_node(struct mlx5_esw_sched_node *curr_node)
 {
 	struct mlx5_esw_sched_node *new_node;
 
-	new_node = __esw_qos_alloc_node(curr_node->esw, curr_node->ix,
-					curr_node->type, NULL);
+	new_node = __esw_qos_alloc_node(curr_node->ix, curr_node->type,
+					curr_node->parent);
 	if (!new_node)
 		return ERR_PTR(-ENOMEM);
 
@@ -1888,7 +1855,9 @@ mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
 		err = mlx5_esw_qos_vport_enable(vport, type, parent, 0, 0,
 						extack);
 	} else if (vport->qos.sched_node) {
-		err = esw_qos_vport_update_parent(vport, parent, extack);
+		err = esw_qos_vport_update_parent(vport,
+						  parent ? : esw->qos.root,
+						  extack);
 	}
 	esw_qos_unlock(esw);
 	return err;
@@ -1959,7 +1928,7 @@ mlx5_esw_qos_node_validate_set_parent(struct mlx5_esw_sched_node *node,
 		return -EOPNOTSUPP;
 	}
 
-	new_level = parent ? parent->level + 1 : 2;
+	new_level = parent->level + 1;
 	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
 		/* Increase by one to account for the vports TC scheduling
 		 * element.
@@ -2010,14 +1979,12 @@ static int esw_qos_vports_node_update_parent(struct mlx5_esw_sched_node *node,
 {
 	struct mlx5_esw_sched_node *curr_parent = node->parent;
 	struct mlx5_eswitch *esw = node->esw;
-	u32 parent_ix;
 	int err;
 
-	parent_ix = parent ? parent->ix : node->esw->qos.root_tsar_ix;
 	mlx5_destroy_scheduling_element_cmd(esw->dev,
 					    SCHEDULING_HIERARCHY_E_SWITCH,
 					    node->ix);
-	err = esw_qos_create_node_sched_elem(esw->dev, parent_ix,
+	err = esw_qos_create_node_sched_elem(esw->dev, parent->ix,
 					     node->max_rate, 0, &node->ix);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack,
@@ -2050,6 +2017,8 @@ static int mlx5_esw_qos_node_update_parent(struct mlx5_esw_sched_node *node,
 
 	esw_qos_lock(esw);
 	curr_parent = node->parent;
+	if (!parent)
+		parent = esw->qos.root;
 	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
 		err = esw_qos_tc_arbiter_node_update_parent(node, parent,
 							    extack);
@@ -2060,8 +2029,8 @@ static int mlx5_esw_qos_node_update_parent(struct mlx5_esw_sched_node *node,
 	if (err)
 		goto out;
 
-	esw_qos_normalize_min_rate(esw, curr_parent, extack);
-	esw_qos_normalize_min_rate(esw, parent, extack);
+	esw_qos_normalize_min_rate(curr_parent, extack);
+	esw_qos_normalize_min_rate(parent, extack);
 
 out:
 	esw_qos_unlock(esw);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index a5a02b26b80b..9b3949a64784 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -390,8 +390,9 @@ struct mlx5_eswitch {
 	struct {
 		/* Initially 0, meaning no QoS users and QoS is disabled. */
 		refcount_t refcnt;
-		u32 root_tsar_ix;
 		struct mlx5_qos_domain *domain;
+		/* The root node of the hierarchy. */
+		struct mlx5_esw_sched_node *root;
 	} qos;
 
 	struct mlx5_esw_bridge_offloads *br_offloads;
-- 
2.44.0


