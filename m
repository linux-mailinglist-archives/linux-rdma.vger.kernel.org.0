Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141AA61532C
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Nov 2022 21:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiKAUYA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Nov 2022 16:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiKAUX6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Nov 2022 16:23:58 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB811EC5A
        for <linux-rdma@vger.kernel.org>; Tue,  1 Nov 2022 13:23:56 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-13bd2aea61bso18180644fac.0
        for <linux-rdma@vger.kernel.org>; Tue, 01 Nov 2022 13:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxXQWRXx2VSWrNX2SesjY05W4BgTQKiZzjs6+V20W2I=;
        b=PsI8bbFk6RBmWhfhUTi7JAxMqqFprdvumuy1KpX1RQYTzYxO1cLjpDoucvamFnzq2D
         imjIOZbo6G6c2L33AbdpxWSEtOZ2TTIyacL8xqP+7Xw9T0JeIZtnpB4oIiwaucmX4stY
         HyPjftG+McwcOGTzqh8M7GLGjI8z8JVSeoZf/yH3My8gN3hTcQpP7n1PNALfOhJ9VGFp
         ChF8zNLsewt+7Jb/N9WokCocV4vs8ahmfpNSQVrHFEJyAUPG4cjQrkCGPSj2Hl0LfZYn
         t5xjr3Gzdd7Q+KlPPHbNWHk3hvw3XcdjPrSMMXQWQHqsz2Wl7laAbCotHo8G4PeQquw0
         UeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxXQWRXx2VSWrNX2SesjY05W4BgTQKiZzjs6+V20W2I=;
        b=HoVjoYrJat7+64qg1McEryyQPAVOCHz6oqC95ZwoqEDI8oqjGCIeq5YKPmWnORNMo1
         QJZYGG/XC1JvsnTJ35/JwVtkaDkArH1uzKUrRvE3YtncTSAvV5x6zTOlyLPmZWmDqG7d
         3Q2r3rZ9kfMZ4k0CL5N1Jik2/1rUYKqJnkG1icmZxrPUs/KpPSvTAUBvIcBa7z4YQLZv
         eL/bvcdwwn7XfkZfjBpcvTZAFmhlqBeiPeTViO2zvS18JEdRRkByYTvODGfQl2WFbyRi
         MZVuDo13E1r08nh5oaCgj+xn/KRHsWXmEQOatbei/OfMF4W684HFRqkTNCQkd6dIY3wb
         UhoA==
X-Gm-Message-State: ACrzQf24Bvaya6aSnZhn7kuM+lCGMHwtongAiRSChqBzUQIkshp9VyOA
        QECPiyTlgyJlEwOIla8hRo0=
X-Google-Smtp-Source: AMsMyM573vNMmDzX709FBcxEgJT9xqIZQpUhrBnpoxP/YBdn5pC+I10Lxotjm3aaywDEBx1ccx07LQ==
X-Received: by 2002:a05:6871:79f:b0:13c:265b:75d2 with SMTP id o31-20020a056871079f00b0013c265b75d2mr20057276oap.175.1667334235823;
        Tue, 01 Nov 2022 13:23:55 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-e052-4710-92ba-8142.res6.spectrum.com. [2603:8081:140c:1a00:e052:4710:92ba:8142])
        by smtp.googlemail.com with ESMTPSA id d22-20020a056830045600b0066210467fb1sm4337493otc.41.2022.11.01.13.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:23:55 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 08/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_qp in rxe_req.c
Date:   Tue,  1 Nov 2022 15:22:33 -0500
Message-Id: <20221101202238.32836-9-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101202238.32836-1-rpearsonhpe@gmail.com>
References: <20221101202238.32836-1-rpearsonhpe@gmail.com>
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

Replace calls to rxe_err/warn in rxe_req.c with rxe_dbg_qp().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 41f1d84f0acb..4d45f508392f 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -100,7 +100,7 @@ void rnr_nak_timer(struct timer_list *t)
 {
 	struct rxe_qp *qp = from_timer(qp, t, rnr_nak_timer);
 
-	pr_debug("%s: fired for qp#%d\n", __func__, qp_num(qp));
+	rxe_dbg_qp(qp, "nak timer fired\n");
 
 	/* request a send queue retry */
 	qp->req.need_retry = 1;
@@ -595,7 +595,7 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 		}
 		break;
 	default:
-		pr_err("Unexpected send wqe opcode %d\n", opcode);
+		rxe_dbg_qp(qp, "Unexpected send wqe opcode %d\n", opcode);
 		wqe->status = IB_WC_LOC_QP_OP_ERR;
 		return -EINVAL;
 	}
@@ -748,14 +748,14 @@ int rxe_requester(void *arg)
 
 	av = rxe_get_av(&pkt, &ah);
 	if (unlikely(!av)) {
-		pr_err("qp#%d Failed no address vector\n", qp_num(qp));
+		rxe_dbg_qp(qp, "Failed no address vector\n");
 		wqe->status = IB_WC_LOC_QP_OP_ERR;
 		goto err;
 	}
 
 	skb = init_req_packet(qp, av, wqe, opcode, payload, &pkt);
 	if (unlikely(!skb)) {
-		pr_err("qp#%d Failed allocating skb\n", qp_num(qp));
+		rxe_dbg_qp(qp, "Failed allocating skb\n");
 		wqe->status = IB_WC_LOC_QP_OP_ERR;
 		if (ah)
 			rxe_put(ah);
@@ -764,7 +764,7 @@ int rxe_requester(void *arg)
 
 	err = finish_packet(qp, av, wqe, &pkt, skb, payload);
 	if (unlikely(err)) {
-		pr_debug("qp#%d Error during finish packet\n", qp_num(qp));
+		rxe_dbg_qp(qp, "Error during finish packet\n");
 		if (err == -EFAULT)
 			wqe->status = IB_WC_LOC_PROT_ERR;
 		else
-- 
2.34.1

