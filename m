Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CCD3B6E68
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 08:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhF2Gzz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 02:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbhF2Gzz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Jun 2021 02:55:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82377C061574
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 23:53:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w13so23816252edc.0
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 23:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bMOlkJ/7n+lh5liKE0v3uj39M6w6vAHGDdB9+X7SX2U=;
        b=fSEY8lw0rCYXbUM8yWhyRTlfoo2cL+f5ex/IGqeKle9Z51seaGoHz65Zx1IkTusK55
         Ni18/26dACzlEBHWfeGDYECaX906RL5UMbSvCS4daLT7T7HLQaMs611TOXhai8MF1J5a
         aaTmIDCNB16MiRaxbtjDMk58YAzFIktij/1Pndw+WYGi4HtZNsYA6tpvHZIM+u9vXv8R
         tZYbOgQg+xsUM6h31al5yFQaY76FdlnXbIYKxXqnjGiOuqD9Ew0wwT2VWIhFvkvmQXRa
         bB35Erlm8RVi+iQ4c4PD2Pz6l3PKPEWnrAI5XDxYpdo50RIGtVlUzDG6nW46oprBhJC7
         5nyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bMOlkJ/7n+lh5liKE0v3uj39M6w6vAHGDdB9+X7SX2U=;
        b=cM7Cos2e1DzyWPZjTcU0+UE9CXMc0O9xiIgxJosPKAI4Yg9/HIoQQlNCsNjWUFMdWJ
         HYr3VUyi7CILzzDN0nWRK6ld/ez7ijy+5WB/WMPkYZKnZCOqYVrcWsH2tFx0Tf3B1wKk
         EsgVuuOHSbg0/dM6Vghk1lE4ScAI90vZSRkMPsNFeg/nltoL7SrTDfvHZbRpMf2v3x3o
         CMESSlP+YEXqK6Pi57v7cxiZ66JynTBG50sbcozAskVN6nbwpH6J8mksDd3F/aIB7k2d
         oBqa0byBDeEtM3O9a68STXSVB9V9lWfEfmn867gYvvxqArMDjSgD8BvdHSv0bnl/VJJI
         DYQw==
X-Gm-Message-State: AOAM5317WSrNj5BBH8mzWlfryjBK2cIsEXJWmUGdRwoj1bH7YTSRd2vU
        tDudV1kBUb29R4U/p41A2o5OFFSe4wrOLw==
X-Google-Smtp-Source: ABdhPJxvvbG1Ha2lrH0Tx2aas1O+nqqfECaam48jichM+oeLpMZQ5f6JeYNM4Zp0ViWEbjedMPdyMA==
X-Received: by 2002:a05:6402:290b:: with SMTP id ee11mr37676155edb.325.1624949607068;
        Mon, 28 Jun 2021 23:53:27 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:49c9:3e00:293f:8e14:7de3:8980])
        by smtp.gmail.com with ESMTPSA id t27sm7717853eje.86.2021.06.28.23.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 23:53:26 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, axboe@kernel.dk, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Aleksei Marov <aleksei.marov@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 5/6] RDMA/rtrs: Remove unused flags parameter
Date:   Tue, 29 Jun 2021 08:53:20 +0200
Message-Id: <20210629065321.12600-6-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629065321.12600-1-jinpu.wang@ionos.com>
References: <20210629065321.12600-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

flags is not used, so remove it from rtrs_post_rdma_write_imm_empty.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 528d6a57c9b6..b56dc5b82db0 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -185,7 +185,6 @@ EXPORT_SYMBOL_GPL(rtrs_iu_post_rdma_write_imm);
 static int rtrs_post_rdma_write_imm_empty(struct rtrs_con *con,
 					  struct ib_cqe *cqe,
 					  u32 imm_data,
-					  enum ib_send_flags flags,
 					  struct ib_send_wr *head)
 {
 	struct ib_rdma_wr wr;
@@ -320,7 +319,7 @@ void rtrs_send_hb_ack(struct rtrs_sess *sess)
 
 	imm = rtrs_to_imm(RTRS_HB_ACK_IMM, 0);
 	err = rtrs_post_rdma_write_imm_empty(usr_con, sess->hb_cqe, imm,
-					     0, NULL);
+					     NULL);
 	if (err) {
 		rtrs_err(sess, "send HB ACK failed, errno: %d\n", err);
 		sess->hb_err_handler(usr_con);
@@ -354,7 +353,7 @@ static void hb_work(struct work_struct *work)
 
 	imm = rtrs_to_imm(RTRS_HB_MSG_IMM, 0);
 	err = rtrs_post_rdma_write_imm_empty(usr_con, sess->hb_cqe, imm,
-					     0, NULL);
+					     NULL);
 	if (err) {
 		rtrs_err(sess, "HB send failed, errno: %d\n", err);
 		sess->hb_err_handler(usr_con);
-- 
2.25.1

