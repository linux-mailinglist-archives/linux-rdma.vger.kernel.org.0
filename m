Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6997F17A5
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Nov 2023 16:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjKTPmB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Nov 2023 10:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjKTPl7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Nov 2023 10:41:59 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC1F9F
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 07:41:55 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-332c82400a5so682639f8f.0
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 07:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700494914; x=1701099714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSBtncvVFIAjcOQx6vcGK234wY6nleJLXfqV+dBrwBU=;
        b=a0RfQbkht0B0YxJD6z/m6swwAHCrdXBuiTF50W5xJceAY4S5dStpvR/ZzfK5lt88gk
         9YvGg4794lMrrZkhuYEY58LNOmfhcTnUt/mSage2FeFIbBwxjlQyvtzJ9TPNilWOTxqo
         Ly6Q1pjqN692fDxSUGGUj/VDgghUHdDojBggG1NVphctvj7EhJvS3uVuOK2pIHhlTdlx
         pnkd+JGZxb9iGeRhjmCnqOsawTvAupUMvXrJVi15/eWAiiWUYYs4CpLf4ao5m9UqlHZe
         FoB15r2J8B84hu0cV66lvI+/heIDDbzrB34ZfiJ9yCISKuWUbsLxo8gUdYkB1eMvLyYG
         JDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700494914; x=1701099714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSBtncvVFIAjcOQx6vcGK234wY6nleJLXfqV+dBrwBU=;
        b=T5dckTDTToBWzpsr2se1dw7r0feK8c8jUnzwyzO+sf+HnA9aZDSIhTHw/OvyMikTat
         TkO3+SJvqemAaNW8t92NKoh5j6xmf+ZaXB6yVoiRx9pgPMwleGbb86Tw/LaFwf4pDowZ
         qdZevr+RHysC5UPqitDBnhZ/bCU5k9WED66X/pL54rj+8pR6zTFrkAA00A9a7PWOyWob
         oSzlONSdUs9SBSQoZeJlo0Hhh++UUuR/fKRWQWwDrY/RgAeTfpErHqY84xqBF63AiFr7
         8uGnPyKwMxbGbKHTgOigwT601zkMwvbOgZwtvJThfCj3C56+/netIkiIkWQBRFJvJEBO
         NYCA==
X-Gm-Message-State: AOJu0YyoeyuaFVXaSRlBUZ7EKoevfNblyquXJSLdJlw2PWjcPhs99x3r
        5Z31dpWXtpKGK37YuoBlYApY10OD2w91OOl1afs=
X-Google-Smtp-Source: AGHT+IFRBfzMl/3CzwSrSwfmmtMP4F/Xc657bjbeY6uwGYZD7PuTwRd0QBk47w9y++yjBuTh1Ni2kg==
X-Received: by 2002:adf:fc4f:0:b0:32f:7cea:2ea1 with SMTP id e15-20020adffc4f000000b0032f7cea2ea1mr4862723wrs.18.1700494914331;
        Mon, 20 Nov 2023 07:41:54 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net (p200300f00f4ce2a470fb6777c650c5ae.dip0.t-ipconnect.de. [2003:f0:f4c:e2a4:70fb:6777:c650:c5ae])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d66c6000000b0031c52e81490sm11611461wrw.72.2023.11.20.07.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:41:54 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Supriti Singh <supriti.singh@ionos.com>,
        Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH v2 for-next 8/9] RDMA/rtrs-clt: use %pe to print errors
Date:   Mon, 20 Nov 2023 16:41:45 +0100
Message-Id: <20231120154146.920486-9-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231120154146.920486-1-haris.iqbal@ionos.com>
References: <20231120154146.920486-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Supriti Singh <supriti.singh@ionos.com>

While printing error, replace %ld by %pe. %pe prints a string
whereas %ld would print an error code.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Supriti Singh <supriti.singh@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 8c5054d18402..493efbba2fe3 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1391,9 +1391,9 @@ static int alloc_path_reqs(struct rtrs_clt_path *clt_path)
 				      clt_path->max_pages_per_mr);
 		if (IS_ERR(req->mr)) {
 			err = PTR_ERR(req->mr);
+			pr_err("Failed to alloc clt_path->max_pages_per_mr %d: %pe\n",
+			       clt_path->max_pages_per_mr, req->mr);
 			req->mr = NULL;
-			pr_err("Failed to alloc clt_path->max_pages_per_mr %d\n",
-			       clt_path->max_pages_per_mr);
 			goto out;
 		}
 
@@ -2061,7 +2061,7 @@ static int create_cm(struct rtrs_clt_con *con)
 			       RDMA_PS_IB : RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(cm_id)) {
 		err = PTR_ERR(cm_id);
-		rtrs_err(s, "Failed to create CM ID, err: %d\n", err);
+		rtrs_err(s, "Failed to create CM ID, err: %pe\n", cm_id);
 
 		return err;
 	}
-- 
2.25.1

