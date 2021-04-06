Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36E435531D
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 14:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343678AbhDFMGG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 08:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhDFMGG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 08:06:06 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5B1C06174A
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 05:05:58 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id p4so5980558edr.2
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 05:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f4XykaULLm/H2BAHIppcboAz/DEhe60yxW9/E6NuP0o=;
        b=LV5M+Z72QyBkBeXuoRVMzfZRi3yUBXy2zh1ICrmjGqKUQogkjsw6jESjaZ+8GddEAD
         KzKYLjSDk+Itbt99YAlCL3Bkygn8VPHfVMhXlP8c+myUW0nez38Yev1WbxChZ8P6INEF
         R0mTLQ9z6C/1aBstigCZt93N/paMyPFTq6yt4R3ca9H78mk98X+XsCRcmLMJyogPSb6T
         VQ0r9mxgg3wz5b4YOaDBaKkYQX7Ic78PVpCfCJbyDbjkLvRZ/4ePMtkysZBmaUXeiAD4
         glT/S1OMdAbK2XJitbZmRBm9eiK8FHBoFZnoXEKdogTsv+mvhCQYjGJXQxROeKDfjKu6
         WZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f4XykaULLm/H2BAHIppcboAz/DEhe60yxW9/E6NuP0o=;
        b=gbseI8FnjidFkXTrwKXRXyL7xlYsUV3F2FJtaxs+ZGxLGDvFOdunESbyyja6ifZTYy
         0hJmb8sNwVkF9uy8gXQi7w7K1TqESurzKvd9yH2LSoVMRdCuNjO3tssQN9oaRYzLfLRf
         Sf0naQnPnCOPezukVR100z0Gv6BvnZgcaU0fpuNCUhwarnm0eDW/NqjYjzNlpR12FTMa
         fnKOSFHpaP6/nIbPg53i2ZcJ0ieEA5LKYuhwub57/2dWBGtYfzjGtMC8+DEXJhui9/v4
         Ee3phOyxXwunu+yr5sdK+cF9sUqHmFv14NCsuwqJJHtv6Og3MfqoriJO25oSLwsIuPhi
         R2BQ==
X-Gm-Message-State: AOAM5318KKGka/OC6/xijR4yPw4R2zO8Gxk0x778uXd4mCNt/VMsbavt
        s3Q6qnUM956OyODOS+3dAHUsjkqfPF4P+/fH
X-Google-Smtp-Source: ABdhPJzx2J4XQFrmIoBy0bd6MN6hRXAxEc8PyL5gBeHOz9CpXtPzWHK63caDrE8Buxg/hsufnOC7rA==
X-Received: by 2002:aa7:d453:: with SMTP id q19mr8244525edr.384.1617710756878;
        Tue, 06 Apr 2021 05:05:56 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id jj15sm10987694ejc.99.2021.04.06.05.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 05:05:56 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH 2/4] RDMA/rtrs-clt: new sysfs attribute to print the latency of each path
Date:   Tue,  6 Apr 2021 14:05:51 +0200
Message-Id: <20210406120553.197848-3-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406120553.197848-1-gi-oh.kim@ionos.com>
References: <20210406120553.197848-1-gi-oh.kim@ionos.com>
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
index bc46b7a99ba0..fc6de514b328 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -354,6 +354,21 @@ static ssize_t rtrs_clt_hca_name_show(struct kobject *kobj,
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
@@ -397,6 +412,7 @@ static struct attribute *rtrs_clt_sess_attrs[] = {
 	&rtrs_clt_reconnect_attr.attr,
 	&rtrs_clt_disconnect_attr.attr,
 	&rtrs_clt_remove_path_attr.attr,
+	&rtrs_clt_cur_latency_attr.attr,
 	NULL,
 };
 
-- 
2.25.1

