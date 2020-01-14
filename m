Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB96513A29F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2020 09:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgANIPR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jan 2020 03:15:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40724 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANIPR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jan 2020 03:15:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so11161953wrn.7
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jan 2020 00:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LSC2FfgJvSDgZwIhbJ4XrULOuTx9Qf60YsaiKMesJSQ=;
        b=qrGYOgIBWq9vj3Nr+j3McFa/fperuS8Vc4TG1a4Vr7y1JyCHKzrQQwerCaMpAAsX+8
         Wty3EkuwUlD2ErhRfqGLaMXOteiWpMYKaHTJdq3l6brlea06fhODxiTy2HOZ5O9FVJkP
         GetjjB0QJPAA0e8AmO/8br0v5EOqgvRrjakE0jCbuEeXHEFleRLKuDeyhliCr9rzEEX7
         +S2YvrNe3jvEkBCs7c3mpsSRDj9z+sERQnfmoGVPrZUFVTpqhxhn0DmmkIakJbd9ngIU
         oM2HkbkexLUf9q8W4leQAYc4TTpYXuDpNWBqVyG3XKKW94NCe4lSnon1tMOdAPP4ulkD
         mreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LSC2FfgJvSDgZwIhbJ4XrULOuTx9Qf60YsaiKMesJSQ=;
        b=sXU1fdxsWTa02cF09dbkyRrhA2BuBHEREOKTkLLnKBzx73dMR9yRTkk1MTRLf+GT6g
         SMyM+7CcDnYP3+j4qo9k6225sfDruM60hypL52gDiGWoHBmFAkvshDnxlNVNiYkm5TCv
         jx8GTl/D0lvjk9GCSK2wWsxYXbc3H/hlWv5EaMxvMdl9Qdyx5HBFp31K6paQmJT6xpoI
         fziYd2dR3SSH4AIyJPeFrn2f5Es4mgkj4MZZPbJ4YlX6A6FT0m9B3uWYL9me8hqSmBGk
         wBhf6+NW6rUKcajeS5PlQuuF/5PyzN3KsmAHINKptefHWPkKId38qypDyoUPvoGCWv0Q
         mQWQ==
X-Gm-Message-State: APjAAAVNhCW2QgpRhlsVdcnE80jFSe0EhWb9fzGQbLF5YrbN2FQDEUyZ
        jYlEdjOz15/czRSamkkIYXrCu3D8
X-Google-Smtp-Source: APXvYqyFppaW17GVCuhfm/S1APKSq7EgNuyiON/1rcY/t3Bx52Lczyci19QwYEaQWOsaJWgK2KYLlg==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr23753059wrc.175.1578989715028;
        Tue, 14 Jan 2020 00:15:15 -0800 (PST)
Received: from kheib-workstation.redhat.com (bzq-79-181-7-148.red.bezeqint.net. [79.181.7.148])
        by smtp.gmail.com with ESMTPSA id n10sm18407049wrt.14.2020.01.14.00.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 00:15:14 -0800 (PST)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next V2] RDMA/core: Fix storing node description
Date:   Tue, 14 Jan 2020 10:14:55 +0200
Message-Id: <20200114081455.1240-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make sure to return -EINVAL when the supplied string is bigger then
the node_desc array.

Fixes: c5bcbbb9fe00 ("IB: Allow userspace to set node description")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/core/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 087682e6969e..aa90a42d6565 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1268,7 +1268,9 @@ static ssize_t node_desc_store(struct device *device,
 	if (!dev->ops.modify_device)
 		return -EOPNOTSUPP;
 
-	memcpy(desc.node_desc, buf, min_t(int, count, IB_DEVICE_NODE_DESC_MAX));
+	if (strscpy(desc.node_desc, buf, sizeof(desc.node_desc)) == -E2BIG)
+		return -EINVAL;
+
 	ret = ib_modify_device(dev, IB_DEVICE_MODIFY_NODE_DESC, &desc);
 	if (ret)
 		return ret;
-- 
2.21.1

