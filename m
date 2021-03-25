Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893263495A3
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhCYPdw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhCYPd0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:33:26 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6DCC06174A
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:25 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id b7so3641628ejv.1
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4GOVCq5OtxB+rmRICqyDm6g4IGdb+CHwcNoU1hFlwsY=;
        b=jDxcW45vTjBmzbNyaQEAhCJBt2Tq+S1TOVU4bY4BzzK63LV+SKSOmIAAdMNMkoy0Jo
         HCG4k2efkoWVbxx3uNZwwhqs5tCIDql+X9BO30wsbmfgGpTjEHVsb/Zz/B6jxj2w7Mov
         tbRyxSPJw9PRZg4i5Kp/erWX44cXkMV7SAb60Jma/uZrVHETkAbFzOJkgpg2Knbwj3ij
         rmRGjxE0BTwU+IUBWRGlP38IU5h6IAhJYxWu8kTcSJ/r+PsG0cwWKZks9hB1/a0L1YP0
         XtXDUbaW7I2eCkkBZs/lrWBFBtkUdb4Eb0xJ3TqChKdTVqsDnRQG2mFomzQKrwjctZUk
         eo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4GOVCq5OtxB+rmRICqyDm6g4IGdb+CHwcNoU1hFlwsY=;
        b=rwvJyl1BtdExP26540/8QeaggkhumYzAxBEowN5xc9raM7Nlv3gEAAznSEdZh6TR2v
         FibljxwYjDc6jElkIb35l+7bG4MF28/c1F287Nv/v0YBYNPmaoTvbm6IOXhJAdavulld
         qIE1eFBIhYZYv/cwyYd31vJOmH+o7fMdAMqv09fgz6Ygfz4IINMSW74FeTZdYy9tkayz
         v7F2+tIg7PqcqmzBvfl2jXxSkLe0cY/nUvP0F0IX2F75hN3pIPnhFSgsHVjqkcEcji/D
         6yeS406yktSx9mkZrnBHxrKJHRp7nwcPpd16aRAF9CYQJ6oGp3EdtEZ8ReOijZ4I49aN
         tj+Q==
X-Gm-Message-State: AOAM532HtJe69QJIrDnAUtnMZJjM+NUsPs04aLJLcNEZB19xBBm8dJYa
        J5Rvrh3l8h3055eQBU2W8zI2qJ5IXRSaHCzY
X-Google-Smtp-Source: ABdhPJzMeFwdbOFcDjSNFvlWbtq6EwiNAKW3l59GLhKbYd0DPJn7PHJeISBfedGPAckt4xWhunW53g==
X-Received: by 2002:a17:906:f56:: with SMTP id h22mr10305626ejj.494.1616686404236;
        Thu, 25 Mar 2021 08:33:24 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id n26sm2854750eds.22.2021.03.25.08.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:33:23 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 13/22] RDMA/rtrs: New function converting rtrs_addr to string
Date:   Thu, 25 Mar 2021 16:32:59 +0100
Message-Id: <20210325153308.1214057-14-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

There are common code converting addresses of source
machine and destination machine to one string.
We already have a struct rtrs_addr to store two addresses.
This patch introduces a new function that converts
two addresses into one string with struct rtrs_addr.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 13 +++++------
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 13 +++++------
 drivers/infiniband/ulp/rtrs/rtrs.c           | 24 ++++++++++++++++++++
 drivers/infiniband/ulp/rtrs/rtrs.h           |  1 +
 4 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index d168bd08037a..c502dcbae9bb 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -396,14 +396,13 @@ int rtrs_clt_create_sess_files(struct rtrs_clt_sess *sess)
 {
 	struct rtrs_clt *clt = sess->clt;
 	char str[NAME_MAX];
-	int err, cnt;
-
-	cnt = sockaddr_to_str((struct sockaddr *)&sess->s.src_addr,
-			      str, sizeof(str));
-	cnt += scnprintf(str + cnt, sizeof(str) - cnt, "@");
-	sockaddr_to_str((struct sockaddr *)&sess->s.dst_addr,
-			str + cnt, sizeof(str) - cnt);
+	int err;
+	struct rtrs_addr path = {
+		.src = &sess->s.src_addr,
+		.dst = &sess->s.dst_addr,
+	};
 
+	rtrs_addr_to_str(&path, str, sizeof(str));
 	err = kobject_init_and_add(&sess->kobj, &ktype_sess, clt->kobj_paths,
 				   "%s", str);
 	if (err) {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index 309693434870..57af9e7c3588 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -259,14 +259,13 @@ int rtrs_srv_create_sess_files(struct rtrs_srv_sess *sess)
 	struct rtrs_srv *srv = sess->srv;
 	struct rtrs_sess *s = &sess->s;
 	char str[NAME_MAX];
-	int err, cnt;
-
-	cnt = sockaddr_to_str((struct sockaddr *)&sess->s.dst_addr,
-			      str, sizeof(str));
-	cnt += scnprintf(str + cnt, sizeof(str) - cnt, "@");
-	sockaddr_to_str((struct sockaddr *)&sess->s.src_addr,
-			str + cnt, sizeof(str) - cnt);
+	int err;
+	struct rtrs_addr path = {
+		.src = &sess->s.dst_addr,
+		.dst = &sess->s.src_addr,
+	};
 
+	rtrs_addr_to_str(&path, str, sizeof(str));
 	err = rtrs_srv_create_once_sysfs_root_folders(sess);
 	if (err)
 		return err;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 5822cb088eef..1dd772d84e71 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -463,6 +463,30 @@ int sockaddr_to_str(const struct sockaddr *addr, char *buf, size_t len)
 }
 EXPORT_SYMBOL(sockaddr_to_str);
 
+/**
+ * rtrs_addr_to_str() - convert rtrs_addr to a string "src@dst"
+ * @addr:	the rtrs_addr structure to be converted
+ * @str:	string containing source and destination addr of a path
+ *		separated by '@' I.e. "ip:1.1.1.1@ip:1.1.1.2"
+ *		"ip:1.1.1.1@ip:1.1.1.2".
+ * @len:	string length
+ *
+ * The return value is the number of characters written into buf not
+ * including the trailing '\0'.
+ */
+int rtrs_addr_to_str(const struct rtrs_addr *addr, char *buf, size_t len)
+{
+	int cnt;
+
+	cnt = sockaddr_to_str((struct sockaddr *)addr->src,
+			      buf, len);
+	cnt += scnprintf(buf + cnt, len - cnt, "@");
+	sockaddr_to_str((struct sockaddr *)addr->dst,
+			buf + cnt, len - cnt);
+	return cnt;
+}
+EXPORT_SYMBOL(rtrs_addr_to_str);
+
 /**
  * rtrs_addr_to_sockaddr() - convert path string "src,dst" or "src@dst"
  * to sockaddreses
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.h b/drivers/infiniband/ulp/rtrs/rtrs.h
index a7e9ae579686..966c1e5ad68e 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs.h
@@ -184,4 +184,5 @@ int rtrs_addr_to_sockaddr(const char *str, size_t len, u16 port,
 			  struct rtrs_addr *addr);
 
 int sockaddr_to_str(const struct sockaddr *addr, char *buf, size_t len);
+int rtrs_addr_to_str(const struct rtrs_addr *addr, char *buf, size_t len);
 #endif
-- 
2.25.1

