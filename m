Return-Path: <linux-rdma+bounces-18973-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IXVFbqFz2mwwwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18973-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 11:17:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CE0392B07
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 11:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BD2130AD495
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Apr 2026 09:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05F038A714;
	Fri,  3 Apr 2026 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fm8rwp7S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE857351C21;
	Fri,  3 Apr 2026 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775207449; cv=fail; b=k2Tzu6dB63aIGA3RzbnS9rFvqBa2ynuWc9imetSQYiWuZc9h6D9uDYw5rzNooBFEt29+gCFGJ/XWzTzumsXrKRM/WUd3ZTXcttdYIgM8TIAVfOG+k2/bOzbnk00F3jThObYXwI6w5DUb0gVEVq3p5OPs0eSv1tD65hoPwPz96SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775207449; c=relaxed/simple;
	bh=DiDHpdTHm/BYrHf6Cj51NhcuRjO8KXsvHnP4vYV/ej4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ooh3Ek6RuilJhyeUNpFsSnMXe5Z2g09YoyNuOPjz9/8r0zCVPrj1xGXTt6W9y5LiH2ZJMDTE+f5B3wmBj7XNDSNqMxSnpryOMuvdXxLcGLKpLPf9dZJHYNCwwplOU/nCXzH+/kk/6xWiYPggNU6Z6znjdYcap4RLF9a1uJpLGsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fm8rwp7S; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TI9sQgxy4IWEG4AIiagWKrp425SDpMVZt9YgClFwwXE1iFuVw8K4brwagPjVU4W0fwFQkQ4atBXkSa1ARPQ6He1Ot7FFEYaL77XJE7iFUDqz2tswozBb9ERvJVYel7YurQqvSf2RnFDEKRvamYJknShyg8up7SUqedBqm2DhepyCzcXnRTk65pyY0j6PKls3Al2EsHLVfyNuIgRianzEum+ZoQjZLk+CskS18PZfjaf+UcQVTo4M6kCuF99eKxJi1oIlPq5+KIZaqswg0WMSWel41o8qAe0aH1rGtSnZxpGSDk3eSjWQgK5U7TmPyHrXL5y9ti+7LYctLvlxoakm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjPQOkDPNFinRoafb4bbU9OO4pI5RQDua91dDrBRxLY=;
 b=frrRn3S2mhMtoyJic61blNgv4A4VSUJaMLkTybsg994ozur0MUTYKptRawyWzVt3YTt+jcjOcNYRKwYwvBtKg6r6i/q05tywMEStY0xR+cqML8j283upZnfTSJ+NoaB6ITYAEkerAajAhOGY2RhY30/I065r43VBpt6MEu0fB9cAg/A5746sEZiVn8LQrHCk71jgqPPma1XX0Gck95LZPoGy6O8KakmZqJgommXrHdu2g7/WqjjKpa2MvuCVs2BrTfZDsj8CwrIoeft99jGrDkVCjTfFAV3L0rCKzcImU36WH+01hUmUFxR7U+rEMxoivOqLGyEihu5q+jgyWG+1rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjPQOkDPNFinRoafb4bbU9OO4pI5RQDua91dDrBRxLY=;
 b=fm8rwp7S8bvHrVuOad0OJJyRplcbdV8WZoJ1ZAeJ83erhDqVzDz8YTWy4MUhOXeFMofS21nnHJe1wsaDIJHDQEAQc2yjYurPpltThtHp45QAa5RRTq928ANgzROCNNOFoXpQsK3rLwuJyahhtqeoiu+pl1L1I7ABKvIceZgvMeKWrsjVIhOUfrtgfPzbwZdMEMiBpql2wEV4jFvIptO2zqRb7YhfE/Vr/PuPOb07Yhey1qu6P3amGYalTnB0+y9oYawhiN7ssFNuLsHYYtqJMCGGFuRT/MfeQEfYYm+GV++Y/t9UE1GJrv26zCIXbLVFNVq73Kg+gXK/AgSCng73pw==
