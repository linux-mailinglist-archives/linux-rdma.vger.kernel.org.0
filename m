Return-Path: <linux-rdma+bounces-20287-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAU/EjAZAGo3DAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20287-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 07:35:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A46A5502A80
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 07:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A58593017243
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 05:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ECC34F24A;
	Sun, 10 May 2026 05:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RXwa7q46"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A801A6801;
	Sun, 10 May 2026 05:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778391335; cv=fail; b=C+NHqs6Ac2d2br+SH143VTWHPvvx7DF/qQRoK5ZibhHEe4hM2AQg2eT+vKHiGugAQmI7hejo0cj9kRSBjW9Mfv5fXMFa3K32Z6tXw8ASo8qnF4v0K4WLTVEdC28VisRA9RmfsMc3sNPSzVQZ8fAHUaXJtnOyNJSz1Yx7SwabgHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778391335; c=relaxed/simple;
	bh=JQl3vazfO6IFmLXp1dXj6IhFKoxH3tCkbza1NyTlhAI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GTdHWjc8JrW3tf3MW7Tv5nhTrhipAK+7Ku/BMD6OLvq4yt2rsEeM1MwC9GfgvbU+Ulbqqiz1uMU5jyxmGQ6xMVDSTo17bMUTrzmMALF0QnN627Sep399ZB0LAEytWG2gwIt6Y39rlBGkf707GykC5WxV71H6q83zNswyJih7UGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RXwa7q46; arc=fail smtp.client-ip=52.101.53.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZ3AN3g7wW9yEE3i/IuMm+ObppNMwCrCU0Mdo9sKY1ZfREhEKOW9dWIajH3vrV2AwOo4pJr31vAOkrjRQTl7AOO5GwQwmcCvlxEx8MIpcblZYlhif8tEEbhdyixK03vPDoLQ4l4kJOfdsgsVpG1J+Jvnss+YLr3hnLxK9hhT0PZmnJdEHbhfRcxfi4VNApczXSpa6vblXMCjOwOWfOwNsFb/ronFOv7hlnIyL/rfn0Oz5JJh7a5Qq3nYqYJqY8yOTK9TGTdeLtR9YdBvfrtKmXpW9JToe88FoHylfMbV5LNE1bwcG0RVuhof+YyCCsFWzvoAVsIFAIw5GDof5Tv31g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAztO7hrIRDBMnd58QYkSNBgUsKykbO74VYFkAr2m3Q=;
 b=HPB6G3ZcKE8dO4WsCaiac00xvWrwDg2a6cHfYvJxpyGia0klg2Eo2sjllWsfzok4OhQRSRbTXAGBjZWGqr6cU14MU4U8pUbanKLj5j9zvzLJawJp1xuRp7X4WPrZXTjEucRd1z1vliOTVsKa7fWKWTu/00aHBsaTcJ+gscc1J5i4sDYvYlIVFCmwHU2PedYxQKM8yO8slnGXZi++n3dEGakVN/EW0ie3FyDRhhSQi6oIgUfye1kPLZf093IlKIQvZImegSdYbHedkDOYhOnRSVi+xs4okVQZnYLrPAetxrVz1oR1T2JVcrSbh+ytJDDKv17hT3TZIaRcA2uDYX7LYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAztO7hrIRDBMnd58QYkSNBgUsKykbO74VYFkAr2m3Q=;
 b=RXwa7q46KeqqWOBFkbcAGHrPd60XUmCErulKs1OLQIQpPrZZhy2C0QlZ+IZNVL9qdRvOd+p6QHt9Sfyg05OWOwQa74LkbyPjA/A/lUfmw3yt7glFEEYw/nhoiYefUmFKtph3iTEvRosDAGsW+SstVfn05aK5osOkhI4C4//eFWr0tKcLMxDLua1JnKfN7FyZDe6C1I0a4MZoCliqAp/BrP5eDq9Uy6oX6CT4dUtUlFrz4U9GDqYGTjTE2RzvCJWICGrts0JUN2FuuwqgNBPxJDOhCaS+HZF7QOktkeFabGdezST4gX9mIrrkBdk3gwx6VVgWe2kHgCgQapZAXqg8Wg==
Received: from SJ0PR03CA0152.namprd03.prod.outlook.com (2603:10b6:a03:338::7)
 by CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sun, 10 May
 2026 05:35:29 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::dd) by SJ0PR03CA0152.outlook.office365.com
 (2603:10b6:a03:338::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Sun,
 10 May 2026 05:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sun, 10 May 2026 05:35:29 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 9 May
 2026 22:35:13 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 9 May
 2026 22:35:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 9 May
 2026 22:35:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 0/8] net/mlx5: Prepare eswitch infrastructure for satellite PF support
