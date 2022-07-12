Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC2E57175A
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Jul 2022 12:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiGLKbV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jul 2022 06:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiGLKbT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Jul 2022 06:31:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2379AD84C
        for <linux-rdma@vger.kernel.org>; Tue, 12 Jul 2022 03:31:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x91so9537049ede.1
        for <linux-rdma@vger.kernel.org>; Tue, 12 Jul 2022 03:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bL2qFotsttP72TZdh1Jw0d0woxIFD2og+CMnPKgAXYY=;
        b=KeWDfrGGEwuRkvIPPsLBuajm8gP0tsZxMs+TOnqXGsvaStxh9ViaLuAeIK6bwxIQyr
         bgPaIuFNUf8MVJJGxUKi7xnOgpThEKllMU03F83AV2PmJm22edGMyN7row+H0nMJ9kqT
         IepSFdOxPhxkEU23ADX1qhTy61bNk48sQBd4Ur5dKMEGfGn583flEWTbX9kLyEekiysg
         LQliwKcawEOzOG/6xvkT/QN9XdbRO7Vhg5JpCbUJkaAmScA2jRh+w4b5/I8vuXZkqZGz
         xDsD+5ejA3y1/SxfavVdYojXzhh92TpkeoLD09Q8pFeCVwZnqhC8RK0PgWxb/X3rUQ7D
         JUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bL2qFotsttP72TZdh1Jw0d0woxIFD2og+CMnPKgAXYY=;
        b=vtwZt/sTYRw9Jc9XXV/X6fBJJ1Bs3CMn30ft4s7tn0lOuVDFezP9gWn//c9MKLBgBJ
         Gfvbvc4um04O3QylPHTJ6sekTcl6uftjcfdqve1RMnCMIb8mHdpeqfsNI5oCYWTgxKRg
         sryoP7PF3lshb3AY74OEwKiXBxtPdmmkBMgGpEqCfmlG24jdsvxg32/F2P3xJEIdNrR8
         Cq12+ssH1hpC5zd8dYk8R8YUIurBD3DkTs5GPvQjqBxK86b5I+cPDmkwaBH56T5DjWMs
         qYbaesHZF1IiU0bprUSo+HkjtOi/O8va+koJDZwXrZzuzBu8ghmc38KGk59q6Tgh9V3L
         bOlA==
X-Gm-Message-State: AJIora/5lnhNXxXaA5Skwd2qF+1GVOvCkkTbB6pjB/0hMMUIbmCLsNJF
        g/9j6N381N69XmYZMb6IvsCRHfDBixVrvw==
X-Google-Smtp-Source: AGRyM1uepjpLH6x3kJ24L0TX6IZztVtqy+xGJqJCGT8ppM8zuMRAVWFEstYWDEKr43KF+CWCu0TvQA==
X-Received: by 2002:a05:6402:1e94:b0:43a:9e92:bf2 with SMTP id f20-20020a0564021e9400b0043a9e920bf2mr30870995edf.248.1657621877397;
        Tue, 12 Jul 2022 03:31:17 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id n18-20020aa7c452000000b004355d27799fsm5763419edr.96.2022.07.12.03.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 03:31:16 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com,
        Santosh Kumar Pradhan <santosh.pradhan@ionos.com>,
        Christoph Lameter <cl@linux.com>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: [PATCH v2 for-next 2/5] RDMA/rtrs-clt: Use this_cpu_ API for stats
Date:   Tue, 12 Jul 2022 12:31:10 +0200
Message-Id: <20220712103113.617754-3-haris.iqbal@ionos.com>
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

Use this_cpu_x() for increasing/adding a percpu counter through a
percpu pointer without the need to disable/enable preemption.

Suggested-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Santosh Kumar Pradhan <santosh.pradhan@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Reviewed-by: Christoph Lameter <cl@linux.com>
---
v1 -> v2: Added Acked-by, Reviewed-by.

 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
index 385a19846c24..1e6ffafa2db3 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
@@ -32,11 +32,7 @@ void rtrs_clt_update_wc_stats(struct rtrs_clt_con *con)
 
 void rtrs_clt_inc_failover_cnt(struct rtrs_clt_stats *stats)
 {
-	struct rtrs_clt_stats_pcpu *s;
-
-	s = get_cpu_ptr(stats->pcpu_stats);
-	s->rdma.failover_cnt++;
-	put_cpu_ptr(stats->pcpu_stats);
+	this_cpu_inc(stats->pcpu_stats->rdma.failover_cnt);
 }
 
 int rtrs_clt_stats_migration_from_cnt_to_str(struct rtrs_clt_stats *stats, char *buf)
@@ -169,12 +165,8 @@ int rtrs_clt_reset_all_stats(struct rtrs_clt_stats *s, bool enable)
 static inline void rtrs_clt_update_rdma_stats(struct rtrs_clt_stats *stats,
 					       size_t size, int d)
 {
-	struct rtrs_clt_stats_pcpu *s;
-
-	s = get_cpu_ptr(stats->pcpu_stats);
-	s->rdma.dir[d].cnt++;
-	s->rdma.dir[d].size_total += size;
-	put_cpu_ptr(stats->pcpu_stats);
+	this_cpu_inc(stats->pcpu_stats->rdma.dir[d].cnt);
+	this_cpu_add(stats->pcpu_stats->rdma.dir[d].size_total, size);
 }
 
 void rtrs_clt_update_all_stats(struct rtrs_clt_io_req *req, int dir)
-- 
2.25.1

