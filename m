Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C197F17A1
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Nov 2023 16:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjKTPl6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Nov 2023 10:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjKTPl5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Nov 2023 10:41:57 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFBBB4
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 07:41:53 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5094cb3a036so6495322e87.2
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 07:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700494911; x=1701099711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pob3bv1VxUk0GJtV3zmJp1DRnvaHALhI3QlwDuZX2QE=;
        b=h+yzvXeVX/yE+u3LRVaxxPvP5zeUVppuTi4bcHjSsux95N3DTshJStzfbx+hrilZSZ
         8AlBZMuBTYGcQmMS9kbWliytrDoMj6ILEgXG5WCpnoSnzLdGIwt05/r7SCEc4p6n8YoC
         n3tNQ3syt7pB9erRYcglpcGu5as2q5wGMGpzUxLhx7phuS+m4Slf0qsNybJ1QAoUFroV
         fQa2HH7I5CtQgS3zDYYesA38MgOx/dOpwt2fHFS+dV+2vHd/mPO9rG9/Y5x+vcJUNL6/
         bJgNA1Vok7N7zTCyEJSU43eSaUjaOIv8z7T6q0OTIf2UoNcTjyf2kJiOeAsslazyJ0Pm
         giAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700494911; x=1701099711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pob3bv1VxUk0GJtV3zmJp1DRnvaHALhI3QlwDuZX2QE=;
        b=IpuYc1lUiyETcj40J8Y7taKmuqAjospRm5DqNPyUGJdDOnmma6zO8oTsccqxGLNPxZ
         qfFW20HEWlm4wer/FNEtcVIs5JzGogV9iG/y7fXEP/vvywAgMFppJ6KZSOK9QrikvqEl
         A1qU12TQ/WRlbmFKH5nlJ9liUa2gwL8TrjDjd98adlZw8zKLxDxf8oQgM/420J/RROcx
         N8hwbegMVDu/CiJC9QqI4dI/z6l3I8ZezDyI8UDyb2eLruNsdPXt6KUlcqZyQdBoS99G
         9drjet683fxS56+1/S38KFraTtB5YTZ2UKPMW20O4b/jrFlThxYCd6LzW9Wks6jY12I+
         8tWQ==
X-Gm-Message-State: AOJu0Yz+Nsi9lNcPKaXu2Plw8AayUkrnnWmlJR7RHzfqagWA/bVSPDFy
        ZRUugRfPEiMIpCeBk/fhc+945YTDX8xd0UbxOdI=
X-Google-Smtp-Source: AGHT+IHGs259yFSfO1rZg+3oxDooCagY41FTswRXR24BS/PfKwEi7S/n6nZrpxXfzVhwFUv1ljog1Q==
X-Received: by 2002:a19:5216:0:b0:509:4916:8b6f with SMTP id m22-20020a195216000000b0050949168b6fmr5388243lfb.37.1700494911618;
        Mon, 20 Nov 2023 07:41:51 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net (p200300f00f4ce2a470fb6777c650c5ae.dip0.t-ipconnect.de. [2003:f0:f4c:e2a4:70fb:6777:c650:c5ae])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d66c6000000b0031c52e81490sm11611461wrw.72.2023.11.20.07.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:41:51 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH v2 for-next 4/9] RDMA/rtrs-srv: Free srv_mr iu only when always_invalidate is true
Date:   Mon, 20 Nov 2023 16:41:41 +0100
Message-Id: <20231120154146.920486-5-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231120154146.920486-1-haris.iqbal@ionos.com>
References: <20231120154146.920486-1-haris.iqbal@ionos.com>
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

Since srv_mr->iu is allocated and used only when always_invalidate is
true, free it only when always_invalidate is true.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 4be0e5b132d4..925b71481c62 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -551,7 +551,10 @@ static void unmap_cont_bufs(struct rtrs_srv_path *srv_path)
 		struct rtrs_srv_mr *srv_mr;
 
 		srv_mr = &srv_path->mrs[i];
-		rtrs_iu_free(srv_mr->iu, srv_path->s.dev->ib_dev, 1);
+
+		if (always_invalidate)
+			rtrs_iu_free(srv_mr->iu, srv_path->s.dev->ib_dev, 1);
+
 		ib_dereg_mr(srv_mr->mr);
 		ib_dma_unmap_sg(srv_path->s.dev->ib_dev, srv_mr->sgt.sgl,
 				srv_mr->sgt.nents, DMA_BIDIRECTIONAL);
-- 
2.25.1

