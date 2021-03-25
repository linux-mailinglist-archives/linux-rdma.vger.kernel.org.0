Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF8A3495AE
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhCYPdy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhCYPdf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:33:35 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC0FC06175F
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z1so2892878edb.8
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f4XykaULLm/H2BAHIppcboAz/DEhe60yxW9/E6NuP0o=;
        b=JddVpOtxcQ9CDcubfF9UMgPq6O9F7Mr0vBiDZ44fStmPbZTtH6CsfhCjsQeGg4Yg4E
         QPt4Yp5+ZsNDjw7GQe8AnEuIo4/d0vP41n/pT4AQecZwXTKQ9YTplBW6tCifV7klqq7V
         23crBJJYFdsuHpGN3wWoyNC9PY6ETA3sndC0bO29IZ5MNGHU10jbOFnfovtn9AK0kPrx
         A4OK0WNH8aCEHc9p+aSqo51aVH4TjzrNVhIvXtrwVxhFgGACUMIxiN847uwY94N7Bd+y
         oqOaBJkQrqqd4+jzXcq3XEmB6hY6Wyo5WIEXLqjs6awh14VB4BA/AIForwMiS8+KCbrN
         YArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f4XykaULLm/H2BAHIppcboAz/DEhe60yxW9/E6NuP0o=;
        b=uGIEJSqBgNM/+yIs6FJAOH1Y+Uq7NKwhPPPNbTJJOwOukyk44TKZSwUkIf2co0hSKc
         1eDHFRxYprv7daZng3iYJtL3i6ZhqkvcW8CnoYdknCs9PfljkVvZh3oHRUeYXsGn1jBM
         +mD43/9j1qz0byf1kAcmdY0ReBElYDU/n+c63WqaUgF3s+PdV5ixzWMHkHpwSToPovDU
         ZCbt0vUmxVjQx9wBLPwOSuNkqT/dGbPpsoWYtHzK7TU3o/8ZoaXz0zoUitmiJ+pMpCmY
         kq2ugD6w2ksoYzCZVL+j0olSC5kKc3sd1Q469HCYtvE5rFiB41A7vNNEcKQT3YAtOmCp
         1Xpg==
X-Gm-Message-State: AOAM533E86AJGFl+XwI9KF5X5VgjHD9tF+lOR6wbMBSYAqqTzZXwjU3w
        JC0nBOtSPTCXR+pvGGc/Em9PppXLQTmBsfrW
X-Google-Smtp-Source: ABdhPJwnChj8omwkEWOtliNjhkg+cJV6zpWB1eN1Hq0F8u+xT0aBZMBudWpnokKUfl+Uj5SET8IAPA==
X-Received: by 2002:aa7:ce1a:: with SMTP id d26mr9687101edv.206.1616686410187;
        Thu, 25 Mar 2021 08:33:30 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id n26sm2854750eds.22.2021.03.25.08.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:33:29 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 21/22] RDMA/rtrs-clt: new sysfs attribute to print the latency of each path
Date:   Thu, 25 Mar 2021 16:33:07 +0100
Message-Id: <20210325153308.1214057-22-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
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

