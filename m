Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6891627C0A3
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 11:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgI2JOF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 05:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbgI2JOE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Sep 2020 05:14:04 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D68F204FD;
        Tue, 29 Sep 2020 09:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601370844;
        bh=Zd9UpoW6JRJ/ucEPMrtkJe/8coFXg+LYrhj/oUBaD2o=;
        h=From:To:Cc:Subject:Date:From;
        b=Bdi7sPqZh06EI8g/goIIEMz6G8OVAf9790vfiKw6Yz1SddLqyM7WYENSIxT+d93ni
         OTRf+Tt5fIWI93mdEFgegpbGhEdFzGbnDJx6oGB3+rkNe2olWYNvjBjbiEHpEf9iTj
         OQvxWAqel4xC0PZcraekXubc1B/+wbzozTybMBWg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blk-next 0/2] Delete the get_vector_affinity leftovers
Date:   Tue, 29 Sep 2020 12:13:56 +0300
Message-Id: <20200929091358.421086-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

There are no drivers that implement .get_vector_affinity(), so delete
the RDMA function and simplify block code.

Thanks

P.S. Probably it should go through block tree.

Leon Romanovsky (2):
  blk-mq-rdma: Delete not-used multi-queue RDMA map queue code
  RDMA/core: Delete not-implemented get_vector_affinity

 block/Kconfig                    |  5 ----
 block/Makefile                   |  1 -
 block/blk-mq-rdma.c              | 44 --------------------------------
 drivers/infiniband/core/device.c |  1 -
 drivers/nvme/host/rdma.c         |  7 ++---
 include/linux/blk-mq-rdma.h      | 11 --------
 include/rdma/ib_verbs.h          | 23 -----------------
 7 files changed, 2 insertions(+), 90 deletions(-)
 delete mode 100644 block/blk-mq-rdma.c
 delete mode 100644 include/linux/blk-mq-rdma.h

--
2.26.2

