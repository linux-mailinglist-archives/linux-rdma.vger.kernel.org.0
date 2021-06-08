Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD11B39F533
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 13:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbhFHLif (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 07:38:35 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:35493 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhFHLie (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 07:38:34 -0400
Received: by mail-ej1-f53.google.com with SMTP id h24so32115296ejy.2
        for <linux-rdma@vger.kernel.org>; Tue, 08 Jun 2021 04:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BCO67ATEZhiNryCOj59nf1QjZjzBte/L5fuaPWdfrQ=;
        b=BGTVO6mDBuZnoYaVUKIHXcSc8Vrb4lBm3qod/BQ6hyFkYXZh/WfbGla0L2mdfIu4Ae
         4Naysng+VysCgNLSJJJH212xvSDSSU/aCGLUwUFKKa/r6qjxlLowoUKvJN2kC72fIZHB
         dVWWVFzjgwZjuPbJSE0GNy35eBsDXrVLic8QnfE8JG897jTvENT0jf20IB4Ni2BG+rDC
         FQKa6DwA7cWEMgr62vqmjtcsIdn3fzjhSOAc8gHkjO0BefpgJzlr1Lt22RAqhqCJJP9F
         U85CGuHsHWt5+QpU9lJlJZgSqoqxakdZLAWyEa17V6JxbOlSjgvdZUk0gBGPvK+imnwe
         cjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BCO67ATEZhiNryCOj59nf1QjZjzBte/L5fuaPWdfrQ=;
        b=cE9M8lp7HRrRiwhgG9XjmQ5B+cqRuH4qB7BhxqgpHabgaqIXSTGD+Mb4peVPb1LIYN
         dG1kEKnamTwCMLXUAqFRedhUPF4NZ/tGsFdRysv1fAS0BrJaKuHDN/H70h/3IakMVWIO
         lbeUo3Hse+KCwvUcnH7I+jNukDafh7QgRKWGn1E/j5XUe7DfSkAP1e0Z7ksy0y7iJ9ro
         gnwAvXWHuH2TKF74A+l4rDvGWJ0bud8wdXNhT1uK77WJjZhCnPzslJTmir8cVBBg+U06
         opDSRBRYkJLaapfezgA1ObocciIvMm6ou3XVAQ/W+8jX3Su5lv7TI9ZX84VE9P97o4bt
         Kvwg==
X-Gm-Message-State: AOAM532VGe3cnIKTCi4YFLsk95qan16VUv7E8tJikGJ0rEaHL/4fWG7W
        rZ5O4MP4yHZNDC+pzQjlFYVaXaagh3Ofeg==
X-Google-Smtp-Source: ABdhPJxf5TFfm9zLHVvDenhAwQ1SwX2PlMTTey7M8zdHaIgx8FaXY5yMhdJVS7jp2J9CZg85FEFxtA==
X-Received: by 2002:a17:906:8608:: with SMTP id o8mr23086028ejx.72.1623152140340;
        Tue, 08 Jun 2021 04:35:40 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4943:5b00:2927:a608:b264:d770])
        by smtp.gmail.com with ESMTPSA id c7sm7675480ejs.26.2021.06.08.04.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 04:35:40 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        axboe@kernel.dk, Jack Wang <jinpu.wang@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH for-next 4/5] RDMA/rtrs-clt: Raise MAX_SEGMENTS
Date:   Tue,  8 Jun 2021 13:35:35 +0200
Message-Id: <20210608113536.42965-5-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608113536.42965-1-jinpu.wang@ionos.com>
References: <20210608113536.42965-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

As we can do fast memory registration on write, we can increase
the max_segments, default to 512K.

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index af738e7e1396..721ed0b5ae70 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -32,6 +32,8 @@
 #define RTRS_RECONNECT_SEED 8
 
 #define FIRST_CONN 0x01
+/* limit to 128 * 4k = 512k max IO */
+#define RTRS_MAX_SEGMENTS          128
 
 MODULE_DESCRIPTION("RDMA Transport Client");
 MODULE_LICENSE("GPL");
@@ -1545,7 +1547,7 @@ static struct rtrs_clt_sess *alloc_sess(struct rtrs_clt *clt,
 		       rdma_addr_size((struct sockaddr *)path->src));
 	strscpy(sess->s.sessname, clt->sessname, sizeof(sess->s.sessname));
 	sess->clt = clt;
-	sess->max_pages_per_mr = max_segments;
+	sess->max_pages_per_mr = RTRS_MAX_SEGMENTS;
 	init_waitqueue_head(&sess->state_wq);
 	sess->state = RTRS_CLT_CONNECTING;
 	atomic_set(&sess->connected_cnt, 0);
@@ -2694,7 +2696,7 @@ static struct rtrs_clt *alloc_clt(const char *sessname, size_t paths_num,
 	clt->paths_up = MAX_PATHS_NUM;
 	clt->port = port;
 	clt->pdu_sz = pdu_sz;
-	clt->max_segments = max_segments;
+	clt->max_segments = RTRS_MAX_SEGMENTS;
 	clt->reconnect_delay_sec = reconnect_delay_sec;
 	clt->max_reconnect_attempts = max_reconnect_attempts;
 	clt->priv = priv;
-- 
2.25.1

