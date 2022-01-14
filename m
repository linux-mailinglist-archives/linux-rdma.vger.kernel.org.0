Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAB348ED64
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jan 2022 16:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242992AbiANPsM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jan 2022 10:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242938AbiANPsJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Jan 2022 10:48:09 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380C9C06161C
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jan 2022 07:48:09 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v123so6950409wme.2
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jan 2022 07:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vil0NtkJScmskuQyDq3wUbG1nj2Cyjzt1U19Hf8vW90=;
        b=jKwckO+KSa0ZmeHA0tUcroe4Gp0nKlVaAqZQC1/MRNMY2mq1wydlFnqF8crZ8CqXFv
         E4hlsEl/GA7El4jb7GZVSlGatHKo9fTHedY1DADLGrM2CGtngQngLVlPdBtQpesNdyOz
         yAAk2fOfLUKjbG5cBlzyuij4QMwq0tvJl/2wwJK5g1rvDdlBUDmDA9I3pi64/tHLAX2R
         Nf+XM5gogkK3/sAUsCMCglmo3m31qJx1Q+2g8Ek+e//ntpfgEhWvnZBUI6NW1K3EkkCr
         /jGIwAtKIeIeZ0HiWr9LjIlIgNjdT2mAQbGnNh1yw4h2kWd23ROQGn2FmN4eCVSdwpuT
         V9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vil0NtkJScmskuQyDq3wUbG1nj2Cyjzt1U19Hf8vW90=;
        b=TjyNEOTE6N+hg3qX5e989gA5UXDDxheHHK+6Gx81xXGDdFQ/a2ZEqOwiWuIjwPIdgG
         vonHg5330X0o8y5W9eOBqm9Hw3XJb9Jfnvdv/WpG03n6VrLBV2ab4sIh1MHazIbXMP3Q
         u35LkyQmDQbA3PWz/cGb3roMeIMcVS0koAi7uo/vkJ4DaN4bWTqRSnzJScnNCBfmkfjS
         DZlOCjtYPXdPsNIPHMIlTKqsQmhIWRg2lYUQgPb7G2lPw7INOj15C5E0Po8e/265N7dR
         DTBTUyNSVpMgEoUufQB5/7RYjZS990+Z9vVMWVm+AIg9aZoKo2o2sicz/R9YOgNCbgmu
         63Hg==
X-Gm-Message-State: AOAM532nqYABBULzm2ZN0ok9/90tDKmJlQe5ur2846FzUBJ7tov7qD9K
        tCMzR859AoFNmeOrEXiYfh8YonkUEd0wJw==
X-Google-Smtp-Source: ABdhPJwIt/v4ZvmuOS2hXPD3w7xtYnZl+Qc2G4lqk2NJM1YEUGaV5ArSI355syxNGdDs7eM/cF0Z1g==
X-Received: by 2002:a17:906:4fcc:: with SMTP id i12mr7905054ejw.529.1642175287748;
        Fri, 14 Jan 2022 07:48:07 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id x20sm2522028edd.28.2022.01.14.07.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:48:07 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH for-next 4/5] RDMA/rtrs-clt: Update one outdated comment in path_it_deinit
Date:   Fri, 14 Jan 2022 16:47:52 +0100
Message-Id: <20220114154753.983568-5-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114154753.983568-1-haris.iqbal@ionos.com>
References: <20220114154753.983568-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@ionos.com>

The skip_list is used for both MIN_INFLIGHT and MIN_LATENCY.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 62ba0f17ac9d..05de9ec7c99a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -907,7 +907,7 @@ static inline void path_it_deinit(struct path_it *it)
 {
 	struct list_head *skip, *tmp;
 	/*
-	 * The skip_list is used only for the MIN_INFLIGHT policy.
+	 * The skip_list is used only for the MIN_INFLIGHT and MIN_LATENCY policies.
 	 * We need to remove paths from it, so that next IO can insert
 	 * paths (->mp_skip_entry) into a skip_list again.
 	 */
-- 
2.25.1

