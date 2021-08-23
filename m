Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6993F43FE
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 05:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhHWDsr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Aug 2021 23:48:47 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47545 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230401AbhHWDsq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 Aug 2021 23:48:46 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ARUfdh6oZMmtvY/uczIYD050aV5oXeYIsimQD?=
 =?us-ascii?q?101hICG9E/bo8/xG+c536faaslgssQ4b8+xoVJPgfZq+z+8R3WByB8bAYOCOgg?=
 =?us-ascii?q?LBQ72KhrGSoQEIdRefysdtkY9kc4VbTOb7FEVGi6/BizWQIpINx8am/cmT6dvj?=
 =?us-ascii?q?8w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,343,1620662400"; 
   d="scan'208";a="113304277"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Aug 2021 11:48:01 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 1AD584D0D489;
        Mon, 23 Aug 2021 11:48:00 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 23 Aug 2021 11:47:54 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 23 Aug 2021 11:47:53 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <yishaih@nvidia.com>
CC:     <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [PATCH] IB/core: Remove deprecated current_seq comments
Date:   Mon, 23 Aug 2021 11:52:46 +0800
Message-ID: <20210823035246.3506-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 1AD584D0D489.AD5F8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

current_seq was removed since 36f30e486d ("IB/core: Improve ODP to use hmm_range_fault()")

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 drivers/infiniband/core/umem_odp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 9462dbe66014..7a47343d11f9 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -292,9 +292,6 @@ EXPORT_SYMBOL(ib_umem_odp_release);
  * @dma_index: index in the umem to add the dma to.
  * @page: the page struct to map and add.
  * @access_mask: access permissions needed for this page.
- * @current_seq: sequence number for synchronization with invalidations.
- *               the sequence number is taken from
- *               umem_odp->notifiers_seq.
  *
  * The function returns -EFAULT if the DMA mapping operation fails.
  *
-- 
2.31.1



