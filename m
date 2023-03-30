Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AC46D083D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 16:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjC3O06 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 10:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjC3O05 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 10:26:57 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03B993CA
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 07:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lP0PXEk38X7H39TbYJC6HRUe3zaXdNp4DqDYlBdtSg+QUXh5vNM/SZA/J3IA7cyDzJG/Vw28j5LYuuxT9ErvG8kwTz/wfkYR3GhHGfi9IjsWPoOzgR+i2NCcsSCKSGu23cTSvz8Xg16NSMFsPi6ngrLwJIVXSByns5rtZIwzjei6zjNMTMZjwZuvWyjK444IPjriSW3UtuWbHuKP3W7zXdeU3t8+kN8EonrK9vYjQF5gBlvw89+m21ahqt2N4XRcPZqzlEkz7lkCZ4JxjW6M5fsfDhQKBiQ/hwTtOLQWdRCulnVNsHQOV+Dws48xjk99CZJzgeqU4navW6ONTFtoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLSgJoUy39MN5SgwWTVYfrnws8AaJf+o50Bj2vddwrc=;
 b=dQEpODF3o8kUCmnBZNLAj3q14T+9qvbu+fsQz1RPjD6PPiRBZYAkbcRS+2obBxlgaTCBHmBlOiTmGL0Q6RxmnXXUDI0YkZk6ZPuO1YpQ03tCNhkTVsQx9nV8+fJSQI6kqohnHkAFoPZH3mB5hVEcJF8CgB69Oj1yKDfLfHGxkk5YbU7tMSbLlWdRgdWsed5IhiMpV/YHh+oJ+AmvtTIFiNG0okjcifXddOcUB0aNM+7dwgxlkgCuGh2ew2ZotyQNVRkGSHUohQU+C6+cmWDPKAQvKAPyJyL3oww/H7k58kl8R9BjI209rvGDh1Tt2A5PPCdrEsQ7Z8hN3n82r8b/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLSgJoUy39MN5SgwWTVYfrnws8AaJf+o50Bj2vddwrc=;
 b=a8YuOw6v5ePesaSzAkj/EHpjdZuIVXdYAgxE9OcDJBum2TFThngXtfn0tv25NLDBicGt9b85GCrHo6axApxfjjUNdy6Ltc7YlLsxFlT3uIuKRjPVDsrscPPzLFuloOGaHXBfRHpFxVMgNa0QGG6N4eF0Q3yfDeojv1zoeQsH2tsF8HroivhrlFER0Fn/1j3hnqEDFJFQVYYGHvHFcZpk0u6SVgoOpddcQP4GswcDy2B0Ar9Y22XP5NYGneOckSC46e01FgHDPYblDhNu1lE7qIEf8sJOpbbyWV0VUebY/e3QmX7vJGiWy0DQ/CJ2KfCSnM1UGPs/WrwERgo19RVTxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7022.namprd12.prod.outlook.com (2603:10b6:806:261::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 14:26:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Thu, 30 Mar 2023
 14:26:52 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] RDMA: Add ib_virt_dma_to_page()
