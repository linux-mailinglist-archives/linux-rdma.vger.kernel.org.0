Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191F635540D
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 14:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhDFMgw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 08:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242201AbhDFMgw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 08:36:52 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DBCC061756
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 05:36:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id hq27so21610432ejc.9
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 05:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=doCHjXrIEyIxkGDp2qrSmqpjfoS5nKo5gHhnzQIaKpo=;
        b=Y4Re7QdMLxxTZxjD61AA6eeDwdBvcJLavqdtYXRzqelnr5mz+PGo/a1JCZschgrPnQ
         1OpUMgtQsnSkLE4rpEzeisTK0WZiS71mvsyGQEeMP/h6YZlg82YgEZ8GlzbYAyfK8uTD
         iMY21ciwlTs4fWzg0NuwkVK4wid13XDKRV3nkXhQ6+yRWTOtSKAjMLeHJJvpySm/7XzO
         taQuXbkzDTbonkUKCcYWhCAv7bQgKwWAWsLs2zwNRZE8mlvPrGwiTLLp5qUfwddsBmZk
         R7h7W2bR8tI6lDdLG6QgKzpZSxdDxdbUEad2yNyZY3lqrK8Bj6gG9Ch8PtUvDueSebKJ
         fzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=doCHjXrIEyIxkGDp2qrSmqpjfoS5nKo5gHhnzQIaKpo=;
        b=AmC8HK1c8aa5+j9i3v/rxhuBk8m2lgbG9OgpgsLVZWV5bzRjC+iK8/6ryoL4oaAjvL
         na3zv2fpbOX4RFruN+KzXstcLaa6TJ0fcNbPzt+aWhnl5V8E5y2u5Mh1BMe/vtGJwqmn
         sJVgYZNkpYvjO8zLIwbQ0TNpYi4UrmUB4kiueyLzGcauoVmXVsvMISMTRLeOImTEUoIp
         cFd9dby/qmD7pyYpbUdmheN/M5pOrWXTdn99t70CUImr2l3uBt0OI5ufPFegvpBjO7Vk
         l5zgtzjyEhyitvwZHZ1v5W3QQEGW2sL/ZL6Kj3YSAgyWOKpE/iSq6yLFYdbZ3Jpf7CAf
         SbsA==
X-Gm-Message-State: AOAM532PcAbUKH5dyv1W4ZXb7nhYDoDJxkir3llFecwHHHLM3vqVVY53
        EPyulOeC2wchdrfCnOhXA1xu4/Su8brLQbfn
X-Google-Smtp-Source: ABdhPJxHfm+oBUPcYej3pA35mSJeWIu67SFi+ZviKza27uhmpOz6omM3JjNCF+W8GTAsbkH+4fjWUQ==
X-Received: by 2002:a17:906:cb2:: with SMTP id k18mr17080794ejh.183.1617712603405;
        Tue, 06 Apr 2021 05:36:43 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id p9sm13738384edu.79.2021.04.06.05.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 05:36:43 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 2/3] RDMA/rtrs-srv: More debugging info when fail to send reply
Date:   Tue,  6 Apr 2021 14:36:38 +0200
Message-Id: <20210406123639.202899-3-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406123639.202899-1-gi-oh.kim@ionos.com>
References: <20210406123639.202899-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

It does not help to debug if it only print error message
without any debugging information which session and connection
the error happened.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 6e53dac0d22c..e11e91626b41 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -518,8 +518,9 @@ bool rtrs_srv_resp_rdma(struct rtrs_srv_op *id, int status)
 
 	if (unlikely(sess->state != RTRS_SRV_CONNECTED)) {
 		rtrs_err_rl(s,
-			     "Sending I/O response failed,  session is disconnected, sess state %s\n",
-			     rtrs_srv_state_str(sess->state));
+			    "Sending I/O response failed,  session %s is disconnected, sess state %s\n",
+			    kobject_name(&sess->kobj),
+			    rtrs_srv_state_str(sess->state));
 		goto out;
 	}
 	if (always_invalidate) {
@@ -529,7 +530,9 @@ bool rtrs_srv_resp_rdma(struct rtrs_srv_op *id, int status)
 	}
 	if (unlikely(atomic_sub_return(1,
 				       &con->sq_wr_avail) < 0)) {
-		pr_err("IB send queue full\n");
+		rtrs_err(s, "IB send queue full: sess=%s cid=%d\n",
+			 kobject_name(&sess->kobj),
+			 con->c.cid);
 		atomic_add(1, &con->sq_wr_avail);
 		spin_lock(&con->rsp_wr_wait_lock);
 		list_add_tail(&id->wait_list, &con->rsp_wr_wait_list);
@@ -543,7 +546,8 @@ bool rtrs_srv_resp_rdma(struct rtrs_srv_op *id, int status)
 		err = rdma_write_sg(id);
 
 	if (unlikely(err)) {
-		rtrs_err_rl(s, "IO response failed: %d\n", err);
+		rtrs_err_rl(s, "IO response failed: %d: sess=%s\n", err,
+			    kobject_name(&sess->kobj));
 		close_sess(sess);
 	}
 out:
-- 
2.25.1

