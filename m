Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF083CF603
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhGTHhz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:37:55 -0400
Received: from mail-sn1anam02on2082.outbound.protection.outlook.com ([40.107.96.82]:21825
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234295AbhGTHhf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:37:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYJ8JuV74oV7J+Lz6lb66aa+c25Bv/XwMudSP5WHO3th9UgPc+4Lj3PdPC/3SkVX8u9GcGzLFMI8+Qv1opjbcK6TSu2wku0nQpgR0hDyRw3SDPt2s1s/8ilmMMJMeT94UgH9nCXXD3fbXeNjsO1rhLnf7DEfFEU6slbJyzdyvVTC/wQi+iaCsxixSkOcb02z1Unp3/qoGwtvfecrFA6SpEM9koxptc2Ol1wlQfI/HySfQMNjUxKjJZ1nkeAKOJjOcs7tE0HJF5spRAX4b+Y0jUbuWEQE/ceHXsQk7LIr8wnOWedohdvXQsviTHq048PK/Kp+MASXiA7U1SVTcbLNiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPCphE+3kxAFs1ItDDj2b2zmHkhsaBoyg92eSBWCdjk=;
 b=SPNSQ16j+5z3weFZBSd8AK0IYED7lris/gxG9ooGK1eZrYrHz9gyJagjrCwXZNmbD5NYbpKaYu5WGv57WM4pWZmOHmF8nZa+hCS8ZjW4EBId/pavogewWQveSmaANmtdHdBj3mpWRCan9ad2yrhov7MKNtquRqXTvwCJp1g0KEtKaEofkErKYJiNRsXuHLMhIV26ehQ+vsp1VLzPAtfsUb8vRNTnDKUWSN8bbZBWbOXd6VU1OhF7o6D4aRQw6lcU96VbgbJymn9yh4b/zIznTf01iocmb10ewSqPlz/o1LdWE8Fd6byrGQJRR4ydeZJcAVqHK+pkT+0UuIfb67zP0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPCphE+3kxAFs1ItDDj2b2zmHkhsaBoyg92eSBWCdjk=;
 b=fWdQFZtV1ZevA2oA5+FDaqAE214b9aQ3/NNQgVjZ7QcW2MaHbqOftNSIUc/qYygIpXrKWXjte5Y4Ty1D87vknumJ5XJaaIZMtCC9vvGLhWwvQNqzxz081s8akMkGbb5SpG/UUjNtzg6U7jcgOIrfADJimJUQgnGIjVs/CvH6kdZHG6eYhMK6tT2WfR9CiDuach+2Xs4h+eVaPQZQtOBSkhOtLtSPaxCbRZXncX6BfhMwa5ycmoRsFkkkVl744dhC8wu/MlYVAG1uamRBAXqZmAndmSXfUSONOa9IoIVD1quBA/0CevZX/8lUj4Wdscg/8v9hKzBrtaguuOha9z3g5g==
Received: from CO2PR07CA0079.namprd07.prod.outlook.com (2603:10b6:100::47) by
 DM5PR1201MB0236.namprd12.prod.outlook.com (2603:10b6:4:57::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Tue, 20 Jul 2021 08:18:13 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::f0) by CO2PR07CA0079.outlook.office365.com
 (2603:10b6:100::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Tue, 20 Jul 2021 08:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:18:12 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:18:12 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:18:12 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:18:10 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>,
        Ido Kalir <idok@nvidia.com>
Subject: [PATCH rdma-core 19/27] pyverbs/mlx5: Support EQN querying
Date:   Tue, 20 Jul 2021 11:16:39 +0300
Message-ID: <20210720081647.1980-20-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23ea6b54-2612-4b6c-6043-08d94b56eaf0
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0236:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0236B0B08B40033787B7281BC3E29@DM5PR1201MB0236.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dAJf2u8xFrVGN5lnCo6dJQ4opBVP0wp/tmcKPb7aTKMDvcnHxFZsLU2sDe3lMoQCV4xO5OO6vZBAQDm3hc6utk1D/Qt3WLUe+WLnaK1f0wGEESMXh34oGs1WpBrZbu3uTAtl25w8BjFFy7vauP5sg5HKkacQrBGrewuAe+KPhT7gUIvUFjQafEbk/yURs+m3cEHlnA+6BhTIw3uYnlO2vNvBpCoYOqFReH0WJOlPjcMmc7/o2tx6ktAbxBJptse+1hNsarpM9DUwl1eKwkBBz3ixirhPXQERN9TDUBs3j19DjCowLOQmWg+l2CMrNuBh8uTtKHcYcUHOwStHnBxyzlx8DGsfo5T4QYn0Sighe0w3PGwKfBvKno8h/AtNXzk6YqZkxOMblw+wRjv17X+blHI1xh1iyOQb32wDoWHcMEMEvZ6AGqgkT9feVbjTC4d6IhSx5qEodZxwAx9SBEDyqT9MoYU6HIDGDIGNcint/CjSIVTMsJoDEvbcmOxbSuDC3ZXqLj/bAu+5OfuEsecpJ7eaH/d/UcXtxVuIc1AvK11JfY0U4lBz42KIBZxicpD7+MezzwEB4IWJ5fWXrpWWbjxnicvtIF+rgIWYxxWbdIqUnSTvZg/E/VEBpsDRwkd61YlhACAj/Ut5wrxf4exDCYxcyOTCXk6UjGQBL2q61O29elxlE3XXAqkx5Fmt5j7SuWC1aQXBCs6At3KboU6NA==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(46966006)(36840700001)(356005)(7636003)(336012)(36906005)(82310400003)(6916009)(426003)(8676002)(86362001)(7696005)(6666004)(316002)(5660300002)(2616005)(478600001)(26005)(54906003)(4326008)(1076003)(36756003)(36860700001)(186003)(82740400003)(2906002)(107886003)(70586007)(83380400001)(70206006)(8936002)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:18:12.9398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ea6b54-2612-4b6c-6043-08d94b56eaf0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0236
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Edward Srouji <edwards@nvidia.com>

Add the ability to retrieve a device's EQ number which relates to a
given input vector.
The query is done over DevX.

Reviewed-by: Ido Kalir <idok@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 pyverbs/providers/mlx5/libmlx5.pxd |  1 +
 pyverbs/providers/mlx5/mlx5dv.pyx  | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/pyverbs/providers/mlx5/libmlx5.pxd b/pyverbs/providers/mlx5/libmlx5.pxd
index 66b8705..ba2c6ec 100644
--- a/pyverbs/providers/mlx5/libmlx5.pxd
+++ b/pyverbs/providers/mlx5/libmlx5.pxd
@@ -318,6 +318,7 @@ cdef extern from 'infiniband/mlx5dv.h':
     mlx5dv_devx_umem *mlx5dv_devx_umem_reg_ex(v.ibv_context *ctx,
                                               mlx5dv_devx_umem_in *umem_in)
     int mlx5dv_devx_umem_dereg(mlx5dv_devx_umem *umem)
+    int mlx5dv_devx_query_eqn(v.ibv_context *context, uint32_t vector, uint32_t *eqn)
 
     # Mkey setters
     void mlx5dv_wr_mkey_configure(mlx5dv_qp_ex *mqp, mlx5dv_mkey *mkey,
diff --git a/pyverbs/providers/mlx5/mlx5dv.pyx b/pyverbs/providers/mlx5/mlx5dv.pyx
index d16aed1..2c47cb6 100644
--- a/pyverbs/providers/mlx5/mlx5dv.pyx
+++ b/pyverbs/providers/mlx5/mlx5dv.pyx
@@ -262,6 +262,18 @@ cdef class Mlx5Context(Context):
         free(clock_info)
         return ns_time
 
+    def devx_query_eqn(self, vector):
+        """
+        Query EQN for a given vector id.
+        :param vector: Completion vector number
+        :return: The device EQ number which relates to the given input vector
+        """
+        cdef uint32_t eqn
+        rc = dv.mlx5dv_devx_query_eqn(self.context, vector, &eqn)
+        if rc:
+            raise PyverbsRDMAError('Failed to query EQN', rc)
+        return eqn
+
     cdef add_ref(self, obj):
         try:
             Context.add_ref(self, obj)
-- 
1.8.3.1

