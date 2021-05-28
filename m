Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFEA23941C2
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 13:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbhE1LcF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 07:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbhE1LcD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 07:32:03 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A732C06174A
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b17so4535651ede.0
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7oViSJszh4ibc5NUk8IoIqQ2ThRs5jfT+cX9V/c4t34=;
        b=V5WhwHvtpnnUV8C6DajZ8E4F/fSStdjGvae8w9rlUO0YUS1A90qcy5MY+aFphD6pGj
         hDsjeY7EGs/4kEaMWDJ/0hdK0XrIEd/qEXlepDIAiA2tAMC76UnMuQE0ATDtizNYFT8F
         MHxOlzKfCvyUiUtRCBJlyVlr5jJZBiIcZgtoB2hIQQ3uJGtcmujO6a8rxTnWSCc3PDuZ
         l2P3DgT7MESqR+6ScQaDtx2QDfMce/KpmHrXEdi6hYYSzBclSrO4T6TFXJQBcr7ptG/s
         gP2JBdUQWqg6uO8SBbvb67b2QD+fWO9b5hMPk5UV6ReWmrSBwQsL+2DKvJUT10KzBCZc
         n5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7oViSJszh4ibc5NUk8IoIqQ2ThRs5jfT+cX9V/c4t34=;
        b=YmIWUOntfOnxjYTzQ/FyM4F0k6N31xirkjhL0dWRxlpWkbXfQN8K2pFht1uGcRzGpd
         lUakxvsYG87DaC3m4qsLv/siLa86xuPQo1byF9zaq+ZgnoemK1BuO1vI8MB1Mrlx+RKy
         1Nv+cVCT6t11JGvWNw3qXYFVZDQzWfFdWcYRlL/plZul8AggBfADZwLwDLz99bvwis9X
         L48Xcut6WOBJSJo186MX2yt02jcHOxGI1JlLzJJZ9TpCujp3PdI0HP/n8F7wS8azvHGf
         s1JXy3UtQm5ipZ4gxF7yx/+g/wI+o5UXgLHhUujdCoEi02aIGiyCnGWotqO5RNa4Cjfz
         BAzw==
X-Gm-Message-State: AOAM533bEfppI5S6aBShyS77F6oY/sNpfoREtluPtpLs7jr2c4UXL1SW
        lIMsvYTt5OI3GotUjIdNEZBQydNmWN2Eqw==
X-Google-Smtp-Source: ABdhPJw5Zqiyxi0V34ZvUjAuyLGrEu4QnU0AL6O6qIzT6vXc/0qoL4mIsnQU18t8wAFb5pFAvQxM/g==
X-Received: by 2002:a05:6402:2691:: with SMTP id w17mr9643914edd.140.1622201421523;
        Fri, 28 May 2021 04:30:21 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:497d:7d00:983b:122a:4685:3849])
        by smtp.gmail.com with ESMTPSA id p15sm2594578edr.50.2021.05.28.04.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:30:21 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 02/20] RDMA/rtrs-clt: Remove MAX_SESS_QUEUE_DEPTH from rtrs_send_sess_info
Date:   Fri, 28 May 2021 13:30:00 +0200
Message-Id: <20210528113018.52290-3-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528113018.52290-1-jinpu.wang@ionos.com>
References: <20210528113018.52290-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

Client receives queue_depth value from server. There is no need
to use MAX_SESS_QUEUE_DEPTH value.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 0a794d748a7a..97fa9da4dde4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2465,7 +2465,7 @@ static int rtrs_send_sess_info(struct rtrs_clt_sess *sess)
 	int err;
 
 	rx_sz  = sizeof(struct rtrs_msg_info_rsp);
-	rx_sz += sizeof(u64) * MAX_SESS_QUEUE_DEPTH;
+	rx_sz += sizeof(struct rtrs_sg_desc) * sess->queue_depth;
 
 	tx_iu = rtrs_iu_alloc(1, sizeof(struct rtrs_msg_info_req), GFP_KERNEL,
 			       sess->s.dev->ib_dev, DMA_TO_DEVICE,
-- 
2.25.1

