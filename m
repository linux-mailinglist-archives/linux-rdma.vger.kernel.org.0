Return-Path: <linux-rdma+bounces-22299-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j6VyJKE/MmrgxQUAu9opvQ
	(envelope-from <linux-rdma+bounces-22299-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 08:33:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EB0696DD4
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 08:33:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="ZY/A8Ytc";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22299-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22299-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F1FD3052B57
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 06:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C5E3955E2;
	Wed, 17 Jun 2026 06:32:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E992EA498;
	Wed, 17 Jun 2026 06:32:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781677959; cv=fail; b=GNy8G206HL8jh3xppDpUx62nH95p+ICKuqtv1bhtNABb+SurEpAuBX3WlZwawUOWUiglVP+CyH++x8e4WU7cOWCNjIsRMq2rE3go66yzQlbEypo6nE1vwLFUm+LPMwmqWr9BSjvvwG44JfiLp/m/sDI67GTqGSIDwUltd0xAhIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781677959; c=relaxed/simple;
	bh=BvyjBYliYc09isIAy/o/0FfwOxAh8KaOyOQZWYlOr4Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bn63qUIyu8DqGD5QhgPJMUqhjQ0cFDZSzPqyQnx0PJQY9izOvumEi5Bp2Upjdgq6WN5Qn9b6g+N/uYfCs1b9aRZdrXgE8e0fX/pWLUmySmZE7WNionUT9qk+/4YJPvu7a3GtF2VHmyHlYEYFuRJmfFjFoShiaSBbJeqqanVuKUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZY/A8Ytc; arc=fail smtp.client-ip=40.107.209.54
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUOOiiwPKtj82u/GLYbMljDSX7ECcI4oo6gjoECdUXAu5vxntfqwvKL+OJVeVjyYbqlwfp/pZSzZE2yFoLEH2fJ1mehY/WmO1Wr/rseYDIGsg8Fw4PCaXidR3lhgLr3dosH9zcaavP5RbH4zWpLLEugHFxZ9h4rsMwtGojbDHMJW9o9Gz49jd/N1uxxW+frtf+aMStZMpwpjJo6Z2P7+UcM0eqFsnEPYr5vA2oEvToiwVNPT66jASdqeXilPGPyFYiRzdMmHavqBA2fFhltK00zrnometwYD94wFGQ2sV4brf9ntlvunEJk/MbyOg/I+Crg06nEa29/fxqWia2YhFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6GQce8brQFGXYtMmiPpK+aMSqkEKVJA6+aaO59HIHw=;
 b=e6xs+E1c/ruY4CF0Fu6RvfMKoMc1mSWIZRnIKxVARZx9wevfCn2GBE6Wiw5snI/Trj9v1dbSTwSUemaNfSQSCkUrpmHvPuzaSxBL7p5O0Q+sQooBW/PZGGhrmAcqBzTI6Z7P1atGdw8BcehGsDNvVDkZn3B7sm9GScs4vcoHKiANnP6F8wwBIb34NdW7wDOobTRsKquVxCvaDpof/okugOzrcB20WvBA/ETQx7ggAi38G7L2PARJR8N5LmWD/atvHz9NJHoG2KF3Dl5HJfv7sF6xM1Heam6KTqaXnUh5dcR5ScuoOw1pVw6JdFqShEsPALlYE1j6Q8QlpY9dGhI8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6GQce8brQFGXYtMmiPpK+aMSqkEKVJA6+aaO59HIHw=;
 b=ZY/A8YtcahEDdl8kyAFwjyLFqvU28O89D6LldSCC6i5JgjMK+EQzMxi8Ekc7vxAfVEwiEvfe6vPlFnmZacmhFDEzwgPPgs41hmzDZqt41Pn4eq586WUUYgynuzRp/02zuJgzfJ5zxFxm8J+KsbMNl7e8+Ccv8/W25Zcnt/5o1VjnSl3e5w6BQaVJiQpuFcuLXftDc1ljPpBlME432hyxksUDwFf9hdeffT9OpMXBvIzXWVHlpSXszAUacaD96PDZsqfTZkkQmuBHUTnmuvRV8k+QHFw3drjbP8z20BnZhl4G8eZn0bkBlbrCtRrmubBaI1w6g70lc5oSn0LxHsO3vg==
Received: from BY3PR03CA0016.namprd03.prod.outlook.com (2603:10b6:a03:39a::21)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 06:32:31 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:39a:cafe::9a) by BY3PR03CA0016.outlook.office365.com
 (2603:10b6:a03:39a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Wed,
 17 Jun 2026 06:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 06:32:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Jun
 2026 23:32:21 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Jun
 2026 23:32:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 16
 Jun 2026 23:32:15 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shay
 Drory <shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Rongwei Liu
	<rongweil@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net 0/3] net/mlx5: LAG bug fixes
