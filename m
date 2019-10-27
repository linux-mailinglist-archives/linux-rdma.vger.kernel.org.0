Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65C9BE6134
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfJ0HG2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:06:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HG2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:06:28 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 317B020873;
        Sun, 27 Oct 2019 07:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572159986;
        bh=ZRc6K5tRhuuVyHCXO/I0Mw/TO2GTp6cailKtzsfOzcA=;
        h=From:To:Cc:Subject:Date:From;
        b=xMWbzHynDD4QNOjoFFyOsGjO6lEo3snA/R6m+rVH3QEZ6+5Sv/tIvqkGgb2y9KiVD
         LV+2MRqWD2fAMdFWKT5G9lmmeWUbbnz9/7sRZ3RuudrGovECBjUSPX8VYnaq4QE/hD
         fhzvdzmlyfc1qn3CIkcqegelcS1tqhs0HTNYKiLc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 00/43] Convert CM to bitmaps
Date:   Sun, 27 Oct 2019 09:05:38 +0200
Message-Id: <20191027070621.11711-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This series is based n previously sent CM cleanup series [1] and
continues already started task to clean up CM related code.

Over the years, the IB/core gained a number of anti-patterns which
led to mistakes. First and most distracting is spread of hardware
specification types (e.g. __beXX) to the core logic. Second, endless
copy/paste to access IBTA binary blobs, which made any IBTA extensions
not an easy task.

In next series, we will add Enhance Connection Establishment bits which
were added recently to IBTA and will continue to convert rest of the CM
code to propose macros by eliminating __beXX variables from core code.

Thanks

[1] https://lore.kernel.org/linux-rdma/20191020071559.9743-1-leon@kernel.org

BTW,
I know that it is more than 15 patches, but they are small and
self-contained.

Leon Romanovsky (43):
  RDMA/cm: Add naive SET/GET implementations to hide CM wire format
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

 drivers/infiniband/core/cm.c      | 519 +++++++----------
 drivers/infiniband/core/cm_msgs.h | 920 +++++++++++-------------------
 drivers/infiniband/core/cma.c     |  11 +-
 include/rdma/ib_cm.h              |  51 --
 4 files changed, 549 insertions(+), 952 deletions(-)

--
2.20.1

