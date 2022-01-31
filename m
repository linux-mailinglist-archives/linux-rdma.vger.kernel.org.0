Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89904A521E
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jan 2022 23:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiAaWKS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jan 2022 17:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiAaWKR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jan 2022 17:10:17 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846C0C06173D
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:17 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id o9-20020a9d7189000000b0059ee49b4f0fso14433724otj.2
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ND85foxjmkXjnsWGNjGYV2h8qNK61stwtqXRrzd7Kv4=;
        b=gIoBekliG6ITOmVi8e89Krw6sSsSh+BciQZg9FmjmYd4XNFWEVTD83q9uSKRNMWufS
         +T9RFqpwA8OIoJ4s1+Yk2H3j9zXQ8I9JYJf0DnxHd3KdiDnSVWEwTwS5NmTR4M7tyKfv
         gRmIv+TVmkcOVIfk3I1PE1UWCEt3H1sJE/2KEWhJBwJ9pCddYVWNvFOx3Q/Xl6sZWxSM
         we0ksivFCBm+ID3swWeHMGDcKV+SwXQYUS1Sb2ysd901Zm5YmxVlUccDpIHyPXzJ6F3i
         hUSFmMWh/Zk9bFIAdnJJKhOYJajJCJTz3IcI7Po9EeqaQN87RX3c+Xdpfb5w44ssgoOG
         qvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ND85foxjmkXjnsWGNjGYV2h8qNK61stwtqXRrzd7Kv4=;
        b=V3+9EfRKhh1/EnVWN0CwspNPMdr/9OhRumBp0J22UeNQOO6zJUt1Qt9H5kVph1w+2l
         DbeAb9DEexmVbAQQarfy2HeKrlm0iBSuOLxjI22yClpYLDUjCUMnb7pjM36ysCrfjCNn
         0rUxqEspQVZjAvTx7q1d+f78ZhP60vQrxa444oBs06y4L1fj5fYUDZVFjylWPlFqrmgM
         V2vcsxrQ+7KIiV2EkLBOd1A2eDVT1OBXl0+UTGlvu86F9h7SbV3+44P59f3QEzEhPpTY
         Tt/HXL3YDT9KD4pNjgH1Gw4rsa6T+xWXP734GRJg1mIIi/94zumggm3L52jlj93/1krV
         K6ew==
X-Gm-Message-State: AOAM532p0d0IjTmHVjYWWVPQQ6Pwkd8TGMtDte0zAI6wonN/s+mT/Fpe
        B38LQ1iKpS5yBDBemWPAVIPoaHQFKmU=
X-Google-Smtp-Source: ABdhPJw/A/FHXzpfITAJ7jl57iHLxrKI6r0TZ3KvJYnAVNyoWqwcvGrpG7qr+2jpQKou9tOrjkAp4w==
X-Received: by 2002:a05:6830:13cd:: with SMTP id e13mr12771141otq.193.1643667016916;
        Mon, 31 Jan 2022 14:10:16 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-5c63-4cee-84ac-42bc.res6.spectrum.com. [2603:8081:140c:1a00:5c63:4cee:84ac:42bc])
        by smtp.googlemail.com with ESMTPSA id t21sm8304929otq.81.2022.01.31.14.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:10:16 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 16/17] RDMA/rxe: Add comments to rxe_mcast.c
Date:   Mon, 31 Jan 2022 16:08:49 -0600
Message-Id: <20220131220849.10170-17-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220849.10170-1-rpearsonhpe@gmail.com>
References: <20220131220849.10170-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add comments to rxe_mcast.c.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 30 ++++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  2 +-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 00b4e3046d39..2fccf69f9a4b 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -1,12 +1,33 @@
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
@@ -16,6 +37,13 @@ static int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
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
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 97d3a59e5c6f..72a913a8e0cb 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -358,7 +358,7 @@ struct rxe_mcg {
 	struct list_head	qp_list;
 	atomic_t		qp_num;
 	union ib_gid		mgid;
-	unsigned int		index;
+	unsigned int		index; /* debugging help */
 	u32			qkey;
 	u16			pkey;
 };
-- 
2.32.0

