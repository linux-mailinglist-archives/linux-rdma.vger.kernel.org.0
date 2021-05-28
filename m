Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166CB3941C9
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 13:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbhE1LcL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 07:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbhE1LcF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 07:32:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B6FC06138C
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:29 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id e12so4868824ejt.3
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XMBpTRUY+kS2EBYl2UDMjKmmroGOrL4HkncHzS5JY3g=;
        b=ZnXuOFF+x0hnjangfJ7BE95LfIp71qGdFCOK1AExkDXbaaxkHTTTBT+j8pdofXX2Zk
         DJrbTlLC3ivoHlewbiY+elHayTa4FW2WMlQ6MlgAoiG4C1YdAURwMPKia0OxErZNq0RH
         LfsV0LEdxr7zBPhZr0Z//DbBISsBltdTFRH21oZRlyZEFAu8NdidbuICTRosFyFusJ3F
         4dYcKY6ljs42r3SrJGee1+vR1GxQU0xXbijxtfnmNUtnK+93uZEQ1dR1i82H0427Sw7V
         hwhwbv5XcdgJLQtY3bjcyg0/rBoJxZ/RdD8/Jr0CfUkffjPTcWuRgIGOUA4plAgamkZM
         Y2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XMBpTRUY+kS2EBYl2UDMjKmmroGOrL4HkncHzS5JY3g=;
        b=JJPe3vRknAiukv+ZM24S2jqn+d71/6xgFXdbx/Q4z90j9nQmKQEKQkT4MZaqMlwAIg
         gG3qboaE/wdYafGVKrSNq5jrrN2EjQ7a4ptc8rQxAuKPrrtdqI6Cb5WVahD5MTkABGlg
         CiG3bfa+1YGBZkAog9ir5TaHNqMEZVSaZFH9A5oNcmHOOPDaMaT6GNmYGkjmyqBBjzt2
         cLjy0sPG/fwaaZF4u7hvG8eVWcQM1mKmyPjUH3dty1NnnE5JRTuT5oz8qJLAu9vON78+
         nqiFMWNvV6kHdBkweSn1xqYkZmHTW1a+uigc639y0He2lQ89BxYdgoj2lwIyK4S8HUNO
         Cozw==
X-Gm-Message-State: AOAM53156EsYOgWH/s53Ry+w3VTNJ+j8XaciJRzohRD4MgfntCAWuXNP
        aRhBsPvHWIHggz22J/Q9c1vAOO3d37iZNw==
X-Google-Smtp-Source: ABdhPJwZttvkHkSgTO9ZtRqx3Jq6mxsPDZzCa38r1KqRVncMWR7XB0IcoxPBr8nEf1LVL0kuqkloZQ==
X-Received: by 2002:a17:906:dfd1:: with SMTP id jt17mr787800ejc.486.1622201427678;
        Fri, 28 May 2021 04:30:27 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:497d:7d00:983b:122a:4685:3849])
        by smtp.gmail.com with ESMTPSA id p15sm2594578edr.50.2021.05.28.04.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:30:27 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 09/20] RDMA/rtrs-clt: Kill rtrs_clt_disconnect_from_sysfs
Date:   Fri, 28 May 2021 13:30:07 +0200
Message-Id: <20210528113018.52290-10-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528113018.52290-1-jinpu.wang@ionos.com>
References: <20210528113018.52290-1-jinpu.wang@ionos.com>
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
index e34d5eadcfb2..e87796a556c0 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1859,7 +1859,7 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
 	return -ECONNRESET;
 }
 
-static void rtrs_clt_close_conns(struct rtrs_clt_sess *sess, bool wait)
+void rtrs_clt_close_conns(struct rtrs_clt_sess *sess, bool wait)
 {
 	if (rtrs_clt_change_state_get_old(sess, RTRS_CLT_CLOSING, NULL))
 		queue_work(rtrs_wq, &sess->close_work);
@@ -2831,13 +2831,6 @@ int rtrs_clt_reconnect_from_sysfs(struct rtrs_clt_sess *sess)
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
index 4c52f30e4da1..919c9f96f25b 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -202,7 +202,7 @@ static inline struct rtrs_permit *get_permit(struct rtrs_clt *clt, int idx)
 }
 
 int rtrs_clt_reconnect_from_sysfs(struct rtrs_clt_sess *sess);
-int rtrs_clt_disconnect_from_sysfs(struct rtrs_clt_sess *sess);
+void rtrs_clt_close_conns(struct rtrs_clt_sess *sess, bool wait);
 int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
 				     struct rtrs_addr *addr);
 int rtrs_clt_remove_path_from_sysfs(struct rtrs_clt_sess *sess,
-- 
2.25.1

