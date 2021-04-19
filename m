Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E167363CB9
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Apr 2021 09:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbhDSHi0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Apr 2021 03:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237882AbhDSHiZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Apr 2021 03:38:25 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48453C061761
        for <linux-rdma@vger.kernel.org>; Mon, 19 Apr 2021 00:37:56 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id mh2so29801899ejb.8
        for <linux-rdma@vger.kernel.org>; Mon, 19 Apr 2021 00:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FY+EvpFdvOhsS+mEDCKKrQ36Emkgr0WIzmwaogwOSK0=;
        b=AhotTSMvcBc4h2JRV2P0XHrws6lMKBwqUlhaYthkdt9GQ8b2GV+GSXFm3oGPPUeP+b
         OkYfyRtyvvukJSZ9F0JoHkSAMLFCYvfL3cGZy2VokgKykiIuQ+Ar/YNUEt+G0XptAk2E
         4i8UC31z4cZE1MvAcRUo3J4xu+N+HmD3WC2HRVhADPLwM02QHj+YrrJ60Tgrc3duj9y2
         P7PeUKDzSNycwr1fWiLIItqfpXmhlatq9G6PSrbgmCyNJ90d63E9pxSeeICpte31ujsy
         TNFJU/39+Cee8CBUDM3B9JQ913pGDlQNDLIJOqW1nT0GeHOdZgeEl0StF2I8KqEOH/6b
         n2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FY+EvpFdvOhsS+mEDCKKrQ36Emkgr0WIzmwaogwOSK0=;
        b=sj/jXwtHGrhymzb0QjS3Vix08cAgq1969dsw00+r4xQ2NJPzi8KMByhZ7bfudf3Ky2
         8T47Bx4TOpvlxsZVh91Xfxt/z4lxH0WfYmROa5x2GYGV4x2iKYMITYPsTB+21C22TdqW
         qLZt41YvrP+fr4RoiCOB8YoehAPtI/BGuA5YjInWFkj/i45vC0aFUoGmeqatrwgX1xm5
         gvTJtppiXn5BrVwKQLIxU+JjiZDWfbi/xh0PoSoadSo0E6Y4E2hC8kCYrH8kunzCfJlW
         WRHBZUhrwkERvByc4gEeVZGfotEpHCHWCRCGZuUzmw4dZI3nmntYpPYkmj7IrAR5iFMu
         awHQ==
X-Gm-Message-State: AOAM532Nv+8mjQ+oX1GoxqkNCRooQN9s445j6lFvBUqvnsdfKGoObga1
        yBte5opchI+WRfC7HUByAxI7NQ==
X-Google-Smtp-Source: ABdhPJxm3/Dl+gYYZ34jHAt3hmcpyInuiR+HGY15eklu5RjyPBH81+/L4lHLiVKRAtyAKRhLeKO8KQ==
X-Received: by 2002:a17:906:4881:: with SMTP id v1mr1535769ejq.383.1618817874957;
        Mon, 19 Apr 2021 00:37:54 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id g22sm8701833ejz.46.2021.04.19.00.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:37:54 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     axboe@kernel.dk, akinobu.mita@gmail.com, corbet@lwn.net,
        hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCHv5 for-next 08/19] block/rnbd-clt: Replace {NO_WAIT,WAIT} with RTRS_PERMIT_{WAIT,NOWAIT}
Date:   Mon, 19 Apr 2021 09:37:11 +0200
Message-Id: <20210419073722.15351-9-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419073722.15351-1-gi-oh.kim@ionos.com>
References: <20210419073722.15351-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

They are defined with the same value and similar meaning, let's remove
one of them, then we can remove {WAIT,NOWAIT}.

