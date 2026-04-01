Return-Path: <linux-rdma+bounces-18916-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPFWLwVrzWkkdQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18916-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:59:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4ED37F8B4
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7021830BDFF5
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 18:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9235447DD71;
	Wed,  1 Apr 2026 18:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H1M+qAWn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E386B47DD57;
	Wed,  1 Apr 2026 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069504; cv=fail; b=SpwvCSqf9tIgS716Dlhe2r3kI2NT98pYmhd/7EfFjOHpEwXo0muAt3llhnqtxAC4oiefTavQ6u6yX5JxoU7Qg277V2NxYP1aVy1QUm3Hnl02as92JOCiRcgggMEA5edstGTbymbOk69nblb8FhMLaMddzj6SXOnq7VFUWY5e8uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069504; c=relaxed/simple;
	bh=RiQexCMPo+00V4cbKjzEUCVsreLQQ6CkM0W8qN5QPM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZRJd2Jw5+6B7g7EnYXv2Z/xQaobkmJVNhggjamp8lkUlEIMMcF2Nb0cF0wVPTt5dOoAYtW/djRfF3y0rRQWhWaOmiFtyrSL8P8K9rrq9nbGI7uzR8S94zuykGfg5V27fq16uHqPfBxFBFd4SGbJF5AhJjxxAsjk8PlFj71/2uno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H1M+qAWn; arc=fail smtp.client-ip=52.101.61.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weUmg9FqRFp97P6NDhgbjvbH1OMpAq3z6REobHaCKKUhGsFhq1GEw4CrxMnOirzcaAZv0RS6v1lWd9GeHrZEMqMPiqVx3TMLhy/8Ymd+VEbx2FbVchF9gc5HpS9QmOtrbgdnuqRlJtQdzhL/HEMp7OJpfDY1RZW92ro/XklZzq/JLzVvZNqU6QbNN0yydN/zRLIJR3SoxMH5Qv56tf+F+7j1VRKR0Q9qM+W2emQVLczjs+HnVx7EPAjo0RP/NETBxwpSW9FT2ydh3XH+4tcyKR6eSNB6T4zDGJjKDX3cA878+Qb3W/XEYik2zYygNmnByQNij7HHfIolT/ig41UqbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heqYlVjZ3tjUMcFQM4kzd8E6+b0/nlvYevWDJyjzK78=;
 b=iYPaPK6jXCG0QH52C8Z7FlGCJJYpq9l+jLBkIdyfWfAuMQbldAqzvu+Y9O4w1WknxLCqbPle07jMdiwhQ/fprQ2JbJ0WK8PNGMe/HHRWsPZUstORtN8rgwz9qTDnt1eEyQMr0fPL5VVtY8nDXRq5lq5KMhA2t7Dt9nfcE+Dmx8avNpH7zP394HdWqo3Kz2F6ZKqE0LCYV7YyIAaNK3dy2O07baXvTt3v+XZdXpE/n1+OmQOAU2K49HTYk0rR59a7e9RBAMa4YQG9A8EP4t8oFTFONZp+QlMdr6Ry8OCawcdxOhJw2Dj1u2HJNMKlo/Q8LNL0v3+6FBeM5NgOQ/mr3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heqYlVjZ3tjUMcFQM4kzd8E6+b0/nlvYevWDJyjzK78=;
 b=H1M+qAWnB14iqli9zc6H1z0Uk4DdYRFAI1e34ueIgc6fTx9PJdfGZlls+8J2cUM6356HEE5bRS8wCShbOCbefdUqN/A7kw3zM/RyWMSmGv4IAsFJ2qa4boD4LeWGVSsBN0EMzWPj6xOSv/K+Hg/3r/FhIaX7Uas3ghouPJIuzCaRyLOqcM2AF13ir8gCTnp+NI00DyEDCdinY7JxduVDkzPkhU1l2a12LtDEAALnoxEDM0RDHGILO1COR2CuEkTo85tGF4G1jcCp0yGiKYSyUUOutTOlCghErrIrYU3ERBf0fEkLAH71Tu21iXUBNOaklobyaK7EZuQGozrMRG4BCA==
