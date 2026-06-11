Return-Path: <linux-rdma+bounces-22110-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F/uJO5uvKmrVuwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22110-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 14:52:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E726720C7
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 14:52:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=BLeDdqMh;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22110-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22110-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 842813073DBA
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 12:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00C33F0763;
	Thu, 11 Jun 2026 12:51:26 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012059.outbound.protection.outlook.com [40.93.195.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB203F9F5C;
	Thu, 11 Jun 2026 12:51:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182286; cv=fail; b=YMRQtf2LaFJ8l5a3hD24SInif9XcEAElLBKCiKBK1HmWgz/FI0ga5OPm3JS6gyHBgMa88P6aa6uClS/GrnQ2R2aom3lu4nkqGmIIXikGW2UcD3V44fKfhVkCQ6dOdGHgL+6nX75mwiuDtC6GJhmCxq8BssitvPx5Iru+bFwfQZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182286; c=relaxed/simple;
	bh=WVWBx1VlhHT53O2S3HixFBgM6ChloJ3a23JorODaPFg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=fa0ARBuo1wBFk0BRDeb7oiRUP9QDuegaMXWO69BSiDIjwJsiME2QIWjI7gr7OfMzxa09ZWCtNenRtsLZb4PWlzFJr0/dR3K1zsOOcZbirf4zah67pEEL88hynOy/QZ9y8Ga+il8wM1xfEb4UH8yt99vf9w2IOIsbHnmyuaBsRu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BLeDdqMh; arc=fail smtp.client-ip=40.93.195.59
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRYRNylPxu+wjJEzVL4Hrhm1yhwHFeHOA2I/++6UUUiK8/aXJ2eol5ybBMpYjjPLx+Ez9vUOElwnZKh9Jd9IeY/FvU09maSNs02bqi+En4NlslIlBLvfYZ3lXqhr41zOY+g7awlteD2hg7dx7U+D91irx1vqG+RaIo/s3gBWhA4UbSD/6fGzCBj94Pzt0KqTTlk7uSn3XQjZk3B7BYy0ySEXfPVIB44qhkN4Liua1uOe2LNxwprEA8ZaefT56K97s80cpQRZQYhbFtFuP8Hg9Mr3AwA8wdyJ3dDYaR9zDUL4UMV58vhYxUeeuZb69i6R8POL+g6dLPBBeGE1gQ6Ozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Mfyd+z1GAkSM8LTHsdULiCY8udje728PYj1a04Hgpc=;
 b=WGu/gppTZoiRuYfgy8o09RZy/h5vnYdF00LuaITcMJ1ygdRx2xPU/XHZVGnuzGe0wwlb3XmgHPPzafiemYozk4Wm0xrrRZgQomzLEpeYJw4mnpxpdgYrVeci/XTrfnAl9j3Kt9tRucWrVpAISsmeDBSjbrKCbQ4CjggktFVHdjcaaJ0tU0ZqmKT/B7CoriFrDMFhs6Cm6aUGlOVtkzqahLatU+icw1CYTkEtlvdoFE7EcsZpLs+mKQrqBzvgDU5fq6ldy1P9x07Vk4YEUvWylMq9O9R+mvaF+tLQ+8s9uvDYDF3JZqju8l5PQCp0Z/3Rl4yU+ZFCN1LfHh/AkHZvyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Mfyd+z1GAkSM8LTHsdULiCY8udje728PYj1a04Hgpc=;
 b=BLeDdqMhSDRKGKAH82eMfswob1F8fTdpmMeBTBxrmSOpyP4HqsGBhKfd/hYk7fMWEJD4F0XpzqQssFMlwdQmHzGjic1Cm8uVV+9crFNZAq7tOy7rRfamSV21DhOi1WPfz7Tc5+lHMPgE4AlAo7xxWrK1tzddgo83lAnfjCYIK9/oayxz0xKeTIetUjfgFqTycP+GHp84fOsxDClkHFwUlpZp6kwGiQ8Kys5RVsBsaH5r4Sa9MTvfhDcxoDRHZnMHBaZeXtefPPwX9z3zKSlNUWfNE29jTpQAtxDA/kiTX/dPU6KKTKjHg/lUY+qi7Vwm0qtI0aAUcKT16sTAuaDdwg==
Received: from CY8PR10CA0001.namprd10.prod.outlook.com (2603:10b6:930:4f::8)
 by SA5PPF5EA4322E1.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Thu, 11 Jun
 2026 12:51:16 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:930:4f:cafe::11) by CY8PR10CA0001.outlook.office365.com
 (2603:10b6:930:4f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Thu,
 11 Jun 2026 12:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 12:51:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Jun
 2026 05:50:55 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Jun
 2026 05:50:55 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 11
 Jun 2026 05:50:52 -0700
From: Edward Srouji <edwards@nvidia.com>
Subject: [PATCH rdma-next 0/2] RDMA/mlx5: Fix user-triggerable overflows in
 QP creation
Date: Thu, 11 Jun 2026 15:50:41 +0300
Message-ID: <20260611-maher-sec-fixes-v1-0-cd8eb2542869@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACGvKmoC/x3LQQqDMBBG4auEWTtgRER7leIiJr86C9MyIyJI7
 t7Q5cfjPWRQgdHLPaS4xOSTK3zjKO4hb2BJ1dS13dAO3vMRdigbIq9yw7iPaZyWaUW/JKrXV/E
 PdXqTpiNwxn3SXMoP6hxCAmwAAAA=
X-Change-ID: 20260611-maher-sec-fixes-4cd89b9fe4bd
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Or
 Gerlitz" <ogerlitz@mellanox.com>, Jack Morgenstein
	<jackm@dev.mellanox.co.il>, Roland Dreier <roland@purestorage.com>, Eli Cohen
	<eli@mellanox.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781182252; l=581;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=WVWBx1VlhHT53O2S3HixFBgM6ChloJ3a23JorODaPFg=;
 b=oQSoultzEU4oRYfaWU//6Rr4IOi87iigHB6zS/fJ1Gl6Xs13HSewnsIUPwzCRNZoczBOafm9Q
 6C6ClLjzyQkBZG3uqyieh/ivGQiOH6r3yiN+khK5cpNTq7b2FjK7G7m
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|SA5PPF5EA4322E1:EE_
X-MS-Office365-Filtering-Correlation-Id: e4374b76-d79d-4fef-d3f7-08dec7b81feb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	SERAFjh7/yCdGWkLWbQ2t4A30jReoIGJQtVqrDd/Yqia5bJkcJ7JBRGKj5DSH8kTtaYQTJ8jZsHHJ5YuDuUZcbZsHEIO4/GwZg4StxZCSrXtFM0xiSAEUO8bC0SkB2yd335wOJXa6B3wvcxNziwNl7zujuEAsi30oFNSVDg3HLiJ60EtZICKKOu9+H2Oh9vRyEPG6jsgCfOALC6XMCLTHbIB0emf59Eq6Z70unitZkPnt+ug8vYiEsZbLYjQh65zwFxsdFLpQ8buMIbG2mF0xEBwaAiOa9R4xxsiOCpgocifiMNIH/6n68zkrrCU4WNYyQy2LJuw02/0RXFrPCCHVffUrnLX9VOChyTHLfDPHizr/QGcAdSQunHtGtTJdzDgNBXaSGvAzfRRLrahmhglZOt00bWtkBc1PTaVdjg1bAf5eX/mTu3ToGuh+FbIgAeYdXfv46FjRe/aKrs6lW+z7eiP82wnAT318vaEUmxQbVmnBAON4vJuOtdKoxd4YC1sdvtBW9Ig6MNAB3MvFzi8MxFgcv/gRzXLCL8NYaHL2cGYNFX1j0f9OoO30KinhmLiYnpOkcyHivUQkMET9ALJz71flFfzUJbnCLO2CNhcWyRpGQSJUVSQeqyem3F+eNL1C6y31FpuxVPvPx0KiffEYeX4QZ/64fHVZQLOtjaJQ74Z2+1lgXfEVS8HKdnFUc2weHjEBh1EtqFG/J7chdS0glbMRYRuVw4s6Z1uHi8k0S0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y4SDm13cORg9jY+BC1Cb2BpKNOqa7KQBgAb4G5+JYNA7XWvSlGq8SgN3T13jHvyQTg2/DQBNlBE+PcOQ9fZWXSuoV6RVR8ob3ZMl3tdFtxLkx9c6aUq847bsURNjNm8iGtl8Il5WQ63HqCBfDaTr5JvurVZ7wcu7V8GLkTWI1WLOnkuYaN4PQNjFBv/frUYcYZJAF8R2Y32etaDAQKG6ik9UM0826XjzrKyzhEly8EHRAgGskJRdiu4ANYuzn6cdyS3D4fEdKb7/GoOZr1SFR9FqZ6d56RHvQK5Juw0CDLJ0l0ia8ZGusqn8SyuM+d3fqbhymLz5PM/D6ZX9LegShNXgD7upSYL8TivA1wqbmeHb3UEyLHH5GOc2klwuq5mefRlg7F8NieIrRQElTbWWZLxGcpiZzM3UAmwQnbnFq3hhfoSdELg7tBBhZ3+82KAv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 12:51:15.5080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4374b76-d79d-4fef-d3f7-08dec7b81feb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF5EA4322E1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22110-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:ogerlitz@mellanox.com,m:jackm@dev.mellanox.co.il,m:roland@purestorage.com,m:eli@mellanox.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edwards@nvidia.com,m:msanalla@nvidia.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64E726720C7

This short series fixes two undefined behavior bugs in user QP creation
path.

Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
Maher Sanalla (2):
      RDMA/mlx5: Fix undefined shift of user RQ WQE size
      RDMA/mlx5: Fix integer overflow of user QP buffer size

 drivers/infiniband/hw/mlx5/qp.c | 54 ++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 12 deletions(-)
---
base-commit: 20ff9350862468af21b46cae2c22d17d6ec637f9
change-id: 20260611-maher-sec-fixes-4cd89b9fe4bd

Best regards,
-- 
Edward Srouji <edwards@nvidia.com>


