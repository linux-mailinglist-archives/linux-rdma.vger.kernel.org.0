Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40663DBC29
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 17:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239730AbhG3PXS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 11:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239731AbhG3PXR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Jul 2021 11:23:17 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41108C06175F
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 08:23:12 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id q6so13617991oiw.7
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 08:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fnj05AnElTEDmIey9tbpBH46J/j9uzolDEoCBGfzla0=;
        b=BjxfbISsT7l/xbGxmkzhg8mbZJb2dPRvYRHdkY1fvX8xSTXhQjKUR//zcGd+ooaPr2
         HFkI3jmAhtEenrf+RjCCCoLj0kxpvi/yX1lcnFHeIf1tj7SVf77LoV5zBkdbSWTLhI2G
         z2PUIBoFpX6/ldrmOkC6N51daGiJa1zFUIP/hsRl9quwK5ASvxPoY1mDtmt/DGCaU7XD
         XOLybDe9U6LhL4IN0Kn8eFr/rFYh0IfJ7KRE9c6I/J7xtYEgsvLPy1prY7UWHFHlMPFz
         SqCHbmpOlosibuOPx3kizRpi4S+5iMiO3vF7p8Dz5/LwilP4/fcGxh/c0Bq6EY8gbXuA
         6wGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fnj05AnElTEDmIey9tbpBH46J/j9uzolDEoCBGfzla0=;
        b=pt/2piggzWTamF797wnTuRdBUCAWRaEUAtJSq+JPx23SEtT+d+D9I9TDJ6DlfSA5f/
         r3EBLoGwTSBGQrpK41YVl+4c2CqdE0oDBBUi+bRs3FuXLKFfNKOzSCwBTAsVVRrWeSYZ
         zMy5sBR4c23MFavD+CPiz/ht4QHUIlcygaIrjPE23Iq+x/gMcr8EpMqEn8A//jO1pVbz
         TWYO67w+YJMBYX1vT9vgv2rMtf7vCd+HRwWJEe/Cmt+4tG2b4iDRBOH/GgMKG0qbozeg
         IWN5QZg7rTTscGfyOmDkXIepc0IWOB81e6D4WsrZ6ydfndmaQekK1GvmL1ZwEyoxySHk
         +krg==
X-Gm-Message-State: AOAM532HiQDpjOHYrPy/LcCFLJ1z9g2Kp4WF+09+g9iYVWZUvFHZtki7
        Y4fUyAmUgxrgMwOsvFXat3k=
X-Google-Smtp-Source: ABdhPJz19t18sp1rOblOlon/EfpYSGTALnyFkRGygVddZ9wvZGtQ9wv5Z9whB35mabCqZx3k1BSsPA==
X-Received: by 2002:aca:ba89:: with SMTP id k131mr2290268oif.176.1627658591704;
        Fri, 30 Jul 2021 08:23:11 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id 45sm335083oty.16.2021.07.30.08.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 08:23:11 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, xyjxyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Bob Pearson <rpearson@gmail.com>
Subject: [PATCH 4/5] Providers/rxe: Support get srq number
Date:   Fri, 30 Jul 2021 10:21:57 -0500
Message-Id: <20210730152157.67592-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730152157.67592-1-rpearsonhpe@gmail.com>
References: <20210730152157.67592-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add support for ibv_get_srq_num verb.

Signed-off-by: Bob Pearson <rpearson@gmail.com>
---
 providers/rxe/rxe.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 9cdddb8c..d4538713 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -696,6 +696,14 @@ static struct ibv_srq *rxe_create_srq_ex(struct ibv_context *context,
 	return &srq->vsrq.srq;
 }
 
+static int rxe_get_srq_num(struct ibv_srq *ibsrq, uint32_t *srq_num)
+{
+	struct rxe_srq *srq = to_rsrq(ibsrq);
+
+	*srq_num = srq->vsrq.srq_num;
+	return 0;
+}
+
 static int rxe_modify_srq(struct ibv_srq *ibsrq,
 		   struct ibv_srq_attr *attr, int attr_mask)
 {
@@ -1836,6 +1844,7 @@ static const struct verbs_context_ops rxe_ctx_ops = {
 	.query_srq = rxe_query_srq,
 	.destroy_srq = rxe_destroy_srq,
 	.post_srq_recv = rxe_post_srq_recv,
+	.get_srq_num = rxe_get_srq_num,
 	.create_qp = rxe_create_qp,
 	.create_qp_ex = rxe_create_qp_ex,
 	.query_qp = rxe_query_qp,
-- 
2.30.2

