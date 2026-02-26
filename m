Return-Path: <linux-rdma+bounces-17258-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCHmBabHoGnImQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17258-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:22:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9271B0522
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9368C3034C6C
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 22:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AE147CC63;
	Thu, 26 Feb 2026 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BtHYc0+W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC83399013;
	Thu, 26 Feb 2026 22:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772144455; cv=fail; b=NXUWDHC4qKWFtlIAZzLMkEkg08wWvu3y9X1ndKy6t6oxvfNojDfGGT4CpqxD6nYcFbVJvQ3V9DHiqYoPdlvxZasDfsLdoFj7j7V5f7FP6lLC7+vAthqEereee4MSGVBMpwawEjQfTmxSjufpjcoCqq8l6/yVCCrI18hXq/oQu7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772144455; c=relaxed/simple;
	bh=mygv8j3FyEUxu5ONg51cx6hvtcsG6ocEXb566FSuX9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qLjQ4jRtWsrOPzYdQXu8oGMRIbeUP8snDscy73KHLbzQSGs3mw4EjqrceDAvizFglXv7TDm5kJ5PqlEF9VDCeG1TDsJzVsaUb9/4EUwvICy3C/FTYaMomMzCPZMZUEv/JDsD8UhquiC4KLH624sbMZpV02aH+yU1LSEvFxaqqIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BtHYc0+W; arc=fail smtp.client-ip=52.101.56.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=es+2IbVQ/6wMiLDmV1YWNDakLCnjgcNXV3F3boFxYRlyPRBXD8gqob/7GdnGViDYMjjvOeGwdIlkTWrL2FJ9I4apBPr87suftI+UEnkOst2CNP6Ogmp5YwO/yUXJybGyaUd50bg4ZbHO7vcJ53PRkvTTYkn9dr6MztXt4aeyOR76zIZJR90Sw0sKHd3sJIU9r+vBz22NleDJPzo464v2A2ojLjLrRd150ySBnoj3lHJhT7PmHtwU8Wlu34Z6CQKDrr3g473zu3oP+5Gk3LMpk79sfWaqoNGoH7W4k0xUj/uwR4a/5ztRc3CCid0as0nyOrlOjvoKvT0+bS3Ld+CzWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miuiwjPloG6AlWo59fMk+iCoMhIlgpe3pCLEFhFosXI=;
 b=ev26lxq2VRZ4tsxkd1b4BYEbVuXnD2asgHYwkPlcaytLeEjx6ycm36ZIDFRMeZG1xZfsRaF4mNUF+3c2nc+tiMp4Jg77PIPII7VuM80EtVEgAM7BCzBQDaqPHhUa/mlL/z9jXENYGQtxOthHLrryMrO3Cqy/nKEDtVTuz+5LuWkUALy9LY4PHCIRsEs2Ea9AXoRme37BZatwI8DvGfsfoveoSfFXf1BG7Y+yLY58CwLquWSR+ziiBeMgHgbuF1sHNpwW9cswNVyldnusQnz8VUMtHTktTf/amBh0pIhFR4HP5Vn/HgLeicWg6pai5Ify/YlKmVyziWL8ZNFmwWJEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miuiwjPloG6AlWo59fMk+iCoMhIlgpe3pCLEFhFosXI=;
 b=BtHYc0+WMLadHqoULXPy3Qo57eIrCjkrTXwZ6Hm7b/kTXklGYidNp9SdcR+Dxlohr7QN3GjcQSUqJ3/sJvj7Rq0FQaGCTH8RNgNjoeJ+qtUtjVpXvT7ZLOrm8JJP3Kc76V92+ytmMG5qjKx5QIglrprFUGyevFAzVlnOJpmEXn2UhgRXgXGoeSrfGwmWE1LBE0FvVPqp9WeSWB8epgsNDd3iqRY9n78a90etZJStgGH2UqrQyCNL5DD7nQtve9rJl4pTxg9YXl1YFC3lPfw80KpzE0PEYBKfqu9SGzzMhzn4fv8luAZKALt3UjjwluIpPRRe0Gx+dHKWl8+HXZhYGg==
