Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6170296A74
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Oct 2020 09:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375769AbgJWHoE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Oct 2020 03:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374490AbgJWHoD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Oct 2020 03:44:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AE6C0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:44:02 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id p5so1062233ejj.2
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JfZtk3pjF4WlFpJWibZh2FBLGDetHSR9s/tKhrXEPr8=;
        b=WXvwE9tcHGlufbxdJd07cJJn7qvGpGJ8k8lhmivlnr/rDfhGcUDVsVS759dA0FPbzL
         ol6XdTx4lyYDDyEOTvXpnO0Anmm9IlXCRW8uemuJSPJ5i2J8L+r6pOcoWXPPR51Vsk8I
         EdEJN8wHca0aHvLaDrx9qYlWhkdNG5aHWk+YHu0unysZTRwt6bDBCWMrY0r7pP6WHX/t
         leB6St96t70TddstRI/d1OfsgZfVVoWvN9gdhqr5uYwbiMbI9kwDrfJ5RCoFEsSCb66I
         QvVPgw0AHdQ2j7tQG64Ar/BUhAwYOapsvrKL51up0KrUt0SUYwZSLZS87cvNye6LZ9Ls
         tEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JfZtk3pjF4WlFpJWibZh2FBLGDetHSR9s/tKhrXEPr8=;
        b=rTpEU1lY4Tu8cnrSgH9w5HnThwnl7mJ6H6FfpIjQSn8E3c6gj0wsfGm0okeVKfamNb
         cGWlBFun13XS9ekZa0OjN9NNDECu8zSt5FOdmzajH8QWGA0Dtaaj5LLqILvuXGcKduq6
         Hl7qbtyMLQP1uJRruc2JMgJzcEXZviy4m/+JlWwt9w5gopVjEzV8Hp1JM5NwfNLR+s11
         +EDriVizjBHL/ZuD8gkEkN65Ma9RZ3b7OWRprtcTZFc3F1bda6WrWPJcy8w/EX1/sRYX
         pYwTKO97l6MhdlSDq0466FeJfcl7xrUn2hi9VZ6XFo0t7MDOURxK5BfsQigSu3kB1QRb
         Z0Ag==
X-Gm-Message-State: AOAM531wq5v4IDGca1rnq9H2TGJtaOd3C71xy5uTACWXx3AJQNhJhv45
        eRngLRU05xC1L+yGX5msHTILUbzSfFZBnQ==
X-Google-Smtp-Source: ABdhPJyK7dW9NhUIx8fzLZofkA5C/rJ3INQfFYnOkWJbLzHbBfyM1U2xbWK/Zf/7yfQNhOdg7aeAXQ==
X-Received: by 2002:a17:906:30c8:: with SMTP id b8mr798723ejb.77.1603439040610;
        Fri, 23 Oct 2020 00:44:00 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49b9:3000:d18a:ee7b:bff9:e374])
        by smtp.gmail.com with ESMTPSA id op24sm337928ejb.56.2020.10.23.00.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 00:44:00 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCHv2 for-next 06/12] RDMA/rtrs-srv: fix typo
Date:   Fri, 23 Oct 2020 09:43:47 +0200
Message-Id: <20201023074353.21946-7-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
References: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

It should mean region here.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
index 08b0b8a6eebe..9543ae19996c 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -62,7 +62,7 @@ struct rtrs_srv_op {
 
 /*
  * server side memory region context, when always_invalidate=Y, we need
- * queue_depth of memory regrion to invalidate each memory region.
+ * queue_depth of memory region to invalidate each memory region.
  */
 struct rtrs_srv_mr {
 	struct ib_mr	*mr;
-- 
2.25.1

