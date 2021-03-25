Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D168B349575
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhCYPab (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhCYPaI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:30:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56ADC061761
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:30:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u5so3589683ejn.8
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+wNTS4XPUWn/jF7E63ntoE+HOXhLVAf70pg15ObO2xg=;
        b=PhpreFigF0UkWO4Tka15xmBMkCgXUs9EM+pPVizfLYJyOb7FKZ36ZhSLq9Z0q2YeWH
         e4l9wo55GDTFajCTZC3UkJHnZyPF+i8MiAUSlXoIZ5OPSXGftkDrBcSnPQwJqtEToct4
         irH1ZLZ5wysG3OpU4EEfumCx4fMRzltRJw0TeVwvpvulAiG1Wq+0bTq0afUHxflEqr1M
         CiWO0nWzySRarL2m3mKZZfMgq4A/mdER+wBPZYAc5ABoMpMi94l53OvZDMbuIUw4JoPE
         MqIFq9Zzz+CgbJRJ6UMkBjN05CGzb2Rxg5yV9/FiQsnRecdAE5DpvgcLxSg45neG9Ua8
         4cqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+wNTS4XPUWn/jF7E63ntoE+HOXhLVAf70pg15ObO2xg=;
        b=UFJbRFi41EShGF+iUqIIVzGziuLr50urNhI78h3Hwj2V78KLS+uW2Lau8AgVa80iou
         2TRQdVgMFOduqWV6bPfkn2IU+yKo4I8mSCSoPHdyLgQLHINvzNf7QVxHRLprsV8Ulvyj
         AsK5MG/+L//9if6gs2q5xdSEyWEaeEEmQ/lhixIW51REl2Ly2f9o1t7nKxNabhOkXl8I
         0We43r7q7dygjHdYRRx8sFOQ/G1LirZwuSSBt1Iz9cUR70LUlXjkM0it7tpr8yYUnfKv
         a1E1xLrijvNaGICfOutFTHXzw3OMCX+ESBqaaFmcd6C7sXKdBdqqoBIY8PC/UtJUuazU
         4wAA==
X-Gm-Message-State: AOAM532VLusI3aQMZnNFXtOIaIbciPyC2HRCw3b1405jAu1TVxoSNbwm
        5SzKpXxYVnA9r2BY57WSYAXEwg==
X-Google-Smtp-Source: ABdhPJyW65blJT3YBI+wjtVxTOAd2w+Udic8e8nvfNaJEnmhmxgfVc0ijHAo/KNh1b+udd8RGk6KXA==
X-Received: by 2002:a17:906:5d05:: with SMTP id g5mr10011179ejt.489.1616686206220;
        Thu, 25 Mar 2021 08:30:06 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id b18sm2574837ejb.77.2021.03.25.08.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:30:06 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org,
        Aleksei Marov <aleksei.marov@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-rc 20/24] block/rnbd-srv: Remove unused arguments of rnbd_srv_rdma_ev
Date:   Thu, 25 Mar 2021 16:29:07 +0100
Message-Id: <20210325152911.1213627-21-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
References: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

struct rtrs_srv is not used when handling rnbd_srv_rdma_ev messages, so
cleaned up
rdma_ev function pointer in rtrs_srv_ops also is changed.

Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Aleksei Marov <aleksei.marov@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/block/rnbd/rnbd-srv.c          | 39 ++++++++++----------------
 drivers/infiniband/ulp/rtrs/rtrs-srv.c |  4 +--
 drivers/infiniband/ulp/rtrs/rtrs.h     |  3 +-
 3 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index a71b6f7662f5..78bd0ce0ebf0 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -119,8 +119,7 @@ rnbd_get_sess_dev(int dev_id, struct rnbd_srv_session *srv_sess)
 	return sess_dev;
 }
 