Received: from BY5PR17CA0049.namprd17.prod.outlook.com (2603:10b6:a03:167::26)
 by SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 22:20:48 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::1c) by BY5PR17CA0049.outlook.office365.com
 (2603:10b6:a03:167::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 22:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 22:20:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 14:20:24 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 14:20:24 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 14:20:18 -0800
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
Subject: [PATCH net-next V3 10/10] devlink: Document port-level resources
Date: Fri, 27 Feb 2026 00:19:16 +0200
Message-ID: <20260226221916.1800227-11-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|SJ0PR12MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d551605-f478-4654-f47b-08de75854af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	DNO/unMolGOhcyMnZprbaxtWxeraPCzlG70tbN1rje3nKtkiVUT8kVB4Ae3HBtx0sftWTKHpQZCS/fHxO33H8fdMb509oPjscyVCkPhQINosHNLNMhup/xBrwJhpsbHN7sqUQPUYCVLBAe0IM0NCJr7V0VeE//msNBCmquE5YomJghMNRU7XeGzOJ3X9h4c+kHRduPlLebH+WL7GuwH2uwKJsg73qtOXZ1sl4ir+weZRpVVoti1LrgK+O8FWUYiBLMzAMlA7rwrfMygudDQK/hz9haCxMOjq8M+OoJ/IRsgdBNDg4opq48PTELbfu5ExGhPRvdedCIsHr6arAVlBjTJeaV9Ay8wxnCeREnxevSRQUet+NnI1paZ1qSORundIR5DMNNpVI0vhlNXHHOPHa4yavExkur9oDcYMZckLMd1kbMEgVMMHFq17xDBwrAqxEzqzkqbtCKpqOx8k0H4QYlbhZeqVguF+EVMkyYHz9cB1slIC5Y0U1M2oLkmdA4Aj5xNNou+ZhxWBOzKayDaTeL5vlOzAGLGwgXtOZQ7fR9SWzohwpRXzBK590C4wPRSsDSAIaPsszeLx6IVuAfmeubWQisyTq2DzDG1bcyZXGYkkEmCY+BnbjG7IMyWQBGQ2hFE7JKaTeyTRE7aaT0rIMhzS7qHrLGNu8sJ7H4JHfM0XqTKJihrEjGAljsl9/t/kAmGW3LoohwP7CudP1/ivWvRsZbDQMUP9x8xLVxe4Bf0/u6lSmWPL8fyvpkyYEHV9Brr1EoFgAS0thUULFtAIyxidVx1PofO7AUow24aDtN1bsOBAYlCrP4QebyrBE1eUasi5pCURz42OtwVj0W4vDQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BljOblQcOrKg69VrZKcxGkdXR1EimKXoAF9b71HM1Ge7iC4HKBTmcGHWnro1hrtbud+q6kBppRBl8EzYXNqbvBLUCN3sy7uGFOwrBpPfTYgDYL/S8xEmb3uqCiXfvSfxU5517nlt1r45ag/+4A+444ayYnYlEM/PbU8Oi6u3brwUkG0k9BVw3eESBLy4XMZGJhZPvl70d9/yAvmt9K8c3ueR0Cbk0fBBiZOXPbrDauTz8ZmItA9zjPOn1JfCjt1RjEZZNN6aOe5ec8WhPzxoMFylyFsHRBUKkxuXVd33E58uBqkRXybjb2Z3bt19EOJ5WPeWFxIU61ZdKLOsJ/hJtF0in78FZ5rMPiafwpO2y4v7PD+GxymjZgxZ37U3haZnSqaQO47x0tNrOALd1WmgnHVJzq9oxW/ZwEDAub6ONyJdsXPg+xkK3krW22s5j6pX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 22:20:48.0774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d551605-f478-4654-f47b-08de75854af9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17258-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.979];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: AD9271B0522
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

Add documentation for the port-level resource feature to
devlink-resource.rst. Port-level resources allow viewing resources
associated with specific devlink ports.

Currently, port-level resources only support the get command for
viewing resource information.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../networking/devlink/devlink-resource.rst   | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-resource.rst b/Documentation/networking/devlink/devlink-resource.rst
index b4203c498bf2..1d6d8bfa1692 100644
--- a/Documentation/networking/devlink/devlink-resource.rst
+++ b/Documentation/networking/devlink/devlink-resource.rst
@@ -94,3 +94,39 @@ attribute, which represents the pending change in size. For example:
 
 Note that changes in resource size may require a device reload to properly
 take effect.
+
+Port-level Resources
+====================
+
+In addition to device-level resources, ``devlink`` also supports port-level
+resources. These resources are associated with a specific devlink port rather
+than the device as a whole.
+
+Currently, port-level resources only support the ``GET`` command for viewing
+resource information.
+
+Port-level resources can be viewed for a specific port:
+
+.. code:: shell
+
+    $devlink port resource show pci/0000:03:00.0/196608
+    pci/0000:03:00.0/196608:
+      name max_SFs size 20 unit entry
+
+Or for ports of a specific device:
+
+.. code:: shell
+
+    $devlink port resource show pci/0000:03:00.0
+    pci/0000:03:00.0/196608:
+      name max_SFs size 20 unit entry
+
+Or for all ports across all devices:
+
+.. code:: shell
+
+    $devlink port resource show
+    pci/0000:03:00.0/196608:
+      name max_SFs size 20 unit entry
+    pci/0000:03:00.1/262144:
+      name max_SFs size 20 unit entry
-- 
2.44.0


