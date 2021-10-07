Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CA7425DB9
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Oct 2021 22:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhJGUn1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Oct 2021 16:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhJGUn1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Oct 2021 16:43:27 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02422C061570
        for <linux-rdma@vger.kernel.org>; Thu,  7 Oct 2021 13:41:33 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id g15-20020a9d128f000000b0054e3d55dd81so3934499otg.12
        for <linux-rdma@vger.kernel.org>; Thu, 07 Oct 2021 13:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pcxAdiImyK4B9yAh9TbVrtYx8EXTONj/TcOyvXcVc/w=;
        b=gqdo2tw4NkUK4iQB9vA4o+8ctjPEBAqV0lHbTl2E/qgq76uGjHpTY2PUDQNIG7wNXu
         rAK5W+Lqz6cAtQEweVAHKfKDJ8kgoP4pyNYdKwiPRXQbQp/Qd94SKtiSul2nF5mfalg6
         Tl/YwQ9hHemhztGx/UVxwAYeFOLrMBPMefsvIsp1+dydb0/hBXMAYelZ3kDHeKzPtnCk
         /anwsho1cXaAezDfMDEqqWl14FSB82rWF+Vr88zvJoMI9uUEQ0FIzi8LwfRsZA4RK9Bh
         y+hb6xIsokO6gTkwDsiQchmEUKY8XnDCodR7IXZcOjxpGG5opOBaDdrcwRKZeqixoa7C
         PMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pcxAdiImyK4B9yAh9TbVrtYx8EXTONj/TcOyvXcVc/w=;
        b=fi2yMmsa33+PjBhL1UmrYpjEvBb0rZ6h1OsT6HRmZtXR0hwVfMqkZVD9dlrZ2nilcA
         NXvyQoggO3SfyR8cyuTbzoCBGOHi5wtg+Rm9JY/SN2Emnl8Qy4qkiit4W4t/7pxy7tWk
         GS2+L1HPdSstpuDE6P3stbehKkT3Ny7T+TcoEgQxZh+tvShcpwCweuzJWB8wla1Ornkk
         Zzt4DWIn8kpf1vrCfDR2GSH3WmLSA3tI7BC6ubw5a2biegCxYTrt4+WTR7dPubA2ZZLC
         RWshVKeVjTV/Y6Rv/G8ZfHjCOrBIBiRG5mSAFxYc2nF1NiUAN+JJ9EJpJIwOl9v7dc7L
         NLFA==
X-Gm-Message-State: AOAM531AeUQsJRMlbQIso5C2a/TsRZp0ALIBK3eCkkUCDuNbLQhmdzir
        emvZboP1H/JgihnX5fFYROVGb9kwLJ8=
X-Google-Smtp-Source: ABdhPJyTtcQwzv/OmcZFm2nvyXqfxRT9CowdP4GCH1+hmRpAuvzskKFYCHCt5Cn93uvpDGFWLLGdOQ==
X-Received: by 2002:a9d:490:: with SMTP id 16mr5502612otm.184.1633639292326;
        Thu, 07 Oct 2021 13:41:32 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-1259-16f0-10f5-1724.res6.spectrum.com. [2603:8081:140c:1a00:1259:16f0:10f5:1724])
        by smtp.gmail.com with ESMTPSA id f10sm71607ooh.42.2021.10.07.13.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:41:31 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v6 1/6] RDMA/rxe: Move AV from rxe_send_wqe to rxe_send_wr
Date:   Thu,  7 Oct 2021 15:40:47 -0500
Message-Id: <20211007204051.10086-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211007204051.10086-1-rpearsonhpe@gmail.com>
References: <20211007204051.10086-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move the struct rxe_av av from struct rxe_send_wqe to struct rxe_send_wr
placing it in wr.ud at the same offset as it was previously. This has the
effect of increasing the size of struct rxe_send_wr while keeping the size of
struct rxe_send_wqe the same. This better reflects the use of this field
which is only used for UD sends. This change has no effect on ABI
compatibility so the modified rxe driver will operate with older versions
of rdma-core.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_av.c    | 2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 3 ++-
 include/uapi/rdma/rdma_user_rxe.h     | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

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
index 9d0bb9aa7514..c09e1c25ce66 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -584,7 +584,8 @@ static void init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	if (qp_type(qp) == IB_QPT_UD ||
 	    qp_type(qp) == IB_QPT_SMI ||
 	    qp_type(qp) == IB_QPT_GSI)
-		memcpy(&wqe->av, &to_rah(ud_wr(ibwr)->ah)->av, sizeof(wqe->av));
+		memcpy(&wqe->wr.wr.ud.av, &to_rah(ud_wr(ibwr)->ah)->av,
+		       sizeof(struct rxe_av));
 
 	if (unlikely(ibwr->send_flags & IB_SEND_INLINE))
 		copy_inline_data_to_wqe(wqe, ibwr);
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index e283c2220aba..2f1ebbe96434 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -98,6 +98,9 @@ struct rxe_send_wr {
 			__u32	remote_qpn;
 			__u32	remote_qkey;
 			__u16	pkey_index;
+			__u16	reserved;
+			__u32	pad[5];
+			struct rxe_av av;
 		} ud;
 		struct {
 			__aligned_u64	addr;
@@ -148,7 +151,6 @@ struct rxe_dma_info {
 
 struct rxe_send_wqe {
 	struct rxe_send_wr	wr;
-	struct rxe_av		av;
 	__u32			status;
 	__u32			state;
 	__aligned_u64		iova;
-- 
2.30.2

