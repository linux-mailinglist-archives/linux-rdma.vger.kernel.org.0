Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F103DB930
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 15:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238937AbhG3NSo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 09:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238890AbhG3NSn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Jul 2021 09:18:43 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEE0C06175F
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 06:18:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m19so5990519wms.0
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 06:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gipMW1mQKUh3sQRjOfvvLSct1hvDgV+kPX6qBnraHXA=;
        b=g2XDAkJ3ynaNz9H0/KsAwvTdmT1ETjajYUfof+EtQ57x/1ha/n2lr54rEGvtmmqgsa
         GzcReVGGFtieeBbAsQwq8iFUSIBLNcCdnU3ZLwx2qBy76SaWWTUcHDPCZZSxlrgfa9hK
         GYe5rFLnjDw8by9nDUXiOWq/Q5zUVD7gdXXVeuKbqyKq8Shsc7353QmTr009AdhgneMl
         HX203rQHgY8vm3PZwGgssS0Ou4iwp3MsBZ57DWFEDIOe2f9DEqfEwCTdijxNSa3Sauug
         9GkhtZALzBaOwo50NX9GTgBoXv7m/KIGOAnjeczyYjZa3cLQgIxGzNZylwyF7xEGpACo
         E7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gipMW1mQKUh3sQRjOfvvLSct1hvDgV+kPX6qBnraHXA=;
        b=Mb/27Vv1NeZxJr4cRXzmxoMiJ7B7luLaV5Ax9RWR8s5eRydnsfl/6wKSEi69ZxGswE
         ZdIziZLfSNRH2q4fhxxXPUmOWAc4/qX6j7cY6jTDun7alCnQCv7PsmQsKitqbU8/Ac+8
         7kc438Pw49rojFKb2bwcOWz0QMC+E9+WFHwWczoGrW5/Gq2sg5tFB6rt23836XJ/aqN1
         n+nZ/i/8V+PV6I4DxO7LCIPAKQQCXipXyPj8I64QuQ9sO5AuJMK/tfzlI73fMqD/xuXm
         BgbVAvnCu3IIoXj8fYS/m3rBnBCHRWyfpnxlKfAGCM89Sl/+JACfLH5zB30eNmhMmdZY
         URTw==
X-Gm-Message-State: AOAM530s4doft2J7m8I7XQ30EXZE/YdW+OVXR+ZfyJgMGolH6oBhnkqS
        xgFDI2OYOlOtSZub9I1V92/WqqP6lDbOpA==
X-Google-Smtp-Source: ABdhPJws8cYC4VHvFoGyQduhlHB4e+ZTY/jTOF9lqSiVNO58ER0lB1HAv6iNYSxSdBK1tg/xzMYRbA==
X-Received: by 2002:a05:600c:2302:: with SMTP id 2mr1090297wmo.169.1627651117425;
        Fri, 30 Jul 2021 06:18:37 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:496a:8500:4512:4a6e:16f3:2377])
        by smtp.gmail.com with ESMTPSA id z5sm1626012wmp.26.2021.07.30.06.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 06:18:37 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 05/10] RDMA/rtrs: Fix warning when use poll mode
Date:   Fri, 30 Jul 2021 15:18:27 +0200
Message-Id: <20210730131832.118865-6-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210730131832.118865-1-jinpu.wang@ionos.com>
References: <20210730131832.118865-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

when test with poll mode, it will fail and lead to warning below:
echo "sessname=bla path=gid:fe80::2:c903:4e:d0b3@gid:fe80::2:c903:8:ca17
device_path=/dev/nullb2 nr_poll_queues=-1" |
sudo tee /sys/devices/virtual/rnbd-client/ctl/map_device

rnbd_client L597: Mapping device /dev/nullb2 on session bla,
(access_mode: rw, nr_poll_queues: 8)
WARNING: CPU: 3 PID: 9886 at drivers/infiniband/core/cq.c:447 ib_cq_pool_get+0x26f/0x2a0 [ib_core]

The problem is in case of poll queue, we need to still call
ib_alloc_cq/ib_free_cq, we can't use cq_poll api for poll queue.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c |  1 +
 drivers/infiniband/ulp/rtrs/rtrs.c     | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index b814a6052cf1..5969a74d45a0 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1776,6 +1776,7 @@ static struct rtrs_srv_sess *__alloc_sess(struct rtrs_srv *srv,
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

