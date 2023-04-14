Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4431F6E24E9
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Apr 2023 15:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDNN6j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Apr 2023 09:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjDNN6i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Apr 2023 09:58:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41A6BB
        for <linux-rdma@vger.kernel.org>; Fri, 14 Apr 2023 06:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgQ/AMCxe2umgBPUbn/3YcxMOx2tWnqmn8LdtK2e+vYMWlYew9RR5xR9laEBM5cN1vC3qjA59vHSmLKl5wE0gVD1O9CRsL+xdB0WCqm6x/YVvUly3Ub4FqJAnkWkG3kYN1YaqDx5LEaMjA+V0a1SL5HgZJCTRykM6fQCNV25NpMpqWkaOoA+ek8XaxJ9yfAmpWTPRnZCZDdmgPqNmYBILnXRhFjGf269vPbGFkW3UrT1MjfsBCCYfVgakfWO1e5RALF4jCXSZSUyuuK1kWJOKeaeO0zSYnub0NuzR6HhBS0Vyy+7yGT92Jsc2zGv/sbWh8LAoCSHGvp33557qWD1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIb94Kw7UA7qFXE1AY5mN0KChutRNIscp4VgkLlr6HU=;
 b=YeiJFZjaAr2CndBqBvUvK4DhBJO7gkPsC4y8ILUlpvYPTg5/C9kZn8KuxY7ENRI/PtE+LK8zVi7jUuqOR2wtAbIfNBPa3wRU4EiDmEBY7V53pt3NokZlvQYtkaF77FRD4guuduMV/0NabfA2OzvTmr/WBfdrZ7f2SrCtJh8ksG7feWK00keHjepqu4DyMmdwBO7dipVCQBjFi+rySQUYF28ZDiqnWIH7J8eIX0079KLSds1pasBTY6CcKoEqy3DxUYXhKaTyUY7oHVwphXOc0N3d+2IOxWHq/IVc13syNlZvW5nNFYPtgwt42MPpluPp/BhgfWWVJBZ2DI6NtY/9Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIb94Kw7UA7qFXE1AY5mN0KChutRNIscp4VgkLlr6HU=;
 b=GnJn/4f9J23+Bj0FvlCpfkmk5MrdiEp+TbPqotK6K2xRmEBYoaH9dWWcdOK2hYc4hHXPnFGZpTurCuSRB5cvnbs5IV2uf6g4P8e7IALNeEBAVCo+1riuFwM4qYL80h2lSUOlyDGtK/pQf4rAnHrAVw3ZLdpjUvCtwvyLNHTA5ErJGa1U92MY2yvBtbToNOBeyrPN67FsCCLHNsKr4ZyKoB9vaCAnW+w7CeVRIXcUwmCAt83MVn0WcSDdF2NLSe64PwAYrfnE4V4+c3eiJnxQllyTBKbLwSxeQo52hvwr4/ZrnTvVj+BhjxR4IctdSGsO/X2QzYRlSes4rzXKvFbM/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 13:58:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 13:58:33 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2] RDMA: Add ib_virt_dma_to_page()
