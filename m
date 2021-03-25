Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6459E34959D
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhCYPdr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhCYPdR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:33:17 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CF9C061761
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id e14so3572298ejz.11
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lDV7JonCYGQdD+L2CIi4xjRjTcPbfiJy/4cE5d4EaOw=;
        b=UdpfwI0vSFKjR6jak70EOgBgk8Sb80jm4y1R18UYsw/vuJma1vUzYWAYPx9/SmKVxh
         X30v4Yy/Ag5auuR8WehPyrxCcUUmqhGwRZylF4ICcTUX4xToBnYRJiNiSdcDK4r1kPQV
         vAOAWAZC/95BOHmdvy3Zjsss7htBTMRpKYJGRTyCnnsmuQ+dYfGB2GSdRpKIaQrFArQc
         mAt30d2J50YMTs7KkUDF1pevsOhKvaS66BXPGzNRO4LppKXklMsnKr1pCh9hbNRFJW7U
         YYMgCeYj3Cy4zyTMQBD7cQ6lmVxJZ90Ons3oSjd97j6AyM/IQRp3lL+ixbxSjR96FXBH
         bENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lDV7JonCYGQdD+L2CIi4xjRjTcPbfiJy/4cE5d4EaOw=;
        b=LEn7R8bJAKPLZydSPFzIyluZYQtv29m0RcgIP9jCqrEMQ7e4znEm7WlPhXNlfN9HqL
         EpVPbubH6ev+wydSFTJBl87XGYW+7rMGGeXEC8j6oBC8MHuHJwULsrql9GlRq/Ib+wgT
         qktkiiKt6oCoY6WyymyHJyV0jqUUTCEVZ8Up7bw5iiUgutCQJZ5/GrXR5YyR0+Wb/XjO
         xwv75BZ6LWqiHuGclQkoED2hOYogt1ooaYkNGo7HLlqoz/8xcKqAXBydRfym+IeMWJPb
         86Tz46mB82DfORpb+Dihp7maw6JP25hDzdUcfxH/hFy0S/J1CBNsmIuXLP+5mVmAxOYy
         VgIg==
X-Gm-Message-State: AOAM531/Cu/IDsx1WnkyTJJOSQpuDwNw/7VeF7Ir18myryyZkQFLqzDs
        bakeZpHmnX5i+0fZyQ9EoNgAvVpiOPLFW0lE
X-Google-Smtp-Source: ABdhPJyNMCByRc8Xgo37oSTXodRbEvKGrLgNk27wA3o+Qp0vOT7RTBfzEL/IBSHiZGhCf/6qkSKIfQ==
X-Received: by 2002:a17:906:819:: with SMTP id e25mr10298956ejd.292.1616686395781;
        Thu, 25 Mar 2021 08:33:15 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id n26sm2854750eds.22.2021.03.25.08.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:33:15 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH for-next 03/22] RDMA/rtrs-clt: Inject a fault at request processing
Date:   Thu, 25 Mar 2021 16:32:49 +0100
Message-Id: <20210325153308.1214057-4-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
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
index b6a0abf40589..d168bd08037a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -480,3 +480,47 @@ void rtrs_clt_destroy_sysfs_root(struct rtrs_clt *clt)
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
index f95955fc2992..4f7690137e42 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1472,6 +1472,7 @@ static struct rtrs_clt_sess *alloc_sess(struct rtrs_clt *clt,
 
 void free_sess(struct rtrs_clt_sess *sess)
 {
+	rtrs_clt_fault_inject_final(&sess->fault_inject);
 	free_percpu(sess->mp_skip_entry);
 	mutex_destroy(&sess->init_mutex);
 	kfree(sess->s.con);
@@ -2689,6 +2690,8 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 			free_sess(sess);
 			goto close_all_sess;
 		}
+
+		rtrs_clt_fault_inject_init(&sess->fault_inject, sess);
 	}
 	err = alloc_permits(clt);
 	if (err)
@@ -2861,6 +2864,10 @@ int rtrs_clt_request(int dir, struct rtrs_clt_req_ops *ops,
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

