Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDA84149C1
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Sep 2021 14:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbhIVMzN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Sep 2021 08:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236035AbhIVMzN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Sep 2021 08:55:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61840C061756
        for <linux-rdma@vger.kernel.org>; Wed, 22 Sep 2021 05:53:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t18so6679169wrb.0
        for <linux-rdma@vger.kernel.org>; Wed, 22 Sep 2021 05:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N6VX/H4c/sdWPmihnLTXpmTVlPKJ98HDRev5YsFguYA=;
        b=TVb7GJ3rPm00YLTu0j60xQyEQgMRVEjKNSRsptQgiG/6cqAosmLBM9NrJP3EvdOs+S
         6Edrn/NepVMglo/+G/+28ZuQlee1LJ8NArP5e6nsMFGH/Mhjo46huln/eYkxBE+lLOwF
         mVVZwF5kHlaqSLnQW3x9wo3A5T8K8fFXVEnFnVJaUmoac0nxnWjN/RAwoLXODCdSzq6Q
         Ndi3BtfsCbbjDBx/R48nNi7MAjNxxyovrKLOpsEMCiHMa6y87wf1bv3i/HAgEgMgsIOq
         QtH/LDmkfsds5uz6X4kQbTpZCDXFoy+D1Nvymm8/49kjrTe+77DETA8wniLf1+vYxFt0
         mtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N6VX/H4c/sdWPmihnLTXpmTVlPKJ98HDRev5YsFguYA=;
        b=1zIXrx6KZytANyjfLTEEwPJHyyrC9Hs7Jqcj5LbqBpVQPVrt41f0awyJpV9fSPvARl
         MP9AzHRgIPMCOK2HPgVur8QTuT37k6dEVWEDm7MM2se8M54xNiB0ZlQ5J2wmjp6RJ++O
         T1YzLOxil4A2twW/hEKAtV7Usckp/i17oAwvRV5/DKqN1xs07XThnPZw15i2m8681Atn
         8+bRIB5OdQGU32BudqLaUvJb6jNkH/4zI4D7TcR/BKs26OgGMkVwwZi1VjyjLOi/G77L
         o60xa2gmp3Ypd26EcauCicVsykLyrGQ31Ub3IndhOQvxoBWVPJEPJYFw+lPhI++WWnB6
         Jfrg==
X-Gm-Message-State: AOAM5327AT4UH2rGcppQ6nqZJfLJMBTUUjMHOvC8ZxaDfq0CGv1KmATd
        n0i+S5qIio7vYdJh65mCO01ELjjouut9Ew==
X-Google-Smtp-Source: ABdhPJx+gzsT8xjrs3GHleSLekTUOUprrJjUiAe/JJDPAUXZDhcOGwgHL9S9+0SfqAcv9Gin7yl7Tw==
X-Received: by 2002:a5d:6741:: with SMTP id l1mr41857253wrw.289.1632315221804;
        Wed, 22 Sep 2021 05:53:41 -0700 (PDT)
Received: from nb01533.pb.local ([2001:1438:4010:2540:40a5:9868:5a83:f3b9])
        by smtp.gmail.com with ESMTPSA id j20sm2173685wrb.5.2021.09.22.05.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 05:53:41 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH for-next 2/7] RDMA/rtrs: Remove len parameter from helper print functions of sysfs
Date:   Wed, 22 Sep 2021 14:53:28 +0200
Message-Id: <20210922125333.351454-3-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210922125333.351454-1-haris.iqbal@ionos.com>
References: <20210922125333.351454-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

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
index 9c27f21ec040..61d5e0018392 100644
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
index 9dc819885ec7..6d81aae53df4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -224,19 +224,17 @@ void rtrs_clt_update_all_stats(struct rtrs_clt_io_req *req, int dir);
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