Date:   Fri, 14 Apr 2023 10:58:29 -0300
Message-Id: <0-v2-05ea785520ed+10-ib_virt_page_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:a03:332::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d249604-0d64-48e5-9d27-08db3cf05582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IgfK88lTytOoGHC08j2HuGm+Z5xppM2YO3NDdbRYz02OvQKJ/WYm9hkx4dwvuKGCbqHtEZn0CJB1Korjf0L5ruGhYoVqI43R2EamPsBl5Ke4F0RPJ9Bl5E4KUAekW5/gCvCW2xPK1l5peNVvW2f5AnsH/5SpUXcxY4qB9jOn6sEv7U6SARif5f2kA5q60SY7GM1E4lLzzzZ5uunHdVQdwTF/+wz7lCyY8WeIZo9Rpw3w+zFqDTuBxFLhHvt53Jt7tCodOkjXBh9jdpeuJCwEGaKrjEL6LkbRC5B8K6cnpREr5p8WRtVMDNK9/XR8VTA3Low/d7XWmYQo5a2QUJ+ugYcyI6fHZ0YzrXjr/FeEJfou6Ltk9W8d20mwxURM4fnS4FSouvxZ65PAqseAww6hnZKI3ez2FtdqK5Tr8TtqALB0R80IITz6C6zvp3Z35MMbZPIFzRptCEb/gZiTfpNXVI5YUwD1ZU4qNi68rk+YQUCEvCNc3QcrpxIZnj12jkeqKNnbDfvX1ZFIVfm4MhIArv4EjBqDmPXz3nHoRFT7AcujY2wh9TgKE3rxwtreA6LxgKFQJOMTes4W28lUW8K7QuDwha8diiIC+Z4bqBAJjohv9UpCPn47TJis8MPMrHBAU0KFeUVGL/HtpneIg9GBQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199021)(316002)(41300700001)(26005)(6512007)(6506007)(6666004)(6486002)(186003)(966005)(38100700002)(86362001)(2616005)(36756003)(83380400001)(66476007)(66556008)(66946007)(110136005)(4326008)(478600001)(8676002)(8936002)(5660300002)(2906002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ELrR/Xu8OQKzvxmB2HRKFwClXCgtA0+5kQjeV7O6AQtXrRROrQ2vEp03Jqj?=
 =?us-ascii?Q?rec8AB0lLkaaPq/nrmSm2PWNkUNLWqDI5MM4H9Z8zTXzIoswkJAcwVG3UT1h?=
 =?us-ascii?Q?0LwP1lRyJ1pCLcbopdJVwmU6+qvUNhv8RIifSbed9yH3I6NAwX8Mm9ziD/Wc?=
 =?us-ascii?Q?T8LXQbQQmOMuc1ULppKe1uYWeKmTEFi+zDu+ExVoEBcfTs7GuumSIzuAC98I?=
 =?us-ascii?Q?IkTXsZlh/f2q1of3Q1PjKygWmVYiSgVTTejoe0t7bcSSI27jHVlHJbBl6OID?=
 =?us-ascii?Q?zCb407KW7UDMHyAaSCmMB5orCfF9bORHt6a3k2w4RupJl9ZaBqwIqon5m2MF?=
 =?us-ascii?Q?YM61vnTrOwN8fEEJY6YNtQanW4ALUJNe+viPJMZ9/ZhFlDPgaat3l1mUeGBm?=
 =?us-ascii?Q?OeV7BtOqjvhUB1SP3tvxL10QtGbdEWc7JZQe7C5+5qH82/dZ19IrLxZugCzu?=
 =?us-ascii?Q?D3YaMdy59DKkDGFR0XUEWbyrbCyjfRBV2tiOICVhJAvvP3NG6YoZaR6NP8dD?=
 =?us-ascii?Q?deaqjmW4I+ShE47X5XhHZmneDD4uJcXi+ZnkCCWDvZ5jbVC3vodThp5Wlw+c?=
 =?us-ascii?Q?Sc+q/vz35O1/NWp8GjrBr2sUDqeGWS6aRSUOkmRPyUjDsmNa2AIHhoMpov+y?=
 =?us-ascii?Q?7UHX04d7yHW6gmcCVBTP07EFT5og+3JDJjTMvhsufHUnPeztEp5lPeCpF4Is?=
 =?us-ascii?Q?0yFTEYBW05whnwGs4A77yjUdwqrNf3VwmQy5V32LCCGxKv+hz72mkQmBWpsx?=
 =?us-ascii?Q?G7c/BY53sT5Qyo1fxnF2pLp1qQy8JlyVLWLQ8zRkbN1JA6E04MEMLiKlKH4z?=
 =?us-ascii?Q?bpKZfxSoMOgJFH6g8KFHD+Dnf63WIgHctMZQQa/Ir8KAmAKTo2Hrh7NYZ22S?=
 =?us-ascii?Q?JIwcM65VROUPOjYvRTEg8pMbKCXnI5EKKnFPqtaY7jdr8y9XLmqWbjgMXlUf?=
 =?us-ascii?Q?fq6gLL6Hn55JPUpH/DH5k/UmhLv//0sa7Dc6rzkJfpDGVWWf/Gf/10dAgR55?=
 =?us-ascii?Q?nKv7WxvCiiS+mFv5Wk4/ksLLOeuO3qM+7onJ4Q/NZ9aoY0w3ww6qSj111IJp?=
 =?us-ascii?Q?y2c1tOQO2VVplnWcJKDLaJJvZHlMCJwqN6TRA3onjcD6Hj3l7wlJkmJ3+3xg?=
 =?us-ascii?Q?1TACI8QAazMXA2GZ83kjtBI7ai1wJBaxxY+hPL5EtpmhSqMRRsfnJt7NbNM/?=
 =?us-ascii?Q?qOA6kO7fmFvKG/U3vfZ0obfojrvqFz+KtZBWViCTtG4eUn8/ckBJs+mtenqr?=
 =?us-ascii?Q?vfVzNMk5kdST93eZBKTnQbwcsAAKw3YP1qstUiwNMOE8OvRcuYTcPb2BYz9v?=
 =?us-ascii?Q?GI5ivzcJbzbe8e+quz7x8K7lt3dJWI+uomZVdJcFgXcpsWMqpBDBd+8KuDh6?=
 =?us-ascii?Q?n+L0Vk3kHKS+Y3w0I2kbka8s5D8L8VnLqxGBvnF5qePHaoLvBHY8FSAAD9SN?=
 =?us-ascii?Q?XmoIPwXaWcmK8rCNguwkqrnJ/YutFuYlkGYm340Jcuj0UcURFEBsHV5zlxMH?=
 =?us-ascii?Q?xJ8u4f8rv9VQBOmV2KBZk/94jplvWyHtACnXsRqkgOqE0RKVgOVHgUQqv6jb?=
 =?us-ascii?Q?8/6R8RvbB7IePse5LxSzfLve7uw+5jOGFXV1yqgj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d249604-0d64-48e5-9d27-08db3cf05582
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 13:58:33.0861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVMc0RFYIasrU/H8sTu+jq4gebWItSLY3+q0B3WhA01Dwo8orkyDAS7gYMRwjE8Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make it clearer what is going on by adding a function to go back from the
"virtual" dma_addr to a kva and another to a struct page. This is used in the
ib_uses_virt_dma() style drivers (siw, rxe, hfi, qib).

Call them instead of a naked casting and  virt_to_page() when working with dma_addr
values encoded by the various ib_map functions.

This also fixes the virt_to_page() casting problem Linus Walleij has been
chasing.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 16 ++++++++--------
 drivers/infiniband/sw/rxe/rxe_verbs.c |  2 +-
 drivers/infiniband/sw/siw/siw_qp_rx.c |  6 +++---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 19 ++++++-------------
 drivers/infiniband/sw/siw/siw_verbs.c |  4 ++--
 include/rdma/ib_verbs.h               | 25 +++++++++++++++++++++++++
 6 files changed, 45 insertions(+), 27 deletions(-)

v2:
 - Add ib_virt_dma_to_ptr() as well to solve the compilation warning problem on 32 bit.
v1: https://lore.kernel.org/r/0-v1-789ba72d2950+2e-ib_virt_page_jgg@nvidia.com/

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 1e17f8086d59a8..0e538fafcc20ff 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -210,10 +210,10 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
 	return err;
 }
 
