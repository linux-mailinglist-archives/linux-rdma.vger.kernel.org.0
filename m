Return-Path: <linux-rdma+bounces-7743-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E278A34CCD
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 19:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540BB16C129
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 18:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774ED24A046;
	Thu, 13 Feb 2025 18:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pUC9+w8a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34202245B0A;
	Thu, 13 Feb 2025 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469773; cv=fail; b=T50z/GiQnGl5yTQF5k/s+QElu0rjx4ssXMIYYa7ayrdz8OdxeSzvALFrji2zFh5aRF11LF3qF3dBiJxSKFmvgDCj76ShoPaNeTcf8YQZNHHTu5PxtzdYDjFxHY8mlArxchOSVIQ2vypl357JoqFq7PgewtxZPGpKyTR09Lt2dUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469773; c=relaxed/simple;
	bh=JDdZxEL2Dk1D+Yd49KjG+qYggkE7GioW8jD4mMIeSkg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pF7nAWTraYYb3gwugDMLPcLIUnGcC1K85ECi6ZsM1DFkjNmW/gWd9ZKy6YPxfo3TxnVmMd2r6mKw2ZPwcPLJBJUt4bwRCewaoUj1fzmWyU3vwGFmE+SYOUBjdIVKK1GqJ7atUps/gYz/rkzrpS9vPTOHNXLFhq2YH9pLJ1O2A7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pUC9+w8a; arc=fail smtp.client-ip=40.107.100.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gf2BDT4CmT/k9SATKyABoZmIV/AMaZ7vB3BMlPP7ZSrFlkN7grxDU1K/TBoFpRlzq0DwoBfzCN2pFwhGzDlsMD0LS2vPGI1RRbuDqTDXibBzrd8RMGYY3pOYYq5uWzzYetBt2vBDVE/uGA3cDoagDxls5plEIkikninIJY4cT4gNnD5JvWCB1MEOWoFR8SeZZ4UXHWQtUrgYn9mJTCHZ51l1vNwF2gBionSMRVB0X1JjJbhVHsROBijzD2ruPEkSinGHLmF+8u7PT9enkiuFviEo+MQH/38L3lEDy5H6cH8pgnp9zYPXYaz3F/sijg06Z3poua3dGd/QmziSJqancw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxIEbbfgk6/pdgzha04CPEYMv2uUqhP5UfIjKKcBYM4=;
 b=pNabL2rcwVYg/NzqtLKGeyd9N4WBD9lsRtL1oewVeqO2qmf/+xAlYHqAGI9EWJYJfh9O03u7OQRqTa9Zu+kA3SNojUobDJPH84awU4jPfTkj1TiMtL4guybH55Fm79lsmRs666pcTQDeBOS7j6J1byeUMSMF87wT4fRZCZjIhtkSq7/LfSRqNC9GxdV+9ENhferb34SmPK2AtbG860e+2Io+l7HTXuH4iVOWsbHN2qqHEXTOBpzbzgEPdvsJy2rmlxRKxCfOKo3uPlTUFlQdQOf40oUopqQyRxmsbwHmcJJ80w+QvjlvIrG1/pNd0SlbR8C4AeupwCOzdup1D8azgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxIEbbfgk6/pdgzha04CPEYMv2uUqhP5UfIjKKcBYM4=;
 b=pUC9+w8aVNLcbzOlZiFcJJEsqiVd86VESJdZd2kZ9LTTyAHX3knPOi2yi59CtRFSS6tk1TLtB307O/T5rph/K8yAnPyLGnX6cqLr4pe2sNYvbiHeq4nG+XZnOK3FEMOLk6ckdPlRjRmgfrYqm19ifzDTp4TXBX46tD9nVSw3Y+/Az9Dd0grjH16wvKGMVVbZErT8Ux+L0uWZ2dg0mABTV4BYilMP0US4MLy2PPm1t+ix3jIiMrVkUdwDC2SJMuQj9KaHrzrT1SrPEipFK3wy1MFs2i+GvGX26CtDC0l+COXUAgqs2pzgkYMFkb/GtsW/Ux2IXnaoMjbhY4nZrPIpeA==
