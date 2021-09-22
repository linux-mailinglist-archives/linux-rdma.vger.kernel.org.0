Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6204149C0
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Sep 2021 14:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbhIVMzM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Sep 2021 08:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbhIVMzM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Sep 2021 08:55:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EF6C061574
        for <linux-rdma@vger.kernel.org>; Wed, 22 Sep 2021 05:53:42 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w17so6399866wrv.10
        for <linux-rdma@vger.kernel.org>; Wed, 22 Sep 2021 05:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TokeasERpDA/o3cDSrmM/KEfSOBhSvrT5GhAQzJxwzg=;
        b=VGV5UofDVDQihX2TfpeAnoAGrwKFFeQt554W0cIKzHY/MTmA1iYoJoSeofdbykP/8B
         fzr3Eb1ogkE/32rHsV28Ef2HhRUsc/PV7hIRvUeVLXH8QKqhbZQK0W4+1Q9Nz16p/5Fe
         ElZ7xMhWFwCFb/XFwW1frnp6Rx1Y0tJY+entD5VPSCQ4DhLjxQnA1k+hO6YOBQjCIS3Y
         5/GwzVnTNKgaNEXSIazM801cXNgOI3ZxuQc48fuuK/zKfzVaFQtkiCkXKcjCE814XgT2
         8FlZO6vepNhr6LU2Gayp/y8oGVyO/ofNz6CizNzERSvFjaN/Cf/9kJqc5U8KJHFqjsBa
         MSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TokeasERpDA/o3cDSrmM/KEfSOBhSvrT5GhAQzJxwzg=;
        b=ADNHTRVx7qwt4dUgKM10legfekha9sHXAEL1ZkZr8oPs+2/Sa4QUKD+I4gGSdVgQ8x
         yO1OyZc/+Jfby91bf1VptdDpV702Vyo6xoJZ1U99nyqldvP722jigSlLtwBmuLOP5IEf
         00ZRDmrAcdE57dGpLl+INCoCudnPPE+a9fE0fgNqM+yYFuiRrKNxwE7BXeJlrN0e2Li6
         Eky2w0WRzB3oGs4d3b7RFHPDXBTYA5qkczClx/AQP+OxLfFqtvgabEA2pu73dXdSHlkU
         GKJe0qUMHdfBn4c4ITwi0AHgdq9DOZIg6tvhSXHLy09bxBRkxfVmyqnQCBCqofy/BJjl
         ic7w==
X-Gm-Message-State: AOAM5306uX0OLFpfOQpPt3QRV86uR+i45E7wLEMxLcq8Bx7zwr76UWr8
        HlGk50pMkhavBBgR+pe6u9lu726pEIw7LA==
X-Google-Smtp-Source: ABdhPJxWpUyNC4IaWoRee/fYWU74UR9Gqc4qC3d2HCXd6dy07eFDiDaUlHW40CUB4ekZe+BcPhUwZA==
X-Received: by 2002:a5d:6d8e:: with SMTP id l14mr41229932wrs.270.1632315220507;
        Wed, 22 Sep 2021 05:53:40 -0700 (PDT)
Received: from nb01533.pb.local ([2001:1438:4010:2540:40a5:9868:5a83:f3b9])
        by smtp.gmail.com with ESMTPSA id j20sm2173685wrb.5.2021.09.22.05.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 05:53:40 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH for-next 1/7] RDMA/rtrs: Use sysfs_emit instead of s*printf function for sysfs show
Date:   Wed, 22 Sep 2021 14:53:27 +0200
Message-Id: <20210922125333.351454-2-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210922125333.351454-1-haris.iqbal@ionos.com>
References: <20210922125333.351454-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

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
index 5e780bdd763d..9c27f21ec040 100644
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

