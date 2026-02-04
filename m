Return-Path: <linux-rdma+bounces-16508-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNjFDtsLg2k+hAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16508-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 10:05:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EBBE389F
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 10:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 594A43027CDE
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 09:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BC43A1A37;
	Wed,  4 Feb 2026 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Q/Vu7ceE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013043.outbound.protection.outlook.com [40.107.159.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE63E3A1A2E;
	Wed,  4 Feb 2026 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770195847; cv=fail; b=p3SbWxw/Gtg1zjU4FXTn3E8HRfzl7lToJoaXxJsT037LzeBdolsddE/Fwkmb3wKWPFquQ2IYgZUSvs1LCHR362IfhZKHPksU3U+PV1sUStNKw170kX9LZIruryAmtXtnCq+QIdg/5CNa+st4bYiU/oV3Knb4wonUmt9EJ7q4trM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770195847; c=relaxed/simple;
	bh=LbOVx5Yh5TL34HuVG3erqqyRyoDtXfAbSpblhud8NB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpST1d3rMRpChwHPqbCyJRBF2dOF2tPGtlA8Yi9GuZmIgemLxiF7tMKNZygliTTTzKFPx9puJjsPEze6AxLFUDVO9JgIPI9qXGJKY0CwHtjsFWtZUqPV8Znk81yJ+3pvXpTWusmJyxLxT/o+/+HCIfBUpT0Cz4Js1Ga6pG+TLCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Q/Vu7ceE; arc=fail smtp.client-ip=40.107.159.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnlCeiuCPeoMj9fmYqgxzDtBKuZ1QhmAMlhw1AaftNABvTWxeAYf3G8HyN6Fwj2TgerJR5pSiLQ6YbC3ikMxYUhkEI/m1mGPwjU0ZaF05f4tEGWJmbnmXSZoQNo2VRsnM6v4wQorcKW7z0rBBZM9j6lm3UL9YLRIHybSkNitBks8orU+vNldliifQ/YKx9fb0/LHkJwuhuEK8fVmKW2He3Q1SjNPrl+Xa/vBM4xrXKIZ5Eh7V0igiFaZtp4MuFIJ+XE5PnVMLKjCJ4/Ttfdvtn48U+byC0Jd2uvHKPmoKYf87OjALfBguGnrM/pV0NOU/bZb/7hW4G32KsRWoJViwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkVONcNgY5WYYfS9KvHzgOZEjvlK0zYwkG1e4J0/bdU=;
 b=ZQLUyjZjZVQ9NIVzjQJOqiCGTcg9nsYKoaNstL7Axu4aPG/DWhx0xsgQAUG/W3opPorn+2v/CW+MR4ncLMMwge/sf2dkY7WVtDcNpFiH9NIMX2XlzkDXFDcXH7RzkVy/Cf/HYbpLo2ovudP8Zdi3tTAUV7CjVF4Lu5MpEYhw4EQtrmKQwsivL/T7hwvbywoFf6EySvkizMqh1GqtzgIu2mMFNadWb3z9d7NUI249/KV7G/QEnh3R6B0peDHyS+Ws1bi9FqmgSevdjAwev3yd8uWrRyHmpXloe+tu8Zh7YD/WhgF8GmHQkOztbYe4FiN1MasElJviW8nMn4KdTInQBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkVONcNgY5WYYfS9KvHzgOZEjvlK0zYwkG1e4J0/bdU=;
 b=Q/Vu7ceEwgGbObzjWUwYKZcX03E7OyQWE/bz5D1mwvFvv6otZ2Kw1S7LHc/VN2+chfq7aICtX19Yv9+drRThAJ7Ziyp5QmfG7fejw8DzeNI80StEhUzVvx3rSyXLr9U+TS9r82okRz7qKfO5qHVt/M1DcoLL6newtjTTqQmX1ecUydHTLph0lqva3YcK8VJPlwjlueOSyfNZAWPElh/99xrFWDtH8cZTdFWvoRYb/rZTff8ypc2kPQlcOQkwyBFC4iUITbYLdCsJkyXSFbrbd+8vZxqVNayc/rmn/Im9G2soQ6bYFdJhva5rqjVKYUCIDYgY7fu3C9SrHbxO68QxNQ==
Received: from DU6P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::17)
 by AMBPR07MB10620.eurprd07.prod.outlook.com (2603:10a6:20b:6b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 09:03:59 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::31) by DU6P191CA0023.outlook.office365.com
 (2603:10a6:10:540::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 09:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Wed, 4 Feb 2026 09:03:59 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id A1B8720324;
	Wed,  4 Feb 2026 11:03:57 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: parav@nvidia.com,
	jasowang@redhat.com,
	mst@redhat.com,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	shaojijie@huawei.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leonro@nvidia.com,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v1 net 2/2] net: hns3/mls5e: fix CWR handling in drivers to preserve ACE signal
