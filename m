Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF8E3DB92F
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 15:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238929AbhG3NSn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 09:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238937AbhG3NSm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Jul 2021 09:18:42 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331F1C06175F
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 06:18:38 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k4so5966085wms.3
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 06:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WoPUXUz948c94A+csjEJkfSs5ZrNmAzBhOOAfwUgLvE=;
        b=iBHCX6ptNT0pvn+H7CJXUE0cIeYn9bCCmEsu590sJfAaai98qE9bDPS//qkXZkl3q6
         2dyq2xUoxCwnQuYBqkEmZ0d4yASJkN8z8PDIQV8q8T+Ymf0N96PXj3nN2rn77lV+6JAf
         KHnDVUUMf/49RkU3r/HP/XlmyW/P1vzrH2N9N78QVmN+IuJfxK0wIbTz4u7J+WWF2hVf
         e9EqumsGwdgvh5wBRme4T6GckOFCUKHfhIp0siZqMZNxJ00k7pj3XqQi6VRZRUTz+e1V
         2mtcUz0UstEO0KL5tVeFxgu4YSrqwkYf19yq213KuR74Y/LV9GovJE1WLu9bgBzbdKsd
         xoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WoPUXUz948c94A+csjEJkfSs5ZrNmAzBhOOAfwUgLvE=;
        b=T8MezzCsgn/K6o4f+STTyBatexYpoeGc+nRNKdvL4m09Mt7Owgf/sDPqp2OlN0eUKJ
         1QqXLlQvMx5h7tYtz8hEqdIu6hU57+EhOCBvFmzmOgwIxlMIC2Y+ntj+CR6a0aQJadaS
         vCvQbn3JhP1Wh6YFYsRnw/xyYo7eBcEvztcEnGf2hXm7dpUnbgmVF80y0En9K9CuOtAg
         03h/aDYWl2881hYGsPzwdxZa/4Dgho3nr7jlPSYgJilpbIc67Cyj19C3emo/aQWYCFyz
         Ty8JK4/GOU1lFcnHk/sCU/UXThCyum8IBtz7uyb/irncp88rrsF+6g9l6waMRv4Jf3YZ
         7bSg==
X-Gm-Message-State: AOAM533aunMfKVgXW2WKIiwJb8iU8ZSbZIxzHE/09u94HXHrxOpYoZHh
        25k18gvsKRdEq2D1MB1BUUrGjQTUNtN19g==
X-Google-Smtp-Source: ABdhPJwmo1pb2DLhtiZsdZGYqHjsJlRd+X9t246lNza96PAci5Yzzqrnvi6eN145ekkJAjKvRUckdQ==
X-Received: by 2002:a05:600c:3510:: with SMTP id h16mr2914779wmq.65.1627651116690;
        Fri, 30 Jul 2021 06:18:36 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:496a:8500:4512:4a6e:16f3:2377])
        by smtp.gmail.com with ESMTPSA id z5sm1626012wmp.26.2021.07.30.06.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 06:18:36 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH for-next 04/10] RDMA/rtrs: Remove unused functions
Date:   Fri, 30 Jul 2021 15:18:26 +0200
Message-Id: <20210730131832.118865-5-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210730131832.118865-1-jinpu.wang@ionos.com>
References: <20210730131832.118865-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The two functions are unused, so just remove them.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.h | 5 +----
 drivers/infiniband/ulp/rtrs/rtrs-srv.h | 4 ----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index 3c3ff094588c..72f9136e3c24 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -229,10 +229,7 @@ int rtrs_clt_stats_migration_cnt_to_str(struct rtrs_clt_stats *stats, char *buf,
 					 size_t len);
 int rtrs_clt_reset_reconnects_stat(struct rtrs_clt_stats *stats, bool enable);
 int rtrs_clt_stats_reconnects_to_str(struct rtrs_clt_stats *stats, char *buf,
-				      size_t len);
-int rtrs_clt_reset_wc_comp_stats(struct rtrs_clt_stats *stats, bool enable);
-int rtrs_clt_stats_wc_completion_to_str(struct rtrs_clt_stats *stats, char *buf,
-					 size_t len);
+				     size_t len);
 int rtrs_clt_reset_rdma_stats(struct rtrs_clt_stats *stats, bool enable);
 ssize_t rtrs_clt_stats_rdma_to_str(struct rtrs_clt_stats *stats,
 				    char *page, size_t len);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
index e81774f5acd3..9d8d2a91a235 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -138,10 +138,6 @@ static inline void rtrs_srv_update_rdma_stats(struct rtrs_srv_stats *s,
 int rtrs_srv_reset_rdma_stats(struct rtrs_srv_stats *stats, bool enable);
 ssize_t rtrs_srv_stats_rdma_to_str(struct rtrs_srv_stats *stats,
 				    char *page, size_t len);
-int rtrs_srv_reset_wc_completion_stats(struct rtrs_srv_stats *stats,
-					bool enable);
-int rtrs_srv_stats_wc_completion_to_str(struct rtrs_srv_stats *stats, char *buf,
-					 size_t len);
 int rtrs_srv_reset_all_stats(struct rtrs_srv_stats *stats, bool enable);
 ssize_t rtrs_srv_reset_all_help(struct rtrs_srv_stats *stats,
 				 char *page, size_t len);
-- 
2.25.1

