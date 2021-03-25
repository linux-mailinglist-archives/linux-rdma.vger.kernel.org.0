Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0A83495AA
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhCYPdx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhCYPd0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:33:26 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAB0C06174A
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:26 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l4so3582924ejc.10
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8+kkQm9mBg+H60pZjUy0NQahnXWvcYZQ0FzB8htOQx8=;
        b=fAFI0J4Du/gg0VFGM6mMRVqUAINI3oX6VJwljiX7wFpipMfL9CbCz2SwU4SP7nx0+b
         /bK4huf1vurf75u/mTqBxasFdrBLpGD/aDW2RqIHv48IaNWcU6l+n8Qs+cEao6q68Cgp
         rmtZgMIR6Mv8Eaq5t5l2uP29v7X3TJI7JXPEHKWHObFCV3FhufVM54fx+SjcnntlQgBA
         S5yoPZrFxut/0SDVs4PpPfYwo+OgEjdGx+H6Pz2RKQphfgH8UqfYuBwHzSS2qeQN1xVH
         PqX+072qhYZannQJQsEQBpDAcZuaH8+yjhNNcBvP6LoT1plos3J3Hji+ycrgIMR0bupH
         ehMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8+kkQm9mBg+H60pZjUy0NQahnXWvcYZQ0FzB8htOQx8=;
        b=frHtjDGjV0JDRS+qkvR0aUB2FV27V7QUAF1HsQQNyqi0WUl2X+8jwVwemX5PLV7FoH
         OyHVT2QKUXb0BHUWveW7ktVRidk+psefP/KIWMOK/WwG8kdZNvzGE6VSXn+UAu8RpmKC
         f5kwnPHLZd7A7Erdd34EiXfG1K+G1XU8oiv3a+3f2+KVsC1zu/xtI0wurIDOEMnSnDoq
         UFwVWkzcCLMTw6eQr75acy2RDMwEtgW+iqMhXorRGsm3hE6nMkvPzXKzKuoeDkq6oUcB
         8QxXfylWzPiPAgXiGOfbhCE7ofug9jyTfvmKjTS28EfSdBkFlNpuG/xvwYPODJMtY7rF
         W59g==
X-Gm-Message-State: AOAM530PtvCTm9A4MhANvTJS2JlNYFtRiQGsafITcVx4ZcMkdb+wFJrA
        tQGp0x2A5JXXDKLBzRyV8YgozboP04RDSLcg
X-Google-Smtp-Source: ABdhPJyAepPcntNRX18y7Bq+WQ2tWHA+9/qV0hcjz/scaxlYy+g+d9Mm5EwZbiPwXarHDxABFf4euw==
X-Received: by 2002:a17:906:b318:: with SMTP id n24mr9920800ejz.372.1616686405165;
        Thu, 25 Mar 2021 08:33:25 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id n26sm2854750eds.22.2021.03.25.08.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:33:24 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 14/22] RDMA/rtrs-clt: Print more info when an error happens
Date:   Thu, 25 Mar 2021 16:33:00 +0100
Message-Id: <20210325153308.1214057-15-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

Client prints only error value and it is not enough for debugging.

1. When client receives an error from server:
the client does not only print the error value but also
more information of server connection.

2. When client failes to send IO:
the client gets an error from RDMA layer. It also
print more information of server connection.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 31 ++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 1519191d7154..a41864ec853d 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -440,6 +440,11 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 	req->in_use = false;
 	req->con = NULL;
 
+	if (unlikely(errno)) {
+		rtrs_err_rl(con->c.sess, "IO request failed: error=%d path=%s [%s:%u]\n",
+			    errno, kobject_name(&sess->kobj), sess->hca_name, sess->hca_port);
+	}
+
 	if (notify)
 		req->conf(req->priv, errno);
 }
@@ -1026,7 +1031,8 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 				       req->usr_len + sizeof(*msg),
 				       imm);
 	if (unlikely(ret)) {
-		rtrs_err(s, "Write request failed: %d\n", ret);
+		rtrs_err_rl(s, "Write request failed: error=%d path=%s [%s:%u]\n",
+			    ret, kobject_name(&sess->kobj), sess->hca_name, sess->hca_port);
 		if (sess->clt->mp_policy == MP_POLICY_MIN_INFLIGHT)
 			atomic_dec(&sess->stats->inflight);
 		if (req->sg_cnt)
@@ -1144,7 +1150,8 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
 	ret = rtrs_post_send_rdma(req->con, req, &sess->rbufs[buf_id],
 				   req->data_len, imm, wr);
 	if (unlikely(ret)) {
-		rtrs_err(s, "Read request failed: %d\n", ret);
+		rtrs_err_rl(s, "Read request failed: error=%d path=%s [%s:%u]\n",
+			    ret, kobject_name(&sess->kobj), sess->hca_name, sess->hca_port);
 		if (sess->clt->mp_policy == MP_POLICY_MIN_INFLIGHT)
 			atomic_dec(&sess->stats->inflight);
 		req->need_inv = false;
@@ -2465,12 +2472,28 @@ static int init_sess(struct rtrs_clt_sess *sess)
 	mutex_lock(&sess->init_mutex);
 	err = init_conns(sess);
 	if (err) {
-		rtrs_err(sess->clt, "init_conns(), err: %d\n", err);
+		char str[NAME_MAX];
+		int err;
+		struct rtrs_addr path = {
+			.src = &sess->s.src_addr,
+			.dst = &sess->s.dst_addr,
+		};
+		rtrs_addr_to_str(&path, str, sizeof(str));
+		rtrs_err(sess->clt, "init_conns() failed: err=%d path=%s [%s:%u]\n",
+			 err, str, sess->hca_name, sess->hca_port);
 		goto out;
 	}
 	err = rtrs_send_sess_info(sess);
 	if (err) {
-		rtrs_err(sess->clt, "rtrs_send_sess_info(), err: %d\n", err);
+		char str[NAME_MAX];
+		int err;
+		struct rtrs_addr path = {
+			.src = &sess->s.src_addr,
+			.dst = &sess->s.dst_addr,
+		};
+		rtrs_addr_to_str(&path, str, sizeof(str));
+		rtrs_err(sess->clt, "rtrs_send_sess_info() failed: err=%d path=%s [%s:%u]\n",
+			 err, str, sess->hca_name, sess->hca_port);
 		goto out;
 	}
 	rtrs_clt_sess_up(sess);
-- 
2.25.1

