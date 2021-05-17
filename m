Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FF1382817
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 11:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbhEQJU4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 05:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235882AbhEQJUm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 05:20:42 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2824CC06138A
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id k14so4625925eji.2
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sau5iekBbmjCCggqbzRjsAgo7kkG9VsIP1EEGY5j7Zc=;
        b=Dw4pNwnsp4K/9S5lFpBS5A0i89eowUm+AEg0BtgBEy2s2qYVd1m0WI4q6GnFVU9DGM
         7hY+gtBhaKBqQwyTWO1HGMZRVKBnizS3ErCPbKak9IqupOiXUwRSZCFQzFoST14cmPSo
         2F1TZDn0zCwcjm1wk7p04uenIrPBq9B7zvK2aUCskf0eIHVnjbbPvsICtc1fn6IXDfE2
         oU0Adn1DO7zRt5Pd3sgebCJFV/Myb76E894zjV0ACH4NOTyi6S1rKyQ8IChqTGFfBrP7
         mo0S/QRTEjwGh1s6T5t6SjdvA7mxfpN2BRMTBCKtvq5LNKXILfHwd7dEOJHeZ5BEAUlP
         1S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sau5iekBbmjCCggqbzRjsAgo7kkG9VsIP1EEGY5j7Zc=;
        b=DQ7OEgKtWFzH8+DQFG/r6nIBawmh6CCiYyJ8LwYcdTjN2XTvgB46EAXUXsYYMRoxEb
         tDZxFdGLfi2AUyCvMdIA7WCzXA6HqnTN0Uch/9kEl1es+w187nfXuQncYWmrFREKG8Kl
         47XEIx5mjcE8ujvlYFLdUUh2zlpUTYMbmOuaaFkbU+3sWEG/l0eufP5pAI/YAGmyuFHT
         GDC0MUwwF6kGvCjwQt06Tzn38FrJILN5Zp+vI0906XWDlOpDDGQFCj7R4cOZQ3jGfaXh
         3AzIUwsuxy6nbeziU1lfYOBUhxnqSELeu1h/ZJpcOgXdkIMp5XWbza9qKsoz5mlz6bdL
         F7rQ==
X-Gm-Message-State: AOAM533qRiDetLd4fNzoJJ2d7MZIKSpzcsilCpWhpC6aTf1SoDNjJhbm
        kUiquLDeY7+6/Qw8y7SXqH3yLKhBWhYmFA==
X-Google-Smtp-Source: ABdhPJwnCZJDOstoqi7MS5V66nmYQ6U3gRLzmuC3aR8STpTtlzonoobTs43q8/0yf+OGj7DJ+oISGA==
X-Received: by 2002:a17:906:14c1:: with SMTP id y1mr63147656ejc.481.1621243160745;
        Mon, 17 May 2021 02:19:20 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id g10sm7925845ejd.109.2021.05.17.02.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:19:20 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>,
        Dima Stepanov <dmitrii.stepanov@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 07/19] RDMA/rtrs: Use strscpy instead of strlcpy
Date:   Mon, 17 May 2021 11:18:31 +0200
Message-Id: <20210517091844.260810-8-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517091844.260810-1-gi-oh.kim@ionos.com>
References: <20210517091844.260810-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>

During checkpatch analyzing the following warning message was found:
  WARNING:STRLCPY: Prefer strscpy over strlcpy - see:
  https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
Fix it by using strscpy calls instead of strlcpy.

Signed-off-by: Dima Stepanov <dmitrii.stepanov@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 4 ++--
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 930a1b496f84..a2505ea4a7a2 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1499,7 +1499,7 @@ static struct rtrs_clt_sess *alloc_sess(struct rtrs_clt *clt,
 	if (path->src)
 		memcpy(&sess->s.src_addr, path->src,
 		       rdma_addr_size((struct sockaddr *)path->src));
-	strlcpy(sess->s.sessname, clt->sessname, sizeof(sess->s.sessname));
+	strscpy(sess->s.sessname, clt->sessname, sizeof(sess->s.sessname));
 	sess->s.con_num = con_num;
 	sess->clt = clt;
 	sess->max_pages_per_mr = max_segments * max_segment_size >> 12;
@@ -2644,7 +2644,7 @@ static struct rtrs_clt *alloc_clt(const char *sessname, size_t paths_num,
 	clt->priv = priv;
 	clt->link_ev = link_ev;
 	clt->mp_policy = MP_POLICY_MIN_INFLIGHT;
-	strlcpy(clt->sessname, sessname, sizeof(clt->sessname));
+	strscpy(clt->sessname, sessname, sizeof(clt->sessname));
 	init_waitqueue_head(&clt->permits_wait);
 	mutex_init(&clt->paths_ev_mutex);
 	mutex_init(&clt->paths_mutex);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 02bc704667a8..afa63f06586b 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -780,7 +780,7 @@ static int process_info_req(struct rtrs_srv_con *con,
 	rwr = kcalloc(sess->mrs_num, sizeof(*rwr), GFP_KERNEL);
 	if (unlikely(!rwr))
 		return -ENOMEM;
-	strlcpy(sess->s.sessname, msg->sessname, sizeof(sess->s.sessname));
+	strscpy(sess->s.sessname, msg->sessname, sizeof(sess->s.sessname));
 
 	tx_sz  = sizeof(*rsp);
 	tx_sz += sizeof(rsp->desc[0]) * sess->mrs_num;
@@ -1261,7 +1261,7 @@ int rtrs_srv_get_sess_name(struct rtrs_srv *srv, char *sessname, size_t len)
 	list_for_each_entry(sess, &srv->paths_list, s.entry) {
 		if (sess->state != RTRS_SRV_CONNECTED)
 			continue;
-		strlcpy(sessname, sess->s.sessname,
+		strscpy(sessname, sess->s.sessname,
 		       min_t(size_t, sizeof(sess->s.sessname), len));
 		err = 0;
 		break;
@@ -1715,7 +1715,7 @@ static struct rtrs_srv_sess *__alloc_sess(struct rtrs_srv *srv,
 	path.src = &sess->s.src_addr;
 	path.dst = &sess->s.dst_addr;
 	rtrs_addr_to_str(&path, str, sizeof(str));
-	strlcpy(sess->s.sessname, str, sizeof(sess->s.sessname));
+	strscpy(sess->s.sessname, str, sizeof(sess->s.sessname));
 
 	sess->s.con_num = con_num;
 	sess->s.recon_cnt = recon_cnt;
-- 
2.25.1

