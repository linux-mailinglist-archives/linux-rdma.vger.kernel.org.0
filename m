Return-Path: <linux-rdma+bounces-16135-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2G1DF/3yeWnT1AEAu9opvQ
	(envelope-from <linux-rdma+bounces-16135-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:29:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A01A066C
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5FEB2301E7EB
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28CD34DCF3;
	Wed, 28 Jan 2026 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S7g2qSX8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DC634DCDF;
	Wed, 28 Jan 2026 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599677; cv=fail; b=Lcq6TeKrHsYcnKJL9xUC4z2cVpLnYuJvCEnstWwXOeyv31c4i1bNU/fkA4nAFIaxZV9gbxz6p8fXkI4FMPesJ9BXr3wU96KZsgep9qEtENmV9wXAeFsF+u/7FuIt4pr+npEwjicVhNo5o4h9d247PKFXlksRNiXxXzUkwjocadI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599677; c=relaxed/simple;
	bh=nBtMJd+3hkvSoU6PrNskqfdNZsmPSEsCiJPZwwVf390=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k36K5YWElfkUdd70e8iL/tY01B2Ep3h7TRtLjiDW7ls3DUUeSp6/oRTcRQK+gdXO8k7VLFVW/gXTd3Wi2+nG8TML5PQObzF7tjzZWoEg5LQRxZ5n5k667CKOBh112r+0zpUXULoyJaBRvVMkXmwGSed3GKRys/o7jc0NT7f7n7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S7g2qSX8; arc=fail smtp.client-ip=40.93.194.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bw9ib91gJRevRCAX55iLUz7q788ybM+SCbG9y/eitJ94DcWTO/xQuTu+eD4K0gBqKa9oqiHoxV+hkE5Bsg5iTlHfsRkD9bjiNul2UpurBGbEGYBgjOQfNoNMTGsIjCtIzz8MDP0n+KCv28Xf3hOUWQZFnE6SCW+VXxsm9f7G4UjdOk7XErP1eddKFnaE+Q4IwjB5j/iGVaxmB8YJ5KIUUDfnM5CRI9UixLqza+a61fi8+vRURnE5+wo9YjVP/pbNEzvTAaNa2xveILYPEqOSquLWcMxgokcxQVMOIRa8VVk48X3WslAZwU/5uwXchYM+bWLoRtWJ5+UHuwCoXlyZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwt4JzvHHI1Y/vwTzWObSNYmSbVYxiK4dsVaYneuqtQ=;
 b=v8oDvIOim2PFlTVOFbH63MFvBgdW77ZHeZ66Lt++Z2pU894hUMJKr9jHgouE/otrxfWTWmsWWLbTAgULoL2iAwoj6jmbfqhcvcApFGpzDDKrnGuLWL5glmY0n5LCEHZglM0G6+wJsctnZiO/LqGbHEaqz0zsxftiMOuNzcYaW1WatbFx4aAlz00ceCZpRrgTGrLrHPml775o9iJ/Ogp/RJ4UOO1jIXLpa9OeNVN212/M8tKGW/+rJGdiwElMI6RBKSW28uFHUu/v/MiP2ZzrAxrnmUuAzw/Bpn6+ewFsQ9t2jXu5BtR88hviOeehTxGy7mFyUBENLxD5z10mz9YGCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwt4JzvHHI1Y/vwTzWObSNYmSbVYxiK4dsVaYneuqtQ=;
 b=S7g2qSX8617Kc1Evdk0KpsORAXoyVf/YNhwzK7BgufCES/k6ZUNmRoW+KJ4Q77NdsV8Cei8MzAKoQkZJyViVkvGWZuKuNKzHBh3WjIa8bCub2YPEmljjmOcg3ZkmKQ66GrMdoFpbbhZBVixPuBDqVc3+gfR2VpdDJE3iefXKMSag3esYzqowrHa5lzLxBXiSTptCa4VdoyRfDpRnw6NYYbK5BHisZZM3thCCem6ypguX9WngF1qW+DDRZY7w0ZmyB6WWaM+ygB2YJkDrjUxeTK5sb1fj6j8p/i/OdiiGKmty5lMMUawRmmwjh79Qb+ucfPWtwFy6c9fInZa3RRz3yg==
Received: from PH8PR07CA0020.namprd07.prod.outlook.com (2603:10b6:510:2cd::12)
 by BL3PR12MB6642.namprd12.prod.outlook.com (2603:10b6:208:38e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 11:27:50 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::8f) by PH8PR07CA0020.outlook.office365.com
 (2603:10b6:510:2cd::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 11:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 11:27:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:27:36 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:27:35 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 28
 Jan 2026 03:27:30 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
	<rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, Krzysztof Kozlowski
	<krzk@kernel.org>
Subject: [PATCH net-next V7 02/14] devlink: introduce shared devlink instance for PFs on same chip
Date: Wed, 28 Jan 2026 13:25:32 +0200
Message-ID: <20260128112544.1661250-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260128112544.1661250-1-tariqt@nvidia.com>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|BL3PR12MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cea2ebb-1d7e-40c7-a0bb-08de5e60455d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|30052699003|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yoRYS+/Cq4Dtft5cebFr4va81nG/saR39mE6zS5LJHjDxc3uTUbj4VbAslta?=
 =?us-ascii?Q?7czMLeezHKG7ivZDzVozFQZTl+vUS/fpmH/TuHXrzbkkBG1wyLGpaot94wZr?=
 =?us-ascii?Q?gUaaUpAS0UUkM2c/P/bhu0WNljv8/dganJ1fMtf5gx+rlkpIneMOXFsHPgKj?=
 =?us-ascii?Q?FUzfA/sygb2qky2Uktpsk/x9vTanHce69rxSDDhAF39feA9y3ce1eIY+OQt9?=
 =?us-ascii?Q?ADx4wygEkv0tazEYKZ2HDIpbk60r05lC4BM9c7PEXuNITd2g6J3/D8LFxmRa?=
 =?us-ascii?Q?9zeRWs3ELnPXCDyUUhR82v7YqZYDtCWDOtFRpnYoxwahpZz98xct4uLRADUP?=
 =?us-ascii?Q?8oevFyVqd09WywexDFO80dM+oh4/19UerDTavlgstqG3qmCipK2lNLPnx1kz?=
 =?us-ascii?Q?5GH8FDzuV3mu3JjQiezQNOHCtm3ZhKfqwUy242og/iMFC0jw7MnW0IEhQl7g?=
 =?us-ascii?Q?3uQK/JEdFfYpb9Qo5qp2Xnl/kxQnux0Cpbqb8ntP5DjySewFWWl07lEpMMf+?=
 =?us-ascii?Q?Ew6AONFTE8U+TeKAu1RAy6Yfggc5n9HViGZeJiTGpuFKpdqI7tuYB2EAVq7h?=
 =?us-ascii?Q?hWnZzYFcJjIHUbxXUwZX0LmSPbZf8PjN50lugNesLNqZ6q8vfqEojHwTy+Eg?=
 =?us-ascii?Q?CdGgt9MsC/lDOTRHzYvNWkkUmTDIDoHPTTi4yIsZm21yVapj2Vo+diNRRSUR?=
 =?us-ascii?Q?PHxQ2i6F5IrWiF8GEukqMc2xkJ5zIaLGFqqelUahPDyuX32lzv5vZqx3Gyb3?=
 =?us-ascii?Q?8jqsKPEpH1Ou8Urqbb6o9BMQDv0u9H0Yw/35iqNbKbIrADQImvHDLLjGqsm2?=
 =?us-ascii?Q?GHGM2GO1aisXQU9nEkzHUZ0Picv54uHHuUNn6wYz9ka/koOFMqIheU+Hkify?=
 =?us-ascii?Q?GnYZ9xSQ2hQGXIk8zfukYT2BbORUm4vh8tCFZVSn44934wwmCzXfVaSKuKJR?=
 =?us-ascii?Q?PPxaKLjQ5tF7Wq366DY8fRQErAVon0NlA0YCtHvCDNafl1yR8CgcjsgeJ0b2?=
 =?us-ascii?Q?u6fAeuzJ9TeR4OL3iEmDAO3/47gWQG/oxMoGmG8E43JNEictGOqaj19OcxzL?=
 =?us-ascii?Q?ii/HfSV1U/2IqlBYXz1SF/IMUvKfHDahxAmrK6tDsIXWvTBWbECySF2HAq/d?=
 =?us-ascii?Q?MNuAKwYdo4isnIXwW38HgK+sMJt5Fe24a1qvYGFM+L3BB2wf16UYQJe1aG7T?=
 =?us-ascii?Q?FyrYXHyu7EDpQft2+87c78yBsI6Vq3og6Dux9xZC28eEKrJVcWUNVMf7lFmX?=
 =?us-ascii?Q?Ubpj0Y/pSTpXoJeSZq/0EHei+leR9BElELVW3ub/jdm/TigNeZFusqzWMzSW?=
 =?us-ascii?Q?b0pdSkymm5WptDk8EdYS6GmHu0pW2OEY3O5XmURjYHGo+xeUHN2NmzY2DGOH?=
 =?us-ascii?Q?GipkC3VB99qaB5UlVD8qUrAWlGJ4/a7oslpY7j7unFR7J9Ttyd10S/zBIImF?=
 =?us-ascii?Q?sqsPTBvv46wRcpv/+rDT0T2BSW/z4gZ1OFouHu0dAcqGjYQudNIB87rU4OiA?=
 =?us-ascii?Q?6FFjmTwLqzi8UZaXM8BvMgCeWHOFnre5b85c1Qi6ILMIIIJdmNpbRsr5dE6g?=
 =?us-ascii?Q?3R4W6lJ1y/S3eSXIiB2Jq+YO3i1uQXg91pgAcFqvA1KEkyA83iKbWIP8xrnA?=
 =?us-ascii?Q?VcwEJxauzf/FbW48k+dL6mjFJvXzvGvybH8DNQ7uNGaP2ufz58xdaSZSx1pH?=
 =?us-ascii?Q?qaJhIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(30052699003)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:27:50.5564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cea2ebb-1d7e-40c7-a0bb-08de5e60455d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6642
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16135-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 43A01A066C
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Multiple PFs may reside on the same physical chip, running a single
firmware. Some of the resources and configurations may be shared among
these PFs. Currently, there is no good object to pin the configuration
knobs on.

Introduce a shared devlink instance, instantiated upon probe of the
first PF and removed during remove of the last PF. The shared devlink
instance is backed by a faux device, as there is no PCI device related
to it. The implementation uses reference counting to manage the
lifecycle: each PF that probes calls devlink_shd_get() to get or create
the shared instance, and calls devlink_shd_put() when it removes. The
shared instance is automatically destroyed when the last PF removes.

Example:

$ devlink dev
pci/0000:08:00.0:
  nested_devlink:
    auxiliary/mlx5_core.eth.0
faux/mlx5_core_83013c12b77faa1a30000c82a1045c91:
  nested_devlink:
    pci/0000:08:00.0
    pci/0000:08:00.1
auxiliary/mlx5_core.eth.0
pci/0000:08:00.1:
  nested_devlink:
    auxiliary/mlx5_core.eth.1
auxiliary/mlx5_core.eth.1

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/net/devlink.h |   6 ++
 net/devlink/Makefile  |   2 +-
 net/devlink/sh_dev.c  | 163 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+), 1 deletion(-)
 create mode 100644 net/devlink/sh_dev.c

diff --git a/include/net/devlink.h b/include/net/devlink.h
index cb839e0435a1..c453faec8ebf 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1644,6 +1644,12 @@ void devlink_register(struct devlink *devlink);
 void devlink_unregister(struct devlink *devlink);
 void devlink_free(struct devlink *devlink);
 
+struct devlink *devlink_shd_get(const char *id,
+				const struct devlink_ops *ops,
+				size_t priv_size);
+void devlink_shd_put(struct devlink *devlink);
+void *devlink_shd_get_priv(struct devlink *devlink);
+
 /**
  * struct devlink_port_ops - Port operations
  * @port_split: Callback used to split the port into multiple ones.
diff --git a/net/devlink/Makefile b/net/devlink/Makefile
index 000da622116a..8f2adb5e5836 100644
--- a/net/devlink/Makefile
+++ b/net/devlink/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y := core.o netlink.o netlink_gen.o dev.o port.o sb.o dpipe.o \
-	 resource.o param.o region.o health.o trap.o rate.o linecard.o
+	 resource.o param.o region.o health.o trap.o rate.o linecard.o sh_dev.o
diff --git a/net/devlink/sh_dev.c b/net/devlink/sh_dev.c
new file mode 100644
index 000000000000..acc8d549aaae
--- /dev/null
+++ b/net/devlink/sh_dev.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <linux/device/faux.h>
+#include <net/devlink.h>
+
+#include "devl_internal.h"
+
+static LIST_HEAD(shd_list);
+static DEFINE_MUTEX(shd_mutex); /* Protects shd_list and shd->list */
+
+/* This structure represents a shared devlink instance,
+ * there is one created per identifier (e.g., serial number).
+ */
+struct devlink_shd {
+	struct list_head list; /* Node in shd list */
+	const char *id; /* Identifier string (e.g., serial number) */
+	struct faux_device *faux_dev; /* Related faux device */
+	refcount_t refcount; /* Reference count */
+	char priv[] __aligned(NETDEV_ALIGN); /* Driver private data */
+};
+
+static struct devlink_shd *devlink_shd_lookup(const char *id)
+{
+	struct devlink_shd *shd;
+
+	list_for_each_entry(shd, &shd_list, list) {
+		if (!strcmp(shd->id, id))
+			return shd;
+	}
+
+	return NULL;
+}
+
+static struct devlink_shd *devlink_shd_create(const char *id,
+					      const struct devlink_ops *ops,
+					      size_t priv_size)
+{
+	struct faux_device *faux_dev;
+	struct devlink_shd *shd;
+	struct devlink *devlink;
+
+	/* Create faux device - probe will be called synchronously */
+	faux_dev = faux_device_create(id, NULL, NULL);
+	if (!faux_dev)
+		return NULL;
+
+	devlink = devlink_alloc(ops, sizeof(struct devlink_shd) + priv_size,
+				&faux_dev->dev);
+	if (!devlink)
+		goto err_devlink_alloc;
+	shd = devlink_priv(devlink);
+
+	shd->id = kstrdup(id, GFP_KERNEL);
+	if (!shd->id)
+		goto err_kstrdup_id;
+	shd->faux_dev = faux_dev;
+	refcount_set(&shd->refcount, 1);
+
+	devl_lock(devlink);
+	devl_register(devlink);
+	devl_unlock(devlink);
+
+	list_add_tail(&shd->list, &shd_list);
+
+	return shd;
+
+err_kstrdup_id:
+	devlink_free(devlink);
+
+err_devlink_alloc:
+	faux_device_destroy(faux_dev);
+	return NULL;
+}
+
+static void devlink_shd_destroy(struct devlink_shd *shd)
+{
+	struct devlink *devlink = priv_to_devlink(shd);
+	struct faux_device *faux_dev = shd->faux_dev;
+
+	list_del(&shd->list);
+	devl_lock(devlink);
+	devl_unregister(devlink);
+	devl_unlock(devlink);
+	kfree(shd->id);
+	devlink_free(devlink);
+	faux_device_destroy(faux_dev);
+}
+
+/**
+ * devlink_shd_get - Get or create a shared devlink instance
+ * @id: Identifier string (e.g., serial number) for the shared instance
+ * @ops: Devlink operations structure
+ * @priv_size: Size of private data structure
+ *
+ * Get an existing shared devlink instance identified by @id, or create
+ * a new one if it doesn't exist. The device is automatically added to
+ * the shared instance's device list. Return the devlink instance
+ * with a reference held. The caller must call devlink_shd_put() when done.
+ *
+ * Return: Pointer to the shared devlink instance on success,
+ *         NULL on failure
+ */
+struct devlink *devlink_shd_get(const char *id,
+				const struct devlink_ops *ops,
+				size_t priv_size)
+{
+	struct devlink_shd *shd;
+
+	if (WARN_ON(!id || !ops))
+		return NULL;
+
+	mutex_lock(&shd_mutex);
+
+	shd = devlink_shd_lookup(id);
+	if (!shd)
+		shd = devlink_shd_create(id, ops, priv_size);
+	else
+		refcount_inc(&shd->refcount);
+
+	mutex_unlock(&shd_mutex);
+	return shd ? priv_to_devlink(shd) : NULL;
+}
+EXPORT_SYMBOL_GPL(devlink_shd_get);
+
+/**
+ * devlink_shd_put - Release a reference on a shared devlink instance
+ * @devlink: Shared devlink instance
+ *
+ * Release a reference on a shared devlink instance obtained via
+ * devlink_shd_get().
+ */
+void devlink_shd_put(struct devlink *devlink)
+{
+	struct devlink_shd *shd;
+
+	if (WARN_ON(!devlink))
+		return;
+
+	mutex_lock(&shd_mutex);
+	shd = devlink_priv(devlink);
+	if (refcount_dec_and_test(&shd->refcount))
+		devlink_shd_destroy(shd);
+	mutex_unlock(&shd_mutex);
+}
+EXPORT_SYMBOL_GPL(devlink_shd_put);
+
+/**
+ * devlink_shd_get_priv - Get private data from shared devlink instance
+ * @devlink: Devlink instance
+ *
+ * Returns a pointer to the driver's private data structure within
+ * the shared devlink instance.
+ *
+ * Return: Pointer to private data
+ */
+void *devlink_shd_get_priv(struct devlink *devlink)
+{
+	struct devlink_shd *shd = devlink_priv(devlink);
+
+	return shd->priv;
+}
+EXPORT_SYMBOL_GPL(devlink_shd_get_priv);
-- 
2.44.0


