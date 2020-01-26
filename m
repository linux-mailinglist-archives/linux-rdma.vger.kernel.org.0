Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 704D3149B08
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2020 15:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgAZO05 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jan 2020 09:26:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:42416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728783AbgAZO05 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Jan 2020 09:26:57 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 495F320708;
        Sun, 26 Jan 2020 14:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580048816;
        bh=eps5y6goLfQ5zwfv/njXtLwpnmBBLGB+X2CAjR+G5YU=;
        h=From:To:Cc:Subject:Date:From;
        b=Cm9NG1/TbThxTO6Q9w4xXWslu5suQprJIS+HX8IfjqkJIpQTiDuUBAmMFD5gjgmBt
         oScx0VSsTrDG3O1HPBe/sxwZ8058U0lmjm/IAuSWTbExa0SzuS2Qvt9Ya4u05IFBla
         v0Sf6UKtQ/lKwuZbjHE+h8vSf0JmJYWgiuKk3V2g=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next 0/7] CMA fix and small improvements
Date:   Sun, 26 Jan 2020 16:26:45 +0200
Message-Id: <20200126142652.104803-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

From Parav,

This series covers a fix for a reference count leak and few small
code improvements to the RDMA CM code as below.

Patch-1: Fixes a reference count leak where reference count
increment was missing.
Patch-2: Uses helper function to hold refcount and to enqueue
work to avoid errors.
Patch-3: Uses RDMA port iterator API and avoids open coding.
Patch-4: Renames cma device's cma_ref/deref_dev() to cma_dev_get/put()
to align it to rest of kernel for similar use.
Patch-5: Uses refcount APIs to get/put reference to CMA device.
Patch-6: Renames cma cm_id's ref helpers to cma_id_get/put() to align
to rest of the kernel for similar use.
Patch-7: Uses refcount APIs to get/put reference to CM id.

Thanks

Parav Pandit (7):
  RDMA/cma: Fix unbalanced cm_id reference count during address resolve
  RDMA/cma: Use helper function to enqueue resolve work item
  RDMA/cma: Use RDMA device port iterator
  RDMA/cma: Rename cma_device ref/deref helpers to to get/put
  RDMA/cma: Use refcount API to reflect refcount
  RDMA/cma: Rename cma_device ref/deref helpers to to get/put
  RDMA/cma: Use refcount API to reflect refcount

 drivers/infiniband/core/cma.c          | 99 ++++++++++++++------------
 drivers/infiniband/core/cma_configfs.c |  6 +-
 drivers/infiniband/core/cma_priv.h     |  6 +-
 3 files changed, 60 insertions(+), 51 deletions(-)

--
2.24.1

