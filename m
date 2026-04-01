Return-Path: <linux-rdma+bounces-18912-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PWWKNNqzWkkdQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18912-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:58:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C77537F87D
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5081E309255C
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 18:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BED047B403;
	Wed,  1 Apr 2026 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IELB2sCJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B2D26E711;
	Wed,  1 Apr 2026 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069470; cv=fail; b=Th/K6ADyTD103D400+3vKOAw3A/XgSKy4GDf85FWGRhTseY4/1BRA1XmPDIqBDeJYIg9aC4w1sSC1xy/+H8cnaORbn3xvKpq6zqwStf/TDk94uDT7FMNqBE9wtI1dKwmlPEH0ieIJjXQnotiAdLpU1i4WBXBGD3mgQsw0T7Sxvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069470; c=relaxed/simple;
	bh=WLUN/AeB/om/Gh7k7+SYlm8IBgnX44fqQcf2ori073Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGhHooHjjmQsCrTHEA+QuFF+VFLc+ceRR8K3KBkj0ro3Wei7z0pyRLKGgR94BAbCGB9Tsz9ig87WafJ1dbhiflbRI4hQCtjvqzRaXUJbTuGrJs7jzGOJ1zTH1rGUw7i14j/Na3BvwPKj3uEmVlJJAFKLLnPc/18PnvPg0Ir9vE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IELB2sCJ; arc=fail smtp.client-ip=52.101.48.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBdJVG2MQDlXfra+wP/5FHBMN6DzV80Nohr9MQ8TrUp8im0Py4qxyxANMvjL4jdZNFbnb7BGnVGBmQCO7eietDczrOIPClTepjIDuROTXCsuZcYgNfbAk/1fJUwnnIFnFA6aYYfpysM6jUFQEd4TghT0eo78/rsU/GHjfTcv6orCVd7jfK6sJC5MF6vvplOqp/eg7HzaTdrgxKrQPVq286xcz62lNhbAyzbD/bATGbqLEujp8RgmYP9xoia1TJEP4oLQ8mmoL+nHlb34aYXjzNHbrt+jkKhAIys9MxpR7Es9WgAYnIZaMnutrvNkyokcPjsahiLG/+Mt3pMxGep2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcYuagJaoChyF58GPXGb5faPOQGoDeLF/02LtJPF0Tg=;
 b=hTNqli7gXmR3+bwpRyJ3no2DVw0U5Nrtm3sqYog/SzFfuFsbvWScaGXVUMZciGZezcnY8eZGHojB8Qf8kCrNGnzlvLNr2pjvw4IVg1gIOyPicSQVZcoQHkoWps6s7ZbLs+psY/cAy8ep2usDg0qDSZvz9HM/TLh9VnZPL2gJ0IZ5+zNe93iJyJK1Gnwxx3SRQ/xSQixzihk66FEnl52CFN5MkeXLM9B72p6g01JB8CKULSItk/xQSx2Gpa5OHHxaiftHwHtOmZimszhSQtSfV1wxpu1blnUoqjxEXywLniPgx4x4g9ac/Fp9CK0WN1RMOJiWmNVyeHSA/6ZewjcSFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcYuagJaoChyF58GPXGb5faPOQGoDeLF/02LtJPF0Tg=;
 b=IELB2sCJe9ojZKjcTk3ASc2PIuwbXQxDUAw5osaq3+pydX3lPV6JIWyFR4kviJRkCk/be3KrryLqvsF8M/iGLvRfiUJKh2RyB79/xfwigACff2lFH1eVp0tYmZB6h6aM6/FkNVNXHGHVaxXxnPACwlA9lXwjohKixlR8bFOObl+PWq6nIZqyNmxtkFUaX8RXJLIvB711dX8r8/sxls6QSTx/pIKQOk8vTBs4AroG+BQjcXN0JUIZ3b/ZicpgOa5cKoaZmriqzajmn0zrhrRC20ajTGN4+VhS1tiKLnmKQIgl6WOXNSbJ1UfADF1i4EMa4k7IJnU0mNsKvNIjzwk7Vw==
