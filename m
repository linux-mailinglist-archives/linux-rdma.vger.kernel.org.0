Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866254C7932
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 20:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiB1TxG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 14:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiB1Twv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 14:52:51 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ACACA0E3;
        Mon, 28 Feb 2022 11:52:11 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id hw13so26994431ejc.9;
        Mon, 28 Feb 2022 11:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SE97nUCoQgsjM3ZnUKhOWf6INqaQW1rfHmBLrrwwrnE=;
        b=HjCUBuqd57irJYB8osf17Ko1A6qfRwi8TZH4nzCHMeW7yc05d9hfgRtHB3S3gS9wk5
         OPtTvBLcwa5UaKspXnCnc5U3ZvqyNnfYnEXY4HSJ1ElNlmZgCb0c3Fjlnfrdvukd5XOU
         0Y4PLIqCFYbOeCQzNk/4H7qWoNSQCBfCQJyer41Vlbhf9wV0D33qKuD05mbt6+zOPMRi
         Db/MFx82xV9Ew622tCmuipMBM0HILAocjBluQeM5WDNc+sh6Nj+pvZKmfRbxIyCfXGFy
         m5ltLsThnS+AJbSz6PODwSnxuUQ6Vo+snke2ES7nMJjtJaEMPNv1Ce01We0d6JeSaLKt
         DlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SE97nUCoQgsjM3ZnUKhOWf6INqaQW1rfHmBLrrwwrnE=;
        b=GTziDsGcuMhz8AeENixXFaodIFq3Gr0uGYmYqlcpoPl1EZ2HBz4GJsLoKWWfw0rjOu
         kpPSEmLplL03TGnjiayUM+cMmHxzVdzHfKA800O1RtgIebZUmjSHbo9vBySs+K1nDOwM
         tuV+rvRoLJPCkqkzGd2miE0x2YinhpRYjfRmorVq69u6xdfdbdOjZsk7DjbgBwrleCxr
         //st6/ZhK75thZht2jUtYG7eA6BpYUkIDiJupvNfYSzV+QXMQWX9k26KrMqyEwT12z7g
         vBvCUYplDOV+qsyZeis29Tcixy+w89EiVsbuxy5sC6mE5A1frNAyL1QAJFOEqNkZYUU/
         doHQ==
X-Gm-Message-State: AOAM533GBKgGf6XxQ6r4038khGumqVkxyTwmeYonIq8vwWaShLMMTZoM
        7E58+RAU5JUyWuMs2UNTgek8EJUKo0MBcw==
X-Google-Smtp-Source: ABdhPJxzPFSQY3wwuaOek4finnBmQcUszLpgbN1KZAXlgFCpWH9GaiCFNYAAt6rbgeWeHVPsQR7Wuw==
X-Received: by 2002:a17:906:3e09:b0:6cf:cf2c:2c02 with SMTP id k9-20020a1709063e0900b006cfcf2c2c02mr16768199eji.291.1646077930253;
        Mon, 28 Feb 2022 11:52:10 -0800 (PST)
Received: from nlaptop.localdomain (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
        by smtp.gmail.com with ESMTPSA id z11-20020a170906814b00b006a6be1e0f86sm4607513ejw.132.2022.02.28.11.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 11:52:09 -0800 (PST)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH] IB/rdmavt: add missing locks in rvt_ruc_loopback
Date:   Mon, 28 Feb 2022 20:51:44 +0100
Message-Id: <20220228195144.71946-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.1
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

The documentation of the function rvt_error_qp says both r_lock and
s_lock need to be held when calling that function.
It also asserts using lockdep that both of those locks are held.
rvt_error_qp is called form rvt_send_cq, which is called from
rvt_qp_complete_swqe, which is called from rvt_send_complete, which is
called from rvt_ruc_loopback in two places. Both of these places do not
hold r_lock. Fix this by acquiring a spin_lock of r_lock in both of
these places.
The r_lock acquiring cannot be added in rvt_qp_complete_swqe because
some of its other callers already have r_lock acquired.

Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---
 drivers/infiniband/sw/rdmavt/qp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index ae50b56e8913..3bac4f90a6d6 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -2775,7 +2775,7 @@ void rvt_qp_iter(struct rvt_dev_info *rdi,
 EXPORT_SYMBOL(rvt_qp_iter);
 
 /*
- * This should be called with s_lock held.
+ * This should be called with s_lock and r_lock held.
  */
 void rvt_send_complete(struct rvt_qp *qp, struct rvt_swqe *wqe,
 		       enum ib_wc_status status)
@@ -3134,7 +3134,9 @@ void rvt_ruc_loopback(struct rvt_qp *sqp)
 	rvp->n_loop_pkts++;
 flush_send:
 	sqp->s_rnr_retry = sqp->s_rnr_retry_cnt;
+	spin_lock(&sqp->r_lock);
 	rvt_send_complete(sqp, wqe, send_status);
+	spin_unlock(&sqp->r_lock);
 	if (local_ops) {
 		atomic_dec(&sqp->local_ops_pending);
 		local_ops = 0;
@@ -3188,7 +3190,9 @@ void rvt_ruc_loopback(struct rvt_qp *sqp)
 	spin_unlock_irqrestore(&qp->r_lock, flags);
 serr_no_r_lock:
 	spin_lock_irqsave(&sqp->s_lock, flags);
+	spin_lock(&sqp->r_lock);
 	rvt_send_complete(sqp, wqe, send_status);
+	spin_unlock(&sqp->r_lock);
 	if (sqp->ibqp.qp_type == IB_QPT_RC) {
 		int lastwqe = rvt_error_qp(sqp, IB_WC_WR_FLUSH_ERR);
 
-- 
2.35.1

