Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E1E64DB2E
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Dec 2022 13:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiLOMbV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Dec 2022 07:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiLOMbT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Dec 2022 07:31:19 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F6D13DED
        for <linux-rdma@vger.kernel.org>; Thu, 15 Dec 2022 04:31:18 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b13so15423542lfo.3
        for <linux-rdma@vger.kernel.org>; Thu, 15 Dec 2022 04:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bell-sw-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=upI87PN1BH4J6q5AGmeF4ixuNT8JvDXApVOLzXphcqc=;
        b=c9CWq5cB7AkYryRqnJQAYj8iilu369dsvvBcj5kszKbUey/qnyx7vEfZhXZDg+w8li
         sEwizJXulHV73YO2pEs+GZZDFIl6lVg8PFAHsn0PnNYPDJL3oQB+mmUoXSx0hT03t9Ot
         wTdbnE080fmNzJvs1+uJ3ltxqgpLr+x9u8JdaUNqotdJoHma7qXbiN97Ee5qTRl9i8/Q
         Rt71/vr6hdPeM50ZZftpxk/qVi3hcoJXnlGeF/l9Kl/hMaTfG3LfNSdEMkmJ4y/XNuwy
         fx0dcvEH0u1PxSK13lQc8CChWjInxWP5wxh/FFpTN/wKJ3WaaHKPak43pJvyKaoHAYRC
         lfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upI87PN1BH4J6q5AGmeF4ixuNT8JvDXApVOLzXphcqc=;
        b=GsYUKcu1Whvc6GUIdu/zVbKYvIv/aCZWs+pqspLmQBiGBeElaVxl+KHXw5SlFuNynq
         1qmhBLYGOEg0LnExPQsZfBxDRdMF9BDv5rrOT/dZWFcxTBQ8eetw+pvTSp02IjsKnMDv
         LY5t07GnVMjOcWGgu8qpyqr+UO1nei2EQqY6AVgVE0qI05ZpuEMvvMUZqqxTFGo2dc7V
         0wwmLgKmTrDzC4uFldxfw/vedbb3Ig6OEN3l5ZMMjr3sTE65iTi2vd0VAxg2kL4isEwT
         yX57KAw0ZuYbIcKxRR5/A+WQF9tA7ufEj8x2meQBZgptdUoKOTMHfcVTguxQva5qaddZ
         hSqg==
X-Gm-Message-State: ANoB5pkraOo9liV7RH/wooFUhduYpMpzqHzPjTcaoUubfAWLVxL1MBa9
        MmtIW9O54ejNzU369EQ+sDOAfG2cOQERltA=
X-Google-Smtp-Source: AA0mqf5RsKxIco83/CRqvvzFk0DE3refkEpmlNImblNRqiiLU61z0KY3Upyn2+UBvDC/517Ku1YJkw==
X-Received: by 2002:a05:6512:3d0e:b0:4b5:9043:2530 with SMTP id d14-20020a0565123d0e00b004b590432530mr10451691lfv.68.1671107476481;
        Thu, 15 Dec 2022 04:31:16 -0800 (PST)
Received: from localhost.localdomain ([95.161.223.113])
        by smtp.gmail.com with ESMTPSA id s25-20020a195e19000000b004b55cebdbd7sm1147869lfb.120.2022.12.15.04.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 04:31:15 -0800 (PST)
From:   Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To:     linux-rdma@vger.kernel.org
Cc:     Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: [PATCH rdma-next] RDMA/cxgb4: remove unnecessary NULL check in __c4iw_poll_cq_one()
Date:   Thu, 15 Dec 2022 15:30:30 +0300
Message-Id: <20221215123030.155378-1-aleksei.kodanev@bell-sw.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If 'qhp' is NULL then 'wq' is also NULL:

    struct t4_wq *wq = qhp ? &qhp->wq : NULL;
    ...
    ret = poll_cq(wq, ...);
    if (ret)
        goto out;

poll_cq(wq, ...) always returns a non-zero status if 'wq' is NULL,
either on a t4_next_cqe() error or on a 'wq == NULL' check.

Therefore, checking 'qhp' again after poll_cq() is redundant.

BTW, there're also 'qhp' dereference cases below poll_cq() without
any checks (c4iw_invalidate_mr(qhp->rhp,...)).

Detected using the static analysis tool - Svace.
Fixes: 4ab39e2f98f2 ("RDMA/cxgb4: Make c4iw_poll_cq_one() easier to analyze")
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 drivers/infiniband/hw/cxgb4/cq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index c7e8d7b3baa1..7e2835dcbc1c 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -767,7 +767,7 @@ static int __c4iw_poll_cq_one(struct c4iw_cq *chp, struct c4iw_qp *qhp,
 		goto out;
 
 	wc->wr_id = cookie;
-	wc->qp = qhp ? &qhp->ibqp : NULL;
+	wc->qp = &qhp->ibqp;
 	wc->vendor_err = CQE_STATUS(&cqe);
 	wc->wc_flags = 0;
 
-- 
2.25.1

