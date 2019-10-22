Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57F57E0D00
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 22:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733008AbfJVUF6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 16:05:58 -0400
Received: from mail-eopbgr680068.outbound.protection.outlook.com ([40.107.68.68]:10926
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731806AbfJVUF6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Oct 2019 16:05:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oqggk30s6DvlPNmstpQMh3UxBeBsJ8zXkOW2aJrs2QSwCbirlbCwKS5Bam5WvMbG8pjp3sE0vRsMfnb/H5PUK34zpCz4QqSrCSs24i/ihP7ZUAGJl/yK2mWp6KJPclDqxON4XPKy3KsMHQKoShWhPj8229wKB4Gh1TdpedM672ZzlgeR6H2QwYJTCY8mUM7THMnmRClHKu5Foer5pkCy3UwFyEStrklRGXAB3cvIYFs9sqjxdqW4iyAb6mqB+VfbVcPVqh6KJDxFtep5nDLDVXmhsquFzMZsctZT5RLLVv4FMVxYtzR90ivqGv+Pkd1+87oVmKQj3BbOAyz66ucyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxdNgXdUh3b90EvBvlLF5VtPUWA2wLYeUYgUKSIinqM=;
 b=cS53I+++GsHe8WOQXxCdETobemlmuncgTOysa5fLsjhB4Xva8MEQKqwwfXzXdxF/T6iHv2/+Ctu+AVCPSMDlNtojlub06kJo+Fr53BsogrCQgjZE42f5mgevs1rtDJo+UciLVCzsO9PgZztcCI/SRVwN1PUzkV8Mj1Rk92HREzgeDr7Zmr+rayItgKaAFJtiPsfQAmhEcj+FiuKhaJTGoBXRryEwP9N/QRCMMwQZHWdrOwVwP9XZ/RUYtETBgLfbuUYAFbdWf8k7TVbRqiXHXF5f8B0aX6PHUlVpgWpOoAQ291fnPpouddIQzB8j+imn7bw4yTFmRsHe8D+2YMNumQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxdNgXdUh3b90EvBvlLF5VtPUWA2wLYeUYgUKSIinqM=;
 b=0FUNkya0uHm+YDTkPUx53hqqCrAaMrhOF+CkS9dSyTMpdjjFoiustp9vNI1344+U9ptdsmTXmUuUDi74m6M2Ou2l7wRATN+KAnkf8a2TBDwfHDCDkEChoqXPqtQfZ/YaAr2jaf61yKEcHMLovMMCUCPYrxuW4OC7SkUkjV0NPOY=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB5173.namprd05.prod.outlook.com (20.177.229.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.14; Tue, 22 Oct 2019 20:05:54 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::c992:3ec7:35ca:d345]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::c992:3ec7:35ca:d345%7]) with mapi id 15.20.2387.016; Tue, 22 Oct 2019
 20:05:54 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     "jgg@mellanox.com" <jgg@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Adit Ranadive <aditr@vmware.com>
