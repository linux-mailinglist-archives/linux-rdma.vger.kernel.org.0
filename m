Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD867207D3
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 18:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbjFBQmg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Jun 2023 12:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236873AbjFBQmd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Jun 2023 12:42:33 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E456E13E
        for <linux-rdma@vger.kernel.org>; Fri,  2 Jun 2023 09:42:32 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1a1b95cc10eso2416614fac.0
        for <linux-rdma@vger.kernel.org>; Fri, 02 Jun 2023 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685724152; x=1688316152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IChJi0lW/a7/uzxrX6HAQ3jc9vGY9aOMbO9nhfcZRcQ=;
        b=qbXWqz0qjWUrlETQ2G9dztfOAJJAyOx4216RVGkoh+EgDdHADavb4bVKTtuxiUWbp4
         54UPCivqNx+Vl1Tb8gE05Y57MYZ6uazLbjyNJLYu2mTXwAeU0hYowX8aY1ouETD9HO1E
         Q4oUKqHQzbonSwGccSC7sl9manaI9wx+urZYfefm6wovSIUSMlV5SXhkgHv8Dx/BQQ9A
         nNlP6aHdcwNkgGtty19lkGFtrj7e2oN3yrPmil9lzc2n50ErEOIVUebW77QYQOFtPa+R
         qipXyDlWZwtHWKPa/VQzTMkfP3kWkGXMkLk6/Jp9+f4cUj+RF4Uaf3URVpOZC4STkvBQ
         coCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685724152; x=1688316152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IChJi0lW/a7/uzxrX6HAQ3jc9vGY9aOMbO9nhfcZRcQ=;
        b=lyI/2l2wUOwuS2ujFqiWZRT0vnOqMJY8cp+MPML91ajiIw2msZRNoFE2RaWVav515X
         zA6NBnIYFkanPehRM6TMUQ9pnKaeZ18DtErpNkyD9gDp6aRYc+jhh2DvYws8my5fkT/I
         quZuvxoAXivzBwINe7rKYwWTtNOY1T+EpBD1PXM0GOt3LQSrTWZH/iwHiPYI+jaxOOZe
         ez/69QdGMoUQBsSKXM9P1XciJ8TVeoWv34GFUIMh+lVOpL8vHudpL/ygdPR9DSJvkkPO
         AIrEz6ffWSHTRfKazYJHs+OM/Hn/r7+Dq8OHqC83hx4w7k1aTKZeO2a5yJLj+0589fqr
         79WA==
X-Gm-Message-State: AC+VfDwZyndvoLsa1/C8nOigcw08vQcYLHNOKNn1rTgqEL407D4eCV4Q
        vzplAgItdgJtPpJiFLZqsRg=
X-Google-Smtp-Source: ACHHUZ5Ns09PN18MYmwDSxWefECWGvVBibbKUBhuWPONycodUPJjJJdkd4xsgLckhiMhB6bUNi6I2w==
X-Received: by 2002:a05:6870:37c6:b0:19f:1c6a:80b6 with SMTP id p6-20020a05687037c600b0019f1c6a80b6mr2886627oai.8.1685724151929;
        Fri, 02 Jun 2023 09:42:31 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-8586-f477-c596-9820.res6.spectrum.com. [2603:8081:140c:1a00:8586:f477:c596:9820])
        by smtp.gmail.com with ESMTPSA id w22-20020a056870a2d600b0019f2bf84bf5sm774961oak.48.2023.06.02.09.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 09:42:31 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Send last wqe reached event on qp cleanup
Date:   Fri,  2 Jun 2023 11:42:29 -0500
Message-Id: <20230602164229.9277-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The IBA requires:
	o11-5.2.5: If the HCA supports SRQ, for RC and UD service,
	the CI shall generate a Last WQE Reached Affiliated Asynchronous
	Event on a QP that is in the Error State and is associated with
	an SRQ when either:
		• a CQE is generated for the last WQE, or
		• the QP gets in the Error State and there are no more
		  WQEs on the RQ.

This patch implements this behavior in flush_recv_queue() which is
called as a result of rxe_qp_error() being called whenever the qp
is put into the error state. The rxe responder executes SRQ WQEs
directly from the SRQ so there are never more WQES on the RQ.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 172c8f916470..0c24facd12cb 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1492,8 +1492,17 @@ static void flush_recv_queue(struct rxe_qp *qp, bool notify)
 	struct rxe_recv_wqe *wqe;
 	int err;
 
-	if (qp->srq)
+	if (qp->srq) {
+		if (notify && qp->ibqp.event_handler) {
+			struct ib_event ev;
+
+			ev.device = qp->ibqp.device;
+			ev.element.qp = &qp->ibqp;
+			ev.event = IB_EVENT_QP_LAST_WQE_REACHED;
+			qp->ibqp.event_handler(&ev, qp->ibqp.qp_context);
+		}
 		return;
+	}
 
 	while ((wqe = queue_head(q, q->type))) {
 		if (notify) {
-- 
2.39.2

