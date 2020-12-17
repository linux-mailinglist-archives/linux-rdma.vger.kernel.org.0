Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3931F2DD2E7
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 15:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgLQOVV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Dec 2020 09:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgLQOVU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Dec 2020 09:21:20 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FA0C0619D2
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:34 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id jx16so38093307ejb.10
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vEuWFoKytWABvotO7nLGCLUvqS5FiiKvtoEn79wZVmk=;
        b=DbFrQGZSOGMGfBwbZfju0J94RHvzZOh//q6gcqaP9AiLTzeWRBXRosPb/9KVb41HHi
         rrC9lwN0Xa9urSqtpE3mQduNF7SfXOBSpe6wgscOw23m0XnslrUoDbLaOShd6IedQ1bm
         h/eulvy3B9WGcRZGLJGOlc5XADNCwKtiwWyAXZ8/4XAHuqTbO1qMd7Y2hirhhhClg+Sj
         noq4TDE4eX3tWfdnl6TlAbLVDgj9AxvpYG8C1z+APyI97OT6z57EXREue+eoNsnFq3mB
         6f9Ofl6CdhqfhD2vP1c1zcrZLFvXW+drvGmrhUhZh7k7cm0hvdp65lE8wLIgCqxA1aqb
         e3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vEuWFoKytWABvotO7nLGCLUvqS5FiiKvtoEn79wZVmk=;
        b=hZwdZfCllMygUHASdL8fIJUxBvXytnDpJm66DllRbR3bHrO+vW5/dfLUh1bPTxhx9u
         fubikZ9th80xwO0F/vA6ZklGPBSiAfwEBNZg21jVfYeSV4xJTdWzkF+QmF9dy6gNS9Zd
         58P73CsJWFejGH7L+pKjgFrUhJdG+Etom3euUFlUtNJ59Be4zCyx/G57PlKvYM/E8Fya
         6vVNfv1YYbacrFjbn8OIMPqgCjCmSS4YptjG8pmLDzWHhxXA935wFS8AS7ThKk9lEV5j
         +2MrQXMRsn1LjgLjz8coSSttgNR4Viq+8p1HO7w4FNpmZ5hxlO/8p91rypvxMc1Z6Ts9
         Cu5A==
X-Gm-Message-State: AOAM5301I8W2b9fn/j1mVVwHf2LTSfb1QpZYQCZsGGtzUmgx8wdbrHnk
        wpvpUPMeEIEDiCmdYZ6t9rEQKAYB97x7aw==
X-Google-Smtp-Source: ABdhPJwMbzNvdmTaB1jM/ErKDbmhnM9S1wNd5vHKAfUDD7zo39BJgP1n0F5waawpavmab5sFiQeS+w==
X-Received: by 2002:a17:906:4756:: with SMTP id j22mr36383724ejs.353.1608214772875;
        Thu, 17 Dec 2020 06:19:32 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4991:de00:e5a4:2f4d:99:ddc5])
        by smtp.gmail.com with ESMTPSA id b14sm18168969edu.3.2020.12.17.06.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:19:32 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCHv2 for-next 17/19] RDMA/rtrs-srv: Do not signal REG_MR
Date:   Thu, 17 Dec 2020 15:19:13 +0100
Message-Id: <20201217141915.56989-18-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We do not need to wait for REG_MR completion, so remove the
SIGNAL flag.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 8ea1df6b4da0..2798c655d7ae 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -818,7 +818,7 @@ static int process_info_req(struct rtrs_srv_con *con,
 		rwr[mri].wr.opcode = IB_WR_REG_MR;
 		rwr[mri].wr.wr_cqe = &local_reg_cqe;
 		rwr[mri].wr.num_sge = 0;
-		rwr[mri].wr.send_flags = mri ? 0 : IB_SEND_SIGNALED;
+		rwr[mri].wr.send_flags = 0;
 		rwr[mri].mr = mr;
 		rwr[mri].key = mr->rkey;
 		rwr[mri].access = (IB_ACCESS_LOCAL_WRITE |
-- 
2.25.1

