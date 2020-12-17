Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2812DD2E3
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 15:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbgLQOVI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Dec 2020 09:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbgLQOVH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Dec 2020 09:21:07 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5701EC0611E4
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:32 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id w1so33433321ejf.11
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dC433w+l94tzlmYEUA1IqAKrp3WUB5gM49lo3vgomRs=;
        b=ddY9/tDTTIvt5H22X9KDu/FgD8IW2dccy6QVnsiRUw4y+gsJcgpW8mDibC1lnpwLkI
         osZbIAYTGRiNNjbnc2YzMW3P18drbFihm/1YmjriFhRIESHfYOltldpjWQ4ejeWiFF2s
         Uc/0oTr4nZ8W45j2eEefqhdywCimY+MVkbUSea1dBDPhdCVFe+9dFEL+nVA5FXW7ZF/H
         69qaQ6Q4Hxhs/DKkNdbHS7VMXC1NqnDstF6gENjXOowULFZRtiQZyLTayMo8oU0LGNlH
         lwZSmoGDOl/x74s+L0nSWkJqGpLKd2FD3bDdJ4pM+nArsFtISo12/OZTMsHOFWFXFDFL
         l74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dC433w+l94tzlmYEUA1IqAKrp3WUB5gM49lo3vgomRs=;
        b=PsPfjBboXx04XpiKURJl/r2lUVzvoPsAEQni95AA8IFc8a6Ie6hl03HPGVbfbBNNNZ
         L6gfhTFLcEeETkyARX+pS6qqLw0H4Kd9p9ndeVCwLkQVArM3E8Nw/S4gLoKTLqh/TbMs
         UYRaaNmLvP7NHhOY9N3kpufRKCMQofzgrpHdHTApzU++l8gFD7ZhC7qODNEl6SSeefjP
         YVBPEkGbMGqMgccIKmjEtzo7rRZIjXadhcdz+fA/tmNMhjtpqBTXnjips5q1ClKBy3v5
         U34GOPZPyUCw8FlIW5NEFjotTVJc2pvUhqE0l9cVUUcAS4aQztHeaddF2kjMPPbf7vzy
         df8Q==
X-Gm-Message-State: AOAM531JurYpAVdGVF8EWnNcNbszkLiWc6Av93f32uK/E8Sj0L9Rtiw4
        ObD3nS7AGELeum+aS3908VFVHTcCCZl7vg==
X-Google-Smtp-Source: ABdhPJxEUEWVB8lLvkaVM/SrDGdNBio8L5xF2DgmBZXQMNhc3zUkcx5BWQHX3MMgxNsldMQopwENLg==
X-Received: by 2002:a17:906:8354:: with SMTP id b20mr35313410ejy.397.1608214770930;
        Thu, 17 Dec 2020 06:19:30 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4991:de00:e5a4:2f4d:99:ddc5])
        by smtp.gmail.com with ESMTPSA id b14sm18168969edu.3.2020.12.17.06.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:19:30 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCHv2 for-next 15/19] RDMA/rtrs: Do not signal for heatbeat
Date:   Thu, 17 Dec 2020 15:19:11 +0100
Message-Id: <20201217141915.56989-16-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

For HB, there is no need to generate signal for completion.

Also remove a comment accordingly.

Fixes: c0894b3ea69d ("RDMA/rtrs: core: lib functions shared between client and server modules")
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reported-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 1 -
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 1 -
 drivers/infiniband/ulp/rtrs/rtrs.c     | 4 ++--
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 493f45a33b5e..2053bf99418a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -664,7 +664,6 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 	case IB_WC_RDMA_WRITE:
 		/*
 		 * post_send() RDMA write completions of IO reqs (read/write)
-		 * and hb
 		 */
 		break;
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 465f20d6b89c..8ea1df6b4da0 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1242,7 +1242,6 @@ static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 	case IB_WC_SEND:
 		/*
 		 * post_send() RDMA write completions of IO reqs (read/write)
-		 * and hb
 		 */
 		atomic_add(srv->queue_depth, &con->sq_wr_avail);
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index df52427f1710..97af8f0bb806 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -310,7 +310,7 @@ void rtrs_send_hb_ack(struct rtrs_sess *sess)
 
 	imm = rtrs_to_imm(RTRS_HB_ACK_IMM, 0);
 	err = rtrs_post_rdma_write_imm_empty(usr_con, sess->hb_cqe, imm,
-					      IB_SEND_SIGNALED, NULL);
+					     0, NULL);
 	if (err) {
 		sess->hb_err_handler(usr_con);
 		return;
@@ -339,7 +339,7 @@ static void hb_work(struct work_struct *work)
 	}
 	imm = rtrs_to_imm(RTRS_HB_MSG_IMM, 0);
 	err = rtrs_post_rdma_write_imm_empty(usr_con, sess->hb_cqe, imm,
-					      IB_SEND_SIGNALED, NULL);
+					     0, NULL);
 	if (err) {
 		sess->hb_err_handler(usr_con);
 		return;
-- 
2.25.1

