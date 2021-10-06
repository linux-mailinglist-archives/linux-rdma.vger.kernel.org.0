Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0DF4235A3
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Oct 2021 03:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbhJFCAR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Oct 2021 22:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237102AbhJFCAQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Oct 2021 22:00:16 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8ADC061749
        for <linux-rdma@vger.kernel.org>; Tue,  5 Oct 2021 18:58:25 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id t4so44447oie.5
        for <linux-rdma@vger.kernel.org>; Tue, 05 Oct 2021 18:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qApN8UnhyEUIjIpM/GmsOjj23Il/VJ1qkJLR9SYk3QA=;
        b=h1k53aN/IQWv9m++g8Olw7Tm/Yp44TPDDzoOCya7Hc3Y1GDwdqZwFE5PqZ8bmUH4LA
         KZaTjof1bYo7wr3uesxZWBt3NCadwwDCxy08Cxz+0Ci2GEIo3N0NX+Um3HC+/dA3dzgB
         ftvYA4RmWba9ETTxOG/hRMoze5dar3IZKjWdv0aJWAkQiE4Nnsb0VlhA+XTyz2wXLGi8
         ahQ5bUsyo0LSJhdPSwqAj3QENlj5dTVb9JiQOZi9C/pZQ95v5jBxXUnDtd499XdUKJVp
         nloelnpoKIl4Q1HxbdQvL3UF2rlCQlJZn38aSzz6uvr8oHeECidB6si5VpIhhQQwWhyN
         zAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qApN8UnhyEUIjIpM/GmsOjj23Il/VJ1qkJLR9SYk3QA=;
        b=TVrlVkyvUwv/N11/28Vd4CD86OX6hpu1LLVi+4G7ScTTPVxbzZp/iSMSj9jCuCkhHK
         1oZ6qz0Sm6XD6W5NI5qvTv4cY4swCgOtFvw462TbgyRsTYSoIcimSBU3kBgoB2RKXK9l
         Ab2ZieC/huxpm/4JspcumJ+Sz2McDCRmXMZ3GVfAJNa8o3BUhuQ1oxARGArJ+9LdwAyZ
         9HBYKT6M/n3VuUaPP9BC5uM3nJdSFZm5nl/aqK7Jw4+rx3vj0CWo/AWVzbyRW68BdgKn
         bzQ7MESdeg3KS4xjyxy81dhRLqYIV9oXhBon+JxclcZI1rilRoJbFj+8WF4leSzKR7l4
         T08g==
X-Gm-Message-State: AOAM5337NOrG9ekMOCCTlgbFqRg78yZ2wSMf6YjUNFJ8LDilvQ7xnc6v
        4BBZX9S+JTznJMQF1VRE5EodFRSBRQ4Xhg==
X-Google-Smtp-Source: ABdhPJxRUEnjrmqA3sEDUzjiVt7FqhRH0ZT7YSyDkytZ9kP5XOO8wITjXOZMmHKBwWLm/35jUDnetw==
X-Received: by 2002:a05:6808:bcb:: with SMTP id o11mr5128868oik.168.1633485505033;
        Tue, 05 Oct 2021 18:58:25 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-2b16-c5f3-6fcc-9065.res6.spectrum.com. [2603:8081:140c:1a00:2b16:c5f3:6fcc:9065])
        by smtp.gmail.com with ESMTPSA id e2sm4016057otk.46.2021.10.05.18.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 18:58:24 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v5 4/6] RDMA/rxe: Replace ah->pd by ah->ibah.pd
Date:   Tue,  5 Oct 2021 20:58:13 -0500
Message-Id: <20211006015815.28350-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006015815.28350-1-rpearsonhpe@gmail.com>
References: <20211006015815.28350-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pd field in struct rxe_ah is redundant with the pd field in the
rdma-core's ib_ah. Eliminate the pd field in rxe_ah and add an inline
to extract the pd from the ibah field.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 9cd203f1fa22..881a5159a7d0 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -46,7 +46,6 @@ struct rxe_pd {
 struct rxe_ah {
 	struct ib_ah		ibah;
 	struct rxe_pool_entry	pelem;
-	struct rxe_pd		*pd;
 	struct rxe_av		av;
 	bool			is_user;
 	int			ah_num;
@@ -471,6 +470,11 @@ static inline struct rxe_mw *to_rmw(struct ib_mw *mw)
 	return mw ? container_of(mw, struct rxe_mw, ibmw) : NULL;
 }
 
+static inline struct rxe_pd *rxe_ah_pd(struct rxe_ah *ah)
+{
+	return to_rpd(ah->ibah.pd);
+}
+
 static inline struct rxe_pd *mr_pd(struct rxe_mr *mr)
 {
 	return to_rpd(mr->ibmr.pd);
-- 
2.30.2