Subject: [PATCH rdma-core v3 1/3] Update kernel headers
Thread-Topic: [PATCH rdma-core v3 1/3] Update kernel headers
Thread-Index: AQHViRQceZJdFjUS8U6X2LLqqK+lOA==
Date:   Tue, 22 Oct 2019 20:05:54 +0000
Message-ID: <4998e00880dc741386ecfc9c1540011ecffe2b9b.1571774292.git.aditr@vmware.com>
References: <cover.1571774291.git.aditr@vmware.com>
In-Reply-To: <cover.1571774291.git.aditr@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:a03:54::24) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
x-mailer: git-send-email 2.18.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c52ea79f-2243-4203-7fd1-08d7572b3eb8
x-ms-traffictypediagnostic: BYAPR05MB5173:|BYAPR05MB5173:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB51738BBACF37F8B85851A85EC5680@BYAPR05MB5173.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(199004)(189003)(71200400001)(110136005)(26005)(6116002)(7736002)(66066001)(6512007)(2501003)(71190400001)(52116002)(2906002)(102836004)(99286004)(6506007)(305945005)(76176011)(386003)(3846002)(6486002)(186003)(5660300002)(486006)(6436002)(476003)(2616005)(11346002)(446003)(14444005)(8676002)(66446008)(64756008)(66556008)(66476007)(66946007)(4326008)(81166006)(81156014)(8936002)(50226002)(316002)(256004)(36756003)(86362001)(25786009)(2201001)(118296001)(478600001)(107886003)(14454004)(15650500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5173;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MJi9yFY+o8jKlrNXvL4MAPRjp0Hvt4DKeX4F7bkX6eUB6qiX7RAJSsgo3olp9j0EdPqfFa6vMPA7Y0arCqZSgX21ylkzkdEya8S79MZAKh4do4MEmmrsOeEmfEhrBwnmhW35o8icGpReqwu4Mokx8vvFv36xatStUeBjnNn0xk/6rHm4yLTeJtSloY/l6qZua3wu+VdVw0T1VSrQFKow9w8l0Xf+AwRfS+KTJFHcIi1lGvxE7adtj1Txdbsya53P0hx2FFY/7XsiDcK7VCVl66HJwGFIO6Yc5P6zOCM/ZYnWv5Y2OuhGLjCIciUHRQG+fTqOvl2SDbjNggkkLc71t+5AqmRjEjRKBB7QtWF4Erfx0XqszzB0n0yev/CGnNPuLk3JBtvUd/BG5cDR0QLf9F/4Rmi0wGx5wkugNr7Tgr9t3NKL9uWA0tU1HbLAnRSU
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52ea79f-2243-4203-7fd1-08d7572b3eb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 20:05:54.6371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YuFzlxj766gfhBHcm6DzYPBi7J+l055oxaR2mTpwKB8DQPV8yDEusv3xL+Q+oWfqQh4AYV5Q43dZ5m6gX3AyWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5173
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To commit ?? ("RDMA/vmw_pvrdma: Use resource ids from physical device if
available")

Signed-off-by: Adit Ranadive <aditr@vmware.com>
---
 kernel-headers/CMakeLists.txt              |  2 +-
 kernel-headers/rdma/cxgb3-abi.h            | 82 ----------------------
 kernel-headers/rdma/ib_user_ioctl_verbs.h  | 22 ++++++
 kernel-headers/rdma/rdma_user_ioctl_cmds.h | 22 ------
 kernel-headers/rdma/rvt-abi.h              | 66 +++++++++++++++++
 kernel-headers/rdma/vmw_pvrdma-abi.h       |  5 ++
 6 files changed, 94 insertions(+), 105 deletions(-)
 delete mode 100644 kernel-headers/rdma/cxgb3-abi.h
 create mode 100644 kernel-headers/rdma/rvt-abi.h

diff --git a/kernel-headers/CMakeLists.txt b/kernel-headers/CMakeLists.txt
index 50bc77e6ab6e..543e0ea1408a 100644
--- a/kernel-headers/CMakeLists.txt
+++ b/kernel-headers/CMakeLists.txt
@@ -1,6 +1,5 @@
 publish_internal_headers(rdma
   rdma/bnxt_re-abi.h
-  rdma/cxgb3-abi.h
   rdma/cxgb4-abi.h
   rdma/efa-abi.h
   rdma/hns-abi.h
@@ -23,6 +22,7 @@ publish_internal_headers(rdma
   rdma/rdma_user_ioctl.h
   rdma/rdma_user_ioctl_cmds.h
   rdma/rdma_user_rxe.h
+  rdma/rvt-abi.h
   rdma/siw-abi.h
   rdma/vmw_pvrdma-abi.h
   )
diff --git a/kernel-headers/rdma/cxgb3-abi.h b/kernel-headers/rdma/cxgb3-ab=
i.h
deleted file mode 100644
index 85aed672f43e..000000000000
--- a/kernel-headers/rdma/cxgb3-abi.h
+++ /dev/null
@@ -1,82 +0,0 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-Op=
enIB) */
-/*
- * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
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
-#ifndef CXGB3_ABI_USER_H
-#define CXGB3_ABI_USER_H
-
-#include <linux/types.h>
-
-#define IWCH_UVERBS_ABI_VERSION	1
-
-/*
- * Make sure that all structs defined in this file remain laid out so
- * that they pack the same way on 32-bit and 64-bit architectures (to
- * avoid incompatibility between 32-bit userspace and 64-bit kernels).
- * In particular do not use pointer types -- pass pointers in __aligned_u6=
4
- * instead.
- */
-struct iwch_create_cq_req {
-	__aligned_u64 user_rptr_addr;
-};
-
-struct iwch_create_cq_resp_v0 {
-	__aligned_u64 key;
-	__u32 cqid;
-	__u32 size_log2;
-};
-
-struct iwch_create_cq_resp {
-	__aligned_u64 key;
-	__u32 cqid;
-	__u32 size_log2;
-	__u32 memsize;
-	__u32 reserved;
-};
-
-struct iwch_create_qp_resp {
-	__aligned_u64 key;
-	__aligned_u64 db_key;
-	__u32 qpid;
-	__u32 size_log2;
-	__u32 sq_size_log2;
-	__u32 rq_size_log2;
-};
-
-struct iwch_reg_user_mr_resp {
-	__u32 pbl_addr;
-};
-
-struct iwch_alloc_pd_resp {
-	__u32 pdid;
-};
-
-#endif /* CXGB3_ABI_USER_H */
diff --git a/kernel-headers/rdma/ib_user_ioctl_verbs.h b/kernel-headers/rdm=
a/ib_user_ioctl_verbs.h
index 72c7fc75f960..9019b2d906ea 100644
--- a/kernel-headers/rdma/ib_user_ioctl_verbs.h
+++ b/kernel-headers/rdma/ib_user_ioctl_verbs.h
@@ -173,4 +173,26 @@ struct ib_uverbs_query_port_resp_ex {
 	__u8  reserved[6];
 };
=20
+enum rdma_driver_id {
+	RDMA_DRIVER_UNKNOWN,
+	RDMA_DRIVER_MLX5,
+	RDMA_DRIVER_MLX4,
+	RDMA_DRIVER_CXGB3,
+	RDMA_DRIVER_CXGB4,
+	RDMA_DRIVER_MTHCA,
+	RDMA_DRIVER_BNXT_RE,
+	RDMA_DRIVER_OCRDMA,
+	RDMA_DRIVER_NES,
+	RDMA_DRIVER_I40IW,
+	RDMA_DRIVER_VMW_PVRDMA,
+	RDMA_DRIVER_QEDR,
+	RDMA_DRIVER_HNS,
+	RDMA_DRIVER_USNIC,
+	RDMA_DRIVER_RXE,
+	RDMA_DRIVER_HFI1,
+	RDMA_DRIVER_QIB,
+	RDMA_DRIVER_EFA,
+	RDMA_DRIVER_SIW,
+};
+
 #endif
diff --git a/kernel-headers/rdma/rdma_user_ioctl_cmds.h b/kernel-headers/rd=
ma/rdma_user_ioctl_cmds.h
index b8bb285f6b2a..7b1ec806f8f9 100644
--- a/kernel-headers/rdma/rdma_user_ioctl_cmds.h
+++ b/kernel-headers/rdma/rdma_user_ioctl_cmds.h
@@ -84,26 +84,4 @@ struct ib_uverbs_ioctl_hdr {
 	struct ib_uverbs_attr  attrs[0];
 };
=20
-enum rdma_driver_id {
-	RDMA_DRIVER_UNKNOWN,
-	RDMA_DRIVER_MLX5,
-	RDMA_DRIVER_MLX4,
-	RDMA_DRIVER_CXGB3,
-	RDMA_DRIVER_CXGB4,
-	RDMA_DRIVER_MTHCA,
-	RDMA_DRIVER_BNXT_RE,
-	RDMA_DRIVER_OCRDMA,
-	RDMA_DRIVER_NES,
-	RDMA_DRIVER_I40IW,
-	RDMA_DRIVER_VMW_PVRDMA,
-	RDMA_DRIVER_QEDR,
-	RDMA_DRIVER_HNS,
-	RDMA_DRIVER_USNIC,
-	RDMA_DRIVER_RXE,
-	RDMA_DRIVER_HFI1,
-	RDMA_DRIVER_QIB,
-	RDMA_DRIVER_EFA,
-	RDMA_DRIVER_SIW,
-};
-
 #endif
diff --git a/kernel-headers/rdma/rvt-abi.h b/kernel-headers/rdma/rvt-abi.h
new file mode 100644
index 000000000000..7c05a02d2be5
--- /dev/null
+++ b/kernel-headers/rdma/rvt-abi.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cl=
ause) */
+
+/*
+ * This file contains defines, structures, etc. that are used
+ * to communicate between kernel and user code.
+ */
+
+#ifndef RVT_ABI_USER_H
+#define RVT_ABI_USER_H
+
+#include <linux/types.h>
+#include <rdma/ib_user_verbs.h>
+#ifndef RDMA_ATOMIC_UAPI
+#define RDMA_ATOMIC_UAPI(_type, _name) struct{ _type val; } _name
+#endif
+
+struct rvt_wqe_sge {
+	__aligned_u64 addr;
+	__u32 length;
+	__u32 lkey;
+};
+
+/*
+ * This structure is used to contain the head pointer, tail pointer,
+ * and completion queue entries as a single memory allocation so
+ * it can be mmap'ed into user space.
+ */
+struct rvt_cq_wc {
+	/* index of next entry to fill */
+	RDMA_ATOMIC_UAPI(__u32, head);
+	/* index of next ib_poll_cq() entry */
+	RDMA_ATOMIC_UAPI(__u32, tail);
+
+	/* these are actually size ibcq.cqe + 1 */
+	struct ib_uverbs_wc uqueue[];
+};
+
+/*
+ * Receive work request queue entry.
+ * The size of the sg_list is determined when the QP (or SRQ) is created
+ * and stored in qp->r_rq.max_sge (or srq->rq.max_sge).
+ */
+struct rvt_rwqe {
+	__u64 wr_id;
+	__u8 num_sge;
+	__u8 padding[7];
+	struct rvt_wqe_sge sg_list[];
+};
+
+/*
+ * This structure is used to contain the head pointer, tail pointer,
+ * and receive work queue entries as a single memory allocation so
+ * it can be mmap'ed into user space.
+ * Note that the wq array elements are variable size so you can't
+ * just index into the array to get the N'th element;
+ * use get_rwqe_ptr() for user space and rvt_get_rwqe_ptr()
+ * for kernel space.
+ */
+struct rvt_rwq {
+	/* new work requests posted to the head */
+	RDMA_ATOMIC_UAPI(__u32, head);
+	/* receives pull requests from here. */
+	RDMA_ATOMIC_UAPI(__u32, tail);
+	struct rvt_rwqe wq[];
+};
+#endif /* RVT_ABI_USER_H */
diff --git a/kernel-headers/rdma/vmw_pvrdma-abi.h b/kernel-headers/rdma/vmw=
_pvrdma-abi.h
index 6e73f0274e41..f8b638c73371 100644
--- a/kernel-headers/rdma/vmw_pvrdma-abi.h
+++ b/kernel-headers/rdma/vmw_pvrdma-abi.h
@@ -179,6 +179,11 @@ struct pvrdma_create_qp {
 	__aligned_u64 qp_addr;
 };
=20
+struct pvrdma_create_qp_resp {
+	__u32 qpn;
+	__u32 qp_handle;
+};
+
 /* PVRDMA masked atomic compare and swap */
 struct pvrdma_ex_cmp_swap {
 	__aligned_u64 swap_val;
--=20
2.18.1

