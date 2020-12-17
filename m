Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DFB2DD2DC
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 15:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgLQOUn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Dec 2020 09:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbgLQOUm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Dec 2020 09:20:42 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E35C0611D0
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:31 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id qw4so38044682ejb.12
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EDx0d7sqRwEf6BTXoENkSiqZnuiDyLvadt8JMtY/Ios=;
        b=XdMDmPcZRDJH7OX2Iw6FKrSs6Aq1WeNs0wZ7OohyRx0HJMAVmzEgK7nvHu3lU27MfA
         csvbOJtqDC9I1pvUzrz6NBttCsS1jbQHooDce4KmdFzyqVQYb2Sbby37i9kA4zSv4hcT
         z7Tdlk+5rqJ6klbgqd0EaFAMWXk/J1XLuO7/3ik7rAxXuOE9T1XncQ/TFztg1RIweKBn
         A+hwP1yghNOnnib4CwkTH9p6M0Z0IVUjoVAy0+CjUCEZ047YJ5a1x6V95eTbd/lHwUKP
         j+LHuIb7K5KuW/MxzI5YOkGE0dpsz03LkSwpIxbYypPoa/bo9XzcThiVeHzZl+5hrw4Z
         18vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EDx0d7sqRwEf6BTXoENkSiqZnuiDyLvadt8JMtY/Ios=;
        b=lhZVzes7EDAouRR6DmV5dnK2UWP57jlgCp3s/xJh1/gveOa7ub7jzGdjWzGmAr1GdK
         hdOQc3aT+2xmeiykH+Wl1XA3lPdn6ExSGGNvm0QIPRSMoVbFefLw0xhM6dkzvM/ecjgu
         wN53ry7ZFglMl2G/vhDOdDaakUAgv41QaYxi5yMAc+9XMRsJ94uEcIDIyXaVmhZLM0HX
         VdPFtYqRcaXc/WjlRiNk2whxfmeOdhWOGqsu0lZwFT81vdXVzzFzWAoqoIJRQ2+E0Ckc
         YJuUtRM+dvppnn7AsBHr2RqyuAoUlpYd5dO8pPdT5KGekJ1FPCjciKThnpz8AKPKJQCd
         BNow==
X-Gm-Message-State: AOAM532XXkLdheYKC/Jr07IpmEUU32ZoP8Z/u/iWVR0+UFWeF4JP1lmo
        WxRIi3p0ldgYc0SF6tBXrglaP6cWkdT3EA==
X-Google-Smtp-Source: ABdhPJxYwIjI2VjAlGzYGT14HI4A5+Wd/IEc/k7afj6pdWIvQD7w9i6HUWmMyiREWiUOC8etDTfKrg==
X-Received: by 2002:a17:906:71ca:: with SMTP id i10mr17695285ejk.528.1608214769982;
        Thu, 17 Dec 2020 06:19:29 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4991:de00:e5a4:2f4d:99:ddc5])
        by smtp.gmail.com with ESMTPSA id b14sm18168969edu.3.2020.12.17.06.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:19:29 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCHv2 for-next 14/19] RDMA/rtrs-clt: Refactor the failure cases in alloc_clt
Date:   Thu, 17 Dec 2020 15:19:10 +0100
Message-Id: <20201217141915.56989-15-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
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

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
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

