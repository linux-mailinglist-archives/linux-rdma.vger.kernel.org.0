Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78753B6AC4
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 00:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbhF1WFB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Jun 2021 18:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238233AbhF1WEE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Jun 2021 18:04:04 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E154C06121D
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 15:01:36 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so12569216otq.11
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 15:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EZrKiku+/v6vMSCb2MWkZlqaTxKjyI39A6bB7JbysTo=;
        b=DyMXh1Vg17ikh5JLJJpWyzyVfTkEuu8qUpRVxYdFAA9/KNtEhes2LZtlDLspSQMGk7
         chCvVKYVVuq524dtE78QyT0/m2S1FIM8S6QFpXHHaiTWEpJ8W5U6YrAYCACGDqoprU38
         rb1TvmQ3/tieIbsYXkEQSjIzujaIUXrtCGpyk7DuaiNSDmzEmORiVq9mu10SeaF6d6Si
         CCSD1+3vyLyL0K97OdBaWcez8iKHO+NAucNNSCFAFNZrHBaUhoaFusooi6nIdYI3Sa2C
         tHQ2rzQjeoDpZ/FbIWHkVsfS+WsscxO1s2AatD2Moy6/GG8kSFB5sQi4xYI3lhbru5/F
         Y0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EZrKiku+/v6vMSCb2MWkZlqaTxKjyI39A6bB7JbysTo=;
        b=QJg7OVEXlv6RGEZySwS186+jjBXdQn6audJGOBIjOwVPVs48F/1RZ49ctKQmDKbbij
         67MEE8zJwT52Kd/dydBk1SHCAroIsSWy6fgFKRXFExZs+3gk2AG78Y7v2Nb1pGwFO8rS
         0XOu83jPbUf6oQO1m0W2S+bW++5uqKdeop5fORxUWWAC9eZ0bHHLQZF62rgte7LR4MWf
         07u0c6qThA2t+3DgSRPEo+vIhXCxBGjrcg/DJxeYxAcglYv5o795VLSOyrDkCpSBeL3K
         O5EsVfsBIZoS4UZnYk0NjrubAEMzS3aPOX33/euStRvfh8ZuZU7qdqpk//psud+u88X5
         WfTQ==
X-Gm-Message-State: AOAM530FuwabKNcojHDkSaWXi5zPuG9V+T5muYoRchgy6eePPMQQ2JHh
        Cmt7HzpsmjguHXBWiDR0zYo=
X-Google-Smtp-Source: ABdhPJxjRpdPg5crlrHMVUFDCVEE4NvzS8ToBnZBwBaCQl4K6JFDdI38TWF0/xXdP/fVbmwY1GCHVQ==
X-Received: by 2002:a9d:8d0:: with SMTP id 74mr1534681otf.89.1624917695946;
        Mon, 28 Jun 2021 15:01:35 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-aaa9-75eb-6e0f-9f85.res6.spectrum.com. [2603:8081:140c:1a00:aaa9:75eb:6e0f:9f85])
        by smtp.gmail.com with ESMTPSA id 2sm3623910ota.58.2021.06.28.15.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 15:01:35 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 5/5] RDMA/rxe: Convert kernel UD post send to use ah_num
Date:   Mon, 28 Jun 2021 17:00:44 -0500
Message-Id: <20210628220043.9851-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210628220043.9851-1-rpearsonhpe@gmail.com>
References: <20210628220043.9851-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Modify ib_post_send for kernel UD sends to put the AH index into the
WQE instead of the address vector.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 11d166bc11e3..820f67c846e9 100644
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
@@ -631,11 +634,6 @@ static void init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 		return;
 	}
 
-	if (qp_type(qp) == IB_QPT_UD ||
-	    qp_type(qp) == IB_QPT_SMI ||
-	    qp_type(qp) == IB_QPT_GSI)
-		memcpy(&wqe->av, &to_rah(ud_wr(ibwr)->ah)->av, sizeof(wqe->av));
-
 	if (unlikely(ibwr->send_flags & IB_SEND_INLINE))
 		copy_inline_data_to_wqe(wqe, ibwr);
 	else
-- 
2.30.2

