Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293F83941C7
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 13:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbhE1LcK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 07:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbhE1LcE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 07:32:04 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E04C06138A
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:27 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g7so4478406edm.4
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hh/MJDuFEwUB9dA5kYACQ+u+GKMwUN2JMjjZ9Bs+lqc=;
        b=RPIir6Oe2gH1uPEmPZ3pKTSKmoINnAP0qu4aVbLuTHcNtxiID1LBKPo3Aba9JsUjEo
         cNw6rrgQ/NeKA6eQikcg89llNcex0McPaIjy39iY4pcvrxkgyTMHJlWSRClwmstCH7Pm
         WF7ijyj/EEAWnFJxR1Q5xicHkRP4BaKY5XP2s0UILNPa7ijqrtgRxfltAfMNQKVuHSU9
         Ymsg4iPQD452PVIfagBcMARe0SxoxtpM9OVxhHIuz6EavpTp0ERZ4UDq1+6zvE7S3mz7
         8SYITr5OboTWnuKZJmRro+0wzf7GNv337bCjc4ijXHzfMvsWT9io+Use3MKKfrar8zqa
         Nm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hh/MJDuFEwUB9dA5kYACQ+u+GKMwUN2JMjjZ9Bs+lqc=;
        b=mX3RsTUyP8vVGHIFfTaJIXke6y7Aqom5PilrRYk4iZb25yibDvaqrPLHHZUhxZtYXx
         wtaJa5FMaB1pA3WywNf77SFEfHck8xzWe3CcSZY+x8yrFUVU/g6+YLoVvT5VtyvFDLEd
         TG0X5GL5lWilW4hIQ2uFutfJy30ZUm6I86xj75yOEePFLiot8vz9EZzftHt89H/sez5X
         mmepA8KZIKHKGct5/HYcNXm3UAel5aYHXQvSB/VQLv22D9FB6tsOk/pibYtEnoLp9Spk
         RHcrkHDQmaeqWGXQMSPhRwUofePuZOBxEclahyYraMfgfWy0NLRjrpmTms2dMqGHpdy6
         yV5A==
X-Gm-Message-State: AOAM531vs722FekkelRb0GjSOPIrwpbIcrfg1TpZOATCU6uhC9Fm/E00
        ybzqveu4bpwWJT69XVRHgQUt6T6oRgQxuw==
X-Google-Smtp-Source: ABdhPJzWsUQ3h3twD/8/Grh1K/GwAKMmav20IrxtH06YdjnWKAEmtKEzYxgGj8usuzf/UX2A7HchhA==
X-Received: by 2002:a05:6402:134d:: with SMTP id y13mr9382959edw.287.1622201425698;
        Fri, 28 May 2021 04:30:25 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:497d:7d00:983b:122a:4685:3849])
        by smtp.gmail.com with ESMTPSA id p15sm2594578edr.50.2021.05.28.04.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:30:25 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>,
        Dima Stepanov <dmitrii.stepanov@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 07/20] RDMA/rtrs: Use strscpy instead of strlcpy
Date:   Fri, 28 May 2021 13:30:05 +0200
Message-Id: <20210528113018.52290-8-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528113018.52290-1-jinpu.wang@ionos.com>
References: <20210528113018.52290-1-jinpu.wang@ionos.com>
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
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 4 ++--
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 97fa9da4dde4..f2005e57ea53 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1505,7 +1505,7 @@ static struct rtrs_clt_sess *alloc_sess(struct rtrs_clt *clt,
 	if (path->src)
 		memcpy(&sess->s.src_addr, path->src,
 		       rdma_addr_size((struct sockaddr *)path->src));
-	strlcpy(sess->s.sessname, clt->sessname, sizeof(sess->s.sessname));
+	strscpy(sess->s.sessname, clt->sessname, sizeof(sess->s.sessname));
 	sess->clt = clt;
 	sess->max_pages_per_mr = max_segments;
 	init_waitqueue_head(&sess->state_wq);
@@ -2652,7 +2652,7 @@ static struct rtrs_clt *alloc_clt(const char *sessname, size_t paths_num,
 	clt->priv = priv;
 	clt->link_ev = link_ev;
 	clt->mp_policy = MP_POLICY_MIN_INFLIGHT;
-	strlcpy(clt->sessname, sessname, sizeof(clt->sessname));
+	strscpy(clt->sessname, sessname, sizeof(clt->sessname));
 	init_waitqueue_head(&clt->permits_wait);
 	mutex_init(&clt->paths_ev_mutex);
 	mutex_init(&clt->paths_mutex);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 5cfc2e3f9596..2ba6658c5e35 100644
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

