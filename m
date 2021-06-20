Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C7E3AE02B
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jun 2021 22:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFTURc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Jun 2021 16:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhFTURb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Jun 2021 16:17:31 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACA5C061574
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 13:15:18 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r7so16070166edv.12
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 13:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UoXeGFUYWl4kX6Xyg07j2TvWhA+3VGoss8gs+6ssYkM=;
        b=Ys+J5XV2BeOiKnPu2nJGFmUd9Yj0G0zwgGLSDFqCh7oQBXNSTgMpbo5G1eCTkGeghE
         CyOMH5rBkeouM/wEluymoCTnZejuOQf+RtKl57dpxHYBOqXPQ2qcenVVFVmoV4cWANMc
         rLDb1Mdy6Gku5H4GZtJHtr57WXpe00sEhUsLHj+Sa/EyY54xLOcjwqM5VWxsuWqENhhA
         VTkXmaJLZ9ckmz0QXdQ/pMR168qdLsmHwDA9TW7EeBXIUS19o+TsS7HLUJhmxEXXyD8O
         HdfhbrmfgLcjvNtlMi8YQxSfWae+nhBV5HCGrFV1XLjKw2liRl6qw+ocYdRi31Nt/Jz8
         Td0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UoXeGFUYWl4kX6Xyg07j2TvWhA+3VGoss8gs+6ssYkM=;
        b=kAOYzGsFauW0VVTNkYd6yoUh4LYcWONVfzOfSSC9lR891B2Ynrflnxc0jrsQAAkmTl
         0kn24Tc8FnH5PPeDD7/Pr0hagAaXmhCyBG2Dk7lNkxdYg9h16PcTJKepOSs4L7BoDv0K
         QXPQMrUGQAIypowCJP3duhlKMzHg5MXrhdSLY2pvbFOuidBlrFm2oEWGoBYtAnGiIn0Y
         D7epO9lHzaFqUf72De8wuTbjCKeCFc+Xn7Wzx4CKkhG0h/M5yVQRXzajd4/KGbZ1qdNH
         opERsQNUltvpowqaSVqbEx/4vDrSzALzvKD6r7ubRWEyq5LjK7xfgMmwNdfp6UjIxBYf
         nSbw==
X-Gm-Message-State: AOAM533/Btd15b7Ta0FeDNapp6mtz627yq17EArSA84pfOZB/gyK8PKZ
        GI+kg1+DqWYpfhi7a1cX/zDiqbF4yzIeCFhV
X-Google-Smtp-Source: ABdhPJzvAySRYES5/Uh3DXbNCvq+zyD4Wna/0ecasDt9bnpiCRUI3UtIgiTrKeoZAOzQQN2FlgqJDg==
X-Received: by 2002:aa7:dc42:: with SMTP id g2mr17374622edu.362.1624220116878;
        Sun, 20 Jun 2021 13:15:16 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([2a00:a040:19b:e02f::1006])
        by smtp.gmail.com with ESMTPSA id hg25sm3880741ejc.51.2021.06.20.13.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 13:15:16 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/irdma: Use the queried port attributes
Date:   Sun, 20 Jun 2021 23:15:03 +0300
Message-Id: <20210620201503.67055-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Instead of hard code the gid_table_len value, use the value from the
ib_query_port() attributes.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index e8b170f0d997..5ae5dbcbc3a5 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3627,7 +3627,7 @@ static int irdma_iw_port_immutable(struct ib_device *ibdev, u32 port_num,
 	err = ib_query_port(ibdev, port_num, &attr);
 	if (err)
 		return err;
-	immutable->gid_tbl_len = 1;
+	immutable->gid_tbl_len = attr.gid_tbl_len;
 
 	return 0;
 }
-- 
2.31.1

