Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5439C37147E
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 13:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbhECLtU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 07:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbhECLtS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 07:49:18 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50953C06138B
        for <linux-rdma@vger.kernel.org>; Mon,  3 May 2021 04:48:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id m12so7422978eja.2
        for <linux-rdma@vger.kernel.org>; Mon, 03 May 2021 04:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nzWg2WdxSRFvsIuV0pZDFdY4JIfzwTgd0gPbycE6Cw8=;
        b=a20snxajAcB11PIa5DZKX47cySrtJJ7waYonESp0n4h5EcIo3BmUXULCpi0/78/P/X
         Fp1cmZpMAQzmcFljaHWyx5qopM91XZbFp2hN5UMDtqc0RV+/LwOghtQB3tn1Wg17dWk4
         Sq620EeXbZapGnt73So7/yzFzIVPVh43ia4yliEEw1rX0xeC1u+0U6Li03FXdeWh2DOs
         LhO97WKiEsXYqfanUQXkX7bss2usvXJCRhXIHjj47LBrq5mEDNnXnoukHHXsNci9KYMF
         6nP6ieAf/Yzi6iaTBRnGOEHWJPC4n/KM59Lttpv/P3wDy97zirORCWc/+JDUChVantLr
         8n/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nzWg2WdxSRFvsIuV0pZDFdY4JIfzwTgd0gPbycE6Cw8=;
        b=Pp4eCHsYXsUaWdn6AesRCNzn/QJudBbjkhqiJ25je/XzW3M/UuahZU0XvJjh9l7QKw
         7g0OQLMJjUyM5QmO2ZYn5GFAzYckU5TWF9UGH4SQEMisQpCyi8Cz0YmCc+iLrk0XwyYB
         PFUh0ESuIoRKrQ/mAtYfEM9uoN+fGByIJzYtiYzWf47hPsfpRGh3COwKeWzQwt7lCoHJ
         hqFq4DgpuoNLFLa28YRWmvyxokpZypOG5zQmO4UTHHNN6P2rtOQDp8lnHYyzQBCxYIEM
         Ft+qc9qM3Fo7+Im5p2hJjVL2njuUVaHIDOy0L5BfSBYAwScVGhnG5VrT2jRgGKCnmOdM
         jc+A==
X-Gm-Message-State: AOAM533BzAKd/Mm7FNE//zaSajfs6gP6JoAo7b89gw2yW7tqmmSbw5Ea
        czmfeScaCAZ4T0fRaHkvGRPJwY7N4m7R7Q==
X-Google-Smtp-Source: ABdhPJwT8lMel3RvjZBvEf9I64tr0WBB4Q57h/tzhdxMQ0UVjhVUaOFMvvtrKnyI86N5Wuxlurd8mg==
X-Received: by 2002:a17:906:c0c7:: with SMTP id bn7mr13646835ejb.393.1620042503879;
        Mon, 03 May 2021 04:48:23 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id z12sm7307705ejd.83.2021.05.03.04.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:48:23 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 04/20] RDMA/rtrs-srv: Add error messages for cases when failing RDMA connection
Date:   Mon,  3 May 2021 13:48:02 +0200
Message-Id: <20210503114818.288896-5-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503114818.288896-1-gi-oh.kim@ionos.com>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

It was difficult to find out why it failed to establish RDMA
connection. This patch adds some messages to show which function
has failed why.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 3d09d01e34b4..df17dd4c1e28 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1356,8 +1356,10 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
 	 * If this request is not the first connection request from the
 	 * client for this session then fail and return error.
 	 */
-	if (!first_conn)
+	if (!first_conn) {
+		pr_err("Error: Not the first connection request for this session\n");
 		return ERR_PTR(-ENXIO);
+	}
 
 	/* need to allocate a new srv */
 	srv = kzalloc(sizeof(*srv), GFP_KERNEL);
@@ -1812,6 +1814,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	srv = get_or_create_srv(ctx, &msg->paths_uuid, msg->first_conn);
 	if (IS_ERR(srv)) {
 		err = PTR_ERR(srv);
+		pr_err("get_or_create_srv(), error %d\n", err);
 		goto reject_w_err;
 	}
 	mutex_lock(&srv->paths_mutex);
@@ -1850,11 +1853,13 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 			mutex_unlock(&srv->paths_mutex);
 			put_srv(srv);
 			err = PTR_ERR(sess);
+			pr_err("RTRS server session allocation failed: %d\n", err);
 			goto reject_w_err;
 		}
 	}
 	err = create_con(sess, cm_id, cid);
 	if (err) {
+		rtrs_err((&sess->s), "create_con(), error %d\n", err);
 		(void)rtrs_rdma_do_reject(cm_id, err);
 		/*
 		 * Since session has other connections we follow normal way
@@ -1865,6 +1870,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	}
 	err = rtrs_rdma_do_accept(sess, cm_id);
 	if (err) {
+		rtrs_err((&sess->s), "rtrs_rdma_do_accept(), error %d\n", err);
 		(void)rtrs_rdma_do_reject(cm_id, err);
 		/*
 		 * Since current connection was successfully added to the
-- 
2.25.1

