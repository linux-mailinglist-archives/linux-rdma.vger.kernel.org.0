Return-Path: <linux-rdma+bounces-19114-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGESC3Jf1Wlq5QcAu9opvQ
	(envelope-from <linux-rdma+bounces-19114-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:48:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 653EC3B3F98
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40193302FFA4
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 19:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBB1379EE2;
	Tue,  7 Apr 2026 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jibf8U0V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD97352C4F;
	Tue,  7 Apr 2026 19:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775591038; cv=fail; b=tqUdauI3zojxkd7TvdzwQTKpGjy7+i5KOY8uE/qq2u0ra8c+MUQgeQ2KTTM67/2PuYi1vGZTjdS0AZTCNe1GD/tnYAoVvKd6m0uvy3NvP9XNLb1XJCKO/dUYHi5qvhVlJs6QTeCvWipC65YGw7qQ0B2uIgX5Sf/Hg1aWscoJQFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775591038; c=relaxed/simple;
	bh=bNxPaFyKTr+8PzSZjErURSRhx42C1826Yt2rbTSXgps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwrJFFay/2hYX04vRlC0lgFCT4ldRCouofgdFuWvDUOpkQVZL1VP06os7g6cNx5HXKjW1TRRqi7ew2dLLeilzqXzmryQMccL5Qj7INBMhJp70YRz9HpUqUmTH4H475IDUX4rAiHPbOtPy3ksQgTM6w7AUuxKPCxB6MNNQAx2qD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jibf8U0V; arc=fail smtp.client-ip=52.101.48.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAwM+nUW9igYwAtpoil5e+Y8wyNUXlzDwU+2emAgFUyGKlTGh+WmD4u9ewzrZKbbCvDR/6eJMGhiyezROzsjKqnSBIDWe9ZPeigQYw2A6YzGXcOPC3J7Fi0CHE4gWM9Hwzr9nHgrlNV99bt9nO9x9qkEaheh3myzcMid9vFi9Mp6s+MO2Hj2/vGM4a2knmj8MaiAfQLvlP+I/gbjTjLwDzgVaTbRg2+gFW930xEbeo1Rteh8F6E3ZkJ2RInzoVwj9/Yt0WVTmhPWwz/G3CuGzsZxRL6Mm7286mzvZ4JQYu3GYz0S9Rl+DW1c+ySgoJ4T8SZrGw4OeYvV3AG+cGvbFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftahLqQoNhhEzHXVvf+M97Mjovjuqjqr+GfvnqTKqeI=;
 b=mq4ZRsd1DgGfbSRvfBYGY1IC3MT0E4DT4veS35DrTW/oJgk8UYdoqtXL1z4PkuhvxifSZWCT9Jxm3KRdLWm2L8W7gLQ04CQ4jGFpkTye8LkNqhmrfhmP8IGJMYdg73cwUXvk7WLuWXryiTT/w9+MJEmIc/TmQL6fFG9MPMIdo6egd6TpbOIQ4WbTox/tD9hxVVnfRgUdWlmvA2mTG/25NyCtbiCY0JiMfLbzkKctjHqiJMwimY06B9XzgpoMDj4wSjR7BHBn0eOqMyzBKP6M1xmJeweFD8qkz4kOPLHFmauw/nRy6xUOIR5fO3PwSXiNIXRF/+b0JlWfayRGnGmDmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftahLqQoNhhEzHXVvf+M97Mjovjuqjqr+GfvnqTKqeI=;
 b=jibf8U0V8adr91NsaKqdmCuEBc4LkEX213JtRB94PSl35N7J9ImMqxT687jIe12Eo+7KMyR06moB44Erc4RR5b0W2dve9YJGHb7KIhQKmU97KoljyOSKwqvaRlhdlOZNv1iKHUpTqWaudzQjAUsvch4JeHrm9aG5ygA2ieT1uksU2LfrcGKxlMcc2ZSibFJMX/CLy1LTnsfBFttLdrCE4jcLGJhHL8fHFof654pKYCemk2lq4ljfIYyYaBJY+vn7cyhPU6jZ7CNnE+2kH/0Pj/4E0GOzNrvkZJKtMFYp/Y7t0SSS9A+HLBz4+MQrcBCcI9UGnRfNFCIEhQECkOV7PA==
Received: from MN2PR03CA0013.namprd03.prod.outlook.com (2603:10b6:208:23a::18)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 19:43:48 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:208:23a:cafe::89) by MN2PR03CA0013.outlook.office365.com
 (2603:10b6:208:23a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Tue,
 7 Apr 2026 19:43:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Tue, 7 Apr 2026 19:43:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:43:33 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:43:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Apr
 2026 12:43:24 -0700
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
	<gal@nvidia.com>
Subject: [PATCH net-next V5 12/12] devlink: Document resource scope filtering
Date: Tue, 7 Apr 2026 22:41:07 +0300
Message-ID: <20260407194107.148063-13-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc6ac0d-ad72-46ce-15cc-08de94ddfceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	LcJabH3riS4mD2EJ+WyOu63jtmUo8uuiHgtlfbLHTHVI1lR5UaY/+mKI9+W9tqhf1XttRpBCZbchb4YgIumvYp7khqEozgA9WkchadUOwNVQ9Gxhdo5HvwvwwEhiGGid5Z3waSp4zQ4geSvuj+kfYg4HtgsBfxg0QFjkpJmQpJPfhbffqMlGmbFsOKhyMXKFi+PWHCAg6XbkVLGMU6/B4Lm0WJpYMDLgGk5rOk7yaYY3dOwoMmJPBKv/fmPsRTyL9NGa3F28CKFAlwxNqxvwTazW+gHBlGWhDgvfJM7HV0JWSE7ApVPmJnUyPAnQNodWplmDxFQzQ0TBVhPZQ3K+tC+IX9qsA2++suznRpbOo0Ywbwjw47I4zAMZ5f9mT8AFkCtWl06z7UbPye9Mv4IbqMLirCbZht7o3f1QenNqCM7WBo81CLKoL4Fy+9hVdZVhTg87FRVD7ajb6VOP3x0hGqgmXZkLiJTefocOP75usbK4bwq3fCyOkbGOhagvwrvJEcCdOac6qhRZwMkg9+WDB58dVsNks01rRgVZzrhJO1GcpZedao2224V4mYPW3xxxJCwdaXhks1sPCMUDnvA+OU9pCNf5ZbEj2pk+FdhEHLpYDTSrvQdwggKQXFHAUVq6A6Gdv0qIdfEStF8kmUsjHdTNvOXoxuLmKbR6oa2zMxQhYL1l1EwMEIVfoj3hPxjDfLo4X+zzCIhGmwVhFbhRW1loUd2+g8rnazmHOvupouqduj0NLLpPvjqb2HEza6Ejn9Knpy4X+MY0eFPcsRjlNA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	z15saFO0VGeiWHBaSbgX/XUI0IvrRA0wiIWNhGxHJET57L5xUmdVQuLs3VgBjVU6raK9c9W2wtohzzGP34dmd5hLrAvICSuB7pQeyqB2913StJT8fuHjgIR7iWc1Avbpa6f+WPOd6PIZWTadyW/iYVGffNmnkhJwBHCUXyGUE6ny9xvUiYt5NIoOQdLMl9jSOfELJyi6kHgYjr8eMItqrwT1DrQp3Ec73HOsZ8hJvRNUG8fqQeheZtoT/Uckf4qO+e+eqtWBEnK8g2Blf40cHugzTQySSfn/U5/jc9XcmLZZ1E9uNYdGIffKgDRjCpMZxO4igkj0jRryYrL3XjpS+BUtdIq5tibEx1nXZEjIPYHQeWiMWQXBDgN+lep7grGTUWDIiOmRZ48zA7wBx4D5YUzURyXCxlEs85NG0CJnrJIge5jgsYrYr6UZcdYVEMuw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 19:43:48.3283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc6ac0d-ad72-46ce-15cc-08de94ddfceb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19114-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 653EC3B3F98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Or Har-Toov <ohartoov@nvidia.com>

Document the scope parameter for devlink resource show, which allows
filtering the dump to device-level or port-level resources only.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../networking/devlink/devlink-resource.rst   | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-resource.rst b/Documentation/networking/devlink/devlink-resource.rst
index 9839c1661315..47eec8f875b4 100644
--- a/Documentation/networking/devlink/devlink-resource.rst
+++ b/Documentation/networking/devlink/devlink-resource.rst
@@ -109,3 +109,38 @@ To show resources for a specific port:
     $ devlink resource show pci/0000:03:00.0/196608
     pci/0000:03:00.0/196608:
       name max_SFs size 128 unit entry dpipe_tables none
+
+Resource Scope Filtering
+========================
+
+When dumping resources for all devices, ``devlink resource show`` accepts
+an optional ``scope`` parameter to restrict the response to device-level
+resources, port-level resources, or both (the default).
+
+To dump only device-level resources across all devices:
+
+.. code:: shell
+
+    $ devlink resource show scope dev
+    pci/0000:03:00.0:
+      name max_local_SFs size 128 unit entry dpipe_tables none
+      name max_external_SFs size 128 unit entry dpipe_tables none
+    pci/0000:03:00.1:
+      name max_local_SFs size 128 unit entry dpipe_tables none
+      name max_external_SFs size 128 unit entry dpipe_tables none
+
+To dump only port-level resources across all devices:
+
+.. code:: shell
+
+    $ devlink resource show scope port
+    pci/0000:03:00.0/196608:
+      name max_SFs size 128 unit entry dpipe_tables none
+    pci/0000:03:00.0/196609:
+      name max_SFs size 128 unit entry dpipe_tables none
+    pci/0000:03:00.1/196708:
+      name max_SFs size 128 unit entry dpipe_tables none
+    pci/0000:03:00.1/196709:
+      name max_SFs size 128 unit entry dpipe_tables none
+
+Note that port-level resources are read-only.
-- 
2.44.0


