Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CA43552F9
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 13:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243397AbhDFL7Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 07:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343667AbhDFL7V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 07:59:21 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC034C06174A
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 04:59:13 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id f8so12199568edd.11
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 04:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RhfII4uebaH6tT/05RbvPjzOwPMCdkdRSsdMzeGMiNQ=;
        b=Sd+mAlKIW4jLAImX+lGmpcHRForqY/g0udSODs/255j9dArb0377taVTKcx7lI98m6
         J9r9XsZtohLsV6MVvmh+y3JBBebaI2JBU8EyAn94uCaLt8z49uVTa7wUJh16K3sE3gvf
         5d5+eFXwTKY8Uv6RDYIQPg52XPzHuA7EoedTJm9BrenA6rxUcMlrw30oTkuXDeLKgCe+
         CBDVcA92HYiNAvcYTBlDHfuKXaWsZMrqaAlwU8TzO2MWB747yc6pKrJ81YOlZ1dnhd/n
         m/kXJyV5YAMY4IW8kxRtitV9GoX8724zGIRqwtj4fDW4cfwtIvlTQnE48gf40vqRffmT
         k1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RhfII4uebaH6tT/05RbvPjzOwPMCdkdRSsdMzeGMiNQ=;
        b=gWJ84F9mpbuha0lven+FMWPM9jWds+qz10L9IECIjUkjxp2OoDc1n1vAm6LIBrQerD
         D0vswGdvQrEhB8irhsVK0BZUGKownIext+zd6hRw9uZ6SJDTHsS8RlvH/wTE8ewnrUxU
         2ZF0CWi0jmT0EePfewBJR7XaZd7zXmhfyutuorQBBxs3nN0sDRiCo9/Q6/zYUsL6FiHw
         JUETmTZy4PfkOmKtaNFr+F7aiU+WfQuCjBmtyYSafy35wfuNeK+5SaXyByzjMIe4YUQW
         JciOe8cxgZjW8vbLXs+MoqNPy8+K8VZ5CT023Ti9gGU+ksNUEqgmpFYV/Q1SIqr8C+W9
         Kp4g==
X-Gm-Message-State: AOAM531hprqArMOJlBKuH4dSE8IljPBjQgm3yuDKNjO9XjBaAmR0Wc8f
        gBWey4zs0O1rjuLPqQkv9yIp1tyzan+v+/Xx
X-Google-Smtp-Source: ABdhPJwwltMoppDwscxyG0UpbS/netHCgcttoKAZ6pfUDmbvOoa8q4fsj+MX9KEZZTO0z9PY1dZXag==
X-Received: by 2002:aa7:dc15:: with SMTP id b21mr37589618edu.350.1617710352443;
        Tue, 06 Apr 2021 04:59:12 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id da12sm3554954edb.34.2021.04.06.04.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 04:59:12 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH 1/3] RDMA/rtrs-clt: Print more info when an error happens
Date:   Tue,  6 Apr 2021 13:59:06 +0200
Message-Id: <20210406115908.197305-2-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406115908.197305-1-gi-oh.kim@ionos.com>
References: <20210406115908.197305-1-gi-oh.kim@ionos.com>
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
index 5062328ac577..bb10a0969e56 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -437,6 +437,11 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
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
@@ -1020,7 +1025,8 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 				       req->usr_len + sizeof(*msg),
 				       imm);
 	if (unlikely(ret)) {
-		rtrs_err(s, "Write request failed: %d\n", ret);
+		rtrs_err_rl(s, "Write request failed: error=%d path=%s [%s:%u]\n",
+			    ret, kobject_name(&sess->kobj), sess->hca_name, sess->hca_port);
 		if (sess->clt->mp_policy == MP_POLICY_MIN_INFLIGHT)
 			atomic_dec(&sess->stats->inflight);
 		if (req->sg_cnt)
@@ -1138,7 +1144,8 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
 	ret = rtrs_post_send_rdma(req->con, req, &sess->rbufs[buf_id],
 				   req->data_len, imm, wr);
 	if (unlikely(ret)) {
-		rtrs_err(s, "Read request failed: %d\n", ret);
+		rtrs_err_rl(s, "Read request failed: error=%d path=%s [%s:%u]\n",
+			    ret, kobject_name(&sess->kobj), sess->hca_name, sess->hca_port);
 		if (sess->clt->mp_policy == MP_POLICY_MIN_INFLIGHT)
 			atomic_dec(&sess->stats->inflight);
 		req->need_inv = false;
@@ -2459,12 +2466,28 @@ static int init_sess(struct rtrs_clt_sess *sess)
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

