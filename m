Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D447296A79
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Oct 2020 09:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375777AbgJWHoH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Oct 2020 03:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S375775AbgJWHoH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Oct 2020 03:44:07 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AD0C0613D2
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:44:07 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w23so633632edl.0
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N98xLNwIrHPVMGn4TFLYhEJS7NXRDPuaQTkSD4Kdyco=;
        b=gNadxjyAJ/SAUFEN/n2FoOEfFGW7zJLUWUktpPazNrl1HtrRxN1PxQz3CRXj6q+0dK
         xCLeib6AWV84VXDVj9n8JqY5stJ7bYVrTfisFZ470jSxiXfYpbrchWsg3fluqVzt3HOO
         vecxRI7aecInlF9ZbwRJlIP1tB0hb3fQQlvYx7+agEh9EqgWNpxhqgbxhqc6WKGeWAS7
         tn6jkmSAiOnV+SLdXcGKB+GGfc5ARGppc76m1axPsSfoplLp6CGIQkqDscrocTRs923l
         +T9x/PMPvcHWNERgUf80P6HhWEXSsJXgf5w4SXtooOmmjhbVyR9Jx1YDQ04qqRkzCdKa
         NzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N98xLNwIrHPVMGn4TFLYhEJS7NXRDPuaQTkSD4Kdyco=;
        b=WQZ9AlakO92AdrDnKXiaxljDGKz5cHdOmWdkVWGYybkECzHFEb/32drs3/qF0FwpUC
         e9njf4pp85vO0IvbUHN8SRp2GCZK7tXOZCVMeCW94TQRlod/obfVdXQDzZ52b79AnWp0
         E9JV7OovrrRamInTC8WsVM2O5qO+6jwGULKfohH6YjCAp7FvE1H6TydWUZQa7s0rQZK3
         oN/vIOMR6MHh9ohNQuvUpslUkLGiRBUUs+oI9T5OswU+AZcK9zyZGaZLAbl+I2/mAviV
         QxeFQrw5hMC0deZZdYVqtoexlYExNeLZTvpwoRPGgSp2aqNlFuyWkAN3HANjgn9zhJmz
         fE/A==
X-Gm-Message-State: AOAM530GBwpLP3Qupy3WXDGE9DKqCr71Wj/cVI/M7TDbE46Nj/WYNwy/
        XiV9BY3KQfMFe2RI5J22GouTrqkbK01Pmg==
X-Google-Smtp-Source: ABdhPJyrr+2FP262gZTTNn093G9iHJ6qw4gcfR27XdRYtXhDPUit9PaZlHiC58+2gQ6hgeKu3E2RYA==
X-Received: by 2002:a50:b023:: with SMTP id i32mr908249edd.377.1603439045509;
        Fri, 23 Oct 2020 00:44:05 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49b9:3000:d18a:ee7b:bff9:e374])
        by smtp.gmail.com with ESMTPSA id op24sm337928ejb.56.2020.10.23.00.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 00:44:05 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCHv2 for-next 11/12] RDMA/rtrs: introduce rtrs_post_send
Date:   Fri, 23 Oct 2020 09:43:52 +0200
Message-Id: <20201023074353.21946-12-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
References: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Since the three functions share the similar logic, let's introduce one
common function for it.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs.c | 52 +++++++++++-------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 48f648f573b6..2e3a849e0a77 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -104,6 +104,22 @@ int rtrs_post_recv_empty(struct rtrs_con *con, struct ib_cqe *cqe)
 }
 EXPORT_SYMBOL_GPL(rtrs_post_recv_empty);
 
+static int rtrs_post_send(struct ib_qp *qp, struct ib_send_wr *head,
+			     struct ib_send_wr *wr)
+{
+	if (head) {
+		struct ib_send_wr *tail = head;
+
+		while (tail->next)
+			tail = tail->next;
+		tail->next = wr;
+	} else {
+		head = wr;
+	}
+
+	return ib_post_send(qp, head, NULL);
+}
+
 int rtrs_iu_post_send(struct rtrs_con *con, struct rtrs_iu *iu, size_t size,
 		       struct ib_send_wr *head)
 {
@@ -126,17 +142,7 @@ int rtrs_iu_post_send(struct rtrs_con *con, struct rtrs_iu *iu, size_t size,
 		.send_flags = IB_SEND_SIGNALED,
 	};
 
-	if (head) {
-		struct ib_send_wr *tail = head;
-
-		while (tail->next)
-			tail = tail->next;
-		tail->next = &wr;
-	} else {
-		head = &wr;
-	}
-
-	return ib_post_send(con->qp, head, NULL);
+	return rtrs_post_send(con->qp, head, &wr);
 }
 EXPORT_SYMBOL_GPL(rtrs_iu_post_send);
 
@@ -168,17 +174,7 @@ int rtrs_iu_post_rdma_write_imm(struct rtrs_con *con, struct rtrs_iu *iu,
 		if (WARN_ON(sge[i].length == 0))
 			return -EINVAL;
 
-	if (head) {
-		struct ib_send_wr *tail = head;
-
-		while (tail->next)
-			tail = tail->next;
-		tail->next = &wr.wr;
-	} else {
-		head = &wr.wr;
-	}
-
-	return ib_post_send(con->qp, head, NULL);
+	return rtrs_post_send(con->qp, head, &wr.wr);
 }
 EXPORT_SYMBOL_GPL(rtrs_iu_post_rdma_write_imm);
 
@@ -195,17 +191,7 @@ int rtrs_post_rdma_write_imm_empty(struct rtrs_con *con, struct ib_cqe *cqe,
 		.ex.imm_data	= cpu_to_be32(imm_data),
 	};
 
-	if (head) {
-		struct ib_send_wr *tail = head;
-
-		while (tail->next)
-			tail = tail->next;
-		tail->next = &wr;
-	} else {
-		head = &wr;
-	}
-
-	return ib_post_send(con->qp, head, NULL);
+	return rtrs_post_send(con->qp, head, &wr);
 }
 EXPORT_SYMBOL_GPL(rtrs_post_rdma_write_imm_empty);
 
-- 
2.25.1