Date: Wed,  4 Feb 2026 10:03:10 +0100
Message-Id: <20260204090310.7528-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204090310.7528-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260204090310.7528-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E5:EE_|AMBPR07MB10620:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 95522466-6c4d-4281-7e46-08de63cc5583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3+F+TOe/2xZf4R3kn6zxVo0Uf//X7Nq9cuo8NTTOyQ3FHtsK3KWKKq4uET+e?=
 =?us-ascii?Q?y9KbhgvkZpkY1Pe/YSqjl6KfM1le3kHjgS5l/WrB/QLXw9d5ky6616N2a2xb?=
 =?us-ascii?Q?uZqa5fOQIsvqIFtQanwTEuTu0LRWmDzqr8a+Ki7CDrf2mjV0ZSLTMiHC6z/R?=
 =?us-ascii?Q?DEdAMWSc4Q6jvj6v5dLXB6O9FJ4AmhGszFZp+85jngrDor+LEw/lFyS1dFww?=
 =?us-ascii?Q?njbmRHrSdMkv2ldGRFMUkZsezQsXAHg3qhS3I2Rcxh1cuAPdOHJxSYrYtDs6?=
 =?us-ascii?Q?t+2+SIG0dVmFoO9DDHRKHHwHJlKAyPh9v2Xq9ht04BkItWMpVXYQbJ1vpEcX?=
 =?us-ascii?Q?32P6x4UN3cEzX0TjgQdRttuCtGamDj0EbsfthLG07nDf35+XH7bdWNt8NTC9?=
 =?us-ascii?Q?+2DQVyC25pgp6QAXG6qPDvBIdnvitAYZ4LgHR+jY+OxK2XAMrFvmvsTrJhoC?=
 =?us-ascii?Q?jj0YgM3R0uq2znHXNNfFFN029e2vTnwJI7c+qgyD1sbHviRWqnor2n7HVcGL?=
 =?us-ascii?Q?HkeRLfQctVtXLJhFiym6VGqwxjazzXSKEojOLi25z0f7BVJaPAOFAgsWH8UW?=
 =?us-ascii?Q?QyHadoRoicKlW+fEMoHpcAewiP0ZTvCWwyIia0VlWSpOcujC3mWLe2mc+pUX?=
 =?us-ascii?Q?fB/s+d7Rko+KW+01U/Ve97Rsjm+TZmsz3kVjOtgYCJSmE6mKIpwY/e7Pg2Ux?=
 =?us-ascii?Q?q3yZdf+fm6NKCUU5u2nkfozg2e3ehP9Ajo+KVM9a736XNIH12osa8Jak2dKF?=
 =?us-ascii?Q?jpLPv5dBCYAcVGUlD6wnrSHmS4xw0Kp9/LQxM8tyyJoqk/ISbL7biEWV5E1m?=
 =?us-ascii?Q?RCVkRoKgS/DggCp44RUxq2x9FgoTxbLTdO5HJT3Pz1WF9UitVDPN8Pd+4dkH?=
 =?us-ascii?Q?M06kT1D/j8ZY1OhozWReZRsOvFnjFmZwHmMEHXIZ7J7alQxLof4wdDydoBRC?=
 =?us-ascii?Q?3hYtO8VvNe9CXOgEAlOBO9kEfOYMFKVErBfkBymcU0hjj8dB9hkgrj2iUQI/?=
 =?us-ascii?Q?jefxppgcWnuIHpjahkObs8Xj8B5FNngzCbCUc79Y9gpWx8310lzQbbnkw7OC?=
 =?us-ascii?Q?YBrfCujMVexU42qAkTudSpcSGefTUBdgCszyx8lb+4Qyp2ftnBzc9byzhojo?=
 =?us-ascii?Q?wUDV3EUUJjqqh0iDaAdPTdg4ix79PayRGQx/FmR4cgF8/P7nAw7NBcuE77Xh?=
 =?us-ascii?Q?dedZg/5dZ4Y7xJ+xz5txxfBO1IHRT6eFa3nOSajFXlYlGjIOfVj0MGEnm3IJ?=
 =?us-ascii?Q?QITfnbU7RavHQY18ObcVQhddPTYhYqeDM6QZA4MyXc1mVA+kUMKRO+PkVBL0?=
 =?us-ascii?Q?5Yg8VVqe8ozM+2u1LJLF5VF650lsnU6UZU9U2aZZiii2BWXYBYDy1khqI9Vz?=
 =?us-ascii?Q?PoFz1TZEOqAj/G0oARrS39cUqMZeZVfl/te0GPisR9LNYLmE6q/06jTim6Xu?=
 =?us-ascii?Q?X+3R6XfiJYZ7kh0qE60A7NxMx8F2OelScduxTrF1XXhf/r6PEnnfrb9l+lrA?=
 =?us-ascii?Q?yhtXPhPwRt2nmksUEldMdRVIbsiqZBr+3SacbIpcLA85a+EkLdlThAq+eSPO?=
 =?us-ascii?Q?Ansp/zRxuekLRSZdOvjT4Z8qDECrnuxC4VLkKGow+AhHtdI8Dd4VEjOFmo6C?=
 =?us-ascii?Q?roJCa0H+8v/pNPEY36/JiMvoML2eTSiIuQYH87LtFdOamwMxAhCf3+F9+wCm?=
 =?us-ascii?Q?6Vw3zREakyRKjBntjygcYU75Cz8=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wwzYk+vR0uyijURpOXOsDVVPAPSaduoeV93L8cc2NOaqAmhvZ8lW18Nmdo5s8+8I8H71uogWIRpSNppNmHLyCDOKvhrVyhsq/KOHjaxTpsEsspTMAlgXUjOgmToO2vKL3nOhA88NW/orhuXsVm5/gu3cyGeJA31V7wMDnLYRBjjl3bWIPCSUlN4tCuDIDdVw0VIh3ot1WShxdMxNOAHsJSIdOkmy4QcyzqmYHZFFnVcymYJBJtiWQ/yZLMGhPcssYlR3qhEd60N+cIRZy7TS+6fVBRX9Wx5qMPeNJOuK8SIAjS1IrXwfIBx/1N66eMacBgMvZEkXNc0v1Zc0yc2lHxicbHOHu41kzDqktMtzTHoAW2YmkFCIus0Iu1DB0X3gYJIuiV/xvaZ5wSjky6a0eKNh7rGa3IIs2y0btsUAfNTyyR33mr+4gu92GnnuM86N
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 09:03:59.1281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95522466-6c4d-4281-7e46-08de63cc5583
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB10620
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16508-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,redhat.com,huawei.com,vger.kernel.org,davemloft.net,google.com,kernel.org,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 24EBBE389F
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Currently, hns3 and mlx5 Rx paths use SKB_GSO_TCP_ECN flag when a TCP
segment with the CWR flag set. This is wrong because SKB_GSO_TCP_ECN
is only valid for RFC3168 ECN on Tx, and using it on Rx allows RFC3168
ECN offload to clear the CWR flag. As a result, incoming TCP segments
lose their ACE signal integrity required for AccECN (RFC9768),
especially when the packet is forwarded and later re-segmented by GSO.

