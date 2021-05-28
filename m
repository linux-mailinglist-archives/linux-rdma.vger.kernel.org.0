Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC063941C4
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 13:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhE1LcH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 07:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbhE1LcD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 07:32:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D892EC061761
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:23 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r11so4426949edt.13
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jkNdeh8nbDctZK6SGkgOCmm67mVJfJlazEs9SPAqMzg=;
        b=H5u3zelF+uixWBKn2JhIyvVpOMLbphHyUSSmskAkMEZ062facrkTmB/NqM5cEi/vzW
         WJDVNtdcM29pviaxm256JKQI4uJAkIHZ5ZAOm8hhFOjqq4SNPMOjbsNb0A+wBuKrEkm+
         2C1wGcUK1gPyUyEA6aXA18+cItaAKe8Pc4rfwmnTO7pCJLTgtteIMigwxAF/qGTqUIhQ
         ZNzAEcKuVJIgn7VjjdhDlOk/aEVk1Hqajy16edMqw3aPLCwI+Bvra0E3F4k2awFeI69n
         5szZflGllUCds4dqxPAYWHm6Oo3e8B/mtG86foDKXI4330ANXZWFbkgOfyCk78aYvvdO
         y1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jkNdeh8nbDctZK6SGkgOCmm67mVJfJlazEs9SPAqMzg=;
        b=OAxGMD7C7EvXxh39bo4HwVSkU9NIOpFuVoIM2GEw41PcppFHn+LcDnnqtmKT5hUoJn
         7qG0VlPMFBwmQSSLV8/Tau9DVri0zwelhPDy6Tzd2mj6cRmK/nea9yjjQHkqJvI6nMRP
         NbHbcPvyQyKYugSv9nxegk0qp+qPuWwV/nWhzqGGPOF4h4Ak17BBV/IOOZXyZ3fHHnsm
         V6KlfEEjeV9F/arMQMg5vv2aFbxyy12iFC1ZbLTc7+wTjTyk5Dz6WtweZiTfpp47At9D
         9wyFA/FVDXfFwtctQlUEQr8K2+BXwlHi1mFxGXwzk369fQ8RsGxRz8tZzwFB7FjFVAWf
         yQjQ==
X-Gm-Message-State: AOAM530+tLy0THHPd9CJ5RJmCDuhMpfNsHPJe++/BscfcGIz6oJjLI82
        VMhMw+JMzMVMSs0KlnFmHGP9FqWZhq2JVQ==
X-Google-Smtp-Source: ABdhPJxvA0ciaQRSfw/R7YKoTD2PXmEYJR+thd9F/093cDJFvKM+KeUwxP0BZmiTfa7B9ZvnzVMbqA==
X-Received: by 2002:aa7:dd10:: with SMTP id i16mr9289500edv.274.1622201422310;
        Fri, 28 May 2021 04:30:22 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:497d:7d00:983b:122a:4685:3849])
        by smtp.gmail.com with ESMTPSA id p15sm2594578edr.50.2021.05.28.04.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:30:22 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 03/20] RDMA/rtrs-srv: Add error messages for cases when failing RDMA connection
Date:   Fri, 28 May 2021 13:30:01 +0200
Message-Id: <20210528113018.52290-4-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528113018.52290-1-jinpu.wang@ionos.com>
References: <20210528113018.52290-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

It was difficult to find out why it failed to establish RDMA
connection. This patch adds some messages to show which function
has failed why.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index cf3283acc8e8..7a0954aa24c8 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1356,8 +1356,10 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
 	 * If this request is not the first connection request from the
 	 * client for this session then fail and return error.
 	 */
-	if (!first_conn)
+	if (!first_conn) {
+		pr_err_ratelimited("Error: Not the first connection request for this session\n");
 		return ERR_PTR(-ENXIO);
+	}
 
 	/* need to allocate a new srv */
 	srv = kzalloc(sizeof(*srv), GFP_KERNEL);
@@ -1812,6 +1814,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	srv = get_or_create_srv(ctx, &msg->paths_uuid, msg->first_conn);
 	if (IS_ERR(srv)) {
 		err = PTR_ERR(srv);
+		pr_err("get_or_create_srv(), error %d\n", err);
 		goto reject_w_err;
 	}
 	mutex_lock(&srv->paths_mutex);
@@ -1850,11 +1853,13 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 			mutex_unlock(&srv->paths_mutex);
 			put_srv(srv);
 			err = PTR_ERR(sess);
+			pr_err("RTRS server session allocation failed: %d\n", err);
 			goto reject_w_err;
 		}
 	}
 	err = create_con(sess, cm_id, cid);
 	if (err) {
+		rtrs_err((&sess->s), "create_con(), error %d\n", err);
 		(void)rtrs_rdma_do_reject(cm_id, err);
 		/*
 		 * Since session has other connections we follow normal way
@@ -1865,6 +1870,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	}
 	err = rtrs_rdma_do_accept(sess, cm_id);
 	if (err) {
+		rtrs_err((&sess->s), "rtrs_rdma_do_accept(), error %d\n", err);
 		(void)rtrs_rdma_do_reject(cm_id, err);
 		/*
 		 * Since current connection was successfully added to the
-- 
2.25.1

