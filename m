Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07775371484
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 13:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbhECLtX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 07:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbhECLtW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 07:49:22 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B27AC06174A
        for <linux-rdma@vger.kernel.org>; Mon,  3 May 2021 04:48:29 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id u13so3210317edd.3
        for <linux-rdma@vger.kernel.org>; Mon, 03 May 2021 04:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TD+IUqvK3rmRyo/UXMWEt8JGbAptLLrQ1RYAde9/BdQ=;
        b=dj89Q+TI9pXmz5M4PQL43nPBzF0Stx8hAExWQJZoyCGNRwStuAeOC9ShAE2EjZZEV8
         rQ0IH0hXBuYDJElrq2SDXr3Htj6Y3J2etYcyKsCPr232EMTBnUjMFV4f2knbXpQI18Jo
         FuJo4fXNQT0WhAcI/+hkhGHbASf3W94cRpI/T4jCIH7TXVX8paAXmt7xpUCx1geZ25kF
         R0ZlzPpHdL0Gw5UVro6zsXtB+37f4LdUOYz/Ph+/v50kGcSZ7PkpgoXjU+w+9Tjff5in
         Um9gw9IELfoYVl3PtodA66maiDJjwyiXH/0xkMxRsKa+ABoqiyY8C3LIrqXP62qfYFaw
         9ZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TD+IUqvK3rmRyo/UXMWEt8JGbAptLLrQ1RYAde9/BdQ=;
        b=BMjVeMeyf+TaIX7r7OTz7U3sFPivyZ3x0CnOXzWCM9Hy2skO0w0PPocBZVNmsUptwX
         /iJtOcMyO5KwB++1eebqTYGE/9q2KWxCMmR1SGgrDPjYj366xZkO/h4QKgEiAuolckZD
         lh7EaOKRtA+PuFP7HpayArHpvhcL9qBp0fsv3tadM5MyWb7c59wRBe7YIFAthcWZzO1n
         01chrk7OXvUnBdHc0f8ttu3VO85EFZdVeWlQdsXBIP1Xb12ld639oTcIx6wgwEu5gwE7
         QIvFtKVhZdnURaGFRhc7sW8+w1JDj7oTaceEKj+RiJJdpCP3S+0HhNu21UfRsIL+XUaF
         CCqg==
X-Gm-Message-State: AOAM531pC06ebZV8em5y9EF1OCYfi1F6laN+bvg6Fdo99iumY7w2uhlD
        7FQs6XgmaSO1qjZrt/T33WtZRx890X6MaA==
X-Google-Smtp-Source: ABdhPJxC1C4FtJc+UzzhS3NgID6SgivJqJXLnk5FrSsl0vMRss1u04J/7ULau5L3vFlasvYaKSDxPw==
X-Received: by 2002:aa7:c850:: with SMTP id g16mr19001661edt.324.1620042507983;
        Mon, 03 May 2021 04:48:27 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id z12sm7307705ejd.83.2021.05.03.04.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:48:27 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 10/20] RDMA/rtrs-clt: Kill rtrs_clt_disconnect_from_sysfs
Date:   Mon,  3 May 2021 13:48:08 +0200
Message-Id: <20210503114818.288896-11-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503114818.288896-1-gi-oh.kim@ionos.com>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
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
index 76040f6c43b2..d9764d1fe0f4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1843,7 +1843,7 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
 	return -ECONNRESET;
 }
 
-static void rtrs_clt_close_conns(struct rtrs_clt_sess *sess, bool wait)
+void rtrs_clt_close_conns(struct rtrs_clt_sess *sess, bool wait)
 {
 	if (rtrs_clt_change_state_get_old(sess, RTRS_CLT_CLOSING, NULL))
 		queue_work(rtrs_wq, &sess->close_work);
@@ -2818,13 +2818,6 @@ int rtrs_clt_reconnect_from_sysfs(struct rtrs_clt_sess *sess)
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

