Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6C44149C6
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Sep 2021 14:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbhIVMzT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Sep 2021 08:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbhIVMzS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Sep 2021 08:55:18 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA689C06175F
        for <linux-rdma@vger.kernel.org>; Wed, 22 Sep 2021 05:53:48 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g16so6546318wrb.3
        for <linux-rdma@vger.kernel.org>; Wed, 22 Sep 2021 05:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a73u6je9MGQm1bgAVFcJn3E75fZC6Gtx6Eslm1ELbEs=;
        b=D1U6M3lzdiFdkrXqNAIS8PnGvFJfHlfKBic8458HvI69abqcnH0zADlNAYls3m05G9
         pDX2lWkG2nTT6Iq8q2CvqcinnA2phjqhjghyaiUKe/BRzgUIyAftE6DsXbLQQhPjR2wI
         WfeWp1PX9tt5aEPJy/YVN86WCbh8c44mLWKDTZzOp1nFU+KjtSzjevhK0Vscam8Wh7h1
         twtL3V3MNqS7gUc2rNtS0dFRR7tnTgFy9RwZtQ4jucGYbxpoza/dlETl3HSjBt8KiuO3
         l9Jk9JVFFjA2n0os/agzYoMeJ0E8NcZhWnW0KUMNi84PFYdgT89HgK5aiKFhVj/wpCa1
         AA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a73u6je9MGQm1bgAVFcJn3E75fZC6Gtx6Eslm1ELbEs=;
        b=CaE0ARolgU4ZOPM5W18jJvrNPRRSCpEpmUj1huPN/TceWaBbiRhDHlieFyriMs7OId
         ieS3bH7VaHB0ilCMIAibsGGlA6VZr8XCDfziP8bUfdwqNTWHXSD6ENR9cz3+bK89UhxT
         yyei++pqnsRooUDmWYJU1qNjRLSkkChX/Re0P7KxDa0ph0UFFgWdJfqOd8U3U3kf01v9
         UEW0iPe78ELJzlmlkhVtT92tGKKN4XkhhSbbXDzpccI+h9SDzM2q3Vk0VWV91hgFdEJY
         rQEW5RUhC/U3nhxEZ9+my9dVIzW0W8FIwyGbrwiOxtidJa1t8/GWZUsxuGORsWTVutah
         AVzQ==
X-Gm-Message-State: AOAM530iy2FpZzUSEyEmi0sF9RB74zbs7cAJSFTT9h6wixPosUvzUWrI
        SKANJNVf7reCOQkbYLaggPZN4AvisVkS2A==
X-Google-Smtp-Source: ABdhPJwErzFmPowoXWKrW4iI3FbvmeQqSC8NJa3bgC4ZAfoSC0iTp2p0ScNcSGUlo2m2NSKBgOTHMA==
X-Received: by 2002:a7b:ce19:: with SMTP id m25mr10088052wmc.152.1632315227327;
        Wed, 22 Sep 2021 05:53:47 -0700 (PDT)
Received: from nb01533.pb.local ([2001:1438:4010:2540:40a5:9868:5a83:f3b9])
        by smtp.gmail.com with ESMTPSA id j20sm2173685wrb.5.2021.09.22.05.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 05:53:47 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Aleksei Marov <aleksei.marov@ionos.com>
Subject: [PATCH for-next 7/7] RDMA/rtrs-clt: Follow "one entry one value" rule for IO migration stats
Date:   Wed, 22 Sep 2021 14:53:33 +0200
Message-Id: <20210922125333.351454-8-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210922125333.351454-1-haris.iqbal@ionos.com>
References: <20210922125333.351454-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This commit divides the sysfs entry cpu_migration into 2 different entries
One for "from cpus" and the other for "to cpus".

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 27 +++++++++++++-------
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 11 +++++---
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       |  3 ++-
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
index 61d5e0018392..f7e459fe68be 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
@@ -37,29 +37,38 @@ void rtrs_clt_inc_failover_cnt(struct rtrs_clt_stats *stats)
 	s->rdma.failover_cnt++;
 }
 
