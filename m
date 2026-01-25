Return-Path: <linux-rdma+bounces-15979-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGNlHm4BdmmMKQEAu9opvQ
	(envelope-from <linux-rdma+bounces-15979-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:41:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC25880667
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45F3830263C9
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 11:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996C23254AE;
	Sun, 25 Jan 2026 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rxLNHXgg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013041.outbound.protection.outlook.com [40.93.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D25631D757;
	Sun, 25 Jan 2026 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769340863; cv=fail; b=eIU87rCb0HGVPgTrNuZgXcHfhbe8ioiu7AMo6Gzkaf+wFjt1KrDPMtMIwVSWBv7+P86/8OafyrFDQFa1KHe8c1juQhr4UFRHTStA24hGnDTvVFz9nyYhD6SBviOY/nNrdUuEA7oDQ+005tvjFreBI6kmholMuT5rNEX/4oPRMsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769340863; c=relaxed/simple;
	bh=dxlh5YyTOfK4DvGzGWvL8KQu3ph2gkHdjwHoTnaU1oY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KH4p3zbuwBL/psP/PniAb3TJLua+lrfPMjdSvkoOpsiThggNDDXszoDsFlcBeZazxcTAxtdsRlBd6VBroLkxSQy1jyg0PyfrF8x+Vj0jtVmyTR8b2xHKT7+APb3semB4vuwyfNGtYxc/0yLnvZAk0mrltWa2r67O08GKArxoqJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rxLNHXgg; arc=fail smtp.client-ip=40.93.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMR+irsCesCoAMRH+XM1La0rV3z18ZkH6ByOJpvFjoQo6hNGkwBAaMiwa3IEHyv+GHAj+ajiQKjZmZwEH+QjQdptuVrHc5/XS06Rd/QCA2vnKy5GeB3fsEkARd/5bDZQz2r+A5JydOE3btULei5U1j1e78HVGK0a0OcELpP7ZHmKbVILQAWXCXGUqOcFY4YmzawOiuX4SV6JwLgXNr1TagpoJYI8BYWRPRskZPiUfPk202Fs+/DrdhN7ajBtzTHb2foOJrxlZQ7GB9HPT9S+mDo9A1V52XeV9p24CiQY2e+YTVwP+z9j7DBkJ4AsswWvj8282wev5pSX7YH+wvKufQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ce5dEHSjywL78gJeDDj9zyYKTZ+kGi8pLFLq/25zV0s=;
 b=GohlrJR7phP17KpOgDsCIdnqmxu1FAgby04FIId0I1rxnM3rwdMGePKlcH4famz4wfvHWhU9UkrtBEyPg+kQAthwvd1nbqtmWyOC0sZpY1gubrV8WdMt4Jd8/OrMUErHM6R102rqbkFI66CR5mU7uvViv8fZxMRne2nL6KfVHLPRAMLinBrLGaIQakLM0td67Ytys3oMR2kq3Ay5IdCSoYNAuvp53eTDa/2egnZ4hqy5RZ1d83DusJ9a1fIXdzrSlPpmTDCLvyXgzY5lbtQ3fPo1YO52dTmVVN62I97J16QTh6WhmYCJV1G+NfzeSezrHBhsX4DyjFbvZG+vEnhZ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ce5dEHSjywL78gJeDDj9zyYKTZ+kGi8pLFLq/25zV0s=;
 b=rxLNHXggk0teYOn3jLUGJVzl6azeI0wJ+gWO7OYKyrjdALgQ4C7bzfKOos+xbd45JuPqLD1Aiy4WgEWspW2o2vm24/Q1GKsAEue3qRM8FajZmpdb/Gj6WOkSKF3ZMOMcVeRKkBzwQW+BxdG2w/LPxiZ+aXnao9ULz6oFUMzIW2rRUNhGe4MnhL+OLNwWGO6rcCmD2AjtQ1w8we4znkKoz+gH5C9G2OsJcbzfbS3zmU1Q+IUkUus3645kBpQ+R9/9nM8p891bjWs4NeZkVuCIeqL5fH4YBdq8I9xELgzmiGTax7QULdMHpCKG0YoAKFnuCTolL3a2xld6jytemOCTsA==
Received: from SA0PR11CA0129.namprd11.prod.outlook.com (2603:10b6:806:131::14)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sun, 25 Jan
 2026 11:34:17 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:131:cafe::1b) by SA0PR11CA0129.outlook.office365.com
 (2603:10b6:806:131::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.14 via Frontend Transport; Sun,
 25 Jan 2026 11:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Sun, 25 Jan 2026 11:34:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:34:06 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:34:05 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 25
 Jan 2026 03:34:00 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
	<rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, Krzysztof Kozlowski
	<krzk@kernel.org>
Subject: [PATCH net-next V6 14/14] net/mlx5: Document devlink rates
Date: Sun, 25 Jan 2026 13:32:03 +0200
Message-ID: <1769340723-14199-15-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1769340723-14199-1-git-send-email-tariqt@nvidia.com>
References: <1769340723-14199-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: b67969c7-13ea-4a90-ad3b-08de5c05ac60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4fONciB26mGnn8InAGnFhhsMiPEEHq4lSQuFSvIgW1JbAeer8LL0YDHQE/jU?=
 =?us-ascii?Q?7xFdqPb7K808ztqSBuV8UCq+5phY6jLR+9TUwGU1lrop2xUG1sHPnoszZ/k+?=
 =?us-ascii?Q?8yOSKujw5QeiMDv/jj6mAp+R/0fwpg96cAH0oOvoqZpFCdfnatXNYiEpDIGB?=
 =?us-ascii?Q?+ZS56S7+zm2d5P4bm6F6IGdWEqFgcV/c7wd8d0p4sIgfLHZRPbWAq2kDJswc?=
 =?us-ascii?Q?3ZkrtG/ksLUE1nXycywE6E+0k/S7L55sAZs6gB0mA72zZfenZ55jCsEev3I9?=
 =?us-ascii?Q?ji51DjWvb7BOze/chlbTPcuAJ3DBVSLjxy/Te+wCXZlsbHvcjGsgavkFk70D?=
 =?us-ascii?Q?zhV19YPY993/lvSOYf0wyQ39ot+f95IIY8UFjtBxpHGC+rBDKEwJ7smbHOKe?=
 =?us-ascii?Q?SFTsKE22rCnt71k15RnfniDjWNx+GzNCYtZXr1aG9wo0nicUZ6CsrU58d0An?=
 =?us-ascii?Q?LnUijARuSvWZXeVmuVGch/AR7tT6+Gconzf6983SQLLdrerr7biKDPZwsQ3Y?=
 =?us-ascii?Q?oRO+7kxRUbynBP7HZ3q237wK7GFpA6nuN6MtYLP0wAe5TY0TA6jYdumUDlMI?=
 =?us-ascii?Q?ZdGsz76PAc+gaD6JiiV/L6PKfJeMZQLnUR7SR/fEEkzyxqayO/+k5rOMd+Tk?=
 =?us-ascii?Q?iGVcCLcFSPCukGRJbtHjngfxyQRXjbJeoThHSF9LAnGmN5tm8AI/Kw4taiGl?=
 =?us-ascii?Q?CcRawjxdpnSahK8vQZ+sQq6pMiKgvx3zyK+N01uPygYgGsPyGyV4RxTTTS4B?=
 =?us-ascii?Q?t8VQ/DSvuLjJxI3Yj8ljqz+/klKuf8nD9OHradK4D6ectoKTwbA7XNaKW6IG?=
 =?us-ascii?Q?ADG9xOgyqXixUfQzY5hxQsPx6iea5gfKa41uI58PHJEdKRaBexXk3mMWCAdj?=
 =?us-ascii?Q?4mPSAOqHI+/ksEmzz0emSXwFvlMOG4iD5d8LxktGitsEtw3a0Y6Cyl3MB2oU?=
 =?us-ascii?Q?C3E9z7vcHZjG74DtAfZ1J///Z5vcANPC5e8kgWrNkGWgRVNjD/ja3Sb5cofq?=
 =?us-ascii?Q?TGiFaoJRDVxFA2SseE3ve17pB4F5w/XtwB0DXZogFhvHzTiRV5u1AgrDIye3?=
 =?us-ascii?Q?RTOpeSorflVouio5OTsWYr6TPtCeGva0SZe9+RyMOrFzOHfge6KbeBaR3CIR?=
 =?us-ascii?Q?AL0xe9C7s+qeM/jXbsyRB0E1HMvAsxePdn7pz5CAm+tjNoz9pCFi4JqLNOGy?=
 =?us-ascii?Q?JMWH752hAtCttsHkwQ8KoHf4Z6RouRQ9ZyalKmyjgbnr0Stk4dmgxJTpqlCQ?=
 =?us-ascii?Q?y4uLmRXz2xXG282Z5nm6i74qKk0PPYo7XgcjJtBNSgiSKHZ8XIH5PytXmdYj?=
 =?us-ascii?Q?SaPhFzPSeYvelKU1ytuqeuriPxLF7FKG1G+FysIxeqYT/ntkwHRJIfRbk3LH?=
 =?us-ascii?Q?xQOCKEoE1RxF3O25iEn5TPFEWTTYySSY9lUwgBfCvMXMvh7/5+SP461DUXgI?=
 =?us-ascii?Q?YSMa/ngxJHyzavfM4A5EDkZfUxp5ZlyxY8mdw5nwj+sTF8SbWTz5njO6KHxa?=
 =?us-ascii?Q?y6lF+Qd4Sg0OgD/P2A71V7PUbxyEaaAcRnMQVpAGbgZllrLIDSBv+CjCsQif?=
 =?us-ascii?Q?y+DJRgmRSV/WY/4DgqNiuk5btWsjm7eeaaOcAeanL/i/pU77/Javt0c9fpgT?=
 =?us-ascii?Q?Zr3qWN2nO3iKW8E/sZUO2WQx9Qpvo39Rv1PdDoq3PTTNhKIRDGKtsxnHXkN1?=
 =?us-ascii?Q?gS34pg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 11:34:16.8430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b67969c7-13ea-4a90-ad3b-08de5c05ac60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15979-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DC25880667
X-Rspamd-Action: no action

From: Cosmin Ratiu <cratiu@nvidia.com>

It seems rates were not documented in the mlx5-specific file, so add
examples on how to limit VFs and groups and also provide an example of
the intended way to achieve cross-esw scheduling.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/devlink/mlx5.rst | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 4bba4d780a4a..62c4d7bf0877 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -419,3 +419,36 @@ User commands examples:
 
 .. note::
    This command can run over all interfaces such as PF/VF and representor ports.
+
+Rates
+=====
+
+mlx5 devices can limit transmission of individual VFs or a group of them via
+the devlink-rate API in switchdev mode.
+
+User commands examples:
+
+- Print the existing rates::
+
+    $ devlink port function rate show
+
+- Set a max tx limit on traffic from VF0::
+
+    $ devlink port function rate set pci/0000:82:00.0/1 tx_max 10Gbit
+
+- Create a rate group with a max tx limit and adding two VFs to it::
+
+    $ devlink port function rate add pci/0000:82:00.0/group1 tx_max 10Gbit
+    $ devlink port function rate set pci/0000:82:00.0/1 parent group1
+    $ devlink port function rate set pci/0000:82:00.0/2 parent group1
+
+- Same scenario, with a min guarantee of 20% of the bandwidth for the first VFs::
+
+    $ devlink port function rate add pci/0000:82:00.0/group1 tx_max 10Gbit
+    $ devlink port function rate set pci/0000:82:00.0/1 parent group1 tx_share 2Gbit
+    $ devlink port function rate set pci/0000:82:00.0/2 parent group1
+
+- Cross-device scheduling::
+
+    $ devlink port function rate add pci/0000:82:00.0/group1 tx_max 10Gbit
+    $ devlink port function rate set pci/0000:82:00.1/32769 parent pci/0000:82:00.0/group1
-- 
2.40.1


