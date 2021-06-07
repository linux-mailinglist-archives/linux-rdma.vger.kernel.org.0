Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1B439E96A
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 00:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhFGWSF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 18:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhFGWSE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Jun 2021 18:18:04 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8093CC061574
        for <linux-rdma@vger.kernel.org>; Mon,  7 Jun 2021 15:16:01 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so602847wmq.0
        for <linux-rdma@vger.kernel.org>; Mon, 07 Jun 2021 15:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/dJwp/5qIv6m4+sjUeD1Id8SPwL449jXcbq/vD1eHq8=;
        b=MDFe37QCtrDjLED85hMNm+pf0wcsqcgkbzHSYgBMNTsSy/aRFT+5Y/X+ZpTyI78Xfu
         IpxUtVQMqWPT2515j5haj4eBnIjd4DWZ2i00eN9tKrV27FR/rk8nUZ03esOlnynoAKyb
         WgiW148McJkhtZ3/GlG05pve0plhbHRBEX2YufSaBZf7MiBkSkYayAtFIhUkLuTO+q9v
         OkcN4wlEn/aCMvgb/LWJqd9jPjuRVQwCLLUAjOsKifwyenuTkQAhfOBEUDuq12pIDWM9
         7uTuFfuNdCQgDT9iYskxq5NZbzATzhz+a7pB0UVxyxBgDS6JWbpiema00HqpVfxZ08OK
         geTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/dJwp/5qIv6m4+sjUeD1Id8SPwL449jXcbq/vD1eHq8=;
        b=GnHde5yeF6DlocfMPKUtBjaUJN1z7dMb6fUgcRAnK/OF16cLvFlWB6Ys2nIq4wbmtf
         M2mxkT/I60Ina1OfUGk+T756FnNwP0TEOTLDz+YZs5Yv+xVgWOQ4uq0zP084IJx4A6RK
         5/sakDlHAH4wsFdWreOO/hn0h4g8c8ASG3SpGIH6TUc+kHw0xr4gZa9b3q89ev2KWMbu
         gA6iZ9tUgrzR8lGOYHE3YRvdu7jOMs1sV9Q0gxjFqDICZfiizP4oHkn0onVuSikwo6CZ
         iIfnAF+b+XeDmnr3U5rXy5/kUbq/+RpCBflRPR9ywlhcoO+8wkMQpHMOM9arIC3rTc6R
         DWCw==
X-Gm-Message-State: AOAM531NmQWT+x3XylmLxOhC22lujAzkCZqf9cbmieaBRMBVByThRhNo
        9L7pN6oXimKt2BxEZf3JBIeq1Zgt9+v7Hw==
X-Google-Smtp-Source: ABdhPJyn/VP5d0B2CFDzcZstPstBmvZ/5qimdw18LiAV2AgYkVToIKQImeO+V2Q6WvnG2MO25EW9Pg==
X-Received: by 2002:a1c:e907:: with SMTP id q7mr1090814wmc.1.1623104159907;
        Mon, 07 Jun 2021 15:15:59 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([2a00:a040:19b:e02f::1006])
        by smtp.gmail.com with ESMTPSA id b188sm1036496wmh.18.2021.06.07.15.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 15:15:59 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/irdma: Fix return error sign from irdma_modify_qp
Date:   Tue,  8 Jun 2021 01:15:43 +0300
Message-Id: <20210607221543.254144-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is a typo in the returned error code sign from irdma_modify_qp()
when the attr_mask is not supported - Fix it.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 294155293243..154ca25e7e32 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1472,7 +1472,7 @@ int irdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
 	unsigned long flags;
 
 	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
-		return ~EOPNOTSUPP;
+		return -EOPNOTSUPP;
 
 	ctx_info = &iwqp->ctx_info;
 	offload_info = &iwqp->iwarp_info;
-- 
2.26.3

