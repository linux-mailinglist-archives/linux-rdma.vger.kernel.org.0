Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07DA3CCAD9
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jul 2021 23:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhGRVal (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 17:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbhGRVak (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 18 Jul 2021 17:30:40 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E1AC061764
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jul 2021 14:27:41 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id w194so18439797oie.5
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jul 2021 14:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EFI/GfRFGOP1NZOrOUXrnngHrueYs1pXzobn8r6/VKQ=;
        b=Ph6HDs9svMcNdly1XHDgh8oyNxF/rS6Ivm2iTnO6h/77P7Q6HG/ERRG4FfM2cMO6Fe
         Qlen+01fNKyIRn7WYBhwJ2GWs8RdGcFCMTfEqAbtqkdi3VDFpVQsfHwVVYjUJU9VTzUX
         O5DEefBZk4uEJMG9FVzzKwRIfws64ik19uvp/qfNHEyIP0MywGF4z/N7eARNOEAyG7JZ
         Nf+KsIdxT3Kgw50I8kF0G/rq2amMiB90WD+E7PqkhAreHu9yoRNrKRlKJyUw7VOP4VoD
         m9I+TTlxdN7McvPQEUzBQrqVaEA2mvTqZmwd+pdM0inw/+kkmr+Z98v7M0UDSxcsxhCi
         VDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EFI/GfRFGOP1NZOrOUXrnngHrueYs1pXzobn8r6/VKQ=;
        b=ji0M8I+A63Q8/7Oomk3ldLW+Wt6Rr7tBOYos6LLrU+Eaj+Er+zH/4mV1th2Z3HkO/Z
         Dbkr+peyfC7dcaae+DsKLy7reITQ0CYnT3PDrFv7hR97TzUVHeKhUNuEC3rxg7Qkg0wc
         Om92pj7h8Cbj5Ku1ew6x7DCsGjt9C/LfzENJsYU4PQsEmBQiPcj/2hurT80n8JGE8JaJ
         eGlEvzDJqa9itPyrw0guAQDlp/eslrLAqBd/PMF8PYy/4ta1dzEKvu+WRfZ0NMd830dx
         k/qK5xqMqKJPVP7jz8iGJsCU6DElT7EsigItX3zk0677aXNevG3QSkoSas2dkVFyWR5d
         H/Og==
X-Gm-Message-State: AOAM5336ZEBe+BlF0med79EYobqnGoDb5pzEiX73NpqDuelnCaCXdRF/
        v2PvJbVvqIhZ1kkjqY3XLkw=
X-Google-Smtp-Source: ABdhPJzWGiGx/mUiKnMxM4HKDBdAypS7x2lVRtJOPoL6H/jxgtZZqxPcuwAawyfCKdNeHOfPcrYwCg==
X-Received: by 2002:a54:4094:: with SMTP id i20mr3698661oii.159.1626643661057;
        Sun, 18 Jul 2021 14:27:41 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-0284-9a3c-0f8a-4ac7.res6.spectrum.com. [2603:8081:140c:1a00:284:9a3c:f8a:4ac7])
        by smtp.gmail.com with ESMTPSA id 39sm3199152otg.36.2021.07.18.14.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 14:27:40 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 5/5] RDMA/rxe: Convert kernel UD post send to use ah_num
Date:   Sun, 18 Jul 2021 16:27:04 -0500
Message-Id: <20210718212703.21471-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210718212703.21471-1-rpearsonhpe@gmail.com>
References: <20210718212703.21471-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Modify ib_post_send for kernel UD sends to put the AH index into the
WQE instead of the address vector.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 1cc12c913e39..5d63e276306c 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -558,8 +558,11 @@ static void init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
 	if (qp_type(qp) == IB_QPT_UD ||
 	    qp_type(qp) == IB_QPT_SMI ||
 	    qp_type(qp) == IB_QPT_GSI) {
+		struct ib_ah *ibah = ud_wr(ibwr)->ah;
+
 		wr->wr.ud.remote_qpn = ud_wr(ibwr)->remote_qpn;
 		wr->wr.ud.remote_qkey = ud_wr(ibwr)->remote_qkey;
+		wr->wr.ud.ah_num = to_rah(ibah)->ah_num;
 		if (qp_type(qp) == IB_QPT_GSI)
 			wr->wr.ud.pkey_index = ud_wr(ibwr)->pkey_index;
 		if (wr->opcode == IB_WR_SEND_WITH_IMM)
@@ -631,12 +634,6 @@ static void init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 		return;
 	}
 
-	if (qp_type(qp) == IB_QPT_UD ||
-	    qp_type(qp) == IB_QPT_SMI ||
-	    qp_type(qp) == IB_QPT_GSI)
-		memcpy(&wqe->wr.wr.ud.av, &to_rah(ud_wr(ibwr)->ah)->av,
-		       sizeof(struct rxe_av));
-
 	if (unlikely(ibwr->send_flags & IB_SEND_INLINE))
 		copy_inline_data_to_wqe(wqe, ibwr);
 	else
-- 
2.30.2

