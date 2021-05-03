Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD67371485
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 13:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhECLtY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 07:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbhECLtX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 07:49:23 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CA1C06174A
        for <linux-rdma@vger.kernel.org>; Mon,  3 May 2021 04:48:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r9so7404152ejj.3
        for <linux-rdma@vger.kernel.org>; Mon, 03 May 2021 04:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xii0S/iziW0WNUb3W/LUH3djvpI4vadbCj4/x9QRIjY=;
        b=Zzw/JoTctOHRH4cIbSh8B2yYl9A7ANFbS8nfN554LotBmePLbArSPiUjdw9K9ZR0KC
         kL1lYwM1qhC/bKH8OGg4b87k8b77ucBmdI4vHguaxO0iuP5zpu+ct4c2qJomc7n33/K7
         yW4k6DWP7bBwWMIxxmOW/d+g0arCzpAqeEiYvpGC5V5pnlrNSRutJzlltO6I6GdOONq1
         C2sGt9/2CQOQ9Q4VxML3ZpimYMg1VdstLw8o29bgIz7oSuwc3k3kJfVljRBv/GzuoNFo
         ZTKulbPs/4C1kfjcwplBLo6w4rx6nvMjg3msVO02nCOa/N9qdTGWKIo4rieCvSiJrJ5/
         TgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xii0S/iziW0WNUb3W/LUH3djvpI4vadbCj4/x9QRIjY=;
        b=BFFvsr2yHb/lDLLKJPBmBJTpgn/X4Klu0hSxi0AYfW8lJdIRnPGcZ/N+ryw+RYBdku
         hld5/946X4qwARHBAne83Pl9JCS8+wpkNB30KzythJ5C7P/QS8DFVH8xqqzd2pjFkEOA
         H8So1MQ2dgsAvuiX8aoxdkuIe95U8ErYM1gmOIkhw9pthVPdNUtBuBRQxn2sDOx+8YW7
         NyAgLdMM5RyoqWNvkPyWMZucO7G1VV1i0BK/eZJ7mBi2MVcK/hek6ia7osJ2uFN42Fga
         maX8m5F+R3fpV4kDkN+HSTqCBvKktO7ZAypT5HbsUfEHgiZ4hxqn957FABc72q6KQQ33
         pYMQ==
X-Gm-Message-State: AOAM531A/zSOU+JCdaDN0Psx/0OK06JF55kuj8MhliU5IPreK+lQQvYx
        SDBYQOAJQL7JOtmYXtJ3zPjgHQPPPXy5/w==
X-Google-Smtp-Source: ABdhPJwEsjhCytAj4i7/giFNBLoNUejUlq0Qt6NBPjvxJvfdzJRLpzzWTrFRzMD7Pd0/fMM5SGOaMw==
X-Received: by 2002:a17:906:8307:: with SMTP id j7mr15878419ejx.420.1620042508679;
        Mon, 03 May 2021 04:48:28 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id z12sm7307705ejd.83.2021.05.03.04.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:48:28 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 11/20] RDMA/rtrs-srv: Kill __rtrs_srv_change_state
Date:   Mon,  3 May 2021 13:48:09 +0200
Message-Id: <20210503114818.288896-12-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503114818.288896-1-gi-oh.kim@ionos.com>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

No need since the only user is rtrs_srv_change_state.

Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index afa63f06586b..54a29285240d 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -67,13 +67,13 @@ static inline struct rtrs_srv_sess *to_srv_sess(struct rtrs_sess *s)
 	return container_of(s, struct rtrs_srv_sess, s);
 }
 
-static bool __rtrs_srv_change_state(struct rtrs_srv_sess *sess,
-				     enum rtrs_srv_state new_state)
+static bool rtrs_srv_change_state(struct rtrs_srv_sess *sess,
+				  enum rtrs_srv_state new_state)
 {
 	enum rtrs_srv_state old_state;
 	bool changed = false;
 
-	lockdep_assert_held(&sess->state_lock);
+	spin_lock_irq(&sess->state_lock);
 	old_state = sess->state;
 	switch (new_state) {
 	case RTRS_SRV_CONNECTED:
@@ -94,17 +94,6 @@ static bool __rtrs_srv_change_state(struct rtrs_srv_sess *sess,
 	}
 	if (changed)
 		sess->state = new_state;
-
-	return changed;
-}
-
-static bool rtrs_srv_change_state(struct rtrs_srv_sess *sess,
-				   enum rtrs_srv_state new_state)
-{
-	bool changed;
-
-	spin_lock_irq(&sess->state_lock);
-	changed = __rtrs_srv_change_state(sess, new_state);
 	spin_unlock_irq(&sess->state_lock);
 
 	return changed;
-- 
2.25.1