Date:   Thu, 30 Mar 2023 11:26:50 -0300
Message-Id: <0-v1-789ba72d2950+2e-ib_virt_page_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:208:23a::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a886e8-6306-4bb2-0f8e-08db312ace02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: shbvoLoy9qcaHFnAYp7brbSGzfRxqkSPyB782xg383LUGwLToALK5jBT+gkkyq5+DrFprbpiegA3fTkRZYTdy6u/Bxb++TM6+SfFctIIm1WY63zF27brOy6jus5w8H3O8OIHoyLZRuvOUeu3/rYFAfy1hBu9//QeGJTVrmKOX4vvr6pb2BfLBSLGJL0qQhh4p33FcY1S8imaSD3ob/WdqHMVy1yaHobpglsWbAkWnCGzI3Cv1vG3/RrQIL/u8B644wJjnLASRcWY5TvCeSiJ87zKvcs2xupElRSDhYu5HHiHTWMWPVlTef8zgcRimsE2JbFpvavtKZz2gLMTFtO2u13Mrzhv/j7IdMPOnsqpBXgj5IbZ4jPRm5GBVSSyMqh7GnXQDlRVJrqaBKm3cpSOH0bDRZCFeh57sSlR4JxhS6684zIxHu/MMmQSSDp/bXEi7k94hWXYO3tKfIdV4aE2HOAoaCv0uJgYCxiVmy4ll3I5xcJ40n3wvqbFfZRZcreQSU7jwe+CExpA3keVLE6X1MMJ+sW8wIriQnHjXwbyor5ZXSi2kihiMaANF/gilsMnkoz2gDBAiou2gxbrOBF+C2JClWQcvehmwDfUcZnPELE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(2906002)(83380400001)(2616005)(66476007)(5660300002)(41300700001)(478600001)(36756003)(316002)(8676002)(66556008)(6486002)(4326008)(110136005)(8936002)(186003)(66946007)(86362001)(26005)(6506007)(6512007)(38100700002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PvIkRp0y2lgR5isCLal5wUNzCJbiX/JsIfjNPg9Df220JwR6Jgugu2DYBS8n?=
 =?us-ascii?Q?cuU1Lw73gr+VPiMzhqA7L94OqOBzURS9lWfQ1XQlGFpb92iJ6ZBKt73QtqA5?=
 =?us-ascii?Q?tq6dI+ELO6oTcCI1Wbhhrju551YlZXK6Fbh1asvv3/QpXefYHWszjJg/tPe7?=
 =?us-ascii?Q?AOT/xdZDxHPdgwTtmFU2rnaJ/T6eu68D5CRZ2oUcWNcfTyda2d2sEVCqDS6C?=
 =?us-ascii?Q?+IYAna02+1Dlq6J8K8s3ZAIMtZbsgaB1AyOfmGKBlCX2gMGaN5okz+3Uzf/2?=
 =?us-ascii?Q?RtGiRnSdcHz0zVf0EGqhc3iO2KZ0XjZlrYuhV+Z2v87Fo1iJSYJOJzGUKIkb?=
 =?us-ascii?Q?RJVpwr9qFRblFpPkPmswWWVdyK8Ij3vSilrrWTzF2r8L60OZMjmtMp0qEn75?=
 =?us-ascii?Q?oM2XcX6BqzKK4ADI0USbG+9PluzNMPO4ml/Q+vr6VlQaX3XaDMSF3X9S/dqD?=
 =?us-ascii?Q?hLcLN0BydYgbEdekhL1Acq/IWZkNBPr4wk2L0CU8pYZOFKS4j7VAHcV7hMv9?=
 =?us-ascii?Q?jJbPsf5LGVYZLHlL6QIC1F2rHBoK+OmbnlPW7MPSKeCWhdzojBCR/OpolyA7?=
 =?us-ascii?Q?qVRV2Da2S3xX1HJUZGkJH8e5l+tr6DH+xGewsNQBfq8NRugFnL5V8un3Nqnc?=
 =?us-ascii?Q?Y+ON1Bp7TXfMFAU9h3Q++4DcgF/oiMdTu7M0G4UxjRrVR4H/EVp4Tm6NiLeU?=
 =?us-ascii?Q?K+XeCKRNdeUu1uIzO5OioBg/wTz0z3E0XSj3XRVUXkR7ZGS4Pep2CACcuVkt?=
 =?us-ascii?Q?0VG5BuNbxw5UahHz8v86PbvtvfYM3qd85AQmu/KHt+4aMNNeTwvoye6n4FXS?=
 =?us-ascii?Q?i1EMOg6UcwkwRPpUWxbiK05N3n1wSQWZHTP7+bXY9GIlsmKbz4Z0Pr5So6bV?=
 =?us-ascii?Q?yDTxURPCp/HWJgQfj1JUduLEScdWRq0sOPayrLS3WYIxLjGJWPh1iMEmcVF+?=
 =?us-ascii?Q?GPfpNhvXWnVvDxAzRhKkJv6UoP2lE8nlKgz0qp/qoFH+BjT1+Tmi2l6Lyw8A?=
 =?us-ascii?Q?R6ebIiGwlGmFXHVdGQQZRABWAUmJE1hcV79Usyn45ZJgIcmLIL6J3nXYYzQI?=
 =?us-ascii?Q?y+baXyQw738fcASheRktdRk9Qcido9m75L9jaGYsDDutrNq/3zzmdcozFjWE?=
 =?us-ascii?Q?ZCQbN1RgtBr5q7Ru1cQeNiiB8gE++P2Bo9y36CCSxW/2XhWiWVb7p7JWVh8k?=
 =?us-ascii?Q?YmW4bLVF4yo6z2KQMFLHJyLoZdcz1dxPi8ysPO/PZbNc3AWVJRgVV02yOPeu?=
 =?us-ascii?Q?RO7nUz/UEGPog6EFKDlYJY4aeHnSMVEbalBk3S0uaE+4mxMAsymDXMyYyKCI?=
 =?us-ascii?Q?CDDFmb20hZM7Y5yLaC+Wxmcfx6FkIpovOeJ15/hi7+q0BRXz6WR+/kF4PteH?=
 =?us-ascii?Q?Bkab+hLWFp5GP1v5ntrFHvS+g9MIy6m/VZj17F/ao5vp26N25jTgoUA/9nFC?=
 =?us-ascii?Q?+5dJUE4djYz6WADAVUeX/umglMbn2EpKo6Mqhm10jHzB2bFYBL/Ue478MwTm?=
 =?us-ascii?Q?gyVD3b/XIF7/QYqSU2qr8cRKVPtk6SCJ62oKI4PmylwUBdS8X6m7ko6t2UWM?=
 =?us-ascii?Q?ulS3yUW088rZvF9iTPXx+sVMOO5hn7WiyRYaGmFJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a886e8-6306-4bb2-0f8e-08db312ace02
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:26:52.5041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDmHEOiG6iXdXpaboeOJn4JG1mZe7KQIqw52OY49CDdNyLymdzxW1sBRsvk0wYSW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7022
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make it clearer what is going on by adding a function to go back from the
"virtual" dma_addr to a struct page. This is used in the
ib_uses_virt_dma() style drivers (siw, rxe, hfi, qib).

