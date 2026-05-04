Return-Path: <linux-rdma+bounces-19941-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNrvJXnh+GnM2gIAu9opvQ
	(envelope-from <linux-rdma+bounces-19941-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:12:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 475FD4C255A
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2CAF302B761
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 18:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DE83E51EE;
	Mon,  4 May 2026 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BOcqSPux"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011042.outbound.protection.outlook.com [52.101.57.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B7613959D;
	Mon,  4 May 2026 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777918323; cv=fail; b=IHX/mS4TzN7j2GKf0zxYhfYQIxsPXYUoG3u3CHHSxpOb+LdeCPmHKmPSXxhHRr1IgYrDfxeu68Dp2JBAcA5WCEMb8VDk0pCu63KlvG1xJqM+WAxofCZD9GyDaeKsrq7Xw5OMg51dkg/UsiCwDc4e5CmbfHga6/tuv65U9s6c8sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777918323; c=relaxed/simple;
	bh=JlYtrOb/3PjwsWSfGTLbWtM+fY4N8OooZ9Yp0wCUmws=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AiE/JmJokNOMOeWRI7UKO5BPyLYhP0C12hxYdxlr5/za3Syou2CGZ4eSEfSKANLJ5LM1EcG0/Aebq1vqwzDkqvRbY7CspKy/RiAPKDzSts7iheEhpNXdmfQYj/1jFzNFzalFZuIKI9vuBE2Iy+GEzTNoKVQrrPDwpuycb5WvNXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BOcqSPux; arc=fail smtp.client-ip=52.101.57.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVpaJDX9oYRSAtsPy+EHqpli+DX2KKI9uECKwYOEkRKoGpnG4zVfFPCZEvrkxgg3SS1vy6wngTDoKgkxF/bq/Y4CjvkQRtRQ/eUDfof+02R8B5YOUl16ARPwWn4iy5rp2cn1X0ukCExRAHZ0eZfNIiWyDri0hcd6PMXvmy+6ebPMvUFAfxZTELhv9Fi+bV65i0DE8PjuPfl+Vn4BkI8RvBJ1jtg4U1gpCJlQ9Mt3tvQRKqaRXgFCv7xUPWbfqFUreOA7nMrr876uRlVuZ8Egxu28Fvrbuvu6JZUI3t02OxU+ViDsnc/MqAsDFQ7f/GhoW68pw6wQdPYGqhb/JLDuPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89G063Vo0Kc1kliJoAe/z6hALodsNqp2q8GZmubZe6Y=;
 b=GT6X/Y5CcfLfbMH9aDOt4VIkvelyJ+uMmvRTCR14DrsQkgeI10Wpqx0EvgseBCHm08koDHe2voWg0QwKqRe5nALBRjym44piDimyYjRJI0AmSGQrfrxBRm8GduDEisBi6FmyzeWOOokp5Uqr+JdRMxxF4pQQpJW6ImGWD8uuW64RV4RtElOwf66fYietSWn5Zo1whj+pVt/MjBv2qpoC+LxjMGHVhBc7CvCb0aK2wK20ojfEisJvWIgKPIIZM+pp2DeZx2V1YOEkzaWaBTQyK+6GMGYFKRv0C9HVlMMJnwyEulI8MFLro+RBM3Sdbx0Q8g2CFMK2WyTCz1yzfzKO3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89G063Vo0Kc1kliJoAe/z6hALodsNqp2q8GZmubZe6Y=;
 b=BOcqSPuxQFzQrPyK/H42TTpzJRnYG1p+8Brb0xadnphQDt3T3neiAAYV3BS9gyjCCVj4LdRzxyJWTFBLQt7/k5TVE+7AEHm0S5NwLhebVB628tqHhLuCnNNi3XBJgouBpnMIfLig3OxMZUa66gBgN4kYw3A3wkKVYsopgVRpTuj7Dre7qwmWsh7Dcf3uYlkdEe++0Tty5CiwpF1DDf55YbPGuHzacLFadEsJHoh+db+7xsxALj6eSjiZW6DKkGoMBxuDqAt4vQf7ufBcxl8UFQOPqg+Pw2+6y4/i5PA7CC6a6HDGuh7m8vSVnm9CmoJd4FCUddb6iSCdhVb4OUY3Og==
Received: from PH8P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::32)
 by DS7PR12MB6047.namprd12.prod.outlook.com (2603:10b6:8:84::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:11:53 +0000
Received: from MW1PEPF00016159.namprd21.prod.outlook.com
 (2603:10b6:510:2d8:cafe::95) by PH8P221CA0014.outlook.office365.com
 (2603:10b6:510:2d8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 18:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MW1PEPF00016159.mail.protection.outlook.com (10.167.249.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.1 via Frontend Transport; Mon, 4 May 2026 18:11:52 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:11:18 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 4 May 2026 11:11:18 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 11:11:13 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Boris Pismenny <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Raed Salem <raeds@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, Kees Cook <kees@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net V3 0/3] net/mlx5e: PSP fixes
Date: Mon, 4 May 2026 21:10:57 +0300
Message-ID: <20260504181100.269334-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF00016159:EE_|DS7PR12MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 75cc96f8-fccf-4753-ecd6-08deaa089e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|82310400026|18002099003|13003099007|56012099003;
X-Microsoft-Antispam-Message-Info:
	/Y95wf/ExKlyCXsJoN7v2UEuXek3nfda+KsOel7TgAs+fPX+net/oRBYmcw+9gi5Ukn10ATFEvjKcYBpZuK9XppiKLO8EWhr55B0Mp4BRJdVpN1lYHR6IamVPUrtHrGw0upj33QkEchRDduh+EDcHqYtRvZUX/yrIeXY57F5oXxWlqjnn/NnmbVEg01loO/0sp+O7hq93K0bJx66ifkfYdKEIeoZDaMqqRana6t+XAO9cN/Afruh2+vC+fRyXAZt8YPuxRPjXGJCbEHM+IOkBX5PB8t4YedCzYu0uZnGmhKCMdWss0AzRxyBQqXidcn3qY87UWN12WcYtx4biItpKRlw/Ja/Sg4A2O5TBVso9Fo0ZfvX6eB63HRMUnJsp8Hdt1ki99zHu87HJO0LDs2G9098t2qKjyighft4FSER7IvUnIQk/RJQa/PIJkhV0/B5QCTf3LxcST4uMXTVKSMtw1A89hxZWSX/IbVYofzyXUII+S3FeUJNK9ezAygM1ZfE4a3MywdMgX8RXUYteg+kGJv1EFhmF4KYay2s4C6v+OQ3Xjz8Y81kg8rKuoz2IpfybW1qWj0hXq0zV6psknKj4RCQkZ4TfRrR1WW9+CJJgTo2qi/k3B2HfnE5nrEDPOSUtTzkrff2GaYyzfuVEAYz1yCaI7SBrYEQ8tjNi/dNkTFVmYsMRZqUuM2DrhnYEC67m46WLAHGYjHE9Ma6hn6PY/puf2S0xjV3HfBLpYjE/7c=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(13003099007)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Kac2SqB8/0l+HlzFecfTX3WCjYvS9+HgN8pAhS4356+pEC9g0dIzQfp5b0YTE2Gbro2WvR/o7fkMkkyKJkenUnxHcahZ+WioZiy3BO71RSfwLmZW7yJ5+12+8O3Osa3ndukrFtCnjXrZ8DmspeSHrKiXLQnRUon8x3cW67TD6H5u3CWgywJoP01YXDX271Zo/aBMhKWcYic2N+ahYy4dQ5lN28DS/hkPjk2y68sj8C821DhYWYepNMYRymoWJN/PghNigY3LuXwCjibId7tOL1232CejRKbZ5r97U++1fbNggz+23ZXRtm9LSZ2HeQl9T0tcjmGPLCK2REefnnF+PjrkwNd80VLIjWi+VDTkaWVJFHmbz0/ITLnAylAFhAPQRTGR8JnqyaEpKFc80imgfEbukRwFSK+QzyQ86Ve/O0s64u+WpsPEwQLiF0fJCdlq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:11:52.8237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cc96f8-fccf-4753-ecd6-08deaa089e8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00016159.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6047
X-Rspamd-Queue-Id: 475FD4C255A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19941-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

Hi,

This patchset provides bug fixes from Cosmin to the mlx5e PSP feature.

Thanks,
Tariq.

---

V3:
- Moved mlx5e_psp_init() changes into separate patch, with proper
  motivation and "Fixes" tag.

V2: https://lore.kernel.org/all/20260426083819.208937-1-tariqt@nvidia.com/
V1: https://lore.kernel.org/all/20260417050201.192070-1-tariqt@nvidia.com/

Cosmin Ratiu (3):
  net/mlx5e: psp: Fix invalid access on PSP dev registration fail
  net/mlx5e: psp: Expose only a fully initialized priv->psp
  net/mlx5e: psp: Hook PSP dev reg/unreg to profile enable/disable

 .../mellanox/mlx5/core/en_accel/psp.c         | 36 ++++++++++---------
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  4 +--
 2 files changed, 22 insertions(+), 18 deletions(-)


base-commit: bd3a4795d5744f59a1f485379f1303e5e606f377
-- 
2.44.0


