Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0964A21EB0E
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 10:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgGNIK7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 04:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgGNIK6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 04:10:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC24C061755
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 01:10:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q5so20215863wru.6
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 01:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VnEpEj7Wi5IT2YAweja/qAq4cg9UzJREPeiQX23JUak=;
        b=nAkmBH3JvswHMUWaM211OT/rvfvVhLL/FiXjr1kSpC8fsumK7aA4uprExmik7c22u3
         goTIVD4z9818KlbB/tV/BskT60YYOiyuTJqJUHZcmfP1h2LlXMeuZyxzCtAAzFlUS8I8
         89AjsnbAykuaZmjDuzzskpS9gnQHm/8xpCFxmrOzReuNX9xTWW/hVE/S3zqIb9Msqoyn
         j+N9CTmevZe10jZtunH3oPsErp7gYs5kEDk1PnTXqq83PwEHPGG8JOijKq9jUjAI+NUH
         6U6IoPQR2eIJdGi667kZFqQg/uEX6ficw16bo4ANZgXy4poTwXAbqXvR5EhuECDc5eKt
         ML/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VnEpEj7Wi5IT2YAweja/qAq4cg9UzJREPeiQX23JUak=;
        b=eiKvaDQXtqGXrPCuOxYSZ7Ts9eVKz5gj+1l+5fOkvtziqZW8r+cVWYSi1gs1dHNokk
         iqQ/nZFwUJLH3SeHEnoHfGYkmO30YfUp2xE3z0giZISURRU3OItQJIcA3Ayz+ViknyXL
         twkIQ/yrqWzJuUyeFwOdySxq+WRGWHcJ11SjOBBXpwQdiItD+g/KkCrBhvUFIeFKVM0d
         phmMr0Zu5/9Fp5yk4Ss56g2cnvoM+0VI2g7ago71r/BeFShq1WuuqXmB1ACMm493akmb
         mZ1XGOyzNrPkty8CAaFYBuSuhDEX4TCgsBxrH5mwdbhSGe2sfmaGbAw7p+iW5eGcJVXE
         7h7w==
X-Gm-Message-State: AOAM5308s7p+9gygqL6fpqc/u1yzJ1gI5sEyQFy6U7pablbYB0Yy1Xk2
        DsFCEiiN3NAsEfgp02Zog/rvr1RtI4Y=
X-Google-Smtp-Source: ABdhPJzlKi8XHH61ooiysLHqpec2vJWztXbda/1FtD01+P4JISMWC1mFGSVNyNO07LZ3b6Boac2kSw==
X-Received: by 2002:a5d:4682:: with SMTP id u2mr3651017wrq.407.1594714256454;
        Tue, 14 Jul 2020 01:10:56 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-176-63-152.red.bezeqint.net. [79.176.63.152])
        by smtp.gmail.com with ESMTPSA id f197sm3403891wme.33.2020.07.14.01.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 01:10:56 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 5/7] RDMA/cxgb4: Remove the query_pkey callback
Date:   Tue, 14 Jul 2020 11:10:36 +0300
Message-Id: <20200714081038.13131-6-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714081038.13131-1-kamalheib1@gmail.com>
References: <20200714081038.13131-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Now that the query_pkey() isn't mandatory by the RDMA core for iwarp
providers, this callback can be removed.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/cxgb4/provider.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 1d3ff59e4060..6c579d2d3997 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -236,14 +236,6 @@ static int c4iw_allocate_pd(struct ib_pd *pd, struct ib_udata *udata)
 	return 0;
 }
 
-static int c4iw_query_pkey(struct ib_device *ibdev, u8 port, u16 index,
-			   u16 *pkey)
-{
-	pr_debug("ibdev %p\n", ibdev);
-	*pkey = 0;
-	return 0;
-}
-
 static int c4iw_query_gid(struct ib_device *ibdev, u8 port, int index,
 			  union ib_gid *gid)
 {
@@ -317,7 +309,6 @@ static int c4iw_query_port(struct ib_device *ibdev, u8 port,
 	    IB_PORT_DEVICE_MGMT_SUP |
 	    IB_PORT_VENDOR_CLASS_SUP | IB_PORT_BOOT_MGMT_SUP;
 	props->gid_tbl_len = 1;
-	props->pkey_tbl_len = 1;
 	props->max_msg_sz = -1;
 
 	return ret;
@@ -439,7 +430,6 @@ static int c4iw_port_immutable(struct ib_device *ibdev, u8 port_num,
 	if (err)
 		return err;
 
-	immutable->pkey_tbl_len = attr.pkey_tbl_len;
 	immutable->gid_tbl_len = attr.gid_tbl_len;
 
 	return 0;
@@ -503,7 +493,6 @@ static const struct ib_device_ops c4iw_dev_ops = {
 	.post_srq_recv = c4iw_post_srq_recv,
 	.query_device = c4iw_query_device,
 	.query_gid = c4iw_query_gid,
-	.query_pkey = c4iw_query_pkey,
 	.query_port = c4iw_query_port,
 	.query_qp = c4iw_ib_query_qp,
 	.reg_user_mr = c4iw_reg_user_mr,
-- 
2.25.4

