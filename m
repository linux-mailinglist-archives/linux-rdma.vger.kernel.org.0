Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B896D296A78
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Oct 2020 09:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374504AbgJWHoG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Oct 2020 03:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S375775AbgJWHoG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Oct 2020 03:44:06 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063BFC0613D2
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:44:05 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w25so633059edx.2
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQPo3xtXQ3c+ba8K989CK1eFGoKLVGepg0kiLuKLBMM=;
        b=DTQU56y2e1AQkGQNRCyHt8SwTDM5bWuIMaFEiw1xFuJgi0bczQoiij826xPmKrS54y
         5tNBxyiKsMFWKYUHhKxOwe3DwiPMIG7yHX6xq9dsTAtH2ou2z90w0HQHM0ft552Z2eIh
         QGahuIeRB+56J1AGideP6MTqzh2UkZUuv4jEzXBGJHifbtt+B4LQOQzSHh0dfPqn/rps
         KMEdosKgVTYE8nRlAAvC77TwHUOlLcC6U+rdVtwMk5w4TuSY6Kb1yQi8NHM561NwUK/7
         FNW8LvPl6uY3vy1UEvcKmjQ0AEjL0mgWeHYUipsuRxADxvtDYZi8WdMdqtC7QipruAGC
         HCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQPo3xtXQ3c+ba8K989CK1eFGoKLVGepg0kiLuKLBMM=;
        b=l8CIXY2LNaqfwuP4zcE4vegzQ9GyIULDdOIWozt0bsWITPOF+peDbutYuulX3Z1mve
         LI9iQ/MfZE2z9mVT6S6Qe7Jod5JSX+rXdYhwb/9Pii93A3WF6XRRXrNZZ8Naan8oyqbF
         URONJ877bcPKkx+4iSCJL1qC54OCzmqwYHgKxTLj2GVv+uuApnvJWsvbWfVAJbd1IxHX
         VOOddelVaD/tyN4BmHZdAQLfUDsu1JQVzxRb2+gnOfjZGjWvel5iIIyrq2sRe/IoAAJW
         9A9NF1pDu9hWlDbaWAC/uUQ+UJmbtbKzH2Vo2XtNL0/cbpuNjr/ZnkTMfQ2PbJ7b3hDE
         TlYQ==
X-Gm-Message-State: AOAM532y4Yx5wtcwQFdGQEZ6ICKGb5INLbtGiKAImCh5y9OrA5Haz6Qc
        pkY6qBm6xRm4uBAwhv3F7ohRsGA/ANGKlg==
X-Google-Smtp-Source: ABdhPJzjw/v4Toc5aXweVwTYUw9HdY+6jdgTGSYMoKwkLB8tGw2yEaPx6ScKI4IieEX4zVf4If0OUA==
X-Received: by 2002:a50:e447:: with SMTP id e7mr966563edm.263.1603439043482;
        Fri, 23 Oct 2020 00:44:03 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49b9:3000:d18a:ee7b:bff9:e374])
        by smtp.gmail.com with ESMTPSA id op24sm337928ejb.56.2020.10.23.00.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 00:44:03 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCHv2 for-next 09/12] RDMA/rtrs-clt: remove duplicated code
Date:   Fri, 23 Oct 2020 09:43:50 +0200
Message-Id: <20201023074353.21946-10-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
References: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

process_info_rsp checks that sg_cnt is zero twice.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 30eda2f355e1..1b2821d71b46 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2264,8 +2264,12 @@ static int process_info_rsp(struct rtrs_clt_sess *sess,
 	int i, sgi;
 
 	sg_cnt = le16_to_cpu(msg->sg_cnt);
-	if (unlikely(!sg_cnt))
+	if (unlikely(!sg_cnt || (sess->queue_depth % sg_cnt))) {
+		rtrs_err(sess->clt, "Incorrect sg_cnt %d, is not multiple\n",
+			  sg_cnt);
 		return -EINVAL;
+	}
+
 	/*
 	 * Check if IB immediate data size is enough to hold the mem_id and
 	 * the offset inside the memory chunk.
@@ -2278,11 +2282,6 @@ static int process_info_rsp(struct rtrs_clt_sess *sess,
 			  MAX_IMM_PAYL_BITS, sg_cnt, sess->chunk_size);
 		return -EINVAL;
 	}
-	if (unlikely(!sg_cnt || (sess->queue_depth % sg_cnt))) {
-		rtrs_err(sess->clt, "Incorrect sg_cnt %d, is not multiple\n",
-			  sg_cnt);
-		return -EINVAL;
-	}
 	total_len = 0;
 	for (sgi = 0, i = 0; sgi < sg_cnt && i < sess->queue_depth; sgi++) {
 		const struct rtrs_sg_desc *desc = &msg->desc[sgi];
-- 
2.25.1

