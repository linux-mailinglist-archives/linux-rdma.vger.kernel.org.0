Return-Path: <linux-rdma+bounces-18577-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLi/GRmKwmkLewQAu9opvQ
	(envelope-from <linux-rdma+bounces-18577-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:56:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA9C308C3A
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C43B306900E
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 12:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2D63FB074;
	Tue, 24 Mar 2026 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YK98mlM8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0283FF8A7;
	Tue, 24 Mar 2026 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355520; cv=fail; b=HA+faQqb0yRerxUjbjdHDla/D+salvEs64BGiT3WMVAAC+op++Vp7b0N1IJaYw6MHn8bm2J+a4VU1tgHHpvnAvh2wGdOP/fQav86RxBb5reRXDOSosfhwKShBCKtCpoNFUtpbslZBrDulo0hqUsvOoIvYVmwRoxU6zv72G/QAhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355520; c=relaxed/simple;
	bh=4eeUc9RIHIgWXag318UGpUedrMXCEQ+cUkvCB4gfNTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gfmx2IPWBXExIqGeOhIcYKx2eoPjhXwP/l7d5QYBSfglE5BlM/cMzIR/z4rWZRLaBF0HDhbZe6DgQGS7wKTm7diqI8WqLw9ov3KY/kijh//BLtn7QDFAg1yosjhM4Qrs6CLjcHmUFq55GSDOl09NwmvXN50n7gDFEJcmdBZoHVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YK98mlM8; arc=fail smtp.client-ip=52.101.57.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=may//gz0jxHyISvcygepgM9i94KRhZ0yyPCnm6qIMJPcZcHXIG6N+NZo/5eqS/vQhvRcnG2emix9BUvIbZJQQMDKpQrfmBQWncyWYsc7meHUwc5apUbEOizrnYKgLkm1NImvVlleUCc/iLu60NwJL2y0A0rMyYzvoR18XeWkOVQTN+FrP52oHqy1kZ7o9WPyCrz7DvDep+l2Qlf17JSIreDl8/xnqU+c4qo+n+Qe0eJsJNcrUinz4OhnUW0r4XInZ5AEZMAGIY2cOza/tZEemfqjCQgyZZU2fwpbrb6OHZX9o08zJLIWUR14FoUcr6CPxVFm8yM7HgdOO8M1WBsCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2unoNL8G4Xxr5VtprXpzS1NFU/fJvHFzPSMcT54g87Y=;
 b=vFgQfJGoWi2A2CVkW3Rff0vTt6plkbXoETvwhosrKBz+orveSZjT+fGrDdGLcrvSbJR5mf8XnSSjAMd9E6VvTJvdAGkcMJtJEDkMlIOTrsG9JVU97luh23cOyuHByegK0qpF7xt9UtD8mk5qIFKSQO16KF+owEgUVpVFEREDJws2V7RH2F12dg6KKJ50M7ScaZnhgBPA3UjtkAMS5dhyJjWdMU03NulUYs4udZ93F5heIYS/adN/gNIfl1J9RBPFal1yJFc6GJiT6yHVNxbA3xUbyK6W/XRVSuHP09dHziBN/+jt2u90QZhQiWdxhgcw1IH9eXWwfTaabBdmwWsb1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2unoNL8G4Xxr5VtprXpzS1NFU/fJvHFzPSMcT54g87Y=;
 b=YK98mlM8wDnSfqf/0c+sLnDVYZqxjif4/V6xc5OMpLgN/alcApCF+fd4hh5vyswcoyPhZjfMc0BpN+RWy0kqVmLWjHPmDPVzRdCz8lSAwVP7jPqnyTCghWV7Mal4BvR1iHtDYiZX2Yv4RIFqsi6N8hrjBTHo+2W7dkjljZ9oOrbulF33dNJUItArMSa1Y9rXcdWPPxgq/+iSwl+DypHVLIdjJxfATXndDGt9iF7dTyunlGbU1xIUbgTEOuUbiCgkbe22ikF/oo7hQKyWd3ADYX4ZcX4QEwSTsIiGSllhL4vT9kN8WB02ZnnXz8ClYB/MxkoRHkZLGEkrL3G+9cugsQ==
Received: from BL1P221CA0038.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::9)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:31:52 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:5b5:cafe::8b) by BL1P221CA0038.outlook.office365.com
 (2603:10b6:208:5b5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:32:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:31:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:31:34 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:31:33 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 24
 Mar 2026 05:31:24 -0700
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
Subject: [PATCH net-next V8 14/14] net/mlx5: Document devlink rates
Date: Tue, 24 Mar 2026 14:28:48 +0200
Message-ID: <20260324122848.36731-15-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 5270c316-bc1d-48f4-6760-08de89a153c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kwS9lbK+r3gk9nxUpR5TbBUxvpOpGjEqQ0KNtmCvwIRCIMOjdmtPB0emx71wKH+tf5YNH+3gQtsXETYxoF6v6u/ulO0Ti7o8ghpT0hiux0rIAKWDQBGC3SnKKGGT/u5X3PNhZ5+jtFZ/DsRG6g1u3KQfRV3lkWjrpiEOZ8Jo8ehnpmpcfLUdMZY9LqaFl/n4TpQ58wtJXgfAtvn95pQCnOHI4jh5V2c3Ywd/PAe/TIkgBQMtUfCArPrP98gI0O+GFkzfAlsDPxnfi4yRJo6xSqNTkE+fsJDt+CFji3cr024+oIEVrYCeIiq7kt6aZrijItYmu21beeUoahI4lUZHpqiV7kPM9Pf3oM1D/o5r/za/XBhbFdpJIEFl+TKDcc/Z1U2eCcepevtRl5kYUjfiY96Neap9Plkv2Yw8ziPq+4vhp8rnFo0PZ4a+cdP2OEl6AsNTbfgryk4eymjXcYL6exnesVZ1Arh3SxnaF/KmCfuK+YT5PF2HuxqiKS3An2Pbi3g+YD6tHY4f2GHQNhJD6Nx5yGcHaQZEbMuEa+dOxzP0aHyAdXMI3HoTq7JApV9nvCxeB3OT69VabztohazKUZG8abwTn/YP3YVXz3blWRIcpYm7zllq4hWLTxMB4SwJjlYGRNxtA9xhOZBTChHSCgjjuKIT/G7tmqPTbl69evAG1N1CUEZS7dtgxyAAZ7vBSi6Ae2/2mL/a6B3mRVeCgmzfbLU57clH4LiUcGP32VuAS+csC4Bu+6cM77o1QYQYhX8Cg8M0GSe4WIeiBeoZew==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3U53vmerjCxiqcHdhQQZcwBIjxDiawBOdtHZaZ6ykoY87NqHqh1Hzdm3x0FEKNXQfLPa9D3lmzt+P/mjiCl2XiwXk4ZDPvtrE5vPWYt2pr1zj36Bjq2VUbVZ22aFkX3ZpunmF23JnxV+2D0SY7kTn7EHcmdHh1sOdKJo7uaQzUjc6GeUCvnRwR+6OLmJmbMcNjb+z+FolXLtHRPZfupaBAXMtSEAFnd4HBNluG+jTx6CC0WowXzz7GWeZXKywZk42EF4hmsUdsuH0T6XEB4uNzrgpMXVqEsr9udKFpU2j2qeQmuO2pLXX/mCI7FyrkCp0YwRzTZMAXKilt4BSbEFD90v44Wl22sHRVvrWDutw5aCPcPsEMFNWDM0tXWCD2GUop67R47//SWfLaj/oW8hlUS+gmHzU6qOVwcy3i5D0DglEi06A/QEfDEOs6ql9nlX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:31:51.9508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5270c316-bc1d-48f4-6760-08de89a153c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751
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
	TAGGED_FROM(0.00)[bounces-18577-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DEA9C308C3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
2.44.0


