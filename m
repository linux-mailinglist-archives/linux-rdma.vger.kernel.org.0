Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B955348ED65
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jan 2022 16:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242955AbiANPsM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jan 2022 10:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242960AbiANPsK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Jan 2022 10:48:10 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309E2C06161C
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jan 2022 07:48:10 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso7608304wmj.0
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jan 2022 07:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=peRhn+ZcQyZuvGaeFx7wqLuFm/wiTjZvH9rBrtDxgzA=;
        b=Pae5wUfDwzlm8Jjcm7ewqMheJoh/r8BGUDjJXZIN70A0oW7g9szuOTGCgEpDttIy9V
         yzajXOGWEjkcP+lbYK3LJmHSuyOR/5/3T6f9v9mnNeDAwCNWslg/vX5EevNxYu0mqQQZ
         i9+85CmJnIcLeAbyLskjKSLEzFSixeUlPNCTg1sIO/kkTgd6rW9DnOEGYe8Gy+oCzXGu
         OwOZeaPiv9MS8urdL4LCOlvnymI9Ugn62okc2ITtvHUvbx33aeIhuDVymW1k2EVK9PHY
         JoLu+f7X0yPX7fo9MK5b7OLHY5dmPLbq/H0zcpnjbWUtxjmmcTk0BdHr01gdEZQ+Z40c
         Cy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=peRhn+ZcQyZuvGaeFx7wqLuFm/wiTjZvH9rBrtDxgzA=;
        b=JutQ9UDzL0Cy7xQO4gjyvAGMZpd40C3dp1veO0NhrK+ayF8KCn6ugwHjZ6ET6y2gzA
         +/aQMCtnOYLkxd3t4fvDlq0wfK9eE6oZneVBkAd9/R8WdIRbNE8jZhhC99Cz1JhF8rgM
         Y7DpgNMCH+XeMzn4CJTS8qQyZDKsf1CVZAAXhA/SFLGGK30HSs+OqZabhQYr6Ke7kxWo
         uiC69ujKJaHVTkejjTEdXQUrfkHBHlf6l+w7RrnSUZnauuCLzV/TBy2KLjhNdgug/jEh
         3PMM42TFEctitWUUFRHIzxFqQ7mKJbirwGr8YFO9X22Qo+/6OHIHeH45BEDObLnM6+dN
         ht0g==
X-Gm-Message-State: AOAM5308JH/P8tWj5LfiwlBnArFaGHnu2Ze51JVv+f3+mqV1R8ORjSdm
        9EgaYkRnwOP47OpJW/d7OFFumvzx1V7MGA==
X-Google-Smtp-Source: ABdhPJyr71+AcR9qxBwN7fNZYxV7MRKotJKFvpAM9TBXxvp7QDS4l5F+VUdcFQ0FinoN/ZVb1Diyqw==
X-Received: by 2002:a05:6402:3d2:: with SMTP id t18mr9205636edw.368.1642175288704;
        Fri, 14 Jan 2022 07:48:08 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id x20sm2522028edd.28.2022.01.14.07.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:48:08 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Aleksei Marov <aleksei.marov@ionos.com>
Subject: [PATCH for-next 5/5] RDMA/rtrs-clt: Do stop and failover outside reconnect work.
Date:   Fri, 14 Jan 2022 16:47:53 +0100
Message-Id: <20220114154753.983568-6-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114154753.983568-1-haris.iqbal@ionos.com>
References: <20220114154753.983568-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@ionos.com>

We can't do instant reconnect, not to DDoS server, but
we should stop and failover earlier, so there is less
service interruption.

To avoid deadlock, as error_recovery is called from different
callback like rdma event or hb error handler, add a new err
recovery_work.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 40 ++++++++++++++------------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |  1 +
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 05de9ec7c99a..b159471a8959 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -297,6 +297,7 @@ static bool rtrs_clt_change_state_from_to(struct rtrs_clt_path *clt_path,
 	return changed;
 }
 
