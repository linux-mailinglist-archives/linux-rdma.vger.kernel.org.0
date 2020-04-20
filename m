Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BAA1B0DE1
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 16:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgDTOGz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 10:06:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgDTOGy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Apr 2020 10:06:54 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6692720722;
        Mon, 20 Apr 2020 14:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587391614;
        bh=e3MmtYQABhBh9rFChqYBDuhjifnNwIB8F2EYklT+0p0=;
        h=From:To:Cc:Subject:Date:From;
        b=eJqItJGpC3V/SGLs6SfOK7Ky7RFScwjitQLkCKIXXESv2ywnxJpfIJHT1j13LxM6t
         lTGaTvVfEkNqzROcWYtBDqtOrCbMPC03zy0/qDftmVvypZiDsEShClzKEMNktC3jBt
         5fxnUjPPZw7jlLmPLh4jN+uHAerw/jDi9T6flIvw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-core 00/12] Add Enhanced Connection Established (ECE) APIs
Date:   Mon, 20 Apr 2020 17:06:36 +0300
Message-Id: <20200420140648.275554-1-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

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

The general (success) communication flow can be described by the following table:

------------------------------------------------------------------------------
Requester (client)                        | Responder (server)
-----------------------------------------------------------------------------
1. Create data QP.                        |
2. Get ECE information about this QP.     |
3. Update REQ message with local ECE data.|
4. Send REQ message with rdma_connect().  |
                                          | 5. Get REQ message with rdma_get_events.
                                          | 6. Read remote ECE data from the REQ message.
                                          | 7. Create data QP.
                                          | 8. Set in QP the desired ECE options by giving remote ECE data.
                                          | 9. Read accepted local ECE options.
                                          |10. Modify QP based on those options.
                                          |11. Fill local ECE options in REP message.
                                          |12. Send REP message with rdma_accept().
13. Receive REP message.                  |
14. Read remote ECE data from REP message.|
15. Set in QP remote ECE data             |
16. Modify QP based on remote ECE data    |
------------------------------------------------------------------------------

In case the server decides to reject connection, the items #9-10 will be
replaced with rdma_reject_ece() call that will send REJ message together
with "ECE options not supported" reason as described in the IBTA.

Thanks

Ido Kalir (2):
  pyverbs: Add support for ECE
  tests: Add test for rdmacm ECE mechanism

Leon Romanovsky (10):
  Update kernel headers
  libibverbs: Add interfaces to configure and use ECE
  libibverbs: Document ECE API
  debian: Install all available librdmacm man pages
  librdmacm: Provide interface to use ECE for external QPs
  librdmacm: Connect rdma_connect to the ECE
  librdmacm: Return ECE results through rdma_accept
  librdmacm: Add an option to reject ECE request
  librdmacm: Implement ECE handshake logic
  librdmacm: Document ECE API

 CMakeLists.txt                             |   2 +-
 debian/libibverbs1.symbols                 |   5 +-
 debian/librdmacm-dev.install               |  53 +--------
 debian/librdmacm1.symbols                  |   4 +
 kernel-headers/rdma/mlx5_user_ioctl_cmds.h |   6 +
 kernel-headers/rdma/rdma_user_cm.h         |  15 ++-
 libibverbs/CMakeLists.txt                  |   2 +-
 libibverbs/driver.h                        |   2 +
 libibverbs/dummy_ops.c                     |  14 +++
 libibverbs/libibverbs.map.in               |   6 +
 libibverbs/man/CMakeLists.txt              |   2 +
 libibverbs/man/ibv_query_ece.3.md          |  56 +++++++++
 libibverbs/man/ibv_set_ece.3.md            |  61 ++++++++++
 libibverbs/verbs.c                         |  15 +++
 libibverbs/verbs.h                         |  18 +++
 librdmacm/CMakeLists.txt                   |   2 +-
 librdmacm/cma.c                            | 130 +++++++++++++++++++--
 librdmacm/librdmacm.map                    |   7 ++
 librdmacm/man/CMakeLists.txt               |   2 +
 librdmacm/man/rdma_cm.7                    |  14 ++-
 librdmacm/man/rdma_get_remote_ece.3.md     |  61 ++++++++++
 librdmacm/man/rdma_set_local_ece.3.md      |  62 ++++++++++
 librdmacm/rdma_cma.h                       |  24 ++++
 librdmacm/rdma_cma_abi.h                   |  15 ++-
 pyverbs/cmid.pyx                           |  23 +++-
 pyverbs/libibverbs.pxd                     |   7 ++
 pyverbs/librdmacm.pxd                      |   2 +
 pyverbs/qp.pxd                             |   3 +
 pyverbs/qp.pyx                             |  45 ++++++-
 tests/rdmacm_utils.py                      |  18 ++-
 30 files changed, 606 insertions(+), 70 deletions(-)
 create mode 100644 libibverbs/man/ibv_query_ece.3.md
 create mode 100644 libibverbs/man/ibv_set_ece.3.md
 create mode 100644 librdmacm/man/rdma_get_remote_ece.3.md
 create mode 100644 librdmacm/man/rdma_set_local_ece.3.md

--
2.25.2

