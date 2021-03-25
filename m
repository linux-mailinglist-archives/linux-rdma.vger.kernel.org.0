Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D027D3495A6
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhCYPdw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbhCYPd1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:33:27 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF83C06174A
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id e14so3573253ejz.11
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bb7d5O4KE+zBJIWdL1D7Y4vj/X5wp9EHY4WQYlPwdNU=;
        b=Ay+bxvSkgO7UGhqI0NGs+Q2psePeDu5eyXWgmeePdVWozsttU2EGXtkt1TRMX6E9li
         J86teUNKOoMSDA+mYnSrmF/gh7RThSXOJX82eGQU/NUIVCO8N0s75ckE9Tv3+dOnaSP4
         7MoP64TYwQki/S3otgrcpJ96IV/J500sL5hzbFThbuyiwTgjECX8blC5E3UoFpGXifOo
         NoDaXwNKFoh/ZULXiCxqlxY3f9S4d4ZBJZjjdizf6NrAIcx166dg3Z6rOVNI+GKrQ9EV
         UG98m2QCKkMDsSLrDVcrXOWbjuU/Vm9p3zHGhGqFW1sCqsLyCu8PUHyLXfXa5W7NFHg6
         ZYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bb7d5O4KE+zBJIWdL1D7Y4vj/X5wp9EHY4WQYlPwdNU=;
        b=EFPKMWbtxOQgb0iT9Te7bxpbnlt8yCZf8Zo9V1k63xScdVNVJIrmVifTgf/sjTinsn
         sRzfCu3aI3Vu+GIFaiojsxgdhVngLlTG8qQgmjbKVVrSJmJBTB4/Icldond7FiS8Ms54
         t4B1wV13RFdCXFRp42z1hHd3FeioOgh+VBHzUK6pf3HGKljk1l+VfQGtQNFUz+1SsDqm
         PY7ShOKJnqpcuAMqfCZxPwrmZXPdvxGnV8wbWP22mS+hVAujiYQhiGNXVmNpNXhrzzAh
         055iudVUUCDHn6zoDJpUDId4uPBeaHp+PCKtPUyhciQCGiRpS2e9nmkudDOqz8E+wLRY
         jMjg==
X-Gm-Message-State: AOAM531Qsq9rdmRxh89sICzT+WPJ+yHRb4RMIE9pd2VMl+XyvKdToVX9
        5noobFAzBpkZQtyebpNCmqBqmXXP80x7+Bxe
X-Google-Smtp-Source: ABdhPJxK8ERB+gR/Q8GOrPQqK4DP2o/N60OK7WiO4ll/uoStQN4n0k2rXiuhzrwWZEmOER3zjCa0Aw==
X-Received: by 2002:a17:907:3e8c:: with SMTP id hs12mr10203110ejc.105.1616686405803;
        Thu, 25 Mar 2021 08:33:25 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id n26sm2854750eds.22.2021.03.25.08.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:33:25 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 15/22] RDMA/rtrs-srv: More debugging info when fail to send reply
Date:   Thu, 25 Mar 2021 16:33:01 +0100
Message-Id: <20210325153308.1214057-16-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
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
index c0a65e1e6fda..c1428cf602bc 100644
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

