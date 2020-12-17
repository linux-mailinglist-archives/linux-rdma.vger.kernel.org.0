Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392C72DD2DB
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 15:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgLQOUm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Dec 2020 09:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgLQOUm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Dec 2020 09:20:42 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96516C0611CD
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:28 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g24so3190605edw.9
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K20am84mWdOPDtt/C3eABp6vABmQqQkIc3UUOw+LTjA=;
        b=CkwzMmS7VdxuoMezxc2GdrjESt9w/uxgcJJrwPh9t5FUcaDJSf8gMvO8N8uWAnNXwP
         0qCcpwhBCsj7o3rgh0y79fiuO+iCAJ7VbUCp9j+tu/04jvvyO76vF2MmaEysanJKUfMk
         OXUJ8gJJsCH6UgqvLbjgO7GJxyW8eCRTdzhPkYKuWdbg+NKFdx1mS3uLULKAvdlBddwV
         pzL4B6EQUArGIc5/SjkMfSkwdmFYaXWkMURLjUiDLd7X6wg+CgyMk0UMFVErXxUpLTf6
         7o3r8QSIuvg7nfwG3VSZrvNW/loY15VU8MOs+okeJqzXpG1JOfG2bKRcuwaKOq6wIDi6
         k8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K20am84mWdOPDtt/C3eABp6vABmQqQkIc3UUOw+LTjA=;
        b=dIX+hof7ZRKW/kkWfL0jKqq9Xa9CvIO3Rw46ZxdkdzwZVpaHCl0bqwurpQbo+VH6Ab
         9Q4JLuJW/ONSuXdwWgMZkYPaVdhXOd0el0HnOCtsUEfu90BNxGNYo38AfGy4Fu7+OoPi
         PmoSt0Dpx+vkYZ/22bq97M6nyVNkr8G64HXMM3HJBccedBXUgL3KAq6fyuff4JsnH4Pe
         QIZxSyWe8bcbgNBDPZ4i9XNUf0ohfAFmwkT1RZwu5kzhji54GuAmh0YtzfplItLhbRpR
         qKfb1ZEYT4Pkl6055Rww6DzBql+dnPyVC7jkXjGdS9cA6++dBAhTuv0pztp2jqsSr8cQ
         KUNg==
X-Gm-Message-State: AOAM533+OYWeSIa03sGWyKRFpb5K4HHGoBfEZcpnRFrh4U0qk9ab2gw7
        U/puSjFb2gX3osrCU8zY4/IZe0joqbqlkg==
X-Google-Smtp-Source: ABdhPJzFalV0eev3YCAgnYcJqGqhPvP+N3pdh3AGlLB1zdy0pyDdNVmzlFLGFZmvNN+e5XAFqV+bog==
X-Received: by 2002:a50:9ea4:: with SMTP id a33mr11439540edf.70.1608214767171;
        Thu, 17 Dec 2020 06:19:27 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4991:de00:e5a4:2f4d:99:ddc5])
        by smtp.gmail.com with ESMTPSA id b14sm18168969edu.3.2020.12.17.06.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:19:26 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCHv2 for-next 11/19] RDMA/rtrs-clt: Kill rtrs_clt_change_state
Date:   Thu, 17 Dec 2020 15:19:07 +0100
Message-Id: <20201217141915.56989-12-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

It is just a wrapper of rtrs_clt_change_state_get_old, and we can reuse
rtrs_clt_change_state_get_old with add the checking of 'old_state' is
valid or not.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 27 ++++++++++----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index d99fb1a1c194..39dc8423d7df 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1359,21 +1359,14 @@ static bool rtrs_clt_change_state_get_old(struct rtrs_clt_sess *sess,
 	bool changed;
 
 	spin_lock_irq(&sess->state_wq.lock);
-	*old_state = sess->state;
+	if (old_state)
+		*old_state = sess->state;
 	changed = __rtrs_clt_change_state(sess, new_state);
 	spin_unlock_irq(&sess->state_wq.lock);
 
 	return changed;
 }
 
