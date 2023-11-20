Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4B17F17A4
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Nov 2023 16:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbjKTPmA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Nov 2023 10:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjKTPl7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Nov 2023 10:41:59 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24691B4
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 07:41:55 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32d9d8284abso3019033f8f.3
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 07:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700494913; x=1701099713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3izQq9XBdcyZonK9bU/62x0R62gqYmTfTwWEQOim/08=;
        b=OFRHVgm1e8IQavk6ogVcZuf3/U/xgFzweEeendkJK9nL7i15MBGRcDPdiEZUM+Ke29
         7Nv+150c+Imi/tWxYn+qgQP6VWJaZyCIHqrpTQ3EO4OioqXsdQ1aHX7bOfA9/Kl5sgy8
         gAiMT5F21S3ZMg7+VxCiLfWStdMKdQqEcMDtMijSomG9Xdk3OsaCJOD4UB0vGhe4HA85
         RW0GYA4OKMnZA4hN2ssga8GZowXW4Ng/3RUN4zUnGLqVDz0aK1xYtzYRXJXK0GI58Mh0
         2+tjsadEGbc77CFLgJceemlKFx8Or3gfXPePDo2NbEoNgwjrXKxQVdsnjjJW5dePu+Zv
         cH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700494913; x=1701099713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3izQq9XBdcyZonK9bU/62x0R62gqYmTfTwWEQOim/08=;
        b=H4yQ8FMdc8jVmoAFxWNmoanmv1kx0ngOBOCDcLce1xmqlMSRMOJ1UJQp71easLcOs8
         fLaI5laTtcl+QHSIKPwchG9+s69gk35/tGy43qHwfKqQWPHr9KTMUn+K584pSnT+UPtl
         6D41WXms5OYcSAls5Rt2+uTMZ7D8pO7gOnk/kmL99VjcUQ6yKSYd9CwI04yhCcRCBH88
         yOZ+x/p+JZBx5dhs0nhqcFyXFHQPVmYrP6QQXpidlggW51PQSDkHr3XHVtAhYoxLZHE+
         NXHKt58w+UJiAwu4jv7Uijyf+QuBVEVyVJfF1DXoHmnStP8WBCmX3LMfkbvV685riVvL
         8+PA==
X-Gm-Message-State: AOJu0Yzp8/pXUisTcUJt6YEASQfNK/HW3vsvvAMKwc74qHLEd7kiG6a8
        IZA6+5ttjR1piERXLbI787KENuHURcqjQhgG+To=
X-Google-Smtp-Source: AGHT+IGKDpNdG7hq6UJ+WDHZhI1IYOH4b/Li15FKjXgyf6cm9txQPPbaV7yGg7/KZ8BU6XE1rakw7A==
X-Received: by 2002:a5d:64c6:0:b0:32d:b2cf:8ccd with SMTP id f6-20020a5d64c6000000b0032db2cf8ccdmr6718690wri.47.1700494913629;
        Mon, 20 Nov 2023 07:41:53 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net (p200300f00f4ce2a470fb6777c650c5ae.dip0.t-ipconnect.de. [2003:f0:f4c:e2a4:70fb:6777:c650:c5ae])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d66c6000000b0031c52e81490sm11611461wrw.72.2023.11.20.07.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:41:53 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH v2 for-next 7/9] RDMA/rtrs-clt: Remove the warnings for req in_use check
Date:   Mon, 20 Nov 2023 16:41:44 +0100
Message-Id: <20231120154146.920486-8-haris.iqbal@ionos.com>
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

From: Jack Wang <jinpu.wang@ionos.com>

As we chain the WR during write request: memory registration,
rdma write, local invalidate, if only the last WR fail to send due
to send queue overrun, the server can send back the reply, while
client mark the req->in_use to false in case of error in rtrs_clt_req
when error out from rtrs_post_rdma_write_sg.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index df10d29c3fe9..8c5054d18402 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -384,7 +384,7 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 	struct rtrs_clt_path *clt_path;
 	int err;
 
-	if (WARN_ON(!req->in_use))
+	if (!req->in_use)
 		return;
 	if (WARN_ON(!req->con))
 		return;
-- 
2.25.1

