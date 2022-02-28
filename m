Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78A04C6507
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 09:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbiB1IuH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 03:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiB1IuC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 03:50:02 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B053968F
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 00:49:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKUmbHoDUxnZ/XjW9720R1/1XZJm9c8xefXNLkhRHPoojmlT/8KBmTBtFNOaOMECJMTtDvc9s/p8PXItYHWR4ch2YqhT0XBPFBe5KXvKMMx3uqIHQI9GUSWFFbDmwAnM/ekZlNxq+27hj3lTZ9S3b7Y0SJRLcDz1BWW3bRJhwKMRvmcEuYJXldpgdKLVK9WjHtQrrzOLQ626qtVuP776DPK91118NOObGv3wLm2ch1nFTsaLq36QsitzA/3GNTSPzDWO9HNqg52TADpNPqu0BaQmhMkbwgBq2IPbw91aOInf1wGuB2s15x4NtIV9yGFp/AJwHRz4aRJrD0Ktmck6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/hqhnu7S18/YyLUfRGRO4z4qgbe9nF2fAYOgo1wNRY=;
 b=NAaCqAyfhayL1TUlvNN+H0gWcjLDeamB+n11/IDYmHEpOHv9QB7fcIOUSKmw5CTvN3FK4o1Tu17bikFwpxRL/N+/cNtao6kYJpPuEdKJ6MzE/7VunQSxru5lWxQRWlYsl/vkLF8RDj4hbZIJ/spW95EsujXtFLZbqUbtQlAl+knZVGqbfRjbTMXFdkV7W+sJBjgNW2JmHaKbX2xbToQ5IIQow48eFtPrjar9sV010fSy6d5aewx73eW8FKWKlbGDMzxemwKMleBCquEx24t1vidq4NaemPjZe88n6fJqDAZGWHqQKwUZo32db+tH8VytiN7X44GGX8YuhFIELPmM7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/hqhnu7S18/YyLUfRGRO4z4qgbe9nF2fAYOgo1wNRY=;
 b=VSNibjfTElSRS47mFCAt+kv0aT8ot4n3nEWPqZzUKzDsk+6K4etB2akhOVZknee5X8uDcxG3fMm6HYhtg+PRw7fueIAbcuulgZ6xJEUt/0c8x2QTO5XZyRmKkEKMx9xWXh5efGLmYna4yYKTGpbd2v9QU4M6Kstei9/uSzXtF4de1MjNDQoMVyoEnyDLIdri+Pp/SebBVhZIYWuzI2yhXoMrVsyiIo/OiSQR3/XuW8XSFZVTLoeAvO3c/T5XtOod7cKP24qPYdaRX0tJOLCve46pBpOp6hCvuZbeq/jcE8k9RXxQip7bM9G96hcCBGAr0r/Da8RgJnGCGfGth61U/g==
Received: from BN0PR04CA0052.namprd04.prod.outlook.com (2603:10b6:408:e8::27)
 by DM6PR12MB2665.namprd12.prod.outlook.com (2603:10b6:5:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Mon, 28 Feb
 2022 08:49:20 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::46) by BN0PR04CA0052.outlook.office365.com
 (2603:10b6:408:e8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Mon, 28 Feb 2022 08:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 08:49:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 28 Feb
 2022 08:49:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 28 Feb 2022
 00:49:09 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.9 via Frontend Transport; Mon, 28 Feb
 2022 00:49:07 -0800
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <msanalla@nvidia.com>, <oulijun@huawei.com>,
        Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH rdma-core 3/5] libhns: Adapt bitmap usage to use util API
