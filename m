Return-Path: <linux-rdma+bounces-18380-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKnlG4Wpu2nHmQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18380-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 08:45:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4142C76F4
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 08:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C0CA30378A5
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 07:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39813A3E69;
	Thu, 19 Mar 2026 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hqiYs4oX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A463A382E;
	Thu, 19 Mar 2026 07:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773906267; cv=fail; b=Yrbf6c8dBOYsrBGpBht8BHj0s4TmmAKO9Y4hX+1eoP4YA8IAtNlllUzIEKKqKvKeGYTFdSb5secV7RrULi62ztkOEsfL9qTW67QSlZmGxvXoRFL/LO3x9K49iGbacqPNUu2lQ+BQRebt1bIv4kS4dJVPe6cFWQqWeNt1dDko470=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773906267; c=relaxed/simple;
	bh=CsNH0KGP3RcAWvbUGk6C99/QeJWS7hnYA5mXZ6yJ+M8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ipyF09TzwXi8+0CUKvksXNTsdjJux0pxnj/JCfow0oaM2OtpdN2ZU+AODEmYJOwMaoVQg/1FHnr0+DfpPqux/I0517Z7VsqwUPner6+FJBDRrOoRuu1WTTGuvhPOkkTXkfwi3OaMBt3hR7vPn/tifVbA3wRillnI5CGhY59diVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hqiYs4oX; arc=fail smtp.client-ip=52.101.62.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRmkMdIjz+iiLehdPxmLObIk+JbX4lQoE+TWMEfJU4XwQaGpo3nirA3Xf7fb4vdWp4Adn9rNY4/THjWSzvnhEwBWn4gPJOENgfJciSF10yPZSP11iYnybapOeh2AvUiiBzY8yKtg+sUvhOiGdHwGJ98hIHm8Q3UETj/krbrZpgHYWnHJ+qAOOt7DtvtnTCbOmTUikqu/tBzI5Rr2OZAA5mNxSlC216DnPeCdHOZ+bxDF3zum9k1ZDAar36e5rQpJCZrrg5IeTT6/QfS5cnBkY1Ap9OimiJKcDIrzJmM5soPSsgj8IUOPhXV68KmkhdTqLsWuHeYiJuTFat9u+1jW3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaNpvgq7Dbh9PfeO9NadTEqc3ArhMsp4BbsSAHGxheA=;
 b=ja2jrOOcfw13zAESPFRlek4nPeM786tgoZ4Yz9tcZB+g+nRJIpSpp/ZgppUCqAzykOAYwBHm+BiqiVKWWTFyyYUoK6qxnXbhL+iNckhgd5PewrbP5pqwsajfqzzbrF/co8oPYOWneVLZXBSYmyB1/SSJokhCKyNm+QijiLTv8vIc1aEGHgmN0QY+g5j4DybZqfB2Vi5l3lMj8Kd7xMRNvm3jTKSB+CwIv8gkQaWeL/0AjnuHq+LqCQCvsXkZ2I5NgzuqC+GSN1r05FwZh+ALSxkcS6RrlXWCxT7IYR4EAdUemp4P4B0/EIXXFf/S0umc5oXQeTKIFj7Laq5VzUZjSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaNpvgq7Dbh9PfeO9NadTEqc3ArhMsp4BbsSAHGxheA=;
 b=hqiYs4oX+s3vl/Vc17+HR2WVHDqFLisunW4JYEI5JxBzbPCMVsImmFY12g/4uKAu/iYI9Q23RmoPLjaSZ/7kZtOKWSj/7c3gIOFs2A/mJyymL/eVcHnqQjfE9azG8DkEP0rTxSYWj3nIrIiHIAWQ4TOiNAa0xAo0YC1j1fuMylKPIIoqzB93qoEEFhOLelft4RAe1j5p8IqqtA2hR5rpc7LfNhclGIe2Ht+liR/plnxWs5Av0Le+tcB+lE3CxNVAQUFZzpAwt3ZJzARVYRxd1y9olsOf7VC3A5mS6HIXSB4W9VYzYc5JtzkeB0lVbYwjAzTUUofZOAsxXwY4T4jvyQ==
Received: from CY8PR19CA0008.namprd19.prod.outlook.com (2603:10b6:930:44::13)
 by PH0PR12MB8823.namprd12.prod.outlook.com (2603:10b6:510:28e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 07:44:21 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:44:cafe::e2) by CY8PR19CA0008.outlook.office365.com
 (2603:10b6:930:44::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 07:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 07:44:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 00:44:03 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 00:44:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 19
 Mar 2026 00:43:59 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 0/3] net/mlx5e: Improve channel creation time via fast-path MKEY initialization
