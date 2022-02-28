Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5644C6504
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 09:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbiB1IuD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 03:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiB1IuB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 03:50:01 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5D836E16
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 00:49:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkbFakF1d4yUgCPVi3lQl3eNtjvgiVlmSWV7t5HTEhzP/XMBh1f6s2d2Mkr7QGeXIio50CclTff4JaEUL7NSUeru+3boNsxix2PMmdSdENkBLnUUpv3kyOcEgHKo1BQGUIJsCfHQe6ZMH82bAClyI7I7aCHaMSxg18yWXQCBQzHp/4B7vy8fdFnwIlU8bHlQge9CTGROo68mnGVp8lVkVtBM9p4p+JC8ucESRTzhQgQ6BpVUYa76LcXsUsSNV9e5qmbN/1qZX1JNe2p3zmSSsZ5YicFwlKcb9/+CRzMehI7TNp9VoEM2+P3eD0i4ywb8UzqLexxpXFYG7eG66bCGPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRiN0joKavkHRGNddfgERd6WKP7A9+TrcRfQu6Dk2tg=;
 b=JdDtEyfw4DelRh4r/gRPCQW1n594gJ7ARFz9V6IvW6YWtNSM0Wf1NVga8/EVZAYTqYOG6CRG5C9lP/ijVS0W4PV1FXQT3BfyX7Yjyh5EGDCffW/P8AlU2gAlO98rmlJxb+Z5d/TuytzVkh1tHHo0iR3JIbYVd3vyZvt6L6je7gUGg1Rh+TR1aBLlSY0dQnz2n9NAJpzx3UdUOIK9a8525RLNFRZkYrDsOvv8njH7shPROXc0mnVMQsfPQmk1xdaUhMOwhsg5ZzQE5uCXdQIv19xokpA52XrAFnAWXK1HVEqvK2uFrs19tmCTTIlEUHPx3Sd5Fg6iy+qjSya9LAdcXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRiN0joKavkHRGNddfgERd6WKP7A9+TrcRfQu6Dk2tg=;
 b=tn6RJllzXoE8jgnp8R5qLQiEnDZBz9REdxx8VV2BIItXCkiCmnWofMNCtBkMsGbnJtYc1q8PxHN++SvEzYjs9zUVJt0OA0ot4ma01qDe88/hjg4V+gwcX9grx+ub/hnWqSMWGoPBzZ5iwMOLcH8PhgfJS+LLCwdc/X3ueNsTi4boSYxhNaHs8nIBWsv3oNX39e6H2qWaZuJ+mMueqHCcvUIhHTiupnbc7MLoanFklsqKfGEfZBbSV8Rl4F9Jw/gpT3fPkAQj1+woyeWQcsKXTQCLDnX65rZSfXi3BLJmU1RoW5RxfpGNOLyu1GbWEwYm4ypp+v6MeeW0PfGRCkS6aQ==
Received: from BN8PR12CA0013.namprd12.prod.outlook.com (2603:10b6:408:60::26)
 by CH2PR12MB3782.namprd12.prod.outlook.com (2603:10b6:610:23::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 08:49:07 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::88) by BN8PR12CA0013.outlook.office365.com
 (2603:10b6:408:60::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Mon, 28 Feb 2022 08:49:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 08:49:06 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 28 Feb
 2022 08:49:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 28 Feb 2022
 00:49:04 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.9 via Frontend Transport; Mon, 28 Feb
 2022 00:49:02 -0800
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <msanalla@nvidia.com>, <oulijun@huawei.com>,
        Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH rdma-core 1/5] util: Add new bitmap API
