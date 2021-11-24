Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98FF45B84D
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Nov 2021 11:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhKXK1B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Nov 2021 05:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhKXK1B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Nov 2021 05:27:01 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FBFC061574
        for <linux-rdma@vger.kernel.org>; Wed, 24 Nov 2021 02:23:52 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s13so3287013wrb.3
        for <linux-rdma@vger.kernel.org>; Wed, 24 Nov 2021 02:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XUitlYZbSSKZbInMx1c/RCiYu8h3KD5yFcGQg+vghPI=;
        b=L4sifeX/h5Qt5fgW5A0mVYCAyVQDLIhpk+tkGz+7xejNodJuIjlGPAE63vqN36789W
         66QD2jgcOw4FKSvKQ4X0kKNWGjg55b1bN//FZjm7q8Xe+jptVqJmSP9i8T+daRZKZ6fl
         pjUAG6fNbN/ryy1ovTSyp2iZ648o9g3xVDQ0t1KRDjtyVw/HmuiM5BRxFHVf7WvYaszs
         rOShDZzmFDj5mpGUUG2DCGeCgkM6RMGo5J203PWkDrzZXXoJL/c3S0cVYlaPTZgAlVJ7
         cigt5w4LAwJfvpUlQcuVtS/mn+sBvmsTT+L5HpqnS49ICxTPvTWqwiZqSTlpBM6I+jWB
         ZBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XUitlYZbSSKZbInMx1c/RCiYu8h3KD5yFcGQg+vghPI=;
        b=yeY/YQQqRxQAVtHuKcPXkZu14Vnc9wmvnNbKFuU0V2pGWTTra2AMlS4r2+g5uOqKMT
         JIhkYFYm5++PnIEZp2MDgudJwGjrYR8WGjOPLYQ46y1TybtIHqWFXISFUqfgr6tCbINX
         ZAFyIQBJbiRce6a25AtqpqoLcfaV/EaYdCQpE7CFZ8Jni8MmtPeyYmtS4dfVjAhCQB0b
         /1+bv813VzjHbu5geded4sohVJ+L7g7dK/3oOqQ8JU93meumS6Wn+Qs7xpCmn5xN07rK
         Bz+2yDF8otsRdWYFEBKPUPB6Lr6Ej283XIq4rkSFARRBnaUxHSj9cDxST9AtOEKCvexg
         O0Cw==
X-Gm-Message-State: AOAM5301cSDI6h5w9WYWMtBL4Fp8iih7qvUqh7Mbx/OfIgwD7OFDr5J4
        lTzrbLESwXaU/Lpg4ogNqnKln7SJ+o0=
X-Google-Smtp-Source: ABdhPJynuVxiQRZa3ZgPzdUA1zscDWFh484Dl4h5fRUIFmgTU3gHKn9nJmNf/5hSuSwtlr21vF2ikg==
X-Received: by 2002:a5d:6a47:: with SMTP id t7mr13670803wrw.367.1637749429666;
        Wed, 24 Nov 2021 02:23:49 -0800 (PST)
Received: from fedora.redhat.com ([2a00:a040:19b:e02f::1001])
        by smtp.gmail.com with ESMTPSA id p14sm3815012wms.29.2021.11.24.02.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 02:23:49 -0800 (PST)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/siw: Use helper function to set sys_image_guid
Date:   Wed, 24 Nov 2021 12:23:36 +0200
Message-Id: <20211124102336.427637-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use the addrconf_addr_eui48() helper function to set the sys_image_guid,
Also make sure the GUID is valid EUI-64 identifier.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/sw/siw/siw_verbs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 1b36350601fa..d15a1f9c59f0 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -8,6 +8,7 @@
 #include <linux/uaccess.h>
 #include <linux/vmalloc.h>
 #include <linux/xarray.h>
+#include <net/addrconf.h>
 
 #include <rdma/iw_cm.h>
 #include <rdma/ib_verbs.h>
@@ -155,7 +156,8 @@ int siw_query_device(struct ib_device *base_dev, struct ib_device_attr *attr,
 	attr->vendor_id = SIW_VENDOR_ID;
 	attr->vendor_part_id = sdev->vendor_part_id;
 
-	memcpy(&attr->sys_image_guid, sdev->netdev->dev_addr, 6);
+	addrconf_addr_eui48((u8 *)&attr->sys_image_guid,
+			    sdev->netdev->dev_addr);
 
 	return 0;
 }
-- 
2.31.1