-static int process_rdma(struct rtrs_srv *sess,
-			struct rnbd_srv_session *srv_sess,
+static int process_rdma(struct rnbd_srv_session *srv_sess,
 			struct rtrs_srv_op *id, void *data, u32 datalen,
 			const void *usr, size_t usrlen)
 {
@@ -350,8 +349,7 @@ void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev,
 	mutex_unlock(&sess->lock);
 }
 
-static int process_msg_close(struct rtrs_srv *rtrs,
-			     struct rnbd_srv_session *srv_sess,
+static int process_msg_close(struct rnbd_srv_session *srv_sess,
 			     void *data, size_t datalen, const void *usr,
 			     size_t usrlen)
 {
@@ -370,20 +368,18 @@ static int process_msg_close(struct rtrs_srv *rtrs,
 	return 0;
 }
 
-static int process_msg_open(struct rtrs_srv *rtrs,
-			    struct rnbd_srv_session *srv_sess,
+static int process_msg_open(struct rnbd_srv_session *srv_sess,
 			    const void *msg, size_t len,
 			    void *data, size_t datalen);
 
-static int process_msg_sess_info(struct rtrs_srv *rtrs,
-				 struct rnbd_srv_session *srv_sess,
+static int process_msg_sess_info(struct rnbd_srv_session *srv_sess,
 				 const void *msg, size_t len,
 				 void *data, size_t datalen);
 
-static int rnbd_srv_rdma_ev(struct rtrs_srv *rtrs, void *priv,
-			     struct rtrs_srv_op *id, int dir,
-			     void *data, size_t datalen, const void *usr,
-			     size_t usrlen)
+static int rnbd_srv_rdma_ev(void *priv,
+			    struct rtrs_srv_op *id, int dir,
+			    void *data, size_t datalen, const void *usr,
+			    size_t usrlen)
 {
 	struct rnbd_srv_session *srv_sess = priv;
 	const struct rnbd_msg_hdr *hdr = usr;
@@ -397,19 +393,16 @@ static int rnbd_srv_rdma_ev(struct rtrs_srv *rtrs, void *priv,
 
 	switch (type) {
 	case RNBD_MSG_IO:
-		return process_rdma(rtrs, srv_sess, id, data, datalen, usr,
-				    usrlen);
+		return process_rdma(srv_sess, id, data, datalen, usr, usrlen);
 	case RNBD_MSG_CLOSE:
-		ret = process_msg_close(rtrs, srv_sess, data, datalen,
-					usr, usrlen);
+		ret = process_msg_close(srv_sess, data, datalen, usr, usrlen);
 		break;
 	case RNBD_MSG_OPEN:
-		ret = process_msg_open(rtrs, srv_sess, usr, usrlen,
-				       data, datalen);
+		ret = process_msg_open(srv_sess, usr, usrlen, data, datalen);
 		break;
 	case RNBD_MSG_SESS_INFO:
-		ret = process_msg_sess_info(rtrs, srv_sess, usr, usrlen,
-					    data, datalen);
+		ret = process_msg_sess_info(srv_sess, usr, usrlen, data,
+					    datalen);
 		break;
 	default:
 		pr_warn("Received unexpected message type %d with dir %d from session %s\n",
@@ -662,8 +655,7 @@ static char *rnbd_srv_get_full_path(struct rnbd_srv_session *srv_sess,
 	return full_path;
 }
 
-static int process_msg_sess_info(struct rtrs_srv *rtrs,
-				 struct rnbd_srv_session *srv_sess,
+static int process_msg_sess_info(struct rnbd_srv_session *srv_sess,
 				 const void *msg, size_t len,
 				 void *data, size_t datalen)
 {
@@ -704,8 +696,7 @@ find_srv_sess_dev(struct rnbd_srv_session *srv_sess, const char *dev_name)
 	return NULL;
 }
 
-static int process_msg_open(struct rtrs_srv *rtrs,
-			    struct rnbd_srv_session *srv_sess,
+static int process_msg_open(struct rnbd_srv_session *srv_sess,
 			    const void *msg, size_t len,
 			    void *data, size_t datalen)
 {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index d071809e3ed2..f7aa2a7e7442 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -998,7 +998,7 @@ static void process_read(struct rtrs_srv_con *con,
 	usr_len = le16_to_cpu(msg->usr_len);
 	data_len = off - usr_len;
 	data = page_address(srv->chunks[buf_id]);
-	ret = ctx->ops.rdma_ev(srv, srv->priv, id, READ, data, data_len,
+	ret = ctx->ops.rdma_ev(srv->priv, id, READ, data, data_len,
 			   data + data_len, usr_len);
 
 	if (unlikely(ret)) {
@@ -1051,7 +1051,7 @@ static void process_write(struct rtrs_srv_con *con,
 	usr_len = le16_to_cpu(req->usr_len);
 	data_len = off - usr_len;
 	data = page_address(srv->chunks[buf_id]);
-	ret = ctx->ops.rdma_ev(srv, srv->priv, id, WRITE, data, data_len,
+	ret = ctx->ops.rdma_ev(srv->priv, id, WRITE, data, data_len,
 			   data + data_len, usr_len);
 	if (unlikely(ret)) {
 		rtrs_err_rl(s,
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.h b/drivers/infiniband/ulp/rtrs/rtrs.h
index eb050738cda1..c25a0fd8a607 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs.h
@@ -139,7 +139,6 @@ struct rtrs_srv_ops {
 	 *			message for the data transfer will be sent to
 	 *			the client.
 
-	 *	@sess:		Session
 	 *	@priv:		Private data set by rtrs_srv_set_sess_priv()
 	 *	@id:		internal RTRS operation id
 	 *	@dir:		READ/WRITE
@@ -153,7 +152,7 @@ struct rtrs_srv_ops {
 	 *	@usr:		The extra user message sent by the client (%vec)
 	 *	@usrlen:	Size of the user message
 	 */
-	int (*rdma_ev)(struct rtrs_srv *sess, void *priv,
+	int (*rdma_ev)(void *priv,
 		       struct rtrs_srv_op *id, int dir,
 		       void *data, size_t datalen, const void *usr,
 		       size_t usrlen);
-- 
2.25.1

