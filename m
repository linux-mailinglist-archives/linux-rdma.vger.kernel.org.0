Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB4B371483
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 13:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhECLtW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 07:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbhECLtV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 07:49:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A597C06174A
        for <linux-rdma@vger.kernel.org>; Mon,  3 May 2021 04:48:28 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y26so5924147eds.4
        for <linux-rdma@vger.kernel.org>; Mon, 03 May 2021 04:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AsOLe37N5znL2LIGR5NZpMMy/fBT3bZJkmUhhMqrF1U=;
        b=h3S8SMS9E/9HUPefDA3pn0AT8ss4ufjJveY8qp18fxX0xSpe1mB92psmzpKonnVNU0
         RgkMpyliAfepjxDPPOH7PSjyv61HxKzv+H1nf29HYkHWdxOUQItZ9BBgAVjscRSG6+5z
         jt1J2Elx86qKYO1P+y6SVN2bI+NttpOo10RGD1Xit6uDs/XVCkVXsCMCL8Lzx7+Olt/9
         mnHcpAMq8iBgn8NIyt5sbY4AORnRexGq+5daHD0SVqY1hLfKuv6zW+xoJjAXkOXrJD6i
         LMss30xrtFhZOZzhudb5OL1WwmoVSJq1TaaTWiHq5KUCUYm/fGmS+0G1JRvKxk19rSBD
         U11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AsOLe37N5znL2LIGR5NZpMMy/fBT3bZJkmUhhMqrF1U=;
        b=FkJh6uNNjazFUEnH+Eo1AzmGu6xra2huf8iAMUHapMPlu3CaudU+B/iVz8UyqXPn2R
         9iVaxP7z/kH5OOX1iy3y60O1QBp84LBd5eNmKuuCR8BKoc/aWlaHwhtuo2pBc7G+Q9Pr
         DPF/Kzyup5kbpx8iKHJgVjNcc1WQ3E2ZReTAErLKYuegLnZjCAqF4hAOTw8124yZJju1
         UMRN7rCiW+92YzolNJFJRS5s2s59TDTGDIhpteg9kJdJW0UDVMBzsnwS97PkU+sozeia
         QW3orpNt5OS6AfGxxZaLEtM6OvA+AubdEMsOgw8srSUt6SeSwR22ksPuFLcZGTYAohUP
         9Bvw==
X-Gm-Message-State: AOAM531TEIJ0sgbNEhf6NKAbg/h3ed3BXlaemgWqKggcUqASjl4zs3Bb
        sNHhgFg7ZlR6tqBpN7QVTDyY+Mjs4OsoXA==
X-Google-Smtp-Source: ABdhPJwseVk6l9vdQ6uYMGFCCAbQVvkPcXV8Dj0NZvHWbpqIx137ywiVuys+Vm4ietF60SvmSa56qQ==
X-Received: by 2002:a05:6402:4403:: with SMTP id y3mr9492692eda.369.1620042506680;
        Mon, 03 May 2021 04:48:26 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id z12sm7307705ejd.83.2021.05.03.04.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:48:26 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>,
        Dima Stepanov <dmitrii.stepanov@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 08/20] RDMA/rtrs: Use strscpy instead of strlcpy
Date:   Mon,  3 May 2021 13:48:06 +0200
Message-Id: <20210503114818.288896-9-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503114818.288896-1-gi-oh.kim@ionos.com>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
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
index 0c828ea0f500..5ba87862a251 100644
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
@@ -2638,7 +2638,7 @@ static struct rtrs_clt *alloc_clt(const char *sessname, size_t paths_num,
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

