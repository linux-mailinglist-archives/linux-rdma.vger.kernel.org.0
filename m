Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8317F2D4714
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 17:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgLIQrH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 11:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgLIQrH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Dec 2020 11:47:07 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C0CC0617A7
        for <linux-rdma@vger.kernel.org>; Wed,  9 Dec 2020 08:45:53 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id jx16so3049307ejb.10
        for <linux-rdma@vger.kernel.org>; Wed, 09 Dec 2020 08:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Pn0i2ODFxtlo5fkTtHKkET0BlkV0Daj5off48gQ1UE=;
        b=M8hcGweIXwjhaE7L62nb/Eb/a3UB/DUuQcWK+0JOh2RydtuKSPxbnzpOv+atEAnYvP
         k7+/+S18bEQFzr2CrdWLBVR51XN62w7cY3wiQMcK81Viv6wewy51cdxNZuNxVNf+1+Ow
         o/6tQb1AOCMI8+gw34EX2vxHve77I7qbLmfNw1/ugZCwN9LnPVsApDIgtTMCemlGC5ev
         fTgZ4ol5n/0ByB9VFwV2f0uOh7wodZs+6w8ZsfATPdBICNanND/o11RKXL1/3okSEeP6
         KqIleIQDhjLcEXa1fGN9601lCbfAT1au3m7weZgFlReFyJzNZSHQ7UExqtR4lVczciOT
         BDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Pn0i2ODFxtlo5fkTtHKkET0BlkV0Daj5off48gQ1UE=;
        b=Y7tVYze8XHurgvOlg7PFoHLSAHPCeL+0aiz4KEcc5FOBnWFvRfflnAbKSvY5TwFBKL
         dfgAAaXumjYtT1BsbAygc20HJc4/fPLQTpB6DG2jFnhB+CtFj5Pz4uyw2aEWR0/daH4i
         RBuOJgNsk3bv4kd7jrF+JMOQHvpKClwKuu9B+lHlFMWvBEeNqDWQCgmWghfU//XFJR/z
         5RS+ffH+WCl377dg3SaJ6kqwFG9PypaQMg/ykZJjy8hjiyqSAFmjpSE6Xv/EDtW71M+B
         PbOJkod67BN+WZp+q1/71yoVuS6ZWq8bwNdwY38Bign2dhrI2OFyTV6LJ/CXzqEaqqY8
         O1vQ==
X-Gm-Message-State: AOAM530EZ1N9eaK2coKXTam5NaQBluzTiisqyVw2fiV/Z8ifygP2ZBNO
        o1+goZsRFsX7uPUxVgMUjgVIe1+l0m99og==
X-Google-Smtp-Source: ABdhPJwjEfHECaPJBXobzKGEC/OMQamBO9Jeo2f7ZOrD/e/V3wDPzWRXvUoZkFuyYmyHncAdpr8fBg==
X-Received: by 2002:a17:906:ccc5:: with SMTP id ot5mr2781618ejb.248.1607532352060;
        Wed, 09 Dec 2020 08:45:52 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id h16sm1977915eji.110.2020.12.09.08.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 08:45:51 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 06/18] RDMA/rtrs-srv: Jump to dereg_mr label if allocate iu fails
Date:   Wed,  9 Dec 2020 17:45:30 +0100
Message-Id: <20201209164542.61387-7-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

The rtrs_iu_free is called in rtrs_iu_alloc if memory is limited, so we
don't need to free the same iu again.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index ef58fe021580..27ac5a03259a 100644
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

