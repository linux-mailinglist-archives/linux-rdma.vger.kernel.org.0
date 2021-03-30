Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747B734E24E
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Mar 2021 09:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhC3Hij (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Mar 2021 03:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhC3HiJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Mar 2021 03:38:09 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A762C061764
        for <linux-rdma@vger.kernel.org>; Tue, 30 Mar 2021 00:38:08 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id bx7so17007925edb.12
        for <linux-rdma@vger.kernel.org>; Tue, 30 Mar 2021 00:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XRGE6YSZlGMJfheJ34bYryhpSeJn76sa8WGvFZ76Ync=;
        b=HuKlJmO327uqa1epPSGqfHDDGCQc0R1mSFe295/0D+tgj2E7DYwUYmHsR8ieBJOd1+
         Gt/MGsW7oIFMuwHlMNgeq+lxvJcnUP1sjKv6WH2xycTJVXfU4zSFRpBzzq8AFQG3vZxp
         nrm85EEmOe9UkYkKxTUEEBPN5uf4r0b4zkm620p4WaSjfMBXx6EdrmWG7znm4ZDOJtin
         5CRFuRe2EpyWkrygvUmZ/OMKb4phEYveqgn+EZkH0oLcbEsDjS5Jaqd32YJWyk1rbpAl
         zaND4V5fDZ7OodR1tFGTs9gPPPR6Dkpu8YbcTQFgrbzmTucksmE0I0W88g49tE/b/0EB
         C8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XRGE6YSZlGMJfheJ34bYryhpSeJn76sa8WGvFZ76Ync=;
        b=jJN+gwaofJBKmj631iLZK73ccNA22O8a+aGTTtI5VBkULCyQmkRRKZpR3Z2eLRq3nH
         qMzPA9wCTxQhs6pt3tB2tTB7ywgK/D7X7BM88kS7fOMmPkxbRDnBH07fk4+SPaSu9Mtk
         rb4d5x1BjsKIE8ehqxv2GJpOGT4myWmw9xKBnAG1VB94DqyIYBAVO9Mw4aSaf67tsfcD
         LYOBt/tT9Eb6XWlA1XRp8A++AvmkZKmQ4jr6IEiKfVzaDz1isRHp/dl3tfI+ziM4i1Lp
         zLuOEClmuqVUzrxSD6mcCc9UhSyPrPjNdWUhi2hPOuXWtChwb3opQdocNWjJovCkkFlI
         28cQ==
X-Gm-Message-State: AOAM5316+b6fGYlrJvmo5vBprBzhoxFCce6ynhQBy/k2o9XDMxcdq4+S
        1vUpMJ36fHoPPo0uHwR66exZ4w==
X-Google-Smtp-Source: ABdhPJyLG+ibtypQgqhve52tSur+fWMfNPHf1Xdf4huK5wMYYs9tiFAdKaX7YiXCgnU5bbKG6HYX8Q==
X-Received: by 2002:a05:6402:484:: with SMTP id k4mr31989952edv.321.1617089887400;
        Tue, 30 Mar 2021 00:38:07 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a3sm9556180ejv.40.2021.03.30.00.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:38:07 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 13/24] block/rnbd-clt: Replace {NO_WAIT,WAIT} with RTRS_PERMIT_{WAIT,NOWAIT}
Date:   Tue, 30 Mar 2021 09:37:41 +0200
Message-Id: <20210330073752.1465613-14-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
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

Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c          | 42 +++++++++++---------------
 drivers/infiniband/ulp/rtrs/rtrs-clt.c |  4 +--
 drivers/infiniband/ulp/rtrs/rtrs.h     |  6 ++--
 3 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index fce0f345f796..6aba7b26f260 100644
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
@@ -440,16 +436,11 @@ static void msg_conf(void *priv, int errno)
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
@@ -481,7 +472,8 @@ static void msg_close_conf(struct work_struct *work)
 	rnbd_clt_put_dev(dev);
 }
 
