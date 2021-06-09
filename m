Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA35F3A1A5B
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 18:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhFIQCQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 12:02:16 -0400
Received: from mail-co1nam11on2087.outbound.protection.outlook.com ([40.107.220.87]:1408
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231783AbhFIQCP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Jun 2021 12:02:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bx0W3GG9FDq6FqSFtmRl4kpL1g6yXeS01ji/Gl+FkmE5lekDRKbSZxGOv0yyzv5uDzLsHA6+emr/K86FjQjex8HuMIQ33v+iEtCzTBvXY8jyxUeGUUM25EeifCUFYP2KEClrJ8nNS6so5xPvPdCUnG1GLuVvhHzX0ciS2i0B93DB8SN4CZ/vkfdu3Om82+AQUZq2FiQW/rMfL9G+dOBoHBKWiP3qAjRNbhook5JZRpKpWjXXAy/SRTcwsTANwYkwW8PzrpY9fAQji9cd+k0MONgI3x+Uuvbe6FxyVYzxEk/phu04Ojg0t9IaPiD7cTwUqyKGEmy7KuWW1m0ChCKe2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se7Q0SBi1s6qk1jefm+deevKBOB2zSwx8mK6A+4bnrs=;
 b=l+7aHWShWMDJJQM3ExAdUwNjitwcAmeRAPXVG2mwobhYFMcUKaaba8i/iyRR53cgqjOJEgxsaz9C4USqoUTcJRdr+nYXJ7t6Y/d3cEA3bD/nSJdmuNJG/T/qrZ29b3rXbMnVQ+EK/h7KUDAn8jDMDTuztSAa70SCLAUAtYysyT3dMpLxo4UOx9rHU4qFOQ3aiiNKCqnHjLUwM3P+4DMYWQj8D4vVgPT56PBSdeJ3vleg+Oiblg2ecPTceGLb4PAKtmcYXB2M2M/9J7BzHz2PUkSaWm98wcrWfmoAp3kABcWco8k2yr5NvcOdbkJv9HbBlLbT751gzRwe77DYE/MlGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se7Q0SBi1s6qk1jefm+deevKBOB2zSwx8mK6A+4bnrs=;
 b=bc3sDguM12PafeQcutVloHPAUxx4gKaFXudu11NukwN9NwC4o1ppN/VJJKB7QAbP1jjAxZ8YooP9XXc5GHvFE/EKrCywwI/v19UBkmnJF+2aw0l6MQSCIpM4fwcKCf4Fg75FzTCZvIQcu14z76KlYwO26YHfdoyPB0axzocBA2ZiJn0jVK531FOeNV2ll+EHZhdMbu+77jP+yOQt08ya+Z7+0skvyt0sz10XJj1vG2Hsd5kreQkSoLfEZ1oYwNLkYdYm0xWeyfEqbeA7TN/KZd8OxzqneUduhMu8DXkcsfnF1hDOH5CG2skw/E20ivMSay3nMQiDSulsmC3H9OGc4Q==
Received: from MW4P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::30)
 by BL0PR12MB4755.namprd12.prod.outlook.com (2603:10b6:208:82::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Wed, 9 Jun
 2021 16:00:19 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::ff) by MW4P220CA0025.outlook.office365.com
 (2603:10b6:303:115::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Wed, 9 Jun 2021 16:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 16:00:19 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Jun
 2021 16:00:06 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Jun 2021 16:00:01 +0000
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@mellanox.com>, <yishaih@mellanox.com>, <maorg@mellanox.com>,
        <phaddad@nvidia.com>, Shachar Kagan <skagan@nvidia.com>,
        Ido Kalir <idok@nvidia.com>, Edward Srouji <edwards@nvidia.com>
Subject: [PATCH rdma-core 3/4] pyverbs: Add query QP data in order support
Date:   Wed, 9 Jun 2021 18:59:31 +0300
Message-ID: <20210609155932.218005-4-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210609155932.218005-1-yishaih@nvidia.com>
References: <20210609155932.218005-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5ab2637-4126-4788-bb6a-08d92b5fae20
X-MS-TrafficTypeDiagnostic: BL0PR12MB4755:
X-Microsoft-Antispam-PRVS: <BL0PR12MB47558736237477ADBE7D5C44C3369@BL0PR12MB4755.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVH4cgpxfmyABpj/l9pRQMl7AcoxBNs5YwBr+N902gk2NTrVSOONz068xlqFCGUdaHceEQEpxiD0QgJjoIXZxFUdObuV7OORh5+me1gG4u1RS/tzMVI+CAFhMgEMbSiQBrPgcWnjtGxUgKYMv3vbFsfadKe8gftpK1mVcdoQ6RwgAEjsUv4LgMxNjBNiO9UgKUMDi4Z1MJh0rKBH/zn8wDGKAbg2H0H+QEoG9OiIFT9+YqNE1kq/zBQUvORB77Ra8fi6NGGosIvzPpCJ9NGL58QL7O0/Y3Y9GYbqaCyICWXHWfzLqtsh8xHYPXE0IXkuaO7dSbQNkBt9U5TTtS/P83AFXXWTFVL/GZPy9DSE1PKX31HDG4e5cJSeA8N4iMv8a3d2QpBe+5p4rHBFHSjIGrDH7CV17T1sEGsVPE6vTm4tgp6/FmDtpzV2r538UFSE2uBU0CxDbZuucuMzyH+3tyc1iK5eY2APfFS6fWCmHf+Y6UJ/OcIagYhCHXKwMqhNqmtX+NSTlLKrn4HkHuKw4WaQ21kOAdAlJPoF98tAn1JG/YvGztVlJMDzpwgd9OR9XqMIAQ/d5ojZrc8eANW8iWV1ui1EU2aANj81l2+oYWp9G2Gqo4ywvITJ6qt+cbZz6X+LFikZrwpX6CS5+mkxX0EqF46x2vYwfn9avV13s1U=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(46966006)(36840700001)(2616005)(8676002)(478600001)(7636003)(36756003)(426003)(336012)(6666004)(107886003)(36860700001)(2906002)(26005)(82740400003)(4326008)(356005)(82310400003)(47076005)(7696005)(5660300002)(86362001)(54906003)(36906005)(316002)(70206006)(70586007)(8936002)(83380400001)(186003)(6916009)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 16:00:19.1744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ab2637-4126-4788-bb6a-08d92b5fae20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4755
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shachar Kagan <skagan@nvidia.com>

Add the ability to check if QP data is guaranteed to be in order.

Signed-off-by: Shachar Kagan <skagan@nvidia.com>
Reviewed-by: Ido Kalir <idok@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 pyverbs/libibverbs.pxd | 1 +
 pyverbs/qp.pyx         | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/pyverbs/libibverbs.pxd b/pyverbs/libibverbs.pxd
index 35e47aa..4c84c18 100644
--- a/pyverbs/libibverbs.pxd
+++ b/pyverbs/libibverbs.pxd
@@ -723,6 +723,7 @@ cdef extern from 'infiniband/verbs.h':
     int ibv_query_rt_values_ex(ibv_context *context, ibv_values_ex *values)
     int ibv_get_async_event(ibv_context *context, ibv_async_event *event)
     void ibv_ack_async_event(ibv_async_event *event)
+    int ibv_query_qp_data_in_order(ibv_qp *qp, ibv_wr_opcode op, uint32_t flags)
 
 
 cdef extern from 'infiniband/driver.h':
diff --git a/pyverbs/qp.pyx b/pyverbs/qp.pyx
index 0b117df..88516f8 100644
--- a/pyverbs/qp.pyx
+++ b/pyverbs/qp.pyx
@@ -1229,6 +1229,15 @@ cdef class QP(PyverbsCM):
         if rc != 0:
             raise PyverbsRDMAError('Failed to Bind MW', rc)
 
+    def query_data_in_order(self, op, flags=0):
+        """
+        Query if QP data is guaranteed to be in order.
+        :param op: Operation type.
+        :param flags: Extra field for future input. For now must be 0.
+        :return: 1 in case the data is guaranteed to be in order, 0 otherwise.
+        """
+        return v.ibv_query_qp_data_in_order(self.qp, op, flags)
+
     @property
     def qp_type(self):
         return self.qp.qp_type
-- 
1.8.3.1

