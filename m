Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 950E1D6898
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2019 19:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbfJNRil (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Oct 2019 13:38:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35101 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730039AbfJNRik (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Oct 2019 13:38:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id v8so20708471wrt.2
        for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2019 10:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E0mAKklmj8b9BHq3gYzHhA+M82D94UL3c4aRysFZhfg=;
        b=k+lqMOyKxtp6FXzpms8F1nl3BwkQR9ZJd4RsKZ9QUOCHgcot+2xjJyHRT2Zbhv9TzL
         9SBvE73C88D62rCfb0EFrQbC1EQobHH9c6GifPA2xamWAorQKXB9xgAVDtuTsuMengP0
         RIs2y0Y8onvCzT/0x7iKyooHUdpAhtTZClF5NfXRrhRUdxgFOXtm31XwRYZZSj1B2iL1
         MCSut+D809DGqUXqcEDVAJ5Bl1I4F2U9NCjRT+qBRDKo6vpfNqHN8lU7pGf7ArHquw6F
         EoUd7fe53FNQyEfBv92c7qEaKrAU4Dd0u3U0sxgvnZddZWtg+mPt4p66Aph39wbWGq66
         3R3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E0mAKklmj8b9BHq3gYzHhA+M82D94UL3c4aRysFZhfg=;
        b=UFVhMf+2RgrllyIhaJNU/vGUDaT7TmAeMnxsGf76dFav4pYPlIlS3rLk4T7hJJzvsg
         obPkF7mo6R5EtZiazj5IXsDKd/JpKtRUFOWNXuJXxF/IhjNG9EQdq9cK0roye7wEY2cv
         cB7OStDyZQizXh01wcWf/FsrtD04f2dVJdp8g8eHdzDsZJsx0r6mpPH47zsA9UFYfWFg
         sneSuS+yWkY/S1frGIWN/7feRU5vAFhvboxqyMHMjViA22SJ6B4PJFfdwO2Z9QdVzGod
         5/NIa62DwM0ryvErmQgjz2V/J1S+r8peIGmsYHGHk59+jHB/iIzUqlZlYZRrFJ1qbCb5
         Y1LA==
X-Gm-Message-State: APjAAAW5bAdTMVCL9fjiEqgX3L2ni/Z5ouiEn010gqyPiWHqysrvcErA
        /Ytq/bwZbtJ4ZFhQvydS9oCokA6M
X-Google-Smtp-Source: APXvYqy79NgNF8ZVMxvVtVSe9UKWkAQnlLsjvm41wex2vFcO9ttU4w8Y/9DoI+eVGp9pNZgDBHQX/A==
X-Received: by 2002:a5d:484e:: with SMTP id n14mr25879009wrs.110.1571074718305;
        Mon, 14 Oct 2019 10:38:38 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id 36sm24981585wrp.30.2019.10.14.10.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 10:38:37 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 2/4] RDMA/hns: Remove unsupported modify_port callback
Date:   Mon, 14 Oct 2019 20:38:15 +0300
Message-Id: <20191014173817.10596-3-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014173817.10596-1-kamalheib1@gmail.com>
References: <20191014173817.10596-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is no need to return always zero for function which is not
supported.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/hns/hns_roce_main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index b5d196c119ee..b241f74a7e3b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -301,12 +301,6 @@ static int hns_roce_modify_device(struct ib_device *ib_dev, int mask,
 	return 0;
 }
 
-static int hns_roce_modify_port(struct ib_device *ib_dev, u8 port_num, int mask,
-				struct ib_port_modify *props)
-{
-	return 0;
-}
-
 static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 				   struct ib_udata *udata)
 {
@@ -438,7 +432,6 @@ static const struct ib_device_ops hns_roce_dev_ops = {
 	.get_port_immutable = hns_roce_port_immutable,
 	.mmap = hns_roce_mmap,
 	.modify_device = hns_roce_modify_device,
-	.modify_port = hns_roce_modify_port,
 	.modify_qp = hns_roce_modify_qp,
 	.query_ah = hns_roce_query_ah,
 	.query_device = hns_roce_query_device,
-- 
2.20.1

