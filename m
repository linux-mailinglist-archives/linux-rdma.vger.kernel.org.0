Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ACA4C6508
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 09:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbiB1IuH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 03:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiB1IuC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 03:50:02 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2945377F5
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 00:49:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlCeSHLtmHRTujtD/3+HPpM97pZsHOqhTwwBuqWS0jlYdf2AzDpAPteX+6a1kjAxhIGmJrz5wQqhDo2y9fyb4yVz/VAeyObW3D/rR4SjHzDkZZ1+G6cSSSY7qtgViv08MW7h7bK2W1F+QLmNHKEMq+ypPOvrPPdYyWcuvXGA8R0I1nPHm+6ABBNY2AULodgbg+kLgrEopX825f7Ij/y3IXepVfc9sysLJp+f1fE7NmSozfp04Exvhn+RMREqzDpvInnfRu/4wX+2RW+qje2gGDnybDqe/jhUd+buoEJSEW5I6MsiS/7jNGXWL3EP9i3rz+p0ETr7smd+9VF3uRnaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5vKTkV0XyDO439PVu105FquebGNlXL6Oo0E4CE0xds=;
 b=DctDtbrxoziwh4l0xo/B6RZtULeb5mDJJ/E4fjR6NNJy+Dfm2akd9RRjZgMjQxQOoadrnBSK3JZAqpN2TH7G8ejH06pXVDT5ZZpXKImHw46g2AENMLOuvHvQxWST7m5Jc7G4GEmnhbmRJ51AswOVhhvJNfL6CoYlDwvrLUMZX7VzdYMHvAvpi19A2xjV2undKKXHfb8gA9PTIsaeIhhfg94DZ/mGzgWu+uMoNI/ef9L7Wczy3fiQeIRLPLo88kBGjc1TsrY1vuF2tiIldCH7Xly7dYw1LFVxZomtYBSbW4CYRjqw96lVfo6RzM1yopBR2WmF5ajhhzpPCAmfdQg2pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5vKTkV0XyDO439PVu105FquebGNlXL6Oo0E4CE0xds=;
 b=XPliktbhOmpbqYfC1ABy1LLpAnhT5sARAZ00hjimDcER4SlLX3q/43ILXF3VpBYJEYMwZ9Qll0PUzD6exxR/dW+X7646OkbaJ4lJzP9ipvYz2i0PTZv37op1pD+Qpj8xq5JoGgQLjydnaoxEzbWaNb5ctvvIM0IKvM2X3yvJCRgz7MME0dHYcjC6OOcatTTDbwCuKDCTicINC4rzYVQh4g2L3uchDNBFCl30Dm0YLqZYUZg+pmJRYFpk1ZFyaq8Niq50no0Qw5mGXzam7AOHgu2BsLI66rwXPobLp090uZHKH/qkPGY2VoUL2SHBgjuzk3UskGv1z18CnOgaXOifDQ==
Received: from DM5PR11CA0023.namprd11.prod.outlook.com (2603:10b6:3:115::33)
 by BYAPR12MB2903.namprd12.prod.outlook.com (2603:10b6:a03:139::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 08:49:10 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::17) by DM5PR11CA0023.outlook.office365.com
 (2603:10b6:3:115::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Mon, 28 Feb 2022 08:49:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 08:49:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 28 Feb
 2022 08:49:08 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 28 Feb 2022
 00:49:07 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.9 via Frontend Transport; Mon, 28 Feb
 2022 00:49:05 -0800
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <msanalla@nvidia.com>, <oulijun@huawei.com>,
        Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH rdma-core 2/5] mlx5: Adapt bitmap usage to use util API
