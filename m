Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D0B356A12
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 12:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhDGKmT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 06:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbhDGKmS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Apr 2021 06:42:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E84C061756
        for <linux-rdma@vger.kernel.org>; Wed,  7 Apr 2021 03:42:09 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a25so3815406ejk.0
        for <linux-rdma@vger.kernel.org>; Wed, 07 Apr 2021 03:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yuSbwWtLvWBEDcvviHPrnkLG61kubVfLdF96J++Fyvw=;
        b=MbVJImCC7lfaeL2yk1i4ZC948BOrijv5rEeUpO7n0YzRglOOajWZbJEHvKdIEY+tDE
         YWy9E/lOnzH/y/h0OJLoAqbR6CAQw/VaB8upetti1Y3CtoE1qCA0FH29Bkxvg0wjx1CI
         KSOv4SGg1q3L6rBGFUfI+MQ2iy21L1OAN9HmIXfYBJoR8skZ8LCdt9O1uuvSdx3kYeaA
         4GA1HPfgEOEfNboWLI3cc8yL9BUlNkFYoQGtCykvLgFVrZq94r9YfoIrtujRGOBH2t5/
         6e0FbpWc9CK/PMJGZOzOzwB1AXZqeYWMnIAAKSthXtTOQV2QlyCi6DOz0dqhi4shQ4To
         Q67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yuSbwWtLvWBEDcvviHPrnkLG61kubVfLdF96J++Fyvw=;
        b=guWingvN9PFfg2R0EXYrG/zuwIhj0r+aQZE65zkbKnq6q2OSR92H4HsXvrDhlVEfO7
         VkAzLdv6iVIu54R8pKvGvi37fOCWdc3d6DozWF0IaTVavVBS9oZGiU5JoREa2ky00zYX
         HGUNQxLtAbvu860PEaFUZal/+qCqkBkHuSzijnAiWXM6BTaOYzAC/1uDc91CiK5v0pEP
         fwGbGhnKE4InaJYOX6KoUhyKO2kLvGtsaAv2jA7nJ1E2eWlbtQmOlsH0VLR0sRW+tO7L
         y2vZ99wsZx8zMl4C++W39yss0gFAOhR6BUoYHit25/r/NTN9/9txuj6CTeNDVLm+/6hA
         GJKA==
X-Gm-Message-State: AOAM530iTYtQmAKE+tITNC1gACX2JdF7ki91qWkdLjq+OsI3jUyeDWTw
        rGbdFA4gC1GI9iJwiIkLdHLW5wkBB7FEjG9K
X-Google-Smtp-Source: ABdhPJwdIQ28EzHG9rNu2AC8BBnDk2XfJiExk4TeW7tJbi2uMNuE+GhiQ6SLcGal+gHSKwjIdwKFDw==
X-Received: by 2002:a17:906:ff41:: with SMTP id zo1mr2944034ejb.19.1617792127616;
        Wed, 07 Apr 2021 03:42:07 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id j1sm12359779ejt.18.2021.04.07.03.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 03:42:07 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 2/4] RDMA/rtrs-clt: new sysfs attribute to print the latency of each path
Date:   Wed,  7 Apr 2021 12:42:01 +0200
Message-Id: <20210407104203.24792-3-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407104203.24792-1-gi-oh.kim@ionos.com>
References: <20210407104203.24792-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

It shows the latest latency that the client checked when sending
the heart-beat.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index c8669d3f79f1..e2673a17b6a3 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -355,6 +355,21 @@ static ssize_t rtrs_clt_hca_name_show(struct kobject *kobj,
 static struct kobj_attribute rtrs_clt_hca_name_attr =
 	__ATTR(hca_name, 0444, rtrs_clt_hca_name_show, NULL);
 
+static ssize_t rtrs_clt_cur_latency_show(struct kobject *kobj,
+				    struct kobj_attribute *attr,
+				    char *page)
+{
+	struct rtrs_clt_sess *sess;
+
+	sess = container_of(kobj, struct rtrs_clt_sess, kobj);
+
+	return scnprintf(page, PAGE_SIZE, "%lld ns\n",
+			 ktime_to_ns(sess->s.hb_cur_latency));
+}
+
+static struct kobj_attribute rtrs_clt_cur_latency_attr =
+	__ATTR(cur_latency, 0444, rtrs_clt_cur_latency_show, NULL);
+
 static ssize_t rtrs_clt_src_addr_show(struct kobject *kobj,
 				       struct kobj_attribute *attr,
 				       char *page)
@@ -398,6 +413,7 @@ static struct attribute *rtrs_clt_sess_attrs[] = {
 	&rtrs_clt_reconnect_attr.attr,
 	&rtrs_clt_disconnect_attr.attr,
 	&rtrs_clt_remove_path_attr.attr,
+	&rtrs_clt_cur_latency_attr.attr,
 	NULL,
 };
 
-- 
2.25.1

