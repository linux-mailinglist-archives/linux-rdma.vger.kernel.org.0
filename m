Return-Path: <linux-rdma+bounces-19106-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE02K0tf1Wlq5QcAu9opvQ
	(envelope-from <linux-rdma+bounces-19106-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:47:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F753B3F6A
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74E5E30F2AC1
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 19:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8DD378D79;
	Tue,  7 Apr 2026 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ing7Xr3H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012017.outbound.protection.outlook.com [40.107.200.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8194C3783A1;
	Tue,  7 Apr 2026 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590968; cv=fail; b=QhOf9oZlZBbUsJmnHwphvTeMqWbK1m6H++0N59ONGcVpyxh/YVIQIUMUCltDPVVjvaDnCsj3//fYZQWQH4JVSwm9WMBQ4MoArrv3lMig5LBwnL2/5F3w7diXpBmtOyCKVQhrTsSdWan8ElYFIgQvHTc97FveBd6DfZDKRqkBRCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590968; c=relaxed/simple;
	bh=J01E6J8KuHlCjJpbMhIzPfQ5OWBz6d68lMLuqM4TmJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIu11PJMnwrCko4Irl/wALCbhyMNZ+d7h9WoBmmUObleArFfSjBkp6yQjlwavIUtf5UgihG8xec7VsXatG5orlk6RueNGLvdP0PecpqmtWd+rpqcvTS1K7CsILtNdKqzO7l1kpECtE+kQ3koBcqWPoEvVSxIaffZKtFivDDiTQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ing7Xr3H; arc=fail smtp.client-ip=40.107.200.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jA06OJ9n4iin/Hr4bA7cIOtnvgSzQuQ4xR9F99J8whQj2Uk+/3y23PC1d0VFQnLazc/vJ9qinP+C72flBIEOzy3ce9bcUmH/1viN1sfUaARijl/bIXT14MI0AmFRSp02O0BKqD+joRJBOmrmDpihoz2vfkIjNZNXEwmkdGm7sJaydKOh/fEg1Kr3rTuk+7cNIrHL27+PIlb/76nfJG6spSSUWfw5MN/zjOfx7JRX1uSchHFe2sQ1rUfvqo84A6x28cT6DPYvMDVAt5vr3vA7SS+YMR69iF1xxenlr7zu40ZOQFezU51c388X5blhEp7TsrkYZY+2u/aOv5VeBjlOdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMTQnsGi7AHX0t8/FTdHAzIaS77LISeKREG8kwQwz0w=;
 b=mI3s6AvRlyjMA/zeFgPTU+RN0YOUVNaWbXvB2xJ20G+TzsGq0D4pY/s4fcSgsz7cpG2kMbPSuF5l1zPT+qWFydcz0g9cRrbjtr8UPqvIGoa5Cu5sHKKsotPRWDrltHMLtw7d+JoseQ0QUxoDY3a4IiWPjyliSj7ZUlXG26DbrUVNNajI1RWbKamtfPsp1956i4eh/8/DbW3rAuZNsHgF5RRqlnpa1Cn1TyFKmqZKTsZYHlp+AOKhm3YriIspL6Bd1M318aC+0pQ08ntYpHJ4/O0Zn37avpcXs3lfxj818s+Xxi0mLAhe4ylFe05hMX1mptN0RiyDTY6/vaXQABid1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMTQnsGi7AHX0t8/FTdHAzIaS77LISeKREG8kwQwz0w=;
 b=Ing7Xr3HwvobnQe7R26yWJ+dXXTD19bRGdd6Dh9XvTWlvw1F2cPILR9Bd7Z1XpJeB71tGfSFZMHivng/RXGmc+htZXRVYfGYgodDlntUW2YTf2sCgZO6qEsnTKkmesW49c9MSEJNr/oI/YfJr4vLLoZYBBSMjdokfvHiU1nQgkPlCgSbf8RQxlYsBLObExmxMJVmatLcvuNVmAtLdd1eOgsykZd1Eu9wYYmCVbSnipcR2rWs/3zYNUsjZHsScr8Gd8Nu1vv8cspblIsgjsdtTPRQrW5QmRHKAeDxn4wO/xCstWEM1hy+bYg7+N6Wfx78ZPkIFGl7u/PoSMMdPuJ4xA==
Received: from MN2PR03CA0026.namprd03.prod.outlook.com (2603:10b6:208:23a::31)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 19:42:42 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:208:23a:cafe::b2) by MN2PR03CA0026.outlook.office365.com
 (2603:10b6:208:23a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Tue,
 7 Apr 2026 19:42:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Tue, 7 Apr 2026 19:42:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:42:21 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:42:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Apr
 2026 12:42:12 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, "Matthieu Baerts (NGI0)"
	<matttbe@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Carolina Jubran
	<cjubran@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Daniel Zahka
	<daniel.zahka@gmail.com>, Shahar Shitrit <shshitrit@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, Parav Pandit
	<parav@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, "Shay
 Drori" <shayd@nvidia.com>, Kees Cook <kees@kernel.org>, Daniel Jurgens
	<danielj@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V5 04/12] netdevsim: Add devlink port resource registration
Date: Tue, 7 Apr 2026 22:40:59 +0300
Message-ID: <20260407194107.148063-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260407194107.148063-1-tariqt@nvidia.com>
References: <20260407194107.148063-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 95dafede-13b5-4207-ac19-08de94ddd583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	PGFayYKNPlNTlAtsW0xGmpOhCUMQ9wsRLpnjXfMOKuNC5E7ukXaLk5JFkuSSc5/wZ6WJszDcWo8E5GRTNkoMD5Mdt4h31UVYEVYddMMRhG0lVbZJMR+u3dzOPsW3w1VfxoVdDnwginoRHUpDWKw7Br43Of/pQzNz7q3e4Ueqqy8DgP5CEr5hgw/H0tAOHrf/797qpENmY4drEx1cpIoZ6e7STPJxAsf6zraG2zlPPsMM7Iatt4SytA1/ZrV8dmo8T3s6tFTO68dxH4yL7W7+DTp7aii7+L/o/2v65xbV0tYoV4BnGc0TfI9daapTicIeehwwQDoC+Y7ImIHXeItGfWNK2EjI/JZiA91HcFpWSWF5FVuj+0i1wdDDgVlpvJPv0l0yM+xwlhE8iLXMSh4zLfUUxqokASbRKHgCrkoGcUbhxtCOm1KPSZ60T3CE+9Fva0XZek8UE/E0EeX/NGEWbJBxRRhedZZB8mgE6kQ/4xP52BwTB/t1Gp2fEmWeqeRTDbo45LkIFYWJJPbeVInwrMR1SdEefThqjxqKdI2jOFFdjNqBHs6/8dnznpXt0oicYHV9D8AYPXNWVj+0/YjWNxPv3xcv0N1ndVF1udlmWZLxkuQz8LOmRseOtPZi+ksu2YZ9NbTadELKr2foASkSitRa7R0aI2bs40DS6VCDgDEPid2NTcW3sKyfA5i1R+1lCAudRCKIPMcujBDKYQTWojwEvDRd+YQUfHI/dRCAntquFe15JqBMMALBOHQRaeGhtVqaMI5yTWYmDz/aSKbCaA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RhUCKeL+wxQaaplq3A0qr3P8mztyJhTgaN9/97cgC8dIZQBGyxEkaFtVzWvU25vGQ9/ab6VX7RtwrjpkW6tQzUhKF9ZCx7g2yfu7103gzvCGN+Yhqb89cb+GjlAq1FOKkwLHAz2+ex2cuHs7eB0XJ8SAvnQdYzV957ghYy0i0YyGRqT5jcvjB7MJNm85yvxxXoN0oNQKM2vhhCdw6tDu1TVvSCCyqoS8IrXaEaCx5Da+9Ll++3n4+xsFn2mzts+xGD5mJ/121YZz2+JeAADUXFPVJRavKsr9N6bJ/YT0I4SZp9nlwI2i4cBmDg2gwAlG0W3XLwFfVzqu4ZniXFG9mcuQ/bf3v4YpAxHvpJ1T/lTCps9hTtO2oBHlNW8D3qt1L637ZlecYyK+fjgZWxIi5fteZx3x8IEgnLqiTdfNxvxPbr2eL+INUEC+dhrT4NFA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 19:42:42.2016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95dafede-13b5-4207-ac19-08de94ddd583
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436
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
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19106-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 61F753B3F6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Or Har-Toov <ohartoov@nvidia.com>

Register port-level resources for netdevsim ports to enable testing
of the port resource infrastructure.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/netdevsim/dev.c       | 23 ++++++++++++++++++++++-
 drivers/net/netdevsim/netdevsim.h |  4 ++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index e82de0fd3157..1e06e781c835 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -1486,9 +1486,25 @@ static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_typ
 	if (err)
 		goto err_port_free;
 
+	if (nsim_dev_port_is_pf(nsim_dev_port)) {
+		u64 parent_id = DEVLINK_RESOURCE_ID_PARENT_TOP;
+		struct devlink_resource_size_params params = {
+			.size_max = 100,
+			.size_granularity = 1,
+			.unit = DEVLINK_RESOURCE_UNIT_ENTRY
+		};
+
+		err = devl_port_resource_register(devlink_port,
+						  "test_resource", 20,
+						  NSIM_PORT_RESOURCE_TEST,
+						  parent_id, &params);
+		if (err)
+			goto err_dl_port_unregister;
+	}
+
 	err = nsim_dev_port_debugfs_init(nsim_dev, nsim_dev_port);
 	if (err)
-		goto err_dl_port_unregister;
+		goto err_port_resource_unregister;
 
 	nsim_dev_port->ns = nsim_create(nsim_dev, nsim_dev_port, perm_addr);
 	if (IS_ERR(nsim_dev_port->ns)) {
@@ -1511,6 +1527,9 @@ static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_typ
 	nsim_destroy(nsim_dev_port->ns);
 err_port_debugfs_exit:
 	nsim_dev_port_debugfs_exit(nsim_dev_port);
+err_port_resource_unregister:
+	if (nsim_dev_port_is_pf(nsim_dev_port))
+		devl_port_resources_unregister(devlink_port);
 err_dl_port_unregister:
 	devl_port_unregister(devlink_port);
 err_port_free:
@@ -1527,6 +1546,8 @@ static void __nsim_dev_port_del(struct nsim_dev_port *nsim_dev_port)
 		devl_rate_leaf_destroy(&nsim_dev_port->devlink_port);
 	nsim_destroy(nsim_dev_port->ns);
 	nsim_dev_port_debugfs_exit(nsim_dev_port);
+	if (nsim_dev_port_is_pf(nsim_dev_port))
+		devl_port_resources_unregister(devlink_port);
 	devl_port_unregister(devlink_port);
 	kfree(nsim_dev_port);
 }
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index c904e14f6b3f..c7de53706ec4 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -224,6 +224,10 @@ enum nsim_resource_id {
 	NSIM_RESOURCE_NEXTHOPS,
 };
 
+enum nsim_port_resource_id {
+	NSIM_PORT_RESOURCE_TEST = 1,
+};
+
 struct nsim_dev_health {
 	struct devlink_health_reporter *empty_reporter;
 	struct devlink_health_reporter *dummy_reporter;
-- 
2.44.0


