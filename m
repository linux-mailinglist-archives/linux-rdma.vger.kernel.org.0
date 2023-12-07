Return-Path: <linux-rdma+bounces-323-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC2780915C
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 20:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2761C20A91
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 19:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5005F5027F;
	Thu,  7 Dec 2023 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKS6GtDx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D438D1711;
	Thu,  7 Dec 2023 11:30:23 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b9d23c8bf7so878897b6e.0;
        Thu, 07 Dec 2023 11:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701977423; x=1702582223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xW8YlJNeX4Wpian/ZFUqeO11K05OcmJkUPNwn2Dt/c=;
        b=AKS6GtDxZjhxBHgvxjRcem2EX6slEveQxwN/W6n7zrTDE0COcarHBa6vlG23kN965K
         QrE1QNZpUCA1FV012koi07iLFi4ekqHkdfS73+ZsYUmnGu09dMHjyi6gORTelq1eFV3a
         Zh48Uxg8kEMdsTLPdI1xCy0yXlpYxTsYLGwy+2b2NG1koJr3LnbX7tEdIEHd7OnQ8LqZ
         LVTp0znh5IZx8bCyoI7c8KrCMuS4LPp0QvGhHkPmLUJxTZbM2u8A4C//5xAo7uMkx6Pb
         KaF1HmAnBfYct4KZyC67jdYFMx8ImyQtxlWyweRkz3O3XXm9Z6WEC+bk9WO0n5fm9YMo
         zbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701977423; x=1702582223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xW8YlJNeX4Wpian/ZFUqeO11K05OcmJkUPNwn2Dt/c=;
        b=m+nIQUsBTAEorB/WexYA74GnfQHJgopL/laEhaIqvvLcCdY8GaTUrPDfFrli8Fdq3t
         7GmuIpI1tqqwoNGVed48HT4RaJgymcrps3ac2HPua3UKJnHftnldIn6OE+AjRcQ5pq+A
         vghZHocgitSY1Z1mDORJTyGVq2Pf9fJJKmo3GATwu7ul7peobJcRE9CqDDysnKROyc+8
         TE2Vg/RoldR1IkKtXBhqWHdAWqQe8dblAiwNbJ0xqMjary864rS9G/bq2iE+Flofdei6
         mcHMZOzSq01j6qhOp826Vfb/eJdHa/OQ/a4wcBfD1B6nJYOQDAs48J1DeCPDVv+NAbI+
         +OMw==
X-Gm-Message-State: AOJu0Yy0IbaQlNKvyO5WxncyujEDNLyNcuAO5pWlLSn1ToZgoVO5wPtU
	lEJZTHNrv0Sep4S/hsnJphU=
X-Google-Smtp-Source: AGHT+IG2G5BMAwx1+fVJfv/Y8zVoBih63xNRl6EbqwKkxNGCCYkTwiAZBRdZ96EB1LtAxmvtZTa78w==
X-Received: by 2002:a05:6870:224a:b0:1fb:75a:779c with SMTP id j10-20020a056870224a00b001fb075a779cmr3174238oaf.77.1701977422814;
        Thu, 07 Dec 2023 11:30:22 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-ca1f-53fd-59c8-8b84.res6.spectrum.com. [2603:8081:1405:679b:ca1f:53fd:59c8:8b84])
        by smtp.gmail.com with ESMTPSA id mp23-20020a056871329700b001fb634b546dsm92347oac.14.2023.12.07.11.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 11:30:22 -0800 (PST)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com,
	yanjun.zhu@linux.dev,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	dsahern@kernel.org,
	rain.1986.08.12@gmail.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v6 7/7] RDMA/rxe: Add module parameters for mcast limits
