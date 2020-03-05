Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5AA017A85F
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 16:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgCEPBL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 10:01:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:46504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgCEPBL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 10:01:11 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FAEB20801;
        Thu,  5 Mar 2020 15:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583420470;
        bh=6rite9ZxAWvVFPonT92LQgcc0u39DnWJuYbpEcbvB/Y=;
        h=From:To:Cc:Subject:Date:From;
        b=vXFSwIBZucJWFOB2d+vCqx50CR3gLPWj+SNAc7ACdsZaULs/0asBH0qmzb+QU83VN
         ZtokE/aG2/63Fm+X9LHYX2/slo/giiujMNrJhQZcBMuwVr8FL7Z0+wzY3Nwxfk6ubH
         UoAJkUBT+nPzLCuzgGF9Pfj5w9AeGem43R0DzkqU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next 0/9] Add Enhanced Connection Established (ECE)
Date:   Thu,  5 Mar 2020 17:00:56 +0200
Message-Id: <20200305150105.207959-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

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

Leon Romanovsky (9):
  RDMA/cm: Add Enhanced Connection Establishment (ECE) bits
  RDMA: Promote field_avail() macro to be general code
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
 drivers/infiniband/hw/efa/efa_verbs.c |  3 --
 drivers/infiniband/hw/mlx4/main.c     |  7 +---
 drivers/infiniband/hw/mlx5/main.c     | 41 ++++++++++----------
 drivers/infiniband/hw/mlx5/mlx5_ib.h  | 18 ++++-----
 include/linux/kernel.h                | 18 +++++++++
 include/rdma/ib_cm.h                  | 11 +++++-
 include/rdma/ibta_vol1_c12.h          |  6 +++
 include/rdma/rdma_cm.h                | 28 ++++++++++++--
 include/uapi/rdma/rdma_user_cm.h      | 15 +++++++-
 13 files changed, 219 insertions(+), 71 deletions(-)

--
2.24.1

