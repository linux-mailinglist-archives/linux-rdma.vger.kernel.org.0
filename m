Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0601A526E67
	for <lists+linux-rdma@lfdr.de>; Sat, 14 May 2022 09:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiENDHm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 May 2022 23:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiENDHk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 May 2022 23:07:40 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324B131E983
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 20:07:39 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id m6-20020a05683023a600b0060612720715so6238873ots.10
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 20:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wJzCta5hxvHHdGkcEjDzislssJoy6pu0EOCtdvMke5A=;
        b=cfBGX4amal5TQbU5ktgCGpDmB3APk1y4IE6lVXHjAv1ZzETScRc9ra3ck1oqQZ5rfr
         hNqyGsVqJMEr6gmIuFgnLCg6TF8bhyrkkFK2iMeXuowllI7Aw5NbSiQVjP60QViydAen
         xSa8vtxLBvsNYI4zho4mLBcq+efm6gcmwQM0Bkf6E/tNyieaCPtoNodNGw4psmjIdm8N
         EzSUXqZaU14Jka0H8OiEfTA8Xc6RrHVaJGYPw5NhztV+TpTjZtdA0fDDnrQipQjGGxDB
         Bi/Ywzte+JvQfEr0ODdpAgmSLLYCdJ+YpVR18mMzKsBRFL9C0xFgbS99A+KLQ2v5sx8n
         TBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wJzCta5hxvHHdGkcEjDzislssJoy6pu0EOCtdvMke5A=;
        b=B5qRlnFDTTcYTIbQbLfQ+azYNZ0W8fDxTMu7FzM19KgYj4a0GrLQOz38USpA4gPo9C
         Qza+MyCL5YVTt/3EJs0jX5aM/Nire6Rn6Hm8yLY/GfpVXZygqKxl0e/h559PAjT4UgUj
         fb6IIk/jAmgMCPXfrdU/8LdxD98CHV1FWlt0ZSsjbrkb7D2p/spS8vM48ZckqKTanGEk
         JjzJ3MzPduOYRiX9CiucV6iMYf3KZEYegi5tcjlf1v/G0mvlte6pp6x4vfRUrLxBZQUf
         p478/eE+F/QJ6TChmvdmRAXGkHSANbaWWcCHwsfMbjAMFo57ss/D6IxJCAF1CqzvOLHl
         jayQ==
X-Gm-Message-State: AOAM533KTahoxAg2WgCWUM14uvT0WlmGwGFWlAUV71bGdB0tM37W0oEK
        EEug6D/5jIWssJ0pUC62Vxw=
X-Google-Smtp-Source: ABdhPJzY7yI41Pkzn9QVS0soDldDhIrPzyG2NyafIkJfbm+sy8blA+9n9PHksTzOGJxZFcDDcRkYhQ==
X-Received: by 2002:a9d:20e5:0:b0:606:8c4a:c671 with SMTP id x92-20020a9d20e5000000b006068c4ac671mr2909821ota.342.1652497658535;
        Fri, 13 May 2022 20:07:38 -0700 (PDT)
Received: from u-22.tx.rr.com (2603-8081-140c-1a00-0642-4ec7-2b63-14d6.res6.spectrum.com. [2603:8081:140c:1a00:642:4ec7:2b63:14d6])
        by smtp.googlemail.com with ESMTPSA id h64-20020a9d2f46000000b0060603221262sm1691176otb.50.2022.05.13.20.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 20:07:38 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, tom@talpey.com,
        linux-rdma@vger.kernel.org, jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-rc v2 1/4] RDMA/rxe: Rename qp->qp_timeout_jiffies
