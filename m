Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F1657175B
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Jul 2022 12:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiGLKbV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jul 2022 06:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiGLKbU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Jul 2022 06:31:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3D7ACEF8
        for <linux-rdma@vger.kernel.org>; Tue, 12 Jul 2022 03:31:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b11so13476519eju.10
        for <linux-rdma@vger.kernel.org>; Tue, 12 Jul 2022 03:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gmVujBePXmmrW4p+h3rFQiuS7xsCFgZ6c7Mmdi7TSCU=;
        b=JcXSBH1uVP/MqNgZnZux0PHVQGy6TTgGoIxozRYQ3LOWZnMmf9MJWznHX39sn4zo2a
         qXTF5RXNNl1pzThw1L1jLuyMvKWrS5AKFMovDIn515XdfoZ3sfNXR22vvTR+XZGYCljx
         M+Nd1abxM5pZFlHnKexEx9eiDvwd6o/2/BBzIu8G/pvt21A/nepSpTYFg6ELiUrz8Q54
         ne//cC+LaJ6VfIE+JC7wKAjUBSArHoWJdxvIAMiawy4CxtiQdf5YzEhJVvSga/4hhFYt
         0Y9ONUS3wkM12Y8/r2E8vZGBwKhlgkG33rVhZRI/mijVTUbcOtBYYlfi5D51/gQS+S4K
         ZWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gmVujBePXmmrW4p+h3rFQiuS7xsCFgZ6c7Mmdi7TSCU=;
        b=zZJa/x5Y6jSc9FHh/8x8I5gRW3G+7FXusrRcpdUxHpfVMWnJvDeaVFeqfydnIyyU8x
         +DrY/mBc2eWLQqkGCz7Vsw0tMQw+qxmHv1RKUpQ3z1RkqsgrdALPqZ4fM5GRUforBZeU
         dNgSiZNhD5VODuRH7ce6+DNzuJp00Ahf5x+SaT/KCxH2+g+g0xzGQhJvp5Q3w8wLwUNi
         PZig3JrwJOfU1fYPEK0eIMaxdiakiruDdyi6uwjPd/vjM6sPDSqYfqIq7cnfIT1CHyXS
         cqRWBj6/6bHesORbKQWpBbjLWcw2oMAsc9J4+cqz5y/zv+Re6DIBRay5BJYSoyEv8bir
         x9cQ==
X-Gm-Message-State: AJIora9EMevTXWaOqSdfloZZZ1AdiTdm6nzyZ0ewozMXjwR54LaEedwj
        BuceI0caxNIwHwQTxk7rUokt/zpDqcjGYw==
X-Google-Smtp-Source: AGRyM1tONuGGVdSEuh2AwZ+Xr21/HHYQGKyeumzsm81GX7FqQaYb0HEegFttQFH5CokHHxbDuM7wFg==
X-Received: by 2002:a17:907:6d12:b0:72b:6e70:8c7d with SMTP id sa18-20020a1709076d1200b0072b6e708c7dmr5821860ejc.23.1657621878170;
        Tue, 12 Jul 2022 03:31:18 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id n18-20020aa7c452000000b004355d27799fsm5763419edr.96.2022.07.12.03.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 03:31:17 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com,
        Santosh Kumar Pradhan <santosh.pradhan@ionos.com>
Subject: [PATCH v2 for-next 3/5] RDMA/rtrs-srv: Use per-cpu variables for rdma stats
Date:   Tue, 12 Jul 2022 12:31:11 +0200
Message-Id: <20220712103113.617754-4-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712103113.617754-1-haris.iqbal@ionos.com>
References: <20220712103113.617754-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Santosh Kumar Pradhan <santosh.pradhan@ionos.com>

Convert server stat counters from atomic to per-cpu variables.

Signed-off-by: Santosh Kumar Pradhan <santosh.pradhan@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
v1 -> v2: No change

 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c | 32 +++++++++++++++-----
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  2 ++
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       |  9 +++++-
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       | 15 ++++-----
 4 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
