Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8840B3DB932
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 15:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238964AbhG3NSp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 09:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238958AbhG3NSp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Jul 2021 09:18:45 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A062AC06175F
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 06:18:39 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id f14-20020a05600c154eb02902519e4abe10so9163221wmg.4
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 06:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cglNi5sbjH/UruPM4dmVzfGLRlJu/atFoMDKVgS8CUk=;
        b=TR7M/9LDs0YFBhpjT/ENr9KM6a/d7ngqwVrQxu1fKBTi4FoGptfr+YJ8Wk4MctKr2C
         z0/rZJQZtN4gGRWHb2BinO+YelG6ilrZbkFoRlgenhjtWui9DHLZWKNf0+euUzyE5dFL
         j/qBVKD//qR5rA3WehgEcF4pyvyTnKlQcuTxMM5h/yamKAu3s27cXY1ZKCDy9YV/QJy8
         D8/m1wUwzbJDe86vnz3rXy3AvH8Qz1bYkXQg6pR9KajjO1wYBnA8RCY74njR5Sv22Gga
         Ft3fldoiT/bjzH77azjAZbyqMxDMiyh31bq25s3V/MxXHsuW35H6oM4Etd7CcZyvGWlE
         AhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cglNi5sbjH/UruPM4dmVzfGLRlJu/atFoMDKVgS8CUk=;
        b=hWO+qo+IlpfCxzoT1p/SIg0xqdk3C6weBK4Om71pZjUhwpx8PqvPK2rvlqM60PdjBa
         3GPcFzRC8p0UD/LdAIwurHAzNlmJxlkuTLF4DIa3JKW2Zt7twD7+Wfb+NtdNrrrFVNXh
         XiP2Q0P7aCWz+QWGtsF3jBAvenmaKMOEpZDJ3eSNAIUbjRIkme+V+Jnqww5Gq+89jw0p
         m0Dcd2yvOAlvZpozCDBrLcONMlIt7XIutYDJXv/pIQoUU8abTW/pmpbOqfhZ9H+FgTAS
         xQMohwTVY6Bx4AEJcIWro28eVPLd8adt4p/Wj1GIAqYimRIq/mJd/BlQysDI6n255az7
         qqVw==
X-Gm-Message-State: AOAM530HKOUlp6FfSP4YWqC+oEVcEaYx+LuiKAQ3Fy/tk02ksNtXbgUd
        Gr6G+ZiCL9lvMheiR3T4IrURZ5kozSf51A==
X-Google-Smtp-Source: ABdhPJzb3bpw99fWjhwsg/0J5NlkmIyV/r0Y8K344/DmeAy3D2xA4l8lAk3JzHJE1cJrKm+i5912dg==
X-Received: by 2002:a1c:7709:: with SMTP id t9mr3004689wmi.161.1627651118118;
        Fri, 30 Jul 2021 06:18:38 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:496a:8500:4512:4a6e:16f3:2377])
        by smtp.gmail.com with ESMTPSA id z5sm1626012wmp.26.2021.07.30.06.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 06:18:37 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH for-next 06/10] RDMA/rtrs: Remove len parameter from helper print functions of sysfs
Date:   Fri, 30 Jul 2021 15:18:28 +0200
Message-Id: <20210730131832.118865-7-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210730131832.118865-1-jinpu.wang@ionos.com>
References: <20210730131832.118865-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@ionos.com>

Since we have changed all sysfs show functions to use sysfs_emit, we do
not require the len (PAGE_SIZE) in our helper print functions. So remove
it from the function parameter.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 12 ++++--------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       | 12 +++++-------
 drivers/infiniband/ulp/rtrs/rtrs-pri.h       |  2 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c |  3 +--
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       |  3 +--
 5 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
index c5c047aa45a4..585f83cd7ed1 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
@@ -37,8 +37,7 @@ void rtrs_clt_inc_failover_cnt(struct rtrs_clt_stats *stats)
 	s->rdma.failover_cnt++;
 }
 
