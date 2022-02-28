Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBDB4C6505
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 09:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbiB1IuF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 03:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbiB1IuD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 03:50:03 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7F139BA5
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 00:49:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuBHpSzKUyJPtchLNBQWXTxfhf9NCPcOj2/uXKmf0ZUD6r9qUzau5sqsXg5BNIIo4tp3wR5blgMmUkycBUC7nDbVDOoyOoiNfLQfTcz3zLynrv+VI6s5aPoxUQ5CQcALegvJcOkiEmJb0/o2Hv0BUaVDn98Xfw8YanGNCwsi6rgJko5DBGYiPiMxOnYRxwNexbvvz8ehqhhdoPSCDRKlsPwqjrwPsyNriLNdhgTIDy6N8oYJcFej8x03wxTMoPdO4EtDdRGf0QpmiYFKWEKpJXkAryRwx2w9pUth4HIeNQgs61cixTaP2E0pbQkpTEAQ4ss9fMA/funJYZvRfiZRUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJC3xzdEqZmOTR5T9/huWT9XU3UuqecI15Jc3fJrL/c=;
 b=hDzm+9pAFSevMif0RTha22MxXuKQz7i/aXF0YtvbNtVScYBGFaTJ3WjCf0wctOEJsTw2muTCgpoTqIItjw851dU67xiRY2GS3pOPxVB/dOzDuN0JDyo2UBQhk2uD7Ylyn1mXP6oV+tShA5oRjo9OPi1+MUyzcht80hNfSxRkjs6GEMq+wC8ukOQG1orMZXY5BK1LgarxIQLZ3fnySFQEXBP/wd0PDxsI+wJQcM2VO+c2CZHdp7zn6S/yxt1whFSyly6+F9qc5MaCvTkYO1lRrpQs2p1/AHZn6LWefTSnhkWJvJIZ5MeGMt7O+MfYkT2QeruxfhxSqDjZmNIWOoBPlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJC3xzdEqZmOTR5T9/huWT9XU3UuqecI15Jc3fJrL/c=;
 b=bUCBOtElIbiGJpYTwBVw12aGqOu10jdQGwCNQbtFq+uFolYvoBMHdIIN/65Gd541DWHLtfmb7EcDeOB83rm7f4g/Tg96lRdSnK9EcKgikQnsLeUoy0aW/1VrCbvrFkiyiQ95hdAe4SyZX47TUpX1KfptAmyGAxnoik2CRzrUb7FENLbedSbudGFeNANdtd4BDvMbNCIlCsTMbnn6JVbeeYj6F8/hmb9lO5/5599siasU8JgDH84ini7UbfqWHLCPuynAQiZQ3i/Rc2ER7gRlbSoiwKuRmfO9pa3YNzXqoUGzNJ96qCVg4EvwaK/fJaR2x+UFjeorH1UtwErxvVuWIQ==
Received: from BN0PR04CA0050.namprd04.prod.outlook.com (2603:10b6:408:e8::25)
 by BY5PR12MB3761.namprd12.prod.outlook.com (2603:10b6:a03:1af::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 08:49:20 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::2b) by BN0PR04CA0050.outlook.office365.com
 (2603:10b6:408:e8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Mon, 28 Feb 2022 08:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 08:49:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 28 Feb
 2022 08:49:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 28 Feb 2022
 00:49:15 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.9 via Frontend Transport; Mon, 28 Feb
 2022 00:49:13 -0800
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <msanalla@nvidia.com>, <oulijun@huawei.com>,
        Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH rdma-core 5/5] ccan: Remove bitmap code
