Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10C6119FBB0
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2020 19:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgDFRfG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Apr 2020 13:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbgDFRfG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Apr 2020 13:35:06 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85B5A20672;
        Mon,  6 Apr 2020 17:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586194506;
        bh=hyFQ3AvPJWl9YW4c+vG32AGU4rO9n74g1u1pdmYN0To=;
        h=From:To:Cc:Subject:Date:From;
        b=miOvMM7RfRtvo7cdQGpnUyL/OjaSl1BTtL6wKJv7yol/ak1eFQNGHSjPaV/7S1ty+
         EmQscBtlFNmhcD1QEAZ03TmGz4aQC1YGZqw8cOb0gFZVLmvTCkSKhLc1AZjmKploeb
         AkCGmchukcgyuXzn8zn+wVxdy82BJpgMt6B4rawg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Zhu Yanjun <yanjunz@mellanox.com>, Amir Vadai <amirv@mellanox.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Kamal Heib <kamalh@mellanox.com>, linux-rdma@vger.kernel.org,
        Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-next] RDMA/rxe: Set default vendor ID
Date:   Mon,  6 Apr 2020 20:35:01 +0300
Message-Id: <20200406173501.1466273-1-leon@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjunz@mellanox.com>

The RXE driver doesn't set vendor_id and user space applications
see zeros. This causes to pyverbs tests to fail with the following
traceback, because the expectation is to have valid vendor_id.

Traceback (most recent call last):
  File "tests/test_device.py", line 51, in test_query_device
    self.verify_device_attr(attr)
  File "tests/test_device.py", line 77, in verify_device_attr
    assert attr.vendor_id != 0

In order to fix it, we will set vendor_id 0XFFFFFF, according
to the IBTA v1.4 A3.3.1 VENDOR INFORMATION section.

"""
A vendor that produces a generic controller (i.e., one that supports a
standard I/O protocol such as SRP), which does not have vendor specific
device drivers, may use the value of 0xFFFFFF in the VendorID field.
"""

Before:
"
hca_id: rxe0
        transport:                      InfiniBand (0)
        fw_ver:                         0.0.0
        node_guid:                      5054:00ff:feaa:5363
        sys_image_guid:                 5054:00ff:feaa:5363
        vendor_id:                      0x0000
"

After:
"
hca_id: rxe0
        transport:                      InfiniBand (0)
        fw_ver:                         0.0.0
        node_guid:                      5054:00ff:feaa:5363
        sys_image_guid:                 5054:00ff:feaa:5363
        vendor_id:                      0xffffff
"

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Zhu Yanjun <yanjunz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/sw/rxe/rxe.c       | 1 +
 drivers/infiniband/sw/rxe/rxe_param.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 4afdd2e20883..5642eefb4ba1 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -77,6 +77,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 {
 	rxe->max_inline_data			= RXE_MAX_INLINE_DATA;
 
+	rxe->attr.vendor_id			= RXE_VENDOR_ID;
 	rxe->attr.max_mr_size			= RXE_MAX_MR_SIZE;
 	rxe->attr.page_size_cap			= RXE_PAGE_SIZE_CAP;
 	rxe->attr.max_qp			= RXE_MAX_QP;
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index f59616b02477..99e9d8ba9767 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -127,6 +127,9 @@ enum rxe_device_param {
 
 	/* Delay before calling arbiter timer */
 	RXE_NSEC_ARB_TIMER_DELAY	= 200,
+
+	/* IBTA v1.4 A3.3.1 VENDOR INFORMATION section */
+	RXE_VENDOR_ID			= 0XFFFFFF,
 };
 
 /* default/initial rxe port parameters */
-- 
2.25.1

