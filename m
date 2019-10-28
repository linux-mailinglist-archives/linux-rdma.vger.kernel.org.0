Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91598E6ECD
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 10:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387873AbfJ1JP7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 05:15:59 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:37888 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387875AbfJ1JP6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 05:15:58 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 28 Oct 2019 11:15:52 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x9S9Fqhv032464;
        Mon, 28 Oct 2019 11:15:52 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id x9S9FqEh031547;
        Mon, 28 Oct 2019 11:15:52 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id x9S9Fp3H031541;
        Mon, 28 Oct 2019 11:15:51 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     yishaih@mellanox.com, haggaie@mellanox.com, jgg@mellanox.com,
        maorg@mellanox.com
Subject: [PATCH rdma-core 0/6] verbs: Custom parent-domain allocators
Date:   Mon, 28 Oct 2019 11:14:53 +0200
Message-Id: <1572254099-30864-1-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series extends the parent domain object with custom allocation callbacks
that can be used by user-applications to override the provider allocation.

This can be used for example to add NUMA aware allocation.

The API was introduced in the mailing list by the below RFC [1] and was
implemented by mlx5 provider.

A detailed man page exists as part of the series to describe the usage and the
behavior.

A PR was sent as well [2].

[1] https://www.spinics.net/lists/linux-rdma/msg84590.html
[2] https://github.com/linux-rdma/rdma-core/pull/596

Haggai Eran (1):
  verbs: custom parent-domain allocators

Yishai Hadas (5):
  Update kernel headers
  mlx5: Extend mlx5_alloc_parent_domain() to support custom allocator
  mlx5: Add custom allocation support for QP and RWQ buffers
  mlx5: Add custom allocation support for DBR
  mlx5: Add custom allocation support for SRQ buffer

 kernel-headers/rdma/ib_user_ioctl_verbs.h  |  22 ++++++
 kernel-headers/rdma/rdma_user_ioctl_cmds.h |  22 ------
 libibverbs/man/ibv_alloc_parent_domain.3   |  54 +++++++++++++++
 libibverbs/verbs.h                         |  12 ++++
 providers/mlx5/buf.c                       |  59 +++++++++++++++++
 providers/mlx5/cq.c                        |   2 +-
 providers/mlx5/dbrec.c                     |  34 +++++++++-
 providers/mlx5/mlx5.h                      |  23 ++++++-
 providers/mlx5/mlx5dv.h                    |   6 ++
 providers/mlx5/srq.c                       |  25 +++++--
 providers/mlx5/verbs.c                     | 103 ++++++++++++++++++++---------
 11 files changed, 297 insertions(+), 65 deletions(-)

-- 
1.8.3.1

