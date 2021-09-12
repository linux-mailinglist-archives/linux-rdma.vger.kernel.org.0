Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176D7407F2A
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Sep 2021 20:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhILSQp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Sep 2021 14:16:45 -0400
Received: from saphodev.broadcom.com ([192.19.11.229]:34430 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhILSQp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 12 Sep 2021 14:16:45 -0400
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id AB1F77DBA;
        Sun, 12 Sep 2021 11:15:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com AB1F77DBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1631470529;
        bh=QYOqWrx1AxMgsaDDZgHIKoglzLpsyrJwYNKgjK+Nd44=;
        h=From:To:Cc:Subject:Date:From;
        b=XdgXYaQ4yrOtB9x79w2Z/YbLGYQZylUBFMXiOgbZmt9EjllnoiPxQyQDDHROkSal3
         jdyj59eqVIQKPPu7oFTjcELXJ7ilLQjbK1rHxIDvfvYhEbFYI7vYd2PBJ6mVNnN7u2
         VE3Psh0VRO4mED+SinfMJqDwbfNel5Id6tVC+qZk=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 00/12] RDMA/bnxt_re: Driver update
Date:   Sun, 12 Sep 2021 11:15:14 -0700
Message-Id: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Includes some feature updates and bug fixes for bnxt_re driver.

Please review and apply.

Thanks,
Selvin Xavier

Edwin Peer (1):
  RDMA/bnxt_re: Use separate response buffer for stat_ctx_free

Selvin Xavier (11):
  RDMA/bnxt_re: Add extended statistics counters
  RDMA/bnxt_re: Update statistics counter name
  RDMA/bnxt_re: Reduce the delay in polling for hwrm command completion
  RDMA/bnxt_re: Support multiple page sizes
  RDMA/bnxt_re: Suppress unwanted error messages
  RDMA/bnxt_re: Fix query SRQ failure
  RDMA/bnxt_re: Fix FRMR issue with single page MR allocation
  RDMA/bnxt_re: Use GFP_KERNEL in non atomic context
  RDMA/bnxt_re: Correct FRMR size calculation
  RDMA/bnxt_re: Check if the vlan is valid before reporting
  MAINTAINERS: Update Broadcom RDMA maintainers

 MAINTAINERS                                 |   1 -
 drivers/infiniband/hw/bnxt_re/bnxt_re.h     |   7 +-
 drivers/infiniband/hw/bnxt_re/hw_counters.c | 277 ++++++++++++++++++----------
 drivers/infiniband/hw/bnxt_re/hw_counters.h |  30 ++-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c    |  35 +++-
 drivers/infiniband/hw/bnxt_re/main.c        |  11 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c    |  14 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c  |   6 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h  |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c   |   5 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h   |   9 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c    |  51 +++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h    |  28 +++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h    |  85 +++++++++
 14 files changed, 438 insertions(+), 123 deletions(-)

-- 
2.5.5

