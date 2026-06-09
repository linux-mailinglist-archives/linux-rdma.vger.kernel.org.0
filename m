Return-Path: <linux-rdma+bounces-22006-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +djgJeenJ2oC0QIAu9opvQ
	(envelope-from <linux-rdma+bounces-22006-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 07:43:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA1965C849
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 07:43:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=fVa8n3CP;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22006-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22006-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 342BF304736C
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 05:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E333C942B;
	Tue,  9 Jun 2026 05:42:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA723C8184;
	Tue,  9 Jun 2026 05:42:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780983724; cv=fail; b=YBfNyaq55AUck+wQCC/tsPOflEINXSVI6phDpyQk435rCY2mhnpq7e6jcmGQzucSYhW/eIfAWHSglhjnZzSzVb4fy2Nxvou0jyRhCdkwplKbglcOBM1zQyH3lX3P3Ho1HVgv5vO+0d3ocml4jufgG2/B2qxcA8lj3iK1UEUZn8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780983724; c=relaxed/simple;
	bh=Y3kSWQyE4TmNGK61C66j1y7whRbKhc0oD4Kz03gGZF8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4XsV+SpJRAvjRGWhVJpQ3EAZ+T8+x46JLCwesD8Tezcz9D6c8UVIdQw/k01p7Et7EQlHfhURq08O+UbX7W1kgw5m1pdxHmAV2N0e/8u1ujLbExO3SdP6JtNrpwJxrtFnGUsh2ykLr6/5auosgKCVZba0FSKCLPdCvJL7nVeh0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fVa8n3CP; arc=fail smtp.client-ip=52.101.46.36
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRJeSPEjrDWbTfvnU+H7zP5S4zmfJ8Ic8WLdggwblIMfQg02IYMLqPQ+EizFkcpi8AnF0VwCZIUMm+n/fFxbIXuIpfcXx3W+qh2qaSOCUy3OFacJZr/fYW5v8VgVPDT6HaoioGiXvhb9/DPnu4qxl3K+s6qXWfFKQDdqr0Wv4QVliseH6Jx/rHw+tXBC3Vz8ItLnq9xliDuB1u/62URP55X76oZs/aiB4UgXY1UJuXimoYze9I1M+gatmzVde2woN1DxwnOicoem87dg/Jdr91dVeA+41c6neAm/2qH8e4PWfGTbY4FVIMFLGWRJTSGYODlRa9IJjDu3cjQOvVJTTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfiUIyiM7VDntiIZ9wmFYH+MRaBrr0QUYHj3WFrS/ZQ=;
 b=WWm+gI81itwDKFrOlJMxAm8/Jz5OLt2/xlRbTzLzMw09STWgtqJRBUs+rc+u4C+34++/6LuJkZKaESNdb4z6B+/1cCiyXxc1IRqbkv2x3HQ/rv7iSjFVDCEG2nGY2dgoWKuxRbwg5N2/0/EwmcVQxyxbSlHNSJJxnbq3w2DF42cJZyF1BSv3rFqHIcjP3HLm+/W3k8wm9EEMGWbQyjHIwLMmmtk0UaFHVmmPJfYUW2rzwTPDgogt5Ppu7SMmR32W6gUPue8zG2JdDQXTrXJhlIpp/E4lPGOSa0TOgYXUMU3V9R6QWuoWNZM+upkergCTSoX64uIIXlxwvnzcn6qlww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfiUIyiM7VDntiIZ9wmFYH+MRaBrr0QUYHj3WFrS/ZQ=;
 b=fVa8n3CPvu47tIY6xScj5FW1EjSO1F11ueLl7zXFjUFP1kTIPFwwdIwoA8+d5SlQmtYIBIyuRnFfteN17VrtU6BC7wk516KswjTuVScR+ja0yeKTkusdmGcIoaKc6O7XygNeAM++7UPASXjE9I9wDL6V+63ljRvtZoU9CxujgMzYSAvuJpJuMsGcXKTSiJ6cpl5Xikr9GyJMIpmdHAoFD+UVgAeWVoyz1qjOssi7FymyGcoJ6msLYheNygd+rX7JcjyprjzwReiPMEaUELTB1Sv/7XFOCUDuMa1txMgacn/EbT4fg/OiScpzujMBMpfXLlLPTgjIjw6lppTsk8az2A==
Received: from CY5P221CA0072.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::41) by
 DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.13; Tue, 9 Jun 2026 05:41:55 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::87) by CY5P221CA0072.outlook.office365.com
 (2603:10b6:930:4::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Tue, 9
 Jun 2026 05:41:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 05:41:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 22:41:38 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Jun 2026 22:41:38 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Jun 2026 22:41:29 -0700
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
Subject: [PATCH iproute2-next 7/7] devlink: add scope filter to resource show
Date: Tue, 9 Jun 2026 08:39:53 +0300
Message-ID: <20260609053953.487152-8-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|DM4PR12MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: aecefc86-c1f3-494f-2618-08dec5e9d09e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Dzsd57fFZX4TamgCqeKENz8nWJmq3dkuVaJL5bIIXDZgHVzlC3CbargQDBk7hlFw9vY5EoSEUjXcawjhS3G3vq49VdfDcTKc+3OTmqCiknkmUoZotT/+RlPRzM8wbAgQ+NwdAp5+EHmbNvcVrlxMSSdt5d3vMgNybkxvfCQP2+RZ9TlIvZD16+uByTLFa7hxx1nxKTlo2tWIGgY+P+Zr/+i7SaQw77Fn12wVLu/oF2vZfR8giLVD4H3sC+NDJo0KDQFv9AKRxpAb4L857DvE8aY/4Wu69IzVoG3A5kPqGbF0yngp8tyJCSoTLEp/482aZFWJVWI6dAmczBAxQSO+kADNwaSRJBM5LhRAnmQy5V1m19iCF24BGYWiCT157GDMsJ66PlT6k93GomHEkogS4BzQy3ax9Y6d8tnp1GQO2WDUy+H5Z4D+o0q/26isbot6o00JW3vbWKeH65SrAYdoHtugEcfjq3zXOmmMOA10b0JbR4J7v0zfVIZX+l3IemmJnAws5qY2QVUGBQQmdYLftmsYrmGY8jUZ6Ssp9dyt9qjK5hBWSf+vKf8pdYr+S5Bbb+H5Znb/5iURg1QKizGDB/feuXZ/U5Yal2W7MRteKTM8hPHFroGXlHzl4b9UZ6EiCvJSQBh2rrdA556FgWOP3Af8mqDYYzBIvNf0SeIZfFcts/gfWkIMRQlEVcv/7kPIyPdH8YeLlNa5DCnlzugCQZm83xYS+9H9/xUNPCthJnw=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ohHsTZOK9BNMZkH0k9yIu9NblBD6M5td9agnDo1OHQ9pvgiFncGWLqDxHwYFWc57guwDgJfBCY63WkQp4jn5xaSN8kLqO5XItyYdNBJodJbgRCKqkZd0fdmwmpiC4dTlyea6dpjOan4K4Uh647Doicflfi4sQczkxXL/XWlD71NJJufjAVyLMtyuBm/ctKT2fv7xZyGRh4HU0g1LLovn1fYfrnaNo/I5fRUW/7pd14icgmja4AS7yMxw0l91JfKbr6i/scMNyToC7wMZZU35sOpah+Ojd49IERtzOXJEbOr2coJuk4HZoXxYYT3mtDvFRLfaGG1zlLE5eW2t5cfqcbcBduBaNUWxlTQIdJTdBqEtoeaynYNr6Zrb+OV/XHesVvE9OLa9EIailNiZ8fcLhln39vxtSkJf67lFzDgYMYTzLdmi7s+niiZMhxNmLQV0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 05:41:54.9939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aecefc86-c1f3-494f-2618-08dec5e9d09e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470
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
	TAGGED_FROM(0.00)[bounces-22006-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 3EA1965C849

From: Or Har-Toov <ohartoov@nvidia.com>

Add optional 'scope { dev | port }' argument to 'devlink resource show'
without a device handle to filter the full dump to device-level or
port-level resources only.

Example - dump only device-level resources:

  $ devlink resource show scope dev
  pci/0000:03:00.0:
    name max_local_SFs size 128 unit entry dpipe_tables none
    name max_external_SFs size 128 unit entry dpipe_tables none
  pci/0000:03:00.1:
    name max_local_SFs size 128 unit entry dpipe_tables none
    name max_external_SFs size 128 unit entry dpipe_tables none

Example - dump only port-level resources:

  $ devlink resource show scope port
  pci/0000:03:00.0/196608:
    name max_SFs size 128 unit entry dpipe_tables none
  pci/0000:03:00.0/196609:
    name max_SFs size 128 unit entry dpipe_tables none
  pci/0000:03:00.1/196708:
    name max_SFs size 128 unit entry dpipe_tables none
  pci/0000:03:00.1/196709:
    name max_SFs size 128 unit entry dpipe_tables none

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 bash-completion/devlink     |  7 ++++++
 devlink/devlink.c           | 47 ++++++++++++++++++++++++++++++++-----
 man/man8/devlink-resource.8 | 11 ++++++++-
 3 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/bash-completion/devlink b/bash-completion/devlink
index 3d8452a8869e..bfc0083f647b 100644
--- a/bash-completion/devlink
+++ b/bash-completion/devlink
@@ -702,9 +702,16 @@ _devlink_resource()
 {
     case $command in
         show)
+            case $prev in
+                scope)
+                    COMPREPLY=( $( compgen -W "dev port" -- "$cur" ) )
+                    return
+                    ;;
+            esac
             if [[ $cword -eq 3 ]]; then
                 _devlink_direct_complete "dev"
                 _devlink_direct_complete "port"
+                COMPREPLY+=( $( compgen -W "scope" -- "$cur" ) )
             fi
             return
             ;;
diff --git a/devlink/devlink.c b/devlink/devlink.c
index 4224b7fa6792..1a94b6413048 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -314,6 +314,7 @@ static int ifname_map_update(struct ifname_map *ifname_map, const char *ifname)
 #define DL_OPT_PORT_FN_RATE_TC_BWS	BIT(59)
 #define DL_OPT_HEALTH_REPORTER_BURST_PERIOD	BIT(60)
 #define DL_OPT_PARAM_SET_DEFAULT	BIT(61)
+#define DL_OPT_RESOURCE_SCOPE		BIT(62)
 
 struct dl_opts {
 	uint64_t present; /* flags of present items */
@@ -382,6 +383,7 @@ struct dl_opts {
 	bool selftests_opt[DEVLINK_ATTR_SELFTEST_ID_MAX + 1];
 	struct nla_bitfield32 port_fn_caps;
 	uint32_t port_fn_max_io_eqs;
+	uint32_t resource_scope_mask;
 };
 
 struct dl {
@@ -1467,6 +1469,19 @@ static int flash_overwrite_section_get(const char *sectionstr, uint32_t *mask)
 	return 0;
 }
 
+static int resource_scope_get(const char *scopestr, uint32_t *scope)
+{
+	if (strcmp(scopestr, "dev") == 0) {
+		*scope = DEVLINK_RESOURCE_SCOPE_DEV;
+	} else if (strcmp(scopestr, "port") == 0) {
+		*scope = DEVLINK_RESOURCE_SCOPE_PORT;
+	} else {
+		pr_err("Unknown resource scope \"%s\"\n", scopestr);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int param_cmode_get(const char *cmodestr,
 			   enum devlink_param_cmode *cmode)
 {
@@ -1647,6 +1662,7 @@ static const struct dl_args_metadata dl_args_required[] = {
 	{DL_OPT_ESWITCH_ENCAP_MODE,   "E-Switch encapsulation option expected."},
 	{DL_OPT_RESOURCE_PATH,	      "Resource path expected."},
 	{DL_OPT_RESOURCE_SIZE,	      "Resource size expected."},
+	{DL_OPT_RESOURCE_SCOPE,	      "Resource scope expected."},
 	{DL_OPT_PARAM_NAME,	      "Parameter name expected."},
 	{DL_OPT_PARAM_VALUE,	      "Value to set expected."},
 	{DL_OPT_PARAM_CMODE,	      "Configuration mode expected."},
@@ -2662,6 +2678,9 @@ static void dl_opts_put(struct nlmsghdr *nlh, struct dl *dl)
 	if (opts->present & DL_OPT_RESOURCE_SIZE)
 		mnl_attr_put_u64(nlh, DEVLINK_ATTR_RESOURCE_SIZE,
 				 opts->resource_size);
+	if (opts->present & DL_OPT_RESOURCE_SCOPE)
+		mnl_attr_put_u32(nlh, DEVLINK_ATTR_RESOURCE_SCOPE_MASK,
+				 opts->resource_scope_mask);
 	if (opts->present & DL_OPT_PARAM_NAME)
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_PARAM_NAME,
 				  opts->param_name);
@@ -9010,13 +9029,29 @@ static int cmd_resource_show(struct dl *dl)
 	uint16_t flags = NLM_F_REQUEST | NLM_F_ACK;
 	struct nlmsghdr *nlh;
 	struct resource_ctx resource_ctx = {};
+	struct dl_opts *opts = &dl->opts;
 	int err;
 
-	err = dl_argv_parse_with_selector(dl, &flags, DEVLINK_CMD_RESOURCE_DUMP,
-					  DL_OPT_HANDLE | DL_OPT_HANDLEP,
-					  0, 0, 0);
-	if (err)
-		return err;
+	if (dl_argv_match(dl, "scope")) {
+		const char *scopestr;
+
+		dl_arg_inc(dl);
+		err = dl_argv_str(dl, &scopestr);
+		if (err)
+			return err;
+		err = resource_scope_get(scopestr, &opts->resource_scope_mask);
+		if (err)
+			return err;
+		opts->present |= DL_OPT_RESOURCE_SCOPE;
+		flags |= NLM_F_DUMP;
+	} else {
+		err = dl_argv_parse_with_selector(dl, &flags,
+						  DEVLINK_CMD_RESOURCE_DUMP,
+						  DL_OPT_HANDLE | DL_OPT_HANDLEP,
+						  0, 0, 0);
+		if (err)
+			return err;
+	}
 
 	err = resource_ctx_init(&resource_ctx, dl);
 	if (err)
@@ -9036,7 +9071,7 @@ static int cmd_resource_show(struct dl *dl)
 
 static void cmd_resource_help(void)
 {
-	pr_err("Usage: devlink resource show [ DEV[/PORT_INDEX] ]\n"
+	pr_err("Usage: devlink resource show [ DEV[/PORT_INDEX] | scope { dev | port } ]\n"
 	       "       devlink resource set DEV path PATH size SIZE\n");
 }
 
diff --git a/man/man8/devlink-resource.8 b/man/man8/devlink-resource.8
index 1e7d96126ce5..04cde2bf8958 100644
--- a/man/man8/devlink-resource.8
+++ b/man/man8/devlink-resource.8
@@ -19,7 +19,7 @@ devlink-resource \- devlink device resource configuration
 
 .ti -8
 .B devlink resource show
-.RI "[ " DEV "[/" PORT_INDEX "] ]"
+.RI "[ " DEV "[/" PORT_INDEX "] | " scope " { " dev " | " port " } ]"
 
 .ti -8
 .B devlink resource help
@@ -53,6 +53,15 @@ Format is:
 .in +2
 BUS_NAME/BUS_ADDRESS/PORT_INDEX
 
+.TP
+.BI scope " { dev | port }"
+Filter resources by scope.
+.B dev
+shows only device-level resources.
+.B port
+shows only port-level resources.
+When omitted, resources of both scopes are shown.
+
 .SS devlink resource set - sets resource size of specific resource
 
 .PP
-- 
2.44.0


