Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D976185DA
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Nov 2022 18:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiKCRLm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Nov 2022 13:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiKCRKr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Nov 2022 13:10:47 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EB926DA
        for <linux-rdma@vger.kernel.org>; Thu,  3 Nov 2022 10:10:42 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-13b23e29e36so2875568fac.8
        for <linux-rdma@vger.kernel.org>; Thu, 03 Nov 2022 10:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adSEA+BlhZc0du2LzSAT+OKe4esyfpgqC1IywAWGqgo=;
        b=G03G1WtzBRNjm/rIxa0Bih0s/T2FUGSQoRilLpZ7lP+HIjQMrQTrR6AXSkPdtrUxqR
         vkvN0QFDwwlYUCqP7t5uYWRec24ZF7cw9ZgelhPQNj9QxKJtAZcAGzna+495/hbD/xKd
         aYUK1LqMDFyzUl+cZwEDIBZYFYwg76VyuNp3PS7t2M2Tg7PYu/l9oWMa0L5llFDshiVD
         HdwePUhQbNIPUxXtn68qkONByVlEuag/oScM05lcc1wTuWx5xWyXYte6HUnhfXjGIWjX
         uVVWgIJc4PUUcNtPhtsFkJwWnVfpisCQofDcEH9gI19na4AybvvazDWrhPQp0JTPMsZ4
         bDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adSEA+BlhZc0du2LzSAT+OKe4esyfpgqC1IywAWGqgo=;
        b=ksmu7JFTO+Dbm9FL5XOhY+0IclZshiLOF/mDO0pouyXA0eaMKre9gfnesFUO1z2ysX
         8W7n30b5tHaEPOnhxtiZKAdCBSAhMCnrkbANJkF/Jdtoi3hpe/YsMw+aSbxsciVjGO0v
         IsPAchOu70b4o2441OwOTinjxN3Yewg4IZe9xwy+pWSzD5vxisQW7G4L1+loPkbxZxNx
         zscIwjr/ufxrcy+7BOhP+g7p/HnGi5nPgfa0gz12t9kKkFq9uxY90CsBJlqm3Y6h46BL
         YBjEfft6HVNOkiDjQ/MKVKTxJh3XoQ2T55evGvhb0h6DxbSejuVkBEvwOd+bnMWm3yPQ
         7hlA==
X-Gm-Message-State: ACrzQf21DygWvFG6rk36KPvufwigK9h31ZTZaZtjSXuvdD3FSJ/qdj9w
        7CQdhZkhv/zmC2E53wXdlkg=
X-Google-Smtp-Source: AMsMyM7dk781YYkPebpKluGs1R2unPQkWySu6htp2KaSSYDC2vX31xyenfgY+unnIoKyF4+hGHjAqA==
X-Received: by 2002:a05:6870:4798:b0:12c:989b:a3b7 with SMTP id c24-20020a056870479800b0012c989ba3b7mr28075440oaq.181.1667495442290;
        Thu, 03 Nov 2022 10:10:42 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-b254-769c-82c0-77a4.res6.spectrum.com. [2603:8081:140c:1a00:b254:769c:82c0:77a4])
        by smtp.googlemail.com with ESMTPSA id m1-20020a056870a10100b0012b298699dbsm624304oae.1.2022.11.03.10.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:10:41 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 08/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_req.c
Date:   Thu,  3 Nov 2022 12:10:06 -0500
Message-Id: <20221103171013.20659-9-rpearsonhpe@gmail.com>
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

Replace calls to pr_xxx() in rxe_req.c with rxe_dbg_xxx().

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