Received: from BN9PR03CA0178.namprd03.prod.outlook.com (2603:10b6:408:f4::33)
 by MN0PR12MB6223.namprd12.prod.outlook.com (2603:10b6:208:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 1 Apr
 2026 18:51:36 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::53) by BN9PR03CA0178.outlook.office365.com
 (2603:10b6:408:f4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 18:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 18:51:36 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:51:15 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:51:14 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Apr
 2026 11:51:06 -0700
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
Subject: [PATCH net-next V4 06/12] devlink: Include port resources in resource dump dumpit
Date: Wed, 1 Apr 2026 21:49:41 +0300
Message-ID: <20260401184947.135205-7-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|MN0PR12MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: e770d823-ef9b-4ab4-dc78-08de901fb372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bH9Iif1k2Zy2ld2ujYe9wAxNzp4uv20wyGoh+TBI/YH5pQZPERyK0gfk9Mclm4yljLnoEn94VF0nCgLNy34a8MFObfRTl4J0A85eykolwFt1Ys0+mMjDWwVex7R9ESTFEEv0dZ79H/F/GqSfLLm7OLfYwbhzyQiX+R/Ss0CEMGIPc82wHXa4woHmxCu8JoYEGY1AdlDRoRtjmsCNddQpFJuLrhUgUQnvMjBv3sGtNcsn45ePXiF63VYNVs84Uw9LvDuWFaoHEQVykFhpjq7cKC1LRXgoQg8oNSXOSmRWWtIEjDp5FZbPTmPWKIlCEsBc71V2wUxoZZgHmo9cm3vnBQbG5jnOpOtpOfHBLRRWe5vLm436bA25mIw4D9WMeL8JUVKZ1rYRma8qW0J62CJz5Afj/dIsew2Q2++MbNoS7y9eiCBZfvBdDt00yhtZ8Wn5Zhi9DZGe3vXQR2doMMffKxF/cKaM/czZQqPQm7gxd5+CNiiRqAhMi8iwGs4Ga+FTkcmNyj1b26sSJx4CH+1Fz/5MaG3Q24zjOEEjbZeVOrMxoMOjyKtGvsGt9/gOks0CQmu5FyjR1av5/Yn3/f4Or68uooHcZPW3zWGCby3QA88nunoQX5b4ff5Jq+yucwOTSscKQUZeKF0mTb9+foHrErplhVwa6wZHvTgGNuRG8NlEp4877Ik9XGFCqXz+AmMrkhlfnEsdBEn9rD9szoq3UkEi28A4uoBIq/MzOPL1khneQJGm1eJd9lgqVbSBUHp+GmiwvaIpcazC0dA45J2giw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YkFAT37oN7nAlHZDR0d2CewDvCZUK/0MY4xDktOJNtWrjwQtM8a8W5/GZcu5G3kuCat7yRgpR06rsYvii3+RWKVpnKVDckc35lP0SgqshZtHat1nNzb8cO+R/6Sj51qV4eLa+PPjYC6Rs+N9fd4HpU5IFP00QBzbZDGqloXI0w2fV/cQoLAX4MVB8u7h4tHEBep/2Q3aOEXSGQk8KRIjtDN4X3pWInfC1MtcoG55fKCK37WdT55sf9VP1vCVLBrZ2VqdDAekl5TPW84PYLX96/W16D+0GpEbFJXSJiYlooDAgZ4hziU0xjMNoHQ807ujxXIyESiJlfb5RSbHXfQqEcgTnzd/obRHk9tJQAYF+6hRG2O7G8OEpWO9gIPHD2PoNkUhY0noLCEPSLPW983n9tAsXFwqGN530hgKo5f4hqwH0k+DOhOw0uRu4PfNst6w
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 18:51:36.0260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e770d823-ef9b-4ab4-dc78-08de901fb372
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6223
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
	TAGGED_FROM(0.00)[bounces-18916-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 5F4ED37F8B4
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
 net/devlink/devl_internal.h |  4 +++
 net/devlink/resource.c      | 53 +++++++++++++++++++++++++++++++------
 2 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 7dfb7cdd2d23..000b8d271b90 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -164,6 +164,10 @@ struct devlink_nl_dump_state {
 		struct {
 			u64 dump_ts;
 		};
+		/* DEVLINK_CMD_RESOURCE_DUMP */
+		struct {
+			unsigned long port_number;
+		};
 	};
 };
 
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 02fb36e25c52..48f195063551 100644
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
@@ -373,6 +379,37 @@ devlink_nl_resource_dump_one(struct sk_buff *skb, struct devlink *devlink,
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
+	if (!state->port_number) {
+		err = devlink_resource_dump_fill_one(skb, devlink, NULL,
+						     cb, flags, &state->idx);
+		if (err)
+			return err;
+		state->idx = 0;
+	}
+
+	xa_for_each_start(&devlink->ports, port_idx, devlink_port,
+			  state->port_number ? state->port_number - 1 : 0) {
+		err = devlink_resource_dump_fill_one(skb, devlink, devlink_port,
+						     cb, flags, &state->idx);
+		if (err) {
+			state->port_number = port_idx + 1;
+			return err;
+		}
+		state->idx = 0;
+	}
+	state->port_number = 0;
+	return 0;
+}
+
 int devlink_nl_resource_dump_dumpit(struct sk_buff *skb,
 				    struct netlink_callback *cb)
 {
-- 
2.44.0


