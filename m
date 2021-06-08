Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C972139F399
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 12:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFHKdi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 06:33:38 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:40860 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhFHKdh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 06:33:37 -0400
Received: by mail-ed1-f43.google.com with SMTP id t3so23927061edc.7
        for <linux-rdma@vger.kernel.org>; Tue, 08 Jun 2021 03:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6DXu4OmBn/6f2pOViHrkn9BqE93+JtM5LZS2wZByLK8=;
        b=WdT1PPYjkk+6eV+2CK8QVpQ+c0oKXaQUCJiUVssnvioI/B5vNLCUwPOi25rsG1c3V+
         u5qO5ucMuxOuoyIurMxMKipeJhS3n5nFnpR4yekTzrSTK/T1L0LxQXViu43bHU4ph1sb
         aKvXJe1ugiaMKV4jrXC0dpkv0RV+p1n0+h8bxjdwXfiuUcyAYcPC7jWvK5cednuBF0jW
         aw0itolJLhixVzCd8iWBPSR6DJo8zUsn9dyEME7dC8Wj/FxF7gt9OAWeKKBiLuV6BMzv
         Nv+glKTL25CEPjKqAV8Y+EzL16rC6PcqUQxQNBwzrHEnJxC0dQCrLIjC9wvxDRmGOxCx
         y1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6DXu4OmBn/6f2pOViHrkn9BqE93+JtM5LZS2wZByLK8=;
        b=sE25C3wsBfdkYWw90x/AgETrdBmDzKgcx9frlsqiqDiSecqtwA4ZPakx1bVh9aVkSr
         RJ7240fI/3LU3KtVHuUjHckqvbyueujiw3Td9eOcpW4svy9XD1gIlsKAKb6da8BA1WCK
         8AAE7JmFO1IB7Lt7Oc7xPBXA3g6vctDsKHJS0LZt+F8KIBOigvdtuEUIvoIl2d82rM3K
         4PhiAAgWP2JtAQ6J5XcsrxIx1Vq9ZvLulzUECf25HL82uOrZL3SN2kfcBZAsLQuLP9zV
         a4wpAeZzsstkjHH9s9d9S6fhcz1s1oghCZBjf1cw0lVZNPlRzzjS/UKbjDwh+iNbAMjG
         jf5g==
X-Gm-Message-State: AOAM532/I7WBoCOkOW9lLhFkNsFbPWj/Vh4Gd/3U4SjQu174aKhAXspf
        wQkSY9rP+RB7DGEP8kFs9Q1uOWarc86+/Q==
X-Google-Smtp-Source: ABdhPJyU8g+rNLnKGpgF8py+iT4lq/Un3JfSiAQwJyc6KCdaFITsbo+w9YJgNMSK8e9/oz+nKEZNgA==
X-Received: by 2002:a05:6402:885:: with SMTP id e5mr25057557edy.248.1623148243746;
        Tue, 08 Jun 2021 03:30:43 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4943:5b00:2927:a608:b264:d770])
        by smtp.gmail.com with ESMTPSA id dy19sm8634400edb.68.2021.06.08.03.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 03:30:43 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 3/4] RDMA/rtrs: RDMA_RXE requires more number of WR
Date:   Tue,  8 Jun 2021 12:30:38 +0200
Message-Id: <20210608103039.39080-4-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608103039.39080-1-jinpu.wang@ionos.com>
References: <20210608103039.39080-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

When using rdma_rxe, post_one_recv() returns
NOMEM error due to the full recv queue.
This patch increase the number of WR for receive queue
to support all devices.

Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 ++++---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index cd53edddfe1f..acf0fde410c3 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1579,10 +1579,11 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 	lockdep_assert_held(&con->con_mutex);
 	if (con->c.cid == 0) {
 		/*
-		 * One completion for each receive and two for each send
-		 * (send request + registration)
+		 * Two (request + registration) completion for send
+		 * Two for recv if always_invalidate is set on server
+		 * or one for recv.
 		 * + 2 for drain and heartbeat
-		 * in case qp gets into error state
+		 * in case qp gets into error state.
 		 */
 		max_send_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
 		max_recv_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 04ec3080e9b5..bb73f7762a87 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1656,7 +1656,7 @@ static int create_con(struct rtrs_srv_sess *sess,
 		 * + 2 for drain and heartbeat
 		 */
 		max_send_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
-		max_recv_wr = SERVICE_CON_QUEUE_DEPTH + 2;
+		max_recv_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
 		cq_size = max_send_wr + max_recv_wr;
 	} else {
 		/*
-- 
2.25.1