-static bool rtrs_clt_change_state(struct rtrs_clt_sess *sess,
-				   enum rtrs_clt_state new_state)
-{
-	enum rtrs_clt_state old_state;
-
-	return rtrs_clt_change_state_get_old(sess, new_state, &old_state);
-}
-
 static void rtrs_clt_hb_err_handler(struct rtrs_con *c)
 {
 	struct rtrs_clt_con *con = container_of(c, typeof(*con), c);
@@ -1799,7 +1792,7 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
 
 static void rtrs_clt_close_conns(struct rtrs_clt_sess *sess, bool wait)
 {
-	if (rtrs_clt_change_state(sess, RTRS_CLT_CLOSING))
+	if (rtrs_clt_change_state_get_old(sess, RTRS_CLT_CLOSING, NULL))
 		queue_work(rtrs_wq, &sess->close_work);
 	if (wait)
 		flush_work(&sess->close_work);
@@ -2185,7 +2178,7 @@ static void rtrs_clt_close_work(struct work_struct *work)
 
 	cancel_delayed_work_sync(&sess->reconnect_dwork);
 	rtrs_clt_stop_and_destroy_conns(sess);
-	rtrs_clt_change_state(sess, RTRS_CLT_CLOSED);
+	rtrs_clt_change_state_get_old(sess, RTRS_CLT_CLOSED, NULL);
 }
 
 static int init_conns(struct rtrs_clt_sess *sess)
@@ -2237,7 +2230,7 @@ static int init_conns(struct rtrs_clt_sess *sess)
 	 * doing rdma_resolve_addr(), switch to CONNECTION_ERR state
 	 * manually to keep reconnecting.
 	 */
-	rtrs_clt_change_state(sess, RTRS_CLT_CONNECTING_ERR);
+	rtrs_clt_change_state_get_old(sess, RTRS_CLT_CONNECTING_ERR, NULL);
 
 	return err;
 }
@@ -2254,7 +2247,7 @@ static void rtrs_clt_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
 		rtrs_err(sess->clt, "Sess info request send failed: %s\n",
 			  ib_wc_status_msg(wc->status));
-		rtrs_clt_change_state(sess, RTRS_CLT_CONNECTING_ERR);
+		rtrs_clt_change_state_get_old(sess, RTRS_CLT_CONNECTING_ERR, NULL);
 		return;
 	}
 
@@ -2378,7 +2371,7 @@ static void rtrs_clt_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
 out:
 	rtrs_clt_update_wc_stats(con);
 	rtrs_iu_free(iu, sess->s.dev->ib_dev, 1);
-	rtrs_clt_change_state(sess, state);
+	rtrs_clt_change_state_get_old(sess, state, NULL);
 }
 
 static int rtrs_send_sess_info(struct rtrs_clt_sess *sess)
@@ -2443,7 +2436,7 @@ static int rtrs_send_sess_info(struct rtrs_clt_sess *sess)
 		rtrs_iu_free(rx_iu, sess->s.dev->ib_dev, 1);
 	if (unlikely(err))
 		/* If we've never taken async path because of malloc problems */
-		rtrs_clt_change_state(sess, RTRS_CLT_CONNECTING_ERR);
+		rtrs_clt_change_state_get_old(sess, RTRS_CLT_CONNECTING_ERR, NULL);
 
 	return err;
 }
@@ -2500,7 +2493,7 @@ static void rtrs_clt_reconnect_work(struct work_struct *work)
 	/* Stop everything */
 	rtrs_clt_stop_and_destroy_conns(sess);
 	msleep(RTRS_RECONNECT_BACKOFF);
-	if (rtrs_clt_change_state(sess, RTRS_CLT_CONNECTING)) {
+	if (rtrs_clt_change_state_get_old(sess, RTRS_CLT_CONNECTING, NULL)) {
 		err = init_sess(sess);
 		if (err)
 			goto reconnect_again;
@@ -2509,7 +2502,7 @@ static void rtrs_clt_reconnect_work(struct work_struct *work)
 	return;
 
 reconnect_again:
-	if (rtrs_clt_change_state(sess, RTRS_CLT_RECONNECTING)) {
+	if (rtrs_clt_change_state_get_old(sess, RTRS_CLT_RECONNECTING, NULL)) {
 		sess->stats->reconnects.fail_cnt++;
 		delay_ms = clt->reconnect_delay_sec * 1000;
 		queue_delayed_work(rtrs_wq, &sess->reconnect_dwork,
-- 
2.25.1

