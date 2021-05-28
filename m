Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250A13941CB
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 13:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbhE1LcN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 07:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbhE1LcF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 07:32:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD459C061760
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:30 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g7so4478584edm.4
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1QD3hWGQenuZYQN4gR9I/abqD2AvoXdG7l4VYDuQ9mM=;
        b=YoN9LKKUdEjhWlKtaVKWazz9wEUz41OOdgQ8jJQJ7Yoh3J/kVIYAgRS6zGjXC7zn1q
         TzsIkHi2elwaxNc6cTjdjPc6hRVJKgkZQLskJ66OvoYsLxOWpKa0fDHMAo16tnDWbjrl
         Xu1/hvYCP8qKUaOSLK+5rjf9/Nz6WkaLdh67fIFyDthM7Tg1TuyWJa6DNOl8Xfbs2t+Q
         z73e6UhLIZcCMmAyQZoMDEDj6PkmscgOrG1wkdfx9z1Wckm5VM6JB2Pzws++lICvQL9d
         ZRAgrl1GS0uUp6RCgNpwnFI6A321UHH4EEAepaKAYMSRPzm3gnAHf00fKJwXd9HcGldf
         qepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1QD3hWGQenuZYQN4gR9I/abqD2AvoXdG7l4VYDuQ9mM=;
        b=gwixe0KYcamcqFeKk3MgPR4m5wlxzKlUpNmCaOa6dPM6/Tz48VsAz6WChoAvtf0DT6
         gc3pyjoQe655gvi532jAjw/TYnlWSeDXRQCmG1NaKzEscJFTOcdccW3PxO3dY3yAS1CM
         qab4lddhvmP7to58qo4WO7i/jjJMSBetVRnfijLffVugAPPJEHLqxV7484H8cH0jvztL
         klVdQVMC0YAdPYrE1nQpMaB78nxvo8hOGgZvMB7cKw2t6rfYlhOjL0o/jQT75MmAC4L+
         jhp3Zr+4/DdCkClpRq2RO/2EATrrOaDdxvSt1pTSWo//fif6RYOG6qSpLJ3KeLalAjFt
         97hQ==
X-Gm-Message-State: AOAM530ZxAP0I+hFQYmLBt10oaRZ0eCw0iaWonrmqMfoYEaXmhcVDb90
        sW0IDKHK6MpxM7FwKlLLC4YN/WH7wVYrzA==
X-Google-Smtp-Source: ABdhPJzBOPAVMKTTX0E/oMsL+AE34UNcOR0EZcphCEEM2E1KdLy2C8cwxQe2uturptM1JsFGhWrHUQ==
X-Received: by 2002:aa7:c499:: with SMTP id m25mr9223354edq.109.1622201429311;
        Fri, 28 May 2021 04:30:29 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:497d:7d00:983b:122a:4685:3849])
        by smtp.gmail.com with ESMTPSA id p15sm2594578edr.50.2021.05.28.04.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:30:29 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 11/20] RDMA/rtrs-clt: Remove redundant 'break'
Date:   Fri, 28 May 2021 13:30:09 +0200
Message-Id: <20210528113018.52290-12-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528113018.52290-1-jinpu.wang@ionos.com>
References: <20210528113018.52290-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

It is duplicated with the very next line

Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index e87796a556c0..79324138df9a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -655,7 +655,6 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 			rtrs_err(con->c.sess, "rtrs_post_recv_empty(): %d\n",
 				  err);
 			rtrs_rdma_error_recovery(con);
-			break;
 		}
 		break;
 	case IB_WC_RECV:
-- 
2.25.1

