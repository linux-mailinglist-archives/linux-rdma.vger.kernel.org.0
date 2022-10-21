Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E462607F70
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 22:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiJUUCy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 16:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiJUUCW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 16:02:22 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D5D263B67
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:11 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-12c8312131fso4910968fac.4
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlLIib9VYaRcJOHWfnIenhWFOSeBBzkMaeQ6xNMElCo=;
        b=WtdKxcNOSO7Q0zAYjpADfP1UvL0cI1lyxzuUOIf+Q80Z+fswgjuzudNVmpDdn3Bbx/
         sJGECRF/4psLq4nV/DtFdk+7EEoFs9entbIZgdYAo9EPhvlVw9I/CdN5wXPrHBEySszh
         OeE3WkU+Oe5YtLXTl+tKVBAEnmTWM4Z4uWgjG2hf+o3eReRcKpb4TGR1v77T1p6aqPe2
         1RpmtmPhFEvERU8a3daUyjKCNK+stkD/LlL8L60O5TmV4+JIcet2Q40iZbdNZNpUI3Rw
         JlHMuUt4BKe3mO4/daSlFm+QW/Uyu94lkTGbmgrS45RDw46bfkPNTZAZtE/OqnBtaHZO
         bAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlLIib9VYaRcJOHWfnIenhWFOSeBBzkMaeQ6xNMElCo=;
        b=1HN8y9s/nlSrR3Rmlm172r50JybLxzmPypcwcrUX0lMi+8gv7zGfOKgpmEK9PoDzXe
         /8Jofalk8QgmzVXxEIKrhsghbrOr+qO4oN9a5IwJLBjDpXV0rULxPWT9UyOPZ16RPDKj
         jlDgrxVsRFXJbU1dW47juT9yUp1vSq+ViIrfJU+eIKFUH6yCsXkxicymj+AaIbOjdRKG
         f2+EKICfxQsduGWtSMFcjXk6Ml4oCjnuIS9/SFdI6Nr9o94jrjb+LXBptSN3iwcPjK4r
         6FVR0ARmT9KH0jISbxBn/j1H4+VXs97BfrMWDKiI4gV2fQIDzhn+COd4QG8IvQE3C8Bm
         Ok8A==
X-Gm-Message-State: ACrzQf0L2kcymlQUXhOf/qs5PXnb2Z9njmKBf3y0ljYmx/ecpnDsZ3EZ
        g8P9NxHhk7uXoiDeBb83BWtZ6iCCrk4=
X-Google-Smtp-Source: AMsMyM4kjdgbZkAPm+2Tr7habAHupofVksCQQnVMw5EuBqPYuv7A8OVaVVyYD0MHNc9b6pe335RwNQ==
X-Received: by 2002:a05:6870:5b89:b0:132:1241:fb5f with SMTP id em9-20020a0568705b8900b001321241fb5fmr12926761oab.74.1666382530952;
        Fri, 21 Oct 2022 13:02:10 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a860-f1d2-9e17-7593.res6.spectrum.com. [2603:8081:140c:1a00:a860:f1d2:9e17:7593])
        by smtp.googlemail.com with ESMTPSA id s23-20020a056870631700b00132f141ef2dsm10674684oao.56.2022.10.21.13.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 13:02:10 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, ian.ziemba@hpe.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, haris.phnx@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 08/18] RDMA/rxe: Split rxe_drain_resp_pkts()
Date:   Fri, 21 Oct 2022 15:01:09 -0500
Message-Id: <20221021200118.2163-9-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021200118.2163-1-rpearsonhpe@gmail.com>
References: <20221021200118.2163-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Split rxe_drain_resp_pkts() into two subroutines which perform separate
functions.

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index d2a250123617..5d434cce2b69 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -524,17 +524,21 @@ static inline enum comp_state complete_wqe(struct rxe_qp *qp,
 	return COMPST_GET_WQE;
 }
 
-static void rxe_drain_resp_pkts(struct rxe_qp *qp, bool notify)
+static void rxe_drain_resp_pkts(struct rxe_qp *qp)
 {
 	struct sk_buff *skb;
-	struct rxe_send_wqe *wqe;
-	struct rxe_queue *q = qp->sq.queue;
 
 	while ((skb = skb_dequeue(&qp->resp_pkts))) {
 		rxe_put(qp);
 		kfree_skb(skb);
 		ib_device_put(qp->ibqp.device);
 	}
+}
+
+static void rxe_drain_send_queue(struct rxe_qp *qp, bool notify)
+{
+	struct rxe_send_wqe *wqe;
+	struct rxe_queue *q = qp->sq.queue;
 
 	while ((wqe = queue_head(q, q->type))) {
 		if (notify) {
@@ -565,6 +569,7 @@ int rxe_completer(void *arg)
 	struct sk_buff *skb = NULL;
 	struct rxe_pkt_info *pkt = NULL;
 	enum comp_state state;
+	bool notify;
 	int ret;
 
 	if (!rxe_get(qp))
@@ -572,8 +577,9 @@ int rxe_completer(void *arg)
 
 	if (!qp->valid || qp->comp.state == QP_STATE_ERROR ||
 	    qp->comp.state == QP_STATE_RESET) {
-		rxe_drain_resp_pkts(qp, qp->valid &&
-				    qp->comp.state == QP_STATE_ERROR);
+		notify = qp->valid && (qp->comp.state == QP_STATE_ERROR);
+		rxe_drain_resp_pkts(qp);
+		rxe_drain_send_queue(qp, notify);
 		goto exit;
 	}
 
-- 
2.34.1