Date:   Mon, 28 Feb 2022 10:48:27 +0200
Message-ID: <20220228084830.96274-3-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220228084830.96274-1-yishaih@nvidia.com>
References: <20220228084830.96274-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5ca8fe1-ed6a-46bc-f2c1-08d9fa972fc8
X-MS-TrafficTypeDiagnostic: BYAPR12MB2903:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2903C2C8B1435F8D6EF298E0C3019@BYAPR12MB2903.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hd0V+MNa362P1cVkNTwzjc2v/0nxL0rkxTbtOAuN/oI0nmjusxLOGGpuVYCFC0piiwBH+0yrbsX6HXS+ijpXxuJIYjCTh91Ihc2gWi/rd0GFlkMdXll8hFxjzxD3GaTNQvrOxLbqahLi1Zt24m7IVXNCPA8ojgy1yAeol02ZNiN2kiJYRzxT5fsaCO2+BPRXC0wzviyPboWu4QuUH3NaBDz5Yxk+lZUSa6Aqv2wZxgQ5WSMW8ov4KnrAAFPCpCWbNXR7Iq5sbs6lia+Eo6Oo+M0i6gAevSilKDt/dtxIioNAmo7iFGcoCpiExqJ7sP4lwun4Gf5OoXE7P0Jxq/H/AHK7ESRP9vuuCi8mry9/jB/jLdNkuH4OyWcyMgqln+dJy3YpVnNxjarlw2b8JEoYXdU0Fw/UdViTECWPb3csDMQUfM3hcp9gPU+8IklakL+KOQnADBYhX3OOU4yFXlQVjBDSgx1G/DFwCsF5rMnMEfrhy7RCtyAwBhE0VLQcyKgo7r7HnWb1aBY2ntQcCf/MYOJQiZcaNA+HHCssJKV4ODylaOrRH96vizijILoOUn5xLda0pU/jjlcmgPo2ah9CtGdfb7ISQAllBlqn2g821RaArfq/Lk3dHBKqTEQ3ybvjEdUgTdgdLQS8uzVfCmElsBv2qkvTHOkaMgbg9AZ8RUSbb9aquFQFEns4LtLLGJmyvJBobYgf8w/zAhX9rzVp7tULTH50kXk3AnzcgRdCNbr686w5dCFZcPEzSMShQcSR
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(8936002)(54906003)(5660300002)(508600001)(6916009)(2616005)(47076005)(316002)(6666004)(30864003)(4326008)(8676002)(70586007)(70206006)(7696005)(336012)(2906002)(186003)(83380400001)(426003)(1076003)(107886003)(82310400004)(86362001)(40460700003)(36860700001)(356005)(81166007)(26005)(461764006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 08:49:09.6621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ca8fe1-ed6a-46bc-f2c1-08d9fa972fc8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2903
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maher Sanalla <msanalla@nvidia.com>

Replace the usage of ccan bitmap with the newly added bitmap
implementation in util.

As part of it, remove mlx5 bitmap API.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 providers/mlx5/bitmap.h    | 109 --------------------------
 providers/mlx5/buf.c       | 187 +++++++++------------------------------------
 providers/mlx5/dr_buddy.c  |  12 +--
 providers/mlx5/mlx5.h      |  17 +----
 providers/mlx5/mlx5_vfio.c |   3 +-
 providers/mlx5/mlx5_vfio.h |   2 +-
 providers/mlx5/mlx5dv_dr.h |   6 +-
 7 files changed, 53 insertions(+), 283 deletions(-)
 delete mode 100644 providers/mlx5/bitmap.h

diff --git a/providers/mlx5/bitmap.h b/providers/mlx5/bitmap.h
deleted file mode 100644
index b2c8a36..0000000
--- a/providers/mlx5/bitmap.h
+++ /dev/null
@@ -1,109 +0,0 @@
-/*
- * Copyright (c) 2000, 2011 Mellanox Technology Inc.  All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
- */
-
-#ifndef BITMAP_H
-#define BITMAP_H
-
-#include <stdlib.h>
-#include <stdio.h>
-#include <pthread.h>
-#include <string.h>
-#include <sys/types.h>
-#include <sys/ipc.h>
-#include <sys/shm.h>
-#include <sys/mman.h>
-#include <linux/errno.h>
-#include <util/util.h>
-#include "mlx5.h"
-
-/* Only ia64 requires this */
-#ifdef __ia64__
-#define MLX5_SHM_ADDR ((void *)0x8000000000000000UL)
-#define MLX5_SHMAT_FLAGS (SHM_RND)
-#else
-#define MLX5_SHM_ADDR NULL
-#define MLX5_SHMAT_FLAGS 0
-#endif
-
-#ifndef HPAGE_SIZE
-#define HPAGE_SIZE		(2UL * 1024 * 1024)
-#endif
-
-#define MLX5_SHM_LENGTH		HPAGE_SIZE
-#define MLX5_Q_CHUNK_SIZE	32768
-#define MLX5_SHM_NUM_REGION	64
-
-static inline unsigned long mlx5_ffz(uint32_t word)
-{
-	return __builtin_ffs(~word) - 1;
-}
-
-static inline uint32_t mlx5_find_first_zero_bit(const unsigned long *addr,
-					 uint32_t size)
-{
-	const unsigned long *p = addr;
-	uint32_t result = 0;
-	unsigned long tmp;
-
-	while (size & ~(BITS_PER_LONG - 1)) {
-		tmp = *(p++);
-		if (~tmp)
-			goto found;
-		result += BITS_PER_LONG;
-		size -= BITS_PER_LONG;
-	}
-	if (!size)
-		return result;
-
-	tmp = (*p) | (~0UL << size);
-	if (tmp == (uint32_t)~0UL)	/* Are any bits zero? */
-		return result + size;	/* Nope. */
-found:
-	return result + mlx5_ffz(tmp);
-}
-
-static inline void mlx5_set_bit(unsigned int nr, unsigned long *addr)
-{
-	addr[(nr / BITS_PER_LONG)] |= (1 << (nr % BITS_PER_LONG));
-}
-
-static inline void mlx5_clear_bit(unsigned int nr,  unsigned long *addr)
-{
-	addr[(nr / BITS_PER_LONG)] &= ~(1 << (nr % BITS_PER_LONG));
-}
-
-static inline int mlx5_test_bit(unsigned int nr, const unsigned long *addr)
-{
-	return !!(addr[(nr / BITS_PER_LONG)] & (1 <<  (nr % BITS_PER_LONG)));
-}
-
-#endif
diff --git a/providers/mlx5/buf.c b/providers/mlx5/buf.c
index 83c32b0..3a3a792 100644
--- a/providers/mlx5/buf.c
+++ b/providers/mlx5/buf.c
@@ -38,155 +38,38 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <sys/mman.h>
+#include <util/bitmap.h>
 
 #include "mlx5.h"
-#include "bitmap.h"
 
-static int mlx5_bitmap_init(struct mlx5_bitmap *bmp, uint32_t num,
-			    uint32_t mask)
-{
-	bmp->last = 0;
-	bmp->top  = 0;
-	bmp->max  = num;
-	bmp->avail = num;
-	bmp->mask = mask;
-	bmp->avail = bmp->max;
-	bmp->table = calloc(BITS_TO_LONGS(bmp->max), sizeof(*bmp->table));
-	if (!bmp->table)
-		return -ENOMEM;
-
-	return 0;
-}
-
-static void bitmap_free_range(struct mlx5_bitmap *bmp, uint32_t obj,
-			      int cnt)
-{
-	int i;
+/* Only ia64 requires this */
+#ifdef __ia64__
+#define MLX5_SHM_ADDR ((void *)0x8000000000000000UL)
+#define MLX5_SHMAT_FLAGS (SHM_RND)
+#else
+#define MLX5_SHM_ADDR NULL
+#define MLX5_SHMAT_FLAGS 0
+#endif
 
-	obj &= bmp->max - 1;
-
-	for (i = 0; i < cnt; i++)
-		mlx5_clear_bit(obj + i, bmp->table);
-	bmp->last = min(bmp->last, obj);
-	bmp->top = (bmp->top + bmp->max) & bmp->mask;
-	bmp->avail += cnt;
-}
-
-static int mlx5_bitmap_empty(struct mlx5_bitmap *bmp)
-{
-	return (bmp->avail == bmp->max) ? 1 : 0;
-}
-
-static int bitmap_avail(struct mlx5_bitmap *bmp)
-{
-	return bmp->avail;
-}
+#ifndef HPAGE_SIZE
+#define HPAGE_SIZE              (2UL * 1024 * 1024)
+#endif
 
-static void mlx5_bitmap_cleanup(struct mlx5_bitmap *bmp)
-{
-	if (bmp->table)
-		free(bmp->table);
-}
+#define MLX5_SHM_LENGTH         HPAGE_SIZE
+#define MLX5_Q_CHUNK_SIZE       32768
 
 static void free_huge_mem(struct mlx5_hugetlb_mem *hmem)
 {
-	mlx5_bitmap_cleanup(&hmem->bitmap);
+	if (hmem->bitmap)
+		free(hmem->bitmap);
+
 	if (shmdt(hmem->shmaddr) == -1)
 		mlx5_dbg(stderr, MLX5_DBG_CONTIG, "%s\n", strerror(errno));
 	shmctl(hmem->shmid, IPC_RMID, NULL);
 	free(hmem);
 }
 
-static int mlx5_bitmap_alloc(struct mlx5_bitmap *bmp)
-{
-	uint32_t obj;
-	int ret;
-
-	obj = mlx5_find_first_zero_bit(bmp->table, bmp->max);
-	if (obj < bmp->max) {
-		mlx5_set_bit(obj, bmp->table);
-		bmp->last = (obj + 1);
-		if (bmp->last == bmp->max)
-			bmp->last = 0;
-		obj |= bmp->top;
-		ret = obj;
-	} else
-		ret = -1;
-
-	if (ret != -1)
-		--bmp->avail;
-
-	return ret;
-}
-
-static uint32_t find_aligned_range(unsigned long *bmp,
-				   uint32_t start, uint32_t nbits,
-				   int len, int alignment)
-{
-	uint32_t end, i;
-
-again:
-	start = align(start, alignment);
-
-	while ((start < nbits) && mlx5_test_bit(start, bmp))
-		start += alignment;
-
-	if (start >= nbits)
-		return -1;
-
-	end = start + len;
-	if (end > nbits)
-		return -1;
-
-	for (i = start + 1; i < end; i++) {
-		if (mlx5_test_bit(i, bmp)) {
-			start = i + 1;
-			goto again;
-		}
-	}
-
-	return start;
-}
-
-static int bitmap_alloc_range(struct mlx5_bitmap *bmp, int cnt,
-			      int align)
-{
-	uint32_t obj;
-	int ret, i;
-
-	if (cnt == 1 && align == 1)
-		return mlx5_bitmap_alloc(bmp);
-
-	if (cnt > bmp->max)
-		return -1;
-
-	obj = find_aligned_range(bmp->table, bmp->last,
-				 bmp->max, cnt, align);
-	if (obj >= bmp->max) {
-		bmp->top = (bmp->top + bmp->max) & bmp->mask;
-		obj = find_aligned_range(bmp->table, 0, bmp->max,
-					 cnt, align);
-	}
-
-	if (obj < bmp->max) {
-		for (i = 0; i < cnt; i++)
-			mlx5_set_bit(obj + i, bmp->table);
-		if (obj == bmp->last) {
-			bmp->last = (obj + cnt);
-			if (bmp->last >= bmp->max)
-				bmp->last = 0;
-		}
-		obj |= bmp->top;
-		ret = obj;
-	} else
-		ret = -1;
-
-	if (ret != -1)
-		bmp->avail -= cnt;
-
-	return obj;
-}
-
 static struct mlx5_hugetlb_mem *alloc_huge_mem(size_t size)
 {
 	struct mlx5_hugetlb_mem *hmem;
@@ -209,12 +92,14 @@ static struct mlx5_hugetlb_mem *alloc_huge_mem(size_t size)
 		goto out_rmid;
 	}
 
-	if (mlx5_bitmap_init(&hmem->bitmap, shm_len / MLX5_Q_CHUNK_SIZE,
-			     shm_len / MLX5_Q_CHUNK_SIZE - 1)) {
+	hmem->bitmap = bitmap_alloc0(shm_len / MLX5_Q_CHUNK_SIZE);
+	if (!hmem->bitmap) {
 		mlx5_dbg(stderr, MLX5_DBG_CONTIG, "%s\n", strerror(errno));
 		goto out_shmdt;
 	}
 
+	hmem->bmp_size = shm_len / MLX5_Q_CHUNK_SIZE;
+
 	/*
 	 * Marked to be destroyed when process detaches from shmget segment
 	 */
@@ -250,9 +135,13 @@ static int alloc_huge_buf(struct mlx5_context *mctx, struct mlx5_buf *buf,
 
 	mlx5_spin_lock(&mctx->hugetlb_lock);
 	list_for_each(&mctx->hugetlb_list, hmem, entry) {
-		if (bitmap_avail(&hmem->bitmap)) {
-			buf->base = bitmap_alloc_range(&hmem->bitmap, nchunk, 1);
-			if (buf->base != -1) {
+		if (!bitmap_full(hmem->bitmap, hmem->bmp_size)) {
+			buf->base = bitmap_find_free_region(hmem->bitmap,
+							    hmem->bmp_size,
+							    nchunk);
+			if (buf->base != hmem->bmp_size) {
+				bitmap_fill_region(hmem->bitmap, buf->base,
+						   buf->base + nchunk);
 				buf->hmem = hmem;
 				found = 1;
 				break;
@@ -266,16 +155,14 @@ static int alloc_huge_buf(struct mlx5_context *mctx, struct mlx5_buf *buf,
 		if (!hmem)
 			return -1;
 
-		buf->base = bitmap_alloc_range(&hmem->bitmap, nchunk, 1);
-		if (buf->base == -1) {
-			free_huge_mem(hmem);
-			return -1;
-		}
+		buf->base = 0;
+		assert(nchunk <= hmem->bmp_size);
+		bitmap_fill_region(hmem->bitmap, 0, nchunk);
 
 		buf->hmem = hmem;
 
 		mlx5_spin_lock(&mctx->hugetlb_lock);
-		if (bitmap_avail(&hmem->bitmap))
+		if (nchunk != hmem->bmp_size)
 			list_add(&mctx->hugetlb_list, &hmem->entry);
 		else
 			list_add_tail(&mctx->hugetlb_list, &hmem->entry);
@@ -295,8 +182,8 @@ static int alloc_huge_buf(struct mlx5_context *mctx, struct mlx5_buf *buf,
 
 out_fork:
 	mlx5_spin_lock(&mctx->hugetlb_lock);
-	bitmap_free_range(&hmem->bitmap, buf->base, nchunk);
-	if (mlx5_bitmap_empty(&hmem->bitmap)) {
+	bitmap_zero_region(hmem->bitmap, buf->base, buf->base + nchunk);
+	if (bitmap_empty(hmem->bitmap, hmem->bmp_size)) {
 		list_del(&hmem->entry);
 		mlx5_spin_unlock(&mctx->hugetlb_lock);
 		free_huge_mem(hmem);
@@ -315,8 +202,8 @@ static void free_huge_buf(struct mlx5_context *ctx, struct mlx5_buf *buf)
 		return;
 
 	mlx5_spin_lock(&ctx->hugetlb_lock);
-	bitmap_free_range(&buf->hmem->bitmap, buf->base, nchunk);
-	if (mlx5_bitmap_empty(&buf->hmem->bitmap)) {
+	bitmap_zero_region(buf->hmem->bitmap, buf->base, buf->base + nchunk);
+	if (bitmap_empty(buf->hmem->bitmap, buf->hmem->bmp_size)) {
 		list_del(&buf->hmem->entry);
 		mlx5_spin_unlock(&ctx->hugetlb_lock);
 		free_huge_mem(buf->hmem);
diff --git a/providers/mlx5/dr_buddy.c b/providers/mlx5/dr_buddy.c
index e153677..8713fe4 100644
--- a/providers/mlx5/dr_buddy.c
+++ b/providers/mlx5/dr_buddy.c
@@ -34,23 +34,23 @@
  */
 
 #include <stdlib.h>
-#include <ccan/bitmap.h>
+#include <util/bitmap.h>
 #include "mlx5dv_dr.h"
 
 struct dr_icm_pool;
 struct dr_icm_buddy_mem;
 
-static int dr_find_first_bit(const bitmap *set_addr,
-			     const bitmap *addr,
+static int dr_find_first_bit(const unsigned long *set_addr,
+			     const unsigned long *addr,
 			     unsigned int size)
 {
 	unsigned int set_size = (size - 1) / BITS_PER_LONG + 1;
 	unsigned long set_idx;
 
 	/* find the first free in the first level */
-	set_idx =  bitmap_ffs(set_addr, 0, set_size);
+	set_idx =  bitmap_find_first_bit(set_addr, 0, set_size);
 	/* find the next level */
-	return bitmap_ffs(addr, set_idx * BITS_PER_LONG, size);
+	return bitmap_find_first_bit(addr, set_idx * BITS_PER_LONG, size);
 }
 
 int dr_buddy_init(struct dr_icm_buddy_mem *buddy, uint32_t max_order)
@@ -161,7 +161,7 @@ static void dr_buddy_update_upper_bitmap(struct dr_icm_buddy_mem *buddy,
 
 	/* clear upper layer of search if needed */
 	dr_buddy_get_seg_borders(seg, &l, &h);
-	m = bitmap_ffs(buddy->bits[order], l, h);
+	m = bitmap_find_first_bit(buddy->bits[order], l, h);
 	if (m == h) /* nothing in the long that includes seg */
 		bitmap_clear_bit(buddy->set_bit[order], seg / BITS_PER_LONG);
 }
diff --git a/providers/mlx5/mlx5.h b/providers/mlx5/mlx5.h
index 1eca478..4656153 100644
--- a/providers/mlx5/mlx5.h
+++ b/providers/mlx5/mlx5.h
@@ -44,9 +44,8 @@
 #include <util/udma_barrier.h>
 #include <util/util.h>
 #include "mlx5-abi.h"
-#include <ccan/bitmap.h>
+#include <util/bitmap.h>
 #include <ccan/list.h>
-#include "bitmap.h"
 #include <ccan/minmax.h>
 #include "mlx5dv.h"
 
@@ -289,7 +288,7 @@ struct mlx5_hca_cap_2_caps {
 };
 
 struct reserved_qpn_blk {
-	bitmap *bmp;
+	unsigned long *bmp;
 	uint32_t first_qpn;
 	struct list_node entry;
 	unsigned int next_avail_slot;
@@ -419,19 +418,11 @@ struct mlx5_context {
 	pthread_mutex_t			crypto_login_mutex;
 };
 
-struct mlx5_bitmap {
-	uint32_t		last;
-	uint32_t		top;
-	uint32_t		max;
-	uint32_t		avail;
-	uint32_t		mask;
-	unsigned long	       *table;
-};
-
 struct mlx5_hugetlb_mem {
 	int			shmid;
 	void		       *shmaddr;
-	struct mlx5_bitmap	bitmap;
+	unsigned long		*bitmap;
+	unsigned long		bmp_size;
 	struct list_node	entry;
 };
 
diff --git a/providers/mlx5/mlx5_vfio.c b/providers/mlx5/mlx5_vfio.c
index 3f1811d..b9cdfeb 100644
--- a/providers/mlx5/mlx5_vfio.c
+++ b/providers/mlx5/mlx5_vfio.c
@@ -142,7 +142,8 @@ static int mlx5_vfio_alloc_page(struct mlx5_vfio_context *ctx, uint64_t *iova)
 	pthread_mutex_lock(&ctx->mem_alloc.block_list_mutex);
 	while (true) {
 		list_for_each(&ctx->mem_alloc.block_list, page_block, next_block) {
-			pg = bitmap_ffs(page_block->free_pages, 0, MLX5_VFIO_BLOCK_NUM_PAGES);
+			pg = bitmap_find_first_bit(page_block->free_pages, 0,
+						   MLX5_VFIO_BLOCK_NUM_PAGES);
 			if (pg != MLX5_VFIO_BLOCK_NUM_PAGES) {
 				bitmap_clear_bit(page_block->free_pages, pg);
 				*iova = page_block->iova + pg * MLX5_ADAPTER_PAGE_SIZE;
diff --git a/providers/mlx5/mlx5_vfio.h b/providers/mlx5/mlx5_vfio.h
index 2165a22..88cc332 100644
--- a/providers/mlx5/mlx5_vfio.h
+++ b/providers/mlx5/mlx5_vfio.h
@@ -163,7 +163,7 @@ struct page_block {
 	void *page_ptr;
 	uint64_t iova;
 	struct list_node next_block;
-	BITMAP_DECLARE(free_pages, MLX5_VFIO_BLOCK_NUM_PAGES);
+	BMP_DECLARE(free_pages, MLX5_VFIO_BLOCK_NUM_PAGES);
 };
 
 struct vfio_mem_allocator {
diff --git a/providers/mlx5/mlx5dv_dr.h b/providers/mlx5/mlx5dv_dr.h
index 16e5340..3cc3035 100644
--- a/providers/mlx5/mlx5dv_dr.h
+++ b/providers/mlx5/mlx5dv_dr.h
@@ -35,7 +35,7 @@
 
 #include <ccan/list.h>
 #include <ccan/minmax.h>
-#include <ccan/bitmap.h>
+#include <util/bitmap.h>
 #include <stdatomic.h>
 #include "mlx5dv.h"
 #include "mlx5_ifc.h"
@@ -1619,9 +1619,9 @@ int dr_send_postsend_action(struct mlx5dv_dr_domain *dmn,
 struct dr_icm_mr;
 
 struct dr_icm_buddy_mem {
-	bitmap			**bits;
+	unsigned long		**bits;
 	unsigned int		*num_free;
-	bitmap			**set_bit;
+	unsigned long		**set_bit;
 	uint32_t		max_order;
 	struct list_node	list_node;
 	struct dr_icm_mr	*icm_mr;
-- 
1.8.3.1

