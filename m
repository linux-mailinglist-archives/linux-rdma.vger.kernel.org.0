Return-Path: <linux-rdma+bounces-19413-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKcJC/FR4mnx4QAAu9opvQ
	(envelope-from <linux-rdma+bounces-19413-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 17:29:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F4A41C9DD
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 17:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62BC83046663
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 15:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8686731715A;
	Fri, 17 Apr 2026 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="loybVM5u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAF3310652;
	Fri, 17 Apr 2026 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439613; cv=fail; b=r/zsy2h4TNqY01ei4odWFiEASbgxL5HmmQ40AmcpN6rHvfwYabITIP4AryaS+s0DIWoqJ2Q06ObLCcO0BCJiW6HAMjyU7n1wrQRCokBnR2z8EUU+mbHh9im7gTum1FSVaOU3m1LnKg33UBym5j27MhTzYcv3RboKDHJrey8Galw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439613; c=relaxed/simple;
	bh=Wpr7i0HeiwkP7szhFalEJ/Lc2lYsrU8exsvlrXo3rug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gR6e0HQLOF7e8zx4LT2gxyvl+L34O5a/WiXGcyzUFtNfbsx2y6S+F9pg1l+XjyLH/zfqAxosR0O3AA0RRP+PNvqOIey6mzaL9hxIDFgYGPKgAIHZjNUnQPuVqUluOXiDoY4Pf8nidiBZImgHDLoyQcEfFRJy5tm3hVo2F1jFAaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=loybVM5u; arc=fail smtp.client-ip=52.101.66.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMR9evYNpAorhlzJQ5JSotGTkPsX5Md3lEFVoXTzLEusp2mOVRhAbHxOuri30HF9eStW44Z1W4JecVd3GoVFv3BaD1mcMVTNHadJD9bZl5yINY24wfNEEQsLrS9BI6/2eG31r690grPRqqQZGufS8Hvx8vE+DlG8oDnMvoJHZnfJiSBQLNqzeFyJ5vUakrrlXEG6N08UA6hBIkMQy8M1eWt3HK5TErYgmrrSj8sNWuuwJ/KAZaA1vjDzxag0PLKzEGwpVPo8b064SGNpyNI8o+GUlqbYKyACoiY0H4nadyKg+s7drSpzU6lmJqaDpkPg/K22kc9552dUUHwFX88/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibwSohpLBNlSJG2MkY7b6J+riJDSCg6HL1nzB7p4bLE=;
 b=JoZb4uL7uTtXT6rEDxFLQO8dcmoxM7HvugknBBTSeEKCvjndVhb7NGK13mM2g1+EF8P04SxNpEo4HNlPhlptf0tVE9v4vp4jGTjUeSArvBuVQ2YL1myjDKFjr8lS6f6Gu41/bVeX7ZbiGmBi5x8WXpv6pTkta0cgjVhwR3dbpn/TP1Eg+eF0kw++8HUyVvi4N7KrIaOf5KyTuCvSzIHdqIZstz85G6E7zEzDi6Jw2S4QstPQWLicACJhld873YNX0CkmrRsZPgDqXhzq1PsBdx9K0LdrI//NpjhWJ96YljTvO6ThYqxRKo3QrqwwNZaVRo/1lyfspQVVgDzgh0qIWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibwSohpLBNlSJG2MkY7b6J+riJDSCg6HL1nzB7p4bLE=;
 b=loybVM5uwvvGKy8iMo4sZMB0X7+CY5VjHQmcxW7N0H3zVB1/XqIjWllPONifOOXoLtYAf61VP7DoE+MiV6F6RjXzwm7JF0ZVrTT8Yd9FArtFPeRb2L2t32aovDt2PJZyJUOpmPgB9FaE4y/nJVVXSTwr0C0Ys2W+J5tIf9VlW64Tuo9qlZi/uklbr7krYju25KeHi482F6PgAQCFIeFVlrAVO42PjqjS8dNLa5siMC7DP/AtOMcHiuOMATjz4tauonEI093J5/MuekfgdeAn4Buhmue0fQ+QwHeUuG8gGDpBzaWSqJdDcMLMlOdR0DxYmpOF4m70YKEEKNjyrdvBYw==
Received: from DUZPR01CA0329.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::28) by AS4PR07MB8659.eurprd07.prod.outlook.com
 (2603:10a6:20b:4ce::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 15:26:47 +0000
Received: from DU2PEPF00028D03.eurprd03.prod.outlook.com
 (2603:10a6:10:4ba:cafe::86) by DUZPR01CA0329.outlook.office365.com
 (2603:10a6:10:4ba::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 15:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU2PEPF00028D03.mail.protection.outlook.com (10.167.242.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 17 Apr 2026 15:26:47 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id CFCC5200CD;
	Fri, 17 Apr 2026 18:26:45 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: linyunsheng@huawei.com,
	andrew+netdev@lunn.ch,
	parav@nvidia.com,
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
Subject: [PATCH v4 net 0/3] ECN offload handling for AccECN series
Date: Fri, 17 Apr 2026 17:26:39 +0200
Message-Id: <20260417152642.71674-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D03:EE_|AS4PR07MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: bdea054c-b5d9-4c1c-fcb7-08de9c95bd5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|1800799024|376014|13003099007|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	koHj2n4MGMcPSWqxyT0B1lMMpSSPY9+iyIE/O8qmsk5zKuQTFSqUTMm4+XImXAzXX+3J0sCM/ZdeYJDVusx3VTeuUAIfiL329t03vgqu3w2cpgJt7uRTyX4Y9b9n7Mtz9lzt/RhYoCOO3qwPJ7RXB4GhQube4m1Q0bmHKq4bZoUlnszn2WViQxT1tHcR1BZLOAW33JlYlMixt55Onsw/WT6bbziEJFW4Mwp/rvr8OYil2G3XVmu6Tda30h2NFctEDZch851irv/XahS/iNn2wzEhj8K3keGu9nGvqJVncnRBaBxSnYujJUuhPdJnchk10apWJZ0Jq4Y6HyitbTTSIqvFAGFOD5b72zgovFlMfgauMTugTouG4upGawqFPL51NTRKlcaUsZ0dbNdPJ9XRzHllVyi4E8kGkR4iMi0uJhIftg/v+jdD8SU5r45TTfBePnGcVrkH+9EPa3mj0wHuClWxTt2aoq48yipg5A7iYdpvikzZDNBtKesY3HBJAmiHpGjfzc7Mn93jajRWr+FrrhU3cmajAMZCFvHbWLsqLdyGfwhO5dHEfZbn8exB6vWIIFcjqImChZl+qJIc9Kr1M/MUOT0BFz+z7MIHehREBWJO7Qc9rq/kNaquAVRG8vtBN7awLUdpziMwi4ccjqGJF9jviXxsmUMdH6Keam7qnEeZmFi45w7R1y+zz7MT1z8QjU78FDhGlX/CgIRaK0YECOvsXkvU/0OYjtDNNz92d655pRNvQ2PaZTTSZF7hYbiHYkNolug65pUP41+cU8A/2w==
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(1800799024)(376014)(13003099007)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mIuj6gXJf0Kipy4hz/DKdvCtbZpXzRst0iWLBHq3DmKqArHrs7POkpgsja4g0MMhYH6lhrheoZwamrsIpWIGpv+6pydyX43pjfpS94WVX2t150zQBz3vzGXZe9gl7SUvZsy3MuPQoIveBNhDmwZ3eiGxoLetSjPbUjuoZpKtlaEW+bNGWHLtznGu8geS2RWxthohNA4cCX60IJnfTBtWNYUWDnvDEjT8wi4Tv7TFzyozmrSIcbFJFaFypCmNcZSdJ2Voh3haJOmkhlu4iVlPGNhaU6xmDqmj1+5CO0snwY3tmpTfi7HFnEYWhDdsCdq8S/dPyQwTEtp/dr3X3iXZXSWDXyUGAu2ELU3Ay4z1Cpzs4Q0HzTcYajQTD6mkGK6V5QkXYUPlvwd8Uvt9cv7c/RvudANlIzml84jdLNNGq/b7ai/Xypn10QGhqQN8BJsl
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 15:26:47.3174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdea054c-b5d9-4c1c-fcb7-08de9c95bd5c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8659
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19413-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[huawei.com,lunn.ch,nvidia.com,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 31F4A41C9DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v4 ECN offload handling for AccECN patch series for net.
It aims to avoid potential CWR flag corruption due to RFC3168 ECN offload,
because this flag is part of ACE signal used for Accurate ECN (RFC9768).

This corresponds to discussions in virtio mailing list:
https://lore.kernel.org/all/20250814120118.81787-1-chia-yu.chang@nokia-bell-labs.com/
And it was suggested to clarify SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN.

A prior submission is made to net-next:
https://lore.kernel.org/all/SJ0PR12MB68066115C5329872316E6B37DC98A@SJ0PR12MB6806.namprd12.prod.outlook.com/
And it was suggetsed to submit the first two patches to net.

Best regards,
Chia-Yu

---
v4:
- Fix spacing in commit message of #2 and #3 (Paolo Abeni <pabeni@redhat.com>)
- In v3, there were questions towards hisilicon and mellanox ppl but no response:
  So, we re-submit this series to ensure the discussion can stay fresh:
  - https://lore.kernel.org/netdev/b796bd57-650a-41d1-8032-f124084634c3@redhat.com/
  - https://lore.kernel.org/netdev/62393422-bc8f-4676-bf3c-4d1be15ab800@redhat.com/

v3:
- Fix commit message title typo
- Seprate prior #2 into #2 and #3 to have one patch per NIC (Paolo Abeni <pabeni@redhat.com>)

v2:
- Fix commit header title typo

---
Chia-Yu Chang (3):
  net: update comments for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
  net: mlx5e: fix CWR handling in drivers to preserve ACE signal
  net: hns3: fix CWR handling in drivers to preserve ACE signal

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c |  4 ++--
 include/linux/skbuff.h                          | 15 ++++++++++++++-
 3 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.34.1