Also change the type of 'wait' from 'int' to 'enum wait_type' to make
it clear.

Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Acked-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/block/rnbd/rnbd-clt.c          | 42 +++++++++++---------------
 drivers/infiniband/ulp/rtrs/rtrs-clt.c |  4 +--
 drivers/infiniband/ulp/rtrs/rtrs.h     |  6 ++--
 3 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 4e687ec88721..652b41cc4492 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -312,13 +312,11 @@ static void rnbd_rerun_all_if_idle(struct rnbd_clt_session *sess)
 
 static struct rtrs_permit *rnbd_get_permit(struct rnbd_clt_session *sess,
 					     enum rtrs_clt_con_type con_type,
-					     int wait)
+					     enum wait_type wait)
 {
 	struct rtrs_permit *permit;
 
-	permit = rtrs_clt_get_permit(sess->rtrs, con_type,
-				      wait ? RTRS_PERMIT_WAIT :
-				      RTRS_PERMIT_NOWAIT);
+	permit = rtrs_clt_get_permit(sess->rtrs, con_type, wait);
 	if (likely(permit))
 		/* We have a subtle rare case here, when all permits can be
 		 * consumed before busy counter increased.  This is safe,
@@ -344,7 +342,7 @@ static void rnbd_put_permit(struct rnbd_clt_session *sess,
 
 static struct rnbd_iu *rnbd_get_iu(struct rnbd_clt_session *sess,
 				     enum rtrs_clt_con_type con_type,
-				     int wait)
+				     enum wait_type wait)
 {
 	struct rnbd_iu *iu;
 	struct rtrs_permit *permit;
@@ -354,9 +352,7 @@ static struct rnbd_iu *rnbd_get_iu(struct rnbd_clt_session *sess,
 		return NULL;
 	}
 
-	permit = rnbd_get_permit(sess, con_type,
-				  wait ? RTRS_PERMIT_WAIT :
-				  RTRS_PERMIT_NOWAIT);
+	permit = rnbd_get_permit(sess, con_type, wait);
 	if (unlikely(!permit)) {
 		kfree(iu);
 		return NULL;
@@ -435,16 +431,11 @@ static void msg_conf(void *priv, int errno)
 	schedule_work(&iu->work);
 }
 
-enum wait_type {
-	NO_WAIT = 0,
-	WAIT    = 1
-};
-
 static int send_usr_msg(struct rtrs_clt *rtrs, int dir,
 			struct rnbd_iu *iu, struct kvec *vec,
 			size_t len, struct scatterlist *sg, unsigned int sg_len,
 			void (*conf)(struct work_struct *work),
-			int *errno, enum wait_type wait)
+			int *errno, int wait)
 {
 	int err;
 	struct rtrs_clt_req_ops req_ops;
@@ -476,7 +467,8 @@ static void msg_close_conf(struct work_struct *work)
 	rnbd_clt_put_dev(dev);
 }
 
-static int send_msg_close(struct rnbd_clt_dev *dev, u32 device_id, bool wait)
+static int send_msg_close(struct rnbd_clt_dev *dev, u32 device_id,
+			  enum wait_type wait)
 {
 	struct rnbd_clt_session *sess = dev->sess;
 	struct rnbd_msg_close msg;
@@ -530,7 +522,7 @@ static void msg_open_conf(struct work_struct *work)
 			 * If server thinks its fine, but we fail to process
 			 * then be nice and send a close to server.
 			 */
-			(void)send_msg_close(dev, device_id, NO_WAIT);
+			send_msg_close(dev, device_id, RTRS_PERMIT_NOWAIT);
 		}
 	}
 	kfree(rsp);
@@ -554,7 +546,7 @@ static void msg_sess_info_conf(struct work_struct *work)
 	rnbd_clt_put_sess(sess);
 }
 
-static int send_msg_open(struct rnbd_clt_dev *dev, bool wait)
+static int send_msg_open(struct rnbd_clt_dev *dev, enum wait_type wait)
 {
 	struct rnbd_clt_session *sess = dev->sess;
 	struct rnbd_msg_open_rsp *rsp;
@@ -601,7 +593,7 @@ static int send_msg_open(struct rnbd_clt_dev *dev, bool wait)
 	return err;
 }
 
