Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182E42DD2D2
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 15:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgLQOUB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Dec 2020 09:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbgLQOUA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Dec 2020 09:20:00 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3442FC0617B0
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:20 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id j22so20121170eja.13
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8XPsxXHpszxd63HxIjgzTJhXEGSxw+1lsDSBnkcjABc=;
        b=TJvw/QhaoiXwTKVokg9Hn1muk2JMizYT+nn0x7X6ke3a6P+BbuZRkJU5uGDswuDiBk
         jTN/rekHr22C8C/vrL/iS6U+CVXuKxO8J/2atpqY5Fom7VGAe1lMd+/+IvG+5WV38wOH
         VAkcoW+6k7ZPuPrXyK1/FAnEbbvLC44AXe7q9f+cxlqOLzfgPdbWsYShXwMgcBc7A/Uz
         0+3B6rvDnJ7r7uOKiuZehwFsWzzzeepjIfJkiyAAILOynraBgme6Ey2wsixINcgvdN8o
         w+46p7sfxdC1dL7Jnc2UkxpYghl3BuDrD2aLQXoMYgh69/JHzvN6XhV+GGdYcPaeOOEN
         ATIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8XPsxXHpszxd63HxIjgzTJhXEGSxw+1lsDSBnkcjABc=;
        b=I7yZEQHBpURrtcKfdYxF9cBYrOlFPmWFUdPb1narDHlKFxpye23IhoSN3kzMBOFqC6
         KvabwIOROAR2w9UJJZ4S9dWFG7bG34NddWeBhJtIbYmCoR5at4hr+t+GNdbQsU5eg2+z
         tDuWkfibmx7jLaEq2pHHFyOGfouPBE/hqgnHbZLiDbBKhB/nVNtvhLOozA5S+/8nmLyD
         JhO4cpcQt2byYN1QkBLkOOv/pgXBtSmVEwO+mRimmKncZxaoQJfx+CX7Fn/yIykMBNm9
         5r7d3uT/mONblhZDSnCGEC/7rJ9PORnjgSFEMuNWBjYjTgQFp7nB1OlJtOxft//JWOUL
         afTw==
X-Gm-Message-State: AOAM532ckAeyI3e4MKt45Y4raw6ZZiUk1po07Bv3M28CaZK5Buv9ceZU
        vUnaczATOnuOAiBo9ZU2KRL6iE2GNqYsbw==
X-Google-Smtp-Source: ABdhPJzMRb3zcDBpp9SlBitAV1SRCChTVEnoBt9GmIaJpFJBtfRL+A004GOsFfr6GvnO3RqS84Ru5w==
X-Received: by 2002:a17:907:2052:: with SMTP id pg18mr3225734ejb.153.1608214758800;
        Thu, 17 Dec 2020 06:19:18 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4991:de00:e5a4:2f4d:99:ddc5])
        by smtp.gmail.com with ESMTPSA id b14sm18168969edu.3.2020.12.17.06.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:19:18 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCHv2 for-next 02/19] RMDA/rtrs-srv: Occasionally flush ongoing session closing
Date:   Thu, 17 Dec 2020 15:18:58 +0100
Message-Id: <20201217141915.56989-3-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If there are many establishments/teardowns, we need to make sure
we do not consume too much system memory. Thus let on going
session closing to finish before accepting new connection.

In cma_ib_req_handler, the conn_id is newly created holding
handler_mutex when call this function, and flush_workqueue
wait for close_work to finish, in close_work rdma_destroy_id
will be called, which will hold the handler_mutex, but they
are mutex for different rdma_cm_id.

To avoid circular locking lockdep warnings, disable lockdep
around flush_workqueue in rtrs_rdma_connect, it's false positive.

Inspired by commit 777dc82395de ("nvmet-rdma: occasionally flush ongoing controller teardown")
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index ed4628f032bb..eb7bb93884e7 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1791,6 +1791,20 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 		err = -ENOMEM;
 		goto reject_w_err;
 	}
+	if (!cid) {
+		/* Let inflight session teardown complete *
+		 *
+		 * Avoid circular locking lockdep warnings.
+		 * cma_ib_req_handler, the conn_id is newly created holding
+		 * handler_mutex when call this function, and flush_workqueue
+		 * wait for close_work to finish, in close_work rdma_destroy_id
+		 * will be called, which will hold the handler_mutex, but they
+		 * are mutex for different rdma_cm_id.
+		 */
+		lockdep_off();
+		flush_workqueue(rtrs_wq);
+		lockdep_on();
+	}
 	mutex_lock(&srv->paths_mutex);
 	sess = __find_sess(srv, &msg->sess_uuid);
 	if (sess) {
-- 
2.25.1

