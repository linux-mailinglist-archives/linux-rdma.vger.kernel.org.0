Return-Path: <linux-rdma+bounces-18385-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ8RHK2ru2ngmQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18385-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 08:54:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1113C2C78A7
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 08:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 996F831B87FB
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 07:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FCA3A3812;
	Thu, 19 Mar 2026 07:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z7x15CJr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03993A5440;
	Thu, 19 Mar 2026 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773906733; cv=fail; b=mTw7TMxrXk8EAa28ma6DQhG4OITtoBiK8cA2oxg/jm+hd/ng/ZsfN4zCwbG5MZbGqUHcuIUd19siywEarrRcTg/NFrpXdtikvM/LRnJWvH4WO6rMPrR0Buh+YsqtAx8spnyU1jvA+/FEOzcbykL65QIa3xfHqwXitkLJmeiBysY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773906733; c=relaxed/simple;
	bh=o7S4FjoW9++IHTN+OUgnurVA3vxY+VWt44lJU75bSwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7T4pmn/ojlCjXnGozFT8mtX5VezuzPuHUXtDwuFfBeirkl+UcVsMffmDlCkyVTuvCP2PNIvFwhqT60ED568jpllAuNxAlTwv+NKlqnGpB3tZKFqZSUAJIM4cZ22c8wZLveJIiHgPx8AS6hxsHttNYH6mo51FsJKuaLcISlE8AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z7x15CJr; arc=fail smtp.client-ip=52.101.61.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9MQphvGADfD6qWKE//N6+TpwbAqqVi7yJAzEBmj4k5MivuqE0rg/UBUGb+4Do+OVGcBEt2VBgQsz0griFShfvE5PcmoqEZH0JoAOWATXtqGX8M5s5ffBBHdaSg1hl9ymNiOMYeZbFt3jUKbl5wOCTH1FJ7gtm2qIklJMKNw3woUnTohwRd9FA23bF0vKkfdxh08Pp5JmVwBOHh4kVeO3/u/2t/x1g0Wx/sVYdhyTvPUWILRZRQahSfqJkkOHGwqwKmhRJdkgWIHYrgzTsIIZDRxeKQnBaiZkX7r0VfcdLxQ+zHECtNUMEFXA9wIJ6/U7fjpmKdV8V5KsJEJREmbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JufVAOsz+AOuUnCEMShvoDXt1sEjrdHJCvtNJyFWj1M=;
 b=hXSANyWXTm5EVqTudXWMYsF1ATe+k3aYs76tIFGe14bNQ8yruFHZnxSoEThDwGiG1ivhsdgH1Zr0XdZAWxFSKQBG69sSaAl8t++S17RVHPvUNX9aHnibr2qZRcZurI0G/9NzcADmQP5fnHH+hELVqpfyHigCyEeAjEmOCmMuB2bGNlQbA/BIJmYOFsUyKt21mjDbgL24t7UItZjAH+lbYRBqV6+E5R76EwI7LwmRXHS4TxmgEzhSDkk4Vws6wWxPzHMeNxmKLnMNjb7RxCBi+w/80kuCcb4mvemhxocPl98NfEz354qTeemsDWC1MTfJo+rrq+WmaQ+4tm7lkYQVag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JufVAOsz+AOuUnCEMShvoDXt1sEjrdHJCvtNJyFWj1M=;
 b=Z7x15CJrtDn6d1aplwLRk+rpMKv1+q9Zkks91HDROGhFBra2rzz180jFrT6wsIb/fPYPzDehdipmik3GIwh5q1gBcaUoONTr70+fZg91VXUfyPU74JwTIyO5dM+wgV63bADwIQeSNLeTkdgCf6IaLEq1xWVOjLTt2AlOTIxFmPPXofbLFjMR4wHYbnO01ZHspti7ZNb1NHaV+h0DD73/ni6TNJpMoKni2+0N+zsCJvFhjdMI4+JqxGiSSeedSzFqZG6hyPwqbAt5OrIa8l5b82q73bkAL0LTsKpvOd4l98OQe54N2WDKA+XbjFGq1EBH2een9yLCyNCFge6VeTX1eg==
