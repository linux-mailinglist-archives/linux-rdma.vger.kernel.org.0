Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871033DB92E
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 15:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbhG3NSm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 09:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238890AbhG3NSm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Jul 2021 09:18:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F5EC06175F
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 06:18:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d8so11288611wrm.4
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 06:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Loqr2AeYIZuZk6MiTZIgumKJU6aYenJOQapXQ2RPPUY=;
        b=YrVSWZsMVciWuwmdyAv9Q3gX32Fis/mLcu/7ocJn1aRQxSvqpzhUCGf24z+Lir4wif
         K3iXxgOrDYo740Cl6GLVPwcQfwSWrbTzFb+QtXgdxo2Sck9ft6VtZuj5r2De2tHlUOUv
         hTl2vTlH4T+Q10dGYYCIcqbdTmmOMORBJmutQ1rg6FCtXh5a3H+o+RMeWlkI090PN1ru
         gfUg2vs+iYh1lcL5R6de02iyGWS7KlOad6TK8h8xbM1pVJ6Kvwxy9Bignv4UGk4ZyY+H
         StWpW+ItZ8aFpAAzenb+R5+OXktEJ2mbvFStLDcUj1xA12Ib52vkxXI8el+QktmNqkD5
         DVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Loqr2AeYIZuZk6MiTZIgumKJU6aYenJOQapXQ2RPPUY=;
        b=WPhjIpgJyPIZLYHxw744tyfOE5mSmK5FW/i6o88KYmuG0rJytpD6p3wUCWrNwxHL+m
         TrozS801X9Fj9BtooG2VUCsiSQtpCoAUfnTNgtY6RB3QGRKUJhi/u9rSXUB9WQww3MPz
         kaUTCgl83YIX4drTgSDR0q8isx8HKp9f1xR/UM/fmOpxIVAwid1Z7ZMMOmfoYjbbGRN2
         tb1UcwrlVlrvlIJZZBG7kaJO9lvPYhWhuHkHC6VuKANqjsCqmty1n7Hsz/CUbD2Y7A2P
         I6mXGHuPVX854zBa0B2uiL2s/2fLUwk0D4pwL0raY91foCyPa6SGbub5EqNUDf6LVw+h
         Hfrg==
X-Gm-Message-State: AOAM531qk1WeWz+IATJpp2uLGfyL3F3IMBOKSHmljN4i7AO7qeQdR012
        q/FiZ/ecWn+FOwuhdmnVEBRYh2zjIqcmPg==
X-Google-Smtp-Source: ABdhPJyvo/K17KY0HBs5AjTIrNkmugyFgOOV9MDb9MUEudmLdt2NQo3hnJ0s9XAhRUPBoQmHschygA==
X-Received: by 2002:a5d:68cc:: with SMTP id p12mr3091082wrw.161.1627651116096;
        Fri, 30 Jul 2021 06:18:36 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:496a:8500:4512:4a6e:16f3:2377])
        by smtp.gmail.com with ESMTPSA id z5sm1626012wmp.26.2021.07.30.06.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 06:18:35 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH for-next 03/10] RDMA/rtrs: Use sysfs_emit instead of s*printf function for sysfs show
Date:   Fri, 30 Jul 2021 15:18:25 +0200
Message-Id: <20210730131832.118865-4-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210730131832.118865-1-jinpu.wang@ionos.com>
References: <20210730131832.118865-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@ionos.com>

