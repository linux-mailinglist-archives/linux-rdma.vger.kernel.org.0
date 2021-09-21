Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5FA412E9D
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Sep 2021 08:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhIUG3b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Sep 2021 02:29:31 -0400
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com ([40.107.92.50]:52096
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229686AbhIUG3b (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Sep 2021 02:29:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuhShXC0XabUH/kkr1Lrbd8hOAdqOtHOBEjIFZEmRWPQ78qUI1CH8HC3tRgeUw7pJVyKA6z78E00+2io0UEgE25OBeFX2YIHyuwwi5ZVYp8LeLwiMt5ftaV9boYMsOCZmDoNTurG4reh00pj6POJ8F7d89yrnDrNfBu5wSpDmgn91aHZEb2+Ew5SgWcQ/oXtn/wS57mFyUi36HrMs7Twc3OTaKS6AdSmEC3UbK23x62trdGE1Py0TRsRiSNAwoxOCwbbnGZXTG6VXp50J3hGDVOcbKn2Dqdql5cl41XvtoIZN8xWDLabrH94RKyS2Mtj6+WJ/W2CW3kvORBzpFJopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TyH6dVba1CT3KazWgMyIHtm/na+nMwaAiIte1JFHKXA=;
 b=Dc49vsVVuJBFOZ8vuJMvHffe5U48qFP/3et7LQjfMMpbNd5et1SzH28Dy5TkV5npIJRh8MtLoNAoA1HVP1LVYxUElrxcnY2bbW9nrfQYXeltUvVsJgnD3FvUk1tI+Os3h37w2I+y7MW/YSuy2nq1zNJlWLDbId9p1C9wIZk3RG9PeImX/aaL2OHPxHndsWIUe9U+VKYwl9/go4hAUYf9fawZIYzWWsUgqHyOVRci3Vkgqf1eCIqBVphtZsP2ws0UGMMuxkruCKQvObMlFqO9wlO/UDg3Fr1HX/ozryAyYNE8JaA7fc8XjAH7AyFA713+Csn5E6u1iJXSyqiEbqtqIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyH6dVba1CT3KazWgMyIHtm/na+nMwaAiIte1JFHKXA=;
 b=X7K0GOhQxgldeEhIPSPaQ6h8LFVTAHGgmoUBoRaMPiHYuqYWQeL7XtXM2aEIA3NL1dV/H+KLE4+pbAQVdgurcsivxGgvJ+z+G93v2qcoLqMQLDVAP7PlcWpNi91akuNzyEwGCqTAWVLxebrMa67lAIK7Ysie3T5AntUC4vt0d+MZeVpcTByUMfqzGoc1b01DEgKJIZv+IV0r34VMbK5vmmbVd13a9XDibEjZW9WNcxEbuD97d441hdtDEuwA1vD6Pe6sluASG0y6K8v5Ry+LLyATLUxqf9a6+J1u0AGXxD+qx0pwxxJOhYEDh4Wz+JPhbgh419mtvxpPHw3M4zdfcw==
Received: from DM6PR10CA0033.namprd10.prod.outlook.com (2603:10b6:5:60::46) by
 DM4PR12MB5198.namprd12.prod.outlook.com (2603:10b6:5:395::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Tue, 21 Sep 2021 06:28:02 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::75) by DM6PR10CA0033.outlook.office365.com
 (2603:10b6:5:60::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 06:28:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 06:28:02 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 06:28:01 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 21 Sep 2021 06:27:59 +0000
From:   Mark Zhang <markzhang@nvidia.com>
To:     <jgg@nvidia.com>, <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <aharonl@nvidia.com>,
        <netao@nvidia.com>, <leonro@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH iproute2-next 1/3] rdma: Update uapi headers
Date:   Tue, 21 Sep 2021 09:27:24 +0300
Message-ID: <20210921062726.79973-2-markzhang@nvidia.com>
X-Mailer: git-send-email 2.8.4
In-Reply-To: <20210921062726.79973-1-markzhang@nvidia.com>
References: <20210921062726.79973-1-markzhang@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dd4411d-74e7-4f93-7586-08d97cc8f69b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5198:
X-Microsoft-Antispam-PRVS: <DM4PR12MB51988C2F4D3C2F2DF0B57779C7A19@DM4PR12MB5198.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:110;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m5xMQbE20aOi/NkyYNfkc/Lsl9HmtlNQWjPX82XpxmBpjTYF0NVKBgZADbPaSFkBR5hNGE7NyF0JiOfAHmszsUTWOzu08Nmp9mIX2VXel/pCq8RO0i0k6PZ0iA4/V3sxOw4GGLSLGoHynlyx2xI5NvNIczTk9bZu4T5Zi90iQyqrSE+btn6Rj0srbYX17GXfb2/2GXhr8A1/AFEX/mxNmWoPpovLdn4OILt36ykrO1s+A8TuJJL+X1Y1lPzdP7jXJrUeQfXEwAEbYMGaDxTlMqamDO1XKVlSCTk0LRShqzmAR17Rl0SrDsOqLwu+meicpSjjEzl7r2CN/4J6NiBwEawFsu6zP0l3m313IUN+qfHdMj5Xy4s3J/vyhBymnfFhqfMxiGPs/lfyE+kzUJKqB/KnMNCPHsKQuvpObwxw2nQmnxXbBiBv9oAMMK8THEVMxsP/vuC+k9599oh2PPsQSmIlxxykZP8UNzxA6uIUo/e4xqJ4GuM8L7sVQxlMXgvXmWmW1Th/VsLLL1VOn9X3sCm1cD2GHU3zaWiESzS9vpeqE2CXh7J/IdAQ2Hfsb8bn/4l/Q0Qa37Mg/5vXmejjtjcs9/s1QQgigWUi661xbDuGIJ+ep9R1elHWavPHx90AVFHUcETYZN6iDDLv1GizmTronAuCF3ArWG8Ih8rXckwKLHh+eB0ywA1gedSHT4kA16VjYPApj2DxmpRu5Icipw==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36906005)(2616005)(36756003)(1076003)(336012)(4744005)(426003)(107886003)(2906002)(7636003)(4326008)(110136005)(316002)(6666004)(47076005)(83380400001)(70586007)(86362001)(7696005)(5660300002)(8936002)(15650500001)(82310400003)(36860700001)(508600001)(26005)(8676002)(186003)(356005)(70206006)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 06:28:02.1303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd4411d-74e7-4f93-7586-08d97cc8f69b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5198
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Neta Ostrovsky <netao@nvidia.com>

Update rdma_netlink.h file upto kernel commit

Signed-off-by: Neta Ostrovsky <netao@nvidia.com>
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
---
 rdma/include/uapi/rdma/rdma_netlink.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rdma/include/uapi/rdma/rdma_netlink.h b/rdma/include/uapi/rdma/rdma_netlink.h
index 37f583ee..fd347bc7 100644
--- a/rdma/include/uapi/rdma/rdma_netlink.h
+++ b/rdma/include/uapi/rdma/rdma_netlink.h
@@ -549,6 +549,9 @@ enum rdma_nldev_attr {
 
 	RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK,	/* u8 */
 
+	RDMA_NLDEV_ATTR_STAT_HWCOUNTER_INDEX,	/* u32 */
+	RDMA_NLDEV_ATTR_STAT_HWCOUNTER_DYNAMIC, /* u8 0 - disabled, 1 - enabled */
+
 	/*
 	 * Always the end
 	 */
-- 
2.26.2