index 44b1c1652131..2aff1213a19d 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
@@ -14,9 +14,14 @@
 int rtrs_srv_reset_rdma_stats(struct rtrs_srv_stats *stats, bool enable)
 {
 	if (enable) {
-		struct rtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
+		int cpu;
+		struct rtrs_srv_stats_rdma_stats *r;
+
+		for_each_possible_cpu(cpu) {
+			r = per_cpu_ptr(stats->rdma_stats, cpu);
+			memset(r, 0, sizeof(*r));
+		}
 
-		memset(r, 0, sizeof(*r));
 		return 0;
 	}
 
@@ -25,11 +30,22 @@ int rtrs_srv_reset_rdma_stats(struct rtrs_srv_stats *stats, bool enable)
 
 ssize_t rtrs_srv_stats_rdma_to_str(struct rtrs_srv_stats *stats, char *page)
 {
-	struct rtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
+	int cpu;
+	struct rtrs_srv_stats_rdma_stats sum;
+	struct rtrs_srv_stats_rdma_stats *r;
+
+	memset(&sum, 0, sizeof(sum));
+
+	for_each_possible_cpu(cpu) {
+		r = per_cpu_ptr(stats->rdma_stats, cpu);
+
+		sum.dir[READ].cnt	  += r->dir[READ].cnt;
+		sum.dir[READ].size_total  += r->dir[READ].size_total;
+		sum.dir[WRITE].cnt	  += r->dir[WRITE].cnt;
+		sum.dir[WRITE].size_total += r->dir[WRITE].size_total;
+	}
 
-	return sysfs_emit(page, "%lld %lld %lld %lldn %u\n",
-			  (s64)atomic64_read(&r->dir[READ].cnt),
-			  (s64)atomic64_read(&r->dir[READ].size_total),
-			  (s64)atomic64_read(&r->dir[WRITE].cnt),
-			  (s64)atomic64_read(&r->dir[WRITE].size_total), 0);
+	return sysfs_emit(page, "%llu %llu %llu %llu\n",
+			  sum.dir[READ].cnt, sum.dir[READ].size_total,
+			  sum.dir[WRITE].cnt, sum.dir[WRITE].size_total);
 }
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index b94ae12c2795..2a3c9ac64a42 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -220,6 +220,8 @@ static void rtrs_srv_path_stats_release(struct kobject *kobj)
 
 	stats = container_of(kobj, struct rtrs_srv_stats, kobj_stats);
 
+	free_percpu(stats->rdma_stats);
+
 	kfree(stats);
 }
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 24024bce2566..8278d3600a36 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1513,6 +1513,7 @@ static void free_path(struct rtrs_srv_path *srv_path)
 		kobject_del(&srv_path->kobj);
 		kobject_put(&srv_path->kobj);
 	} else {
+		free_percpu(srv_path->stats->rdma_stats);
 		kfree(srv_path->stats);
 		kfree(srv_path);
 	}
@@ -1755,13 +1756,17 @@ static struct rtrs_srv_path *__alloc_path(struct rtrs_srv_sess *srv,
 	if (!srv_path->stats)
 		goto err_free_sess;
 
+	srv_path->stats->rdma_stats = alloc_percpu(struct rtrs_srv_stats_rdma_stats);
+	if (!srv_path->stats->rdma_stats)
+		goto err_free_stats;
+
 	srv_path->stats->srv_path = srv_path;
 
 	srv_path->dma_addr = kcalloc(srv->queue_depth,
 				     sizeof(*srv_path->dma_addr),
 				     GFP_KERNEL);
 	if (!srv_path->dma_addr)
-		goto err_free_stats;
+		goto err_free_percpu;
 
 	srv_path->s.con = kcalloc(con_num, sizeof(*srv_path->s.con),
 				  GFP_KERNEL);
@@ -1813,6 +1818,8 @@ static struct rtrs_srv_path *__alloc_path(struct rtrs_srv_sess *srv,
 	kfree(srv_path->s.con);
 err_free_dma_addr:
 	kfree(srv_path->dma_addr);
+err_free_percpu:
+	free_percpu(srv_path->stats->rdma_stats);
 err_free_stats:
 	kfree(srv_path->stats);
 err_free_sess:
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
index 6292e87f6afd..186a63c217df 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -12,6 +12,7 @@
 
 #include <linux/device.h>
 #include <linux/refcount.h>
+#include <linux/percpu.h>
 #include "rtrs-pri.h"
 
 /*
@@ -29,15 +30,15 @@ enum rtrs_srv_state {
  */
 struct rtrs_srv_stats_rdma_stats {
 	struct {
-		atomic64_t	cnt;
-		atomic64_t	size_total;
+		u64 cnt;
+		u64 size_total;
 	} dir[2];
 };
 
 struct rtrs_srv_stats {
-	struct kobject				kobj_stats;
-	struct rtrs_srv_stats_rdma_stats	rdma_stats;
-	struct rtrs_srv_path			*srv_path;
+	struct kobject					kobj_stats;
+	struct rtrs_srv_stats_rdma_stats __percpu	*rdma_stats;
+	struct rtrs_srv_path				*srv_path;
 };
 
 struct rtrs_srv_con {
@@ -130,8 +131,8 @@ void close_path(struct rtrs_srv_path *srv_path);
 static inline void rtrs_srv_update_rdma_stats(struct rtrs_srv_stats *s,
 					      size_t size, int d)
 {
-	atomic64_inc(&s->rdma_stats.dir[d].cnt);
-	atomic64_add(size, &s->rdma_stats.dir[d].size_total);
+	this_cpu_inc(s->rdma_stats->dir[d].cnt);
+	this_cpu_add(s->rdma_stats->dir[d].size_total, size);
 }
 
 /* functions which are implemented in rtrs-srv-stats.c */
-- 
2.25.1

