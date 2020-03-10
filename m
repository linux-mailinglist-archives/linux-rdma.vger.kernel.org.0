Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D043717F32B
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 10:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgCJJOn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 05:14:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbgCJJOn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 05:14:43 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F64C20674;
        Tue, 10 Mar 2020 09:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583831682;
        bh=Wi6CL6iB7RwT0hh+gpEgbzB/O/wFTDNg36YiiDVjK5M=;
        h=From:To:Cc:Subject:Date:From;
        b=vSB/ejyXc+jE1iES8JJPvEKTB+3tk3Yi3JlMQbNr1iARpr5TCrxpIJE6bkCSM2Y3M
         QcHeqxVRrAx4K+pPjZYYGqIbOf10YoJ9tnuBY/U0zmMisXTTSC5K4bmWmTzls6b3df
         /Gt6l3s53xwKtF+vW4Wxh0p4r2URxaGS5HjR0OIg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next v1 00/11] Add Enhanced Connection Established (ECE)
Date:   Tue, 10 Mar 2020 11:14:27 +0200
Message-Id: <20200310091438.248429-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Changelog:
 v1: Dropped field_avail patch in favor of mass conversion to use function
     which already exists in the kernel code.
 v0: https://lore.kernel.org/lkml/20200305150105.207959-1-leon@kernel.org

Enhanced Connection Established or ECE is new negotiation scheme
introduced in IBTA v1.4 to exchange extra information about nodes
capabilities and later negotiate them at the connection establishment
phase.

The RDMA-CM messages (REQ, REP, SIDR_REQ and SIDR_REP) were extended
to carry two fields, one new and another gained new functionality:
 * VendorID is a new field that indicates that common subset of vendor
   option bits are supported as indicated by that VendorID.
 * AttributeModifier already exists, but overloaded to indicate which
   vendor options are supported by this VendorID.

This is kernel part of such functionality which is responsible to get data
from librdmacm and properly create and handle RDMA-CM messages.

Thanks

Leon Romanovsky (11):
  RDMA/cm: Add Enhanced Connection Establishment (ECE) bits
  RDMA/mlx4: Delete duplicated offsetofend implementation
  RDMA/efa: Use in-kernel offsetofend() to check field availability
  RDMA/mlx5: Use offsetofend() instead of duplicated variant
  RDMA/cm: Delete not implemented CM peer to peer communication
  RDMA/uapi: Add ECE definitions to UCMA
  RDMA/ucma: Extend ucma_connect to receive ECE parameters
  RDMA/ucma: Deliver ECE parameters through UCMA events
  RDMA/cm: Send and receive ECE parameter over the wire
  RDMA/cma: Connect ECE to rdma_accept
  RDMA/cma: Provide ECE reject reason

 drivers/infiniband/core/cm.c          | 48 ++++++++++++++++++------
 drivers/infiniband/core/cma.c         | 54 ++++++++++++++++++++++++---
 drivers/infiniband/core/cma_priv.h    |  1 +
 drivers/infiniband/core/ucma.c        | 40 ++++++++++++++++----
 drivers/infiniband/hw/efa/efa_verbs.c |  7 +---
 drivers/infiniband/hw/mlx4/main.c     |  9 ++---
 drivers/infiniband/hw/mlx5/main.c     | 42 ++++++++++-----------
 drivers/infiniband/hw/mlx5/mlx5_ib.h  | 16 +++-----
 include/rdma/ib_cm.h                  | 11 +++++-
 include/rdma/ibta_vol1_c12.h          |  6 +++
 include/rdma/rdma_cm.h                | 28 ++++++++++++--
 include/uapi/rdma/rdma_user_cm.h      | 15 +++++++-
 12 files changed, 203 insertions(+), 74 deletions(-)

--
2.24.1

