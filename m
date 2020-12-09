Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A522D4719
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 17:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgLIQrf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 11:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgLIQrW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Dec 2020 11:47:22 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3CDC0611CC
        for <linux-rdma@vger.kernel.org>; Wed,  9 Dec 2020 08:46:04 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ga15so3076144ejb.4
        for <linux-rdma@vger.kernel.org>; Wed, 09 Dec 2020 08:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=15VQrmvhlUpyxMOUEn1612DZAbVr+8NuIXtdm8Gd1fw=;
        b=ftsCkmXvj3ClXhazKO2e+EZHBNCbOjYAGlwMZC/qbIY9NAVk4s2f7ZmSCMi/UWY9a+
         ABIrmvDiErhhY5PiNAX71ivMieOtu/2ypkf4BtzWa/iPZL4Y36vuhv/zjLffl5GA84ub
         XGT7ONeuGIZEzFsa+7oCMn2wPMnjGkHseiq11oKfhp2jf1+0beMeRHYLJreSsExF+lv2
         dnV463H6EBuXyHfAZYN+EA1a136eJs+6gye4c8DjLsw0abpHbszQo2vPjf8WY0aOW3hN
         GjEmzU/YO6GxHGRWw/W9WWk6D4OBDN4ANOMKBTqvjEhTfiXUjdkeQDMA0GeOE+CcDuS1
         1P3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=15VQrmvhlUpyxMOUEn1612DZAbVr+8NuIXtdm8Gd1fw=;
        b=JpWehOGpjU03r8iWfGZBXUCYg8V3EogSxR3TPem9Y33upGdlyV6smT/ZyjGazJpu5D
         p8EWurouLHSGA6GxbAYNjNS8UsoYqSLZIonQn1Ze2mhGwn57/6BPwfIaSGyRorkjY7Fv
         x3/b9EbjtxGVOsjZ0gPoi5iN7j3asAsHd2G0JdzBpsVglT1va4qpZS0OAh3/x905XJB/
         W/f7N5rB3kR+nBzBQSwUh1HhWc8gjFTYk/JRFeXRK7KbFZ84AOWCti/yicBDrpcA5/lC
         K+pXq1JWD82zRZLVsfY/kRN4Vr4VPrkHXvfBvlUitDMDzt04dKkYTdQWdMoMEyC34M4d
         JAWg==
X-Gm-Message-State: AOAM531SkaZs2dpaG4mmjCtPdp/3/L82QHcM9IpeImRpuG79tK0J7FhM
        zSawOueNgytjMV/7WAqp3joPCmmPUC8WqQ==
X-Google-Smtp-Source: ABdhPJw54p/6Scj6YfCnIg0CaZxn+WUec42ilRO3sdghXIfSpWYTp6UTBt8NC7cleThlDjEvVkJNbg==
X-Received: by 2002:a17:907:20dc:: with SMTP id qq28mr2737236ejb.403.1607532362910;
        Wed, 09 Dec 2020 08:46:02 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id h16sm1977915eji.110.2020.12.09.08.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 08:46:02 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 15/18] RDMA/rtrs: Do not signal for heatbeat
Date:   Wed,  9 Dec 2020 17:45:39 +0100
Message-Id: <20201209164542.61387-16-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

For HB, there is no need to generate signal for completion.

Also remove a comment accordingly.

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reported-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 1 -
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 1 -
 drivers/infiniband/ulp/rtrs/rtrs.c     | 4 ++--
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 493f45a33b5e..2053bf99418a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -664,7 +664,6 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 	case IB_WC_RDMA_WRITE:
 		/*
 		 * post_send() RDMA write completions of IO reqs (read/write)
-		 * and hb
 		 */
 		break;
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index c742bb5d965b..5065bf31729d 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1242,7 +1242,6 @@ static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 	case IB_WC_SEND:
 		/*
 		 * post_send() RDMA write completions of IO reqs (read/write)
-		 * and hb
 		 */
 		atomic_add(srv->queue_depth, &con->sq_wr_avail);
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index df52427f1710..97af8f0bb806 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -310,7 +310,7 @@ void rtrs_send_hb_ack(struct rtrs_sess *sess)
 
 	imm = rtrs_to_imm(RTRS_HB_ACK_IMM, 0);
 	err = rtrs_post_rdma_write_imm_empty(usr_con, sess->hb_cqe, imm,
-					      IB_SEND_SIGNALED, NULL);
+					     0, NULL);
 	if (err) {
 		sess->hb_err_handler(usr_con);
 		return;
@@ -339,7 +339,7 @@ static void hb_work(struct work_struct *work)
 	}
 	imm = rtrs_to_imm(RTRS_HB_MSG_IMM, 0);
 	err = rtrs_post_rdma_write_imm_empty(usr_con, sess->hb_cqe, imm,
-					      IB_SEND_SIGNALED, NULL);
+					     0, NULL);
 	if (err) {
 		sess->hb_err_handler(usr_con);
 		return;
-- 
2.25.1

