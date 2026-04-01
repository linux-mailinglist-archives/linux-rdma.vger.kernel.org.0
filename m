Return-Path: <linux-rdma+bounces-18922-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKlMCf1qzWkkdQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18922-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:59:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2A837F8AC
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD94A3089A14
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 18:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B7047DD7C;
	Wed,  1 Apr 2026 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VEvpT9Eb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012048.outbound.protection.outlook.com [40.107.200.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96F7345CC2;
	Wed,  1 Apr 2026 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069573; cv=fail; b=S8iFpG1UpHV8/r9aPz+jzGcxgLGgB3Ay9an396YssVSqMyeiPexhq4Jsr1YPEn+tvj+qacJPfai3BE6fGRkOTp28LeLCVyoszbKhtsEtp61CteF4Gt8mbMQKTSti+W02PnWIEXf3RLTNYZP6jACUGjBuOpgEDqGjbhYoeqdIHOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069573; c=relaxed/simple;
	bh=bNxPaFyKTr+8PzSZjErURSRhx42C1826Yt2rbTSXgps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hiXiB9d09sl+qtLazygbS1e0jqhc+oLoty+bFFYVWSxpKZvoG7j/AqxAbpEvS65OU3fZbafGVvoVV/vszN1r1IxPzzsadXi+4xmQhj513X2ZZlrVOnSbkcNdRGlfVn05vuvgpNLGLtkE2BI4FYmqwPIG90bdzV221YsmVo1x5WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VEvpT9Eb; arc=fail smtp.client-ip=40.107.200.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/4CkEHqrN4Km22fFYVXSXT9EFJVmZX9fBrWb3Jp/16d8o2PaQPkMHnX9yT+p56B8al4lR2TetKRL60vhBU5SWVjFCNbN6AZDHApcp3pck7OYIYsHGe1rwcdH4F8kYsmZc6c6WvX9CuymhOyqFjr4x/L5yjOOQgfOWSzlJkgxDhGpZRm63v//nEy5OmIpNa3ys3c6lhLVbE6kYMEnMBtCcjVGlmOMW4Voqtlvk1n5s2/cWx+ks3yfQkY62kcLnwUpkvzHOP2tSedVdOSBt0HGCM8f/z2fHhAAcdVOzwKe4BLRSQxWdguJIZbn/xaLDboI+nDqZ6NYwxsgIWouKhY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftahLqQoNhhEzHXVvf+M97Mjovjuqjqr+GfvnqTKqeI=;
 b=i2u/dy10327DGAdmzKutmNcUjQ9RAG9N/OEi7tWnRqfkoqRm6IvKB/nrokLJEzyM2KUkxPcS+mEfyi71WtRteTBSDHen34LYK1uzsO1jXycguP5IHY1j64p6T9isKVIlacXyQVkeQSZKmWOkG6S5mzGwtvE4u6egBz2P5FMA09JLmJIoliyNXlqkayZdwNACIlI1LrihkKYbptrY6IdmT2EkPgHkgHYLze7uVGnsaaxd9tPGuYiBKAYDpLah8HqqZtgnw3k5E+0gu+yF5mLHmSzkPpczSO0Wo8lrI/Zn0aP1BkkU1l22N86mUcPblgVYFjQ6FEHzUDXAkT7k1kMJog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftahLqQoNhhEzHXVvf+M97Mjovjuqjqr+GfvnqTKqeI=;
 b=VEvpT9EbDtxZrIddUGd427KxnYlZW/gSVzC7ySpbjY5kZw0PItZPkW8gRmlw+mhQgpvaf1Z6owCUHwckK68Ztws2XjS4FStEx0LCbDQ9Rl7gg5Kh2cuKu6XAXDdewP3nAVQzmMxmLD6TYk88z6aUVEbPqaGHjTMJqitkThp3xQKSL/pezaOEpL7Zod5UqsZ5v1XrrxAdU48NyYQoM+0BTZ4sMG1vKKnGa78qp82Tn81InRLxaHOe4NQXWdiMsWsT8PVI7ilc9/9WFqL9J1iWO8J5dByXJIONI5cef3kLKKusFL+6GKVa+HfNIIbB3DzK0bhXbEr4p7jWD8I7+ySwuQ==
Received: from BN9PR03CA0447.namprd03.prod.outlook.com (2603:10b6:408:113::32)
 by SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 18:52:30 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::9d) by BN9PR03CA0447.outlook.office365.com
 (2603:10b6:408:113::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Wed,
 1 Apr 2026 18:52:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 18:52:30 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:52:08 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:52:08 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Apr
 2026 11:52:00 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, Shay Drori <shayd@nvidia.com>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, Kees Cook <kees@kernel.org>, "Daniel
 Jurgens" <danielj@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next V4 12/12] devlink: Document resource scope filtering
Date: Wed, 1 Apr 2026 21:49:47 +0300
Message-ID: <20260401184947.135205-13-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260401184947.135205-1-tariqt@nvidia.com>
References: <20260401184947.135205-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 306d6d6a-d97e-49c2-063d-08de901fd3a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aTycqXDe7ZVxkDKzAycH8LdSIH5sZBaJ8aJ+HOVt+3+L7jb9A7yWwCPlv3QKffPirMnm7M7h0d5UGRorSP9kVDINuSI/H586OwH/GWTXMaaHZEVw7Kf8ki2e4GgBCbwS/GPN7CxCFUHKBQ8xg02W8Q5h6BC9+lxGBWHR1aXll5sooNZpxPN0wVvel2Eg9f0fBz9O5mbmFCuZGYp61ApYXCbtSTTg1KsyGbThNxj8sDEzYbNTpPZV+Hh8lVX2pe9m/ilC0/NciGq183FNBcBPyvM8lvHXq8TJVKTO1ubHDNDVx4BT6wGYGcG4xux6QZ9bi45nIUnXjoGxYnLAylmpcpAREPo7N/KX/i76k+v7iwX/STJwUXpjasVRimN+UBXVzrADDlRdPQRO00278YuILIDPO7RAOR+1ZQbx3ibF55pNZQz/WQxGvJM5oQAxoCO5CJnJBtzMFHckOPDmlRmqDqqi4dBntOEQkAWlLP5qLbvyVgjgUyQ49el0sDn6n3km1sm++gP+mQPa+uSM4o/OULyXsvUjgKlIh1WSF13laBP40WgiPPiUYdqReCYpjEkMYJhl+wRCYJX4cIMbxAZB3nHUb8WEYfudcOOreOah38tX8zjLZEH8uMDS2Gog88KgYKuKl8vD6wOyvVMNApuJjZ9tmYQALPEbntaH1B/0eOK/a385Wz4YjQJw3jRkFsc1YPbXa3OmUFjL2rrK6iZm2MXZxhbhDVVKaDzDUOzVke7DVNxTMA6Rq3Ka4miWSktrDH4vEiIf6aZTv+G+TtkV4A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	T48YHFUGQS4OI5cgrxLc35yGWxvJAr40HGSq3z7jCUwHTNpMdds3MwN4SDgAnyt074U9202Fy49h4BMjFJ4xeopyiimTKI+NSoYFQWEXYjtNWwYs1NYDQkfyL0Oej6udqq4gQQAz3/HiniygqbZ7pENHRQztvIliSVR8FxcM+2h4wqbuM1E4AVNjkcF2C7XuItpaij43M1RehIlweC6DD8rSgZDigB2925cXorvW1AcxvaJHFTFn5Vv6CGjZxZ/zCisoR1GOfaLik3k+u4izWICKoGnnlHqZPlureWzGllNyimr2pzTTAvrqo9BmUqHwbYK1xmu4cQiu3m4s2cS4AADZ06Meo7OJ1IbpyvMNoF19sb+xuLaLhixQ2z96AqJAH7F0BfDZ5fb6nmM7uBm694c9rb57SElL50o+4GkGU1Q1HxcBwbdPyGjzWDyBsY1k
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 18:52:30.0379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 306d6d6a-d97e-49c2-063d-08de901fd3a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18922-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: AA2A837F8AC
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