Date:   Mon, 28 Feb 2022 10:48:26 +0200
Message-ID: <20220228084830.96274-2-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220228084830.96274-1-yishaih@nvidia.com>
References: <20220228084830.96274-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 329abb35-534c-429b-20ba-08d9fa972de0
X-MS-TrafficTypeDiagnostic: CH2PR12MB3782:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB37826126E9191E6A08D5A576C3019@CH2PR12MB3782.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 63Qb8FZ13r5HqgPVH1fJKUrMDGA1Whc3f+cBbxylidBLzcQ0eInB02umv8Y7wnRFQgxsHchjj1sIzLyL7oDyrTRxqTdWErsgD8JfAMQgCNqBP0y1wF+7jE7hwihL4S2w0Ty+Vty/k3B5w8L+skfnf0/s6xsK58wrCEXCkNCcdv+tO7jrZz8N9sIu2kwMvNbVRdZImkFoCVAhtBek1m1TRyA4RKl1mz7EgiQrl23IWYDlah5q6QKiyHvG2C89KCwQBF8otr/ZawHChvWqj70YTQrX2hQISBaKJdvU53CWzRgKoVo4+9fxQkEYdKQlWFqpakTLP4mWE5YmDRQnNfhGxZyWXkC1w71Ml4IB3/kWmI67DoXFuIpkzNwxpYOKYogekHfVuuPBVXNYo/YwGBEbYuQhYtEox1saWDBDP0rW/fZ7mPhjx/tHKagISRPvbXyCrqCGVSlBNPAOCGZ8VEWXGQeEeby/s6PqZdcH1bEC/Wm8ZK7NcDNm8mZg00npZczmstES+BwX+WcpWCagm2ElvOEcAOGO7zmJNljTzdYOysERXoKU1qEwxA6csl00ouymiLWYRj56qRgpf9x8IUoJZCvykTle40twTsH40VOC0S4aWiBYEhbwBbpM2bGBgW6Da7N65Iumpf8TBFcZP9Em3/sqb3+I2gFAN+/cTjlPlH80BGZjXR/8NK42+sG3lMuevpb8AS1kPxHT+Wa2gU07nQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(1076003)(8676002)(4326008)(2906002)(82310400004)(36860700001)(2616005)(7696005)(70206006)(70586007)(508600001)(86362001)(6666004)(8936002)(107886003)(40460700003)(81166007)(5660300002)(356005)(54906003)(6916009)(336012)(186003)(26005)(316002)(36756003)(426003)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 08:49:06.3961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 329abb35-534c-429b-20ba-08d9fa972de0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3782
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

Adds new bitmap implementation to util directory, which replaces the
ccan equivalent, due to the license used (LGPLv2+) which is not fitting
in rdma-core.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 providers/mlx5/bitmap.h |   2 -
 util/CMakeLists.txt     |   2 +
 util/bitmap.c           | 180 ++++++++++++++++++++++++++++++++++++++++++++++++
 util/bitmap.h           | 120 ++++++++++++++++++++++++++++++++
 util/util.h             |   1 +
 5 files changed, 303 insertions(+), 2 deletions(-)
 create mode 100644 util/bitmap.c
 create mode 100644 util/bitmap.h

diff --git a/providers/mlx5/bitmap.h b/providers/mlx5/bitmap.h
index 034fb98..b2c8a36 100644
--- a/providers/mlx5/bitmap.h
+++ b/providers/mlx5/bitmap.h
@@ -54,8 +54,6 @@
 #define MLX5_SHMAT_FLAGS 0
 #endif
 
-#define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_LONG)
-
 #ifndef HPAGE_SIZE
 #define HPAGE_SIZE		(2UL * 1024 * 1024)
 #endif