-static int send_msg_close(struct rnbd_clt_dev *dev, u32 device_id, bool wait)
+static int send_msg_close(struct rnbd_clt_dev *dev, u32 device_id,
+			  enum wait_type wait)
 {
 	struct rnbd_clt_session *sess = dev->sess;
 	struct rnbd_msg_close msg;
@@ -535,7 +527,7 @@ static void msg_open_conf(struct work_struct *work)
 			 * If server thinks its fine, but we fail to process
 			 * then be nice and send a close to server.
 			 */
-			(void)send_msg_close(dev, device_id, NO_WAIT);
+			send_msg_close(dev, device_id, RTRS_PERMIT_NOWAIT);
 		}
 	}
 	kfree(rsp);
@@ -559,7 +551,7 @@ static void msg_sess_info_conf(struct work_struct *work)
 	rnbd_clt_put_sess(sess);
 }
 
-static int send_msg_open(struct rnbd_clt_dev *dev, bool wait)
+static int send_msg_open(struct rnbd_clt_dev *dev, enum wait_type wait)
 {
 	struct rnbd_clt_session *sess = dev->sess;
 	struct rnbd_msg_open_rsp *rsp;
@@ -606,7 +598,7 @@ static int send_msg_open(struct rnbd_clt_dev *dev, bool wait)
 	return err;
 }
 
-static int send_msg_sess_info(struct rnbd_clt_session *sess, bool wait)
+static int send_msg_sess_info(struct rnbd_clt_session *sess, enum wait_type wait)
 {
 	struct rnbd_msg_sess_info_rsp *rsp;
 	struct rnbd_msg_sess_info msg;
@@ -692,7 +684,7 @@ static void remap_devs(struct rnbd_clt_session *sess)
 	 * be asynchronous.
 	 */
 
-	err = send_msg_sess_info(sess, NO_WAIT);
+	err = send_msg_sess_info(sess, RTRS_PERMIT_NOWAIT);
 	if (err) {
 		pr_err("send_msg_sess_info(\"%s\"): %d\n", sess->sessname, err);
 		return;
@@ -716,7 +708,7 @@ static void remap_devs(struct rnbd_clt_session *sess)
 			continue;
 
 		rnbd_clt_info(dev, "session reconnected, remapping device\n");
-		err = send_msg_open(dev, NO_WAIT);
+		err = send_msg_open(dev, RTRS_PERMIT_NOWAIT);
 		if (err) {
 			rnbd_clt_err(dev, "send_msg_open(): %d\n", err);
 			break;
@@ -1248,7 +1240,7 @@ find_and_get_or_create_sess(const char *sessname,
 	if (err)
 		goto close_rtrs;
 
-	err = send_msg_sess_info(sess, WAIT);
+	err = send_msg_sess_info(sess, RTRS_PERMIT_WAIT);
 	if (err)
 		goto close_rtrs;
 
@@ -1531,7 +1523,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 		ret = -EEXIST;
 		goto put_dev;
 	}
-	ret = send_msg_open(dev, WAIT);
+	ret = send_msg_open(dev, RTRS_PERMIT_WAIT);
 	if (ret) {
 		rnbd_clt_err(dev,
 			      "map_device: failed, can't open remote device, err: %d\n",
@@ -1567,7 +1559,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 	return dev;
 
 send_close:
-	send_msg_close(dev, dev->device_id, WAIT);
+	send_msg_close(dev, dev->device_id, RTRS_PERMIT_WAIT);
 del_dev:
 	delete_dev(dev);
 put_dev:
@@ -1636,7 +1628,7 @@ int rnbd_clt_unmap_device(struct rnbd_clt_dev *dev, bool force,
 	destroy_sysfs(dev, sysfs_self);
 	destroy_gen_disk(dev);
 	if (was_mapped && sess->rtrs)
-		send_msg_close(dev, dev->device_id, WAIT);
+		send_msg_close(dev, dev->device_id, RTRS_PERMIT_WAIT);
 
 	rnbd_clt_info(dev, "Device is unmapped\n");
 
@@ -1670,7 +1662,7 @@ int rnbd_clt_remap_device(struct rnbd_clt_dev *dev)
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

