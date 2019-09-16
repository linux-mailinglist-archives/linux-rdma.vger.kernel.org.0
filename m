Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD94B3541
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2019 09:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfIPHMB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 03:12:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfIPHMB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Sep 2019 03:12:01 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14B3C2067D;
        Mon, 16 Sep 2019 07:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568617920;
        bh=DUY3mgtYISV7IEFwxANux0lzD94GgadyfGjtM1o/QlM=;
        h=From:To:Cc:Subject:Date:From;
        b=BVbmS92yHs9BIPlQxibX1u+4pusxd7XzXUcIr6cT8tXyd+r073KUDl2I9W0XEyFON
         Rdk9Gmg2G/wiGQAN+L3zgXfhXaniXYZ7BfeybkIjVNv0VQ5u1yiBmj+dXRnijgchJv
         Mbfqj+v+PjF363qJiYJYZvecwiwwTqmL7dsKa+1M=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH 0/4] Random fixes to IB/core
Date:   Mon, 16 Sep 2019 10:11:50 +0300
Message-Id: <20190916071154.20383-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This is a random set of various fixes in IB/core, which were in my
submission queue before LPC>

Thanks

Jack Morgenstein (2):
  RDMA/cm: Fix memory leak in cm_add/remove_one
  RDMA: Fix double-free in srq creation error flow

Leon Romanovsky (1):
  RDMA/nldev: Reshuffle the code to avoid need to rebind QP in error
    path

Mark Zhang (1):
  RDMA/counter: Prevent QP counter manual binding in auto mode

 drivers/infiniband/core/cm.c         |  3 +++
 drivers/infiniband/core/counters.c   | 12 +++++++++++-
 drivers/infiniband/core/nldev.c      | 12 +++++-------
 drivers/infiniband/core/uverbs_cmd.c |  3 ++-
 4 files changed, 21 insertions(+), 9 deletions(-)

--
2.20.1