Received: from SJ0PR13CA0023.namprd13.prod.outlook.com (2603:10b6:a03:2c0::28)
 by SJ2PR12MB7848.namprd12.prod.outlook.com (2603:10b6:a03:4ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Fri, 3 Apr
 2026 09:10:42 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::64) by SJ0PR13CA0023.outlook.office365.com
 (2603:10b6:a03:2c0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Fri,
 3 Apr 2026 09:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 3 Apr 2026 09:10:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 02:10:25 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 02:10:25 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 3 Apr
 2026 02:10:18 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Dragos
 Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Simon Horman
	<horms@kernel.org>, "Jacob Keller" <jacob.e.keller@intel.com>, Lama Kayal
	<lkayal@nvidia.com>, "Michal Swiatkowski"
	<michal.swiatkowski@linux.intel.com>, Carolina Jubran <cjubran@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>, Daniel Zahka <daniel.zahka@gmail.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, "Raed Salem" <raeds@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next V2 3/5] net/mlx5e: XDP, Remove stride size limitation
Date: Fri, 3 Apr 2026 12:09:25 +0300
Message-ID: <20260403090927.139042-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260403090927.139042-1-tariqt@nvidia.com>
References: <20260403090927.139042-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|SJ2PR12MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad12e53-1087-4ed2-74d9-08de9160e1bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qLDjDfKlrRDKlxPK3KJceVA1ABpwIgypy4n3kR3nGbuRAoKA311C11TcgRDWLA1v6z2oa4GcnWSG0eZ0o1WsLNDJM2fjMkjItKz7C65f/kiC24efk8GHbG2+kHOReYHGOtk7pPamHsEwD4NU1+D8lcfwRoj57f+SeBkugfekZ2VEEVLNk7G3CBWNfl9MKijPHKSl6gmkDNn1vQuBH45DIkrXd/CQ9aZ3pduOtoino+QkEAqFaRGBSpOyyyTXmMNRpvzksJWectTdcuzr1CHpXifddqlmMmRm9dimUV7Ou+/rrPEptYkU3etqLAK7kg0W0LWWxW1i6XY+SNss7Ik0rPmpf7frMOf2xj9u28qKo2549rfIcnScL4Ttgn3JkxusalKCtayBGapm37WDTKzbDLcFEv9Xi4d2IbROu4HSS0Lp7yZmVeGVfcLZRolaAaKqYdZNNJlwgdUzPSMDMoB3LClQSIOiiTTFtiSqavlhK3zkW1xjCVGSIPAimxaVjnZO4As4nc6YJsZ1SZc5WGthwC2nVnZBACvDpRKDYjVkXWG2ATWozRDbQKYrZM2s28cPJf7taKd4f399U+onY/EmVzUtDlXSf0kMisyRs6zMFSBaj1Z9Cp5rXUWc/yl9DQWIn4fVgeE4R5txewTu51rFdXqr3OttjjNjF/5bbPPrTgffaECfuWIdo9GMmuP61ois2JG6n26dkQyAbCPqGKArxwKVfHaCrgFdqwRBLXhuo5YrjKqRYYR+l05j8YYFnJfM6+ijXA3WQI8jAAvdPweRjg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pN8fdz8XztV0geeSMdtIesTuXrQdRVyJVwA/WLAuvLJO7Ai7ET9EU1Bo/AEEhKIBA4ZFgyJg0vn278SFvLoNR9YNljrwKrc0gS7JHOHna9qPCmp/wWRTltu0UwkmM22+UfM8W3wqYMQqjIw5PGcnFDA701pvMBuXwVHzySKzCPUKCRX0ayMt0K3zWzX0SyZUnIo3sfBVY5jSxamO5S4F3NU2JrQnaPEFvQ2tddLivzNkd/7Vz1W1/BV69WxB285dEq3vuqe4N+exQDaVmf48ZkGJCjtSNSrdPOd0CBOZCeANfNdsrfJvBDa4rjW8jVAhYzs05lr4S+fL3OepQ9tHGWyAwVQxHVsWg5aD/cA5si7dnL6ddG3QMBmVOeSzi1uJQIJZcCcmHffOLhCzM5+hP5tEFdmP3sChe15F9icyzQ/JiVvGw8v7ii2+hXjKScmB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 09:10:42.1939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad12e53-1087-4ed2-74d9-08de9160e1bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7848
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
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,intel.com,linux.intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18973-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A9CE0392B07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dragos Tatulea <dtatulea@nvidia.com>

