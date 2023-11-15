Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851207EC72A
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Nov 2023 16:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjKOP2F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Nov 2023 10:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjKOP2D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Nov 2023 10:28:03 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E64912F
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 07:28:00 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507bd644a96so9875498e87.3
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 07:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700062078; x=1700666878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1s0YFa68fF+ubtjF9HVVaUhPUqjPwA2OrrJXt0ep3L8=;
        b=hAP5XEOG6qPS5qtZbGs//WZTveHa7WxjeGQj4cxAab2xiXg/lf9Xq+Dj67Fhp3S3rC
         rCdI0MGBhzRVfEJqdUlhhmz85HmSDetkoifEgW2DUd8Rfd0kS8nRmA+zvggXYu07Q1j6
         E7rf+PvlmQjC1pUl9hcbMHLpF8c3r+QBxw0S7aRAErD99wUZTh+hFMF9K1XC66XC24ZH
         WSJxawUYLV3yXxQ3uP847+JxhUDo55PEC+FN5I2tdgR5kHTDqiLhnr/+yHkI34/bY2U0
         puy7BPHr/xmZhhgIqGxNjpK/ISQiyXtKD4dGXzqPiU2ipGWas0qiXvLp53mKt8Fpgdj4
         Zxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700062078; x=1700666878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1s0YFa68fF+ubtjF9HVVaUhPUqjPwA2OrrJXt0ep3L8=;
        b=H5M8qReMWI+6G8SyJ9Kxfnt2mT8dNu0zD9iZWev9V8umw1rpTFjKl0jYS2vtE+W6rj
         udFbr/8DRWDHRuguS4Ohx6H9wPoQfPR062FfYoGKj/gn7Rjw92ZdaOPFel3r/U8n+7TN
         0Wdatbhxr/Rj7vRyqy7rZfKAHFkQRkYDDbAwNWsnOmyNAwwweMDRouc+UX5dC+Rd1MSx
         jM6uEzAfqtfhSNgg3u4KxhZ6SEglJD8MjbXypS4ZCOBCbK3Jr8sTXN2sKPB+MimZPYO3
         prGN6iPIt2e0tRtCmI4kZvxXEJ8pJXVUUISkUX+/fAuAzuipkyAdXRR4t7S763AnQRbs
         Nbtw==
X-Gm-Message-State: AOJu0YwjX2E+cWkEvgcdl0OYHCtu/vdHvefyy5SpRWRPD4T5l64Rytze
        7cy1bCE9HBW68dC3br/wmUseZ3mKrY8Xlt1vLUI=
X-Google-Smtp-Source: AGHT+IEeCFvnCYTpbmzbDNGab2vfngGxrmvPQcZxjGRGNZbPcW8s2HcOpPDcxgEE4vbzuqDnj2Supg==
X-Received: by 2002:ac2:558b:0:b0:4fb:bef0:948e with SMTP id v11-20020ac2558b000000b004fbbef0948emr8232855lfg.5.1700062078585;
        Wed, 15 Nov 2023 07:27:58 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id u6-20020a056402064600b00542da55a716sm6577349edx.90.2023.11.15.07.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 07:27:58 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next 4/9] RDMA/rtrs-srv: Check return values while processing info request
Date:   Wed, 15 Nov 2023 16:27:44 +0100
Message-Id: <20231115152749.424301-5-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231115152749.424301-1-haris.iqbal@ionos.com>
References: <20231115152749.424301-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

While processing info request, it could so happen that the srv_path goes
to CLOSING state, cause of any of the error events from RDMA. That state
change should be picked up while trying to change the state in
process_info_req, by checking the return value. In case the state change
call in process_info_req fails, we fail the processing.

We should also check the return value for rtrs_srv_path_up, since it
sends a link event to the client above, and the client can fail for any
reason.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index ab4200041fd3..4be0e5b132d4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -710,20 +710,23 @@ static void rtrs_srv_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
 	WARN_ON(wc->opcode != IB_WC_SEND);
 }
 
-static void rtrs_srv_path_up(struct rtrs_srv_path *srv_path)
+static int rtrs_srv_path_up(struct rtrs_srv_path *srv_path)
 {
 	struct rtrs_srv_sess *srv = srv_path->srv;
 	struct rtrs_srv_ctx *ctx = srv->ctx;
-	int up;
+	int up, ret = 0;
 
 	mutex_lock(&srv->paths_ev_mutex);
 	up = ++srv->paths_up;
 	if (up == 1)
-		ctx->ops.link_ev(srv, RTRS_SRV_LINK_EV_CONNECTED, NULL);
+		ret = ctx->ops.link_ev(srv, RTRS_SRV_LINK_EV_CONNECTED, NULL);
 	mutex_unlock(&srv->paths_ev_mutex);
 
 	/* Mark session as established */
-	srv_path->established = true;
+	if (!ret)
+		srv_path->established = true;
+
+	return ret;
 }
 
 static void rtrs_srv_path_down(struct rtrs_srv_path *srv_path)
@@ -852,7 +855,12 @@ static int process_info_req(struct rtrs_srv_con *con,
 		goto iu_free;
 	kobject_get(&srv_path->kobj);
 	get_device(&srv_path->srv->dev);
-	rtrs_srv_change_state(srv_path, RTRS_SRV_CONNECTED);
+	err = rtrs_srv_change_state(srv_path, RTRS_SRV_CONNECTED);
+	if (!err) {
+		rtrs_err(s, "rtrs_srv_change_state(), err: %d\n", err);
+		goto iu_free;
+	}
+
 	rtrs_srv_start_hb(srv_path);
 
 	/*
@@ -861,7 +869,11 @@ static int process_info_req(struct rtrs_srv_con *con,
 	 * all connections are successfully established.  Thus, simply notify
 	 * listener with a proper event if we are the first path.
 	 */
-	rtrs_srv_path_up(srv_path);
+	err = rtrs_srv_path_up(srv_path);
+	if (err) {
+		rtrs_err(s, "rtrs_srv_path_up(), err: %d\n", err);
+		goto iu_free;
+	}
 
 	ib_dma_sync_single_for_device(srv_path->s.dev->ib_dev,
 				      tx_iu->dma_addr,
-- 
2.25.1

