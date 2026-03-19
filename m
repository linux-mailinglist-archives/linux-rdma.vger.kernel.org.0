Return-Path: <linux-rdma+bounces-18384-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AZJOIaru2ngmQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18384-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 08:53:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 909822C7888
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 08:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AB94304E73E
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 07:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD873A255F;
	Thu, 19 Mar 2026 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZJft4ApG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF4026AF4;
	Thu, 19 Mar 2026 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773906731; cv=fail; b=LGWONYzYxK+3UGq702MNaDIGFZxa9zylGpJrSSZJTpHkKjJK1gNC6rhJSM3+hiBEHFugkftzg9KPKarD4D0fa+dfOp+2V9aL2ICuYYeWg3bD9WFAv9ljxYdaRcHx1G9lMF+y2CqCBG4rfkriDmXyLN/mKNKInB1KjolSB/tf6vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773906731; c=relaxed/simple;
	bh=FTrDIrT6epFnBAJ7B1iKpP4/Qb+BInf1Z7uA0MuHhT8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hfKOAzs0ef7OLFpSNQZyc8ekngeweKVWeHesfdyj6M502/wYEV8rZPJ+enjsFSQmpXden8LoTTaAz3x7uU1UzQPDULcOeAO8jGST09EXqFSvK6Nt+BwoKhJVwiLYsa0jgPIHh+HqSw+Se6sLSyZRe2UZYo1LNkiDEPlx0B70tjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZJft4ApG; arc=fail smtp.client-ip=52.101.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4Htrf6QkYO8fTIXI5w4Gj6qYkQXZdxOa2a2haPl7NrMcgiYgmKfejgeuLCS4q5DfE47QB5FtopMnC8RFnCQHzWsbY6Roqa1JqJpe30JAinTk7bn553fYFILjZl42/X+HFoONxATW310FkrixXDZIiN1ENjeqV0Lb9t46TGfPNLAuylb7T3V6VCrS4Gizr/YHAixCRcRiUSX3DBSpdmS3tSX0x88Zc8ZwFmzzlTc94hJ0v7II7/xx3QRykjRG8InkwmtYhBVWTAhC0LWSSkRMW3kTz9PN2zwdH8JlvCa5Op4tIxmqnIGewDLdJ+Itv+a5JgGNndkMsdGnYer/xzUiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LebWcriToDJgLrGflNRElzLGcL9O9Ik5xR71I679o8w=;
 b=QVEpqrGB5f9ksS/ejPGwvefHXb+vIXoP0h+YNzhY+AQkXgIgxVC1UNbTUhs2c//LhI0oH5ZpjNlG2/UdRmC1wIrMWot3SZy5XIyvN6cvbNoCRYcUbrxX0fhr9pdcf4SuiUL2t5W8nQZLQwRnrMiu787Sn1c7XZRLD5kMWcKczw09gWaGIEP11dSltpn1ayUutxDXCcUIza2pt4uAzkCwYQW66t5GqFTjX4hy9sDDJ75Gri0A0i0heo0UmVTMFPJnr/OBRtOEoLGEdjj+MjmkeOppJ2b4zxBpL1zBqbUt7d1a+dvY0X+Bi1TkSyCEg9RNB/bQsD17X5aEufO+HoeDJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LebWcriToDJgLrGflNRElzLGcL9O9Ik5xR71I679o8w=;
 b=ZJft4ApGMhY9zPpx4PuWxRTmhD8FmNWfyTujipULjAAAJR4sWaSuuo78td5VW32UUrSLd8sFugV14jdahiYzzL7r2u0uj8cUMg7dLOBfvLm2zT8RaR6xt1cFSwZIiEJtUI6B4IsmuFFIoVz8+zd0QHIX9XC5/S/SNcf+vGE5WqJyqSQIsV7KyUYtBdIZb93ktjdYrj2k8cUvVlHl4gh+epmgZbi/DC27JsX6HyFXhUjytJ0w1//oWKcUI3KfctMcMIdbobvZ9Nc68QVUd7iIbbx/Hr2hPmKj2g7aBkSB3vY46VVqQqFxs5LRQIBLWMtZ4yfVfxArS3Z8Im5kr5NWMg==
