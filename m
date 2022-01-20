Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F41A495366
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jan 2022 18:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiATRg6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jan 2022 12:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiATRgz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jan 2022 12:36:55 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E766EC061574
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jan 2022 09:36:54 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id l5so14776409edv.3
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jan 2022 09:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kORcCkPxHkqDADxiV1u6PxZ8vgUlVOKU+qEglizB29k=;
        b=V9RDxZiqaXOM+rvAuU/AG3x/Wq2H+V7T3sQMfHr9dIp+ltNaCGzFWkUuXK9IA4ZB6+
         WvBsxlmHTeS4N4CkLXNTnpz9ydruxtpOu71XOwZjeIMzAq2AJTwDBR3fNcP1JG9UKlIV
         1cfd1q9sdwziGaybN6rxS6ihxUAYywzIleBntPYOZt1fnp/+RIuaiQjCwKT5K9AQrcPt
         pg8DpNV20yrHDKxc01jm2v1IHwKMAHw6zilO2cMO8pw6BIBtlg8JmVyjnU8x110xe2Je
         ld99hnovKssOxGItWujrAaoaJsk6We6DL1kp8L+bWAHLi5H3QdHTN1HXASXLZLkbTY9s
         yc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kORcCkPxHkqDADxiV1u6PxZ8vgUlVOKU+qEglizB29k=;
        b=Bmu1inobd/2hj9ta7iiZ0kRSLKGkwyjnTRaI3Yh+6M5ana3IdULj+gHaeQQMKeU05A
         z0AoRlAxeMy9Quv2lD5tO7y2hm1FtqzcIL4omUMORMe1FK3YblkuavWZlWv28oyTDMuO
         hgBD/H/sBtdRLc45PD2R7dMbNJufXhQWXt2gW6oTLtmDg5vYLNo7XiqFXfr0GdWireNm
         E//6tQBtfhUg9S551mA/hbMjEf+JDN6JRB6iRfdRUxzOHNeEp7GoJaQziM1lFte3OJeW
         pyZ3SrJI9aF7Ah5nrGykJzYiDKo1Y65Rndk6o5ChBaa9+LGdCr02ZpFpe62ReoAB+XbN
         /5+A==
X-Gm-Message-State: AOAM532xU1rNf1kfKCH6Q3gU2EQXMuBi/CkhvhlhrX5IxG7yaSxsTi2y
        OGOqK35nEG0iFbRMtp0YaCyNeuacQRJ4wQ==
X-Google-Smtp-Source: ABdhPJzeQySFBZoR+r4CnkAf9NRhcd0htbGErgCbu6ceibdmKcAOVUBu0jb8GJyF6wi9ylSeGKjvGA==
X-Received: by 2002:a17:906:274f:: with SMTP id a15mr29420216ejd.492.1642700213528;
        Thu, 20 Jan 2022 09:36:53 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id s7sm1252092ejo.212.2022.01.20.09.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 09:36:53 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com, linmq006@gmail.com,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Santosh Kumar Pradhan <santosh.pradhan@ionos.com>
Subject: [PATCH v2] RDMA/rtrs-clt: Fix possible double free in error case
Date:   Thu, 20 Jan 2022 18:36:32 +0100
Message-Id: <20220120173632.420807-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Callback function rtrs_clt_dev_release() for put_device()
calls kfree(clt) to free memory. We shouldn't call kfree(clt) again,
and we can't use the clt after kfree too.

free clt->pcpu_path and clt explicitly when dev_set_name fails.
For other errors after that, let the release function take care of
freeing them. Also remove free_percpu(clt->pcpu_path) from free_clt()

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Reported-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
Reviewed-by: Santosh Kumar Pradhan <santosh.pradhan@ionos.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
---
Changes since v1:
 - Explicitly free clt->pcpu_path and clt when dev_set_name fails
 - Remove free_percpu(clt->pcpu_path) from free_clt function

---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 7c3f98e57889..b8fc6ee4bb7f 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2682,6 +2682,7 @@ static void rtrs_clt_dev_release(struct device *dev)
 	struct rtrs_clt_sess *clt = container_of(dev, struct rtrs_clt_sess,
 						 dev);
 
+	free_percpu(clt->pcpu_path);
 	kfree(clt);
 }
 
@@ -2731,8 +2732,11 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
 	clt->dev.class = rtrs_clt_dev_class;
 	clt->dev.release = rtrs_clt_dev_release;
 	err = dev_set_name(&clt->dev, "%s", sessname);
-	if (err)
+	if (err) {
+		free_percpu(clt->pcpu_path);
+		kfree(clt);
 		goto err;
+	}
 	/*
 	 * Suppress user space notification until
 	 * sysfs files are created
@@ -2762,18 +2766,17 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
 err_dev:
 	device_unregister(&clt->dev);
 err:
-	free_percpu(clt->pcpu_path);
-	kfree(clt);
 	return ERR_PTR(err);
 }
 
 static void free_clt(struct rtrs_clt_sess *clt)
 {
 	free_permits(clt);
-	free_percpu(clt->pcpu_path);
 	mutex_destroy(&clt->paths_ev_mutex);
 	mutex_destroy(&clt->paths_mutex);
-	/* release callback will free clt in last put */
+	/*
+	 * release callback will free clt->pcpu_path and clt in last put
+	 */
 	device_unregister(&clt->dev);
 }
 
-- 
2.25.1