+static void rtrs_clt_stop_and_destroy_conns(struct rtrs_clt_path *clt_path);
 static void rtrs_rdma_error_recovery(struct rtrs_clt_con *con)
 {
 	struct rtrs_clt_path *clt_path = to_clt_path(con->c.path);
@@ -304,16 +305,7 @@ static void rtrs_rdma_error_recovery(struct rtrs_clt_con *con)
 	if (rtrs_clt_change_state_from_to(clt_path,
 					   RTRS_CLT_CONNECTED,
 					   RTRS_CLT_RECONNECTING)) {
-		struct rtrs_clt_sess *clt = clt_path->clt;
-		unsigned int delay_ms;
-
-		/*
-		 * Normal scenario, reconnect if we were successfully connected
-		 */
-		delay_ms = clt->reconnect_delay_sec * 1000;
-		queue_delayed_work(rtrs_wq, &clt_path->reconnect_dwork,
-				   msecs_to_jiffies(delay_ms +
-						    prandom_u32() % RTRS_RECONNECT_SEED));
+		queue_work(rtrs_wq, &clt_path->err_recovery_work);
 	} else {
 		/*
 		 * Error can happen just on establishing new connection,
@@ -1501,6 +1493,22 @@ static void rtrs_clt_init_hb(struct rtrs_clt_path *clt_path)
 static void rtrs_clt_reconnect_work(struct work_struct *work);
 static void rtrs_clt_close_work(struct work_struct *work);
 
+static void rtrs_clt_err_recovery_work(struct work_struct *work)
+{
+	struct rtrs_clt_path *clt_path;
+	struct rtrs_clt_sess *clt;
+	int delay_ms;
+
+	clt_path = container_of(work, struct rtrs_clt_path, err_recovery_work);
+	clt = clt_path->clt;
+	delay_ms = clt->reconnect_delay_sec * 1000;
+	rtrs_clt_stop_and_destroy_conns(clt_path);
+	queue_delayed_work(rtrs_wq, &clt_path->reconnect_dwork,
+			   msecs_to_jiffies(delay_ms +
+					    prandom_u32() %
+					    RTRS_RECONNECT_SEED));
+}
+
 static struct rtrs_clt_path *alloc_path(struct rtrs_clt_sess *clt,
 					const struct rtrs_addr *path,
 					size_t con_num, u32 nr_poll_queues)
@@ -1552,6 +1560,7 @@ static struct rtrs_clt_path *alloc_path(struct rtrs_clt_sess *clt,
 	clt_path->state = RTRS_CLT_CONNECTING;
 	atomic_set(&clt_path->connected_cnt, 0);
 	INIT_WORK(&clt_path->close_work, rtrs_clt_close_work);
+	INIT_WORK(&clt_path->err_recovery_work, rtrs_clt_err_recovery_work);
 	INIT_DELAYED_WORK(&clt_path->reconnect_dwork, rtrs_clt_reconnect_work);
 	rtrs_clt_init_hb(clt_path);
 
@@ -2321,6 +2330,7 @@ static void rtrs_clt_close_work(struct work_struct *work)
 
 	clt_path = container_of(work, struct rtrs_clt_path, close_work);
 
+	cancel_work_sync(&clt_path->err_recovery_work);
 	cancel_delayed_work_sync(&clt_path->reconnect_dwork);
 	rtrs_clt_stop_and_destroy_conns(clt_path);
 	rtrs_clt_change_state_get_old(clt_path, RTRS_CLT_CLOSED, NULL);
@@ -2633,7 +2643,6 @@ static void rtrs_clt_reconnect_work(struct work_struct *work)
 {
 	struct rtrs_clt_path *clt_path;
 	struct rtrs_clt_sess *clt;
-	unsigned int delay_ms;
 	int err;
 
 	clt_path = container_of(to_delayed_work(work), struct rtrs_clt_path,
@@ -2650,8 +2659,6 @@ static void rtrs_clt_reconnect_work(struct work_struct *work)
 	}
 	clt_path->reconnect_attempts++;
 
-	/* Stop everything */
-	rtrs_clt_stop_and_destroy_conns(clt_path);
 	msleep(RTRS_RECONNECT_BACKOFF);
 	if (rtrs_clt_change_state_get_old(clt_path, RTRS_CLT_CONNECTING, NULL)) {
 		err = init_path(clt_path);
@@ -2664,11 +2671,7 @@ static void rtrs_clt_reconnect_work(struct work_struct *work)
 reconnect_again:
 	if (rtrs_clt_change_state_get_old(clt_path, RTRS_CLT_RECONNECTING, NULL)) {
 		clt_path->stats->reconnects.fail_cnt++;
-		delay_ms = clt->reconnect_delay_sec * 1000;
-		queue_delayed_work(rtrs_wq, &clt_path->reconnect_dwork,
-				   msecs_to_jiffies(delay_ms +
-						    prandom_u32() %
-						    RTRS_RECONNECT_SEED));
+		queue_work(rtrs_wq, &clt_path->err_recovery_work);
 	}
 }
 
@@ -2900,6 +2903,7 @@ int rtrs_clt_reconnect_from_sysfs(struct rtrs_clt_path *clt_path)
 						 &old_state);
 	if (changed) {
 		clt_path->reconnect_attempts = 0;
+		rtrs_clt_stop_and_destroy_conns(clt_path);
 		queue_delayed_work(rtrs_wq, &clt_path->reconnect_dwork, 0);
 	}
 	if (changed || old_state == RTRS_CLT_RECONNECTING) {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index d1b18a154ae0..f848c0392d98 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -134,6 +134,7 @@ struct rtrs_clt_path {
 	struct rtrs_clt_io_req	*reqs;
 	struct delayed_work	reconnect_dwork;
 	struct work_struct	close_work;
+	struct work_struct	err_recovery_work;
 	unsigned int		reconnect_attempts;
 	bool			established;
 	struct rtrs_rbuf	*rbufs;
-- 
2.25.1