Date:   Fri, 13 May 2022 22:04:34 -0500
Message-Id: <20220514030435.91155-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220514030435.91155-1-rpearsonhpe@gmail.com>
References: <20220514030435.91155-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace qp->qp_timeout_jiffies by the shorter name
qp->timeout_jiffies which is a little less redundant.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  | 4 ++--
 drivers/infiniband/sw/rxe/rxe_qp.c    | 8 ++++----
 drivers/infiniband/sw/rxe/rxe_req.c   | 5 +++--
 drivers/infiniband/sw/rxe/rxe_verbs.h | 6 +++---
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 138b3e7d3a5f..badd423966dc 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -672,9 +672,9 @@ int rxe_completer(void *arg)
 			if ((qp_type(qp) == IB_QPT_RC) &&
 			    (qp->req.state == QP_STATE_READY) &&
 			    (psn_compare(qp->req.psn, qp->comp.psn) > 0) &&
-			    qp->qp_timeout_jiffies)
+			    qp->timeout_jiffies)
 				mod_timer(&qp->retrans_timer,
-					  jiffies + qp->qp_timeout_jiffies);
+					  jiffies + qp->timeout_jiffies);
 			ret = -EAGAIN;
 			goto done;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 62acf890af6c..fc22ff36fdea 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -253,7 +253,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	rxe_init_task(rxe, &qp->comp.task, qp,
 		      rxe_completer, "comp");
 
-	qp->qp_timeout_jiffies = 0; /* Can't be set for UD/UC in modify_qp */
+	qp->timeout_jiffies = 0; /* Can't be set for UD/UC in modify_qp */
 	if (init->qp_type == IB_QPT_RC) {
 		timer_setup(&qp->rnr_nak_timer, rnr_nak_timer, 0);
 		timer_setup(&qp->retrans_timer, retransmit_timer, 0);
@@ -633,12 +633,12 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 	if (mask & IB_QP_TIMEOUT) {
 		qp->attr.timeout = attr->timeout;
 		if (attr->timeout == 0) {
-			qp->qp_timeout_jiffies = 0;
+			qp->timeout_jiffies = 0;
 		} else {
 			/* According to the spec, timeout = 4.096 * 2 ^ attr->timeout [us] */
 			int j = nsecs_to_jiffies(4096ULL << attr->timeout);
 
-			qp->qp_timeout_jiffies = j ? j : 1;
+			qp->timeout_jiffies = j ? j : 1;
 		}
 	}
 
@@ -781,7 +781,7 @@ int rxe_qp_chk_destroy(struct rxe_qp *qp)
 void rxe_qp_destroy(struct rxe_qp *qp)
 {
 	qp->valid = 0;
-	qp->qp_timeout_jiffies = 0;
+	qp->timeout_jiffies = 0;
 	rxe_cleanup_task(&qp->resp.task);
 
 	if (qp_type(qp) == IB_QPT_RC) {
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index ae5fbc79dd5c..1884e3a64310 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -157,6 +157,7 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
 		return NULL;
 
 	wqe = queue_addr_from_index(q, index);
+	WARN_ON((long)wqe & (L1_CACHE_BYTES - 1));
 
 	if (unlikely((qp->req.state == QP_STATE_DRAIN ||
 		      qp->req.state == QP_STATE_DRAINED) &&
@@ -538,9 +539,9 @@ static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 
 	qp->need_req_skb = 0;
 
-	if (qp->qp_timeout_jiffies && !timer_pending(&qp->retrans_timer))
+	if (qp->timeout_jiffies && !timer_pending(&qp->retrans_timer))
 		mod_timer(&qp->retrans_timer,
-			  jiffies + qp->qp_timeout_jiffies);
+			  jiffies + qp->timeout_jiffies);
 }
 
 static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index e7eff1ca75e9..83b6f80440d8 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -249,11 +249,11 @@ struct rxe_qp {
 	 * started. The responder resets it whenever an ack is
 	 * received.
 	 */
-	struct timer_list retrans_timer;
-	u64 qp_timeout_jiffies;
+	struct timer_list	retrans_timer;
+	u64			timeout_jiffies;
 
 	/* Timer for handling RNR NAKS. */
-	struct timer_list rnr_nak_timer;
+	struct timer_list	rnr_nak_timer;
 
 	spinlock_t		state_lock; /* guard requester and completer */
 
-- 
2.34.1

