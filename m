Return-Path: <linux-rdma+bounces-18919-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIkVAyVrzWkkdQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18919-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:59:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A373E37F8F1
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2D9B30D4C06
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 18:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F083E47DD61;
	Wed,  1 Apr 2026 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bevWfGrZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7943847DD53;
	Wed,  1 Apr 2026 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069534; cv=fail; b=WWHf3hZfHD2mcvF8jhZ7bPgxYPOSl8ynTkOQ/XuVvIsyXK6Cj21AM690/gNSA4EDqi2JoI5KVdTyDSbjtAin/ztzU6yMggM84oDhe0fjWdxZhtmpcSNaFrOKLUuV5Cgp+qGZuivndRMR9Gor0fKfiWejXrm+1ucnOJYbUlriFHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069534; c=relaxed/simple;
	bh=NbXsMUvWQMqPAxAGJntF7oc52EiiDoxMJRzBnkoro78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSkp4hxR0ktTWnaC0r2egUofnFQBzCRM+R4VhIljUquautr6N/FlJTAhsyUSJbDkB5Jcwr8uUKlcK0gZ5QkHAHF9HgR8C4Ve5UcqE2hTCmOawpInL3ZrP6Tejuwu9Lsf3wvwjmSQv9AAjlVyS4+RbYBEwREov3it4SLjar2euuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bevWfGrZ; arc=fail smtp.client-ip=52.101.61.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLAQNLExQLrh9wzXmQ/YK5HtC7bCN9Ia7u3jPWSaQBuc0aKd3lqgdndANYjScf95hj8WFX2KCFW5JsZFFIvelDya0KXxqAIIlkNLBi+myipeivnCPggpu6gAm0Uj3XYa/ZBCb42/p3PUEkBny1SSbbKmjttY4u606kB/DKxrBtTlkxwWotvEtcDa8JdjRZTdlefFGfIOnaBaDrrAwSZ/w/xw0MoCAvTNqZjinLIpKzqfP3CazexDWAEVb4Hc3Nj30Wm6CyXuHzV/dS/AZ19bvCrYNP78p2QISCLJp9eRs7QwnjbvZ5kn97oc+LGChshqZkyrD52+Uiuj7x1kDFaEAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBMzI8zfOOVQ1PucAWar0F5NDjlTcnjInWTwF8+xY5w=;
 b=iOL3KrWpN/McSSAxpoud9RTMDbFMoUV9rkD/UfgEM/+8TdrZDvWDW8Z4/POhgWkEp//3TKKmdBV7XzX7otQcQvqaaQ+nV4Rtf63Yb/RPhYouOsb5U0ipHXxYMCMMAZhOfrMWbwPjuRk7TupgzPuO5+HXOhyNF4H5GVT/i85UtED2CfuVcqmi7FoAuzf8fB5OZWPyI9j2sqMD27NRZoe5XuTNRILPVF2e6GJlYxOE0+HsuWWcuyEooQL5zW60Ox7kmBdwIjk7mag310j/5tuLtLze1Zg4UM+xNKn3NiasoDhDwVGTsLUYhPgIhtrNVRFyl6sPm4cQHJ9zpFzxP7h3PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBMzI8zfOOVQ1PucAWar0F5NDjlTcnjInWTwF8+xY5w=;
 b=bevWfGrZO8Nll8Jhl/mIvllK+yzQQia5/CapbI0f0Jx/atDMXRXHvbiwPRHi0Dz3frTl9BhovHcXZHnbYBoyk11XJNlrdxx6gEgS/niGMH/lJpym5tFRWuVh7ebMF1o5+RKLrFSXKn/tcC3E2YnJjuqrmT6hedujorgmAuAXmf8YfWOnAOsj/5Tc3HB6rqN2zjFfbvdzSsRYgK32NAt41TSb61ra5bZ8Kb+NUoqbhk7TwJrfQEXO2tKM0THFoR5x5FzsVf4JaC0pWlE3wKYS9T1NhxBjXbaS7qMwLAu0Gs4TABEH+aopM95y86+ac++PQBoHqVTOTsYaMTznnHSBJA==
