Return-Path: <linux-rdma+bounces-7745-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EC5A34CEA
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 19:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55BCD3A549D
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 18:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E288924BBF0;
	Thu, 13 Feb 2025 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NHJsr0I5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF3024A07E;
	Thu, 13 Feb 2025 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469787; cv=fail; b=SgFvy05D48DTthWHBGp08aKmwir8XG06BrR4AIrHbMUmf+Tt95m4Kv8NTJZV5SL11iYw/CkW8yJa0F0XAuDupQPmlXAByzyqQ3Jy7+6F2rIAOw5W2RA3H548h9qqNI6gRCPP+omc8IhvcFN34IO1d/EraiumT/1duV2O51mIGHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469787; c=relaxed/simple;
	bh=2VlYHJ/HwDRf4sVfg1AAzBqaWZMXo5OGvMOs1kWq5pE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFsILoTeAwL2NhIG1YohRaIK0YYerekLPnF3dmnWDWLnjoArLCfWHbWMRQyaES0SHUYl2XnDuoR4TkEb5pw1dsscJlVx6yTq8WEZw6Nte2dkFZvb25lxVnCTlUDzOXQM73CEuFCFcZWGdzMlfgOyAjF2Hq3Mci/RLqgcpFS8ptY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NHJsr0I5; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhHhRONlBh5VGC99j3SH2xECixfkHjLA+ZrGznDsoGGwd2WQu+g4ua5Vh5Ln+eTVEwn2avK2Lqlt3MJqrDnhFalGtCe0he6W3DenHGIfMsmj8QQAt3CPdn2KnVjIlB+PsS33WPY1gmGF1iwmY6JPeeKZZ44xMZ2wHKaXg9i9Kdaqo9FZVFV3eBS/zZQ82KsVkzkMq+K0+ZRprwqy3oweTr9q+FhDsDuJ0w4nrElCEQzl5gXphqIIZQqC+JP8VVf0vfglZDEd4nX7gGLYh7o44tVNB10t5WAdzRDJmjgKYGOrxxAg2R4gQSvCCChqZkPSh7JnOZM0Sy18pLAuOwQ7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPv3w4MwXGMAvlgMsofVfQEgC4c2caFRPK55N0OTVFo=;
 b=OcIvKNE4QIH0CpR53v5ryFEVx6JgomwH8HjCDY/qCuoHG1OEBeBRdp3R9gSs+/7uaYN1TvhUCP9XhMCsgRV7Oz/Ho8LHrcFIuRaL3d2//lUuH6+23CM8HKrfKOlssqK5GZ+icKTp3ZHr22P6FeIMv1sGZStU2VvCktoRBHMxZjbaYUBlopcSSMvjOTUWSCjvDx7F9r5B/FI+REVmVJdwq84oZgSYpUxYjSMf1TDNBlXhryN+yO7EHrZDBpgiGB1Sa+JzBj8Vfhwt0S9bMPaUXZIQQg49H1EmRl1RS9rqKURUCYsNogGZYCvHK8oVxwB+7CT7LFcTWI8/cotHVkvQrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPv3w4MwXGMAvlgMsofVfQEgC4c2caFRPK55N0OTVFo=;
 b=NHJsr0I5MLqsBoDZVt0DLjcwfFqdcw0EZJSTHbsi8qUe2vWS7UKP9T8ghuXjezL29eMUzgylnq9gqziNjvgiP/UOHaINe/gtjdijhnLZtZHiQg3LhTlhxYchwsajDSQI5YcU9JhmXt2K/FIfQbtoahcI3R+Y/cAbWOfC1/potXkX0L+lxKuptxgRReHtB2Hh6zSEDMMrs3yRuQEwYIXEEoQiTdd0f4qUJtHnWdCp0+DfytCiFs/R43JSlNYHhh2PJN/ojzAuHzdAk94jETVBYHF85A36qkBT3hNCGUNDMzlL5Y9g5ZvC5XlhH3hPYjjCFWVA5tAhltm1kV0M/J/hnA==
