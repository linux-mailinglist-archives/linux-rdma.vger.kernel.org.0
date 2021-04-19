Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2FF363CC9
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Apr 2021 09:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbhDSHid (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Apr 2021 03:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbhDSHic (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Apr 2021 03:38:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6DDC061763
        for <linux-rdma@vger.kernel.org>; Mon, 19 Apr 2021 00:38:02 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r20so1565117ejo.11
        for <linux-rdma@vger.kernel.org>; Mon, 19 Apr 2021 00:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Ol0LrZCvE5dH2E8oH5l2wl0+ueRQwWjooW1k9QXypo=;
        b=RbMBNs3DQD+nVFI3O/iNsYrbO54hOcK3wJUpUoyj0gaHGQ6W03fNF/7E08xbBqyV2n
         CXxz5UrCPHClPBFtYNYKYHAeEjiZ0fvhWtpKG/091bF0WngU/mgYa99FkKAGxyfDXJJ4
         aU8k/Yp6072rItlde2dXiS4fc+D4BBAAhEiB5s6tPrtGqm6LZdpUsxLprcVyQsVE2SKr
         8qc6wVWZ9Q2Y03kzlUGN3K/bQTPeX2P9spvhECgKMw8dzeBk2liY7Of0DbreVgjJ1lo3
         nwQRPR5cGdWvZuhrLq6HHxwZC0uA5aruYQG/PX2PHsTI3ONWek6fRFMkVlVwavulm048
         tfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Ol0LrZCvE5dH2E8oH5l2wl0+ueRQwWjooW1k9QXypo=;
        b=tPkNPZoSTi63norgRvHLuKwfrnp3RCMrx1SEviBTOrzTIiNa15FNkW7w0sc1+UrkOe
         28Zgf/hkZVFN+NluQLXbwkMp58kv3H0yDeOgXyv09o0jIKvm1vZXe/t4OJzrPRt+jDkr
         IPJip092zOeocyx6YKwy7iBH30XCCsgu8njMkminVyVLOAo+/Zu7qPdRl9qn71B1TXB4
         H2eNPHZ+eUCjGjsKPRY+wh8LlAD477047IzSdUQnBag+xLnZoX0CXyMVyp0RlVnuT6d2
         oQgzZSMqPFa0xWuVtb15jp4BqfOOab5LLmJ99jzgAa+3bepoTROycAQrmjj33DDnM9Se
         nfzQ==
X-Gm-Message-State: AOAM5317NWpkAtokASaJPNnI6NcQLT8bOy8eRzUvb2VDRoT8doZfdmLz
        dtfgHvnUSHUiK7fzrXrKps12FsmEvdoVWVTz
X-Google-Smtp-Source: ABdhPJyVCfyNTKITacxmTNiOaR3AEHgee/Ayc4fmmxjdpSH+cSNUMHPuXK/3iQeILvQ8LAlXgD5IrQ==
X-Received: by 2002:a17:906:7c52:: with SMTP id g18mr20246722ejp.362.1618817881516;
        Mon, 19 Apr 2021 00:38:01 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id g22sm8701833ejz.46.2021.04.19.00.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:38:01 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     axboe@kernel.dk, akinobu.mita@gmail.com, corbet@lwn.net,
        hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org,
        Aleksei Marov <aleksei.marov@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCHv5 for-next 15/19] block/rnbd-srv: Remove unused arguments of rnbd_srv_rdma_ev
Date:   Mon, 19 Apr 2021 09:37:18 +0200
Message-Id: <20210419073722.15351-16-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419073722.15351-1-gi-oh.kim@ionos.com>
References: <20210419073722.15351-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

struct rtrs_srv is not used when handling rnbd_srv_rdma_ev messages, so
cleaned up
rdma_ev function pointer in rtrs_srv_ops also is changed.

Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Aleksei Marov <aleksei.marov@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Acked-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/block/rnbd/rnbd-srv.c          | 39 ++++++++++----------------
 drivers/infiniband/ulp/rtrs/rtrs-srv.c |  4 +--
 drivers/infiniband/ulp/rtrs/rtrs.h     |  3 +-
 3 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index a9bb414f7442..abacd9ef10d6 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -114,8 +114,7 @@ rnbd_get_sess_dev(int dev_id, struct rnbd_srv_session *srv_sess)
 	return sess_dev;
 }
 
-static int process_rdma(struct rtrs_srv *sess,
-			struct rnbd_srv_session *srv_sess,
+static int process_rdma(struct rnbd_srv_session *srv_sess,
 			struct rtrs_srv_op *id, void *data, u32 datalen,
 			const void *usr, size_t usrlen)
 {
@@ -344,8 +343,7 @@ void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev,
 	mutex_unlock(&sess->lock);
 }
 
-static int process_msg_close(struct rtrs_srv *rtrs,
-			     struct rnbd_srv_session *srv_sess,
+static int process_msg_close(struct rnbd_srv_session *srv_sess,
 			     void *data, size_t datalen, const void *usr,
 			     size_t usrlen)
 {
@@ -364,20 +362,18 @@ static int process_msg_close(struct rtrs_srv *rtrs,
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
@@ -391,19 +387,16 @@ static int rnbd_srv_rdma_ev(struct rtrs_srv *rtrs, void *priv,
 
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
@@ -656,8 +649,7 @@ static char *rnbd_srv_get_full_path(struct rnbd_srv_session *srv_sess,
 	return full_path;
 }
 
-static int process_msg_sess_info(struct rtrs_srv *rtrs,
-				 struct rnbd_srv_session *srv_sess,
+static int process_msg_sess_info(struct rnbd_srv_session *srv_sess,
 				 const void *msg, size_t len,
 				 void *data, size_t datalen)
 {
@@ -698,8 +690,7 @@ find_srv_sess_dev(struct rnbd_srv_session *srv_sess, const char *dev_name)
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
index f891fbe7abe6..b0f56ffeff88 100644
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

