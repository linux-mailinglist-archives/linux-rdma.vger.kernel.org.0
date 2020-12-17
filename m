Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7EC2DD2DD
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 15:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgLQOUn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Dec 2020 09:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgLQOUn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Dec 2020 09:20:43 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EF7C0611CF
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:30 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id d17so38116979ejy.9
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rWIBp61eWpeeSiM2PO3HAO/lWFN6/Kggc1TmjydEVeo=;
        b=GXrCYwsl/ebMrIiNgtWgA2YNVYDGjVnc8eNaOQDZn9qGloPs7a+6gtsZIZYbsZKbf2
         H6d8BwpFIRlHOJa4dLDfdABUkB0huC8jo4CdX4oJqdeM3cxUecBr5fPO6FjdKMsPG3ND
         d3kS6E7R+xytWc58PKV8X3iz4l2xz0pWpCr9LlpbZOXcfu1Yaw04TwfZNTENWNOTFxYc
         IxlpEC9SDbGfn9JiePKWvYouTADsAu3QnmCw0oBBS8FEy0kTCX9mYXI+u1ouRLfXmWyw
         tNW5tATAsLHe0meK+c57OYDKjOSH8ZzK36zm4NMPDSOKcJanwtxdn1lSjELfFEQB9pVK
         3d7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rWIBp61eWpeeSiM2PO3HAO/lWFN6/Kggc1TmjydEVeo=;
        b=I9dmmPKkVjJSh9jdn5wu0/z+egR69WevNPYxjt0dWILhB7UfnQyY3C8wIxF7HSsKlf
         a2dAImWhpy4Bn2cntcViJfNPksCu5vVS3Z3xxR+zyKzFE+QTJmtGXLxtw3JubtbwR6uj
         olXjb91vhbNFpPfYBRSNboukxO3yshCp4IK31u5fcHnW2CNWZp5MW7Re3CmNt4ynv0HJ
         S+n72QBDwh/pykjhLK53ynz+UnWbmjNAQCe4zmE6poj6/xWUmYOLduV37bIY31eYRrR2
         CwNLPT0AN/I4eXcxg3xGAhsNRGQimWO6N1TJ6AJGc4/+XvzjZ2B1+TLyksR6vL8Cn8m2
         FSEA==
X-Gm-Message-State: AOAM531dAfmntyWLe0rh3CttkMWVtAI33gT83pUy1zT4WfVr5YiN2F82
        SYdLLLuz3bRK/l15sL0FUM0EPPRVIjl8Aw==
X-Google-Smtp-Source: ABdhPJyJETbT5kqrbW6Bg4/spbywqPs0TZU39duRdspDdkQivSDorFa79yRW6h3cZPT8ZDefaNwwjg==
X-Received: by 2002:a17:906:924a:: with SMTP id c10mr35159031ejx.113.1608214768996;
        Thu, 17 Dec 2020 06:19:28 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4991:de00:e5a4:2f4d:99:ddc5])
        by smtp.gmail.com with ESMTPSA id b14sm18168969edu.3.2020.12.17.06.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:19:28 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCHv2 for-next 13/19] RDMA/rtrs-srv: Fix missing wr_cqe
Date:   Thu, 17 Dec 2020 15:19:09 +0100
Message-Id: <20201217141915.56989-14-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We had a few places wr_cqe is not set, which could lead to NULL pointer
deref or GPF in error case.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 89e938a1a4fb..465f20d6b89c 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -267,6 +267,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 		WARN_ON_ONCE(rkey != wr->rkey);
 
 	wr->wr.opcode = IB_WR_RDMA_WRITE;
+	wr->wr.wr_cqe   = &io_comp_cqe;
 	wr->wr.ex.imm_data = 0;
 	wr->wr.send_flags  = 0;
 
@@ -294,6 +295,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 		inv_wr.sg_list = NULL;
 		inv_wr.num_sge = 0;
 		inv_wr.opcode = IB_WR_SEND_WITH_INV;
+		inv_wr.wr_cqe   = &io_comp_cqe;
 		inv_wr.send_flags = 0;
 		inv_wr.ex.invalidate_rkey = rkey;
 	}
@@ -304,6 +306,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 
 		srv_mr = &sess->mrs[id->msg_id];
 		rwr.wr.opcode = IB_WR_REG_MR;
+		rwr.wr.wr_cqe = &local_reg_cqe;
 		rwr.wr.num_sge = 0;
 		rwr.mr = srv_mr->mr;
 		rwr.wr.send_flags = 0;
@@ -379,6 +382,7 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 
 		if (need_inval) {
 			if (likely(sg_cnt)) {
+				inv_wr.wr_cqe   = &io_comp_cqe;
 				inv_wr.sg_list = NULL;
 				inv_wr.num_sge = 0;
 				inv_wr.opcode = IB_WR_SEND_WITH_INV;
@@ -421,6 +425,7 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 		srv_mr = &sess->mrs[id->msg_id];
 		rwr.wr.next = &imm_wr;
 		rwr.wr.opcode = IB_WR_REG_MR;
+		rwr.wr.wr_cqe = &local_reg_cqe;
 		rwr.wr.num_sge = 0;
 		rwr.wr.send_flags = 0;
 		rwr.mr = srv_mr->mr;
-- 
2.25.1

