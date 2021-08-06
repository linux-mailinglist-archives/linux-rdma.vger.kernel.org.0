Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC0D3E296E
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Aug 2021 13:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245431AbhHFLWE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Aug 2021 07:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245443AbhHFLV5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Aug 2021 07:21:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79F0C06179B
        for <linux-rdma@vger.kernel.org>; Fri,  6 Aug 2021 04:21:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u3so14568337ejz.1
        for <linux-rdma@vger.kernel.org>; Fri, 06 Aug 2021 04:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T2gLNwhKmIs20UxnAeqaP1nsbNcWIyqXILzuHlH8PY0=;
        b=Kbr5RZ+J4RpF1xvEH0aBtsfGSQWEWWqwc26ks3w496yxmtkZSF69JokdFpsW1nwh8f
         KtcGaa9fWLJ9PEPt1Mb+g2ar6CQ5lzM1tvbOIzaegemwqXUsUzPOc6X0t0jubBrf1dYc
         wxU5JjfOxoF1ET4o7bBho/zHmVQ6atqoOsWTeLt9JA1uG5uv6+uJa0wgvrkzfvTOcDfI
         peZpJJZDutNmTv0ojSOOtM2rtxLeeYzFgEBp3JsuysVe/uo8dzfbWo44pqOGN5KzcixX
         sVR+uZCAbaCSJse/Ru1CC+kQLCCkQyYJPvvzrJzhY3G+gIGDRxZFLNr8N3pMTVUoydv3
         Vfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T2gLNwhKmIs20UxnAeqaP1nsbNcWIyqXILzuHlH8PY0=;
        b=gnlnTAVqpSrsG6lgDCZ7Abk36bYTEowvwYBvQvNP4TmdHDigqgFFnltvsHyZdXeyxe
         7Yt+pMsSXesJyLseLzMOyTR6Yio39le9exXiXbeYsbmqoI8npivXdccZ5R0qvIbz4GbI
         yUP/KNmyQMqPxOOnGxK7vQyBsiA5yw+9Sxo+PFI4kvXssTjFSqGG+e/Wvs7U9KEWcdXU
         50x5gr1aaS14ID6L7SdD76ecLtSWaNsEW71TGyHvPtH6P1E/I4tAW5onHqSnI01AT4Kh
         XsjQODIqoFDrv7OVAOLQDdOKAs/9LKdVm7Swine8nHY/EDnGyU59ITd9MUNml+Tkp+Xr
         VJ6w==
X-Gm-Message-State: AOAM530w3ugUvKiheJy+SxI2Q5SgicWzC+sQSIW77LeLTqbX5tXrLMGh
        CX4X8HYCMkDgWym7ZEE9D6U87qiN7GZRgg==
X-Google-Smtp-Source: ABdhPJxs6Oj+3dPWGi461qmHUxEiZZ9zYiPWmLHG96AHdF7Giop2z+7JmGn7Lyboci/DwTtxRuI3qw==
X-Received: by 2002:a17:907:1c92:: with SMTP id nb18mr9601072ejc.191.1628248900481;
        Fri, 06 Aug 2021 04:21:40 -0700 (PDT)
Received: from nb01533.pb.local ([2001:1438:4010:2540:9e61:8a1a:7868:3b15])
        by smtp.gmail.com with ESMTPSA id q11sm2794729ejb.10.2021.08.06.04.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:21:40 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH v2 for-next 3/6] RDMA/rtrs: Fix warning when use poll mode
Date:   Fri,  6 Aug 2021 13:21:09 +0200
Message-Id: <20210806112112.124313-4-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806112112.124313-1-haris.iqbal@ionos.com>
References: <20210806112112.124313-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@ionos.com>

when test with poll mode, it will fail and lead to warning below:
echo "sessname=bla path=gid:fe80::2:c903:4e:d0b3@gid:fe80::2:c903:8:ca17
device_path=/dev/nullb2 nr_poll_queues=-1" |
sudo tee /sys/devices/virtual/rnbd-client/ctl/map_device

rnbd_client L597: Mapping device /dev/nullb2 on session bla,
(access_mode: rw, nr_poll_queues: 8)
WARNING: CPU: 3 PID: 9886 at drivers/infiniband/core/cq.c:447 ib_cq_pool_get+0x26f/0x2a0 [ib_core]

The problem is, when poll_queues are used, there will be more connections than
number of cpus; and those extra connections will have ib poll context set to
IB_POLL_DIRECT, which is not allowed to be used for shared CQs.

So, in case those extra connections when poll queues are used, use
ib_alloc_cq/ib_free_cq.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c |  1 +
 drivers/infiniband/ulp/rtrs/rtrs.c     | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index cd9a4ccf4c28..47775987f91a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1768,6 +1768,7 @@ static struct rtrs_srv_sess *__alloc_sess(struct rtrs_srv *srv,
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

