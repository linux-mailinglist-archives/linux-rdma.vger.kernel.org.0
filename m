Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540932DD2D9
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 15:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgLQOUl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Dec 2020 09:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbgLQOUl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Dec 2020 09:20:41 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8BBC0611CA
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:26 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id 6so23453839ejz.5
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qy3ygq6w7O8DF53aV7q7DOLXGPF0OfN7MeSVY+w05wM=;
        b=B0TKE+vjtx+0BG3H7KiU4TJ/P1oBR+BobIQ8CKfnEq18l/s3dydiYC4EfnQWN2Me5B
         5fcpLqXse7cjrec7GIAId5UgOoN0iydwF8MbXHFLY7wVvZNkDpiMdzGYdPhZ1lyS0WOt
         qBgp7nKn1abRJ8d08qYauDROnP1mWFZdQXWl9SudYUBprr863Y+jqnbNBGC0EejyTMbv
         qvwqlk89JPakKc3KuEGZa4fpSebYUkpscAX8cwfW+zgg9u38kfxxiH5K0wdRGLxHddXw
         7v3WZXSBLYW8+rfbrk4ZulczH2wB6Y+w1vYtGeZpdyNrsZC55lA3l6soI592r7t/pbs5
         Wlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qy3ygq6w7O8DF53aV7q7DOLXGPF0OfN7MeSVY+w05wM=;
        b=PYikgmGs7OZ3DfbUuGOszQWAFe3Xu0upehLjSdh4PCkzmgqUarsrSBNDAvqszLJMKM
         d9YLSJGelxiH5Sq1Z7HjHZJbiiflWgYfcjmZBV2K+aDd2sTkpEo78JVp+a/s/YYaQHfw
         +2Ikf04GikLNNWxDkf5fW/O2iKdKqlloFrqtzUkys9gnEXHjCoTOXLQ8OZVsq+dWoaBF
         E8pBVINQX1flk3cXIuWucy+QlgX+3db0+PY4RofIpTeCLJU9zPO5C2AcDQ6Uo3pFG/oj
         QCXmFbEHE2WMpHo59ZpBo7rMtP29uEeLu4qJXRTjqsYaqoCd2zk15BhNUXGIcJ9Lql87
         h3eQ==
X-Gm-Message-State: AOAM533nhY7YlHaOTVmIDYHz9RHdINQyASDSYOqLbw1IW8k4jg1p65B/
        nWrLwopRkcwX1fX4BMPOnwJZZCerypmR2Q==
X-Google-Smtp-Source: ABdhPJzvgmmtd4lfNJ8Yr7gPJbFf9a2Bo3wd2EBQx0KMqpWa005lMFlCc3qvfX1d6tzwe4byfb7I9w==
X-Received: by 2002:a17:906:ce2b:: with SMTP id sd11mr36357385ejb.334.1608214765452;
        Thu, 17 Dec 2020 06:19:25 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4991:de00:e5a4:2f4d:99:ddc5])
        by smtp.gmail.com with ESMTPSA id b14sm18168969edu.3.2020.12.17.06.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:19:25 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCHv2 for-next 09/19] RDMA/rtrs-clt: Kill wait_for_inflight_permits
Date:   Thu, 17 Dec 2020 15:19:05 +0100
Message-Id: <20201217141915.56989-10-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Let's wait the inflight permits before free it.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 99fc34950032..6a5b72ad5ba1 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1318,6 +1318,12 @@ static int alloc_permits(struct rtrs_clt *clt)
 
 static void free_permits(struct rtrs_clt *clt)
 {
+	if (clt->permits_map) {
+		size_t sz = clt->queue_depth;
+
+		wait_event(clt->permits_wait,
+			   find_first_bit(clt->permits_map, sz) >= sz);
+	}
 	kfree(clt->permits_map);
 	clt->permits_map = NULL;
 	kfree(clt->permits);
@@ -2607,19 +2613,8 @@ static struct rtrs_clt *alloc_clt(const char *sessname, size_t paths_num,
 	return clt;
 }
 
-static void wait_for_inflight_permits(struct rtrs_clt *clt)
-{
-	if (clt->permits_map) {
-		size_t sz = clt->queue_depth;
-
-		wait_event(clt->permits_wait,
-			   find_first_bit(clt->permits_map, sz) >= sz);
-	}
-}
-
 static void free_clt(struct rtrs_clt *clt)
 {
-	wait_for_inflight_permits(clt);
 	free_permits(clt);
 	free_percpu(clt->pcpu_path);
 	mutex_destroy(&clt->paths_ev_mutex);
-- 
2.25.1

