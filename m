Return-Path: <linux-rdma+bounces-6173-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 461EB9DF545
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Dec 2024 11:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068ED28123A
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Dec 2024 10:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87ED13B7AE;
	Sun,  1 Dec 2024 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ju7jO10U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D713E13959D;
	Sun,  1 Dec 2024 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733049510; cv=fail; b=mSRoeP8SNhk6gxZZqWeMCygkumvCEi0jxqJ9pd5SnFSRr5/KvHyOoOCLSSM7ij82YuKllsPX4+yaT+TkhA0bfetNoeJAhPJnnvKW1nCLMV9b8ISzGbYBk+JiulrLU1/zMvadmjWKU5ns0PkI/21x1wfWaHvlnL0Ckjenpt9V1NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733049510; c=relaxed/simple;
	bh=lWVtCoQ0kc8ESYbg8Ni7tONY0GPRduSl2cyqJ0wfWMg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJ79mc6SeNfbk/zJ/NEvylvX8zm0n4KAXN2WvSYq07p8sZLXXjebX0CTRTvPsgn4bnpmUszHxvO1nRvfh9JWxU6zs4EM3XPAC/vcRzAmAozeAftX/rGuIhZUW5rUs+c+43Lk6rE8eNRoxxb8Rb8L0mK8e2w85NBFwBeGieD9gvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ju7jO10U; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9dML4BQOGhYdlULdXPLescpYREcpwyP+gI/Wqk0F6LKybELoTDPCeEDJlkUGFWj5+/IS4Xa9/yJtzYxjuGB4U+NaydsT2MbO25AwO9waKrdw9ug1/N2XHvaSt2hK1WKog9EvwYXZF/9taAIuCu+3n4EeK8VCzIxiqxWOvcxVsQ31TBEuUo1ahoCPokigqWIgeYzqta3Xkw9HPI2iK4q6Hf6AAcuZSz8Kuc8qnROywGUJlUJtdUX2Lnvc1ImmVQQEjRzmEWEJvrylnN90PtxNwi+euwSh6bVHdMmiK+8HbcLGDp8g2S3uifP5DgbKdPrZaLe6OWNoQ5LJxzyt0LDxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5lebes+3vCSQ2c73btKjDroQu3/xg9vnF+gZ5x1ies=;
 b=qcNa8aQa4F2oo5STzR1V7B/QrCRj5jkxPnY9cHCsXZIEo2Hz/zP8OwMJn6m/OVTlvHDuNkewhj/KzT0kc4njdyCJjNOceDhrIKwO+1Ndlg8olaSijZUX/I19kZR3apfQBWjKMeyUg6dGTb5cxYzgojahBbCPnTYD12yWZnyYMyHYe9jwhHzirYD+nzzo9vErE83xdJ8WkXMxZD2aSiaOOH7MnfSwT/G7vSlQAcF6wsyAy9m+Bf8k1vw8JVCgj4bG5vOfPqPaTKE6XDm5qqMWpxzNgRw8JPrnihov+ZlHHYvUx+ebvthWgB/cvl9BDWp2zYVpnQb4Ia4xbNhpBq3C8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5lebes+3vCSQ2c73btKjDroQu3/xg9vnF+gZ5x1ies=;
 b=ju7jO10U7pE96ufbXoZ9BffptrFQJEnU/yIKGbzekfWQA7tUaOjvIzMzOd6n3MszQP4AZG3XqgFwqpusZKXuZQnRVV/qwygsNLb/rCz/eaYa5Jm/AYHHDH0dA28b2i2DrKQbJluSnkXAxE6D83WjoRcV10iaa0wILDKTMsWgVH1mm0wf31YWC28kSHdiekYheRv2+0/kIU8NBCQYq6UMFW4YMC+fbJ9Og/fSGugfw0hSCsoSXQ6kzNzwBXfu5P+xwABhtQeh1lSCvYQ1kZvDJb2itSJ04BEjEQhmIyEd7NvkgeVyXcVGjgTrz8DgmUyUw6BXJ2uXVf1mGqrsk4OW4g==
