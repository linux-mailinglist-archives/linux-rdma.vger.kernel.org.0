Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F714149C2
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Sep 2021 14:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbhIVMzO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Sep 2021 08:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236035AbhIVMzO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Sep 2021 08:55:14 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1DFC061760
        for <linux-rdma@vger.kernel.org>; Wed, 22 Sep 2021 05:53:44 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i23so6578443wrb.2
        for <linux-rdma@vger.kernel.org>; Wed, 22 Sep 2021 05:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y1UL7Nlf2kMcbJh3azmP4EsiIrVGqW6KQ7WA/oJgmcc=;
        b=SqUIcK9Rwd2Ch6MV3jrQdSM35JnaIGe6t3wIIdXBWHqdVgAhVWGyUpeJcZQ49dWp7r
         BfYX76nSKGMlQUAavqXPkbi6mWHZbrE8Ev7H+zGhm4KL5RtS2sW0Q4EjFrkDmBsoOTjz
         Iaeq1gkGyvzl7SN6uR96x/iyF9AgTlX0eClj+W77unrQGfqCWmdz5pEqfpbBZz1nc+2E
         koj32j94xH/WP1zo9+0lkeC6siND1X2WnGObXhpLOnhy0/Sp3Pmf3QyxasJLSggBoz/C
         yggxmsRLnLTXLR1LH0GqJSgXB11DFXspKrl1yN7QQ4sQpaZhlc8gpOJhUkVwsg1GXxrf
         Pw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y1UL7Nlf2kMcbJh3azmP4EsiIrVGqW6KQ7WA/oJgmcc=;
        b=Y2BvYwkc91SO1JwIm0h2PYd+8dlrMnncWOqh8doFj0Hfz0XFmM4WChDdYwOljToO7G
         Y5C/dQBO09S9OSF5AtQ/gvNoV6s9qYUQtM+6d7JrfZ7G17adHmXhwxebmWaizhfnk30m
         edZIj9xQwVIKVWfarhqRHdw0cq11eD8UXMNyNld4hDUVbjVd88e9RH5tB7wTN0h5GT3z
         mtJECT4+tSVOv+YblHOqz2rbQVUGTngJWlusbfTKtmx8NeK6K9wZhekRh6lRf2z8Sc33
         qve9eRwuZVlrqzDmk4gH/l5hSVXwJwmUC4auWWXPAQj/qCoRkOz2nwPniuAYpFqZwFxz
         nD1Q==
X-Gm-Message-State: AOAM5325K2nAg35wVW40+NAFGEizagKko/bk8F9rUJ8PiEhfOtTSDRhM
        vocSyjC5pt+iU7edGLx0jwky1HAsZHdJ8Q==
X-Google-Smtp-Source: ABdhPJxYrg7atfT4c4/LUWdGpPR1dMnAjUDVW8we+kTG+ZBwBNtD4pTwQPvYFXSzWMU6qrrVnseGuw==
X-Received: by 2002:adf:e44c:: with SMTP id t12mr42984645wrm.49.1632315222914;
        Wed, 22 Sep 2021 05:53:42 -0700 (PDT)
Received: from nb01533.pb.local ([2001:1438:4010:2540:40a5:9868:5a83:f3b9])
        by smtp.gmail.com with ESMTPSA id j20sm2173685wrb.5.2021.09.22.05.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 05:53:42 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH for-next 3/7] RDMA/rtrs: Fix warning when use poll mode on client side.
Date:   Wed, 22 Sep 2021 14:53:29 +0200
Message-Id: <20210922125333.351454-4-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210922125333.351454-1-haris.iqbal@ionos.com>
References: <20210922125333.351454-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@ionos.com>

when test with poll mode, it will fail and lead to warning below on
client side:
echo "sessname=bla path=gid:fe80::2:c903:4e:d0b3@gid:fe80::2:c903:8:ca17
device_path=/dev/nullb2 nr_poll_queues=-1" |
sudo tee /sys/devices/virtual/rnbd-client/ctl/map_device

rnbd_client L597: Mapping device /dev/nullb2 on session bla,
(access_mode: rw, nr_poll_queues: 8)
WARNING: CPU: 3 PID: 9886 at drivers/infiniband/core/cq.c:447 ib_cq_pool_get+0x26f/0x2a0 [ib_core]

The problem is in case of poll queue, we need to still call
ib_alloc_cq/ib_free_cq, we can't use cq_poll api for poll queue.

As both client and server use shared function from rtrs, set irq_con_num
to con_num on server side, which is number of total connection of the
session, this way we can differ if the rtrs_con requires pollqueue.

Following up patches will replace the duplicate code with helpers.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c |  1 +
 drivers/infiniband/ulp/rtrs/rtrs.c     | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 716ef7b23558..078a1cbac90c 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1766,6 +1766,7 @@ static struct rtrs_srv_sess *__alloc_sess(struct rtrs_srv *srv,
 	strscpy(sess->s.sessname, str, sizeof(sess->s.sessname));
 
 	sess->s.con_num = con_num;
+	sess->s.irq_con_num = con_num;
 	sess->s.recon_cnt = recon_cnt;
 	uuid_copy(&sess->s.uuid, uuid);
 	spin_lock_init(&sess->state_lock);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index ca542e477d38..9bc323490ce3 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -228,7 +228,12 @@ static int create_cq(struct rtrs_con *con, int cq_vector, int nr_cqe,
 	struct rdma_cm_id *cm_id = con->cm_id;
 	struct ib_cq *cq;
 
-	cq = ib_cq_pool_get(cm_id->device, nr_cqe, cq_vector, poll_ctx);
+	if (con->cid >= con->sess->irq_con_num)
+		cq = ib_alloc_cq(cm_id->device, con, nr_cqe, cq_vector,
+				 poll_ctx);
+	else
+		cq = ib_cq_pool_get(cm_id->device, nr_cqe, cq_vector, poll_ctx);
+
 	if (IS_ERR(cq)) {
 		rtrs_err(con->sess, "Creating completion queue failed, errno: %ld\n",
 			  PTR_ERR(cq));
@@ -283,7 +288,10 @@ int rtrs_cq_qp_create(struct rtrs_sess *sess, struct rtrs_con *con,
 	err = create_qp(con, sess->dev->ib_pd, max_send_wr, max_recv_wr,
 			max_send_sge);
 	if (err) {
-		ib_cq_pool_put(con->cq, con->nr_cqe);
+		if (con->cid >= con->sess->irq_con_num)
+			ib_free_cq(con->cq);
+		else
+			ib_cq_pool_put(con->cq, con->nr_cqe);
 		con->cq = NULL;
 		return err;
 	}
@@ -300,7 +308,10 @@ void rtrs_cq_qp_destroy(struct rtrs_con *con)
 		con->qp = NULL;
 	}
 	if (con->cq) {
-		ib_cq_pool_put(con->cq, con->nr_cqe);
+		if (con->cid >= con->sess->irq_con_num)
+			ib_free_cq(con->cq);
+		else
+			ib_cq_pool_put(con->cq, con->nr_cqe);
 		con->cq = NULL;
 	}
 }
-- 
2.25.1

