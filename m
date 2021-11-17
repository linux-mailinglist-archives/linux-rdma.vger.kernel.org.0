Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746C7454978
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Nov 2021 16:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbhKQPDD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Nov 2021 10:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238256AbhKQPDC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Nov 2021 10:03:02 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D572C061570
        for <linux-rdma@vger.kernel.org>; Wed, 17 Nov 2021 07:00:03 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso5047832wms.3
        for <linux-rdma@vger.kernel.org>; Wed, 17 Nov 2021 07:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GjMpGXwdISEOF2DSyvJRS6pWwGK3b3XoehSw6jJ/1jY=;
        b=EBO+7R9mUeevdYqw7iPulUUkiqsWjxBFgMGTfuR0tCBXyz46FIo2yHuaU9A8DtaeNP
         I6xDOp1ufTibUk9adfZgPnGqdzk2i98+O1dP4gcKcL+DK3kd06vficx0r51YiiUnvjMk
         FPGCfOHC0W8mcrZFL6TDu0uTK7zGmEyCUeFP/24QCR5p0Ti6/a+ct0/JGnrOWdJfvJmj
         8eyfWGDswNEEXg6YIxGawB/tWsUh6+e58qzWYeXw7Ac7YT86i6NV6mksZoXzjbA4bS4+
         Ut9CeP+itcld+Ra4vUbKMQ29bsDGayj5tIinc2bQgfi4lL4ySA33g4Rinxhh7lyaTYxg
         PMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GjMpGXwdISEOF2DSyvJRS6pWwGK3b3XoehSw6jJ/1jY=;
        b=dcgl+kPY3WYvqc21MGORFloJyd4bKK4rtBQa3jjh7OESuwUnfMHD1S5ewiU/ePkUhv
         onoLBJWrXt0p+J5s1i9J2rJClE+cNQHvZukCHOTWJT9giFQ6JgRBv+DjbMwBQ7LitONU
         8Nf2vp7IZJfn2GaGLNzi9xRqo88pnVOkNQ/N1T8OO+M8PVxRXkM6CsR/NXHRQLNLH+ko
         8tc58+FCC1D9++hUOmS59uHZqezIVZZ9nnJM5jtzqGQ97zrPCPJHBUA3oSkiWY09CciM
         3Cx+ArF0ztmMFFL6ISqrB+h5DVuPJqgWyEZH7l39QvYeP+BBb+8yIYrkA5ukCqa+Tskk
         CZ8Q==
X-Gm-Message-State: AOAM530wa27wn+nX6CQ0s8bl4s+QvuOxImkfiZXpmEM9a+XviuXyVV7K
        qaJ30dRE/5q2gPkXv/S9jyekxWsR5nVVsQ==
X-Google-Smtp-Source: ABdhPJy3ha6e201Gg4EZTDjAGwy0pjTjw4jO7c3sjbe87qIw5qtDRDmLdm3Epm2uT6f/c0VWLXbBQQ==
X-Received: by 2002:a05:600c:1c20:: with SMTP id j32mr321042wms.1.1637161201603;
        Wed, 17 Nov 2021 07:00:01 -0800 (PST)
Received: from fedora.. ([2a00:a040:19b:e02f::1005])
        by smtp.gmail.com with ESMTPSA id g13sm173685wrd.57.2021.11.17.07.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 07:00:01 -0800 (PST)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Wenpeng Liang <liangwenpeng@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH v2 for-rc] RDMA/hns: Validate the pkey index
Date:   Wed, 17 Nov 2021 16:59:54 +0200
Message-Id: <20211117145954.123893-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Before query pkey, make sure that the queried index is valid.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
v2: Fix commit message.
---
 drivers/infiniband/hw/hns/hns_roce_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 4194b626f3c6..8233bec053ee 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -270,6 +270,9 @@ static enum rdma_link_layer hns_roce_get_link_layer(struct ib_device *device,
 static int hns_roce_query_pkey(struct ib_device *ib_dev, u32 port, u16 index,
 			       u16 *pkey)
 {
+	if (index > 0)
+		return -EINVAL;
+
 	*pkey = PKEY_ID;
 
 	return 0;
-- 
2.31.1

