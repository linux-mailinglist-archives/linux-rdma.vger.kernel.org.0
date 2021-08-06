Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C4D3E296D
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Aug 2021 13:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhHFLV7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Aug 2021 07:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242230AbhHFLVz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Aug 2021 07:21:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0CEC061799
        for <linux-rdma@vger.kernel.org>; Fri,  6 Aug 2021 04:21:40 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id hs10so14645316ejc.0
        for <linux-rdma@vger.kernel.org>; Fri, 06 Aug 2021 04:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SAE/NjhOdDPrJ6NpQuWo+pEKeFLpFrzk3z+YIKk6Jik=;
        b=SKfxmllpa70u6vU1PUax8jfSn3pSfY9ruTNQRg259ieizVkf0HWcTGCPAuH02ehhGs
         jHSlbERR0Y9ZbuE+Wa3jVVLjNkhKSMm531SJBg/6iwsWxHQ/8nONEHvW7U2UhN0ET+kK
         clApiH09mN30rkffFeGjG0enr2/KdaJPAE44BnSHNwR2a5PHAOT/RzSisCkx3A52BX1t
         H940Znl/m70hLgiR7iRTGSh468akPMi3vpcBqydX2qt1xHVglcaDhLFwnPApeF3tTugI
         OD27/2fi02fhxS8UU1gFlk6L7aUV+IZ/233b1Pi8VGpVLCqR2SlxAZVUxQCWg3/ULiH5
         /CCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SAE/NjhOdDPrJ6NpQuWo+pEKeFLpFrzk3z+YIKk6Jik=;
        b=aoQz2R20UShnEOc3P1Fy/ekjDzjqU3tu+rp0izFKxDFy7aSjz6JWXJz0+f4vqmMslo
         VNZZvI+u7O/CrxuOmKKqSfAZDSRAbjtcKOqSAvU0UJFDeDnoTY76198+Uy7h9B+MhH6+
         2zB+Q9y/EByKnHyR3+1iEkAnTJYaB3XuLQuHpV42deVf2fPF3Yq456CvMj/PXtQQ4Pi2
         0HMjSRHCj94cai64DlrVQVLmuojDrvom2s2rt7ezKg7X7DkecgkLIDJG2Fdb9KrkTY45
         02OextEhEmH/m1nQimc6b8gpXtwe4U/U+SEWF5T0u73LxvfJdF07/SuXSCAstR//fbqo
         VhLw==
X-Gm-Message-State: AOAM530WXrdBZW9FapI9+ldIfw4eoVVakkGJHGG3xAt+pXQm14FFXuRb
        T3dVBR2VaatYELVJsUTpW1jym6rEuhnDkA==
X-Google-Smtp-Source: ABdhPJx8pozMVBSwdo0KP+/s5yKrxl1ckTWlqs5y1uZWsOtqnWsqKs+h6BW2dVZvfdPkLGs0njbl8g==
X-Received: by 2002:a17:906:76c1:: with SMTP id q1mr9659449ejn.156.1628248898808;
        Fri, 06 Aug 2021 04:21:38 -0700 (PDT)
Received: from nb01533.pb.local ([2001:1438:4010:2540:9e61:8a1a:7868:3b15])
        by smtp.gmail.com with ESMTPSA id q11sm2794729ejb.10.2021.08.06.04.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:21:38 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH v2 for-next 2/6] RDMA/rtrs: Remove unused functions
Date:   Fri,  6 Aug 2021 13:21:08 +0200
Message-Id: <20210806112112.124313-3-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806112112.124313-1-haris.iqbal@ionos.com>
References: <20210806112112.124313-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@ionos.com>

The two functions are unused, so just remove them.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
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

