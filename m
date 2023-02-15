Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F01698818
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Feb 2023 23:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBOWuw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Feb 2023 17:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBOWuv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Feb 2023 17:50:51 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2D32683
        for <linux-rdma@vger.kernel.org>; Wed, 15 Feb 2023 14:50:50 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 70-20020a9d084c000000b0068bccf754f1so102806oty.7
        for <linux-rdma@vger.kernel.org>; Wed, 15 Feb 2023 14:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJRMVeNtIB7JjWOFIfKTi20wn0MYbuzFHQy/pRHB81I=;
        b=mFG3NwA0GZN1ICtz5WvSan/L0hyyrht335gRHq2gvLrtdbOmbZG3lpja3AGQ9u/H6W
         aXyPsba8FoqCzy+/SeSR60+JfuL0hnwww69C5GTcKEtuzcNBygDc5nqJX860xKSnt27M
         lHjFEIbFDO3bkiYJkHZTexugpyVAwGP5NnNLR1hYjOYAxQkNi8eJBjXP7phlISXBtU9Q
         ISsbgPCRI/UO0dUxwWRqaY5mC/B4aRwuzEbN02cP4hM6LydcEH9vnkglpse1oZ9iDmay
         QAwcAEp622mTYosI3KBet6lGPXlzZI/xzIB/oBZ14VnwCnNXtloidQE6yURun4N3M1tr
         0rRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJRMVeNtIB7JjWOFIfKTi20wn0MYbuzFHQy/pRHB81I=;
        b=54/blONlx0zc7mYdjM0vSC+N4miDq91ZCB+xK+yiqhuRLuOo9G+/pPKQCvqsH/t4dc
         445oSwt8Xdpykn23p7wWK8w6ceoAx5EwhYKpE3z3iWslQHY3JM4qTYTfaiIF0mkK6MiX
         DlQxlPuvCcfVGqg1VWX7wuhUZkAVjaG3vfPgnQUeS1OOYwlsCtKT+dXoM0VozBhITNg8
         5853r85BSp0uismrW6IBHF1avCTLf8aa46IA21Cc66QROZpKU5wLxPIAtPoMgdw0/762
         4HbVOIWqjtSfJdgQTr3DkP8TXtqADGOX7whlO1cMm/7aUUjFYMhR0I7b0+FQ7woCwDwl
         93+A==
X-Gm-Message-State: AO0yUKU83nIEudJP6UuJh/EJ8RbX1dZCJYDHfME+CXK9iBW6T24XA5TP
        We5FHZwpb90hFh/y27/8x00=
X-Google-Smtp-Source: AK7set/oC7k17nxVgq481ZfsCH1cD3L42Owfk39FdeCSYTA91VJyIuqE/0l64jD1zeyEVPMcBx9pCw==
X-Received: by 2002:a9d:6e04:0:b0:68f:37e0:3afe with SMTP id e4-20020a9d6e04000000b0068f37e03afemr1866327otr.12.1676501449912;
        Wed, 15 Feb 2023 14:50:49 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id w1-20020a056830110100b0068d752f1870sm4862otq.5.2023.02.15.14.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 14:50:49 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 1/1] RDMA-rxe: Allow retry sends for rdma read responses
Date:   Wed, 15 Feb 2023 16:44:21 -0600
Message-Id: <20230215224419.9195-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230215224419.9195-1-rpearsonhpe@gmail.com>
References: <20230215224419.9195-1-rpearsonhpe@gmail.com>
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

This patch modifies read_reply() in rxe_resp.c to retry the
send if err == -EAGAIN. When IP does drop a packet it requires
more time to recover than a simple retry takes so a subroutine
read_retry_delay() is added that dynamically estimates the time
required for this recovery and inserts a delay before the retry.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c  | 62 +++++++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |  9 ++++
 2 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index cd2d88de287c..4e2fa2d72e70 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -863,6 +863,57 @@ static struct rxe_mr *rxe_recheck_mr(struct rxe_qp *qp, u32 rkey)
 	return mr;
 }
 
+/* Compute the delay to insert before retrying sending a
+ * dropped read reply packet in microseconds. Compute as half
+ * the average burst delay over the last 128 delay bursts.
+ * Slowly decay the delay if many good packets are seen.
+ */
+static int read_retry_delay(struct rxe_qp *qp, int err)
+{
+	struct tune_read_drop *tune = &qp->resp.tune_read_drop;
+	u32 delay = tune->delay;
+	u32 num = tune->num_bursts;
+	u32 good = tune->num_good_pkts;
+	u32 burst = tune->burst_delay;
+	u32 tot = tune->total_delay;
+
+	if (err == -EAGAIN) {
+		burst += delay;
+		good = 0;
+	} else if (burst) {
+		tot += burst;
+		burst = 0;
+		num++;
+	} else {
+		good++;
+	}
+
+	if (num >= (1 << 7)) {
+		delay = tot >> 8;
+		tot = 0;
+		num = 0;
+		rxe_dbg_qp(qp, "delay = %d", delay);
+	}
+
+	if (delay > 1 && good > 512) {
+		good = 0;
+		delay--;
+	}
+
+	/* make sure delay is at least 1 else algorithm breaks
+	 * with tot = burst = 0 -> delay = 0
+	 */
+	delay = delay ?: 1;
+
+	tune->delay = delay;
+	tune->num_bursts = num;
+	tune->num_good_pkts = good;
+	tune->burst_delay = burst;
+	tune->total_delay = tot;
+
+	return delay;
+}
+
 /* RDMA read response. If res is not NULL, then we have a current RDMA request
  * being processed or replayed.
  */
@@ -878,6 +929,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	int err;
 	struct resp_res *res = qp->resp.res;
 	struct rxe_mr *mr;
+	int delay;
 
 	if (!res) {
 		res = rxe_prepare_res(qp, req_pkt, RXE_READ_MASK);
@@ -909,8 +961,6 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST;
 	}
 
-	res->state = rdatm_res_state_next;
-
 	payload = min_t(int, res->read.resid, mtu);
 
 	skb = prepare_ack_packet(qp, &ack_pkt, opcode, payload,
@@ -937,9 +987,15 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	}
 
 	err = rxe_xmit_packet(qp, &ack_pkt, skb);
-	if (err)
+	delay = read_retry_delay(qp, err);
+	if (err == -EAGAIN) {
+		udelay(delay);
+		return RESPST_READ_REPLY;
+	} else if (err) {
 		return RESPST_ERR_RNR;
+	}
 
+	res->state = rdatm_res_state_next;
 	res->read.va += payload;
 	res->read.resid -= payload;
 	res->cur_psn = (res->cur_psn + 1) & BTH_PSN_MASK;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index c269ae2a3224..84994a474e9a 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -203,6 +203,15 @@ struct rxe_resp_info {
 		struct ib_sge		sge[RXE_MAX_SGE];
 	} srq_wqe;
 
+	/* dynamic delay tuning for read reply drops */
+	struct tune_read_drop {
+		u32			total_delay;
+		u32			burst_delay;
+		u32			num_bursts;
+		u32			num_good_pkts;
+		u32			delay;
+	}			tune_read_drop;
+
 	/* Responder resources. It's a circular list where the oldest
 	 * resource is dropped first.
 	 */
-- 
2.37.2

