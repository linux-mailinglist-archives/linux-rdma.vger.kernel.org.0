Return-Path: <linux-rdma+bounces-8318-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEB7A4E23A
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 16:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15C53BEC6E
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 14:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291E6263899;
	Tue,  4 Mar 2025 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o20JVU5F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E71878F2B;
	Tue,  4 Mar 2025 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099612; cv=fail; b=hJzLCq9ikVU5MLzx5Qj4On/K2t4QVKPIMsvdgemAfFof0CCUDZnNFpGpKa91Gdkx8KHFB89rvPVROTNHKUbcfGjRytCVjWOVn1zdmFxAxHraHho9b9jC79hEejKoD+HrobjCDTJoRTYFMg/dyuktDjRloy0lhGHnDHhdKAjQunk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099612; c=relaxed/simple;
	bh=z4IsCd23C1101L4JvXqFh7G2dxng8Ehdsj4yFpiQUCk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L0e4h3V6fcRGDfdfjM4PJCbd1J7iZFpGfaC/SnjE3geYYL0LX/3OyFhi5Edpb2jLxNGwrFr4i3+6+tc88vcA3g8Z2UzxJf9HelpZX72+bOUdWgyblsOBrnotdzU16OuxnlA36vbLbselPO0znU9iezVGD/Lg8PHPavS4b0bcspM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o20JVU5F; arc=fail smtp.client-ip=40.107.212.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvdAV0aoBDdDjl2YETP0Dr887uHeP41pcZRgMYVlN9B8Gw8F9+mRx5xcLO188e+iT6HAoRnYQkHgxOgDUcayzpqW1tC/IO57GImA3FcDDaHH3q19XhGvoOmHQND/D5uBj0XQ6v7bS1qqciFTRkkKrYIDJ+bRFwczmZL43M5oiRoz9YNbuLwdGA1KpsJduRmcINC7vz3P6v1YohHGJQ/2WvizCvoEifB+MF7E02qQoIfJe9YEAo9U/Njdf0FR+NSyrowb64ikHWbuNRWtaj7np+w2Px+yzq/mFcf6B6O24mWBEZLbhxc2B4R0etFFk72Rc59naG5Vs6aZBbD4uH/B4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RU0G/zpRfqElzZSDPZOEVaDf9yaKjf6RoeIyIrko05U=;
 b=iZww5JoXc0X1g1szjyQ7cBMW6Mt6HdZ9zzdh80QAOu8Hf/i0h8hNRl7riybvipqINQ7SJy3pcVygDcwqVhQuZubu3GwV5JTaJh3QIxE9qUVGbjjYn7hRSyMAgKaU5rdwHfnLGf+YLlkbAuggkcgKymLFlQ6nKQxRbNZrNhDnv7NqXyKhPDvdiI4vKDg1SiCKbSFHdc7Q6AZMSWsqzQK189ey0JyvgXundWYq1DMe1sb4iccaUhnp9vWRk9mM951VmaP6yUrJd9XL7Qv1z/wA6yc1+cmi6wNpCqkBaDf5iXVlS3VoBRHxcdwcwrnh0tpuMHdKA6FJCb/Rm4NWozQSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RU0G/zpRfqElzZSDPZOEVaDf9yaKjf6RoeIyIrko05U=;
 b=o20JVU5FBOsvo5mC+dHQmbbATkExll4t+QKJAjsB4y9bfTdLUe+dhY+FQlBoONN47r8u0NMit2S+nh80cUlFgY2MJfB/jmAy4mwxFZsrcS4rb8Rw8M2rU7WBt75MPGIWOD6IP69Sfr0zKlEplP3YHLg76x+M50nA3fT1RtWpBkU6OCT8leKa0mocOaD8vICD3GM0bTJPhr159HDXSyfysav4DnTpyr9RkESbCC6YQFHkWpjBMrf/SVZx8JrEnvzJ/dCIGLj3c1cgMvM4DkbZ6vCHYVzy0x9/H52A1HEoRC4fhH8QtKn8VJv7SoiU8Myc9WgJwSWW0D/DdC6Lil1WaQ==