Call it instead of a naked virt_to_page() when working with dma_addr
values encoded by the various ib_map functions.

This also fixes the vir_to_page() casting problem Linus Walleij has been
chasing.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 16 ++++++++--------
 drivers/infiniband/sw/siw/siw_qp_tx.c | 12 +++---------
 include/rdma/ib_verbs.h               | 13 +++++++++++++
 3 files changed, 24 insertions(+), 17 deletions(-)

Maybe this will be clearer overall

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
diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 6bb9e9e81ff4ca..108985af49723b 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -29,7 +29,7 @@ static struct page *siw_get_pblpage(struct siw_mem *mem, u64 addr, int *idx)
 	dma_addr_t paddr = siw_pbl_get_buffer(pbl, offset, NULL, idx);
 
 	if (paddr)
-		return virt_to_page((void *)(uintptr_t)paddr);
+		return ib_virt_dma_to_page(paddr);
 
 	return NULL;
 }
@@ -537,15 +537,9 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 				 * Cast to an uintptr_t to preserve all 64 bits
 				 * in sge->laddr.
 				 */
-				uintptr_t va = (uintptr_t)(sge->laddr + sge_off);
+				u64 va = (uintptr_t)(sge->laddr + sge_off);
 
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
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 949cf4ffc536c5..4e8868171de68c 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4035,6 +4035,19 @@ static inline bool ib_dma_pci_p2p_dma_supported(struct ib_device *dev)
 	return dma_pci_p2pdma_supported(dev->dma_device);
 }
 
+/**
+ * ib_virt_dma_to_page - Convert a dma_addr to a struct page
+ * @dma_addr: The DMA address to check
+ *
+ * Used by ib_uses_virt_dma() to get back to the struct page after
+ * going through the dma_addr marshalling.
+ */
+static inline struct page *ib_virt_dma_to_page(u64 dma_addr)
+{
+	/* virt_dma mode maps the kvs's directly into the dma addr */
+	return virt_to_page((void *)(uintptr_t)dma_addr);
+}
+
 /**
  * ib_dma_mapping_error - check a DMA addr for error
  * @dev: The device for which the dma_addr was created

base-commit: 78b26a335310a097d6b22581b706050db42f196c
-- 
2.40.0

