Return-Path: <linux-rdma+bounces-11140-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AB8AD3C57
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 17:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C13189B509
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 15:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BC1239E84;
	Tue, 10 Jun 2025 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DgXXn716"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DFA238C11;
	Tue, 10 Jun 2025 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568256; cv=fail; b=jVV0mlzdNDnErOFlTQS5eR1Ts1SrA7MhJeuGCdib+rAZQm0E0damtJSl6GqP8D12uilznMcrA978pje2JTLehFPFzWu7opwIcoN7yQII+wKIlYqZshQFiWD7/bhRjfqwtHI33c+6IL1VYJAsPxTbiWd5ja1ml+DFP2MOWWhffvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568256; c=relaxed/simple;
	bh=MXJCFpQk0ITlb68Z3rITxiHhTNvSNng24lrxHR7pRkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m4AXmP4InzoIXckA/pFhEzTpx2eHBlZDMWksNwoucjMg62Z+ZLy/LFkyOgN/kDWfulj+oW924mGnUojtdE99mwBSyqxAGnrRV0f8CK1H0ta2fHd1AJ7VvbhjssJ0Zm7PPL/SjWLHnU8G3hX6Cd1Y2v9N0xKvCDLjSj79JuWkscs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DgXXn716; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXJK/o3S0nHtcCQ0D9zCkAs/oSr0zl7TCQ4oK7pu20a2y59oOak+MEMRHNjvP9qURKnQcoAIoNjLCYMLMdlZ6M/9YNMv9jVNpMM/J1Xo6qRaEijQVYUc2YWzO/OAWYLa6XEh5dBJ7GnFxD2U75OV4R7L9CNTqpqfJ0Ay2b95whnEuCLoOAAP+2i9yC/FeUNSery4ZpMG1jUHlv8KK98C61/MBjnciU464siyVi28f+Iz8CvAyRqsbbYUrLRMmxDXcuHCgrsaGkQ0P0lvWPcbjyTB3W0xXupK3f94+gahsfKK1rUCjo8qcF/yCaemWrWy6D7L9M2WPP2BvADgLf+Pqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQzZQO1GCTLQNzZAF0PQ2CE0PXGyWMF3kDIh86h9fDY=;
 b=NkI/JRsU4YPeETN6niwbfrdzI3t1ocGn4ehqcw+Lsw9R+IWNZs1yoTJ5VKYr86cdLRYQYIGfwn73LpthWCCiWea4BFDoqrU12xcRFNYzfnUDH7h1RLurBf+rKHrxXpLqeU2U/2p/F/WqFfkFdyNdOxC6ngV9YGxiIMyjhKzxSj+ksjLUGU7HqYVCbM+uSau+V+UHyIbK22f/e8b69DMElhrQ4LJUzYTCFMpzsA+XeMxK/sBc8r81g/MsxU8cNYQTuDURQWlOjoMnDVpEWy7z6+gTrmXVNQPB6jn9hH+avtGjdjHYIONfC2ueShlh+Rfh2wTqy9aLDgGCAvf9PM1OGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQzZQO1GCTLQNzZAF0PQ2CE0PXGyWMF3kDIh86h9fDY=;
 b=DgXXn716qe6t1PV+An0fstbuZFqdD9cAyG5BZx9wFq38oHdC455tsqlD0j2Lusb83DQ06Qw1MBwrQPVCzpmjCh8pJCZ271EzZXWLDE98n9I++IdZs2kftBXJuMxBJ36Zu42pdrHzF+lhJ/cMpMWDBPlcHMviY8R6STY/G/2kC0EThWTaA4vomiwOIH25H3h0dOwNYq25IAmhuwZyqJ3+bnTkClG1qdoh6zAGQSVfPjsk2xmFQ6aM9gImm4usUxXL06+WisFW6ABPCn2l6IZqIEfYchq+1PBvR5XVGeG+treyNrHeS88C+hK7z6n/qqK1DVQzvKoOcPRDreB48aEFLA==
Received: from SJ0PR05CA0142.namprd05.prod.outlook.com (2603:10b6:a03:33d::27)
 by SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.42; Tue, 10 Jun
 2025 15:10:52 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::ac) by SJ0PR05CA0142.outlook.office365.com
 (2603:10b6:a03:33d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.14 via Frontend Transport; Tue,
 10 Jun 2025 15:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:10:51 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:10:29 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:10:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 10
 Jun 2025 08:10:24 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v4 02/11] net: Add skb_can_coalesce for netmem