Date: Thu,  7 Dec 2023 13:29:08 -0600
Message-Id: <20231207192907.10113-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231207192907.10113-1-rpearsonhpe@gmail.com>
References: <20231207192907.10113-1-rpearsonhpe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add module parameters for max_mcast_grp, max_mcast_qp_attach,
and tot_mcast_qp_attach to allow setting these parameters to
small values when the driver is loaded to support testing these
limits.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/Makefile    |  3 ++-
 drivers/infiniband/sw/rxe/rxe.c       |  6 +++---
 drivers/infiniband/sw/rxe/rxe_param.c | 23 +++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_param.h |  4 ++++
 4 files changed, 32 insertions(+), 4 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_param.c

diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
index 5395a581f4bb..b183924ea01d 100644
--- a/drivers/infiniband/sw/rxe/Makefile
+++ b/drivers/infiniband/sw/rxe/Makefile
@@ -22,4 +22,5 @@ rdma_rxe-y := \
 	rxe_mcast.o \
 	rxe_task.o \
 	rxe_net.o \
-	rxe_hw_counters.o
+	rxe_hw_counters.o \
+	rxe_param.o
diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 147cb16e937d..599fbfdeb426 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -59,9 +59,9 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 	rxe->attr.max_res_rd_atom		= RXE_MAX_RES_RD_ATOM;
 	rxe->attr.max_qp_init_rd_atom		= RXE_MAX_QP_INIT_RD_ATOM;
 	rxe->attr.atomic_cap			= IB_ATOMIC_HCA;
-	rxe->attr.max_mcast_grp			= RXE_MAX_MCAST_GRP;
-	rxe->attr.max_mcast_qp_attach		= RXE_MAX_MCAST_QP_ATTACH;
-	rxe->attr.max_total_mcast_qp_attach	= RXE_MAX_TOT_MCAST_QP_ATTACH;
+	rxe->attr.max_mcast_grp			= rxe_max_mcast_grp;
+	rxe->attr.max_mcast_qp_attach		= rxe_max_mcast_qp_attach;
+	rxe->attr.max_total_mcast_qp_attach	= rxe_max_tot_mcast_qp_attach;
 	rxe->attr.max_ah			= RXE_MAX_AH;
 	rxe->attr.max_srq			= RXE_MAX_SRQ;
 	rxe->attr.max_srq_wr			= RXE_MAX_SRQ_WR;
diff --git a/drivers/infiniband/sw/rxe/rxe_param.c b/drivers/infiniband/sw/rxe/rxe_param.c
new file mode 100644
index 000000000000..27873e7de753
--- /dev/null
+++ b/drivers/infiniband/sw/rxe/rxe_param.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2023 Hewlett Packard Enterprise, Inc. All rights reserved.
+ */
+
+#include "rxe.h"
+
+int rxe_max_mcast_grp = RXE_MAX_MCAST_GRP;
+module_param_named(max_mcast_grp, rxe_max_mcast_grp, int, 0444);
+MODULE_PARM_DESC(max_mcast_grp,
+	"Maximum number of multicast groups per device");
+
+int rxe_max_mcast_qp_attach = RXE_MAX_MCAST_QP_ATTACH;
+module_param_named(max_mcast_qp_attach, rxe_max_mcast_qp_attach,
+		int, 0444);
+MODULE_PARM_DESC(max_mcast_qp_attach,
+	"Maximum number of QPs attached to a multicast group");
+
+int rxe_max_tot_mcast_qp_attach = RXE_MAX_TOT_MCAST_QP_ATTACH;
+module_param_named(max_tot_mcast_qp_attach, rxe_max_tot_mcast_qp_attach,
+		int, 0444);
+MODULE_PARM_DESC(max_tot_mcast_qp_attach,
+	"Maximum total number of QPs attached to multicast groups per device");
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index d2f57ead78ad..d6fe50f5f483 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -125,6 +125,10 @@ enum rxe_device_param {
 	RXE_VENDOR_ID			= 0XFFFFFF,
 };
 
+extern int rxe_max_mcast_grp;
+extern int rxe_max_mcast_qp_attach;
+extern int rxe_max_tot_mcast_qp_attach;
+
 /* default/initial rxe port parameters */
 enum rxe_port_param {
 	RXE_PORT_GID_TBL_LEN		= 1024,
-- 
2.40.1


