Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C282220BD
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 12:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgGPKkC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 06:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgGPKkC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jul 2020 06:40:02 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62EBF2074B;
        Thu, 16 Jul 2020 10:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594896002;
        bh=r/8Oh1rit4CQjxeB1Qex0fA/yclw0hsotGx9cOiaz1g=;
        h=From:To:Cc:Subject:Date:From;
        b=D3rsYugSoLV9FqfQvdCME/kYHCS46rSd922a9iW22Ksv7gNdlmSkPxA0cU0lXKuNv
         HDWHlYNUPjC+H18tdMvP/mq/FiRXzKuHytp7nwDO8n7+q1EQoGqS0ClM0f6mz+TxyN
         b/WVs4kGGBgucd6EKv1B9lH3a7vZi1NahSYXBqqI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 0/2] Align write() and ioctl() paths
Date:   Thu, 16 Jul 2020 13:39:54 +0300
Message-Id: <20200716103956.1422139-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Changelog:
v1:
 * v0 revealed old bug https://lore.kernel.org/linux-rdma/20200716102059.1420681-1-leon@kernel.org
  that took a while to find.
 * create_cq() was rewritten to make sure that uobj is properly initialized.
v0: https://lore.kernel.org/lkml/20200708110554.1270613-1-leon@kernel.org

----------------------------------------------------
Hi,

The discussion about RWQ table patch revealed incosistency with use of
usecnt, complex unwind flows without any reason and difference between
write() and ioctl() paths.

This series extends infrastructure to be consistent, reliable and
predicable in regards of commit/desotry uobject.

Thanks

Leon Romanovsky (2):
  RDMA/core: Align abort/commit object scheme for write() and ioctl()
    paths
  RDMA/core: Update write interface to use automatic object lifetime

 drivers/infiniband/core/uverbs_cmd.c          | 314 ++++++------------
 drivers/infiniband/core/uverbs_main.c         |   4 +
 .../infiniband/core/uverbs_std_types_device.c |   7 +-
 include/rdma/uverbs_ioctl.h                   |   1 +
 include/rdma/uverbs_std_types.h               |  14 +
 5 files changed, 120 insertions(+), 220 deletions(-)

--
2.26.2

