Return-Path: <linux-rdma+bounces-256-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6298780435D
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 01:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9399F1C20C33
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 00:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F59657;
	Tue,  5 Dec 2023 00:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvNXgLVQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21994101
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 16:26:40 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-58d9a4e9464so2119716eaf.0
        for <linux-rdma@vger.kernel.org>; Mon, 04 Dec 2023 16:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701735999; x=1702340799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xW8YlJNeX4Wpian/ZFUqeO11K05OcmJkUPNwn2Dt/c=;
        b=jvNXgLVQNV2DrieYctnlqbZW1brVmJ82ifY1cFYHWJVp0S+FoUUf+CLy87Q49VGDEy
         Yyf6YXKKospr3m4yfCp1GH4ldRj6sJt0cprEsWbAkmdbKim7K/JsXSEdMNBHurSP/tsa
         aIbmk22zqh8voZBKjSvG5sBv7iMi8y+p1yS0k0NdKfIGESalZz4Lf75V38BMid0VqWDY
         a1DYUSQ2LgDt+KI4rl668yFqUBX9S4wDAWf9EOopQGKpJ3tURvGFXT0BQxJRqjBbsYGB
         fCa76NPnauiyklorihjfr/qcRz3BEfjM4PYMDOzChlOjHuTetHJ4PVgWXTrn5jTkBwhO
         PLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701735999; x=1702340799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xW8YlJNeX4Wpian/ZFUqeO11K05OcmJkUPNwn2Dt/c=;
        b=aRcLGxGbXxepH5GJBdvrkM2VfSZjAQVd03OGd6kDXTo+nlJOq974VAgng+An9Vk80g
         r3oc6+5bwF8TXZ+9O0Gq8OAAVh9wTFGnpdEsRB2XUtilJz8VlmLPU63Q8QyPcHj6gPLi
         usLvFQ/QmFDs93aeDNzdcibh75l5877gVih2uwBH4oai0gKABKQdmOpH3O1FRneJ1DO1
         Dr0WZXJv89o5lEz4S9TgQcYrSNetTEE1yLDt2JBJYWs6XytZVkl2VMrjZ2BUoVbL98Mi
         epYZeJzSumbPDeAG1NA/urjdhRRy/dAkqAZLT0i0d+nQSXMCtp90oFUAiFDhpw5W6j8+
         3WNQ==
X-Gm-Message-State: AOJu0YyRZWZgwOvbxs2FsLFxRF9JZoVmmcdD1ftXCLLlFXIBCwR0Cdc9
	Zi3CfpQdTVyfCcaoGHhkQ5w=
X-Google-Smtp-Source: AGHT+IHPgbqQjTSpGBS3XWQiknNiZaaxQ69rr989yEo4G3bk316XWrCuye9FaMva/439B4mqbcWUYQ==
X-Received: by 2002:a05:6870:55d1:b0:1fb:75b:2bb8 with SMTP id qk17-20020a05687055d100b001fb075b2bb8mr2639213oac.116.1701735999416;
        Mon, 04 Dec 2023 16:26:39 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-e463-fe8f-1aa8-6edb.res6.spectrum.com. [2603:8081:1405:679b:e463:fe8f:1aa8:6edb])
        by smtp.gmail.com with ESMTPSA id se6-20020a05687122c600b001faf09f0899sm2524844oab.24.2023.12.04.16.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 16:26:38 -0800 (PST)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com,
	yanjun.zhu@linux.dev,
	linux-rdma@vger.kernel.org
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v5 7/7] RDMA/rxe: Add module parameters for mcast limits
Date: Mon,  4 Dec 2023 18:26:14 -0600
Message-Id: <20231205002613.10219-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205002613.10219-1-rpearsonhpe@gmail.com>
References: <20231205002613.10219-1-rpearsonhpe@gmail.com>
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


