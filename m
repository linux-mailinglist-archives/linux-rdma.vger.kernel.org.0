Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BE43552B5
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 13:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343510AbhDFLvK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 07:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243291AbhDFLvJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 07:51:09 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D80C061756
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 04:51:01 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b7so21467608ejv.1
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 04:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yhYSkkjpU5IfIPXcZKK0yRLPqPmuK4dmhYnUCfX5zg8=;
        b=cwz/mHWtnT/66yWBTYV62zisuRSO/RSrOCLE9Kk2dvPq0nNI6wVJ1TMD5Z49DO30+q
         UydEyKWkfNavdIpeLcKKwzSHICRh8tPgOPaWhEbgL8mFSHezxgBSD1abscQ+AShAtpE2
         NGVTrE6s540C9/2qNUq+huloMG4s58XhPeGGxXij4Rj/Sg2zfkz0KyQGAczUM2VVZrR2
         1fmdthedyl9fFkur18z7prynvZ5A5UKU4DfY0mIYNQK3Zsd4XdWkvjLd3jTES9oTn+8P
         tYMPHJtSz1fP7V5in60qaasUANAWmuhfUlxzkJfD07KZQyhZztSUD84D7ppwJZF/gcfy
         qKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yhYSkkjpU5IfIPXcZKK0yRLPqPmuK4dmhYnUCfX5zg8=;
        b=RJF8z5mrGJfl6MMnP1FyCd6zKuPUlU2s/cQ/z8Jj9LcSGnlam/Mf8LSiiFWhTeNggr
         RzUdM6+4dpq8qtoDpMcjy4Z1uzMMH7tYkzJ2fu2qR3xNs4DOBWHnkXuByQTmFHu0PaJE
         GV7m535IGxWjDAERYYG49rHlgeazyoJVDHT9nfkRtm74LHdy5KHjRWPmO0s3bHP77wzB
         jaGzwbYOZL+C/TqZIVRminoJ9gpBrusf7ZX8Y8YYIECZw33wW1zz2q2MNxkrmoGPCxh0
         5HknN0GIQ2qvJPqroOeUkzCrkb2XtPp7XN/nC0shq8c+BBI2sC/y6YL3scTAmpqfzKaz
         n8sQ==
X-Gm-Message-State: AOAM533O1M9IkftoP6IvEirnRUPVNaZAL66WU8AP1MkZ6CO+jf0rEFwM
        4kEBswd/lM/khDTVSX1twNHyaxUmUyTe60zd
X-Google-Smtp-Source: ABdhPJyPiWZU8lIdrp34G4ldr2FaQdACD8Lu1cLjzwLu1Xu5u5MFNTH80bmnr5jmu09Drua9C/iFKw==
X-Received: by 2002:a17:906:4810:: with SMTP id w16mr15788013ejq.207.1617709860292;
        Tue, 06 Apr 2021 04:51:00 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id t1sm855964eds.53.2021.04.06.04.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 04:51:00 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        akinobu.mita@gmail.com, corbet@lwn.net,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH 2/4] RDMA/rtrs-clt: Inject a fault at request processing
Date:   Tue,  6 Apr 2021 13:50:47 +0200
Message-Id: <20210406115049.196527-3-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406115049.196527-1-gi-oh.kim@ionos.com>
References: <20210406115049.196527-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

If the fault-injection is enabled, it does not sent a request to the
server and returns error.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 44 ++++++++++++++++++++
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       |  7 ++++
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       | 13 ++++++
 3 files changed, 64 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index eb92ec13cb57..c502dcbae9bb 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -479,3 +479,47 @@ void rtrs_clt_destroy_sysfs_root(struct rtrs_clt *clt)
 		kobject_put(clt->kobj_paths);
 	}
 }
