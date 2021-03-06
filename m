Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D59A32FAF3
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Mar 2021 14:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhCFNyS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 6 Mar 2021 08:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhCFNxw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 6 Mar 2021 08:53:52 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B042DC06174A;
        Sat,  6 Mar 2021 05:53:52 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so655905pjc.2;
        Sat, 06 Mar 2021 05:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FYJi31DX+dhl/A48m98af7vgNMsMwrVQX+PM5e9RccA=;
        b=khYkvtp0AY6HiqKyREnspfRGRv5Um5sMvkfg3A0KsF6Afq695Ja/L1ALtklIbKdNaG
         WOCcQnb/fiMN9rgVVRaDpk6gl4tqeW0AIrjUgwk3dXJDzP3INv2fizznkEPqSfF+21fL
         V9zfllAKL04BsCi2ZT/fz9a+yVdusd8O6yPhK3vHsdeG4S/2CjG3ETgAjk7FumolwBBT
         Wect+f4cXrkaPPt3aaZ2Pj+lyL0ShxtToz4KjsPIJriXXdvpbdt017ExQw2q8Cg3RXdA
         3LaRsLk3x+KmaAY9QsS4jNTYjb0P2iZj+2GH+yxWj7ar6YpHJN+C7YqB2rzO2g5tMtZn
         D0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FYJi31DX+dhl/A48m98af7vgNMsMwrVQX+PM5e9RccA=;
        b=iJVdDRixxJaH2C+Ihv+lqDMu9D6eUhFraUN3ua141orrmss058f/ikNUnSBmM5sHEx
         9QC4o0YgzG8C9Hn5kTpHhvR5jZU2GDfGyYNOFW77cBq8PHVEfC3t5RAEZRzwQtxsT3Lg
         2+9VRhAQDCpLnOi1jBxcIvsF5nd3gLSjznaxtQGEebDAUd2t7O+Yk2s8HD7nYLoVzQ4+
         k4rLq+mpi0cKEo7oGkKpY0Of5Y/Jp5FzVMCGBhlrDnysrDcS7goTo31wn7oa9cv8XwAx
         +mIMz/mvvRf2xNj3aqxMwO+6JqLZUrTz0hWC8P6b2IV3EQ5Nhfki5Xih8NaUKyAmlma9
         LV7g==
X-Gm-Message-State: AOAM530YOTVY9zBm884CCSlCGIFUvtZNeOXL50QUmWyHLOrJWkXbxbDd
        Z7hEDgtzaOjQCD1e45zPTvQSwsDPFWO9dw==
X-Google-Smtp-Source: ABdhPJwXEYA+UWCiYUe1LeUfBKpehh44LIfIqEgQUU4YUIbqHQlqylZb/97rlAlGqtJUV9rCvVpAZg==
X-Received: by 2002:a17:90a:7bce:: with SMTP id d14mr16199470pjl.139.1615038832250;
        Sat, 06 Mar 2021 05:53:52 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.66])
        by smtp.gmail.com with ESMTPSA id z2sm5500739pfa.121.2021.03.06.05.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 05:53:51 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     bharat@chelsio.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] infiniband: hw: cxgb4: fix error return code of pass_open_rpl()
Date:   Sat,  6 Mar 2021 05:53:17 -0800
Message-Id: <20210306135317.17803-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When ep is NULL, no error code of pass_open_rpl() is returned.
To fix this bug, pass_open_rpl() returns -EINVAL in this case.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/infiniband/hw/cxgb4/cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index 8769e7aa097f..773d3805bb25 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -2382,7 +2382,7 @@ static int pass_open_rpl(struct c4iw_dev *dev, struct sk_buff *skb)
 
 	if (!ep) {
 		pr_warn("%s stid %d lookup failure!\n", __func__, stid);
-		goto out;
+		return -EINVAL;
 	}
 	pr_debug("ep %p status %d error %d\n", ep,
 		 rpl->status, status2errno(rpl->status));
-- 
2.17.1