Fix this by setting SKB_GSO_TCP_ACCECN for any Rx segment with the CWR
flag set. SKB_GSO_TCP_ACCECN ensure that RFC3168 ECN offload will
not clear the CWR flag, therefore preserving the ACE signal.

Fixes: d474d88f88261 ("net: hns3: add hns3_gro_complete for HW GRO process")
Fixes: 92552d3abd329 ("net/mlx5e: HW_GRO cqe handler implementation")

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 7a9573dcab74..32993652efa2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3899,7 +3899,7 @@ static int hns3_gro_complete(struct sk_buff *skb, u32 l234info)
 
 	skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
 	if (th->cwr)
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
 
 	if (l234info & BIT(HNS3_RXD_GRO_FIXID_B))
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1f6930c77437..a2ab97d721d1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1307,7 +1307,7 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
 	skb->csum_offset = offsetof(struct tcphdr, check);
 
 	if (tcp->cwr)
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
 }
 
 static void mlx5e_shampo_update_ipv6_tcp_hdr(struct mlx5e_rq *rq, struct ipv6hdr *ipv6,
@@ -1328,7 +1328,7 @@ static void mlx5e_shampo_update_ipv6_tcp_hdr(struct mlx5e_rq *rq, struct ipv6hdr
 	skb->csum_offset = offsetof(struct tcphdr, check);
 
 	if (tcp->cwr)
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
 }
 
 static void mlx5e_shampo_update_hdr(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe, bool match)
-- 
2.34.1