Received: from SJ0PR03CA0207.namprd03.prod.outlook.com (2603:10b6:a03:2ef::32)
 by DS7PR12MB9476.namprd12.prod.outlook.com (2603:10b6:8:250::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Thu, 19 Mar
 2026 07:52:05 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::2a) by SJ0PR03CA0207.outlook.office365.com
 (2603:10b6:a03:2ef::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 07:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 07:52:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 00:51:45 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 00:51:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 19
 Mar 2026 00:51:37 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>
Subject: [PATCH net-next 0/5] net/mlx5e: XDP, Add support for multi-packet per page
Date: Thu, 19 Mar 2026 09:50:31 +0200
Message-ID: <20260319075036.24734-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|DS7PR12MB9476:EE_
X-MS-Office365-Filtering-Correlation-Id: c4839380-0781-4fb5-334b-08de858c6a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	50Pel+Rw24Lq3J010a039sI3/qYrOkSeBFOSe8KJd24EmfRoj7b67xtgQQ/lvmlKYBEo+TUn7/5nCmllQhFcnd/o81Zr9GAwXePg5fJMRv2i01WWyoNO7IlXVygWWGroSOqL8pF9I0O2jfOmuhgf9fYbfmGTeAciKncJVTLjtzUT/QuKW0DaiqXPtDbFKs3A87HkOxEo46v/cMPVducZOBif3AuIOB50xpe7UgW66fS/IqlynxplfZel3sfqEeggJtdyb/XpoKsFDo5SP9Q3eylaNo5y3GTG/csvqyGm6KokHTKjgaleHArIjN8giPDPcC0EEY3rE4fhIFs3L0d0KsvWaZj4NkziPJdYffpxUPsFXjKyMhn9UWp9ns2FwSTBsXKnH0hOq+GrzxjFdy8rjBjI6ArzXodR1p55y9jYkf8BVhkKUqg8f/LYQ29mUGuZo4KAlOxDKSrMuEYUybztk66Zq5vdJWCAlRFJYFlCTrQGtdXWcfzGOEZt/1ksvCwpgSI4nsB9w3DcrWbI0Hpkxo4I7Z6nTA4EiJBAMtHQMpS2mqgkzrpugaKtiWu7nzvIMnZmXYQtCwYYpjZD8SKNEFNm+3EK5zH0y2aMJsJshXCVMSrQmHyndN1LLPqYnJNyupMdCnvkraUNj9O+iS9AV5q2IejpdIdFDDmVK89a66cW5YGgKRZtfpJHTma1DWLAPSRNzYQuuUQT7ciDPanP//9+nGpTdMYIuDWo/KtQsiqN9CcaE4NDYswTIxvnBUA2ObhLH/fXhE7aCRmbGxw1ow==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kSwQfhyH3lfYgm5GNCkucmo+9q+e4vmXuPwVmnvIUodK0XRuFMJ/tOONglRX6pOsR0oFitZBLK+xAIoZZZVJKojX5L+nEqznCqaHZIDeQ2xiW5WuE8Cy2nGwEl6rAMKyQxu6UDx9/qCTmXZyw3CaKxpnRByZ9UK0vhbdPFu9Inse6MDORcvot3rliiKs1C1EfuHu5IAijGCXq1fb4Hr+qraBLvYKubjyNHdMQmSAIGGy2jBcd6Vjsny06mhSNjNldfZ5tNcpEmsiSfMhzh+doKJhm21rUCiJKXE0wbpbCmKM2Da+IVQVH/4WrE1J6V0nId0cnSRGumslVm6JrtEBvyzj2lWx3uSkGLiOv7F7JdcHmFHzCOYHbhd0mH31ZtIBYedb6cE5Tg26F8ZcXDmAHH5W5ent0EvZ+bX03r/A7TwGekCnVRq4H8HS7SJuzo9N
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 07:52:05.2714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4839380-0781-4fb5-334b-08de858c6a09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9476
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
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18384-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.937];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 909822C7888
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This change removes the limitation of having one packet per page in XDP
mode. This has the following implications:

- XDP in Striding RQ mode can now be used on 64K page systems.

- XDP in Legacy RQ mode was using a single packet per page which on 64K
  page systems is quite inefficient. The improvement can be observed
  with an XDP_DROP test when running in Legacy RQ mode on a ARM
  Neoverse-N1 system with a 64K page size:
  +-----------------------------------------------+
  | MTU  | baseline   | this change | improvement |
  |------+------------+-------------+-------------|
  | 1500 | 15.55 Mpps | 18.99 Mpps  | 22.0 %      |
  | 9000 | 15.53 Mpps | 18.24 Mpps  | 17.5 %      |
  +-----------------------------------------------+

After lifting this limitation, the series switches to using fragments
for the side page in non-linear mode. This small improvement is at most
visible for XDP_DROP tests with small 64B packets and a large enough MTU
for Striding RQ to be in non-linear mode:
+----------------------------------------------------------------------+
| System               | MTU  | baseline   | this change | improvement |
|----------------------+------+------------+-------------+-------------|
| 4K page x86_64 [1]   | 9000 | 26.30 Mpps | 30.45 Mpps  | 15.80 %     |
| 64K page aarch64 [2] | 9000 | 15.27 Mpps | 20.10 Mpps  | 31.62 %     |
+----------------------------------------------------------------------+

This series does not cover the xsk (AF_XDP) paths for 64K page systems.


Dragos Tatulea (5):
  net/mlx5e: XSK, Increase size for chunk_size param
  net/mlx5e: XDP, Improve dma address calculation of linear part for
    XDP_TX
  net/mlx5e: XDP, Remove stride size limitation
  net/mlx5e: XDP, Use a single linear page per rq
  net/mlx5e: XDP, Use page fragments for linear data in multibuf-mode

 drivers/net/ethernet/mellanox/mlx5/core/en.h  | 12 +++-
 .../ethernet/mellanox/mlx5/core/en/params.c   | 11 +---
 .../ethernet/mellanox/mlx5/core/en/params.h   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 50 ++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 59 +++++++++++++++----
 6 files changed, 107 insertions(+), 29 deletions(-)


base-commit: a7fb05cbb8f989fa5a81818be9680464cff9d717
-- 
2.44.0


