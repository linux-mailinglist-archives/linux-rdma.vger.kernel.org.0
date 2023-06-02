Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7B97207CF
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 18:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjFBQlA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Jun 2023 12:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbjFBQkr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Jun 2023 12:40:47 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A86413E
        for <linux-rdma@vger.kernel.org>; Fri,  2 Jun 2023 09:40:46 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6af8b25fc72so1929849a34.3
        for <linux-rdma@vger.kernel.org>; Fri, 02 Jun 2023 09:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685724045; x=1688316045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IChJi0lW/a7/uzxrX6HAQ3jc9vGY9aOMbO9nhfcZRcQ=;
        b=plFf1AQBiqTW3vdedhJZI0yQ3SG6iUGe6b125rqP3NhYXjXEBduWts7JbEiPcez7EQ
         N0tBAS35/mmZRQYM2iVxSQjXrJ22Ue2KHUun6nZ5qmGa4FaojFciAG30RPQy9BkM64Kx
         JXD/DjaKA8mQNDrNWN6gCRurmEcXGSJRQiYZeaiXVuHQxUhWN3kDs3UAs5IbdyacNhWC
         Xr2yQlQrVBYR2i3JRrPtEtY7nR0MuTB7tX0L8nV8dKP4zu9S7HlUzXjKKBWPagc50D2K
         yuBdUEosz+UiJFK3UGC/rFRC3P2FtmhtjFM694hibTuBisfb5tef85VPJThL2f3s+49b
         Hhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685724045; x=1688316045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IChJi0lW/a7/uzxrX6HAQ3jc9vGY9aOMbO9nhfcZRcQ=;
        b=EoIlXCaRdQjywsBfKARbbljyujIediSXKQtOjHcf9X5URkPOg0tQQhAgPwPeIdMtaH
         1SFOUJQMZbc2bVn+GI2LFSmt3k/w5C4Wz/qZ5R9Fmz/sF2ucBwAbwAUMS/cOsj/gMqcu
         zPnZBFGnfuocHSfcUiprSuaEbRpbjhwdZz+VEA1Lo8rJ79wXrEvyKnzPm/Iu+lT46jd0
         URMG0hc87MK9Q0eLkdIuLgUJHtT6i1k0wbMPJiZztdZOb9eEVWUndeDMjmQsZj+NEG4y
         hZkUEMsI4WZLxpHSUOwBY2WvlOUvm8FSZymjrSKUM3eBpjqwFdKRL7uYTQuTj77DGCNj
         0r4A==
X-Gm-Message-State: AC+VfDy0Oh2UndbRdDEifwIlYJGglvgd3T7OAjcPZv9PaSemx0OdHjDw
        MHUOxEqKhWDFkb06vCZS5sHrjWB5NU4=
X-Google-Smtp-Source: ACHHUZ5VpKIl6xy1aYRGJNrtcgNzVMjBCJCVvHWgss1Q4QrUnTIx168OyLkJsrmJgHvpmGXf7TBLgQ==
X-Received: by 2002:a05:6830:3b07:b0:6af:a0d7:1819 with SMTP id dk7-20020a0568303b0700b006afa0d71819mr3162111otb.28.1685724045565;
        Fri, 02 Jun 2023 09:40:45 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-8586-f477-c596-9820.res6.spectrum.com. [2603:8081:140c:1a00:8586:f477:c596:9820])
        by smtp.gmail.com with ESMTPSA id y25-20020a056830109900b006af92419e70sm742145oto.70.2023.06.02.09.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 09:40:45 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH] RDMA/rxe: Send last wqe reached event on qp cleanup
Date:   Fri,  2 Jun 2023 11:40:42 -0500
Message-Id: <20230602164042.9240-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