Received: from BN0PR04CA0063.namprd04.prod.outlook.com (2603:10b6:408:ea::8)
 by IA0PPFB67404FBA.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 14:46:48 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::ba) by BN0PR04CA0063.outlook.office365.com
 (2603:10b6:408:ea::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Tue,
 4 Mar 2025 14:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 14:46:48 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Mar 2025
 06:46:35 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 06:46:34 -0800
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 4 Mar 2025 06:46:33 -0800
From: Patrisious Haddad <phaddad@nvidia.com>
To: <leon@kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
	<jgg@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: [RFC iproute2-next 0/2] Add optional-counters binding support
Date: Tue, 4 Mar 2025 16:46:14 +0200
Message-ID: <20250304144621.207187-1-phaddad@nvidia.com>
X-Mailer: git-send-email 2.47.0
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|IA0PPFB67404FBA:EE_
X-MS-Office365-Filtering-Correlation-Id: cebc597f-a08a-474f-735f-08dd5b2b649a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SbsKQM4y3dnhmkdotduJpvmT9O38P2QVyyycc56Oy2DaRKdQonq/Ui3M5sYJ?=
 =?us-ascii?Q?0DS5evJim2DBjHY6P6jGjknSmx7uqtSaqs5HT9193Xiothfs9nUIKcUi4Zjq?=
 =?us-ascii?Q?TkntWD9OqKAZetuDHr/1XlYbuwAhJdfz3AORddWTLyMadf7GQONsWrdb6G5c?=
 =?us-ascii?Q?FKwdypPgCkzoyO9qkx2gZOQZRx3Cw6KAiFuSIpsKiGqGsXWP7RObJKSWRuSj?=
 =?us-ascii?Q?2lHE6vtRDXMH8DrZGnikNOn4n3xiCyawQu5OAJ60SSDUl4/P+B1fVhY2li9F?=
 =?us-ascii?Q?ZHzatdXepWbIv93CQuFS0NlG5a/YaoqGaBzyw+KAYEMq3eBTlU4lwwkVGl14?=
 =?us-ascii?Q?IJ9e6M0fNy8nlp6hCqHqd94bWJBjnICF2I9wJQrYNJliLSksA929I6J7uC7Q?=
 =?us-ascii?Q?SAVHFy6O8NQbNPlZ1XsDjMzyZ405LJYsMGkezQQ+9Xv0FksbTsV79wS3OssI?=
 =?us-ascii?Q?yFAbxqXAJeufkfutrJkF8aX+eWcLFmFsheJl4t8BdsGWecFGtV8aIoDJS/qs?=
 =?us-ascii?Q?buoJr47Qc1JduZC2dnsI00MckF6QyFSuNAvCW6oznoD8LLCae1UV8MxrUjHS?=
 =?us-ascii?Q?Hq1gPgLOmyLbwqwgdD8smBLEqGP9qV887XRU/ZhjK3gscPvsvEfFMPTk5aLF?=
 =?us-ascii?Q?GBfxU5pS9t3W0KItkpz01XgaY8hKJuMJe1zEiBLwD4Fq6d1CBAI49/WOA483?=
 =?us-ascii?Q?+xYTG4fF8VAVBXJxmi7Y8JM9BT4Ae5JISZNKvQUdn2eUyhYEye7awFFxvzAR?=
 =?us-ascii?Q?CO4il/jRqtEbWyFR/x7ROdsTPJdsF940+kuuw1YMLzZtgBMixHppldfsddZq?=
 =?us-ascii?Q?pxS+xWv8/3CdByq4wlGgO12ExZjFRaf1qhkWs8mfqOISOaiVcEJqWniiJtYQ?=
 =?us-ascii?Q?4+JmtuDyQxInwG7SCzLL+aae67wvBQJ8d/S7sCtyhBpJrJ7zBw3pzOGAYI9F?=
 =?us-ascii?Q?A2CFZHZ0gI/sW9IaDf7TP2Ou284Woa6cLE3F75D4N7CuZNxXi+AtnYQxwfs9?=
 =?us-ascii?Q?YreG37Me31XMQa53zU0CrBjg29khPV2NJnZ4clMCfbpFxOSwZ/5WdB8ml+O3?=
 =?us-ascii?Q?mLt/3OH45UvVTyiYl4fPsj3OWovj95IEu3zlRow+uF2skPP8SvkvefoiZjeC?=
 =?us-ascii?Q?RghVAqR8yVS9frz8CclXUgQKnwselThTmh3DxGBUrVbqBuW933VBRWDGnhcT?=
 =?us-ascii?Q?5EWEkGPLodD0Rf3dCGh9b2rEkbG28uUS+82mXi/rALt0CUc2Bc0Kegzr20Xa?=
 =?us-ascii?Q?yAiECJ5AoGzDh/QLht6RxH1h5Rwtz2jwqppY8ECvVSreGSEWzU+OuqvbalnE?=
 =?us-ascii?Q?WubMabNugZZHKYIqnJP65d0VD9+CHqR89AAmSAsAFoNbSm0mBKOLMrCwqSZS?=
 =?us-ascii?Q?Nx51qCskc5ZEIH4dB2W/Gm6/Ejg0cAmGz4CMXNIAuyRiVeMqYT5uZFTx7i7d?=
 =?us-ascii?Q?dUqU4yr62HYxxy3jRpNM6PPQqcj5CvYRLH1di84V8TiC17SW+nFQZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 14:46:48.4168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cebc597f-a08a-474f-735f-08dd5b2b649a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFB67404FBA

Add optional-counters binding support together with new packets/bytes
counters. Previously optional-counters were on a per link basis, this
series allows users to bind optional-counters to a specific counter,
which allows tracking optional-counter over a specific QP group.

The support is added for both binding modes, automatic and manual,
in both cases the bound optional counters are those that are currently
configured over the link when trying to bind the QP.

In addition introduce four new optional-counters :
rdma_tx_bytes, rdma_tx_packets, rdma_rx_bytes, rdma_rx_packets
That just as their name implies allow tracking RDMA egress and ingress
traffic.

This is exposed to users through the iproute2 package which needs to be
updated as well to provide the support for this feature.

Example commands:
- rdma stat set link rocep8s0f0/1 optional-counters
  rdma_tx_bytes,rdma_rx_packets
        Enables rdma_tx_bytes and rdma_rx_packets optional-counters over
        the link.

- rdma stat qp set link rocep8s0f0/1 auto type on optional-counters on
        Enabled link automatic counter binding for QPs of same type,
        with optional-counter binding support.

- rdma stat qp bind link rocep8s0f0/1 lqpn 134
        Manually bind QP number 134 to all available counters.

- rdma stat qp bind link rocep8s0f0/1 lqpn 134 cntn 4
        Manually bind QP number 134 to counter number 4 depending on its
        configured counters.

Thanks

Patrisious Haddad (2):
  rdma: update uapi headers
  rdma: Add optional-counter option to rdma stat bind commands

 man/man8/rdma-statistic.8             |  6 ++++
 rdma/include/uapi/rdma/rdma_netlink.h |  2 ++
 rdma/stat.c                           | 50 +++++++++++++++++++++++++--
 rdma/utils.c                          |  1 +
 4 files changed, 57 insertions(+), 2 deletions(-)

-- 
2.47.0


