Return-Path: <linux-rdma+bounces-20124-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL2cJYRi/GkZPgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20124-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 11:59:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 396444E6620
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 11:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 923B330924F5
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 09:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A5F3C65FF;
	Thu,  7 May 2026 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="itK/VnQ3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B556361656;
	Thu,  7 May 2026 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778147656; cv=fail; b=plKwF6GNxeQvRh2556KOYVGSdF9wmRSYWeEf+/gffVtYl4bw0qgO73JNKiYTJGBWlGHcZtSV4iSW//BHuA72LohRFstjNEAyTwqWpvxrEb0g400zror8m4YZynOvqOp8CpqCyCo6lYoRvNhwB+MC/0+wuy8jXPuAncE3EVBQFIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778147656; c=relaxed/simple;
	bh=/2hPXRNsfo/DhvCkgModNki5gh4DZjS3tO2sD3YLFd4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WuQzvhvtYT2LlVEJNWazv4/J0n29S4Yxp6BGD9mMMQ3bL4NYb17DkUYJggebNDyoHSDBAzQFNh8is0V6XP+XoYnoKVHa8t5OEVrrSM+sNovLGGGhpSmKftylAXR6lcw8jpU7hH/aH3j5JwpytrLevY0pWYJcCEjDeUQ6QwUGQcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=itK/VnQ3; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6svys2qR3sV9XD2JYsOWzIzZK7qGC+OqjRpBgW2nr3JSuH7BTPMWMkpSyzZ9uzkSWGuJis1FG1gNIJRuxAvfK+Nkrn7nyC8FNDwEDbOHxA86L82aU84q5MGwF/nnA62tm7rJOSwokEzsEFkWG1wARdsU5vpYdTVUg3e2CSdkqs6QPQJWZ7sq6e59XV8f9A5DuO8gDYnHKZsfVItccVq/vu/XZz1jgSdpqsS4M1Nc+YFYcCpMxpTcdRcGhbdlL6xD4CRi682LZuFhocXk5VvW0bwUTdZAiTM4piprpU5IK9nJiEaHL3u1FSaOrl4lsyus+jGHYC/SAp0BrphTY/gsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0H2/xeFkMvfGfr8yNoJWDRlDHIeT7sbWAx30ginr3w=;
 b=FLli9IXQ7n16eN7FfpGjcgMRdvXUb72WCxNN/TvcazfugunzMTm7kLBigiSZiVW45pwKF3Q+eyMrJIwKBv9RShpO9CaRmekYh2tH577nsbYlwfOwUi79nq6g9FMNanP1zGDtZBxbKgHLLAo/ZY/mLCXkOfiTDn0URgwt0vo3EukJLzl1Y8DsXVz7UeLaAW+P4sEcmYJE3iPAUB2+IdtNAs8pjAo5JHjb2LpomzTzZ4BWoESAGkvlONqcIa6rlqLRdz2XwAHWLKeNJuXnApG0aGMz/UzALUhFtM7AXJUL7Fn/NstJxPBQYmdIOw53TXbyQqfjU8ENNJT6rGc4MwG+vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=openai.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0H2/xeFkMvfGfr8yNoJWDRlDHIeT7sbWAx30ginr3w=;
 b=itK/VnQ30YsyY1JECfzJrkFYvNNwub/mtPCwiIIeNswBv56HaFw8p2PVW2ePQZtmHx8isZEOacdkhRvthIrBQ8wuGn3awovfjJM4jROZqkUWO1iRrGEvvX3W7JVhDrwV+eC73DYzFc7mmGfeX/JnUynn4Tl+bOz2CxvqjVq16WHUm28NGrwORFWo5VxsmC8MM791+m7WLc1dPsDx0dSDOCoNYZlpDGAyg1137/aj/IWvBZqRtzXdrizpIP++c+dgMYqQz6tiS2p4I50+Up+aF/IHSIkOv9mX2zXsbvzH4YFMbywBFRjkdRUT9Y2PUx/UoLAfhcNjw0kPYt4gR4m7fQ==
Received: from MN2PR16CA0063.namprd16.prod.outlook.com (2603:10b6:208:234::32)
 by CY1PR12MB9676.namprd12.prod.outlook.com (2603:10b6:930:104::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 09:54:11 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::e7) by MN2PR16CA0063.outlook.office365.com
 (2603:10b6:208:234::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.18 via Frontend Transport; Thu,
 7 May 2026 09:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 09:54:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 02:54:00 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 7 May 2026 02:53:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 7 May 2026 02:53:55 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Christoph Paasch <cpaasch@openai.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Amery Hung
	<ameryhung@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH net-next V6 0/3] net/mlx5: Avoid payload in skb's linear part for better GRO-processing