Date: Sun, 10 May 2026 08:34:40 +0300
Message-ID: <20260510053448.326823-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|CY1PR12MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b70ea1-a69d-4e48-fa6d-08deae55f25a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	iQ4wmEx8ieWpJtrPMNqNUiu6s9/7/cDVjIZLOIQxzVAHl80rLZZ8JO2bUjUjNJKiSpxAx3j4Zle+Vd2bgFuRiirovhULXXI88VQJUi/eMQqtKT9lLjjs2ghlScz1wwJOunOj0/7i6lCFZMa1hyTzfP13x0Wyc7wF2aH4gTc54x7BtqaqP00/AV7Vld7Deh/Cl8v1+8mrgRK8yeTfQiEqfjGUlsnoisJ23cu1uoyqT2IheIyjtvXZB9i2SSktKc3k38X8KAilc5LqISRMMFCRsj4tztxF5AXfnhyNZxUEW3bFbNl6eKoCRUoRlm2W56Nny65uyOao9CJnFATqNClJaAsr6bvsFDS6Io368Y2mBDvgcD7akxJPv2JSVN57RFbiHviyZU99U22k9bzBKqUVabH4ZIUc9+b3MrfCKQTDhnnUtL0PN1Kg/gdTgN0SwrNtCa5mIdsseiLg07LlwFJ9xr3pV/OL5POAnaslMln3CIWPM2FY7MqR/hiqEdKrWfR8TA2vgF3qhrtB6X4gkOoFYdG+TEMtQDcSnl8lQ7c6E+1RzOl/sBHBxodz0sh52VwU4RJq/JyNpd3jkADQ7q1yfm+7NP+jiP7p92XKU9wZ6259ztMU0so7Vr5+WuEQImIdi1o4HLYQ73fP3oM2ejYn8Dii8HL/iiRe/LXHieB+xq0JRsJxKuzn53n9dUMPuq2o68KSRj9McfMBVAXIPue/zxxb+Bcaq2z8PaU+MODOVNM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lbWfshHi7/y7acyu6agNU5rGmuN1U8qnfKxZEaTh/PsVlySfYBRdxbDzi9ikG93v+R8uy9VBgXnd696VhU8XDP9W2v6uvh6nWuj+pg9fwImVy61u29a81FCExE0eD+32A88Lhof89aW2O76hdB6SKvPGJcw8RMPs49RYOvYQe+3EAUq9Zz5krpir9+bkkz7j4k3uvlqCviW7kWT9WHKKvrJy+zxUuPKR57tTz7KhFYErcz9fXFCRZOexqt1MgO7Z4GGoj8/DLdoi2NucyYKsGTQgXcQkS8VY1iTD9FQQjLWVKJAp1qhVrI1XRt+P08bkTTU0V7IKdn0TLjyA63HsJfPjJ+BT9ynQdT08a6vS1uECozReMtWQQflAX4SwE9kcRjeooY87+Qvidz1UKOqNGzbO5DYg6T8MS1AFUJnc7Hl7/owFDuTs9WeEZvjG5MKM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 05:35:29.4369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b70ea1-a69d-4e48-fa6d-08deae55f25a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9601
X-Rspamd-Queue-Id: A46A5502A80
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20287-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Hi,

See detailed description by Moshe below.

Regards,
Tariq

This series prepares the mlx5 eswitch command interface and vport
infrastructure for satellite PF support.

The first two patches abstract host PF data parsing behind a helper and
switch to the v1 response layout for query_esw_functions when supported,
so callers are insulated from layout differences.

The IPsec VF checks are tightened to use mlx5_eswitch_is_vf_vport()
instead of comparing against a specific vport number.

The remaining patches refactor SET_HCA_CAP and enable/disable_hca
command helpers to support vhca_id-based addressing, which is required
for managing functions that are not directly addressable by function_id.

A follow-up series will introduce satellite PF discovery and management
using this infrastructure.

Moshe Shemesh (8):
  net/mlx5: Use helper to parse host PF info
  net/mlx5: Use v1 response layout for query_esw_functions
  net/mlx5: Use mlx5_eswitch_is_vf_vport() for IPsec VF checks
  net/mlx5: Switch vport HCA cap helpers to kvzalloc
  net/mlx5: Add mlx5_vport_set_other_func_general_cap macro
  net/mlx5: Refactor mlx5_set_msix_vec_count() SET_HCA_CAP
  net/mlx5: Use vport helper for IPsec eswitch set caps
  net/mlx5: Generalize enable/disable HCA for any PF vport

 .../net/ethernet/mellanox/mlx5/core/ecpf.c    |  24 ++-
 .../net/ethernet/mellanox/mlx5/core/ecpf.h    |   4 +-
 .../ethernet/mellanox/mlx5/core/esw/ipsec.c   |  83 +++------
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 157 +++++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  16 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     |  38 ++---
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |   6 +
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c |  27 +--
 .../net/ethernet/mellanox/mlx5/core/sriov.c   |   8 +-
 .../net/ethernet/mellanox/mlx5/core/vport.c   |  12 +-
 10 files changed, 227 insertions(+), 148 deletions(-)


base-commit: 8b2feced65cd3aa0597d596ed5733a1abd4c4d78
-- 
2.44.0


