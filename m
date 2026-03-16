Return-Path: <linux-rdma+bounces-18178-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLWfHdIIuGkWYQEAu9opvQ
	(envelope-from <linux-rdma+bounces-18178-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 14:42:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E774E29AA2F
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 14:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F362B303B4F4
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 13:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CB939A04F;
	Mon, 16 Mar 2026 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m3K3mML5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013040.outbound.protection.outlook.com [40.107.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA07039934D;
	Mon, 16 Mar 2026 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773668211; cv=fail; b=XSzI8L7LPZzOpQ7eQPvHF/X0QcNEeL8KLdc+AB07IZWpJpQ4fK7v43kF81q9KBiL8Q+CbgaEqFQMnPQFUZjo1dLNSJvlVGgCpQF+7cUvjU6oLYXw1hmJXgwoo+kdmGJf3+wBIxG1pIjXnhXD/mifds0GCTD46/bn8BKNI1Bhn9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773668211; c=relaxed/simple;
	bh=OsjNuxKPZNGmwrAmyN+JHX+6fxzJDaLHyIV7jH1jNyQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J9BSN0T3TuAUXocjqLVaudCWc/WlQj3qI8GcAnvQhBcwPM58Frhx1tl220BvDcl/YEAq2c2eQbyO5bUMi9UxOlvKn6F7BFAFhIz7xkXQX5GJOW9Cv//AlDjTLuvzVTpCUS1ncRWa4u3al49KhxijMzx8zZD/2N0Rqo/C2Ld6RU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m3K3mML5; arc=fail smtp.client-ip=40.107.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQWYOSKAkGiju2WLYsuUoEj2xz8DluwJbCrjpdM2ehQytfZJqvjv6T/kOrYG3FrYTAbo9abOiAZUYkC9iAW+RmYQtg8NsLnTb1gvNHt6x/u587z/QIFDUpAzKx0zbEHfwltrC9bM3OQ1VhyrMxGShrsSwr3QfWCFaiQhYsv48k1LthtCP9JWHDpxhw9k8LCqePv4IFQ17QSDnfS8z4ozk+x32dFRONWTQEa5c6dZ2kFX4wpyVEWggURtv0PY22L0Mc4VjGKU0YuVZrFbxYctFvzZFYmWa6J4U7vUAaXjNljy6AYEQrOGQuLEMjLEj9rj46+n4d0cgKNdQU8hrr2vzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLuw0Qe2Rm0iu412hsuEm8dBfCtqIhiFDyEguD1n0WM=;
 b=WzM2vuv/VSyY3bi6lguC3iTPs4UO6vg8SYe50WjtgjsVsjMDKmj6Hof85zbjWpCJZx57TMFCRE18+x5NkYigItaQvUyk0dvzWc+MctwafKpEXkAhW3Ms4LkicmMEz+4w3DWE+VWEUlTraPijiSZB4/a1e5OAlqKRqDpLAiTt98i/DeJztle03qRJYL2dPGakUOELkjGim4rr966j8Fht7Q9o/xv2YgRcN73X4YJOs4dSiWUQRBdNFXsSzYaHZogw6kkgoUirxnZnWOb2QFkW1jTg1BzrBDikP+g9AHu3+intMCmIjTykkLH00ZIwt8P3Sn7cSAFUI5p/mbGHUxLPeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLuw0Qe2Rm0iu412hsuEm8dBfCtqIhiFDyEguD1n0WM=;
 b=m3K3mML5oaIYSaYXj8HQkYvOoLgdm3UPo7X576xAgmOVT3U1yDNvqMw2ySvDKM5WtV6MNoXQk8A+HKvTYAhiMTG8TudDVpUegnTHXzgERa5kdnsVIhpFYe2+aXRi71zm0N07ZVOxT1M4/+6N8DUsWlA3+DAafA9myp/OKLAmbVOsNXxDeAtdY9snKg9i3vN33asAuMNZclBwEiKUdUfd7CI1cWPdrYPWOn1QpMAsAKuhG82ym2u4q2XnZ3je/TKSzlRJckL2HN/BWNRD9bktloDRWfCOrg3fmMajL8D6URy8T6J4Kbn5fLaZ5tDfb5dlAu37svrosAwXnbdTwHdr7Q==
Received: from PH7P220CA0159.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::28)
 by DS7PR12MB5936.namprd12.prod.outlook.com (2603:10b6:8:7f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Mon, 16 Mar 2026 13:36:45 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::f4) by PH7P220CA0159.outlook.office365.com
 (2603:10b6:510:33b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 13:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 13:36:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 06:36:30 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 16 Mar 2026 06:36:30 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 06:36:25 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>
Subject: [PATCH net-next 0/2] net/mlx5: Support PTM on ARM architecture
Date: Mon, 16 Mar 2026 15:36:05 +0200
Message-ID: <20260316133607.8738-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|DS7PR12MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 3870e2b5-4f7c-4311-ef2e-08de8361112e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KvZ9pEazA9JUW11DU9C29svCBFponfTYe0wdhQunL4SJIHAwgiSW1Y7AzC2Fz7/inZESX1ZrgJQ1ELyGRfNczIuIN+czeRz5uUhSIStC38aYhaAAOVpu2Em3vNaej0IlrlklErtl+lFy7Dwd+V1LuVjn4Zw9ui6YI8LUx9IZxopKsa0zZeDwhrVOnMxfbZD45YWkP6psBwQWzjo8jdx+jWRUscBG8qX7KI58tyADGay2mmDk9bUUf+iKfwflvNN0lbnFCji01p93jueJiPPZukfbIngmF5Ff0SWXyE2ct6DUhWfciWcZKem3cAe2VfVDWCGVBzvgeNaFu2ht0WWd/82yAevK1FGOWLGMVIyrmCWnjKn+5esv70eGkcCEXx6x6jJ2s2aImzJ6aHVT1wry/dS7t719u+nztfklP0HiSaBGdQ2t8ZwHncRTrzHG9Ko+awmAHBhwpCVyswRafjpYQTtijgbJuAjP3GooIZ6aTPOZ1+ooZbLufiHQWSinemK5QuSgHM+phadHe8KzgHv7HwVVE2p6rUggXcnUT3lTdTzVM1OTxjRxJwOTQboHvZ1lh6EZpDvWJx6f5eepbUJvqjxG3U4Zl22xJeITguEO2bKJOJ2BSsdIDYmOwRojsukcz6qbZNc9npKnEOxkPpfGJH7NHcx+4l3/0jCyihC6EGlHdL7FlOftQU3yeSN5MHqrIxdYfeqCnVaqKa2RK5Hu56ecHFuJFXMvp2vmIq1JPYi0cXHL8Q+rfbqJDqa3qtLyXnK9DAIexCtCAHomQZdkpA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yV1JLePOOCJYFjT9PRS8jY53JhcyKb6J+fH0nmANrzTyRMuv4QoK/UYwsZULuj2zEcr6+5Wy3WLRMiPjbnp5yBOUnFHkOLUcUnK/K0c0gLnqkBrZNdgdrW7NPva8CWt/pqDVyn5TPHPN/qUuZ0aP15McUru6y5Ufeap6cuAW8WqOw4E9TnRQpPGgDixtlGouo5X5LQU6VMgHUuJYnmUN9kzvv+oxrkQMPdbuKX5Va6oZ0bVaqkT5cmK+1KC41cWdu+lf0Ps9mXfK3pcsykr4z6flNEKpEDiFtvPhngfijNBSzJmmwKGs/tA7DbdLsndEob/n+Uswomdlotj4GgaC3g/5jPg22OqCaQKkETkMwR1Anqi4Htude5yhTg7D+km78as9DGql+TAN75GWMYGimmOcQr+E7KZx1cAeDp/B+ZJ6x4mVCerx0zYDMQFvpM2u
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 13:36:45.5226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3870e2b5-4f7c-4311-ef2e-08de8361112e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5936
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18178-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E774E29AA2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series by Carolina refactors mlx5 crosststamp initialization and
enables cross-timestamp support on ARM.

Regards,
Tariq

Carolina Jubran (2):
  net/mlx5: Move crosststamp setup into helper function
  net/mlx5: Support cross-timestamping on ARM architectures

 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 40 ++++++++++++-------
 1 file changed, 26 insertions(+), 14 deletions(-)


base-commit: 5446b8691eb8278f10deca92048fad84ffd1e4d5
-- 
2.44.0


