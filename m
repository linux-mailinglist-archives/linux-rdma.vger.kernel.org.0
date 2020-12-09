Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234B72D4710
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 17:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgLIQrM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 11:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729544AbgLIQrM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Dec 2020 11:47:12 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41996C0611CB
        for <linux-rdma@vger.kernel.org>; Wed,  9 Dec 2020 08:46:03 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id h16so2275586edt.7
        for <linux-rdma@vger.kernel.org>; Wed, 09 Dec 2020 08:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UFNb99s/RTR+9Z5BZf2S4yuaWavk0ZSJFDP1tqF7kdg=;
        b=KGl3SpWhDsbPX8C1TKapogbU35UkySnTh7YZZ+RtMBFzDNhiR/9maQ6KLCXQtWy2ub
         tW2nE1s4eFYEvuEpyiw5V5NCzhqT7fVjNWrq/d0pcXFOs99suQnRw8qa9lGXCvHLkYDu
         4DbhlE+oSWUdJkOm87+6fSftZhmPZgUjb8331RvNvhWexcRvz/FZMle1b5qjWo4R82NP
         PKYh7GbbHQAmqA0Scp9r5bWQ90NE6nXgJwUwg8nY4sGeOrGsgtCos3+ohroeMT5kCzNy
         pghJXr2r1JK1BzlTfvE94KB2Ov1CKhFPrF/M4oFcbM/Ats9ho871D1vOOhbB4IrPlR2w
         a+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UFNb99s/RTR+9Z5BZf2S4yuaWavk0ZSJFDP1tqF7kdg=;
        b=BWw4W4TxUpVhNhqFa4wOxqF2piLwMPXPnxPY9R7m+ndBG64KhHy5Ga0sXre4sFBM4i
         tn5srXxnqy3QOIpzOSp7CoKTeWQ2V8UDcYU3CyvgOaL7oAG7QMo4k7G2sGfROC+bJqnh
         i4oFrsyEhSDmYL2Nd7mNjsNFPeh6yv+mLJuLkEt4Om7TEX6RrIkNhXAVLxokuk/ER4Fq
         kSBpp4rJAb5HX86/N05kO4kyM61+x+aBOzWsgq9Doar3PASyIvRB1yQ5F9KU4xu3cSYj
         FCVvyl9XoylwMJj4Xv40O6jFVufcjHN7oz92yukgIjDszep9TfSp9zxMO+JlTKq7Jp2g
         d7sA==
X-Gm-Message-State: AOAM532ll2PGMHFivl/De14zXusNe3rtPuZAllaakWHY0PR1hc9ioUie
        4t+Xt41brhSyY9daGPtNL6WKinPMlfsdZA==
X-Google-Smtp-Source: ABdhPJxEeJCdG1Db4aYHbdhMgUW6toypLmMBXfhVhPixDqgViNIdswrXBELhPkDKXeknj5RP+tM/GA==
X-Received: by 2002:a05:6402:1d24:: with SMTP id dh4mr2791438edb.161.1607532361764;
        Wed, 09 Dec 2020 08:46:01 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id h16sm1977915eji.110.2020.12.09.08.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 08:46:00 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH for-next 14/18] RDMA/rtrs-clt: Refactor the failure cases in alloc_clt
Date:   Wed,  9 Dec 2020 17:45:38 +0100
Message-Id: <20201209164542.61387-15-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Make all failure cases go to the common path to avoid duplicate code.
And some issued existed before.

1. clt need to be freed to avoid memory leak.

2. return ERR_PTR(-ENOMEM) if kobject_create_and_add fails, because
   rtrs_clt_open checks the return value of by call "IS_ERR(clt)".

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 3c90718f668d..493f45a33b5e 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2568,11 +2568,8 @@ static struct rtrs_clt *alloc_clt(const char *sessname, size_t paths_num,
 	clt->dev.class = rtrs_clt_dev_class;
 	clt->dev.release = rtrs_clt_dev_release;
 	err = dev_set_name(&clt->dev, "%s", sessname);
-	if (err) {
-		free_percpu(clt->pcpu_path);
-		kfree(clt);
-		return ERR_PTR(err);
-	}
+	if (err)
+		goto err;
 	/*
 	 * Suppress user space notification until
 	 * sysfs files are created
@@ -2580,29 +2577,31 @@ static struct rtrs_clt *alloc_clt(const char *sessname, size_t paths_num,
 	dev_set_uevent_suppress(&clt->dev, true);
 	err = device_register(&clt->dev);
 	if (err) {
-		free_percpu(clt->pcpu_path);
 		put_device(&clt->dev);
-		return ERR_PTR(err);
+		goto err;
 	}
 
 	clt->kobj_paths = kobject_create_and_add("paths", &clt->dev.kobj);
 	if (!clt->kobj_paths) {
-		free_percpu(clt->pcpu_path);
-		device_unregister(&clt->dev);
-		return NULL;
+		err = -ENOMEM;
+		goto err_dev;
 	}
 	err = rtrs_clt_create_sysfs_root_files(clt);
 	if (err) {
-		free_percpu(clt->pcpu_path);
 		kobject_del(clt->kobj_paths);
 		kobject_put(clt->kobj_paths);
-		device_unregister(&clt->dev);
-		return ERR_PTR(err);
+		goto err_dev;
 	}
 	dev_set_uevent_suppress(&clt->dev, false);
 	kobject_uevent(&clt->dev.kobj, KOBJ_ADD);
 
 	return clt;
+err_dev:
+	device_unregister(&clt->dev);
+err:
+	free_percpu(clt->pcpu_path);
+	kfree(clt);
+	return ERR_PTR(err);
 }
 
 static void free_clt(struct rtrs_clt *clt)
-- 
2.25.1