Date: Thu, 19 Mar 2026 09:43:35 +0200
Message-ID: <20260319074338.24265-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|PH0PR12MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d5c688-175e-4885-42cd-08de858b5549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	U4UknZov45TuYYwG9rMM90fM/dgzbHIGWR6bdg79whzoCt2QhjiXBlQPJlhznQoIRW8gDz6pSnAS0GtYQN2yjThMnR3Qti4mF1UFRdusjdDkGBXvUlp6LNveSfxxpyCTU4FbGjlHV4EXqBpLIDcOaf6jlg5ATrn1Vs1yOvu9OD0DfZVrC35IUYBOF0CGKz0Z4tS2HGr62axE01hNo7JZpvmSLdKCcEp97o4QgWvG4Jc6BdwDh79TmJ7DG8LAhpSSj6pB9xGiSxcL7+T5dqbqUHPkCrLxoEM19olyKelE+ZODracBqj/Do/G0NIm5AG3D5ZpwolZoMV36fyQs4f+silx6adw+k+yXZ8Ee/7xBsA5ZmKsMU6SyetjBD0aTCgRY/dQk+YZh+QdmhASiHKomULZPr5a3fZqtteq6Mjf7WAznD4wm682IZpNHQVi1xxQ6pzv/3jLdqVPx3vCLSl2KK26ei9QFNhfu7ZvoO29fLxoV3J6RgUm6DQxTjJoXRdhSd3hvooR9nbJcxMeXOV355FR4+ZLBcT+A2qiuOM1cUZeCOj2Yy4peQoJeApuT7hXEkQsClIJG/VSPWkZ8C8miQFTXWpLwg8ztF8tpG1SGnY3hCSl6E41htbSunkMaAQeyPKIgBOgP+J7V5rbDZMcHhV48d+cW/DK63pS73uhg1k8UPT5MIPtjG+Dim2sftBK12mhJNGSQfnmnANswYooz3eTOlbNEvC3PE0dVjMaM9JUp9hv+D5OUg1oPothtFxES1T/y4ma0L+5PGmM5OiT11Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fkZMTF9MTrFU2DlQEXLxzAgTmt7wDBcnt4lNh4FO+XYygxAzFF10Qqhje6CRWb9tDqHP/4bOGeIgNrCdvxuwKX+S5jHZyZtM6o1OFPbdO8YVKapX2hdvzTJAHpbboiOUReG18p5N8I1d36hETMgMZHJG25Eq+ABqZrqHCNFJtPhXBonAJG2cLi/rsezNGYLlKyccJrB5n4falvJ40BKZOlc2/3IJwhawj/lZi/TXiUv/BmGdOCCDXZggk19C43UgzxZsnrIbhsbTD9K8lVC8Bn0cHUC7NHiCPeO8ESdeU5USQjvv6tlj20m5rtj9y5sngfqcRohJWHaKhTjwt86z7SCEJyGtizUoAJSSGtGd3fuSuPKbVd+lZD9jyWsQ9TXQw9b+DEwImev4gImIuylARz3wJpDhHVHVHaXsplUR7qkBDtSmoCg4E+nm22CYGUaA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 07:44:20.9689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d5c688-175e-4885-42cd-08de858b5549
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8823
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
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18380-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.967];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: EC4142C76F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series improves channel creation time by moving per-channel MKEY
initialization from a slow-path FW command to a fast-path UMR WQE.

The benefit becomes more significant with larger MKEYs and a higher
number of channels.

On my setup with the maximum configuration (248 channels, MTU 9000,
RX/TX ring size 8K), the "interface up" operation is 2.081 seconds
faster:

Before: 5.618 seconds
After:  3.537 seconds

This corresponds to ~8.4 msec saved per channel.

Regards,
Tariq

Tariq Toukan (3):
  net/mlx5e: Move RX MPWQE slowpath fields into a separate struct
  net/mlx5e: RX, Pre-calculate pad value in MPWQE
  net/mlx5e: Speed up channel creation by initializing MKEY entries via
    UMR WQE

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  11 +-
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 263 +++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   9 +-
 4 files changed, 212 insertions(+), 72 deletions(-)


base-commit: a7fb05cbb8f989fa5a81818be9680464cff9d717
-- 
2.44.0


