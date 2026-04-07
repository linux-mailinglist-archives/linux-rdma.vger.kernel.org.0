Return-Path: <linux-rdma+bounces-19111-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CHdKahe1Wlq5QcAu9opvQ
	(envelope-from <linux-rdma+bounces-19111-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:44:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 884C43B3E6F
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70869302578F
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 19:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D649B37A496;
	Tue,  7 Apr 2026 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KJfZRgCE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427683793AA;
	Tue,  7 Apr 2026 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775591010; cv=fail; b=AEQFIzE9Vgb7hL8HHENnJJhPs86nAv4Hhas0MQjjkgP1HeB2WBhc9G+IjK6kj/y1It8Z9CFZ+BPXsgiZ8I9cB1nuEb6iJlDFg5tnuU8JxGDAfxVdi4dRvsmCpKq12/KnO9HRXGG6qqhLa1Lg+sEh3gRAR31mQ8Q9Mzz/DJgiYN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775591010; c=relaxed/simple;
	bh=NbXsMUvWQMqPAxAGJntF7oc52EiiDoxMJRzBnkoro78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jv1lpGuHYUb+c2SLACOzlCXlfVc7d00Z531kVWIE/x+RTo+LJXB/2wuwnSs6IJoqdlzTTHfKn5EF/hyd1oGsZrEcLKLe2qByjzbH8WrEgKS8W9022/y3ldL8HSoVrIR8mH7K9lXU8WV5sOVCmexrh1/9LRarsaNKb4YlGuYTZVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KJfZRgCE; arc=fail smtp.client-ip=52.101.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3HfGZrsp9DXnJ7oEytTTz/COzo72F5jNNVYKeJxAXlYAbGlBLCeCNooN/CMLtD/mFr5/h+4HyDE7GbkVTZArdn+zDXtLrQFwHveQOYUX3abEj56JhHgwBjTn+Ah6z8arBhLminILyFrq8BXsBJ12mTOAIdatSz3Dte5e6+bYz9ASYlfxs61O9aCoe+aEbUqHWAhO/rxochIX0Dt+2LzmN83PXrAO8dvYUVbpId+6O9fQUxCHksJUrHdmY7OtER7sLo8SG/tXGaSmvyfnZZmcT1PFZvk6JNQhYD9gTW01ETGXjNcVXDOZbnC3op1UMlPeZb2q13F0ZUo3NAYzh7XNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBMzI8zfOOVQ1PucAWar0F5NDjlTcnjInWTwF8+xY5w=;
 b=yekKKtficzsneBrUspJXLXWZaWHvskDgSjm8X+VJdEzPM1zdjinRhkoY2JPswmwlgaoyNWC49C/i55fgR76b0OYV3XtxYZCFh3pNfyT8QZad0l2N9krgF27e0L1K/KX3RgYbLRjL0OWjJ/SjbLnclWzKT0YiEoSBv0hwXZo076/D+FrE7Q3RjZyVx2hr57X6Ee1gjRcsvqCFJYvp1gEEE7mlb+y3Xt25hrK8X1SdaXSNkwVvVLus9JynXf2ti153Wtq5w+shA++W9LXZVBDSWYiTlJxM22a/l8lEC2y+wKeh6PvbPRQiA5n6DSQ3HyeBQTpy3NbNK0gTeOzLs+oAKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBMzI8zfOOVQ1PucAWar0F5NDjlTcnjInWTwF8+xY5w=;
 b=KJfZRgCEMXv4AZ60YMB+dW2g7Y/Pe/aS/2fHsBBMA/9m/LvJrY5njQJodtJ5kEiijKdjm6tkLCBd5F2+Gb+623kvz+nOHJ9jibp4urRXQDB6q4IGQ8hsRgjZhqYSVLlffzNVUQBO39+0ge1qPkGEErIM1mEhgbNV9aoQwx3gWpVKgkkUZN8I8uMhGrRQYBD/5GsYrnnWTpbLtXCXp5tfyU0a+zxlKRFW8zpFw9j8zja0DSx8UMrci58t8r6K7p0mqvlF7zeQYr+7a/U+OMdDuZOiqhOS4IB6gsu2mNSJTRJ3uffYb7+S75KErjS7GDR5tMHqAIWzxQ1P5pHjO2tGjA==
Received: from BN9PR03CA0363.namprd03.prod.outlook.com (2603:10b6:408:f7::8)
 by SJ5PPF183341E5B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Tue, 7 Apr
 2026 19:43:24 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:f7:cafe::33) by BN9PR03CA0363.outlook.office365.com
 (2603:10b6:408:f7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Tue,
 7 Apr 2026 19:43:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Tue, 7 Apr 2026 19:43:24 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:43:06 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:43:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Apr
 2026 12:42:57 -0700
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
Subject: [PATCH net-next V5 09/12] devlink: Document port-level resources and full dump
Date: Tue, 7 Apr 2026 22:41:04 +0300
Message-ID: <20260407194107.148063-10-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|SJ5PPF183341E5B:EE_
X-MS-Office365-Filtering-Correlation-Id: 698c194e-cdb4-4348-dd32-08de94ddeea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iyPb5pL1vmhNaYJJjJEniJa/tLllC3s3v+H9krv08hMHCtTMjfs24mZieeQA7khXSK4eSmnucDAUwkDVwClxJLXrabKcSmDb7As7MwhazUJOXCjvs+RyvXOr8UPleEC3opl6jiS8B/x7SL9sh9VZVXUmC4VAv5kx/N3LvM/uv7+HyZGz4LybBN/XYd9ZmCDeVbxfZcHOE1557GzdzkGmDfmy4X/4Q322ZKMNWnIDKGzDl91qknlEBE4g7LordK1nOkzDUqydmUdI/kT7lYjMZ+jq/EiTAl1Af0wswY5xqe5Flmq2nslIAw1k+Vj4nbSjX/9CNLx4JemEEWSrekpydtVScB2vt6x/ghq9lyQ+Vb4JRiNIvO0zBUC/DGbxrehL4vdKUFBOhGPXweOkW424aZhGuFZhqMT0WTJRAnzt5JNkOaLfL4EO3hsQDsPM0c5q1TC/MuikfGzprjVvAGHPAnpnpnlG/GdynFmDeClu3FH11UraiwI7xefwvRAIMlcgNsFDxHD07Ckv1UFdPh4VGxGxWjjrZK4lANfd0XnvZI/FWDeuULB8ZNmi6JJ2CLRp5fq7UbwRc/Cb1pqLLCgK12v77lot4GZ144Srv7Tyxl2x1Q3e/cxhyKuE/UPr/cX0Q/nidRHTsqriHb2ou1ixnNpL1axVyrNtDV65e7MxUddYUQ5oKn9NJ2Z1vBQ87HqO6nhzRZ727UIUSnHMjZofLTtAeEIBgXKI0yjmRFDR48sFQK4Qsir7TCX8KchJQ472KzzTP2YKJaxunv5LbdUeaA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vyI5nvC/fF+lKR17keq7H0xNYoAUhURoOGeeVQqiEda/zcSRnHj0ZysEbx0asqeCnsCm2z6LVQHXttjE+RAUyaoyoKrnTfYD+wHphpjD/raE4C0KfZPecgEhOUwkAunKFOB57jP2afKkTyrMj8IYcb77dD5Q+QAVDA4wHdF2d60dF6I6g/6F/T9Z08Oil+E3SVf6/ysEqGpmNesbcjMv97+Al9WQ718xhjxAB1hSgi5qrS/SEXt3grskpUIR+v62ZESCoSuvJABvuKkt0SM1wKxy3KIAMMCaElqJlqb7rooyq+TMy2bQ8FCjnjjehNTuIz5RMnDSy4HEF2ZsfVDeu5ZSvPSsmHz67j8xCdfApc4u4Dka1PH+96JMU44nLQ7wsPuHw6HEoq6glcFdF/ad1mL2uahnHSonk+R/MQZBTc6Z7mgXfZjLRtkWaosUNst6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 19:43:24.3548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 698c194e-cdb4-4348-dd32-08de94ddeea0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183341E5B
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
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19111-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 884C43B3E6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Or Har-Toov <ohartoov@nvidia.com>

Document the port-level resource support and the option to dump all
resources, including both device-level and port-level entries.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../networking/devlink/devlink-resource.rst   | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-resource.rst b/Documentation/networking/devlink/devlink-resource.rst
index 3d5ae51e65a2..9839c1661315 100644
--- a/Documentation/networking/devlink/devlink-resource.rst
+++ b/Documentation/networking/devlink/devlink-resource.rst
@@ -74,3 +74,38 @@ attribute, which represents the pending change in size. For example:
 
 Note that changes in resource size may require a device reload to properly
 take effect.
+
+Port-level Resources and Full Dump
+==================================
+
+In addition to device-level resources, ``devlink`` also supports port-level
+resources. These resources are associated with a specific devlink port rather
+than the device as a whole.
+
+To list resources for all devlink devices and ports:
+
+.. code:: shell
+
+    $ devlink resource show
+    pci/0000:03:00.0:
+      name max_local_SFs size 128 unit entry dpipe_tables none
+      name max_external_SFs size 128 unit entry dpipe_tables none
+    pci/0000:03:00.0/196608:
+      name max_SFs size 128 unit entry dpipe_tables none
+    pci/0000:03:00.0/196609:
+      name max_SFs size 128 unit entry dpipe_tables none
+    pci/0000:03:00.1:
+      name max_local_SFs size 128 unit entry dpipe_tables none
+      name max_external_SFs size 128 unit entry dpipe_tables none
+    pci/0000:03:00.1/196708:
+      name max_SFs size 128 unit entry dpipe_tables none
+    pci/0000:03:00.1/196709:
+      name max_SFs size 128 unit entry dpipe_tables none
+
+To show resources for a specific port:
+
+.. code:: shell
+
+    $ devlink resource show pci/0000:03:00.0/196608
+    pci/0000:03:00.0/196608:
+      name max_SFs size 128 unit entry dpipe_tables none
-- 
2.44.0