Received: from BN0PR03CA0047.namprd03.prod.outlook.com (2603:10b6:408:e7::22)
 by IA1PR12MB6114.namprd12.prod.outlook.com (2603:10b6:208:3ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 18:52:02 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::8) by BN0PR03CA0047.outlook.office365.com
 (2603:10b6:408:e7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.31 via Frontend Transport; Wed,
 1 Apr 2026 18:52:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 18:52:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:51:42 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:51:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Apr
 2026 11:51:33 -0700
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
Subject: [PATCH net-next V4 09/12] devlink: Document port-level resources and full dump
Date: Wed, 1 Apr 2026 21:49:44 +0300
Message-ID: <20260401184947.135205-10-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|IA1PR12MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b5e27e-d5e9-4329-2b3d-08de901fc305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fUmP65wvlMJpWhYvfoYWlPy5cTVE6TjIU4YOWN5r24CHB40XEkBzMAJxX34NXDh/8i6fX5HUwh287fXBtpilN/MIda1VoBPAYqGp5mwTvY3aM+AcQCfDqsBMVoHJxyl/Rhy0YK0aqAz0AeFJRXHw+vhFQ9AuFxtNzpKvsY3zT8HaYhE5+5HjAKoH41icb2ywzh6tYNzbQ62wxRqcx9qj5Vug+e9P6Duj3p+9COTC1J+xe31B5dvToFC1El49eFs7fHPW+QsRJE6F1JqDPhRpytjqZ2Fe03ESk4/oUyQ+Vs6e+aGCgql/oS5tEEHJTDh2L9eEre4RGpMGp9kwzLUVWKRFscpAFNe6xYDlanSPjDPFN6YcaXHs1dStZ4ZPd1jmu5w2T46jwaVDt+ectpMeV9tHU0VTYADgbPMCu/J+5ZnEV1k3SDu1RqCN7g6vdvYzi4wsZFNrBxDATyHKbYQALJzhjnS2rvqFFf9JHdCqgK1VfKgfX7KCkezkZ+SBI2J9h+qRhuQhb9F37tlINsMozv86cHeTSicvFrD960OoNBeZn4lashIwSUKJsKLBEpOpUnX2wmfyx9DmJBXGXCa/puluc4+iN3mq8NvFWVO5Vrg+KT/1c6j1ZL0k8J2wq5LKwqFJ2LfapWUXBjOzHhVMPDGMyuQDL7Kal5prlQIuczlBuNL0heHVuDzYJZYw0GppKm5dh2vDGPSyCrRCVb9hnV+dik1P9Sol6+thWCyeYT0j1eqLRDjn8syqy6d6oe/IDcbg/cYY9n7H2vfdygKT1A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PFSVoBOXndClTc/M0N1DL/MpL+/6oWdKo0zF4mSZSBLl/sm36oacFJuaduPiX886fLum84EuySGxZ6aoQvMpPT0fzwIlR58l20s4LT16/HNx2oHiCrpQsVkpQzFqwokf8wtsfI7TbTScIahb9MG/3qsKyzUZMfs0pu2K9WrXbjfCKVw22DQnBOAnZTH50WDT/rPyLcJRWvMxCMzLQngwZolyHVS8FktsOh4S+K8w71zsZiBg1DyYKyYC83jjM/7ObSEl0D+VnznbZRsuOYf7iDcH90cLITP6PV3J+tuJ5s8kqbyYaLokwYbNnjfUQxYIKyBbzBS57zn05qoHrPTqn+RC5BMAwlBRfVJOgYh3bD7iiToBpKzMhpBMugQOaPUbVzJMGRQQNEHvyEU/1be/3XxUn3tPpE+TpIypQEOigmageoOxEfLv+9ruHvbKbebm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 18:52:02.1666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b5e27e-d5e9-4329-2b3d-08de901fc305
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6114
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
	TAGGED_FROM(0.00)[bounces-18919-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: A373E37F8F1
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


