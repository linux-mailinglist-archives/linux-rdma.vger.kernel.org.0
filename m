Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527DF34959A
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhCYPdq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhCYPdS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:33:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C320CC06174A
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u21so3563035ejo.13
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k9DSpDdIDI7/ljoYeqOAAMTDPv5z8jBa0tFnB14dJ8Q=;
        b=Dl757kzcao7oi2z3lKKh1ZHb7upvvOkS0Lgi1160Ewt3k4birrh/qOdghl//0MfZ+S
         RA8p6dGt2ZX3MknpBuL6nb0anvCSW97u7+BWDw1IDa2wDgKauZX3MwOF357+3BsR+UYo
         grOBP/d8RzzZCCqCF4OKhbKKsXGbBEx1LNmYOZili+uQvpkV5Z1Lsp0rVzrDLM53SD05
         34XC3idN5n7zaql+hLOLoNHv66vBJbz+F/OoTnhRKgK+vlCCjiGjKc8uzaPI71FqSbNI
         +RJP8GbT0bHdDWiCEj7FU/gY3vIOphvGu9j+qumW5h0tFfwPJDYyOqlCR9nlBiFa8LQS
         6g6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k9DSpDdIDI7/ljoYeqOAAMTDPv5z8jBa0tFnB14dJ8Q=;
        b=LFvPjYWeI/nM4b3XOxC7RJtLyUNXe24eKDB6NwSLFI/2llUByzlmeD2a+MdWQfjOty
         ZyRitKqbE/ZxyZZaqNf9y2E5tw3KhpRPlLiGfraw17hvN1zg0TiteAEAbULiMdi+Pgja
         1+f1Pyor0UNccXevzh+PYuLKP7QyAhC7TqN2nQAIg+PojvuEaMJDXYA1CWo5HHMaye73
         pYUBZyXLtBCX+l+aWd0ljOATTp1VO3fFntRYQDQ9HT1nQl7iGapfYSknagurAka8HTth
         5XyggWOZAV7uR9H9VZ1nM9njY/bIxTImdd1ATHP5Qj5hO1AH6chU4RlO9kYWclk9DwfR
         bs1g==
X-Gm-Message-State: AOAM530FcI7H18aawLhd/UBuUO8EF0Xg0m6FKeLUmpGdVj1lH2Gmu8h7
        O+EYx74hD28ZCwPQOHMJBv9cpp5Ubr2SaSDM
X-Google-Smtp-Source: ABdhPJxv+CRKFDMhxo44UyymY5/VY2O29Q6d1Fe9bKy6J1VYpiXgu5I/7I8u/gIcsRqIPhmWefQQMA==
X-Received: by 2002:a17:906:78d:: with SMTP id l13mr10264552ejc.97.1616686396401;
        Thu, 25 Mar 2021 08:33:16 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id n26sm2854750eds.22.2021.03.25.08.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:33:16 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH for-next 04/22] RDMA/rtrs-srv: Inject a fault at heart-beat sending
Date:   Thu, 25 Mar 2021 16:32:50 +0100
Message-Id: <20210325153308.1214057-5-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

If the fault-injection is enabled, it does not send a heart-beat
and generates the error on the client side.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 44 ++++++++++++++++++++
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       |  5 +++
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       | 13 ++++++
 3 files changed, 62 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index 126a96e75c62..7ac3fe884409 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -313,3 +313,47 @@ void rtrs_srv_destroy_sess_files(struct rtrs_srv_sess *sess)
 		rtrs_srv_destroy_once_sysfs_root_folders(sess);
 	}
 }
+
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+void rtrs_srv_fault_inject_init(struct rtrs_srv_fault_inject *fault_inject,
+				struct rtrs_srv_sess *sess)
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
+			      "fail-hb-ack", &fault_inject->fail_hb_ack);
+}
+
+void rtrs_srv_fault_inject_final(struct rtrs_srv_fault_inject *fault_inject)
+{
+	rtrs_fault_inject_final(&fault_inject->fj);
+}
+
+int rtrs_should_fail_hb_ack(struct rtrs_srv_fault_inject *fault_inject)
+{
+	if (fault_inject->fail_hb_ack && should_fail(&fault_inject->fj.attr, 1))
+		return fault_inject->fj.status;
+	return 0;
+}
+#else
+void rtrs_srv_fault_inject_init(struct rtrs_srv_fault_inject *fault_inject,
+				struct rtrs_srv_sess *sess_name)
+{
+}
+void rtrs_srv_fault_inject_final(struct rtrs_srv_fault_inject *fault_inject)
+{
+}
+int rtrs_should_fail_hb_ack(struct rtrs_srv_fault_inject *fault_inject)
+{
+	return 0;
+}
+#endif
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 37ba121564a2..e9998e40f2f7 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1232,6 +1232,8 @@ static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 			}
 		} else if (imm_type == RTRS_HB_MSG_IMM) {
 			WARN_ON(con->c.cid);
+			if (unlikely(rtrs_should_fail_hb_ack(&sess->fault_inject)))
+				break;
 			rtrs_send_hb_ack(&sess->s);
 		} else if (imm_type == RTRS_HB_ACK_IMM) {
 			WARN_ON(con->c.cid);
@@ -1489,6 +1491,7 @@ static void rtrs_srv_close_work(struct work_struct *work)
 
 	sess = container_of(work, typeof(*sess), close_work);
 
+	rtrs_srv_fault_inject_final(&sess->fault_inject);
 	rtrs_srv_destroy_sess_files(sess);
 	rtrs_srv_stop_hb(sess);
 
@@ -1739,6 +1742,8 @@ static struct rtrs_srv_sess *__alloc_sess(struct rtrs_srv *srv,
 
 	__add_path_to_srv(srv, sess);
 
+	rtrs_srv_fault_inject_init(&sess->fault_inject, sess);
+
 	return sess;
 
 err_unmap_bufs:
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
index 9543ae19996c..001889e148ac 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/refcount.h>
 #include "rtrs-pri.h"
+#include "rtrs-fault.h"
 
 /*
  * enum rtrs_srv_state - Server states.
@@ -73,6 +74,13 @@ struct rtrs_srv_mr {
 	struct rtrs_iu	*iu;		/* send buffer for new rkey msg */
 };
 
+struct rtrs_srv_fault_inject {
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+	struct rtrs_fault_inject fj;
+	bool fail_hb_ack;
+#endif
+};
+
 struct rtrs_srv_sess {
 	struct rtrs_sess	s;
 	struct rtrs_srv	*srv;
@@ -90,6 +98,7 @@ struct rtrs_srv_sess {
 	unsigned int		mem_bits;
 	struct kobject		kobj;
 	struct rtrs_srv_stats	*stats;
+	struct rtrs_srv_fault_inject	fault_inject;
 };
 
 struct rtrs_srv {
@@ -152,4 +161,8 @@ ssize_t rtrs_srv_reset_all_help(struct rtrs_srv_stats *stats,
 int rtrs_srv_create_sess_files(struct rtrs_srv_sess *sess);
 void rtrs_srv_destroy_sess_files(struct rtrs_srv_sess *sess);
 
+void rtrs_srv_fault_inject_init(struct rtrs_srv_fault_inject *fault_inject,
+				struct rtrs_srv_sess *sess);
+void rtrs_srv_fault_inject_final(struct rtrs_srv_fault_inject *fault_inject);
+int rtrs_should_fail_hb_ack(struct rtrs_srv_fault_inject *fault_inject);
 #endif /* RTRS_SRV_H */
-- 
2.25.1