Date:   Mon, 28 Feb 2022 10:48:28 +0200
Message-ID: <20220228084830.96274-4-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220228084830.96274-1-yishaih@nvidia.com>
References: <20220228084830.96274-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d52c956e-e639-42d1-7dc9-08d9fa97356f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2665:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2665825F2BFAC39EBE85FD07C3019@DM6PR12MB2665.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0RTci3JRYr4eFVwfWL92xfE7RZGaCHiYX0r4cGvB9b1OcMiDCc8M6l6cb3MFz01aPr/XzDILK1mNZZNLJXjOuVyVqCeqcyA/zSZCwqtHIYbGil+mSiixgUD62WAnYsncCwySW4exV6Bc5wUSUb3e1bXEpprTDV7osUVpkQYx+ppujv28ra8lwOaLYyssRUljvmIcEOUwPAFd4BC6frcV3FYhtvXN2lAfKY6vNJwORq2oBqa9/bs7i0W3HBCRVLBOwITEqYLwUzfPLWOoNZohk1iR0AvkJuOr7e9W99c3PxI6vkIQkkiXcfZfd16lkUDEkMM6UyPVQHkqoFV1Nlp8lQoTW0qEV6lz62dzoy8M2YyrlsmQBRGgZSeHKS6UZlSEFTFVQTq8xF/vOCQpPJ+M6aVfJP8bv5ai+AseAReq5FhgRTVAcQz8NTqnRKv/8NCGVKAgjMJ3Wh18kRtol3tHZNBBf+rdrYt2zzEpmSi+OfX29VfBb1dur5mN2MMpKR5yL+UQ2p1CCwV3/A7gEkxQsf+lY8MVxq0uDxLsiA6h6fwCQ6d919Du5BOKZwBZz+uFB7BdnExEzenZFAOdqzizhjy7ppjr4TBvxRpNZcBBvqpyZ8/Y6Y7VHS2tf91tKbC28MIdWIslIAZptuQEorIyI86kHD1/kJmh9XCEKh32UjJo5jT+TT6lQV+W+LC+onGiRlyU9HP0AjsXBVbX8kUV8Q==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(86362001)(36756003)(1076003)(6666004)(2616005)(7696005)(508600001)(107886003)(26005)(336012)(426003)(186003)(54906003)(83380400001)(6916009)(47076005)(36860700001)(70206006)(70586007)(4326008)(8676002)(316002)(5660300002)(81166007)(8936002)(356005)(82310400004)(2906002)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 08:49:19.1265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d52c956e-e639-42d1-7dc9-08d9fa97356f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2665
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

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 providers/hns/hns_roce_u.h    | 4 ++--
 providers/hns/hns_roce_u_db.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
index 2b4ba18..d786efb 100644
--- a/providers/hns/hns_roce_u.h
+++ b/providers/hns/hns_roce_u.h
@@ -42,7 +42,7 @@
 #include <util/util.h>
 #include <infiniband/verbs.h>
 #include <ccan/array_size.h>
-#include <ccan/bitmap.h>
+#include <util/bitmap.h>
 #include <ccan/container_of.h>
 #include <linux/if_ether.h>
 #include "hns_roce_u_abi.h"
@@ -193,7 +193,7 @@ struct hns_roce_db_page {
 	struct hns_roce_buf	buf;
 	unsigned int		num_db;
 	unsigned int		use_cnt;
-	bitmap			*bitmap;
+	unsigned long		*bitmap;
 };
 
 struct hns_roce_context {
diff --git a/providers/hns/hns_roce_u_db.c b/providers/hns/hns_roce_u_db.c
index f7aaa6e..f5acac2 100644
--- a/providers/hns/hns_roce_u_db.c
+++ b/providers/hns/hns_roce_u_db.c
@@ -33,7 +33,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <stdio.h>
-#include <ccan/bitmap.h>
+#include <util/bitmap.h>
 #include "hns_roce_u.h"
 #include "hns_roce_u_db.h"
 
@@ -109,7 +109,7 @@ void *hns_roce_alloc_db(struct hns_roce_context *ctx,
 found:
 	++page->use_cnt;
 
-	npos = bitmap_ffs(page->bitmap, 0, page->num_db);
+	npos = bitmap_find_first_bit(page->bitmap, 0, page->num_db);
 	bitmap_clear_bit(page->bitmap, npos);
 	db = page->buf.buf + npos * db_size[type];
 
-- 
1.8.3.1