-int rtrs_clt_stats_migration_cnt_to_str(struct rtrs_clt_stats *stats,
-					 char *buf, size_t len)
+int rtrs_clt_stats_migration_cnt_to_str(struct rtrs_clt_stats *stats, char *buf)
 {
 	struct rtrs_clt_stats_pcpu *s;
 
@@ -66,15 +65,13 @@ int rtrs_clt_stats_migration_cnt_to_str(struct rtrs_clt_stats *stats,
 	return used;
 }
 
-int rtrs_clt_stats_reconnects_to_str(struct rtrs_clt_stats *stats, char *buf,
-				      size_t len)
+int rtrs_clt_stats_reconnects_to_str(struct rtrs_clt_stats *stats, char *buf)
 {
 	return sysfs_emit(buf, "%d %d\n", stats->reconnects.successful_cnt,
 			  stats->reconnects.fail_cnt);
 }
 
-ssize_t rtrs_clt_stats_rdma_to_str(struct rtrs_clt_stats *stats,
-				    char *page, size_t len)
+ssize_t rtrs_clt_stats_rdma_to_str(struct rtrs_clt_stats *stats, char *page)
 {
 	struct rtrs_clt_stats_rdma sum;
 	struct rtrs_clt_stats_rdma *r;
@@ -98,8 +95,7 @@ ssize_t rtrs_clt_stats_rdma_to_str(struct rtrs_clt_stats *stats,
 			 atomic_read(&stats->inflight), sum.failover_cnt);
 }
 
-ssize_t rtrs_clt_reset_all_help(struct rtrs_clt_stats *s,
-				 char *page, size_t len)
+ssize_t rtrs_clt_reset_all_help(struct rtrs_clt_stats *s, char *page)
 {
 	return sysfs_emit(page, "echo 1 to reset all statistics\n");
 }
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index 72f9136e3c24..c31f920e6d10 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -223,19 +223,17 @@ void rtrs_clt_update_all_stats(struct rtrs_clt_io_req *req, int dir);
 int rtrs_clt_reset_rdma_lat_distr_stats(struct rtrs_clt_stats *stats,
 					 bool enable);
 ssize_t rtrs_clt_stats_rdma_lat_distr_to_str(struct rtrs_clt_stats *stats,
-					      char *page, size_t len);
+					      char *page);
 int rtrs_clt_reset_cpu_migr_stats(struct rtrs_clt_stats *stats, bool enable);
-int rtrs_clt_stats_migration_cnt_to_str(struct rtrs_clt_stats *stats, char *buf,
-					 size_t len);
+int rtrs_clt_stats_migration_cnt_to_str(struct rtrs_clt_stats *stats, char *buf);
 int rtrs_clt_reset_reconnects_stat(struct rtrs_clt_stats *stats, bool enable);
-int rtrs_clt_stats_reconnects_to_str(struct rtrs_clt_stats *stats, char *buf,
-				     size_t len);
+int rtrs_clt_stats_reconnects_to_str(struct rtrs_clt_stats *stats, char *buf);
 int rtrs_clt_reset_rdma_stats(struct rtrs_clt_stats *stats, bool enable);
 ssize_t rtrs_clt_stats_rdma_to_str(struct rtrs_clt_stats *stats,
-				    char *page, size_t len);
+				    char *page);
 int rtrs_clt_reset_all_stats(struct rtrs_clt_stats *stats, bool enable);
 ssize_t rtrs_clt_reset_all_help(struct rtrs_clt_stats *stats,
-				 char *page, size_t len);
+				 char *page);
 
 /* rtrs-clt-sysfs.c */
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index d12ddfa50747..78eac9a4f703 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -398,7 +398,7 @@ static ssize_t get_value##_show(struct kobject *kobj,			\
 {									\
 	type *stats = container_of(kobj, type, kobj_stats);		\
 									\
-	return print(stats, page, PAGE_SIZE);			\
+	return print(stats, page);			\
 }
 
 #define STAT_ATTR(type, stat, print, reset)				\
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
index 12c374b5eb6e..44b1c1652131 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
@@ -23,8 +23,7 @@ int rtrs_srv_reset_rdma_stats(struct rtrs_srv_stats *stats, bool enable)
 	return -EINVAL;
 }
 
-ssize_t rtrs_srv_stats_rdma_to_str(struct rtrs_srv_stats *stats,
-				    char *page, size_t len)
+ssize_t rtrs_srv_stats_rdma_to_str(struct rtrs_srv_stats *stats, char *page)
 {
 	struct rtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
index 9d8d2a91a235..7d403c12faf3 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -136,8 +136,7 @@ static inline void rtrs_srv_update_rdma_stats(struct rtrs_srv_stats *s,
 
 /* functions which are implemented in rtrs-srv-stats.c */
 int rtrs_srv_reset_rdma_stats(struct rtrs_srv_stats *stats, bool enable);
-ssize_t rtrs_srv_stats_rdma_to_str(struct rtrs_srv_stats *stats,
-				    char *page, size_t len);
+ssize_t rtrs_srv_stats_rdma_to_str(struct rtrs_srv_stats *stats, char *page);
 int rtrs_srv_reset_all_stats(struct rtrs_srv_stats *stats, bool enable);
 ssize_t rtrs_srv_reset_all_help(struct rtrs_srv_stats *stats,
 				 char *page, size_t len);
-- 
2.25.1

