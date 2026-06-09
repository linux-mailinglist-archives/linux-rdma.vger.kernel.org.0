Return-Path: <linux-rdma+bounces-22003-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Sh8LMJunJ2ru0AIAu9opvQ
	(envelope-from <linux-rdma+bounces-22003-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 07:41:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 998CC65C7FF
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 07:41:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=YpdNYrTp;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22003-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22003-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05804302D0F7
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 05:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E5E3C8196;
	Tue,  9 Jun 2026 05:41:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012042.outbound.protection.outlook.com [40.107.200.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420B3369D63;
	Tue,  9 Jun 2026 05:41:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780983700; cv=fail; b=ttNeHlubWh0z7m0NsEY6CARvNvimOGYNo7ctuUeDOZADmVETcd3+tKG9yyCQ3CDPdOO4NVogGmWAZmLY7bMZinfHJ+hltOzzAju7JtteGENRJ5zZuw7F7XjarBnf+zopP13zrUbfHOlIp77xz1uMJbZowvZmkypnc3hETmWV9S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780983700; c=relaxed/simple;
	bh=HvLbXJpRnmxAbl8Hh6T1vC114txfrNQ8ZQC+KRQ5VJQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QnTzemCANO291ZXxMOOF19WUh/1zxB+f63OXvoFXf0jRZsBkNzRAGyhzNL9J89BPbV1+5gTcA00Pbf7DghHhM6reKuXvaQhf8t3/Zjge23Q0B8vQrmLAwexxg5UrBc4sjinMseMbQtP2KsZC7DfEBI0o4Wi5N0okrQIOXhkaXUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YpdNYrTp; arc=fail smtp.client-ip=40.107.200.42
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxh01DwFf/xQKgHPTn0Hh+ZahVr9Owu49J3CzmnKIZkuse04ex7Yl0cYn6ZTmbwX/dqNDe9wxieOWsWYIprfn5+fsEJF6NEv4WjXd+SDiLvHdMupY7d4TiydQCkqRvNhApFp1wmtgUEbC0NRITiEy/Uri8dzhti47RiUmSJ8lbuh/fejEuvQ7CbNoWqtu6uW2y858qOKgPbpAKVnOo71ZBaVD4D/r5n3Qad/R5YM8ZWhCAzYS9z33wYUKWJmOgRscpvJ/LPG5/pcl1dEHiz0lYIVdGr7awHPzoiXPC7EqA4Per5TxVh+chMdIvSOrMlBu048YWimr0sBPKPJ22d+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLT/jPX4RQ5gdkE400kI47nj37KN1kHPGZ9gUM34XTg=;
 b=vcwn5Lao9mIJvK4eHK03+UDEoLLCrUPc563xbU4OLKbBRu1+/NjkTd07PSeto3keYQyTTOab9nSakcEGML3TThfpC0B2HpA6SEXymzrelOPYRE1tswEp7ySrxtqLRBoPkYVnQ0yzoooHdn2S71/b8oGQ0J3+nX4mcMpcLS6wIfhGAyjTMWa5MjSlynBYlp8lvwIAOe9/ZZ7kJf98aPYHQtVwUshh0x73EJWPpk3ulOaxPRwSSWLcGSb93jD5d6OU/kwwOXaqbZD2RUvnn0N/x18MWO2lbGVE1uby71T1W+GTnnRRAieVfO8WZ+h+RL7syvxr3q5VvWOEy2Bcay/GuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLT/jPX4RQ5gdkE400kI47nj37KN1kHPGZ9gUM34XTg=;
 b=YpdNYrTpuNU1+XgLAJkGzEiViX5jXKBQ+ZX+qR6VQczJ4q38/QTkNwr8TrL1Pn8iCTab0AypqkCzP+r1SanYmc+lhsXKhSPv+tzHIeHAL/satbbZALnfBdohg+iB4sucSsD8Eo4R+/1gpbG8rVFvIKM5wBXICH1gfDzH4ii+YbzoAtbpnouhxtjGakN2caApgnJtoJoaclu2gEdBZrxBufGE/+2IrGskDL8NFFsrNVxxTfbJMTfJEsDJiSy6UZgKHZoWWpe+In8iMsohaQqZsXwitJYjRsY+j+4EJNUpow1c/oHZoQgUdSYbYotih+5Mpfpn2HzcXivMri5dVpYIBw==
Received: from PH8P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::24)
 by PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 05:41:30 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:510:345:cafe::24) by PH8P220CA0004.outlook.office365.com
 (2603:10b6:510:345::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 05:41:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 05:41:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 22:41:10 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Jun 2026 22:41:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Jun 2026 22:41:01 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>
CC: David Ahern <dsahern@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, "Chuck
 Lever" <chuck.lever@oracle.com>, Or Har-Toov <ohartoov@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drori
	<shayd@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Daniel Zahka
	<daniel.zahka@gmail.com>, Shahar Shitrit <shshitrit@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Cosmin Ratiu <cratiu@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Kees Cook <kees@kernel.org>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Petr Machata
	<petrm@nvidia.com>
Subject: [PATCH iproute2-next 4/7] devlink: add dump support for resource show
Date: Tue, 9 Jun 2026 08:39:50 +0300
Message-ID: <20260609053953.487152-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260609053953.487152-1-tariqt@nvidia.com>
References: <20260609053953.487152-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|PH7PR12MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: c7af328f-124a-4fe9-3529-08dec5e9c171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	u/aqGt+v6wR2SW10aJC57YY51MZV8L2lJkCy4EJWxxlx+w5y7W6bxGVexWXjieer+oOakG2HfRgA7lm+LvEUbD0HZ/v4NkDrnKyG+3H3zdxKP4dlIfKEma6o7kWEHeXgEJ+v6w38IAksG0ITRmzzkFAqYtERxcTsHzT9dBZY8wJ8uYNNh40QUxRbE1+byMM7KJ6rRIb6m4RtaWTJmDjcJBynpTxFRMJ6t5RmxpB7S0Tluvi5pKTncQ0RTd/3GqdknbioVZ8XtDF1nyMZElLifpIml0Vo7M+HQWtzzzcuuQArc4s+/Fo2pW+rDK2YZ4IG0W/zd807g8KPx7MDSWo9BDuFMuCFOk7DuOhgkPBqx8Lp0+po/5z1YmOjefMalpp4DlWvvSBQnxLMw+wRIzu19E7V07aET+gttyTR+mwiYdFPgS0S9fXVQMI86xk7izEtB/oKLMDa/rhjPfzPYutpHD0trXb/vFyLExoeH9ZOWPxAFqiuzajRwUmUYK+74ahrmxqn63XMPHUi1Bp0EdwdSr02OV65iLCODuf8i4HN1fnmxRg+oRkjWSQQN0IdRUdSPzSEmHempdfWZMMxcy+tzs3vlL+ARaEwAgjFw3lnyuZjUPIzcYnoxbJv5qJjGrlQm/xpuU60MtqiyrlSx7hbfLEMaRGxO/q5+4GCxu+RDTCWCakrVuiXE4Y2NSV4nAUZK/DnjXF1DE/N0mhGMm/4tnzcrBsnf4Eycx07caW8i4k=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E/7pMJJUtknOTK8O2SHsPDTcpgo9cCIyhUzR+QX+tQbUoAWrZuQX6RUlsmatR+k2vgcorwYCuhBuvipPSRyk5tLX2R2c3Kv6T86TOEOJwX+aXQgb8sACloBmwXZOkYY/IHcCsh4XHlff7uqIKH1W+/3XYhTF7sgL1wLEOEMC+YJObKKuoJn4in8kUYFUMhJEpSOqVbRecGfefqFy52wOtEhSWPqiC6G1PtAd/XMCCyjGsAMLdSKjLdTvo0IMBAVpF/gtoyuUe3FRoNbSDEBLLqaMG56EmJq9K8aaRpKxjLXSc7f1ZdgtY8i5EeTzQh+vgidQBFK0Ne5tCusfK5uM1isD2XtRKzn5jZncXqb1S1l1TPnBMdplLHHNMliVbSzDDDCTZbIvtdf6Gfg3EZUTKajt5Z48GqUDdwR7Nn5i7uk1vdxKcFyKdSVm7u+dR+as
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 05:41:29.5431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7af328f-124a-4fe9-3529-08dec5e9c171
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[41];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:dsahern@kernel.org,m:donald.hunter@gmail.com,m:horms@kernel.org,m:jiri@resnulli.us,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shuah@kernel.org,m:matttbe@kernel.org,m:chuck.lever@oracle.com,m:ohartoov@nvidia.com,m:cjubran@nvidia.com,m:moshe@nvidia.com,m:shayd@nvidia.com,m:dtatulea@nvidia.com,m:daniel.zahka@gmail.com,m:shshitrit@nvidia.com,m:jacob.e.keller@intel.com,m:cratiu@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:ajayachandra@nvidia.com,m:danielj@nvidia.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:gal@nvidia.com,m:idosch@nvidia.com,m:jiri@nvidia.com,m:petrm@nvidia.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,m:danielzahka@gmail.
 com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22003-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 998CC65C7FF

From: Or Har-Toov <ohartoov@nvidia.com>

Allow 'devlink resource show' without specifying a device to dump
resources from all devlink devices.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 devlink/devlink.c           | 18 ++++++++++++++----
 man/man8/devlink-resource.8 | 10 ++++++++--
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index ba14c0056b1c..0962ffd861ad 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -7429,6 +7429,12 @@ static void resources_free(struct resources *resources)
 		resource_free(resource);
 }
 