Date:   Mon, 28 Feb 2022 10:48:30 +0200
Message-ID: <20220228084830.96274-6-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220228084830.96274-1-yishaih@nvidia.com>
References: <20220228084830.96274-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cfbd5b0-9bd0-45ed-add9-08d9fa973624
X-MS-TrafficTypeDiagnostic: BY5PR12MB3761:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3761C8DC02147CB5BE914314C3019@BY5PR12MB3761.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 42Mrwfq2y1VURkHeCKFjNV3xktxEW2HXrEuxAhznPYlawCwFaU4Mv4ffvEQhIJUf/TAlPweKnACVwXKuRxO+vev2ZWd8PZyuydYFszfTZghSA8XhzHPbKBqhRg2PNJg0aBMqxVwMzauQcD7613lrhksMbp4v62/7l1i/7dNV2QBJS7fkfYqmmoozAQncQ0z0ZMyTmRcf4QOBtZFRnHt6GUOlM2ifz3kNU56c/JEHKPtWeQcmM1NXd1rSCcpT6wzS9PxbQ+t6pRCt3HlLMNSopiq9kxdvsz03W87vnJi3yDZ23M0z2s6zNZqqkYqwWSorENJ7oJhv9tPw0SyFidmRPL0gEZUV5X36VtAqqUMpxjHmd5mEUh0zfHHfNfRiMXb0Jd7Y8LESmk446xSM3wztBJIb1Ljfyde5O0vgoMHAe5d/7CKoCzn8WvKqe2S0f/bZ9ftZfVArc6oMkCFvPT5rFb+FBhTnBzyyBAVNDPwS8pMckEyjXgQkGL2ljxhfLOn3xbhCSFjYTbP5Tayhln2505qkTZpjuKX+2+iWmpv8bo2pK6Sgm/lddwuHDaHD7tPtxdPjCWvuYomsWR7lHnA60623k5V9e/UUBGyfJeyFZX5753zd5IfD9a47gEm0YB4SN9CM4X0E2R6X7pfrZo/Axx3RKw6DVboy6pky0A2/K5/UGUb1bamliLMU/G7JnRlxOy1ODSlbVvfZeCs0poCykg==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(83380400001)(36860700001)(107886003)(82310400004)(8936002)(47076005)(1076003)(36756003)(7696005)(26005)(186003)(40460700003)(426003)(336012)(2616005)(508600001)(6916009)(54906003)(316002)(81166007)(356005)(4326008)(8676002)(2906002)(86362001)(5660300002)(70586007)(70206006)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 08:49:20.3296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfbd5b0-9bd0-45ed-add9-08d9fa973624
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3761
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

Removes ccan bitmap implementation, along with adjustments to the
ccan Makefile.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 ccan/CMakeLists.txt |   2 -
 ccan/bitmap.c       | 125 ---------------------------
 ccan/bitmap.h       | 239 ----------------------------------------------------
 3 files changed, 366 deletions(-)
 delete mode 100644 ccan/bitmap.c
 delete mode 100644 ccan/bitmap.h

