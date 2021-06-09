Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73333A1A58
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 18:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbhFIQBv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 12:01:51 -0400
Received: from mail-dm6nam11on2052.outbound.protection.outlook.com ([40.107.223.52]:17953
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234008AbhFIQBu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Jun 2021 12:01:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hN8G1lNNVqXE5aFFExwnV6DSz5bc7tMExz0miBVT+Z1Ne6qoWgHxj7W4LUTv3mvb6CIPvsZXCu9+6oFotPH2dDEUs7TXCDpbvHO68yTtVc9+VKAsF0Jh+2zILzZ9oCnlij3z0a+0Aar5c5SSoze038GAIQ2MojW3Z7AIzXFXwApl+01/VDKoYuZZWBMmm1YBVczlTZqREiYKKu4I00YBXDYOuShlmwh9X4ZeY8nlTXj29TkAabGOW1Gsk5nCz9VxcxYzrvKv+HxirNZ7x/1q+4+l/O8pauy2A3Xgq4dw17XJDQnQ4Fml3uPkg0ZwN7TJxO+e4H4TRwySmfpX/yZ7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsuBq1nxnFReU05LeloaeknDCX2EzlPCjfCMhVT7hp0=;
 b=FI9JBhZpqBo1Q/TGs0cdbGru7XcZLi0vbvSH8lEiLlgaSjCylxgHfpbq6umbXuorQIihXGMBLNZzJGKY+JIBt3KJUoVlCpfLAjvStpVp5yFmpzU6lB8xBbQBWWhR+6/+kWRUD+v5d8tRwoyfgqqULPhmaZrLLE+FYuWUM0XIavYBn0kLOpXOostypCtMF1HVZi5Vhw9v34UJLLmTSYsnktttRXz7uJUjKxz45+vEwLYRh9yD/oQW6Cu3rqaJ4Clz5LNbW2JveZTyNEW7qVvtejfKHGW7fwV79BsVhqD/EN0c1j0hHDoQkAg1b+7nULm/DRzqURXXaSta57oxWrLrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsuBq1nxnFReU05LeloaeknDCX2EzlPCjfCMhVT7hp0=;
 b=hNHLYyv2uQgpqFzkSdwMbjHd/eCL9dU0o78gA3aRmyz1Wnp48XzCcne/xOV7jqqK2wg+jzWUPwrPAnUW/KG9/F+qiHfk2zvudyx5DFwA6Qsz9ZWu1FUG2lEunu/YYvBbmoa8VJtCynm3Fwo9J7tmvqfFZpUsy0BuLBWspuJSvGP/ZqsPCpVuP+g7EJzcJj3NopDlyXe0e0ekvaDGXYNQiOyvG/5pXYDppaMHEv40HaLoAe2f1exsq57p4UJJQKAkPrz9eLzQcEttnZLMmQvW0q8geYyMJ8hZPinQG51RUBgg35c1pqHaEzwfYlRxhfZbTlvluJpe0nXTA2k2AQ2bqw==
Received: from BN6PR14CA0038.namprd14.prod.outlook.com (2603:10b6:404:13f::24)
 by DM5PR12MB2486.namprd12.prod.outlook.com (2603:10b6:4:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 9 Jun
 2021 15:59:54 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::b) by BN6PR14CA0038.outlook.office365.com
 (2603:10b6:404:13f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Wed, 9 Jun 2021 15:59:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 15:59:54 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Jun
 2021 15:59:53 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Jun 2021 15:59:49 +0000
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@mellanox.com>, <yishaih@mellanox.com>, <maorg@mellanox.com>,
        <phaddad@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-core 1/4] verbs: Introduce ibv_query_qp_data_in_order() verb
Date:   Wed, 9 Jun 2021 18:59:29 +0300
Message-ID: <20210609155932.218005-2-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210609155932.218005-1-yishaih@nvidia.com>
References: <20210609155932.218005-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3358bac4-b477-451d-0ed4-08d92b5f9f89
X-MS-TrafficTypeDiagnostic: DM5PR12MB2486:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24869A6E342CC00111BE0FECC3369@DM5PR12MB2486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dSLCxc4SBAfbxHsyvqv4lcfTW/I98xdhu9jA65mk7GJsIQwbwmxxqBvpyNQb4AmJaTYw60FbyYXj8mWJJ2dqzo+wBjZsZ3h/BPudo0dtJm/00kJtfVpHhO4C+IDlYOydTeEAtXCYcXyZ4YlX4vp1iuZOZTXDJEdseDw4eAeyRp0tFhTLOPA6DITtrrq8DbwLvxJnkiVu/8snlX/0qoZBLc7hfkaKzARqNyjZyzvdorP7zVIB27tyw7pAMKsKUOYh+di2iXqu0XBDqPOfnEtN5/UobvA01XJD2nK6k06t8eTLA0vzp+wJtBhc3zec0HEnl+NwLDSkjodZkCsXDDZ/0li9tQytrbMa7mt53H+eV8Np3Q4mz8dRuIB2LxD//7kzXw7GaVUpOuP1Bame+QM3lp6Zi1ggJjNV+TfMP4SWXLT1OzE3T+zm3/sq57sjExEMn0erKzzarmv6B/vVE3Cx61cw1eSqG0LV+Os71Ij3h1LQSVmyTta4nOtMcr4bWJsdjEM5nba21P2XvuYhT98EkJkSpkN5DfsU8Qemy620eRPn638z5eOAZLp9i8H53xvXwU+7xkNaAypuFJT/tYhLLgp/YVRyB5rz8YlGCGVGV48dQFAvUbTlXoB1Wf9CaBU5i0r7biKXGlQrtvMmABHn24oby42rVcszm9DQvjku2k=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(36840700001)(46966006)(36906005)(86362001)(54906003)(316002)(7696005)(82310400003)(4001150100001)(5660300002)(186003)(8676002)(1076003)(6916009)(70586007)(70206006)(83380400001)(8936002)(26005)(36756003)(36860700001)(2616005)(336012)(478600001)(7636003)(6666004)(356005)(426003)(4326008)(82740400003)(47076005)(107886003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 15:59:54.5034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3358bac4-b477-451d-0ed4-08d92b5f9f89
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2486
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

Introduce ibv_query_qp_data_in_order() verb, this enables an application
to check whether the receiving data of the local QP is guaranteed to be
in order for a given operation within its WQE.

Once true, it allows user to poll for data instead of poll for
completion.

A detailed man page was added as well.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 debian/libibverbs1.symbols                     |  2 +
 libibverbs/CMakeLists.txt                      |  2 +-
 libibverbs/driver.h                            |  2 +
 libibverbs/dummy_ops.c                         |  8 ++++
 libibverbs/libibverbs.map.in                   |  5 +++
 libibverbs/man/CMakeLists.txt                  |  1 +
 libibverbs/man/ibv_query_qp_data_in_order.3.md | 62 ++++++++++++++++++++++++++
 libibverbs/verbs.c                             |  6 +++
 libibverbs/verbs.h                             | 14 ++++++
 9 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 libibverbs/man/ibv_query_qp_data_in_order.3.md

diff --git a/debian/libibverbs1.symbols b/debian/libibverbs1.symbols
index e7453b5..7b6bc8f 100644
--- a/debian/libibverbs1.symbols
+++ b/debian/libibverbs1.symbols
@@ -11,6 +11,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
  IBVERBS_1.11@IBVERBS_1.11 32
  IBVERBS_1.12@IBVERBS_1.12 34
  IBVERBS_1.13@IBVERBS_1.13 35
+ IBVERBS_1.14@IBVERBS_1.14 36
  (symver)IBVERBS_PRIVATE_34 34
  _ibv_query_gid_ex@IBVERBS_1.11 32
  _ibv_query_gid_table@IBVERBS_1.11 32
@@ -98,6 +99,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
  ibv_query_port@IBVERBS_1.1 1.1.6
  ibv_query_qp@IBVERBS_1.0 1.1.6
  ibv_query_qp@IBVERBS_1.1 1.1.6
+ ibv_query_qp_data_in_order@IBVERBS_1.14 36
  ibv_query_srq@IBVERBS_1.0 1.1.6
  ibv_query_srq@IBVERBS_1.1 1.1.6
  ibv_rate_to_mbps@IBVERBS_1.1 1.1.8
diff --git a/libibverbs/CMakeLists.txt b/libibverbs/CMakeLists.txt
index 16df2c5..3c486b9 100644
--- a/libibverbs/CMakeLists.txt
+++ b/libibverbs/CMakeLists.txt
@@ -21,7 +21,7 @@ configure_file("libibverbs.map.in"
 
 rdma_library(ibverbs "${CMAKE_CURRENT_BINARY_DIR}/libibverbs.map"
   # See Documentation/versioning.md
-  1 1.13.${PACKAGE_VERSION}
+  1 1.14.${PACKAGE_VERSION}
   all_providers.c
   cmd.c
   cmd_ah.c
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index 926023b..8b2e045 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -370,6 +370,8 @@ struct verbs_context_ops {
 			  struct ibv_port_attr *port_attr);
 	int (*query_qp)(struct ibv_qp *qp, struct ibv_qp_attr *attr,
 			int attr_mask, struct ibv_qp_init_attr *init_attr);
+	int (*query_qp_data_in_order)(struct ibv_qp *qp, enum ibv_wr_opcode op,
+				      uint32_t flags);
 	int (*query_rt_values)(struct ibv_context *context,
 			       struct ibv_values_ex *values);
 	int (*query_srq)(struct ibv_srq *srq, struct ibv_srq_attr *srq_attr);
diff --git a/libibverbs/dummy_ops.c b/libibverbs/dummy_ops.c
index 5ed67bf..bf70775 100644
--- a/libibverbs/dummy_ops.c
+++ b/libibverbs/dummy_ops.c
@@ -397,6 +397,12 @@ static int query_ece(struct ibv_qp *qp, struct ibv_ece *ece)
 	return EOPNOTSUPP;
 }
 
+static int query_qp_data_in_order(struct ibv_qp *qp, enum ibv_wr_opcode op,
+				  uint32_t flags)
+{
+	return 0;
+}
+
 static int query_port(struct ibv_context *context, uint8_t port_num,
 		      struct ibv_port_attr *port_attr)
 {
@@ -559,6 +565,7 @@ const struct verbs_context_ops verbs_dummy_ops = {
 	query_ece,
 	query_port,
 	query_qp,
+	query_qp_data_in_order,
 	query_rt_values,
 	query_srq,
 	read_counters,
@@ -683,6 +690,7 @@ void verbs_set_ops(struct verbs_context *vctx,
 	SET_PRIV_OP_IC(vctx, query_ece);
 	SET_PRIV_OP_IC(ctx, query_port);
 	SET_PRIV_OP(ctx, query_qp);
+	SET_PRIV_OP_IC(ctx, query_qp_data_in_order);
 	SET_OP(vctx, query_rt_values);
 	SET_OP(vctx, read_counters);
 	SET_PRIV_OP(ctx, query_srq);
diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
index 7c0fb6a..0e39428 100644
--- a/libibverbs/libibverbs.map.in
+++ b/libibverbs/libibverbs.map.in
@@ -160,6 +160,11 @@ IBVERBS_1.13 {
 		ibv_unimport_dm;
 } IBVERBS_1.12;
 
+IBVERBS_1.14 {
+	global:
+		ibv_query_qp_data_in_order;
+} IBVERBS_1.13;
+
 /* If any symbols in this stanza change ABI then the entire staza gets a new symbol
    version. See the top level CMakeLists.txt for this setting. */
 
diff --git a/libibverbs/man/CMakeLists.txt b/libibverbs/man/CMakeLists.txt
index 4d96e80..712a30f 100644
--- a/libibverbs/man/CMakeLists.txt
+++ b/libibverbs/man/CMakeLists.txt
@@ -64,6 +64,7 @@ rdma_man_pages(
   ibv_query_pkey.3.md
   ibv_query_port.3
   ibv_query_qp.3
+  ibv_query_qp_data_in_order.3.md
   ibv_query_rt_values_ex.3
   ibv_query_srq.3
   ibv_rate_to_mbps.3.md
diff --git a/libibverbs/man/ibv_query_qp_data_in_order.3.md b/libibverbs/man/ibv_query_qp_data_in_order.3.md
new file mode 100644
index 0000000..7558a92
--- /dev/null
+++ b/libibverbs/man/ibv_query_qp_data_in_order.3.md
@@ -0,0 +1,62 @@
+---
+date: 2020-3-3
+footer: libibverbs
+header: "Libibverbs Programmer's Manual"
+layout: page
+license: 'Licensed under the OpenIB.org BSD license (FreeBSD Variant) - See COPYING.md'
+section: 3
+title: ibv_query_qp_data_in_order
+---
+
+# NAME
+
+ibv_query_qp_data_in_order - check if qp data is guaranteed to be in order.
+
+# SYNOPSIS
+
+```c
+#include <infiniband/verbs.h>
+
+int ibv_query_qp_data_in_order(struct ibv_qp *qp, enum ibv_wr_opcode op, uint32_t flags);
+
+```
+
+
+# DESCRIPTION
+
+**ibv_query_qp_data_in_order()** Checks whether WQE data is guaranteed to be
+written in-order, and thus reader may poll for data instead of poll for completion.
+This function indicates data is written in-order within each WQE, but cannot be used to determine ordering between separate WQEs.
+This function describes ordering at the receiving side of the QP, not the sending side.
+
+# ARGUMENTS
+*qp*
+:       The local queue pair (QP) to query.
+
+*op*
+:       The operation type to query about. Different operation types may write data in a different order.
+	For RDMA read operations: describes ordering of RDMA reads posted on this local QP.
+	For RDMA write operations: describes ordering of remote RDMA writes being done into this local QP.
+	For RDMA send operations: describes ordering of remote RDMA sends being done into this local QP.
+	This function should not be used to determine ordering of other operation types.
+
+*flags*
+:	Extra field for future input. For now must be 0.
+
+# RETURN VALUE
+
+**ibv_query_qp_data_in_order()** Returns 1 if the data is guaranteed to be written in-order, 0 otherwise.
+
+# NOTES
+
+Return value is valid only when the data is read by the CPU and relaxed ordering MR is not the target of the transfer.
+
+# SEE ALSO
+
+**ibv_query_qp**(3)
+
+# AUTHOR
+
+Patrisious Haddad <phaddad@nvidia.com>
+
+Yochai Cohen <yochai@nvidia.com>
diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
index b2cba3f..19ff12f 100644
--- a/libibverbs/verbs.c
+++ b/libibverbs/verbs.c
@@ -684,6 +684,12 @@ LATEST_SYMVER_FUNC(ibv_query_qp, 1_1, "IBVERBS_1.1",
 	return 0;
 }
 
+int ibv_query_qp_data_in_order(struct ibv_qp *qp, enum ibv_wr_opcode op,
+			       uint32_t flags)
+{
+	return get_ops(qp->context)->query_qp_data_in_order(qp, op, flags);
+}
+
 LATEST_SYMVER_FUNC(ibv_modify_qp, 1_1, "IBVERBS_1.1",
 		   int,
 		   struct ibv_qp *qp, struct ibv_qp_attr *attr,
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index 7d42095..3dd9a79 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -3148,6 +3148,20 @@ ibv_modify_qp_rate_limit(struct ibv_qp *qp,
 }
 
 /**
+ * ibv_query_qp_data_in_order - Checks whether the data is guaranteed to be
+ *   written in-order.
+ * @qp: The QP to query.
+ * @op: Operation type.
+ * @flags: Extra field for future input. For now must be 0.
+ *
+ * Return Value
+ * ibv_query_qp_data_in_order() returns 1 if the data is guaranteed to be
+ *   written in-order, 0 otherwise.
+ */
+int ibv_query_qp_data_in_order(struct ibv_qp *qp, enum ibv_wr_opcode op,
+			       uint32_t flags);
+
+/**
  * ibv_query_qp - Returns the attribute list and current values for the
  *   specified QP.
  * @qp: The QP to query.
-- 
1.8.3.1