Received: from DM5PR08CA0051.namprd08.prod.outlook.com (2603:10b6:4:60::40) by
 IA1PR12MB6353.namprd12.prod.outlook.com (2603:10b6:208:3e3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Thu, 13 Feb 2025 18:02:59 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::f5) by DM5PR08CA0051.outlook.office365.com
 (2603:10b6:4:60::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Thu,
 13 Feb 2025 18:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 18:02:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 10:02:41 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 10:02:40 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 13
 Feb 2025 10:02:36 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Jiri Pirko <jiri@nvidia.com>
CC: Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Donald Hunter
	<donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
	<corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [PATCH net-next 07/10] net/mlx5: qos: Introduce shared esw qos domains
Date: Thu, 13 Feb 2025 20:01:31 +0200
Message-ID: <20250213180134.323929-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250213180134.323929-1-tariqt@nvidia.com>
References: <20250213180134.323929-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|IA1PR12MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a0f9c89-314d-4f0e-7303-08dd4c58a659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5HkIrweEzn25xh9vHKNipcTz6mVjicBgqQ3AKi/Camxn0ACM7zGYx6WQXrU7?=
 =?us-ascii?Q?isMGAzqCFbRg8MaVrtFsKGumuPKO80Xerdp04xFG4r/Os7NJ/rKfqsh908rY?=
 =?us-ascii?Q?Q62Iqw8CPldW1iOSszeCRD8vGu8TPbK1ARqMbxcw/TzsW9v6eJ7jeyysa0G7?=
 =?us-ascii?Q?dmkU4oSa3SXtd0+Cxl3Gpqmyq+W0L69gq8PEJI9eDJrD8WZLL5sGl6xB4EEJ?=
 =?us-ascii?Q?0Sjq6cGwJDrNEspcMk8ZUJeZG+OGUeNA+//dcx1AjAlzPXBpR1FAesyV16O0?=
 =?us-ascii?Q?M9RhwTIz1HWTPbvA2JOy1+zuerhEt9oxjZxq4xhvQtxnjrd1o6qnE0I5KBNJ?=
 =?us-ascii?Q?mhOK4Ju/uYTs//1v+lQgx6oFbT57EGfvvjsdvB1tDNbqrGNUL1NTo3nwQ15n?=
 =?us-ascii?Q?6UfVNQiwm2RURvgfD3hQT9xkQgKfUdloTNxAAJj0UF27IZhIsEMScBYNUD5J?=
 =?us-ascii?Q?+mn2NYv0HSqXcIS+Nzi6UJrOoZOVmTGyjeykbqFa/BSsJLvGM+5bNnzVnmwG?=
 =?us-ascii?Q?x4YyGppXFaBBfmEb5qeSDI1XRViKoIt3UyrbrBwYfC71Y0oQAvTNdu22yvgg?=
 =?us-ascii?Q?8BYKaxfiGQ2yawEkG4koL1UXh+lRw+ahleLKYsjocWCS4RFnCdba0GxIdXDn?=
 =?us-ascii?Q?h9BmhVkJU3GoXXS4x9uRcIZ0zcgp1cHeSMvijB59zRGPoGBasCUGoEXMkDBW?=
 =?us-ascii?Q?2ah89yUTDdxlrWhhoAn6/VdaN2Z9cGcY8WMC/2MPH5NySymfT8FYcNQJN+yF?=
 =?us-ascii?Q?OzqJakHebZPkLGE/Xw19MLZQKiD4V4Tksfw9FBf/SPuTAxiw8X0y6fiVEPwP?=
 =?us-ascii?Q?3FyS4NsPS9ydAe02oyb30vKY1aNf5LO14eihciAsI3zrHn3tuzH2JtD6Lbj3?=
 =?us-ascii?Q?+FEFUOR5ZHci7E/GvWvECP0wmq1dNWrF2AnjdwTil/fVHch1io0+I2HNvjp7?=
 =?us-ascii?Q?M9mlwt/MX+/mPHCribdK2vdZdRM2xvaKwp5NG7lyl7HsQrocnj6ykjjFrjDZ?=
 =?us-ascii?Q?2OEPzlcaajNoTitYURaQ0zg/bzC6nZuaY3jj5ELV3yHELdj8RCkWXrS4Ryms?=
 =?us-ascii?Q?AlQlXQx/tLmLCV9nHong74BXu/6XSmmf1F34vI8ma9pRWq0cDYAvlxd1ZPhF?=
 =?us-ascii?Q?g1bD76VyCJK67p2e1w+ahmO8yH1DELqPmU02QWl4aC8nroBdkfiJd5H9khmU?=
 =?us-ascii?Q?IGVb4Lwmn5FqBxGrmtW4NCXkJx+sZjJpj73MUttOrKfZR5VIw5WodDcHK5uF?=
 =?us-ascii?Q?EBoseYatX8TM+zo4Ycza+5J5tbtmDin8MvgLMbJWUSTqhlAMrUdhdTRtizEd?=
 =?us-ascii?Q?s+cbetU5cuPohoxxzPl6J1Bo3zEB/5RlX6Qs98KhsXg9jYY4blHzCaXJtWRi?=
 =?us-ascii?Q?HZB0hggSqck4QKyyYzFKhjrwemhHaNG1uBwkcYUdbY9HeCRifSTdyD6MmxNl?=
 =?us-ascii?Q?gjAgfui7z4DSWBVk4abFcg1AFEVu6hlAkD8nCEMd8JTON0FvNNL5bnL62U24?=
 =?us-ascii?Q?eyCkMYCcGYdyxJA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:02:58.6785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0f9c89-314d-4f0e-7303-08dd4c58a659
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6353

From: Cosmin Ratiu <cratiu@nvidia.com>

Introduce shared esw qos domains, capable of holding rate groups for
multiple E-Switches of the same NIC. Shared qos domains are reference
counted and can be discovered via devcom. The devcom comp lock is used
in write-mode to prevent init/cleanup races.

When initializing a shared qos domain fails due to devcom errors,
the code falls back to using a private qos domain while logging a
message that cross-esw scheduling cannot be supported.

Shared esw qos domains will be used in a future patch to support
cross-eswitch scheduling.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 73 +++++++++++++++++--
 1 file changed, 67 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 8b7c843446e1..6a469f214187 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -11,10 +11,17 @@
 /* Minimum supported BW share value by the HW is 1 Mbit/sec */
 #define MLX5_MIN_BW_SHARE 1
 
-/* Holds rate nodes associated with an E-Switch. */
+/* Holds rate nodes associated with one or more E-Switches.
+ * If cross-esw scheduling is supported, this is shared between all
+ * E-Switches of a NIC.
+ */
 struct mlx5_qos_domain {
 	/* Serializes access to all qos changes in the qos domain. */
 	struct mutex lock;
+	/* Whether this domain is shared with other E-Switches. */
+	bool shared;
+	/* The reference count is only used for shared qos domains. */
+	refcount_t refcnt;
 	/* List of all mlx5_esw_sched_nodes. */
 	struct list_head nodes;
 };
@@ -34,7 +41,7 @@ static void esw_assert_qos_lock_held(struct mlx5_eswitch *esw)
 	lockdep_assert_held(&esw->qos.domain->lock);
 }
 
