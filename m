Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FE93941CD
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 13:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbhE1LcO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 07:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbhE1LcH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 07:32:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D951C061763
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:33 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id j9so4464696edt.6
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T0q/jMZciVG2+7gzShTXuQ1XSOgTAm8wBpLFKZiDIbE=;
        b=WMvSS6XOjck+Tz+YELscOm87RKF1soInSdKRuADY6bIh17LyctbGXMz8PCMLDxQudk
         YVzLCF+5g4PZMupVhIBMGb8v+Dh5o4JeZG8HhO3i6FzBklcZJtiIzlx47pCdmtnipAUp
         dC9rxNZFMSQkJx4gxCj8mCQM0ZgSvLHzzkYHnjlG5Aps8pH/atM2PxJlop1LKyUOG2aM
         8VlCOwwQwm1BYKhMtbrH/kM9cVeo70kjN+/pPsRooNN6L/Ya96pGwGh2M2HwsmgV/Scs
         yjO9CZ1NBJiGVBWuTqUppI1mnS6/s1ha7t+IlFNO9NM+btiHNx6z7yd/ZYH2KPjK+1UY
         x+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T0q/jMZciVG2+7gzShTXuQ1XSOgTAm8wBpLFKZiDIbE=;
        b=rLaaCol3gGnKs3PVmXwOUIKIn9xSl+BVG8qHErqy22M2847RT5yddz1wlpsqBoL05e
         MgtqZ9kGhkw7qCfonS1eE8RT55I+jjxt6jeTLIXp4fWPlWr+jf2QXNusm/9Pu7SfJTtn
         h1JInjPcrf9QftHGvF4Md+Wy5IlAsHuhraUN6S4L8kXzPc/zZC+HwawW7v3EPPO4Qm/h
         9luOzd8t2A4G98u7N7DlQDYzUmOir469jN7U4Hsrcd6kGRpDoaDs+LO4cYbwK9t96njW
         iCChITKPKQV3qW61zg/PdeDYT3Dz7/gu0jHjyDlyez2binRM7fULNNy+47Xf9/6yeI+0
         fIvA==
X-Gm-Message-State: AOAM5308qAePpyvEEIi2Dt7GsjRQ0K2+LK9la39+DDZLLoFEzHgUbMlP
        SBW2TfPWZj+Ai1flXCHFIOcMsVxc2MdDcQ==
X-Google-Smtp-Source: ABdhPJy9lIMEA5NoPxFckHl8EkB5SkNPvI5t2aLtGD1gQSJ2lKgcts47K1ERydZpTCg5BMPoqEntYw==
X-Received: by 2002:a50:ef15:: with SMTP id m21mr9200172eds.226.1622201431696;
        Fri, 28 May 2021 04:30:31 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:497d:7d00:983b:122a:4685:3849])
        by smtp.gmail.com with ESMTPSA id p15sm2594578edr.50.2021.05.28.04.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:30:31 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCHv3 for-next 14/20] RDMA/rtrs-srv: convert scnprintf to sysfs_emit
Date:   Fri, 28 May 2021 13:30:12 +0200
Message-Id: <20210528113018.52290-15-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528113018.52290-1-jinpu.wang@ionos.com>
References: <20210528113018.52290-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
index 520c24773229..12c374b5eb6e 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
@@ -28,7 +28,7 @@ ssize_t rtrs_srv_stats_rdma_to_str(struct rtrs_srv_stats *stats,
 {
 	struct rtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
 
-	return scnprintf(page, len, "%lld %lld %lld %lldn %u\n",
+	return sysfs_emit(page, "%lld %lld %lld %lldn %u\n",
 			  (s64)atomic64_read(&r->dir[READ].cnt),
 			  (s64)atomic64_read(&r->dir[READ].size_total),
 			  (s64)atomic64_read(&r->dir[WRITE].cnt),
-- 
2.25.1