sysfs_emit function was added to be aware of the PAGE_SIZE maximum of
the temporary buffer used for outputting sysfs content, so there is no
possible overruns. So replace the uses of any s*printf functions for
the sysfs show functions with sysfs_emit.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 24 +++++++++-----------
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  2 +-
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
index 26bbe5d6dff5..c5c047aa45a4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
@@ -45,24 +45,23 @@ int rtrs_clt_stats_migration_cnt_to_str(struct rtrs_clt_stats *stats,
 	size_t used;
 	int cpu;
 
-	used = scnprintf(buf, len, "    ");
+	used = sysfs_emit(buf, "    ");
 	for_each_possible_cpu(cpu)
-		used += scnprintf(buf + used, len - used, " CPU%u", cpu);
+		used += sysfs_emit_at(buf, used, " CPU%u", cpu);
 
-	used += scnprintf(buf + used, len - used, "\nfrom:");
+	used += sysfs_emit_at(buf, used, "\nfrom:");
 	for_each_possible_cpu(cpu) {
 		s = per_cpu_ptr(stats->pcpu_stats, cpu);
-		used += scnprintf(buf + used, len - used, " %d",
+		used += sysfs_emit_at(buf, used, " %d",
 				  atomic_read(&s->cpu_migr.from));
 	}
 
-	used += scnprintf(buf + used, len - used, "\nto  :");
+	used += sysfs_emit_at(buf, used, "\nto  :");
 	for_each_possible_cpu(cpu) {
 		s = per_cpu_ptr(stats->pcpu_stats, cpu);
-		used += scnprintf(buf + used, len - used, " %d",
-				  s->cpu_migr.to);
+		used += sysfs_emit_at(buf, used, " %d", s->cpu_migr.to);
 	}
-	used += scnprintf(buf + used, len - used, "\n");
+	used += sysfs_emit_at(buf, used, "\n");
 
 	return used;
 }
@@ -70,9 +69,8 @@ int rtrs_clt_stats_migration_cnt_to_str(struct rtrs_clt_stats *stats,
 int rtrs_clt_stats_reconnects_to_str(struct rtrs_clt_stats *stats, char *buf,
 				      size_t len)
 {
-	return scnprintf(buf, len, "%d %d\n",
-			 stats->reconnects.successful_cnt,
-			 stats->reconnects.fail_cnt);
+	return sysfs_emit(buf, "%d %d\n", stats->reconnects.successful_cnt,
+			  stats->reconnects.fail_cnt);
 }
 
 ssize_t rtrs_clt_stats_rdma_to_str(struct rtrs_clt_stats *stats,
@@ -94,7 +92,7 @@ ssize_t rtrs_clt_stats_rdma_to_str(struct rtrs_clt_stats *stats,
 		sum.failover_cnt	  += r->failover_cnt;
 	}
 
-	return scnprintf(page, len, "%llu %llu %llu %llu %u %llu\n",
+	return sysfs_emit(page, "%llu %llu %llu %llu %u %llu\n",
 			 sum.dir[READ].cnt, sum.dir[READ].size_total,
 			 sum.dir[WRITE].cnt, sum.dir[WRITE].size_total,
 			 atomic_read(&stats->inflight), sum.failover_cnt);
@@ -103,7 +101,7 @@ ssize_t rtrs_clt_stats_rdma_to_str(struct rtrs_clt_stats *stats,
 ssize_t rtrs_clt_reset_all_help(struct rtrs_clt_stats *s,
 				 char *page, size_t len)
 {
-	return scnprintf(page, len, "echo 1 to reset all statistics\n");
+	return sysfs_emit(page, "echo 1 to reset all statistics\n");
 }
 
 int rtrs_clt_reset_rdma_stats(struct rtrs_clt_stats *stats, bool enable)
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index 20efd44297fb..9c43ce5ba1c1 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -102,7 +102,7 @@ static ssize_t rtrs_srv_src_addr_show(struct kobject *kobj,
 	sess = container_of(kobj, struct rtrs_srv_sess, kobj);
 	cnt = sockaddr_to_str((struct sockaddr *)&sess->s.dst_addr,
 			      page, PAGE_SIZE);
-	return cnt + scnprintf(page + cnt, PAGE_SIZE - cnt, "\n");
+	return cnt + sysfs_emit_at(page, cnt, "\n");
 }
 
 static struct kobj_attribute rtrs_srv_src_addr_attr =
-- 
2.25.1