Received: from DS7PR03CA0225.namprd03.prod.outlook.com (2603:10b6:5:3ba::20)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Thu, 13 Feb
 2025 18:02:44 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::2d) by DS7PR03CA0225.outlook.office365.com
 (2603:10b6:5:3ba::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 18:02:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 18:02:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 10:02:26 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 10:02:26 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 13
 Feb 2025 10:02:22 -0800
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
Subject: [PATCH net-next 04/10] devlink: Introduce shared rate domains
Date: Thu, 13 Feb 2025 20:01:28 +0200
Message-ID: <20250213180134.323929-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DM6PR12MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: a77181bd-571b-4295-2ec8-08dd4c589d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y0PZuCPwmN3j6U1ONKAb5ehTBETIdKshNIZ2m6ExMPowbS0O98wGs+pZI0U7?=
 =?us-ascii?Q?8vUq/0PpxBIlZ3AAHejtASbTiBbB5AJP8cZHWi7B6unCbIYyZX2W2TmjIgzK?=
 =?us-ascii?Q?eeFLqv+ncucjJf/dtRO7Cb1w20vNJCRqU5ph7+uXjddRv3LHlB1+d4nCTP9M?=
 =?us-ascii?Q?mt3A5l7hDeZa/V1rjmzNMSIZTxuOWFnSPCShLWcuOL+NLITaM0NjhFzMTFZ0?=
 =?us-ascii?Q?BXrZfekilt7sktBzpV/sIhuX/n9iS/12dNy1LytZ8sNe2nzIEy/0yzL2OusL?=
 =?us-ascii?Q?+bDCcQI4jqH9Oxy7g2goG91KktVGGR4LDhgEwGsMh4qgBgIe7JfxDwr+XWKu?=
 =?us-ascii?Q?9Yt1bS6cwJ7X50XRD2I3OUKydaVx07mdJqlA++Du0RLdC5xOpYCTqCU7/jbX?=
 =?us-ascii?Q?bLoO/r9gd++1WLrsgi9YWxHsu+2fuOmlhrY8U0di14b26DZDU+Yk4uBTTjSj?=
 =?us-ascii?Q?ugh86IgM/itKGxQWAOCIO2g08/fLHgUxU2DpAmgSvvgxGEQQuql80aqiZ097?=
 =?us-ascii?Q?GB7400P6tIKR34oUx1ExvJNNM3ySBUQ9kjnAOstbFJBJqT8L5Nk4kBgy3wnE?=
 =?us-ascii?Q?1iqaaduqQ/5mnZ0BA7V9WLOUwvzP0A6bbrp9ux6NINqfyPOAahtQZ3L4ljoU?=
 =?us-ascii?Q?o36OCJO2KvPr+zpCZVavf9IESITa3KU1+h1qTJKmLq9fMLWUQ2aD6Pr9Nvcw?=
 =?us-ascii?Q?FOEEDhlOJH8/AiQO0sFGSs0xo1lTkAT0bg8rDbAoveWgwOu5qrDs1aZnXIab?=
 =?us-ascii?Q?5N6yaXb9VqPiPcUcLX97b/hWpDKi0Phd/6/9fFsNMvtAd83VVS6J1/Jy3CzS?=
 =?us-ascii?Q?NjMF2yyefk4f5Xgdc4aZxHT58b8+5YpQkVMV8rmVHlspAwU6vxKbZbZ3iBi9?=
 =?us-ascii?Q?UmyISOAV+MJB9iDtgEG16SbCoAUcIczJosy9QxoMDPuhOd3BFP/OqRYgPdGB?=
 =?us-ascii?Q?6WW28fa8jeYitdc6Ldypymyz/Z/17ujGaLCVbXCCNkIa9lJbyuu5k9e4Rrw1?=
 =?us-ascii?Q?f5U8aObW4KmW2TaUpSPb4bPFE37PaPYWvZKotxnPweEaskQZB6aP9HJC2Maw?=
 =?us-ascii?Q?KdEpjiKLHVUPKvWoL/Q3AA0TI9LzGuiM9AyhVijCbe306+goqLIbuI1P777x?=
 =?us-ascii?Q?L+mL7QAHsSsDCWLjiA2KUgt/oyaKb22pwZni0sSW7/eJrOnY+wmvt1ZG4rcx?=
 =?us-ascii?Q?6dYqc3T0+SmwGcikGZcN5jP/+YZ3fCiaUid3RHR/+wZOKHjgKbzITDJVOKP7?=
 =?us-ascii?Q?27sRKtkcJH9JMkvFt+Fdi0u5yLWCnN1zBTMdSeG1rnTPj3Teseza2hszAFoX?=
 =?us-ascii?Q?0zYe5B4n8a9DdpPmyDpUi2e84RKqAmaIkQGFocowZioiIEGFpcZMRO4TvdVz?=
 =?us-ascii?Q?CEPBUTJga+NaOucfQzGJjd44O1cmYsUWjOH4mwgYmlhYxtX6q2wgumVudeXl?=
 =?us-ascii?Q?U0CbgIayxuaN6BTS+9vggt1chi/U1dyFbKWJCtdH69Zi27KSGvgbRcpo6Q5a?=
 =?us-ascii?Q?kpYTljwVI6BRVsg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(30052699003)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:02:43.9886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a77181bd-571b-4295-2ec8-08dd4c589d93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268

From: Cosmin Ratiu <cratiu@nvidia.com>

The underlying idea is modeling a piece of hardware which:
1. Exposes multiple functions as separate devlink objects.
2. Is capable of instantiating a transmit scheduling tree spanning
   multiple functions.

Modeling this requires devlink rate nodes with parents across other
devlink objects. A naive approach that relies on the current
one-lock-per-devlink model is impossible, as it would require in some
cases acquiring multiple devlink locks in the correct order.

Based on the preliminary patches in this series, this commit introduces
the concept of a shared rate domain.

1. A shared rate domain stores rate nodes for a piece of hardware that
   has the properties described at the beginning.
2. A shared rate domain is identified by the devlink operations pointer
   (a proxy for the device type) and a unique u64 hardware identifier
   provided by the driver.
3. There is a global registry of reference counted shared rate domains.
4. A devlink object starts out with a private rate domain, and can be
   switched once to use a shared rate domain with
   devlink_shared_rate_domain_init. Further calls do nothing.
5. Shared rate domains have an additional mutex serializing access to
   rate nodes, acquired by the previously introduced functions
   devl_rate_domain_lock and devl_rate_domain_unlock.

These new code paths are unused for now. A caller to
devlink_shared_rate_domain_init will be added in a subsequent patch.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/net/devlink.h       |  8 ++++
 net/devlink/core.c          | 79 ++++++++++++++++++++++++++++++++++++-
 net/devlink/dev.c           |  2 +-
 net/devlink/devl_internal.h | 26 ++++++++++--
 net/devlink/rate.c          | 15 +++++++
 5 files changed, 124 insertions(+), 6 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index b8783126c1ed..a9675c1810e6 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1561,6 +1561,14 @@ void devlink_register(struct devlink *devlink);
 void devlink_unregister(struct devlink *devlink);
 void devlink_free(struct devlink *devlink);
 
+/* Can be used to tell devlink that shared rate domains are supported.
+ * The same id needs to be provided for devlink objects that can share
+ * rate nodes in hw (e.g. contain nodes with parents in other devlink objects).
+ * This requires holding the devlink lock and can only be called once per object.
+ * Rate node relationships across different rate domains are not supported.
+ */
+int devlink_shared_rate_domain_init(struct devlink *devlink, u64 id);
+
 /**
  * struct devlink_port_ops - Port operations
  * @port_split: Callback used to split the port into multiple ones.
diff --git a/net/devlink/core.c b/net/devlink/core.c
index 06a2e2dce558..9d374d84225a 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -289,6 +289,80 @@ void devl_unlock(struct devlink *devlink)
 }
 EXPORT_SYMBOL_GPL(devl_unlock);
 
+/* A global data struct with all shared rate domains. */
+static struct {
+	struct mutex lock;    /* Acquired after the devlink lock. */
+	struct list_head rate_domains;
+} devlink_rate_domains = {
+	.lock = __MUTEX_INITIALIZER(devlink_rate_domains.lock),
+	.rate_domains = LIST_HEAD_INIT(devlink_rate_domains.rate_domains),
+};
+
+static bool devlink_rate_domain_eq(struct devlink_rate_domain *rate_domain,
+				   const struct devlink_ops *ops, u64 id)
+{
+	return rate_domain->ops == ops && rate_domain->id == id;
+}
+
+int devlink_shared_rate_domain_init(struct devlink *devlink, u64 id)
+{
+	struct devlink_rate_domain *rate_domain;
+	int err = 0;
+
+	devl_assert_locked(devlink);
+
+	if (devlink->rate_domain->shared) {
+		if (devlink_rate_domain_eq(devlink->rate_domain, devlink->ops, id))
+			return 0;
+		return -EEXIST;
+	}
+	if (!list_empty(&devlink->rate_domain->rate_list))
+		return -EINVAL;
+
+	mutex_lock(&devlink_rate_domains.lock);
+	list_for_each_entry(rate_domain, &devlink_rate_domains.rate_domains, list) {
+		if (devlink_rate_domain_eq(rate_domain, devlink->ops, id)) {
+			refcount_inc(&rate_domain->refcount);
+			goto replace_domain;
+		}
+	}
+
+	/* Shared domain not found, create one. */
+	rate_domain = kvzalloc(sizeof(*rate_domain), GFP_KERNEL);
+	if (!rate_domain) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+	rate_domain->shared = true;
+	rate_domain->ops = devlink->ops;
+	rate_domain->id = id;
+	mutex_init(&rate_domain->lock);
+	INIT_LIST_HEAD(&rate_domain->rate_list);
+	refcount_set(&rate_domain->refcount, 1);
+	list_add_tail(&rate_domain->list, &devlink_rate_domains.rate_domains);
+replace_domain:
+	kvfree(devlink->rate_domain);
+	devlink->rate_domain = rate_domain;
+unlock:
+	mutex_unlock(&devlink_rate_domains.lock);
+	return err;
+}
+EXPORT_SYMBOL_GPL(devlink_shared_rate_domain_init);
+
+static void devlink_rate_domain_put(struct devlink_rate_domain *rate_domain)
+{
+	if (rate_domain->shared) {
+		if (!refcount_dec_and_test(&rate_domain->refcount))
+			return;
+
+		WARN_ON(!list_empty(&rate_domain->rate_list));
+		mutex_lock(&devlink_rate_domains.lock);
+		list_del(&rate_domain->list);
+		mutex_unlock(&devlink_rate_domains.lock);
+	}
+	kvfree(rate_domain);
+}
+
 /**
  * devlink_try_get() - try to obtain a reference on a devlink instance
  * @devlink: instance to reference
@@ -314,7 +388,7 @@ static void devlink_release(struct work_struct *work)
 	mutex_destroy(&devlink->lock);
 	lockdep_unregister_key(&devlink->lock_key);
 	put_device(devlink->dev);
-	kvfree(devlink->rate_domain);
+	devlink_rate_domain_put(devlink->rate_domain);
 	kvfree(devlink);
 }
 
@@ -428,6 +502,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	devlink->rate_domain = kvzalloc(sizeof(*devlink->rate_domain), GFP_KERNEL);
 	if (!devlink->rate_domain)
 		goto err_rate_domain;
+	devlink->rate_domain->shared = false;
 	INIT_LIST_HEAD(&devlink->rate_domain->rate_list);
 
 	ret = xa_alloc_cyclic(&devlinks, &devlink->index, devlink, xa_limit_31b,
@@ -484,7 +559,7 @@ void devlink_free(struct devlink *devlink)
 	WARN_ON(!list_empty(&devlink->resource_list));
 	WARN_ON(!list_empty(&devlink->dpipe_table_list));
 	WARN_ON(!list_empty(&devlink->sb_list));
-	WARN_ON(!list_empty(&devlink->rate_domain->rate_list));
+	WARN_ON(devlink_rates_check(devlink));
 	WARN_ON(!list_empty(&devlink->linecard_list));
 	WARN_ON(!xa_empty(&devlink->ports));
 
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index c926c75cc10d..84353a85e8fe 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -434,7 +434,7 @@ static void devlink_reload_reinit_sanity_check(struct devlink *devlink)
 	WARN_ON(!list_empty(&devlink->trap_list));
 	WARN_ON(!list_empty(&devlink->dpipe_table_list));
 	WARN_ON(!list_empty(&devlink->sb_list));
-	WARN_ON(!list_empty(&devlink->rate_domain->rate_list));
+	WARN_ON(devlink_rates_check(devlink));
 	WARN_ON(!list_empty(&devlink->linecard_list));
 	WARN_ON(!xa_empty(&devlink->ports));
 }
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index fae81dd6953f..7401aab274e5 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -30,9 +30,20 @@ struct devlink_dev_stats {
 	u32 remote_reload_stats[DEVLINK_RELOAD_STATS_ARRAY_SIZE];
 };
 
-/* Stores devlink rates associated with a rate domain. */
+/* Stores devlink rates associated with a rate domain.
+ * Multiple devlink objects may share the same domain (when 'shared' is true)
+ * and rate nodes can have members from multiple devices.
+ */
 struct devlink_rate_domain {
+	bool shared;
+	struct list_head list;
 	struct list_head rate_list;
+	/* Fields below are only used for shared rate domains. */
+	const struct devlink_ops *ops;
+	u64 id;
+	refcount_t refcount;
+	/* Serializes access to rates. */
+	struct mutex lock;
 };
 
 struct devlink {
@@ -121,9 +132,17 @@ static inline void devl_dev_unlock(struct devlink *devlink, bool dev_lock)
 		device_unlock(devlink->dev);
 }
 
-static inline void devl_rate_domain_lock(struct devlink *devlink) { }
+static inline void devl_rate_domain_lock(struct devlink *devlink)
+{
+	if (devlink->rate_domain->shared)
+		mutex_lock(&devlink->rate_domain->lock);
+}
 
-static inline void devl_rate_domain_unlock(struct devlink *devlink) { }
+static inline void devl_rate_domain_unlock(struct devlink *devlink)
+{
+	if (devlink->rate_domain->shared)
+		mutex_unlock(&devlink->rate_domain->lock);
+}
 
 typedef void devlink_rel_notify_cb_t(struct devlink *devlink, u32 obj_index);
 typedef void devlink_rel_cleanup_cb_t(struct devlink *devlink, u32 obj_index,
@@ -307,6 +326,7 @@ int devlink_resources_validate(struct devlink *devlink,
 
 /* Rates */
 int devlink_rate_nodes_check(struct devlink *devlink, struct netlink_ext_ack *extack);
+int devlink_rates_check(struct devlink *devlink);
 
 /* Linecards */
 unsigned int devlink_linecard_index(struct devlink_linecard *linecard);
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 54e6a9893e3d..38f18216eb80 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -621,6 +621,21 @@ int devlink_rate_nodes_check(struct devlink *devlink, struct netlink_ext_ack *ex
 	return err;
 }
 
+int devlink_rates_check(struct devlink *devlink)
+{
+	struct devlink_rate *devlink_rate;
+	int err = 0;
+
+	devl_rate_domain_lock(devlink);
+	list_for_each_entry(devlink_rate, &devlink->rate_domain->rate_list, list)
+		if (devlink_rate->devlink == devlink) {
+			err = -EBUSY;
+			break;
+		}
+	devl_rate_domain_unlock(devlink);
+	return err;
+}
+
 /**
  * devl_rate_node_create - create devlink rate node
  * @devlink: devlink instance
-- 
2.45.0