+static void resources_reset(struct resources *resources)
+{
+	resources_free(resources);
+	INIT_LIST_HEAD(&resources->resource_list);
+}
+
 static int resource_ctx_init(struct resource_ctx *ctx, struct dl *dl)
 {
 	ctx->resources = resources_alloc();
@@ -8986,19 +8992,23 @@ static int cmd_resource_dump_cb(const struct nlmsghdr *nlh, void *data)
 		return MNL_CB_ERROR;
 	}
 
-	if (ctx->print_resources)
+	if (ctx->print_resources) {
 		resources_show(ctx, tb);
+		resources_reset(ctx->resources);
+	}
 
 	return MNL_CB_OK;
 }
 
 static int cmd_resource_show(struct dl *dl)
 {
+	uint16_t flags = NLM_F_REQUEST | NLM_F_ACK;
 	struct nlmsghdr *nlh;
 	struct resource_ctx resource_ctx = {};
 	int err;
 
-	err = dl_argv_parse(dl, DL_OPT_HANDLE, 0);
+	err = dl_argv_parse_with_selector(dl, &flags, DEVLINK_CMD_RESOURCE_DUMP,
+					  DL_OPT_HANDLE, 0, 0, 0);
 	if (err)
 		return err;
 
@@ -9008,7 +9018,7 @@ static int cmd_resource_show(struct dl *dl)
 
 	resource_ctx.print_resources = true;
 	nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_RESOURCE_DUMP,
-			       NLM_F_REQUEST | NLM_F_ACK);
+					  flags);
 	dl_opts_put(nlh, dl);
 	pr_out_section_start(dl, "resources");
 	err = mnlu_gen_socket_sndrcv(&dl->nlg, nlh, cmd_resource_dump_cb,
@@ -9020,7 +9030,7 @@ static int cmd_resource_show(struct dl *dl)
 
 static void cmd_resource_help(void)
 {
-	pr_err("Usage: devlink resource show DEV\n"
+	pr_err("Usage: devlink resource show [ DEV ]\n"
 	       "       devlink resource set DEV path PATH size SIZE\n");
 }
 
diff --git a/man/man8/devlink-resource.8 b/man/man8/devlink-resource.8
index c4f6918c9b03..b55138d950c7 100644
--- a/man/man8/devlink-resource.8
+++ b/man/man8/devlink-resource.8
@@ -19,7 +19,7 @@ devlink-resource \- devlink device resource configuration
 
 .ti -8
 .B devlink resource show
-.IR DEV
+.RI "[ " DEV " ]"
 
 .ti -8
 .B devlink resource help
@@ -31,11 +31,12 @@ devlink-resource \- devlink device resource configuration
 .BI size " RESOURCE_SIZE"
 
 .SH "DESCRIPTION"
-.SS devlink resource show - display devlink device's resosources
+.SS devlink resource show - display devlink device resources
 
 .PP
 .I "DEV"
 - specifies the devlink device to show.
+If omitted, all devices are listed.
 
 .in +4
 Format is:
@@ -58,6 +59,11 @@ The new resource's size.
 
 .SH "EXAMPLES"
 .PP
+devlink resource show
+.RS 4
+Shows resources for all devlink devices.
+.RE
+.PP
 devlink resource show pci/0000:01:00.0
 .RS 4
 Shows the resources of the specified devlink device.
-- 
2.44.0