+
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+void rtrs_clt_fault_inject_init(struct rtrs_clt_fault_inject *fault_inject,
+				struct rtrs_clt_sess *sess)
+{
+	char str[NAME_MAX];
+	int cnt;
+
+	cnt = sockaddr_to_str((struct sockaddr *)&sess->s.src_addr,
+			      str, sizeof(str));
+	cnt += scnprintf(str + cnt, sizeof(str) - cnt, "@");
+	sockaddr_to_str((struct sockaddr *)&sess->s.dst_addr,
+			str + cnt, sizeof(str) - cnt);
+
+	rtrs_fault_inject_init(&fault_inject->fj, str, -EBUSY);
+	/* injection points */
+	rtrs_fault_inject_add(fault_inject->fj.dir,
+			      "fail-request", &fault_inject->fail_request);
+}
+
+void rtrs_clt_fault_inject_final(struct rtrs_clt_fault_inject *fault_inject)
+{
+	rtrs_fault_inject_final(&fault_inject->fj);
+}
+
+int rtrs_clt_should_fail_request(struct rtrs_clt_fault_inject *fault_inject)
+{
+	if (fault_inject->fail_request && should_fail(&fault_inject->fj.attr, 1))
+		return fault_inject->fj.status;
+	return 0;
+}
+#else
+void rtrs_clt_fault_inject_init(struct rtrs_clt_fault_inject *fault_inject,
+				struct rtrs_clt_sess *sess)
+{
+}
+void rtrs_clt_fault_inject_final(struct rtrs_clt_fault_inject *fault_inject)
+{
+}
+int rtrs_clt_should_fail_request(struct rtrs_clt_fault_inject *fault_inject)
+{
+	return 0;
+}
+#endif
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 64990df81937..5062328ac577 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1469,6 +1469,7 @@ static struct rtrs_clt_sess *alloc_sess(struct rtrs_clt *clt,
 
 void free_sess(struct rtrs_clt_sess *sess)
 {
+	rtrs_clt_fault_inject_final(&sess->fault_inject);
 	free_percpu(sess->mp_skip_entry);
 	mutex_destroy(&sess->init_mutex);
 	kfree(sess->s.con);
@@ -2686,6 +2687,8 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 			free_sess(sess);
 			goto close_all_sess;
 		}
+
+		rtrs_clt_fault_inject_init(&sess->fault_inject, sess);
 	}
 	err = alloc_permits(clt);
 	if (err)
@@ -2858,6 +2861,10 @@ int rtrs_clt_request(int dir, struct rtrs_clt_req_ops *ops,
 		if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED))
 			continue;
 
+		err = rtrs_clt_should_fail_request(&sess->fault_inject);
+		if (unlikely(err))
+			continue;
+
 		if (unlikely(usr_len + hdr_len > sess->max_hdr_size)) {
 			rtrs_wrn_rl(sess->clt,
 				     "%s request failed, user message size is %zu and header length %zu, but max size is %u\n",
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index 692bc83e1f09..59ea2ec44fe5 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -12,6 +12,7 @@
 
 #include <linux/device.h>
 #include "rtrs-pri.h"
+#include "rtrs-fault.h"
 
 /**
  * enum rtrs_clt_state - Client states.
@@ -122,6 +123,13 @@ struct rtrs_rbuf {
 	u32 rkey;
 };
 
+struct rtrs_clt_fault_inject {
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+	struct rtrs_fault_inject fj;
+	bool fail_request;
+#endif
+};
+
 struct rtrs_clt_sess {
 	struct rtrs_sess	s;
 	struct rtrs_clt	*clt;
@@ -150,6 +158,7 @@ struct rtrs_clt_sess {
 	char                    hca_name[IB_DEVICE_NAME_MAX];
 	struct list_head __percpu
 				*mp_skip_entry;
+	struct rtrs_clt_fault_inject	fault_inject;
 };
 
 struct rtrs_clt {
@@ -250,4 +259,8 @@ int rtrs_clt_create_sess_files(struct rtrs_clt_sess *sess);
 void rtrs_clt_destroy_sess_files(struct rtrs_clt_sess *sess,
 				  const struct attribute *sysfs_self);
 
+void rtrs_clt_fault_inject_init(struct rtrs_clt_fault_inject *fault_inject,
+				struct rtrs_clt_sess *sess);
+void rtrs_clt_fault_inject_final(struct rtrs_clt_fault_inject *fault_inject);
+int rtrs_clt_should_fail_request(struct rtrs_clt_fault_inject *fault_inject);
 #endif /* RTRS_CLT_H */
-- 
2.25.1

