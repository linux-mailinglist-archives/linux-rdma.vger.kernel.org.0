Return-Path: <linux-rdma+bounces-19104-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Lk5KeVe1WnU5QcAu9opvQ
	(envelope-from <linux-rdma+bounces-19104-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:45:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C68A3B3EF5
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5B4530A5DF6
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 19:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE0937881A;
	Tue,  7 Apr 2026 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IU1i1+Ji"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010036.outbound.protection.outlook.com [40.93.198.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345AF3783A1;
	Tue,  7 Apr 2026 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590952; cv=fail; b=Zygzuh2rHdukGeTj6FAUPyebnranXWM8riG8cM8C351W80/u+ZBO1Ygkx37896+0fkLuKhGNOTO1AETNkYLiX2FROrImG2e+KUKCwtABYucPT2902ZnACC2BR0QxDAsMNC04ySGbPnChWDGVRkwn6hUmcGUYEi5MFGQMork/rdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590952; c=relaxed/simple;
	bh=WLUN/AeB/om/Gh7k7+SYlm8IBgnX44fqQcf2ori073Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mLyDrhPtiO49QL+/eDm34Gw4PAqhSyYAGA9K0c2gZdDIpT4LbBzwnwEpYNqAFAcoGFOWri7rnlxzXJfEaW5URsoFCPk/gWHpMMuAVL/czKSe1RQ8fzAGrpfCEkFxDGvFyOsn0QF1K7JukJ2ASCz57Uz9qP1CWUhnFN8Lku3zak4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IU1i1+Ji; arc=fail smtp.client-ip=40.93.198.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/GL34SBxFcZFjWqP10/wwsw9zYMVoFuod7g3ug1DUud6rm/A9w5DQjw1CpUHE2zMK9BM/bTOpa4rWzpwUCHpO6kax73okl0LN1HbnCy90lgKxo2NpWTGj37XY7UmQlvRYyvWjwYz7RDxSK0k92cUo9d6wvDzjVAhJNalXAkvRdbvQ5h0QoFMQd9hj/QIg5NSJdvVa3qTAy+HGXYkMVc1qB+KAOa7LU6yQ33x/4KBpI6WNVa+Rf0JdjMi4elEWL/l+anY2DWYjkwCkmgLSG8LwyEFsU8ATHXgH6yKRW+YjUUsBfvRwphMtZvjfT/2yv4wBAR/z3WiplS4Q1iUPbEeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcYuagJaoChyF58GPXGb5faPOQGoDeLF/02LtJPF0Tg=;
 b=EqGNh9/ebzzErkF9G4TLplE3euwjC5QURlqTlv56uMP/AfQnq1CDtfd5P82T+rl16VqsDpIdOkf3PrjDo1Cpb088Eci0S0QPi12U4ReXBmsEBJUMbVSgCNVM6ZN6sPad/W7wVp9+p7vP7wi+ib6Ewp5amXqefdj4G+Sl944hymWzPK35SbQkk6UXLXLETKFORykafhF2ik+9mkT5ZXx3yf7pg+fRnCr4JKDGyDfCdDboNm1eayp5fwvzvftMLnukqlKTZflaPsIzNznOVQdrdazAAwDABrOmbkqOEkju3OzEZyZUynteF/RkRoBjG6eedc/zzQH+ZuuMbpaIeL43dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcYuagJaoChyF58GPXGb5faPOQGoDeLF/02LtJPF0Tg=;
 b=IU1i1+Ji5yI5xZrXJsan/eOgwGGHYuit91E4m1jZLEk6MD3I+cji9Vj/icWFNn4775cROi+mUyTvlvCS4DEVJXX4Nsu5j+j8hNxdlCPdhRpTMLxX4ihXrBxHbcbAx8Vfyf+tCFWThYIH7AGlz9EOaLOays6CLYMuOR53Y2L0yd78sj2k9Q0Q97CV79QtTMChUUbmGaQInQnD8St9ZG4RExDnEsuBv2iKeL8BCu9AF9www/n7cNVlZr3TeG/FDJowjwXHH1GvH6x6CZ9h36lqfWD3+OZtG8Pcaj4kTQWYD1v0wA3ryAf5zvv5LvfppORtYX23HwahQRWZykvWi1c9oA==
Received: from BN0PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:143::24)
 by CY8PR12MB8215.namprd12.prod.outlook.com (2603:10b6:930:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 19:42:23 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::ad) by BN0PR10CA0021.outlook.office365.com
 (2603:10b6:408:143::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Tue,
 7 Apr 2026 19:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 19:42:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:42:03 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:42:02 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Apr
 2026 12:41:54 -0700
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
Subject: [PATCH net-next V5 02/12] devlink: Add port-level resource registration infrastructure
Date: Tue, 7 Apr 2026 22:40:57 +0300
Message-ID: <20260407194107.148063-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|CY8PR12MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: 1487f2fd-0407-4505-dddf-08de94ddc9d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sCPSXYka5oy7lylWPrk1MxcN14Rc/+zFgWFWYKMRZaD6cd9DVyJoQLDAQqbnsX0pY9q6FkBbICRI0t1ZeG68HCeEEb2bP5UbkjHdoZ9UNz8WC5u1v1U+blJamkYoat2Kw5vN3jZbKB8f757+QKoT9CZ4jyhQwjPvDIqJw+MV9byf+UNPB1bQePosoShqG7GDKC9FCVmj1WagqVmh7azPc+gtEBGQ7vNEuEuvjSGvMaYVNJ1qxSw/R8Pm8ysaAO/pgFFjG6It8L2jbUHYNGNA/Ou+WK+RNueyJ+BrqHu6HWLLaiC1sc5n6EpZPsLVSwWBCvWZlZaKcLyCnUa1bvuxq6ogAChfWFooDsZxyDK5DusXGHfHo5iMlewOh7Pl1XmKlS89mZ/4ikeqRWKcZrAXzJrBAp0ghsaiU9BFtVYnLduQvo5kJPMPyVMHoUsNle9hrwhW0+V7WLyn1iYit+rlOa/8BAvFsaxhYPv5idQMJFC6CNtmo3Jl8FsdvIlR5EVndYdn2btK2QEk6kFn9gez5d5rUhWylhmNoeDgq+MtCDODEK9S3oIVUoQzabXkTcMOjE6VN2jJ6gPKcWmoE83nFofsU94R8FB7ksZeN+UnNTUsUCAx0VUFBG12RxsF2tgMYqZP5o6AoYeLmxhAN+s7VBIGrHgQLujqN5nynjWmyLJfRVt2oWlP60qrNhYNMdb3q3xAC6jYw8WaDC5i7VQZsSrba3skoaRq86gkyeJQxYIV7T/+ZtR3eDnzKxBXBta7BXS78ryAVr/vHXaz6/P5KQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qEHspivCrnkOIuo7lOgcRQA25l6Xr3WMqe3NMTyWeaCypeuWlSaxi4a4bm3xQmDVH4hTvRvGF2zz9pauW4VNndqBMr15W8rmlyliHJ+s58zpCzL/x01VwZooZ0QIloL/nGj+GsMwXI3B/nmKjff/VtRWyn79Me3aorCZkz3U0aCBye6wsav7EtaRjX083P2JdfcmJJ8gWhBEQhhDQJR0IkLT65Zg6ZoNKQPUNLseSbO3GjXzIzoDc6Fn5Qw3Nql7gqGXD/VXVD/d1GhaWt9TFxcOuW1jCHSrMjEc2h7P1W6SX3j7TB45vTRgq60UKEoqfiYqtQRFF3dr+7NC0BeOw2KRyRFKD1CAubJ89Tbh0uOfi9qdXIfJFpHlzqzbcDafoGlm3XAabuy52H61Lv3IwzaTNbspGpdeHYapwDoqGJPjjrAlO3LO9APUI4OKwP6E
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 19:42:22.6211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1487f2fd-0407-4505-dddf-08de94ddc9d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8215
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19104-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4C68A3B3EF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Or Har-Toov <ohartoov@nvidia.com>

The current devlink resource infrastructure supports only device-level
resources. Some hardware resources are associated with specific ports
rather than the entire device, and today we have no way to show resource
per-port.

Add support for registering resources at the port level.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/net/devlink.h  |  8 ++++++++
 net/devlink/port.c     |  2 ++
 net/devlink/resource.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index f5439d050eb0..bcd31de1f890 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -129,6 +129,7 @@ struct devlink_rate {
 struct devlink_port {
 	struct list_head list;
 	struct list_head region_list;
+	struct list_head resource_list;
 	struct devlink *devlink;
 	const struct devlink_port_ops *ops;
 	unsigned int index;
@@ -1891,6 +1892,13 @@ void devlink_resources_unregister(struct devlink *devlink);
 int devl_resource_size_get(struct devlink *devlink,
 			   u64 resource_id,
 			   u64 *p_resource_size);
+int
+devl_port_resource_register(struct devlink_port *devlink_port,
+			    const char *resource_name,
+			    u64 resource_size, u64 resource_id,
+			    u64 parent_resource_id,
+			    const struct devlink_resource_size_params *params);
+void devl_port_resources_unregister(struct devlink_port *devlink_port);
 int devl_dpipe_table_resource_set(struct devlink *devlink,
 				  const char *table_name, u64 resource_id,
 				  u64 resource_units);
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 7fcd1d3ed44c..485029d43428 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -1025,6 +1025,7 @@ void devlink_port_init(struct devlink *devlink,
 		return;
 	devlink_port->devlink = devlink;
 	INIT_LIST_HEAD(&devlink_port->region_list);
+	INIT_LIST_HEAD(&devlink_port->resource_list);
 	devlink_port->initialized = true;
 }
 EXPORT_SYMBOL_GPL(devlink_port_init);
@@ -1042,6 +1043,7 @@ EXPORT_SYMBOL_GPL(devlink_port_init);
 void devlink_port_fini(struct devlink_port *devlink_port)
 {
 	WARN_ON(!list_empty(&devlink_port->region_list));
+	WARN_ON(!list_empty(&devlink_port->resource_list));
 }
 EXPORT_SYMBOL_GPL(devlink_port_fini);
 
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index ee169a467d48..f3014ec425c4 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -532,3 +532,46 @@ void devl_resource_occ_get_unregister(struct devlink *devlink,
 	resource->occ_get_priv = NULL;
 }
 EXPORT_SYMBOL_GPL(devl_resource_occ_get_unregister);
+
+/**
+ * devl_port_resource_register - devlink port resource register
+ *
+ * @devlink_port: devlink port
+ * @resource_name: resource's name
+ * @resource_size: resource's size
+ * @resource_id: resource's id
+ * @parent_resource_id: resource's parent id
+ * @params: size parameters
+ *
+ * Generic resources should reuse the same names across drivers.
+ * Please see the generic resources list at:
+ * Documentation/networking/devlink/devlink-resource.rst
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int
+devl_port_resource_register(struct devlink_port *devlink_port,
+			    const char *resource_name,
+			    u64 resource_size, u64 resource_id,
+			    u64 parent_resource_id,
+			    const struct devlink_resource_size_params *params)
+{
+	return __devl_resource_register(devlink_port->devlink,
+					&devlink_port->resource_list,
+					resource_name, resource_size,
+					resource_id, parent_resource_id,
+					params);
+}
+EXPORT_SYMBOL_GPL(devl_port_resource_register);
+
+/**
+ * devl_port_resources_unregister - unregister all devlink port resources
+ *
+ * @devlink_port: devlink port
+ */
+void devl_port_resources_unregister(struct devlink_port *devlink_port)
+{
+	__devl_resources_unregister(devlink_port->devlink,
+				    &devlink_port->resource_list);
+}
+EXPORT_SYMBOL_GPL(devl_port_resources_unregister);
-- 
2.44.0


