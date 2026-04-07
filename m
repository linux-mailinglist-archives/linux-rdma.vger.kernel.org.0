Return-Path: <linux-rdma+bounces-19108-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFMcI6pf1Wlq5QcAu9opvQ
	(envelope-from <linux-rdma+bounces-19108-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:48:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5243B3FF4
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D4D6311608F
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 19:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145C5378824;
	Tue,  7 Apr 2026 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CKH+pF4j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0676B3783C3;
	Tue,  7 Apr 2026 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590990; cv=fail; b=AANMlnVs05TO9VIorRucXT76JxL+NNI1f6BPzZdpoSxiBXuZU5QOCdfKH4PUPe5U0Op3I4R5dsTj4tc8PZyPiNWg28MIi7chz0J6isX2factoBxSqSXig52RnRC98pVXU+gKulS2zfH/nQpszys4OzvqroVN4OwuEiAfm9VDCjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590990; c=relaxed/simple;
	bh=G7KzlIA6Ix1XvzvIUiMPRTwVXAQHZa6+rk68/WIzqVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iClGdWQuyrpcLAkXp7ZVFxRUDUpidN9yN4mJPWjV60T18fxx9t6YHRbu9tUB/QkY0ektdkEqj1rgfiDTKlPyDQtggzg791VSIQYnBeu9ci/KBVpSZ8+5Fgvsp2fQJARlFUCYGtlBo5sMLz2rtc0nMvBrb7BK+TS+sQS6Dmk6U7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CKH+pF4j; arc=fail smtp.client-ip=52.101.85.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCcOAoyf57I3cMaihwofzeitetiCYQLI6myIPHkapE7emFxMshkCGifLMAWRxXPyTPz6AxNW3rDi3VQ2VVthnUUfN2/wy/lPsFEjXBQZV2UmWdVuIy+glRPOIEe/DHZ+UNtdlkaCmbiANde9isv/oMyWWMLTgFcOJnVjnhvIGNkFU4G6mlL8KQj5Z4I0xOFqAFTL8d5KvxqSeTLnJ78u/oZ3o2rBeMOPbcZgolWFU+UIk7eK6CHgqYqa9Xt1D7Ga3IUMs8EA9c39hS9zVjzsIJ4gSg5LnsPRR8c87PfKSwV/YgGVvmicMYI49jNJB7XEgX4i/gqERHG2vxDKZsoVZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0lzP3FEuGdTEpBm6q3Bn8kY0M2482vBdcB00OtSOR0=;
 b=Jf053+KY+P0eZCKErTT5qLqBuPCGEidOIH/tSM2Ej7cxVznXg9wQcGteZG+KOOZaeTsFYs1VpqJqz0x4fGKiWUHexVSBsxmqNK3RWyEK+vyppVR1BinhebvV99MYn/Q0fiVQsf/siid+H4alfXWHtK/YqrG69URyTq80Emmh0TtDo/EdWlZBIA/oxUuWKOp6lfHk5z5/Uwl3RaILcV+vWprQ3Nd++fXGQ9jWwQ1shQg2k+37oUBQBwq2Y0KJfSp8SIp2qoOXiXKbdhSrllcrNsPAKm6K7R90Kd5ZbEt+lFPlVhMSo3r5LzqQ3xLT27PoBgXAO+N+BghCUW3q2ogV7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0lzP3FEuGdTEpBm6q3Bn8kY0M2482vBdcB00OtSOR0=;
 b=CKH+pF4jgSsD+J0UNUtj6GMXL0WsBCeDbdeF3CSfB1HLbji5qUeNu/c9Nt0AfX/WTlgOLwCnXM+W779IIQyuRk2o+Ne+Tqu32sxBNecczqy4K0kWLfwLMLQI4Jx8nHg4rMfRSQgRRQJ9FPQ6okl7Nj3B73EpNkOWJNFZydwUtPiPWBcvDW+INUoqgLwJE/Tra28IHbw/DnIwejPmuQHvcX6aGpsaDpcwAK4hVTiIjeDma/DUl7ZXp9Pj3cnrpXT8xYvFMZkTzY08+/rm6F1U3Tg8wVVcaxG140UIvip68osNV+jlcq2RXfJ7cZyVUYbA9o70/EbFa82Q5AdVUB5iVw==
Received: from BN1PR14CA0023.namprd14.prod.outlook.com (2603:10b6:408:e3::28)
 by LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 7 Apr
 2026 19:43:01 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::6a) by BN1PR14CA0023.outlook.office365.com
 (2603:10b6:408:e3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 19:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Tue, 7 Apr 2026 19:43:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:42:39 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:42:38 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Apr
 2026 12:42:30 -0700
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
Subject: [PATCH net-next V5 06/12] devlink: Include port resources in resource dump dumpit
Date: Tue, 7 Apr 2026 22:41:01 +0300
Message-ID: <20260407194107.148063-7-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|LV2PR12MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d866e84-fc92-40eb-5119-08de94dde0f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fkRQZM3BB+zeNBPyWMyKQZ2cyr6UCBnXGJ2xjGmLCfDQq/RpmoE8JhM1o0A0ohcSJjmoS9IDKq0tQ1V4wB3Y2q/SCzDjiIzQblABqZ4CQtq3SugbhFAAArj2KQtnCymDOJUjzsayVtH6CwsgIPVRxOayTJXLihEiCJlPFkjQpHqzHzLKECS6qHxLWD1RZVS9nWUffnipvPY7x/62CdjzhuZBmHUYOss06apjXB7pViBQz/unVAZ2k7B5h+wPXw2mIvGDhhQLODcZ8stwgOi5yAsSYREwbph13a0qZWQVQGHSYq9T5pZ1D7Ia4ssr4CTQtYcAD8e0DV/KnU+L+9Q0N98XfOuPUNf/gE5Z+Um9ZGwxKEiACXdqLz7zWH0ruAaLiKwCF25gCRQCZ+y98QzGy0PzqXHIeuSQsD/U+I5U3BRsV84S+qGMIS4pXTd9UQqi9IgDicGAFDDVSxFkyCazL118Ji2ITBKT2p+YjE5y+gOj3oOtugW8gBfYL/70V6ntMScE1OZGcIQ6B6Znk7vHaFTq9fjC+qsA7B2JUU2Ks9OmT1bOQIqvf/dqExCSPoNNXLXdeo6bxGV9muScQIgenjfxFWeteXWWfmfHqilRSD26w+YRgmYGIVmm+SvvSEnKlsfM4EDpVslRU+xePgNn4Hgw5n7KghtoeYqY6qATvPeCxTIvC7e1kVQfgd1BradQm98ZYyfRzV4G+tk4Y+idAI807bouH7MADGu4wB4Hesx+ld4aaFBiHQZb1ucXzUk7IufJ9IGzlY0BMpIFXfoO9Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gw2uTLPavguaoOSq9WexWyGbM1XjCP+QfFJKhqzX4Tb6lTXPn/4lE9/cNlBnuhHqP0489E8a4Gll11HQG4gODumiB7yYnEzklodPIWax0p1FfUwJCemUooxhWYC7H9BSFHrL3pdmEp8WDCFva47j8onz+LmBSzkWW5ZIV6f+ZYcWTbqaFrTeAjdktcmt0o8wgzdUk+owrqTmycAJYND/NGbLAKrwhGirJBsATB2nSeH3vYW5CDtgLFycK5iT8s6r37Bhc94X1EM7rLRz7+hLZjeh4F3E6afV9sFOJxTQLQCRTmVe8Boh2P2OJqIOzXyy525/XnjuLpqI2xbB2Gs49+jYF9eMAZpKB6xdB20HbLqFGGSkXZwBwtRRaPvN1R4ySjt3/SLz3fE+Og7EsMx+xHiyXBOao+eFHz5vNi+abQoIuXt1dNmQMYkyjT5E0CMZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 19:43:01.4380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d866e84-fc92-40eb-5119-08de94dde0f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944
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
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19108-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2C5243B3FF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Or Har-Toov <ohartoov@nvidia.com>

Allow querying devlink resources per-port via the resource-dump dumpit
handler. Both device-level and all ports resources are included in the
reply.

For example:

$ devlink resource show
pci/0000:03:00.0:
  name local_max_SFs size 508 unit entry
  name external_max_SFs size 508 unit entry
pci/0000:03:00.0/196608:
  name max_SFs size 20 unit entry
pci/0000:03:00.1:
  name local_max_SFs size 508 unit entry
  name external_max_SFs size 508 unit entry
pci/0000:03:00.1/262144:
  name max_SFs size 20 unit entry

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/devl_internal.h |  5 ++++
 net/devlink/netlink.c       |  2 ++
 net/devlink/resource.c      | 59 ++++++++++++++++++++++++++++++++-----
 3 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 7dfb7cdd2d23..e4e48ee2da5a 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -164,6 +164,11 @@ struct devlink_nl_dump_state {
 		struct {
 			u64 dump_ts;
 		};
+		/* DEVLINK_CMD_RESOURCE_DUMP */
+		struct {
+			u32 index;
+			bool index_valid;
+		} port_ctx;
 	};
 };
 
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 32ddbe244cb7..ae4afc739678 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -370,6 +370,8 @@ static int devlink_nl_inst_iter_dumpit(struct sk_buff *msg,
 
 		/* restart sub-object walk for the next instance */
 		state->idx = 0;
+		state->port_ctx.index = 0;
+		state->port_ctx.index_valid = false;
 	}
 
 	if (err != -EMSGSIZE)
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 02fb36e25c52..7984eda63eb6 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -328,16 +328,20 @@ int devlink_nl_resource_dump_doit(struct sk_buff *skb, struct genl_info *info)
 }
 
 static int