diff --git a/ccan/CMakeLists.txt b/ccan/CMakeLists.txt
index 5c5c6a2..d370a8e 100644
--- a/ccan/CMakeLists.txt
+++ b/ccan/CMakeLists.txt
@@ -1,6 +1,5 @@
 publish_internal_headers(ccan
   array_size.h
-  bitmap.h
   build_assert.h
   check_type.h
   compiler.h
@@ -13,7 +12,6 @@ publish_internal_headers(ccan
   )
 
 set(C_FILES
-  bitmap.c
   ilog.c
   list.c
   str.c
diff --git a/ccan/bitmap.c b/ccan/bitmap.c
deleted file mode 100644
index ea5531c..0000000
--- a/ccan/bitmap.c
+++ /dev/null
@@ -1,125 +0,0 @@
-/* Licensed under LGPLv2.1+ - see LICENSE file for details */
-
-#include "config.h"
-
-#include <ccan/bitmap.h>
-
-#include <assert.h>
-
-#define BIT_ALIGN_DOWN(n)	((n) & ~(BITMAP_WORD_BITS - 1))
-#define BIT_ALIGN_UP(n)		BIT_ALIGN_DOWN((n) + BITMAP_WORD_BITS - 1)
-
-void bitmap_zero_range(bitmap *bmap, unsigned long n, unsigned long m)
-{
-	unsigned long an = BIT_ALIGN_UP(n);
-	unsigned long am = BIT_ALIGN_DOWN(m);
-	bitmap_word headmask = -1ULL >> (n % BITMAP_WORD_BITS);
-	bitmap_word tailmask = ~(-1ULL >> (m % BITMAP_WORD_BITS));
-
-	assert(m >= n);
-
-	if (am < an) {
-		BITMAP_WORD(bmap, n) &= ~bitmap_bswap(headmask & tailmask);
-		return;
-	}
-
-	if (an > n)
-		BITMAP_WORD(bmap, n) &= ~bitmap_bswap(headmask);
-
-	if (am > an)
-		memset(&BITMAP_WORD(bmap, an), 0,
-		       (am - an) / BITMAP_WORD_BITS * sizeof(bitmap_word));
-
-	if (m > am)
-		BITMAP_WORD(bmap, m) &= ~bitmap_bswap(tailmask);
-}
-
-void bitmap_fill_range(bitmap *bmap, unsigned long n, unsigned long m)
-{
-	unsigned long an = BIT_ALIGN_UP(n);
-	unsigned long am = BIT_ALIGN_DOWN(m);
-	bitmap_word headmask = -1ULL >> (n % BITMAP_WORD_BITS);
-	bitmap_word tailmask = ~(-1ULL >> (m % BITMAP_WORD_BITS));
-
-	assert(m >= n);
-
-	if (am < an) {
-		BITMAP_WORD(bmap, n) |= bitmap_bswap(headmask & tailmask);
-		return;
-	}
-
-	if (an > n)
-		BITMAP_WORD(bmap, n) |= bitmap_bswap(headmask);
-
-	if (am > an)
-		memset(&BITMAP_WORD(bmap, an), 0xff,
-		       (am - an) / BITMAP_WORD_BITS * sizeof(bitmap_word));
-
-	if (m > am)
-		BITMAP_WORD(bmap, m) |= bitmap_bswap(tailmask);
-}
-
-static int bitmap_clz(bitmap_word w)
-{
-#if HAVE_BUILTIN_CLZL
-	return __builtin_clzl(w);
-#else
-	int lz = 0;
-	bitmap_word mask = 1UL << (BITMAP_WORD_BITS - 1);
-
-	while (!(w & mask)) {
-		lz++;
-		mask >>= 1;
-	}
-
-	return lz;
-#endif
-}
-
-unsigned long bitmap_ffs(const bitmap *bmap,
-			 unsigned long n, unsigned long m)
-{
-	unsigned long an = BIT_ALIGN_UP(n);
-	unsigned long am = BIT_ALIGN_DOWN(m);
-	bitmap_word headmask = -1ULL >> (n % BITMAP_WORD_BITS);
-	bitmap_word tailmask = ~(-1ULL >> (m % BITMAP_WORD_BITS));
-
-	assert(m >= n);
-
-	if (am < an) {
-		bitmap_word w = bitmap_bswap(BITMAP_WORD(bmap, n));
-
-		w &= (headmask & tailmask);
-
-		return w ? am + bitmap_clz(w) : m;
-	}
-
-	if (an > n) {
-		bitmap_word w = bitmap_bswap(BITMAP_WORD(bmap, n));
-
-		w &= headmask;
-
-		if (w)
-			return BIT_ALIGN_DOWN(n) + bitmap_clz(w);
-	}
-
-	while (an < am) {
-		bitmap_word w = bitmap_bswap(BITMAP_WORD(bmap, an));
-
-		if (w)
-			return an + bitmap_clz(w);
-
-		an += BITMAP_WORD_BITS;
-	}
-
-	if (m > am) {
-		bitmap_word w = bitmap_bswap(BITMAP_WORD(bmap, m));
-
-		w &= tailmask;
-
-		if (w)
-			return am + bitmap_clz(w);
-	}
-
-	return m;
-}
diff --git a/ccan/bitmap.h b/ccan/bitmap.h
deleted file mode 100644
index ff0b8c8..0000000
--- a/ccan/bitmap.h
+++ /dev/null
@@ -1,239 +0,0 @@
-/* Licensed under LGPLv2+ - see LICENSE file for details */
-#ifndef CCAN_BITMAP_H_
-#define CCAN_BITMAP_H_
-
-#include <stdbool.h>
-#include <stdlib.h>
-#include <string.h>
-#include <limits.h>
-
-typedef unsigned long bitmap_word;
-
-#define BITMAP_WORD_BITS	(sizeof(bitmap_word) * CHAR_BIT)
-#define BITMAP_NWORDS(_n)	\
-	(((_n) + BITMAP_WORD_BITS - 1) / BITMAP_WORD_BITS)
-
-/*
- * We wrap each word in a structure for type checking.
- */
-typedef struct {
-	bitmap_word w;
-} bitmap;
-
-#define BITMAP_DECLARE(_name, _nbits) \
-	bitmap (_name)[BITMAP_NWORDS(_nbits)]
-
-static inline size_t bitmap_sizeof(unsigned long nbits)
-{
-	return BITMAP_NWORDS(nbits) * sizeof(bitmap_word);
-}
-
-static inline bitmap_word bitmap_bswap(bitmap_word w)
-{
-	/* We do not need to have the bitmap in any specific endianness */
-	return w;
-}
-
-#define BITMAP_WORD(_bm, _n)	((_bm)[(_n) / BITMAP_WORD_BITS].w)
-#define BITMAP_WORDBIT(_n) 	\
-	(bitmap_bswap(1UL << (BITMAP_WORD_BITS - ((_n) % BITMAP_WORD_BITS) - 1)))
-
-#define BITMAP_HEADWORDS(_nbits) \
-	((_nbits) / BITMAP_WORD_BITS)
-#define BITMAP_HEADBYTES(_nbits) \
-	(BITMAP_HEADWORDS(_nbits) * sizeof(bitmap_word))
-
-#define BITMAP_TAILWORD(_bm, _nbits) \
-	((_bm)[BITMAP_HEADWORDS(_nbits)].w)
-#define BITMAP_HASTAIL(_nbits)	(((_nbits) % BITMAP_WORD_BITS) != 0)
-#define BITMAP_TAILBITS(_nbits)	\
-	(bitmap_bswap(~(-1UL >> ((_nbits) % BITMAP_WORD_BITS))))
-#define BITMAP_TAIL(_bm, _nbits) \
-	(BITMAP_TAILWORD(_bm, _nbits) & BITMAP_TAILBITS(_nbits))
-
-static inline void bitmap_set_bit(bitmap *bmap, unsigned long n)
-{
-	BITMAP_WORD(bmap, n) |= BITMAP_WORDBIT(n);
-}
-
-static inline void bitmap_clear_bit(bitmap *bmap, unsigned long n)
-{
-	BITMAP_WORD(bmap, n) &= ~BITMAP_WORDBIT(n);
-}
-
-static inline void bitmap_change_bit(bitmap *bmap, unsigned long n)
-{
-	BITMAP_WORD(bmap, n) ^= BITMAP_WORDBIT(n);
-}
-
-static inline bool bitmap_test_bit(const bitmap *bmap, unsigned long n)
-{
-	return !!(BITMAP_WORD(bmap, n) & BITMAP_WORDBIT(n));
-}
-
-void bitmap_zero_range(bitmap *bmap, unsigned long n, unsigned long m);
-void bitmap_fill_range(bitmap *bmap, unsigned long n, unsigned long m);
-
-static inline void bitmap_zero(bitmap *bmap, unsigned long nbits)
-{
-	memset(bmap, 0, bitmap_sizeof(nbits));
-}
-
-static inline void bitmap_fill(bitmap *bmap, unsigned long nbits)
-{
-	memset(bmap, 0xff, bitmap_sizeof(nbits));
-}
-
-static inline void bitmap_copy(bitmap *dst, const bitmap *src,
-			       unsigned long nbits)
-{
-	memcpy(dst, src, bitmap_sizeof(nbits));
-}
-
-#define BITMAP_DEF_BINOP(_name, _op) \
-	static inline void bitmap_##_name(bitmap *dst, bitmap *src1, bitmap *src2, \
-					  unsigned long nbits)		\
-	{ \
-		unsigned long i = 0; \
-		for (i = 0; i < BITMAP_NWORDS(nbits); i++) { \
-			dst[i].w = src1[i].w _op src2[i].w; \
-		} \
-	}
-
-BITMAP_DEF_BINOP(and, &)
-BITMAP_DEF_BINOP(or, |)
-BITMAP_DEF_BINOP(xor, ^)
-BITMAP_DEF_BINOP(andnot, & ~)
-
-#undef BITMAP_DEF_BINOP
-
-static inline void bitmap_complement(bitmap *dst, const bitmap *src,
-				     unsigned long nbits)
-{
-	unsigned long i;
-
-	for (i = 0; i < BITMAP_NWORDS(nbits); i++)
-		dst[i].w = ~src[i].w;
-}
-
-static inline bool bitmap_equal(const bitmap *src1, const bitmap *src2,
-				unsigned long nbits)
-{
-	return (memcmp(src1, src2, BITMAP_HEADBYTES(nbits)) == 0)
-		&& (!BITMAP_HASTAIL(nbits)
-		    || (BITMAP_TAIL(src1, nbits) == BITMAP_TAIL(src2, nbits)));
-}
-
-static inline bool bitmap_intersects(const bitmap *src1, const bitmap *src2,
-				     unsigned long nbits)
-{
-	unsigned long i;
-
-	for (i = 0; i < BITMAP_HEADWORDS(nbits); i++) {
-		if (src1[i].w & src2[i].w)
-			return true;
-	}
-	if (BITMAP_HASTAIL(nbits) &&
-	    (BITMAP_TAIL(src1, nbits) & BITMAP_TAIL(src2, nbits)))
-		return true;
-	return false;
-}
-
-static inline bool bitmap_subset(const bitmap *src1, const bitmap *src2,
-				 unsigned long nbits)
-{
-	unsigned long i;
-
-	for (i = 0; i < BITMAP_HEADWORDS(nbits); i++) {
-		if (src1[i].w  & ~src2[i].w)
-			return false;
-	}
-	if (BITMAP_HASTAIL(nbits) &&
-	    (BITMAP_TAIL(src1, nbits) & ~BITMAP_TAIL(src2, nbits)))
-		return false;
-	return true;
-}
-
-static inline bool bitmap_full(const bitmap *bmap, unsigned long nbits)
-{
-	unsigned long i;
-
-	for (i = 0; i < BITMAP_HEADWORDS(nbits); i++) {
-		if (bmap[i].w != -1UL)
-			return false;
-	}
-	if (BITMAP_HASTAIL(nbits) &&
-	    (BITMAP_TAIL(bmap, nbits) != BITMAP_TAILBITS(nbits)))
-		return false;
-
-	return true;
-}
-
-static inline bool bitmap_empty(const bitmap *bmap, unsigned long nbits)
-{
-	unsigned long i;
-
-	for (i = 0; i < BITMAP_HEADWORDS(nbits); i++) {
-		if (bmap[i].w != 0)
-			return false;
-	}
-	if (BITMAP_HASTAIL(nbits) && (BITMAP_TAIL(bmap, nbits) != 0))
-		return false;
-
-	return true;
-}
-
-unsigned long bitmap_ffs(const bitmap *bmap,
-			 unsigned long n, unsigned long m);
-
-/*
- * Allocation functions
- */
-static inline bitmap *bitmap_alloc(unsigned long nbits)
-{
-	return malloc(bitmap_sizeof(nbits));
-}
-
-static inline bitmap *bitmap_alloc0(unsigned long nbits)
-{
-	bitmap *bmap;
-
-	bmap = bitmap_alloc(nbits);
-	if (bmap)
-		bitmap_zero(bmap, nbits);
-	return bmap;
-}
-
-static inline bitmap *bitmap_alloc1(unsigned long nbits)
-{
-	bitmap *bmap;
-
-	bmap = bitmap_alloc(nbits);
-	if (bmap)
-		bitmap_fill(bmap, nbits);
-	return bmap;
-}
-
-static inline bitmap *bitmap_realloc0(bitmap *bmap, unsigned long obits,
-				      unsigned long nbits)
-{
-	bmap = realloc(bmap, bitmap_sizeof(nbits));
-
-	if ((nbits > obits) && bmap)
-		bitmap_zero_range(bmap, obits, nbits);
-
-	return bmap;
-}
-
-static inline bitmap *bitmap_realloc1(bitmap *bmap, unsigned long obits,
-				      unsigned long nbits)
-{
-	bmap = realloc(bmap, bitmap_sizeof(nbits));
-
-	if ((nbits > obits) && bmap)
-		bitmap_fill_range(bmap, obits, nbits);
-
-	return bmap;
-}
-
-#endif /* CCAN_BITMAP_H_ */
-- 
1.8.3.1