-static int send_msg_sess_info(struct rnbd_clt_session *sess, bool wait)
+static int send_msg_sess_info(struct rnbd_clt_session *sess, enum wait_type wait)
 {
 	struct rnbd_msg_sess_info_rsp *rsp;
 	struct rnbd_msg_sess_info msg;
@@ -687,7 +679,7 @@ static void remap_devs(struct rnbd_clt_session *sess)
 	 * be asynchronous.
 	 */
 
-	err = send_msg_sess_info(sess, NO_WAIT);
+	err = send_msg_sess_info(sess, RTRS_PERMIT_NOWAIT);
 	if (err) {
 		pr_err("send_msg_sess_info(\"%s\"): %d\n", sess->sessname, err);
 		return;
@@ -711,7 +703,7 @@ static void remap_devs(struct rnbd_clt_session *sess)
 			continue;
 
 		rnbd_clt_info(dev, "session reconnected, remapping device\n");
-		err = send_msg_open(dev, NO_WAIT);
+		err = send_msg_open(dev, RTRS_PERMIT_NOWAIT);
 		if (err) {
 			rnbd_clt_err(dev, "send_msg_open(): %d\n", err);
 			break;
@@ -1242,7 +1234,7 @@ find_and_get_or_create_sess(const char *sessname,
 	if (err)
 		goto close_rtrs;
 
-	err = send_msg_sess_info(sess, WAIT);
+	err = send_msg_sess_info(sess, RTRS_PERMIT_WAIT);
 	if (err)
 		goto close_rtrs;
 
@@ -1525,7 +1517,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 		ret = -EEXIST;
 		goto put_dev;
 	}
-	ret = send_msg_open(dev, WAIT);
+	ret = send_msg_open(dev, RTRS_PERMIT_WAIT);
 	if (ret) {
 		rnbd_clt_err(dev,
 			      "map_device: failed, can't open remote device, err: %d\n",
@@ -1559,7 +1551,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 	return dev;
 
 send_close:
-	send_msg_close(dev, dev->device_id, WAIT);
+	send_msg_close(dev, dev->device_id, RTRS_PERMIT_WAIT);
 del_dev:
 	delete_dev(dev);
 put_dev:
@@ -1619,7 +1611,7 @@ int rnbd_clt_unmap_device(struct rnbd_clt_dev *dev, bool force,
 	destroy_sysfs(dev, sysfs_self);
 	destroy_gen_disk(dev);
 	if (was_mapped && sess->rtrs)
-		send_msg_close(dev, dev->device_id, WAIT);
+		send_msg_close(dev, dev->device_id, RTRS_PERMIT_WAIT);
 
 	rnbd_clt_info(dev, "Device is unmapped\n");
 
@@ -1653,7 +1645,7 @@ int rnbd_clt_remap_device(struct rnbd_clt_dev *dev)
 	mutex_unlock(&dev->lock);
 	if (!err) {
 		rnbd_clt_info(dev, "Remapping device.\n");
-		err = send_msg_open(dev, WAIT);
+		err = send_msg_open(dev, RTRS_PERMIT_WAIT);
 		if (err)
 			rnbd_clt_err(dev, "remap_device: %d\n", err);
 	}
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 0a08b4b742a3..7efd49bdc78c 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -103,11 +103,11 @@ static inline void __rtrs_put_permit(struct rtrs_clt *clt,
  *    up earlier.
  *
  * Context:
- *    Can sleep if @wait == RTRS_TAG_WAIT
+ *    Can sleep if @wait == RTRS_PERMIT_WAIT
  */
 struct rtrs_permit *rtrs_clt_get_permit(struct rtrs_clt *clt,
 					  enum rtrs_clt_con_type con_type,
-					  int can_wait)
+					  enum wait_type can_wait)
 {
 	struct rtrs_permit *permit;
 	DEFINE_WAIT(wait);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.h b/drivers/infiniband/ulp/rtrs/rtrs.h
index 8738e90e715a..2db1b5eb3ab0 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs.h
@@ -63,9 +63,9 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 
 void rtrs_clt_close(struct rtrs_clt *sess);
 
-enum {
+enum wait_type {
 	RTRS_PERMIT_NOWAIT = 0,
-	RTRS_PERMIT_WAIT   = 1,
+	RTRS_PERMIT_WAIT   = 1
 };
 
 /**
@@ -81,7 +81,7 @@ enum rtrs_clt_con_type {
 
 struct rtrs_permit *rtrs_clt_get_permit(struct rtrs_clt *sess,
 				    enum rtrs_clt_con_type con_type,
-				    int wait);
+				    enum wait_type wait);
 
 void rtrs_clt_put_permit(struct rtrs_clt *sess, struct rtrs_permit *permit);
 
-- 
2.25.1