Date: Tue, 10 Jun 2025 18:09:41 +0300
Message-ID: <20250610150950.1094376-3-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610150950.1094376-1-mbloch@nvidia.com>
References: <20250610150950.1094376-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SJ2PR12MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2b0716-d870-4a96-2eff-08dda830fd0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UzdXUUVdOX/Gq6r7AiErUalMn9SJpIgx14z3GFE+CuA6/et/8b4SHHeRJnRX?=
 =?us-ascii?Q?qrTjmY3logN/wzq1SNccU7IfUvGHTpfRF7P0/95pc6PM45r+HQ+qk98Ligfo?=
 =?us-ascii?Q?SseHrAngV3FAoaqfvVUwDhxMCWjuB1+Wz4AL+JjhJj0AAyKC8nLf+hmBOttp?=
 =?us-ascii?Q?uQtpDufmMUYVQWYa9MdXONcy4WtgFDgkD3m6r7AQv7A1olf9mXIPLJolFdEk?=
 =?us-ascii?Q?PvgLrjayW8h/QOR3b8knQd0EEhSTTF6WrYgYzRvhHpVR3bTfifMGy8UhrY+X?=
 =?us-ascii?Q?tGGvq5j3+pCSaNllVV0+/Sz3w0tWygaMvVB/k9hIVoyINOfjBZRzLbeb3ABz?=
 =?us-ascii?Q?ErpX8HnE4q44zGk4OLGoYXZsN2vK5m/zLP7yCcMZIJ09Oss/qJNWhZNJ8eP7?=
 =?us-ascii?Q?fsj/xywAACaNuEZfgBE34JtXDIIGr/lE1pqS30RQX1j0wKN0MZ+9agVSSvOy?=
 =?us-ascii?Q?uJ4i3DHigYU4UQdnbZqzFHEyVIi8AtEQjhEdLP+xqZ8p4H3l+/iF3tj5u2MC?=
 =?us-ascii?Q?glhiwTaF6tcF3jPY4nb+RRX0QyseoFUb6Q8X+IB7iUnAoXjPdv1JtlGESM4E?=
 =?us-ascii?Q?ogOBrw3f+s2XGq/G+qtaCNa+okNQ3rmf/jYxGv05TfjgM6JWSj7qgGs0IOSm?=
 =?us-ascii?Q?cZs9AbjmsucPIAW2w7QT63P9/qmCyga7pXqd6FsANY5CUU+jWXB5NsvDJzG2?=
 =?us-ascii?Q?v/TmYrkkvMqyEuVwlTVwujE03yz3tdGqI9JQaALpwV7hEozQYmRzq3fFz8M3?=
 =?us-ascii?Q?a3cUwcAkD2/oi49bkFhWRs3HfEEJYCE1Yt70RZuA4DC97CpdM6stSZ2+q+JF?=
 =?us-ascii?Q?wu2xkqhhR7zLSyYZwNx/PjyR5olBd9Qt1XJPPJb8d2pjjsuB8PwD1L30NzPJ?=
 =?us-ascii?Q?OL1nCUKUe4tgUmCgXdCFofUdyFUD0OxpmN28PvBw7wAPXyc67t/lmKM3RhV6?=
 =?us-ascii?Q?c7NIQRZA0w2HtS/YpRvTHMOeOEyKnjQqeE5H9nIrpzRUkLDorL0YoRQjT51Q?=
 =?us-ascii?Q?SkcJZEb3yq0E8V4NhCd0KRXeiDIkdYCwkoZQorDDe0ncP0MV1uar0nS/PwWw?=
 =?us-ascii?Q?LlwwDOO9PRTHiISlqoemFKsvTN13hFddLZC2BdTwtPstrM+3B4wKUmUUHRZu?=
 =?us-ascii?Q?dt+NsvZ8vDfPy2Wp/8wVMqF81/hd3I9HjqAkDsK3OQ7a2Rx63AhEX2AqOg2T?=
 =?us-ascii?Q?ksV6c/kchoYDRbIKjPvbEFKguucXxtzLdtyPgaTK/061zDaIsy/a0MiwOJUp?=
 =?us-ascii?Q?91FmN9yXRFc3F6YbhZD32bD42Sumic85YU8ihBDvro6aWlaBKZi5FrZZAKrx?=
 =?us-ascii?Q?+608ZPFKrf9J+51xfk5rHCwWJ28Scu1VnZfO3nVjOj0UCFu0Lbl6KV7rPuII?=
 =?us-ascii?Q?84A4sapfhYjGCeBfW3xTQvcZMAsXMijcskbHgJ8g46f/vIOZEHHY+G8Xzet6?=
 =?us-ascii?Q?WHGd3ZekF/FHHCKc2oGp7o+IB3ej8LtP5NDYRAnhQs1YCmk4XrMqjdpghBqj?=
 =?us-ascii?Q?2P+OqGIJOLmQoEwH4V3niYmR3Gs3qVzHtdj9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:10:51.2495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2b0716-d870-4a96-2eff-08dda830fd0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7990

From: Dragos Tatulea <dtatulea@nvidia.com>

Allow drivers that have moved over to netmem to do fragment coalescing.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 include/linux/skbuff.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 5520524c93bf..9508968cb300 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3873,20 +3873,26 @@ static inline int __must_check skb_put_padto(struct sk_buff *skb, unsigned int l
 bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i)
 	__must_check;
 
-static inline bool skb_can_coalesce(struct sk_buff *skb, int i,
-				    const struct page *page, int off)
+static inline bool skb_can_coalesce_netmem(struct sk_buff *skb, int i,
+					   netmem_ref netmem, int off)
 {
 	if (skb_zcopy(skb))
 		return false;
 	if (i) {
 		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i - 1];
 
-		return page == skb_frag_page(frag) &&
+		return netmem == skb_frag_netmem(frag) &&
 		       off == skb_frag_off(frag) + skb_frag_size(frag);
 	}
 	return false;
 }
 
+static inline bool skb_can_coalesce(struct sk_buff *skb, int i,
+				    const struct page *page, int off)
+{
+	return skb_can_coalesce_netmem(skb, i, page_to_netmem(page), off);
+}
+
 static inline int __skb_linearize(struct sk_buff *skb)
 {
 	return __pskb_pull_tail(skb, skb->data_len) ? 0 : -ENOMEM;
-- 
2.34.1