-static int rxe_set_page(struct ib_mr *ibmr, u64 iova)
+static int rxe_set_page(struct ib_mr *ibmr, u64 dma_addr)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
-	struct page *page = virt_to_page(iova & mr->page_mask);
+	struct page *page = ib_virt_dma_to_page(dma_addr);
 	bool persistent = !!(mr->access & IB_ACCESS_FLUSH_PERSISTENT);
 	int err;
 
@@ -279,16 +279,16 @@ static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
 	return 0;
 }
 
-static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 iova, void *addr,
+static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 dma_addr, void *addr,
 			    unsigned int length, enum rxe_mr_copy_dir dir)
 {
-	unsigned int page_offset = iova & (PAGE_SIZE - 1);
+	unsigned int page_offset = dma_addr & (PAGE_SIZE - 1);
 	unsigned int bytes;
 	struct page *page;
 	u8 *va;
 
 	while (length) {
-		page = virt_to_page(iova & mr->page_mask);
+		page = ib_virt_dma_to_page(dma_addr);
 		bytes = min_t(unsigned int, length,
 				PAGE_SIZE - page_offset);
 		va = kmap_local_page(page);
@@ -300,7 +300,7 @@ static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 iova, void *addr,
 
 		kunmap_local(va);
 		page_offset = 0;
-		iova += bytes;
+		dma_addr += bytes;
 		addr += bytes;
 		length -= bytes;
 	}
@@ -488,7 +488,7 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 
 	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
 		page_offset = iova & (PAGE_SIZE - 1);
-		page = virt_to_page(iova & PAGE_MASK);
+		page = ib_virt_dma_to_page(iova);
 	} else {
 		unsigned long index;
 		int err;
@@ -545,7 +545,7 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 
 	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
 		page_offset = iova & (PAGE_SIZE - 1);
-		page = virt_to_page(iova & PAGE_MASK);
+		page = ib_virt_dma_to_page(iova);
 	} else {
 		unsigned long index;
 		int err;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 4e2db7c2e4ed78..12819153bda769 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -760,7 +760,7 @@ static void copy_inline_data_to_wqe(struct rxe_send_wqe *wqe,
 	int i;
 
 	for (i = 0; i < ibwr->num_sge; i++, sge++) {
-		memcpy(p, (void *)(uintptr_t)sge->addr, sge->length);
+		memcpy(p, ib_virt_dma_to_page(sge->addr), sge->length);
 		p += sge->length;
 	}
 }
diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index fd721cc19682eb..58bbf738e4e599 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -139,7 +139,7 @@ static int siw_rx_pbl(struct siw_rx_stream *srx, int *pbl_idx,
 			break;
 
 		bytes = min(bytes, len);
-		if (siw_rx_kva(srx, (void *)(uintptr_t)buf_addr, bytes) ==
+		if (siw_rx_kva(srx, ib_virt_dma_to_ptr(buf_addr), bytes) ==
 		    bytes) {
 			copied += bytes;
 			offset += bytes;
@@ -487,7 +487,7 @@ int siw_proc_send(struct siw_qp *qp)
 		mem_p = *mem;
 		if (mem_p->mem_obj == NULL)
 			rv = siw_rx_kva(srx,
-				(void *)(uintptr_t)(sge->laddr + frx->sge_off),
+				ib_virt_dma_to_ptr(sge->laddr + frx->sge_off),
 				sge_bytes);
 		else if (!mem_p->is_pbl)
 			rv = siw_rx_umem(srx, mem_p->umem,
@@ -852,7 +852,7 @@ int siw_proc_rresp(struct siw_qp *qp)
 
 	if (mem_p->mem_obj == NULL)
 		rv = siw_rx_kva(srx,
-			(void *)(uintptr_t)(sge->laddr + wqe->processed),
+			ib_virt_dma_to_ptr(sge->laddr + wqe->processed),
 			bytes);
 	else if (!mem_p->is_pbl)
 		rv = siw_rx_umem(srx, mem_p->umem, sge->laddr + wqe->processed,
diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 6bb9e9e81ff4ca..4b292e0504f1a1 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -29,7 +29,7 @@ static struct page *siw_get_pblpage(struct siw_mem *mem, u64 addr, int *idx)
 	dma_addr_t paddr = siw_pbl_get_buffer(pbl, offset, NULL, idx);
 
 	if (paddr)
-		return virt_to_page((void *)(uintptr_t)paddr);
+		return ib_virt_dma_to_page(paddr);
 
 	return NULL;
 }
@@ -56,8 +56,7 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, void *paddr)
 
 		if (!mem->mem_obj) {
 			/* Kernel client using kva */
-			memcpy(paddr,
-			       (const void *)(uintptr_t)sge->laddr, bytes);
+			memcpy(paddr, ib_virt_dma_to_ptr(sge->laddr), bytes);
 		} else if (c_tx->in_syscall) {
 			if (copy_from_user(paddr, u64_to_user_ptr(sge->laddr),
 					   bytes))
@@ -477,7 +476,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 			 * or memory region with assigned kernel buffer
 			 */
 			iov[seg].iov_base =
-				(void *)(uintptr_t)(sge->laddr + sge_off);
+				ib_virt_dma_to_ptr(sge->laddr + sge_off);
 			iov[seg].iov_len = sge_len;
 
 			if (do_crc)
@@ -537,19 +536,13 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 				 * Cast to an uintptr_t to preserve all 64 bits
 				 * in sge->laddr.
 				 */
-				uintptr_t va = (uintptr_t)(sge->laddr + sge_off);
+				u64 va = sge->laddr + sge_off;
 
-				/*
-				 * virt_to_page() takes a (void *) pointer
-				 * so cast to a (void *) meaning it will be 64
-				 * bits on a 64 bit platform and 32 bits on a
-				 * 32 bit platform.
-				 */
-				page_array[seg] = virt_to_page((void *)(va & PAGE_MASK));
+				page_array[seg] = ib_virt_dma_to_page(va);
 				if (do_crc)
 					crypto_shash_update(
 						c_tx->mpa_crc_hd,
-						(void *)va,
+						ib_virt_dma_to_ptr(va),
 						plen);
 			}
 
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 906fde1a2a0de2..398ec13db62481 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -660,7 +660,7 @@ static int siw_copy_inline_sgl(const struct ib_send_wr *core_wr,
 			bytes = -EINVAL;
 			break;
 		}
-		memcpy(kbuf, (void *)(uintptr_t)core_sge->addr,
+		memcpy(kbuf, ib_virt_dma_to_ptr(core_sge->addr),
 		       core_sge->length);
 
 		kbuf += core_sge->length;
@@ -1523,7 +1523,7 @@ int siw_map_mr_sg(struct ib_mr *base_mr, struct scatterlist *sl, int num_sle,
 		}
 		siw_dbg_mem(mem,
 			"sge[%d], size %u, addr 0x%p, total %lu\n",
-			i, pble->size, (void *)(uintptr_t)pble->addr,
+			i, pble->size, ib_virt_dma_to_ptr(pble->addr),
 			pbl_size);
 	}
 	rv = ib_sg_to_pages(base_mr, sl, num_sle, sg_off, siw_set_pbl_page);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 949cf4ffc536c5..1e7774ac808f08 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4035,6 +4035,31 @@ static inline bool ib_dma_pci_p2p_dma_supported(struct ib_device *dev)
 	return dma_pci_p2pdma_supported(dev->dma_device);
 }
 
+/**
+ * ib_virt_dma_to_ptr - Convert a dma_addr to a kernel pointer
+ * @dma_addr: The DMA address
+ *
+ * Used by ib_uses_virt_dma() devices to get back to the kernel pointer after
+ * going through the dma_addr marshalling.
+ */
+static inline void *ib_virt_dma_to_ptr(u64 dma_addr)
+{
+	/* virt_dma mode maps the kvs's directly into the dma addr */
+	return (void *)(uintptr_t)dma_addr;
+}
+
+/**
+ * ib_virt_dma_to_page - Convert a dma_addr to a struct page
+ * @dma_addr: The DMA address
+ *
+ * Used by ib_uses_virt_dma() device to get back to the struct page after going
+ * through the dma_addr marshalling.
+ */
+static inline struct page *ib_virt_dma_to_page(u64 dma_addr)
+{
+	return virt_to_page(ib_virt_dma_to_ptr(dma_addr));
+}
+
 /**
  * ib_dma_mapping_error - check a DMA addr for error
  * @dev: The device for which the dma_addr was created

base-commit: a2e20b29cf9ce6d2070a6e36666e2239f7f9625b
-- 
2.40.0

