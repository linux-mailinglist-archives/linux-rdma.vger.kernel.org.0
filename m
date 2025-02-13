Return-Path: <linux-rdma+bounces-7740-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 090CDA34CCC
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 19:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549983ABCD7
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 18:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24141245010;
	Thu, 13 Feb 2025 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dacPDwOj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADC5241684;
	Thu, 13 Feb 2025 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469763; cv=fail; b=ai0uMMtSijbLeDbQb55yWskyPcWdDICATToZ+mGuTZ3rXlazhOQoEzDDIaiWSONEZAq7wb/MfimdNzp2P89OVAe51WWxj2hDxdCPLUw4VBG5eKs06S5mX9/BkDqBqJr+GXZq2E4KW44ZTrVTpAOCdH8pcmyrLlI7MEDjRsjtYrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469763; c=relaxed/simple;
	bh=BhXKViZjV1QEveffxJ15Y4m0qwb2bPydm+kFF63W6cs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ch2lcm17p0Xg3usJVrRvcUU18NsU6qC9Lrk1bdX4JFWDUozpF/y9U5i+ll6WJqM3o9kNWZH3S6dfYAPyGGY/esJ88nTRbO6AgJ2o2SWm6MVfCy3bjJACSXsCoobPjMLyKtrFoEilKbwlAzRbsTBmLRDowPwAYUAJdhagQFcHBD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dacPDwOj; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FG5eXgpzh2mgQ48IZQbNa/Yn9ajsU51JHeSRVe1oHfRcSNXfEdEoG/WmBgsmCbJvDtTsysg46SkQ5B7CqT0mzuSVXQ2cSjBM3dyUFDGJ5evy9WLyre7K0vFDEed/K0GLo6vGIs1/75LgZWJFEk7DVkWah0sqJvD4CYFSEkC3J08VMUWxOQeFKsvmogMt8okuUCb3vJ1SG0t8yldrTl7o9XKPYoMj0m9dSI6M5SIHFgS9Mk+LgdpPiUTilra/5FwAWxwZudaK8FiiRPMXX2s7FtxNHwi+hiSEYF17TkEviYHG5g7ezs8ar6E4imtAq6R3rcrdfE3Gu5tolJZCxk904w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N86pFw1iIKZgiPehQHP+xkQoVVfDaS8pBROT62bULdU=;
 b=Od/HKjTL3GfK6I2xKIxj78N567IajWoJCla5nOeAQVoB+NZiUf7CzfU+D7mwGjJ7GZuPKrFfpMNbqIjvtwLhMHuvyVSxoGSHeaVWxdymZP3wN0hKlYYebFHYlWgZycct8Xj1bMHI4fscACk+o8Oxybq2qHHOJ3ZzBFaMH0HJDKvxAIqn1OP9elIjOmeyypnZde6vHFRwjkG56WkdNoWLWzbXjZodr6RZehx75dU9abubs1CrwBrDo7lyoZnk0uvSbLRHX4t2d9Y8Ot01cELI+iKGfqohr0/8ed5MnZGKXIutbQc4jVxnWcOfpqX/izlxQ+ifD1j0RJiRzSeb9wcn0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N86pFw1iIKZgiPehQHP+xkQoVVfDaS8pBROT62bULdU=;
 b=dacPDwOjMPQ803QrygT4lCOd4JfTiD7Xs6Oviiq1aswLlzPoWBpIXNfIXo2nCSqp0NH+gikup/4/wnHQ9MO6+JpWoTVJvKokviL+VDs1/IJQY1jUkpRkqwEQPVN3hEb9HZ9zuVUK25QfSIUrshPdJ2dtAgf/556BzBkrRRlBKiOD2bENu08dRIk2AxO/Gxkh++7xrjNlMdg9BpvajDi7uA4qmb+0AgB1/rW1K8w0goacNsmcXfhcA2NmGeJQYvOPAoIEabfG0pC3/9cF7LQuYpQkG72IEErUvMwAP9UC1jFlwMD2qPA7fLWCBpuK8oobbpklRIq9+fcwkio2e6Ecuw==
