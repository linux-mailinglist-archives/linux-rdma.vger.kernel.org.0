Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6373D47B04A
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Dec 2021 16:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbhLTPaz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Dec 2021 10:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240025AbhLTPaa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Dec 2021 10:30:30 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D105C08EAC2
        for <linux-rdma@vger.kernel.org>; Mon, 20 Dec 2021 07:25:39 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v7so13539477wrv.12
        for <linux-rdma@vger.kernel.org>; Mon, 20 Dec 2021 07:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fnBTSp+JK2hSLIWhpXjiZLSMbC/ycLtAYiw8oV7TfsI=;
        b=Z/a/eAlVyCC09tSsWEUtrcBWAXDnyOHNho13twk4A5sDJ48QLQVyjegK3zrZenuU6K
         HpyCbZ1DAsvFGehn844yeN5R+FZW8w5cNrwsPzzEs2rY0LVeMLS2ip7JihGsneYX91Z5
         bK2kZFipSVOSVPOqYiyN0yRTKx7yWrWS3C8oZs15DUVEhX21lNhMgRmQIoTFUK5vaoHh
         wo5g/DjI3Q/mgLy6PPwJu9dxCehin561x01/N7zrBloLcIIWgJ0FfvYhfs8EGhWLYwX1
         xhUxK6oxroGYpd+6bv4EJXm/OItWAbjYTmb7FuG8s+f3eLukL92kAsscQrh+LBwRBWWZ
         VQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fnBTSp+JK2hSLIWhpXjiZLSMbC/ycLtAYiw8oV7TfsI=;
        b=H66wIPSKd3Yl0iK25vIhqCKulBAolqN8X6jPkXKbFH58jsgcGuUsfS+KkwVTHcYsac
         bjMeo7fZw4kO/VLG6IbIkjykT8TSUVvjHdW+qkijU5USOJlwrE1J95gvZrAyKik+Ogr2
         F8o26y+pXUZUQBmvmNE1L885QbS/+m+j0ZIPfUovtGBUgtYopyYJDZH4mEzMRsGM+FSy
         kKNRCkBoVVmDqLXSi2Z4c73OIknZ1sVwLHiG6EGGV9LjyML14/PGyI0O4jqjgEGlv9MM
         SUDXHaxS12eWkn2oAXLcU9GUf+wTDw8LirR0quc0wYDcOTZNGg3gxQ9OGUQzH8P+QGse
         yz8g==
X-Gm-Message-State: AOAM532McVu7tX8n4io5jpqxq+jpFK+zT4g1ejVV0OWUUQ+o3GfLcv4+
        nkHJXe8hywC3KvrmrgeSkPfHPnyeihU=
X-Google-Smtp-Source: ABdhPJxnsaa3sM4lmaAKTr0oW2Nkl3qkhpOZmk5tloFReLJUrw/eHTvaO7BvmhTgOpitwPAiMB2cQA==
X-Received: by 2002:adf:f68a:: with SMTP id v10mr13358469wrp.212.1640013937745;
        Mon, 20 Dec 2021 07:25:37 -0800 (PST)
Received: from fedora.. ([2a00:a040:19b:e02f::1004])
        by smtp.gmail.com with ESMTPSA id d143sm9802729wmd.6.2021.12.20.07.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 07:25:37 -0800 (PST)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/cxgb4: Set queue pair state when being queried
Date:   Mon, 20 Dec 2021 17:25:30 +0200
Message-Id: <20211220152530.60399-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The API for ib_query_qp requires the driver to set
cur_qp_state on return, add the missing set.

Fixes: 67bbc05512d8 ("RDMA/cxgb4: Add query_qp support")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/cxgb4/qp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index d20b4ef2c853..ffbd9a89981e 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -2460,6 +2460,7 @@ int c4iw_ib_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	memset(attr, 0, sizeof(*attr));
 	memset(init_attr, 0, sizeof(*init_attr));
 	attr->qp_state = to_ib_qp_state(qhp->attr.state);
+	attr->cur_qp_state = to_ib_qp_state(qhp->attr.state);
 	init_attr->cap.max_send_wr = qhp->attr.sq_num_entries;
 	init_attr->cap.max_recv_wr = qhp->attr.rq_num_entries;
 	init_attr->cap.max_send_sge = qhp->attr.sq_max_sges;
-- 
2.31.1

