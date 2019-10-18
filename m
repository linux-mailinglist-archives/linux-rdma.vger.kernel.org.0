Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB6A7DC18D
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 11:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392366AbfJRJlg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 05:41:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39596 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409690AbfJRJlf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Oct 2019 05:41:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id v17so5400330wml.4
        for <linux-rdma@vger.kernel.org>; Fri, 18 Oct 2019 02:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hAZ2TrIIVcLEbxIdOVbHEBWi4WBUQuacFKnyYRaMGgU=;
        b=bc0N4yFtCDvQuTeYZbrZBl0MvigSkN/d+Owm/UhJoB/Yuf0yGrx+N8VJ5xbxaLkcIs
         3aFzoCDF3e0CzGJ+YBO5rGqGr2dGriND5Wiscx4WR9TQBnjhqEbQlHhaLkQPHqqz8TOO
         qGfmbxc+w8AHxnGffbbkLYh6JBgqH8jU+0x7NRFCjJHnVzTk2kYdRq4WfF2bil7nP7+i
         P/flMoP5CliusO2wAcYkcPzxgiBjl3CaYCdTybMzOixSuSCZ45J2Z1YX+8zHqrG34M9P
         Y+0saYfebZjgxoZRRvd6cglPj3OcubZyAlChApE7OMg3pk89iEuB1mp6cdOF2dvRqo8x
         5tyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hAZ2TrIIVcLEbxIdOVbHEBWi4WBUQuacFKnyYRaMGgU=;
        b=GjLoroG+jN6tmI4n4vVry+AoBpcEbfkYkAwoJLJqaSxowzQeJzwwLHA+wtdt6qgf4W
         YG6mAo2GmEib7a3bzXBmlAaYmlKXPmgYvZNtOTsQZUkEZOTNS74vbwZTjEvDE96XM6og
         IXfHxIFWycpeySdbZNRN+uPX+Skw36rWcbAzVbsWyZCPf60oJoids1lAWyHZkDrwXPDY
         SzdZ2uWg3Ozf3FvHybg7C1g42QmmZQilD/bpTZr9OEQuX2DtQgi79Vr5B/phrliqbdJL
         uwEDend9pmdGA4u5pL5CXlnefL6MHwBf+sb9fnwA/UWJUARfQ+fWQLzqSUXHaqQo+WQU
         5Ntg==
X-Gm-Message-State: APjAAAVYUDmvj7e+TLVWT7nU7W4IR+CoK3IspzliKz+HbtYmELwgxZpq
        QpHSo16Fcrbx3VEcJVRlVjgh6ATQ
X-Google-Smtp-Source: APXvYqyerypUNCBquYnHL2UsrO76eXBKC/pqW1dHPXbMKYbmPA7ia01iOOZbGxSf2WFkEsWA9YlDLA==
X-Received: by 2002:a1c:3c07:: with SMTP id j7mr691766wma.122.1571391693514;
        Fri, 18 Oct 2019 02:41:33 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id 126sm2186111wma.48.2019.10.18.02.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 02:41:33 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v3 2/4] RDMA/hns: Remove unsupported modify_port callback
Date:   Fri, 18 Oct 2019 12:41:13 +0300
Message-Id: <20191018094115.13167-3-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018094115.13167-1-kamalheib1@gmail.com>
References: <20191018094115.13167-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is no need to return always zero for function which is not
supported.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
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

