Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3415B3941C3
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 13:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhE1LcG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 07:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbhE1LcD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 07:32:03 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F82C061763
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t3so4456126edc.7
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UqI8oT48GQU5Cb3cgdbS9uhiAtyr8X1676tU5j3rscY=;
        b=XtLfibf9rI0H6odRlVHQBJi3CL04cBJuyl+Ff5mBYSW2vVqM4+s/R8rYbZ/CPkPCEK
         J0fPxUTeoP56K62yJmFJi1Jn0Dx/1M0ZuFWsp1AnaAtRgW1w2e/X5rNKH6+qjcjHENs0
         FkmQhFJxRnY7Mgx+htPs6ndwfINYWjFVK903+MCMpFKukUELxmFkQ/OdgwcvBaqBe+NY
         K845Qs9eQhymoTpYEio11UDl5v41WD0OfOZNnVOGaCE97HLgeLxzYZwHtgXb4eatabKT
         C5+qV1zrDKh7+N2FYttK/FeP+bkq6RufkjHP/HiqszIxgwTAVzmCyzBd9OGl5i/Ewb8E
         MLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UqI8oT48GQU5Cb3cgdbS9uhiAtyr8X1676tU5j3rscY=;
        b=lbVALeUr7wXJTARGT62nz8tbdIQIQE1qQ50XEVk/3j5yUP2cbAXLm99G6ie6Cj6wmX
         L3Q10Je4S/dYR4S2WfrbDRXG3Q+IPu0tqLmlsMHCCiIWFfXwIWD3aKtmPHrTKPk7lYcj
         rPz56rNIlEIAmiJTkxItCWekqpp4ZcV3loRWtsA3pAMdgOQluQTpmEi7S+8xXltuZwRC
         lPXutIQq0VgulfdSm49zk64OIS1ojAZIzUcMAdRf8WEbL758/Z4ZW6sszhcJ5KvYmJqa
         eawORB/s6Zil+9svLP96r4SckWK+gcGDyyv1YbaVSAK6ciZG6mBoKFAe1H2f7F1hN3Fg
         pvkw==
X-Gm-Message-State: AOAM533Qgs76Cx6YW7ty0OYV48lHBVwXnO9kvCnTonFgli/HRECmfkjJ
        nuHCKUOgfqbkOEW769Q9Zer9oo8wmWuSCA==
X-Google-Smtp-Source: ABdhPJwP1BE3j+Q1zEusu2ARcesZeJtw1zi2Bp/iYYdM3ETRHYjjYiM2RUzoTjPw8CITpf9YzkCWuw==
X-Received: by 2002:a05:6402:3587:: with SMTP id y7mr9158523edc.360.1622201423112;
        Fri, 28 May 2021 04:30:23 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:497d:7d00:983b:122a:4685:3849])
        by smtp.gmail.com with ESMTPSA id p15sm2594578edr.50.2021.05.28.04.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:30:22 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 04/20] RDMA/rtrs-srv: Clean up the code in __rtrs_srv_change_state
Date:   Fri, 28 May 2021 13:30:02 +0200
Message-Id: <20210528113018.52290-5-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528113018.52290-1-jinpu.wang@ionos.com>
References: <20210528113018.52290-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

No need to use double switch to check the change of state everywhere,
let's change them to "if" to reduce size.

Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 7a0954aa24c8..aa0585c176c9 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -77,32 +77,17 @@ static bool __rtrs_srv_change_state(struct rtrs_srv_sess *sess,
 	old_state = sess->state;
 	switch (new_state) {
 	case RTRS_SRV_CONNECTED:
-		switch (old_state) {
-		case RTRS_SRV_CONNECTING:
+		if (old_state == RTRS_SRV_CONNECTING)
 			changed = true;
-			fallthrough;
-		default:
-			break;
-		}
 		break;
 	case RTRS_SRV_CLOSING:
-		switch (old_state) {
-		case RTRS_SRV_CONNECTING:
-		case RTRS_SRV_CONNECTED:
+		if (old_state == RTRS_SRV_CONNECTING ||
+		    old_state == RTRS_SRV_CONNECTED)
 			changed = true;
-			fallthrough;
-		default:
-			break;
-		}
 		break;
 	case RTRS_SRV_CLOSED:
-		switch (old_state) {
-		case RTRS_SRV_CLOSING:
+		if (old_state == RTRS_SRV_CLOSING)
 			changed = true;
-			fallthrough;
-		default:
-			break;
-		}
 		break;
 	default:
 		break;
-- 
2.25.1