Date: Thu, 7 May 2026 12:53:27 +0300
Message-ID: <20260507095330.318892-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|CY1PR12MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ef95d6-f8bd-4e76-49a2-08deac1e972a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	yt97CYxIJsLCfVCELsU+moO3g6kz0oxzm1UNTGZ4SK17HI8Qs8JoAWzeDTuY5yVDka5mkU53bNZ7h60BPbdQzG8qX0fWGzvm9p9nw6vPlbzrYH7tIMBshSD4IC0uaS2LspPUr/Ca1AgpRnjA+MXdF4cFbOEj5iuNw6M/3zGWV3uLS9cm5CbC2qj+whg41zkzOMnfa8kHce27sFzqCFnbi7LMXiPXgI16SytcMacEx2AKt5BA/BAbdfp/cLGDtyUUGRgVpSq3H9YV6pKKzNSth5MN6MQCParaZqz4emEAM9w4OfBGjeC0dU4Swtmfo/yqJlu4h+Jl88Gsd95WNeTHXkFEgpmgAjgO28prZsIhzCY6I+2/h/xIKtpin6cztT5of+yHywKSlRxNHP73lbU3SfrZqRuuiAcMnu1JBLLICtu7u0qyvVodZFyWKWnL//6ndp0A15qlKdurkjPRvTbemIR97ERLYuYWyF6Lt0C1PsMDkuLWQDMT1GRCi1qXbxtNItk3GfmeMP/ru1KMvaGYPLHtLIcu0dua1mqfZ9SKlTIWxEWBABxsU8KJ/1KcnxYS291uP7Un5K17YUbCuuoXygTL8nrg+jz8r+Wh06mti2QJoIUxnojJzwGv7E9pF6I1Z4T2viGuLzk3BSK6xAg9JpkCT5StKybz1cpX8nS/MYDW8oWhR0G41cbmHAqSyBC88byvTHPqBKQg5OIDMAfskK2SFwxBsibcMUiOKB4FREE=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wAmQAW7T0jfsylZljQY4Z/lW6F6SBFQFMa/e4XBzcSkeQr9akSFgJ3IEfj7rJ3vQpFR+97AKiL2yjqpREQi/FW6e8qrhurrlZcE3qXHOLLccwRImgjjyj4DpMn4h9mG2A6kMUsbyxqoOvr290XBN199GpwDJE1H3K4abyMhd1Ng2owK/TFZOsM99Zo+SfFV/kT4DwlZ/UZy5py7+M5FTaAPrYgwheG4tnlVMHiTDqHe92LOT1CbdMpyumPSjrxI130AOgnTeBkck5SFdcpsYGFurdaT9iQ7y2ziMSSIGfEisqJDNLYc+pK8pndQfOhSU6eUIwAhvOKMAf0U8xDht6GXIO5uw5yKupxT/BnIhaoOvyp9zrhtzf91x2k/cP3CXSgc6AbUXKGWBbYJrdkw247gfxtpQw7oK2tXQpiQtIrn0+f8Yllh3b3Cp5foW48vq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:54:11.6560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ef95d6-f8bd-4e76-49a2-08deac1e972a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9676
X-Rspamd-Queue-Id: 396444E6620
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
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20124-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Hi,

This is V6 of a series originally submitted by Christoph.

When LRO is enabled on the MLX, mlx5e_skb_from_cqe_mpwrq_nonlinear
copies parts of the payload to the linear part of the skb.

This triggers suboptimal processing in GRO, causing slow throughput.

This patch series addresses this by using eth_get_headlen to compute the
size of the protocol headers and only copy those bits. This results in a
significant throughput improvement (detailed results in the specific
patch).

Regards,
Tariq

---

V6:
- Rebase after Amery's changes.
- Address Amery's concern about header length after XDP pull.
- Add a small optimization to memcpy the header length aligned to cache
  line.

V5: https://lore.kernel.org/all/20250904-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v5-0-ea492f7b11ac@openai.com/


Christoph Paasch (2):
  net/mlx5e: DMA-sync earlier in mlx5e_skb_from_cqe_mpwrq_nonlinear
  net/mlx5e: Avoid copying payload to the skb's linear part

Dragos Tatulea (1):
  net/mlx5e: Align header copy to cache line for Striding RQ non-linear

 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 31 +++++++++++++------
 1 file changed, 22 insertions(+), 9 deletions(-)


base-commit: dacf281771a9aed1a723b196120a0de8637910b9
-- 
2.44.0


