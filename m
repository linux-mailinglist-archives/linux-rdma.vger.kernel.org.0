Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4837E3A1A5C
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 18:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhFIQCS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 12:02:18 -0400
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com ([40.107.244.72]:36896
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232332AbhFIQCS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Jun 2021 12:02:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYETS1gdm/7U4oqhQD3RHywyS7uzjs7dW4w2txQloapwigUwv0fsFkKX09Vr06+ayZfjGCTg2ZtDmEwyx+6pZXWmKNmAOWi5eZth9QUciokwwd22NmEWLP011OS68Y8nueCgMhhYmSIteLKrnsBKf6exnJki4Pu+lE+L84enrDIMcqyGX7Neop8OjBFGq6tNlFONU+sLidoPXWW+w12sSE4D1s4eujQoib1mVIoo0ri589MWaIN4kqlgfxvqfNN07x7hQDqVG7kflkUnRXUIe3XTFxQ43eCUFfLVHuusbY7KDswNy3plTTRO3q833MHKKHINad4Zc3x5LHkiW+sE5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxQ/sEFt09N32kFATYtl+p86AkR/pHHuMTQB869t9ZU=;
 b=gES0jgjTmwB9YHCR9Nvobu42qyP7QfRoKEyx616usIKx56JwkWZ8SaMVRPKYafcnu8HXLkdjohkmwxcWq71nFn+6gG1aLWsqUDRh8Ll3hM5Ogr4WunlQRt4usIWcjkuJwUUaSffjPbpPLH3xWvNa56OPxWDO+iXL3dA+nXDGaqHrG/GzpmpmHh2soNGdyQNtvQQKpYvB+++OkyytYcLRF8aOI9L1iD6i8mjH2ALebN8Vd1Kb2XqeTABCGyOk5Td09nzTgPCZF/Z4R+9SjKiIpoAfTahTeXzR4xtdyAknvKN9pyXMCa4hPPvlbfz6HL89660wlv46Erx9k7G/fnQ7Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxQ/sEFt09N32kFATYtl+p86AkR/pHHuMTQB869t9ZU=;
 b=L2uX5rBK4X/xBG7q17BubKmOIfS7+9CSPx0IDXrG+OCiKM7Xtv9A2HBJrjVfC394YoshsNwVoxhfEhQelWmoAQF+NafHHxQbmC2BpJUQS64XzfamaUDzFRA8H85YYReNaVdO+aeo5ET6kUolb5WUflnrenhphBKllazFhUHNNUzG24pYZHvPkrJoYwmH2F8pWOc4RwaqaZ41pfkV8ox+9413QGG3+DvAtJXQi2n/P7NEHAbMxkkZiJy7y76KEO1fpwLk/8ZgULfizBvY793d9zQ61Em6eQCYdiMwG8M3rM8rdweZzDa3BroC6PAMb5SGkleYTpjAc/yjgM2lfEOVwA==
Received: from MW4PR04CA0175.namprd04.prod.outlook.com (2603:10b6:303:85::30)
 by MN2PR12MB3391.namprd12.prod.outlook.com (2603:10b6:208:c3::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 16:00:22 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::66) by MW4PR04CA0175.outlook.office365.com
 (2603:10b6:303:85::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Wed, 9 Jun 2021 16:00:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 16:00:22 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Jun
 2021 16:00:11 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Jun 2021 16:00:07 +0000
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@mellanox.com>, <yishaih@mellanox.com>, <maorg@mellanox.com>,
        <phaddad@nvidia.com>, Shachar Kagan <skagan@nvidia.com>,
        Ido Kalir <idok@nvidia.com>, Edward Srouji <edwards@nvidia.com>
Subject: [PATCH rdma-core 4/4] tests: Add query QP data in order coverage
Date:   Wed, 9 Jun 2021 18:59:32 +0300
Message-ID: <20210609155932.218005-5-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210609155932.218005-1-yishaih@nvidia.com>
References: <20210609155932.218005-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46c9d322-289b-4c86-9581-08d92b5faff7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3391:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3391581B9D5033667EECB868C3369@MN2PR12MB3391.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1c8HA7duWwq0gYS8OY6+pxoJCXqRAo0aEmabyXlao01rXIuJub8ftJmA09YhVD9QFmDQQkdmTNQbbpaNKfx6VdU/NY3NdSW2olEEbfJNAsEmfAE4X2k/tnMV0JfpL7BdOZRVMiH7N3k+GgTeQ+L41v4Uslowx2elpgmv0niGrCISzUIHTgePSYzWr1wuIgXao5tzyoMZD8BQblk9M+TExoyQ4nI4fCy2l1zD9GfdJuPOXn/349V6r6Q0HjuuA5SxKj3BmGxLlSVwZi0ksh6NBDItp4HM4hYWcDzwv1Jcbh1rA1pmELwTio/MwHys5juN+P8pINHSGjiw2Oe5hQvMrGOywCJjFThCsmUBHPvmidB9znGIj/kFzbaQkljB7V6duApA/xVYyATgiZiLMgVKVguGSc72DiEU3nlE6nvTk4aysR25NjsRbwpvys99EI7v4Xub2JoAJe5p/kXxa3Jud+CFODRbjCPkTq7nLvjBBT/GyyJ1XqcJrOl1IyfIalrbS1Dxf2+uU8tciknExz9/4KCWR4cfPpdyFrtst0Swglj4znC6I4TjiKyJ5WgtwTGgvQBj9UrRi9Iko/WS3gH2Eb8TpP7JDOk2Zud3oiEma7HTYqQ+Twl4tY0O1GCUhRwTV2MwV9GVD5/f3Tywo5yjAm3uq/Zx5jDR2rtRvu/MbP0=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966006)(36840700001)(316002)(2906002)(6666004)(54906003)(86362001)(7696005)(82310400003)(478600001)(5660300002)(47076005)(36756003)(1076003)(36860700001)(7636003)(356005)(70586007)(36906005)(336012)(8936002)(26005)(186003)(6916009)(8676002)(82740400003)(4326008)(426003)(83380400001)(2616005)(107886003)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 16:00:22.2812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c9d322-289b-4c86-9581-08d92b5faff7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3391
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shachar Kagan <skagan@nvidia.com>

Add a test which queries a QP in RTS state and check if data is
guaranteed to be in order.

Signed-off-by: Shachar Kagan <skagan@nvidia.com>
Reviewed-by: Ido Kalir <idok@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 tests/test_qp.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/test_qp.py b/tests/test_qp.py
index 53b1d32..a623cb3 100644
--- a/tests/test_qp.py
+++ b/tests/test_qp.py
@@ -228,6 +228,19 @@ class QPTest(PyverbsAPITestCase):
         """
         self.query_qp_common_test(e.IBV_QPT_RAW_PACKET)
 
+    def test_query_data_in_order(self):
+        """
+        Queries an UD QP data in order after moving it to RTS state.
+        Verifies that the result from the query is valid.
+        """
+        with PD(self.ctx) as pd:
+            with CQ(self.ctx, 100, None, None, 0) as cq:
+                qia = u.get_qp_init_attr(cq, self.attr)
+                qia.qp_type = e.IBV_QPT_UD
+                qp = self.create_qp(pd, qia, False, True, self.ib_port)
+                is_data_in_order = qp.query_data_in_order(e.IBV_WR_SEND)
+                self.assertIn(is_data_in_order, [0, 1], 'Data in order result is not valid')
+
     def test_modify_ud_qp(self):
         """
         Queries a UD QP after calling modify(). Verifies that its properties are
-- 
1.8.3.1