-devlink_nl_resource_dump_one(struct sk_buff *skb, struct devlink *devlink,
-			     struct netlink_callback *cb, int flags)
+devlink_resource_dump_fill_one(struct sk_buff *skb, struct devlink *devlink,
+			       struct devlink_port *devlink_port,
+			       struct netlink_callback *cb, int flags, int *idx)
 {
-	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	struct list_head *resource_list;
 	struct nlattr *resources_attr;
-	int start_idx = state->idx;
+	int start_idx = *idx;
 	void *hdr;
 	int err;
 
-	if (list_empty(&devlink->resource_list))
+	resource_list = devlink_port ?
+		&devlink_port->resource_list : &devlink->resource_list;
+
+	if (list_empty(resource_list))
 		return 0;
 
 	err = -EMSGSIZE;
@@ -348,15 +352,17 @@ devlink_nl_resource_dump_one(struct sk_buff *skb, struct devlink *devlink,
 
 	if (devlink_nl_put_handle(skb, devlink))
 		goto nla_put_failure;
+	if (devlink_port &&
+	    nla_put_u32(skb, DEVLINK_ATTR_PORT_INDEX, devlink_port->index))
+		goto nla_put_failure;
 
 	resources_attr = nla_nest_start_noflag(skb, DEVLINK_ATTR_RESOURCE_LIST);
 	if (!resources_attr)
 		goto nla_put_failure;
 
-	err = devlink_resource_list_fill(skb, devlink,
-					 &devlink->resource_list, &state->idx);
+	err = devlink_resource_list_fill(skb, devlink, resource_list, idx);
 	if (err) {
-		if (state->idx == start_idx)
+		if (*idx == start_idx)
 			goto resource_list_cancel;
 		nla_nest_end(skb, resources_attr);
 		genlmsg_end(skb, hdr);
@@ -373,6 +379,43 @@ devlink_nl_resource_dump_one(struct sk_buff *skb, struct devlink *devlink,
 	return err;
 }
 
+static int
+devlink_nl_resource_dump_one(struct sk_buff *skb, struct devlink *devlink,
+			     struct netlink_callback *cb, int flags)
+{
+	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	struct devlink_port *devlink_port;
+	unsigned long port_idx;
+	int err;
+
+	if (!state->port_ctx.index_valid) {
+		err = devlink_resource_dump_fill_one(skb, devlink, NULL,
+						     cb, flags, &state->idx);
+		if (err)
+			return err;
+		state->idx = 0;
+	}
+
+	/* Check in case port was removed between dump callbacks. */
+	if (state->port_ctx.index_valid &&
+	    !xa_load(&devlink->ports, state->port_ctx.index))
+		state->idx = 0;
+	state->port_ctx.index_valid = true;
+	xa_for_each_start(&devlink->ports, port_idx, devlink_port,
+			  state->port_ctx.index) {
+		err = devlink_resource_dump_fill_one(skb, devlink, devlink_port,
+						     cb, flags, &state->idx);
+		if (err) {
+			state->port_ctx.index = port_idx;
+			return err;
+		}
+		state->idx = 0;
+	}
+	state->port_ctx.index_valid = false;
+	state->port_ctx.index = 0;
+	return 0;
+}
+
 int devlink_nl_resource_dump_dumpit(struct sk_buff *skb,
 				    struct netlink_callback *cb)
 {
-- 
2.44.0


