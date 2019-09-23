Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC091BBF11
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 01:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391461AbfIWXti (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 19:49:38 -0400
Received: from mail-eopbgr690069.outbound.protection.outlook.com ([40.107.69.69]:35713
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729276AbfIWXti (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Sep 2019 19:49:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwHy3szSf2ccITNzuiHlHt1d3ORKyzdZVWWhCNhrNy7oLLa2j1sClWK+hZhPpMXV7io/n0yjvAQoa2yqlukCDK3yX57aKgcbibCCXx6I85NjLEpVtTg+aBw6tODCCs+6WcM8RGwskf+N29tsh1wAJCHPaj6H1uWMqmYOTl0q3cWjlhiqS9YyIEafLDkjH3pJLgiJFLsUae4kliXnWHnqBCkyJAjLlLFC6PBXj3Kav6R6ZNVft4+IvPIlTw155KyywM9y7I2rYtYUbs7cxDF0hQTKQdVfRkTAKQ/oWsixGVPzCVsIA4WDUOvhZqNJrjvVho3HuDlR7Y+zkrmasgJqbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS8y2tp3e/ixPXzH44FkJjTVoSIm0u836gvhFsxJVHA=;
 b=UKoxERjBMX9tOhjXr6wVSbw/hXb2FhJHM+wz2epMOOAeBey0uFynUOYGFDxSxtmCGlsiCDdYAC8FGDi5ZDPbpHPis2VpUn+tCxWPzWShTENkOZGnZvg7D+ss4YMDbnCpBOk/yE8VjL2r9Yx1m1S6O9PpididAv7C3GYnNjKH+EE8su0he1Df2LY0qXUd/m6UUE/G3PLcnTcPKGmqON9KBV1xedN6EjiedW4okxnx143RfQcPV4j0hQwg9PFCKBFCNPSV6eVEECHdtOD4zYh39woKP1Yk2kryw8Wqa8kT4z7QBP66NRq0n1maFnYleP/JxE7kfYG7kAHjCqGtonuRxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS8y2tp3e/ixPXzH44FkJjTVoSIm0u836gvhFsxJVHA=;
 b=FyeuMbmQICDHWsl5kTL42pKz4gK59DDJF6jUZyShl5+tmvRaHIsTpvpfLOPmsw4m7O9jHJOoaJanKU8TTmMsGJpPsoHAFnAr6SnYgJWCfBdDsxmwvpVwc77loIsP/1Qhxvci090LYBSE8w8VoCXn2JqbrmITK5zPla+L7xFilow=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB4455.namprd05.prod.outlook.com (52.135.205.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Mon, 23 Sep 2019 23:49:35 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::81ed:73c3:bc95:7d03]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::81ed:73c3:bc95:7d03%5]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 23:49:35 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     "jgg@mellanox.com" <jgg@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Adit Ranadive <aditr@vmware.com>
Subject: [PATCH rdma-core v2 1/2] Update kernel headers
Thread-Topic: [PATCH rdma-core v2 1/2] Update kernel headers
Thread-Index: AQHVcmmNIkofFtfnkEivO4vWC26rdg==
Date:   Mon, 23 Sep 2019 23:49:34 +0000
Message-ID: <333074d88847396252a597993d9a51645acfffd6.1569282124.git.aditr@vmware.com>
References: <cover.1569282124.git.aditr@vmware.com>
In-Reply-To: <cover.1569282124.git.aditr@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0069.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::46) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
x-mailer: git-send-email 2.18.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 763020b9-2a8c-4169-2a03-08d74080afcf
x-ms-traffictypediagnostic: BYAPR05MB4455:|BYAPR05MB4455:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB4455033AE4D19A4C89CA5260C5850@BYAPR05MB4455.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(39850400004)(376002)(366004)(199004)(189003)(8936002)(110136005)(14454004)(316002)(7736002)(25786009)(305945005)(4326008)(6486002)(256004)(2201001)(6436002)(6512007)(14444005)(107886003)(36756003)(478600001)(66066001)(3846002)(6116002)(81166006)(8676002)(81156014)(71190400001)(186003)(66946007)(76176011)(52116002)(86362001)(26005)(99286004)(6506007)(102836004)(386003)(486006)(11346002)(71200400001)(476003)(5660300002)(2906002)(446003)(66446008)(66556008)(64756008)(50226002)(2616005)(2501003)(118296001)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4455;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gDyWi352Kbwn684au2rL822Px2HvmMJss2nmEDYVdOeMNu+A2lcYFY6YCE1C32vIi/txWL0F3ukiyZnlSte6fds4+3ozz/6AuFQ0TjmT27kT9XeCyvVDXbqJNx0g9W44/gMI/26+elsajE5TZ8ZbNW5+DZlfQds0mSCMJ0DqstHDT6zF4XjmRUgsV8YqjTIRi+DEBhAt/RpcKZl1yUI854mrZXWhBFML1g3+BM25n6puodpRGdh5NJxPZBIKO3vs/IYVQwRE29CcLJchTshosd97VAYyB8PgZnzbo70zJKv5vJjkwqtsH5nCXL7oOnAazI8AuFW2w2NR1En7KnNZJlyw3iBSG3c6sL7YIVY2L11udusrGSih/iJYqflvjmnXwBUfHK2jXurMUu8EMkLM5bPlTpOBaAAzSpvC6peYDUc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763020b9-2a8c-4169-2a03-08d74080afcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 23:49:34.8843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0AvA6Iav5ZaeEfbxV47CuXdJsHZfa8m8KXB5y8D8Zshs1woBqP5V6Jm1OItKEoonFCZN3JTJt8Qcpjwih3db0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4455
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To commit ?? ("RDMA/vmw_pvrdma: Use resource ids from physical device if
available")

Signed-off-by: Adit Ranadive <aditr@vmware.com>
---
 kernel-headers/CMakeLists.txt        |  1 +
 kernel-headers/rdma/rvt-abi.h        | 66 ++++++++++++++++++++++++++++
 kernel-headers/rdma/vmw_pvrdma-abi.h | 13 ++++++
 3 files changed, 80 insertions(+)
 create mode 100644 kernel-headers/rdma/rvt-abi.h

diff --git a/kernel-headers/CMakeLists.txt b/kernel-headers/CMakeLists.txt
index 50bc77e6ab6e..13624b22d81b 100644
--- a/kernel-headers/CMakeLists.txt
+++ b/kernel-headers/CMakeLists.txt
@@ -23,6 +23,7 @@ publish_internal_headers(rdma
   rdma/rdma_user_ioctl.h
   rdma/rdma_user_ioctl_cmds.h
   rdma/rdma_user_rxe.h
+  rdma/rvt-abi.h
   rdma/siw-abi.h
   rdma/vmw_pvrdma-abi.h
   )
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
index 6e73f0274e41..1d339285550e 100644
--- a/kernel-headers/rdma/vmw_pvrdma-abi.h
+++ b/kernel-headers/rdma/vmw_pvrdma-abi.h
@@ -133,6 +133,10 @@ enum pvrdma_wc_flags {
 	PVRDMA_WC_FLAGS_MAX		=3D PVRDMA_WC_WITH_NETWORK_HDR_TYPE,
 };
=20
+enum pvrdma_user_qp_create_flags {
+	PVRDMA_USER_QP_CREATE_USE_RESP	=3D 1 << 0,
+};
+
 struct pvrdma_alloc_ucontext_resp {
 	__u32 qp_tab_size;
 	__u32 reserved;
@@ -177,6 +181,15 @@ struct pvrdma_create_qp {
 	__u32 rbuf_size;
 	__u32 sbuf_size;
 	__aligned_u64 qp_addr;
+	__u32 flags;
+	__u32 reserved;
+};
+
+struct pvrdma_create_qp_resp {
+	__u32 qpn;
+	__u32 qp_handle;
+	__u32 qpn_valid;
+	__u32 reserved;
 };
=20
 /* PVRDMA masked atomic compare and swap */
--=20
2.18.1

