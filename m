Return-Path: <linux-rdma+bounces-17252-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJYrMErHoGnImQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17252-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:20:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 858BE1B04B7
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 434C23024919
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 22:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC38478862;
	Thu, 26 Feb 2026 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eWpA3VwC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663E03A1A4F;
	Thu, 26 Feb 2026 22:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772144419; cv=fail; b=XwwYl18/+TqJikxkHRLC1qe/tcA2fkgUOCy9brDCMKdsV7ppfphlsgkQ+JqXhI0DGJ6XPzB9/cEGuF3aFHL25rGfhiXv5qYtWvRKgkJzG5fxd6EDsdBqYA1T+0Hmx6OIIsXm1Gxh90KTjvo6HN0tl/afUsLwsUdKdrpsYIPCLT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772144419; c=relaxed/simple;
	bh=kwOD2oMWb2pWcLkxnSvecyZR7tnzSv9DBEFYaxMKRKo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=URI3EAv4aK9H8O6xvmfQpX2F2HZJRkvz0K4T8orIbN1gmd7AlQOE2ap8eQVUIJ0TAV2G6DNnbVP9BCm2r6FvxyJzrFzVcTwYhFP+zG+rnJamUQq7iTRERXS9Q0a7PK2K87h9ysTOAVBSssCB7Jk69/7GH5QMYRKBHol1VF2gSkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eWpA3VwC; arc=fail smtp.client-ip=52.101.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZ3Xec6X+AQ/HJGTXNEnCv5ZkOU0bf4Scd5WVVaOLrrHo5pUgNcM26Dw9TOgj6DTFsDdDreaRgIrTlKYH3NtdGDZMgVy7B3uUHhw0VfPPcqeUAiwPs9C8Cz3liggAfMqrHp2U3yZb9IuQ4P6lW/kF3c2TXHARuKNNdoSC02GoGEsf+mCYWAQ1beyyKM+zY2pNPu1MrEQgvH/dWoJg1VMPy1B6sGn2yrHZ6Okia7RHWAxBIpmKGMCcXW2vyQ1u+NeodEzBtWiEowhsPcdOAcEp3JomS5shPcCiTo1c80Ryq8WJuyT9GJ76nM8YapkcE488/Rmd98sZyweOV+ayqJH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUvSjPbCmlMD9rnDGyjRRxi15wuGA9ghauSXSmpkaWk=;
 b=PlhXwrrHwm6oo4fXciyLnS2NzpkRBn0/6G0oLP0OxNgH2I2di5hOZ8cpnGBCBX7UtpXPvdEVQhStVzKQ8w1RHjVIHiGsqo6TFvaubc/D2zcG4KoJOtVBp4PcZLxO7sPVqufTzEJ/R5g0LoU3Nib1LkAU8t+memMBvn07wWZPW8F1/dIcB8YxnAWtKls4dgM4ZTJ4rGbRUB2tLLb8Af0+DOQlqtEm+iASid5UCAf1gvCKCGG02+tizg7FETVXvwEklpxpVYdB0z08g2GN8xgXusOXtYahpEOTbTgmgMoO4G9vQ/Xi60Qp+pjmqKy246M6+C5wfHEWrYi6CrV9XNfVOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUvSjPbCmlMD9rnDGyjRRxi15wuGA9ghauSXSmpkaWk=;
 b=eWpA3VwCqfE7etVeuZbtxFzc28WZPhhW+d3fijRPccPCKXT5/gjrnh/l+5X0TsYUK+v/6mEuk2It0Fy6xpdzADaqTYQl/kX0jnTz0DqNojdgJiCIJrndR9XfYfSPIXdzCHviHs/WcE+EJq36doeeevNSsdjK3R23PGmy71D2CJQvhTs5FTERjgg9bG3MwB51vTMrLm2JrcOQV7bgd2L/5psFCNwU2yRB0A/odDAu/GJ5ew5gBybcJryEq9YlRD7vzEVQJBQNFSTrwInrCqfGCx6LHsIBQ+GD0QdKjH6iGj1zsZt+5JTOkzW4cK6dKDt9pmC3eVDsxBfvk5qs2EvMpA==
