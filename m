Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3624235A0
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Oct 2021 03:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhJFCAP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Oct 2021 22:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhJFCAP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Oct 2021 22:00:15 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8C3C061749
        for <linux-rdma@vger.kernel.org>; Tue,  5 Oct 2021 18:58:23 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so1330173otb.1
        for <linux-rdma@vger.kernel.org>; Tue, 05 Oct 2021 18:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pcxAdiImyK4B9yAh9TbVrtYx8EXTONj/TcOyvXcVc/w=;
        b=hRJBLiy3dVN0BU1JAaW/7WNWqtIwFsk8AFQaAIkwPCCizLaHYjsMCJTll1eCCXTCE/
         PBD7RVVW4fR2qDbU0biDpXr9Kta+Oqnh45hrBHcW1UuW1PohMvBc/KBo/Npokr7Wu3PM
         ZJHk99aDVbCQXOF9o2ExeJuYgCTtJCQt8jAmNRIuFn8WLp+Jeua5EVeD9MOytxr3TDrl
         42Gjgy7cKBN210DYo2HMn0fLevGu8YU9LJJexM66cfF/Vyfh0o1jJvLesRJY1jzvTrHY
         lgB1Dw0FgAvc0JFRP9dIfVvYC2DWYhtDa2xv9kDap0IwNzxYNpGf0p+VJtgsisaaz6g3
         vdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pcxAdiImyK4B9yAh9TbVrtYx8EXTONj/TcOyvXcVc/w=;
        b=qRlYxii8Gb038htT/CmReqOeXhLA+G3QgGPhJRXb2B/I1iJSo2hGIU2ep6LJ2Ka97S
         YdkptIO3BxlsnZiHOm4vLUZN6rjVP4Sxh9lWkc+BTBEx5Zrj0b/t28QErRWFL+haxGw/
         ocikLafOC/3+/wXyugRrq7yQD6+LF2jGcv2jIj7WSGPvO7RcSvxKU2TfSxafVWY942L0
         OnQxAJIfAAgePigO4/43sedgUvLlHLShv+pZr+jorOoNo4/22dginDbaujtM01qiZek1
         AHLIqBzNfU/rkl9UAw7Atu2pB8ZjKxAQaAQA3UnRH2JrHaZc8B0aCtcMaMg7pmAq20iX
         se1g==
X-Gm-Message-State: AOAM531rHk9p4/OG2c33WG72AhNtiEh/ib0169mvKkmlvL9iGKulWfw7
        H9N/gjszYsOgQeZ/LqCDdI8=
X-Google-Smtp-Source: ABdhPJy/zaT7plcB3tvHhl/Hpepe77JRbwCNy/Dr/KHLrPS39wxAwzG7aHd2SV7knXlhbWOjRnA8Gw==
X-Received: by 2002:a05:6830:4105:: with SMTP id w5mr3188437ott.36.1633485503240;
        Tue, 05 Oct 2021 18:58:23 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-2b16-c5f3-6fcc-9065.res6.spectrum.com. [2603:8081:140c:1a00:2b16:c5f3:6fcc:9065])
        by smtp.gmail.com with ESMTPSA id e2sm4016057otk.46.2021.10.05.18.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 18:58:23 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v5 1/6] RDMA/rxe: Move AV from rxe_send_wqe to rxe_send_wr
Date:   Tue,  5 Oct 2021 20:58:10 -0500
Message-Id: <20211006015815.28350-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006015815.28350-1-rpearsonhpe@gmail.com>
References: <20211006015815.28350-1-rpearsonhpe@gmail.com>
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

