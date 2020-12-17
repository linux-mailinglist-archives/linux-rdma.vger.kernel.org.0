Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16142DD2D6
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 15:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgLQOUk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Dec 2020 09:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbgLQOUj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Dec 2020 09:20:39 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16376C061248
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:24 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cm17so28824678edb.4
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HaKGDnuifTU5L5KLU2Tpj7+tCZ+lTyDwJG4jK//u6Sk=;
        b=VI+ekysY4Vx41AFO01ZJU5eGxwCcFIAMDyXbUo1DeHj9YKE8C8PHcD6ryt0eKBjqxr
         TVBDQ6TFrFSenbDgtY/XVFAKi3n0CKBST4AR+hO6YXgoBVMsM7AU4jMbYAbIDCxawZuB
         BHxb28kt4TW0SEkWQTRi9+beSNJh6vuFXZWwWHmWjjabNFjWSQH7I0ZaSjFqiixP+LHA
         4Mbn/0cIbV986P65L4+4M3nAtkqRjE/ozfmneguTgjk+DcipcNWqif/cAsVDmq5FFOeP
         sI1i7kc8lnt/SAt/KlanMr5FAJyfh+eOkhanJ1iEZ1DMOndbExaQkVE7ZBy9oXYVzvGI
         z9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HaKGDnuifTU5L5KLU2Tpj7+tCZ+lTyDwJG4jK//u6Sk=;
        b=gijEVexpUjPTKPdcyD/ZtmH9heEbEPFtWsHqtpDo9lL3iGSt0mPlmU+F+B0OsZWVcp
         SUkiDiDmOOJiFd2QorjLynj4jbnGJ9CXESdIQYoIa/jQ43kwasxNtqnSAI2AGX7OxfpW
         4bk30RvaC7W0bbmW1BCMGrD+1EZ88m0X0Tq4QkrfXX9HmZce8hO3GWoX1L5TqCnhmZHt
         LFJGgJye17kVJFf/JDCkYFWK72LZby8u9r6yeZa8GuWE5IzLPEVXxOy5MhIjlF2xfQzr
         iPLwZfmhgm87aQ5wh3QhgegYaaDe93RAfkFKpfa2ZtjwVAnypgRsHwfaueKSb8ZSsEV/
         m3pg==
X-Gm-Message-State: AOAM530m3DG4tSMPn6v+82+DzUEqOEGngfukP74z9V8fbCo+X22OfqQI
        AfgpbErqm4DsE/8pnERxlFxmQlbl3mtAlg==
X-Google-Smtp-Source: ABdhPJx3pjmlYhdC7oA9AoMCKKRqBll3MHb4SDGbfUe0roHhv7Tn28oMxB/A0bszVddsNe/IDSLyig==
X-Received: by 2002:aa7:d485:: with SMTP id b5mr37568150edr.214.1608214762707;
        Thu, 17 Dec 2020 06:19:22 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4991:de00:e5a4:2f4d:99:ddc5])
        by smtp.gmail.com with ESMTPSA id b14sm18168969edu.3.2020.12.17.06.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:19:22 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCHv2 for-next 06/19] RDMA/rtrs-srv: Jump to dereg_mr label if allocate iu fails
Date:   Thu, 17 Dec 2020 15:19:02 +0100
Message-Id: <20201217141915.56989-7-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

The rtrs_iu_free is called in rtrs_iu_alloc if memory is limited, so we
don't need to free the same iu again.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 6771fb4a1110..89e938a1a4fb 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -651,7 +651,7 @@ static int map_cont_bufs(struct rtrs_srv_sess *sess)
 			if (!srv_mr->iu) {
 				err = -ENOMEM;
 				rtrs_err(ss, "rtrs_iu_alloc(), err: %d\n", err);
-				goto free_iu;
+				goto dereg_mr;
 			}
 		}
 		/* Eventually dma addr for each chunk can be cached */
@@ -667,7 +667,6 @@ static int map_cont_bufs(struct rtrs_srv_sess *sess)
 			srv_mr = &sess->mrs[mri];
 			sgt = &srv_mr->sgt;
 			mr = srv_mr->mr;
-free_iu:
 			rtrs_iu_free(srv_mr->iu, sess->s.dev->ib_dev, 1);
 dereg_mr:
 			ib_dereg_mr(mr);
-- 
2.25.1

