Return-Path: <linux-rdma+bounces-149-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6107FE0FB
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 21:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DBD2823C9
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 20:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D4D60EEE;
	Wed, 29 Nov 2023 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyUy2RxQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B903910C2
	for <linux-rdma@vger.kernel.org>; Wed, 29 Nov 2023 12:26:32 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-58dd3528497so139251eaf.3
        for <linux-rdma@vger.kernel.org>; Wed, 29 Nov 2023 12:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701289592; x=1701894392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xW8YlJNeX4Wpian/ZFUqeO11K05OcmJkUPNwn2Dt/c=;
        b=eyUy2RxQ+u+EtCpl0CMmsJHDsA8pgSnmzPFDOyfHgo0/7xE8Vy7nBKVD5pFD8lMvhD
         8HdsxYH6yTcrE6ZhphamUIh7TiTGrqRv3e71t5Z/odbZf6fTIBE/q4p44EeKNTnBLwXn
         YQMo7RlNjJY5Mvq88VqZp83h+1F7fkIUt6cbsZtaopmgQ2XD1iO0d3ra9oPILPX+MDYX
         1MrNPnQhRJRS/j6jK9l4VKWh4G4n12iyk7Zw8ElNInDeNGUHxCxBTOH/Izupt1gcyx0h
         fbcssIhemP3q66DrvLq2XLPsfqprVXQOAeWzx7JUeL5YFkg7r85DIx6iKIjupMdqDEdn
         9XZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701289592; x=1701894392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xW8YlJNeX4Wpian/ZFUqeO11K05OcmJkUPNwn2Dt/c=;
        b=c4CwUsh9H8KZyInrLW4vYlxD2aYZuCuOdlAhJhjCuQ/9rP6zEyIXxKBfGgg8iNgEkf
         uFit79qYx1nybZmr3GGoZ0RF4Gf9zRRfKTslGSTEbWFzBJ9sKJRXWv4HWjhl3GkxfuQ/
         PoJGy5JKjdnViMqMvdBDnfdbtNmgjRwCmTIKC5Cea/u1hAWnJ1c/1YrechbfD7FswLEj
         b54+oJVLHpPNeLydoJh5fMDC7xoptaN5s4+DwtZroWFfYtfc+Nytj2CyjcGc5s9z2uft
         L4jv/c+cKxJH28ayIQPYEM3XKqRbNdYMUL+yUV9hYWUlutiERny8zFUPTCRM6RmYUm4W
         LhGQ==
X-Gm-Message-State: AOJu0YysmW8iSLnoxAMH83JsybBaEWufdGOG3FrZODmnygAjBWroqQLU
	LIJlRYsgOeOUz1n9S5eheGp5TnIugDI=
X-Google-Smtp-Source: AGHT+IHPN3GfAiGMQTOaEfaGDw3kcFqkDlHBAyBqnrFPKLKsWKcgCk7Oz/nyuc0/AlVbubV1rVhhVQ==
X-Received: by 2002:a05:6820:1c92:b0:58d:e48a:6e63 with SMTP id ct18-20020a0568201c9200b0058de48a6e63mr336226oob.2.1701289592029;
        Wed, 29 Nov 2023 12:26:32 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-6755-34f8-2ed3-56ec.res6.spectrum.com. [2603:8081:1405:679b:6755:34f8:2ed3:56ec])
        by smtp.gmail.com with ESMTPSA id 126-20020a4a0684000000b0058ab906ae38sm2473867ooj.2.2023.11.29.12.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:26:31 -0800 (PST)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com,
	yanjun.zhu@linux.dev,
	linux-rdma@vger.kernel.org
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 7/7] RDMA/rxe: Add module parameters for mcast limits
Date: Wed, 29 Nov 2023 14:25:59 -0600
Message-Id: <20231129202558.31682-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129202558.31682-1-rpearsonhpe@gmail.com>
References: <20231129202558.31682-1-rpearsonhpe@gmail.com>
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


