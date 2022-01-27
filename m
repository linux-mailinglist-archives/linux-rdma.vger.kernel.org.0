Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC5849ED8C
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344418AbiA0ViU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344421AbiA0ViR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:17 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541BFC061747
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:17 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id e81so8544183oia.6
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O9HP4u1QtSz+UTDeR5PfbOxd1zQDa2gpLbjYJV32Jsc=;
        b=hevN2zdNUuWHf+Z2CCawe9Uur5FU1WfWod4PxURq2N24Cy9kwgoNeWBqQnQHCZMSmc
         qOizGxsQtXGRNaX7w2e2diUKScN15MBqhY/UU4w1bLmZ0rSLojos4GZFAepPolV1m5Rj
         RpcGp2vpdRHNuNXpRI/r0UyDstSu2Sb+lnnVH1ERLsDL+mZvpZ8ebrS6pBplO3Fwj/9H
         8QhaWW6su02SLHsXn1JvJDlLS9cvdNRewCNWUD28F8Xk/63OLr45mCTO5IGT/BFluF6I
         y/bu1WTg2f6WV78F4gD9YHeQWSyYlmoe4avSlTiqRyzsa0x7uBBOF65fV1rQFJ+D4rBP
         ANnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9HP4u1QtSz+UTDeR5PfbOxd1zQDa2gpLbjYJV32Jsc=;
        b=RgPdmIqsjkLkThXOv030H9fwBz93Qqvu4ubLl/Cgo5IojIZpt048Ldn6ITmiy+2hba
         juD3FwQ/qXEPECH5Uuj+kP9y0Lp2OKRbvx/GRG2IhigNBoTa8IRC+7ngyiQc3zQ9Dl1E
         ExwX5gjDlo2jbryPFuZcj/T87+zp+H03TVc1gojf21uwl0/exspcMPEAcYptFK8b3WnO
         PYUIaUVqs0s4Lrb4C3oJWReCvk2ZJj/9BSvR0TOLUCDzI/TYGNFf2gNHEizA3diVL3Y/
         J4xDG9puZ2Gs7KQOSIA4CAUrgvSbFMr/Dp3kPYiVfBjSC7zEKJ7QDH5P1+WZWGL+9VmE
         bjSA==
X-Gm-Message-State: AOAM532hUBobievsz2jOggJv431mhXz28dRhIufDs6cdM2eiNDPl3BnB
        60Ygs1a3vqUPOq5qadIjF+U=
X-Google-Smtp-Source: ABdhPJzOIiHJR1T0h2oM15XpinwS2xKtmy2xWO3P8MTcFGYxFGquZsx45IqdVXjARHr4VbE6A2Q3/A==
X-Received: by 2002:a05:6808:30a3:: with SMTP id bl35mr8214215oib.226.1643319496738;
        Thu, 27 Jan 2022 13:38:16 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:16 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 16/26] RDMA/rxe: Add comments to rxe_mcast.c
Date:   Thu, 27 Jan 2022 15:37:45 -0600
Message-Id: <20220127213755.31697-17-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add comments to rxe_mcast.c.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 42 ++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 49cc1ad05bba..77f166a5d5c8 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -1,12 +1,45 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * Copyright (c) 2022 Hewlett Packard Enterprise, Inc. All rights reserved.
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
  */
 
+/*
+ * rxe_mcast.c implements driver support for multicast transport.
+ * It is based on two data structures struct rxe_mcg ('mcg') and
+ * struct rxe_mca ('mca'). An mcg is allocated each time a qp is
+ * attached to a new mgid for the first time. These are indexed by
+ * a red-black tree using the mgid. This data structure is searched
+ * for the mcg when a multicast packet is received and when another
+ * qp is attached to the same mgid. It is cleaned up when the last qp
+ * is detached from the mcg. Each time a qp is attached to an mcg an
+ * mca is created. It holds a pointer to the qp and is added to a list
+ * of qp's that are attached to the mcg. The qp_list is used to replicate
+ * mcast packets in the rxe receive path.
+ *
+ * mcg's keep a count of the number of qp's attached and once the count
+ * goes to zero it needs to be cleaned up. mcg's also have a reference
+ * count. While InfiniBand multicast groups are created and destroyed
+ * by explicit MADs, for rxe devices this is more implicit and the mcg
+ * is created by the first qp attach and destroyed by the last qp detach.
+ * To implement this there is some hysteresis with an extra kref_get when
+ * the mcg is created and an extra kref_put when the qp count decreases
+ * to zero.
+ *
+ * The qp list and the red-black tree are protected by a single
+ * rxe->mcg_lock per device.
+ */
+
 #include "rxe.h"
-#include "rxe_loc.h"
 
+/**
+ * rxe_mcast_add - add multicast address to rxe device
+ * @rxe: rxe device object
+ * @mgid: multicast address as a gid
+ *
+ * Returns 0 on success else an error
+ */
 static int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	unsigned char ll_addr[ETH_ALEN];
@@ -16,6 +49,13 @@ static int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
 	return dev_mc_add(rxe->ndev, ll_addr);
 }
 
+/**
+ * rxe_mcast_delete - delete multicast address from rxe device
+ * @rxe: rxe device object
+ * @mgid: multicast address as a gid
+ *
+ * Returns 0 on success else an error
+ */
 static int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	unsigned char ll_addr[ETH_ALEN];
-- 
2.32.0

