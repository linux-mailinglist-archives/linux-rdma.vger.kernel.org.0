Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EE934956F
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhCYPa1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhCYPaC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:30:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A8DC06174A
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:30:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id hq27so3578018ejc.9
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CO3mf/jnkrczlmLG3PkjYkNQp/y7QsJz9GFGn2qNDY0=;
        b=Tpoh7OVpy6i7Lg+9mKXpSg59naHQL8UCUAqWMWQWfH0++K/PAPj2X6LEvR1c8H+Z4C
         kydUzmjaYuJCtV3EBvlpKFX/CkKw1Rk8gshlZ7I0HK5GYzm4maCoUrjUkwBbPlaP2302
         heQJGYgtupES4Nm6exdmt7rRAj5DowC20mUcjJivYbpd/jCiQRTaPvrPIxCbaDY9mZmn
         R7eWgqqM/poVgtiV1VObndhuqqMnqigwWbHs8ondaVvqCl7K9sj6yy9oLUc3QJP2KS+e
         E7cpA/xirejll5JM8qunCF0JrzlR1Q6oSEeqhRCPaS4a1VtklJZhJgiyrne4TJLfBNP8
         3z6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CO3mf/jnkrczlmLG3PkjYkNQp/y7QsJz9GFGn2qNDY0=;
        b=ub3JW5lN2ko4J6pzGCmAVD6iJENspKj8OeuCb8uL2rGU5QNxp7ijDRC3oET0xnQOpZ
         lI01OEtiYyvPYoZ3lrAxd8H7Kg2doHzueUmH3s6v6SaZGB9lq0fdcBPI3IqCf4zLC7u/
         8evHR+FOwYoiwn+CNKa7BMiJEq+R+28a2HN7lrsvD008pvpjiPAnr4VdIJs2nScafKgq
         htrD1x4uOCbu14wdkMbd948Ly6E8WVoft0404vU9yq2GUpo4XQfZLFXJ7TFXdxExScgp
         iiEOkK+9LGcy7F05MoSmVvAzEnLx+4R2SWnKoCGUZYek+QkPFbs4oeNaXfKTqY3lFX9Q
         3ypQ==
X-Gm-Message-State: AOAM531EaVuE9AFcGrswWsRetwLJ0zOkEWOZZkpiowYUUrGjUjoiQSCc
        R3fL5l4/Km9gVUvGI1zbtUiuFg==
X-Google-Smtp-Source: ABdhPJxIqP8xjDQY1UCkWhxbJ9g6kciha8esJlIxf4q8TXOllBrcmh0K3GWdaS4Pskbj6ApU6Nz8Hg==
X-Received: by 2002:a17:907:3e12:: with SMTP id hp18mr10044447ejc.366.1616686201026;
        Thu, 25 Mar 2021 08:30:01 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id b18sm2574837ejb.77.2021.03.25.08.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:30:00 -0700 (PDT)
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
Subject: [PATCH for-rc 13/24] block/rnbd-clt: Replace {NO_WAIT,WAIT} with RTRS_PERMIT_{WAIT,NOWAIT}
Date:   Thu, 25 Mar 2021 16:29:00 +0100
Message-Id: <20210325152911.1213627-14-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
References: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
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
index fce0f345f796..1a1c57b51fd8 100644
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
+			(void)send_msg_close(dev, device_id, RTRS_PERMIT_NOWAIT);
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