Received: from CH2PR15CA0028.namprd15.prod.outlook.com (2603:10b6:610:51::38)
 by CH1PPFC596BECF8.namprd12.prod.outlook.com (2603:10b6:61f:fc00::621) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Thu, 19 Mar
 2026 07:52:07 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::4a) by CH2PR15CA0028.outlook.office365.com
 (2603:10b6:610:51::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Thu,
 19 Mar 2026 07:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 07:52:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 00:51:50 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 00:51:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 19
 Mar 2026 00:51:43 -0700
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
Subject: [PATCH net-next 1/5] net/mlx5e: XSK, Increase size for chunk_size param
Date: Thu, 19 Mar 2026 09:50:32 +0200
Message-ID: <20260319075036.24734-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260319075036.24734-1-tariqt@nvidia.com>
References: <20260319075036.24734-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|CH1PPFC596BECF8:EE_
X-MS-Office365-Filtering-Correlation-Id: 34712cb3-e0ca-4ba5-176a-08de858c6b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ci8bmtwkONEi9qmd2QD7Uekq6H5W061ZLZ0DbOh+1yTAC7rWOIZfnNro8eSjRsKGd7Jhc0zmieXDhrb6fW7421cyLDQ0enQ23P9Jt8zx29k5T10J9O7hPqy0b89kpekcllxVF2kMT73afutbxE3z3o1L4qa1yq+3YQnJD5OLy7lRCLP9xlqC26R+i1jQ5NU8C+7mlV1oXkIctYsjj41Cb/bXL57jxiRJ0BkdFHlSGJ5vKpAfBz3diBq+0kMEzS83rD0RHNvyXgT/hK9dRBuDbl9v6A4RHq5q6FCxLme9EyjH4futTlpR6fl7hJ2/BZbT+vnoCHnRKnFc5EZeO4mUnPtj53cliWhsWm6QpNxtowqfrL+l4vFuvCLGvikwPD2zu7OUqDCHnElmXEy78trRgMwSut1SwWSKpHOxSQZnrkB+PF7v1621Tva4V+jwMOquUiSMUr/2jCbI//Fda16Q2sTWflowMygfscjtvGHmjwedijqb5Yxsi5mz2X/Wwnz0g+yLBw57Jq+h6LTpueoz8RPnlWBoDcnCjJbkvdNz+NXCdEvQyt7FVO8p9/UUDaQXoJnZLsVl6Bm6MYYVSicAPKXJs7eqRHE7ABqbFg2PkF89pDwhIVuRfLgV2UFDOMuwypA+7QiqZcVVj8Nejq8KXrWtemADWLTaC4BH39sMYA4TOJryoP4FpDE/ycMEFWgNSSI2TBwh+Eovv8qw+ZYiLL7SAaD15uSp6TESFst89Zo76av/r9lomyfce6P4Y3wdy7NJYq9Y5svucl/9/wN5xQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3+qrh5LMp4WIj9M6Bv16KFZrBRgnb4U7+7O6NGUi23h0I1N2zdrp/dE4r3VwfGnqUKo8f/0DXNhf99vJZelfDH7TNj7Gr7U2mKL07AepyHGkjl5Fo+TPnlSCFdmW01eTiLNsIww3Y+aTW8bRcd9xy/4u3Ai2lSJZB3SU8cRyaXGFTi5v3kb1PNMu0NAcOWk0DWtUePdCrQqQoRv2yVgHCkMlKZQRLxGgKMRU6H40/iabU7C/xsAroU5z22qE1dbbDJHS/Jl4VB+3uYeov52h3dellI/ya5LQx8ubzKiLiAMzQxNzRDRQlZZuFt/L1u0SFWvoAlwxTQAIG0nbn53UBqus8QgD9WE5CjB/k926+X4aiY4GTHg0Zxod27dvZUAmEOCLW2EvnJb1obTxg0e45jyolgE72QVPOf8Tr/7arO7yFgh0qSMcZ9wsh1YCudUY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 07:52:06.8692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34712cb3-e0ca-4ba5-176a-08de858c6b01
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC596BECF8
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
	TAGGED_FROM(0.00)[bounces-18385-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.944];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1113C2C78A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dragos Tatulea <dtatulea@nvidia.com>

When 64K pages are used, chunk_size can take the 64K value
which doesn't fit in u16. This results in overflows that
are detected in mlx5e_mpwrq_log_wqe_sz().

Increase the type to u32 to fix this.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/params.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index 9b1a2aed17c3..275f9be53a34 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -8,7 +8,7 @@
 
 struct mlx5e_xsk_param {
 	u16 headroom;
-	u16 chunk_size;
+	u32 chunk_size;
 	bool unaligned;
 };
 
-- 
2.44.0


