Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C36738281D
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 11:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbhEQJVD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 05:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbhEQJUn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 05:20:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F78C061573
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id p24so6872965ejb.1
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wr3oGd2AXGQRTQMnzq8qo5e2Hw8gAn5xCsknsd45XjQ=;
        b=EQP8hNCEUbT/ijWhe4XVFIYLColKaztNgJjHgj5baIF8Zp8J+AGRGWBzjWp3zRZapE
         PKdumCH6VH7qyzSN6qS0z1s2mSHjjf0LxunnQXB4Jcfk8ZD3+kdx3XpqB5dSGGdaMcIo
         8+dEFDJzQ/Nlns+KwWKeOdPpV+cdY71B3z1bkYwfpR31RYYFHFIKbKNB4jgsd8Hp6pHA
         eYYU4m6UWWEKe81p32JLdh1tro0r8tXz8YUPVSraOvpD/LK3fQP78wqqq16Gz4QdmLQL
         jzyZ5yctF1oTZAMDSXDNNGPiJdMkdjtZQkbE5kn360kbqCUI88Hh3IuAhRN3Nn9YiKb1
         ZDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wr3oGd2AXGQRTQMnzq8qo5e2Hw8gAn5xCsknsd45XjQ=;
        b=M0NI35/Qg1lYukKDb+2AOgBF3W+98kdgWOkcki7GOL4SqKg6vtZ0dkaWarK5ZRUOIT
         XGknvmOfZLVmDj1ByUXV4n5/sa425wH/g/m/YswgYQrDB3F3aGqr8gZxLThsm8WAzv0V
         TUb1y88MJD8RYwMum0hO3Xf7OyROfZp8mqNUnDIxjLLOENd+Xn+5m/AJaEm1MOt4ItRu
         OAG1XxezO8f1cJBRzmCRWl/xI3ZcS6UPa22YnECOcI17RO15y+KTB4uw4RJQRnVAgp2I
         SD5woU5ZjGMHEX9pQfykEirpKc256SA8kV1ZjmYgZN3ON/Hlld8huKSO/OLtUWKxQy29
         u99w==
X-Gm-Message-State: AOAM5331gQTVou/exYlWBfCZtesUo1NJo1Uip1PWH3PJH7BkBWxekVBd
        7totVPA1e4fISsSr8tZaEippIPKkZ4scng==
X-Google-Smtp-Source: ABdhPJweYQKHH2/5tzGj1SKZ6b7+MW+3pvB90lXd+CLXXT6HDdPf5amZEP/oZNINxKnWexUGGnZTNA==
X-Received: by 2002:a17:906:b0cd:: with SMTP id bk13mr62142281ejb.184.1621243165855;
        Mon, 17 May 2021 02:19:25 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id g10sm7925845ejd.109.2021.05.17.02.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:19:25 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 14/19] RDMA/rtrs: Do not reset hb_missed_max after re-connection
Date:   Mon, 17 May 2021 11:18:38 +0200
Message-Id: <20210517091844.260810-15-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517091844.260810-1-gi-oh.kim@ionos.com>
References: <20210517091844.260810-1-gi-oh.kim@ionos.com>
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

