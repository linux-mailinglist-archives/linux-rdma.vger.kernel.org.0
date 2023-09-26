Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183A27AEA45
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 12:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjIZKXn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 06:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIZKXm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 06:23:42 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576C3BE;
        Tue, 26 Sep 2023 03:23:36 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c328b53aeaso74277785ad.2;
        Tue, 26 Sep 2023 03:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695723816; x=1696328616; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMHH68coiyikCq+WsDtMwndQkQZOfF+YA1O85uD6LCA=;
        b=OneQs8q89+CyECkSv2oP0JGYAw6uHgjowio2XT7HpsyXXaKIo/xBBYIJ3Dw/teRJFB
         mbckTjfHGRgD80iZ39l3Or+cNFKi4K+j1tmnFdJF7VH+Pu1let+WgUYHnUnvXAwHwg8J
         GUy7NZbaI7sQw+xpT5SWVJw+VJ8k3zYpfI8kQED36W3xRGRc1+haR0TMuTPfVV0ITU1f
         gwih5ZhfkU+fsEWJX3n1kTsooAfP4OCk3tqeAmvhayN1h75NEGu5l1bTLTyKrq5Ro/WC
         uP/IpOOEZGz4ipVr+u42wNDvZUt/48YPBji2BOY2gRDjJweovBt6tLoPwFzFtg7+LSfh
         VWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695723816; x=1696328616;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMHH68coiyikCq+WsDtMwndQkQZOfF+YA1O85uD6LCA=;
        b=CQUi0hZcNy29SJTlVJkAqR17F+URd9BZkDoi/DM/ba2iBOuifMZ1ru8O7OY1Rz+nWQ
         CtSJxHZoFadd7X5kQ1tkmNTt49ukW5Yd3I1aj1ARufFfQzEEm/Ys86XDCjNVLiUfv0pw
         7HJyMV71EwtXV78JOkbcO/MJkS4+LVP6eJ2utn0TVlYru7y9XFsvZiKrWN5znDyeP7kH
         D09+RDJh1VQhrST63bMitXT2UaMs76CFLwdnkqlLBE4uCX9TgCdE42HN31pGlaDMLS+P
         qa0MJoYbD7Uatpg2LdEp4Ydsi3ESDVMVDYOQx+s53iUUG32RqZ5SF89UtJp6dTkqWwkz
         iAaA==
X-Gm-Message-State: AOJu0YyZiq3CkA+nsRHm1I8LwVGGFG+Ni+sVRLMU3sSjLLQjAgjsVIAF
        kg5nSXngWGbFbJGsoH2ykas=
X-Google-Smtp-Source: AGHT+IEF0wgtiaw9tXX8b+HUFgzNZEGl0UzCfgId4g4ZQ389XUyUmdKLlhXgn4a+7n6QYnbA2hrCGw==
X-Received: by 2002:a17:902:d507:b0:1c3:dafa:b1e9 with SMTP id b7-20020a170902d50700b001c3dafab1e9mr11285170plg.10.1695723815663;
        Tue, 26 Sep 2023 03:23:35 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902e75000b001c3a8b135ebsm10572902plf.282.2023.09.26.03.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 03:23:35 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] RDMA: Fix potential deadlock on &dev->rdi.pending_lock
Date:   Tue, 26 Sep 2023 10:23:31 +0000
Message-Id: <20230926102331.5095-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

qib_7322intr() could introduce double locks on &dev->rdi.pending_lock
if it preempts other execution units requiring the same locks.

<Deadlock #1>
qib_notify_error_qp()
--> spin_lock(&dev->rdi.pending_lock)
<interrupt>
   --> qib_7322intr()
   --> qib_ib_piobufavail()
   --> spin_lock_irqsave(&dev->rdi.pending_lock)

<Deadlock #2>
qib_flush_qp_waiters()
--> spin_lock(&dev->rdi.pending_lock)
<interrupt>
   --> qib_7220intr()
   --> qib_ib_piobufavail()
   --> spin_lock_irqsave(&dev->rdi.pending_lock)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

To prevent the potential deadlock, the patch uses spin_lock_irqsave()
on &dev->rdi.pending_lock inside qib_notify_error_qp() and
qib_flush_qp_waiters() to prevent the possible deadlock scenario.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/infiniband/hw/qib/qib_qp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_qp.c b/drivers/infiniband/hw/qib/qib_qp.c
index 1974ceb9d405..05a107fb6ebc 100644
--- a/drivers/infiniband/hw/qib/qib_qp.c
+++ b/drivers/infiniband/hw/qib/qib_qp.c
@@ -241,13 +241,14 @@ void qib_notify_error_qp(struct rvt_qp *qp)
 {
 	struct qib_qp_priv *priv = qp->priv;
 	struct qib_ibdev *dev = to_idev(qp->ibqp.device);
+	unsigned long flags;
 
-	spin_lock(&dev->rdi.pending_lock);
+	spin_lock_irqsave(&dev->rdi.pending_lock, flags);
 	if (!list_empty(&priv->iowait) && !(qp->s_flags & RVT_S_BUSY)) {
 		qp->s_flags &= ~RVT_S_ANY_WAIT_IO;
 		list_del_init(&priv->iowait);
 	}
-	spin_unlock(&dev->rdi.pending_lock);
+	spin_unlock_irqrestore(&dev->rdi.pending_lock, flags);
 
 	if (!(qp->s_flags & RVT_S_BUSY)) {
 		qp->s_hdrwords = 0;
@@ -367,11 +368,12 @@ void qib_flush_qp_waiters(struct rvt_qp *qp)
 {
 	struct qib_qp_priv *priv = qp->priv;
 	struct qib_ibdev *dev = to_idev(qp->ibqp.device);
+	unsigned long flags;
 
-	spin_lock(&dev->rdi.pending_lock);
+	spin_lock_irqsave(&dev->rdi.pending_lock, flags);
 	if (!list_empty(&priv->iowait))
 		list_del_init(&priv->iowait);
-	spin_unlock(&dev->rdi.pending_lock);
+	spin_unlock_irqrestore(&dev->rdi.pending_lock, flags);
 }
 
 /**
-- 
2.17.1

