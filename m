Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60314C6506
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 09:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbiB1IuG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 03:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiB1IuC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 03:50:02 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC0938BC0
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 00:49:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kO43RiJMGHBLccqHns8J/9c6jHXKU0fEMXPwk0bo24TCmpUv0QaA641sLGNJvS7p3UT0Jq6eiwwAmMGnCkJgBZ4poAikuvzqhlSL5CnnLz7Ih7Ux7ICNZXaAr4V2M2Td2Lo7hW1W+MBnoi19yl7PVSL+pMassY77yOiNu+poVyjwv7mXskReBTwNYeZCrdT7s+1RNWUfgsZDFpB7T5W2OhF6zbkATSQV3D9VhCd16QY/cUQD4TwsQNr0LGO7YLIq+kdUmFoBZFrS0QB6aYqDCz7U9KQCZ835aUM52A85CrCPQNIm3+RaccwlGL8L3g9el3yqc+i6xDx9WdhzdrkRsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHEXWYtDQMnt0Hc5VSFNTf1Qm8eIexqP7WsK57ATNro=;
 b=KJt6ThXH/fpmHO/kAJAH6srQKM8r+M0KUjs8QGJ1ML8YGnINq3f0rQFnK4I9TAS3Pg3LIt8+FqRtiuYAV8/E5pOCB8tfR2yOJLniFxP5vlnszoeka4gGvY3/ToM3YdtZ79vv/H4Tyq4ZtMGM4tkKux+Unc49JYMnGp8onU6MFw1Eynxdl1KlyYOd7uzQCQY22qb6OSS0FZmDrZ65sEpXwOYSAH3AJld81mP9a/dJPZc5jeID3wPOCKzi28EX0eS49HdMfZRDjrkQwl+3ERd+n5VXxFxhfswLjVgATg4mDlsyjajidWWaazCuozEtLGpvy4IdGukZffojkgXs0L1GZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHEXWYtDQMnt0Hc5VSFNTf1Qm8eIexqP7WsK57ATNro=;
 b=QVShPhITw+7t0oUywjTFd2Xr4mkRX8k9TbRRqiem2AfvRIV/DbCSVJKkOcXeHAF71MIplVkfZujL0DFejYLE3fzieS+8eA65SUqcvPGCQUMoYHUdChpmfs0RnEpHceYtDVanceG7sOy8VqNKM213tX9FXjBKb2LMUg+mVHTDyJb+p4ElMLmyduyxqVb7qpfi3LIbtetXpAEytWO9vD4/ORJpWrOHp8WuuskGBIoMJ3jM6UgXUuUmM9yAmJPIh4dyJJ8E8xXt+qAIYlf6AJk5vwze62jjAW5Nz16D+xlKUwsPtsVplDrOBEPQPPJ4NgK8Od4qBPMAEHJQpBft8ahrjw==
Received: from DM5PR21CA0025.namprd21.prod.outlook.com (2603:10b6:3:ed::11) by
 MW4PR12MB5603.namprd12.prod.outlook.com (2603:10b6:303:16a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 08:49:13 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::52) by DM5PR21CA0025.outlook.office365.com
 (2603:10b6:3:ed::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.1 via Frontend
 Transport; Mon, 28 Feb 2022 08:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 08:49:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 28 Feb
 2022 08:49:13 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 28 Feb 2022
 00:49:12 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.9 via Frontend Transport; Mon, 28 Feb
 2022 00:49:10 -0800
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <msanalla@nvidia.com>, <oulijun@huawei.com>,
        Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH rdma-core 4/5] verbs: Adapt bitmap usage to use util API
Date:   Mon, 28 Feb 2022 10:48:29 +0200
Message-ID: <20220228084830.96274-5-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220228084830.96274-1-yishaih@nvidia.com>
References: <20220228084830.96274-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10fb8446-2fc2-4b40-4dcb-08d9fa9732ca
X-MS-TrafficTypeDiagnostic: MW4PR12MB5603:EE_
X-Microsoft-Antispam-PRVS: <MW4PR12MB5603338903DCEFD766D33C6AC3019@MW4PR12MB5603.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ta81KSxpcbeJe3edgpShZ/fpasEK4MipTDz5iVjJgbsGn5X2IXKGsyFpcwoz43FHejmH0C3BuTXf4yIbQZsUmMlxFMcgroYy7i+fh4Hox2y4BgFp9EcfekK41kzpUhqQwn6TF8VPamJ61DeCi+VwSkMtlYnQyVknJy94GkvCKj23ek//52TDB+mReTRUkoYOo6YMyP9VlN04SoE0G0fOc8wh9LzkI88WOFns/3k/a62TjFpC1Rg5miEosa0fIMbEKFAQITKObvTBhqsi77zN5/g3mgfFVfAo5wselP9ZlycmY8tZAtXHsoPbNEoz2UhZGS+vpDoWljGcsVKrrBxMGvP+/+eqwZMKeRz71JhoIjdlhBuuV7U5/WhvfFw/UCcKrgUNh8jUHsOK6WTw9kC7Ag3+MQFnONyaR1KzVWyhfDpLTEU9WL2o7WDeD8p1caM4ZGV8COFspCMcmVC43rXfAObHYlfSNreWsbmFmULLpdYWJczkdO/1jd/LMBy2sMdylzwWxGvwVCsSt/CNb3HSZfSZhLTZL/wyo+g+eqwP1dkEArORqi5IFM76an2Th3hQJBG8vaIlHuVJ6pVLbayctI9sEdFaxEoH1pomApG5GuYtbiYT289Dds8h1LRpDpUsKFXvI5Ker6S+zqi5xHFjmUDG+VJikfdWeZ/49sxCmLl6HpsElYZLaU0Mm7Wta5ClbtzXV3X9mGtEBySqylEWQ==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2616005)(1076003)(40460700003)(54906003)(316002)(47076005)(70586007)(6916009)(86362001)(26005)(336012)(186003)(426003)(508600001)(36860700001)(2906002)(81166007)(82310400004)(70206006)(5660300002)(36756003)(356005)(107886003)(7696005)(6666004)(8936002)(8676002)(4744005)(4326008)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 08:49:14.7510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fb8446-2fc2-4b40-4dcb-08d9fa9732ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5603
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
 libibverbs/ibverbs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libibverbs/ibverbs.h b/libibverbs/ibverbs.h
index 5e60ace..33f83a7 100644
--- a/libibverbs/ibverbs.h
+++ b/libibverbs/ibverbs.h
@@ -37,7 +37,7 @@
 #include <pthread.h>
 
 #include <infiniband/driver.h>
-#include <ccan/bitmap.h>
+#include <util/bitmap.h>
 
 #define INIT		__attribute__((constructor))
 
@@ -70,7 +70,7 @@ void load_drivers(void);
 #endif
 
 struct verbs_ex_private {
-	BITMAP_DECLARE(unsupported_ioctls, VERBS_OPS_NUM);
+	BMP_DECLARE(unsupported_ioctls, VERBS_OPS_NUM);
 	uint32_t driver_id;
 	bool use_ioctl_write;
 	struct verbs_context_ops ops;
-- 
1.8.3.1