-int rtrs_clt_stats_migration_cnt_to_str(struct rtrs_clt_stats *stats, char *buf)
+int rtrs_clt_stats_migration_from_cnt_to_str(struct rtrs_clt_stats *stats, char *buf)
 {
 	struct rtrs_clt_stats_pcpu *s;
 
 	size_t used;
 	int cpu;
 
-	used = sysfs_emit(buf, "    ");
-	for_each_possible_cpu(cpu)
-		used += sysfs_emit_at(buf, used, " CPU%u", cpu);
-
-	used += sysfs_emit_at(buf, used, "\nfrom:");
+	used = 0;
 	for_each_possible_cpu(cpu) {
 		s = per_cpu_ptr(stats->pcpu_stats, cpu);
-		used += sysfs_emit_at(buf, used, " %d",
+		used += sysfs_emit_at(buf, used, "%d ",
 				  atomic_read(&s->cpu_migr.from));
 	}
 
-	used += sysfs_emit_at(buf, used, "\nto  :");
+	used += sysfs_emit_at(buf, used, "\n");
+
+	return used;
+}
+
+int rtrs_clt_stats_migration_to_cnt_to_str(struct rtrs_clt_stats *stats, char *buf)
+{
+	struct rtrs_clt_stats_pcpu *s;
+
+	size_t used;
+	int cpu;
+
+	used = 0;
 	for_each_possible_cpu(cpu) {
 		s = per_cpu_ptr(stats->pcpu_stats, cpu);
-		used += sysfs_emit_at(buf, used, " %d", s->cpu_migr.to);
+		used += sysfs_emit_at(buf, used, "%d ", s->cpu_migr.to);
 	}
+
 	used += sysfs_emit_at(buf, used, "\n");
 
 	return used;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index 4ee592ccf979..0e69180c3771 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -296,8 +296,12 @@ static struct kobj_attribute rtrs_clt_remove_path_attr =
 	__ATTR(remove_path, 0644, rtrs_clt_remove_path_show,
 	       rtrs_clt_remove_path_store);
 
-STAT_ATTR(struct rtrs_clt_stats, cpu_migration,
-	  rtrs_clt_stats_migration_cnt_to_str,
+STAT_ATTR(struct rtrs_clt_stats, cpu_migration_from,
+	  rtrs_clt_stats_migration_from_cnt_to_str,
+	  rtrs_clt_reset_cpu_migr_stats);
+
+STAT_ATTR(struct rtrs_clt_stats, cpu_migration_to,
+	  rtrs_clt_stats_migration_to_cnt_to_str,
 	  rtrs_clt_reset_cpu_migr_stats);
 
 STAT_ATTR(struct rtrs_clt_stats, reconnects,
@@ -313,7 +317,8 @@ STAT_ATTR(struct rtrs_clt_stats, reset_all,
 	  rtrs_clt_reset_all_stats);
 
 static struct attribute *rtrs_clt_stats_attrs[] = {
-	&cpu_migration_attr.attr,
+	&cpu_migration_from_attr.attr,
+	&cpu_migration_to_attr.attr,
 	&reconnects_attr.attr,
 	&rdma_attr.attr,
 	&reset_all_attr.attr,
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index 6d81aae53df4..9afffccff973 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -226,7 +226,8 @@ int rtrs_clt_reset_rdma_lat_distr_stats(struct rtrs_clt_stats *stats,
 ssize_t rtrs_clt_stats_rdma_lat_distr_to_str(struct rtrs_clt_stats *stats,
 					      char *page);
 int rtrs_clt_reset_cpu_migr_stats(struct rtrs_clt_stats *stats, bool enable);
-int rtrs_clt_stats_migration_cnt_to_str(struct rtrs_clt_stats *stats, char *buf);
+int rtrs_clt_stats_migration_from_cnt_to_str(struct rtrs_clt_stats *stats, char *buf);
+int rtrs_clt_stats_migration_to_cnt_to_str(struct rtrs_clt_stats *stats, char *buf);
 int rtrs_clt_reset_reconnects_stat(struct rtrs_clt_stats *stats, bool enable);
 int rtrs_clt_stats_reconnects_to_str(struct rtrs_clt_stats *stats, char *buf);
 int rtrs_clt_reset_rdma_stats(struct rtrs_clt_stats *stats, bool enable);
-- 
2.25.1

