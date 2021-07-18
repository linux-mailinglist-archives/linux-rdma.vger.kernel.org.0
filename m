Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA9A3CCAD6
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jul 2021 23:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhGRVai (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 17:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhGRVai (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 18 Jul 2021 17:30:38 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A8FC061762
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jul 2021 14:27:38 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id y66so9011634oie.7
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jul 2021 14:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7+cWWG+X6YgSz1Adp48PcDN3mkt0jili7TeJ8haPNl8=;
        b=kWS98M2tKZ8rTfv/bMYUZ9QpQaBkz7z8Dxznx3IV0xfPBmAy2YB0W+qjSZlQ8qZFi6
         sZ9Oh/c82eT8uVyT/xnfEw8E/khAaXTAHX3i6JGY4+7IWpcYPf4BsXj80+sUAAIeYtF+
         FzRy6jxLOWlPesD/CzWdlpXdECjzkE6qPqXeEk9hfmV6Z+oOSXc/QImxYFctnv4CAgX1
         hZDrErRxj0FiG02lg2YqZho5uki29/MvgBrUAPcFCi8h9YNCn8lTGUjunXchbelVgWy9
         xHyw2fWHi5GxYHRnUCrTYjBLnfJrrkLbg41N6foo43lJ2GFeAvJGiicPcaE03tgsVkvu
         DG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7+cWWG+X6YgSz1Adp48PcDN3mkt0jili7TeJ8haPNl8=;
        b=VD9zoEDIyWLv1dRMhqWZDrm9UrhGFYpiLjFK/AmdIfuzeEFO/wBDUaV6LZ+1pQa9Wv
         5p/MN9chR3aeGeDvDDt6v0aW7OuEbHmxln1KdOH4cfvVtH+DimM/u2fkJdsNeP3bMCIy
         uPM5CUXl6iOpyLM1A2eNyjzI8U+V0rgclAOA6noPEZnxB7td04jGX+AEsFmpS0CG3RWm
         CFTK9eq2gvHGxfY9xFPuo6P29F65BqiK0G8liApxtfqN5MLfhfFzTJ2MGgg2Pxu9cLVN
         xbV/qd7khvdZ6XbsTxEqHf8mNYtOy2gpRnFVv8U+2yTQpTExjHuIk3pIVN5TtgJ5Qu7N
         oUpw==
X-Gm-Message-State: AOAM532s4wqI6CBCE5IuAzl6KNCUNirOVlGz9esRPajnxeYcO8s2qHVx
        WBa4PceDnT9r5D3RQWAi3KE=
X-Google-Smtp-Source: ABdhPJzdIH8XdH85GuWQceQWxsAaPrZDhTyRfu7fn5QwrvEicTPUbdT6navlyuXpWaB4boirEecyrg==
X-Received: by 2002:a54:4109:: with SMTP id l9mr15795609oic.3.1626643658203;
        Sun, 18 Jul 2021 14:27:38 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-0284-9a3c-0f8a-4ac7.res6.spectrum.com. [2603:8081:140c:1a00:284:9a3c:f8a:4ac7])
        by smtp.gmail.com with ESMTPSA id y5sm2601775otu.27.2021.07.18.14.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 14:27:37 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 1/5] RDMA/rxe: Change user/kernel API to allow indexing AH
Date:   Sun, 18 Jul 2021 16:27:00 -0500
Message-Id: <20210718212703.21471-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210718212703.21471-1-rpearsonhpe@gmail.com>
References: <20210718212703.21471-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make changes to rdma_user_rxe.h to allow indexing AH objects, passing
the index in UD send WRs to the driver and returning the index to the rxe
provider. This change will allow removing handling of the AV in the user
space provider.

In order to preserve ABI compatibility for old kernel and/or rdma-core
code keep the AV in the WQE at the same offset but move to the UD specific
part of the work request since that is the only case that uses it.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2:
  Moved AV from rxe_send_wqe to rxe_wr.

 drivers/infiniband/sw/rxe/rxe_av.c    |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c |  3 ++-
 include/uapi/rdma/rdma_user_rxe.h     | 10 +++++++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
index da2e867a1ed9..85580ea5eed0 100644
--- a/drivers/infiniband/sw/rxe/rxe_av.c
+++ b/drivers/infiniband/sw/rxe/rxe_av.c
@@ -107,5 +107,5 @@ struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt)
 	if (qp_type(pkt->qp) == IB_QPT_RC || qp_type(pkt->qp) == IB_QPT_UC)
 		return &pkt->qp->pri_av;
 
-	return (pkt->wqe) ? &pkt->wqe->av : NULL;
+	return (pkt->wqe) ? &pkt->wqe->wr.wr.ud.av : NULL;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index c223959ac174..4176fffa7fdc 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -605,7 +605,8 @@ static void init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	if (qp_type(qp) == IB_QPT_UD ||
 	    qp_type(qp) == IB_QPT_SMI ||
 	    qp_type(qp) == IB_QPT_GSI)
-		memcpy(&wqe->av, &to_rah(ud_wr(ibwr)->ah)->av, sizeof(wqe->av));
+		memcpy(&wqe->wr.wr.ud.av, &to_rah(ud_wr(ibwr)->ah)->av,
+		       sizeof(struct rxe_av));
 
 	if (unlikely(ibwr->send_flags & IB_SEND_INLINE))
 		copy_inline_data_to_wqe(wqe, ibwr);
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index e283c2220aba..ad7da77dca04 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -98,6 +98,10 @@ struct rxe_send_wr {
 			__u32	remote_qpn;
 			__u32	remote_qkey;
 			__u16	pkey_index;
+			__u16	reserved;
+			__u32	ah_num;
+			__u32	pad[4];
+			struct rxe_av av;	/* deprecated */
 		} ud;
 		struct {
 			__aligned_u64	addr;
@@ -148,7 +152,6 @@ struct rxe_dma_info {
 
 struct rxe_send_wqe {
 	struct rxe_send_wr	wr;
-	struct rxe_av		av;
 	__u32			status;
 	__u32			state;
 	__aligned_u64		iova;
@@ -168,6 +171,11 @@ struct rxe_recv_wqe {
 	struct rxe_dma_info	dma;
 };
 
+struct rxe_create_ah_resp {
+	__u32 ah_num;
+	__u32 reserved;
+};
+
 struct rxe_create_cq_resp {
 	struct mminfo mi;
 };
-- 
2.30.2

