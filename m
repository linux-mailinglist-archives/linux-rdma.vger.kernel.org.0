Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FC63A41C2
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 14:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhFKMMn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Jun 2021 08:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhFKMMi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Jun 2021 08:12:38 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07995C061574
        for <linux-rdma@vger.kernel.org>; Fri, 11 Jun 2021 05:10:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w21so36774064edv.3
        for <linux-rdma@vger.kernel.org>; Fri, 11 Jun 2021 05:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6DXu4OmBn/6f2pOViHrkn9BqE93+JtM5LZS2wZByLK8=;
        b=OLryWsAoA83HE6aJvvwlkX5vWOFN9FnvUSBz07ybGPvAbNf5k1/mblcKaeyBsUcJhc
         hZ4GqBL/PLgh1j7/CSvK/t42pFqtJIEvm4FjQ4scVkhrf7CkYpOn4E5JmZNVO6whcnBo
         z9VvxqnUH53mx8MrD/plofftRfGWN7AqBA2cP1ues1QtssUCxZE5Xt9tm4wBTtKJU1wG
         P3h/owTVWr7bC5q+rlv+WO5Lw0hcgXpwm8KjNQVl68ijexfWvmOFzJ9+gQ0/+JMiPKYg
         YP5+cb09Pp9B1L8pfBAubiQSnv2AJXOuY7YTB/yp/S0FFMAUdLOM6P5j96usV0e7QCEg
         b1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6DXu4OmBn/6f2pOViHrkn9BqE93+JtM5LZS2wZByLK8=;
        b=Yo4FtIyP94qdH9kpEcf5PZ7aWnEEjIkvuOfp0fTUDzjoVPMHp6FB6EqSgpB5YERQvd
         aAwdfAjqJv2eJY6B+JUHL4bfBGTnq/MX0hw9AxxYF+JsPXvaINk4aPgz/Q0Pw6N5rqF6
         aJpEw1OuN4CB7QqD92fJOi479iotbssF0/ebe+406VZlkvljRm2jTAf++kfOU/7PstCZ
         6mezI36txVtrh2sX3MavrVt7Q9yahlOeA1zey3h/sDJ4TtVWe9TzWk6vGCdolbTW8V9m
         SffhE+m68vrtDyuaeIlUJmwNBbjrstgKgVXW7BIr6/jvJBPcNAO57C/LiRFovTrrEfB+
         qIfQ==
X-Gm-Message-State: AOAM5302816VnOy6Wp9RAt0DNjvzHCMA3UJSx1raYDnW3aYyI2I5svvp
        cwr/xTGDds6CpYfbW+A6K9xvNkRCB1318Q==
X-Google-Smtp-Source: ABdhPJzlJOH2u23gPdGYBOxQ8+tyQ51bdIuGPE16+EVZbw0G6PogqA/iWwcyWIE8pRJ5xFpn3ra9eQ==
X-Received: by 2002:a05:6402:1592:: with SMTP id c18mr3393915edv.2.1623413438386;
        Fri, 11 Jun 2021 05:10:38 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4954:2e00:fd6f:fc71:2689:4a7a])
        by smtp.gmail.com with ESMTPSA id n11sm2084116ejg.43.2021.06.11.05.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 05:10:38 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 3/5] RDMA/rtrs: RDMA_RXE requires more number of WR
Date:   Fri, 11 Jun 2021 14:10:32 +0200
Message-Id: <20210611121034.48837-4-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210611121034.48837-1-jinpu.wang@ionos.com>
References: <20210611121034.48837-1-jinpu.wang@ionos.com>
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

