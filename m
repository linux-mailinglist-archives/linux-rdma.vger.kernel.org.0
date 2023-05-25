Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C05710412
	for <lists+linux-rdma@lfdr.de>; Thu, 25 May 2023 06:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjEYE0d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 May 2023 00:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEYE0c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 May 2023 00:26:32 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3FDA1
        for <linux-rdma@vger.kernel.org>; Wed, 24 May 2023 21:26:31 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-19a13476ffeso952607fac.0
        for <linux-rdma@vger.kernel.org>; Wed, 24 May 2023 21:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684988790; x=1687580790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/roThbYZCSuZiJLsVgHd2Y9oggMmArXpfeJ8dLweZ5o=;
        b=BrhAuF11RJNOJn8LRdFOsmPdHI79K/OOegMtmbljwh+HDoy8lrNzA5uW7KgCBcBx6n
         /l+TWDzEhpttHpyjgSPhSdsBj7l5dEQbEduBXLU7/tRBgyf4pdESZ5NfE0+YebhjO1Sh
         k4wfiLzBMm9iAR3C5qinw+Gdb06EeyHjJ3QbTEPNz0lF9gnWKDGjH9xpJVYlOjNcaoRP
         FzYumTloUUo+vTtg9jKBIw1f9PaJfmaxdeQ/8HMljptSRom7SnZQKKJBgPoX6WVP7f5T
         A5KRhC8YLjfBgfLWy+veQXCbqxUfbWMiM+a45BO5a/PoKBkJv5gaCw3Ae+HwHBJ59Qqi
         jRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684988790; x=1687580790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/roThbYZCSuZiJLsVgHd2Y9oggMmArXpfeJ8dLweZ5o=;
        b=ToWaCXNyyV60RQv40DJrZd2yZyIeLsUoFm9v/B1Ld+uU5gHUwj+ekNV0fsr93oiwpQ
         aBzCa1QVFqyTBqUvg49l/y6dOZNZ6xvO3oZDJ/Q7/s/wwoJsQ/hjHRR6xRBgncDQx58q
         l+ANKuGN7rEzOf1JgnpYBdSGRK6nOk+04kTw/TQU+yr806ecVH+oRlyRm+o2a2A75xf7
         eUAE1DSC6KqYjeZkKcck4k0q/xq6ARK++LEtigS39RCn3LIFzUfTZjdJ6Q4W0wW5psBb
         ppqVICldLjRG06NHqkpETi7MBj2DHMaiBsP5l1Dx38AhL6YvzCauZRYAXBRwSe1tv5uS
         cgag==
X-Gm-Message-State: AC+VfDzmPGrRmpof66N+4teZQr5JGkjn2XbIhmaZja1flyb6kYfUFtlw
        nIVdMR2BANJewobPL+a6PrM=
X-Google-Smtp-Source: ACHHUZ5PtkjsCQx/OioUy3sB/Ltv9RsWmzT24VQ/0fra4IgNOjolb3383E8Dw6B7m7UHccKRSsjgPA==
X-Received: by 2002:a05:6870:9187:b0:19a:82b:a8d8 with SMTP id b7-20020a056870918700b0019a082ba8d8mr1298158oaf.40.1684988790133;
        Wed, 24 May 2023 21:26:30 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-e32a-8417-bb00-f8d7.res6.spectrum.com. [2603:8081:140c:1a00:e32a:8417:bb00:f8d7])
        by smtp.gmail.com with ESMTPSA id t3-20020a056871054300b0017aafd12843sm264124oal.32.2023.05.24.21.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 21:26:29 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     edwards@nvidia.com, idok@nvidia.com, jgg@nvidia.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH RFC] tests: Fix test_mr_rereg_pd
Date:   Wed, 24 May 2023 23:25:17 -0500
Message-Id: <20230525042517.14657-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch adds a util method drain_cq which drains out
the cq associated with a client or server. This is then
added to the method restate_qps in tests/test_mr.py.
This allows correct operation when recovering test state
from an error which may have also left stray completions
in the cqs before resetting the qps for use.

Fixes: 4bc72d894481 ("tests: Add rereg MR tests")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 tests/test_mr.py |  2 ++
 tests/utils.py   | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/tests/test_mr.py b/tests/test_mr.py
index 534df46a..73dfbff2 100644
--- a/tests/test_mr.py
+++ b/tests/test_mr.py
@@ -109,6 +109,8 @@ class MRTest(RDMATestCase):
         self.server.qp.to_rts(self.server_qp_attr)
         self.client.qp.modify(QPAttr(qp_state=e.IBV_QPS_RESET), e.IBV_QP_STATE)
         self.client.qp.to_rts(self.client_qp_attr)
+        u.drain_cq(self.client.cq)
+        u.drain_cq(self.server.cq)
 
     def test_mr_rereg_access(self):
         self.create_players(MRRes)
diff --git a/tests/utils.py b/tests/utils.py
index a1dfa7d8..f6966b1a 100644
--- a/tests/utils.py
+++ b/tests/utils.py
@@ -672,6 +672,20 @@ def poll_cq_ex(cqex, count=1, data=None, sgid=None):
     finally:
         cqex.end_poll()
 
+def drain_cq(cq):
+    """
+    Drain completions from a CQ.
+    :param cq: CQ to drain
+    :return: None
+    """
+    channel = cq.comp_channel
+    while 1:
+        if channel:
+            channel.get_cq_event(cq)
+            cq.req_notify()
+        nc, tmp_wcs = cq.poll(1)
+        if nc == 0:
+            break
 
 def validate(received_str, is_server, msg_size):
     """
-- 
2.39.2