Received: from BN1PR10CA0010.namprd10.prod.outlook.com (2603:10b6:408:e0::15)
 by IA1PR12MB9524.namprd12.prod.outlook.com (2603:10b6:208:596::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Sun, 1 Dec
 2024 10:38:24 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:408:e0:cafe::cf) by BN1PR10CA0010.outlook.office365.com
 (2603:10b6:408:e0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Sun,
 1 Dec 2024 10:38:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Sun, 1 Dec 2024 10:38:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Dec 2024
 02:38:11 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 1 Dec 2024 02:38:11 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 1 Dec
 2024 02:38:07 -0800
From: Yonatan Maman <ymaman@nvidia.com>
To: <kherbst@redhat.com>, <lyude@redhat.com>, <dakr@redhat.com>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <jgg@ziepe.ca>, <leon@kernel.org>,
	<jglisse@redhat.com>, <akpm@linux-foundation.org>, <Ymaman@Nvidia.com>,
	<GalShalom@Nvidia.com>, <dri-devel@lists.freedesktop.org>,
	<nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-tegra@vger.kernel.org>
Subject: [RFC 4/5] RDMA/mlx5: Add fallback for P2P DMA errors
Date: Sun, 1 Dec 2024 12:36:58 +0200
Message-ID: <20241201103659.420677-5-ymaman@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241201103659.420677-1-ymaman@nvidia.com>
References: <20241201103659.420677-1-ymaman@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|IA1PR12MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 1202fbe9-9a6b-47be-1980-08dd11f4485a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lggH5GV1eeXpGR81zJS92Pi/2C8pUZROuRntiu1vQfJEBRAw3t/d7cOMJ0dF?=
 =?us-ascii?Q?iaSe/wiolGsxLqWdglPM64sJb8lJafSxRJmuEHmAPqlgR/S8ii/nCy0xcRFN?=
 =?us-ascii?Q?1M6w6QQTESz5EOuYW+N38n5l07E8kXcLzd0ZPA8RzSL4dVJLgKdJe/g6+GRo?=
 =?us-ascii?Q?mHajRSlDM32RmesXrsU+nsWQhrWCMIXIwzG7hTX+lSbSpgLebt5KhrFVgqPB?=
 =?us-ascii?Q?JqswdCo73IRWb8bGb51nww/JrSmYrbgQOc4Z3uExNRxG+OqQb23jRDv4UypQ?=
 =?us-ascii?Q?G/19zZ8prTBhgcZPgQNKQKeyHNMGftOY/kFtg6eNzTEv229vSkH72fehR9Ep?=
 =?us-ascii?Q?B8OB9XfU0UyAq3BCvMVRN6g7RLLyAoHTjbjHT+NCNkj7nS8AwLg/z/t+je3c?=
 =?us-ascii?Q?O3EXmjqI4/OSIhKkjlCpaTYY3wjLUmkhS9TLVTr2JTZxHPsX07jOhtXycUyC?=
 =?us-ascii?Q?vT+GWso8NosLDyJFrEtMB5wXXO4ZKBirZqhgkFi6rkD2HdGipL3ZKo3WVKrx?=
 =?us-ascii?Q?4t/8jjimHlNcYhapu9N8+Gldp/Z80B7HnXydjSKtSGwvSesQ2d4hRMrWvBpz?=
 =?us-ascii?Q?A8ziv1xak0LmkmPHud8kaOo4cRtX6Gm3+HtWTB9mDvMz8+2JDdjOggeyHAJG?=
 =?us-ascii?Q?65L3PAFCszfuOrj/8kTblGvzTUmFTD6wst5Iwd/5D7DFaTrLfl6RlvKcRzoV?=
 =?us-ascii?Q?/xfOzZnx0XjBDLKQyT9wclE3InYCDYe0hP7W3qEhRi83uU3UbKVmOeyAIQ5a?=
 =?us-ascii?Q?mrjulxusEzdSqkiTzdaudxBxc2xfKpB8Gglc+1zyPwaglvUQ+iZWif1Lu+cJ?=
 =?us-ascii?Q?7dp4DwUw3Ql2lr7QzRcSrzjBB3eLntCe/DcXE9luBYSgs1Hw89/peG0vyzdt?=
 =?us-ascii?Q?k8YUQmz8RewPIje59VaTmGPeZ988Vr2c56UlwOq6FLn9VWNDdUa14zawVzQt?=
 =?us-ascii?Q?s/AHPW52nvTbhn6iM+0uSPTm6zTogPOm3vnsY0V38Ru/u9I7oVw7EWXp2wPf?=
 =?us-ascii?Q?2i5plvYe5b+A2u69lDzB8NGufVMW2jQVO2FllhMlI8r34kSlCdj8hLE52Ve7?=
 =?us-ascii?Q?b+XDp8EOFtzri3578SIXZkk/h7q7YjX5xSru3h2rUCVZVIh8K9Q0fTdP1LBb?=
 =?us-ascii?Q?Cxop+WQQlF8aM98kF9yzO7Udo8y5+pwirapeR6zgmKMFhyxCYVPAt3spcTEW?=
 =?us-ascii?Q?0RTbFm3rjsFk655rqqeRizK7YfWTQeRUK10IIowqTteabWEDjRb6gFBSOZTM?=
 =?us-ascii?Q?qfgMLbEJmoHPqlgMi0N7hhQAI3700M5/Not7Z4L/492r8pjKjgZ+x1TtGFqu?=
 =?us-ascii?Q?ImlPsauUghTqzD2gUw1MqTY492ZbuGWEd6f0KejAIIhvnayXdt+XKIC+NoJx?=
 =?us-ascii?Q?sImmyOvL9IxgeMcgEkrTAhCLBORCwmxLCwddg9ChHTuJaqcIo408nTo7luyI?=
 =?us-ascii?Q?nTwrj5YWhcY5A0NLm3ISxlXoZ26CXr3qoEpSOSNgxLTm+dcLImT/cA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2024 10:38:23.8003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1202fbe9-9a6b-47be-1980-08dd11f4485a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9524

From: Yonatan Maman <Ymaman@Nvidia.com>

Handle P2P DMA mapping errors when the transaction requires traversing
an inaccessible host bridge that is not in the allowlist:

- In `populate_mtt`, if a P2P mapping fails, the `HMM_PFN_ALLOW_P2P` flag
  is cleared only for the PFNs that returned a mapping error.

- In `pagefault_real_mr`, if a P2P mapping error occurs, the mapping is
  retried with the `HMM_PFN_ALLOW_P2P` flag only for the PFNs that didn't
  fail, ensuring a fallback to standard DMA(host memory) for the rest,
if possible.

Signed-off-by: Yonatan Maman <Ymaman@Nvidia.com>
Signed-off-by: Gal Shalom <GalShalom@Nvidia.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index fbb2a5670c32..f7a1291ec7d1 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -169,6 +169,7 @@ static int populate_mtt(__be64 *pas, size_t start, size_t nentries,
 	struct pci_p2pdma_map_state p2pdma_state = {};
 	struct ib_device *dev = odp->umem.ibdev;
 	size_t i;
+	int ret = 0;
 
 	if (flags & MLX5_IB_UPD_XLT_ZAP)
 		return 0;
@@ -184,8 +185,11 @@ static int populate_mtt(__be64 *pas, size_t start, size_t nentries,
 
 		dma_addr = hmm_dma_map_pfn(dev->dma_device, &odp->map,
 					   start + i, &p2pdma_state);
-		if (ib_dma_mapping_error(dev, dma_addr))
-			return -EFAULT;
+		if (ib_dma_mapping_error(dev, dma_addr)) {
+			odp->map.pfn_list[start + i] &= ~(HMM_PFN_ALLOW_P2P);
+			ret = -EFAULT;
+			continue;
+		}
 
 		dma_addr |= MLX5_IB_MTT_READ;
 		if ((pfn & HMM_PFN_WRITE) && !downgrade)
@@ -194,7 +198,7 @@ static int populate_mtt(__be64 *pas, size_t start, size_t nentries,
 		pas[i] = cpu_to_be64(dma_addr);
 		odp->npages++;
 	}
-	return 0;
+	return ret;
 }
 
 int mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t nentries,
@@ -696,6 +700,10 @@ static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 	if (odp->umem.writable && !downgrade)
 		access_mask |= HMM_PFN_WRITE;
 
+	/*
+	 * try fault with HMM_PFN_ALLOW_P2P flag
+	 */
+	access_mask |= HMM_PFN_ALLOW_P2P;
 	np = ib_umem_odp_map_dma_and_lock(odp, user_va, bcnt, access_mask, fault);
 	if (np < 0)
 		return np;
@@ -705,6 +713,16 @@ static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 	 * ib_umem_odp_map_dma_and_lock already checks this.
 	 */
 	ret = mlx5r_umr_update_xlt(mr, start_idx, np, page_shift, xlt_flags);
+	if (ret == -EFAULT) {
+		/*
+		 * Indicate P2P Mapping Error, retry with no HMM_PFN_ALLOW_P2P
+		 */
+		access_mask &= ~HMM_PFN_ALLOW_P2P;
+		np = ib_umem_odp_map_dma_and_lock(odp, user_va, bcnt, access_mask, fault);
+		if (np < 0)
+			return np;
+		ret = mlx5r_umr_update_xlt(mr, start_idx, np, page_shift, xlt_flags);
+	}
 	mutex_unlock(&odp->umem_mutex);
 
 	if (ret < 0) {
-- 
2.34.1