Currently XDP mode always uses PAGE_SIZE strides. This limitation
existed because page fragment counting was not implemented when XDP was
added. Furthermore, due to this limitation there were other issues as
well on system with larger pages (e.g. 64K):

- XDP for Striding RQ was effectively disabled on such systems.

- Legacy RQ allows the configuration but uses a fixed scheme of one XDP
  buffer per page which is inefficient.

As fragment counting was added during the driver conversion to
page_pool and the support for XDP multi-buffer, it is now possible
to remove this stride size limitation. This patch does just that.

Now it is possible to use XDP on systems with higher page sizes (e.g.
64K):

- For Striding RQ, loading the program is no longer blocked.
  Although a 64K page can fit any packet, MTUs that result in
  stride > 8K will still make the RQ in non-linear mode. That's
  because the HW doesn't support a higher than 8K stride.

- For Legacy RQ, the stride size was PAGE_SIZE which was very
  inefficient. Now the stride size will be calculated relative to MTU.
  Legacy RQ will always be in linear mode for larger system pages.

  This can be observed with an XDP_DROP test [1] when running
  in Legacy RQ mode on a ARM Neoverse-N1 system with a 64K
  page size:
  +-----------------------------------------------+
  | MTU  | baseline   | this change | improvement |
  |------+------------+-------------+-------------|
  | 1500 | 15.55 Mpps | 18.99 Mpps  | 22.0 %      |
  | 9000 | 15.53 Mpps | 18.24 Mpps  | 17.5 %      |
  +-----------------------------------------------+

There are performance benefits for Striding RQ mode as well:

- Striding RQ non-linear mode now uses 256B strides, just like
  non-XDP mode.

- Striding RQ linear mode can now fit a number of XDP buffers per page
  that is relative to the MTU size. That means that on 4K page systems
  and a small enough MTU, 2 XDP buffers can fit in one page.

The above benefits for Striding RQ can be observed with an
XDP_DROP test [1] when running on a 4K page x86_64 system
(Intel Xeon Platinum 8580):
  +-----------------------------------------------+
  | MTU  | baseline   | this change | improvement |
  |------+------------+-------------+-------------|
  | 1000 | 28.36 Mpps | 33.98 Mpps  | 19.82 %     |
  | 9000 | 20.76 Mpps | 26.30 Mpps  | 26.70 %     |
  +-----------------------------------------------+

[1] Test description:
- xdp-bench with XDP_DROP
- RX: single queue
- TX: sends 64B packets to saturate CPU on RX side

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 26bb31c56e45..1f4a547917ba 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -298,12 +298,9 @@ static u32 mlx5e_rx_get_linear_stride_sz(struct mlx5_core_dev *mdev,
 	 * no_head_tail_room should be set in the case of XDP with Striding RQ
 	 * when SKB is not linear. This is because another page is allocated for the linear part.
 	 */
-	sz = roundup_pow_of_two(mlx5e_rx_get_linear_sz_skb(params, no_head_tail_room));
+	sz = mlx5e_rx_get_linear_sz_skb(params, no_head_tail_room);
 
-	/* XDP in mlx5e doesn't support multiple packets per page.
-	 * Do not assume sz <= PAGE_SIZE if params->xdp_prog is set.
-	 */
-	return params->xdp_prog && sz < PAGE_SIZE ? PAGE_SIZE : sz;
+	return roundup_pow_of_two(sz);
 }
 
 static u8 mlx5e_mpwqe_log_pkts_per_wqe(struct mlx5_core_dev *mdev,
@@ -453,10 +450,6 @@ u8 mlx5e_mpwqe_get_log_stride_size(struct mlx5_core_dev *mdev,
 		return order_base_2(mlx5e_rx_get_linear_stride_sz(mdev, params,
 								  rqo, true));
 
-	/* XDP in mlx5e doesn't support multiple packets per page. */
-	if (params->xdp_prog)
-		return PAGE_SHIFT;
-
 	return MLX5_MPWRQ_DEF_LOG_STRIDE_SZ(mdev);
 }
 
-- 
2.44.0