Received: from BYAPR01CA0062.prod.exchangelabs.com (2603:10b6:a03:94::39) by
 PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 18:02:38 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:94:cafe::5a) by BYAPR01CA0062.outlook.office365.com
 (2603:10b6:a03:94::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Thu,
 13 Feb 2025 18:02:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 18:02:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 10:02:12 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 10:02:12 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 13
 Feb 2025 10:02:07 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Jiri Pirko <jiri@nvidia.com>
CC: Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Donald Hunter
	<donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
	<corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [PATCH net-next 01/10] devlink: Remove unused param of devlink_rate_nodes_check
Date: Thu, 13 Feb 2025 20:01:25 +0200
Message-ID: <20250213180134.323929-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250213180134.323929-1-tariqt@nvidia.com>
References: <20250213180134.323929-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: dd92e055-4519-47d5-4efc-08dd4c58999e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n9M1C7NpaiSOsaiDJAtXUoGTVCkK9klGUPMtKY325btiwbnb1jettFFRz1yg?=
 =?us-ascii?Q?QM24AfypukThzP/BgDtEO22dlnIzcHbt+ulFnI7euMjvy/cWdT5KA0fqwXto?=
 =?us-ascii?Q?GzUqb0AU+ZkIOFNR8lsx+gndWPDve1/FZrdSP63TMMDgcoC8WZpclDT/mMn5?=
 =?us-ascii?Q?+a0evaIea6hmWC9N7QOVbf24y+Oy7OtjxuTmBbHG8cczGHD1gkRfGFNLPteh?=
 =?us-ascii?Q?I5tcjUO3X3KMeegZVl3OdJgw/N63ogVyXq8oXUolCIsZZqc5ZLGGhocWslFp?=
 =?us-ascii?Q?Whr/8iFecvm5SUV8i4JxeWwW1oYxMcQmxKg9cFkaHrXodO0l/Nu7pxH3AHto?=
 =?us-ascii?Q?yjtk1/K7ETKp/5cifx/SwuMmaVsXnZFk+lrnefw9jrowINqc4eq50aMgNufk?=
 =?us-ascii?Q?X4Fu6Kf73cz+8CQh3n6vkOp0QJLANEZ420Xo/fLZ5hAFYKIz+uqGle+zioGb?=
 =?us-ascii?Q?5/qm0QFgCB5X9hA/IxfHjlgS8DG8XGhuafe7V98lo5U/Rw1XqAPJ3W37JmOn?=
 =?us-ascii?Q?5bZb+zMeLRROWNggUkbipTTJ6AcP3mTtGCafPP3CDY/AX2fYSMbCLeQ837Qs?=
 =?us-ascii?Q?PjDh7pnQTd+tWO/ZbinYkP7N9WYKoGTTWpRxNvBmVlAG/u/Ine4eJ+GLYCgB?=
 =?us-ascii?Q?N30VWK0tat0YUE4Vk+ri+ISfemCwbg0NoX0s4x1dAsL3seDlgXLlmifGeKTD?=
 =?us-ascii?Q?F3KM5RpvN6cStMdq5dNphplNbTj09kiNNgJdhzG5jqHjSQOw2fF8zfH4h29q?=
 =?us-ascii?Q?OI4KmEeScgPlKtNv7m0iPbiebt5Zr97yrCamh57TNWViYqrserzH8ozLlGiX?=
 =?us-ascii?Q?D63ZwKaf4PyFSKRKdCQPtgKavz3UPlVUZOpHILbOY9YJpo/41W5noR+8NHWT?=
 =?us-ascii?Q?9E3gyrgAVjIsnTSI+avhCVYBqEGuWpHF3f9jxrw/PpZor0PPthlK1SGNUX8J?=
 =?us-ascii?Q?tHAvTjzAC/uFGNG2AooaaZl8xapwm4yvmHYVmlPT7x1BFpWUZ6/elP/0K/up?=
 =?us-ascii?Q?c7yTnaldz5vhm2eHS8Qc0eLs3B+qtx7wl9K/WiV3Af9+dlEp6b3BMjZHs9e1?=
 =?us-ascii?Q?NekWFE5QwSYpn/7OUKaxS4hZMWDeSWdOyVEJdpQUm3YkfJEsBAyhAc2G4xp4?=
 =?us-ascii?Q?BmCXjpZ1tcfpb+bYosAeY2dGnOk43bWojWATPoob5qIk548JkFwQ/zi6Fek9?=
 =?us-ascii?Q?AADYbl3ZMJIiHcI7KGcyuVQoMxa8JRnnfYarv3WxuGtHyp+s1k4cBV4IyGGJ?=
 =?us-ascii?Q?XSeBU4sU2IMc6m0wWoK3DmP+O+E7bm6ahpVT7H21nF/zgaZwiQXhUrr7TZr8?=
 =?us-ascii?Q?RP5tR4f7D9U759gcUfn56qebEjn4GZ2qUR6GtemLUfET8N5M2s4aG4sNcyk+?=
 =?us-ascii?Q?pW2wRC0Vh9LF43dxSaSUQI4HgxlcyZpf0pYcHHhrTPLpdmonLdvhKbokE1TN?=
 =?us-ascii?Q?9460QnCgE0kkRcu2N5siLijm3mI56cjdckwixBoWlhSZ95l0sG3kpT3gz5/r?=
 =?us-ascii?Q?xqZ6UrKjaLqZkgg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:02:37.3037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd92e055-4519-47d5-4efc-08dd4c58999e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699

From: Cosmin Ratiu <cratiu@nvidia.com>

The 'mode' param is unused so remove it.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/dev.c           | 4 ++--
 net/devlink/devl_internal.h | 3 +--
 net/devlink/rate.c          | 3 +--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index d6e3db300acb..5ff5d9055a8d 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -713,10 +713,10 @@ int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[DEVLINK_ATTR_ESWITCH_MODE]) {
 		if (!ops->eswitch_mode_set)
 			return -EOPNOTSUPP;
-		mode = nla_get_u16(info->attrs[DEVLINK_ATTR_ESWITCH_MODE]);
-		err = devlink_rate_nodes_check(devlink, mode, info->extack);
+		err = devlink_rate_nodes_check(devlink, info->extack);
 		if (err)
 			return err;
+		mode = nla_get_u16(info->attrs[DEVLINK_ATTR_ESWITCH_MODE]);
 		err = ops->eswitch_mode_set(devlink, mode, info->extack);
 		if (err)
 			return err;
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 14eaad9cfe35..9cc7a5f4a19f 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -297,8 +297,7 @@ int devlink_resources_validate(struct devlink *devlink,
 			       struct genl_info *info);
 
 /* Rates */
-int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
-			     struct netlink_ext_ack *extack);
+int devlink_rate_nodes_check(struct devlink *devlink, struct netlink_ext_ack *extack);
 
 /* Linecards */
 unsigned int devlink_linecard_index(struct devlink_linecard *linecard);
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 8828ffaf6cbc..d163c61cdd98 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -561,8 +561,7 @@ int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
-			     struct netlink_ext_ack *extack)
+int devlink_rate_nodes_check(struct devlink *devlink, struct netlink_ext_ack *extack)
 {
 	struct devlink_rate *devlink_rate;
 
-- 
2.45.0