diff --git a/util/CMakeLists.txt b/util/CMakeLists.txt
index d8a66be..58c77d5 100644
--- a/util/CMakeLists.txt
+++ b/util/CMakeLists.txt
@@ -1,4 +1,5 @@
 publish_internal_headers(util
+  bitmap.h
   cl_qmap.h
   compiler.h
   interval_set.h
@@ -9,6 +10,7 @@ publish_internal_headers(util
   )
 
 set(C_FILES
+  bitmap.c
   cl_map.c
   interval_set.c
   node_name_map.c
diff --git a/util/bitmap.c b/util/bitmap.c
new file mode 100644
index 0000000..e5ed30e
--- /dev/null
+++ b/util/bitmap.c
@@ -0,0 +1,180 @@
+/* GPLv2 or OpenIB.org BSD (MIT) See COPYING file */
+
+#include "bitmap.h"
+
+#define BMP_WORD_INDEX(n) (BITS_TO_LONGS((n) + 1) - 1)
+#define BMP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
+#define BMP_LAST_WORD_MASK(end) (~BMP_FIRST_WORD_MASK(end))
+
+static unsigned long __word_ffs(const unsigned long *word)
+{
+	unsigned long i;
+
+	for (i = 0; i < BITS_PER_LONG; i++) {
+		if (bitmap_test_bit(word, i))
+			return i;
+	}
+
+	return i;
+}
+
+static unsigned long word_ffs(const unsigned long *word,
+			      unsigned long bmp_index, unsigned long end)
+{
+	unsigned long set_bit;
+
+	set_bit = __word_ffs(word);
+	set_bit += bmp_index * BITS_PER_LONG;
+	if (set_bit >= end)
+		return end;
+
+	return set_bit;
+}
+
+/*
+ * Finds the first set bit in the bitmap starting from
+ * 'start' bit until ('end'-1) bit.
+ *
+ * Returns the set bit index if found, otherwise returns 'end'.
+ */
+unsigned long bitmap_find_first_bit(const unsigned long *bmp,
+				    unsigned long start, unsigned long end)
+{
+	unsigned long mask;
+	unsigned long first_word;
+	unsigned long curr_idx = BMP_WORD_INDEX(start);
+	unsigned long end_idx = BMP_WORD_INDEX(end);
+
+	assert(start <= end);
+
+	mask = BMP_FIRST_WORD_MASK(start);
+
+	first_word = bmp[curr_idx] & mask;
+	if (first_word)
+		return word_ffs(&first_word, curr_idx, end);
+
+	for (curr_idx++; curr_idx <= end_idx; curr_idx++) {
+		if (!bmp[curr_idx])
+			continue;
+
+		return word_ffs(&bmp[curr_idx], curr_idx, end);
+	}
+
+	return end;
+}
+
+/*
+ * Zeroes bitmap bits in the following range: [start,end-1]
+ */
+void bitmap_zero_region(unsigned long *bmp, unsigned long start,
+			unsigned long end)
+{
+	unsigned long start_mask;
+	unsigned long last_mask;
+	unsigned long curr_idx = BMP_WORD_INDEX(start);
+	unsigned long end_idx = BMP_WORD_INDEX(end);
+
+	assert(start <= end);
+
+	start_mask = BMP_FIRST_WORD_MASK(start);
+	last_mask = BMP_LAST_WORD_MASK(end);
+
+	if (curr_idx == end_idx) {
+		bmp[curr_idx] &= ~(start_mask & last_mask);
+		return;
+	}
+
+	bmp[curr_idx] &= ~start_mask;
+
+	for (curr_idx++; curr_idx < end_idx; curr_idx++)
+		bmp[curr_idx] = 0;
+
+	bmp[curr_idx] &= ~last_mask;
+}
+
+/*
+ * Sets bitmap bits in the following range: [start,end-1]
+ */
+void bitmap_fill_region(unsigned long *bmp, unsigned long start,
+			unsigned long end)
+{
+	unsigned long start_mask;
+	unsigned long last_mask;
+	unsigned long curr_idx = BMP_WORD_INDEX(start);
+	unsigned long end_idx = BMP_WORD_INDEX(end);
+
+	assert(start <= end);
+
+	start_mask = BMP_FIRST_WORD_MASK(start);
+	last_mask = BMP_LAST_WORD_MASK(end);
+
+	if (curr_idx == end_idx) {
+		bmp[curr_idx] |= (start_mask & last_mask);
+		return;
+	}
+
+	bmp[curr_idx] |= start_mask;
+
+	for (curr_idx++; curr_idx < end_idx; curr_idx++)
+		bmp[curr_idx] = ULONG_MAX;
+
+	bmp[curr_idx] |= last_mask;
+}
+
+/*
+ * Checks whether the contiguous region of region_size bits starting from
+ * start is free.
+ *
+ * Returns true if the said region is free, otherwise returns false.
+ */
+static bool bitmap_is_free_region(unsigned long *bmp, unsigned long start,
+				  unsigned long region_size)
+{
+	unsigned long curr_idx;
+	unsigned long last_idx;
+	unsigned long last_mask;
+	unsigned long start_mask;
+
+	curr_idx = BMP_WORD_INDEX(start);
+	start_mask = BMP_FIRST_WORD_MASK(start);
+	last_idx = BMP_WORD_INDEX(start + region_size);
+	last_mask = BMP_LAST_WORD_MASK(start + region_size);
+
+	if (curr_idx == last_idx)
+		return !(bmp[curr_idx] & start_mask & last_mask);
+
+	if (bmp[curr_idx] & start_mask)
+		return false;
+
+	for (curr_idx++; curr_idx < last_idx; curr_idx++) {
+		if (bmp[curr_idx])
+			return false;
+	}
+
+	return !(bmp[curr_idx] & last_mask);
+}
+
+/*
+ * Finds a contiguous region with the size of region_size
+ * in the bitmap that is not set.
+ *
+ * Returns first index of such region if found,
+ * otherwise returns nbits.
+ */
+unsigned long bitmap_find_free_region(unsigned long *bmp,
+				      unsigned long nbits,
+				      unsigned long region_size)
+{
+	unsigned long start;
+
+	for (start = 0; start + region_size <= nbits; start++) {
+		if (bitmap_test_bit(bmp, start))
+			continue;
+
+		if (bitmap_is_free_region(bmp, start, region_size))
+			return start;
+	}
+
+	return nbits;
+}
+
diff --git a/util/bitmap.h b/util/bitmap.h
new file mode 100644
index 0000000..c48706a
--- /dev/null
+++ b/util/bitmap.h
@@ -0,0 +1,120 @@
+/* GPLv2 or OpenIB.org BSD (MIT) See COPYING file */
+
+#ifndef UTIL_BITMAP_H
+#define UTIL_BITMAP_H
+
+#include <stdlib.h>
+#include <stdbool.h>
+#include <limits.h>
+#include <string.h>
+#include <assert.h>
+
+#include "util.h"
+
+#define BMP_DECLARE(name, nbits) \
+	unsigned long (name)[BITS_TO_LONGS((nbits))]
+
+unsigned long bitmap_find_first_bit(const unsigned long *bmp,
+				    unsigned long start, unsigned long end);
+
+void bitmap_zero_region(unsigned long *bmp, unsigned long start,
+			unsigned long end);
+
+void bitmap_fill_region(unsigned long *bmp, unsigned long start,
+			unsigned long end);
+
+unsigned long bitmap_find_free_region(unsigned long *bmp,
+				      unsigned long nbits,
+				      unsigned long region_size);
+
+static inline void bitmap_fill(unsigned long *bmp, unsigned long nbits)
+{
+	unsigned long size = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+
+	memset(bmp, 0xff, size);
+}
+
+static inline void bitmap_zero(unsigned long *bmp, unsigned long nbits)
+{
+	unsigned long size = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+
+	memset(bmp, 0, size);
+}
+
+static inline bool bitmap_empty(const unsigned long *bmp, unsigned long nbits)
+{
+	unsigned long i;
+	unsigned long mask = ULONG_MAX;
+
+	assert(nbits);
+
+	for (i = 0; i < BITS_TO_LONGS(nbits) - 1; i++) {
+		if (bmp[i] != 0)
+			return false;
+	}
+
+	if (nbits % BITS_PER_LONG)
+		mask = (1UL << (nbits % BITS_PER_LONG)) - 1;
+
+	return (bmp[i] & mask) ? false : true;
+}
+
+static inline bool bitmap_full(const unsigned long *bmp, unsigned long nbits)
+{
+	unsigned long i;
+	unsigned long mask = ULONG_MAX;
+
+	assert(nbits);
+
+	for (i = 0; i < BITS_TO_LONGS(nbits) - 1; i++) {
+		if (bmp[i] != -1UL)
+			return false;
+	}
+
+	if (nbits % BITS_PER_LONG)
+		mask = (1UL << (nbits % BITS_PER_LONG)) - 1;
+
+	return ((bmp[i] & mask) ^ (mask)) ? false : true;
+}
+
+static inline void bitmap_set_bit(unsigned long *bmp, unsigned long idx)
+{
+	bmp[(idx / BITS_PER_LONG)] |= (1UL << (idx % BITS_PER_LONG));
+}
+
+static inline void bitmap_clear_bit(unsigned long *bmp, unsigned long idx)
+{
+	bmp[(idx / BITS_PER_LONG)] &= ~(1UL << (idx % BITS_PER_LONG));
+}
+
+static inline bool bitmap_test_bit(const unsigned long *bmp, unsigned long idx)
+{
+	return !!(bmp[(idx / BITS_PER_LONG)] &
+		 (1UL << (idx % BITS_PER_LONG)));
+}
+
+static inline unsigned long *bitmap_alloc0(unsigned long size)
+{
+	unsigned long *bmp;
+
+	bmp = calloc(BITS_TO_LONGS(size), sizeof(long));
+	if (!bmp)
+		return NULL;
+
+	return bmp;
+}
+
+static inline unsigned long *bitmap_alloc1(unsigned long size)
+{
+	unsigned long *bmp;
+
+	bmp = bitmap_alloc0(size);
+	if (!bmp)
+		return NULL;
+
+	bitmap_fill(bmp, size);
+
+	return bmp;
+}
+
+#endif
diff --git a/util/util.h b/util/util.h
index f721b83..af03c42 100644
--- a/util/util.h
+++ b/util/util.h
@@ -28,6 +28,7 @@ static inline bool __good_snprintf(size_t len, int rc)
 
 #define BITS_PER_LONG	   (8 * sizeof(long))
 #define BITS_PER_LONG_LONG (8 * sizeof(long long))
+#define BITS_TO_LONGS(nr)  (((nr) + BITS_PER_LONG - 1) / BITS_PER_LONG)
 
 #define GENMASK(h, l) \
 	(((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
-- 
1.8.3.1