Received: from SJ0PR13CA0038.namprd13.prod.outlook.com (2603:10b6:a03:2c2::13)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 22:20:06 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::17) by SJ0PR13CA0038.outlook.office365.com
 (2603:10b6:a03:2c2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.0 via Frontend Transport; Thu,
 26 Feb 2026 22:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 22:20:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 14:19:45 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 14:19:44 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 14:19:39 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>
Subject: [PATCH net-next V3 03/10] devlink: Add dump to resource documentation
Date: Fri, 27 Feb 2026 00:19:09 +0200
Message-ID: <20260226221916.1800227-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260226221916.1800227-1-tariqt@nvidia.com>
References: <20260226221916.1800227-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|CH2PR12MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: 712e18b8-8c72-431c-6bc9-08de758531cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	8Zg9PeTVP0SwnwfzpTSS0ZoRbgdqqlffzmQMn2X+JSG8FPC2CouOuR4C/omZhdUrlw8P3h9Q+5QGxKkJgro8XeuNlTv5YP4+rhxwtGiVzcZDIwm+JXbYwNDguLp+Ggtfa1Y7145zHCp13i12Z+IkZ4935/Nxzc98bIqc73qOQ1Aq9WR/kwJv4cqwtSrjw5u3EJksPfyBZCplEqn1glY0SoCR3yjQG0S/th9aPBc9TC2VPdXbpHwt7SyQUS5HZoN6A4qoUWO6pWnVGA3ZY4GmifrTK34fuFYDxjn+an4wM/5vcVQQruy341v8zWjA2In7AluSjKfXFr/WUI5M9aBmUrTbmIQlPX9KvFQ+LK+ztHTaIgZ7HKg4nxIQ6Kfk77Dh2xs0AKGMflzDeYGMehJ8/qMYP9RTD4bL/6pAuzNQwavYniG0BltoZt3yPQny2PoTRXO6EhOAH2H2qG6whXZhpaqhAo5hBL1FOLZ/TQ8ArpXdAgqad/mjQBA9c8zE4bNZjf4dv+IkFPt3EkADDkGc/w4jnDQO/feNU4IEo5LfjfH+ZPuKii2mkWej2Xk8QteFTxY+fg5wsEdIvils5ishVbkZHaT9bd+uXW5JU9wo3UXjlfVjg9PXFhU+KQx8nQ88Ff13+rZ8zpmP+7AYoWZQuv74gcgZtax1GnTvlboLwtrLQdPcx22sW48qAT/vEBnIT5QHUsrocpHI1DXKxwgPMCYrXnoz359CtFvmS0IgyoCIdnPYK+VMy/Q78ogIChbHzcfnxAWITlhX/IuC6YJekaod1pbqO7BBuEnCCLGfMgpezD6jTwLNWzSD3g1jRFLv6A+PswMWTuAo3zlzw4rYzg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FgWIhQqlWq5s6cc/p9VWiTPLL+wQuP+7mbZnSdk5NVEgJvY/DNKM2tYCmzjmQsbcbcyctPoJwRuoRVDi9aabm3nuDpQ/QgDHkb5DIT41tfe004t6fpdI/AI3FaYeqvO02MKrY9QwPNUzc1ZE9/bHthoW5fzTyDcQ6Y3oI1BWMfU5nQvAB6X6cMm2yxKrMpdNc/MNABnz5G4gIZsNEyttqeLkUBJjX1IKqYtfYjcfMxWlOPaGp2JQ4rou5564PaOQvCYXsTwuZ4KEu7BdM5m0jeV4+Rc4zGiaeC46cgffqB/2zXX0ajd03qSUBwSqIqlAAF/1boN+nTsO9npzfpJFLn7tSIQvb0TW99Ks8iTpz8MN8XX5fGujhkwnIqCfwZQctRq0t8oXQkdHgjPjsRPH6bOiCXMV/FvF2LaQuANmKHiAz3IG+6yjtXMhlGJin29u
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 22:20:05.8433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 712e18b8-8c72-431c-6bc9-08de758531cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17252-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.981];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 858BE1B04B7
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

Add dump documentation for resource command.
Resource dump command allow viewing resources
for all devices as a list.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../networking/devlink/devlink-resource.rst   | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/devlink/devlink-resource.rst b/Documentation/networking/devlink/devlink-resource.rst
index 3d5ae51e65a2..b4203c498bf2 100644
--- a/Documentation/networking/devlink/devlink-resource.rst
+++ b/Documentation/networking/devlink/devlink-resource.rst
@@ -40,11 +40,31 @@ device drivers and their description must be added to the following table:
 example usage
 -------------
 
-The resources exposed by the driver can be observed, for example:
+The resources exposed by the driver can be observed.
+
+To list resources for all devlink devices that have resources registered:
 
 .. code:: shell
 
-    $devlink resource show pci/0000:03:00.0
+    $ devlink resource show
+    pci/0000:03:00.0:
+      name kvd size 245760 unit entry
+        resources:
+          name linear size 98304 occ 0 unit entry size_min 0 size_max 147456 size_gran 128
+          name hash_double size 60416 unit entry size_min 32768 size_max 180224 size_gran 128
+          name hash_single size 87040 unit entry size_min 65536 size_max 212992 size_gran 128
+    pci/0000:04:00.0:
+      name kvd size 245760 unit entry
+        resources:
+          name linear size 98304 occ 0 unit entry size_min 0 size_max 147456 size_gran 128
+          name hash_double size 60416 unit entry size_min 32768 size_max 180224 size_gran 128
+          name hash_single size 87040 unit entry size_min 65536 size_max 212992 size_gran 128
+
+To show resources for a specific device:
+
+.. code:: shell
+
+    $ devlink resource show pci/0000:03:00.0
     pci/0000:03:00.0:
       name kvd size 245760 unit entry
         resources:
-- 
2.44.0


