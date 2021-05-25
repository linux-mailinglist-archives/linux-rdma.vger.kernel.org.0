Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6555390A59
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 22:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhEYUOP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 16:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhEYUOP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 16:14:15 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B94C061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 13:12:44 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id h9so31492849oih.4
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 13:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B79RRQBGNm458ZhZ6Ia7jPLTqd+pWFymuAAMYVQjgxU=;
        b=SQJdX8pobUgYws7vdw8pV9BjIMue0ankTIAbBWIQSKm2Nzk46Z90HQlSq5zD4sqjSM
         fTVC5lGE5fE6P/xywfPIgMSvySlrmVoCIFNpGNVy3aAlx44oGMOnkY2aezzwLufd+w2h
         dCOc+6oF38lgfShbj3f7Ml4lhCfAyAhRTvTl0Udwss4XTAUZvvpqnc16SXztcGVyfIQR
         a8epXTciaF3+3paKXGmMsTFXViKi12ctguGQQz+u3DfKP3vK9XagX/hnf9aGkAFy4Dp7
         fZ8+LbMdypatPz93XTcS8S48YmqTywK0PpyPfx5pAYN96Cqa+luq7CwWCNHmt+iCo5B+
         znDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B79RRQBGNm458ZhZ6Ia7jPLTqd+pWFymuAAMYVQjgxU=;
        b=sIUmdl4RfwHHxKlAfqWVKbOMiikjR70hNGBn34ru3Po/pDopSq+BCR2X6eobk+NnOA
         GZg4DIJlJl39NdSW631UO8qhDHVgLEypXpws/dwMWA5sEX4jtYKoNL+NSa+AYyoPGOoC
         SporHTxrYlTF3zlG1tRo0iZa449F2CWQ7/7c/v0q3yajxVrMkAdOEN87Um7VFSFqjjs/
         dxCxzF2zqE5JfmpiKEUMEyPhTvKltmEw03Z1iQoKUbmMdZ/EtB8yIJ+YfZJHPmnh4cQi
         Mgop7+vof9AUPZyLpTLoNfEUv4zeVVvrQ60H5cUaV93Cg/U7FxlBFKXsRo75R+bFpzEj
         NcuA==
X-Gm-Message-State: AOAM531aIB9HtAkMDeasYKh3Po8H0j4EY7oi1oCmlj3/BvdsFIxbXgWU
        mFIgb8ReFFWLh+b32XC8KEA=
X-Google-Smtp-Source: ABdhPJwifQN6J4Ap4zfDLHLL7h7F6fpQ2TDwH4TO/3qDn5J6v15SHfqU1SdQE0SH+iwVxYwhwh5/9g==
X-Received: by 2002:a54:4819:: with SMTP id j25mr14902783oij.2.1621973563792;
        Tue, 25 May 2021 13:12:43 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-e4a4-ac6f-8cca-71ad.res6.spectrum.com. [2603:8081:140c:1a00:e4a4:ac6f:8cca:71ad])
        by smtp.gmail.com with ESMTPSA id p3sm3648417oov.2.2021.05.25.13.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 13:12:43 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyj2020@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Fix memory ordering problem for resize cq
Date:   Tue, 25 May 2021 15:11:12 -0500
Message-Id: <20210525201111.623970-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The rxe driver has recently begun exhibiting failures in the python
tests that are due to stale values read from the completion queue
producer or consumer indices. Unlike the other loads of these shared
indices those in queue_count() were not protected by smp_load_acquire().

This patch replaces loads by smp_load_acquire() in queue_count().
The observed errors no longer occur.

Reported-by: Zhu Yanjun <zyj2020@gmail.com>
Fixes: d21a1240f516 ("RDMA/rxe: Use acquire/release for memory ordering")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_queue.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
index 2902ca7b288c..5cb142282fa6 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.h
+++ b/drivers/infiniband/sw/rxe/rxe_queue.h
@@ -161,8 +161,22 @@ static inline unsigned int index_from_addr(const struct rxe_queue *q,
 
 static inline unsigned int queue_count(const struct rxe_queue *q)
 {
-	return (q->buf->producer_index - q->buf->consumer_index)
-		& q->index_mask;
+	u32 prod;
+	u32 cons;
+	u32 count;
+
+	/* make sure all changes to queue complete before
+	 * changing producer index
+	 */
+	prod = smp_load_acquire(&q->buf->producer_index);
+
+	/* make sure all changes to queue complete before
+	 * changing consumer index
+	 */
+	cons = smp_load_acquire(&q->buf->consumer_index);
+	count = (prod - cons) % q->index_mask;
+
+	return count;
 }
 
 static inline void *queue_head(struct rxe_queue *q)
-- 
2.30.2

