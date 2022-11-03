Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A046185D5
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Nov 2022 18:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiKCRLe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Nov 2022 13:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiKCRKq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Nov 2022 13:10:46 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8662624
        for <linux-rdma@vger.kernel.org>; Thu,  3 Nov 2022 10:10:35 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-13b23e29e36so2875110fac.8
        for <linux-rdma@vger.kernel.org>; Thu, 03 Nov 2022 10:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDWhhmoLCvQb/2C5OWiEIWP2Q00NyIokzTFhjSEPio8=;
        b=BMcYuEeBRaswdS1Mx7FULlFHg3CZ4wCueM7japi/2/0lP38jfLh5xlJGYHhkewaqQV
         EReGbL38CUR83h5WiK+clWB92EQgDEDB8Mxt9lv5DdMEz/JOdrwpgwg+Ul49uKNmZEEq
         XwVjw+YfU0NgmuMa4rDqNFpBg9SwIKxDvjEcqkmId2veQiWLlVVfHU7XU/h1QklnYCbE
         XiByurRYN9OSe6PVzXW5+ziDXeIGfdHQfkT71jGWyc60WQEIkeeGmOUj2GseLm5Zqhkp
         DxxPyoFqSh2Q+7OwzdPHblfAb1xmr6U6Fcju+KM4umUASSX3ACH3lFwRqWPMqnOOnxj/
         jc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDWhhmoLCvQb/2C5OWiEIWP2Q00NyIokzTFhjSEPio8=;
        b=ZBHQjT7eoDmibKL+uHBlA0rJfbVWbee/EEp+bXwnFmuKUbWBUSMzl1dn7dTr1POJoW
         unpntyQ1HGzdTgXCcAiUgcI6q8XdVSR2lKJ9z2PlzugsLiAjqX0p+v/n42g/OOxwnplK
         gKxWlTB9bjPqQ/JK8X0z1p55nc/5ihI9j++/+/F6uYy9Drff0Px+x+P8fR0yOdqn1NGO
         r3JV4xdX4l9/3rGwuq/gAUaCC3rbJtBE+j7Y14JMYIPjVRNLPCLY0HyUxPr7y/NmokRn
         AMMDdHSkGe6drM1aSe7YzcQQQiZS3llH8RXZcOURj4cE6HRXxWpIVWQI+jE4Up2JXSka
         V+oA==
X-Gm-Message-State: ACrzQf2Mkg6Jb/LCg9e5xtadMKlQeCwUwJUh5Gt2V8BKTTPq39/B2t97
        kcmwlTQ990BFinN2PKXfmEM=
X-Google-Smtp-Source: AMsMyM59sBwfrfCYadv5JhlUwiAkmEMmqQPxGm3ST2cerjvhNh5RDcUDeUBsBg6wA/65Uv32qFantw==
X-Received: by 2002:a05:6870:b14f:b0:127:d4f1:6a90 with SMTP id a15-20020a056870b14f00b00127d4f16a90mr18527681oal.116.1667495434613;
        Thu, 03 Nov 2022 10:10:34 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-b254-769c-82c0-77a4.res6.spectrum.com. [2603:8081:140c:1a00:b254:769c:82c0:77a4])
        by smtp.googlemail.com with ESMTPSA id m1-20020a056870a10100b0012b298699dbsm624304oae.1.2022.11.03.10.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:10:34 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 02/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_comp.c
Date:   Thu,  3 Nov 2022 12:10:00 -0500
Message-Id: <20221103171013.20659-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103171013.20659-1-rpearsonhpe@gmail.com>
References: <20221103171013.20659-1-rpearsonhpe@gmail.com>
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

Replace calls to pr_xxx() in rxe_comp.c with rxe_dbg_xxx().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 66f392810c86..4dca4f8bbb5a 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -114,7 +114,7 @@ void retransmit_timer(struct timer_list *t)
 {
 	struct rxe_qp *qp = from_timer(qp, t, retrans_timer);
 
-	pr_debug("%s: fired for qp#%d\n", __func__, qp->elem.index);
+	rxe_dbg_qp(qp, "retransmit timer fired\n");
 
 	if (qp->valid) {
 		qp->comp.timeout = 1;
@@ -334,7 +334,7 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 				return COMPST_ERROR;
 
 			default:
-				pr_warn("unexpected nak %x\n", syn);
+				rxe_dbg_qp(qp, "unexpected nak %x\n", syn);
 				wqe->status = IB_WC_REM_OP_ERR;
 				return COMPST_ERROR;
 			}
@@ -345,7 +345,7 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 		break;
 
 	default:
-		pr_warn("unexpected opcode\n");
+		rxe_dbg_qp(qp, "unexpected opcode\n");
 	}
 
 	return COMPST_ERROR;
@@ -598,8 +598,7 @@ int rxe_completer(void *arg)
 	state = COMPST_GET_ACK;
 
 	while (1) {
-		pr_debug("qp#%d state = %s\n", qp_num(qp),
-			 comp_state_name[state]);
+		rxe_dbg_qp(qp, "state = %s\n", comp_state_name[state]);
 		switch (state) {
 		case COMPST_GET_ACK:
 			skb = skb_dequeue(&qp->resp_pkts);
@@ -746,8 +745,7 @@ int rxe_completer(void *arg)
 				 * rnr timer has fired
 				 */
 				qp->req.wait_for_rnr_timer = 1;
-				pr_debug("qp#%d set rnr nak timer\n",
-					 qp_num(qp));
+				rxe_dbg_qp(qp, "set rnr nak timer\n");
 				mod_timer(&qp->rnr_nak_timer,
 					  jiffies + rnrnak_jiffies(aeth_syn(pkt)
 						& ~AETH_TYPE_MASK));
-- 
2.34.1