Date: Wed, 17 Jun 2026 09:32:01 +0300
Message-ID: <20260617063204.547427-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 4776bafb-aaff-494e-c07e-08decc3a3540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|82310400026|23010399003|376014|1800799024|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	U+rHIUn2f3nH5eLJ3+Yww56KBygt0diyPy689hXKsiPNywzOu6gsvGmNLd6NJHAPJ2+NCi58EVCeNNeYekg8jGZ5vFXGhBd2vPOWemkL9NGGJ2bpfZoxEAMMtu6boDerONHD17bMftuMIiZENyZSdkufu6h4y8LLEiNeUg2N+dX+p+X6lcybUYgUXL6T527VOkRym4Up91giMJcUSAuT4XuUMmrugUFOL1B2tZUsIp2AKIfCyu03xPZi8ZJ0MqBoJDbzlEY2UC/MMvFpoRYT9w60q+8M51f5on2uQqmdE5Bs8Xbadjhjo7CIcybpYLlKIKkqQt3xR7ClMSAi9pSxYNLjpUObOb7777ZLCBhw0TXs3XHvM7PngvKeA4nmLSuiaZ9QgjoY8YT9k5eqgCDCsD6vn7XN4hEYSmN5SGWTdipx5PXfCjtZRotBDEokPkg+VpgIWFk+49v8wzqiKVt58YBrW8+P1ip8f4XHfTmYxBeUzmeFyyZWhgPp+hfUemBiedcLDGoCIDMvrHKQbkU5ueA6XhvS11eQ9wl8ySKa0zQI+MB2OyeUDrxRAN0FUj5z3RaMCDOGVdexyM97GI3FPjnz6hM7X31iWb+YQ57WczWyOFMWgPrdCfrIzao27tlAOWvWzgtSW0Gv73P4+x/LCXAsnPVPlEBvZec3+7fglttVmeXxYNYWJsdBTiLH3/a2DRMxR/WIe7bLsLZoabz/Ygb/Gulx1yJHdKT9kwf3zpE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S3DiJCcx6HUiTSFAzclmHt/xZRljotktXguoA/NlcI3eTEpXxXFVBORb0Tu2lhQHeP4Pv6T2aQ7pB0/z6z+bss3szpN6FQhFftFykV8BScQ2pRkBjcTFgnft8M4TbCTeoIh0ClXauEMN/Ud4X7pO+KnGarDU2vOfg+frFEMOtd+9ptuZEg51HewDFbpvY/GqG3qrPbp9C5+f6Gf1EkpGxTYgMBKB3HNYK2kPPPGbgdkYWgcWnq/4ssJX2wd5oCQvxZpqHbqZImJYMzXt5g5ZB+HCBGmUwCcf06Me/Xo+XfSsuI/FJN5O8Hpt6KUNvIw+eLH6aE6b1he4cA/u4TKDDNgsDYq3rLMfQTOb53+PH/EzZViHHfzv/TAzGUcyrg8rqqWTigFpAO/DoA7zaNGmtrMitarfZFz8VcXLMSqpUgLxZuC8QymRsW+TFOxzR7v5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 06:32:30.5688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4776bafb-aaff-494e-c07e-08decc3a3540
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22299-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:phaddad@nvidia.com,m:parav@nvidia.com,m:gbayer@linux.ibm.com,m:kees@kernel.org,m:moshe@nvidia.com,m:rongweil@nvidia.com,m:jacob.e.keller@intel.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01EB0696DD4

Hi,

Three bug fixes by Shay in the mlx5 LAG subsystem.

Patch 1 fixes an off-by-one in the error rollback path of
mlx5_lag_create_single_fdb(): the loop started from the failed index i,
potentially operating on uninitialized state or double-tearing-down an
entry that had already self-rolled-back. The rollback should start from
i - 1.

Patch 2 fixes a hang in mlx5_mpesw_work(): when
mlx5_lag_get_devcom_comp() returns NULL the function returned early
without calling complete(), blocking any caller waiting on mpesww->comp
indefinitely.

Patch 3 fixes a kernel crash during teardown when mlx5_lag_get_dev_seq()
returns an error because no device is marked as master or the peer is no
longer in the LAG. The peer flow cleanup is now skipped instead of
proceeding with a bad pointer.

Regards,
Tariq

Shay Drory (3):
  net/mlx5: LAG, Fix off-by-one in single-FDB error rollback
  net/mlx5: LAG, MPESW, Fix missing complete() on devcom error
  net/mlx5e: TC, skip peer flow cleanup when LAG seq is unavailable

 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c     | 6 ++++++
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c   | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c | 7 +++++--
 3 files changed, 12 insertions(+), 3 deletions(-)


base-commit: 0068940907d33217ae01217f84910a5cde606c17
-- 
2.44.0


