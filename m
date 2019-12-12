Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2275D11C963
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfLLJil (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:38:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbfLLJil (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:38:41 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7A9F2173E;
        Thu, 12 Dec 2019 09:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143520;
        bh=XJWd2DS4SZ4kowUBQn2qHZtJw5N3g/Z3dJmXDcAH+hI=;
        h=From:To:Cc:Subject:Date:From;
        b=DYxgiOQ/Ueiy7842+aSgpInYOA6/rbTv2YWUjx4EWXl4ZA0ouFtywLG5oERlFGrIf
         v4laDQBjQT+kuI72RqnimRuOBgBv3J3rb1Ue5ZJfpNXCZO6ZsHDG6TF3igu+Ane2W9
         YQ3cUuJBm2Q8M0pgpxKUXDoXbRlfqa/mfXoh6RC4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 00/48] Organize code according to IBTA layout
Date:   Thu, 12 Dec 2019 11:37:42 +0200
Message-Id: <20191212093830.316934-1-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Changelog:
v1->v2: https://lore.kernel.org/linux-rdma/20191121181313.129430-1-leon@kernel.org
 * Added forgotten CM_FIELD64_LOC().
v0->v1: https://lore.kernel.org/linux-rdma/20191027070621.11711-1-leon@kernel.org
 * Used Jason's macros as a basis for all get/set operation for wire protocol.
 * Fixed wrong offsets.
 * Grouped all CM related patches in one patchset bomb.
----------------------------------------------------------------------
Hi,

This series continues already started task to clean up CM related code.

Over the years, the IB/core gained a number of anti-patterns which
led to mistakes. First and most distracting is spread of hardware
specification types (e.g. __beXX) to the core logic. Second, endless
copy/paste to access IBTA binary blobs, which made any IBTA extensions
not an easy task.
In this series, we add Enhance Connection Establishment bits which
were added recently to IBTA and will continue to convert rest of the CM
code to propose macros by eliminating __beXX variables from core code.

All IBTA CM declarations are places into new header
file: include/rdma/ibta_vol1_c12.h and the idea that every
spec chapter will have separate header file, so we will see
immediately the relations between declarations and values.

Thanks

BTW,
1. The whole area near private_data looks sketchy to me and needs
   separate cleanup.
2. I know that it is more than 15 patches, but they are small and
   self-contained.

Leon Romanovsky (48):
  RDMA/cm: Provide private data size to CM users
  RDMA/srpt: Use private_data_len instead of hardcoded value
  RDMA/ucma: Mask QPN to be 24 bits according to IBTA
  RDMA/cm: Add SET/GET implementations to hide IBA wire format
  RDMA/cm: Request For Communication (REQ) message definitions
  RDMA/cm: Message Receipt Acknowledgment (MRA) message definitions
  RDMA/cm: Reject (REJ) message definitions
  RDMA/cm: Reply To Request for communication (REP) definitions
  RDMA/cm: Ready To Use (RTU) definitions
  RDMA/cm: Request For Communication Release (DREQ) definitions
  RDMA/cm: Reply To Request For Communication Release (DREP) definitions
  RDMA/cm: Load Alternate Path (LAP) definitions
  RDMA/cm: Alternate Path Response (APR) message definitions
  RDMA/cm: Service ID Resolution Request (SIDR_REQ) definitions
  RDMA/cm: Service ID Resolution Response (SIDR_REP) definitions
  RDMA/cm: Convert QPN and EECN to be u32 variables
  RDMA/cm: Convert REQ responded resources to the new scheme
  RDMA/cm: Convert REQ initiator depth to the new scheme
  RDMA/cm: Convert REQ remote response timeout
  RDMA/cm: Simplify QP type to wire protocol translation
  RDMA/cm: Convert REQ flow control
  RDMA/cm: Convert starting PSN to be u32 variable
  RDMA/cm: Update REQ local response timeout
  RDMA/cm: Convert REQ retry count to use new scheme
  RDMA/cm: Update REQ path MTU field
  RDMA/cm: Convert REQ RNR retry timeout counter
  RDMA/cm: Convert REQ MAX CM retries
  RDMA/cm: Convert REQ SRQ field
  RDMA/cm: Convert REQ flow label field
  RDMA/cm: Convert REQ packet rate
  RDMA/cm: Convert REQ SL fields
  RDMA/cm: Convert REQ subnet local fields
  RDMA/cm: Convert REQ local ack timeout
  RDMA/cm: Convert MRA MRAed field
  RDMA/cm: Convert MRA service timeout
  RDMA/cm: Update REJ struct to use new scheme
  RDMA/cm: Convert REP target ack delay field
  RDMA/cm: Convert REP failover accepted field
  RDMA/cm: Convert REP flow control field
  RDMA/cm: Convert REP RNR retry count field
  RDMA/cm: Convert REP SRQ field
  RDMA/cm: Delete unused CM LAP functions
  RDMA/cm: Convert LAP flow label field
  RDMA/cm: Convert LAP fields
  RDMA/cm: Delete unused CM ARP functions
  RDMA/cm: Convert SIDR_REP to new scheme
  RDMA/cm: Add Enhanced Connection Establishment (ECE) bits
  RDMA/cm: Convert private_date access

 drivers/infiniband/core/cm.c          | 554 ++++++++++--------------
 drivers/infiniband/core/cm_msgs.h     | 600 +-------------------------
 drivers/infiniband/core/cma.c         |  11 +-
 drivers/infiniband/core/ucma.c        |   2 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c |   2 +-
 include/rdma/ib_cm.h                  |  55 +--
 include/rdma/iba.h                    | 138 ++++++
 include/rdma/ibta_vol1_c12.h          | 211 +++++++++
 8 files changed, 599 insertions(+), 974 deletions(-)
 create mode 100644 include/rdma/iba.h
 create mode 100644 include/rdma/ibta_vol1_c12.h

--
2.20.1

