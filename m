Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299F2296A77
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Oct 2020 09:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375774AbgJWHoG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Oct 2020 03:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374504AbgJWHoG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Oct 2020 03:44:06 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E756BC0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:44:05 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z5so1043275ejw.7
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T3kquoa30tyLSRFx7MemJ0XnJhaHJc5eZ+rWAVL23ME=;
        b=UG2YNypfJog4EzocyTVZr+BtqojKpY6z5LgWRxLB+15RpDCz5KNcum0MdR5OpwpkzJ
         cGjb8XSWY7oY5Xc0/fTZfwiW1oB3WNGfRUoEaRG9GcMWYWbtR9A9bnaLWhHoX35Z6xm8
         HeL0AybevD4Qw1fNL533nlOykSyP5pwjVjsljjhcTbZPnXFcq6C7NjAsKWvni1xZav/Z
         dXeQRbvjgqMGIO6iHOsNrK1gGoXGbYdViexAA9ZXvLWd0f5mBOLrS7LfU980WsxmLFH/
         Vu8N2C84/8yHafvqeYmNI+mfONVExdV/moJdyGw8WmeH1fe4WjbmED2HiwGDW19slLca
         5j0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T3kquoa30tyLSRFx7MemJ0XnJhaHJc5eZ+rWAVL23ME=;
        b=sgEZLnWWsbOCILr5ALZMAqp1S1aPKNghyYUGcuEFJ7jagqKTjLZNDDeVIqPTbfD6rv
         Bpr8T6Jhc0icQxBBcqJRId2VJusajK45VlwwKqgvUji9TgQdEkuIzWitc9wpK6UUKzdv
         26Zh/6hUp3R3tenBNq9+gG1qvVilRXUR8U8gKdSkeMrx0MusRhJYwH0xxls6knokOGXI
         ZFrcnlF5dydrhOrLEvkeeX/NhmoKAvuCNIqCFJ1WmTKm2Bb3QivI1o/bZ5L3i9oawx8v
         bEdCHvDdBEIH4yqNTwuGKX2PRxXQ25l9nczG7kG0dYOK9X17nV1s9S8hUoYVjBHEW15D
         JG+A==
X-Gm-Message-State: AOAM530RK6Xbx4MhkGYIHEhLnasqtkLGE3BKQKvlPvlYe57KmEptIIPg
        bnfMTb82AreS+yntBnu4es+zwjMLqzTXzg==
X-Google-Smtp-Source: ABdhPJwcpD26zEFwBFAXjqY8L5g/PebwdcGWcHUBMzW02cM9BX2G8yEz/K9SLjVguNPxv2KtjPDo7Q==
X-Received: by 2002:a17:906:7fd7:: with SMTP id r23mr712953ejs.310.1603439044502;
        Fri, 23 Oct 2020 00:44:04 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49b9:3000:d18a:ee7b:bff9:e374])
        by smtp.gmail.com with ESMTPSA id op24sm337928ejb.56.2020.10.23.00.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 00:44:04 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCHv2 for-next 10/12] RDMA/rtrs-srv: kill rtrs_srv_change_state_get_old
Date:   Fri, 23 Oct 2020 09:43:51 +0200
Message-Id: <20201023074353.21946-11-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
References: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

This function isn't needed since no caller checks the old_state of sess.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 42ee3bf7dc52..c42fd470c4eb 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -113,28 +113,18 @@ static bool __rtrs_srv_change_state(struct rtrs_srv_sess *sess,
 	return changed;
 }
 
-static bool rtrs_srv_change_state_get_old(struct rtrs_srv_sess *sess,
-					   enum rtrs_srv_state new_state,
-					   enum rtrs_srv_state *old_state)
+static bool rtrs_srv_change_state(struct rtrs_srv_sess *sess,
+				   enum rtrs_srv_state new_state)
 {
 	bool changed;
 
 	spin_lock_irq(&sess->state_lock);
-	*old_state = sess->state;
 	changed = __rtrs_srv_change_state(sess, new_state);
 	spin_unlock_irq(&sess->state_lock);
 
 	return changed;
 }
 
-static bool rtrs_srv_change_state(struct rtrs_srv_sess *sess,
-				   enum rtrs_srv_state new_state)
-{
-	enum rtrs_srv_state old_state;
-
-	return rtrs_srv_change_state_get_old(sess, new_state, &old_state);
-}
-
 static void free_id(struct rtrs_srv_op *id)
 {
 	if (!id)
@@ -471,10 +461,7 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 
 void close_sess(struct rtrs_srv_sess *sess)
 {
-	enum rtrs_srv_state old_state;
-
-	if (rtrs_srv_change_state_get_old(sess, RTRS_SRV_CLOSING,
-					   &old_state))
+	if (rtrs_srv_change_state(sess, RTRS_SRV_CLOSING))
 		queue_work(rtrs_wq, &sess->close_work);
 	WARN_ON(sess->state != RTRS_SRV_CLOSING);
 }
-- 
2.25.1

