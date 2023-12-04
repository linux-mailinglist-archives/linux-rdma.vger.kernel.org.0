Return-Path: <linux-rdma+bounces-236-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 778DE803EF8
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 21:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B1D1F21289
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 20:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCE133CEF;
	Mon,  4 Dec 2023 20:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHhxJ7S1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21953107
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 12:04:16 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-58d439e3e15so2359839eaf.1
        for <linux-rdma@vger.kernel.org>; Mon, 04 Dec 2023 12:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701720255; x=1702325055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xW8YlJNeX4Wpian/ZFUqeO11K05OcmJkUPNwn2Dt/c=;
        b=gHhxJ7S11HvEUsqdmoHtgUGw8RFt4xsnqfY/OvH+c/4Ws+t5HrqeMwGo5+pLFIYdCc
         0IdHorir8wDsj39HrNG5eNbv+vfYkbCXtSXiftGcSyzJnnh/nVQJNiSKGSzsgICibnTz
         GsgeXVaHMO7udRiYz26wR/UCv+P6tmDEgSgO8MG+6H8cogkG4/zBdlxaxnUtsg3gKkpl
         mplvWYENQI4a8ltxbdbG+ZdwLD5vcjww8/lCtc+3ZUiuSCXJy9pm0jJ4G+El3lxABwZp
         ugb9mh2DEUiDXM5PMOVKuJli6QPF9KjD2njz9ffhCW0bhycFX0DTH7fk/NmMZHswtPs4
         hYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720255; x=1702325055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xW8YlJNeX4Wpian/ZFUqeO11K05OcmJkUPNwn2Dt/c=;
        b=WxulN+I8reAeLyGXPGqU3FCKrNKUOeR2M/l35TNNOXH1QczUs0Umq2ZyAf3K7jqRxU
         Y2F2Zor56L+YhVoOGsJCfka/temHMJrn4nzvqxn+PKFNc/bX1YlwwJI/oBplngD+kiGW
         NeaxDjD6QZdOWxNd1cUoy7r2qGcuzI7AJbut8RZKYKGgnF331g5B+LaOUwehZVhKL2Pe
         sXZVaWk2SunOZYPg6zqO9OLjOtiDaLeJBmnPtTc/fniMMpQiq7PyK43DsWyEf+qbIVCY
         mrBImHoTqVSrHb3DVYP7y2EMdnlc/GMBTjtTzIZN9zS9/JR+aAQFKrEMApEYDVv/AGe3
         IZhw==
X-Gm-Message-State: AOJu0Yzeq3OlsFd0riNlFUsXMdTGgOr1o/vKFUy+AbMThxD+E0X2n2Vi
	ygry3J/rNTX4NbFSkR248eA=
X-Google-Smtp-Source: AGHT+IEVuDhmsUNSBM8Ku/K3k+rqIHfffXEM3/tNFxmbZbnsGltWKDBAUVjBFrytswoIv6o5eOpXMg==
X-Received: by 2002:a05:6820:60f:b0:58e:1c46:f440 with SMTP id e15-20020a056820060f00b0058e1c46f440mr1804206oow.6.1701720255406;
        Mon, 04 Dec 2023 12:04:15 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-e463-fe8f-1aa8-6edb.res6.spectrum.com. [2603:8081:1405:679b:e463:fe8f:1aa8:6edb])
        by smtp.gmail.com with ESMTPSA id e72-20020a4a554b000000b0054f85f67f31sm537281oob.46.2023.12.04.12.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:04:14 -0800 (PST)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com,
	yanjun.zhu@linux.dev,
	linux-rdma@vger.kernel.org
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 7/7] RDMA/rxe: Add module parameters for mcast limits
Date: Mon,  4 Dec 2023 14:03:43 -0600
Message-Id: <20231204200342.7125-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204200342.7125-1-rpearsonhpe@gmail.com>
References: <20231204200342.7125-1-rpearsonhpe@gmail.com>
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