Received: from BYAPR02CA0045.namprd02.prod.outlook.com (2603:10b6:a03:54::22)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 1 Apr
 2026 18:51:02 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::70) by BYAPR02CA0045.outlook.office365.com
 (2603:10b6:a03:54::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 18:51:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 18:51:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:50:39 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:50:38 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Apr
 2026 11:50:30 -0700
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
	<gal@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V4 02/12] devlink: Add port-level resource registration infrastructure
Date: Wed, 1 Apr 2026 21:49:37 +0300
Message-ID: <20260401184947.135205-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fdde610-3a9c-4738-2ff1-08de901f9f07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	NobesJOmAx+ZqAIeVA/VhdFQHLlta0sO7MwXt4KQxkzJie0DVZI2iT4z0n7kqht1HdWRi/2fpRn1Zen36R4yCqd7Bff3/Cr/eXWdofw4UTN0zobNrTg66PlcJOjQu/3hULrTdEj99Jm8zvnQFFz9b/Y1G0UxaViQEOfIYELznMZdcG+XvMY8FgrYwQzTxQYs8oKf/Y5NUPGj5fE5TKRxMgvyA+Xgfsc+TkZ7Sp2l714K1j2QKjpA+hF663yXqk/KYtaTiBr1ltHKCCXUCvsmiJWQg2XO1fI32b5PXrqapOKlLtG6HkS7OgTQ3gAK2NOatCGjIsq4SuM8R0OeEmKzUD8ymyA4+PqaKtcSgotWaWkZCTBc4fadX6pTotX36Hce1yKYfuSh4+jjpf3jSeuYY3H2PHUSgSI7X4UM70cgQm5+PxBHwgHD6BHx/MIqHyK4JaeEz/TVQB/jDMmyk6ksF+NP4U9sdJDdZeTr8MoJw6KI+j1PlCRWa4sWXXSa0oi3P5bRMuf+2p1NZ/zl6rA5hxEoqlC0hdoqjBZ1e1NoR7zRk5LNLffZ0z6hqo3mrIOf8Ggpe8Fv05Vxz8CvwYQAAsWRPSGYzI0AwL4dhlruDcHf3/3FhauhzPtwp9TMlyrxzMJdgrmQ5U3amEoW0eEINRlsYOUqRhJY2o2DiU2TX9WHV7/FNGuk+jgMUkFmPG4LyWfQEJPDgjQBinnIzQilFExvLiV586ZRHl1mS30M0iAEuJHBrsoq/HNG4t3qieyfDER5wLnCazylc0ZiWSfFKQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wRmTUPhlyEnFWx8tY6ilvoIrVxqMs7018/1AWeIqjVGpvfVw20LxAA2qQdqEEzfOzs/PcgJmoX/Fy1LgQlFppRg4rNC2fDPmHTDPigac8V+agfjSvydxRIYWHz7FlMmpbSNiKmG5TrZx5C7dBHZ5PcoaMUhBG1sRLXyct0gA5SRuYQYvjn8VlY6JxCL9U9BVAtQYis9HD9AAp/qksfm7vzAa3E2S2C02wohLkR4VENMBdaec5NdFaPqugpPjTQogaSEAQdaBuAPB+oJlaPcLZdhYBT/KctQGjR8L+It8UVngZr3ZU19OrSrMEW0/rruSCQMaCqU5ErxwTJ/S+Egrwpt3y2Nq95FVsORmE0pURASlaJ9QcA8V3929QtIJXTtdSGMw7q3OGAdH4OAPq4Ff5JamMT21MEdv7vkejXZbV1+IVFftBdDPrkakxFTujl4L
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 18:51:01.8229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdde610-3a9c-4738-2ff1-08de901f9f07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280
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
	TAGGED_FROM(0.00)[bounces-18912-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3C77537F87D
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


