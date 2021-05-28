Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2398E3941CF
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 13:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhE1LcQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 07:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbhE1LcJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 07:32:09 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15166C0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:34 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id j9so4464762edt.6
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wr3oGd2AXGQRTQMnzq8qo5e2Hw8gAn5xCsknsd45XjQ=;
        b=JmJ8GDvajYFVGnoDmhVxib5sYfeig/zI1UxiZ0ChWWE5lAeBfn6yhgcvHeRU6x3LxO
         DbjmvAi7Z4ZTIBn8wjrzZoZofNUp2IjAOHCLw3V0GKZSD/PynQ34di9ve3ajszWd/r1D
         +mo8mpedjp3udQaj8WX4DLDalRQJXam4hSrK0H7dpw3YA6Pkn5PcP1jrapGpxGTVZAox
         MRDwC0b+S4PKqH13cIcxhcCpa80bDy4McQwe7F3yNI0GU1lmUgSuN/8bEjXWC1DLac1k
         aCJyAyodDUZXeIp4enc+Koef/UrsB8I38JEY6frW/lCT6YC4hKsOqv3GISltMN8KAp0t
         Ffcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wr3oGd2AXGQRTQMnzq8qo5e2Hw8gAn5xCsknsd45XjQ=;
        b=kDYeEkf592Ik4UYyO2Jf+76s9vuAXhnCtqAHAXT/1HHrLsKiJl4fcS0+N1+7BibHJj
         vNtCXfObAO/i3Xc95jdQaX4prIV0OVWPCXkG4HlZFdCbgC5TIInGbAFE/d70auX69FXu
         F0SyT2PBSIvbwAnbCySYvQS11dsbEIhkgG+//NQBh5mUDrRtbp68dxKSGnrVAtyWlaXl
         JxhTe/5kPk+W95hyQKICt45DZvoj1MtIatQTvqpDvnSvWWH3yEtq9UHL5xyh60oFsgqx
         34YCNY6FC31Q/9NT8s0RqGjr14TIEwga2mXFCNMR520o+JLIvW2gSfB6N13FYaeR+W6s
         cHew==
X-Gm-Message-State: AOAM532RVJV6NWucZU1iBwG+kTsdbxiiMigknHJBoMUbmpJJLyE0UDWG
        4V1GBTC5Fm9Z8u+0mCofbIa9IIBB7Lwu0w==
X-Google-Smtp-Source: ABdhPJwm+zxPNva/6u4ydjhdLD8A99d23bOCOefgl7eMURmwp1x7i1fPcRaxrB9/ThyACOhKotgh7A==
X-Received: by 2002:a05:6402:684:: with SMTP id f4mr9622781edy.25.1622201432532;
        Fri, 28 May 2021 04:30:32 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:497d:7d00:983b:122a:4685:3849])
        by smtp.gmail.com with ESMTPSA id p15sm2594578edr.50.2021.05.28.04.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:30:32 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 15/20] RDMA/rtrs: Do not reset hb_missed_max after re-connection
Date:   Fri, 28 May 2021 13:30:13 +0200
Message-Id: <20210528113018.52290-16-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528113018.52290-1-jinpu.wang@ionos.com>
References: <20210528113018.52290-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

When re-connecting, it resets hb_missed_max to 0.
Before the first re-connecting, client will trigger re-connection
when it gets hb-ack more than 5 times. But after the first
re-connecting, clients will do re-connection whenever it does
not get hb-ack because hb_missed_max is 0.

There is no need to reset hb_missed_max when re-connecting.
hb_missed_max should be kept until closing the session.

Fixes: c0894b3ea69d3 ("RDMA/rtrs: core: lib functions shared between client and server modules")
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index a7847282a2eb..4e602e40f623 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -376,7 +376,6 @@ void rtrs_stop_hb(struct rtrs_sess *sess)
 {
 	cancel_delayed_work_sync(&sess->hb_dwork);
 	sess->hb_missed_cnt = 0;
-	sess->hb_missed_max = 0;
 }
 EXPORT_SYMBOL_GPL(rtrs_stop_hb);
 
-- 
2.25.1