-static struct mlx5_qos_domain *esw_qos_domain_alloc(void)
+static struct mlx5_qos_domain *esw_qos_domain_alloc(bool shared)
 {
 	struct mlx5_qos_domain *qos_domain;
 
@@ -44,21 +51,75 @@ static struct mlx5_qos_domain *esw_qos_domain_alloc(void)
 
 	mutex_init(&qos_domain->lock);
 	INIT_LIST_HEAD(&qos_domain->nodes);
+	qos_domain->shared = shared;
+	if (shared)
+		refcount_set(&qos_domain->refcnt, 1);
 
 	return qos_domain;
 }
 
-static int esw_qos_domain_init(struct mlx5_eswitch *esw)
+static void esw_qos_devcom_lock(struct mlx5_devcom_comp_dev *devcom, bool shared)
 {
-	esw->qos.domain = esw_qos_domain_alloc();
+	if (shared)
+		mlx5_devcom_comp_lock(devcom);
+}
+
+static void esw_qos_devcom_unlock(struct mlx5_devcom_comp_dev *devcom, bool shared)
+{
+	if (shared)
+		mlx5_devcom_comp_unlock(devcom);
+}
+
+static int esw_qos_domain_init(struct mlx5_eswitch *esw, bool shared)
+{
+	struct mlx5_devcom_comp_dev *devcom = esw->dev->priv.hca_devcom_comp;
+
+	if (shared && IS_ERR_OR_NULL(devcom)) {
+		esw_info(esw->dev, "Cross-esw QoS cannot be initialized because devcom is unavailable.");
+		shared = false;
+	}
+
+	esw_qos_devcom_lock(devcom, shared);
+	if (shared) {
+		struct mlx5_devcom_comp_dev *pos;
+		struct mlx5_core_dev *peer_dev;
+
+		mlx5_devcom_for_each_peer_entry(devcom, peer_dev, pos) {
+			struct mlx5_eswitch *peer_esw = peer_dev->priv.eswitch;
+
+			if (peer_esw->qos.domain && peer_esw->qos.domain->shared) {
+				esw->qos.domain = peer_esw->qos.domain;
+				refcount_inc(&esw->qos.domain->refcnt);
+				goto unlock;
+			}
+		}
+	}
+
+	/* If no shared domain found, this esw will create one.
+	 * Doing it with the devcom comp lock held prevents races with other
+	 * eswitches doing concurrent init.
+	 */
+	esw->qos.domain = esw_qos_domain_alloc(shared);
+unlock:
+	esw_qos_devcom_unlock(devcom, shared);
 
 	return esw->qos.domain ? 0 : -ENOMEM;
 }
 
 static void esw_qos_domain_release(struct mlx5_eswitch *esw)
 {
-	kfree(esw->qos.domain);
+	struct mlx5_devcom_comp_dev *devcom = esw->dev->priv.hca_devcom_comp;
+	struct mlx5_qos_domain *domain = esw->qos.domain;
+	bool shared = domain->shared;
+
+	/* Shared domains are released with the devcom comp lock held to
+	 * prevent races with other eswitches doing concurrent init.
+	 */
+	esw_qos_devcom_lock(devcom, shared);
+	if (!shared || refcount_dec_and_test(&domain->refcnt))
+		kfree(domain);
 	esw->qos.domain = NULL;
+	esw_qos_devcom_unlock(devcom, shared);
 }
 
 enum sched_node_type {
@@ -829,7 +890,7 @@ int mlx5_esw_qos_init(struct mlx5_eswitch *esw)
 	if (esw->qos.domain)
 		return 0;  /* Nothing to change. */
 
-	return esw_qos_domain_init(esw);
+	return esw_qos_domain_init(esw, false);
 }
 
 void mlx5_esw_qos_cleanup(struct mlx5_eswitch *esw)
-- 
2.45.0


