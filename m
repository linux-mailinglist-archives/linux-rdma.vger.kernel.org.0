Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D511382818
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 11:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbhEQJU4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 05:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbhEQJUm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 05:20:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21A7C06138C
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:23 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id n25so6002031edr.5
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+GKl0MddXRuonEJEjz0CxXLWo+V6CCyFMssNddaPwzk=;
        b=RZC/R7UaS7pH91P0stnbGX7SAaomxY5I/TX7qGjklYfHcnz6FVcuJhdAayEwPX3G/D
         OHiXNZtrYDkHgKmvPV9eeQn+r4NDG3PnHZ9VAznaAuqeL0hIacioaRVU8Z4mENxC41ws
         KKg7i8M21D0UxUkV0yuMVYxMP84cLdbgF25eRPjo/+lu7WbfBN6K9a0J6YRb0Tkwo9xL
         daPWY3sTpTrhsun1KgcFT293AZZZScbhTUXvbRA0mp+DlMdQpBzb5aArmNK8O3Yx4PsW
         MBPXNTg3rNvPmZmy4SUlakaN2n+GRt8/qiPBgNcPNZXMEtzdN1TELJPhCiHhrG0xbZYy
         xVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+GKl0MddXRuonEJEjz0CxXLWo+V6CCyFMssNddaPwzk=;
        b=MDva7HPM0WMjDlWASbSntgs6/tMYwtczVQ4EdGudnvtbi5MPb7ipnh1jhsj2os4dhA
         0kmaqMcGepdE2MEhYIiCHCdM8liT6K6t+fEGFh7kz1lqM0aX8E13jz5NcJRCq4tmp2Gp
         sFxR7Tsb5FOVrrq79RKCCBBgVepiHP7ag6D2sdmTGGEuRCm4uQfWPQqhNF0HneJLnZzI
         3aizE9q7WV1MZYYmjp0aBu6IyRhOgAdDiAhBNT+N/JdmH+gyt5K2qOpho8qdYsPsl99L
         dAl2ym36CLeghF3n/JYoD4iV8KRKCAFhS6rbUuaCnfeAiKcxbALo9WykZqQ5484cmDTV
         cyAg==
X-Gm-Message-State: AOAM533O5s1AmeYjEm8EOizzQcLKSrKGoMYm5bk6rdnnBhsQ1YS+1sLB
        iK77TKALHXoWmZwJOfjbv7j1AQ+2ZPLViQ==
X-Google-Smtp-Source: ABdhPJxBKtuasTYmlHRMbWhFbkQBJCBNpOO6heb8tskh97fWGZVz0+LX/wFirJ8TSkCnjc8g7AfzIA==
X-Received: by 2002:a05:6402:40c:: with SMTP id q12mr37888257edv.0.1621243162400;
        Mon, 17 May 2021 02:19:22 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id g10sm7925845ejd.109.2021.05.17.02.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:19:22 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 09/19] RDMA/rtrs-clt: Kill rtrs_clt_disconnect_from_sysfs
Date:   Mon, 17 May 2021 11:18:33 +0200
Message-Id: <20210517091844.260810-10-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517091844.260810-1-gi-oh.kim@ionos.com>
References: <20210517091844.260810-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

The function is just a wrapper of rtrs_clt_close_conns, let's call
rtrs_clt_close_conns directly.

Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 5 +----
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 9 +--------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       | 2 +-
 3 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index 7d53d18a5004..4ee592ccf979 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -250,7 +250,6 @@ static ssize_t rtrs_clt_disconnect_store(struct kobject *kobj,
 					  const char *buf, size_t count)
 {
 	struct rtrs_clt_sess *sess;
-	int ret;
 
 	sess = container_of(kobj, struct rtrs_clt_sess, kobj);
 	if (!sysfs_streq(buf, "1")) {
@@ -258,9 +257,7 @@ static ssize_t rtrs_clt_disconnect_store(struct kobject *kobj,
 			  attr->attr.name, buf);
 		return -EINVAL;
 	}
-	ret = rtrs_clt_disconnect_from_sysfs(sess);
-	if (ret)
-		return ret;
+	rtrs_clt_close_conns(sess, true);
 
 	return count;
 }
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 0f19c133b7cc..1de72784e1c0 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1849,7 +1849,7 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
 	return -ECONNRESET;
 }
 
-static void rtrs_clt_close_conns(struct rtrs_clt_sess *sess, bool wait)
+void rtrs_clt_close_conns(struct rtrs_clt_sess *sess, bool wait)
 {
 	if (rtrs_clt_change_state_get_old(sess, RTRS_CLT_CLOSING, NULL))
 		queue_work(rtrs_wq, &sess->close_work);
@@ -2824,13 +2824,6 @@ int rtrs_clt_reconnect_from_sysfs(struct rtrs_clt_sess *sess)
 	return err;
 }
 
-int rtrs_clt_disconnect_from_sysfs(struct rtrs_clt_sess *sess)
-{
-	rtrs_clt_close_conns(sess, true);
-
-	return 0;
-}
-
 int rtrs_clt_remove_path_from_sysfs(struct rtrs_clt_sess *sess,
 				     const struct attribute *sysfs_self)
 {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index ef15927dfeda..0a0ea43d2b46 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -203,7 +203,7 @@ static inline struct rtrs_permit *get_permit(struct rtrs_clt *clt, int idx)
 }
 
 int rtrs_clt_reconnect_from_sysfs(struct rtrs_clt_sess *sess);
-int rtrs_clt_disconnect_from_sysfs(struct rtrs_clt_sess *sess);
+void rtrs_clt_close_conns(struct rtrs_clt_sess *sess, bool wait);
 int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
 				     struct rtrs_addr *addr);
 int rtrs_clt_remove_path_from_sysfs(struct rtrs_clt_sess *sess,
-- 
2.25.1

